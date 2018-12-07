/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

import zes.base.vo.PaggingVO;

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
 *  2014. 10. 22.    이슬버미       신규
 * </pre>
 * @see
 */
public class SuplerCeartIaasIVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 수요자아이디 */
    private String endsUserId;

    /** 공급자아이디 */
    private String suplerId;

    /** 수요자 여부 */
    private String consumerYn;

    /** 답변여부 */
    private String applyGbn;

    /** CDN 전송량 */
    private String cdnTransVlmn;

    /** CDN 예상요청수 */
    private String cdnRequCnt;

    /** 웹방화벽 서비스유형 */
    private String webGoodsKind;

    /** 웹방화벽 처리속도 */
    private String webAccess;

    /** 모니터링 VM */
    private String mntingVm;

    /** 모니터링 계정수량 */
    private String mntingIdCnt;

    /** 백업 수량 */
    private String bakupCnt;
    
    /** 백업 저장용량 */
    private String bakupStorg;
    
    /** 관리기능 */
    private String mangFunc;
    
    /** 보안관리 VPN */
    private String sectyVpn;
    
    /** 보안관리 SSLVPN */
    private String sectySslvpn;
    
    /** 기술지원 */
    private String techSupt;
    
    /** 기능요구1 */
    private String funcDmnd1;
    
    /** 기능요구2 */
    private String funcDmnd2;
    
    /** 기능요구3 */
    private String funcDmnd3;
    
    /** 기능요구4 */
    private String funcDmnd4;

    /** 인터페이스 요구 */
    private String interfaceDmnd;
    
    /** 보안요구1 */
    private String sectyDmnd1;
    
    /** 보안요구2 */
    private String sectyDmnd2;
    
    /** 보안요구3 */
    private String sectyDmnd3;
    
    /** 보안요구4 */
    private String sectyDmnd4;
    
    /** 보안요구5 */
    private String sectyDmnd5;

    /** 품질요구1 */
    private String qutyDmnd1;
    
    /** 품질요구2 */
    private String qutyDmnd2;
    
    /** 운영요구1 */
    private String optnDmnd1;
    
    /** 운영요구2 */
    private String optnDmnd2;
    
    /** 프로젝트지원요구1 */
    private String prjtDmnd1;
    
    /** 프로젝트지원요구2 */
    private String prjtDmnd2;
    
    /** 프로젝트지원요구3 */
    private String prjtDmnd3;
    
    /** 기타요구 */
    private String etcDmnd;

    
    /**
     * String notifyNum을 반환
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }

    
    /**
     * notifyNum을 설정
     * @param notifyNum 을(를) String notifyNum로 설정
     */
    public void setNotifyNum(String notifyNum) {
        this.notifyNum = notifyNum;
    }

    
    /**
     * int notifySeq을 반환
     * @return int notifySeq
     */
    public int getNotifySeq() {
        return notifySeq;
    }

    
    /**
     * notifySeq을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
    }

    
    /**
     * String endsUserId을 반환
     * @return String endsUserId
     */
    public String getEndsUserId() {
        return endsUserId;
    }

    
    /**
     * endsUserId을 설정
     * @param endsUserId 을(를) String endsUserId로 설정
     */
    public void setEndsUserId(String endsUserId) {
        this.endsUserId = endsUserId;
    }

    
    /**
     * String suplerId을 반환
     * @return String suplerId
     */
    public String getSuplerId() {
        return suplerId;
    }

    
    /**
     * suplerId을 설정
     * @param suplerId 을(를) String suplerId로 설정
     */
    public void setSuplerId(String suplerId) {
        this.suplerId = suplerId;
    }

    
    /**
     * String consumerYn을 반환
     * @return String consumerYn
     */
    public String getConsumerYn() {
        return consumerYn;
    }

    
    /**
     * consumerYn을 설정
     * @param consumerYn 을(를) String consumerYn로 설정
     */
    public void setConsumerYn(String consumerYn) {
        this.consumerYn = consumerYn;
    }

    
    /**
     * String applyGbn을 반환
     * @return String applyGbn
     */
    public String getApplyGbn() {
        return applyGbn;
    }

    
    /**
     * applyGbn을 설정
     * @param applyGbn 을(를) String applyGbn로 설정
     */
    public void setApplyGbn(String applyGbn) {
        this.applyGbn = applyGbn;
    }

    
    /**
     * String cdnTransVlmn을 반환
     * @return String cdnTransVlmn
     */
    public String getCdnTransVlmn() {
        return cdnTransVlmn;
    }

    
    /**
     * cdnTransVlmn을 설정
     * @param cdnTransVlmn 을(를) String cdnTransVlmn로 설정
     */
    public void setCdnTransVlmn(String cdnTransVlmn) {
        this.cdnTransVlmn = cdnTransVlmn;
    }

    
    /**
     * String cdnRequCnt을 반환
     * @return String cdnRequCnt
     */
    public String getCdnRequCnt() {
        return cdnRequCnt;
    }

    
    /**
     * cdnRequCnt을 설정
     * @param cdnRequCnt 을(를) String cdnRequCnt로 설정
     */
    public void setCdnRequCnt(String cdnRequCnt) {
        this.cdnRequCnt = cdnRequCnt;
    }

    
    /**
     * String webGoodsKind을 반환
     * @return String webGoodsKind
     */
    public String getWebGoodsKind() {
        return webGoodsKind;
    }

    
    /**
     * webGoodsKind을 설정
     * @param webGoodsKind 을(를) String webGoodsKind로 설정
     */
    public void setWebGoodsKind(String webGoodsKind) {
        this.webGoodsKind = webGoodsKind;
    }

    
    /**
     * String webAccess을 반환
     * @return String webAccess
     */
    public String getWebAccess() {
        return webAccess;
    }

    
    /**
     * webAccess을 설정
     * @param webAccess 을(를) String webAccess로 설정
     */
    public void setWebAccess(String webAccess) {
        this.webAccess = webAccess;
    }

    
    /**
     * String mntingVm을 반환
     * @return String mntingVm
     */
    public String getMntingVm() {
        return mntingVm;
    }

    
    /**
     * mntingVm을 설정
     * @param mntingVm 을(를) String mntingVm로 설정
     */
    public void setMntingVm(String mntingVm) {
        this.mntingVm = mntingVm;
    }

    
    /**
     * String mntingIdCnt을 반환
     * @return String mntingIdCnt
     */
    public String getMntingIdCnt() {
        return mntingIdCnt;
    }

    
    /**
     * mntingIdCnt을 설정
     * @param mntingIdCnt 을(를) String mntingIdCnt로 설정
     */
    public void setMntingIdCnt(String mntingIdCnt) {
        this.mntingIdCnt = mntingIdCnt;
    }

    
    /**
     * String bakupCnt을 반환
     * @return String bakupCnt
     */
    public String getBakupCnt() {
        return bakupCnt;
    }

    
    /**
     * bakupCnt을 설정
     * @param bakupCnt 을(를) String bakupCnt로 설정
     */
    public void setBakupCnt(String bakupCnt) {
        this.bakupCnt = bakupCnt;
    }

    
    /**
     * String bakupStorg을 반환
     * @return String bakupStorg
     */
    public String getBakupStorg() {
        return bakupStorg;
    }

    
    /**
     * bakupStorg을 설정
     * @param bakupStorg 을(를) String bakupStorg로 설정
     */
    public void setBakupStorg(String bakupStorg) {
        this.bakupStorg = bakupStorg;
    }

    
    /**
     * String mangFunc을 반환
     * @return String mangFunc
     */
    public String getMangFunc() {
        return mangFunc;
    }

    
    /**
     * mangFunc을 설정
     * @param mangFunc 을(를) String mangFunc로 설정
     */
    public void setMangFunc(String mangFunc) {
        this.mangFunc = mangFunc;
    }

    
    /**
     * String sectyVpn을 반환
     * @return String sectyVpn
     */
    public String getSectyVpn() {
        return sectyVpn;
    }

    
    /**
     * sectyVpn을 설정
     * @param sectyVpn 을(를) String sectyVpn로 설정
     */
    public void setSectyVpn(String sectyVpn) {
        this.sectyVpn = sectyVpn;
    }

    
    /**
     * String sectySslvpn을 반환
     * @return String sectySslvpn
     */
    public String getSectySslvpn() {
        return sectySslvpn;
    }

    
    /**
     * sectySslvpn을 설정
     * @param sectySslvpn 을(를) String sectySslvpn로 설정
     */
    public void setSectySslvpn(String sectySslvpn) {
        this.sectySslvpn = sectySslvpn;
    }

    
    /**
     * String techSupt을 반환
     * @return String techSupt
     */
    public String getTechSupt() {
        return techSupt;
    }

    
    /**
     * techSupt을 설정
     * @param techSupt 을(를) String techSupt로 설정
     */
    public void setTechSupt(String techSupt) {
        this.techSupt = techSupt;
    }

    
    /**
     * String funcDmnd1을 반환
     * @return String funcDmnd1
     */
    public String getFuncDmnd1() {
        return funcDmnd1;
    }

    
    /**
     * funcDmnd1을 설정
     * @param funcDmnd1 을(를) String funcDmnd1로 설정
     */
    public void setFuncDmnd1(String funcDmnd1) {
        this.funcDmnd1 = funcDmnd1;
    }

    
    /**
     * String funcDmnd2을 반환
     * @return String funcDmnd2
     */
    public String getFuncDmnd2() {
        return funcDmnd2;
    }

    
    /**
     * funcDmnd2을 설정
     * @param funcDmnd2 을(를) String funcDmnd2로 설정
     */
    public void setFuncDmnd2(String funcDmnd2) {
        this.funcDmnd2 = funcDmnd2;
    }

    
    /**
     * String funcDmnd3을 반환
     * @return String funcDmnd3
     */
    public String getFuncDmnd3() {
        return funcDmnd3;
    }

    
    /**
     * funcDmnd3을 설정
     * @param funcDmnd3 을(를) String funcDmnd3로 설정
     */
    public void setFuncDmnd3(String funcDmnd3) {
        this.funcDmnd3 = funcDmnd3;
    }

    
    /**
     * String funcDmnd4을 반환
     * @return String funcDmnd4
     */
    public String getFuncDmnd4() {
        return funcDmnd4;
    }

    
    /**
     * funcDmnd4을 설정
     * @param funcDmnd4 을(를) String funcDmnd4로 설정
     */
    public void setFuncDmnd4(String funcDmnd4) {
        this.funcDmnd4 = funcDmnd4;
    }

    
    /**
     * String interfaceDmnd을 반환
     * @return String interfaceDmnd
     */
    public String getInterfaceDmnd() {
        return interfaceDmnd;
    }

    
    /**
     * interfaceDmnd을 설정
     * @param interfaceDmnd 을(를) String interfaceDmnd로 설정
     */
    public void setInterfaceDmnd(String interfaceDmnd) {
        this.interfaceDmnd = interfaceDmnd;
    }

    
    /**
     * String sectyDmnd1을 반환
     * @return String sectyDmnd1
     */
    public String getSectyDmnd1() {
        return sectyDmnd1;
    }

    
    /**
     * sectyDmnd1을 설정
     * @param sectyDmnd1 을(를) String sectyDmnd1로 설정
     */
    public void setSectyDmnd1(String sectyDmnd1) {
        this.sectyDmnd1 = sectyDmnd1;
    }

    
    /**
     * String sectyDmnd2을 반환
     * @return String sectyDmnd2
     */
    public String getSectyDmnd2() {
        return sectyDmnd2;
    }

    
    /**
     * sectyDmnd2을 설정
     * @param sectyDmnd2 을(를) String sectyDmnd2로 설정
     */
    public void setSectyDmnd2(String sectyDmnd2) {
        this.sectyDmnd2 = sectyDmnd2;
    }

    
    /**
     * String sectyDmnd3을 반환
     * @return String sectyDmnd3
     */
    public String getSectyDmnd3() {
        return sectyDmnd3;
    }

    
    /**
     * sectyDmnd3을 설정
     * @param sectyDmnd3 을(를) String sectyDmnd3로 설정
     */
    public void setSectyDmnd3(String sectyDmnd3) {
        this.sectyDmnd3 = sectyDmnd3;
    }

    
    /**
     * String sectyDmnd4을 반환
     * @return String sectyDmnd4
     */
    public String getSectyDmnd4() {
        return sectyDmnd4;
    }

    
    /**
     * sectyDmnd4을 설정
     * @param sectyDmnd4 을(를) String sectyDmnd4로 설정
     */
    public void setSectyDmnd4(String sectyDmnd4) {
        this.sectyDmnd4 = sectyDmnd4;
    }

    
    /**
     * String sectyDmnd5을 반환
     * @return String sectyDmnd5
     */
    public String getSectyDmnd5() {
        return sectyDmnd5;
    }

    
    /**
     * sectyDmnd5을 설정
     * @param sectyDmnd5 을(를) String sectyDmnd5로 설정
     */
    public void setSectyDmnd5(String sectyDmnd5) {
        this.sectyDmnd5 = sectyDmnd5;
    }

    
    /**
     * String qutyDmnd1을 반환
     * @return String qutyDmnd1
     */
    public String getQutyDmnd1() {
        return qutyDmnd1;
    }

    
    /**
     * qutyDmnd1을 설정
     * @param qutyDmnd1 을(를) String qutyDmnd1로 설정
     */
    public void setQutyDmnd1(String qutyDmnd1) {
        this.qutyDmnd1 = qutyDmnd1;
    }

    
    /**
     * String qutyDmnd2을 반환
     * @return String qutyDmnd2
     */
    public String getQutyDmnd2() {
        return qutyDmnd2;
    }

    
    /**
     * qutyDmnd2을 설정
     * @param qutyDmnd2 을(를) String qutyDmnd2로 설정
     */
    public void setQutyDmnd2(String qutyDmnd2) {
        this.qutyDmnd2 = qutyDmnd2;
    }

    
    /**
     * String optnDmnd1을 반환
     * @return String optnDmnd1
     */
    public String getOptnDmnd1() {
        return optnDmnd1;
    }

    
    /**
     * optnDmnd1을 설정
     * @param optnDmnd1 을(를) String optnDmnd1로 설정
     */
    public void setOptnDmnd1(String optnDmnd1) {
        this.optnDmnd1 = optnDmnd1;
    }

    
    /**
     * String optnDmnd2을 반환
     * @return String optnDmnd2
     */
    public String getOptnDmnd2() {
        return optnDmnd2;
    }

    
    /**
     * optnDmnd2을 설정
     * @param optnDmnd2 을(를) String optnDmnd2로 설정
     */
    public void setOptnDmnd2(String optnDmnd2) {
        this.optnDmnd2 = optnDmnd2;
    }

    
    /**
     * String prjtDmnd1을 반환
     * @return String prjtDmnd1
     */
    public String getPrjtDmnd1() {
        return prjtDmnd1;
    }

    
    /**
     * prjtDmnd1을 설정
     * @param prjtDmnd1 을(를) String prjtDmnd1로 설정
     */
    public void setPrjtDmnd1(String prjtDmnd1) {
        this.prjtDmnd1 = prjtDmnd1;
    }

    
    /**
     * String prjtDmnd2을 반환
     * @return String prjtDmnd2
     */
    public String getPrjtDmnd2() {
        return prjtDmnd2;
    }

    
    /**
     * prjtDmnd2을 설정
     * @param prjtDmnd2 을(를) String prjtDmnd2로 설정
     */
    public void setPrjtDmnd2(String prjtDmnd2) {
        this.prjtDmnd2 = prjtDmnd2;
    }

    
    /**
     * String prjtDmnd3을 반환
     * @return String prjtDmnd3
     */
    public String getPrjtDmnd3() {
        return prjtDmnd3;
    }

    
    /**
     * prjtDmnd3을 설정
     * @param prjtDmnd3 을(를) String prjtDmnd3로 설정
     */
    public void setPrjtDmnd3(String prjtDmnd3) {
        this.prjtDmnd3 = prjtDmnd3;
    }

    
    /**
     * String etcDmnd을 반환
     * @return String etcDmnd
     */
    public String getEtcDmnd() {
        return etcDmnd;
    }

    
    /**
     * etcDmnd을 설정
     * @param etcDmnd 을(를) String etcDmnd로 설정
     */
    public void setEtcDmnd(String etcDmnd) {
        this.etcDmnd = etcDmnd;
    }

}
