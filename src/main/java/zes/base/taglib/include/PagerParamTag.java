/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.include;

import java.util.HashMap;
import java.util.Map;

import zes.base.taglib.SalmonTagSupport;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;

/**
 * 목록 페이징 태그. <code>Pager</code> 객체를 입력받아 페이징 UI를 생성한다.
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
 *  2012. 3. 5.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class PagerParamTag extends SalmonTagSupport {

    /** 페이징 번호 */
    private final int[] RPP_NUM = GlobalConfig.DEFAULT_PAGE_NUMS;

    /** 미지정 시 기본 JSP 템플릿 */
    private static final String LIST_JSP = "param/listPagerParam.jsp";
    /** 팝업 화면 목록 JSP 템플릿 */
    private static final String POPUP_LIST_JSP = "param/popupListPagerParam.jsp";
    /** 상세(수정등 포함) 화면 기본 JSP 템플릿 */
    private static final String VIEW_JSP = "param/viewPagerParam.jsp";
    /** 페이징 관련 타이틀 */
    private String title = "";
    /** 기본 값은 목록 형 */
    private VIEW_TYPE view = VIEW_TYPE.list;
    /** 무시할 파라미터 명 */
    private Map<String, Boolean> ignore = new HashMap<String, Boolean>();

    /** 뷰 페이지 유형 */
    private static enum VIEW_TYPE {
        /** 목록형 */
        list(LIST_JSP),

        /** 팝업 화면 목록형 */
        plist(POPUP_LIST_JSP),

        /** 상세형(등록, 수정 포함) */
        view(VIEW_JSP);

        /** 항목에 따른 jsp 페이지 */
        private String jsp;

        /**
         * 항목에 해당 jsp 설정
         * 
         * @param jsp
         */
        VIEW_TYPE(String jsp) {
            this.jsp = jsp;
        }

        /**
         * 항목별 jsp 반환
         * 
         * @return
         */
        public String getJsp() {
            return jsp;
        }
    }

    /**
     * title을 설정
     * 
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * view을 설정
     * 
     * @param view 을(를) String view로 설정
     */
    public void setView(String view) {

        if(VIEW_TYPE.valueOf(view) != null) {
            this.view = VIEW_TYPE.valueOf(view);
        }
        this.page = this.view.getJsp();
    }

    /**
     * 자동화된 질의 파라미터에서 특정 파라미터를 제거할때 사용함.
     * 
     * @param ignoreParams 제거할 파라미터 ','로 구분하여 나열
     */
    public void setIgnores(String ignores) {
        if(Validate.isNotEmpty(ignores)) {
            ignores = StringUtil.deleteWhitespace(ignores);
            String[] arrIgnore;
            if(ignores.indexOf(",") >= 0) {
                arrIgnore = ignores.split(",");
            } else {
                arrIgnore = new String[] { ignores };
            }
            for(String strIgnore : arrIgnore) {
                this.ignore.put(strIgnore, Boolean.TRUE);
            }
        }
    }

    @Override
    public String getPage() {
        if(this.page == null) {
            return this.view.getJsp();
        }

        return this.page;
    }

    @Override
    public void beforeTag() {
        addAttribute("ignores", this.ignore);

        if(!VIEW_TYPE.view.equals(this.view)) {
            addAttribute("RPP_NUM", RPP_NUM);
            addAttribute("paggingTitle", this.title);
        }
    }
}
