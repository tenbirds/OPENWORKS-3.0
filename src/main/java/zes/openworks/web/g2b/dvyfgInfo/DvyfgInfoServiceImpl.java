/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.dvyfgInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;

/**
 * @version 2.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)엔키소프트
 *
 *         <pre>
 * << 납품정보(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
  *  2016. 11. 29.    guest1       신규
 * </pre>
 * @see
 */
@Service
public class DvyfgInfoServiceImpl extends AbstractServiceImpl implements DvyfgInfoService {

    @Resource
    private DvyfgInfoDAO dao;

 
    /* (나라장터 납품정보 중복 체크)
     * @see zes.openworks.web.g2b.cntrctInfo.CntrctInfoService#cntrctInfoCheck(zes.openworks.web.g2b.cntrctInfo.CntrctInfoVO)
     */
    @Override
    public int dvyfgInfoCheck(DvyfgInfoVO vo) {        
        return dao.dvyfgInfoCheck(vo);
    }


    /* (나라장터 납품정보 등록)
     * @see zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoService#dvyfgInfoInsertAction(zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoVO)
     */
    @Override
    public int dvyfgInfoInsertAction(DvyfgInfoVO vo) {
        return dao.dvyfgInfoInsertAction(vo);
    }


    /* (나라장터 납품정보 수정)
     * @see zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoService#dvyfgInfoUpdateAction(zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoVO)
     */
    @Override
    public int dvyfgInfoUpdateAction(DvyfgInfoVO vo) {
        return dao.dvyfgInfoUpdateAction(vo);
    }
    
}
