/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.validate;

import zes.base.taglib.SalmonTagSupport;

/**
 * <code>Validating Javascript</code> 생성
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
public class ValidateScriptTag extends SalmonTagSupport {

    /** <code>Javascript</code> 유형 */
    private static enum SCRIPT_TYPE {
        alert("validate/validateAlert.jsp"),
        msgbox("validate/validateMsgBox.jsp"),
        jquery("validate/validateJquery.jsp");

        /** 항목에 따른 jsp 페이지 */
        private String jsp;

        /**
         * 항목에 해당 jsp 설정
         * 
         * @param jsp
         */
        SCRIPT_TYPE(String jsp) {
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

    /** 기본 스크립트 유형 */
    private SCRIPT_TYPE type = SCRIPT_TYPE.alert;

    /**
     * Javascript 유형을 설정
     * 
     * <pre>
     * alert : alert("메시지"); 
     * msgbox : jsErrorBox("메시지"); 레이어 유형
     * jquery : jquery.validate.js 파일의 검증 스크립트를 사용
     * </pre>
     * 
     * @param type 을(를) String type로 설정
     */
    public void setType(String type) {

        if(SCRIPT_TYPE.valueOf(type) != null) {
            this.type = SCRIPT_TYPE.valueOf(type);
        }
        this.page = this.type.getJsp();
    }

    @Override
    protected String getPage() {
        if(this.page == null) {
            return this.type.getJsp();
        }

        return this.page;
    }

}
