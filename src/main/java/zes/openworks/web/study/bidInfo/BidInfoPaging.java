/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.study.bidInfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import zes.core.lang.Validate;
import zes.openworks.common.rest.g2b.vo.G2bItemVO;


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
 * 2014. 12. 16.    이슬버미       신규
 *</pre>
 * @see
 */
public class BidInfoPaging {
    
    /*
     * HashMap<키값,리스트>
     * List<G2bItemVO,Count,Date>
     * */
    public static HashMap<String, ItemList> HM_list = new HashMap<String, ItemList>();

    public static class ItemList{
        public List<G2bItemVO> list;
        public int totalCount;
        public Date dateTime;
    }
    
    public static long calculateMins(Date dateEarly, Date dateLater) {  
        return (dateLater.getTime() - dateEarly.getTime()) / (60000);  
     } 

    /**
     * setPager 설명
     * @param currPage 페이지 번호
     * @param rowPerPage 한 페이지 결과 수
     * @return
     */    
    public static List<G2bItemVO> setPager(String key, int currPage, int rowPerPage){
        
        List<G2bItemVO> list = new ArrayList<G2bItemVO>();
        if(Validate.isNotEmpty(HM_list.get(key))){
            
            ItemList item = HM_list.get(key);
            
            list = (List<G2bItemVO>) item.list;
            try {
                currPage = rowPerPage * (currPage-1);
                list = list.subList(currPage, Math.min(list.size(), currPage + rowPerPage));
            } catch (Exception e) {
                e.getStackTrace();
            }
        }
        return list;
    }
    
}
