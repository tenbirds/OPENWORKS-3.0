/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDtls;

/**
 * @version 1.0
 * @since
 * @author
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2017. 9. 08.    최강식   신규작성
 * </pre>
 * @see
 */
public class DmandExaminRegistMngrVO {
    
    /*수요조사년도*/
    private String dmandExaminOprtnYear;
    /*수요조사 작성시작일자*/
    private String registBeginDate;
    /*수요조사 작성종료일자*/
    private String registEndDate;
    /*사용여부*/
    private String useYn;
    
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
     * String useYn을 반환
     * @return String useYn
     */
    public String getUseYn() {
        return useYn;
    }
    
    /**
     * useYn을 설정
     * @param useYn 을(를) String useYn로 설정
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    
}