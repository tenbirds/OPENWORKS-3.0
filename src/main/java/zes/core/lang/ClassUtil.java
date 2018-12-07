/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang;

import java.lang.reflect.Constructor;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <code>Class</code> 관련 Util Class
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
 *  2012. 3. 2.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ClassUtil {

    /** 로깅 */
    private static Logger logger = LoggerFactory.getLogger(ClassUtil.class);

    /** 기본형 클레스 */
    private static final HashMap<Class<?>, Class<?>> primitiveWrapperMap = new HashMap<Class<?>, Class<?>>();
    static {
        primitiveWrapperMap.put(Boolean.TYPE, Boolean.class);
        primitiveWrapperMap.put(Byte.TYPE, Byte.class);
        // primitiveWrapperMap.put(Character.TYPE, Character.class);
        primitiveWrapperMap.put(Short.TYPE, Short.class);
        primitiveWrapperMap.put(Integer.TYPE, Integer.class);
        primitiveWrapperMap.put(Float.TYPE, Float.class);
        primitiveWrapperMap.put(Double.TYPE, Double.class);
        primitiveWrapperMap.put(Long.TYPE, Long.class);
    }

    /** 기본형 렙핑 클레스 */
    private static final HashMap<Class<?>, Constructor<?>> constructorMap = new HashMap<Class<?>, Constructor<?>>();
    static {
        /* 기본 생성자 설정 */
        Class<?>[] args = { String.class };
        for(Class<?> primitiveClass : primitiveWrapperMap.keySet()) {
            Class<?> wrapperClass = primitiveWrapperMap.get(primitiveClass);
            try {
                constructorMap.put(primitiveClass, wrapperClass.getDeclaredConstructor(args));
            } catch (NoSuchMethodException e) {
                if(logger.isDebugEnabled()) {
                    logger.debug("DeclaredConstructor failed", e);
                }
            }
        }
    }

    /**
     * 기본형 데이터 타입 값을 위한 Constructor 생성
     * 
     * @param fieldType <code>Field</code> 유형
     * @param fieldValue <code>Field</code> 값
     * @return fieldType에 따른 Constructor
     */
    public static Object getPrimitiveConstructor(Class<?> fieldType, final Object fieldValue) {

        Object constructorObj = null;

        if(fieldType.isPrimitive() && fieldValue != null) {
            try {
                if(!fieldType.equals(char.class)) {
                    constructorObj = constructorMap.get(fieldType).newInstance(
                        new Object[] { fieldValue });
                } else {
                    constructorObj = new Character(((String) fieldValue).charAt(0));
                }
            } catch (Exception e) {
                if(logger.isDebugEnabled()) {
                    logger.debug("newInstance failed", e);
                }
            }
        }

        return constructorObj;
    }

    /**
     * <code>Object</code> 데이터 타입 값을 위한 Constructor 생성
     * 
     * @param fieldType <code>Field</code> 유형
     * @param fieldValue <code>Field</code> 값
     * @return fieldType에 따른 Constructor
     */
    public static Object getObjectConstructor(Class<?> fieldType, final Object fieldValue) {

        Object ObjectInstanse = null;
        Class<?>[] args = { String.class };

        try {
            Constructor<?> constructor = fieldType.getDeclaredConstructor(args);
            ObjectInstanse = constructor.newInstance(new Object[] { fieldValue });
        } catch (Exception e) {}

        return ObjectInstanse;
    }
}
