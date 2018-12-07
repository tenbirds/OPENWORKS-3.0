/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.goods;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.core.lang.Validate;
import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class GoodsStatsDAO extends EgovAbstractMapper {

    /**
     * langList 서비스 언어 목록
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<GoodsManageVO> langList(GoodsManageVO vo) {
        return list("_goodsManage.langList", vo);
    }

    /**
     * intrStatList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> intrStatList(ResultVO vo) {
      //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }
        return list("_goodsStatic.intrStatList",  vo.getDataMap());
    }

    /**
     * purchStatList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> purchStatList(ResultVO vo) {
      //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }
        return list("_goodsStatic.purchStatList",  vo.getDataMap());
    }

    /**
     * registStatList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> registStatList(ResultVO vo) {
      //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }
        return list("_goodsStatic.registStatList",  vo.getDataMap());
    }

    /**
     * goodsPpsStatList 설명
     * 서비스구매통계
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> goodsPpsStatList(ResultVO vo) {
      //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_init")) ||  vo.getDataMap().get("q_init") == "1"){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c1.add(Calendar.MONTH, -1);

            vo.getDataMap().put("q_beginDate",sdf.format(c1.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c2.getTime()));
        }
        return list("_goodsStatic.goodsPpsStatList",  vo.getDataMap());
    }
    
}
