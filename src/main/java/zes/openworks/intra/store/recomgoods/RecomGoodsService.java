/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.recomgoods;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsManageVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.   김병욱     신규
 *</pre>
 * @see
 */
public interface RecomGoodsService {

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    Pager<RecomGoodsVO> goodsList(RecomGoodsVO vo);

    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<GoodsManageVO> langList(GoodsManageVO vo);

    List<GoodsManageVO> ctgryList(GoodsManageVO vo);

    /**
     * recomGoodsList 설명
     * @param vo
     * @return
     */
    Pager<RecomGoodsVO> recomGoodsList(RecomGoodsVO vo);

    /**
     * recomGoodsInsert 설명
     * @param vo
     * @param request
     * @return
     */
    int recomGoodsInsert(RecomGoodsVO vo, boolean recomApply);

    /**
     * recomGoodsDelete 설명
     * @param vo
     * @return
     */
    int recomGoodsDelete(RecomGoodsVO vo);

    /**
     * recomGoodsList2 설명
     * @param vo
     * @return
     */
    Pager<RecomGoodsVO> recomGoodsList2(RecomGoodsVO vo);

    /**
     * recomGoodsInsert2 설명
     * @param vo
     * @return
     */
    int recomGoodsInsert2(RecomGoodsVO vo, boolean recomAplly);
}
