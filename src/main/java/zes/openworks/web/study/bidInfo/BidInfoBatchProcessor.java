/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.study.bidInfo;

import java.util.Date;

import zes.core.lang.Validate;
import zes.openworks.common.schedule.Processor;
import zes.openworks.web.study.bidInfo.BidInfoPaging.ItemList;


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
 * 2014. 12. 18.    이슬버미       신규
 *</pre>
 * @see
 */
public class BidInfoBatchProcessor implements Processor{

    @Override
    public void process() {
        
        //입찰정보 메모리 누수를 위해서 어쩔수 없이 넣음
        //내부 시간 정보를 확인해서 1시간 이상 사용을 안하면 삭제해준다.
        if(Validate.isNotEmpty( BidInfoPaging.HM_list)){
            for(String key : BidInfoPaging.HM_list.keySet()) {
                ItemList list =  BidInfoPaging.HM_list.get(key);
                
                if(BidInfoPaging.calculateMins(list.dateTime, new Date()) >= 60){
                    BidInfoPaging.HM_list.remove(key);
                }
            }
        }
        
    }
    
}
