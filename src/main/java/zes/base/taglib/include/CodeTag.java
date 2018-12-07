/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.include;

import java.io.IOException;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.support.WebApplicationContextUtils;

import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.code.CodeCtgVO;
import zes.openworks.intra.code.CodeDAO;
import zes.openworks.intra.code.CodeVO;

/**
 * <pre>
 * 코드 데이터를 기준으로 html 코드를 생성한다.
 * 코드는 select, radio, checkbox 를 지원한다.
 * </pre>
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
public class CodeTag extends SimpleTagSupport {

    /** SL4J 로깅 */
    private static Logger logger = LoggerFactory.getLogger(CodeTag.class);

    /** 그룹 코드 */
    private Integer grpCd;
    /** 카테고리 코드 */
    private String ctgCd;
    /** HTML 기준 radio, checkbox, select 중 선택 */
    private TAG_TYPE type = TAG_TYPE.select;
    /** 고유 식별자 */
    private String id;
    /** 기본 선택될 값들 */
    private Object defaultValues;
    /** Only 셀렉트 박스 - 첫번째 옵션 라벨 */
    private String defaultLabel = GlobalConfig.SELECT_TEXT;
    /** 셀렉트 박스의 크기 설정 */
    private String size;
    /** 셀렉트 박스의 title 설정 */
    private String title;
    /** 셀렉트 박스의 name 설정 */
    private String name;
    /** 기타 옵션 Attributes */
    private String option;
    /** javascript onclick event 발생시 적용할 메소드 */
    private String onclick;
    /** javascript onchange event 발생시 적용할 메소드 */
    private String onchange;
    /** 기본 선택값 */
    private Integer[] arrayDefaultValues;
    /** 코드 목록 */
    private List<CodeVO> codeList;
    /** 언어 코드 */
    private String langCode;

    /**
     * html tag 코드
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
    enum TAG_TYPE {
        select, radio, checkbox
    }

    /**
     * 코드목록으로 html tag를 생성한다.
     */
    @Override
    public void doTag() throws JspException, IOException {
        JspWriter writer = getJspContext().getOut();

        this.arrayDefaultValues = getDefaultValues();
        try {
            this.codeList = getCodeList(langCode);
        } catch (Exception e) {
            writer.write("<div class=\"error\">" + e.toString() + "</div>");
            return;
        }

        if(Validate.isEmpty(codeList)) {
            writer.write("<div class=\"error\">[" + grpCd + "]에 해당하는 공통코드 정보가 없습니다.</div>");
            return;
        }

        if(TAG_TYPE.select.equals(type)) {
            writer.write(createSelectTag());
        } else if(TAG_TYPE.radio.equals(type) || TAG_TYPE.checkbox.equals(type)) {
            writer.write(createRadioOrCheckTag());
        } else {
            writer.write(StringUtil.EMPTY);
        }
    }

    /**
     * select tag html 생성
     * 
     * @return
     */
    private String createSelectTag() {
        StringBuilder html = new StringBuilder();

        if(Validate.isNotEmpty(name)) {
            html.append("<select name=\"" + name + "\" ");
        }else{
            html.append("<select name=\"" + id + "\" ");
        }
        html.append("id=\"" + id + "\"");
        if(Validate.isNotEmpty(size)) {
            html.append(" size=\"" + size + "\"");
        }
        if(Validate.isNotEmpty(title)) {
            html.append(" title=\"" + title + "\"");
        }
        if(Validate.isNotEmpty(onchange)) {
            html.append(" onchange=\"" + onchange + "\"");
        }
        if(Validate.isNotEmpty(option)) {
            html.append(" " + option);
        }
        html.append(">\n");

        if(Validate.isNotEmpty(defaultLabel)) {
            html.append("<option value=\"\">" + defaultLabel + "</option>\n");
        }

        for(CodeVO bean : codeList) {
            html.append("<option value=\"" + bean.getPrvCd() + "\" ");
            if(hasValue(bean.getPrvCd())) {
                html.append("selected=\"selected\"");
            }
            html.append(">" + bean.getPrvNm() + "</option>\n");
        }
        html.append("</select>\n");

        return html.toString();
    }

    /**
     * input radio 또는 checkbox tag html 생성
     * 
     * @return
     */
    private String createRadioOrCheckTag() {
        int idSeq = 1;
        String eleType = null;
        String eleId = null;

        if(TAG_TYPE.radio.equals(type)) {
            eleType = "radio";
            eleId = "_rb_";
        } else {
            eleType = "checkbox";
            eleId = "_cb_";
        }

        StringBuilder html = new StringBuilder();

        for(CodeVO bean : codeList) {
            String __id = id + eleId + (idSeq++);

            html.append("<input type=\"" + eleType + "\"");
            html.append(" name=\"" + id + "\"");
            html.append(" id=\"" + __id + "\"");
            html.append(" value=\"" + bean.getPrvCd() + "\"");
            if(hasValue(bean.getPrvCd())) {
                html.append(" checked=\"checked\"");
            }
            if(Validate.isNotEmpty(onclick)) {
                html.append(" onclick=\"" + onclick + "\"");
            }
            if(Validate.isNotEmpty(option)) {
                html.append(" " + option);
            }
            html.append("/>");
            html.append("<label for=\"" + __id + "\">");
            html.append(bean.getPrvNm() + "</label>\n");
        }

        return html.toString();
    }

    /**
     * 지정된 값 존재여부
     * 
     * @param compareValue
     * @return
     */
    private boolean hasValue(Integer compareValue) {
        if(Validate.isEmpty(arrayDefaultValues)) {
            return false;
        }
        for(int i = 0 ; i < arrayDefaultValues.length ; i++) {
            if(compareValue.intValue() == arrayDefaultValues[i].intValue()) {
                return true;
            }
        }
        return false;
    }

    /**
     * 코드 목록을 가져 온다
     * 
     * @return
     */
    private List<CodeVO> getCodeList(String langCode) {
        ServletConfig cfg = (ServletConfig) getJspContext().getAttribute(PageContext.CONFIG, PageContext.PAGE_SCOPE);
        CodeDAO codeDao = (CodeDAO) WebApplicationContextUtils.getWebApplicationContext(cfg.getServletContext()).getBean("codeDAO");

        if(Validate.isNotEmpty(ctgCd)) {
            CodeCtgVO vo = new CodeCtgVO();
            vo.setLangCode(langCode);
            vo.setGrpCd(grpCd);
            vo.setCtgCd(ctgCd);
            return codeDao.prvNmForCtgCd(vo);
        }

        return codeDao.codeList(langCode, grpCd);
    }

    /**
     * 기본 값 목록
     * 
     * @return
     */
    private Integer[] getDefaultValues() {
        Integer[] arrayDefaultValues = null;

        if(defaultValues instanceof Collection<?>) {
            @SuppressWarnings("unchecked")
            List<Integer> list = (List<Integer>) defaultValues;
            arrayDefaultValues = list.toArray(new Integer[list.size()]);
        } else if(defaultValues instanceof Integer[]) {
            arrayDefaultValues = (Integer[]) defaultValues;
        } else if(defaultValues instanceof Integer) {
            arrayDefaultValues = new Integer[1];
            arrayDefaultValues[0] = (Integer) defaultValues;
        } else if(defaultValues instanceof String) {
            String value = (String) defaultValues;
            String[] values = StringUtil.trim(value).split(",");
            if(Validate.isNotEmpty(values)) {
                arrayDefaultValues = new Integer[values.length];
                for(int i = 0 ; i < values.length ; i++) {
                    try {
                        if(Validate.isNotEmpty(values[i])) {
                            arrayDefaultValues[i] = Integer.parseInt(StringUtil.trim(values[i]));
                        } else {
                            arrayDefaultValues[i] = 0;
                        }
                    } catch (Exception e) {
                        if(logger.isDebugEnabled()) {
                            logger.debug("create default value failed", e);
                        }
                        arrayDefaultValues[i] = -1;
                    }
                }
            }
        } else {
            arrayDefaultValues = new Integer[0];
        }

        return arrayDefaultValues;
    }

    /**
     * 그룹코드 설정
     * 
     * @param grpCd
     */
    public void setGrpCd(Integer grpCd) {
        this.grpCd = grpCd;
    }

    /**
     * 그룹코드 설정
     * 
     * @param grpCd
     */
    public void setCtgCd(String ctgCd) {
        this.ctgCd = ctgCd;
    }

    /**
     * html tag 설정
     * 
     * @param type
     */
    public void setType(String type) {
        this.type = TAG_TYPE.valueOf(type);
    }

    /**
     * html tag의 고유 id 설정
     * 
     * @param id
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * select tag의 첫 선택 항목의 텍스트
     * 
     * @param defaultLabel
     * @see
     */
    public void setDefaultLabel(String defaultLabel) {
        this.defaultLabel = defaultLabel;
    }

    /**
     * 기본 선택 값 설정
     * 
     * @param defaultValues
     */
    public void setDefaultValues(Object defaultValues) {
        this.defaultValues = defaultValues;
    }

    /**
     * javascript onclick 이벤트시 실행될 메소드 명
     * 
     * @param onclick
     */
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }

    /**
     * javascript onchange 이벤트시 실행될 메소드 명
     * 
     * @param onclick
     */
    public void setOnchange(String onchange) {
        this.onchange = onchange;
    }

    /**
     * select tag에서만 사용되며 화면에 표시될 크기 설정
     * 
     * @param size
     */
    public void setSize(String size) {
        this.size = size;
    }

    /**
     * 적용 html tag에 설정할 추가 속성
     * 예) class="design"
     * 
     * @param option
     */
    public void setOption(String option) {
        this.option = option;
    }

    /**
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    
    /**
     * String title을 반환
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    
    /**
     * title을 설정
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }
}
