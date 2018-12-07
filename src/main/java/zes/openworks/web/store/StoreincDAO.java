/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
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
@Repository
@SuppressWarnings("unchecked")
public class StoreincDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * dstbStoreView (상세 화면 분뷰)
     * @param vo
     * @return
     */
    public String dstbStoreView(StoreincVO vo) {
        return  (String) selectByPk("_storeinc.dstbStoreView", vo);
    }

    /**
     * dstbStoreStatus (정시 상태 확인)
     * @param vo
     * @return
     */
    public Integer dstbStoreStatus(StoreincVO vo) {
        return  (Integer) selectByPk("_storeinc.dstbStoreStatus", vo);
    }


    /**
     * incComment (서비스평 목록)
     * @param vo
     * @return
     */
    public Pager<StoreincVO> incCommentList(StoreincVO vo) {

        vo.getDataMap().put("pageUrlNm", vo.getPageUrlNm());
        vo.getDataMap().put("goodsCode", vo.getGoodsCode());

        List<StoreincVO> dataList = list("_storeinc.incCommentList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_storeinc.incCommentCount", vo.getDataMap()));
        return new Pager<StoreincVO>(dataList, vo);
    }

    /**
     * incCommentAvg (서비스평 평점)
     * @param vo
     * @return
     */
    public StoreincVO incCommentAvg(StoreincVO vo) {
        return (StoreincVO) selectByPk("_storeinc.incCommentAvg", vo);
    }

    /**
     * incCommentDeleteAction (서비스평 삭제)
     * @param vo
     * @return
     */
    public int incCommentDeleteAction(StoreincVO vo) {
        return delete("_storeinc.incCommentDeleteAction", vo);
    }

    /**
     * incCommentCheck (서비스평 중복 체크)
     * @param vo
     * @return
     */
    public int incCommentCheck(StoreincVO vo) {
        return (Integer) selectByPk("_storeinc.incCommentCheck", vo);
    }

    /**
     * incCommentInsertAction (서비스평 등록)
     * @param vo
     * @return
     */
    public int incCommentInsertAction(StoreincVO vo) {
        return insert("_storeinc.incCommentInsertAction", vo);
    }

    /**
     * incCommentUpdateAction (서비스평 수정)
     * @param vo
     * @return
     */
    public int incCommentUpdateAction(StoreincVO vo) {
        return update("_storeinc.incCommentUpdateAction", vo);
    }

    /**
     * incLnquiry (서비스문의 목록)
     * @param vo
     * @return
     */
    public Pager<StoreincVO> incLnquiry(StoreincVO vo) {

        vo.getDataMap().put("pageUrlNm", vo.getPageUrlNm());
        vo.getDataMap().put("goodsCode", vo.getGoodsCode());

        List<StoreincVO> dataList = list("_storeinc.incLnquiryList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_storeinc.incLnquiryCount", vo.getDataMap()));
        return new Pager<StoreincVO>(dataList, vo);
    }

    /**
     * incLnquiryView (문의 상세)
     * @param vo
     * @return
     */
    public StoreincVO incLnquiryView(StoreincVO vo) {
        return (StoreincVO) selectByPk("_storeinc.inquiryView", vo);
    }

    /**
     * incLnquiryDeleteAction (서비스문의 삭제)
     * @param vo
     * @return
     */
    public int incLnquiryDeleteAction(StoreincVO vo) {
        return delete("_storeinc.incLnquiryDeleteAction", vo);
    }

    /**
     * incLnquiryInsertAction (서비스문의 등록)
     * @param vo
     * @return
     */
    public int incLnquiryInsertAction(StoreincVO vo) {
        return insert("_storeinc.incLnquiryInsertAction", vo);
    }

    /**
     * incLnquiryUpdateAction (서비스문의 수정)
     * @param vo
     * @return
     */
    public int incLnquiryUpdateAction(StoreincVO vo) {
        return update("_storeinc.incLnquiryUpdateAction", vo);
    }

    /**
     * incRelation (연관)
     * @param vo
     * @return
     */
    public Pager<StoreincVO> incRelation(StoreincVO vo) {

        vo.getDataMap().put("langCode", vo.getLangCode());
        vo.getDataMap().put("goodsCode", vo.getGoodsCode());

        List<StoreincVO> dataList = list("_storeinc.incRelationList",  vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_storeinc.incRelationListCount", vo.getDataMap()));
        for(StoreincVO data : dataList) {
//          for(int fileSeq : data.getGoodsMarkList()){
            data.setImageFile(fileDao.getFiles(data.getGoodsImageFileSeq()));
            if (Validate.isNotEmpty(data.getCngdMarkList())) {
                data.setCngdMarkFile(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getCngdMarkList().get(0).get("CNTC_GOODS_IMAGE_SEQ")))));
            }
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }

            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }

        return new Pager<StoreincVO>(dataList, vo);
    }




    /**
     * incReview (리뷰)
     * @param vo
     * @return
     */
    public List<BoardVO> incReview(BoardVO boardVO) {

        //int listTotalCount = ((Integer) (selectByPk("_storeinc.incReviewListCount", boardVO))).intValue();

        List<BoardVO> dataList = list("_storeinc.incReviewList", boardVO);
        for(BoardVO dataVO : dataList) {
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
        }

        return dataList;
    }

    /**
     * inquiryInsertAction (문의하기 등록)
     * @param vo
     * @return
     */
    public int inquiryInsertAction(StoreincVO vo) {
        insert("_storeinc.inquiryInsertAction", vo);
        return  ((StoreincVO)  selectByPk("_storeinc.inquirySelectKey", vo)).getGoodsInqryNo();
    }

    /**
     * inquiryUpdateAction (문의하기 수정)
     * @param vo
     * @return
     */
    public int inquiryUpdateAction(StoreincVO vo) {
        return update("_storeinc.inquiryUpdateAction", vo);
    }

    /**
     * inquiryDeleteAction (문의하기 삭제)
     * @param vo
     * @return
     */
    public int inquiryDeleteAction(StoreincVO vo) {
        return delete("_storeinc.inquiryDeleteAction", vo);
    }


    /**
     * accuseInsertAction (문의하기)
     * @param vo
     * @return
     */
    public int accuseInsertAction(StoreincVO vo) {
        return update("_storeinc.inquiryUpdateAction", vo);
    }


    /**
     * inquiryCheck (신고하기 체크)
     * @param vo
     * @return
     */
    public StoreincVO inquiryCheck(StoreincVO vo) {
        return (StoreincVO) selectByPk("_storeinc.inquiryCheck", vo);
    }

    /**
     * adminEmailList (관리자 이메일 리스트)
     * @return
     */
    public List<StoreincVO> adminEmailList(){
        return list("_storeinc.adminEmailList", new StoreincVO());
    }

    /**
     * adminEmailList (관리자 이메일 리스트)
     * @return
     */
    public List<FileVO> goodUserImgList(StoreincVO vo){
        return fileDao.getFiles(vo.getGoodsImageFileSeq());
       // return list("_storeinc.adminEmailList",vo);
    }

}
