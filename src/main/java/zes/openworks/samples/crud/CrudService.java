/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.samples.crud;

import java.util.List;

import zes.base.pager.Pager;

/**
 * 셈플
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface CrudService {

    /**
     * 상세 화면
     * 
     * @param crudVo
     * @return
     */
    CrudVO crudView(CrudVO crudVo);

    /**
     * 화면 데이터(수정등의 용도)
     * 
     * @param crudVo
     * @return
     */
    CrudVO crudData(CrudVO crudVo);

    /**
     * 목록 화면
     * 
     * @param crudVo
     * @return
     */
    Pager<CrudVO> crudList(CrudVO crudVo);

    /**
     * 등록
     * 
     * @param crudVo
     * @return
     */
    Object crudInsert(CrudVO crudVo);

    /**
     * 수정
     * 
     * @param crudVo
     * @return
     */
    Integer crudUpdate(CrudVO crudVo);

    /**
     * 삭제
     * 
     * @param crudVo
     * @return
     */
    Integer crudDelete(CrudVO crudVo);

    /**
     * 목록 삭제
     * 
     * @param crudVo
     * @return
     */
    Integer crudListDelete(CrudVO crudVo);

    /**
     * 답변 상세(답변 수정용)
     * 
     * @param crudVo
     * @return
     */
    CrudReplyVO crudReplyView(CrudReplyVO crudReplyVo);

    /**
     * 답변 목록(원본 상세 화면 하단에 표시)
     * 
     * @param crudReplyVo
     * @return
     */
    List<CrudReplyVO> crudReplyList(CrudReplyVO crudReplyVo);

    /**
     * 답변 등록
     * 
     * @param crudReplyVo
     * @return
     */
    Object crudReplyInsert(CrudReplyVO crudReplyVo);

    /**
     * 답변 수정
     * 
     * @param crudReplyVo
     * @return
     */
    Integer crudReplyUpdate(CrudReplyVO crudReplyVo);

    /**
     * 답글 삭제
     * 
     * @param crudReplyVo
     * @return
     */
    Integer crudReplyDelete(CrudReplyVO crudReplyVo);

}
