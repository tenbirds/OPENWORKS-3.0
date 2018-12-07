/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.utils.SynchronizeUtil;
import zes.openworks.component.domain.DomainDAO;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.intra.cms.CmsDAO;
import zes.openworks.intra.cms.CmsVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 사용자 컨텐츠 승인/반려 관리
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
 *  2012. 6. 21.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("contentManageService")
public class ContentManageServiceImpl extends AbstractServiceImpl implements ContentManageService {

    @Resource
    private ContentManageDAO contentManageDAO;
    @Resource
    private CmsDAO cmsDAO;
    @Resource
    private DomainDAO domainDAO;

    @Override
    public Pager<ContentManageVO> getApproveContentList(ContentManageVO contentManageVo) throws Exception {

        return contentManageDAO.getApproveContentList(contentManageVo);
    }

    @Override
    public ContentManageVO getApproveContent(ContentManageVO contentManageVo) throws Exception {

        return contentManageDAO.getApproveContent(contentManageVo);
    }

    @Override
    public int approveAction(ContentManageVO contentManageVo) throws Exception {

        int approveCnt = 0;

        /*
         * 승인 처리하는 경우 아래 로직을 수행하여 등록된 컨텐츠 내용을 파일로 출판한다.
         * 반려의 경우는 단순 UPDATE를 수행한다.(반려코드와 반려 사유 등록)
         */
        if(contentManageVo.getApprovalSt().equals("1040")) {

            CmsVO cmsVo = new CmsVO();
            cmsVo.setDomainCd(contentManageVo.getDomainCd());
            cmsVo.setMenuCode(contentManageVo.getMenuCode());
            cmsVo = cmsDAO.getMenu(cmsVo);

            approveCnt = contentManageDAO.approveAction(contentManageVo);

        } else {
            approveCnt = contentManageDAO.approveAction(contentManageVo);
        }

        return approveCnt;
    }

    @Override
    public String synchronize(ContentManageVO contentManageVo) throws Exception {

        List<DomainGroupVO> domainGroup = domainDAO.getDomainGroupSync(contentManageVo.getDomainCd());

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("serviceName", "cmsContentSyncService");
        param.put("q_domainCd", contentManageVo.getDomainCd());
        param.put("q_menuCode", contentManageVo.getMenuCode());
        param.put("q_contentSeqNo", contentManageVo.getCntntsSeq());

        return SynchronizeUtil.synchronize(domainGroup, param);
    }
}
