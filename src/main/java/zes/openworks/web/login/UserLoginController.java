/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Kisinfo.Check.IPINClient;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.listener.LoginSessionBinding;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;

/**
 * 회원 로그인 관리
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
 *  2012. 6. 20.    김영상   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/login/user")
public class UserLoginController extends WebController {

    @Autowired
    private UserLoginService webLoginService;

    @Autowired
    private CommonDutyService codtservice;

    @Autowired
    private AutoMailService amservice;

    @Autowired
    private SmsTransHistService smsservice;

    private static final int LOGIN_MAX_TRY_COUNT = 3;
    private static final int LOGIN_RETRY_DELAY = 300;

    /**
     * 로그인 폼
     *
     * [Return URl 설명]
     * 1. URL 호출            : /login/user/BD_index.do
     * 2. Return URL 호출     : ?returnUrl=
     * 3. Return Param 호출   : &returnParam=
     * 4. Return Method 호출  : &returnMethod=            : 기본은 GET 방식
     *
     * 예) /login/user/BD_index.do?returnUrl=(value)&returnParam=(value)&returnMethod=(post/get)" ;
     *
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model) {
        String rtnDomUrl = "";
        String rtnDomain = "";
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String uri = url + "?" + query;

        /*url = url.replace(":446", "");
        url = url.replace(":445", "");
        url = url.replace(":444", "");
        url = url.replace(":443", "");
        url = url.replace(":80", "");*/
        if(!"".equals(uri)){
            rtnDomain = CmsUtil.getRtnDomain(uri);
            rtnDomUrl = new CommonDutyConstant().getRedirectUrl(request);
            model.addAttribute("rtnDomain",rtnDomain);
            model.addAttribute("rtnDomUrl",rtnDomUrl);
            if(!"".equals(query) && (query.indexOf("memChk=") > -1)){
                String[] param = query.split("memChk=");
                if(param.length > 1) {
                    query = query.split("memChk=")[1];
                    model.addAttribute("memChk",query);
                }
            }
            if(!"".equals(query) && (query.indexOf("returnParam=") > -1)){
                String[] param = query.split("returnParam=");
                if(param.length > 1) {
                    query = query.split("returnParam=")[1];
                    model.addAttribute("returnParam",query);
                }
            }
        }
    }

    /**
     * 로그인 액션
     */
    @RequestMapping(value = "ND_loginAction.do", method = RequestMethod.POST)
    public String loginAction(UserLoginVO vo, HttpServletRequest request, ModelMap model, UserLogVO logVo, HttpServletResponse response) {
        LOG_RESULT logResult = LOG_RESULT.OK;
        String resultStr = "200";
        String failReason = "";
        HttpSession session = request.getSession(true);

        if(isValidLogin(session, logResult)) {
            String hostNm = CmsUtil.getHostName(request.getServerName());
            String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
            vo.setLangCode(codtservice.getLangCd(Integer.parseInt(domainCd)));
            UserLoginVO dataVo = webLoginService.loginAction(vo);
            if(Validate.isNotEmpty(dataVo.getUserSttusCd()) && dataVo.getUserSttusCd() == 1002){
                resultStr = "Withdraw";
            }else if(Validate.isNotEmpty(dataVo.getUserSttusCd()) && dataVo.getUserSttusCd() == 1004){
                if(!dataVo.isValidId() || !dataVo.isValidPwd()){
                    resultStr = "notMatchLogin"; //ID & PASSWORD 입력오류 통합
                } else {
                    //20160804 : KS : 신규약관동의 종료
                    //if(dataVo.getStplatAgreAt().equals("N")) {
                    //    resultStr = "2002";      //신규 약관동의하지 않은 회원
                    //} else {
                        resultStr = "2001";
                        session.setAttribute("userDrmncyId", dataVo.getUserId());
                        session.setAttribute("userDrmncyPw", vo.getUserPassword());

                        Crypto cry = CryptoFactory.getInstance("ARIA");
                        resultStr += " "+cry.encrypt(dataVo.getUserId()); //userId 암호화추가
                    //}
                }
            }else{

                if(dataVo.isValidId() && dataVo.isValidPwd()) {
                    
                    session.setAttribute(GlobalConfig.USER_SESSION_KEY, dataVo);

                    // 현재 접속자 구현을 위한 바인딩 리스너
                    session.setAttribute("__musk", new LoginSessionBinding());

                    session.setAttribute("MEM_ID", dataVo.getUserId());
                    session.setAttribute("MEM_KEY", dataVo.getUserKey());
                    session.setAttribute("MEM_NAME", dataVo.getUserNm());
                    session.setAttribute("MEM_TYPE", dataVo.getUserTyCd());
                    session.setAttribute("MEM_CHARGER_AT", dataVo.getDmandExaminChargerAt());  
                    //session.setAttribute("MEM_BUSEOCD", arg1);
                    if(Validate.isNotEmpty(vo.getMemChk())){
                        session.setAttribute("MEM_CHK", vo.getMemChk());  //구매기록 사용여부
                    } else {
                        session.setAttribute("MEM_CHK", "N");  //구매기록 사용여부(Default : N)
                    }
                    // 접속자 아이디set
                    logVo.setUserId(dataVo.getUserId());
                    // 금일 접속 확인
                    int loginYn = webLoginService.loginYn(logVo);
                    // 접속자 아이피 set
                    String ipAddr = request.getRemoteAddr();
                    logVo.setLoginIp(ipAddr);
                    logVo.setLoginResult(1);
                    // 접속이력을 남김
                    webLoginService.logAction(logVo);
                    webLoginService.userLog(logVo);
                    if(loginYn == StringUtil.ZERO) {
                        UserLogVO logVo2 = webLoginService.userInfo(logVo);
                        if(Validate.isNotEmpty(logVo2.getAge())) {
                            logVo.setAge(logVo2.getAge());
                        }
                        if(Validate.isNotEmpty(logVo2.getSex())) {
                            logVo.setSex(logVo2.getSex());
                        }
                        if(Validate.isNotEmpty(logVo2.getSbscrbTyCd())) {
                            logVo.setSbscrbTyCd(logVo2.getSbscrbTyCd());
                        }
                        int userAllCount = webLoginService.userAllCount(logVo);
                        logVo.setEntireUserCount(userAllCount);
                        // 통계카운트 올리기
                        //webLoginService.logStatsCount(logVo);
                    }
                } else {
                    String ipAddr = request.getRemoteAddr();
                    logVo.setLoginIp(ipAddr);
                    if(!"".equals(logVo.getUserId())){
                        webLoginService.logAction(logVo);
                    }
                }

                if(!dataVo.isValidId() || !dataVo.isValidPwd()){
                    resultStr = "notMatchLogin"; //ID & PASSWORD 입력오류 통합
                } else {
                    resultStr = "200";
                    //기관회원중 기관정보가 맞지않는 경우
                    if(dataVo.getPblinsttUpdtAt().equals("Y")) {
                        resultStr = "2002";      //기관회원중 기관정보가 맞지않는 경우
                        Crypto cry = CryptoFactory.getInstance("ARIA");
                        resultStr += " "+cry.encrypt(dataVo.getUserId()); //userId 암호화추가
                    } else {
                        webLoginService.logging(setLogginInfo(request, vo, failReason, logResult));
                        String passwordChangeCheck = webLoginService.passwordChangeDeCheck(vo);
                        if(Validate.isNotEmpty(passwordChangeCheck)){
                            if(passwordChangeCheck.equals("Y")){
                                resultStr = "2000";
                            }
                        }
                        Crypto cry = CryptoFactory.getInstance("ARIA");
                        resultStr += " "+cry.encrypt(dataVo.getUserId()); //userId 암호화추가
                    }
                }
            }
        } else {
            String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
            if(url.indexOf(Config.getString("url.userMain")) > -1){
                resultStr = MessageHelper.getMsg(request,MessageHelper.getMsg(request, "limitTry"));
            }else{
                resultStr = MessageHelper.getMsg(request, "limitTry");
            }
        }

        //돌려보낼 주소가 있으면 해당 주소로 보낸다.
        String returnUrl = request.getParameter("returnUrl") != null ? request.getParameter("returnUrl") : "";
        String param = request.getParameter("returnParam") != null ? request.getParameter("returnParam") : "";

        if("Y".equals(Config.getString("global.sslUse"))) {
            returnUrl = returnUrl.replace("https", "http");
            returnUrl = returnUrl.replace(":446", "");
            //returnUrl = returnUrl.replace(":445", "");
            returnUrl = returnUrl.replace(":8445", "");
            returnUrl = returnUrl.replace(":444", "");
            returnUrl = returnUrl.replace(":443", "");
            returnUrl = returnUrl.replace(":80", "");
        }

        if(!"".equals(returnUrl)){
            return "redirect:" + returnUrl + "?" + param;
        }else{
            return responseText(model, resultStr);
        }
    }


    @RequestMapping(value = "ND_flgChangeAction.do", method = RequestMethod.POST)
    public String ND_flgChangeAction(UserLoginVO vo, HttpServletRequest request,  ModelMap model, String userChk, HttpServletResponse response) {

        HttpSession session = request.getSession(true);
        if(session.getAttribute("MEM_CHK") != null)
            session.setAttribute("MEM_CHK", userChk);
        return responseText(model, "");
    }
    /**
     * 로그아웃 액션
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "ND_logoutAction.do", method = RequestMethod.GET)
    public String logoutAction(HttpServletRequest request) {

        HttpSession session = request.getSession(true);

        Enumeration<String> enumer = session.getAttributeNames();
        while(enumer.hasMoreElements()) {
            String key = enumer.nextElement();
            session.removeAttribute(key);
        }

        session.invalidate();

        String rtnDomUrl = new CommonDutyConstant().getRedirectUrl(request);
        if("Y".equals(Config.getString("global.sslUse"))) {
            rtnDomUrl = rtnDomUrl.replace("https", "http");
            rtnDomUrl = rtnDomUrl.replace(":446", "");
            //rtnDomUrl = rtnDomUrl.replace(":445", "");
            rtnDomUrl = rtnDomUrl.replace(":8445", "");
            rtnDomUrl = rtnDomUrl.replace(":444", "");
            rtnDomUrl = rtnDomUrl.replace(":443", "");
            rtnDomUrl = rtnDomUrl.replace(":80", "");
        }
        String url = "index.do";
        return "redirect:" + rtnDomUrl+url;
        //return "redirect:" + Config.getString("url.userMain");
    }

    /**
     * 로그인 제한 조건을 체크
     *
     * @param session
     * @param logResult
     * @return
     */
    private boolean isValidLogin(HttpSession session, LOG_RESULT logResult) {

        String loginLimitCount = (String) session.getAttribute("__LOGIN_TRY_COUNT");
        if(Validate.isAlphaNumeric(loginLimitCount)) {
            int loginTryCount = Integer.parseInt(loginLimitCount) + 1;

            /* 로그인 제한 횟수를 초과함 */
            if(loginTryCount > LOGIN_MAX_TRY_COUNT) {
                // 현재시간 설정
                Long loginLimitTime = (Long) session.getAttribute("__LOGIN_REJECT_TIME");

                /* 로그인 제한 횟수를 최초로 초과함, 로긴 거부 */
                if(loginLimitTime == null) {
                    session.setAttribute("__LOGIN_REJECT_TIME", Long.valueOf(String.valueOf(System.currentTimeMillis())));
                    logResult = LOG_RESULT.OVER_COUNT_LOGIN_TRY;
                    return false;
                } else {
                    long currentTime = System.currentTimeMillis();
                    long elapsedTime = currentTime - loginLimitTime.longValue();

                    /* 로그인 재시도 지연시간을 지남, 로그인 허용 */
                    if((elapsedTime / 1000) > LOGIN_RETRY_DELAY) {
                        session.removeAttribute("__LOGIN_TRY_COUNT");
                        session.removeAttribute("__LOGIN_REJECT_TIME");
                        return true;
                    }
                    /* 로그인 재시도 지연시간이 남았음, 로그인 거부 */
                    else {
                        logResult = LOG_RESULT.OVER_TIME_LOGIN_TRY;
                        return false;
                    }
                }
            } else {    /* 아직 로그인 제한 횟수에 도달하지 않음 : 허용 */
                session.setAttribute("__LOGIN_TRY_COUNT", String.valueOf(loginTryCount));
                return true;
            }
        } else {  /* 최초 로그인 시도임 : 로그인 허용 */
            session.setAttribute("__LOGIN_TRY_COUNT", String.valueOf(1));
            return true;
        }
    }

    private LoggingWebUserLoginVO setLogginInfo(HttpServletRequest request, UserLoginVO vo, String failReason, LOG_RESULT logResult) {
        LoggingWebUserLoginVO userLogVO = new LoggingWebUserLoginVO();
        userLogVO.setUserLoginVO(vo);
        userLogVO.setLoginMenu(request.getHeader("REFERER"));
        userLogVO.setLoginResult(String.valueOf(logResult));
        userLogVO.setLoginIp(request.getRemoteAddr());
        userLogVO.setLoginFailReason(failReason);

        return userLogVO;
    }

    private enum LOG_RESULT {
        OK,
        PASSWORD_FAIL,
        OVER_COUNT_LOGIN_TRY,
        OVER_TIME_LOGIN_TRY,
    }

    /**
     * 아이디 찾기 폼
     */
    @RequestMapping(value = "BD_findId.do", method = RequestMethod.GET)
    public void findId(HttpServletRequest request, ModelMap model) {

    }

    /**
     * 아이디 찾기 1단계
     */
    @RequestMapping(value = "ND_findIdAction.do", method = RequestMethod.POST)
    public String findIdAction(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        String classify = request.getParameter("classify") != null ? cleanScript(request.getParameter("classify").toString()) : "";
        String resultStr = "0";
        vo.setUserTyCd(Integer.parseInt(classify));

        /*if(null != vo.getBrthdy()){         //생년월일로 찾기
            vo.setIdFindTy("birthday");
        }else */if(null != vo.getMbtlnum()){  //휴대전화번호로 찾기
            vo.setIdFindTy("mobile");
        }else{                             //이메일로 찾기
            vo.setIdFindTy("email");
        }
        if("1".equals(classify)){       //개인 구매회원 | 기업 구매회원 -> 구매회원 1001,2001,3001
            vo.setIdUserTy("A");
        }else /*if("2".equals(classify)){ //기업(구매 + 판매회원)
            vo.setIdUserTy("B");
        }else if("3".equals(classify)){ //개인(구매 + 판매회원)
            vo.setIdUserTy("C");
        }else*/{                          //해외회원 -> 공급자회원 1002,2002,3002
            vo.setIdUserTy("D");
        }
        UserLoginVO dataVo = webLoginService.findIdAction(vo);
        if(Validate.isNotEmpty(dataVo)) {
            String nonMaskId = dataVo.getUserId().substring(0, 3);
            String maskId = dataVo.getUserId().substring(3);
            maskId = strMaskingReplace(maskId.length());
            String nonMaskMail = "";
            String maskMail = "";
            String mailDom = "";
            if(dataVo.getEmail().split("@")[0].length() > 3){
                nonMaskMail = dataVo.getEmail().split("@")[0].substring(0, 3);
                maskMail = dataVo.getEmail().split("@")[0].substring(3);
                mailDom = dataVo.getEmail().split("@")[1];
            }else{
                nonMaskMail = dataVo.getEmail().split("@")[0].substring(0, 1);
                maskMail = dataVo.getEmail().split("@")[0].substring(1);
                mailDom = dataVo.getEmail().split("@")[1];
            }
            maskMail = strMaskingReplace(maskMail.length());
            resultStr = nonMaskId+maskId+","+dataVo.getRegistDt()+","+nonMaskMail+maskMail+"@"+mailDom;
            //session에 메일 및 SMS 발송용 정보를 담아둔다
            session.setAttribute("email", dataVo.getEmail());
            session.setAttribute("userNm", dataVo.getUserNm());
            session.setAttribute("userId", dataVo.getUserId());
            session.setAttribute("regDt", dataVo.getRegistDt());
            session.setAttribute("smsNum", dataVo.getMbtlnum());
            session.setAttribute("classify", classify);
            session.setAttribute("idpwse", "I");    //아이디 찾기 구분
        }
        return responseText(model, cleanScript(resultStr));
    }

    public static String strMaskingReplace(int i){
        String rtnStr = "";
        for(int j = 0; j < i; j++){
            rtnStr = rtnStr+"*";
        }
        return rtnStr;
    }

    /**
     * 아이디 찾기 2단계
     */
    @RequestMapping(value = "BD_findId2.do", method = RequestMethod.POST)
    public void findId2Action(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        vo.setEmail(session.getAttribute("email") != null ? cleanScript(session.getAttribute("email").toString()) : "");
        vo.setIdFindTy(session.getAttribute("classify") != null ? cleanScript(session.getAttribute("classify").toString()) : "");
        session.setAttribute("idpwse", "I");    //아이디 찾기 구분
        model.addAttribute("sesEmail", cleanScript(vo.getEmail()));
    }

    /**
     * 아이디 찾기  2단계에서 메일 및 SMS발송
     */
    @RequestMapping(value = "ND_findIdMailSend.do", method = RequestMethod.POST)
    public boolean findIdSend(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        vo.setEmail(session.getAttribute("email") != null ? session.getAttribute("email").toString() : "");
        vo.setUserNm(session.getAttribute("userNm") != null ? session.getAttribute("userNm").toString() : "");
        vo.setUserId(session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "");
        vo.setRegistDt(session.getAttribute("regDt") != null ? session.getAttribute("regDt").toString() : "");
        vo.setMbtlnum(session.getAttribute("smsNum") != null ? session.getAttribute("smsNum").toString() : "");

        //메일 및 SMS전송
        /** 이메일발송시작 **/
        boolean result = false;
        Map<String, Object> emailMap = new HashMap<String, Object>();
        /*  필수 입력 항목
            ---------------------------------------------------------
                           메일템플릿 번호
            ---------------------------------------------------------
                    //AutoMailTemplate.java참고
            ---------------------------------------------------------
         */
        vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
        if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
            emailMap.put("automailId", AutoMailTemplate.KOR_ID_SECH);
        }

        // 전송할 메일 정보 입력
        emailMap.put("receiverName", vo.getUserNm());    //수신자명
        emailMap.put("email", vo.getEmail());            //수신이메일주소

        /*
               메일 템플릿에 적용될 치환값 : userId, regDt
         */
        HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

        // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
        oneToOneInfoMap.put("id", vo.getUserId());
        oneToOneInfoMap.put("regDt", vo.getRegistDt());

        // 치환정보 맵 입력
        emailMap.put("oneToOneInfo", oneToOneInfoMap);

        // 선택 입력 항목
        emailMap.put("senderName", "ceartMarket");     // 생략시 기본 설정값 적용 : 씨앗마켓
        //autoMap.put("senderEmail", "발신자 이메일");   // 생략시 기본 설정값 적용 : webmaster@ceart.kr
        //autoMap.put("mailTitle", "메일 제목");        // 생략시 기본 설정값 적용

        //EMAIL 발송
        result = amservice.sendAutoMail(emailMap);
        if(result){
          /*  System.out.println("########################################################");
            System.out.println("####아이디찾기 E-MAIL : "+vo.getEmail()+","+vo.getUserNm()+"에게 발송 성공#########");
            System.out.println("########################################################");*/
        }else{
            /*System.out.println("########################################################");
            System.out.println("####아이디찾기 E-MAIL : "+vo.getEmail()+","+vo.getUserNm()+"에게 발송 실패#########");
            System.out.println("########################################################");*/
        }
        /** 이메일발송끝 **/
        /** SMS발송시작 **/
        if(vo.getMbtlnum() != null){
            Map<String, Object> smsMap = new HashMap<String, Object>();
            /*
            smsMap.put("rcvNo", "수신번호");
            smsMap.put("msg", "발신내용");      //메시지번호별 발송메시지 SmsTransHistConstant.java참고
            smsMap.put("dutyCd", "업무코드");   //RM,CM,UM,CO...
            */
            //SMS발송 및 전송이력쌓기
            SmsTransHistConstant shc = new SmsTransHistConstant();
            //수신번호-필수
            smsMap.put("rcvNo", vo.getMbtlnum());
            //발신내용-필수
            if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
                smsMap.put("msg", shc.getSmsMsg("213"));
            }else if(vo.getSbscrbSiteSeCd() == 3001 || vo.getSbscrbSiteSeCd() == 3002){   //영어사이트
                smsMap.put("msg", shc.getSmsMsg("313"));
            }else if(vo.getSbscrbSiteSeCd() == 4001 || vo.getSbscrbSiteSeCd() == 4002){   //스페인어사이트
                smsMap.put("msg", shc.getSmsMsg("413"));
            }
            //업무코드
            smsMap.put("dutyCd", "CO");
            boolean smsRst = smsservice.smsTransHist(smsMap);
            if(smsRst){
               /* System.out.println("########################################################");
                System.out.println("####아이디찾기 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 성공#########");
                System.out.println("########################################################");*/
            }else{
                /*System.out.println("########################################################");
                System.out.println("####아이디찾기 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
        }
        /** SMS발송끝 **/

        return result;
    }

    /**
     * 아이디 찾기 3단계
     */
    @RequestMapping(value = "BD_findId3.do", method = RequestMethod.POST)
    public String findId3Action(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        vo.setUserId(session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "");
        vo.setRegistDt(session.getAttribute("regDt") != null ? session.getAttribute("regDt").toString() : "");
        vo.setUserNm(session.getAttribute("userNm") != null ? session.getAttribute("userNm").toString() : "");
        vo.setIdUserTy(session.getAttribute("classify") != null ? session.getAttribute("classify").toString() : "");        //인증회원구분
        String sResponseData = request.getParameter("enc_data") != null ? request.getParameter("enc_data").toString() : ""; //IPIN인증결과
        String bizrno = session.getAttribute("bizNo") != null ? session.getAttribute("bizNo").toString() : "";                //인증된 사업자번호
        String cmpnyNm = session.getAttribute("bizNm") != null ? session.getAttribute("bizNm").toString() : "";               //인증된 사업자명
        String strRetCd = request.getParameter("strRetCd") != null ? request.getParameter("strRetCd").toString() : "";      //사업자번호인증 결과 응답코드
        String strRetDtlCd = request.getParameter("strRetDtlCd") != null ? request.getParameter("strRetDtlCd").toString() : ""; //사업자번호인증 결과 상세코드
        String dResponseData = request.getParameter("encData") != null ? request.getParameter("encData").toString() : ""; //SMS인증결과

        String url = "";
        //기업판매회원(사업자인증)
        if(!"1".equals(vo.getIdUserTy())){
            //인증 확인을 위해 세션의 사업자정보 유무 확인
            if("".equals(strRetCd) || "".equals(strRetDtlCd)){
                url = requestUrl(request) + "/BD_findId.do";
                return alertAndRedirect(model, MessageHelper.getMsg(request, "noDiInfo"), url);
            }else{
                //인증 확인을 위해 인증정보 유무 판단
                if("1".equals(strRetCd) && "A".equals(strRetDtlCd)){  //사업자번호와 회사명의 일치가 인증됨
                    bizrno = bizrno.substring(0, 3) + "-" + bizrno.substring(3, 5) + "-" + bizrno.substring(5);
                    vo.setBizrno(bizrno);
                    vo.setCmpnyNm(cmpnyNm);
                    //인증데이터와 DB상의 정보 비교
                    String certfcNm = webLoginService.cetifybizNo(vo);  //가입자명가져오기
                    if(null != certfcNm && !"".equals(certfcNm)) {           //회원시스템 내 같은 회사명과 사업자번호가 존재함
                        if(!certfcNm.equals(vo.getUserNm())){           //찾으려는 사람과 가입한 사람이 다름
                            url = requestUrl(request) + "/BD_findId.do";
                            return alertAndRedirect(model, MessageHelper.getMsg(request, "notMatchBizno"), url);
                        }else{
                            model.addAttribute("fUserId", vo.getUserId());
                            model.addAttribute("regDate", vo.getRegistDt());
                            model.addAttribute("bizNoSecs", "Y");
                            return requestUrl(request) + "/BD_findId3";
                        }
                    }else{
                        url = requestUrl(request) + "/BD_index.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "noneBiznoInfo"), url);
                    }
                }else if("2".equals(strRetCd)){
                    if("B".equals(strRetDtlCd)){ //인증시스템에서 인증실패
                        url = requestUrl(request) + "/BD_findId.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoFail"), url);
                    }else if("D".equals(strRetDtlCd)){   //사업자번호 체계가 틀림
                        url = requestUrl(request) + "/BD_findId.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoIncorrect"), url);
                    }else if("E".equals(strRetDtlCd)){       //일시적인 통신장애
                        url = requestUrl(request) + "/BD_index.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "certfyErrorBizNo"), url);
                    }else{
                        url = requestUrl(request) + "/BD_findId.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoFail"), url);
                    }
                }else if("3".equals(strRetCd) && "G".equals(strRetDtlCd)){    //나이스에 등록되어있지 않은 사업자
                    url = requestUrl(request) + "/BD_index.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "noRegBizNo"), url);
                }else{
                    url = requestUrl(request) + "/BD_findId.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoFail"), url);
                }
            }
        //휴대폰 및 IPIN인증
        }else{
            //IPIN인증값이 있는지 확인
            if(!"".equals(sResponseData)){
                String sSiteCode                = "K517";
                String sSitePw                  = "57168249";
                IPINClient pClient = new IPINClient();
                int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
                String sDupInfo             = pClient.getDupInfo(); //중복가입방지키
                String sName                = pClient.getName();    //유저명
                if(iRtn == 1){
                    //인증 확인을 위해 세션유무 판단
                    if(null == session.getAttribute("userNm") || null == session.getAttribute("userId")){
                        url = requestUrl(request) + "/BD_findId.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "noCertfyInfo"), url);
                    }else{
                        //인증데이터와 세션상의 이름 및 DB상의 중복가입방지키와 비교
                        String chk = webLoginService.getDupCheck(vo);
                        if(null != chk && !"".equals(chk)) {
                            if(sDupInfo.equals(chk) && sName.equals(vo.getUserNm())){
                                model.addAttribute("ipinSecs", "Y");
                                model.addAttribute("fUserId", vo.getUserId());
                                model.addAttribute("regDate", vo.getRegistDt());
                                return requestUrl(request) + "/BD_findId3";
                            }else{
                                url = requestUrl(request) + "/BD_findId.do";
                                return alertAndRedirect(model, MessageHelper.getMsg(request, "notMatchDi"), url);
                            }
                        }else{
                            url = requestUrl(request) + "/BD_index.do";
                            return alertAndRedirect(model, MessageHelper.getMsg(request, "noneDiInfo"), url);
                        }
                    }
                }else{
                    url = requestUrl(request) + "/BD_index.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "decDiFail"), url);
                }
            //휴대폰 인증값이 있는지 확인
            }else if(!"".equals(dResponseData)){
                String sSiteCode                = "G7358";
                String sSitePassword            = "UM0TNW4SRJ9S";
                NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();
                int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, dResponseData);
                String sPlainData = niceCheck.getPlainData();  // 암호화된 결과 데이터의 복호화
                String sDupInfo             = "";       //중복가입방지키
                String sName                = "";       //유저명
                if(iReturn == 0){
                    // 데이타를 추출합니다.
                    @SuppressWarnings("rawtypes")
                    HashMap mapresult = new HashMap();
                    mapresult = niceCheck.fnParse(sPlainData);
                    if(mapresult != null){
                        sName = mapresult.get("NAME") != null ? (String)mapresult.get("NAME") : "";
                        sDupInfo = mapresult.get("DI") != null ? (String)mapresult.get("DI") : "";
                    }

                    //인증 확인을 위해 세션유무 판단
                    if(null == session.getAttribute("userNm") || null == session.getAttribute("userId")){
                        url = requestUrl(request) + "/BD_findId.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "noCertfyInfo"), url);
                    }else{
                        //인증데이터와 세션상의 이름 및 DB상의 중복가입방지키와 비교
                        String chk = webLoginService.getDupCheck(vo);
                        if(null != chk && !"".equals(chk)) {
                            if(sDupInfo.equals(chk) && sName.equals(vo.getUserNm())){
                                model.addAttribute("hpSecs", "Y");
                                model.addAttribute("fUserId", vo.getUserId());
                                model.addAttribute("regDate", vo.getRegistDt());
                                return requestUrl(request) + "/BD_findId3";
                            }else{
                                url = requestUrl(request) + "/BD_findId.do";
                                return alertAndRedirect(model, MessageHelper.getMsg(request, "notMatchDi"), url);
                            }
                        }else{
                            url = requestUrl(request) + "/BD_index.do";
                            return alertAndRedirect(model, MessageHelper.getMsg(request, "noneDiInfo"), url);
                        }
                    }
                }else{
                    url = requestUrl(request) + "/BD_index.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "decDiFail"), url);
                }
            }else{
                url = requestUrl(request) + "/BD_index.do";
                return alertAndRedirect(model, MessageHelper.getMsg(request, "noCertfyInfo"), url);
            }
        }
    }

    /**
     * 비밀번호 찾기 폼
     */
    @RequestMapping(value = "BD_findPwd.do", method = RequestMethod.GET)
    public void findPwd(HttpServletRequest request, ModelMap model) {

    }

    /**
     * 비밀번호 찾기 1단계
     */
    @RequestMapping(value = "ND_findPwdAction.do", method = RequestMethod.POST)
    public String findPwd(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        String classify = request.getParameter("classify") != null ? request.getParameter("classify").toString() : "";
        String resultStr = "0";
        vo.setUserTyCd(Integer.parseInt(classify));
        /*if(null != vo.getBrthdy()){         //생년월일로 찾기
            vo.setIdFindTy("birthday");
        }else */if(null != vo.getMbtlnum()){  //휴대전화번호로 찾기
            vo.setIdFindTy("mobile");
        }else{                              //이메일로 찾기
            vo.setIdFindTy("email");
        }
        if("1".equals(classify)){       //개인 구매회원 | 기업 구매회원 -> 구매자 검색 1001,2001,3001
            vo.setIdUserTy("A");
        }else/* if("2".equals(classify)){ //기업(구매 + 판매회원)
            vo.setIdUserTy("B");
        }else if("3".equals(classify)){ //개인(구매 + 판매회원)
            vo.setIdUserTy("C");
        }else*/{                          //해외회원 -> 공급자 검색 1002,2002,3002
            vo.setIdUserTy("D");
        }
        UserLoginVO dataVo = webLoginService.findPwdAction(vo);
        if(Validate.isNotEmpty(dataVo)) {
            String nonMaskId = dataVo.getUserId().substring(0, 3);
            String maskId = dataVo.getUserId().substring(3);
            maskId = strMaskingReplace(maskId.length());
            String nonMaskMail = "";
            String maskMail = "";
            String mailDom = "";
            if(dataVo.getEmail().split("@")[0].length() > 3){
                nonMaskMail = dataVo.getEmail().split("@")[0].substring(0, 3);
                maskMail = dataVo.getEmail().split("@")[0].substring(3);
                mailDom = dataVo.getEmail().split("@")[1];
            }else{
                nonMaskMail = dataVo.getEmail().split("@")[0].substring(0, 1);
                maskMail = dataVo.getEmail().split("@")[0].substring(1);
                mailDom = dataVo.getEmail().split("@")[1];
            }
            maskMail = strMaskingReplace(maskMail.length());
            resultStr = nonMaskId+maskId+","+dataVo.getRegistDt()+","+nonMaskMail+maskMail+"@"+mailDom;
            //session에 메일 및 SMS 발송용 정보를 담아둔다
            session.setAttribute("email", dataVo.getEmail());
            session.setAttribute("userId", dataVo.getUserId());
            session.setAttribute("userNm", dataVo.getUserNm());
            session.setAttribute("regDt", dataVo.getRegistDt());
            session.setAttribute("smsNum", dataVo.getMbtlnum());
            session.setAttribute("classify", classify);
            session.setAttribute("idpwse", "P");    //비밀번호 찾기 구분
        }
        return responseText(model, resultStr);
    }

    /**
     * 비밀번호 찾기 2단계
     */
    @RequestMapping(value = "BD_findPwd2.do", method = RequestMethod.POST)
    public void findPwd2Action(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        vo.setEmail(session.getAttribute("email") != null ? cleanScript(session.getAttribute("email").toString()) : "");
        vo.setIdFindTy(session.getAttribute("classify") != null ? cleanScript(session.getAttribute("classify").toString()) : "");
        session.setAttribute("idpwse", "P");    //비밀번호 찾기 구분
        model.addAttribute("sesEmail", vo.getEmail());
    }

    /**
     * 비밀번호 찾기 2단계에서 메일 및 SMS발송
     */
    @RequestMapping(value = "ND_findPwdSend.do", method = RequestMethod.POST)
    public boolean findPwdSend(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        vo.setEmail(session.getAttribute("email") != null ? session.getAttribute("email").toString() : "");
        vo.setUserNm(session.getAttribute("userNm") != null ? session.getAttribute("userNm").toString() : "");
        vo.setUserId(session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "");
        vo.setRegistDt(session.getAttribute("regDt") != null ? session.getAttribute("regDt").toString() : "");
        vo.setMbtlnum(session.getAttribute("smsNum") != null ? session.getAttribute("smsNum").toString() : "");

        //신규 비밀번호 생성
        String newPwd = webLoginService.newPwdCreate(vo);
        //메일 및 SMS전송
        boolean result = false;
        if(!"".equals(newPwd)){
            /** 이메일발송시작 **/
            Map<String, Object> emailMap = new HashMap<String, Object>();
            vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
            if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
                emailMap.put("automailId", AutoMailTemplate.KOR_NEW_PSWD);
            }

            // 전송할 메일 정보 입력
            emailMap.put("receiverName", vo.getUserNm());    //수신자명
            emailMap.put("email", vo.getEmail());            //수신이메일주소

            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            oneToOneInfoMap.put("passWord", newPwd);  // 치환내용 입력(치환값 : passWord)
            emailMap.put("oneToOneInfo", oneToOneInfoMap);  // 치환정보 맵 입력
            emailMap.put("senderName", "ceartMarket");  // 선택 입력 항목

            //EMAIL 발송
            result = amservice.sendAutoMail(emailMap);
            if(result){
                /*System.out.println("########################################################");
                System.out.println("####비밀번호 찾기 E-MAIL : "+vo.getEmail()+","+vo.getUserNm()+"에게 발송 성공#########");
                System.out.println("########################################################");*/
            }else{
                /*System.out.println("########################################################");
                System.out.println("####비밀번호 찾기 E-MAIL : "+vo.getEmail()+","+vo.getUserNm()+"에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
            /** 이메일발송끝 **/
            /** SMS발송시작 **/
            if(vo.getMbtlnum() != null){
                Map<String, Object> smsMap = new HashMap<String, Object>();

                //SMS발송 및 전송이력쌓기
                SmsTransHistConstant shc = new SmsTransHistConstant();
                //수신번호-필수
                smsMap.put("rcvNo", vo.getMbtlnum());
                //발신내용-필수
                if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
                    smsMap.put("msg", shc.getSmsMsg("214"));
                }else if(vo.getSbscrbSiteSeCd() == 3001 || vo.getSbscrbSiteSeCd() == 3002){   //영어사이트
                    smsMap.put("msg", shc.getSmsMsg("314"));
                }else if(vo.getSbscrbSiteSeCd() == 4001 || vo.getSbscrbSiteSeCd() == 4002){   //스페인어사이트
                    smsMap.put("msg", shc.getSmsMsg("414"));
                }
                //업무코드
                smsMap.put("dutyCd", "CO");
                boolean smsRst = smsservice.smsTransHist(smsMap);
                if(smsRst){
                    /*System.out.println("########################################################");
                    System.out.println("####비밀번호 찾기 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 성공#########");
                    System.out.println("########################################################");*/
                }else{
                   /* System.out.println("########################################################");
                    System.out.println("####비밀번호 찾기 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 실패#########");
                    System.out.println("########################################################");*/
                }
            }
            /** SMS발송끝 **/
        }

        return result;
    }

    /**
     * 비밀번호 찾기 3단계
     */
    @RequestMapping(value = "BD_findPwd3.do", method = RequestMethod.POST)
    public String findPwd3Action(UserLoginVO vo, HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        vo.setUserId(session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "");
        vo.setRegistDt(session.getAttribute("regDt") != null ? session.getAttribute("regDt").toString() : "");
        vo.setUserNm(session.getAttribute("userNm") != null ? session.getAttribute("userNm").toString() : "");
        vo.setIdUserTy(session.getAttribute("classify") != null ? session.getAttribute("classify").toString() : "");        //인증회원구분
        String sResponseData = request.getParameter("enc_data") != null ? request.getParameter("enc_data").toString() : ""; //IPIN인증결과
        String bizrno = session.getAttribute("bizNo") != null ? session.getAttribute("bizNo").toString() : "";                //인증된 사업자번호
        String cmpnyNm = session.getAttribute("bizNm") != null ? session.getAttribute("bizNm").toString() : "";               //인증된 사업자명
        String strRetCd = request.getParameter("strRetCd") != null ? request.getParameter("strRetCd").toString() : "";      //사업자번호인증 결과 응답코드
        String strRetDtlCd = request.getParameter("strRetDtlCd") != null ? request.getParameter("strRetDtlCd").toString() : ""; //사업자번호인증 결과 상세코드
        String dResponseData = request.getParameter("encData") != null ? request.getParameter("encData").toString() : ""; //SMS인증결과

        String url = "";
        //기업판매회원(사업자인증)
        if(!"1".equals(vo.getIdUserTy())){
            //인증 확인을 위해 세션의 사업자정보 유무 확인
            if("".equals(strRetCd) || "".equals(strRetDtlCd)){
                url = requestUrl(request) + "/BD_findPwd.do";
                return alertAndRedirect(model, MessageHelper.getMsg(request, "noDiInfo"), url);
            }else{
                //인증 확인을 위해 인증정보 유무 판단
                if("1".equals(strRetCd) && "A".equals(strRetDtlCd)){  //사업자번호와 회사명의 일치가 인증됨
                    bizrno = bizrno.substring(0, 3) + "-" + bizrno.substring(3, 5) + "-" + bizrno.substring(5);
                    vo.setBizrno(bizrno);
                    vo.setCmpnyNm(cmpnyNm);
                    //인증데이터와 DB상의 정보 비교
                    String certfcNm = webLoginService.cetifybizNo(vo);  //가입자명가져오기
                    if(null != certfcNm && !"".equals(certfcNm)) {           //회원시스템 내 같은 회사명과 사업자번호가 존재함
                        if(!certfcNm.equals(vo.getUserNm())){           //찾으려는 사람과 가입한 사람이 다름
                            url = requestUrl(request) + "/BD_findPwd.do";
                            return alertAndRedirect(model, MessageHelper.getMsg(request, "notMatchBizno"), url);
                        }else{
                            model.addAttribute("bizNoSecs", "Y");
                            model.addAttribute("fUserId", vo.getUserId());
                            return requestUrl(request) + "/BD_findPwd3";
                        }
                    }else{
                        url = requestUrl(request) + "/BD_index.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "noneBiznoInfo"), url);
                    }
                }else if("2".equals(strRetCd)){
                    if("B".equals(strRetDtlCd)){ //인증시스템에서 인증실패
                        url = requestUrl(request) + "/BD_findPwd.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoFail"), url);
                    }else if("D".equals(strRetDtlCd)){   //사업자번호 체계가 틀림
                        url = requestUrl(request) + "/BD_findPwd.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoIncorrect"), url);
                    }else if("E".equals(strRetDtlCd)){       //일시적인 통신장애
                        url = requestUrl(request) + "/BD_index.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "certfyErrorBizNo"), url);
                    }else{
                        url = requestUrl(request) + "/BD_findPwd.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoFail"), url);
                    }
                }else if("3".equals(strRetCd) && "G".equals(strRetDtlCd)){    //나이스에 등록되어있지 않은 사업자
                    url = requestUrl(request) + "/BD_index.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "noRegBizNo"), url);
                }else{
                    url = requestUrl(request) + "/BD_findPwd.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "bizNoFail"), url);
                }
            }
        //휴대폰 및 IPIN인증
        }else{
            //IPIN인증값이 있는지 확인
            if(!"".equals(sResponseData)){
                String sSiteCode                = "K517";
                String sSitePw                  = "57168249";
                IPINClient pClient = new IPINClient();
                int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
                String sDupInfo             = pClient.getDupInfo(); //중복가입방지키
                String sName                = pClient.getName();    //유저명
                if(iRtn == 1){
                    //인증 확인을 위해 세션유무 판단
                    if(null == session.getAttribute("userNm") || null == session.getAttribute("userId")){
                        url = requestUrl(request) + "/BD_findPwd.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "noCertfyInfo"), url);
                    }else{
                        //인증데이터와 세션상의 이름 및 DB상의 중복가입방지키와 비교
                        String chk = webLoginService.getDupCheck(vo);
                        if(null != chk && !"".equals(chk)) {
                            if(sDupInfo.equals(chk) && sName.equals(vo.getUserNm())){
                                model.addAttribute("ipinSecs", "Y");
                                model.addAttribute("fUserId", vo.getUserId());
                                return requestUrl(request) + "/BD_findPwd3";
                            }else{
                                url = requestUrl(request) + "/BD_findPwd.do";
                                return alertAndRedirect(model, MessageHelper.getMsg(request, "notMatchDi"), url);
                            }
                        }else{
                            url = requestUrl(request) + "/BD_index.do";
                            return alertAndRedirect(model, MessageHelper.getMsg(request, "noneDiInfo"), url);
                        }
                    }
                }else{
                    url = requestUrl(request) + "/BD_index.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "decDiFail"), url);
                }
            }else if(!"".equals(dResponseData)){
                String sSiteCode                = "G7358";
                String sSitePassword            = "UM0TNW4SRJ9S";
                NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();
                int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, dResponseData);
                String sPlainData = niceCheck.getPlainData();  // 암호화된 결과 데이터의 복호화
                String sDupInfo             = "";       //중복가입방지키
                String sName                = "";       //유저명
                if(iReturn == 0){
                    // 데이타를 추출합니다.
                    @SuppressWarnings("rawtypes")
                    HashMap mapresult = new HashMap();
                    mapresult = niceCheck.fnParse(sPlainData);
                    if(mapresult != null){
                        sName = mapresult.get("NAME") != null ? (String)mapresult.get("NAME") : "";
                        sDupInfo = mapresult.get("DI") != null ? (String)mapresult.get("DI") : "";
                    }

                    //인증 확인을 위해 세션유무 판단
                    if(null == session.getAttribute("userNm") || null == session.getAttribute("userId")){
                        url = requestUrl(request) + "/BD_findPwd.do";
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "noCertfyInfo"), url);
                    }else{
                        //인증데이터와 세션상의 이름 및 DB상의 중복가입방지키와 비교
                        String chk = webLoginService.getDupCheck(vo);
                        if(null != chk && !"".equals(chk)) {
                            if(sDupInfo.equals(chk) && sName.equals(vo.getUserNm())){
                                model.addAttribute("hpSecs", "Y");
                                model.addAttribute("fUserId", vo.getUserId());
                                model.addAttribute("regDate", vo.getRegistDt());
                                return requestUrl(request) + "/BD_findPwd3";
                            }else{
                                url = requestUrl(request) + "/BD_findPwd.do";
                                return alertAndRedirect(model, MessageHelper.getMsg(request, "notMatchDi"), url);
                            }
                        }else{
                            url = requestUrl(request) + "/BD_index.do";
                            return alertAndRedirect(model, MessageHelper.getMsg(request, "noneDiInfo"), url);
                        }
                    }
                }else{
                    url = requestUrl(request) + "/BD_index.do";
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "decDiFail"), url);
                }
            }else{
                url = requestUrl(request) + "/BD_index.do";
                return alertAndRedirect(model, MessageHelper.getMsg(request, "noCertfyInfo"), url);
            }
        }
    }

    /**
     * 사용자 비밀번호 변경 액션
     */
    @RequestMapping(value = "ND_passwordUpdateAction.do", method = RequestMethod.POST)
    public String passwordUpdateAction(ModelMap model, HttpServletRequest request, UserLoginVO vo) throws Exception {
        vo.setUpdtId(vo.getUserId());
        int affected = webLoginService.passwordUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }else if(affected < 0){
            return responseText(model, "-1");
        }else{
            return responseText(model, Messages.FALSE);
        }
    }

    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    /**
     * JavaScript를 구동 시킬수 있는 <script /> 태그를 치환
     *
     * @param content
     * @param target
     * @param replace
     * @return
     */
    private static String[] SCRIPT = new String[] { "script", "</script>" };
    private static String[] NO_SCRIPT = new String[] { "ncript", "</ncript>" };

    private static String cleanScript(String content) {

        String cont = content.toLowerCase();
        int scriptCnt = SCRIPT.length;
        for(int i = 0 ; i < scriptCnt ; i++) {

            String target = SCRIPT[i];
            String replace = NO_SCRIPT[i];

            StringBuilder sb = new StringBuilder();

            int prePos = 0;
            int nxtPos = 0;
            int targetLength = target.length();
            while(nxtPos > -1) {
                nxtPos = cont.indexOf(target, prePos);

                if(nxtPos > -1) {
                    sb.append(content.substring(prePos, nxtPos));
                    sb.append(replace);

                    prePos = nxtPos + targetLength;
                }
            }

            int contLen = cont.length();
            if(prePos < contLen) {
                sb.append(content.substring(prePos));
            }

            content = sb.toString();
        }

        return content;
    }

    /**
     * 약관동의 액션
     */
    @RequestMapping(value = "ND_stplatAgreAction.do", method = RequestMethod.POST)
    public String stplatAgreAction(UserLoginVO vo, HttpServletRequest request, ModelMap model, UserLogVO logVo, HttpServletResponse response) {
        String resultStr = "999";

        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCode(codtservice.getLangCd(Integer.parseInt(domainCd)));
        UserLoginVO dataVo = webLoginService.loginAction(vo);

        if(!dataVo.isValidId() || !dataVo.isValidPwd()){
            resultStr = "notMatchLogin"; //ID & PASSWORD 입력오류 통합
        } else {
            if(dataVo.isValidId() && dataVo.isValidPwd()) {
                if(Validate.isNotEmpty(dataVo.getUserSttusCd()) && (dataVo.getUserSttusCd() == 1001 || dataVo.getUserSttusCd() == 1004)){
                    if(dataVo.getStplatAgreAt().equals("Y")) {
                        resultStr = "2002";      //이미 동의한 회원
                    } else {
                        int chkNum = 0;
                        // ID/PW확인 완료시 약관동의 여부를 Update
                        chkNum = webLoginService.stplatAgreUpdateAction(dataVo);
                        if(chkNum > 0) {
                            //CROSS SITE 약관동의 여부 update

                            UserNewAgreeTrans nATrans = new UserNewAgreeTrans();
                            nATrans.open();
                            nATrans.newAgreeTrans(dataVo.getUserId());
                            nATrans.close();


                            resultStr = "200";  //동의 업데이트 완료
                        } else {
                            resultStr = "2001";  //동의 업데이트 실패
                        }
                    }
                }else{
                    if(Validate.isNotEmpty(dataVo.getUserSttusCd()) && (dataVo.getUserSttusCd() == 1002 || dataVo.getUserSttusCd() == 1003)){
                        resultStr = "Withdraw";     //탈퇴된 회원
                    }
                }
            } else {
                resultStr = "notMatchLogin"; //ID & PASSWORD 입력오류 통합
            }
        }
        return responseText(model, resultStr);
    }

    @RequestMapping(value = "BD_newAgree.do", method = RequestMethod.GET)
    public void newAgree(HttpServletRequest request, ModelMap model) {
        String rtnDomUrl = "";
        String rtnDomain = "";
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String uri = url + "?" + query;

        if(!"".equals(uri)){
            rtnDomain = CmsUtil.getRtnDomain(uri);
            rtnDomUrl = new CommonDutyConstant().getRedirectUrl(request);
            model.addAttribute("rtnDomain",rtnDomain);
            model.addAttribute("rtnDomUrl",rtnDomUrl);

            if(!"".equals(query) && (query.indexOf("returnParam=") > -1)){
                String[] param = query.split("returnParam=");
                if(param.length > 1) {
                    query = query.split("returnParam=")[1];
                    model.addAttribute("returnParam",query);
                }
            }
        }
    }
    
    /**
     * 모바일 로그인 폼
     */
    @RequestMapping(value = "BD_index_m.do", method = RequestMethod.GET)
    public void m_index(HttpServletRequest request, ModelMap model) {
        String rtnDomUrl = "";
        String rtnDomain = "";
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String uri = url + "?" + query;

        if(!"".equals(uri)){
            rtnDomain = CmsUtil.getRtnDomain(uri);
            rtnDomUrl = new CommonDutyConstant().getRedirectUrl(request);
            model.addAttribute("rtnDomain",rtnDomain);
            model.addAttribute("rtnDomUrl",rtnDomUrl);
            if(!"".equals(query) && (query.indexOf("memChk=") > -1)){
                String[] param = query.split("memChk=");
                if(param.length > 1) {
                    query = query.split("memChk=")[1];
                    model.addAttribute("memChk",query);
                }
            }
            if(!"".equals(query) && (query.indexOf("returnParam=") > -1)){
                String[] param = query.split("returnParam=");
                if(param.length > 1) {
                    query = query.split("returnParam=")[1];
                    model.addAttribute("returnParam",query);
                }
            }
        }
    }
    
    
    /**
     * 모바일 로그아웃 액션
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "ND_logoutAction_m.do", method = RequestMethod.GET)
    public String logoutAction_m(HttpServletRequest request) {

        HttpSession session = request.getSession(true);

        Enumeration<String> enumer = session.getAttributeNames();
        while(enumer.hasMoreElements()) {
            String key = enumer.nextElement();
            session.removeAttribute(key);
        }

        session.invalidate();

        return "redirect:" + Config.getString("url.mobileMain");
    }
    
}
