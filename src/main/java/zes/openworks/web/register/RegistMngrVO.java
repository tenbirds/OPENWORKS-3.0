/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;


/**
 * 
 *
 * @version 1.0
 * @since openworks-3.0 프로젝트. (After JDK 1.7)
 * @author 김찬서
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 9. 12.    김찬서       신규
 *</pre>
 * @see
 */
public class RegistMngrVO {
    
    /*수요조사 실시년도*/
    private String dmandExaminOptnYear;
    /*수요조사 시작 날짜*/
    private String registBeginDate;
    /*수요조사 종료 날짜*/
    private String registEndDate;
    /*사용유무*/
    private String useYn;
    /*현재날짜*/
    private String currentDate;
    
    public String getDmandExaminOptnYear() {
        return dmandExaminOptnYear;
    }

    public void setDmandExaminOptnYear(String dmandExaminOptnYear) {
        this.dmandExaminOptnYear = dmandExaminOptnYear;
    }
    
    public String getRegistBeginDate() {
        return registBeginDate;
    }
    
    public void setRegistBeginDate(String registBeginDate) {
        this.registBeginDate = registBeginDate;
    }
    
    public String getRegistEndDate() {
        return registEndDate;
    }
    
    public void setRegistEndDate(String registEndDate) {
        this.registEndDate = registEndDate;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(String currentDate) {
        this.currentDate = currentDate;
    }
    
}
