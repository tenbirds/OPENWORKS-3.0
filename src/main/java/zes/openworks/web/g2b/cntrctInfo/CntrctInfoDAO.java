/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.cntrctInfo;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
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
@Repository
@SuppressWarnings("unchecked")
public class CntrctInfoDAO extends EgovAbstractMapper {

    /**
     * cntrctInfoList (나라장터 계약정보 목록 조회)
     *
     * @param vo
     * @return
     */
    public Pager<CntrctInfoVO> cntrctInfoList(BidInfoVO vo) {

        List<CntrctInfoVO> dataList = list("_cntrctInfo.cntrctInfoList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_cntrctInfo.cntrctInfoCount", vo.getDataMap()));

        return new Pager<CntrctInfoVO>(dataList, vo);
    }

    /**
     * cntrctInfoCheck (나라장터 계약정보 중복 체크)
     * @param vo
     * @return
     */
    public int cntrctInfoCheck(CntrctInfoVO vo) {
        return (Integer) selectByPk("_cntrctInfo.cntrctInfoCheck", vo);
    }

    /**
     * cntrctInfoInsertAction (나라장터 계약정보 등록)
     * @param vo
     * @return
     */
    public int cntrctInfoInsertAction(CntrctInfoVO vo) {
        return insert("_cntrctInfo.cntrctInfoInsertAction", vo);
    }

    /**
     * cntrctInfoUpdateAction (나라장터 계약정보 수정)
     * @param vo
     * @return
     */
    public int cntrctInfoUpdateAction(CntrctInfoVO vo) {
        return update("_cntrctInfo.cntrctInfoUpdateAction", vo);
    }

    /**
     * cntrctItemCheck (나라장터 계약물품 중복 체크)
     * @param vo
     * @return
     */
    public int cntrctItemCheck(CntrctInfoVO vo) {
        return (Integer) selectByPk("_cntrctInfo.cntrctItemCheck", vo);
    }

    /**
     * cntrctItemDelete (나라장터 계약물품 삭제)
     * @param vo
     * @return
     */
    public int cntrctItemDelete(CntrctInfoVO vo) {
        return delete("_cntrctInfo.cntrctItemDelete", vo);
    }

    /**
     * cntrctItemInsertAction (나라장터 계약물품 등록)
     * @param vo
     * @return
     */
    public int cntrctItemInsertAction(CntrctItemVO itemVO) {
        return insert("_cntrctInfo.cntrctItemInsertAction", itemVO);
    }

}
