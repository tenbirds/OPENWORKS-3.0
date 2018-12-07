/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandManage;

import zes.base.vo.PaggingVO;

/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2017-09-07      손은구      신규
*</pre>
* @see
*/

public class DmandManageVO extends PaggingVO {

    private static final long serialVersionUID = -2065559676127699119L;

    /*년도*/
    private String dmandExaminOprtnYear;
    /*수요조시 시작 날짜*/
    private String registBeginDate;
    /*수요조사 종료 날짜*/
    private String registEndDate;
    /*최상위기관명*/
    private String orgnNm;
    /*기관명*/
    private String orgnNmSt;
    /*유저이름(담당자)*/
    private String userNm;
    /*유저아이디*/
    private String userId;
    /*시스템수*/
    private int sumCount;
    /*제출일*/
    private String presentnDate;
    /* 제출 수*/
    private int presentnCount; 
    /* 검색 제출 수*/
    private int subMissionCount;
    /* 대상기관 수*/
    private int orgnCount;
    /* 미제출 기관목록 순번*/
    private String rowNumb;
    /*기관명*/
    private String buseoCodeNm;
    /*기관코드*/
    private String buseoCode;
    /*기관유형*/
    private String statsTyNm;
    /*기관수*/
    private String totalCount;
    /*전체 시스템 수*/
    private String totalSys;
    /*기이용건수*/
    private String clouduseCount;
    /*전환 및 도입 예정 건수*/
    private String planCount1;
    /*도입 및 전환예정 구분 - 민간 카운트*/
    private String separaCount1;
    /*도입 및 전환예정 구분 - 자체 카운트*/
    private String separaCount2;
    /*도입 및 전환예정 구분 - G-클라우드 카운트*/
    private String separaCount3;
    /*도입 및 전환예정 구분 - 하이브리드 카운트*/
    private String separaCount4;
    /*서비스 구분 - SaaS 카운트*/
    private String separatCount1;
    /*서비스 구분 - PaaS 카운트*/
    private String separatCount2;
    /*서비스 구분 - IaaS 카운트*/
    private String separatCount3;
    /*서비스 구분 - IaaS+SaaS 카운트*/
    private String separatCount4;
    /*서비스 구분 - IaaS+PaaS 카운트*/
    private String separatCount5;
    /*서비스 구분 - PaaS+SaaS 카운트*/
    private String separatCount6;
    /*서비스 구분 - IaaS+PaaS+SaaS 카운트*/
    private String separatCount7;
    /*수요없음*/
    private String planCount2;
    /*예정없음*/
    private String planCount3;
    /*클라우드 예산*/
    private String dmandSurveyBudget;
    /*제출현황 - 제출완료*/
    private String subMission;
    /*제출현황 -제출미완료*/
    private String unSubMission;
    /*제출현황 -기관별 제출율*/
    private String subMissionRate;
    /*제출현황 -제출 백분률*/
    private String subMissionRate2;
    private String bestOrgnCodeNm;
    private String dmandsurveyphone;    

    
    
    
    
    /**
     * String dmandsurveyphone을 반환
     * @return String dmandsurveyphone
     */
    public String getDmandsurveyphone() {
        return dmandsurveyphone;
    }



    
    /**
     * dmandsurveyphone을 설정
     * @param dmandsurveyphone 을(를) String dmandsurveyphone로 설정
     */
    public void setDmandsurveyphone(String dmandsurveyphone) {
        this.dmandsurveyphone = dmandsurveyphone;
    }



    /**
     * String bestOrgnCodeNm을 반환
     * @return String bestOrgnCodeNm
     */
    public String getBestOrgnCodeNm() {
        return bestOrgnCodeNm;
    }


    
    /**
     * bestOrgnCodeNm을 설정
     * @param bestOrgnCodeNm 을(를) String bestOrgnCodeNm로 설정
     */
    public void setBestOrgnCodeNm(String bestOrgnCodeNm) {
        this.bestOrgnCodeNm = bestOrgnCodeNm;
    }


    /**
     * String orgnNm을 반환
     * @return String orgnNm
     */
    public String getOrgnNm() {
        return orgnNm;
    }
    
    
    /**
     * String dmandExaminOprtnYear을 반환
     * @return String dmandExaminOprtnYear
     */
    public String getDmandExaminOprtnYear() {
        return dmandExaminOprtnYear;
    }

    
    /**
     * dmandExaminOprtnYear을 설정
     * @param dmandExaminOprtnYear 을(를) String dmandExaminOprtnYear로 설정
     */
    public void setDmandExaminOprtnYear(String dmandExaminOprtnYear) {
        this.dmandExaminOprtnYear = dmandExaminOprtnYear;
    }

    
    /**
     * String registBeginDate을 반환
     * @return String registBeginDate
     */
    public String getRegistBeginDate() {
        return registBeginDate;
    }

    
    /**
     * registBeginDate을 설정
     * @param registBeginDate 을(를) String registBeginDate로 설정
     */
    public void setRegistBeginDate(String registBeginDate) {
        this.registBeginDate = registBeginDate;
    }

    
    /**
     * String registEndDate을 반환
     * @return String registEndDate
     */
    public String getRegistEndDate() {
        return registEndDate;
    }

    
    /**
     * registEndDate을 설정
     * @param registEndDate 을(를) String registEndDate로 설정
     */
    public void setRegistEndDate(String registEndDate) {
        this.registEndDate = registEndDate;
    }

    
    /**
     * sumCount을 설정
     * @param sumCount 을(를) int sumCount로 설정
     */
    public void setSumCount(int sumCount) {
        this.sumCount = sumCount;
    }

    /**
     * orgnNm을 설정
     * @param orgnNm 을(를) String orgnNm로 설정
     */
    public void setOrgnNm(String orgnNm) {
        this.orgnNm = orgnNm;
    }
    
    /**
     * String orgnNmSt을 반환
     * @return String orgnNmSt
     */
    public String getOrgnNmSt() {
        return orgnNmSt;
    }
    
    /**
     * orgnNmSt을 설정
     * @param orgnNmSt 을(를) String orgnNmSt로 설정
     */
    public void setOrgnNmSt(String orgnNmSt) {
        this.orgnNmSt = orgnNmSt;
    }
    
    /**
     * String userNm을 반환
     * @return String userNm
     */
    public String getUserNm() {
        return userNm;
    }
    
    /**
     * userNm을 설정
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm) {
        this.userNm = userNm;
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
    
    /**
     * int sumcount을 반환
     * @return int sumcount
     */
    public int getSumCount() {
        return sumCount;
    }
    
    /**
     * sumcount을 설정
     * @param sumcount 을(를) int sumcount로 설정
     */
    public void setSumcount(int sumCount) {
        this.sumCount = sumCount;
    }
    
    /**
     * String dmandExaminDt을 반환
     * @return String dmandExaminDt
     */
    public String getPresentnDate() {
        return presentnDate;
    }
    
    /**
     * dmandExaminDt을 설정
     * @param dmandExaminDt 을(를) String dmandExaminDt로 설정
     */
    public void setPresentnDate(String presentnDate) {
        this.presentnDate = presentnDate;
    }

    
    /**
     * int presentnCount을 반환
     * @return int presentnCount
     */
    public int getPresentnCount() {
        return presentnCount;
    }

    
    /**
     * presentnCount을 설정
     * @param presentnCount 을(를) int presentnCount로 설정
     */
    public void setPresentnCount(int presentnCount) {
        this.presentnCount = presentnCount;
    }

    
    /**
     * int userCount을 반환
     * @return int userCount
     */
    public int getSubMissionCount() {
        return subMissionCount;
    }

    
    /**
     * userCount을 설정
     * @param userCount 을(를) int userCount로 설정
     */
    public void setSubMissionCount(int subMissionCount) {
        this.subMissionCount = subMissionCount;
    }

    
    /**
     * int orgnCount을 반환
     * @return int orgnCount
     */
    public int getOrgnCount() {
        return orgnCount;
    }

    
    /**
     * orgnCount을 설정
     * @param orgnCount 을(를) int orgnCount로 설정
     */
    public void setOrgnCount(int orgnCount) {
        this.orgnCount = orgnCount;
    }


    
    /**
     * String statsTyNm을 반환
     * @return String statsTyNm
     */
    public String getStatsTyNm() {
        return statsTyNm;
    }


    
    /**
     * statsTyNm을 설정
     * @param statsTyNm 을(를) String statsTyNm로 설정
     */
    public void setStatsTyNm(String statsTyNm) {
        this.statsTyNm = statsTyNm;
    }


    
    /**
     * String totalCount을 반환
     * @return String totalCount
     */
    public String getTotalCount() {
        return totalCount;
    }


    
    /**
     * totalCount을 설정
     * @param totalCount 을(를) String totalCount로 설정
     */
    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }


    
    /**
     * String totalSys을 반환
     * @return String totalSys
     */
    public String getTotalSys() {
        return totalSys;
    }


    
    /**
     * totalSys을 설정
     * @param totalSys 을(를) String totalSys로 설정
     */
    public void setTotalSys(String totalSys) {
        this.totalSys = totalSys;
    }


    
    /**
     * String clouduseCount을 반환
     * @return String clouduseCount
     */
    public String getClouduseCount() {
        return clouduseCount;
    }


    
    /**
     * clouduseCount을 설정
     * @param clouduseCount 을(를) String clouduseCount로 설정
     */
    public void setClouduseCount(String clouduseCount) {
        this.clouduseCount = clouduseCount;
    }


    
    /**
     * String separaCount1을 반환
     * @return String separaCount1
     */
    public String getSeparaCount1() {
        return separaCount1;
    }


    
    /**
     * separaCount1을 설정
     * @param separaCount1 을(를) String separaCount1로 설정
     */
    public void setSeparaCount1(String separaCount1) {
        this.separaCount1 = separaCount1;
    }


    
    /**
     * String separaCount2을 반환
     * @return String separaCount2
     */
    public String getSeparaCount2() {
        return separaCount2;
    }


    
    /**
     * separaCount2을 설정
     * @param separaCount2 을(를) String separaCount2로 설정
     */
    public void setSeparaCount2(String separaCount2) {
        this.separaCount2 = separaCount2;
    }


    
    /**
     * String separaCount3을 반환
     * @return String separaCount3
     */
    public String getSeparaCount3() {
        return separaCount3;
    }


    
    /**
     * separaCount3을 설정
     * @param separaCount3 을(를) String separaCount3로 설정
     */
    public void setSeparaCount3(String separaCount3) {
        this.separaCount3 = separaCount3;
    }


    
    /**
     * String separatCount1을 반환
     * @return String separatCount1
     */
    public String getSeparatCount1() {
        return separatCount1;
    }


    
    /**
     * separatCount1을 설정
     * @param separatCount1 을(를) String separatCount1로 설정
     */
    public void setSeparatCount1(String separatCount1) {
        this.separatCount1 = separatCount1;
    }


    
    /**
     * String separatCount2을 반환
     * @return String separatCount2
     */
    public String getSeparatCount2() {
        return separatCount2;
    }


    
    /**
     * separatCount2을 설정
     * @param separatCount2 을(를) String separatCount2로 설정
     */
    public void setSeparatCount2(String separatCount2) {
        this.separatCount2 = separatCount2;
    }


    
    /**
     * String separatCount3을 반환
     * @return String separatCount3
     */
    public String getSeparatCount3() {
        return separatCount3;
    }


    
    /**
     * separatCount3을 설정
     * @param separatCount3 을(를) String separatCount3로 설정
     */
    public void setSeparatCount3(String separatCount3) {
        this.separatCount3 = separatCount3;
    }


    
    /**
     * String separatCount4을 반환
     * @return String separatCount4
     */
    public String getSeparatCount4() {
        return separatCount4;
    }


    
    /**
     * separatCount4을 설정
     * @param separatCount4 을(를) String separatCount4로 설정
     */
    public void setSeparatCount4(String separatCount4) {
        this.separatCount4 = separatCount4;
    }


    
    /**
     * String dmandSurveyBudget을 반환
     * @return String dmandSurveyBudget
     */
    public String getDmandSurveyBudget() {
        return dmandSurveyBudget;
    }


    
    /**
     * dmandSurveyBudget을 설정
     * @param dmandSurveyBudget 을(를) String dmandSurveyBudget로 설정
     */
    public void setDmandSurveyBudget(String dmandSurveyBudget) {
        this.dmandSurveyBudget = dmandSurveyBudget;
    }


    
    /**
     * String planCount1을 반환
     * @return String planCount1
     */
    public String getPlanCount1() {
        return planCount1;
    }


    
    /**
     * planCount1을 설정
     * @param planCount1 을(를) String planCount1로 설정
     */
    public void setPlanCount1(String planCount1) {
        this.planCount1 = planCount1;
    }


    
    /**
     * String planCount2을 반환
     * @return String planCount2
     */
    public String getPlanCount2() {
        return planCount2;
    }


    
    /**
     * planCount2을 설정
     * @param planCount2 을(를) String planCount2로 설정
     */
    public void setPlanCount2(String planCount2) {
        this.planCount2 = planCount2;
    }


    
    /**
     * String planCount3을 반환
     * @return String planCount3
     */
    public String getPlanCount3() {
        return planCount3;
    }


    
    /**
     * planCount3을 설정
     * @param planCount3 을(를) String planCount3로 설정
     */
    public void setPlanCount3(String planCount3) {
        this.planCount3 = planCount3;
    }

    
    
    
    /**
     * String indexNo을 반환
     * @return String indexNo
     */
    public String getRowNumb() {
        return rowNumb;
    }


    
    /**
     * indexNo을 설정
     * @param indexNo 을(를) String indexNo로 설정
     */
    public void setRowNumb(String rowNumb) {
        this.rowNumb = rowNumb;
    }


    /**
     * String buseoCodeNm을 반환
     * @return String buseoCodeNm
     */
    public String getBuseoCodeNm() {
        return buseoCodeNm;
    }


    
    /**
     * buseoCodeNm을 설정
     * @param buseoCodeNm 을(를) String buseoCodeNm로 설정
     */
    public void setBuseoCodeNm(String buseoCodeNm) {
        this.buseoCodeNm = buseoCodeNm;
    }


    
    /**
     * String subMission을 반환
     * @return String subMission
     */
    public String getSubMission() {
        return subMission;
    }


    
    /**
     * subMission을 설정
     * @param subMission 을(를) String subMission로 설정
     */
    public void setSubMission(String subMission) {
        this.subMission = subMission;
    }


    
    /**
     * String unSubMission을 반환
     * @return String unSubMission
     */
    public String getUnSubMission() {
        int SunMission = Integer.valueOf(getSubMission());
        int orgnCount = Integer.valueOf(getOrgnCount());

        return String.valueOf(orgnCount - SunMission);
    }


    
    /**
     * String subMissionRate을 반환
     * @return String subMissionRate
     */
    public String getSubMissionRate() {
        return subMissionRate;
    }


    
    /**
     * subMissionRate을 설정
     * @param subMissionRate 을(를) String subMissionRate로 설정
     */
    public void setSubMissionRate(String subMissionRate) {
        this.subMissionRate = subMissionRate;
    }


    
    /**
     * String subMissionRate2을 반환
     * @return String subMissionRate2
     */
    public String getSubMissionRate2() {
        return subMissionRate2;
    }


    
    /**
     * subMissionRate2을 설정
     * @param subMissionRate2 을(를) String subMissionRate2로 설정
     */
    public void setSubMissionRate2(String subMissionRate2) {
        this.subMissionRate2 = subMissionRate2;
    }


    
    /**
     * String separaCount4을 반환
     * @return String separaCount4
     */
    public String getSeparaCount4() {
        return separaCount4;
    }


    
    /**
     * separaCount4을 설정
     * @param separaCount4 을(를) String separaCount4로 설정
     */
    public void setSeparaCount4(String separaCount4) {
        this.separaCount4 = separaCount4;
    }


    
    /**
     * String separatCount5을 반환
     * @return String separatCount5
     */
    public String getSeparatCount5() {
        return separatCount5;
    }


    
    /**
     * separatCount5을 설정
     * @param separatCount5 을(를) String separatCount5로 설정
     */
    public void setSeparatCount5(String separatCount5) {
        this.separatCount5 = separatCount5;
    }


    
    /**
     * String separatCount6을 반환
     * @return String separatCount6
     */
    public String getSeparatCount6() {
        return separatCount6;
    }


    
    /**
     * separatCount6을 설정
     * @param separatCount6 을(를) String separatCount6로 설정
     */
    public void setSeparatCount6(String separatCount6) {
        this.separatCount6 = separatCount6;
    }


    
    /**
     * String separatCount7을 반환
     * @return String separatCount7
     */
    public String getSeparatCount7() {
        return separatCount7;
    }


    
    /**
     * separatCount7을 설정
     * @param separatCount7 을(를) String separatCount7로 설정
     */
    public void setSeparatCount7(String separatCount7) {
        this.separatCount7 = separatCount7;
    }


    
    /**
     * String buseoCode을 반환
     * @return String buseoCode
     */
    public String getBuseoCode() {
        return buseoCode;
    }


    
    /**
     * buseoCode을 설정
     * @param buseoCode 을(를) String buseoCode로 설정
     */
    public void setBuseoCode(String buseoCode) {
        this.buseoCode = buseoCode;
    }    
    
    
}