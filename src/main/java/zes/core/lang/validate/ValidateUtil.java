/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang.validate;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.core.lang.AnnotationUtil;
import zes.core.lang.FieldUtil;
import zes.core.lang.validate.annotation.ValidatorInfo;
import zes.core.lang.validate.validator.ValidatorFactory;

/**
 * 검증 툴을 이용하여 검증을 수행하고 결과를 반환한다.
 * <p />
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
public class ValidateUtil {

    /** 로깅 */
    private static Logger logger = LoggerFactory.getLogger(ValidateUtil.class);

    /**
     * 검증 수행 및 결과 반환
     * 
     * @param vo
     * @return
     */
    public static ValidateResultHolder validate(Object vo) {

        return doValidate(vo);
    }

    /**
     * 개별 필드 검증 수행 및 결과 반환
     * 
     * @param vo
     * @return
     */
    public static ValidateResultHolder validateField(Object vo, String fieldName) {

        return doFiledValidate(vo, fieldName);
    }

    /**
     * 유연성 확보를 위한 메소드
     * <p />
     * VO 객체 전체 검증 수행 및 결과 반환
     * 
     * @param vo
     * @return
     */
    private static ValidateResultHolder doValidate(Object vo) {

        // 전체 검증 결과 설정
        ValidateResultHolder validateHolder = new ValidateResultHolder();

        Field[] fields = FieldUtil.getFields(vo.getClass());

        for(Field field : fields) {
            if(field.isAccessible()) {
                setValidateResults(validateHolder, vo, field);
            }
        }
        return validateHolder;
    }

    /**
     * 개별 필드(파라미터) 검증결과 반환
     * 
     * @param vo
     * @param fieldName
     * @return
     */
    public static ValidateResultHolder doFiledValidate(Object vo, String fieldName) {

        // 전체 검증 결과 설정
        ValidateResultHolder validateHolder = new ValidateResultHolder();
        Field field = FieldUtil.getField(vo.getClass(), fieldName);

        if(field.isAccessible()) {
            setValidateResults(validateHolder, vo, field);
        }

        return validateHolder;
    }

    /**
     * 대상을 검증 후 결과를 담는다
     * 
     * @param validateHolder 결과 객체
     * @param vo 대상 Object
     * @param field 대상 field
     */
    private static void setValidateResults(ValidateResultHolder validateHolder, Object vo,
        Field field) {

        Annotation[] anotations = AnnotationUtil.getAnnotationsWidthFieldName(vo.getClass(),
            field.getName());

        if(anotations != null) {
            ValidateGroup group = new ValidateGroup();
            Object fieldValue = null;

            try {
                fieldValue = field.get(vo);
            } catch (Exception e) {
                fieldValue = "";
                logger.debug("{} 필드의 값을 읽을 수 없습니다. {}", field.getName(), e.getStackTrace());
            }
            for(Annotation anno : anotations) {
                if(isValidatorInfo(anno)) {
                    group.add(ValidatorFactory.getInstance(anno, vo));
                }
            }
            if(group.get().size() > 0) {
                boolean isValid = group.doValidte(field.getName(), fieldValue).isValid();
                if(!isValid) {
                    validateHolder.setValid(isValid);
                }

                validateHolder.addResult(field.getName(), group.getResult());
            }
        }
    }

    /**
     * 검증용 Field 인지 확인
     * 
     * @param anno
     * @return
     */
    public static boolean isValidatorInfo(Annotation anno) {

        return (anno.annotationType().getAnnotation(ValidatorInfo.class) != null);
    }
}
