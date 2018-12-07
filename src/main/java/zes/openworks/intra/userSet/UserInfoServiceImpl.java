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

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
 *  2012. 5. 11.
 * </pre>
 * @see
 */
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

    @Resource
    private UserInfoDAO dao;

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 SELECT
     * 
     * @param
     * @return List<UserInfoVO>
     */
    @Override
    public List<UserInfoVO> userInfoList(UserInfoVO vo) {
        return dao.userInfoList(vo);
    }

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 개인 & 사업자별 COUNT
     * 
     * @param
     * @return UserInfoVO
     */
    @Override
    public UserInfoVO userInfoCount(UserInfoVO vo) {
        return dao.userInfoCount(vo);
    }

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 사용여부 코드 네임
     * 
     * @param
     * @return List<UserInfoVO>
     */
    @Override
    public List<UserInfoVO> getUseYnNameList() {
        return dao.getUseYnNameList();
    }

    /**
     * 회원 가입정보 설정 기본 & 추가 항목 수정
     * 
     * @param
     * @return Integer
     */
    @Override
    public int userInfoSetUpdate(UserInfoVO vo) {
        return dao.userInfoSetUpdate(vo);
    }

    /**
     * 회원 가입정보 설정 회원 선택 여부
     * 
     * @param
     * @return Map<String, String>
     */
    @Override
    public Map<String, String> userSelect() {
        return dao.userSelect();
    }

    /**
     * 회원 가입정보 설정 회원 선택 여부 수정
     * 
     * @param
     * @return Integer
     */
    @Override
    public int userSelectUpdate(String[] str) {
        return dao.userSelectUpdate(str);
    }

    /**
     * 관심항목 리스트
     * 
     * @param
     * @return List<UserInfoVO>
     */
    @Override
    public List<UserInfoVO> interestItemList(UserInfoVO vo) {
        return dao.interestItemList(vo);
    }

    /**
     * 관심항목 리스트 개인 | 사업자별 COUNT
     * 
     * @param
     * @return UserInfoVO
     */
    @Override
    public UserInfoVO interestItemCount() {
        return dao.interestItemCount();
    }

    /**
     * 관심항목 등록
     * 
     * @param
     * @return Integer
     */
    @Override
    public int interestInsert(UserInfoVO vo) {
        int affected = dao.interestInsert(vo);

        return affected;
    }

    /**
     * 관심항목 개인 | 사업자별 수정
     * 
     * @param
     * @return Integer
     */
    @Override
    public int interestUpdate(UserInfoVO vo) {
        return dao.interestUpdate(vo);
    }

    /**
     * 관심항목 삭제
     * 
     * @param
     * @return Integer
     */
    @Override
    public int interestDelete(UserInfoVO vo) {
        return dao.interestDelete(vo);
    }

    /**
     * 가입정보 변경 이력 사항 LIST
     * 
     * @param
     * @return List<UserInfoVO>
     */
    @Override
    public List<UserInfoVO> setLogList() {
        return dao.setLogList();
    }

    /**
     * 가입정보 변경 이력 사항 등록
     * 
     * @param
     * @return void
     */
    @Override
    public void userInfoSetLog(UserInfoVO vo) {
        String[] uCode = vo.getParamUseYnCodes();
        String[] bCode = vo.getBeforeYnCodes();
        String[] itemNm = vo.getItemNms();
        String[] useYnCodes = vo.getUseYnCodes();
        String[] useYnNms = vo.getUseYnNms();
        String[] userTys = vo.getUserTys();

        Map<String, String> m = new HashMap<String, String>();
        for(int i = 0 ; i < useYnCodes.length ; i++) {
            m.put(useYnCodes[i], useYnNms[i]);
        }

        String str = "";
        String userGubunNm = "";
        int modCount = 0;
        for(int i = 0 ; i < uCode.length ; i++) {
            if("P".equals(userTys[i])){
                userGubunNm = "개인";
            } else if("C".equals(userTys[i])){
                userGubunNm = "기업";
            } else {
                userGubunNm = "스토어";
            }
            if(!uCode[i].equals(bCode[i])) { // 변경 전,후를 비교하여 이력로그에 저장한다.
                modCount++;
                str += "(" + userGubunNm + ") " + itemNm[i] + " " + m.get(bCode[i]) + " -> " + m.get(uCode[i]);
                str += " / ";
            }
        }

        if(modCount != 0) {
            vo.setUpdtCn(str.substring(0, (str.length() - 3)));
            dao.insertLog(vo);
        }
    }

    /**
     * 관심항목 등록,수정,삭제 이력사항 등록
     * 
     * @param
     * @return void
     */
    @Override
    public void interestSetLog(UserInfoVO vo) {
        dao.insertLog(vo);
    }

}
