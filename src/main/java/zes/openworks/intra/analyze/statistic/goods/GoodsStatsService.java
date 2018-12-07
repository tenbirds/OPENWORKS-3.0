/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.goods;

import java.util.List;

import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.store.goods.GoodsManageVO;

public interface GoodsStatsService {

    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<GoodsManageVO> langList(GoodsManageVO vo);

    /**
     * intrStatList 설명
     * @param vo
     * @return
     */
    List<ResultVO> intrStatList(ResultVO vo);

    /**
     * purchStatList 설명
     * @param vo
     * @return
     */
    List<ResultVO> purchStatList(ResultVO vo);

    /**
     * registStatList 설명
     * @param vo
     * @return
     */
    List<ResultVO> registStatList(ResultVO vo);

    /**
     * goodsPpsStatList 설명
     * 서비스구매통계
     * @param vo
     * @return
     */
    List<ResultVO> goodsPpsStatList(ResultVO vo);
    
    
}
