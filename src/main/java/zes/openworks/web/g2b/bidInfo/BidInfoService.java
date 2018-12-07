/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidInfo;

import zes.base.pager.Pager;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;

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
public interface BidInfoService {

    
    /**
     * bidInfoList (나라장터 입찰정보 리스트)
     * 
     * @param vo
     * @return
     */
    Pager<BidInfoVO> bidInfoList(BidInfoVO vo);
    
    /**
     * bidInfoCheck (나라장터 입찰정보 중복체크)
     * 
     * @param vo
     * @return
     */
    int bidInfoCheck(BidInfoVO vo);

    /**
     * bidInfoInsertAction (나라장터 입찰정보 등록)
     * 
     * @param vo
     * @return
     */
    int bidInfoInsertAction(BidInfoVO vo);

    /**
     * bidInfoUpdateAction (나라장터 입찰정보 수정)
     * 
     * @param vo
     * @return
     */
    int bidInfoUpdateAction(BidInfoVO vo);
        
}
