/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class UserStatsDAO extends EgovAbstractMapper {

    public Map<String, Object> userList(Map<String, Object> searchMap) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", list("_userstats.userList", searchMap));
        return resultMap;
    }

}
