/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.manage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.cms.CmsConstant;
import zes.openworks.intra.cms.CmsService;
import zes.openworks.intra.cms.CmsVO;
import zes.openworks.intra.cms.content.ContentDiffVO;
import zes.openworks.intra.cms.content.ContentService;
import zes.openworks.intra.login.LoginVO;

/**
 * 사용자컨텐츠 관리
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
@Controller
@RequestMapping(value = "/intra/cms/manage")
public class ContentManageController extends IntraController {

    @Autowired
    DomainService domainService;
    @Autowired
    CmsService cmsService;
    @Autowired
    ContentService contentService;
    @Autowired
    ContentManageService contentManageService;

    /**
     * 승인 대상 컨텐츠 목록(총괄관리자)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_ApproveContentList.do")
    public void getApproveContentList(HttpServletRequest request, ModelMap model,
        ContentManageVO contentManageVo, DomainVO domainVO) throws Exception {

        OpHelper.bindSearchMap(contentManageVo, request);

        if(Validate.isNull(contentManageVo.getDataMap().get("q_approvalSt"))) {
            contentManageVo.getDataMap().put("q_approvalSt", "1020");
        }

        List<DomainVO> domainList = domainService.getDomainList(domainVO);

        Map<Integer, String> approvalStat = CmsConstant.APPROVAL_STAT;
        Iterator<Integer> it = approvalStat.keySet().iterator();
        Integer key;

        List<Map<String, String>> appList = new ArrayList<Map<String, String>>();
        Map<String, String> appMap;
        while(it.hasNext()) {

            key = it.next();

            appMap = new HashMap<String, String>();
            appMap.put("KEY", String.valueOf(key));
            appMap.put("VAL", approvalStat.get(key));

            appList.add(appMap);
        }

        // model.addAttribute("DOMAIN_CD", contentManageVo.getDomainCd());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, appList);
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);
        model.addAttribute(GlobalConfig.KEY_PAGER, contentManageService.getApproveContentList(contentManageVo));

    }

    /**
     * 사용자컨텐츠 소스비교보기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_ApproveSourceDiffView.do" })
    public void getApproveSourceDiffView(HttpServletRequest request, ModelMap model, ContentDiffVO contentDiffVO)
        throws Exception {

        OpHelper.bindSearchMap(contentDiffVO, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, contentService.getSourceDiffView(contentDiffVO));
        model.addAttribute(GlobalConfig.KEY_BASE_VO, contentDiffVO);

    }

    /**
     * 사용자컨텐츠 화면비교보기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_ApproveScreenDiffView.do" })
    public void getApproveScreenDiffView(HttpServletRequest request, ModelMap model, ContentDiffVO contentDiffVO)
        throws Exception {

        OpHelper.bindSearchMap(contentDiffVO, request);

        CmsVO cmsVO = new CmsVO();
        cmsVO.setDomainCd(contentDiffVO.getDomainCd());
        cmsVO.setMenuCode(contentDiffVO.getMenuCode());
        cmsVO = cmsService.getMenu(cmsVO);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, cmsVO);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, contentService.getScreenDiffView(contentDiffVO));

    }

    /**
     * 승인 대상 컨텐츠 승인/반려 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_ApproveAction.do")
    public String approveAction(HttpServletRequest request, ModelMap model, ContentManageVO contentManageVo)
        throws Exception {

        OpHelper.bindSearchMap(contentManageVo, request);

        LoginVO loginVo = getLoginSession(request);
        contentManageVo.setApprovalId(loginVo.getMngrId());

        int cnt = contentManageService.approveAction(contentManageVo);

        if(cnt != 1) {
            return responseJson(model, Boolean.TRUE, Messages.COMMON_PROCESS_FAIL);
        }

        if(null != contentManageVo.getApprovalSt() && contentManageVo.getApprovalSt().equals("1040")) {
            contentManageService.synchronize(contentManageVo);
        }

        return responseJson(model, Boolean.TRUE, Messages.COMMON_PROCESS_OK);

    }

}
