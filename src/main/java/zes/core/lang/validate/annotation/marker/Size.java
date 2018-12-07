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
import zes.core.lang.validate.validator.impl.SizeValidator;

/**
 * Collection 또는 배열 값의 길이(length 또는 size)를 확인
 * <p />
 * 
 * <pre>
 * 사용 예)
 * &#64;Size(min=3, max=20) 3~20 사이 크기
 * &#64;Size(min=3) 3 이상의 크기
 * &#64;Size(max=20) 20 이하의 크기
 * 
 * 기본값
 * min() 최소길이 기본값 0
 * max() 최대길이 필수
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
@ValidatorInfo(validatorName = "rangelength", validator = SizeValidator.class)
public @interface Size {

    /**
     * 오류 메시지 설정
     * 
     * @return
     */
    String message() default "범위내로 선택하세요.({0}~{1})";

    /**
     * 최소길이
     * 
     * @return
     */
    int min() default 0;

    /**
     * 최대길이
     * 
     * @return
     */
    int max();
}
