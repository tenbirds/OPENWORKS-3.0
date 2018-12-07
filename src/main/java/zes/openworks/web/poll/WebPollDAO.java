/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.poll;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * <pre>
 * 설문관리 DAO
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 12.
 * @version $Id: WebPollDAO.java 2010. 3. 12. yesno $
 */
@Repository
public class WebPollDAO extends EgovAbstractMapper {

    public WebPollDomainVO getDomain(String domainName) {

        Map<String, String> parameterMap = new HashMap<String, String>();
        parameterMap.put("domainNm", domainName);

        return (WebPollDomainVO) selectByPk("_user_poll.getDomain", parameterMap);
    }

    /*
     * (non-Javadoc)
     * @see zes.openworks.web.poll.WebPollService#domainList()
     */
    @SuppressWarnings("unchecked")
    public List<WebPollDomainVO> getDomainList() {

        Map<String, String> parameterMap = new HashMap<String, String>();

        return list("_user_poll.getDomainList", parameterMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollList(zes.openworks.web.poll
     * .WebPollVO)
     */
    @SuppressWarnings("unchecked")
    public Pager<WebPollVO> pollList(WebPollVO pollVo) {

        List<WebPollVO> dataList = list("_user_poll.pollList", pollVo.getDataMap());
        pollVo.setTotalNum((Integer) (selectByPk("_user_poll.pollListCount", pollVo.getDataMap())));

        return new Pager<WebPollVO>(dataList, pollVo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollBannerList(zes.openworks.web
     * .poll.WebPollVO)
     */
    @SuppressWarnings("unchecked")
    public List<WebPollVO> pollBannerList(WebPollVO pollVo) {

        return list("_user_poll.pollBannerList", pollVo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollView(zes.openworks.web.poll
     * .WebPollVO)
     */
    public WebPollVO pollView(WebPollVO pollVo) {

        update("_user_poll.increaseReadCntUpdate", pollVo.getDataMap());

        return (WebPollVO) selectByPk("_user_poll.pollView", pollVo.getDataMap());
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollGroupList(zes.openworks.web
     * .poll.WebPollVO)
     */
    @SuppressWarnings("unchecked")
    public List<WebPollGroupVO> pollGroupList(WebPollVO pollVo) {

        return list("_user_poll.pollGroupList", pollVo.getDataMap());
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollCommentList(zes.openworks.web
     * .poll.WebPollGroupVO)
     */
    public Pager<WebPollGroupVO> pollCommentList(WebPollGroupVO pollGroupVO) {

        @SuppressWarnings("unchecked")
        List<WebPollGroupVO> dataList = list("_user_poll.pollCommentList", pollGroupVO.getDataMap());
        pollGroupVO.setTotalNum((Integer) (selectByPk("_user_poll.pollCommentListCount", pollGroupVO.getDataMap())));

        return new Pager<WebPollGroupVO>(dataList, pollGroupVO);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollResponseList(zes.openworks.
     * web.poll.WebPollResponseVO)
     */
    @SuppressWarnings("unchecked")
    public List<WebPollResponseVO> pollResponseList(WebPollResponseVO pollResponseVo) {

        return list("_user_poll.pollResponseList", pollResponseVo);

    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.web.poll.WebPollService#pollValidList(zes.openworks.web
     * .poll.WebPollVO)
     */
    @SuppressWarnings("unchecked")
    public List<WebPollGroupVO> pollValidList(WebPollVO pollVo) {

        return list("_user_poll.pollValidList", pollVo.getDataMap());
    }

    /*
     * (non-Javadoc)
     * @see zes.openworks.web.poll.WebPollService#pollResponse(java.util.Map)
     */
    public int pollResponse(Map<String, Object> itemMap) {

        int listCnt = 0;
        // Query 에 사용될 데이터
        Map<String, Object> paramMap = new HashMap<String, Object>();
        // 선택형과 단답형(기타의견 포함) 목록을 가져온다
        Map<String, List<Map<String, Object>>> paramListMap = getParseItem(itemMap);

        // 항목별 선택 수 증가
        List<Map<String, Object>> increaseItemList = paramListMap.get("increaseItemList");

        listCnt = increaseItemList.size();
        for(int i = 0 ; i < listCnt ; i++) {

            paramMap = increaseItemList.get(i);
            paramMap.put("domainCd", itemMap.get("domainCd"));
            paramMap.put("seq", itemMap.get("seq"));
            paramMap.put("regId", itemMap.get("regId"));
            update("_user_poll.pollItemUpdate", paramMap);

        }

        // 단답형 및 기타의견
        List<Map<String, Object>> commentItemList = paramListMap.get("commentItemList");

        listCnt = commentItemList.size();
        for(int i = 0 ; i < listCnt ; i++) {

            paramMap = commentItemList.get(i);
            paramMap.put("domainCd", itemMap.get("domainCd"));
            paramMap.put("seq", itemMap.get("seq"));
            paramMap.put("regId", itemMap.get("regId"));
            insert("_user_poll.pollCommentInsert", paramMap);

        }

        // 설문 등답자수 카운트 업데이트
        update("_user_poll.increaseResponseUpdate", paramMap);

        insert("_user_poll.pollResponseHistInsert", itemMap);
        int insertKey = (Integer) itemMap.get("histSeq");

        return insertKey;

    }

    /**
     * <pre>
     * 설문 응답 파라미터를 DB 입력에 맞도록 구성한다.
     * 항목(input name)명은 아래와 같은 규칙을 가진다.
     * 
     * 예) pollItem__5__R__E  : __ 구분자로 <code>String.split()</code>하며 각 항목의 의미는 아래와 같다.
     *    - pollItem : form 속성중에 고유의 이름을 가지기 위한 구분
     *    - 5 : 설문 그룹 일련번호
     *    - R,C,I : 각각 input type에 해당한다. 'R'=radio, 'C'=checkbox, 'I'=text
     *    - E : 기타의견 항목의 내용인지를 나타내며, 기타 항목 이외의 경우에는 E 자리는 없다.
     * 
     * </pre>
     */
    @SuppressWarnings("unchecked")
    private Map<String, List<Map<String, Object>>> getParseItem(Map<String, Object> itemMap) {

        String key = "";
        String[] keyArr = null;

        Map<String, List<Map<String, Object>>> paramMap = new HashMap<String, List<Map<String, Object>>>();
        Map<String, Object> tempMap = new HashMap<String, Object>();

        // 항목별 선택 수 증가 대상
        List<Map<String, Object>> increaseItemList = new ArrayList<Map<String, Object>>();
        // 단답형 및 기타의견 등록 대상
        List<Map<String, Object>> commentItemList = new ArrayList<Map<String, Object>>();

        Iterator<String> it = itemMap.keySet().iterator();

        while(it.hasNext()) {

            key = it.next();

            if(key.startsWith("pollItem__")) {
                keyArr = getSplitKey(key);

                tempMap = new HashMap<String, Object>();
                if(keyArr[2].equals("I")) {

                    tempMap.put("groupSeq", keyArr[1]);
                    tempMap.put("itemSeq", "1");
                    increaseItemList.add(tempMap);

                    tempMap = new HashMap<String, Object>();

                    tempMap.put("groupSeq", keyArr[1]);
                    tempMap.put("itemSeq", "1");
                    tempMap.put("etcComments", itemMap.get(key));
                    commentItemList.add(tempMap);

                } else if(keyArr[2].equals("C")) {

                    Object checkBoxObj = itemMap.get(key);

                    if(checkBoxObj instanceof String) {

                        tempMap = new HashMap<String, Object>();
                        tempMap.put("groupSeq", keyArr[1]);
                        tempMap.put("itemSeq", itemMap.get(key));
                        increaseItemList.add(tempMap);

                    } else if(checkBoxObj instanceof ArrayList<?>) {

                        ArrayList<String> valueList = (ArrayList<String>) checkBoxObj;
                        int valueCnt = valueList.size();
                        for(int j = 0 ; j < valueCnt ; j++) {
                            tempMap = new HashMap<String, Object>();
                            tempMap.put("groupSeq", keyArr[1]);
                            tempMap.put("itemSeq", valueList.get(j));
                            increaseItemList.add(tempMap);
                        }

                    } else if(checkBoxObj instanceof String[]) {

                        String[] valueArr = (String[]) checkBoxObj;
                        int valueCnt = valueArr.length;
                        for(int j = 0 ; j < valueCnt ; j++) {
                            tempMap = new HashMap<String, Object>();
                            tempMap.put("groupSeq", keyArr[1]);
                            tempMap.put("itemSeq", valueArr[j]);
                            increaseItemList.add(tempMap);
                        }
                    }

                } else if(keyArr[2].equals("R")) {

                    int splitKeyCnt = keyArr.length;
                    tempMap = new HashMap<String, Object>();
                    /*
                     * 기타의견 내용이 아니면 선택수만 반영 기타의견 내용은 splitKeyCnt == 4 의 조건이 만족되야
                     * 함
                     */
                    if(splitKeyCnt <= 3) {
                        /* 기타의견 이외의 일반 선택 */
                        tempMap.put("groupSeq", keyArr[1]);
                        tempMap.put("itemSeq", itemMap.get(key));
                        increaseItemList.add(tempMap);
                    } else {
                        /*
                         * 기타의견내용 특성상 기타의견 항목에 딸리기 때문에 기타의견의 항목일련번호(부모키)를 구하여
                         * 기타의견 테이블에 등록한다.
                         */
                        String parentKey = key.substring(0, (key.length() - 3));
                        tempMap.put("groupSeq", keyArr[1]);
                        tempMap.put("itemSeq", itemMap.get(parentKey));
                        tempMap.put("etcComments", itemMap.get(key));
                        commentItemList.add(tempMap);
                    }
                }
            }
        }

        paramMap.put("increaseItemList", increaseItemList);
        paramMap.put("commentItemList", commentItemList);

        return paramMap;
    }

    /**
     * 설문 항목 키를 구분자로 분리하여 문자 배열로 반환
     */
    private String[] getSplitKey(String key) {

        String[] splitKey = key.split("__");

        return splitKey;
    }

}
