/*
 * Copyright (c) 2010 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.schedule.sample;

import java.util.concurrent.atomic.AtomicInteger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.schedule.Processor;

public class SampleProcessor implements Processor {

    Logger logger = LoggerFactory.getLogger(SampleProcessor.class);

    AtomicInteger atInt = new AtomicInteger();

    /**
     * 설정에 지정된 시간마다 출력
     */
    @Override
    public void process() {
        int cnt = atInt.incrementAndGet();

        logger.debug("zes.openworks.common.schedule.sample.SampleProcessor run is  {} times", cnt);
    }

}
