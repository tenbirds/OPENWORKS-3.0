/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.purchs;

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
public class PurchsOrderDAO extends EgovAbstractMapper{

    /**
     * consultList (구매/신청관리 목록)
     * @param vo
     * @return
     */
    public Pager<PurchsOrderVO> purchsList(PurchsOrderVO vo) {
        
        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }
        
        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);
            
            vo.getDataMap().put("q_beginDate",sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
        
        List<PurchsOrderVO> dataList = list("_purchsOrder.purchsList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_purchsOrder.purchsCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        
        return new Pager<PurchsOrderVO>(dataList, vo);

    }
 
    /**
     * langList (서비스 언어 목록)
     * @param vo
     * @return
     */    
    
    public List<PurchsOrderVO> langList(PurchsOrderVO vo){
        return list("_purchsOrder.langList", vo);
    }
    
    /**
     * ctgryList (카테고리 항목)
     * @param vo
     * @return
     */    
    public List<PurchsOrderVO> ctgryList(PurchsOrderVO vo){
        return list("_purchsOrder.ctgryList", vo);
    } 
    
    /**
     * purchsListExcel (엑셀 다운로드)
     * @param vo
     * @return
     */
    public List<PurchsOrderVO> purchsListExcel(PurchsOrderVO vo) {
        
        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)){
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }
        
        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);
            
            vo.getDataMap().put("q_beginDate",sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
        
        //전체 페이지 출력
        vo.getDataMap().put("pagingStartNum", 0);
        vo.getDataMap().put("pagingEndNum", (Integer) selectByPk("_purchsOrder.purchsCount", vo.getDataMap()));
        
        return  list("_purchsOrder.purchsList", vo.getDataMap());

    }
    
    
}
