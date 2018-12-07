/*
 * Copyright (c) 2010 ZESINC Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZESINC Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZESINC Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.poll;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.cms.support.CmsReference;
import zes.openworks.intra.cms.support.CmsReferenceVO;
import zes.openworks.intra.login.LoginVO;

/**
 * <pre>
 * 설문조사 관리 컨트롤러
 * </pre>
 * 
 * @author yesno
 * @version $Id: PollController.java 456 2010-02-25 12:09:41Z yesno $
 */
@Controller
@RequestMapping(value = "/intra/poll")
@CmsReference(name = "설문조사", method = "getCmsRefrence")
public class PollController extends IntraController {

    @Autowired
    PollService pollService;

    /**
     * 사용자 메뉴관리에서 본 기능의 링크를 획득하기 위한 함수
     * xanadu : 2011. 3. 8.
     * 
     * @return 게시판 목록(url, 게시판명
     */
    public List<CmsReferenceVO> getCmsRefrence() {

        List<PollDomainVO> pollDomainList = pollService.getDomainList(new PollDomainVO());

        List<CmsReferenceVO> reference = new ArrayList<CmsReferenceVO>();
        CmsReferenceVO cmsReferenceVO;

        for(PollDomainVO pollDomainVO : pollDomainList) {

            cmsReferenceVO = new CmsReferenceVO();
            cmsReferenceVO.setName(pollDomainVO.getDomainNm() + " 홈페이지 용");

            cmsReferenceVO.setUserMenuUrl("/web/poll/BD_pollList.do");
            cmsReferenceVO.setAdminMenuUrl("/intra/poll/BD_pollList.do?q_domainCd=" + pollDomainVO.getDomainCd());

            reference.add(cmsReferenceVO);
        }

        return reference;
    }

    /**
     * 기본정보 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_pollList.do", method = RequestMethod.GET)
    public void pollList(ModelMap model, HttpServletRequest request, PollVO pollVo, PollDomainVO pollDomainVo) {

        OpHelper.bindSearchMap(pollVo, request);

        LoginVO loginVo = getLoginSession(request);
        pollVo.setRegId(loginVo.getMngrId());

        model.addAttribute("isSuper", isSuperUser(request));

        model.addAttribute("domainList", pollService.getDomainList(pollDomainVo));
        model.addAttribute(GlobalConfig.KEY_PAGER, pollService.pollList(pollVo));
    }

    /**
     * 기본정보 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_pollView.do", method = RequestMethod.GET)
    public void pollView(ModelMap model, HttpServletRequest request, PollVO pollVo, PollDomainVO pollDomainVo) {

        OpHelper.bindSearchMap(pollVo, request);

        LoginVO loginVo = getLoginSession(request);
        pollVo.setRegId(loginVo.getMngrId());
        pollVo.setDeptCd(loginVo.getDeptCode());

        model.addAttribute("domainList", pollService.getDomainList(pollDomainVo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, pollService.pollView(pollVo));
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, pollService.pollGroupList(pollVo));
    }

    /**
     * 기본정보 등록 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_pollInsertForm.do", method = RequestMethod.GET)
    public void pollInsertForm(ModelMap model, HttpServletRequest request, PollDomainVO pollDomainVo)
        throws Exception {

        model.addAttribute("domainList", pollService.getDomainList(pollDomainVo));
    }

    /**
     * 기본정보 등록(설문추가)
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_pollInsertAction.do", method = RequestMethod.POST)
    public String pollInsertAction(ModelMap model, HttpServletRequest request, PollVO pollVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        pollVo.setRegId(loginVo.getMngrId());
        pollVo.setDeptCd(loginVo.getDeptCode());

        Integer selectKey = pollService.pollInsertAction(pollVo);

        if(Validate.isEmpty(selectKey)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        StringBuilder queryString = new StringBuilder();
        queryString.append("BD_pollView.do?").append(RequestUtil.getSearchQueryString(request)).append("&q_seq=")
            .append(selectKey);

        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, queryString.toString());
    }

    /**
     * 기본정보 수정 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_pollUpdateForm.do", method = RequestMethod.GET)
    public void pollUpdateForm(ModelMap model, HttpServletRequest request, PollVO pollVo, PollDomainVO pollDomainVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        pollVo.setRegId(loginVo.getMngrId());
        pollVo.setDeptCd(loginVo.getDeptCode());

        model.addAttribute("domainList", pollService.getDomainList(pollDomainVo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, pollService.pollView(pollVo));
    }

    /**
     * 기본정보 수정
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_pollUpdateAction.do", method = RequestMethod.POST)
    public String pollUpdateAction(ModelMap model, HttpServletRequest request, PollVO pollVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        pollVo.setRegId(loginVo.getMngrId());
        pollVo.setDeptCd(loginVo.getDeptCode());

        int updatedCnt = pollService.pollUpdateAction(pollVo);

        StringBuilder queryString = new StringBuilder();
        queryString.append("BD_pollView.do?").append(RequestUtil.getSearchQueryString(request));

        if(updatedCnt < 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, queryString.toString());
    }

    /**
     * 기본정보(설문) 삭제
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_pollDeleteAction.do", method = RequestMethod.POST)
    public String pollDeleteAction(ModelMap model, HttpServletRequest request, PollVO pollVo)
        throws Exception {

        int deletedCnt = pollService.pollDeleteAction(pollVo);

        if(deletedCnt < 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, "BD_pollList.do");
    }

    /**
     * 그룹등록 - 문항당 속성정보와 상세 설문항목을 셋트로 저장함
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_pollGroupInsertAction.do", method = RequestMethod.POST)
    public String pollGroupInsertAction(ModelMap model, HttpServletRequest request,
        PollGroupVO pollGroupVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        pollGroupVo.setRegId(loginVo.getMngrId());

        Integer selectKey = pollService.pollGroupInsertAction(pollGroupVo);

        if(Validate.isEmpty(selectKey)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }
        StringBuilder queryString = new StringBuilder();
        queryString.append("BD_pollView.do?").append(RequestUtil.getSearchQueryString(request));

        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, queryString.toString());
    }

    /**
     * 설문정보 항목 수정
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_pollGroupUpdateAction.do", method = RequestMethod.POST)
    public String pollGroupUpdateAction(ModelMap model, HttpServletRequest request,
        PollGroupVO pollGroupVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        pollGroupVo.setRegId(loginVo.getMngrId());

        int updatedCnt = pollService.pollGroupUpdateAction(pollGroupVo);

        if(updatedCnt < 1) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Boolean.TRUE, updatedCnt, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 설문항목 삭제
     * 
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_pollGroupDeleteAction.do", method = RequestMethod.GET)
    public String pollGroupDeleteAction(ModelMap model, HttpServletRequest request,
        PollGroupVO pollGroupVo) throws Exception {

        int deletedCnt = pollService.pollGroupDeleteAction(pollGroupVo);

        if(deletedCnt < 1) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Boolean.TRUE, deletedCnt, Messages.COMMON_DELETE_OK);
    }

    /**
     * 기타의견 또는 단답형 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_pollCommentList.do", method = RequestMethod.GET)
    public void pollCommentList(ModelMap model, HttpServletRequest request, PollGroupVO pollGroupVo) {

        OpHelper.bindSearchMap(pollGroupVo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, pollService.pollCommentList(pollGroupVo));
    }

    /**
     * 설문참여자 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_pollResponseList.do", method = RequestMethod.GET)
    public void pollResponseList(ModelMap model, HttpServletRequest request,
        PollResponseVO pollResponseVo) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, pollService.pollResponseList(pollResponseVo));
    }

}
