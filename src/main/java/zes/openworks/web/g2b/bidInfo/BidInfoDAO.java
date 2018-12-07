/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidInfo;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
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
public class BidInfoDAO extends EgovAbstractMapper {
    /**
     * bidInfoList (나라장터 입찰정보 목록 조회)
     * 
     * @param vo
     * @return
     */
    public Pager<BidInfoVO> bidInfoList(BidInfoVO vo) {

        List<BidInfoVO> dataList = list("_bidInfo.bidInfoList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_bidInfo.bidInfoCount", vo.getDataMap()));

        return new Pager<BidInfoVO>(dataList, vo);
    }
    
    /**
     * bidInfoCheck (나라장터 입찰정보 중복 체크)
     * @param vo
     * @return
     */
    public int bidInfoCheck(BidInfoVO vo) {
        return (Integer) selectByPk("_bidInfo.bidInfoCheck", vo);
    }

    /**
     * bidInfoInsertAction (나라장터 입찰정보 등록)
     * @param vo
     * @return
     */
    public int bidInfoInsertAction(BidInfoVO vo) {
        return insert("_bidInfo.bidInfoInsertAction", vo);
    }

    /**
     * bidInfoUpdateAction (나라장터 입찰정보 수정)
     * @param vo
     * @return
     */
    public int bidInfoUpdateAction(BidInfoVO vo) {
        return update("_bidInfo.bidInfoUpdateAction", vo);
    }
    
}
