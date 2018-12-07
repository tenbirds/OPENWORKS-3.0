/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.validate;

import zes.base.taglib.SalmonTagSupport;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.validator.ValidateResult;
import zes.openworks.common.GlobalConfig;

/**
 * <code>Validate</code> 결과 또는 폼 페이지에 해당 입력 폼에 해당하는 메시지 출력
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
 *  2012. 3. 19.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see zes.core.lang.validate.ValidateResultHolder
 * @see zes.core.lang.validate.validator.ValidateResult
 * @see zes.core.lang.validate.validator.ValidTypeMsg
 */
public class ValidateMessageTag extends SalmonTagSupport {

    /** Validate 이후 설정 기본 값 속성명 */
    private static String KEY_VALIDATE = GlobalConfig.KEY_VALIDATE;
    /** 필드별 결과 Validate 속성명 */
    private static String KEY_VALIDATE_RESULT_KEY = GlobalConfig.KEY_VALIDATE_RESULT_KEY;
    /** JSP 페이지 */
    private static String JSP_PAGE = "validate/validateMessage.jsp";
    /** 입력 폼의 name 속성값 */
    private String name = "";

    /**
     * 입력폼 name을 설정
     * 
     * @param name 을(를) String name로 설정
     */
    public void setName(String name) {
        this.name = name;
    }

    @Override
    protected String getPage() {
        if(this.page == null) {
            return JSP_PAGE;
        }

        return this.page;
    }

    /**
     * 입력폼 name 명에 해당하는 검증 정보 및 검증 결과를 <code>HttpServletRequest</code> 객체에 추가
     */
    @Override
    protected void beforeTag() {

        ValidateResultHolder holder = (ValidateResultHolder) getAttribute(KEY_VALIDATE);
        if(holder != null) {
            ValidateResult result = holder.getResult(this.name);
            addAttribute(KEY_VALIDATE_RESULT_KEY, result);
        }
    }

}
