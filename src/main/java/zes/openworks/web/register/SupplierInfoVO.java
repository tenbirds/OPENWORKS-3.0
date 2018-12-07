/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

import zes.base.vo.PaggingVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 3.    방기배       신규
 *</pre>
 * @see
 */
public class SupplierInfoVO extends PaggingVO{
    
    private static final long serialVersionUID = 3122469237627583722L;
 
    /* 협약차순 */
    private String agremOrder;
    /* 권한 신청일*/
    private String presentnDe;
    /* 승인일 */
    private String cnclsComptDe;
    /* 종료일 */
    private String agremEndDe;
    /* 협약 상태 */
    private String agremNm;
    /* 로그인 아이디*/
    private String userId;
    /* NIA 메시지 */
    private String mangComt;
    /* 기본협약관리순번 */
    private int bassAgremManageSeq;
    
    
    /**
     * int bassAgremManageSeq을 반환
     * @return int bassAgremManageSeq
     */
    public int getBassAgremManageSeq() {
        return bassAgremManageSeq;
    }


    
    /**
     * bassAgremManageSeq을 설정
     * @param bassAgremManageSeq 을(를) int bassAgremManageSeq로 설정
     */
    public void setBassAgremManageSeq(int bassAgremManageSeq) {
        this.bassAgremManageSeq = bassAgremManageSeq;
    }


    /**
     * String mangComt을 반환
     * @return String mangComt
     */
    public String getMangComt() {
        return mangComt;
    }

    
    /**
     * mangComt을 설정
     * @param mangComt 을(를) String mangComt로 설정
     */
    public void setMangComt(String mangComt) {
        this.mangComt = mangComt;
    }

    /**
     * String agremOrder을 반환
     * @return String agremOrder
     */
    public String getAgremOrder() {
        return agremOrder;
    }
    
    /**
     * agremOrder을 설정
     * @param agremOrder 을(를) String agremOrder로 설정
     */
    public void setAgremOrder(String agremOrder) {
        this.agremOrder = agremOrder;
    }
    
    /**
     * String presentnDe을 반환
     * @return String presentnDe
     */
    public String getPresentnDe() {
        return presentnDe;
    }
    
    /**
     * presentnDe을 설정
     * @param presentnDe 을(를) String presentnDe로 설정
     */
    public void setPresentnDe(String presentnDe) {
        this.presentnDe = presentnDe;
    }
    
    /**
     * String cnclsComptDe을 반환
     * @return String cnclsComptDe
     */
    public String getCnclsComptDe() {
        return cnclsComptDe;
    }
    
    /**
     * cnclsComptDe을 설정
     * @param cnclsComptDe 을(를) String cnclsComptDe로 설정
     */
    public void setCnclsComptDe(String cnclsComptDe) {
        this.cnclsComptDe = cnclsComptDe;
    }
    
    /**
     * String agremEndDe을 반환
     * @return String agremEndDe
     */
    public String getAgremEndDe() {
        return agremEndDe;
    }
    
    /**
     * agremEndDe을 설정
     * @param agremEndDe 을(를) String agremEndDe로 설정
     */
    public void setAgremEndDe(String agremEndDe) {
        this.agremEndDe = agremEndDe;
    }
    
    /**
     * String agremNm을 반환
     * @return String agremNm
     */
    public String getAgremNm() {
        return agremNm;
    }
    
    /**
     * agremNm을 설정
     * @param agremNm 을(를) String agremNm로 설정
     */
    public void setAgremNm(String agremNm) {
        this.agremNm = agremNm;
    }
    
    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }
    
    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    
}
