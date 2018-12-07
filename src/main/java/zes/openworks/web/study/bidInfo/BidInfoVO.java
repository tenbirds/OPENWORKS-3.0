/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.study.bidInfo;

import zes.openworks.common.rest.g2b.vo.G2bVO;


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
 * 2014. 12. 12.    이슬버미       신규
 *</pre>
 * @see
 */
public class BidInfoVO extends G2bVO {

    /**  */
    private static final long serialVersionUID = 8066298618131160918L;
    
    /* 공고명 */
    private String pblancNm; 
    
    /* 탭상태 */
    private String flag;
    
    /**
     * String pblancNm을 반환
     * @return String pblancNm
     */
    public String getPblancNm() {
        return pblancNm;
    }


    
    /**
     * pblancNm을 설정
     * @param pblancNm 을(를) String pblancNm로 설정
     */
    public void setPblancNm(String pblancNm) {
        this.pblancNm = pblancNm;
    }


    /**
     * String flag을 반환
     * @return String flag
     */
    public String getFlag() {
        return flag;
    }

    
    /**
     * flag을 설정
     * @param flag 을(를) String flag로 설정
     */
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    
    
}
