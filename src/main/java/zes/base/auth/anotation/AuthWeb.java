/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.auth.anotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import zes.base.auth.AuthType;

/**
 * 메소드별 권한 인증 타입
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
 *  2012. 2. 29.    방기배   신규 추가
 * </pre>
 * @see
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
public @interface AuthWeb {

    /**
     * 대상 메소드에 적용되는 권한 유형
     * 
     * @return LIST, VIEW, CREATE, UPDATE, DELETE for AuthTypeEnum
     * @see AuthType
     */
    AuthType authType();

    /**
     * 권한 구분을 위한 파라미터가 사용되는 경우 파라미터를 등록
     * <p />
     * 예) 게시판을 구분 하기 위한 bbsCd=코드 인 경우 bbsCd를 설정<br />
     * 또한 복수의 파라미터가 더 사용된다면 {"bbsCd","bbsType"} 와 같이 배열로 사용한다.
     * 
     * @return
     */
    String[] authParams() default {};
}
