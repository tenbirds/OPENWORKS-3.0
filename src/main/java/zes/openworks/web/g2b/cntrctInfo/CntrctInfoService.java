/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.cntrctInfo;

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
public interface CntrctInfoService {

    /**
     * cntrctInfoList (나라장터 계약정보 리스트)
     *
     * @param vo
     * @return
     */
    Pager<CntrctInfoVO> cntrctInfoList(BidInfoVO vo);

    /**
     * cntrctInfoCheck (나라장터 계약정보 중복체크)
     *
     * @param vo
     * @return
     */
    int cntrctInfoCheck(CntrctInfoVO vo);

    /**
     * cntrctInfoInsertAction (나라장터 계약정보 등록)
     *
     * @param vo
     * @return
     */
    int cntrctInfoInsertAction(CntrctInfoVO vo);

    /**
     * cntrctInfoUpdateAction (나라장터 계약정보 수정)
     *
     * @param vo
     * @return
     */
    int cntrctInfoUpdateAction(CntrctInfoVO vo);


    /**
     * cntrctItemCheck (나라장터 계약물품 중복체크)
     *
     * @param itemVo
     * @return
     */
    int cntrctItemCheck(CntrctInfoVO vo);

    /**
     * cntrctItemDelete (나라장터 계약물품 삭제)
     *
     * @param itemVo
     * @return
     */
    int cntrctItemDelete(CntrctInfoVO vo);

    /**
     * cntrctItemInsertAction (나라장터 계약물품 등록)
     *
     * @param itemVo
     * @return
     */
    int cntrctItemInsertAction(CntrctItemVO itemVo);

}
