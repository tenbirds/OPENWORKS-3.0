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
import zes.core.lang.validate.validator.impl.MaxLengthValidator;

/**
 * 문자열 값의 길이를 확인
 * <p/>
 * max=3 인 경우 "1234" : false, "12" : true
 * 
 * <pre>
 * 사용 예)
 * &#64;MaxLength(max=20)
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
 *  2012. 3. 2.    방기배   신규 추가
 * </pre>
 * @see
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(value = { ElementType.METHOD, ElementType.FIELD })
@Documented
@ValidatorInfo(validatorName = "maxlength", validator = MaxLengthValidator.class)
public @interface MaxLength {

    /**
     * 오류 메시지 설정
     * 
     * @return
     */
    String message() default "최대 길이에 맞게 입력하세요. ({0}자)";

    /**
     * 최대길이
     * 
     * @return
     */
    int max() default -1;
}
