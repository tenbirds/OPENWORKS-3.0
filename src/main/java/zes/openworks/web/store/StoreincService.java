/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store;

import java.util.List;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.board.BoardVO;

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
 *  2014. 11. 6.    이슬버미       신규
 * </pre>
 * @see
 */
public interface StoreincService {


    /**
     * dstbStoreView 상세 페이지 분배
     * @param vo
     * @return
     */
    String dstbStoreView(StoreincVO vo);

    /**
     * dstbStoreStatus (정시 상탷 확인)
     * @param vo
     * @return
     */
    Integer dstbStoreStatus(StoreincVO vo);

    /**
     * incComment (서비스평 목록)
     *
     * @param vo
     * @return
     */
    Pager<StoreincVO> incCommentList(StoreincVO vo);

    /**
     * incCommentAvg (서비스명 평점)
     *
     * @param vo
     * @return
     */
    StoreincVO incCommentAvg(StoreincVO vo);

    /**
     * incCommentDeleteAction (서비스평 삭제)
     *
     * @param vo
     * @return
     */
    int incCommentDeleteAction(StoreincVO vo);

    /**
     * incCommentCheck (서비스평 중복체크)
     *
     * @param vo
     * @return
     */
    int incCommentCheck(StoreincVO vo);

    /**
     * incCommentInsertAction (서비스평 등록)
     *
     * @param vo
     * @return
     */
    int incCommentInsertAction(StoreincVO vo);

    /**
     * incCommentUpdateAction (서비스평 수정)
     *
     * @param vo
     * @return
     */
    int incCommentUpdateAction(StoreincVO vo);

    /**
     * incLnquiry (문의 목록)
     *
     * @param vo
     * @return
     */
    Pager<StoreincVO> incLnquiry(StoreincVO vo);

    /**
     * incLnquiryView (문의 상세)
     * @param vo
     * @return
     */
    StoreincVO incLnquiryView(StoreincVO vo);

    /**
     * incLnquiryDeleteAction (문의 삭제)
     *
     * @param vo
     * @return
     */
    int incLnquiryDeleteAction(StoreincVO vo);

    /**
     * incLnquiryInsertAction (문의 등록)
     *
     * @param vo
     * @return
     */
    int incLnquiryInsertAction(StoreincVO vo);

    /**
     * incLnquiryUpdateAction (문의 수정)
     *
     * @param vo
     * @return
     */
    int incLnquiryUpdateAction(StoreincVO vo);

    /**
     * incRelation (연관 목록)
     *
     * @param vo
     * @return
     */
    Pager<StoreincVO> incRelation(StoreincVO vo);


    /**
     * incReview (리뷰 목록)
     *
     * @param vo
     * @return
     */
    List<BoardVO> incReview(BoardVO vo);

    /**
     * inquiryInsertAction (문의하기 등록)
     *
     * @param vo
     * @return
     */
    int inquiryInsertAction(StoreincVO vo);

    /**
     * inquiryUpdateAction (문의하기 수정)
     *
     * @param vo
     * @return
     */
    int inquiryUpdateAction(StoreincVO vo);

    /**
     * inquiryDeleteAction (문의하기 삭제)
     *
     * @param vo
     * @return
     */
    int inquiryDeleteAction(StoreincVO vo);

    /**
     * accuseInsertAction (신고하기)
     * @param vo
     * @return
     */
    int accuseInsertAction(StoreincVO vo);

    /**
     * inquiryCheck (신고하기 체크)
     * @param vo
     * @return
     */
    StoreincVO inquiryCheck(StoreincVO vo);

    /**
     * adminEmailList (관리자 이메일 리스트)
     * @return
     */
    List<StoreincVO> adminEmailList();

    List<FileVO> goodUserImgList(StoreincVO vo);

}
