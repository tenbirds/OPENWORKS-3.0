/*
 * Copyright (c) 2010 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.core.lang;

import java.lang.reflect.Array;
import java.util.Collection;

import zes.core.utils.StringUtil;

/**
 * 아래와 같은 코드 사용을 통일하여 검증에 따라서 적정한 <code>Exception</code>을 발생 시킨다.
 * 
 * <pre>
 * if(Object == null) {
 *     throw new Exception(&quot;INVALID_ARGUMENTS&quot;);
 * }
 * </pre>
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author 방기배
 * @history <pre>
 * << 개정이력(Modification Information) >>
 *   
 *     수정일       수정자    수정내용
 * --------------  --------  -------------------------------
 * 2012. 2. 26.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class AssertUtil {

    /**
     * 대상 객체가 <code>null</code>이 아니면 오류
     * 
     * @param obj null 체크 대상 객체
     * @param msg 오류 메시지
     * @throws IllegalArgumentException 대상이 <code>null</code>이 아닌 경우
     */
    public static void assertNull(Object obj, String msg) {
        if(obj != null) {
            throw new IllegalArgumentException(msg);
        }
    }

    /**
     * 대상 객체가 <code>null</code>이 아니면 오류
     * 
     * @param obj null 체크 대상 객체
     * @throws IllegalArgumentException 대상이 <code>null</code>이 아닌 경우
     */
    public static void assertNull(Object obj) {
        assertNull(obj, "[오류] 대상 객체는 null이 아닙니다. ");
    }

    /**
     * 객체 배열에 <code>null</code>이 아닌 항목이 있으면 오류
     * 
     * @param objs
     * @throws IllegalArgumentException 대상이 <code>null</code>이 아닌 항목이 있는 경우
     */
    public static void assertAllNull(Object[] objs) {
        assertNotNull(objs, "[오류] null 체크 대상 배열 객체가 null입니다.");
        int objLength = objs.length;
        for(int i = 0 ; i < objLength ; i++) {
            assertNull(objs[i], "[오류] null이 아닌 항목이 포함되어 있습니다.");
        }
    }

    /**
     * 대상 객체가 <code>null</code>이면 오류
     * 
     * @param obj null 체크 대상 객체
     * @param msg 오류 메시지
     * @throws IllegalArgumentException 대상 객체가 <code>null</code>인 경우
     */
    public static void assertNotNull(Object obj, String msg) {
        if(obj == null) {
            throw new IllegalArgumentException(msg);
        }
    }

    /**
     * 대상 객체가 <code>null</code>이면 오류
     * 
     * @param obj null 체크 대상 객체
     * @throws IllegalArgumentException 대상 객체가 <code>null</code>인 경우
     */
    public static void assertNotNull(Object obj) {
        assertNotNull(obj, "[오류] 대상 객체는 null 입니다.");
    }

    /**
     * 객체 배열이 <code>null</code>인 항목이 있으면 오류
     * 
     * @param objs
     * @throws IllegalArgumentException 대상이 <code>null</code>인 항목이 있는 경우
     */
    public static void assertAllNotNull(Object[] objs, String msg) {
        assertNotNull(objs, "[오류] null 체크 대상 배열 객체가 null입니다.");
        int objLength = objs.length;
        for(int i = 0 ; i < objLength ; i++) {
            assertNotNull(objs[i], "[오류] null인 항목이 포함되어 있습니다.");
        }
    }

    /**
     * 대상 객체가 <code>null</code> 또는, objectType과 유형이 다르면 오류
     * 
     * @param objectType obj 비교 유형
     * @param obj 비교할 <code>Object</code>
     * @param msg 오류 메시지
     * @throws IllegalArgumentException 대상 객체가 <code>null</code>이거나 유형이 다른 경우
     */
    public static void assertTypeEqual(Class<?> objectType, Object obj, String msg) {
        assertNotNull(obj, msg);
        if(!objectType.isInstance(obj)) {
            throw new IllegalArgumentException(msg);
        }
    }

    /**
     * 대상 객체가 <code>null</code>이 아니고, objectType과 유형이 다르면 오류
     * 
     * @param objectType obj 비교 유형
     * @param obj 비교할 <code>Object</code>
     * @throws IllegalArgumentException 대상 객체가 유형이 다른 경우
     */
    public static void assertTypeEqual(Class<?> objectType, Object obj) {
        assertTypeEqual(objectType, obj, "[오류] " + (obj != null ? obj.getClass().getName() : "null") + "은(는)"
            + objectType + " 유형이 아닙니다.");
    }

    /**
     * 대상 문자열이 숫자만(<code>Integer</code>)으로 되어 있지 않으면 오류
     * 
     * @param str <code>Integer</code>로 변환 체크 대상 문자열
     * @param msg 오류 메시지
     * @throws IllegalArgumentException <code>Integer.parseInt() </code>이 불가능 할
     *         경우
     */
    public static void assertNumber(String str, String msg) {
        assertNotNull(str);
        try {
            Integer.parseInt(str);
        } catch (Exception e) {
            throw new IllegalArgumentException(msg);
        }
    }

    /**
     * 대상 문자열이 숫자만(<code>Integer</code>)으로 되어 있지 않으면 오류
     * 
     * @param str <code>Integer</code>로 변환 체크 대상 문자열
     * @throws IllegalArgumentException <code>Integer.parseInt() </code>이 불가능 할
     *         경우
     */
    public static void assertNumber(String str) {
        assertNumber(str, "[오류] '" + str + "' 문자열은 숫자로 변환이 불가능합니다.");
    }

    /**
     * 객체가 <code>null</code>이 아니고, length() > 0, size() > 0 에 해당하면 오류
     * 
     * @param obj 대상 객체
     * @param msg 오류 메시지
     * @see {@link #isNotEmpty(Object)}
     */
    public static void assertEmpty(Object obj, String msg) {

        if(obj != null) {
            if(obj instanceof String) {
                String str = (String) obj;
                if(null != str || str.length() > 0) {
                    throw new IllegalArgumentException(msg);
                }
            }

            if(obj instanceof Collection) {
                Collection<?> collection = (Collection<?>) obj;
                if(null != collection || collection.size() > 0) {
                    throw new IllegalArgumentException(msg);
                }
            }

            if(obj.getClass().isArray()) {
                if(null != obj || Array.getLength(obj) > 0) {
                    throw new IllegalArgumentException(msg);
                }
            }
        }

    }

    /**
     * 객체가 <code>null</code>이 아니고, length() > 0, size() > 0 에 해당하면 오류
     * 
     * @param obj 대상 객체
     * @see {@link #isNotEmpty(Object, String)}
     */
    public static void assertEmpty(Object obj) {
        assertEmpty(obj, "[오류] null 또는 값이 없습니다.");
    }

    /**
     * 객체가 null, length() == 0, size() == 0 에 해당하면 오류
     * 
     * @param obj 대상 객체
     * @param msg 오류 메시지
     * @see {@link #isNotEmpty(Object)}
     */
    public static void assertNotEmpty(Object obj, String msg) {
        assertNotNull(obj, msg);

        if(obj instanceof String) {
            String str = (String) obj;
            if(str.length() == 0) {
                throw new IllegalArgumentException(msg);
            }
        }

        if(obj instanceof Collection) {
            Collection<?> collection = (Collection<?>) obj;
            if(collection.size() == 0) {
                throw new IllegalArgumentException(msg);
            }
        }

        if(obj.getClass().isArray()) {
            if(Array.getLength(obj) == 0) {
                throw new IllegalArgumentException(msg);
            }
        }

    }

    /**
     * 객체가 null, length() == 0, size() == 0 에 해당하면 오류
     * 
     * @param obj 대상 객체
     * @see {@link #isNotEmpty(Object, String)}
     */
    public static void assertNotEmpty(Object obj) {
        assertNotEmpty(obj, "[오류] null 또는 값이 없습니다.");
    }

    /**
     * 두 문자 배열의 길이가 동일하지 않으면 오류
     * 
     * @param objArr1 비교문자 배열 1
     * @param objArr2 비교문자 배열 2
     * @param msg 오류 메시지
     */
    public static void assertEqualArrLength(String[] objArr1, String[] objArr2, String msg) {
        assertNotNull(objArr1, "[오류] 비교 대상 문자 배열 1이 null입니다.");
        assertNotNull(objArr2, "[오류] 비교 대상 문자 배열 2이 null입니다.");
        if(objArr1.length != objArr2.length) {
            throw new IllegalArgumentException(msg);
        }
    }

    /**
     * 두 문자 배열의 길이가 동일하지 않으면 오류
     * 
     * @param objArr1 비교문자 배열 1
     * @param objArr2 비교문자 배열 2
     */
    public static void assertEqualArrLength(String[] objArr1, String[] objArr2) {
        assertEqualArrLength(objArr1, objArr2, "[오류] 배열의 길이가 다릅니다.");
    }

    /**
     * 쿼리 결과 후 1이 리턴되지 않은 경우 YESNO : 2011. 3. 3.
     * 
     * @param num
     * @throws Exception
     */
    public static void assertOne(int num) throws Exception {
        if(num != StringUtil.ONE) {
            throw new Exception("값이 1이 아닙니다.");
        }
    }

    /**
     * 1 이 아닌 경우 오류 YESNO : 2011. 3. 3.
     * 
     * @param num 비교 숫자
     * @param msg 오류 메시지
     * @throws Exception
     */
    public static void assertOne(int num, String msg) throws Exception {
        if(num != StringUtil.ONE) {
            throw new Exception(msg);
        }
    }

    /**
     * 0 이 아닌 경우 오류 YESNO : 2011. 3. 3.
     * 
     * @param num 비교 숫자
     * @throws Exception
     */
    public static void assertZero(int num) throws Exception {
        if(num != StringUtil.ZERO) {
            throw new Exception("값이 0이 아닙니다.");
        }
    }

    /**
     * 0 이 아닌 경우 오류 YESNO : 2011. 3. 3.
     * 
     * @param num 비교 숫자
     * @param msg 오류 메시지
     * @throws Exception
     */
    public static void assertZero(int num, String msg) throws Exception {
        if(num != StringUtil.ZERO) {
            throw new Exception(msg);
        }
    }

    /**
     * 현재 스레드의 <code>ClassLoader</code>를 구한다. 오류발생시 현재 클레스의 기본
     * <code>ClassLoader</code>를 호출하여 반환한다.
     * 
     * @return ClassLoader
     */
    public static ClassLoader getDefaultClassLoader() {
        ClassLoader cl = null;
        try {
            cl = Thread.currentThread().getContextClassLoader();
        } catch (Throwable ex) {

        }
        if(cl == null) {
            cl = AssertUtil.class.getClassLoader();
        }
        return cl;
    }

}
