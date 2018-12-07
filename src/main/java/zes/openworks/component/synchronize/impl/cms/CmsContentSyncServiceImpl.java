/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.synchronize.impl.cms;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.component.synchronize.SynchronizeService;
import zes.openworks.component.synchronize.SynchronizeVO;
import zes.openworks.intra.cms.CmsDAO;
import zes.openworks.intra.cms.CmsVO;
import zes.openworks.intra.cms.content.ContentDAO;
import zes.openworks.intra.cms.content.ContentVO;
import zes.openworks.intra.cms.support.CmsUtil;

/**
 * CMS Layout 정보 동기화
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
 *  2012. 5. 9.    방기배   신규 생성
 * </pre>
 * @see
 */
@Service("cmsContentSyncService")
public class CmsContentSyncServiceImpl implements SynchronizeService {

    @Resource
    private ContentDAO contentDAO;
    @Resource
    private CmsDAO cmsDAO;

    /**
     * 
     */
    @Override
    public void synchronize(HttpServletRequest request, SynchronizeVO synchronizeVo) throws Exception {

        ContentVO contentVo = new ContentVO();
        OpHelper.bindRequestMap(contentVo, request);

        contentVo = contentDAO.getContent(contentVo);

        CmsVO cmsVO = new CmsVO();
        cmsVO.setDomainCd(contentVo.getDomainCd());
        cmsVO.setMenuCode(contentVo.getMenuCode());

        cmsVO = cmsDAO.getMenu(cmsVO);

        String title = cmsVO.getTitle();
        if(Validate.isEmpty(title)) {
            title = cmsVO.getMenuNm();
        }

        CmsUtil.makeContent(contentVo.getMenuCode(), cmsVO.getBasePath(), title, contentVo.getHeadContent(), contentVo.getBodyContent());

    }

}
