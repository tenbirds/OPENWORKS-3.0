/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.event;

import java.util.Map;

public interface EventStatsService {

    Map<String, Object> eventList(Map<String, Object> searchMap);

    Map<String, Object> eventView(Map<String, Object> searchMap);
}
