/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.satisfy;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 사용자만족도 관리 DAO 객체
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
@Repository
public class SatisfyDAO extends EgovAbstractMapper {

    /**
     * 사용자만족도 상세
     */
    public SatisfyVO getSatisfy(SatisfyVO satisfyVo) {

        return (SatisfyVO) selectByPk("intra.cms.satisfy.getSatisfy", satisfyVo);
    }

    /**
     * 사용자만족도 목록
     */
    public List<SatisfyVO> getSatisfyList(SatisfyVO satisfyVo) throws Exception {

        @SuppressWarnings("unchecked")
        List<SatisfyVO> dataList = list("intra.cms.satisfy.getSatisfyList", satisfyVo);

        return dataList;
    }

    /**
     * 사용자만족도상세 목록
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<SatisfyVO> getSatisfyDetlList(SatisfyVO satisfyVo) throws Exception {

        satisfyVo.init();

        List<SatisfyVO> dataList = list("intra.cms.satisfy.getSatisfyDetlList", satisfyVo);
        satisfyVo.setTotalNum((Integer) (selectByPk("intra.cms.satisfy.getSatisfyDetlListCount", satisfyVo)));

        return new Pager<SatisfyVO>(dataList, satisfyVo);

    }

    /**
     * 사용자만족도 등록
     */
    public Object insertSatisfy(SatisfyVO satisfyVo) throws Exception {

        insert("intra.cms.satisfy.insertSatisfy", satisfyVo);

        Object primaryKey = insert("intra.cms.satisfy.insertSatisfyDetl", satisfyVo);

        return primaryKey;
    }

    /**
     * 사용자만족도 점수
     */
    public SatisfyVO getScoreAvg(SatisfyVO satisfyVo) {

        return (SatisfyVO) selectByPk("intra.cms.satisfy.getScoreAvg", satisfyVo);
    }
}
