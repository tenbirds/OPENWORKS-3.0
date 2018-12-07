/*
\ * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.support;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.module.sitemesh.Config;
import com.opensymphony.module.sitemesh.Decorator;
import com.opensymphony.module.sitemesh.DecoratorMapper;
import com.opensymphony.module.sitemesh.Page;
import com.opensymphony.module.sitemesh.mapper.AbstractDecoratorMapper;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.spi.oscache.Cache;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.cache.CmsCache;
import zes.openworks.intra.cms.CmsConstant;
import zes.openworks.intra.cms.CmsUserGradeVO;
import zes.openworks.intra.cms.CmsVO;
import zes.openworks.intra.cms.content.ContentVO;
import zes.openworks.web.login.UserLoginVO;

/**
 * 기본 세션 데코레이터를 CMS 구조에 맞도록 확장
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
public class CmsDecoratorMapper extends AbstractDecoratorMapper {

    /** CmsDecoratorMapper.class logger */
    private static Logger logger = LoggerFactory.getLogger(CmsDecoratorMapper.class);
    /** 데코레이터 파라미터명 */
    private static final String DECORATOR_PARAMETER = CmsConstant.DECORATOR_NAME;
    /** 사용자 이용권한이 없는 경우 이동 페이지 */
    public static final String NO_AUTH_PAGE = "NoAuth";
    /** 사용자 이용권한 명칭 */
    private static final String USER_GRADE_INFO = "userGradeInfo";
    private static final String NO_SESSION = "회원전용 서비스입니다.";

    @Override
    public void init(Config config, Properties properties, DecoratorMapper parent) throws InstantiationException {
        super.init(config, properties, parent);
    }

    @Override
    public Decorator getDecorator(HttpServletRequest request, Page page) {

        String decorator = null;

        String reqUri = request.getRequestURI();

        if(reqUri.endsWith("PD_LayoutPreView.do") || reqUri.endsWith("PD_ContentPreView.do")) {
            decorator = setPreViewDecorator(request);

            if(logger.isDebugEnabled()) {
                logger.debug("setPreViewDecorator is ==> " + request.getParameter("q_layoutCode"));
            }

        } else if(!reqUri.startsWith("/intra/") && !reqUri.startsWith("/component/")) {

            decorator = setMenuDecorator(request, null);
        }

        Decorator result = null;
        if(decorator != null) {
            result = getNamedDecorator(request, decorator);
        }

        return result == null ? super.getDecorator(request, page) : result;
    }

    /**
     * 미리보기 데코레이터를 설정
     *
     * @param request
     */
    private String setPreViewDecorator(HttpServletRequest request) {

        String layoutCode = request.getParameter("q_layoutCode");
        String userMenuUrl = request.getParameter("userMenuUrl");
        ContentVO contentVo = (ContentVO) request.getAttribute("dataVo");

        if(null == userMenuUrl && null != contentVo) {
            userMenuUrl = contentVo.getUserMenuUrl();
        }

        if(Validate.isEmpty(layoutCode)) {
            return null;
        }

        if(Validate.isNotEmpty(userMenuUrl)) {

            return setMenuDecorator(request, userMenuUrl);
        } else {
            HttpSession hs = request.getSession();
            hs.setAttribute(CmsConstant.DECORATOR_MENU, request.getParameter("q_layoutCode"));

            return DECORATOR_PARAMETER;
        }

    }

    /**
     * 실 사용자 메뉴 데코레이터를 설정
     *
     * @param request
     */
    @SuppressWarnings("unchecked")
    private String setMenuDecorator(HttpServletRequest request, String userMenuUrl) {

        HttpSession hs = request.getSession();
        String reqUri = userMenuUrl;


        if(Validate.isEmpty(reqUri)) {
            reqUri = request.getRequestURI();
        }

        if(reqUri.indexOf("jsessionid") > -1) {
            reqUri = reqUri.substring(0, reqUri.indexOf(";jsessionid"));
        }

        String domainNm = request.getServerName();
        /*
         * QueryString()으로는 post 형식의 메뉴를 매핑 할 수 없으므로 만들어 낸다.
         */
        String enumStr = "";
        Enumeration<String> enumer = request.getParameterNames();

        StringBuilder sb = new StringBuilder();

        while(enumer.hasMoreElements()) {
            enumStr = enumer.nextElement();
            // 30 이상은 필요 없는 데이터라 판정하여 생성하지 않는다.
            if(request.getParameter(enumStr).length() < 30 && !"targetUrl".equals(enumStr)) {
                sb.append(enumStr).append("=").append(request.getParameter(enumStr)).append("&");
            }
        }

        if(!enumStr.equals("")) {
            sb.insert(0, reqUri + "?");
        } else {
            sb.append(reqUri);
        }

        String reqUrl = sb.toString();
        String contextPath = request.getContextPath();

        reqUrl = reqUrl.replaceFirst(contextPath, "");

        CmsVO cmsVo = null;

        try {
            // 케쉬에서 사용자메뉴 Map을 가져 온다.
            String cacheKey = domainNm + CmsCache.ALL_MENU_MAP;
            HashMap<String, CmsVO> userAllMenuMap = (HashMap<String, CmsVO>) Cache.get(cacheKey);

            if(userAllMenuMap == null) {
                return null;
            }

            Iterator<String> it = userAllMenuMap.keySet().iterator();

            int idx = 0;
            boolean find = false;

            String menuUrl = "";
            String[] arrMenu = { "", "" };

            List<String> userMenuUrls = null;
            List<String> subMenuUrl = null;

            cmsVo = userAllMenuMap.get(reqUri);
            /*{{ BH, 2015.11.19, 도메인관리 삭제로 인한 변경 */
             hs.setAttribute(CmsConstant.DOMAIN_NAME, GlobalConfig.DOMAIN_SUBNM);
            //}}
            if(Validate.isEmpty(cmsVo)) {
                while(it.hasNext()) {
                    menuUrl = it.next();

                    if(Validate.isNotEmpty(menuUrl)) {
                        cmsVo = userAllMenuMap.get(menuUrl);
                        subMenuUrl = cmsVo.getSubMenuUrl();

                        userMenuUrls = new ArrayList<String>();
                        userMenuUrls.add(menuUrl);

                        if(null != subMenuUrl) {
                            userMenuUrls.addAll(subMenuUrl);
                        }

                        for(String url : userMenuUrls) {
                            if(reqUri.equals(url)) {
                                find = true;
                                break;
                            } else {
                                idx = url.indexOf("?");
                                if(idx > -1) {
                                    find = true;
                                    arrMenu[0] = url.substring(0, idx);
                                    arrMenu[1] = url.substring(idx + 1);
                                    if(reqUrl.indexOf(arrMenu[0]) > -1) {
                                        String[] arrRequestParam = arrMenu[1].split("&");
                                        for(String requestParam : arrRequestParam) {
                                            if(!(reqUrl.indexOf(requestParam) > -1)) {
                                                find = false;
                                                break;
                                            }
                                        }
                                        if(find) {
                                            break;
                                        }
                                    } else {
                                        find = false;
                                    }
                                }
                            }
                        }

                        // 해당 메뉴를 찾았다면 중지, 못찾았다면 확인 대상 메뉴 VO 초기화
                        if(find) {
                            break;
                        } else {
                            cmsVo = null;
                        }
                    }
                }
            }

            // 사용자 권한 확인 후 권한이 없는 경우 컨텐츠를 보여주지 않는다.
            if(Validate.isNotEmpty(cmsVo)) {
                List<CmsUserGradeVO> cmsUserGrades = cmsVo.getUserGradeCd();

                if(Validate.isNotEmpty(cmsUserGrades)) {
                    UserLoginVO userLoginVo = OpHelper.getUserSession(request);

                    if(null == userLoginVo) {
                        request.setAttribute(USER_GRADE_INFO, NO_SESSION);
                        hs.setAttribute(CmsConstant.DECORATOR_MENU, NO_AUTH_PAGE);
                        return DECORATOR_PARAMETER;
                    }

                    boolean gradeTf = false;
                    String userGrade = userLoginVo.getUserGradCode();
                    String userGradeInfo = "";
                    for(CmsUserGradeVO cmsUserGrade : cmsUserGrades) {
                        userGradeInfo += "[" + cmsUserGrade.getUserGradeNm() + "]";

                        if(cmsUserGrade.getUserGradeCd().equals(userGrade)) {
                            gradeTf = true;
                            break;
                        }
                    }

                    if(!gradeTf) {
                        request.setAttribute(USER_GRADE_INFO, userGradeInfo);
                        hs.setAttribute(CmsConstant.DECORATOR_MENU, NO_AUTH_PAGE);
                        return DECORATOR_PARAMETER;
                    }
                }
            }

            // 사용자메뉴관리에 현재 메뉴가 존재하고, 레이아웃이 설정 되었으면 진행
            if(Validate.isNotEmpty(cmsVo) && Validate.isNotEmpty(cmsVo.getLayoutCode())) {

                // 현재 매뉴의 서브 메뉴 리스트를 케쉬에서 가져온다.
                cacheKey = domainNm + CmsCache.TOP_MENU_LIST;
                List<CmsVO> topMenuList = (List<CmsVO>) Cache.get(cacheKey);
                request.setAttribute("topMenuList", topMenuList);

                // 현재 매뉴의 서브 메뉴 리스트를 케쉬에서 가져온다.
                String topMenuCode = cmsVo.getTopMenuCode();

                cacheKey = domainNm + topMenuCode + CmsCache.TOP_MENU_VO;
                CmsVO userTopMenuVo = (CmsVO) Cache.get(cacheKey);
                if(Validate.isNotEmpty(userTopMenuVo)) {
                    List<CmsVO> subMenuList = userTopMenuVo.getChildList();
                    request.setAttribute("subMenuList", subMenuList);
                }

                // 현재 메뉴정보 및 테마 설정
                request.setAttribute("domainNm", domainNm);
                request.setAttribute("cmsVo", cmsVo);

                List<CmsVO> allSubList = (List<CmsVO>) Cache.get(domainNm + CmsCache.ALL_SUB_LIST);
                request.setAttribute("allSubMenuList", allSubList);
                List<CmsVO> allCtgList = (List<CmsVO>) Cache.get(domainNm + CmsCache.ALL_CTG_LIST);
                request.setAttribute("goodsSubMenuList", allCtgList);


                // Decorator 설정
                String decorator = "";
                if(Validate.isNotEmpty(cmsVo.getLayoutCode())) {
                    decorator = cmsVo.getLayoutCode();
                }

                hs.setAttribute(CmsConstant.DECORATOR_MENU, decorator);

                logger.info("===================================================================");
                logger.info("Content Decorator is ==> " + decorator);
                logger.info("===================================================================");

                return DECORATOR_PARAMETER;
            }

        } catch (Exception e) {
            logger.error("데코레이팅 오류 URL " + reqUrl, e);
        }

        return null;
    }

}
