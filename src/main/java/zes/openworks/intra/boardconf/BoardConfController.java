/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.read.biff.BiffException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.bind.RequestBinder;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.login.LoginVO;

/**
 * 게시판 관리 Controller
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *  수정일			수정자					 수정내용
 * --------------  --------  ---------------------------------
 *  2012. 4. 24.	  손재숙	  JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20.   박꽃송이    DB 컬럼(사이트 구분 - DOMAIN_CD) 추가로 인한 수정 및 추가
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/boardconf")
public class BoardConfController extends IntraController {

    @Autowired
    private BoardConfService boardConfService;
    @Autowired
    DomainService domainService;

    /**
     * 게시판 목록 조회
     */
    @SuppressWarnings("rawtypes")
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_boardconf.list.do", method = RequestMethod.GET)
    public void boardConfList(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) {
        OpHelper.bindSearchMap(boardConfVO, request);

        //세션에서 로그인 정보 가져오기 및 권한정보 가져오기 #1
        LoginVO loginVo = getLoginSession(request);
        if(loginVo != null) {
            HashMap authMap = getLoginAuth(loginVo);
            model.addAttribute("auth", authMap);
            //언어별 관리자가 들어 왔을 경우에는 해당 언어의 목록을 조회 할수 있도록 조건값 적용

            /* 일단 ★★★   권한이 아직없기때문에 강제로 정보 넣어주기 아래는 삭제해야함  ★★★  */
//            boardConfVO.setQ_domain_cd(2); 아래도 지워야하지만 현재 모든 게시판을 보여주려고 도메인 시디를 안넣는다.
            model.addAttribute("domCd", 2);
            
            //            if(authMap.get("kmt_tot_adm").toString() == "N") {
//                if(authMap.get("admengyn").toString() == "Y") {
//                    boardConfVO.setQ_domain_cd(Integer.parseInt(authMap.get("q_domCd").toString()));
//                    model.addAttribute("domCd", Integer.parseInt(authMap.get("q_domCd").toString()));
//                } else if(authMap.get("admjpnyn").toString() == "Y") {
//                    boardConfVO.setQ_domain_cd(Integer.parseInt(authMap.get("q_domCd").toString()));
//                    model.addAttribute("domCd", Integer.parseInt(authMap.get("q_domCd").toString()));
//                } else if(authMap.get("admchnyn").toString() == "Y") {
//                    boardConfVO.setQ_domain_cd(Integer.parseInt(authMap.get("q_domCd").toString()));
//                    model.addAttribute("domCd", Integer.parseInt(authMap.get("q_domCd").toString()));
//                }
//            }
            
            
            
        }
        model.addAttribute(GlobalConfig.KEY_PAGER, boardConfService.boardConfList(boardConfVO));
    }

    /**
     * 게시판 기본 설정 등록 폼
     * @throws Exception 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_boardconf.insert.form.do", method = RequestMethod.GET)
    public String insertForm(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) throws Exception {
        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, new BoardConfVO());
        model.addAttribute("kndCdMap", BoardConfConstant.MAP_KIND_CD);

        // 게시판 템플릿 종류
        model.addAttribute("listTemplates", boardConfService.boardTemplateList("L"));
        model.addAttribute("viewTemplates", boardConfService.boardTemplateList("V"));
        model.addAttribute("formTemplates", boardConfService.boardTemplateList("F"));

        //도메인 목록
        DomainVO domainVo = new DomainVO();
        domainVo.setUseYn("Y");
        List<DomainVO> domainList = domainService.getDomainList(domainVo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, domainList);

        return baseUrl + "/BD_boardconf.insert.form";
    }

    /**
     * 게시판 기본 설정 수정 폼
     * @throws Exception 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_boardconf.update.form.do", method = RequestMethod.GET)
    public String updateForm(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) throws Exception {
        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);
        
        if(Validate.isNotEmpty(boardConfVO.getDataMap().get("q_domainCd")) && Validate.isNotEmpty(boardConfVO.getDataMap().get("q_bbsCd"))) {
            boardConfVO.setDomainCd(Integer.parseInt(boardConfVO.getDataMap().get("q_domainCd").toString()));
            boardConfVO.setBbsCd(Integer.parseInt(boardConfVO.getDataMap().get("q_bbsCd").toString()));
            boardConfVO.setGubunCd(BoardConfConstant.GUBUN_CD_GLOBAL);
            model.addAttribute(GlobalConfig.KEY_DATA_VO, boardConfService.boardConfView(boardConfVO));
        }

        model.addAttribute("kndCdMap", BoardConfConstant.MAP_KIND_CD);

        // 게시판 템플릿 종류
        model.addAttribute("listTemplates", boardConfService.boardTemplateList("L"));
        model.addAttribute("viewTemplates", boardConfService.boardTemplateList("V"));
        model.addAttribute("formTemplates", boardConfService.boardTemplateList("F"));

        //도메인 목록
        DomainVO domainVo = new DomainVO();
        domainVo.setUseYn("Y");
        List<DomainVO> domainList = domainService.getDomainList(domainVo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, domainList);

        return baseUrl + "/BD_boardconf.update.form";
    }

    /**
     * 게시판 목록 설정 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_list.config.do", method = RequestMethod.POST)
    public String listConfig(HttpServletRequest request, ModelMap model, HttpServletResponse response, BoardConfVO boardConfVO) {
        response.setHeader("Cache-Control", "no-cache");// HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);

        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        if(Validate.isEmpty(boardConfVO.getBbsCd())) {
            model.addAttribute(GlobalConfig.KEY_DATA_VO, new BoardConfVO());
        } else {
            boardConfVO.setGubunCd(BoardConfConstant.GUBUN_CD_LIST);
            model.addAttribute(GlobalConfig.KEY_DATA_VO, boardConfService.boardConfView(boardConfVO));
        }

        model.addAttribute("registerViewCdMap", BoardConfConstant.MAP_REGISTER_VIEW_CD);

        return baseUrl + "/INC_list.config";
    }

    /**
     * 게시판 목록 배치 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_list.arrange.do", method = RequestMethod.POST)
    public String listArrange(ModelMap model, HttpServletResponse response, BoardArrangeVO boardArrangeVO) {
        response.setHeader("Cache-Control", "no-cache");// HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);
        
        if(Validate.isEmpty(boardArrangeVO.getBbsCd())) {
            model.addAttribute("boardDisplayColumnList", new BoardArrangeVO());
        } else {
            boardArrangeVO.setListViewSe(BoardConfConstant.GUBUN_DISPLAY_COLUMN_LIST);
            List<BoardArrangeVO> list = boardConfService.boardDisplayColumnList(boardArrangeVO);
            model.addAttribute("boardDisplayColumnList", list);
        }

        model.addAttribute("boardColumnList", boardConfService.boardColumnList(boardArrangeVO));

        return baseUrl + "/INC_list.arrange";
    }

    /**
     * 게시판 상세조회 설정 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_view.config.do", method = RequestMethod.POST)
    public String viewConfig(HttpServletRequest request, ModelMap model, HttpServletResponse response, BoardConfVO boardConfVO) {
        response.setHeader("Cache-Control", "no-cache");// HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);

        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        if(Validate.isEmpty(boardConfVO.getBbsCd())) {
            model.addAttribute(GlobalConfig.KEY_DATA_VO, new BoardConfVO());
        } else {
            boardConfVO.setGubunCd(BoardConfConstant.GUBUN_CD_VIEW);
            model.addAttribute(GlobalConfig.KEY_DATA_VO, boardConfService.boardConfView(boardConfVO));
        }

        model.addAttribute("listViewCdMap", BoardConfConstant.MAP_LIST_VIEW_CD);

        return baseUrl + "/INC_view.config";
    }

    /**
     * 게시판 상세조회 배치 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_view.arrange.do", method = RequestMethod.POST)
    public String viewArrange(ModelMap model, HttpServletResponse response, BoardArrangeVO boardArrangeVO) {
        response.setHeader("Cache-Control", "no-cache");// HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);

        if(Validate.isEmpty(boardArrangeVO.getBbsCd())) {
            model.addAttribute("boardDisplayColumnList", new BoardArrangeVO());
        } else {
            boardArrangeVO.setListViewSe(BoardConfConstant.GUBUN_DISPLAY_COLUMN_VIEW);
            List<BoardArrangeVO> list = boardConfService.boardDisplayColumnList(boardArrangeVO);
            model.addAttribute("boardDisplayColumnList", list);
        }

        model.addAttribute("boardColumnList", boardConfService.boardColumnList(boardArrangeVO));

        return baseUrl + "/INC_view.arrange";
    }

    /**
     * 게시판 입력폼(등록/수정) 설정 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_form.config.do", method = RequestMethod.POST)
    public String formConfig(ModelMap model, HttpServletRequest request, HttpServletResponse response, BoardConfVO boardConfVO) {
        response.setHeader("Cache-Control", "no-cache");// HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);

        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        if(Validate.isEmpty(boardConfVO.getBbsCd())) {
            model.addAttribute(GlobalConfig.KEY_DATA_VO, new BoardConfVO());
        } else {
            boardConfVO.setGubunCd(BoardConfConstant.GUBUN_CD_FORM);
            model.addAttribute(GlobalConfig.KEY_DATA_VO, boardConfService.boardConfView(boardConfVO));
        }

        return baseUrl + "/INC_form.config";
    }

    /**
     * 게시판 확장관리(표시항목 및 추가 컬럼)
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_ext.config.do", method = RequestMethod.POST)
    public String extConfig(HttpServletRequest request, ModelMap model, HttpServletResponse response, BoardConfVO boardConfVO) {
        response.setHeader("Cache-Control", "no-cache");// HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);

        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        List<BoardExtensionVO> extList = boardConfService.boardConfExtList(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, extList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, BoardConfConstant.SEARCH_TYPE_LIST);

        return baseUrl + "/INC_ext.config";
    }

    /**
     * 게시판 관리 보기/웹 미리보기
     */
    @RequestMapping(value = { "AR_manageBoard.do", "AR_webBoard.do" }, method = RequestMethod.GET)
    public void manageBbs(ModelMap model, BoardConfVO boardConfVO) throws Exception {
        if(Validate.isEmpty(boardConfVO.getBbsCd())) {
            throw new Exception("INVALID_ARGUMENTS");
        }

    }

    /**
     * 게시판 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.insert.do", method = RequestMethod.POST)
    public String boardConfInsert(ModelMap model, HttpServletRequest request, BoardConfVO boardConfVO) throws Exception {
        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        if(holder.isValid()) {
            // 등록 실행
            Object key = boardConfService.insertAction(boardConfVO);
            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_boardconf.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 게시판 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.update.do", method = RequestMethod.POST)
    public String updateAction(ModelMap model, HttpServletRequest request, BoardConfVO boardConfVO) throws Exception {
        
        int affected = 0;
        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        if(holder.isValid()) {
            // 수정 실행
            affected = boardConfService.updateAction(boardConfVO);
            if(affected != StringUtil.ONE) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }
        
        String url = "BD_boardconf.update.form.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 게시판 수정 액션(기본 설정을 제외한 설정 수정) - ui-tabs 사용 시
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.update2.do", method = RequestMethod.POST)
    public String updateTabsAction(ModelMap model, BoardConfVO boardConfVO) throws Exception {
        int affected = 0;
        // 수정 실행
        affected = boardConfService.updateAction(boardConfVO);
        if(affected != StringUtil.ONE) {
            return responseJson(model, Messages.TRUE);
        }else{
            return responseJson(model, Messages.FALSE);
        }
    }

    /**
     * 게시판 목록/상세 배치 수정 액션
     * @throws IOException 
     * @throws BiffException 
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.arrange.update.do", method = RequestMethod.POST)
    public String arrangeUpdateAction(ModelMap model, BoardArrangeVO boardArrangeVO, HttpServletRequest request) throws Exception {
        
        int affected = boardConfService.arrangeUpdateAction(boardArrangeVO,request);
        if(affected < StringUtil.ONE) {
            return responseText(model, Messages.FALSE);
        }else{
            return responseText(model, Messages.TRUE);
        }
        
    }

    /**
     * 게시판 확장 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.ext.update.do", method = RequestMethod.POST)
    public String extUpdateAction(ModelMap model, HttpServletRequest request,
        @RequestParam(value = "domainCd", required = false) Integer domainCd,
        @RequestParam(value = "bbsCd", required = false) Integer bbsCd) throws Exception {
        List<BoardExtensionVO> boardExtList = new ArrayList<BoardExtensionVO>();
        String[] columnIds = request.getParameterValues("columnId");

        BoardExtensionVO boardExtensionVO;
        for(String columnId : columnIds) {
            boardExtensionVO = new BoardExtensionVO();
            RequestBinder.beanBind(boardExtensionVO, request, columnId + "_");
            boardExtensionVO.setDomainCd(domainCd);
            boardExtensionVO.setBbsCd(bbsCd);
            boardExtensionVO.setColumnId(columnId);
            boardExtList.add(boardExtensionVO);
        }

        int affected = 0;
        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardExtList);
        if(holder.isValid()) {
            // 수정 실행
            affected = boardConfService.updateExtAction(boardExtList);
            if(affected < StringUtil.ONE) {
                return responseText(model, Messages.FALSE);
            }
        } else {
            return responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);
    }

    /**
     * 게시판 옵션별 사용여부 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_ynUpdateAction.do", method = RequestMethod.POST)
    public String ynUpdateAction(ModelMap model, @ModelAttribute BoardConfYnVO boardConfYnVO,
        @RequestParam(value = "fieldColumn", required = true) String fieldColumn,
        @RequestParam(value = "fieldYn", required = true) String fieldYn) throws Exception {

    	if(boardConfYnVO == null) {
            throw new Exception("INVALID_ARGUMENTS");
        }

        configureBbsConfVO(boardConfYnVO, fieldColumn, fieldYn);

        int affected = boardConfService.updateAction(boardConfYnVO);

        if(affected != StringUtil.ONE) {
            throw new Exception("DB_UPDATE_FAIL");
        }

        return responseJson(model, boardConfService.updateAction(boardConfYnVO));
    }
    
    private void configureBbsConfVO(BoardConfYnVO boardConfYnVO, String fieldColumn, String fieldYn) {
        if(fieldColumn.equals("useYn")) {
            boardConfYnVO.setUseYn(fieldYn);
        } else if(fieldColumn.equals("ctgYn")) {
            boardConfYnVO.setCtgYn(fieldYn);
        } else if(fieldColumn.equals("fileYn")) {
            boardConfYnVO.setFileYn(fieldYn);
        } else if(fieldColumn.equals("captchaYn")) {
            boardConfYnVO.setCaptchaYn(fieldYn);
        } else if(fieldColumn.equals("recomendYn")) {
            boardConfYnVO.setRecomendYn(fieldYn);
        } else if(fieldColumn.equals("cmtYn")) {
            boardConfYnVO.setCmtYn(fieldYn);
        } else if(fieldColumn.equals("noticeBbscttUseYn")) {
            boardConfYnVO.setNoticeBbscttUseYn(fieldYn);
        } else if(fieldColumn.equals("userEditorYn")) {
            boardConfYnVO.setUserEditorYn(fieldYn);
        } else if(fieldColumn.equals("dwldYn")) {
            boardConfYnVO.setDwldYn(fieldYn);
        } else if(fieldColumn.equals("feedYn")) {
            boardConfYnVO.setFeedYn(fieldYn);
        } else if(fieldColumn.equals("accuseYn")) {
            boardConfYnVO.setAccuseYn(fieldYn);
        } else if(fieldColumn.equals("stsfdgYn")) {
            boardConfYnVO.setStsfdgYn(fieldYn);
        }
    }

    /**
     * 게시판 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.delete.do", method = RequestMethod.POST)
    public String boardConfDelete(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) throws Exception {
        OpHelper.bindSearchMap(boardConfVO, request);

        Integer cnt = boardConfService.boardConfDelete(boardConfVO);
        if(cnt != 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_boardconf.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 게시판 목록 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.list.delete.do", method = RequestMethod.POST)
    public String boardConfListDelete(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) throws Exception {
        OpHelper.bindSearchMap(boardConfVO, request);
        
        Integer cnt = boardConfService.boardConfListDelete(boardConfVO);
        if(cnt <= 0) {
            return responseText(model, Messages.COMMON_PROCESS_FAIL);
        }

        return responseText(model, cnt);
    }

    /**
     * 게시판 복사 등록 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_boardconf.copy.form.do", method = RequestMethod.GET)
    public void copyForm(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) {
        OpHelper.bindSearchMap(boardConfVO, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardConfVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);
    }

    /**
     * 게시판 복사 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_boardconf.copy.do", method = RequestMethod.POST)
    public String copyAction(HttpServletRequest request, ModelMap model,
        @RequestParam(value = "domainCd", required = true) String domainCd,
        @RequestParam(value = "bbsCd", required = true) String oldBbsCd,
        @RequestParam(value = "bbsNm", required = true) String newBbsNm,
        @RequestParam(value = "bbsDc", required = false) String newBbsDc) throws Exception {
        
        Object primaryKey = boardConfService.copyAction(domainCd, oldBbsCd, newBbsNm, newBbsDc);

        if(primaryKey == null) {
            return responseText(model, Messages.COMMON_PROCESS_FAIL);
        }

        return responseText(model, "200");
    }
    
    
    /* -------------------- 2014. 3. 17 추가 --------------------*/
    
    /**
     * 도메인별 메뉴 목록 불러오기
     */
    @SuppressWarnings("rawtypes")
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_boardTypeList.do", method = RequestMethod.GET)
    public String boardTypeList(HttpServletRequest request, ModelMap model, BoardConfVO boardConfVO) {
        OpHelper.bindSearchMap(boardConfVO, request);

        //대메뉴 목록 불러오기 
        List userMenuList = boardConfService.boardTypeList(boardConfVO);
        
        return responseJson(model, userMenuList);
    }
    
}

