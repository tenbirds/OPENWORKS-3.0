/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidAno;

import zes.base.pager.Pager;
import zes.openworks.web.g2b.bidAno.BidAnoVO;

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
public interface BidAnoService {

    
    /**
     * bidAnoList (입찰공고 리스트)
     * 
     * @param vo
     * @return
     */
    Pager<BidAnoVO> bidAnoList(BidAnoVO vo);
    
    /**
     * bidAnoCheck (입찰공고 중복체크)
     * 
     * @param vo
     * @return
     */
    int bidAnoCheck(BidAnoVO vo);

    /**
     * bidAnoInsertAction (입찰공고 등록)
     * 
     * @param vo
     * @return
     */
    int bidAnoInsertAction(BidAnoVO vo);

    /**
     * bidAnoUpdateAction (입찰공고 수정)
     * 
     * @param vo
     * @return
     */
    int bidAnoUpdateAction(BidAnoVO vo);
        
}
