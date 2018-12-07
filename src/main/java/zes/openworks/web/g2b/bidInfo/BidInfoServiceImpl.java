/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
@Service
public class BidInfoServiceImpl extends AbstractServiceImpl implements BidInfoService {
    
    @Resource
    private BidInfoDAO dao;
    
    @Override
    public Pager<BidInfoVO> bidInfoList(BidInfoVO vo) {
        return dao.bidInfoList(vo);
    }
    
    /* (나라장터 입찰정보 중복 체크)
     * @see zes.openworks.web.g2b.bidInfo.BidInfoService#bidInfoCheck(zes.openworks.web.g2b.bidInfo.BidInfoVO)
     */
    public int bidInfoCheck(BidInfoVO vo) {
        return dao.bidInfoCheck(vo);
    }
    
    /*
     * (나라장터 입찰정보 등록)
     * @see zes.openworks.web.g2b.bidInfo.BidInfoService#bidInfoInsertAction(zes.openworks.web.g2b.bidInfo.BidInfoVO)
     */
    @Override
    public int bidInfoInsertAction(BidInfoVO vo) {
        return dao.bidInfoInsertAction(vo);
    }

    /*
     * (나라장터 입찰정보 수정)
     * @see zes.openworks.web.g2b.bidInfo.BidInfoService#bidInfoUpdateAction(zes.openworks.web.g2b.bidInfo.BidInfoVO)
     */
    @Override
    public int bidInfoUpdateAction(BidInfoVO vo) {
        return dao.bidInfoUpdateAction(vo);
    }

}
