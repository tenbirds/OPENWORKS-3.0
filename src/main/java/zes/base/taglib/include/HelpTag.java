/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.include;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import zes.core.lang.Validate;
import zes.core.spi.oscache.Cache;
import zes.openworks.common.cache.MenuHelpCache;
import zes.openworks.intra.help.HelpVO;

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
 *  2013. 5. 3.    neteran   신규 생성
 * </pre>
 * @see
 */
public class HelpTag extends SimpleTagSupport {

    /** 메뉴 코드 */
    private String menuCd;
    /** 도움말 목록 */
    private HashMap<String, HelpVO> helpMap;

    /**
     * 도움말목록으로 html tag를 생성한다.
     */
    @Override
    public void doTag() throws JspException, IOException {
        JspWriter writer = getJspContext().getOut();

        try {
            this.helpMap = helpInfoMap();
        } catch (Exception e) {
            writer.write(e.toString() + "<br />");
            return;
        }

        if(Validate.isEmpty(helpMap)) {
            writer.write("<h4 class=\"tx_13\">도움말정보가 없습니다. 도움말을 등록해 주세요.</h4>" + "<br />");
            return;
        } else {
            writer.write(createHelpTag());
        }
    }

    /**
     * 도움말 html 생성
     * 
     * @return
     */
    private String createHelpTag() {
        StringBuilder html = new StringBuilder();

        HelpVO helpVo = new HelpVO();
        if(helpMap.get(menuCd) != null) {
            helpVo = helpMap.get(menuCd);
            if(helpVo.getContents() != null) {
                html.append("<h4 class=\"tx_13\">" + helpVo.getContents() + "</h4>");
            } else {
                html.append("<h4 class=\"tx_13\">[" + helpVo.getMenuNm() + "]메뉴의 도움말 내용이 없습니다.</h4>");
            }
        } else {
            html.append("<h4 class=\"tx_13\">해당메뉴로 등록된 도움말정보가 없습니다.</h4>");
        }
        html.append("<br />");

        return html.toString();
    }

    /**
     * 도움말 목록을 가져 온다
     * cache에서 추출
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    private HashMap<String, HelpVO> helpInfoMap() {
        // 케쉬에서 도움말 Map을 가져 온다.
        String cacheKey = MenuHelpCache.CACHE_KEY;
        HashMap<String, HelpVO> menuHelpMap = (HashMap<String, HelpVO>) Cache.get(cacheKey);

        return menuHelpMap;
    }

    /**
     * 메뉴코드 설정
     * 
     * @param menuCd
     */
    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }
}
