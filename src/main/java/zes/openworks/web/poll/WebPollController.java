/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.poll;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.CookieUtil;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.login.UserLoginVO;

/**
 * <pre>
 * 설문조사 관리 컨트롤러
 * </pre>
 * 
 * @author yesno
 * @version $Id: WebPollController.java 456 2010-02-25 12:09:41Z yesno $
 */
@Controller
@RequestMapping(value = "/**/poll")
public class WebPollController extends WebController {

    private static final String POLL_COOKIE_NAME_PREFIX = "__poll_seq__";
    private static final String PREFIX_POLLITEM_FIELD = "pollItem__";

    @Autowired
    WebPollService webPollService;

    /**
     * 기본정보 목록 조회
     */
    @RequestMapping(value = "BD_pollList.do", method = RequestMethod.GET)
    public void pollList(ModelMap model, HttpServletRequest request, WebPollVO pollVo) {

        OpHelper.bindSearchMap(pollVo, request);

        String domainName = request.getParameter("domainNm");

        if(Validate.isEmpty(domainName)) {
            domainName = request.getServerName();
        }

        // 현재 기본 도메인 코드 선택
        WebPollDomainVO domainVo = webPollService.getDomain(domainName);
        pollVo.getDataMap().put("q_domainCd", domainVo.getDomainCd());

        model.addAttribute("domain", domainVo);
        model.addAttribute(GlobalConfig.KEY_PAGER, webPollService.pollList(pollVo));
    }

    /**
     * <pre>
     * 랜덤 베너형 설문(메인 화면)
     * - 베너형으로 설정된 설문 최대 5개를 추출하여 그중에 1개만 랜덤하게 표시하기 위함
     * </pre>
     */
    @RequestMapping(value = "INC_pollBanner.do", method = RequestMethod.GET)
    public void pollBanner(ModelMap model, HttpServletRequest request) {

        WebPollVO pollVo = new WebPollVO();

        List<WebPollVO> pollBannerList = webPollService.pollBannerList(pollVo);

        if(null != pollBannerList && !pollBannerList.isEmpty()) {
            int bannerCnt = pollBannerList.size();
            int randomNum = ((int) (Math.random() * 10) % bannerCnt);

            pollVo = pollBannerList.get(randomNum);
            List<WebPollGroupVO> pollGroupList = null;

            // 항목이 1개인 것만 사용시 주석 해제
            // if(pollVo.getGroupCnt() <= 1)
            pollGroupList = webPollService.pollGroupList(pollVo);

            // 중복 응답 여부를 확인
            /*
             * 중복 등록 확인 체크 결과 "Y" 값인 경우 설문 등록 페이지로 이동하므로 검증데이터를 추가로 View로 전달하여
             * 스크립트로 유효성 체크를 한다.
             */
            checkValidate(request, pollVo);
            /*
             * "Y" 값인 경우 설문등록 페이지로 이동하므로 검증데이터를 추가로 View로 전달하여 유효성 체크를 한다.
             */
            // if(pollVo.getValidCheck().equals("Y"))
            model.addAttribute("pollValidList", webPollService.pollValidList(pollVo));

            model.addAttribute("pollVo", pollVo);
            model.addAttribute("pollList", pollGroupList);
        }
    }

    /**
     * 기본정보 조회
     * 
     * @throws Exception
     */
    @RequestMapping(value = "BD_pollView.do", method = RequestMethod.GET)
    public void pollView(ModelMap model, HttpServletRequest request, WebPollVO webPollVo) {

        OpHelper.bindSearchMap(webPollVo, request);

        WebPollVO pollVo = webPollService.pollView(webPollVo);
        /*
         * 중복 등록 확인 체크 결과 "Y" 값인 경우 설문 등록 페이지로 이동하므로
         * 검증데이터를 추가로 View로 전달하여 스크립트로 유효성 체크를 한다.
         */
        checkValidate(request, pollVo);

        if(pollVo.getValidCheck().equals("Y")) {
            model.addAttribute("pollValidList", webPollService.pollValidList(webPollVo));
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, pollVo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, webPollService.pollGroupList(webPollVo));
    }

    /**
     * 설문결과 조회
     * 
     * @throws Exception
     */
    @RequestMapping(value = "BD_pollResult.do", method = RequestMethod.GET)
    public void pollResult(ModelMap model, HttpServletRequest request, WebPollVO webPollVo) {

        OpHelper.bindSearchMap(webPollVo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, webPollService.pollView(webPollVo));
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, webPollService.pollGroupList(webPollVo));
    }

    /**
     * 기타의견 또는 단답형 목록
     */
    @RequestMapping(value = "PD_pollCommentList.do", method = RequestMethod.GET)
    public void pollCommentList(ModelMap model, HttpServletRequest request,
        WebPollGroupVO pollGroupVO) {

        OpHelper.bindSearchMap(pollGroupVO, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, webPollService.pollCommentList(pollGroupVO));
    }

    /**
     * 설문참여
     * 
     * @throws NoKeyValueMappingException
     * @throws Exception
     */
    @RequestMapping(value = "pollResponse.do", method = RequestMethod.POST)
    public String pollResponse(ModelMap model, HttpServletRequest request, HttpServletResponse response, WebPollVO pollVo) throws Exception {

        OpHelper.bindSearchMap(pollVo, request);

        pollVo = webPollService.pollView(pollVo);
        // 중복 등록 유효성 체크
        checkValidate(request, pollVo);

        if("Y".equals(pollVo.getValidCheck())) {

            // 설문 참여 정보를 Map에 바인딩(DB 저장용 데이터)
            Map<String, Object> itemMap = RequestUtil.getRequestMap(request, PREFIX_POLLITEM_FIELD);
            itemMap.put("seq", pollVo.getSeq());

            UserLoginVO userVO = getLoginSession(request);

            if(null != userVO) {
                itemMap.put("registerType", "U");
                itemMap.put("regId", userVO.getUserId());
                itemMap.put("regNm", userVO.getUserNm());
            } else {
                itemMap.put("registerType", "A");
            }
            itemMap.put("ipAddr", request.getRemoteAddr());

            webPollService.pollResponse(itemMap);

            // 설문 중복 체크 방식이 쿠키인경우
            if(Validate.isNotEmpty(pollVo.getDupCheck()) && "C".equals(pollVo.getDupCheck())) {

                String cookieVal = CookieUtil.getCookie(request, POLL_COOKIE_NAME_PREFIX + pollVo.getSeq());
                Integer cookieCnt = 0;
                if(Validate.isNotEmpty(cookieVal)) {
                    cookieCnt = Integer.valueOf(cookieVal);
                    cookieCnt++;
                }
                // 1개월간 유지되는 쿠키 생성
                CookieUtil.setCookie(response, POLL_COOKIE_NAME_PREFIX + pollVo.getSeq(), cookieCnt.toString(), 43200);
            }

            return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), "BD_pollList.do");
        }

        return alertAndRedirect(model, MessageHelper.getMsg(request, "processFail"), "BD_pollList.do");
    }

    /**
     * 중복 등록 체크(회원, IP, Cookie 설정을 기반으로 함)
     */
    private void checkValidate(HttpServletRequest request, WebPollVO pollVo) {

        UserLoginVO userVO = getLoginSession(request);

        // 중복 응답 여부를 확인
        pollVo.setValidCheck("Y");

        // 참여 제한이 없는 경우 검증을 하지 않음 '0' 인경우 무제한 참여
        if(pollVo.getLimitCnt() > 0) {
            /*
             * 설문이 진행중인 경우라면 설문 중복응답 차단 설정을 한다.
             * 설문기간이 만료되거나 중복 응답인 경우 설문 결과 화면을 표시
             */
            if("Y".equals(pollVo.getStartYn()) && "N".equals(pollVo.getEndYn())) {
                /*
                 * DB에 중복 여부를 질의하지 않아도 되는 케이스를 위해 false 가 되는 경우는 질의를 하지 않음.
                 * U : 회원, I : IP Address, C : Cookie 기타
                 */
                boolean needCheck = true;

                WebPollResponseVO pollResponseVo = new WebPollResponseVO();
                pollResponseVo.setSeq(pollVo.getSeq());

                if("Y".equals(pollVo.getDupYn())) {

                    if("U".equals(pollVo.getDupCheck())) {
                        if(null == userVO) {
                            pollVo.setValidCheck("N");
                            pollVo.setUserYn("N");
                            needCheck = false;
                        } else {
                            pollResponseVo.setRegId(userVO.getUserId());
                            pollVo.setUserYn("Y");
                        }
                    } else if("I".equals(pollVo.getDupCheck())) {

                        pollResponseVo.setIpAddr(request.getRemoteAddr());
                    } else if("C".equals(pollVo.getDupCheck())) {
                        try {

                            String cookieVal = CookieUtil.getCookie(request, POLL_COOKIE_NAME_PREFIX + pollVo.getSeq());
                            Integer cookieCnt = 0;
                            if(Validate.isNotEmpty(cookieVal)) {
                                cookieCnt = Integer.valueOf(cookieVal);
                            }

                            if(cookieCnt >= pollVo.getLimitCnt()) {
                                pollVo.setValidCheck("N");
                            }
                        } catch (Exception e) {
                            /* do Nothing */
                        }

                        needCheck = false;
                    }

                    if(needCheck) {
                        List<WebPollResponseVO> responseHist = webPollService.pollResponseList(pollResponseVo);

                        if(Validate.isNotEmpty(responseHist)) {
                            int histCnt = responseHist.size();
                            if(histCnt >= pollVo.getLimitCnt()) {
                                pollVo.setValidCheck("N");
                            }
                        }
                    }
                }
            } else if("Y".equals(pollVo.getEndYn())) {
                pollVo.setValidCheck("N");
            }
        }
    }
}
