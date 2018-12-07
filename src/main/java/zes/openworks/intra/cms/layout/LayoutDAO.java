/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.layout;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.openworks.component.domain.DomainVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * Layout 관리 DAO
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
 *  2012. 5. 7.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class LayoutDAO extends EgovAbstractMapper {

    /**
     * 사이트 목록
     */
    @SuppressWarnings("unchecked")
    public List<DomainVO> getDomainList(LayoutVO layoutVo) throws Exception {

        DomainVO domainVo = new DomainVO();
        domainVo.setDomainCd(layoutVo.getDomainCd());
        domainVo.setUseYn("Y");

        return list("component.domain.getDomainList", domainVo);
    }

    /**
     * Layout 목록
     */
    @SuppressWarnings("unchecked")
    public List<LayoutVO> getLayoutList(LayoutVO layoutVo) throws Exception {

        return list("intra.cms.layout.getLayoutList", layoutVo);
    }

    /**
     * Layout 상세
     */
    public LayoutVO getLayout(LayoutVO layoutVo) throws Exception {

        return (LayoutVO) selectByPk("intra.cms.layout.getLayout", layoutVo);
    }

    /**
     * Layout 등록
     */
    public Object insertLayout(LayoutVO layoutVo) throws Exception {

        Object primaryKey = insert("intra.cms.layout.insertLayout", layoutVo);

        return primaryKey;
    }

    /**
     * Layout 수정
     */
    public int updateLayout(LayoutVO layoutVo) throws Exception {

        return update("intra.cms.layout.updateLayout", layoutVo);
    }

    /**
     * Layout 삭제
     */
    public int deleteLayout(LayoutVO layoutVo) throws Exception {

        return delete("intra.cms.layout.deleteLayout", layoutVo);
    }

}
