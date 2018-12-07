/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b.vo;

import zes.base.vo.PaggingVO;

import com.thoughtworks.xstream.annotations.XStreamAlias;

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
 *  2014. 12. 11.    이슬버미       신규
 * </pre>
 * @see
 */

public class G2bItemVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 4996124346976919152L;

    @XStreamAlias("각면허별허용업종")
    private String obj01;
    @XStreamAlias("개찰일시")
    private String obj02;
    @XStreamAlias("개찰장소")
    private String obj03;
    @XStreamAlias("계약방법명")
    private String obj04;
    @XStreamAlias("공고규격서1")
    private String obj05;
    @XStreamAlias("공고규격서2")
    private String obj06;
    @XStreamAlias("공고규격파일명1")
    private String obj07;
    @XStreamAlias("공고규격파일명2")
    private String obj08;
    @XStreamAlias("공고명")
    private String obj09;
    @XStreamAlias("공고상세링크")
    private String obj10;
    @XStreamAlias("공고일시")
    private String obj11;
    @XStreamAlias("공고종류")
    private String obj12;
    @XStreamAlias("공동수급구성방식")
    private String obj13;
    @XStreamAlias("공동수급업체지역제한여부")
    private String obj14;
    @XStreamAlias("공동수급여부")
    private String obj15;
    @XStreamAlias("구매대상물품전체")
    private String obj16;
    @XStreamAlias("국제입찰여부")
    private String obj17;
    @XStreamAlias("규격명")
    private String obj18;
    @XStreamAlias("납품일수")
    private String obj19;
    @XStreamAlias("단위")
    private String obj20;
    @XStreamAlias("담당자메일주소")
    private String obj21;
    @XStreamAlias("담당자명")
    private String obj22;
    @XStreamAlias("담당자전화번호")
    private String obj23;
    @XStreamAlias("등록유형")
    private String obj24;
    @XStreamAlias("면허제한명1")
    private String obj25;
    @XStreamAlias("면허제한명2")
    private String obj26;
    @XStreamAlias("면허제한명3")
    private String obj27;
    @XStreamAlias("면허제한명4")
    private String obj28;
    @XStreamAlias("면허제한명5")
    private String obj29;
    @XStreamAlias("면허제한명6")
    private String obj30;
    @XStreamAlias("면허제한명7")
    private String obj31;
    @XStreamAlias("면허제한명8")
    private String obj32;
    @XStreamAlias("면허제한명9")
    private String obj33;
    @XStreamAlias("면허제한명10")
    private String obj34;
    @XStreamAlias("면허제한명11")
    private String obj35;
    @XStreamAlias("면허제한명12")
    private String obj36;
    @XStreamAlias("발주기관")
    private String obj37;
    @XStreamAlias("발주기관코드")
    private String obj38;
    @XStreamAlias("배정예산금액")
    private String obj39;
    @XStreamAlias("세부품명")
    private String obj40;
    @XStreamAlias("세부품명번호")
    private String obj41;
    @XStreamAlias("수량")
    private String obj42;
    @XStreamAlias("수요기관")
    private String obj43;
    @XStreamAlias("수요기관명")
    private String obj44;
    @XStreamAlias("수요기관코드")
    private String obj45;
    @XStreamAlias("예가방법")
    private String obj46;
    @XStreamAlias("인도조건명")
    private String obj47;
    @XStreamAlias("일련번호")
    private String obj48;
    @XStreamAlias("입찰공고번호")
    private String obj49;
    @XStreamAlias("입찰공고차수")
    private String obj50;
    @XStreamAlias("입찰방식")
    private String obj51;
    @XStreamAlias("입찰보증금납부여부")
    private String obj52;
    @XStreamAlias("입찰서개시일시")
    private String obj53;
    @XStreamAlias("입찰서마감일시")
    private String obj54;
    @XStreamAlias("입찰자격등록일시")
    private String obj55;
    @XStreamAlias("입찰참가수수료")
    private String obj56;
    @XStreamAlias("입찰참가수수료납부여부")
    private String obj57;
    @XStreamAlias("재입찰허용여부")
    private String obj58;
    @XStreamAlias("제조여부")
    private String obj59;
    @XStreamAlias("지명경쟁")
    private String obj60;
    @XStreamAlias("지사투찰허용여부")
    private String obj61;
    @XStreamAlias("집행관명")
    private String obj62;
    @XStreamAlias("참가가능지역1")
    private String obj63;
    @XStreamAlias("참가가능지역2")
    private String obj64;
    @XStreamAlias("참가가능지역3")
    private String obj65;
    @XStreamAlias("참가가능지역목록")
    private String obj66;
    @XStreamAlias("참조번호")
    private String obj67;
    @XStreamAlias("채권자명")
    private String obj68;
    @XStreamAlias("총예가갯수")
    private String obj69;
    @XStreamAlias("추정가격")
    private String obj70;
    @XStreamAlias("추첨예가갯수")
    private String obj71;
    @XStreamAlias("허용업종전체")
    private String obj72;
    @XStreamAlias("용역구분")
    private String obj73;
    @XStreamAlias("pq신청서접수방법")
    private String obj74;
    @XStreamAlias("pq심사")
    private String obj75;
    @XStreamAlias("tp심사신청방법")
    private String obj76;

    @XStreamAlias("계약건명")
    private String obj78;
    @XStreamAlias("계약구분")
    private String obj79;
    @XStreamAlias("계약기간")
    private String obj80;
    @XStreamAlias("계약기관담당부서명")
    private String obj81;
    @XStreamAlias("계약기관담당자성명")
    private String obj82;
    @XStreamAlias("계약기관담당자전화번호")
    private String obj83;
    @XStreamAlias("계약기관담당자팩스번호")
    private String obj84;
    @XStreamAlias("계약기관명")
    private String obj85;
    @XStreamAlias("계약기관소관구분")
    private String obj86;
    @XStreamAlias("계약기관코드")
    private String obj87;
    @XStreamAlias("계약참조번호")
    private String obj88;
    @XStreamAlias("계약체결일자")
    private String obj89;
    @XStreamAlias("공고번호")
    private String obj90;
    @XStreamAlias("공동계약여부")
    private String obj91;
    @XStreamAlias("근거법률")
    private String obj92;
    @XStreamAlias("금액")
    private String obj93;
    @XStreamAlias("금차계약금액")
    private String obj94;
    @XStreamAlias("대표여부")
    private String obj95;
    @XStreamAlias("링크url")
    private String obj96;
    @XStreamAlias("보증금율")
    private String obj97;
    @XStreamAlias("상세링크")
    private String obj98;
    @XStreamAlias("수요기관담당부서명")
    private String obj99;
    @XStreamAlias("수요기관담당자성명")
    private String obj100;
    @XStreamAlias("수요기관담당자전화번호")
    private String obj101;
    @XStreamAlias("수요기관소관구분")
    private String obj102;
    @XStreamAlias("업체정보")
    private String obj103;
    @XStreamAlias("요청번호")
    private String obj104;
    @XStreamAlias("장기계속구분")
    private String obj105;
    @XStreamAlias("지급구분")
    private String obj106;
    @XStreamAlias("총계약금액")
    private String obj107;
    @XStreamAlias("확정계약번호")
    private String obj108;

    /**
     * String obj01을 반환
     * 
     * @return String obj01
     */
    public String getObj01() {
        return obj01;
    }

    /**
     * obj01을 설정
     * 
     * @param obj01 을(를) String obj01로 설정
     */
    public void setObj01(String obj01) {
        this.obj01 = obj01;
    }

    /**
     * String obj02을 반환
     * 
     * @return String obj02
     */
    public String getObj02() {
        return obj02;
    }

    /**
     * obj02을 설정
     * 
     * @param obj02 을(를) String obj02로 설정
     */
    public void setObj02(String obj02) {
        this.obj02 = obj02;
    }

    /**
     * String obj03을 반환
     * 
     * @return String obj03
     */
    public String getObj03() {
        return obj03;
    }

    /**
     * obj03을 설정
     * 
     * @param obj03 을(를) String obj03로 설정
     */
    public void setObj03(String obj03) {
        this.obj03 = obj03;
    }

    /**
     * String obj04을 반환
     * 
     * @return String obj04
     */
    public String getObj04() {
        return obj04;
    }

    /**
     * obj04을 설정
     * 
     * @param obj04 을(를) String obj04로 설정
     */
    public void setObj04(String obj04) {
        this.obj04 = obj04;
    }

    /**
     * String obj05을 반환
     * 
     * @return String obj05
     */
    public String getObj05() {
        return obj05;
    }

    /**
     * obj05을 설정
     * 
     * @param obj05 을(를) String obj05로 설정
     */
    public void setObj05(String obj05) {
        this.obj05 = obj05;
    }

    /**
     * String obj06을 반환
     * 
     * @return String obj06
     */
    public String getObj06() {
        return obj06;
    }

    /**
     * obj06을 설정
     * 
     * @param obj06 을(를) String obj06로 설정
     */
    public void setObj06(String obj06) {
        this.obj06 = obj06;
    }

    /**
     * String obj07을 반환
     * 
     * @return String obj07
     */
    public String getObj07() {
        return obj07;
    }

    /**
     * obj07을 설정
     * 
     * @param obj07 을(를) String obj07로 설정
     */
    public void setObj07(String obj07) {
        this.obj07 = obj07;
    }

    /**
     * String obj08을 반환
     * 
     * @return String obj08
     */
    public String getObj08() {
        return obj08;
    }

    /**
     * obj08을 설정
     * 
     * @param obj08 을(를) String obj08로 설정
     */
    public void setObj08(String obj08) {
        this.obj08 = obj08;
    }

    /**
     * String obj09을 반환
     * 
     * @return String obj09
     */
    public String getObj09() {
        return obj09;
    }

    /**
     * obj09을 설정
     * 
     * @param obj09 을(를) String obj09로 설정
     */
    public void setObj09(String obj09) {
        this.obj09 = obj09;
    }

    /**
     * String obj10을 반환
     * 
     * @return String obj10
     */
    public String getObj10() {
        return obj10;
    }

    /**
     * obj10을 설정
     * 
     * @param obj10 을(를) String obj10로 설정
     */
    public void setObj10(String obj10) {
        this.obj10 = obj10;
    }

    /**
     * String obj11을 반환
     * 
     * @return String obj11
     */
    public String getObj11() {
        return obj11;
    }

    /**
     * obj11을 설정
     * 
     * @param obj11 을(를) String obj11로 설정
     */
    public void setObj11(String obj11) {
        this.obj11 = obj11;
    }

    /**
     * String obj12을 반환
     * 
     * @return String obj12
     */
    public String getObj12() {
        return obj12;
    }

    /**
     * obj12을 설정
     * 
     * @param obj12 을(를) String obj12로 설정
     */
    public void setObj12(String obj12) {
        this.obj12 = obj12;
    }

    /**
     * String obj13을 반환
     * 
     * @return String obj13
     */
    public String getObj13() {
        return obj13;
    }

    /**
     * obj13을 설정
     * 
     * @param obj13 을(를) String obj13로 설정
     */
    public void setObj13(String obj13) {
        this.obj13 = obj13;
    }

    /**
     * String obj14을 반환
     * 
     * @return String obj14
     */
    public String getObj14() {
        return obj14;
    }

    /**
     * obj14을 설정
     * 
     * @param obj14 을(를) String obj14로 설정
     */
    public void setObj14(String obj14) {
        this.obj14 = obj14;
    }

    /**
     * String obj15을 반환
     * 
     * @return String obj15
     */
    public String getObj15() {
        return obj15;
    }

    /**
     * obj15을 설정
     * 
     * @param obj15 을(를) String obj15로 설정
     */
    public void setObj15(String obj15) {
        this.obj15 = obj15;
    }

    /**
     * String obj16을 반환
     * 
     * @return String obj16
     */
    public String getObj16() {
        return obj16;
    }

    /**
     * obj16을 설정
     * 
     * @param obj16 을(를) String obj16로 설정
     */
    public void setObj16(String obj16) {
        this.obj16 = obj16;
    }

    /**
     * String obj17을 반환
     * 
     * @return String obj17
     */
    public String getObj17() {
        return obj17;
    }

    /**
     * obj17을 설정
     * 
     * @param obj17 을(를) String obj17로 설정
     */
    public void setObj17(String obj17) {
        this.obj17 = obj17;
    }

    /**
     * String obj18을 반환
     * 
     * @return String obj18
     */
    public String getObj18() {
        return obj18;
    }

    /**
     * obj18을 설정
     * 
     * @param obj18 을(를) String obj18로 설정
     */
    public void setObj18(String obj18) {
        this.obj18 = obj18;
    }

    /**
     * String obj19을 반환
     * 
     * @return String obj19
     */
    public String getObj19() {
        return obj19;
    }

    /**
     * obj19을 설정
     * 
     * @param obj19 을(를) String obj19로 설정
     */
    public void setObj19(String obj19) {
        this.obj19 = obj19;
    }

    /**
     * String obj20을 반환
     * 
     * @return String obj20
     */
    public String getObj20() {
        return obj20;
    }

    /**
     * obj20을 설정
     * 
     * @param obj20 을(를) String obj20로 설정
     */
    public void setObj20(String obj20) {
        this.obj20 = obj20;
    }

    /**
     * String obj21을 반환
     * 
     * @return String obj21
     */
    public String getObj21() {
        return obj21;
    }

    /**
     * obj21을 설정
     * 
     * @param obj21 을(를) String obj21로 설정
     */
    public void setObj21(String obj21) {
        this.obj21 = obj21;
    }

    /**
     * String obj22을 반환
     * 
     * @return String obj22
     */
    public String getObj22() {
        return obj22;
    }

    /**
     * obj22을 설정
     * 
     * @param obj22 을(를) String obj22로 설정
     */
    public void setObj22(String obj22) {
        this.obj22 = obj22;
    }

    /**
     * String obj23을 반환
     * 
     * @return String obj23
     */
    public String getObj23() {
        return obj23;
    }

    /**
     * obj23을 설정
     * 
     * @param obj23 을(를) String obj23로 설정
     */
    public void setObj23(String obj23) {
        this.obj23 = obj23;
    }

    /**
     * String obj24을 반환
     * 
     * @return String obj24
     */
    public String getObj24() {
        return obj24;
    }

    /**
     * obj24을 설정
     * 
     * @param obj24 을(를) String obj24로 설정
     */
    public void setObj24(String obj24) {
        this.obj24 = obj24;
    }

    /**
     * String obj25을 반환
     * 
     * @return String obj25
     */
    public String getObj25() {
        return obj25;
    }

    /**
     * obj25을 설정
     * 
     * @param obj25 을(를) String obj25로 설정
     */
    public void setObj25(String obj25) {
        this.obj25 = obj25;
    }

    /**
     * String obj26을 반환
     * 
     * @return String obj26
     */
    public String getObj26() {
        return obj26;
    }

    /**
     * obj26을 설정
     * 
     * @param obj26 을(를) String obj26로 설정
     */
    public void setObj26(String obj26) {
        this.obj26 = obj26;
    }

    /**
     * String obj27을 반환
     * 
     * @return String obj27
     */
    public String getObj27() {
        return obj27;
    }

    /**
     * obj27을 설정
     * 
     * @param obj27 을(를) String obj27로 설정
     */
    public void setObj27(String obj27) {
        this.obj27 = obj27;
    }

    /**
     * String obj28을 반환
     * 
     * @return String obj28
     */
    public String getObj28() {
        return obj28;
    }

    /**
     * obj28을 설정
     * 
     * @param obj28 을(를) String obj28로 설정
     */
    public void setObj28(String obj28) {
        this.obj28 = obj28;
    }

    /**
     * String obj29을 반환
     * 
     * @return String obj29
     */
    public String getObj29() {
        return obj29;
    }

    /**
     * obj29을 설정
     * 
     * @param obj29 을(를) String obj29로 설정
     */
    public void setObj29(String obj29) {
        this.obj29 = obj29;
    }

    /**
     * String obj30을 반환
     * 
     * @return String obj30
     */
    public String getObj30() {
        return obj30;
    }

    /**
     * obj30을 설정
     * 
     * @param obj30 을(를) String obj30로 설정
     */
    public void setObj30(String obj30) {
        this.obj30 = obj30;
    }

    /**
     * String obj31을 반환
     * 
     * @return String obj31
     */
    public String getObj31() {
        return obj31;
    }

    /**
     * obj31을 설정
     * 
     * @param obj31 을(를) String obj31로 설정
     */
    public void setObj31(String obj31) {
        this.obj31 = obj31;
    }

    /**
     * String obj32을 반환
     * 
     * @return String obj32
     */
    public String getObj32() {
        return obj32;
    }

    /**
     * obj32을 설정
     * 
     * @param obj32 을(를) String obj32로 설정
     */
    public void setObj32(String obj32) {
        this.obj32 = obj32;
    }

    /**
     * String obj33을 반환
     * 
     * @return String obj33
     */
    public String getObj33() {
        return obj33;
    }

    /**
     * obj33을 설정
     * 
     * @param obj33 을(를) String obj33로 설정
     */
    public void setObj33(String obj33) {
        this.obj33 = obj33;
    }

    /**
     * String obj34을 반환
     * 
     * @return String obj34
     */
    public String getObj34() {
        return obj34;
    }

    /**
     * obj34을 설정
     * 
     * @param obj34 을(를) String obj34로 설정
     */
    public void setObj34(String obj34) {
        this.obj34 = obj34;
    }

    /**
     * String obj35을 반환
     * 
     * @return String obj35
     */
    public String getObj35() {
        return obj35;
    }

    /**
     * obj35을 설정
     * 
     * @param obj35 을(를) String obj35로 설정
     */
    public void setObj35(String obj35) {
        this.obj35 = obj35;
    }

    /**
     * String obj36을 반환
     * 
     * @return String obj36
     */
    public String getObj36() {
        return obj36;
    }

    /**
     * obj36을 설정
     * 
     * @param obj36 을(를) String obj36로 설정
     */
    public void setObj36(String obj36) {
        this.obj36 = obj36;
    }

    /**
     * String obj37을 반환
     * 
     * @return String obj37
     */
    public String getObj37() {
        return obj37;
    }

    /**
     * obj37을 설정
     * 
     * @param obj37 을(를) String obj37로 설정
     */
    public void setObj37(String obj37) {
        this.obj37 = obj37;
    }

    /**
     * String obj38을 반환
     * 
     * @return String obj38
     */
    public String getObj38() {
        return obj38;
    }

    /**
     * obj38을 설정
     * 
     * @param obj38 을(를) String obj38로 설정
     */
    public void setObj38(String obj38) {
        this.obj38 = obj38;
    }

    /**
     * String obj39을 반환
     * 
     * @return String obj39
     */
    public String getObj39() {
        return obj39;
    }

    /**
     * obj39을 설정
     * 
     * @param obj39 을(를) String obj39로 설정
     */
    public void setObj39(String obj39) {
        this.obj39 = obj39;
    }

    /**
     * String obj40을 반환
     * 
     * @return String obj40
     */
    public String getObj40() {
        return obj40;
    }

    /**
     * obj40을 설정
     * 
     * @param obj40 을(를) String obj40로 설정
     */
    public void setObj40(String obj40) {
        this.obj40 = obj40;
    }

    /**
     * String obj41을 반환
     * 
     * @return String obj41
     */
    public String getObj41() {
        return obj41;
    }

    /**
     * obj41을 설정
     * 
     * @param obj41 을(를) String obj41로 설정
     */
    public void setObj41(String obj41) {
        this.obj41 = obj41;
    }

    /**
     * String obj42을 반환
     * 
     * @return String obj42
     */
    public String getObj42() {
        return obj42;
    }

    /**
     * obj42을 설정
     * 
     * @param obj42 을(를) String obj42로 설정
     */
    public void setObj42(String obj42) {
        this.obj42 = obj42;
    }

    /**
     * String obj43을 반환
     * 
     * @return String obj43
     */
    public String getObj43() {
        return obj43;
    }

    /**
     * obj43을 설정
     * 
     * @param obj43 을(를) String obj43로 설정
     */
    public void setObj43(String obj43) {
        this.obj43 = obj43;
    }

    /**
     * String obj44을 반환
     * 
     * @return String obj44
     */
    public String getObj44() {
        return obj44;
    }

    /**
     * obj44을 설정
     * 
     * @param obj44 을(를) String obj44로 설정
     */
    public void setObj44(String obj44) {
        this.obj44 = obj44;
    }

    /**
     * String obj45을 반환
     * 
     * @return String obj45
     */
    public String getObj45() {
        return obj45;
    }

    /**
     * obj45을 설정
     * 
     * @param obj45 을(를) String obj45로 설정
     */
    public void setObj45(String obj45) {
        this.obj45 = obj45;
    }

    /**
     * String obj46을 반환
     * 
     * @return String obj46
     */
    public String getObj46() {
        return obj46;
    }

    /**
     * obj46을 설정
     * 
     * @param obj46 을(를) String obj46로 설정
     */
    public void setObj46(String obj46) {
        this.obj46 = obj46;
    }

    /**
     * String obj47을 반환
     * 
     * @return String obj47
     */
    public String getObj47() {
        return obj47;
    }

    /**
     * obj47을 설정
     * 
     * @param obj47 을(를) String obj47로 설정
     */
    public void setObj47(String obj47) {
        this.obj47 = obj47;
    }

    /**
     * String obj48을 반환
     * 
     * @return String obj48
     */
    public String getObj48() {
        return obj48;
    }

    /**
     * obj48을 설정
     * 
     * @param obj48 을(를) String obj48로 설정
     */
    public void setObj48(String obj48) {
        this.obj48 = obj48;
    }

    /**
     * String obj49을 반환
     * 
     * @return String obj49
     */
    public String getObj49() {
        return obj49;
    }

    /**
     * obj49을 설정
     * 
     * @param obj49 을(를) String obj49로 설정
     */
    public void setObj49(String obj49) {
        this.obj49 = obj49;
    }

    /**
     * String obj50을 반환
     * 
     * @return String obj50
     */
    public String getObj50() {
        return obj50;
    }

    /**
     * obj50을 설정
     * 
     * @param obj50 을(를) String obj50로 설정
     */
    public void setObj50(String obj50) {
        this.obj50 = obj50;
    }

    /**
     * String obj51을 반환
     * 
     * @return String obj51
     */
    public String getObj51() {
        return obj51;
    }

    /**
     * obj51을 설정
     * 
     * @param obj51 을(를) String obj51로 설정
     */
    public void setObj51(String obj51) {
        this.obj51 = obj51;
    }

    /**
     * String obj52을 반환
     * 
     * @return String obj52
     */
    public String getObj52() {
        return obj52;
    }

    /**
     * obj52을 설정
     * 
     * @param obj52 을(를) String obj52로 설정
     */
    public void setObj52(String obj52) {
        this.obj52 = obj52;
    }

    /**
     * String obj53을 반환
     * 
     * @return String obj53
     */
    public String getObj53() {
        return obj53;
    }

    /**
     * obj53을 설정
     * 
     * @param obj53 을(를) String obj53로 설정
     */
    public void setObj53(String obj53) {
        this.obj53 = obj53;
    }

    /**
     * String obj54을 반환
     * 
     * @return String obj54
     */
    public String getObj54() {
        return obj54;
    }

    /**
     * obj54을 설정
     * 
     * @param obj54 을(를) String obj54로 설정
     */
    public void setObj54(String obj54) {
        this.obj54 = obj54;
    }

    /**
     * String obj55을 반환
     * 
     * @return String obj55
     */
    public String getObj55() {
        return obj55;
    }

    /**
     * obj55을 설정
     * 
     * @param obj55 을(를) String obj55로 설정
     */
    public void setObj55(String obj55) {
        this.obj55 = obj55;
    }

    /**
     * String obj56을 반환
     * 
     * @return String obj56
     */
    public String getObj56() {
        return obj56;
    }

    /**
     * obj56을 설정
     * 
     * @param obj56 을(를) String obj56로 설정
     */
    public void setObj56(String obj56) {
        this.obj56 = obj56;
    }

    /**
     * String obj57을 반환
     * 
     * @return String obj57
     */
    public String getObj57() {
        return obj57;
    }

    /**
     * obj57을 설정
     * 
     * @param obj57 을(를) String obj57로 설정
     */
    public void setObj57(String obj57) {
        this.obj57 = obj57;
    }

    /**
     * String obj58을 반환
     * 
     * @return String obj58
     */
    public String getObj58() {
        return obj58;
    }

    /**
     * obj58을 설정
     * 
     * @param obj58 을(를) String obj58로 설정
     */
    public void setObj58(String obj58) {
        this.obj58 = obj58;
    }

    /**
     * String obj59을 반환
     * 
     * @return String obj59
     */
    public String getObj59() {
        return obj59;
    }

    /**
     * obj59을 설정
     * 
     * @param obj59 을(를) String obj59로 설정
     */
    public void setObj59(String obj59) {
        this.obj59 = obj59;
    }

    /**
     * String obj60을 반환
     * 
     * @return String obj60
     */
    public String getObj60() {
        return obj60;
    }

    /**
     * obj60을 설정
     * 
     * @param obj60 을(를) String obj60로 설정
     */
    public void setObj60(String obj60) {
        this.obj60 = obj60;
    }

    /**
     * String obj61을 반환
     * 
     * @return String obj61
     */
    public String getObj61() {
        return obj61;
    }

    /**
     * obj61을 설정
     * 
     * @param obj61 을(를) String obj61로 설정
     */
    public void setObj61(String obj61) {
        this.obj61 = obj61;
    }

    /**
     * String obj62을 반환
     * 
     * @return String obj62
     */
    public String getObj62() {
        return obj62;
    }

    /**
     * obj62을 설정
     * 
     * @param obj62 을(를) String obj62로 설정
     */
    public void setObj62(String obj62) {
        this.obj62 = obj62;
    }

    /**
     * String obj63을 반환
     * 
     * @return String obj63
     */
    public String getObj63() {
        return obj63;
    }

    /**
     * obj63을 설정
     * 
     * @param obj63 을(를) String obj63로 설정
     */
    public void setObj63(String obj63) {
        this.obj63 = obj63;
    }

    /**
     * String obj64을 반환
     * 
     * @return String obj64
     */
    public String getObj64() {
        return obj64;
    }

    /**
     * obj64을 설정
     * 
     * @param obj64 을(를) String obj64로 설정
     */
    public void setObj64(String obj64) {
        this.obj64 = obj64;
    }

    /**
     * String obj65을 반환
     * 
     * @return String obj65
     */
    public String getObj65() {
        return obj65;
    }

    /**
     * obj65을 설정
     * 
     * @param obj65 을(를) String obj65로 설정
     */
    public void setObj65(String obj65) {
        this.obj65 = obj65;
    }

    /**
     * String obj66을 반환
     * 
     * @return String obj66
     */
    public String getObj66() {
        return obj66;
    }

    /**
     * obj66을 설정
     * 
     * @param obj66 을(를) String obj66로 설정
     */
    public void setObj66(String obj66) {
        this.obj66 = obj66;
    }

    /**
     * String obj67을 반환
     * 
     * @return String obj67
     */
    public String getObj67() {
        return obj67;
    }

    /**
     * obj67을 설정
     * 
     * @param obj67 을(를) String obj67로 설정
     */
    public void setObj67(String obj67) {
        this.obj67 = obj67;
    }

    /**
     * String obj68을 반환
     * 
     * @return String obj68
     */
    public String getObj68() {
        return obj68;
    }

    /**
     * obj68을 설정
     * 
     * @param obj68 을(를) String obj68로 설정
     */
    public void setObj68(String obj68) {
        this.obj68 = obj68;
    }

    /**
     * String obj69을 반환
     * 
     * @return String obj69
     */
    public String getObj69() {
        return obj69;
    }

    /**
     * obj69을 설정
     * 
     * @param obj69 을(를) String obj69로 설정
     */
    public void setObj69(String obj69) {
        this.obj69 = obj69;
    }

    /**
     * String obj70을 반환
     * 
     * @return String obj70
     */
    public String getObj70() {
        return obj70;
    }

    /**
     * obj70을 설정
     * 
     * @param obj70 을(를) String obj70로 설정
     */
    public void setObj70(String obj70) {
        this.obj70 = obj70;
    }

    /**
     * String obj71을 반환
     * 
     * @return String obj71
     */
    public String getObj71() {
        return obj71;
    }

    /**
     * obj71을 설정
     * 
     * @param obj71 을(를) String obj71로 설정
     */
    public void setObj71(String obj71) {
        this.obj71 = obj71;
    }

    /**
     * String obj72을 반환
     * 
     * @return String obj72
     */
    public String getObj72() {
        return obj72;
    }

    /**
     * obj72을 설정
     * 
     * @param obj72 을(를) String obj72로 설정
     */
    public void setObj72(String obj72) {
        this.obj72 = obj72;
    }

    /**
     * String obj73을 반환
     * 
     * @return String obj73
     */
    public String getObj73() {
        return obj73;
    }

    /**
     * obj73을 설정
     * 
     * @param obj73 을(를) String obj73로 설정
     */
    public void setObj73(String obj73) {
        this.obj73 = obj73;
    }

    /**
     * String obj74을 반환
     * 
     * @return String obj74
     */
    public String getObj74() {
        return obj74;
    }

    /**
     * obj74을 설정
     * 
     * @param obj74 을(를) String obj74로 설정
     */
    public void setObj74(String obj74) {
        this.obj74 = obj74;
    }

    /**
     * String obj75을 반환
     * 
     * @return String obj75
     */
    public String getObj75() {
        return obj75;
    }

    /**
     * obj75을 설정
     * 
     * @param obj75 을(를) String obj75로 설정
     */
    public void setObj75(String obj75) {
        this.obj75 = obj75;
    }

    /**
     * String obj76을 반환
     * 
     * @return String obj76
     */
    public String getObj76() {
        return obj76;
    }

    /**
     * obj76을 설정
     * 
     * @param obj76 을(를) String obj76로 설정
     */
    public void setObj76(String obj76) {
        this.obj76 = obj76;
    }

    /**
     * String obj78을 반환
     * 
     * @return String obj78
     */
    public String getObj78() {
        return obj78;
    }

    /**
     * obj78을 설정
     * 
     * @param obj78 을(를) String obj78로 설정
     */
    public void setObj78(String obj78) {
        this.obj78 = obj78;
    }

    /**
     * String obj79을 반환
     * 
     * @return String obj79
     */
    public String getObj79() {
        return obj79;
    }

    /**
     * obj79을 설정
     * 
     * @param obj79 을(를) String obj79로 설정
     */
    public void setObj79(String obj79) {
        this.obj79 = obj79;
    }

    /**
     * String obj80을 반환
     * 
     * @return String obj80
     */
    public String getObj80() {
        return obj80;
    }

    /**
     * obj80을 설정
     * 
     * @param obj80 을(를) String obj80로 설정
     */
    public void setObj80(String obj80) {
        this.obj80 = obj80;
    }

    /**
     * String obj81을 반환
     * 
     * @return String obj81
     */
    public String getObj81() {
        return obj81;
    }

    /**
     * obj81을 설정
     * 
     * @param obj81 을(를) String obj81로 설정
     */
    public void setObj81(String obj81) {
        this.obj81 = obj81;
    }

    /**
     * String obj82을 반환
     * 
     * @return String obj82
     */
    public String getObj82() {
        return obj82;
    }

    /**
     * obj82을 설정
     * 
     * @param obj82 을(를) String obj82로 설정
     */
    public void setObj82(String obj82) {
        this.obj82 = obj82;
    }

    /**
     * String obj83을 반환
     * 
     * @return String obj83
     */
    public String getObj83() {
        return obj83;
    }

    /**
     * obj83을 설정
     * 
     * @param obj83 을(를) String obj83로 설정
     */
    public void setObj83(String obj83) {
        this.obj83 = obj83;
    }

    /**
     * String obj84을 반환
     * 
     * @return String obj84
     */
    public String getObj84() {
        return obj84;
    }

    /**
     * obj84을 설정
     * 
     * @param obj84 을(를) String obj84로 설정
     */
    public void setObj84(String obj84) {
        this.obj84 = obj84;
    }

    /**
     * String obj85을 반환
     * 
     * @return String obj85
     */
    public String getObj85() {
        return obj85;
    }

    /**
     * obj85을 설정
     * 
     * @param obj85 을(를) String obj85로 설정
     */
    public void setObj85(String obj85) {
        this.obj85 = obj85;
    }

    /**
     * String obj86을 반환
     * 
     * @return String obj86
     */
    public String getObj86() {
        return obj86;
    }

    /**
     * obj86을 설정
     * 
     * @param obj86 을(를) String obj86로 설정
     */
    public void setObj86(String obj86) {
        this.obj86 = obj86;
    }

    /**
     * String obj87을 반환
     * 
     * @return String obj87
     */
    public String getObj87() {
        return obj87;
    }

    /**
     * obj87을 설정
     * 
     * @param obj87 을(를) String obj87로 설정
     */
    public void setObj87(String obj87) {
        this.obj87 = obj87;
    }

    /**
     * String obj88을 반환
     * 
     * @return String obj88
     */
    public String getObj88() {
        return obj88;
    }

    /**
     * obj88을 설정
     * 
     * @param obj88 을(를) String obj88로 설정
     */
    public void setObj88(String obj88) {
        this.obj88 = obj88;
    }

    /**
     * String obj89을 반환
     * 
     * @return String obj89
     */
    public String getObj89() {
        return obj89;
    }

    /**
     * obj89을 설정
     * 
     * @param obj89 을(를) String obj89로 설정
     */
    public void setObj89(String obj89) {
        this.obj89 = obj89;
    }

    /**
     * String obj90을 반환
     * 
     * @return String obj90
     */
    public String getObj90() {
        return obj90;
    }

    /**
     * obj90을 설정
     * 
     * @param obj90 을(를) String obj90로 설정
     */
    public void setObj90(String obj90) {
        this.obj90 = obj90;
    }

    /**
     * String obj91을 반환
     * 
     * @return String obj91
     */
    public String getObj91() {
        return obj91;
    }

    /**
     * obj91을 설정
     * 
     * @param obj91 을(를) String obj91로 설정
     */
    public void setObj91(String obj91) {
        this.obj91 = obj91;
    }

    /**
     * String obj92을 반환
     * 
     * @return String obj92
     */
    public String getObj92() {
        return obj92;
    }

    /**
     * obj92을 설정
     * 
     * @param obj92 을(를) String obj92로 설정
     */
    public void setObj92(String obj92) {
        this.obj92 = obj92;
    }

    /**
     * String obj93을 반환
     * 
     * @return String obj93
     */
    public String getObj93() {
        return obj93;
    }

    /**
     * obj93을 설정
     * 
     * @param obj93 을(를) String obj93로 설정
     */
    public void setObj93(String obj93) {
        this.obj93 = obj93;
    }

    /**
     * String obj94을 반환
     * 
     * @return String obj94
     */
    public String getObj94() {
        return obj94;
    }

    /**
     * obj94을 설정
     * 
     * @param obj94 을(를) String obj94로 설정
     */
    public void setObj94(String obj94) {
        this.obj94 = obj94;
    }

    /**
     * String obj95을 반환
     * 
     * @return String obj95
     */
    public String getObj95() {
        return obj95;
    }

    /**
     * obj95을 설정
     * 
     * @param obj95 을(를) String obj95로 설정
     */
    public void setObj95(String obj95) {
        this.obj95 = obj95;
    }

    /**
     * String obj96을 반환
     * 
     * @return String obj96
     */
    public String getObj96() {
        return obj96;
    }

    /**
     * obj96을 설정
     * 
     * @param obj96 을(를) String obj96로 설정
     */
    public void setObj96(String obj96) {
        this.obj96 = obj96;
    }

    /**
     * String obj97을 반환
     * 
     * @return String obj97
     */
    public String getObj97() {
        return obj97;
    }

    /**
     * obj97을 설정
     * 
     * @param obj97 을(를) String obj97로 설정
     */
    public void setObj97(String obj97) {
        this.obj97 = obj97;
    }

    /**
     * String obj98을 반환
     * 
     * @return String obj98
     */
    public String getObj98() {
        return obj98;
    }

    /**
     * obj98을 설정
     * 
     * @param obj98 을(를) String obj98로 설정
     */
    public void setObj98(String obj98) {
        this.obj98 = obj98;
    }

    /**
     * String obj99을 반환
     * 
     * @return String obj99
     */
    public String getObj99() {
        return obj99;
    }

    /**
     * obj99을 설정
     * 
     * @param obj99 을(를) String obj99로 설정
     */
    public void setObj99(String obj99) {
        this.obj99 = obj99;
    }

    /**
     * String obj100을 반환
     * 
     * @return String obj100
     */
    public String getObj100() {
        return obj100;
    }

    /**
     * obj100을 설정
     * 
     * @param obj100 을(를) String obj100로 설정
     */
    public void setObj100(String obj100) {
        this.obj100 = obj100;
    }

    /**
     * String obj101을 반환
     * 
     * @return String obj101
     */
    public String getObj101() {
        return obj101;
    }

    /**
     * obj101을 설정
     * 
     * @param obj101 을(를) String obj101로 설정
     */
    public void setObj101(String obj101) {
        this.obj101 = obj101;
    }

    /**
     * String obj102을 반환
     * 
     * @return String obj102
     */
    public String getObj102() {
        return obj102;
    }

    /**
     * obj102을 설정
     * 
     * @param obj102 을(를) String obj102로 설정
     */
    public void setObj102(String obj102) {
        this.obj102 = obj102;
    }

    /**
     * String obj103을 반환
     * 
     * @return String obj103
     */
    public String getObj103() {
        return obj103;
    }

    /**
     * obj103을 설정
     * 
     * @param obj103 을(를) String obj103로 설정
     */
    public void setObj103(String obj103) {
        this.obj103 = obj103;
    }

    /**
     * String obj104을 반환
     * 
     * @return String obj104
     */
    public String getObj104() {
        return obj104;
    }

    /**
     * obj104을 설정
     * 
     * @param obj104 을(를) String obj104로 설정
     */
    public void setObj104(String obj104) {
        this.obj104 = obj104;
    }

    /**
     * String obj105을 반환
     * 
     * @return String obj105
     */
    public String getObj105() {
        return obj105;
    }

    /**
     * obj105을 설정
     * 
     * @param obj105 을(를) String obj105로 설정
     */
    public void setObj105(String obj105) {
        this.obj105 = obj105;
    }

    /**
     * String obj106을 반환
     * 
     * @return String obj106
     */
    public String getObj106() {
        return obj106;
    }

    /**
     * obj106을 설정
     * 
     * @param obj106 을(를) String obj106로 설정
     */
    public void setObj106(String obj106) {
        this.obj106 = obj106;
    }

    /**
     * String obj107을 반환
     * 
     * @return String obj107
     */
    public String getObj107() {
        return obj107;
    }

    /**
     * obj107을 설정
     * 
     * @param obj107 을(를) String obj107로 설정
     */
    public void setObj107(String obj107) {
        this.obj107 = obj107;
    }

    /**
     * String obj108을 반환
     * 
     * @return String obj108
     */
    public String getObj108() {
        return obj108;
    }

    /**
     * obj108을 설정
     * 
     * @param obj108 을(를) String obj108로 설정
     */
    public void setObj108(String obj108) {
        this.obj108 = obj108;
    }

}
