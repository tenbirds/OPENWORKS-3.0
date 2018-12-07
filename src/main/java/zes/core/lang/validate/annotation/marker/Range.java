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
import zes.core.lang.validate.validator.impl.RangeValidator;

/**
 * 숫자 값의 크기를 확인. 최소 기본값은 0
 * 
 * <pre>
 * 사용 예)
 * &#64;Range(min=3, max=20) 3~20 사이의 숫자 값
 * &#64;Range(max=20) 20 이하의 숫자 값
 * 기본값
 * max() 최대 필수
 * min() 최소 기본값 0
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
 *  2012. 3. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(value = { ElementType.METHOD, ElementType.FIELD })
@Documented
@ValidatorInfo(validatorName = "range", validator = RangeValidator.class)
public @interface Range {

    /**
     * 오류 메시지 설정
     * 
     * @return
     */
    String message() default "숫자값을 입력하세요.({0}~{1}사이)";

    /**
     * 최소크기
     * 
     * @return
     */
    int min() default 0;

    /**
     * 최대크기
     * 
     * @return
     */
    int max();
}
