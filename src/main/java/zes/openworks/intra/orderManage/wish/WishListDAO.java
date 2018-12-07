/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.wish;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
public class WishListDAO extends EgovAbstractMapper{

    /**
     * consultList (구매/신청관리 목록)
     * @param vo
     * @return
     */
    public Pager<WishListVO> wishList(WishListVO vo) {
        
        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);
            
            vo.getDataMap().put("q_beginDate",sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
        
        //엑셀적용할떄만ㅍ사용함
        if(!Validate.isEmpty(vo.getUserId()) && !Validate.isEmpty(vo.getGrpSeq())){
            vo.getDataMap().put("q_userId", vo.getUserId());
            vo.getDataMap().put("q_grpSeq", vo.getGrpSeq());
            vo.getDataMap().put("q_beginDate", "");
            vo.getDataMap().put("q_endDate", "");
        }
        
        List<WishListVO> dataList = list("_wishList.wishList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_wishList.wishCount", vo.getDataMap()));;
        
        return new Pager<WishListVO>(dataList, vo);

    }

    /**
     * purchsListExcel (엑셀 다운로드)
     * @param vo
     * @return
     */
    public List<WishListVO> wishListExcel(WishListVO vo) {
        
        vo.getDataMap().put("userId", vo.getUserId());
        vo.getDataMap().put("grpSeq", vo.getGrpSeq());
        return  list("_wishList.wishExcelList", vo.getDataMap());

    }

    /**
     * wishDetailList 설명
     * @param vo
     * @return
     */
    public Pager<WishListVO> wishDetailList(WishListVO vo) {
        
        
        vo.getDataMap().put("userId", vo.getUserId());
        vo.getDataMap().put("grpSeq", vo.getGrpSeq());
        List<WishListVO> dataList = list("_wishList.wishDetailList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_wishList.wishDetailCount", vo.getDataMap()));;
        return new Pager<WishListVO>(dataList, vo);

    }
    
    
}
