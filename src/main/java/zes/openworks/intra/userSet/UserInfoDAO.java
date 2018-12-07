/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.userSet;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
@Repository
@SuppressWarnings("unchecked")
public class UserInfoDAO extends EgovAbstractMapper {

    /**
     * 회원가입정보설정 기본 항목 화면 LIST
     * 
     * @param
     * @return List<UserInfoVO>
     */
    public List<UserInfoVO> userInfoList(UserInfoVO vo) {
        return list("_userInfo.userInfoList", String.valueOf(vo.getIemTy()));
    }

    /**
     * 회원가입정보설정 기본 항목 화면 COUNT
     * 
     * @param
     * @return UserInfoVO
     */
    public UserInfoVO userInfoCount(UserInfoVO vo) {
        return (UserInfoVO) selectByPk("_userInfo.userInfoCount", String.valueOf(vo.getIemTy()));
    }

    /**
     * 회원가입정보설정 사용여부 코드 LIST
     * 
     * @param
     * @return List<UserInfoVO>
     */
    public List<UserInfoVO> getUseYnNameList() {
        return list("_userInfo.useYnCodeList", null);
    }

    /**
     * 회원가입정보설정 회원 선택 여부
     * 
     * @param
     * @return Map<String, String>
     */
    public Map<String, String> userSelect() {
        Map<String, String> map = new HashMap<String, String>();
        List<UserInfoVO> list = list("_userInfo.userSelect", null);

        for(UserInfoVO vo : list) {
            map.put(vo.getUserTy(), vo.getIemTy());
        }

        return map;
    }

    /**
     * 회원가입정보설정 기본 항목 화면 수정
     * 
     * @param
     * @return Integer
     */
    public int userInfoSetUpdate(UserInfoVO vo) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        String[] iCode = vo.getParamItemCodes();
        String[] uCode = vo.getParamUseYnCodes();

        int affected = 0;

        for(int i = 0 ; i < iCode.length ; i++) {
            map.put("iCode", Integer.parseInt(iCode[i]));
            map.put("uCode", Integer.parseInt(uCode[i]));
            affected = update("_userInfo.updateInfo", map);
        }

        return affected;
    }

    /**
     * 회원 가입정보 설정 회원 선택 여부 수정
     * 
     * @param
     * @return Integer
     */
    public int userSelectUpdate(String[] str) {

        UserInfoVO vo = new UserInfoVO();
        int affected = 0;
        for(int i = 0 ; i < str.length ; i++) {
            if(i == 0) {
                vo.setIemCd(1000);
            } else if (i == 1){
                vo.setIemCd(2000);
            } else if (i == 2){
                vo.setIemCd(3000);
            }
            vo.setIemTy(str[i]);
            affected = update("_userInfo.updateUserSelect", vo);
        }
        return affected;
    }

    /**
     * 회원가입정보설정 관심항목 LIST
     * 
     * @param
     * @return List<UserInfoVO>
     */
    public List<UserInfoVO> interestItemList(UserInfoVO vo) {
        return list("_userInfo.selectInterestItem", null);
    }

    /**
     * 회원가입정보설정 관심항목 COUNT
     * 
     * @param
     * @return UserInfoVO
     */
    public UserInfoVO interestItemCount() {
        return (UserInfoVO) selectByPk("_userInfo.interestItemCount", null);
    }

    /**
     * 회원가입정보설정 관심항목 추가
     * 
     * @param
     * @return Integer
     */
    public int interestInsert(UserInfoVO vo) {
        int affected = update("_userInfo.insertInterestItem", vo);

        return affected;
    }

    /**
     * 회원가입정보설정 관심항목 수정
     * 
     * @param
     * @return Integer
     */
    public int interestUpdate(UserInfoVO vo) {
        int affected = 0;

        affected = update("_userInfo.updateInterestItem", vo);

        return affected;
    }

    /**
     * 회원가입정보설정 관심항목 삭제
     * 
     * @param
     * @return Integer
     */
    public int interestDelete(UserInfoVO vo) {
        int affected = delete("_userInfo.deleteInterestItem", vo);

        return affected;
    }

    /**
     * 회원가입정보설정 변경 이력사항 LIST
     * 
     * @param
     * @return void
     */
    public void insertLog(UserInfoVO vo) {
        insert("_userInfo.insertLog", vo);
    }

    /**
     * 회원가입정보설정 변경 이력사항 등록
     * 
     * @param
     * @return List<UserInfoVO>
     */
    public List<UserInfoVO> setLogList() {
        return list("_userInfo.logList", null);
    }

}
