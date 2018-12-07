/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store.premium;

import java.util.List;
import java.util.Map;

import zes.base.vo.FileVO;
import zes.openworks.web.store.StoreincVO;

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
 * 2014. 11. 6.    이슬버미       신규
 *</pre>
 * @see
 */
public class PremiumVO  extends StoreincVO {

    /**  */
    private static final long serialVersionUID = -8226486936502927954L;
    
    private String rankNum;
    
    private String sellCnt;
    
    private String cmmntyId;
    
    private List<Map<String, Object>> goodsScore;
    
    private String revCnt;
    private String evlCnt;
    private String inqrCnt;
    
    private String loginUserId;
    
    private String purchsNo;
    private String mbtlnum;
    private String email;
    private String cmpnyNm;
    private String cmpnyReprsntTelno;
    private String chargerNm; 
    private String chargerCttpc;
    private String chargerEmail;
    private String dlivMssage;
    private String orderCnfirmAt;
    private Integer domainCd;
    private Integer bbsCd;
    private Integer cntrCount;
    
    
    
    
    /**
     * Integer cntrCount을 반환
     * @return Integer cntrCount
     */
    public Integer getCntrCount() {
        return cntrCount;
    }







    
    /**
     * cntrCount을 설정
     * @param cntrCount 을(를) Integer cntrCount로 설정
     */
    public void setCntrCount(Integer cntrCount) {
        this.cntrCount = cntrCount;
    }



    private List<FileVO> storeImageFile; 
    
    private Integer intrstSn;
    
    //{{skyou 2015-12-02  -검색용 필터링 사용
    private String[] selectItem1;   //중소기업
    private String[] selectItem2;   //무료/체험  =>공공기관 이용 필터
    private String[] selectItem3;   //계약단위 =>제공기업 공급 유형
    private String[] selectItem4;   //인증
    private String[] selectItem5;   //서비스 관리 =>서비스기술지원 명칭변경
    private String[] selectItem6;   //호환성(표준)
    private String[] selectItem7;   //구축방식
    private String[] selectItem8;   //지원언어=>개발지원
    private String[] selectItem9;   //CSQC Level=>교육, 기술지원
    private String[] selectItem10;   //관리정보제공
    private String[] selectItem11;   //제공기업 공급 유형
    private String[] selectItem13;   //공공기관 이용 필터 > 클라우드서비스보안인증(CSAP)
    
    private String relationCnt;     //연관서비스 카툰드
    List<Map<String, Object>>  CntrctInfoList;  //계약현황  
    //}}
    
    private String registDt;
    private String ctgryCode; 
    private String langCtgryNm;
    private String cstmrInfo;
    private String comouDe;    
    private String svcPc;    
    private String svcPcUntCd;
    private String smlpzChk;
    
    private int specErr;

    /*20181127 eulro 추가 (필터 검색)*/
    private String apiSportAt;                        // API 지원 여부
    private String atmcEstnSportAt;                   // 자동확장
    private String clusteringSportAt;                 // 클러스터링 지원 여부
    private String cstmrCnterOperAt;                  // 고객센터 운영 여부
    private String dataCnterLcInfo;                   // 데이터센터 국내, 외 위치 정보
    private String entrprsSe;                         // 기업 구분 
    private String hybridCloudAt;                     // Hybrid cloud 구축 여부
    private String privateCloudAt;                    // Private cloud 구축 여부
    private String publicCloudAt;                     // Public cloud 구축 여부
    private String sApiAccessSportAt;                 // 외부 API ACCESS 지원 여부
    private String sDbMigrationSportAt;               // DB 마이그레이션 지원 여부
    private String sGvrnFrmwrkSportAt;                // 정부표준프레임워크 지원 여부
    private String sMultiPltfomSportAt;               // 다중 플랫폼 지원 여부
    private String sOpenSourcSwAt;                    // 오픈소스 SW 호환 여부
    private String sOpenStdSportAt;                   // 개방형 표준 지원 여부
    private String sPaastaAt;                         // PaaS-Ta 호환 여부
    private String sSourcOthbcAt;                     // 소스 공개 여부
    private String sfsrvProvisioningSportAt;          // 셀프서비스 프로비저닝 지원 여부
    private String slaApplcAt;                        // SLA 적용 여부
    private String svcManageSttusInfoSuply;           // 서비스 관리 및 현황 정보 제공 
    private String svcUseLogSuplyAt;                  // 서비스 이용 로그 제공 여부
    private String userEdcSportAt;                    // 사용자 교육 지원 여부
    private String userMnlSuplyAt;                    // 사용자 매뉴얼 제공 여부
    private String visitEdcSportAt;                   // 방문 교육 지원 여부
    private String visitElseTchnlgySportAt;           // 방문 외(온라인, 이메일, 전화 등) 기술 지원 여부
    private String visitTchnlgySportAt;               // 방문 기술 지원 여부
    
    /**
     * String smlpzChk을 반환
     * @return String smlpzChk
     */
    public String getSmlpzChk() {
        return smlpzChk;
    }

    /**
     * smlpzChk을 설정
     * @param smlpzChk 을(를) String smlpzChk로 설정
     */
    public void setSmlpzChk(String smlpzChk) {
        this.smlpzChk = smlpzChk;
    }






    /**
     * String svcPcUntCd을 반환
     * @return String svcPcUntCd
     */
    public String getSvcPcUntCd() {
        return svcPcUntCd;
    }





    
    /**
     * svcPcUntCd을 설정
     * @param svcPcUntCd 을(를) String svcPcUntCd로 설정
     */
    public void setSvcPcUntCd(String svcPcUntCd) {
        this.svcPcUntCd = svcPcUntCd;
    }





    
    /**
     * String dueStdrMumm을 반환
     * @return String dueStdrMumm
     */
    public String getDueStdrMumm() {
        return dueStdrMumm;
    }





    
    /**
     * dueStdrMumm을 설정
     * @param dueStdrMumm 을(를) String dueStdrMumm로 설정
     */
    public void setDueStdrMumm(String dueStdrMumm) {
        this.dueStdrMumm = dueStdrMumm;
    }



    private String dueStdrMumm;    
    
    /**
     * String svcPc을 반환
     * @return String svcPc
     */
    public String getSvcPc() {
        return svcPc;
    }




    
    /**
     * svcPc을 설정
     * @param svcPc 을(를) String svcPc로 설정
     */
    public void setSvcPc(String svcPc) {
        this.svcPc = svcPc;
    }




    /**
     * String comouDe을 반환
     * @return String comouDe
     */
    public String getComouDe() {
        return comouDe;
    }



    
    /**
     * comouDe을 설정
     * @param comouDe 을(를) String comouDe로 설정
     */
    public void setComouDe(String comouDe) {
        this.comouDe = comouDe;
    }



    /**
     * String cstmrInfo을 반환
     * @return String cstmrInfo
     */
    public String getCstmrInfo() {
        return cstmrInfo;
    }


    
    /**
     * cstmrInfo을 설정
     * @param cstmrInfo 을(를) String cstmrInfo로 설정
     */
    public void setCstmrInfo(String cstmrInfo) {
        this.cstmrInfo = cstmrInfo;
    }



    private Integer goodsCount;
    private Integer specMaxNum; //규격서 유무 체크


    /**
     * Integer goodsCount을 반환
     * @return Integer goodsCount
     */
    public Integer getGoodsCount() {
        return goodsCount;
    }

    
    /**
     * goodsCount을 설정
     * @param goodsCount 을(를) Integer goodsCount로 설정
     */
    public void setGoodsCount(Integer goodsCount) {
        this.goodsCount = goodsCount;
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
     * String rankNum을 반환
     * @return String rankNum
     */
    public String getRankNum() {
        return rankNum;
    }

    /**
     * rankNum을 설정
     * @param rankNum 을(를) String rankNum로 설정
     */
    public void setRankNum(String rankNum) {
        this.rankNum = rankNum;
    }

    /**
     * String sellCnt을 반환
     * @return String sellCnt
     */
    public String getSellCnt() {
        return sellCnt;
    }

    /**
     * sellCnt을 설정
     * @param sellCnt 을(를) String sellCnt로 설정
     */
    public void setSellCnt(String sellCnt) {
        this.sellCnt = sellCnt;
    }

    /**
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }

    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }

    /**
     * List<Map<String,Object>> goodsScore을 반환
     * @return List<Map<String,Object>> goodsScore
     */
    public List<Map<String, Object>> getGoodsScore() {
        return goodsScore;
    }

    /**
     * goodsScore을 설정
     * @param goodsScore 을(를) List<Map<String,Object>> goodsScore로 설정
     */
    public void setGoodsScore(List<Map<String, Object>> goodsScore) {
        this.goodsScore = goodsScore;
    }

    /**
     * String loginUserId을 반환
     * @return String loginUserId
     */
    public String getLoginUserId() {
        return loginUserId;
    }

    /**
     * loginUserId을 설정
     * @param loginUserId 을(를) String loginUserId로 설정
     */
    public void setLoginUserId(String loginUserId) {
        this.loginUserId = loginUserId;
    }

    /**
     * String mbtlnum을 반환
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }

    /**
     * mbtlnum을 설정
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    /**
     * String email을 반환
     * @return String email
     */
    public String getEmail() {
        return email;
    }

    /**
     * email을 설정
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * String cmpnyReprsntTelno을 반환
     * @return String cmpnyReprsntTelno
     */
    public String getCmpnyReprsntTelno() {
        return cmpnyReprsntTelno;
    }

    /**
     * cmpnyReprsntTelno을 설정
     * @param cmpnyReprsntTelno 을(를) String cmpnyReprsntTelno로 설정
     */
    public void setCmpnyReprsntTelno(String cmpnyReprsntTelno) {
        this.cmpnyReprsntTelno = cmpnyReprsntTelno;
    }

    /**
     * String chargerNm을 반환
     * @return String chargerNm
     */
    public String getChargerNm() {
        return chargerNm;
    }

    /**
     * chargerNm을 설정
     * @param chargerNm 을(를) String chargerNm로 설정
     */
    public void setChargerNm(String chargerNm) {
        this.chargerNm = chargerNm;
    }

    /**
     * String chargerCttpc을 반환
     * @return String chargerCttpc
     */
    public String getChargerCttpc() {
        return chargerCttpc;
    }

    /**
     * chargerCttpc을 설정
     * @param chargerCttpc 을(를) String chargerCttpc로 설정
     */
    public void setChargerCttpc(String chargerCttpc) {
        this.chargerCttpc = chargerCttpc;
    }

    /**
     * String chargerEmail을 반환
     * @return String chargerEmail
     */
    public String getChargerEmail() {
        return chargerEmail;
    }

    /**
     * chargerEmail을 설정
     * @param chargerEmail 을(를) String chargerEmail로 설정
     */
    public void setChargerEmail(String chargerEmail) {
        this.chargerEmail = chargerEmail;
    }

    /**
     * String dlivMssage을 반환
     * @return String dlivMssage
     */
    public String getDlivMssage() {
        return dlivMssage;
    }

    /**
     * dlivMssage을 설정
     * @param dlivMssage 을(를) String dlivMssage로 설정
     */
    public void setDlivMssage(String dlivMssage) {
        this.dlivMssage = dlivMssage;
    }

    /**
     * String orderCnfirmAt을 반환
     * @return String orderCnfirmAt
     */
    public String getOrderCnfirmAt() {
        return orderCnfirmAt;
    }

    /**
     * orderCnfirmAt을 설정
     * @param orderCnfirmAt 을(를) String orderCnfirmAt로 설정
     */
    public void setOrderCnfirmAt(String orderCnfirmAt) {
        this.orderCnfirmAt = orderCnfirmAt;
    }

    /**
     * String purchsNo을 반환
     * @return String purchsNo
     */
    public String getPurchsNo() {
        return purchsNo;
    }

    /**
     * purchsNo을 설정
     * @param purchsNo 을(를) String purchsNo로 설정
     */
    public void setPurchsNo(String purchsNo) {
        this.purchsNo = purchsNo;
    }

    /**
     * String inqrCnt을 반환
     * @return String inqrCnt
     */
    public String getInqrCnt() {
        return inqrCnt;
    }

    /**
     * inqrCnt을 설정
     * @param inqrCnt 을(를) String inqrCnt로 설정
     */
    public void setInqrCnt(String inqrCnt) {
        this.inqrCnt = inqrCnt;
    }

    /**
     * String evlCnt을 반환
     * @return String evlCnt
     */
    public String getEvlCnt() {
        return evlCnt;
    }

    /**
     * evlCnt을 설정
     * @param evlCnt 을(를) String evlCnt로 설정
     */
    public void setEvlCnt(String evlCnt) {
        this.evlCnt = evlCnt;
    }

    /**
     * Integer domainCd을 반환
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * domainCd을 설정
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * Integer bbsCd을 반환
     * @return Integer bbsCd
     */
    public Integer getBbsCd() {
        return bbsCd;
    }

    /**
     * bbsCd을 설정
     * @param bbsCd 을(를) Integer bbsCd로 설정
     */
    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    /**
     * String revCnt을 반환
     * @return String revCnt
     */
    public String getRevCnt() {
        return revCnt;
    }

    /**
     * revCnt을 설정
     * @param revCnt 을(를) String revCnt로 설정
     */
    public void setRevCnt(String revCnt) {
        this.revCnt = revCnt;
    }

    /**
     * List<FileVO> storeImageFile을 반환
     * @return List<FileVO> storeImageFile
     */
    public List<FileVO> getStoreImageFile() {
        return storeImageFile;
    }

    /**
     * storeImageFile을 설정
     * @param storeImageFile 을(를) List<FileVO> storeImageFile로 설정
     */
    public void setStoreImageFile(List<FileVO> storeImageFile) {
        this.storeImageFile = storeImageFile;
    }

    /**
     * String cmpnyNm을 반환
     * @return String cmpnyNm
     */
    public String getCmpnyNm() {
        return cmpnyNm;
    }

    /**
     * cmpnyNm을 설정
     * @param cmpnyNm 을(를) String cmpnyNm로 설정
     */
    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    /**
     * Integer intrstSn을 반환
     * @return Integer intrstSn
     */
    public Integer getIntrstSn() {
        return intrstSn;
    }

    /**
     * intrstSn을 설정
     * @param intrstSn 을(를) Integer intrstSn로 설정
     */
    public void setIntrstSn(Integer intrstSn) {
        this.intrstSn = intrstSn;
    }

  
    /**
     * String[] selectItem2을 반환
     * @return String[] selectItem2
     */
    public String[] getSelectItem2() {
        return selectItem2;
    }

    
    
    /**
     * String[] selectItem1을 반환
     * @return String[] selectItem1
     */
    public String[] getSelectItem1() {
        return selectItem1;
    }

    
    /**
     * selectItem1을 설정
     * @param selectItem1 을(를) String[] selectItem1로 설정
     */
    public void setSelectItem1(String[] selectItem1) {
        this.selectItem1 = selectItem1;
    }

    /**
     * selectItem2을 설정
     * @param selectItem2 을(를) String[] selectItem2로 설정
     */
    public void setSelectItem2(String[] selectItem2) {
        this.selectItem2 = selectItem2;
    }

    
    /**
     * String[] selectItem3을 반환
     * @return String[] selectItem3
     */
    public String[] getSelectItem3() {
        return selectItem3;
    }

    
    /**
     * selectItem3을 설정
     * @param selectItem3 을(를) String[] selectItem3로 설정
     */
    public void setSelectItem3(String[] selectItem3) {
        this.selectItem3 = selectItem3;
    }

    
    /**
     * String[] selectItem4을 반환
     * @return String[] selectItem4
     */
    public String[] getSelectItem4() {
        return selectItem4;
    }

    
    /**
     * selectItem4을 설정
     * @param selectItem4 을(를) String[] selectItem4로 설정
     */
    public void setSelectItem4(String[] selectItem4) {
        this.selectItem4 = selectItem4;
    }

    
    /**
     * String[] selectItem5을 반환
     * @return String[] selectItem5
     */
    public String[] getSelectItem5() {
        return selectItem5;
    }

    
    /**
     * selectItem5을 설정
     * @param selectItem5 을(를) String[] selectItem5로 설정
     */
    public void setSelectItem5(String[] selectItem5) {
        this.selectItem5 = selectItem5;
    }

    
    /**
     * String[] selectItem6을 반환
     * @return String[] selectItem6
     */
    public String[] getSelectItem6() {
        return selectItem6;
    }

    
    /**
     * selectItem6을 설정
     * @param selectItem6 을(를) String[] selectItem6로 설정
     */
    public void setSelectItem6(String[] selectItem6) {
        this.selectItem6 = selectItem6;
    }

    
    /**
     * List<Map<String,Object>> cntrctInfoList을 반환
     * @return List<Map<String,Object>> cntrctInfoList
     */
    public List<Map<String, Object>> getCntrctInfoList() {
        return CntrctInfoList;
    }

    
    /**
     * cntrctInfoList을 설정
     * @param cntrctInfoList 을(를) List<Map<String,Object>> cntrctInfoList로 설정
     */
    public void setCntrctInfoList(List<Map<String, Object>> cntrctInfoList) {
        CntrctInfoList = cntrctInfoList;
    }

    
    /**
     * String[] selectItem7을 반환
     * @return String[] selectItem7
     */
    public String[] getSelectItem7() {
        return selectItem7;
    }

    
    /**
     * selectItem7을 설정
     * @param selectItem7 을(를) String[] selectItem7로 설정
     */
    public void setSelectItem7(String[] selectItem7) {
        this.selectItem7 = selectItem7;
    }

    
    /**
     * String[] selectItem8을 반환
     * @return String[] selectItem8
     */
    public String[] getSelectItem8() {
        return selectItem8;
    }

    
    /**
     * selectItem8을 설정
     * @param selectItem8 을(를) String[] selectItem8로 설정
     */
    public void setSelectItem8(String[] selectItem8) {
        this.selectItem8 = selectItem8;
    }
    
    
    /**
     * String[] selectItem9을 반환
     * @return String[] selectItem9
     */
    public String[] getSelectItem9() {
        return selectItem9;
    }

    
    /**
     * selectItem9을 설정
     * @param selectItem9 을(를) String[] selectItem9로 설정
     */
    public void setSelectItem9(String[] selectItem9) {
        this.selectItem9 = selectItem9;
    }

    
    /**
     * String relationCnt을 반환
     * @return String relationCnt
     */
    public String getRelationCnt() {
        return relationCnt;
    }

    
    /**
     * relationCnt을 설정
     * @param relationCnt 을(를) String relationCnt로 설정
     */
    public void setRelationCnt(String relationCnt) {
        this.relationCnt = relationCnt;
    }

    
    /**
     * String[] selectItem10을 반환
     * @return String[] selectItem10
     */
    public String[] getSelectItem10() {
        return selectItem10;
    }

    
    /**
     * selectItem10을 설정
     * @param selectItem10 을(를) String[] selectItem10로 설정
     */
    public void setSelectItem10(String[] selectItem10) {
        this.selectItem10 = selectItem10;
    }

    
    /**
     * String[] selectItem11을 반환
     * @return String[] selectItem11
     */
    public String[] getSelectItem11() {
        return selectItem11;
    }

    
    /**
     * selectItem11을 설정
     * @param selectItem11 을(를) String[] selectItem11로 설정
     */
    public void setSelectItem11(String[] selectItem11) {
        this.selectItem11 = selectItem11;
    }

    
    /**
     * String ctgryCode을 반환
     * @return String ctgryCode
     */
    public String getCtgryCode() {
        return ctgryCode;
    }

    
    /**
     * ctgryCode을 설정
     * @param ctgryCode 을(를) String ctgryCode로 설정
     */
    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }

    
    /**
     * String langCtgryNm을 반환
     * @return String langCtgryNm
     */
    public String getLangCtgryNm() {
        return langCtgryNm;
    }

    
    /**
     * langCtgryNm을 설정
     * @param langCtgryNm 을(를) String langCtgryNm로 설정
     */
    public void setLangCtgryNm(String langCtgryNm) {
        this.langCtgryNm = langCtgryNm;
    }


    /**
     * selectItem13을 설정
     * @param selectItem13 을(를) String[] selectItem13로 설정
     */
    public void setSelectItem13(String[] selectItem13) {
        this.selectItem13 = selectItem13;
    }
    /**
     * getSelectItem13 설명
     * @return
     */
    public String[] getSelectItem13() {
        return selectItem13;
    }


    
    /**
     * Integer specMaxNum을 반환
     * @return Integer specMaxNum
     */
    public Integer getSpecMaxNum() {
        return specMaxNum;
    }


    
    /**
     * specMaxNum을 설정
     * @param specMaxNum 을(를) Integer specMaxNum로 설정
     */
    public void setSpecMaxNum(Integer specMaxNum) {
        this.specMaxNum = specMaxNum;
    }







    /**
     * int specErr을 반환
     * @return int specErr
     */
    public int getSpecErr() {
        return specErr;
    }







    /**
     * specErr을 설정
     * @param specErr 을(를) int specErr로 설정
     */
    public void setSpecErr(int specErr) {
        this.specErr = specErr;
    }








    
    /**
     * String apiSportAt을 반환
     * @return String apiSportAt
     */
    public String getApiSportAt() {
        return apiSportAt;
    }








    
    /**
     * apiSportAt을 설정
     * @param apiSportAt 을(를) String apiSportAt로 설정
     */
    public void setApiSportAt(String apiSportAt) {
        this.apiSportAt = apiSportAt;
    }








    
    /**
     * String atmcEstnSportAt을 반환
     * @return String atmcEstnSportAt
     */
    public String getAtmcEstnSportAt() {
        return atmcEstnSportAt;
    }








    
    /**
     * atmcEstnSportAt을 설정
     * @param atmcEstnSportAt 을(를) String atmcEstnSportAt로 설정
     */
    public void setAtmcEstnSportAt(String atmcEstnSportAt) {
        this.atmcEstnSportAt = atmcEstnSportAt;
    }








    
    /**
     * String clusteringSportAt을 반환
     * @return String clusteringSportAt
     */
    public String getClusteringSportAt() {
        return clusteringSportAt;
    }








    
    /**
     * clusteringSportAt을 설정
     * @param clusteringSportAt 을(를) String clusteringSportAt로 설정
     */
    public void setClusteringSportAt(String clusteringSportAt) {
        this.clusteringSportAt = clusteringSportAt;
    }








    
    /**
     * String cstmrCnterOperAt을 반환
     * @return String cstmrCnterOperAt
     */
    public String getCstmrCnterOperAt() {
        return cstmrCnterOperAt;
    }








    
    /**
     * cstmrCnterOperAt을 설정
     * @param cstmrCnterOperAt 을(를) String cstmrCnterOperAt로 설정
     */
    public void setCstmrCnterOperAt(String cstmrCnterOperAt) {
        this.cstmrCnterOperAt = cstmrCnterOperAt;
    }








    
    /**
     * String dataCnterLcInfo을 반환
     * @return String dataCnterLcInfo
     */
    public String getDataCnterLcInfo() {
        return dataCnterLcInfo;
    }








    
    /**
     * dataCnterLcInfo을 설정
     * @param dataCnterLcInfo 을(를) String dataCnterLcInfo로 설정
     */
    public void setDataCnterLcInfo(String dataCnterLcInfo) {
        this.dataCnterLcInfo = dataCnterLcInfo;
    }








    
    /**
     * String entrprsSe을 반환
     * @return String entrprsSe
     */
    public String getEntrprsSe() {
        return entrprsSe;
    }








    
    /**
     * entrprsSe을 설정
     * @param entrprsSe 을(를) String entrprsSe로 설정
     */
    public void setEntrprsSe(String entrprsSe) {
        this.entrprsSe = entrprsSe;
    }








    
    /**
     * String hybridCloudAt을 반환
     * @return String hybridCloudAt
     */
    public String getHybridCloudAt() {
        return hybridCloudAt;
    }








    
    /**
     * hybridCloudAt을 설정
     * @param hybridCloudAt 을(를) String hybridCloudAt로 설정
     */
    public void setHybridCloudAt(String hybridCloudAt) {
        this.hybridCloudAt = hybridCloudAt;
    }








    
    /**
     * String privateCloudAt을 반환
     * @return String privateCloudAt
     */
    public String getPrivateCloudAt() {
        return privateCloudAt;
    }








    
    /**
     * privateCloudAt을 설정
     * @param privateCloudAt 을(를) String privateCloudAt로 설정
     */
    public void setPrivateCloudAt(String privateCloudAt) {
        this.privateCloudAt = privateCloudAt;
    }








    
    /**
     * String publicCloudAt을 반환
     * @return String publicCloudAt
     */
    public String getPublicCloudAt() {
        return publicCloudAt;
    }








    
    /**
     * publicCloudAt을 설정
     * @param publicCloudAt 을(를) String publicCloudAt로 설정
     */
    public void setPublicCloudAt(String publicCloudAt) {
        this.publicCloudAt = publicCloudAt;
    }








    
    /**
     * String sApiAccessSportAt을 반환
     * @return String sApiAccessSportAt
     */
    public String getsApiAccessSportAt() {
        return sApiAccessSportAt;
    }








    
    /**
     * sApiAccessSportAt을 설정
     * @param sApiAccessSportAt 을(를) String sApiAccessSportAt로 설정
     */
    public void setsApiAccessSportAt(String sApiAccessSportAt) {
        this.sApiAccessSportAt = sApiAccessSportAt;
    }








    
    /**
     * String sDbMigrationSportAt을 반환
     * @return String sDbMigrationSportAt
     */
    public String getsDbMigrationSportAt() {
        return sDbMigrationSportAt;
    }








    
    /**
     * sDbMigrationSportAt을 설정
     * @param sDbMigrationSportAt 을(를) String sDbMigrationSportAt로 설정
     */
    public void setsDbMigrationSportAt(String sDbMigrationSportAt) {
        this.sDbMigrationSportAt = sDbMigrationSportAt;
    }








    
    /**
     * String sGvrnFrmwrkSportAt을 반환
     * @return String sGvrnFrmwrkSportAt
     */
    public String getsGvrnFrmwrkSportAt() {
        return sGvrnFrmwrkSportAt;
    }








    
    /**
     * sGvrnFrmwrkSportAt을 설정
     * @param sGvrnFrmwrkSportAt 을(를) String sGvrnFrmwrkSportAt로 설정
     */
    public void setsGvrnFrmwrkSportAt(String sGvrnFrmwrkSportAt) {
        this.sGvrnFrmwrkSportAt = sGvrnFrmwrkSportAt;
    }








    
    /**
     * String sMultiPltfomSportAt을 반환
     * @return String sMultiPltfomSportAt
     */
    public String getsMultiPltfomSportAt() {
        return sMultiPltfomSportAt;
    }








    
    /**
     * sMultiPltfomSportAt을 설정
     * @param sMultiPltfomSportAt 을(를) String sMultiPltfomSportAt로 설정
     */
    public void setsMultiPltfomSportAt(String sMultiPltfomSportAt) {
        this.sMultiPltfomSportAt = sMultiPltfomSportAt;
    }








    
    /**
     * String sOpenSourcSwAt을 반환
     * @return String sOpenSourcSwAt
     */
    public String getsOpenSourcSwAt() {
        return sOpenSourcSwAt;
    }








    
    /**
     * sOpenSourcSwAt을 설정
     * @param sOpenSourcSwAt 을(를) String sOpenSourcSwAt로 설정
     */
    public void setsOpenSourcSwAt(String sOpenSourcSwAt) {
        this.sOpenSourcSwAt = sOpenSourcSwAt;
    }








    
    /**
     * String sOpenStdSportAt을 반환
     * @return String sOpenStdSportAt
     */
    public String getsOpenStdSportAt() {
        return sOpenStdSportAt;
    }








    
    /**
     * sOpenStdSportAt을 설정
     * @param sOpenStdSportAt 을(를) String sOpenStdSportAt로 설정
     */
    public void setsOpenStdSportAt(String sOpenStdSportAt) {
        this.sOpenStdSportAt = sOpenStdSportAt;
    }








    
    /**
     * String sPaastaAt을 반환
     * @return String sPaastaAt
     */
    public String getsPaastaAt() {
        return sPaastaAt;
    }








    
    /**
     * sPaastaAt을 설정
     * @param sPaastaAt 을(를) String sPaastaAt로 설정
     */
    public void setsPaastaAt(String sPaastaAt) {
        this.sPaastaAt = sPaastaAt;
    }








    
    /**
     * String sSourcOthbcAt을 반환
     * @return String sSourcOthbcAt
     */
    public String getsSourcOthbcAt() {
        return sSourcOthbcAt;
    }








    
    /**
     * sSourcOthbcAt을 설정
     * @param sSourcOthbcAt 을(를) String sSourcOthbcAt로 설정
     */
    public void setsSourcOthbcAt(String sSourcOthbcAt) {
        this.sSourcOthbcAt = sSourcOthbcAt;
    }








    
    /**
     * String sfsrvProvisioningSportAt을 반환
     * @return String sfsrvProvisioningSportAt
     */
    public String getSfsrvProvisioningSportAt() {
        return sfsrvProvisioningSportAt;
    }








    
    /**
     * sfsrvProvisioningSportAt을 설정
     * @param sfsrvProvisioningSportAt 을(를) String sfsrvProvisioningSportAt로 설정
     */
    public void setSfsrvProvisioningSportAt(String sfsrvProvisioningSportAt) {
        this.sfsrvProvisioningSportAt = sfsrvProvisioningSportAt;
    }








    
    /**
     * String slaApplcAt을 반환
     * @return String slaApplcAt
     */
    public String getSlaApplcAt() {
        return slaApplcAt;
    }








    
    /**
     * slaApplcAt을 설정
     * @param slaApplcAt 을(를) String slaApplcAt로 설정
     */
    public void setSlaApplcAt(String slaApplcAt) {
        this.slaApplcAt = slaApplcAt;
    }








    
    /**
     * String svcManageSttusInfoSuply을 반환
     * @return String svcManageSttusInfoSuply
     */
    public String getSvcManageSttusInfoSuply() {
        return svcManageSttusInfoSuply;
    }








    
    /**
     * svcManageSttusInfoSuply을 설정
     * @param svcManageSttusInfoSuply 을(를) String svcManageSttusInfoSuply로 설정
     */
    public void setSvcManageSttusInfoSuply(String svcManageSttusInfoSuply) {
        this.svcManageSttusInfoSuply = svcManageSttusInfoSuply;
    }








    
    /**
     * String svcUseLogSuplyAt을 반환
     * @return String svcUseLogSuplyAt
     */
    public String getSvcUseLogSuplyAt() {
        return svcUseLogSuplyAt;
    }








    
    /**
     * svcUseLogSuplyAt을 설정
     * @param svcUseLogSuplyAt 을(를) String svcUseLogSuplyAt로 설정
     */
    public void setSvcUseLogSuplyAt(String svcUseLogSuplyAt) {
        this.svcUseLogSuplyAt = svcUseLogSuplyAt;
    }








    
    /**
     * String userEdcSportAt을 반환
     * @return String userEdcSportAt
     */
    public String getUserEdcSportAt() {
        return userEdcSportAt;
    }








    
    /**
     * userEdcSportAt을 설정
     * @param userEdcSportAt 을(를) String userEdcSportAt로 설정
     */
    public void setUserEdcSportAt(String userEdcSportAt) {
        this.userEdcSportAt = userEdcSportAt;
    }








    
    /**
     * String userMnlSuplyAt을 반환
     * @return String userMnlSuplyAt
     */
    public String getUserMnlSuplyAt() {
        return userMnlSuplyAt;
    }








    
    /**
     * userMnlSuplyAt을 설정
     * @param userMnlSuplyAt 을(를) String userMnlSuplyAt로 설정
     */
    public void setUserMnlSuplyAt(String userMnlSuplyAt) {
        this.userMnlSuplyAt = userMnlSuplyAt;
    }








    
    /**
     * String visitEdcSportAt을 반환
     * @return String visitEdcSportAt
     */
    public String getVisitEdcSportAt() {
        return visitEdcSportAt;
    }








    
    /**
     * visitEdcSportAt을 설정
     * @param visitEdcSportAt 을(를) String visitEdcSportAt로 설정
     */
    public void setVisitEdcSportAt(String visitEdcSportAt) {
        this.visitEdcSportAt = visitEdcSportAt;
    }








    
    /**
     * String visitElseTchnlgySportAt을 반환
     * @return String visitElseTchnlgySportAt
     */
    public String getVisitElseTchnlgySportAt() {
        return visitElseTchnlgySportAt;
    }








    
    /**
     * visitElseTchnlgySportAt을 설정
     * @param visitElseTchnlgySportAt 을(를) String visitElseTchnlgySportAt로 설정
     */
    public void setVisitElseTchnlgySportAt(String visitElseTchnlgySportAt) {
        this.visitElseTchnlgySportAt = visitElseTchnlgySportAt;
    }








    
    /**
     * String visitTchnlgySportAt을 반환
     * @return String visitTchnlgySportAt
     */
    public String getVisitTchnlgySportAt() {
        return visitTchnlgySportAt;
    }








    
    /**
     * visitTchnlgySportAt을 설정
     * @param visitTchnlgySportAt 을(를) String visitTchnlgySportAt로 설정
     */
    public void setVisitTchnlgySportAt(String visitTchnlgySportAt) {
        this.visitTchnlgySportAt = visitTchnlgySportAt;
    }


}
