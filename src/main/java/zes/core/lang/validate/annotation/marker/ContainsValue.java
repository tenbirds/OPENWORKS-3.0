/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.annotation.marker;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import zes.core.lang.validate.annotation.ValidatorInfo;
import zes.core.lang.validate.validator.impl.ContainsValueValidator;

/**
 * 비교대상 값(배열)을 설정하여 입력된 값이 비교대상 값 중에 있는지를 확인
 * <p />
 * 사용 예)
 * 
 * <pre>
 * &#64;CompareValue(compareValues={"A", "B", "1"})
 * </pre>
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
@Retention(RetentionPolicy.RUNTIME)
@Target(value = { ElementType.METHOD, ElementType.FIELD })
@Documented
@ValidatorInfo(validatorName = "contains", validator = ContainsValueValidator.class)
public @interface ContainsValue {

    /**
     * 오류 메시지 설정
     * 
     * @return
     */
    String message() default "지정된 값을 입력하세요.({0})";

    /**
     * 비교 대상 값(배열)
     * 
     * @return
     */
    String[] compareValues() default {};
}
