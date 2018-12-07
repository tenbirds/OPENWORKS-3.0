/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

import java.util.List;

import zes.base.vo.FileVO;
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
 *  2018. 03.      이홍석       신규
 * </pre>
 * @see
 */
public class SuplerCeartIaas2IVO extends PaggingVO 
{

    private static final long serialVersionUID = 1L;

    private String notifyNum;         /** 공고번호 */
    private int notifySeq;            /** 공고순번 */
    private String endsUserId;        /** 수요자아이디 */
    private String suplerId;          /** 공급자아이디 */
    private String consumerYn;        /** 수요자 여부 */
    private String applyGbn;          /** 답변여부 */    
    
    private String chkDb;            /** 체크 DB */
    private String chkStorage;       /** 체크 스토리지 */
    private String chkCdn;           /** 체크 CDN */
    private String chkWebFirewall;   /** 체크 웹방화벽 */
    private String chkMonitoring;    /** 체크 모니터링 */
    private String chkBackup;        /** 체크 백업 */
    private String chkAddedService;  /** 체크 부가서비스 */
    
    /* 서버 부가정보 */
    private String serverIp;             /** 서버 IP */    
    private String serverNetwork;        /** 서버 네트웍트래픽 */    
    private String serverGslb;           /** 서버 GSLB */    
    private String serverLdbl;           /** 서버 로드밸런스 */    
    private String serverSnap;           /** 서버 스냅샷 */    
    private String serverImg;            /** 서버 이미지 */
    
    /* DB 부가정보 */
    private String dbIp;                 /** DB IP */
    private String dbNetwork;            /** DB 네트웍트래픽 */
    private String dbAddDisk;            /** DB 추가디스크 */
    private String dbBackStorg;          /** DB 백업스토리지 */
    
    private String dbStorgSpace;         /** DB 저장공간 */
    private String dbTransVlmn;          /** DB 전송량 */    
    private String cdnTransVlmn;         /** CDN 전송량 */   
    private String cdnRequCnt;           /** CDN 예상요청수 */   
    private String webGoodsKind;         /** 웹방화벽 상품유형 */   
    private String webGoodsKindNm;       /** 웹방화벽 상품유형 */
    private String webAccess;            /** 웹방화벽 처리속도 */   
    private String mntingVm;             /** 모니터링 VM */   
    private String mntingIdCnt;          /** 모니터링 계정수량 */   
    private String bakupCnt;             /** 백업 수량 */      
    private String bakupStorg;           /** 백업 저장용량 */    
    private String mangFunc;             /** 관리기능 */      
    private String sectyVpn;             /** 보안관리 VPN */    
    private String sectySslvpn;          /** 보안관리 SSLVPN */   
    private String addedEtc;             /** 기타요구 */
    
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
     * String chkDb을 반환
     * @return String chkDb
     */
    public String getChkDb() {
        return chkDb;
    }


    
    /**
     * chkDb을 설정
     * @param chkDb 을(를) String chkDb로 설정
     */
    public void setChkDb(String chkDb) {
        this.chkDb = chkDb;
    }


    
    /**
     * String chkStorage을 반환
     * @return String chkStorage
     */
    public String getChkStorage() {
        return chkStorage;
    }


    
    /**
     * chkStorage을 설정
     * @param chkStorage 을(를) String chkStorage로 설정
     */
    public void setChkStorage(String chkStorage) {
        this.chkStorage = chkStorage;
    }


    
    /**
     * String chkCdn을 반환
     * @return String chkCdn
     */
    public String getChkCdn() {
        return chkCdn;
    }


    
    /**
     * chkCdn을 설정
     * @param chkCdn 을(를) String chkCdn로 설정
     */
    public void setChkCdn(String chkCdn) {
        this.chkCdn = chkCdn;
    }


    
    /**
     * String chkWebFirewall을 반환
     * @return String chkWebFirewall
     */
    public String getChkWebFirewall() {
        return chkWebFirewall;
    }


    
    /**
     * chkWebFirewall을 설정
     * @param chkWebFirewall 을(를) String chkWebFirewall로 설정
     */
    public void setChkWebFirewall(String chkWebFirewall) {
        this.chkWebFirewall = chkWebFirewall;
    }


    
    /**
     * String chkMonitoring을 반환
     * @return String chkMonitoring
     */
    public String getChkMonitoring() {
        return chkMonitoring;
    }


    
    /**
     * chkMonitoring을 설정
     * @param chkMonitoring 을(를) String chkMonitoring로 설정
     */
    public void setChkMonitoring(String chkMonitoring) {
        this.chkMonitoring = chkMonitoring;
    }


    
    /**
     * String chkBackup을 반환
     * @return String chkBackup
     */
    public String getChkBackup() {
        return chkBackup;
    }


    
    /**
     * chkBackup을 설정
     * @param chkBackup 을(를) String chkBackup로 설정
     */
    public void setChkBackup(String chkBackup) {
        this.chkBackup = chkBackup;
    }


    
    /**
     * String chkAddedService을 반환
     * @return String chkAddedService
     */
    public String getChkAddedService() {
        return chkAddedService;
    }


    
    /**
     * chkAddedService을 설정
     * @param chkAddedService 을(를) String chkAddedService로 설정
     */
    public void setChkAddedService(String chkAddedService) {
        this.chkAddedService = chkAddedService;
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
     * String webGoodsKindNm을 반환
     * @return String webGoodsKindNm
     */
    public String getWebGoodsKindNm() {
        return webGoodsKindNm;
    }


    /**
     * webGoodsKindNm을 설정
     * @param webGoodsKindNm 을(를) String webGoodsKindNm로 설정
     */
    public void setWebGoodsKindNm(String webGoodsKindNm) {
        this.webGoodsKindNm = webGoodsKindNm;
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
     * String serverIp을 반환
     * @return String serverIp
     */
    public String getServerIp() {
        return serverIp;
    }


    
    /**
     * serverIp을 설정
     * @param serverIp 을(를) String serverIp로 설정
     */
    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }


    
    /**
     * String serverNetwork을 반환
     * @return String serverNetwork
     */
    public String getServerNetwork() {
        return serverNetwork;
    }


    
    /**
     * serverNetwork을 설정
     * @param serverNetwork 을(를) String serverNetwork로 설정
     */
    public void setServerNetwork(String serverNetwork) {
        this.serverNetwork = serverNetwork;
    }


    
    /**
     * String serverGslb을 반환
     * @return String serverGslb
     */
    public String getServerGslb() {
        return serverGslb;
    }


    
    /**
     * serverGslb을 설정
     * @param serverGslb 을(를) String serverGslb로 설정
     */
    public void setServerGslb(String serverGslb) {
        this.serverGslb = serverGslb;
    }


    
    /**
     * String serverLdbl을 반환
     * @return String serverLdbl
     */
    public String getServerLdbl() {
        return serverLdbl;
    }


    
    /**
     * serverLdbl을 설정
     * @param serverLdbl 을(를) String serverLdbl로 설정
     */
    public void setServerLdbl(String serverLdbl) {
        this.serverLdbl = serverLdbl;
    }


    
    /**
     * String serverSnap을 반환
     * @return String serverSnap
     */
    public String getServerSnap() {
        return serverSnap;
    }


    
    /**
     * serverSnap을 설정
     * @param serverSnap 을(를) String serverSnap로 설정
     */
    public void setServerSnap(String serverSnap) {
        this.serverSnap = serverSnap;
    }


    
    /**
     * String serverImg을 반환
     * @return String serverImg
     */
    public String getServerImg() {
        return serverImg;
    }


    
    /**
     * serverImg을 설정
     * @param serverImg 을(를) String serverImg로 설정
     */
    public void setServerImg(String serverImg) {
        this.serverImg = serverImg;
    }


    
    /**
     * String dbIp을 반환
     * @return String dbIp
     */
    public String getDbIp() {
        return dbIp;
    }


    
    /**
     * dbIp을 설정
     * @param dbIp 을(를) String dbIp로 설정
     */
    public void setDbIp(String dbIp) {
        this.dbIp = dbIp;
    }


    
    /**
     * String dbNetwork을 반환
     * @return String dbNetwork
     */
    public String getDbNetwork() {
        return dbNetwork;
    }


    
    /**
     * dbNetwork을 설정
     * @param dbNetwork 을(를) String dbNetwork로 설정
     */
    public void setDbNetwork(String dbNetwork) {
        this.dbNetwork = dbNetwork;
    }


    
    /**
     * String dbAddDisk을 반환
     * @return String dbAddDisk
     */
    public String getDbAddDisk() {
        return dbAddDisk;
    }


    
    /**
     * dbAddDisk을 설정
     * @param dbAddDisk 을(를) String dbAddDisk로 설정
     */
    public void setDbAddDisk(String dbAddDisk) {
        this.dbAddDisk = dbAddDisk;
    }


    
    /**
     * String dbBackStorg을 반환
     * @return String dbBackStorg
     */
    public String getDbBackStorg() {
        return dbBackStorg;
    }


    
    /**
     * dbBackStorg을 설정
     * @param dbBackStorg 을(를) String dbBackStorg로 설정
     */
    public void setDbBackStorg(String dbBackStorg) {
        this.dbBackStorg = dbBackStorg;
    }


    
    /**
     * String dbStorgSpace을 반환
     * @return String dbStorgSpace
     */
    public String getDbStorgSpace() {
        return dbStorgSpace;
    }


    
    /**
     * dbStorgSpace을 설정
     * @param dbStorgSpace 을(를) String dbStorgSpace로 설정
     */
    public void setDbStorgSpace(String dbStorgSpace) {
        this.dbStorgSpace = dbStorgSpace;
    }


    
    /**
     * String dbTransVlmn을 반환
     * @return String dbTransVlmn
     */
    public String getDbTransVlmn() {
        return dbTransVlmn;
    }


    
    /**
     * dbTransVlmn을 설정
     * @param dbTransVlmn 을(를) String dbTransVlmn로 설정
     */
    public void setDbTransVlmn(String dbTransVlmn) {
        this.dbTransVlmn = dbTransVlmn;
    }


    
    /**
     * String addedEtc을 반환
     * @return String addedEtc
     */
    public String getAddedEtc() {
        return addedEtc;
    }


    
    /**
     * addedEtc을 설정
     * @param addedEtc 을(를) String addedEtc로 설정
     */
    public void setAddedEtc(String addedEtc) {
        this.addedEtc = addedEtc;
    }

    
}
