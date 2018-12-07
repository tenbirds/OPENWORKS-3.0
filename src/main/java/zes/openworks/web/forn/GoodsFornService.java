/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */

package zes.openworks.web.forn;

import zes.base.pager.Pager;
import zes.openworks.web.forn.GoodsFornVO;

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
public interface GoodsFornService {

    
    /**
     * bidInfoList (해외동향 리스트)
     * 
     * @param vo
     * @return
     */
    Pager<GoodsFornVO> goodsFornList(GoodsFornVO vo);
    
  }
