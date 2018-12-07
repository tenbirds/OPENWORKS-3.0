/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidAno;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.web.g2b.bidAno.BidAnoVO;
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
 *  2014. 11. 6.    이슬버미       신규
 * </pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class BidAnoDAO extends EgovAbstractMapper {
    /**
     * bidAnoList (나라장터 입찰정보 목록 조회)
     * 
     * @param vo
     * @return
     */
    public Pager<BidAnoVO> bidAnoList(BidAnoVO vo) {

        List<BidAnoVO> dataList = list("_bidAno.bidAnoList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_bidAno.bidAnoCount", vo.getDataMap()));

        return new Pager<BidAnoVO>(dataList, vo);
    }
    
    /**
     * bidAnoCheck (나라장터 입찰정보 중복 체크)
     * @param vo
     * @return
     */
    public int bidAnoCheck(BidAnoVO vo) {
        return (Integer) selectByPk("_bidAno.bidAnoCheck", vo);
    }

    /**
     * bidAnoInsertAction (나라장터 입찰정보 등록)
     * @param vo
     * @return
     */
    public int bidAnoInsertAction(BidAnoVO vo) {
        return insert("_bidAno.bidAnoInsertAction", vo);
    }

    /**
     * bidAnoUpdateAction (나라장터 입찰정보 수정)
     * @param vo
     * @return
     */
    public int bidAnoUpdateAction(BidAnoVO vo) {
        return update("_bidAno.bidAnoUpdateAction", vo);
    }
    
}
