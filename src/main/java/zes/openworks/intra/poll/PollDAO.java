/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.poll;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * <pre>
 * 설문관리 DAO
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 12.
 * @version $Id: PollDao.java 2010. 3. 12. yesno $
 */
@Repository
public class PollDAO extends EgovAbstractMapper {

    public PollDomainVO getDomain(String domainCd) {

        Map<String, String> parameterMap = new HashMap<String, String>();
        parameterMap.put("domainCd", domainCd);

        return (PollDomainVO) selectByPk("_poll.getDomain", parameterMap);
    }

    /*
     * (non-Javadoc)
     * @see zes.openworks.modules.poll.PollService#domainList()
     */
    @SuppressWarnings("unchecked")
    public List<PollDomainVO> getDomainList(PollDomainVO pollDomainVo) {

        return list("_poll.getDomainList", pollDomainVo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollList(zes.openworks.modules
     * .poll.PollVO)
     */
    @SuppressWarnings("unchecked")
    public Pager<PollVO> pollList(PollVO pollVo) {

        List<PollVO> dataList = list("_poll.pollList", pollVo.getDataMap());
        pollVo.setTotalNum((Integer) (selectByPk("_poll.pollListCount", pollVo.getDataMap())));

        return new Pager<PollVO>(dataList, pollVo);

    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollView(zes.openworks.modules
     * .poll.PollVO)
     */
    public PollVO pollView(PollVO pollVo) {

        return (PollVO) selectByPk("_poll.pollView", pollVo.getDataMap());

    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollInsertAction(zes.openworks
     * .modules.poll.PollVO)
     */
    public Integer pollInsertAction(PollVO pollVo) {

        pollVo.setEndTime(pollVo.getEndTime() + "235959");

        insert("_poll.pollInsert", pollVo);

        Integer insertKey = pollVo.getSeq();

        return insertKey;

    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollUpdateAction(zes.openworks
     * .modules.poll.PollVO)
     */
    public int pollUpdateAction(PollVO pollVo) {

        pollVo.setEndTime(pollVo.getEndTime() + "235959");

        return update("_poll.pollUpdate", pollVo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollDeleteAction(zes.openworks
     * .modules.poll.PollVO)
     */
    @Transactional(rollbackFor = Exception.class)
    public int pollDeleteAction(PollVO pollVo) {

        PollGroupVO pollGroupVo = new PollGroupVO();
        pollGroupVo.setSeq(pollVo.getSeq());

        delete("_poll.pollItemDelete", pollGroupVo);

        delete("_poll.pollGroupDelete", pollGroupVo);

        delete("_poll.pollResponseDelete", pollVo);

        int deleteCnt = delete("_poll.pollDelete", pollVo);

        return deleteCnt;
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollGroupList(zes.openworks.modules
     * .poll.PollVO)
     */
    @SuppressWarnings("unchecked")
    public List<PollGroupVO> pollGroupList(PollVO pollVo) {

        return list("_poll.pollGroupList", pollVo.getDataMap());
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollGroupInsertAction(zes.openworks
     * .modules.poll.PollGroupVO)
     */
    @Transactional(rollbackFor = Exception.class)
    public Integer pollGroupInsertAction(PollGroupVO pollGroupVo) {

        List<String> items = pollGroupVo.getItems();

        // 설문 항목의 특성별 설정(I:단답형, R: 단일선택형, C: 복수 선택형)
        if(pollGroupVo.getType().equals("I")) {
            // 단답형은 기타의견을 받지 않음
            pollGroupVo.setCommentUseYn("N");
            /*
             * 단답형은 그룹명이 항목명과 동일하게 설정하며 등록화면에서 Parameter 없이 요청되므로 List를 생성 후 add
             * 해 준다.
             */
            items = new ArrayList<String>();
            items.add(pollGroupVo.getGroupTitle());
        } else if(pollGroupVo.getType().equals("C") && pollGroupVo.getMultiChoiceCnt() > 1) {
            pollGroupVo.setCommentUseYn("N");
        } else {
            pollGroupVo.setType("R");
        }

        // 그룹별 설문항목 수
        int itemCnt = items.size();

        pollGroupVo.setItemCnt(itemCnt);
        if(pollGroupVo.getCommentUseYn().equals("Y")) {
            pollGroupVo.setItemCnt(itemCnt + 1);
        }

        insert("_poll.pollGroupInsert", pollGroupVo);
        Integer insertKey = pollGroupVo.getGroupSeq();

        Iterator<String> itItem = items.iterator();

        String itemVal = "";
        while(itItem.hasNext()) {
            itemVal = itItem.next();
            if(!Validate.isEmpty(itemVal)) {
                pollGroupVo.setItem(itemVal);
                insert("_poll.pollItemInsert", pollGroupVo);
            }
        }

        if(pollGroupVo.getCommentUseYn().equals("Y")) {
            pollGroupVo.setEtcYn("Y");
            pollGroupVo.setItem("기타의견");
            insert("_poll.pollItemInsert", pollGroupVo);
        }

        // 설문항목수 증가
        pollGroupVo.setAddOrDel("ADD");
        update("_poll.groupCntUpdate", pollGroupVo);

        return insertKey;
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollGroupUpdateAction(zes.openworks
     * .modules.poll.PollGroupVO)
     */
    @Transactional(rollbackFor = Exception.class)
    public int pollGroupUpdateAction(PollGroupVO pollGroupVo) {

        PollGroupVO groupInfo = (PollGroupVO) selectByPk("_poll.pollGroupView", pollGroupVo);

        List<String> items = new ArrayList<String>();
        int itemCnt = 0;

        if(groupInfo.getType().equals("I")) {

            items.add(pollGroupVo.getGroupTitle());
            itemCnt = 1;
            pollGroupVo.setItemCnt(itemCnt);

        } else {

            items = pollGroupVo.getItems();
            itemCnt = items.size();
            pollGroupVo.setItemCnt(itemCnt);

            if(pollGroupVo.getMultiChoiceCnt().intValue() > 1) {
                pollGroupVo.setType("C");
            } else {
                pollGroupVo.setType("R");
            }

            /*
             * CHECKBOX 타입(기타의견 사용불가)이거나,사용에서 미사용으로 변경시 이전 기타의견 항목 삭제 및 기타의견
             * 미사용으로 설정 변경
             */
            if(pollGroupVo.getType().equals("C")
                || (groupInfo.getCommentUseYn().equals("Y") && pollGroupVo.getCommentUseYn().equals("N"))) {

                pollGroupVo.setEtcYn("Y");
                delete("_poll.pollItemDelete", pollGroupVo);

                // 기타의견 미사용설정
                pollGroupVo.setCommentUseYn("N");

            } else if(groupInfo.getCommentUseYn().equals("N") && pollGroupVo.getCommentUseYn().equals("Y")) {

                pollGroupVo.setEtcYn("Y");
                pollGroupVo.setItem("기타의견");
                insert("_poll.pollItemInsert", pollGroupVo);

                // 기타의견 사용설정
                pollGroupVo.setCommentUseYn("Y");
                pollGroupVo.setItemCnt(itemCnt + 1);

            }

        }

        update("_poll.pollGroupUpdate", pollGroupVo);

        for(int i = 0 ; i < itemCnt ; i++) {
            pollGroupVo.setItemSeq(i + 1);
            pollGroupVo.setItem(items.get(i));
            update("_poll.pollItemUpdate", pollGroupVo);
        }

        return itemCnt;
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollGroupDeleteAction(zes.openworks
     * .modules.poll.PollGroupVO)
     */
    @Transactional(rollbackFor = Exception.class)
    public int pollGroupDeleteAction(PollGroupVO pollGroupVo) {

        // 항목 삭제
        delete("_poll.pollItemDelete", pollGroupVo);

        // 그룹 삭제
        int deleteCnt = delete("_poll.pollGroupDelete", pollGroupVo);

        // 설문항목수 감소
        if(deleteCnt > 0) {
            pollGroupVo.setAddOrDel("DEL");
            delete("_poll.groupCntUpdate", pollGroupVo);
        }

        return deleteCnt;

    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollCommentList(zes.openworks.
     * modules.poll.PollGroupVO)
     */
    public Pager<PollGroupVO> pollCommentList(PollGroupVO pollGroupVo) {

        @SuppressWarnings("unchecked")
        List<PollGroupVO> dataList = list("_poll.pollCommentList", pollGroupVo.getDataMap());
        pollGroupVo.setTotalNum((Integer) (selectByPk("_poll.pollCommentListCount", pollGroupVo.getDataMap())));

        return new Pager<PollGroupVO>(dataList, pollGroupVo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.modules.poll.PollService#pollResponseList(zes.openworks
     * .modules.poll.PollResponseVO)
     */
    @SuppressWarnings("unchecked")
    public List<PollResponseVO> pollResponseList(PollResponseVO pollResponseVo) {

        return list("_poll.pollResponseList", pollResponseVo);

    }

}
