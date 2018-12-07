/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.advertisement;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 7.    김영상       신규
 *</pre>
 * @see
 */
@Service("AdvrtsService")
public class AdvrtsServiceImpl extends AbstractServiceImpl implements AdvrtsService {
    @Resource
    private AdvrtsDAO dao;

    @Override
    public Pager<AdvrtsVO> advrtsList(AdvrtsVO vo) {
        return dao.advrtsList(vo);
    }

    @Override
    public int advrtsInsertAction(AdvrtsVO vo) {
        return dao.advrtsInsert(vo);
    }

    @Override
    public int advrtsUpdateAction(AdvrtsVO vo) {
        return dao.advrtsUpdate(vo);
    }

    @Override
    public AdvrtsVO advrtsUpdateForm(AdvrtsVO vo) {
        return dao.advrtsUpdateForm(vo);
    } 
 
    @Override
    public int advrtsDeleteAction(AdvrtsVO vo) {
        return dao.advrtsDelete(vo);
    }
}
