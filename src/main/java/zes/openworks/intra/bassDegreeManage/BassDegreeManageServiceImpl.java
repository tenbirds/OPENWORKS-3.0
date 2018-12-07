/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.bassDegreeManage;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.openworks.intra.bassAgremManage.BassAgremManageVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 3.    방기배       신규
 *</pre>
 * @see
 */
@Service("BassDegreeManageService")
public class BassDegreeManageServiceImpl extends AbstractServiceImpl implements BassDegreeManageService {

    @Resource BassDegreeManageDAO dao;

    @Override
    public Pager<BassDegreeManageVO> bassDegreeManageList(BassDegreeManageVO vo) {
        return dao.bassDegreeManageList(vo);
    }
    
    /* 기본협약차수관리 =- 기능 - 추가
     * @see zes.openworks.intra.bassDegreeManage.BassDegreeManageService#bassDegreeManageInsert(zes.openworks.intra.bassDegreeManage.BassDegreeManageVO)
     */
    @Override
    public int bassDegreeManageInsert(BassDegreeManageVO vo) {
        return dao.bassDegreeManageInsert(vo);
    }

    /* 기본협약차수관리 =- 기능 - 삭제
     * @see zes.openworks.intra.bassDegreeManage.BassDegreeManageService#bassDegreeManageDelete(zes.openworks.intra.bassDegreeManage.BassDegreeManageVO)
     */
    @Override
    public int bassDegreeManageDelete(BassDegreeManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bassDegreeManageDelete(vo);
    }

    /* 기본협약차수관리 =- 기능 - 수정
     * @see zes.openworks.intra.bassDegreeManage.BassDegreeManageService#bassDegreeManageUpdate(zes.openworks.intra.bassDegreeManage.BassDegreeManageVO)
     */
    @Override
    public int bassDegreeManageUpdate(BassDegreeManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bassDegreeManageUpdate(vo);
    }

}
