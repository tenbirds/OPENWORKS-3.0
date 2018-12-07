/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b.vo;

import com.thoughtworks.xstream.annotations.XStreamAlias;


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


@XStreamAlias("response")
public class G2bResponseVO {

    @XStreamAlias("header")
    private G2bHeaderVO g2bHeaderVO;

    @XStreamAlias("body")
    private G2bBodyVO g2bBodyVO;

    
    /**
     * G2bHeaderVO g2bHeaderVO을 반환
     * @return G2bHeaderVO g2bHeaderVO
     */
    public G2bHeaderVO getG2bHeaderVO() {
        return g2bHeaderVO;
    }

    
    /**
     * g2bHeaderVO을 설정
     * @param g2bHeaderVO 을(를) G2bHeaderVO g2bHeaderVO로 설정
     */
    public void setG2bHeaderVO(G2bHeaderVO g2bHeaderVO) {
        this.g2bHeaderVO = g2bHeaderVO;
    }

    
    /**
     * G2bBodyVO g2bBodyVO을 반환
     * @return G2bBodyVO g2bBodyVO
     */
    public G2bBodyVO getG2bBodyVO() {
        return g2bBodyVO;
    }

    
    /**
     * g2bBodyVO을 설정
     * @param g2bBodyVO 을(를) G2bBodyVO g2bBodyVO로 설정
     */
    public void setG2bBodyVO(G2bBodyVO g2bBodyVO) {
        this.g2bBodyVO = g2bBodyVO;
    }
    
        
    
    
}
