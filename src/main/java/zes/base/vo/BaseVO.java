/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.vo;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.Map;

/**
 * 기본 VO 객체
 * <p />
 * Object 클레스의 기본 메소드를 Override하여 편의성을 추가함
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author 방기배
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 2. 26.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BaseVO implements Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 8346094199260151851L;

    private final static String GET_PREFIX = "get";
    private final static String HAS_PREFIX = "has";
    private final static String IS_PREFIX = "is";

    /** 확장 값을 저장하기 위한 멥 */
    private Map<String, Object> dataMap;

    /**
     * 확장 파라미터(검색 파라미터등) 값 반환
     * 
     * @return
     */
    public Map<String, Object> getDataMap() {
        return dataMap;
    }

    /**
     * 확장 파라미터(검색 파라미터등) 값 저장
     * 
     * @param dataMap
     */
    public void setDataMap(Map<String, Object> dataMap) {
        this.dataMap = dataMap;
    }

    /**
     * 맴버 변수 값을 전부를 키와 값으로 구분하여 문자열로 반환
     */
    @SuppressWarnings("unused")
    @Override
    public String toString() {

        StringBuilder result = new StringBuilder("VO : ");
        if(this == null) {
            result.append("null");
            return result.toString();
        }
        result.append(this.getClass().getName()).append('\n');

        Method[] methods = this.getClass().getMethods();
        for(int i = 0 ; i < methods.length ; i++) {
            Method method = methods[i];
            Class<?>[] params = method.getParameterTypes();
            if(params.length != 0) {
                continue; // skip methods that have params
            }
            String mname = method.getName();
            if(mname.equals("getClass")) { // skip getClass() method
                continue;
            }
            if(mname.startsWith(GET_PREFIX) || mname.startsWith(IS_PREFIX)
                || mname.startsWith(HAS_PREFIX)) {

                String paramName = method.getName().substring(3);
                Object mresult = null;
                try {
                    mresult = method.invoke(this);
                } catch (Exception ex) {}

                result.append("  ").append(paramName);
                if(mresult == null) {
                    result.append(" : null");
                } else {
                    String val = mresult.toString();
                    if(val.length() > 100) {
                        val = val.substring(0, 100) + "....";
                    }
                    result.append(" : [ ").append(val).append(" ]");
                }
                result.append('\n');
            }
        }
        return result.toString();
    }

}
