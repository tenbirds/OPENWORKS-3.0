/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.grade;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 회원 등급관리 DAO
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
 *  2012. 6. 18.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class UserGradeDAO extends EgovAbstractMapper {

    /**
     * 회원 등급 목록
     */
    @SuppressWarnings("unchecked")
    public List<UserGradeVO> getUserGradeList(UserGradeVO userGradeVo) throws Exception {

        return list("intra.user.grade.getUserGradeList", userGradeVo);
    }

    /**
     * 회원 등급 상세
     */
    public UserGradeVO getUserGrade(UserGradeVO userGradeVo) throws Exception {

        userGradeVo = (UserGradeVO) selectByPk("intra.user.grade.getUserGrade", userGradeVo);

        return userGradeVo;
    }

    /**
     * 회원 등급 등록
     */
    public Object insertUserGrade(UserGradeVO userGradeVo) throws Exception {

        // 회원 등급 등록
        Object key = insert("intra.user.grade.insertUserGrade", userGradeVo);

        return key;
    }

    /**
     * 회원 등급 수정
     */
    public int updateUserGrade(UserGradeVO userGradeVo) throws Exception {

        return update("intra.user.grade.updateUserGrade", userGradeVo);
    }

    /**
     * 회원 등급 삭제
     */
    public int deleteUserGrade(UserGradeVO userGradeVo) throws Exception {

        return delete("intra.user.grade.deleteUserGrade", userGradeVo);
    }

}
