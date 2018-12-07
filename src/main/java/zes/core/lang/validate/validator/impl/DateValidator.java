/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.validator.impl;

import java.lang.annotation.Annotation;

import zes.core.lang.Validate;
import zes.core.lang.validate.annotation.marker.Date;
import zes.core.lang.validate.validator.AbstractValidator;
import zes.core.lang.validate.validator.Validator;

/**
 * 지정된 날짜 포멧과 일치 하는지 확인한다.
 * <p />
 * 길이가 같은지 우선 체크한 후 년월일을 각각 파싱하여 <code>Calendar</code> 클레스를 통하여 유효한 날짜인지 확인한다.
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 2.    방기배   신규 추가
 * </pre>
 * @see
 */
public class DateValidator extends AbstractValidator {

    /** 날짜 포멧 */
    private String pattern;

    @Override
    public Validator setAnnotation(Annotation annotation) {

        Date anno = (Date) annotation;
        this.message = anno.message();
        this.pattern = anno.pattern();
        // 메시지 포멧용 데이터 설정
        this.validData = new String[] { "\'" + this.pattern + "\'" };

        return this;
    }

    /**
     * 지정된 날짜 포멧 패턴과 입력 값을 비교하여 패턴에 적합한지 확인
     */
    @Override
    protected boolean doValidate(Object propertyValue) {

        if(null == propertyValue || propertyValue.toString().length() == 0) {
            return true;
        }

        String value = propertyValue.toString();

        return Validate.isEqualsDataFormat(value, pattern);
    }

}
