/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import zes.core.lang.validate.validator.Validator;

/**
 * <code>Annotation</code> 기반 <code>Validator</code> 설정
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
@Target({ ElementType.ANNOTATION_TYPE })
@Documented
public @interface ValidatorInfo {

    /**
     * <code>Validator</code> 명칭
     * 
     * @return <code>Validator</code> 명칭 반환
     */
    public String validatorName();

    /**
     * <code>Validator</code> 설정
     * 
     * @return <code>Validator</code> 반환
     */
    public Class<? extends Validator> validator();

    /**
     * 검증 결과 메시지
     * 
     * @return
     */
    public String message() default "";
}
