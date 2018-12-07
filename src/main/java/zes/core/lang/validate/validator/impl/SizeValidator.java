/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate.validator.impl;

import java.lang.annotation.Annotation;

import zes.core.lang.Validate;
import zes.core.lang.validate.annotation.marker.Size;
import zes.core.lang.validate.validator.AbstractValidator;
import zes.core.lang.validate.validator.Validator;

/**
 * Collection 또는 배열 값의 길이를 확인
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
 *  2012. 3. 2.    방기배   신규 추가
 * </pre>
 * @see
 */
public class SizeValidator extends AbstractValidator {

    /** 최소값 */
    private Integer min;

    /** 최대값 */
    private Integer max;

    @Override
    public Validator setAnnotation(Annotation annotation) {

        Size anno = (Size) annotation;
        this.message = anno.message();
        this.min = anno.min();
        this.max = anno.max();

        String msg1 = String.valueOf(min);
        String msg2 = this.max < 0 ? "무제한" : String.valueOf(max);
        // 메시지 포멧용 데이터 설정
        this.validData = new String[] { msg1, msg2 };

        return this;
    }

    /**
     * 입력된 Collection 또는 배열 값의 길이를 확인
     */
    @Override
    protected boolean doValidate(Object propertyValue) {

        if(null == propertyValue || propertyValue.toString().length() == 0) {
            return true;
        }

        return Validate.isSizeMatch(propertyValue, min, max);
    }

}
