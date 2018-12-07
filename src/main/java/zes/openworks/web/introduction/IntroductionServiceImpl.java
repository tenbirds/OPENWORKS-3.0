/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.introduction;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;

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
 * 2018. 3. 7.    이홍석       신규
 *</pre>
 * @see
 */

@Service("IntroductionService")
public class IntroductionServiceImpl extends AbstractServiceImpl implements IntroductionService 
{
    @Resource
    private IntroductionDAO dao;

    /* 협약기업정보 리스트 _ 페이지 단위
     * @see zes.openworks.web.introduction.IntroductionService#index()
     */
    @Override
    public Pager<AgremManageVO> agremManage(AgremManageVO vo) 
    {
        return dao.agremManage(vo);
    }

    /* 총서비스 갯수
     * @see zes.openworks.web.introduction.IntroductionService#getTatalService()
     */
    @Override
    public int totalService(AgremManageVO vo) {
        return dao.totalService(vo);
    }

    /* 서비스(상품) 목록 
     * @see zes.openworks.web.introduction.IntroductionService#listService(zes.openworks.web.introduction.ServiceVO)
     */
    @Override
    public List<AgremManageServiceVO> listService(AgremManageServiceVO vo) {
        return dao.listService(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.introduction.IntroductionService#getServiceNum(zes.openworks.web.introduction.AgremManageServiceVO)
     */
    @Override
    public int getServiceNum(AgremManageServiceVO vo) {
        return dao.getServiceNum(vo);
    }

}
