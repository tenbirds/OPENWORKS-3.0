/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.orderManage;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
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
 *  2014. 11. 14.    이슬버미       신규
 * </pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class OrderManageDAO extends EgovAbstractMapper {

    private Object langCodes = null;
    
    /**
     * orderList (구매/신청 목록)
     * 
     * @param vo
     * @return
     */
    public Pager<OrderManageVO> orderList(OrderManageVO vo) {
        
        getDataMap(vo);
        
        vo.setTotalNum((Integer) selectByPk("_ordermanage.orderCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<OrderManageVO> dataList = list("_ordermanage.orderList", vo.getDataMap());
        
        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        
        return new Pager<OrderManageVO>(dataList, vo);
    }

    /**
     * cnslList (컨설팅 목록)
     * 
     * @param vo
     * @return
     */
    public Pager<OrderManageVO> cnslList(OrderManageVO vo) {
        
        getDataMap(vo);
        
        //컨설팅신청
        vo.getDataMap().put("q_goodsTyCd", OrderManageVO.OM_MT_CD_CT);
        
        List<OrderManageVO> dataList = list("_ordermanage.orderList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_ordermanage.orderCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        
        return new Pager<OrderManageVO>(dataList, vo);
    }

    /**
     * langList (서비스 언어 목록)
     * 
     * @param vo
     * @return
     */
    public List<OrderManageVO> langList(OrderManageVO vo) {
        return list("_ordermanage.langList", vo);
    }

    /**
     * ctgryList (카테고리 항목)
     * 
     * @param vo
     * @return
     */    
    public List<OrderManageVO> ctgryList(OrderManageVO vo) {
        return list("_ordermanage.ctgryList", vo);
    }

    /**
     * getDataMap (기본 파라메터 입력)
     * 
     * @param vo
     */
    private void getDataMap(OrderManageVO vo) {
        
        Object langCodes = vo.getDataMap().get("q_langCodes");
        
        if(Validate.isNotEmpty(langCodes)) {
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }

        // 날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate", sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
        
        if(Validate.isNotEmpty(vo.getRegistId())){
            vo.getDataMap().put("q_registId", vo.getRegistId());
        }
        
        
        this.langCodes = langCodes;

    }

}
