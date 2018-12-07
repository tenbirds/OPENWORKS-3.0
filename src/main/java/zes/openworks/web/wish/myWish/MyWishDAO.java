/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.wish.myWish;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.openworks.component.file.FileDAO;
import zes.openworks.web.myCeart.vo.HistoryGoodsSearchVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNofyVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class MyWishDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * consultList (구매/신청관리 목록)
     * @param vo
     * @return
     */
    public List<MyWishVO> myWishList(MyWishVO vo) {
        return list("_myWish.myWishList", vo);
    }

    /**
     * myWishStoreList (구매희망 보관 목록)
     * @param vo
     * @return
     */
    public Pager<MyWishVO> myWishStoreList(MyWishVO vo) {
        vo.getDataMap().put("userId", vo.getUserId());
        vo.getDataMap().put("grpSeq", vo.getGrpSeq());
        vo.getDataMap().put("goodsCodeList", vo.getGoodsCodeList());
        
        List<MyWishVO> dataList = list("_myWish.myWishStoreList", vo.getDataMap()); // 구매희망 보관 서비스 목록
        vo.setTotalNum( dataList.size() );                                          // 구매희망 보관 서비스수
        return new Pager<MyWishVO>(dataList, vo);
    }

    /**
     * myWishConfirmList (구매희망 확정 목록)
     * @param vo
     * @return
     */
    public Pager<MyWishVO> myWishConfirmList(MyWishVO vo) {
        vo.getDataMap().put("userId", vo.getUserId());
        vo.getDataMap().put("grpSeq", vo.getGrpSeq());
        vo.getDataMap().put("goodsCd", vo.getGoodsCd());
        List<MyWishVO> dataList = list("_myWish.myWishConfirmList", vo.getDataMap());     // 구매희망 확정 서비스 목록
        vo.setTotalNum( dataList.size() );                                                // 구매희망 확정 서비스수
        return new Pager<MyWishVO>(dataList, vo);
    }

    /**
     * myWishConfrmDt (구매희망 확정 일자)
     * @param vo
     * @return
     */
    public String myWishConfrmDt(MyWishVO vo) {
        vo.getDataMap().put("userId", vo.getUserId());
        vo.getDataMap().put("grpSeq", vo.getGrpSeq());
        String confrmDt = (String) selectByPk("_myWish.myWishConfrmDt", vo.getDataMap());     // 구매희망 최종 생성일자
        return confrmDt;
    }

    /**
     * consultList (구매/신청관리 목록)
     * @param vo
     * @return
     */
    public MyWishVO myWishInfo(MyWishVO vo) {
        return (MyWishVO) selectByPk("_myWish.myWishInfo", vo);
    }


    /**
     * wishDetailList 설명
     * @param vo
     * @return
     */
    public Pager<MyWishVO> myWishDetailList(MyWishVO vo) {
        vo.getDataMap().put("userId", vo.getUserId());
        vo.getDataMap().put("grpSeq", vo.getGrpSeq());
        List<MyWishVO> dataList = list("_myWish.myWishDetailList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_myWish.myWishDetailCount", vo.getDataMap()));;
        return new Pager<MyWishVO>(dataList, vo);
    }

    /**
     * purchsListExcel (엑셀 다운로드)
     * @param vo
     * @return
     */
    public List<MyWishVO> myWishDetailListExcel(MyWishVO vo) {
        return  list("_myWish.myWishExcelList", vo);
    }

    /**
     * myWishDeleteAction (구매희망목록 - 보관목록 서비스 삭제)
     * @param vo
     * @return
     */
    public int myWishDeleteAction(MyWishVO vo) {
        int delCnt = 0;
        delCnt += delete("_myWish.myWishDetailDelete", vo); // 구매희망목록 상세 삭제(서비스)
        delCnt += delete("_myWish.myWishMasterDelete", vo); // 구매희망목록 마스터 삭제
        return delCnt;
    }

    /**
     * myWishStoreGoodsDeleteAction (구매희망목록 - 보관목록 서비스 삭제)
     * @param vo
     * @return
     */
    public int myWishStoreGoodsDeleteAction(MyWishVO vo) {
        int confirmCnt = 0;
        confirmCnt += delete("_myWish.myWishStoreGoodsDelete", vo);
        return confirmCnt;
    }

    /**
     * myWishDeleteAction (구매희망목록 - 보관목록 서비스 확정)
     * @param vo
     * @return
     */
    public int myWishConfirmAction(MyWishVO vo) {
        int confirmCnt = 0;
        confirmCnt += update("_myWish.myWishDetailConfirm", vo);
        return confirmCnt;
    }

    /**
     * updateWishStatusAction (구매희망 사업에 완료 FLAG 처리)
     * @param vo
     * @return
     */
    public int updateWishStatusAction(HashMap map) {
        return update("_myWish.updateWishStatus", map);
    }

    /**
     * myWishOptional 설명
     * @param vo
     * @return
     */
    public int myWishOptional(MyWishVO vo) {
        int confirmCnt = 0;
        confirmCnt = insert("_myWish.myWishOptional", vo);
        return confirmCnt;
    }

    /**
     * @param vo
     * @return
     */
    public int myWishConfirmGoodsDeleteAction(MyWishVO vo) {
        int confirmCnt = 0;
        confirmCnt += delete("_myWish.myWishConfirmGoodsDelete", vo);
        return confirmCnt;
    }

    /**
     * getBeforeEstimate 설명
     * @param vo
     * @return
     */
    public List<MyCeartBeforeNofyVO> beforeEstimate(WishViewVO vo) {
        return list("_myWish.beforeEstimate", vo);
    }

    /**
     * historyGoodsSearch 설명
     * @param vo
     * @return
     */
    public List<HistoryGoodsSearchVO> historyGoodsSearch(WishViewVO vo)
    {
        return list("_myWish.historyGoodsSearch", vo);
    }

    /**
     * myWishSetCntrctChk 설명
     * @param myvo
     * @return
     */
    public int myWishSetCntrctChk(MyWishVO myvo) {
        
        return update("_myWish.myWishSetCntrctChk", myvo);
    }

    /**
     * myWishStore 설명
     * @param vo
     * @return
     */
    public MyWishVO myWishStore(WishViewVO vo)
    {
        return (MyWishVO)selectByPk("_myWish.myWishStore", vo); 
    }
   
}
