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
import zes.core.lang.validate.annotation.marker.Pattern;
import zes.core.lang.validate.validator.AbstractValidator;
import zes.core.lang.validate.validator.Validator;

/**
 * 문자열을 정규표현식을 통하여 검증
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
 *  2012. 3. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class PatternValidator extends AbstractValidator {

    /** 정규표현식 */
    private String regexp;

    @Override
    public Validator setAnnotation(Annotation annotation) {

        Pattern anno = (Pattern) annotation;
        this.message = anno.message();
        this.regexp = anno.regexp();
        // 메시지 포멧용 데이터 설정
        this.validData = new String[] { this.regexp };

        return this;
    }

    /**
     * 문자열이 정규 표현식에 일치 하는지 검증
     */
    @Override
    protected boolean doValidate(Object propertyValue) {

        if(null == propertyValue || propertyValue.toString().length() == 0) {
            return true;
        }

        String value = propertyValue.toString();

        return Validate.isRegExpMatch(value, regexp);
    }

}
