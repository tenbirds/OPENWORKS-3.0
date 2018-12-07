/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.content;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.spi.commons.configuration.Config;
import zes.core.spi.diff.DiffView;
import zes.core.spi.diff.DiffViewImpl;
import zes.core.spi.diff.DiffViewVO;
import zes.core.utils.SynchronizeUtil;
import zes.openworks.component.domain.DomainDAO;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.intra.cms.CmsConstant;
import zes.openworks.intra.cms.CmsDAO;
import zes.openworks.intra.cms.CmsVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 사용자컨텐츠 서비스 객체
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
@Service("contentService")
public class ContentServiceImpl extends AbstractServiceImpl implements ContentService {

    @Resource
    private CmsDAO cmsDAO;
    @Resource
    private ContentDAO contentDAO;
    @Resource
    private DomainDAO domainDAO;

    @Override
    public ContentVO getContent(ContentVO contentVo) throws Exception {

        return contentDAO.getContent(contentVo);
    }

    @Override
    public Pager<ContentVO> getContentList(ContentVO contentVo) throws Exception {

        return contentDAO.getContentList(contentVo);
    }

    @Override
    public Object insertContent(ContentVO contentVo) throws Exception {

        CmsVO cmsVo = new CmsVO();
        cmsVo.setDomainCd(contentVo.getDomainCd());
        cmsVo.setMenuCode(contentVo.getMenuCode());
        cmsVo = cmsDAO.getMenu(cmsVo);

        // 작성중 상태
        contentVo.setApprovalSt(Config.getString("cms.approval.write[@code]"));

        return contentDAO.insertContent(cmsVo, contentVo);
    }

    @Override
    public int updateContent(ContentVO contentVo) throws Exception {

        int updateCnt = 0;

        if(null != contentVo.getApprovalSt() && contentVo.getApprovalSt().equals("1040")) {
            contentVo.setApplyYn("Y");
            updateCnt = contentDAO.updateContent(contentVo);

        } else {
            updateCnt = contentDAO.updateContent(contentVo);
        }

        return updateCnt;
    }

    @Override
    public int deleteContent(ContentVO contentVo) throws Exception {

        return contentDAO.deleteContent(contentVo);
    }

    @Override
    public List<DiffViewVO> getSourceDiffView(ContentDiffVO contentDiffVO) throws Exception {

        // 비교를 위한 두개 버전의 컨텐츠 정보를 설정한다.
        setDiffContent(contentDiffVO);

        // 좌측 비교화면 컨텐츠
        StringBuilder leftDiff = new StringBuilder();
        if(contentDiffVO.getLeftContent().getHeadContent() != null) {
            leftDiff.append(contentDiffVO.getLeftContent().getHeadContent()).append(CmsConstant.SYS_LINE_SEPA);
        }

        leftDiff.append(contentDiffVO.getLeftContent().getBodyContent());

        // 우측비교화면 컨텐츠
        StringBuilder rightDiff = new StringBuilder();
        if(contentDiffVO.getRightContent() != null) {

            if(contentDiffVO.getRightContent().getHeadContent() != null) {
                rightDiff.append(contentDiffVO.getRightContent().getHeadContent()).append(CmsConstant.SYS_LINE_SEPA);
            }

            rightDiff.append(contentDiffVO.getRightContent().getBodyContent());
        }

        DiffView diffView = new DiffViewImpl().setOldContent(leftDiff).setNewContent(rightDiff);

        return diffView.getDiffVoList();
    }

    @Override
    public ContentDiffVO getScreenDiffView(ContentDiffVO contentDiffVO) throws Exception {

        // 비교를 위한 두개 버전의 컨텐츠 정보를 설정한다.
        setDiffContent(contentDiffVO);

        return contentDiffVO;
    }

    @Override
    public String synchronize(ContentVO contentVo) throws Exception {

        List<DomainGroupVO> domainGroup = domainDAO.getDomainGroupSync(contentVo.getDomainCd());

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("serviceName", "cmsContentSyncService");
        param.put("q_domainCd", contentVo.getDomainCd());
        param.put("q_menuCode", contentVo.getMenuCode());
        param.put("q_contentSeqNo", contentVo.getContentSeqNo());

        return SynchronizeUtil.synchronize(domainGroup, param);
    }

    /**
     * 비교를 위한 두개 버전의 컨텐츠 정보를 설정한다.
     * 
     * @param contentDiffVO
     * @throws Exception
     */
    private void setDiffContent(ContentDiffVO contentDiffVO) throws Exception {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.putAll(contentDiffVO.getDataMap());

        ContentVO leftContent = new ContentVO();
        paramMap.put("q_contentSeqNo", paramMap.get("q_leftContentSeqNo"));
        leftContent.setDataMap(paramMap);
        leftContent = getContent(leftContent);

        ContentVO rightContent = new ContentVO();
        // 비교 컨텐츠에 우측(비교대상)에 해당하는 컨텐츠가 없는 경우 현재 적용된 컨텐츠를 설정한다.
        if(null != paramMap.get("q_rightContentSeqNo")) {
            paramMap.put("q_contentSeqNo", paramMap.get("q_rightContentSeqNo"));
        } else {
            paramMap.put("q_contentSeqNo", null);
            paramMap.put("q_applyYn", "Y");
        }

        rightContent.setDataMap(paramMap);
        rightContent = getContent(rightContent);

        contentDiffVO.setLeftContent(leftContent);
        contentDiffVO.setRightContent(rightContent);

        contentDiffVO.setContentSeqNos(contentDAO.getContentSeqNos(paramMap));

    }

}
