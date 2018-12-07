/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.synchronize.impl.cms;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zes.core.bind.RequestBinder;
import zes.openworks.component.synchronize.SynchronizeService;
import zes.openworks.component.synchronize.SynchronizeVO;
import zes.openworks.intra.cms.layout.LayoutService;
import zes.openworks.intra.cms.layout.LayoutVO;
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
@Service("cmsLayoutSyncService")
public class CmsLayoutSyncServiceImpl implements SynchronizeService {

    @Autowired
    LayoutService layoutService;

    /**
     * 
     */
    @Override
    public void synchronize(HttpServletRequest request, SynchronizeVO synchronizeVo) throws Exception {

        LayoutVO layoutVo = new LayoutVO();

        RequestBinder.beanBind(layoutVo, request, null);

        layoutVo = layoutService.getLayout(layoutVo);

        CmsUtil.makeLayout(layoutVo.getLayoutContent(), layoutVo.getFilePath());

    }

}
