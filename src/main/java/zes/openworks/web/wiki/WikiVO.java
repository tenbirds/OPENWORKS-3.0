/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.wiki;

import zes.base.vo.*;

/**
*
* @Class Name : WikiVO
* @version 1.0
* @since OpenMarketPlace 프로젝트. (After JDK 1.6)
* @author 오픈마켓플레이스
* @Description : 씨앗마켓 위키 공통 Service
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일                 수정자                수정내용
*--------------    ----------    -------------------------------
* 2016. 01. 04.    (주)엔키소프트      신규
* @see
*/
public class WikiVO extends PaggingVO {
    /* 위키순번 */
    private String wikiSn;
    /* 위키내용 */
    private String wikiCn;
    /* 위키등록자명 */
    private String registerNm;
    /* 위키등록자ID */
    private String registId;
    /* 위키등록일자 */
    private String registDt;
    /* 위키수정자ID */
    private String updtId;
    /* 위키수정일자 */
    private String updtDt;
    
    /**
     * String wikiSn을 반환
     * @return String wikiSn
     */
    public String getWikiSn() {
        return wikiSn;
    }
    
    /**
     * wikiSn을 설정
     * @param wikiSn 을(를) String wikiSn로 설정
     */
    public void setWikiSn(String wikiSn) {
        this.wikiSn = wikiSn;
    }
    
    /**
     * String wikiCn을 반환
     * @return String wikiCn
     */
    public String getWikiCn() {
        return wikiCn;
    }
    
    /**
     * wikiCn을 설정
     * @param wikiCn 을(를) String wikiCn로 설정
     */
    public void setWikiCn(String wikiCn) {
        this.wikiCn = wikiCn;
    }
    
    /**
     * String registerNm을 반환
     * @return String registerNm
     */
    public String getRegisterNm() {
        return registerNm;
    }
    
    /**
     * registerNm을 설정
     * @param registerNm 을(를) String registerNm로 설정
     */
    public void setRegisterNm(String registerNm) {
        this.registerNm = registerNm;
    }
    
    /**
     * String registId을 반환
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }
    
    /**
     * registId을 설정
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }
    
    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }
    
    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }
    
    /**
     * String updtId을 반환
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }
    
    /**
     * updtId을 설정
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }
    
    /**
     * String updtDt을 반환
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }
    
    /**
     * updtDt을 설정
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

}
