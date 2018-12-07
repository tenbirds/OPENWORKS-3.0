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
import zes.core.lang.validate.validator.impl.RequireFromValidator;

/**
 * 대상 필드가 <code>null</code>이 아닌 경우 필수
 * <p />
 * 
 * <pre>
 * 사용 예)
 * @RegExp(regexp="[a-zA-Z]+")  영문 확인시.
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
@ValidatorInfo(validatorName = "requirefrom", validator = RequireFromValidator.class)
public @interface RequireFrom {

    /**
     * 오류 메시지 설정
     * 
     * @return
     */
    String message() default "{2} 선택시 필수 입력항목 입니다.";

    /**
     * 대상 필드명
     * 
     * @return
     */
    String fieldName();

    /**
     * 대상 필드 값
     * 
     * @return
     */
    String fieldValue();

    /**
     * 대상 필드의 한글 명칭(메시지 포멧 용)
     * 
     * @return
     */
    String fieldDesc();
}
