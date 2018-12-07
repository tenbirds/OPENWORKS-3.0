/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;

/**
 * 목록형 출력시 데이터가 없는 경우 목록 하단에 메시지를 자동으로 생성
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
 *  2012. 3. 15.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class NoDataTag extends SimpleTagSupport {

    private Object obj;
    private String colspan = "1";
    private String msg = Config.getString("msg.noData", "데이터가 존재하지 않습니다.");

    /**
     * 테이블 컬럼수를 입력받아서 레코드를 생성한다.
     * <p />
     * &lt;tr&gt;&lt;td colspan="입력값"&gt;데이터가 존재하지 않습니다.&lt;/td&gt;&lt;/tr&gt;
     */
    @Override
    public void doTag() throws JspException, IOException {

        if(obj == null) {
            return;
        }

        JspWriter writer = getJspContext().getOut();

        if(obj instanceof Pager) {
            List<?> list = ((Pager<?>) obj).getList();
            if(list == null || list.size() > 0) {
                return;
            }
        } else if(obj instanceof List<?>) {
            List<?> list = (List<?>) obj;
            if(list == null || list.size() > 0) {
                return;
            }
        } else if(obj instanceof Object[]) {
            Object[] oArray = (Object[]) obj;
            if(oArray == null || oArray.length > 0) {
                return;
            }
        } else {
            return;
        }

        StringBuilder html = new StringBuilder();

        html.append("<tr>\n");
        html.append("<td class=\"no-data lr_none\"");
        if(Validate.isDigits(colspan)) {
            html.append(" colspan=\"" + colspan + "\"");
        }
        html.append("><span>" + msg + "</span></td>\n");
        html.append("</tr>\n");

        writer.write(html.toString());
    }

    /**
     * 목록 객체
     * 
     * @param obj
     */
    public void setObj(Object obj) {
        this.obj = obj;
    }

    /**
     * &lt;td&gt; colspan 값 설정
     * 
     * @param colspan
     */
    public void setColspan(String colspan) {
        this.colspan = colspan;
    }

    /**
     * 별도의 메시지로 정의 하는 경우 메시지 지정
     * 
     * @param msg
     */
    public void setMsg(String msg) {
        this.msg = msg;
    }
}
