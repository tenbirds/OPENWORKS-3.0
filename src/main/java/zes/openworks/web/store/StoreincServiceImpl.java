/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
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
@Service
public class StoreincServiceImpl extends AbstractServiceImpl implements StoreincService {

    @Resource
    private StoreincDAO dao;


    /* (상세 화면 분뷰)
     * @see zes.openworks.web.store.StoreincService#dstbStoreView(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public String dstbStoreView(StoreincVO vo) {
        return dao.dstbStoreView(vo);
    }

    /* (전시 하기 상태 확인)
     * @see zes.openworks.web.store.StoreincService#dstbStoreStatus(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public Integer dstbStoreStatus(StoreincVO vo) {
        return dao.dstbStoreStatus(vo);
    }

    /*
     * (서비스평 목록)
     * @see zes.openworks.web.store.StoreincService#incComment(java.lang.Object)
     */
    @Override
    public Pager<StoreincVO> incCommentList(StoreincVO vo) {
        return dao.incCommentList(vo);
    }

    /*
     * (서비스평 평점)
     * @see
     * zes.openworks.web.store.StoreincService#incCommentAvg(zes.openworks.web
     * .store.StoreincVO)
     */
    @Override
    public StoreincVO incCommentAvg(StoreincVO vo) {
        return dao.incCommentAvg(vo);
    }

    /*
     * (서비스평 삭제)
     * @see
     * zes.openworks.web.store.StoreincService#incCommentDeleteAction(zes.openworks
     * .web.store.StoreincVO)
     */
    @Override
    public int incCommentDeleteAction(StoreincVO vo) {
        return dao.incCommentDeleteAction(vo);
    }

    /* (서비스평 중복 체크)
     * @see zes.openworks.web.store.StoreincService#incCommentCheck(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public int incCommentCheck(StoreincVO vo) {
        return dao.incCommentCheck(vo);
    }


    /*
     * (서비스평 등록)
     * @see
     * zes.openworks.web.store.StoreincService#incCommentInsertAction(zes.openworks
     * .web.store.StoreincVO)
     */
    @Override
    public int incCommentInsertAction(StoreincVO vo) {
        return dao.incCommentInsertAction(vo);
    }

    /*
     * (서비스평 수정)
     * @see
     * zes.openworks.web.store.StoreincService#incCommentUpdateAction(zes.openworks
     * .web.store.StoreincVO)
     */
    @Override
    public int incCommentUpdateAction(StoreincVO vo) {
        return dao.incCommentUpdateAction(vo);
    }

    /*
     * (문의 목록)
     * @see zes.openworks.web.store.StoreincService#incLnquiry(java.lang.Object)
     */
    @Override
    public Pager<StoreincVO> incLnquiry(StoreincVO vo) {
        return dao.incLnquiry(vo);
    }

    /* (문의 상세)
     * @see zes.openworks.web.store.StoreincService#incLnquiryView(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public StoreincVO incLnquiryView(StoreincVO vo) {
        return dao.incLnquiryView(vo);
    }

    /*
     * (문의 삭제)
     * @see
     * zes.openworks.web.store.StoreincService#incLnquiryDeleteAction(zes.openworks
     * .web.store.StoreincVO)
     */
    @Override
    public int incLnquiryDeleteAction(StoreincVO vo) {
        return dao.incLnquiryDeleteAction(vo);
    }

    /*
     * (문의 등록)
     * @see
     * zes.openworks.web.store.StoreincService#incLnquiryInsertAction(zes.openworks
     * .web.store.StoreincVO)
     */
    @Override
    public int incLnquiryInsertAction(StoreincVO vo) {
        return dao.incLnquiryInsertAction(vo);
    }

    /*
     * (문의 수정)
     * @see
     * zes.openworks.web.store.StoreincService#incLnquiryUpdateAction(zes.openworks
     * .web.store.StoreincVO)
     */
    @Override
    public int incLnquiryUpdateAction(StoreincVO vo) {
        return dao.incLnquiryUpdateAction(vo);
    }

    /*
     * (연관 목록)
     * @see
     * zes.openworks.web.store.StoreincService#incRelation(java.lang.Object)
     */
    @Override
    public Pager<StoreincVO> incRelation(StoreincVO vo) {
        return dao.incRelation(vo);
    }


    /*
     * (리뷰 목록)
     * @see zes.openworks.web.store.StoreincService#incReview(java.lang.Object)
     */
    @Override
    public List<BoardVO> incReview(BoardVO vo) {
        return dao.incReview(vo);
    }



    /* (문의하기 등록)
     * @see zes.openworks.web.store.StoreincService#inquiryInsertAction(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public int inquiryInsertAction(StoreincVO vo) {
        return dao.inquiryInsertAction(vo);
    }



    /* (문의하기 수정)
     * @see zes.openworks.web.store.StoreincService#inquiryUpdateAction(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public int inquiryUpdateAction(StoreincVO vo) {
        return dao.inquiryUpdateAction(vo);
    }

    /* (문의하기 삭제)
     * @see zes.openworks.web.store.StoreincService#inquiryDeleteAction(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public int inquiryDeleteAction(StoreincVO vo) {
        return dao.inquiryDeleteAction(vo);
    }

    /* (신고하기)
     * @see zes.openworks.web.store.StoreincService#accuseInsertAction(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public int accuseInsertAction(StoreincVO vo) {
        return dao.accuseInsertAction(vo);
    }

    /* (신고하기 체크)
     * @see zes.openworks.web.store.StoreincService#inquiryCheck(zes.openworks.web.store.StoreincVO)
     */
    @Override
    public StoreincVO inquiryCheck(StoreincVO vo) {
        return dao.inquiryCheck(vo);
    }


    @Override
    public List<StoreincVO> adminEmailList(){
        return dao.adminEmailList();
    }

    @Override
    public List<FileVO> goodUserImgList(StoreincVO vo){
        return dao.goodUserImgList(vo);
    }

}
