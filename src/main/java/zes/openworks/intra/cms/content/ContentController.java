/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.content;

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
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.pager.Pager;
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
 *  2012. 6. 27.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/cms/content")
public class ContentController extends IntraController {

    @Autowired
    ContentService contentService;
    @Autowired
    CmsService cmsService;
    @Autowired
    DomainService domainService;

    /**
     * 사용자컨텐츠 목록
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "INC_ContentList.do" })
    public void getContentList(HttpServletRequest request, ModelMap model, ContentVO contentVo) throws Exception {

        OpHelper.bindSearchMap(contentVo, request);

        CmsVO cmsVo = new CmsVO();
        cmsVo.setDomainCd(contentVo.getDomainCd());
        cmsVo.setMenuCode(contentVo.getMenuCode());
        cmsVo = cmsService.getMenu(cmsVo);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, cmsVo);

        Pager<ContentVO> dataList = contentService.getContentList(contentVo);

        model.addAttribute(GlobalConfig.KEY_PAGER, dataList);

    }

    /**
     * 사용자컨텐츠 상세
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_ContentForm.do", "PD_ContentView.do" })
    public void getContent(HttpServletRequest request, ModelMap model, ContentVO contentVo)
        throws Exception {

        OpHelper.bindSearchMap(contentVo, request);

        CmsVO cmsVo = new CmsVO();
        cmsVo.setDomainCd(contentVo.getQ_domainCd());
        cmsVo.setMenuCode(contentVo.getQ_menuCode());
        cmsVo = cmsService.getMenu(cmsVo);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, cmsVo);

        contentVo = contentService.getContent(contentVo);

        if(contentVo != null) {
            contentVo.setApprovalStNm(CmsConstant.APPROVAL_STAT.get(Integer.valueOf(contentVo.getApprovalSt())));
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, contentVo);

    }

    /**
     * 사용자컨텐츠 등록 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_InsertAction.do", method = RequestMethod.POST)
    public String insertAction(HttpServletRequest request, ModelMap model, ContentVO contentVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        contentVo.setRegId(loginVo.getMngrId());

        Object primaryKey = contentService.insertContent(contentVo);

        String url = "BD_ContentForm.do?" + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_contentSeqNo", primaryKey);

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 사용자컨텐츠 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_UpdateAction.do", method = RequestMethod.POST)
    public String updateAction(HttpServletRequest request, ModelMap model, ContentVO contentVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        contentVo.setModId(loginVo.getMngrId());

        int affected = contentService.updateContent(contentVo);

        if(affected < 1) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        if(null != contentVo.getApprovalSt() && contentVo.getApprovalSt().equals("1040")) {
            contentService.synchronize(contentVo);
        }

        return responseJson(model, Boolean.TRUE, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 사용자컨텐츠 삭제 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_DeleteAction.do", method = RequestMethod.POST)
    public String deleteAction(ModelMap model, ContentVO contentVo) throws Exception {

        int affected = contentService.deleteContent(contentVo);

        if(affected != 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        return alertAndClose(model, Messages.COMMON_DELETE_OK);

    }

    /**
     * 발행요청 대상 컨텐츠 목록 상태별
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_PublishContentList.do")
    public void getPublishContentList(HttpServletRequest request, ModelMap model,
        ContentVO contentVo, DomainVO domainVO) throws Exception {

        OpHelper.bindSearchMap(contentVo, request);

        if(Validate.isNull(contentVo.getDataMap().get("q_approvalSt"))) {
            contentVo.getDataMap().put("q_approvalSt", "1020");
        }

        LoginVO loginVo = getLoginSession(request);
        contentVo.setModId(loginVo.getMngrId());
        contentVo.getDataMap().put("q_modId", loginVo.getMngrId());

        List<Map<String, String>> appList = new ArrayList<Map<String, String>>();
        Map<String, String> appMap;

        Map<Integer, String> approvalStat = CmsConstant.APPROVAL_STAT;
        Iterator<Integer> it = approvalStat.keySet().iterator();
        Integer key;

        while(it.hasNext()) {

            key = it.next();

            appMap = new HashMap<String, String>();
            appMap.put("KEY", String.valueOf(key));
            appMap.put("VAL", approvalStat.get(key));

            appList.add(appMap);
        }

        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        Pager<ContentVO> dataList = contentService.getContentList(contentVo);

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, appList);
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);
        model.addAttribute(GlobalConfig.KEY_PAGER, dataList);

    }

    /**
     * 사용자컨텐츠 소스비교보기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "PD_SourceDiffView.do" })
    public void getSourceDiffView(HttpServletRequest request, ModelMap model, ContentDiffVO contentDiffVO)
        throws Exception {

        OpHelper.bindSearchMap(contentDiffVO, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, contentService.getSourceDiffView(contentDiffVO));
        model.addAttribute(GlobalConfig.KEY_BASE_VO, contentDiffVO);

    }

    /**
     * 사용자컨텐츠 화면비교보기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "PD_ScreenDiffView.do" })
    public void getScreenDiffView(HttpServletRequest request, ModelMap model, ContentDiffVO contentDiffVO)
        throws Exception {

        OpHelper.bindSearchMap(contentDiffVO, request);

        CmsVO cmsVo = new CmsVO();
        cmsVo.setDomainCd(contentDiffVO.getDomainCd());
        cmsVo.setMenuCode(contentDiffVO.getMenuCode());
        cmsVo = cmsService.getMenu(cmsVo);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, cmsVo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, contentService.getScreenDiffView(contentDiffVO));

    }
}
