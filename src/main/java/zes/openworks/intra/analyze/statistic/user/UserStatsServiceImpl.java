/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.user;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service
public class UserStatsServiceImpl extends AbstractServiceImpl implements UserStatsService {

    @Resource
    private UserStatsDAO dao;

    @Override
    public Map<String, Object> userList(Map<String, Object> searchMap) {
        return dao.userList(searchMap);
    }
}
