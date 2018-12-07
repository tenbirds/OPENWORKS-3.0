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

import zes.base.pager.Pager;
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
public interface MyWishService {

    /**
     * wishList (구매희망 목록)
     * @param vo
     * @return
     */
    List<MyWishVO> myWishList(MyWishVO vo);

    /**
     * wishList (구매희망 보관 목록)
     * @param vo
     * @return
     */
    Pager<MyWishVO> myWishStoreList(MyWishVO vo);

    /**
     * wishList (구매희망 확정 목록)
     * @param vo
     * @return
     */
    Pager<MyWishVO> myWishConfirmList(MyWishVO vo);

    /**
     * wishList (구매희망 확정 일자)
     * @param vo
     * @return
     */
    String myWishConfrmDt(MyWishVO vo);

    /**
     * wishList (구매희망 기본정보)
     * @param vo
     * @return
     */
    MyWishVO myWishInfo(MyWishVO vo);

    /**
     * wishList (구매희망 상세 목록)
     * @param vo
     * @return
     */
    Pager<MyWishVO> myWishDetailList(MyWishVO vo);

    /**
     * wishListExcel (엑셀 다운로드)
     * @param vo
     * @return
     */
    List<MyWishVO> myWishDetailListExcel(MyWishVO vo);

    /**
     * myWishDeleteAction (구매희망목록 - 보관목록 서비스 삭제)
     * @param vo
     * @return
     */
    int myWishDeleteAction(MyWishVO vo);

    /**
     * myWishStoreGoodsDeleteAction (구매희망목록 - 보관목록 서비스 삭제)
     * @param vo
     * @return
     */
    int myWishStoreGoodsDeleteAction(MyWishVO vo);

    /**
     * myWishConfirmAction (구매희망목록 - 보관목록 서비스 확정)
     * @param vo
     * @return
     */
    int myWishConfirmAction(MyWishVO vo);

    /**
     * updateWishStatusAction (구매희망 사업에 완료 FLAG 처리)
     * @param vo
     * @return
     */
    int updateWishStatusAction(HashMap map);

    /**
     * myWishOptional (구매희망 확정목록 수의계약)
     * @param vo
     * @return
     */
    int myWishOptional(MyWishVO vo);
    
    /**
     * myWishConfirmGoodsDeleteAction (구매확정목록 - 확정목록 서비스 삭제)
     * @param vo
     * @return
     */
    int myWishConfirmGoodsDeleteAction(MyWishVO vo);

    /**
     * beforeEstimate 설명
     * @param wvVO
     */
    List<MyCeartBeforeNofyVO> beforeEstimate(WishViewVO vo);
    
    /**
     * historyGoodsSearch 설명
     * @param wvVO
     */
    List<HistoryGoodsSearchVO> historyGoodsSearch(WishViewVO vo);

    /**
     * myWishSetCntrctChk 설명
     * @param myvo
     */
    int myWishSetCntrctChk(MyWishVO myvo);

    /**
     * myWishStore 설명
     * @param vo
     * @return
     */
    MyWishVO myWishStore(WishViewVO vo);
    
}
