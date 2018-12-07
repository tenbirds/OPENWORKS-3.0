/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.domain;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.core.lang.Validate;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 사이트관리 DAO
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
 *  2012. 6. 18.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class DomainDAO extends EgovAbstractMapper {

    /**
     * 사이트 목록
     */
    @SuppressWarnings("unchecked")
    public List<DomainVO> getDomainList(DomainVO domainVo) throws Exception {

        return list("component.domain.getDomainList", domainVo);
    }

    /**
     * 사이트 상세
     */
    public DomainVO getDomain(DomainVO domainVo) throws Exception {

        domainVo = (DomainVO) selectByPk("component.domain.getDomain", domainVo);

        @SuppressWarnings("unchecked")
        List<DomainGroupVO> domainGroup = list("component.domain.getDomainGroup", domainVo);

        if(Validate.isNotEmpty(domainGroup)) {
            domainVo.setDomainGroup(domainGroup);
        }

        return domainVo;
    }

    /**
     * 사이트 그룹 목록
     */
    public List<DomainGroupVO> getDomainGroup(DomainVO domainVo) throws Exception {

        @SuppressWarnings("unchecked")
        List<DomainGroupVO> domainGroup = list("component.domain.getDomainGroup", domainVo);

        return domainGroup;
    }

    /**
     * 사이트 그룹 목록(동기화용)
     */
    public List<DomainGroupVO> getDomainGroupSync(Integer domainCd) throws Exception {

        DomainVO domainVo = new DomainVO();
        domainVo.setDomainCd(domainCd);

        List<DomainGroupVO> domainGroup = new ArrayList<DomainGroupVO>();

        domainGroup = getDomainGroup(domainVo);

        if(Validate.isEmpty(domainGroup)) {

            domainVo = (DomainVO) selectByPk("component.domain.getDomain", domainVo);

            DomainGroupVO domainGroupVO = new DomainGroupVO();
            domainGroupVO.setDomainCd(domainVo.getDomainCd());
            domainGroupVO.setGroupIpAddr(domainVo.getDomainNm());
            domainGroupVO.setGroupPortNo(domainVo.getPortNo());
            domainGroupVO.setContextPath(domainVo.getContextPath());

            domainGroup.add(domainGroupVO);
        }

        return domainGroup;

    }

    /**
     * 사이트 등록
     */
    public Object insertDomain(DomainVO domainVo) throws Exception {

        // 사이트 등록
        insert("component.domain.insertDomain", domainVo);
        Integer domainCd = domainVo.getDomainCd();

        if(null != domainVo.getGroupIpAddr()) {
            // 사이트 그룹 IP 등록
            List<String> groupIpAddr = domainVo.getGroupIpAddr();
            // 사이트 그룹 IP 등록
            List<Integer> groupPortNo = domainVo.getGroupPortNo();

            DomainGroupVO domainGroupVO = new DomainGroupVO();
            domainGroupVO.setDomainCd(domainCd);

            int groupCnt = groupIpAddr.size();
            for(int i = 0 ; i < groupCnt ; i++) {

                if(Validate.isNotEmpty(groupIpAddr.get(i))) {
                    domainGroupVO.setGroupIpAddr(groupIpAddr.get(i));
                    if(Validate.isEmpty(groupPortNo.get(i))) {
                        domainGroupVO.setGroupPortNo(80);
                    } else {
                        domainGroupVO.setGroupPortNo(groupPortNo.get(i));
                    }

                    insert("component.domain.insertDomainGroup", domainGroupVO);
                }
            }
        }

        return domainCd;
    }

    /**
     * 사이트 수정
     */
    public int updateDomain(DomainVO domainVo) throws Exception {

        insert("component.domain.deleteDomainGroup", domainVo);

        if(null != domainVo.getGroupIpAddr()) {
            // 사이트 그룹 IP 등록
            List<String> groupIpAddr = domainVo.getGroupIpAddr();
            // 사이트 그룹 IP 등록
            List<Integer> groupPortNo = domainVo.getGroupPortNo();

            DomainGroupVO domainGroupVO = new DomainGroupVO();
            domainGroupVO.setDomainCd(domainVo.getDomainCd());

            int groupCnt = groupIpAddr.size();
            for(int i = 0 ; i < groupCnt ; i++) {

                if(Validate.isNotEmpty(groupIpAddr.get(i))) {
                    domainGroupVO.setGroupIpAddr(groupIpAddr.get(i));
                    if(Validate.isEmpty(groupPortNo.get(i))) {
                        domainGroupVO.setGroupPortNo(80);
                    } else {
                        domainGroupVO.setGroupPortNo(groupPortNo.get(i));
                    }

                    insert("component.domain.insertDomainGroup", domainGroupVO);
                }
            }
        }

        return update("component.domain.updateDomain", domainVo);
    }

    /**
     * 사이트 삭제
     */
    public int deleteDomain(DomainVO domainVo) throws Exception {

        //도메인 연결 사용자메뉴 삭제
        delete("component.domain.deleteUserMenuAuth", domainVo);
        delete("component.domain.deleteUserMenuSubUrls", domainVo);
        delete("component.domain.deleteUserMenuContents", domainVo);
        delete("component.domain.deleteUserMenuGrade", domainVo);
        delete("component.domain.deleteUserMenuDomain", domainVo);
        
        //도메인 연결 게시판정보 업데이트
        update("component.domain.updateBbsDomainDel", domainVo);
        
        //도메인정보 삭제
        delete("component.domain.deleteDomainGroup", domainVo);
        delete("component.domain.deleteLayout", domainVo);

        return delete("component.domain.deleteDomain", domainVo);
    }

}
