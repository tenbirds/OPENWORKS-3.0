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

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
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
@Service("MyWishService")
public class MyWishServiceImpl extends AbstractServiceImpl implements MyWishService {

    @Resource MyWishDAO dao;

    /* (구매희망 목록)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishList(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public List<MyWishVO> myWishList(MyWishVO vo) {
        return dao.myWishList(vo);
    }

    /* (구매희망 보관 목록)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishStoreList(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public Pager<MyWishVO> myWishStoreList(MyWishVO vo) {
        return dao.myWishStoreList(vo);
    }

    /* (구매희망 확정 목록)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishConfirmList(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public Pager<MyWishVO> myWishConfirmList(MyWishVO vo) {
        return dao.myWishConfirmList(vo);
    }

    /* (구매희망 확정 일자)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishConfrmDt(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public String myWishConfrmDt(MyWishVO vo) {
        return dao.myWishConfrmDt(vo);
    }

    /* (구매희망 데이터 기본정보)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishInfo(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public MyWishVO myWishInfo(MyWishVO vo) {
        return dao.myWishInfo(vo);
    }

    /* (구매희망 상세 목록)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishDetailList(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public Pager<MyWishVO> myWishDetailList(MyWishVO vo) {
        return dao.myWishDetailList(vo);
    }


    /* (엑셀다운로드)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishDetailListExcel(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public  List<MyWishVO> myWishDetailListExcel(MyWishVO vo){
        return dao.myWishDetailListExcel(vo);
    }

    /* (구매희망목록 - 보관목록 서비스 삭제)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishDeleteAction(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public int myWishDeleteAction(MyWishVO vo){
        return dao.myWishDeleteAction(vo);
    }

    /* (구매희망목록 - 보관목록 서비스 삭제)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishStoreGoodsDeleteAction(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public int myWishStoreGoodsDeleteAction(MyWishVO vo){
        return dao.myWishStoreGoodsDeleteAction(vo);
    }

    /* (구매희망목록 - 보관목록 서비스 확정)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishConfirmAction(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public int myWishConfirmAction(MyWishVO vo){
        return dao.myWishConfirmAction(vo);
    }

    /* (구매희망 사업에 완료 FLAG 처리)
     * @see zes.openworks.web.wish.myWish.MyWishService#updateWishStatusAction(HashMap)
     */
    @Override
    public int updateWishStatusAction(HashMap map){
        return dao.updateWishStatusAction(map);
    }

    /* (구매희망 확정목록 수의계약)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishOptional(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public int myWishOptional(MyWishVO vo) {
        return dao.myWishOptional(vo);
    }
    
    /* (구매확정목록 - 확정목록 서비스 삭제)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishConfirmGoodsDeleteAction(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public int myWishConfirmGoodsDeleteAction(MyWishVO vo){
        return dao.myWishConfirmGoodsDeleteAction(vo);
    }

    /* (팝업 - 사전견적서 보기화면을 위한 견적서)
     * @see zes.openworks.web.wish.myWish.MyWishService#getBeforeEstimate(zes.openworks.web.pop.WishViewVO)
     */
    @Override
    public List<MyCeartBeforeNofyVO> beforeEstimate(WishViewVO vo) {
        return dao.beforeEstimate(vo);        
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.web.wish.myWish.MyWishService#historyGoodsSearch(zes.openworks.web.wish.myWish.WishViewVO)
     */
    @Override
    public List<HistoryGoodsSearchVO> historyGoodsSearch(WishViewVO vo)
    {
        return dao.historyGoodsSearch(vo);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishSetCntrctChk(zes.openworks.web.wish.myWish.MyWishVO)
     */
    @Override
    public int myWishSetCntrctChk(MyWishVO myvo) {
        // TODO Auto-generated method stub
        return dao.myWishSetCntrctChk(myvo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.wish.myWish.MyWishService#myWishStore(zes.openworks.web.wish.myWish.WishViewVO)
     */
    @Override
    public MyWishVO myWishStore(WishViewVO vo)
    {
        return dao.myWishStore(vo);
    }
    
}
