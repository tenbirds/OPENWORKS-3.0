/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.auth;

/**
 * 권한 설정 목록
 * <p />
 * READ : 조회, BASIC : 기본(mine 조회+등록+수정+삭제), GENERALIZE : 총괄(mine + other
 * 조회+등록+수정+삭제)
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
 *  2012. 2. 29.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public enum AuthType {
    // 순서대로 조회, 본인컨텐츠, 관리자. 클레스 설명 참조
    READ("R"), BASIC("A"), GENERALIZE("G");

    AuthType(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    private String code;
}
