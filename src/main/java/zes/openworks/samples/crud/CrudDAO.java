/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.samples.crud;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 25.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class CrudDAO extends EgovAbstractMapper {

    /**
     * 상세 조회
     * 
     * @param crudVo
     * @return
     */
    public CrudVO crudView(CrudVO crudVo) {

        insert("zes.openworks.samples.crud.increase", crudVo.getDataMap());
        return (CrudVO) selectByPk("zes.openworks.samples.crud.crudView", crudVo.getDataMap());
    }

    /**
     * 상세 데이터
     * 
     * @param crudVo
     * @return
     */
    public CrudVO crudData(CrudVO crudVo) {

        return (CrudVO) selectByPk("zes.openworks.samples.crud.crudView", crudVo.getDataMap());
    }

    /**
     * 목록 조회
     * 
     * @param request
     * @param crudVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<CrudVO> crudList(CrudVO crudVo) {

        List<CrudVO> dataList = list("zes.openworks.samples.crud.crudList", crudVo.getDataMap());
        crudVo.setTotalNum((Integer) selectByPk("zes.openworks.samples.crud.crudListCount", crudVo.getDataMap()));

        return new Pager<CrudVO>(dataList, crudVo);
    }

    /**
     * 등록
     * 
     * @param crudVo
     * @return
     */
    public Object crudInsert(CrudVO crudVo) {

        return insert("zes.openworks.samples.crud.crudInsert", crudVo);
    }

    /**
     * 수정
     * 
     * @param crudVo
     * @return
     */
    public Integer crudUpdate(CrudVO crudVo) {

        return update("zes.openworks.samples.crud.crudUpdate", crudVo);
    }

    /**
     * 삭제
     * 
     * @param crudVo
     * @return
     */
    public Integer crudDelete(CrudVO crudVo) {

        return delete("zes.openworks.samples.crud.crudDelete", crudVo.getDataMap());
    }

    /**
     * 답변 상세(답변 수정용)
     * 
     * @param crudReplyVo
     * @return
     */
    public CrudReplyVO crudReplyView(CrudReplyVO crudReplyVo) {

        return (CrudReplyVO) selectByPk("zes.openworks.samples.crud-reply.crudReplyView",
            crudReplyVo.getDataMap());
    }

    /**
     * 답변 목록
     * 
     * @param crudReplyVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<CrudReplyVO> crudReplyList(CrudReplyVO crudReplyVo) {

        return list("zes.openworks.samples.crud-reply.crudReplyList", crudReplyVo.getDataMap());
    }

    /**
     * 답변 등록
     * 
     * @param crudVo
     * @return
     */
    public Object crudReplyInsert(CrudReplyVO crudReplyVo) {

        Object key = insert("zes.openworks.samples.crud-reply.crudReplyInsert", crudReplyVo);

        crudReplyVo.setReplySeq((Integer) key);

        update("zes.openworks.samples.crud-reply.crudReplyYnUpdate", crudReplyVo);

        return key;
    }

    /**
     * 답변 수정
     * 
     * @param crudVo
     * @return
     */
    public Integer crudReplyUpdate(CrudReplyVO crudReplyVo) {

        return update("zes.openworks.samples.crud-reply.crudReplyUpdate", crudReplyVo);
    }

    /**
     * 답변 삭제
     * 
     * @param crudVo
     * @return
     */
    public Integer crudReplyDelete(CrudReplyVO crudReplyVo) {

        Integer cnt = delete("zes.openworks.samples.crud-reply.crudReplyDelete", crudReplyVo.getDataMap());

        update("zes.openworks.samples.crud-reply.crudReplyYnUpdate", crudReplyVo);

        return cnt;
    }

    /**
     * 답변 목록 삭제
     * 
     * @param crudVo
     * @return
     */
    public Integer crudReplyListDelete(CrudReplyVO crudReplyVo) {

        Integer cnt = delete("zes.openworks.samples.crud-reply.crudReplyListDelete", crudReplyVo.getDataMap());

        return cnt;
    }

}