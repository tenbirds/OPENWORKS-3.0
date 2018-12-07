/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.validator.impl;

import java.lang.annotation.Annotation;
import java.util.Arrays;

import zes.core.lang.Validate;
import zes.core.lang.validate.annotation.marker.ContainsValue;
import zes.core.lang.validate.validator.AbstractValidator;
import zes.core.lang.validate.validator.Validator;

/**
 * 주어진 값(배열)들 중에 같은 값이 있는지 확인
 * < p/>
 * 입력 값은 <code>String</code>과 <code>String[]</code> 배열 <code>Integer</code>와
 * <code>Integer[]</code> 배열 <code>Collection</code> 타입을 을 검사할 수 있다.
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
public class ContainsValueValidator extends AbstractValidator {

    /** 비교 대상 값 */
    private String[] compareValues;

    @Override
    public Validator setAnnotation(Annotation annotation) {

        ContainsValue anno = (ContainsValue) annotation;
        this.message = anno.message();
        this.compareValues = anno.compareValues();
        // 메시지 포멧용 데이터 설정
        this.validData = new String[] { Arrays.toString(this.compareValues) };

        return this;
    }

    /**
     * 제시된 비교 대상 값(배열)과 입력 값을 비교하여 비교 값이 존재하는지 확인
     */
    @Override
    protected boolean doValidate(Object propertyValue) {

        if(null == propertyValue || propertyValue.toString().length() == 0) {
            return true;
        }

        return Validate.isContainsValue(propertyValue, compareValues);
    }

}
