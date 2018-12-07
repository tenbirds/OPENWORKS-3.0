/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.grade;

import java.util.List;

/**
 * 회원 등급관리 서비스객체 인터페이스
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
 *  2012. 6. 18.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface UserGradeService {

    /**
     * 회원 등급 상세
     * 
     * @param userGradeVo
     * @return
     */
    UserGradeVO getUserGrade(UserGradeVO userGradeVo) throws Exception;

    /**
     * 회원 등급 목록
     * 
     * @param userGradeVo
     * @return
     */
    List<UserGradeVO> getUserGradeList(UserGradeVO userGradeVo) throws Exception;

    /**
     * 회원 등급정보 등록
     * 
     * @param userGradeVo
     * @return
     */
    Object insertUserGrade(UserGradeVO userGradeVo) throws Exception;

    /**
     * 회원 등급정보 수정
     * 
     * @param userGradeVo
     * @return
     */
    int updateUserGrade(UserGradeVO userGradeVo) throws Exception;

    /**
     * 회원 등급 삭제
     * 
     * @param userGradeVo
     * @return
     */
    int deleteUserGrade(UserGradeVO userGradeVo) throws Exception;

}
