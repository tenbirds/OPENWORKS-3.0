/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.content;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.cms.CmsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 사용자컨텐츠 관리 DAO 객체
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
 *  2012. 6. 27.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class ContentDAO extends EgovAbstractMapper {

    /**
     * 사이트 그룹 목록
     */
    @SuppressWarnings("unchecked")
    public List<DomainGroupVO> getDomainGroup(DomainVO domainVO) throws Exception {

        List<DomainGroupVO> domainGroup = new ArrayList<DomainGroupVO>();

        domainGroup = list("component.domain.getDomainGroup", domainVO);

        if(Validate.isEmpty(domainGroup)) {
            domainVO = (DomainVO) selectByPk("component.domain.getDomain", domainVO);

            DomainGroupVO domainGroupVO = new DomainGroupVO();
            domainGroupVO.setDomainCd(domainVO.getDomainCd());
            domainGroupVO.setGroupIpAddr(domainVO.getDomainNm());
            domainGroupVO.setGroupPortNo(domainVO.getPortNo());
            domainGroupVO.setContextPath(domainVO.getContextPath());

            domainGroup.add(domainGroupVO);
        }

        return domainGroup;
    }

    /**
     * 사용자컨텐츠 상세
     */
    public ContentVO getContent(ContentVO contentVo) {

        return (ContentVO) selectByPk("intra.cms.content.getContent", contentVo.getDataMap());
    }

    /**
     * 사용자컨텐츠 목록
     */
    public Pager<ContentVO> getContentList(ContentVO contentVo) throws Exception {

        @SuppressWarnings("unchecked")
        List<ContentVO> dataList = list("intra.cms.content.getContentList", contentVo.getDataMap());
        contentVo.setTotalNum((Integer) (selectByPk("intra.cms.content.getContentListCount", contentVo.getDataMap())));

        return new Pager<ContentVO>(dataList, contentVo);

    }

    /**
     * 사용자컨텐츠 등록
     */
    public Object insertContent(CmsVO cmsVo, ContentVO contentVo) throws Exception {

        // 자동승인 설정시 적용여부가 Y로 설정되고, 이전 적용여부는 N으로 변경한다.
        if(null != contentVo.getApplyYn() && contentVo.getApplyYn().equals("Y")) {
            update("intra.cms.content.updateApplyN", contentVo);
        }

        insert("intra.cms.content.insertContent", contentVo);
        Integer primaryKey = contentVo.getContentSeqNo();

        StringBuilder adminUrl = new StringBuilder();
        adminUrl.append(Config.getString("cms.adminUrl"));
        adminUrl.append("?domainCd=");
        adminUrl.append(contentVo.getDomainCd());
        adminUrl.append("&menuCode=");
        adminUrl.append(contentVo.getMenuCode());
        adminUrl.append("&contentSeqNo=");
        adminUrl.append(String.valueOf(primaryKey));

        StringBuilder userUrl = new StringBuilder();
        userUrl.append(cmsVo.getBasePath()).append(cmsVo.getMenuCode()).append(".jsp");

        cmsVo.setContentSeqNo(primaryKey);
        cmsVo.setAdminMenuUrl(adminUrl.toString());
        cmsVo.setUserMenuUrl(userUrl.toString());

        update("intra.cms.updateContentInfo", cmsVo);

        return primaryKey;
    }

    /**
     * 사용자컨텐츠 수정
     */
    public int updateContent(ContentVO contentVo) throws Exception {

        if(null != contentVo.getApprovalSt() && contentVo.getApprovalSt().equals("1040")) {
            update("intra.cms.content.updateApplyN", contentVo);

            CmsVO cmsVo = new CmsVO();
            cmsVo.setDomainCd(contentVo.getDomainCd());
            cmsVo.setMenuCode(contentVo.getMenuCode());
            cmsVo.setContentSeqNo(contentVo.getContentSeqNo());

            update("intra.cms.updateContentInfo", cmsVo);
        }

        return update("intra.cms.content.updateContent", contentVo);
    }

    /**
     * 사용자컨텐츠 삭제
     */
    public int deleteContent(ContentVO contentVo) throws Exception {

        return delete("intra.cms.content.deleteContent", contentVo);
    }

    /**
     * 사용자컨텐츠 일련번호 반환
     */
    @SuppressWarnings("unchecked")
    public List<Integer> getContentSeqNos(Map<String, Object> paramMap) throws Exception {

        return list("intra.cms.content.getContentSeqNos", paramMap);
    }

}
