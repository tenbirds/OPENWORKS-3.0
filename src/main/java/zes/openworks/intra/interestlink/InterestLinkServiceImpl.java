/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.interestlink;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("interestLinkService")
public class InterestLinkServiceImpl extends AbstractServiceImpl implements InterestLinkService {

    @Resource
    private InterestLinkDAO dao;

    @Override
    public int insertInterestLink(InterestLinkVO interestLinkVo) {
        return dao.insertInterestLink(interestLinkVo);
    }

    @Override
    public List<String> getCategoryList(InterestLinkVO interestLinkVo) {
        return dao.getCategoryList(interestLinkVo);
    }

    @Override
    public List<InterestLinkVO> interestLinkList(InterestLinkVO interestLinkVo) {
        return dao.interestLinkList(interestLinkVo);
    }

    @Override
    public Pager<InterestLinkVO> interestLinkPager(InterestLinkVO interestLinkVo) {
        return dao.interestLinkPager(interestLinkVo);
    }

    @Override
    public int deleteInterestLink(InterestLinkVO interestLinkVo) {
        return dao.deleteInterestLink(interestLinkVo);
    }

    @Override
    public int delListInterestLink(InterestLinkVO interestLinkVo, String[] seqs) {
        return dao.delListInterestLink(interestLinkVo, seqs);
    }

    @Override
    public int updateInterestLink(InterestLinkVO interestLinkVo) {
        return dao.updateInterestLink(interestLinkVo);
    }

}
