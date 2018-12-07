/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.authStat;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
 *  2012. 5. 17.    이찬희   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Service("authStatService")
public class AuthStatServiceImpl implements AuthStatService {

    @Autowired
    private AuthStatDAO dao;

    @Override
    public List<Map<String, String>> getPersonPerAuth(Map<String, String[]> param) {
        return dao.getPersonPerAuth(param);
    }

    @Override
    public List<Map<String, String>> getAuthWebLoggingPerMonth4Chart(Map<String, String[]> param) {
        return dao.getAuthWebLoggingPerMonth4Chart(param);
    }

    @Override
    public List<Map<String, String>> getAuthWebLoggingPerYear(Map<String, String[]> param) {
        return dao.getAuthWebLoggingPerYear(param);
    }

    @Override
    public List<Map<String, String>> getAuthWebLoggingPerMonth(Map<String, String[]> param) {
        return dao.getAuthWebLoggingPerMonth(param);
    }

    @Override
    public List<Map<String, String>> getAuthWebLoggingPerDay(Map<String, String[]> param) {
        return dao.getAuthWebLoggingPerDay(param);
    }

    @Override
    public Map<String, String> getAuthWebLoggingPerDay4Chart(Map<String, String[]> param) {
        return dao.getAuthWebLoggingPerDay4Chart(param);
    }

    @Override
    public List<Map<String, String>> getAuthPerDept(Map<String, String[]> param) {
        return dao.getAuthPerDept(param);
    }

}
