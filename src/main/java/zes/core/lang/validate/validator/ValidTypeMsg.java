/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.validator;

import java.io.Serializable;

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
 *  2012. 3. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ValidTypeMsg implements Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = -3470278207396902613L;

    /** 검증 유형 명 */
    private String validType;

    /** 검증 오류 메시지 */
    private String validMsg;

    /** 포멧팅용 데이터 */
    private String[] validData = new String[3];

    /**
     * String validType을 반환
     * 
     * @return String validType
     */
    public String getValidType() {
        return validType;
    }

    /**
     * validType을 설정
     * 
     * @param validType 을(를) String validType로 설정
     */
    public void setValidType(String validType) {
        this.validType = validType;
    }

    /**
     * String validMsg을 반환
     * 
     * @return String validMsg
     */
    public String getValidMsg() {
        return validMsg;
    }

    /**
     * validMsg을 설정
     * 
     * @param validMsg 을(를) String validMsg로 설정
     */
    public void setValidMsg(String validMsg) {
        this.validMsg = validMsg;
    }

    /**
     * String[] validData을 반환
     * 
     * @return String[] validData
     */
    public String[] getValidData() {
        return validData;
    }

    /**
     * validData 설정
     * 
     * @param validData 을(를) String[] validData 설정
     */
    public void setValidData(String[] validData) {
        this.validData = validData;
    }
}
