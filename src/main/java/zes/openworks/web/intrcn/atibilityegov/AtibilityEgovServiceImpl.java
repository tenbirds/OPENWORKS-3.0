/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.intrcn.atibilityegov;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.code.CodeVO;
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
 *  2014. 10. 31.    이슬버미       신규
 * </pre>
 * @see
 */

@Service
public class AtibilityEgovServiceImpl extends AbstractServiceImpl implements AtibilityEgovService {

    @Resource
    private AtibilityEgovDAO dao;

    /*
     * (호환성 목록)
     * @see
     * zes.openworks.web.intrcn.atibilityegov.AtibilityEgovService#atibilityEgovList
     * (zes.openworks.web.intrcn.atibilityegov.AtibilityEgovVO)
     */
    @Override
    public Pager<AtibilityEgovVO> atibilityEgovList(AtibilityEgovVO vo) {
        return dao.atibilityEgovList(vo);
    }

    /*
     * (호환성 상세)
     * @see
     * zes.openworks.web.intrcn.atibilityegov.AtibilityEgovService#atibilityEgovView
     * (zes.openworks.web.intrcn.atibilityegov.AtibilityEgovVO)
     */
    @Override
    public AtibilityEgovVO atibilityEgovView(AtibilityEgovVO vo) {

        return dao.atibilityEgovView(vo);
    }

    /*
     * (호환성 신청)
     * @see zes.openworks.web.intrcn.atibilityegov.AtibilityEgovService#
     * atibilityEgovInsertAction
     * (zes.openworks.web.intrcn.atibilityegov.AtibilityEgovVO)
     */
    @Override
    public int atibilityEgovInsertAction(AtibilityEgovVO vo) {
        return dao.atibilityEgovInsertAction(vo);
    }


    /* (호환성 분류)
     * @see zes.openworks.web.intrcn.atibilityegov.AtibilityEgovService#cmptbClCdList()
     */
    public List<CodeVO> cmptbClCdList(AtibilityEgovVO vo) {
        return dao.cmptbClCdList(vo);
    }

}
