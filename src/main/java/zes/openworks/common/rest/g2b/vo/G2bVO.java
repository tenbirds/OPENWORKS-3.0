/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b.vo;

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
 *  2014. 12. 11.    이슬버미       신규
 * </pre>
 * @see
 */
public class G2bVO extends PaggingVO{

    /**  */
    private static final long serialVersionUID = -660860388794612146L;
    
    
    /* 한 페이지 결과 수 */
    private String numOfRows;
    /* 페이지 번호 */
    private String pageNo;
    /* 조회날짜(시작) */
    private String sDate;
    /* 조회날짜(끝) */
    private String eDate;
    /* 발주기관 */
    private String orderCode;
    /* 수요기관명 */
    private String demandCode;
    /* 공고/개찰일 : 0/1 */
    private String dateType;
    /* 계약기관명 */
    private String contractNum;
    /* 수요기관명 */
    private String demandNum;

    /**
     * String numOfRows을 반환
     * 
     * @return String numOfRows
     */
    public String getNumOfRows() {
        return numOfRows;
    }

    /**
     * numOfRows을 설정
     * 
     * @param numOfRows 을(를) String numOfRows로 설정
     */
    public void setNumOfRows(String numOfRows) {
        this.numOfRows = numOfRows;
    }

    /**
     * String pageNo을 반환
     * 
     * @return String pageNo
     */
    public String getPageNo() {
        return pageNo;
    }

    /**
     * pageNo을 설정
     * 
     * @param pageNo 을(를) String pageNo로 설정
     */
    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    /**
     * String sDate을 반환
     * 
     * @return String sDate
     */
    public String getsDate() {
        return sDate;
    }

    /**
     * sDate을 설정
     * 
     * @param sDate 을(를) String sDate로 설정
     */
    public void setsDate(String sDate) {
        this.sDate = sDate;
    }

    /**
     * String eDate을 반환
     * 
     * @return String eDate
     */
    public String geteDate() {
        return eDate;
    }

    /**
     * eDate을 설정
     * 
     * @param eDate 을(를) String eDate로 설정
     */
    public void seteDate(String eDate) {
        this.eDate = eDate;
    }

    /**
     * String orderCode을 반환
     * 
     * @return String orderCode
     */
    public String getOrderCode() {
        return orderCode;
    }

    /**
     * orderCode을 설정
     * 
     * @param orderCode 을(를) String orderCode로 설정
     */
    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    /**
     * String demandCode을 반환
     * 
     * @return String demandCode
     */
    public String getDemandCode() {
        return demandCode;
    }

    /**
     * demandCode을 설정
     * 
     * @param demandCode 을(를) String demandCode로 설정
     */
    public void setDemandCode(String demandCode) {
        this.demandCode = demandCode;
    }

    /**
     * String dateType을 반환
     * 
     * @return String dateType
     */
    public String getDateType() {
        return dateType;
    }

    /**
     * dateType을 설정
     * 
     * @param dateType 을(를) String dateType로 설정
     */
    public void setDateType(String dateType) {
        this.dateType = dateType;
    }

    /**
     * String contractNum을 반환
     * 
     * @return String contractNum
     */
    public String getContractNum() {
        return contractNum;
    }

    /**
     * contractNum을 설정
     * 
     * @param contractNum 을(를) String contractNum로 설정
     */
    public void setContractNum(String contractNum) {
        this.contractNum = contractNum;
    }

    /**
     * String demandNum을 반환
     * 
     * @return String demandNum
     */
    public String getDemandNum() {
        return demandNum;
    }

    /**
     * demandNum을 설정
     * 
     * @param demandNum 을(를) String demandNum로 설정
     */
    public void setDemandNum(String demandNum) {
        this.demandNum = demandNum;
    }

}
