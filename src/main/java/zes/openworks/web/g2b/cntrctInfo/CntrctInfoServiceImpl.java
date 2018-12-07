/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.cntrctInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
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
@Service
public class CntrctInfoServiceImpl extends AbstractServiceImpl implements CntrctInfoService {

    @Resource
    private CntrctInfoDAO dao;

    @Override
    public Pager<CntrctInfoVO> cntrctInfoList(BidInfoVO vo) {
        return dao.cntrctInfoList(vo);
    }

    /* (나라장터 계약정보 중복 체크)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctInfoCheck(zes.openworks.web.g2b.cntrctInfo.CntrctInfoVO)
     */
    @Override
    public int cntrctInfoCheck(CntrctInfoVO vo) {
        return dao.cntrctInfoCheck(vo);
    }

    /*
     * (나라장터 계약정보 등록)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctInfoInsertAction(zes.openworks.web.g2b.cntrctInfo.CntrctInfoVO)
     */
    @Override
    public int cntrctInfoInsertAction(CntrctInfoVO vo) {
        return dao.cntrctInfoInsertAction(vo);
    }

    /*
     * (나라장터 계약정보 수정)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctInfoUpdateAction(zes.openworks.web.g2b.cntrctInfo.CntrctInfoVO)
     */
    @Override
    public int cntrctInfoUpdateAction(CntrctInfoVO vo) {
        return dao.cntrctInfoUpdateAction(vo);
    }


    /* (나라장터 계약정보 중복 체크)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctItemCheck(zes.openworks.web.g2b.cntrctInfo.CntrctItemVO)
     */
    @Override
    public int cntrctItemCheck(CntrctInfoVO vo) {
        return dao.cntrctItemCheck(vo);
    }

    /* (나라장터 계약물품 삭제)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctItemDelete(zes.openworks.web.g2b.cntrctInfo.CntrctItemVO)
     */
    @Override
    public int cntrctItemDelete(CntrctInfoVO vo) {
        return dao.cntrctItemDelete(vo);
    }

    /*
     * (나라장터 계약물품 등록)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctItemInsertAction(zes.openworks.web.g2b.cntrctInfo.CntrctItemVO)
     */
    @Override
    public int cntrctItemInsertAction(CntrctItemVO itemVo) {
        return dao.cntrctItemInsertAction(itemVo);
    }

}
