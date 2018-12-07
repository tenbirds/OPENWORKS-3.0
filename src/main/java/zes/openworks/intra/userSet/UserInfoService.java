/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.userSet;

import java.util.List;
import java.util.Map;

/**
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface UserInfoService {

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 SELECT
     * 
     * @param
     * @return List<UserInfoVO>
     */
    List<UserInfoVO> userInfoList(UserInfoVO vo);

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 개인 & 사업자별 공공기관 추가COUNT
     * 
     * @param
     * @return UserInfoVO
     */
    UserInfoVO userInfoCount(UserInfoVO vo);

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 사용여부 코드 네임
     * 
     * @param
     * @return List<UserInfoVO>
     */
    List<UserInfoVO> getUseYnNameList();

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 수정
     * 
     * @param
     * @return Integer
     */
    int userInfoSetUpdate(UserInfoVO vo);

    /**
     * 회원 가입정보 설정 회원 선택 여부
     * 
     * @param
     * @return Map<String, String>
     */
    Map<String, String> userSelect();

    /**
     * 회원 가입정보 설정 회원 선택 여부 수정
     * 
     * @param
     * @return Integer
     */
    int userSelectUpdate(String[] str);

    /**
     * 관심항목 리스트
     * 
     * @param
     * @return List<UserInfoVO>
     */
    List<UserInfoVO> interestItemList(UserInfoVO vo);

    /**
     * 관심항목 리스트 개인 | 사업자별 COUNT
     * 
     * @param
     * @return UserInfoVO
     */
    UserInfoVO interestItemCount();

    /**
     * 관심항목 등록
     * 
     * @param
     * @return Integer
     */
    int interestInsert(UserInfoVO vo);

    /**
     * 관심항목 개인 | 사업자별 수정
     * 
     * @param
     * @return Integer
     */
    int interestUpdate(UserInfoVO vo);

    /**
     * 관심항목 삭제
     * 
     * @param
     * @return Integer
     */
    int interestDelete(UserInfoVO vo);

    /**
     * 가입정보 변경 이력 사항 LIST
     * 
     * @param
     * @return List<UserInfoVO>
     */
    List<UserInfoVO> setLogList();

    /**
     * 가입정보 변경 이력 사항 등록
     * 
     * @param
     * @return void
     */
    void userInfoSetLog(UserInfoVO vo);

    /**
     * 관심항목 등록,수정,삭제 이력사항 등록
     * 
     * @param
     * @return void
     */
    void interestSetLog(UserInfoVO vo);
}
