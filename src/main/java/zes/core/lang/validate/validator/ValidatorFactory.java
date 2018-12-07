/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.validator;

import java.lang.annotation.Annotation;

import zes.core.lang.validate.annotation.ValidatorInfo;

/**
 * Annotation Type에 따른 검증기를 반환한다.
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
 *  2012. 3. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ValidatorFactory {

    /**
     * <code>Annotation</code> 타입에 따른 <code>Validator</code> 반환
     * 
     * @param annotation
     * @return
     */
    public static Validator getInstance(Annotation annotation, Object obj) {

        ValidatorInfo type = annotation.annotationType().getAnnotation(ValidatorInfo.class);
        Validator validator = null;

        try {

            validator = type.validator().newInstance();
            validator.setValidatorName(type.validatorName()).setAnnotation(annotation).setObject(obj);

        } catch (Exception e) {
            // do nothing
        }

        return validator;
    }
}
