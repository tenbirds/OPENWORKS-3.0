/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.support;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import zes.base.pager.Pager;
import zes.base.vo.BaseVO;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.web.login.UserLoginVO;

/**
 * 프레임워크 지원 클레스
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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class OpHelper {

    /**
     * 관리자 세션정보 얻기
     * 
     * @param request
     * @return
     */
    public static LoginVO getMgrSession(HttpServletRequest request) {

        return (LoginVO) getSession(request, GlobalConfig.MGR_SESSION_KEY);
    }

    /**
     * 관리자 세션정보 얻기
     * 
     * @param session
     * @return
     */
    public static LoginVO getMgrSession(HttpSession session) {

        return (LoginVO) session.getAttribute(GlobalConfig.MGR_SESSION_KEY);
    }

    /**
     * 사용자 세션정보 얻기
     * 
     * @param request
     * @return
     */
    public static UserLoginVO getUserSession(HttpServletRequest request) {

        return (UserLoginVO) getSession(request, GlobalConfig.USER_SESSION_KEY);
    }

    /**
     * 사용자 세션정보 얻기
     * 
     * @param request
     * @return
     */
    public static LoginVO getUserSession(HttpSession session) {

        return (LoginVO) session.getAttribute(GlobalConfig.USER_SESSION_KEY);
    }

    /**
     * 세션정보 얻기
     * 
     * @param request
     * @param sessionKey
     * @return
     */
    public static Object getSession(HttpServletRequest request, String sessionKey) {

        return RequestUtil.getSessionAttribue(request, sessionKey);
    }

    /**
     * 모든 파라미터를 URL 형식으로 반환(GET,POST 모두)
     * 
     * @param request 요청객체
     * @return 키, 값으로 이루어진 QueryString
     */
    public static String getQueryString(HttpServletRequest request) {

        return RequestUtil.getQueryString(request);
    }

    /**
     * 모든 검색용 파라미터를 URL 형식으로 반환(GET,POST 모두)
     * 
     * @param request 요청객체
     * @return 키, 값으로 이루어진 QueryString
     */
    public static String getSearchQueryString(HttpServletRequest request) {

        return RequestUtil.getSearchQueryString(request);
    }

    /**
     * QueryString 문자열 중 특정 parameter의 값을 변경한다.
     * 
     * @param queryString
     * @param paramKey
     * @param paramValue
     * @return paramKey의 값이 paramValue의 값으로 대체된 결과 문자열 반환
     */
    public static String getReplaceParamValue(String queryString, String paramKey, Object paramValue) {

        return RequestUtil.getReplaceParamValue(queryString, paramKey, paramValue);
    }

    /**
     * 검색용 파라메타 정보를 맵에 담아 대상 VO 오브젝트에 설정
     * 
     * @param baseVo 파라미터 정보를 담을 VO 객체
     * @param request 요청객체
     */
    public static void bindSearchMap(BaseVO baseVo, HttpServletRequest request) {
        Map<String, Object> dataMap = RequestUtil.getSearchMap(request, false, Pager.DEFAULT_ROW_PER_PAGE, Pager.DEFAULT_PAGE_PER_PAGE);
        request.setAttribute("searchMap", dataMap);
        baseVo.setDataMap(dataMap);
    }

    /**
     * 검색용 파라메타 정보를 맵에 담아 대상 VO 오브젝트에 설정
     * 
     * @param baseVo 파라미터 정보를 담을 VO 객체
     * @param request 요청객체
     * @param sessionYn 세션정보 포함 여부
     */
    public static void bindSearchMap(BaseVO baseVo, HttpServletRequest request, boolean sessionYn) {
        OpHelper.bindSearchMap(baseVo, request, sessionYn, Pager.DEFAULT_ROW_PER_PAGE, Pager.DEFAULT_PAGE_PER_PAGE);
    }

    /**
     * 검색용 파라메타 정보를 맵에 담아 대상 VO 오브젝트에 설정
     * 
     * @param baseVo 파라미터 정보를 담을 VO 객체
     * @param request 요청객체
     * @param rowPerPage 페이지당 목록 수
     */
    public static void bindSearchMap(BaseVO baseVo, HttpServletRequest request, int rowPerPage) {
        OpHelper.bindSearchMap(baseVo, request, false, rowPerPage, Pager.DEFAULT_PAGE_PER_PAGE);
    }

    /**
     * 검색용 파라메타 정보를 맵에 담아 대상 VO 오브젝트에 설정
     * 
     * @param baseVo 파라미터 정보를 담을 VO 객체
     * @param request 요청객체
     * @param rowPerPage 페이지당 목록 수
     * @param pagePerPage 하단 페이지 목록 갯수
     */
    public static void bindSearchMap(BaseVO baseVo, HttpServletRequest request, int rowPerPage, int pagePerPage) {
        OpHelper.bindSearchMap(baseVo, request, false, rowPerPage, pagePerPage);
    }

    /**
     * 검색용 파라메타 정보를 맵에 담아 대상 VO 오브젝트에 설정
     * 
     * @param baseVo 파라미터 정보를 담을 VO 객체
     * @param request 요청객체
     * @param sessionYn 세션정보 포함 여부
     * @param rowPerPage 페이지당 목록 수
     * @param pagePerPage 하단 페이지 목록 갯수
     */
    public static void bindSearchMap(BaseVO baseVo, HttpServletRequest request, boolean sessionYn, int rowPerPage, int pagePerPage) {
        Map<String, Object> dataMap = RequestUtil.getSearchMap(request, sessionYn, rowPerPage, pagePerPage);
        request.setAttribute("searchMap", dataMap);
        baseVo.setDataMap(dataMap);
    }

    /**
     * 모든 파라메타 정보를 맵에 담아 대상 VO 오브젝트에 설정
     */
    public static void bindRequestMap(BaseVO baseVo, HttpServletRequest request) {
        bindRequestMap(baseVo, request, null);
    }

    /**
     * 파라메타 정보(prefix 로 시작하는 것만)를 맵에 담아 대상 VO 오브젝트에 설정
     */
    public static void bindRequestMap(BaseVO baseVo, HttpServletRequest request, String prefix) {
        Map<String, Object> requestMap = RequestUtil.getRequestMap(request, prefix);
        baseVo.setDataMap(requestMap);
    }

    /**
     * 권한정보 확인하기
     * @param vo
     * @return
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public static HashMap getMgrAuth(LoginVO vo) {
        
        HashMap authMap = new HashMap();
        
        //저장된 권한(3개)
        String[] authCd = {"omp_tot_adm"        //총괄관리자
                          ,"omp_gdcf_adm"       //서비스승인담당자
                          ,"omp_gdex_adm"       //서비스검토담당자
                          };
        
        //로그인ID의 권한과 저장된 권한 비교하기
        for(int i = 0; i < authCd.length; i++) {
            if(vo.getAuthType().indexOf(authCd[i]) > -1) {
                authMap.put(authCd[i], "Y");
            } else {
                authMap.put(authCd[i], "N");
            }
        }

        return authMap;
    }
    
}
