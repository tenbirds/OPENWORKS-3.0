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
import zes.core.lang.validate.annotation.marker.NoWhiteSpace;
import zes.core.lang.validate.validator.AbstractValidator;
import zes.core.lang.validate.validator.Validator;

/**
 * 공백 문자가 포함되지 않았다면 true
 * <p />
 * * WhiteSpace 존재여부 확인(blank 및 개행문자) " ", "\t", "\n", "\r", "\n\r", "\r\n"
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
public class NoWhiteSpaceValidator extends AbstractValidator {

    @Override
    public Validator setAnnotation(Annotation annotation) {

        NoWhiteSpace anno = (NoWhiteSpace) annotation;
        this.message = anno.message();

        return this;
    }

    /**
     * WhiteSpace 존재여부 확인(blank 및 개행문자)
     * " ", "\t", "\n", "\r", "\n\r", "\r\n"
     */
    @Override
    protected boolean doValidate(Object propertyValue) {

        if(null == propertyValue || propertyValue.toString().length() == 0) {
            return true;
        }

        String value = propertyValue.toString();

        return Validate.isNoWhiteSpace(value);
    }

}
