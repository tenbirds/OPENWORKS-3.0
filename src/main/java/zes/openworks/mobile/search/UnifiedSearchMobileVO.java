/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.mobile.search;

import zes.openworks.common.controller.WebController;

/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author 와이즈넛
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 3.    문상석       신규
 *</pre>
 * @see
 */
public class UnifiedSearchMobileVO extends WebController {
    
    // 검색용 필터링 사용
    private String[] sMeta1;   //중소기업
    private String[] sMeta2;   //무료/체험
    private String[] sMeta3;   //계약단위
    private String[] sMeta4;   //인증
    private String[] sMeta5;   //서비스 관리
    private String[] sMeta6;   //호환성(표준)
    private String[] sMeta7;   //구축방식
    private String[] sMeta8;   //지원언어
    private String[] sMeta9;   //CSQC Level
    private String[] sMeta10;   //CSQC Level
    private String[] sMeta11;   //CSQC Level
    private String[] sMeta12;   //CSQC Level
    private String[] sMeta13;  
    
    private String[] iMeta1;   //인력규모 
    private String[] iMeta2;   //AS/방침
    private String[] iMeta3;   //AS/방침
    private String[] iMeta4;   //AS/방침
    
    /**
     * String[] sMeta1을 반환
     * @return String[] sMeta1
     */
    public String[] getsMeta1() {
        return sMeta1;
    }
    
    /**
     * sMeta1을 설정
     * @param sMeta1 을(를) String[] sMeta1로 설정
     */
    public void setsMeta1(String[] sMeta1) {
        this.sMeta1 = sMeta1;
    }
    
    /**
     * String[] sMeta2을 반환
     * @return String[] sMeta2
     */
    public String[] getsMeta2() {
        return sMeta2;
    }
    
    /**
     * sMeta2을 설정
     * @param sMeta2 을(를) String[] sMeta2로 설정
     */
    public void setsMeta2(String[] sMeta2) {
        this.sMeta2 = sMeta2;
    }
    
    /**
     * String[] sMeta3을 반환
     * @return String[] sMeta3
     */
    public String[] getsMeta3() {
        return sMeta3;
    }
    
    /**
     * sMeta3을 설정
     * @param sMeta3 을(를) String[] sMeta3로 설정
     */
    public void setsMeta3(String[] sMeta3) {
        this.sMeta3 = sMeta3;
    }
    
    /**
     * String[] sMeta4을 반환
     * @return String[] sMeta4
     */
    public String[] getsMeta4() {
        return sMeta4;
    }
    
    /**
     * sMeta4을 설정
     * @param sMeta4 을(를) String[] sMeta4로 설정
     */
    public void setsMeta4(String[] sMeta4) {
        this.sMeta4 = sMeta4;
    }
    
    /**
     * String[] sMeta5을 반환
     * @return String[] sMeta5
     */
    public String[] getsMeta5() {
        return sMeta5;
    }
    
    /**
     * sMeta5을 설정
     * @param sMeta5 을(를) String[] sMeta5로 설정
     */
    public void setsMeta5(String[] sMeta5) {
        this.sMeta5 = sMeta5;
    }
    
    /**
     * String[] sMeta6을 반환
     * @return String[] sMeta6
     */
    public String[] getsMeta6() {
        return sMeta6;
    }
    
    /**
     * sMeta6을 설정
     * @param sMeta6 을(를) String[] sMeta6로 설정
     */
    public void setsMeta6(String[] sMeta6) {
        this.sMeta6 = sMeta6;
    }
    
    /**
     * String[] iMeta1을 반환
     * @return String[] iMeta1
     */
    public String[] getiMeta1() {
        return iMeta1;
    }
    
    /**
     * iMeta1을 설정
     * @param iMeta1 을(를) String[] iMeta1로 설정
     */
    public void setiMeta1(String[] iMeta1) {
        this.iMeta1 = iMeta1;
    }
    
    /**
     * String[] iMeta2을 반환
     * @return String[] iMeta2
     */
    public String[] getiMeta2() {
        return iMeta2;
    }
    
    /**
     * iMeta2을 설정
     * @param iMeta2 을(를) String[] iMeta2로 설정
     */
    public void setiMeta2(String[] iMeta2) {
        this.iMeta2 = iMeta2;
    }
    
    /**
     * String[] iMeta3을 반환
     * @return String[] iMeta3
     */
    public String[] getiMeta3() {
        return iMeta3;
    }
    
    /**
     * iMeta3을 설정
     * @param iMeta3 을(를) String[] iMeta3로 설정
     */
    public void setiMeta3(String[] iMeta3) {
        this.iMeta3 = iMeta3;
    }
    
    /**
     * String[] iMeta4을 반환
     * @return String[] iMeta4
     */
    public String[] getiMeta4() {
        return iMeta4;
    }
    
    /**
     * iMeta4을 설정
     * @param iMeta4 을(를) String[] iMeta4로 설정
     */
    public void setiMeta4(String[] iMeta4) {
        this.iMeta4 = iMeta4;
    }

    
    /**
     * String[] sMeta7을 반환
     * @return String[] sMeta7
     */
    public String[] getsMeta7() {
        return sMeta7;
    }

    
    /**
     * sMeta7을 설정
     * @param sMeta7 을(를) String[] sMeta7로 설정
     */
    public void setsMeta7(String[] sMeta7) {
        this.sMeta7 = sMeta7;
    }

    
    /**
     * String[] sMeta8을 반환
     * @return String[] sMeta8
     */
    public String[] getsMeta8() {
        return sMeta8;
    }

    
    /**
     * sMeta8을 설정
     * @param sMeta8 을(를) String[] sMeta8로 설정
     */
    public void setsMeta8(String[] sMeta8) {
        this.sMeta8 = sMeta8;
    }

    
    /**
     * String[] sMeta9을 반환
     * @return String[] sMeta9
     */
    public String[] getsMeta9() {
        return sMeta9;
    }

    
    /**
     * sMeta9을 설정
     * @param sMeta9 을(를) String[] sMeta9로 설정
     */
    public void setsMeta9(String[] sMeta9) {
        this.sMeta9 = sMeta9;
    }

    
    /**
     * String[] sMeta10을 반환
     * @return String[] sMeta10
     */
    public String[] getsMeta10() {
        return sMeta10;
    }

    
    /**
     * sMeta10을 설정
     * @param sMeta10 을(를) String[] sMeta10로 설정
     */
    public void setsMeta10(String[] sMeta10) {
        this.sMeta10 = sMeta10;
    }

    
    /**
     * String[] sMeta11을 반환
     * @return String[] sMeta11
     */
    public String[] getsMeta11() {
        return sMeta11;
    }

    
    /**
     * sMeta11을 설정
     * @param sMeta11 을(를) String[] sMeta11로 설정
     */
    public void setsMeta11(String[] sMeta11) {
        this.sMeta11 = sMeta11;
    }

    
    /**
     * String[] sMeta12을 반환
     * @return String[] sMeta12
     */
    public String[] getsMeta12() {
        return sMeta12;
    }

    
    /**
     * sMeta12을 설정
     * @param sMeta12 을(를) String[] sMeta12로 설정
     */
    public void setsMeta12(String[] sMeta12) {
        this.sMeta12 = sMeta12;
    }

    
    /**
     * String[] sMeta13을 반환
     * @return String[] sMeta13
     */
    public String[] getsMeta13() {
        return sMeta13;
    }

    
    /**
     * sMeta13을 설정
     * @param sMeta13 을(를) String[] sMeta13로 설정
     */
    public void setsMeta13(String[] sMeta13) {
        this.sMeta13 = sMeta13;
    }
    
    
}
