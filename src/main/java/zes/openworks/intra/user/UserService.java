/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user;

import java.util.List;
import java.util.Map;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.user.coLog.UserLogVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface UserService {

    /**
     * 개인회원정보 목록
     * 
     * @param vo
     * @return
     */
    Pager<UserVO> userList(UserVO vo);

    /**
     * 회원 정보 삭제 액션
     */
    Map<String, Integer> deleteAction(UserVO vo);
    
    /**
     * 회원정보 등록액션
     * 
     * @param vo
     * @return
     */
    int insertAction(UserVO vo);
    
    /**
     * 회원정보 등록액션
     * 
     * @param vo
     * @return
     */
    int updateAction(UserVO vo);

    /**
     * 개인회원정보 등록액션
     * 
     * @param vo
     * @return
     */
//    int pInsertAction(UserVO vo);

    /**
     * 개인회원 추가정보 등록액션
     * 
     * @param vo
     * @return
     */
    int pOptionInsertAction(UserVO vo);

    /**
     * 회원(개인 & 기업) 상세보기
     * 
     * @param vo
     * @return
     */
    UserVO userForm(UserVO vo);
    
    /**
     * 회원(개인 & 기업) 상세보기
     * 
     * @param vo
     * @return
     */
    int fileDelete(FileVO vo);

    /**
     * 개인회원 상세보기
     * 
     * @param vo
     * @return
     */
    UserVO pUpdateForm(UserVO vo);

    /**
     * 개인회원정보 수정액션
     * 
     * @param vo
     * @return
     */
    int pUpdateAction(UserVO vo);

    /**
     * 개인회원 상세보기
     * 
     * @param vo
     * @return
     */
    UserVO pOptionUpdateForm(UserVO vo);

    /**
     * 개인회원 추가정보 수정액션
     * 
     * @param vo
     * @return
     */
    int pOptionUpdateAction(UserVO vo);

    /**
     * ID로 비밀번호 가져오기
     * 
     * @param vo
     * @return
     */
    Object selectUserPwd(UserLogVO lvo);
    
    /**
     * 비밀번호 수정
     * 
     * @param vo
     * @return
     */
    int passwordUpdateAction(UserVO vo);

    /**
     * 사용자 ID 체크
     * 
     * @param vo
     * @return
     */
    int checkDupleId(UserVO vo);

    /**
     * 공통이력관리 액션
     * 
     * @param vo
     */
    Object userLogInsertAction(UserLogVO vo);

    /**
     * userListCExcel 설명
     * 
     * @param vo
     * @return
     */
    List<UserVO> userListCExcel(UserVO vo);

    /**
     * userListSExcel 설명
     * 
     * @param vo
     * @return
     */
    List<UserVO> userListSExcel(UserVO vo);

    /**
     * UserCount 설명
     * 
     * @param vo
     * @return
     */
    Object userCount(UserVO vo);

    /**
     * checkUserListExel 설명
     * 
     * @param vo
     * @return
     */
    Object pUserSetYn(UserVO vo);

    /**
     * cpUserSetYn 설명
     * 
     * @param vo
     * @return
     */
    Object cpUserSetYn(UserVO vo);
    
    /**
     * pblUserSetYn 설명
     * 
     * @param vo
     * @return
     */
    Object pblUserSetYn(UserVO vo);
    
    /**
     * storeSetYn 설명
     * 
     * @param vo
     * @return
     */
    Object storeSetYn(UserVO vo);

    /**
     * userGradeList 설명
     * 
     * @param vo
     * @return
     */
    List<UserVO> userGradeList(UserVO vo);

    Integer checkDupleStoreNm(UserVO vo);

    Integer selectUserTyCd(UserVO vo);

    int emailDupleCheck(UserVO vo);

    List<Map<String, Object>> userNation(UserVO vo);

    Integer checkDupleBizrno(UserVO vo);

    List<Map<String, Object>> continentList();

    Integer checkStoreSales(UserVO vo);

    /**
     * userDrmncyList 설명
     * @param vo
     * @return
     */
    Pager<UserVO> userDrmncyList(UserVO vo);
}