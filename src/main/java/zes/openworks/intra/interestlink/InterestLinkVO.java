/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.interestlink;

import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;

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
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class InterestLinkVO extends PaggingVO {

    private static final long serialVersionUID = 5191395027553292087L;

    /** 일련번호 */
    private Integer seq;
    /** 회원 고유번호 */
    private String virKey;
    /** 담당자아이디 */
    private String mngrId = null;
    /** 회원 고유번호 */
    private String userKey = null;
    /** 분 류 */
    private String category = "미분류";
    /** 관심 내용 */
    @Required(message = "관심 내용은 필수 입력입니다.")
    @RangeLength(min = 2, max = 30)
    private String interestDesc;
    /** 링크 */
    @Required(message = "링크는 필수 입력입니다.")
    @RangeLength(min = 5, max = 200)
    private String link;
    /** 등록일 */
    private String regDt;

    /**
     * Integer seq을 반환
     * 
     * @return Integer seq
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * String virKey을 반환
     * 
     * @return String virKey
     */
    public String getVirKey() {
        return virKey;
    }

    /**
     * String mgrId을 반환
     * 
     * @return String mgrId
     */
    public String getMngrId() {
        return mngrId;
    }

    /**
     * String userKey을 반환
     * 
     * @return String userKey
     */
    public String getUserKey() {
        return userKey;
    }

    /**
     * String category을 반환
     * 
     * @return String category
     */
    public String getCategory() {
        return category;
    }

    /**
     * String interestDesc을 반환
     * 
     * @return String interestDesc
     */
    public String getInterestDesc() {
        return interestDesc;
    }

    /**
     * String link을 반환
     * 
     * @return String link
     */
    public String getLink() {
        return link;
    }

    /**
     * String regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * seq을 설정
     * 
     * @param seq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * virKey을 설정
     * 
     * @param virKey 을(를) String virKey로 설정
     */
    public void setVirKey(String virKey) {
        this.virKey = virKey;
    }

    /**
     * mgrId을 설정
     * 
     * @param mgrId 을(를) String mgrId로 설정
     */
    public void setMngrId(String mgrId) {
        this.mngrId = mgrId;
    }

    /**
     * userKey을 설정
     * 
     * @param userKey 을(를) String userKey로 설정
     */
    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    /**
     * category을 설정
     * 
     * @param category 을(를) String category로 설정
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * interestDesc을 설정
     * 
     * @param interestDesc 을(를) String interestDesc로 설정
     */
    public void setInterestDesc(String interestDesc) {
        this.interestDesc = interestDesc;
    }

    /**
     * link을 설정
     * 
     * @param link 을(를) String link로 설정
     */
    public void setLink(String link) {
        this.link = link;
    }

    /**
     * regDt을 설정
     * 
     * @param regDt 을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

}
