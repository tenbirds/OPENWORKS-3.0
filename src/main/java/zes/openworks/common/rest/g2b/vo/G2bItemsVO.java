/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b.vo;

import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamImplicit;


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
 * 2014. 12. 11.    이슬버미       신규
 *</pre>
 * @see
 */
public class G2bItemsVO {
    
    @XStreamImplicit(itemFieldName="item")
    List<G2bItemVO> item;

    
    /**
     * List<G2bItemVO> item을 반환
     * @return List<G2bItemVO> item
     */
    public List<G2bItemVO> getItem() {
        return item;
    }

    
    /**
     * item을 설정
     * @param item 을(를) List<G2bItemVO> item로 설정
     */
    public void setItem(List<G2bItemVO> item) {
        this.item = item;
    }

        
}
