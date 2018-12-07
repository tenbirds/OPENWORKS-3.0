/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.support.SpringHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FeedVO;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.spi.oscache.Cache;
import zes.core.utils.Converter;
import zes.core.utils.CookieUtil;
import zes.core.utils.RequestUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.cache.BoardConfCache;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.intra.boardconf.BoardConfConstant;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.boardconf.BoardCtgVO;
import zes.openworks.intra.cms.support.CmsReference;
import zes.openworks.intra.cms.support.CmsReferenceVO;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.register.RegisterUserVO;

/**
 * 게시판 Controller
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *    수정일                  수정자                   수정내용
 * --------------  --------  ---------------------------------
 *  2012. 5. 14.      손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = { "/intra/board" })
@CmsReference(name = "게시판", method = "getCmsRefrence")
public class BoardController extends IntraController {

    private BoardService boardService;
    
    @Autowired
    private AutoMailService amservice;
    @Autowired
    private SmsTransHistService smsService;
    @Autowired
    private RegisterService registerService;
    @Autowired
    private PopService popService;
    @Autowired 
    private GoodsManageService service;
    
    public void setBoardService(HttpServletRequest request) {
        this.boardService = getBoardServiceName(request);
    }

    public void setBoardService(HttpServletRequest request, String pageType) {
       this.boardService = getBoardServiceName(request, pageType);
    }

    /**
     * 게시판 유형별 서비스 설정
     */
    private BoardService getBoardServiceName(HttpServletRequest request) {
        String serviceName = "";
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + request.getParameter("domainCd") + "_" + request.getParameter("bbsCd"));
        
        int kndCd = (boardConfVO.getKndCd() == null) ? 0 : boardConfVO.getKndCd();
        
        if(kndCd == 0) {
            kndCd = BoardConfConstant.GUBUN_BOARD_BASIC;
        }
        switch(kndCd) {
            case BoardConfConstant.GUBUN_BOARD_BASIC:
                serviceName = "basicBoardService";
                break;
            case BoardConfConstant.GUBUN_BOARD_PETITION:
                serviceName = "petitionBoardService";
                break;
            case BoardConfConstant.GUBUN_BOARD_REPLY:
                serviceName = "replyBoardService";
                break;
            case BoardConfConstant.GUBUN_BOARD_GALLERY:
                serviceName = "galleryBoardService";
                break;
            case BoardConfConstant.GUBUN_BOARD_EBOOK:
                serviceName = "ebookBoardService";
                break;
            case BoardConfConstant.GUBUN_BOARD_FAQ:
                serviceName = "faqBoardService";
                break;
            default:
                serviceName = "basicBoardService";
                break;
        }
        
        return (BoardService) SpringHelper.findService(request.getSession().getServletContext(), serviceName);
    }

    /**
     * 게시판 유형별 서비스 설정(템플릿별)
     */
    private BoardService getBoardServiceName(HttpServletRequest request, String pageType) {
        String serviceName = "", skinName = "";
        
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + request.getParameter("domainCd") + "_" + request.getParameter("bbsCd"));
        System.out.println("BoardConfCache.BBS_CD_KEY: " + BoardConfCache.BBS_CD_KEY); 
        System.out.println("domainCd: " + request.getParameter("domainCd"));
        System.out.println("bbsCd: " + request.getParameter("bbsCd"));
        
        if(pageType.equals("L")) {
            skinName = boardConfVO.getListSkin().toLowerCase();
        } else if(pageType.equals("V")) {
            skinName = boardConfVO.getViewSkin().toLowerCase();
        } else if(pageType.equals("F")) {
            skinName = boardConfVO.getFormSkin().toLowerCase();
        }
        if(skinName.contains("basic")) {
            serviceName = "basicBoardService";
        } else if(skinName.contains("petition")) {
            serviceName = "petitionBoardService";
        } else if(skinName.contains("reply")) {
            serviceName = "replyBoardService";
        } else if(skinName.contains("gallery")) {
            serviceName = "galleryBoardService";
        } else if(skinName.contains("ebook")) {
            serviceName = "ebookBoardService";
        } else if(skinName.contains("faq")) {
            serviceName = "faqBoardService";
        } else {
            serviceName = "basicBoardService";
        }

        return (BoardService) SpringHelper.findService(request.getSession().getServletContext(), serviceName);
    }

    /**
     * 각 템플릿별 폴더 이름을 가져온다.
     */
    private String getTemplateFolderName(Integer kndCd) {
        if(Validate.isEmpty(kndCd)) {
            return StringUtil.EMPTY;
        }
        switch(kndCd) {
            case BoardConfConstant.GUBUN_BOARD_BASIC:
                return "basic";
            case BoardConfConstant.GUBUN_BOARD_PETITION:
                return "petition";
            case BoardConfConstant.GUBUN_BOARD_REPLY:
                return "reply";
            case BoardConfConstant.GUBUN_BOARD_GALLERY:
                return "gallery";
            case BoardConfConstant.GUBUN_BOARD_EBOOK:
                return "ebook";
            case BoardConfConstant.GUBUN_BOARD_FAQ:
                return "faq";
            case BoardConfConstant.GUBUN_BOARD_COMMON:
                return "common";
            default:
                return "basic";
        }
    }

    /**
     * 각 템플릿별 베이스 URL("basePath/URI.do")
    private String getTemplateFolderName(String url, Integer kindCd, String skinPath) {
        if(Validate.isNotEmpty(skinPath)) {
            return ("intra/board/templates/" + skinPath + "/");
        } else if(Validate.isNotEmpty(kindCd)) {
            return ("intra/board/templates/" + getTemplateFolderName(kindCd) + "/");
        } else {
            return ("intra/board/templates/" + getTemplateFolderName(1001) + "/");
        }
    }
    */
    
    /**
     * 각 템플릿별 베이스 URL("basePath/URI.do")
     */
    private String getTemplateFolderName(String url, String skin, String skinPath) {
        if(Validate.isNotEmpty(skinPath)) {
            return ("intra/board/skin/" + skinPath + "/");
        } else if(Validate.isNotEmpty(skin)) {
            return ("intra/board/templates/" + skin + "/");
        } else {
            return ("intra/board/templates/" + getTemplateFolderName(1007) + "/"); //???????????????????????
        }
    }

    /**
     * 사용자 메뉴관리에서 본 기능의 링크를 획득하기 위한 함수
     * 
     * @return 게시판 목록(url, 게시판명)
     */
    public List<CmsReferenceVO> getCmsRefrence() {
        // 게시판 목록
        @SuppressWarnings("unchecked")
        List<BoardConfVO> boardConfList = (List<BoardConfVO>) Cache.get(BoardConfCache.CACHE_KEY);

        List<CmsReferenceVO> reference = new ArrayList<CmsReferenceVO>();
        CmsReferenceVO cmsReferenceVO;

        for(BoardConfVO boardConf : boardConfList) {
            cmsReferenceVO = new CmsReferenceVO();
            cmsReferenceVO.setName(boardConf.getBbsNm());

            cmsReferenceVO.setUserMenuUrl("/web/board/BD_board.list.do?domainCd=" + boardConf.getDomainCd() + "&bbsCd=" + boardConf.getBbsCd());
            cmsReferenceVO.setAdminMenuUrl("/intra/board/BD_board.list.do?domainCd=" + boardConf.getDomainCd() + "&bbsCd=" + boardConf.getBbsCd());

            reference.add(cmsReferenceVO);
        }

        return reference;
    }

    
    @AuthIntra(authType = AuthType.READ, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "PD_servicePop.do")
    public String PD_servicePop(HttpServletRequest request, ModelMap model, GoodsManageVO vo, BoardVO boardVO) {

        System.out.println("========================================");
        System.out.println("BoardController.PD_servicePop");
        System.out.println("========================================");
        
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
        
        return "/intra/board/templates/basic/PD_servicePop";
    }
    
    
    /**
     * 게시물 목록 조회
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.READ, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "BD_board.list.do", method = RequestMethod.GET)
    public String boardList(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        
        setBoardService(request, "L"); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);
        
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());

        System.out.println("boardConfVO: " + BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());
        
        //세션에서 로그인 정보 가져오기 및 권한정보 가져오기 #1 ★★★★★★ 주석 풀어야함
//        LoginVO loginVo = getLoginSession(request);
//        if(loginVo != null) {
//            HashMap authMap = getLoginAuth(loginVo);
//            model.addAttribute("auth", authMap);
//
//            String mgrNm = new BoardConstant().getAuthName(authMap.get("q_domCd").toString());
//            String divNm = new BoardConstant().getDivName(authMap);
//            String siteDivCd = new BoardConstant().getSiteDivCd(mgrNm, divNm);
//            String aythName = "kmt_" + mgrNm + "_" + divNm + "_mng";
//
//        }

        if(Validate.isEmpty(boardVO.getQ_rowPerPage())) {
            boardVO.setQ_rowPerPage(boardConfVO.getRppNum());
        }

        // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        if(Validate.isNotEmpty(boardVO.getQ_searchKeyType())) {
            if(boardVO.getQ_searchKeyType().contains("___")) {
                String[] search = boardVO.getQ_searchKeyType().split("___");
                boardVO.setQ_searchKey(search[0]);
                boardVO.setQ_searchType(search[1]);
            }
        }
        // 날짜 검색값 포맷
        if(Validate.isNotEmpty(boardVO.getQ_startDt())) {
            String startDt = boardVO.getQ_startDt();
            startDt = StringUtil.remove(startDt, "-");
            boardVO.setQ_startDt(startDt + "000000");
        }
        if(Validate.isNotEmpty(boardVO.getQ_endDt())) {
            String endDt = boardVO.getQ_endDt();
            endDt = StringUtil.remove(endDt, "-");
            boardVO.setQ_endDt(endDt + "232359");
        }

        boardVO.setCutTitleNum(boardConfVO.getCutTitleNum());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
        model.addAttribute("pageType", "LIST");
/*
        System.out.println("boardConfVO.getListSkin(): " + boardConfVO.getListSkin());
        System.out.println("boardVO: " + boardVO);
*/        
        addNoticeBbsList(boardVO, boardConfVO.getListSkin(), request.getSession().getServletContext().getRealPath("/"), model);

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getListSkin(), boardConfVO.getSkinPath());

        return url + "BD_board.list";
    }

    // 공지리스트 및 게시물 리스트를 셋팅.
    private void addNoticeBbsList(BoardVO boardVO, String listSkin, String contextPath, ModelMap model) {
        Pager<BoardVO> pager = null;
        List<BoardVO> noticeList = null;
        
        // 비즈매칭 - 상태(대기중인경우 선정여부 S->N으로 변경
        if(boardVO.getBbsCd() == 1010){
            boardVO.setEstnColumn5("N");
        }
        
        boardVO.setNoticeBbscttAt("N");
        pager = boardService.boardList(boardVO, listSkin);
        boardVO.setNoticeBbscttAt("Y");
        noticeList = boardService.noticeList(boardVO, listSkin);
        
        System.out.println("Validate.isNotEmpty(boardVO.getQ_aditCtgCd()): " +  Validate.isNotEmpty(boardVO.getQ_aditCtgCd()));;
        
        if(Validate.isNotEmpty(boardVO.getQ_aditCtgCd())){
            //2Depth 조회
            BoardConfVO boardConfVO = new BoardConfVO();
            System.out.println("boardVO.getQ_aditCtgCd(): " + boardVO.getQ_aditCtgCd());
            boardConfVO.setCtgCd(Integer.parseInt(boardVO.getQ_aditCtgCd()));
            boardConfVO.setBbsCd(boardVO.getBbsCd());
            boardConfVO.setDomainCd(boardVO.getDomainCd());
            model.addAttribute("aditCtgList", boardService.boardAditCtgList(boardConfVO));
        }
        
        if(listSkin.equals("gallery")) {
            convertFilePaths(pager.getList(), contextPath);
            convertFilePaths(noticeList, contextPath);
        }
        
        if(Validate.isNotEmpty(pager.getList())){ 
            model.addAttribute("bbsCd",pager.getList().get(0).getBbsCd());
        }
        model.addAttribute(GlobalConfig.KEY_PAGER, pager);
        model.addAttribute(GlobalConfig.KEY_NOTICE_LIST, noticeList);
    }

    // BoardVO 리스트에 대해 파일리스트의 패스를 절대 패스로 변환한다.(사진 미리 보기용)
    private void convertFilePaths(List<BoardVO> list, String contextPath) {
        if(list == null) {
            return;
        }
        for(BoardVO tempVO : list) {
            convertFilePath(tempVO.getFileList(), contextPath);
        }
    }

    // 파일 리스트의 패쓰를 절대패스로 변환한다.(사진 미리 보기용)
    private void convertFilePath(List<FileVO> list, String contextPath) {
        if(list == null) {
            return;
        }
        for(FileVO fileVO : list) {
            if(fileVO != null) {
                String filePath = fileVO.getServerNm();
                filePath = StringUtil.replace(filePath, contextPath, "/");
                filePath = StringUtil.replace(filePath, "\\", "/");
                fileVO.setServerNm(filePath);
                String fileUrl = fileVO.getFileUrl();
                fileVO.setFileUrl(StringUtil.replace(fileUrl, "\\", "/"));
            }
        }
    }

    /**
     * 게시물 상세 조회
     */
    @AuthIntra(authType = AuthType.READ, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "BD_board.view.do")
    public String boardView(ModelMap model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute BoardVO boardVO)
        throws Exception {
        setBoardService(request, "V"); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());

        // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        if(Validate.isNotEmpty(boardVO.getQ_searchKeyType())) {
            if(boardVO.getQ_searchKeyType().contains("___")) {
                String[] search = boardVO.getQ_searchKeyType().split("___");
                boardVO.setQ_searchKey(search[0]);
                boardVO.setQ_searchType(search[1]);
            }
        }
        // 날짜 검색값 포맷
        if(Validate.isNotEmpty(boardVO.getQ_startDt())) {
            String startDt = boardVO.getQ_startDt();
            startDt = StringUtil.remove(startDt, "-");
            boardVO.setQ_startDt(startDt + "000000");
        }
        if(Validate.isNotEmpty(boardVO.getQ_endDt())) {
            String endDt = boardVO.getQ_endDt();
            endDt = StringUtil.remove(endDt, "-");
            boardVO.setQ_endDt(endDt + "232359");
        }

        BoardVO dataVO = boardService.boardView(boardVO);
        
        if(dataVO == null) {
            return alertAndBack(model, Messages.COMMON_NO_DATA);
        }

        // 비밀글인 경우 작성자나 슈퍼유저인가? => 회원 게시판에서 체크할 것
        if("N".equals(dataVO.getOthbcAt())) {
            LoginVO loginVo = OpHelper.getMgrSession(request);
            if(Validate.isEmpty(loginVo.getMngrId())) { // 일단은 관리자 세션이 존재하는지 체크함
                return alertAndBack(model, Messages.COMMON_NO_AUTH);
            }
        }

        // 조회수 증가를 위한 쿠키 체크
        if(CookieUtil.isIncreateReadCnt("board" + boardVO.getBbsCd() + "_" + boardVO.getBbscttSeq(), boardConfVO.getRdcntIncrsLmttTime(), request, response)) {
            boardService.incReadCount(boardVO);
            dataVO.setRdcnt(dataVO.getRdcnt() + 1);
        }

        // 에디터사용이 N일 때 \n이 있으면 <br/> 태그로 전환
        if("N".equals(boardConfVO.getMngrEditorYn())) {
            dataVO.setBbscttCn(Converter.translateBR(dataVO.getBbscttCn()));
        }else if("N".equals(boardConfVO.getUserEditorYn())){
            dataVO.setBbscttCn(Converter.translateBR(dataVO.getBbscttCn()));
        }

        if(boardConfVO.getViewSkin().equals("gallery")) {
            convertFilePath(dataVO.getFileList(), request.getSession().getServletContext().getRealPath("/"));
        } else if(boardConfVO.getViewSkin().equals("petition")) {
            if(Validate.isEmpty(dataVO.getMngrNm())) {
                LoginVO loginVo = OpHelper.getMgrSession(request);
                dataVO.setMngrNm(loginVo.getMngrNm());
            }
        }

        
        model.addAttribute("pageType", "VIEW");
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVO);

        if(boardConfVO.getListViewCd() == BoardConfConstant.GUBUN_LISTVIEW_LIST) {
            addNoticeBbsList(boardVO, boardConfVO.getListSkin(), request.getSession().getServletContext().getRealPath("/"), model);
        }

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getViewSkin(), boardConfVO.getSkinPath());
        return url + "BD_board.view";
    }

    /**
     * 게시물 평가하기
     */
    /*@AuthIntra(authType = AuthType.BASIC, authParams = { "bbsCd" })
    @RequestMapping(value = "ND_score.action.do", method = RequestMethod.POST)
    public String scoreAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        Integer result = (Integer) boardService.scoreAction(boardVO);
        if(Validate.isEmpty(result)) {
            responseJson(model, 0, "");
        }

        BoardVO resultVO = boardService.boardView(boardVO);
        return responseJson(model, resultVO.getScoreAvg(), "");
    }*/

    /**
     * 부류코드(2Depth추가)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_aditCtgList.do", method = RequestMethod.GET)
    public String aditCtgList(ModelMap model, HttpServletRequest request, @ModelAttribute BoardConfVO boardConfVO) throws Exception {
        return responseJson(model, boardService.boardAditCtgList(boardConfVO));
    }
    
    /**
     * 추천 하기
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_recom.action.do", method = RequestMethod.POST)
    public String recommAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        Integer result = (Integer) boardService.recommAction(boardVO);
        if(Validate.isEmpty(result)) {
            alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        BoardVO resultVO = boardService.boardView(boardVO);
        return responseJson(model, resultVO.getRecomendCnt());
    }

    /**
     * 신고 하기
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_accuse.action.do", method = RequestMethod.POST)
    public String accuseAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        Integer result = (Integer) boardService.accuseAction(boardVO);
        if(Validate.isEmpty(result)) {
            alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        BoardVO resultVO = boardService.boardView(boardVO);
        return responseJson(model, resultVO.getAccuseCnt());
    }


    /**
     * 게시물 등록 폼 & (domainCd, bbsCd, bbscttSeq=null, refrnSeq=null)
     * 답글 등록 폼 & (domainCd, bbsCd, refrnSeq, bbscttSeq)
     * 게시물 수정 폼 (domainCd, bbsCd, bbscttSeq, refrnSeq=null)
     * 게시물 등록 당사자나 관리자만 가능하다.
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = { "BD_board.insert.form.do", "BD_board.update.form.do", "BD_board.reply.form.do" })
    public String insertForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO, @RequestParam(value = "pageType", required = true) String pageType) throws Exception {

        setBoardService(request, "F"); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
        
        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        BoardVO dataVO = new BoardVO();
        dataVO.setBbsCd(boardVO.getBbsCd());
        dataVO.setDomainCd(boardVO.getDomainCd());
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
/*        
        GoodsManageVO vo = new GoodsManageVO();
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.ctgryList(vo));
*/        
        if("UPDATE".equals(pageType)) {
            // *** 수정폼 ***
            model.addAttribute("pageType", "UPDATE");
            
            dataVO = boardService.boardView(boardVO);
            boardConfVO.setCtgCd(dataVO.getCtgCd());
            
            model.addAttribute("aditCtgList", boardService.boardAditCtgList(boardConfVO));

        } else if("REPLY".equals(pageType)) {
            // *** 답변등록폼 ***
            model.addAttribute("pageType", "REPLY");
            boardVO = boardService.boardView(boardVO);
            dataVO = boardVO.copyCreateVO();
            dataVO.setRegisterNm(loginVo.getMngrNm());

        } else {
            // *** 등록폼 ***
            model.addAttribute("pageType", "INSERT");
            dataVO.setRegisterNm(loginVo.getMngrNm());
        }

        
//        if(loginVo != null) {
//            HashMap authMap = getLoginAuth(loginVo);
//            model.addAttribute("auth", authMap);
//
//            String mgrNm = new BoardConstant().getAuthName(authMap.get("q_domCd").toString());
//            String divNm = new BoardConstant().getDivName(authMap);
//            String siteDivCd = new BoardConstant().getSiteDivCd(mgrNm, divNm);
//            String aythName = "kmt_" + mgrNm + "_" + divNm + "_mng";
//        }

        if(!Validate.isEmpty(loginVo.getMngrId())) {
            dataVO.setRegistId(loginVo.getMngrId());
            
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVO);

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getFormSkin(), boardConfVO.getSkinPath());
        return url + "BD_board.form";
    }

    /**
     * 게시물 등록 액션
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_board.insert.do", method = RequestMethod.POST)
    public String boardInsert(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());

        // GUBUN_UPLOADER_FLASH 일때는 파일 업로드를 하지 않는다.
        List<FileVO> fileList = new ArrayList<FileVO>();
        if(boardConfVO.getUploadTy() == BoardConfConstant.GUBUN_UPLOADER_FORM) {
            fileList = UploadHelper.upload(request, "board");

            // 폼 업로드시 업로드 파일 용량을 체크한다.
            if(!checkUploadFileSize(fileList, boardConfVO)) {
                if(boardService.fileDelete(fileList)) {
                    return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                } else {
                    return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                }
            }
        }

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        if(holder.isValid()) {
            LoginVO loginVo = OpHelper.getMgrSession(request);
            if(!Validate.isEmpty(loginVo.getMngrId())) {
                boardVO.setRegistId(loginVo.getMngrId());
//                boardVO.setRegisterNm(loginVo.getMngrNm());
                boardVO.setMngrId(loginVo.getMngrId());
                boardVO.setMngrNm(loginVo.getMngrNm());
                boardVO.setDeptCode(loginVo.getDeptCode());
                boardVO.setDeptNm(loginVo.getDeptNm());
            }
            boardVO.setIpAdres(request.getRemoteAddr());
            boardVO.setFileList(fileList);

            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if(boardConfVO.getMngrEditorYn().equals("N")) {
                boardVO.setBbscttCn(Converter.XSS(boardVO.getBbscttCn()));
            }

            String goodsNmVal = ""; 
            if (!Validate.isEmpty(boardVO.getGoodsNm())) {
                goodsNmVal = boardVO.getGoodsNm();
                goodsNmVal = goodsNmVal.replace(",", "^");
                goodsNmVal = goodsNmVal.replace("~", ",");
            }
            
            System.out.println("goodsNmVal: " + goodsNmVal);
            
            boardVO.setGoodsNm(goodsNmVal);
            
            // 등록 실행
            Object key = boardService.boardInsert(boardVO);
            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 게시물 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_board.update.do", method = RequestMethod.POST)
    public String boardUpdate(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());


        // 자동 작성 방지 체크
        if("Y".equals(boardConfVO.getCaptchaYn())) {
            Captcha captcha = (Captcha) RequestUtil.getSessionAttribue(request, Captcha.NAME);
            String answer = request.getParameter("answer");
            if(!captcha.isCorrect(answer)) {
                String message = "자동 작성 방지 문자를 다시 입력해주세요.";
                return alertAndBack(model, message);
            }
        }

        // *** 수정데이터 ***
        model.addAttribute("pageType", "UPDATE");
        BoardVO dataVO = boardService.boardView(boardVO);
        if(dataVO == null) {
            return alertAndBack(model, Messages.COMMON_NO_DATA);
        }

        // GUBUN_UPLOADER_FLASH 일때는 파일 업로드를 하지 않는다.
        List<FileVO> fileList = new ArrayList<FileVO>();
        if(boardConfVO.getUploadTy() == BoardConfConstant.GUBUN_UPLOADER_FORM) {
            fileList = UploadHelper.upload(request, "board");

            // 폼 업로드시 업로드 파일 용량을 체크한다.
            if(!checkUploadFileSize(fileList, boardConfVO)) {
                if(boardService.fileDelete(fileList)) {
                    return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                } else {
                    return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                }
            }
        }

        System.out.println("boardVO.getBbsCd(): " + boardVO.getBbsCd());
        if (("1031").equals(boardVO.getBbsCd())) {
            String goodsNmVal = ""; 
            if (!Validate.isEmpty(boardVO.getGoodsNm())) {
                goodsNmVal = boardVO.getGoodsNm();
                goodsNmVal = goodsNmVal.replace(",", "^");
                goodsNmVal = goodsNmVal.replace("~", ",");
            }
            
            System.out.println("goodsNmVal: " + goodsNmVal);
            
            boardVO.setGoodsNm(goodsNmVal);
        }
        
        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        if(holder.isValid()) {
            LoginVO loginVo = OpHelper.getMgrSession(request);
            if(!Validate.isEmpty(loginVo.getMngrId())) {
                boardVO.setUpdtId(loginVo.getMngrId());
                boardVO.setUpdtNm(loginVo.getMngrNm());
                boardVO.setMngrId(loginVo.getMngrId());
                boardVO.setMngrNm(loginVo.getMngrNm());
                boardVO.setDeptCode(loginVo.getDeptCode());
                boardVO.setDeptNm(loginVo.getDeptNm());
            }
            boardVO.setIpAdres(request.getRemoteAddr());
            boardVO.setFileList(fileList);
            
            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if(boardConfVO.getMngrEditorYn().equals("N")) {
                boardVO.setBbscttCn(Converter.XSS(boardVO.getBbscttCn()));
            }

            if(boardVO.getBbsCd() == 1002){
                boardVO.setEstnColumn1(Integer.toString(boardVO.getAditCtgCd()));
                boardVO.setEstnColumn2(boardVO.getAditCtgNm());
            }

            // 수정 실행
            int result = boardService.boardUpdate(boardVO);
            if(StringUtil.ONE != result) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&bbscttSeq=" + boardVO.getBbscttSeq() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 게시물 답변글 등록 액션
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_board.reply.do", method = RequestMethod.POST)
    public String boardReply(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());

        // 자동 작성 방지 체크
        if("Y".equals(boardConfVO.getCaptchaYn())) {
            Captcha captcha = (Captcha) RequestUtil.getSessionAttribue(request, Captcha.NAME);
            String answer = request.getParameter("answer");
            if(!captcha.isCorrect(answer)) {
                String message = "자동 작성 방지 문자를 다시 입력해주세요.";
                return alertAndBack(model, message);
            }
        }

        // GUBUN_UPLOADER_FLASH 일때는 파일 업로드를 하지 않는다.
        List<FileVO> fileList = new ArrayList<FileVO>();
        if(boardConfVO.getUploadTy() == BoardConfConstant.GUBUN_UPLOADER_FORM) {
            fileList = UploadHelper.upload(request, "board");

            // 폼 업로드시 업로드 파일 용량을 체크한다.
            if(!checkUploadFileSize(fileList, boardConfVO)) {
                if(boardService.fileDelete(fileList)) {
                    return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                } else {
                    return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                }
            }
        }

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        if(holder.isValid()) {
            LoginVO loginVo = OpHelper.getMgrSession(request);
            if(!Validate.isEmpty(loginVo.getMngrId())) {
                boardVO.setRegistId(loginVo.getMngrId());
                boardVO.setRegisterNm(loginVo.getMngrNm());
                boardVO.setMngrId(loginVo.getMngrId());
                boardVO.setMngrNm(loginVo.getMngrNm());
                boardVO.setDeptCode(loginVo.getDeptCode());
                boardVO.setDeptNm(loginVo.getDeptNm());
            }
            boardVO.setIpAdres(request.getRemoteAddr());
            boardVO.setFileList(fileList);
            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if(boardConfVO.getMngrEditorYn().equals("N")) {
                boardVO.setBbscttCn(Converter.XSS(boardVO.getBbscttCn()));
            }

            // 등록 실행
            Object key = boardService.boardInsert(boardVO);
            
            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 민원형 게시물 답글 등록
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_board.answer.do", method = RequestMethod.POST)
    public String boardAnswer(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(!Validate.isEmpty(loginVo.getMngrId())) {
            boardVO.setReplyId(loginVo.getMngrId());
            boardVO.setMngrId(loginVo.getMngrId());
            boardVO.setDeptCode(loginVo.getDeptCode());
            boardVO.setDeptNm(loginVo.getDeptNm());
        }
        
        boardService.boardAnswer(boardVO);
        
        if("Y".equals(boardVO.getEstnColumn3())){//답변 처리완료라고 선택하였을때가 답변완료이므로 문자,이메일발송
            //답변등록후 문의자에게 메일발송
            BoardVO boardEmailVO = boardService.boardView(boardVO);
            
            // 받는사람(user) = 게시물 등록자 정보불러오기
            RegisterUserVO vo = boardService.userBoardSelect(boardEmailVO);
            
            if(boardEmailVO.getOthbcAt() != "Y"){
                boardEmailVO.setOthbcAt("공개");
            }else{
                boardEmailVO.setOthbcAt("비공개");
            }
            
            boardEmailVO.setMailSection(52); // 이메일 사용 구분값
            emailCrtfcAction(request, model, boardEmailVO, vo); //이메일 전송
        }
        
        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&bbscttSeq=" + boardVO.getBbscttSeq() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    // 금칙어 존재 여부 - 존재시 true
    private boolean banCheck(Integer domainCd, Integer bbsCd, String contents) {
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + domainCd + "_" + bbsCd);
        boolean result = false;
        if(boardConfVO.getBannedWordYn().equals("Y")) {
            String banContents = boardConfVO.getBannedWordCn();
            if(Validate.isNotEmpty(banContents)) {
                List<String> banList = Arrays.asList(banContents.split(","));
                for(String banStr : banList) {
                    if(contents.indexOf(banStr) > -1) {
                        result = true;
                        break;
                    }
                }
            }
        }
        return result;
    }

    // 폼 업로드시 업로드 파일 용량을 체크한다.
    private boolean checkUploadFileSize(List<FileVO> fileList, BoardConfVO boardConfVO) {
        Long totalFileSize = 0L;
        boolean uploadYn = true;
        // 업로드 파일 사이즈 제한이 있는 경우(사이즈 0일 경우 무제한 용량)
        for(FileVO baseFileVO : fileList) {
            try {
                Long fileSize = baseFileVO.getFileByteSize();

                if(boardConfVO.getMaxFileSize() > 0) {
                    Long maxFileSize = Long.valueOf(((Integer) (boardConfVO.getMaxFileSize() * 1024 * 1024)).toString());
                    if(fileSize > maxFileSize) {
                        uploadYn = false;
                    }
                }
                totalFileSize += fileSize;
            } catch (Exception e) {
                uploadYn = false;
            }
        }
        // 업로드 총 파일 사이즈 제한이 있는 경우
        if(boardConfVO.getTotalFileSize() > 0) {
            Long totalMaxFileSize = Long.valueOf(((Integer) (boardConfVO.getTotalFileSize() * 1024 * 1024)).toString());
            if(totalFileSize > totalMaxFileSize) {
                return false;
            }
        }
        return uploadYn;
    }

    /**
     * 불건전 단어를 포함하고 있는지 여부 확인(폼 화면에서 Ajsx 방식으로 체크)
     */
    @RequestMapping(value = "ND_check.ban.do", method = RequestMethod.POST)
    public String checkBanAction(ModelMap model, HttpServletRequest request, BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());
        boolean result = banCheck(boardVO.getDomainCd(), boardVO.getBbsCd(), boardVO.getBbscttSj() + boardVO.getBbscttCn());

        if(result) {
            String message = "금칙어가 존재합니다.\n\n" + boardConfVO.getBannedWordCn();
            return responseJson(model, true, message);
        } else {
            return responseJson(model, false);
        }
    }

    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_file.delete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request) {
        setBoardService(request); // 게시판 유형 서비스 설정
        int affected = boardService.fileDelete(fileVO);
        if(affected < 1) {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, affected);
    }

    /**
     * 게시판 목록 PDF, EXCEL 다운로드 설정폼
     */
    @RequestMapping(value = "PD_convert.form.do", method = RequestMethod.GET)
    public String convertForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO, @RequestParam(required = true) String type)
        throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" +boardVO.getBbsCd());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);

        model.addAttribute("type", type);

        String url = getTemplateFolderName(request.getRequestURL().toString(), null, null);
        return url + "PD_convert.form";
    }

    /**
     * 게시글 목록 변환 (RSS, ATOM, EXCEL, PDF)
     */
    @RequestMapping(value = "ND_convertAction.do", method = RequestMethod.GET)
    public String convertAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardConvertOptionVO boardConvertOptionVO,
        @RequestParam(required = true) String type) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        if(boardConvertOptionVO == null) {
            alertAndClose(model, Messages.COMMON_INVALID_PARAM);
        }

        OpHelper.bindSearchMap(boardConvertOptionVO, request);

        // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        if(Validate.isNotEmpty(boardConvertOptionVO.getQ_searchKey())) {
            if(boardConvertOptionVO.getQ_searchKeyType().contains("___")) {
                String[] search = boardConvertOptionVO.getQ_searchKeyType().split("___");
                boardConvertOptionVO.setQ_searchKey(search[0]);
                boardConvertOptionVO.setQ_searchType(search[1]);
            }
        }
        // 날짜 검색값 포맷
        if(Validate.isNotEmpty(boardConvertOptionVO.getQ_startDt())) {
            String startDt = boardConvertOptionVO.getQ_startDt();
            startDt = StringUtil.remove(startDt, "-");
            boardConvertOptionVO.setQ_startDt(startDt + "000000");
        }
        if(Validate.isNotEmpty(boardConvertOptionVO.getQ_endDt())) {
            String endDt = boardConvertOptionVO.getQ_endDt();
            endDt = StringUtil.remove(endDt, "-");
            boardConvertOptionVO.setQ_endDt(endDt + "232359");
        }

        String SERVER_ADDR = "http://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardConvertOptionVO.getDomainCd() + "_" + boardConvertOptionVO.getBbsCd());

        if("rss".equals(type) || "atom".equals(type)) {
            boardConvertOptionVO.setMaxResult(100);
        }

        Pager<BoardVO> pager = boardService.boardAllList(boardConvertOptionVO);
        List<BoardVO> list = pager.getList();

        String baseUrl = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getListSkin(), boardConfVO.getSkinPath());

        if("rss".equals(type) || "atom".equals(type)) {
            FeedVO metaFeedVO = new FeedVO();
            metaFeedVO.setTitle(boardConfVO.getBbsNm());
            metaFeedVO.setLink(SERVER_ADDR + baseUrl);
            metaFeedVO.setDescription(boardConfVO.getBbsDc());
            List<FeedVO> itemList = new ArrayList<FeedVO>();
            for(BoardVO bean : list) {
                FeedVO _feedVO = new FeedVO();
                _feedVO.setTitle(bean.getBbscttSj());
                _feedVO.setDescription(bean.getCnSumry());
                _feedVO.setLink(SERVER_ADDR + baseUrl + "../../BD_board.view.do?domainCd=" + boardConvertOptionVO.getDomainCd() + "&bbsCd="
                    + boardConvertOptionVO.getBbsCd() + "&bbscttSeq=" + bean.getBbscttSeq());
                
                int viewCd = boardConfVO.getRegisterIndictCd().intValue();
                switch(viewCd) {
                    case BoardConfConstant.GUBUN_SHOW_NM:
                        _feedVO.setAuthor(bean.getMngrNm() + bean.getUserNm() + bean.getRegisterNm());
                        break;
                    case BoardConfConstant.GUBUN_SHOW_ID:
                        _feedVO.setAuthor(bean.getMngrId() + bean.getRegistId() + bean.getRegisterNm());
                        break;
                    case BoardConfConstant.GUBUN_SHOW_DEPT_NM:
                        _feedVO.setAuthor(bean.getDeptNm());
                        break;
                    default:
                        _feedVO.setAuthor(bean.getRegisterNm());
                        break;
                }
                _feedVO.setPubDate(bean.getRegistDt());

                itemList.add(_feedVO);
            }
            metaFeedVO.setItemList(itemList);

            if("rss".equals(type)) {
                return responseRSS(model, metaFeedVO);
            } else {
                return responseAtom(model, metaFeedVO);
            }
        } else if("excel".equals(type)) {
            BoardExcelVO boardExcelVO = new BoardExcelVO();
            boardExcelVO.setItemList(list);
            boardExcelVO.setBbsConvertOptionVO(boardConvertOptionVO);
            boardExcelVO.setBbsConfVO(boardConfVO);

            return responseExcel(model, boardExcelVO);
        } else { // pdf
            BoardPdfVO boardPdfVO = new BoardPdfVO();
            boardPdfVO.setItemList(list);
            boardPdfVO.setBbsConvertOptionVO(boardConvertOptionVO);
            boardPdfVO.setBbsConfVO(boardConfVO);

            return responsePDF(model, boardPdfVO);
        }
    }


    /**
     * 목록에서 선택 게시글 이동 액션
     */
    @RequestMapping(value = "ND_list.transfer.do", method = RequestMethod.POST)
    public String listTransfer(ModelMap model, HttpServletRequest request, Integer domainCd, String bbsCd, String isMove,
        @RequestParam(value = "toBbsCds", required = false) Integer[] toBbsCds,
        @RequestParam(value = "bbscttSeqs[]", required = true) String[] bbscttSeqs, @RequestParam(value = "newCtgs", required = true) Integer[] newCtgs)
        throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        if(Validate.isEmpty(bbscttSeqs)) {
            return alertAndBack(model, Messages.COMMON_INVALID_PARAM);
        }

        return responseJson(model, boardService.listTransfer(domainCd, bbsCd, toBbsCds, bbscttSeqs, isMove, newCtgs), Messages.COMMON_PROCESS_OK);
    }

    /**
     * 상세 보기에서 게시물 이동 액션
     */
    @RequestMapping(value = "ND_article.transfer.do", method = RequestMethod.POST)
    public String articleTransfer(ModelMap model, HttpServletRequest request, String isMove,
        @RequestParam(value = "toBbsCd", required = true) Integer toBbsCd,
        @RequestParam(value = "domainCd", required = true) Integer domainCd,
        @ModelAttribute BoardVO boardVO, @RequestParam(required = false) Integer newCtg) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        if(boardVO == null) {
            return alertAndBack(model, Messages.COMMON_INVALID_PARAM);
        }

        if(Validate.isEmpty(newCtg)) {
            newCtg = -1;
        }

        Integer result = boardService.articleTransfer(boardVO.getDomainCd(), String.valueOf(boardVO.getBbsCd()), toBbsCd, boardVO.getBbscttSeq(), isMove,
            newCtg);
        if(result != null && result.intValue() == 1) {
            return responseJson(model, StringUtil.ONE, Messages.COMMON_PROCESS_OK);
        } else {
            return responseJson(model, StringUtil.ZERO, Messages.COMMON_PROCESS_FAIL);
        }
    }

    /**
     * 카테고리 목록을 가져온다(게시물 이동폼)
     */
    @RequestMapping(value = "INC_board.ctg.list.do", method = RequestMethod.POST)
    public String ctgList(ModelMap model, HttpServletRequest request, @RequestParam(value = "bbsCd", required = true) Integer bbsCd, 
        @RequestParam(value = "domainCd", required = true) Integer domainCd) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + domainCd + "_" + bbsCd);
        if(boardConfVO == null) {
            return responseJson(model, true, new ArrayList<BoardCtgVO>(), "");
        } else {
            return responseJson(model, true, boardConfVO.getCtgList(), "");
        }
    }

    /**
     * 게시물 완전 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_board.delete.do", method = RequestMethod.POST)
    public String boardDelete(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);

        Integer cnt = boardService.boardDelete(boardVO, true);
        if(cnt != StringUtil.ONE) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 게시물 목록 선택 완전 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_board.list.delete.do", method = RequestMethod.POST)
    public String boardListDelete(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);
/*        
        System.out.println("bbscttSeq: " + request.getParameterValues("bbscttSeq"));
        System.out.println("getBbscttSeq: " + boardVO.getBbscttSeq());
        
        System.out.println("getBbscttSeqs: " + boardVO.getBbscttSeqs());
        System.out.println("getDomainCd: " + boardVO.getDomainCd());
        System.out.println("getBbsCd: " + boardVO.getBbsCd());
*/
        
        String bbscttSeqs = request.getParameter("bbscttSeq");
        String [] bbscttSeqsArry = bbscttSeqs.split(",");
        
        boardVO.setBbscttSeqs(bbscttSeqsArry);
        
        Integer cnt = boardService.boardListDelete(boardVO, true);
        if(cnt <= StringUtil.ZERO) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 게시물 플래그 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "bbsCd" })
    @RequestMapping(value = "ND_board.flag.delete.do", method = RequestMethod.POST)
    public String boardFlagDelete(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);

        Integer cnt = boardService.boardFlagDelete(boardVO);
        if(cnt != StringUtil.ONE) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 게시물 목록 선택 플래그 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "bbsCd" })
    @RequestMapping(value = "ND_board.list.flag.delete.do", method = RequestMethod.POST)
    public String boardListFlagDelete(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);

        Integer cnt = boardService.boardListFlagDelete(boardVO);
        if(cnt <= StringUtil.ZERO) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 댓글 목록 조회
     */
    @AuthIntra(authType = AuthType.READ, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "INC_cmt.list.do", method = RequestMethod.GET)
    public String commentList(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO) throws Exception {
        
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardCmtVO, request);
        
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardCmtVO.getDomainCd() + "_" + boardCmtVO.getBbsCd());
        Pager<BoardCmtVO> pager = boardService.commentList(boardCmtVO);

        model.addAttribute(BoardConfConstant.KEY_PAGER_VO, pager);
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
        
        String url = getTemplateFolderName(request.getRequestURL().toString(), null, null);
        return url + "INC_cmt.list";
    }

    /**
     * 댓글 등록 & 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "bbsCd" })
    @RequestMapping(value = "ND_cmt.insert.do", method = RequestMethod.POST)
    public String commentInsert(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO, String type) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        // 금칙어 존재여부 체크
        if(banCheck(boardCmtVO.getDomainCd(), boardCmtVO.getBbsCd(), boardCmtVO.getNttCmtCn())) {
            String message = "금칙어가 존재합니다.";
            return responseText(model, message);
        }

        LoginVO loginVo = OpHelper.getMgrSession(request);
        Integer result = null;

        if("UPDATE".equals(type)) {
            if(!Validate.isEmpty(loginVo.getMngrId())) {
                boardCmtVO.setUpdtId(loginVo.getMngrId());
                boardCmtVO.setRegisterNm(loginVo.getMngrNm());
                boardCmtVO.setMngrId(loginVo.getMngrId());
            }

            result = (Integer) boardService.updateComment(boardCmtVO);
            if(result == null) {
                return responseJson(model, false, Messages.COMMON_PROCESS_FAIL);
            } else {
                return responseJson(model, true, Messages.COMMON_UPDATE_OK);
            }
        } else if("INSERT".equals(type)) {
            
            boardCmtVO.setIpAdres(request.getRemoteAddr());
            if(!Validate.isEmpty(loginVo.getMngrId())) {
                boardCmtVO.setRegistId(loginVo.getMngrId());
                boardCmtVO.setRegisterNm(loginVo.getMngrNm());
                boardCmtVO.setMngrId(loginVo.getMngrId());
            }
            result = (Integer) boardService.insertComment(boardCmtVO);
            
            return responseJson(model, true, Messages.COMMON_INSERT_OK);
        } else {
            return responseJson(model, false, Messages.COMMON_INVALID_PARAM);
        }
    }

    /**
     * 댓글 삭제 액션(완전삭제)
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = "ND_comment.delete.do", method = RequestMethod.POST)
    public String commentDelete(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardCmtVO, request);
        
        BoardCmtVO dataVO = boardService.viewComment(boardCmtVO);
        if(dataVO == null) {
            return responseText(model, Messages.COMMON_NO_DATA);
        }

        String result = "";
        result = boardService.deleteComment(boardCmtVO);
        
        if("TRUE".equals(result)) {
            return responseText(model, result);
        } else {
            return responseText(model, Messages.COMMON_PROCESS_FAIL);
       
        }
    }

    /**
     * 댓글 플래그 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "bbsCd" })
    @RequestMapping(value = "ND_comment.flag.delete.do", method = RequestMethod.POST)
    public String cmtFlagDelete(HttpServletRequest request, ModelMap model, BoardCmtVO boardCmtVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        
        Integer result = boardService.cmtFlagDelete(boardCmtVO);
        if(result == null || result == 0) {
            return responseText(model, Messages.COMMON_PROCESS_FAIL);
        } else {
            return responseText(model, result);
        }
    }

    /**
     * 댓글 수정 요청 폼
     * return true/false
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "bbsCd" })
    @RequestMapping(value = "ND_comment.update.form.do", method = RequestMethod.POST)
    public String commentView(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        if(boardCmtVO == null) {
            return responseJson(model, false, Messages.COMMON_INVALID_PARAM);
        }

        BoardCmtVO dataVO = boardService.viewComment(boardCmtVO);

        return responseJson(model, true, dataVO, Messages.COMMON_PROCESS_OK);
    }
    
    /**
     * 게시판 공개비공개 여부 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_othbcAtUpdateAction.do", method = RequestMethod.POST)
    public String othbcAtUpdateAction(ModelMap model, @ModelAttribute BoardVO boardVo) throws Exception {
        if(boardVo == null) {
            throw new Exception("INVALID_ARGUMENTS");
        }
        
        int affected = boardService.othbcAtUpdateAction(boardVo);
        
        if(affected != StringUtil.ONE) {
            throw new Exception("DB_UPDATE_FAIL");
        }
        
        return responseJson(model, boardService.othbcAtUpdateAction(boardVo));
    }
    
    /**
     * 게시판 비즈매칭 선정여부 
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_selectionUpdate.do", method = RequestMethod.POST)
    public String selectionUpdate(ModelMap model, @ModelAttribute BoardVO boardVo) throws Exception {
        String msg ="";
        int affected = boardService.selectionUpdate(boardVo);
        
        if(affected < 1) {
            msg = Messages.COMMON_PROCESS_FAIL;
        }else{
            msg = Messages.COMMON_PROCESS_OK;
        }
        return responseJson(model,msg);
    }
    
    
    
    /**
     * 이메일 발송 액션
     * emailCrtfcAction 설명
     * 
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_emailCrtfcAction.do")
    public boolean emailCrtfcAction(HttpServletRequest request, ModelMap model, BoardVO boardVO, RegisterUserVO vo) {
        //이력쌓기
        registerService.mailCrtfcInsert(vo);
        
        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL
//        String cnlurl = ""; // 가입취소 시 돌아올 URL
        boolean result = false;
            Map<String, Object> autoMap = new HashMap<String, Object>();
            /*
             * 필수 입력 항목
             * ---------------------------------------------------------
             * 메일템플릿 번호
             * ---------------------------------------------------------
             * //AutoMailTemplate.java참고
             * ---------------------------------------------------------
             */
            
            /** mailSection 메일구분값 
             * 52 : Q&A답변등록
             * */
            /** 매일발송 시작 **/
            
            if(boardVO.getDomainCd() == 2){ // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_QNA_AREG);
                hostNm="korean";
            }

            // 전송할 메일 정보 입력 
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소
            
            /*
             * 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            
            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("name", vo.getUserNm());
            
            if(boardVO.getMailSection() == 52){
                // 이전소스
                //rtnurl = "http://" + hostNm + ".ceart.kr/web/board/BD_board.list.do?bbsCd=" + boardVO.getBbsCd() +"&domainCd="+boardVO.getDomainCd();
                
                //{{ BH, 2015.12.03, 도메인관리삭제로 인한 소스변경 
                // 변경소스
                rtnurl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/web/board/BD_board.list.do?bbsCd=" + boardVO.getBbsCd() +"&domainCd="+boardVO.getDomainCd();
                //}}
                oneToOneInfoMap.put("rtnurl",rtnurl);                              // 비즈매칭 제목
                oneToOneInfoMap.put("ctgNm",boardVO.getCtgNm());                   // 구분(부류코드)명
                oneToOneInfoMap.put("title",boardVO.getBbscttSj());                // 문의글 제목
                oneToOneInfoMap.put("othbcAt",boardVO.getOthbcAt());               // 문의글 공개여부
                oneToOneInfoMap.put("contents",boardVO.getBbscttCn());             // 문의글 내용
                oneToOneInfoMap.put("replyContents",boardVO.getReplyCn());         // 문의글 답변내용
                
                for(int i = 0 ; i < boardVO.getFileList().size() ; i++) {
                    oneToOneInfoMap.put("fileNm", boardVO.getFileList().get(i).getLocalNm());    // 첨부파일 이름
                    oneToOneInfoMap.put("fileSize", boardVO.getFileList().get(i).getFileSize()); // 첨부파일 사이즈
                    oneToOneInfoMap.put("fileUrl", boardVO.getFileList().get(i).getFileUrl());   // 첨부파일 URL
                }
                
            }

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);
            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
            
            /** 매일발송 끝 **/
            /** SMS발송시작 **/
            if(vo.getMbtlnum() != null){
                Map<String, Object> smsMap = new HashMap<String, Object>();

                //SMS발송 및 전송이력쌓기
                SmsTransHistConstant shc = new SmsTransHistConstant();   
                //수신번호-필수
                smsMap.put("rcvNo", vo.getMbtlnum());
                //발신내용-필수
                if(boardVO.getDomainCd() == 2){ // 한국어사이트
                    smsMap.put("msg", shc.getSmsMsg("252"));
                }else if(boardVO.getDomainCd() == 3){ // 영어사이트
                    smsMap.put("msg", shc.getSmsMsg("352"));
                }else if(boardVO.getDomainCd() == 4){ // 스페인어사이트
                    smsMap.put("msg", shc.getSmsMsg("452"));
                }
                
                //업무코드
                smsMap.put("dutyCd", "BM");
                boolean smsRst = smsService.smsTransHist(smsMap);
                if(smsRst){
                   /* System.out.println("########################################################");
                    System.out.println("####가입완료 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 성공#########");
                    System.out.println("########################################################");*/
                }else{
                    /*System.out.println("########################################################");
                    System.out.println("####가입완료 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 실패#########");
                    System.out.println("########################################################");*/
                }
            }
            /** SMS발송끝 **/
            
            return result;
    }
    

}
