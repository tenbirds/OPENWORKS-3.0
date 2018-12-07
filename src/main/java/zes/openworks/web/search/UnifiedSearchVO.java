/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.search;

import zes.openworks.web.store.StoreincVO;

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
public class UnifiedSearchVO extends StoreincVO{
    /**  */
    private static final long serialVersionUID = 1L;
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
    
    private String[] selectItem1;   //기업구분
    private String[] selectItem2;   //공공기관 이용 필터
    private String[] selectItem3;   //제공기업 공급 유형
    private String[] selectItem4;   //클라우드 인증정보
    private String[] selectItem5;   //서비스기술지원
    private String[] selectItem6;   //호환성 지원
    private String[] selectItem7;   //클라우드 구축방식
    private String[] selectItem8;   //개발지원
    private String[] selectItem9;   //교육/기술지원
    private String[] selectItem13;   //SaaS. PaaS, IaaS, SCS
    private String[] selectItem10;  //관리정보제공
    private String[] selectItem11;  //고객지원
    
    
    
    private String[] META1;   //중소기업
    private String[] META2;   //무료/체험
    private String[] META3;   //계약단위
    private String[] META4;   //인증
    private String[] META5;   //서비스 관리
    private String[] META6;   //호환성(표준)
    private String[] META7;   //구축방식
    private String[] META8;   //지원언어
    private String[] META9;   //CSQC Level
    private String[] META10;   //CSQC Level
    private String[] META11;   //CSQC Level
    private String[] META12;   //CSQC Level
    private String[] META13;  
    
    
    private String CSTMR_CNTER_OPER_AT;
    private String API_SPORT_AT;
    private String SVC_MANAGE_STTUS_INFO_SUPLY;
    private String SVC_USE_LOG_SUPLY_AT;
    private String USER_EDC_SPORT_AT;
    private String VISIT_EDC_SPORT_AT;
    private String USER_MNL_SUPLY_AT;
    private String VISIT_TCHNLGY_SPORT_AT;
    private String VISIT_ELSE_TCHNLGY_SPORT_AT;
    private String S_SOURC_OTHBC_AT;
    private String S_API_ACCESS_SPORT_AT;
    private String HYBRID_CLOUD_AT;
    private String PRIVATE_CLOUD_AT;
    private String PUBLIC_CLOUD_AT;
    private String S_MULTI_PLTFOM_SPORT_AT;
    private String S_OPEN_STD_SPORT_AT;
    private String S_GVRN_FRMWRK_SPORT_AT;
    private String S_OPEN_SOURC_SW_AT;
    private String S_PAASTA_AT;
    private String CLUSTERING_SPORT_AT;
    private String ATMC_ESTN_SPORT_AT;
    private String SLA_APPLC_AT;
    private String SFSRV_PROVISIONING_SPORT_AT;
    private String S_DB_MIGRATION_SPORT_AT;
    
    
    
    
    
    /**
     * String cSTMR_CNTER_OPER_AT을 반환
     * @return String cSTMR_CNTER_OPER_AT
     */
    public String getCSTMR_CNTER_OPER_AT() {
        return CSTMR_CNTER_OPER_AT;
    }



    
    /**
     * cSTMR_CNTER_OPER_AT을 설정
     * @param cSTMR_CNTER_OPER_AT 을(를) String cSTMR_CNTER_OPER_AT로 설정
     */
    public void setCSTMR_CNTER_OPER_AT(String cSTMR_CNTER_OPER_AT) {
        CSTMR_CNTER_OPER_AT = cSTMR_CNTER_OPER_AT;
    }



    
    /**
     * String aPI_SPORT_AT을 반환
     * @return String aPI_SPORT_AT
     */
    public String getAPI_SPORT_AT() {
        return API_SPORT_AT;
    }



    
    /**
     * aPI_SPORT_AT을 설정
     * @param aPI_SPORT_AT 을(를) String aPI_SPORT_AT로 설정
     */
    public void setAPI_SPORT_AT(String aPI_SPORT_AT) {
        API_SPORT_AT = aPI_SPORT_AT;
    }



    
    /**
     * String sVC_MANAGE_STTUS_INFO_SUPLY을 반환
     * @return String sVC_MANAGE_STTUS_INFO_SUPLY
     */
    public String getSVC_MANAGE_STTUS_INFO_SUPLY() {
        return SVC_MANAGE_STTUS_INFO_SUPLY;
    }



    
    /**
     * sVC_MANAGE_STTUS_INFO_SUPLY을 설정
     * @param sVC_MANAGE_STTUS_INFO_SUPLY 을(를) String sVC_MANAGE_STTUS_INFO_SUPLY로 설정
     */
    public void setSVC_MANAGE_STTUS_INFO_SUPLY(String sVC_MANAGE_STTUS_INFO_SUPLY) {
        SVC_MANAGE_STTUS_INFO_SUPLY = sVC_MANAGE_STTUS_INFO_SUPLY;
    }



    
    /**
     * String sVC_USE_LOG_SUPLY_AT을 반환
     * @return String sVC_USE_LOG_SUPLY_AT
     */
    public String getSVC_USE_LOG_SUPLY_AT() {
        return SVC_USE_LOG_SUPLY_AT;
    }



    
    /**
     * sVC_USE_LOG_SUPLY_AT을 설정
     * @param sVC_USE_LOG_SUPLY_AT 을(를) String sVC_USE_LOG_SUPLY_AT로 설정
     */
    public void setSVC_USE_LOG_SUPLY_AT(String sVC_USE_LOG_SUPLY_AT) {
        SVC_USE_LOG_SUPLY_AT = sVC_USE_LOG_SUPLY_AT;
    }



    
    /**
     * String uSER_EDC_SPORT_AT을 반환
     * @return String uSER_EDC_SPORT_AT
     */
    public String getUSER_EDC_SPORT_AT() {
        return USER_EDC_SPORT_AT;
    }



    
    /**
     * uSER_EDC_SPORT_AT을 설정
     * @param uSER_EDC_SPORT_AT 을(를) String uSER_EDC_SPORT_AT로 설정
     */
    public void setUSER_EDC_SPORT_AT(String uSER_EDC_SPORT_AT) {
        USER_EDC_SPORT_AT = uSER_EDC_SPORT_AT;
    }



    
    /**
     * String vISIT_EDC_SPORT_AT을 반환
     * @return String vISIT_EDC_SPORT_AT
     */
    public String getVISIT_EDC_SPORT_AT() {
        return VISIT_EDC_SPORT_AT;
    }



    
    /**
     * vISIT_EDC_SPORT_AT을 설정
     * @param vISIT_EDC_SPORT_AT 을(를) String vISIT_EDC_SPORT_AT로 설정
     */
    public void setVISIT_EDC_SPORT_AT(String vISIT_EDC_SPORT_AT) {
        VISIT_EDC_SPORT_AT = vISIT_EDC_SPORT_AT;
    }



    
    /**
     * String uSER_MNL_SUPLY_AT을 반환
     * @return String uSER_MNL_SUPLY_AT
     */
    public String getUSER_MNL_SUPLY_AT() {
        return USER_MNL_SUPLY_AT;
    }



    
    /**
     * uSER_MNL_SUPLY_AT을 설정
     * @param uSER_MNL_SUPLY_AT 을(를) String uSER_MNL_SUPLY_AT로 설정
     */
    public void setUSER_MNL_SUPLY_AT(String uSER_MNL_SUPLY_AT) {
        USER_MNL_SUPLY_AT = uSER_MNL_SUPLY_AT;
    }



    
    /**
     * String vISIT_TCHNLGY_SPORT_AT을 반환
     * @return String vISIT_TCHNLGY_SPORT_AT
     */
    public String getVISIT_TCHNLGY_SPORT_AT() {
        return VISIT_TCHNLGY_SPORT_AT;
    }



    
    /**
     * vISIT_TCHNLGY_SPORT_AT을 설정
     * @param vISIT_TCHNLGY_SPORT_AT 을(를) String vISIT_TCHNLGY_SPORT_AT로 설정
     */
    public void setVISIT_TCHNLGY_SPORT_AT(String vISIT_TCHNLGY_SPORT_AT) {
        VISIT_TCHNLGY_SPORT_AT = vISIT_TCHNLGY_SPORT_AT;
    }



    
    /**
     * String vISIT_ELSE_TCHNLGY_SPORT_AT을 반환
     * @return String vISIT_ELSE_TCHNLGY_SPORT_AT
     */
    public String getVISIT_ELSE_TCHNLGY_SPORT_AT() {
        return VISIT_ELSE_TCHNLGY_SPORT_AT;
    }



    
    /**
     * vISIT_ELSE_TCHNLGY_SPORT_AT을 설정
     * @param vISIT_ELSE_TCHNLGY_SPORT_AT 을(를) String vISIT_ELSE_TCHNLGY_SPORT_AT로 설정
     */
    public void setVISIT_ELSE_TCHNLGY_SPORT_AT(String vISIT_ELSE_TCHNLGY_SPORT_AT) {
        VISIT_ELSE_TCHNLGY_SPORT_AT = vISIT_ELSE_TCHNLGY_SPORT_AT;
    }



    
    /**
     * String s_SOURC_OTHBC_AT을 반환
     * @return String s_SOURC_OTHBC_AT
     */
    public String getS_SOURC_OTHBC_AT() {
        return S_SOURC_OTHBC_AT;
    }



    
    /**
     * s_SOURC_OTHBC_AT을 설정
     * @param s_SOURC_OTHBC_AT 을(를) String s_SOURC_OTHBC_AT로 설정
     */
    public void setS_SOURC_OTHBC_AT(String s_SOURC_OTHBC_AT) {
        S_SOURC_OTHBC_AT = s_SOURC_OTHBC_AT;
    }



    
    /**
     * String s_API_ACCESS_SPORT_AT을 반환
     * @return String s_API_ACCESS_SPORT_AT
     */
    public String getS_API_ACCESS_SPORT_AT() {
        return S_API_ACCESS_SPORT_AT;
    }



    
    /**
     * s_API_ACCESS_SPORT_AT을 설정
     * @param s_API_ACCESS_SPORT_AT 을(를) String s_API_ACCESS_SPORT_AT로 설정
     */
    public void setS_API_ACCESS_SPORT_AT(String s_API_ACCESS_SPORT_AT) {
        S_API_ACCESS_SPORT_AT = s_API_ACCESS_SPORT_AT;
    }



    
    /**
     * String hYBRID_CLOUD_AT을 반환
     * @return String hYBRID_CLOUD_AT
     */
    public String getHYBRID_CLOUD_AT() {
        return HYBRID_CLOUD_AT;
    }



    
    /**
     * hYBRID_CLOUD_AT을 설정
     * @param hYBRID_CLOUD_AT 을(를) String hYBRID_CLOUD_AT로 설정
     */
    public void setHYBRID_CLOUD_AT(String hYBRID_CLOUD_AT) {
        HYBRID_CLOUD_AT = hYBRID_CLOUD_AT;
    }



    
    /**
     * String pRIVATE_CLOUD_AT을 반환
     * @return String pRIVATE_CLOUD_AT
     */
    public String getPRIVATE_CLOUD_AT() {
        return PRIVATE_CLOUD_AT;
    }



    
    /**
     * pRIVATE_CLOUD_AT을 설정
     * @param pRIVATE_CLOUD_AT 을(를) String pRIVATE_CLOUD_AT로 설정
     */
    public void setPRIVATE_CLOUD_AT(String pRIVATE_CLOUD_AT) {
        PRIVATE_CLOUD_AT = pRIVATE_CLOUD_AT;
    }



    
    /**
     * String pUBLIC_CLOUD_AT을 반환
     * @return String pUBLIC_CLOUD_AT
     */
    public String getPUBLIC_CLOUD_AT() {
        return PUBLIC_CLOUD_AT;
    }



    
    /**
     * pUBLIC_CLOUD_AT을 설정
     * @param pUBLIC_CLOUD_AT 을(를) String pUBLIC_CLOUD_AT로 설정
     */
    public void setPUBLIC_CLOUD_AT(String pUBLIC_CLOUD_AT) {
        PUBLIC_CLOUD_AT = pUBLIC_CLOUD_AT;
    }



    
    /**
     * String s_MULTI_PLTFOM_SPORT_AT을 반환
     * @return String s_MULTI_PLTFOM_SPORT_AT
     */
    public String getS_MULTI_PLTFOM_SPORT_AT() {
        return S_MULTI_PLTFOM_SPORT_AT;
    }



    
    /**
     * s_MULTI_PLTFOM_SPORT_AT을 설정
     * @param s_MULTI_PLTFOM_SPORT_AT 을(를) String s_MULTI_PLTFOM_SPORT_AT로 설정
     */
    public void setS_MULTI_PLTFOM_SPORT_AT(String s_MULTI_PLTFOM_SPORT_AT) {
        S_MULTI_PLTFOM_SPORT_AT = s_MULTI_PLTFOM_SPORT_AT;
    }



    
    /**
     * String s_OPEN_STD_SPORT_AT을 반환
     * @return String s_OPEN_STD_SPORT_AT
     */
    public String getS_OPEN_STD_SPORT_AT() {
        return S_OPEN_STD_SPORT_AT;
    }



    
    /**
     * s_OPEN_STD_SPORT_AT을 설정
     * @param s_OPEN_STD_SPORT_AT 을(를) String s_OPEN_STD_SPORT_AT로 설정
     */
    public void setS_OPEN_STD_SPORT_AT(String s_OPEN_STD_SPORT_AT) {
        S_OPEN_STD_SPORT_AT = s_OPEN_STD_SPORT_AT;
    }



    
    /**
     * String s_GVRN_FRMWRK_SPORT_AT을 반환
     * @return String s_GVRN_FRMWRK_SPORT_AT
     */
    public String getS_GVRN_FRMWRK_SPORT_AT() {
        return S_GVRN_FRMWRK_SPORT_AT;
    }



    
    /**
     * s_GVRN_FRMWRK_SPORT_AT을 설정
     * @param s_GVRN_FRMWRK_SPORT_AT 을(를) String s_GVRN_FRMWRK_SPORT_AT로 설정
     */
    public void setS_GVRN_FRMWRK_SPORT_AT(String s_GVRN_FRMWRK_SPORT_AT) {
        S_GVRN_FRMWRK_SPORT_AT = s_GVRN_FRMWRK_SPORT_AT;
    }



    
    /**
     * String s_OPEN_SOURC_SW_AT을 반환
     * @return String s_OPEN_SOURC_SW_AT
     */
    public String getS_OPEN_SOURC_SW_AT() {
        return S_OPEN_SOURC_SW_AT;
    }



    
    /**
     * s_OPEN_SOURC_SW_AT을 설정
     * @param s_OPEN_SOURC_SW_AT 을(를) String s_OPEN_SOURC_SW_AT로 설정
     */
    public void setS_OPEN_SOURC_SW_AT(String s_OPEN_SOURC_SW_AT) {
        S_OPEN_SOURC_SW_AT = s_OPEN_SOURC_SW_AT;
    }



    
    /**
     * String s_PAASTA_AT을 반환
     * @return String s_PAASTA_AT
     */
    public String getS_PAASTA_AT() {
        return S_PAASTA_AT;
    }



    
    /**
     * s_PAASTA_AT을 설정
     * @param s_PAASTA_AT 을(를) String s_PAASTA_AT로 설정
     */
    public void setS_PAASTA_AT(String s_PAASTA_AT) {
        S_PAASTA_AT = s_PAASTA_AT;
    }



    
    /**
     * String cLUSTERING_SPORT_AT을 반환
     * @return String cLUSTERING_SPORT_AT
     */
    public String getCLUSTERING_SPORT_AT() {
        return CLUSTERING_SPORT_AT;
    }



    
    /**
     * cLUSTERING_SPORT_AT을 설정
     * @param cLUSTERING_SPORT_AT 을(를) String cLUSTERING_SPORT_AT로 설정
     */
    public void setCLUSTERING_SPORT_AT(String cLUSTERING_SPORT_AT) {
        CLUSTERING_SPORT_AT = cLUSTERING_SPORT_AT;
    }



    
    /**
     * String aTMC_ESTN_SPORT_AT을 반환
     * @return String aTMC_ESTN_SPORT_AT
     */
    public String getATMC_ESTN_SPORT_AT() {
        return ATMC_ESTN_SPORT_AT;
    }



    
    /**
     * aTMC_ESTN_SPORT_AT을 설정
     * @param aTMC_ESTN_SPORT_AT 을(를) String aTMC_ESTN_SPORT_AT로 설정
     */
    public void setATMC_ESTN_SPORT_AT(String aTMC_ESTN_SPORT_AT) {
        ATMC_ESTN_SPORT_AT = aTMC_ESTN_SPORT_AT;
    }



    
    /**
     * String sLA_APPLC_AT을 반환
     * @return String sLA_APPLC_AT
     */
    public String getSLA_APPLC_AT() {
        return SLA_APPLC_AT;
    }



    
    /**
     * sLA_APPLC_AT을 설정
     * @param sLA_APPLC_AT 을(를) String sLA_APPLC_AT로 설정
     */
    public void setSLA_APPLC_AT(String sLA_APPLC_AT) {
        SLA_APPLC_AT = sLA_APPLC_AT;
    }



    
    /**
     * String sFSRV_PROVISIONING_SPORT_AT을 반환
     * @return String sFSRV_PROVISIONING_SPORT_AT
     */
    public String getSFSRV_PROVISIONING_SPORT_AT() {
        return SFSRV_PROVISIONING_SPORT_AT;
    }



    
    /**
     * sFSRV_PROVISIONING_SPORT_AT을 설정
     * @param sFSRV_PROVISIONING_SPORT_AT 을(를) String sFSRV_PROVISIONING_SPORT_AT로 설정
     */
    public void setSFSRV_PROVISIONING_SPORT_AT(String sFSRV_PROVISIONING_SPORT_AT) {
        SFSRV_PROVISIONING_SPORT_AT = sFSRV_PROVISIONING_SPORT_AT;
    }



    /**
     * String[] mETA1을 반환
     * @return String[] mETA1
     */
    public String[] getMETA1() {
        return META1;
    }


    
    /**
     * mETA1을 설정
     * @param mETA1 을(를) String[] mETA1로 설정
     */
    public void setMETA1(String[] META1) {
        this.META1 = META1;
    }


    
    /**
     * String[] mETA2을 반환
     * @return String[] mETA2
     */
    public String[] getMETA2() {
        return META2;
    }


    
    /**
     * mETA2을 설정
     * @param mETA2 을(를) String[] mETA2로 설정
     */
    public void setMETA2(String[] META2) {
        this.META2 = META2;
    }


    
    /**
     * String[] mETA3을 반환
     * @return String[] mETA3
     */
    public String[] getMETA3() {
        return META3;
    }


    
    /**
     * mETA3을 설정
     * @param mETA3 을(를) String[] mETA3로 설정
     */
    public void setMETA3(String[] META3) {
        this.META3 = META3;
    }


    
    /**
     * String[] mETA4을 반환
     * @return String[] mETA4
     */
    public String[] getMETA4() {
        return META4;
    }


    
    /**
     * mETA4을 설정
     * @param mETA4 을(를) String[] mETA4로 설정
     */
    public void setMETA4(String[] META4) {
        this.META4 = META4;
    }


    
    /**
     * String[] mETA5을 반환
     * @return String[] mETA5
     */
    public String[] getMETA5() {
        return META5;
    }


    
    /**
     * mETA5을 설정
     * @param mETA5 을(를) String[] mETA5로 설정
     */
    public void setMETA5(String[] META5) {
        this.META5 = META5;
    }


    
    /**
     * String[] mETA6을 반환
     * @return String[] mETA6
     */
    public String[] getMETA6() {
        return META6;
    }


    
    /**
     * mETA6을 설정
     * @param mETA6 을(를) String[] mETA6로 설정
     */
    public void setMETA6(String[] META6) {
        this.META6 = META6;
    }


    
    /**
     * String[] mETA7을 반환
     * @return String[] mETA7
     */
    public String[] getMETA7() {
        return META7;
    }


    
    /**
     * mETA7을 설정
     * @param mETA7 을(를) String[] mETA7로 설정
     */
    public void setMETA7(String[] META7) {
        this.META7 = META7;
    }


    
    /**
     * String[] mETA8을 반환
     * @return String[] mETA8
     */
    public String[] getMETA8() {
        return META8;
    }


    
    /**
     * mETA8을 설정
     * @param mETA8 을(를) String[] mETA8로 설정
     */
    public void setMETA8(String[] META8) {
        this.META8 = META8;
    }


    
    /**
     * String[] mETA9을 반환
     * @return String[] mETA9
     */
    public String[] getMETA9() {
        return META9;
    }


    
    /**
     * mETA9을 설정
     * @param mETA9 을(를) String[] mETA9로 설정
     */
    public void setMETA9(String[] META9) {
        this.META9 = META9;
    }


    
    /**
     * String[] mETA10을 반환
     * @return String[] mETA10
     */
    public String[] getMETA10() {
        return META10;
    }


    
    /**
     * mETA10을 설정
     * @param mETA10 을(를) String[] mETA10로 설정
     */
    public void setMETA10(String[] META10) {
        this.META10 = META10;
    }


    
    /**
     * String[] mETA11을 반환
     * @return String[] mETA11
     */
    public String[] getMETA11() {
        return META11;
    }


    
    /**
     * mETA11을 설정
     * @param mETA11 을(를) String[] mETA11로 설정
     */
    public void setMETA11(String[] META11) {
        this.META11 = META11;
    }


    
    /**
     * String[] mETA12을 반환
     * @return String[] mETA12
     */
    public String[] getMETA12() {
        return META12;
    }


    
    /**
     * mETA12을 설정
     * @param mETA12 을(를) String[] mETA12로 설정
     */
    public void setMETA12(String[] META12) {
        this.META12 = META12;
    }


    
    /**
     * String[] mETA13을 반환
     * @return String[] mETA13
     */
    public String[] getMETA13() {
        return META13;
    }


    
    /**
     * mETA13을 설정
     * @param mETA13 을(를) String[] mETA13로 설정
     */
    public void setMETA13(String[] META13) {
        this.META13 = META13;
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
     * String[] selectItem2을 반환
     * @return String[] selectItem2
     */
    public String[] getSelectItem2() {
        return selectItem2;
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
     * String[] selectItem13을 반환
     * @return String[] selectItem13
     */
    public String[] getSelectItem13() {
        return selectItem13;
    }

    
    /**
     * selectItem9을 설정
     * @param selectItem13 을(를) String[] selectItem13로 설정
     */
    public void setSelectItem13(String[] selectItem13) {
        this.selectItem13 = selectItem13;
    }
    
    /**
     * String sMeta1을 반환
     * @return String sMeta1
     */
    public String[] getsMeta1() {
        return sMeta1;
    }
    
    /**
     * sMeta1을 설정
     * @param sMeta1 을(를) String sMeta1로 설정
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




    public String getS_DB_MIGRATION_SPORT_AT() {
        return S_DB_MIGRATION_SPORT_AT;
    }




    public void setS_DB_MIGRATION_SPORT_AT(String s_DB_MIGRATION_SPORT_AT) {
        S_DB_MIGRATION_SPORT_AT = s_DB_MIGRATION_SPORT_AT;
    }
 
}
