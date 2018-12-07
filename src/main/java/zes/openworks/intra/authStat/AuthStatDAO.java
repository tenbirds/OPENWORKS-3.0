/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.authStat;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.core.lang.Validate;
import zes.core.utils.DateCalcUtil;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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

@Repository
public class AuthStatDAO extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getPersonPerAuth(Map<String, String[]> param) {
        return list("_authStat.personPerAuth", param);
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getAuthWebLoggingPerMonth4Chart(Map<String, String[]> param) {
        return list("_authStat.authWebLoggingPerMonth4Chart", setEmptyParam(param));
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getAuthWebLoggingPerYear(Map<String, String[]> param) {
        return list("_authStat.authWebLoggingPerYear", setEmptyParam(param));
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getAuthWebLoggingPerMonth(Map<String, String[]> param) {
        return list("_authStat.authWebLoggingPerMonth", setEmptyParam(param));
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getAuthWebLoggingPerDay(Map<String, String[]> param) {
        return list("_authStat.authWebLoggingPerDay", setEmptyParam(param));
    }

    @SuppressWarnings("unchecked")
    public Map<String, String> getAuthWebLoggingPerDay4Chart(Map<String, String[]> param) {
        return (Map<String, String>) selectByPk("_authStat.authWebLoggingPerDay4Chart", setEmptyParam(param));
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getAuthPerDept(Map<String, String[]> param) {

        return list("_authStat.authPerDept", param);
    }

    private Map<String, String> setEmptyParam(Map<String, String[]> param) {
        Map<String, String> newParam = new HashMap<String, String>();
        if(param.get("q_year") == null || Validate.isEmpty(param.get("q_year")[0])) {
            newParam.put("q_year", (new SimpleDateFormat("yyyy")).format(new Date()));
        } else {
            newParam.put("q_year", param.get("q_year")[0]);
        }

        if((param.get("q_stDate") == null || Validate.isEmpty(param.get("q_stDate")[0])) &&
            (param.get("q_enDate") == null || Validate.isEmpty(param.get("q_enDate")[0]))) {
            String[] dates = DateCalcUtil.getTermMonth();

            newParam.put("q_stDate", dates[0]);
            newParam.put("q_enDate", dates[1]);
        } else {
            newParam.put("q_stDate", param.get("q_stDate")[0].replaceAll("-", ""));
            newParam.put("q_enDate", param.get("q_enDate")[0].replaceAll("-", ""));
        }

        return newParam;
    }
}
