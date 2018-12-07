/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.satisfy;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 사용자만족도 서비스 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 22.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("satisfyService")
public class SatisfyServiceImpl extends AbstractServiceImpl implements SatisfyService {

    @Resource
    private SatisfyDAO satisfyDAO;

    @Override
    public SatisfyVO getSatisfy(SatisfyVO satisfyVo) throws Exception {

        SatisfyVO satisfyVo1 = satisfyDAO.getSatisfy(satisfyVo);
        satisfyVo1.setSatisfyDetlList(satisfyDAO.getSatisfyDetlList(satisfyVo));

        return satisfyVo1;
    }

    @Override
    public List<SatisfyVO> getSatisfyList(SatisfyVO satisfyVo) throws Exception {

        return satisfyDAO.getSatisfyList(satisfyVo);
    }

    @Override
    public Pager<SatisfyVO> getSatisfyDetlList(SatisfyVO satisfyVo) throws Exception {

        return satisfyDAO.getSatisfyDetlList(satisfyVo);
    }

    @Override
    public Object insertSatisfy(SatisfyVO satisfyVo) throws Exception {

        return satisfyDAO.insertSatisfy(satisfyVo);
    }

    @Override
    public SatisfyVO getScoreAvg(SatisfyVO satisfyVo) throws Exception {

        return satisfyDAO.getScoreAvg(satisfyVo);
    }
}
