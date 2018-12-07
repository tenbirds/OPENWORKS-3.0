/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
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
import zes.core.spi.commons.configuration.Config;
import zes.core.spi.oscache.Cache;
import zes.core.utils.Converter;
import zes.core.utils.CookieUtil;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.RequestUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.cache.BoardConfCache;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.loginCheck.LoginCheckReturn;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.board.BoardCmtVO;
import zes.openworks.intra.board.BoardConvertOptionVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.boardconf.BoardConfConstant;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.boardconf.BoardCtgVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.mgr.MgrVO;
import zes.openworks.intra.orderManage.consult.ConsultOrderVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.alarm.AlarmService;
import zes.openworks.web.alarm.AlarmVO;
import zes.openworks.web.boardCount.BoardCountService;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.pop.PopVO;
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
 *  2012. 6. 14.      손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller("boardWebController")
@RequestMapping(value = { "/web/board" ,  "/english/board"  ,  "/spanish/board" })
public class BoardController extends WebController {

    private BoardService boardService;

    @Autowired
    private PopService popService;

    @Autowired
    private BoardCountService boardCountService;

    @Autowired
    private CommonDutyService commonDutyService;

    @Autowired
    private GoodsManageService service;

    @Autowired
    private AutoMailService amservice;
    
    @Autowired
    private SmsTransHistService smsService;

    @Autowired AlarmService alarmService;
    
    public void setBoardService(HttpServletRequest request) {
        this.boardService = getBoardServiceName(request);
    }

    /**
     * 게시판 유형별 서비스 설정
     */
    private BoardService getBoardServiceName(HttpServletRequest request) {
        String serviceName = "";
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + request.getParameter("domainCd") + "_" + request.getParameter("bbsCd"));
        String url = request.getRequestURL().toString();

        String templateId = "basic";
        if(url.contains("BD_board.list"))
            templateId = boardConfVO.getListSkin();
        else if(url.contains("BD_board.view") || url.contains("INC_cmt.list"))
            templateId = boardConfVO.getViewSkin();
        else if(url.contains("BD_board.form"))
            templateId = boardConfVO.getFormSkin();
        
        if(templateId.equals("basic")) {
            serviceName = "basicBoardWebService";
        } else if(templateId.equals("petition")) {
            serviceName = "petitionBoardWebService";
        } else if(templateId.equals("reply")) {
            serviceName = "replyBoardWebService";
        } else if(templateId.equals("gallery")) {
            serviceName = "galleryBoardWebService";
        } else if(templateId.equals("ebook")) {
            serviceName = "ebookBoardWebService";
        } else if(templateId.equals("faq")) {
            serviceName = "faqBoardWebService";
        } else {
            serviceName = "basicBoardWebService";
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
     */
    /*
    private String getTemplateFolderName(String url, Integer kindCd, String skinPath) {
        if(Validate.isNotEmpty(skinPath)) {
            return ("web/board/templates/" + skinPath + "/");
        } else if(Validate.isNotEmpty(kindCd)) {
            return ("web/board/templates/" + getTemplateFolderName(kindCd) + "/");
        } else {
            return ("web/board/");
        }
    }
    */

    /**
     * 각 템플릿별 베이스 URL("basePath/URI.do")
     */
    private String getTemplateFolderName(String url, String skin, String skinPath, HttpServletRequest request) {

        //포털인지 모바일인지 URL을 통해서 값을 가져온다.
//        String rtnUrl = request.getRequestURI().toString();

        //        // URL에 호출된 값중에 mobile 이 포함되어 있으면 주소에 값을 담아 보내준다.
//        if(rtnUrl.indexOf("mobile") > -1) {      //모바일
//            if(Validate.isNotEmpty(skinPath)) {
//                return ("mobile/board/skin/" + skinPath + "/");
//            } else if(Validate.isNotEmpty(skin)) {
//                return ("mobile/board/templates/" + skin + "/");
//            } else {
//                return ("mobile/board/templates/" + getTemplateFolderName(1007) + "/");
//            }
//        } else {
//
//        }

        String lang= "web";

        if(Validate.isNotEmpty(skinPath)) {     //포털
            return (lang +"/board/skin/" + skinPath + "/");
        } else if(Validate.isNotEmpty(skin)) {
            return (lang+"/board/templates/" + skin + "/");
        } else {
            return (lang+"/board/templates/" + getTemplateFolderName(1007) + "/");
        }
    }

    /**
     * 게시물 목록 조회
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = {"BD_board.list.do","BD_board.list1.do"}, method = RequestMethod.GET)
    public String boardList(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        setBoardService(request); // 게시판 유형 서비스 설정

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        

        if(Validate.isEmpty(boardVO.getQ_rowPerPage())) {
            OpHelper.bindSearchMap(boardVO, request, boardConfVO.getRppNum());
        } else {
            OpHelper.bindSearchMap(boardVO, request);
        }

      System.out.println("q_searchType: " + boardVO.getQ_searchKeyType());
        // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        //(1006_제목+내용, 1002_제목,내용, 댓글내용, 1007_댓글작성자 , 1008_작성자
        if(Validate.isNotEmpty(boardVO.getQ_searchKeyType())) {
            if(boardVO.getQ_searchKeyType().equals("NTT_CMT_CN")) {
                boardVO.setQ_searchType("1010");
            }else if(boardVO.getQ_searchKeyType().equals("CMT_REG_ID_REGISTER_NM")) {
                boardVO.setQ_searchType("1007");
            }else if(boardVO.getQ_searchKeyType().equals("CONTENTS_TITLE")) {
                boardVO.setQ_searchType("1006");
            }else if(boardVO.getQ_searchKeyType().equals("REGIST_ID_REGISTER_NM")) {
                boardVO.setQ_searchType("1008");
            }else if(boardVO.getQ_searchKeyType().equals("BBSCTT_SJ_BBSCTT_CN")) {
                boardVO.setQ_searchType("1006");
            }else if(boardVO.getQ_searchKeyType().equals("BBSCTT_SJ")) {
                boardVO.setQ_searchType("1011");
            }else if(boardVO.getQ_searchKeyType().equals("BBSCTT_CN")) {
                boardVO.setQ_searchType("1012");
            }else if(boardVO.getQ_searchKeyType().equals("GOODS_NM")) {
                boardVO.setQ_searchType("1013");
            }
            
            
            
            if(boardVO.getQ_searchKeyType().contains("___")) {
                String[] search = boardVO.getQ_searchKeyType().split("___");
                boardVO.setQ_searchKey(search[0]);
                boardVO.setQ_searchType(search[1]);
            }
        }

        if(boardConfVO.getBbsCd() == 1019){ // 공급자씨앗 -> 씨앗공지 권한체크          
            // 판매하기 권한 체크 20170111
            if(Validate.isEmpty(userLoginVo)) {
                return confirmAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do");
            }    
            // 판매하기 권한 체크 20170111
            if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
                return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
              //  return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");          
            }   
        }
        
        //날짜 설정 없으면 디폴트 현재 날짜(마이페이지 메뉴들)
        if(request.getParameter("section") != "" && request.getParameter("section") != null ){
            if(request.getParameter("q_init") == "" || request.getParameter("q_init") == "1" || request.getParameter("q_init") == null){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar c1 = Calendar.getInstance();
                Calendar c2 = Calendar.getInstance();
                c1.add(Calendar.MONTH, -1);
                if("myboardQ".equals(request.getParameter("section"))){//묻고답하기
                    boardVO.setQ_startDt(sdf.format(c1.getTime()));
                    boardVO.setQ_endDt(sdf.format(c2.getTime()));
                }
            }
        }

        // 날짜 검색값 포맷
        if(Validate.isNotEmpty(boardVO.getQ_startDt()) || Validate.isNotEmpty(boardVO.getQ_bizStartDt())) {
            if( Validate.isNotEmpty(boardVO.getQ_startDt())){
                String startDt = boardVO.getQ_startDt();
                startDt = StringUtil.remove(startDt, "-");
                boardVO.setQ_startDt(startDt + "000000");
            }else{
                String bizStartDt = boardVO.getQ_bizStartDt();
                bizStartDt = StringUtil.remove(bizStartDt, "-");
                boardVO.setQ_bizStartDt(bizStartDt + "000000");
            }
        }

        if(Validate.isNotEmpty(boardVO.getQ_endDt()) || Validate.isNotEmpty(boardVO.getQ_bizEndDt())) {
            if( Validate.isNotEmpty(boardVO.getQ_endDt())){
                String endDt = boardVO.getQ_endDt();
                endDt = StringUtil.remove(endDt, "-");
                boardVO.setQ_endDt(endDt + "232359");
            }else{
                String bizEndDt = boardVO.getQ_bizEndDt();
                bizEndDt = StringUtil.remove(bizEndDt, "-");
                boardVO.setQ_bizEndDt(bizEndDt + "232359");
            }
        }

        boardVO.setCutTitleNum(boardConfVO.getCutTitleNum());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
        model.addAttribute("pageType", "LIST");

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        model.addAttribute("domCd", domainCode);
        boardVO.setLangType(hostNm);

        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));
        //마이페이지(myboardUserkey)
        if("myboardQ".equals(request.getParameter("section")) ){
           //로그인이 안되어 있으면 로그인 화면으로 가기(등록 화면시에만 적용 되도록 되어 있음)

            if(Validate.isNotEmpty(boardVO.getBbsCd()) && ( boardVO.getBbsCd() == 1003 || boardVO.getBbsCd() == 1010)){ //묻고답하기,비즈매칭 게시판만 로그인 필요

                if(userLoginVo != null) {
                    boardVO.setRegistId(userLoginVo.getUserId());
                }else{
                    String url2 = "/web/board/BD_board.list.do";

                    String loginUrl = loginchk.LoginCheckRtn(request);
                    String returnUrl = url2;
                    String returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd()+"&section=myboardQ";

                    String message = MessageHelper.getMsg(request, "requiredLogin");
                     return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);
                }
            }
        }else{
            boardVO.setSection("");
        }

        addNoticeBbsList(boardVO, boardConfVO.getListSkin(), request.getSession().getServletContext().getRealPath("/"), model);

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getListSkin(), boardConfVO.getSkinPath(), request);

        //myboard 경로
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");

        if("myboardQ".equals(request.getParameter("section"))){ // 마이페이지 묻고답하기(Q&A)
            return rtnUrl +"myboard/BD_board.list";
        }else{
            return url + "BD_board.list";
        }
    }

    // 공지리스트 및 게시물 리스트를 셋팅.
    private void addNoticeBbsList(BoardVO boardVO, String listSkin, String contextPath, ModelMap model) {
        Pager<BoardVO> pager = null;
        List<BoardVO> noticeList = null;

        boardVO.setNoticeBbscttAt("N");
        pager = boardService.boardList(boardVO, listSkin);
        boardVO.setNoticeBbscttAt("Y");
        noticeList = boardService.noticeList(boardVO, listSkin);

        if(listSkin.equals("gallery")) {
            convertFilePaths(pager.getList(), contextPath);
            convertFilePaths(noticeList, contextPath);
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
    @RequestMapping(value = {"BD_board.view.do","BD_board.view1.do"}, method = {RequestMethod.POST , RequestMethod.GET})
    public String boardView(ModelMap model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute BoardVO boardVO)
        throws Exception {

        //로그인이 안되어 있으면 로그인 화면으로 가기(등록 화면시에만 적용 되도록 되어 있음)
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        String hostNm = CmsUtil.getHostName(request.getServerName());

        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        if(Validate.isNotEmpty(boardVO.getBbsCd()) && ( boardVO.getBbsCd() == 1003 || boardVO.getBbsCd() == 1010)){ //묻고답하기,비즈매칭 게시판만 로그인 필요
            if(userLoginVo != null) {
              //마이페이지(myboardUserkey)
                if("myboardQ".equals(request.getParameter("section")) ){
                    boardVO.setRegistId(userLoginVo.getUserId());
                }else{
                    boardVO.setRegistId(null);
                }
            }else{

                String url2 ="";
                String returnParam="";
                if(!"myboardQ".equals(request.getParameter("section")) && boardVO.getBbsCd() == 1003){
                    url2 = "/web/board/BD_board.list1.do";
                    returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd()+"&section=1003";
                }else{
                    url2 = "/web/board/BD_board.list.do";
                    returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd()+"&section="+request.getParameter("section");
                }

                String loginUrl = loginchk.LoginCheckRtn(request);
                String returnUrl = url2;

                String message = MessageHelper.getMsg(request, "requiredLogin");
                 return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);
            }
        }

        //setBoardService(request, "V"); // 게시판 유형 서비스 설정
        setBoardService(request); // 게시판 유형 서비스 설정

        OpHelper.bindSearchMap(boardVO, request);

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());

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

        String message = "";

        BoardVO dataVO = boardService.boardView(boardVO);
        if(dataVO == null) {
            message = MessageHelper.getMsg(request, "noData");
            return alertAndBack(model, message);
        }

        // 비밀글인 경우 작성자나 슈퍼유저인가? => 일단은 작성자만 체크
        if("N".equals(dataVO.getOthbcAt())) {
//            UserLoginVO userLoginVo = OpHelper.getUserSession(request);
            if(Validate.isEmpty(userLoginVo)) {
                // 사용자 세션이 없을 경우 로그인페이지로 이동
            } else {
                if(Validate.isEmpty(userLoginVo.getUserKey())) {
                    return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
                } else {
                    if(!userLoginVo.getUserKey().equals(dataVO.getUserKey()) && !userLoginVo.getUserId().equals(dataVO.getRegistId())) {
                        if(!userLoginVo.getUserId().equals(dataVO.getRegistId())) {
                            message = MessageHelper.getMsg(request, "noUserBoard");
                            return alertAndBack(model,message);
//                            return alertAndRedirect(model, message,"BD_board.list.do?bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd());
                        }
                    }
                }
            }
        }

        // 메뉴 증가를 위한 쿠키 체크
        if(CookieUtil.isIncreateReadCnt("board" + boardVO.getBbsCd(), boardConfVO.getRdcntIncrsLmttTime(), request, response)) {
            boardCountService.incMenuReadCount(boardVO.getBbsCd());
        }

        // 조회수 증가를 위한 쿠키 체크
        if(CookieUtil.isIncreateReadCnt("board" + boardVO.getBbsCd() + "_" + boardVO.getBbscttSeq(), boardConfVO.getRdcntIncrsLmttTime(), request, response)) {
            dataVO.setRdcnt(dataVO.getRdcnt() + 1);
            boardService.incReadCount(boardVO);
        }

        // 에디터사용이 N일 때 \n이 있으면 <br/> 태그로 전환
        /*if("N".equals(boardConfVO.getMngrEditorYn())) {
            dataVO.setBbscttCn(Converter.translateBR(dataVO.getBbscttCn()));
        }else*/ 
        if(dataVO.getBbsCd() != 1009 && dataVO.getBbsCd() != 1012)
            if("N".equals(boardConfVO.getUserEditorYn())){
                dataVO.setBbscttCn(Converter.translateBR(dataVO.getBbscttCn()));
            }
        if(Validate.isNotEmpty(dataVO.getReplyCn())){
            dataVO.setReplyCn(Converter.translateBR(dataVO.getReplyCn()));
        }

        if(boardConfVO.getKndCd() == BoardConfConstant.GUBUN_BOARD_GALLERY) {
            convertFilePath(dataVO.getFileList(), request.getSession().getServletContext().getRealPath("/"));
        }

        model.addAttribute("pageType", "VIEW");
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVO);

//        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        model.addAttribute("domCd", domainCode);

        if(boardConfVO.getListViewCd() == BoardConfConstant.GUBUN_LISTVIEW_LIST) {
            addNoticeBbsList(boardVO, boardConfVO.getListSkin(), request.getSession().getServletContext().getRealPath("/"), model);
        }

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getListSkin(), boardConfVO.getSkinPath(), request);

        //myboard 경로
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");

       if("myboardQ".equals(request.getParameter("section"))){ // 마이페이지 묻고답하기(Q&A)
            return rtnUrl +"myboard/BD_board.view";
        }else{
            return url + "BD_board.view";
        }
    }

    /**
     * 비공개 게시물 비밀번호 확인 폼
     */
    @RequestMapping(value = "PD_pwd.form.do")
    public String boardPwdForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String url = getTemplateFolderName(request.getRequestURL().toString(), null, null, request);
        return url + "templates/common/PD_pwd.form";
    }

    /**
     * 비공개 게시물 비밀번호 확인
     */
    @RequestMapping(value = "ND_pwd.confirm.do", method = RequestMethod.POST)
    public String boardPwdConfirm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정

        boolean result = false;

        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        boardService.boardView(boardVO);
        /*if(boardVO.getRegistPassword().equals(dataVO.getRegistPassword())) {
            result = true;
        }*/
        return responseJson(model, result);
    }

    /**
     * 게시물 평가하기
     */
    /*@RequestMapping(value = "ND_score.action.do", method = RequestMethod.POST)
    public String scoreAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        Integer result = (Integer) boardService.scoreAction(boardVO);
        if(Validate.isEmpty(result)) {
            responseJson(model, 0, "");
        }

        //언어코드 삽입
        boardVO.setLangCd(commonDutyService.getLangCd(boardVO.getDomainCd()));

        BoardVO resultVO = boardService.boardView(boardVO);
        return responseJson(model, resultVO.getScoreAvg(), "");
    }*/

    /**
     * 추천 하기
     */
    @RequestMapping(value = "ND_recom.action.do", method = RequestMethod.POST)
    public String recommAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";
        Integer result = (Integer) boardService.recommAction(boardVO);
        if(Validate.isEmpty(result)) {
            message = MessageHelper.getMsg(request, "processFail");
            alertAndBack(model, message);
        }

        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        BoardVO resultVO = boardService.boardView(boardVO);

        return responseJson(model, resultVO.getRecomendCnt());
    }

    /**
     * 신고 하기
     */
    @RequestMapping(value = "ND_accuse.action.do", method = RequestMethod.POST)
    public String accuseAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";
        Integer result = (Integer) boardService.accuseAction(boardVO);
        if(Validate.isEmpty(result)) {
            message = MessageHelper.getMsg(request, "processFail");
            alertAndBack(model, message);
        }

        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        BoardVO resultVO = boardService.boardView(boardVO);
        return responseJson(model, resultVO.getAccuseCnt());
    }

    /**
     * 게시물 등록 폼 & (bbsCd, bbscttSeq=null, refrnSeq=null)
     * 답글 등록 폼 & (bbsCd, refrnSeq, bbscttSeq)
     * 게시물 수정 폼 (bbsCd, bbscttSeq, refrnSeq=null)
     * 게시물 등록 당사자나 관리자만 가능하다.
     */
    @RequestMapping(value = { "BD_board.insert.form.do", "BD_board.update.form.do", "BD_board.reply.form.do","BD_board.insert.form1.do", "BD_board.update.form1.do", })
    public String insertForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO,
        @RequestParam(value = "pageType", required = true) String pageType) throws Exception {

        //로그인이 안되어 있으면 로그인 화면으로 가기(등록 화면시에만 적용 되도록 되어 있음)
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        String hostNm = CmsUtil.getHostName(request.getServerName());

        if(userLoginVo == null) {

            String url="";

            if(!"myboardQ".equals(request.getParameter("section")) && boardVO.getBbsCd() == 1003){
                url = "/web/board/BD_board.list1.do";
            }else{
                url = "/web/board/BD_board.list.do";
            }

            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl = url;
            String returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd()+"&pageType=" +pageType+"&bbscttSeq="+boardVO.getBbscttSeq();
            String message = MessageHelper.getMsg(request, "requiredLogin");
             return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);

        }

        //검색조건비우기(서비스)
        boardVO.setQ_product("");

        setBoardService(request); // 게시판 유형 서비스 설정

        OpHelper.bindSearchMap(boardVO, request);

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        BoardVO dataVO = new BoardVO();
        dataVO.setDomainCd(boardVO.getDomainCd());
        dataVO.setBbsCd(boardVO.getBbsCd());
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        // 사용스토리 - 주문한 서비스내역이없으면 글을 등록할수 없음.
        if(boardConfVO.getBbsCd() == 1008){
            if("INSERT".equals(request.getParameter("pageType"))){

                if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
                    boardVO.setUserId(userLoginVo.getUserId());
                    int count = boardService.productView(boardVO);
                    if(count == 0){
                        String message = MessageHelper.getMsg(request, "chkProduct");
                        return alertAndRedirect(model, message,"BD_board.list.do?bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd());
    //                    return alertAndBack(model, message);
                    }
                }
            }
        }

        if("UPDATE".equals(pageType)) {
            // *** 수정폼 ***
            model.addAttribute("pageType", "UPDATE");
            dataVO = boardService.boardView(boardVO);

            if(!dataVO.getRegistId().equals(userLoginVo.getUserId())){
                String message = MessageHelper.getMsg(request, "illegalRequest");
                return alertAndRedirect(model, message,"BD_board.list.do?bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd());
            }

            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if("N".equals(boardConfVO.getUserEditorYn())){
                dataVO.setBbscttCn(Converter.cleanHtml(dataVO.getBbscttCn()));
            }
            
            model.addAttribute("aditCtgList", boardService.boardAditCtgList(boardVO));

        } else if("REPLY".equals(pageType)) {
            // *** 답변등록폼 ***
            model.addAttribute("pageType", "REPLY");
            boardVO = boardService.boardView(boardVO);
            dataVO = boardVO.copyCreateVO();

        } else {
            // *** 등록폼 ***
            model.addAttribute("pageType", "INSERT");
            pageType = "INSERT";
        }

        if(Validate.isNotEmpty(boardVO.getBbscttSeq()) && "INSERT".equals(pageType)) {
            String message = MessageHelper.getMsg(request, "illegalRequest");
            return alertAndRedirect(model, message,"BD_board.list.do?bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd());
        }

        if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
            dataVO.setUserId(userLoginVo.getUserId());
            dataVO.setRegistId(userLoginVo.getUserId());
            dataVO.setRegisterNm(userLoginVo.getUserNm());
            dataVO.setUserKey(userLoginVo.getUserKey());
        }

        dataVO.setLangCode(boardVO.getLangCode());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVO);



        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        model.addAttribute("domCd", domainCode);

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getListSkin(), boardConfVO.getSkinPath(), request);

        //myboard 경로
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
        if("myboardQ".equals(request.getParameter("section"))){ // 마이페이지 묻고답하기(Q&A)
            return rtnUrl +"myboard/BD_board.form";
        }else{
            return url + "BD_board.form";
        }
    }

    /**
     * 부류코드(2Depth추가)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_aditCtgList.do", method = RequestMethod.GET)
    public String aditCtgList(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        return responseJson(model, boardService.boardAditCtgList(boardVO));
    }
    
    /**
     * 게시물 등록 액션
     */
    @RequestMapping(value = "ND_board.insert.do", method = RequestMethod.POST)
    public String boardInsert(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {

        setBoardService(request); // 게시판 유형 서비스 설정

 /*       if(boardVO.getDomainCd() != null ){
            String message2 = MessageHelper.getMsg(request, "validateFail");
            return alertAndBack(model, message2);
        }*/
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        String message = "";
        // 자동 작성 방지 체크
        if("Y".equals(boardConfVO.getCaptchaYn())) {
            Captcha captcha = (Captcha) RequestUtil.getSessionAttribue(request, Captcha.NAME);
            // request.setCharacterEncoding("UTF-8");
            String answer = request.getParameter("answer");
            if(!captcha.isCorrect(answer)) {
                message = MessageHelper.getMsg(request, "captchaRetype");
                return alertAndBack(model, message);
            }
        }

        // GUBUN_UPLOADER_FLASH 일때는 파일 업로드를 하지 않는다.
        List<FileVO> fileList = new ArrayList<FileVO>();
        
        
        if(boardConfVO.getUploadTy() == BoardConfConstant.GUBUN_UPLOADER_FORM) {
            fileList = UploadHelper.upload(request, "board");

            
            //파일 업로드시 확장자체크
            if(fileList.size() > 0){
                FileVO fileVO = fileList.get(0);
                String fileName = fileVO.getLocalNm(); // 원본파일 이름
                System.out.println("fileName; " + fileName);
                
                String extension = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length()); // 파일 확장자
                System.out.println("extension; " + extension);
                
                String filePermExtsn = boardConfVO.getFilePermExtsn().toLowerCase(); //파일 확장자 종류
                System.out.println("filePermExtsn; " + filePermExtsn);
                
                
                
                if(filePermExtsn.indexOf(extension.toLowerCase()) == -1) {
                    if(boardService.fileDelete(fileList)) {
                        message = MessageHelper.getMsg(request, "fileCannotUplaod");
                        return alertAndBack(model, "[ "+extension+" ]"+message);
                    } else {
                        message = MessageHelper.getMsg(request, "processFail");
                        return alertAndBack(model, message);
                    }
                }
            }

            // 폼 업로드시 업로드 파일 용량을 체크한다.
            if(!checkUploadFileSize(fileList, boardConfVO)) {
                if(boardService.fileDelete(fileList)) {
                    message = MessageHelper.getMsg(request, "fileSizeOver");
                    return alertAndBack(model, message);
                } else {
                    message = MessageHelper.getMsg(request, "processFail");
                    return alertAndBack(model, message);
                }
            }
           
        }

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(holder.isValid()) {
            if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
                boardVO.setRegistId(userLoginVo.getUserId());
                boardVO.setRegisterNm(userLoginVo.getUserNm());
                boardVO.setUserKey(userLoginVo.getUserKey());
                boardVO.setEmail(userLoginVo.getEmail());
            }else{

                LoginCheckReturn loginchk = new LoginCheckReturn();

                String url = "";
                if(!"myboardQ".equals(request.getParameter("section")) && boardVO.getBbsCd() == 1003){ // 마이페이지 묻고답하기 아닐때
                    url = "/web/board/BD_board.insert.form1.do";
                }else{
                    url = "/web/board/BD_board.insert.form.do";
                }

                String loginUrl = loginchk.LoginCheckRtn(request);
                String returnUrl = url;
                String returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd()+"&pageType=INSERT"+"&bbscttSeq="+boardVO.getBbscttSeq();

                message = MessageHelper.getMsg(request, "requiredLogin");
                return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);
            }

            boardVO.setIpAdres(request.getRemoteAddr());
            boardVO.setFileList(fileList);

            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if(boardConfVO.getUserEditorYn().equals("N")) {
                boardVO.setBbscttCn(Converter.XSS(boardVO.getBbscttCn()));
            }

            if(boardVO.getBbsCd() == 1003){
                boardVO.setEstnColumn3("N");
            }

            // 등록 실행
            Object key = boardService.boardInsert(boardVO);

            if(Validate.isEmpty(key)) {
                message = MessageHelper.getMsg(request, "processFail");
                return alertAndBack(model, message);
            }

        } else {
            message = MessageHelper.getMsg(request, "validateFail");
            return alertAndBack(model, message);
        }

        //이메일발송 vo
        RegisterUserVO vo = new RegisterUserVO();

        if(boardConfVO.getBbsCd() == 1010 ){//비즈매칭 게시물이 등록후 메일발송

            String endDt = boardVO.getEstnColumn6().substring(0,4) +"-" + boardVO.getEstnColumn6().substring(4,6)+"-"
                                    +boardVO.getEstnColumn6().substring(6,8)+" "+boardVO.getEstnColumn6().substring(8,10) +":"+boardVO.getEstnColumn6().substring(10,12);
            boardVO.setEstnColumn6(endDt);

            String[] category = {boardVO.getEstnColumn8(),boardVO.getEstnColumn9(),boardVO.getEstnColumn10()};
            boardVO.setCategorys(category);
            List<RegisterUserVO> datalist;
            //희망답변자가 선택되지 않았을 경우
            if("".equals(boardVO.getEstnColumn1()) || boardVO.getEstnColumn1() == null){
                //서비스카테고리에 등록된 서비스의 유저 조회-받는사람
                datalist = boardService.categoryUserList(boardVO);
                
            } else { //희망답변자 선택시
                boardVO.setCtgryUserIds(boardVO.getEstnColumn1().trim().split(","));
                datalist = boardService.selectCtgryUserList(boardVO);
            }
            
            /********************************************************/
            /** 알란 기능의 기본정보********************************************/            
            AlarmVO avo = new AlarmVO();
            avo.setAlarmBizGbn("01") ; //문가상담
            avo.setConfrmGbn("N"); 
            avo.setUserId(userLoginVo.getUserId());
            avo.setAlarmTitle(boardVO.getBbscttSj());
            /********************************************************/
            
            for(int i = 0 ; i < datalist.size() ; i++) {
                vo.setEmail(datalist.get(i).getEmail());
                vo.setUserNm(datalist.get(i).getUserNm());
                //vo.setUserTyCd(datalist.get(i).getUserTyCd());
                vo.setMbtlnum(datalist.get(i).getTelno());

                boardVO.setMailSection(31); // 이메일 사용 구분값
                emailCrtfcAction(request, model, boardVO, vo); //이메일 전송
                
                /********************************************************/
                /** 알란기능 저장 ********************************************/
                avo.setConfrmId(datalist.get(i).getUserId());
                alarmService.alarmInsert(avo);
                /********************************************************/

            }
            
        }else if(boardConfVO.getBbsCd() == 1003){ // 고객센터 질문등록 후 메일발송

            //받는사람정보
            List<MgrVO> mgrList = boardService.mgrInfo();
            for(int i = 0 ; i < mgrList.size() ; i++) {
                vo.setEmail(mgrList.get(i).getEmail());
                vo.setUserNm(mgrList.get(i).getMngrNm());

                //보내는내용
                BoardVO boardEmailVO = boardService.boardView(boardVO);
                boardEmailVO.setEmail(userLoginVo.getEmail()); //게시물등록자정보(받는사람정보)
                boardEmailVO.setUserNm(userLoginVo.getUserNm());
                boardEmailVO.setUserTyCd(userLoginVo.getUserTyCd());
                boardEmailVO.setTelNo(userLoginVo.getTelno());

                if(boardEmailVO.getOthbcAt() != "Y"){
                    boardEmailVO.setOthbcAt("공개");
                }else{
                    boardEmailVO.setOthbcAt("비공개");
                }

                boardEmailVO.setMailSection(51); // 이메일 사용 구분값
                emailCrtfcAction(request, model, boardEmailVO, vo); //이메일 전송

            }
        }
        String url = "";

        if(!"myboardQ".equals(request.getParameter("section")) && boardVO.getBbsCd() == 1003){
            url = "BD_board.list1.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() ; //+ "&" + OpHelper.getSearchQueryString(request)
        }else{
            url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() ; //+ "&" + OpHelper.getSearchQueryString(request)
        }
        message = MessageHelper.getMsg(request, "insertOk");
        return alertAndRedirect(model, message, url);
    }

    /**
     * 게시물 수정 액션
     */
    @RequestMapping(value = "ND_board.update.do", method = RequestMethod.POST)
    public String boardUpdate(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        String message = "";

        // 자동 작성 방지 체크
        if("Y".equals(boardConfVO.getCaptchaYn())) {
            Captcha captcha = (Captcha) RequestUtil.getSessionAttribue(request, Captcha.NAME);
            String answer = request.getParameter("answer");
            if(!captcha.isCorrect(answer)) {
                message = MessageHelper.getMsg(request, "captchaRetype");
                return alertAndBack(model, message);
            }
        }

        // *** 수정데이터 ***
        model.addAttribute("pageType", "UPDATE");

        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        BoardVO dataVO = boardService.boardView(boardVO);
        if(dataVO == null) {
            message = MessageHelper.getMsg(request, "noData");
            return alertAndBack(model, message);
        }

        // GUBUN_UPLOADER_FLASH 일때는 파일 업로드를 하지 않는다.
        List<FileVO> fileList = new ArrayList<FileVO>();
        if(boardConfVO.getUploadTy() == BoardConfConstant.GUBUN_UPLOADER_FORM) {
            fileList = UploadHelper.upload(request, "board");

            // 폼 업로드시 업로드 파일 용량을 체크한다.
            if(!checkUploadFileSize(fileList, boardConfVO)) {
                if(boardService.fileDelete(fileList)) {
                    message = MessageHelper.getMsg(request, "fileSizeOver");
                    return alertAndBack(model, message);
                } else {
                    message = MessageHelper.getMsg(request, "processFail");
                    return alertAndBack(model, message);
                }
            }
        }

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        if(holder.isValid()) {
            UserLoginVO userLoginVo = OpHelper.getUserSession(request);

            if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
                boardVO.setUpdtId(userLoginVo.getUserId());
                boardVO.setUserKey(userLoginVo.getUserKey());
            }
            boardVO.setIpAdres(request.getRemoteAddr());
            boardVO.setFileList(fileList);

            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if(boardConfVO.getUserEditorYn().equals("N")) {
                boardVO.setBbscttCn(Converter.XSS(boardVO.getBbscttCn()));
            }

            // 수정실행
            boardService.boardUpdate(boardVO);

        } else {
            message = MessageHelper.getMsg(request, "validateFail");
            return alertAndBack(model, message);
        }

        String url = "";

        if("myboardQ".equals(request.getParameter("section"))){ // 마이페이지 묻고답하기(Q&A)
            url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&section=" + request.getParameter("section");
        }else if(!"myboardQ".equals(request.getParameter("section"))&& boardVO.getBbsCd() == 1003){
            url = "BD_board.view1.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&bbscttSeq=" + boardVO.getBbscttSeq() + "&" + OpHelper.getSearchQueryString(request);
        }else{
            url = "BD_board.view.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&bbscttSeq=" + boardVO.getBbscttSeq() + "&" + OpHelper.getSearchQueryString(request);
        }


        message = MessageHelper.getMsg(request, "updateOk");
        return alertAndRedirect(model, message, url);
    }

    /**
     * 팝업 게시물 수정 폼 (bbsCd, bbscttSeq, refrnSeq=null)
     */
    @RequestMapping(value = { "PD_board.update.form.do"})
    public String popUpdateForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO,
        @RequestParam(value = "pageType", required = true) String pageType) throws Exception {

        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);

        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        BoardVO dataVO = new BoardVO();
        dataVO.setDomainCd(boardVO.getDomainCd());
        dataVO.setBbsCd(boardVO.getBbsCd());
        dataVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

        if("UPDATE".equals(pageType)) {
            // *** 수정폼 ***
            model.addAttribute("pageType", "UPDATE");
            dataVO = boardService.boardView(boardVO);

        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVO);

        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        model.addAttribute("domCd", domainCode);

        String url = getTemplateFolderName(request.getRequestURL().toString(), boardConfVO.getListSkin(), boardConfVO.getSkinPath(), request);
        return url + hostNm + "/PD_board.form";
    }

    /**
     * 게시물 답변글 등록 액션
     */
    @RequestMapping(value = "ND_board.reply.do", method = RequestMethod.POST)
    public String boardReply(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        String message = "";

        // 자동 작성 방지 체크
        if("Y".equals(boardConfVO.getCaptchaYn())) {
            Captcha captcha = (Captcha) RequestUtil.getSessionAttribue(request, Captcha.NAME);
            String answer = request.getParameter("answer");
            if(!captcha.isCorrect(answer)) {
                message = MessageHelper.getMsg(request, "captchaRetype");
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
                    message = MessageHelper.getMsg(request, "fileSizeOver");
                    return alertAndBack(model, message);
                } else {
                    message = MessageHelper.getMsg(request, "processFail");
                    return alertAndBack(model, message);
                }
            }
        }

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(boardVO);
        if(holder.isValid()) {
            UserLoginVO userLoginVo = OpHelper.getUserSession(request);
            if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
                boardVO.setRegistId(userLoginVo.getUserId());
                boardVO.setUserKey(userLoginVo.getUserKey());
            } else {
                // 테스트를 위해 임시로 하는 것임. 추후 삭제할 것
                boardVO.setUserKey("testUserKey");
            }
            boardVO.setIpAdres(request.getRemoteAddr());
            boardVO.setFileList(fileList);
            // 에디터 사용 상태가 아닌 경우 HTML 태그 제거
            if(boardConfVO.getUserEditorYn().equals("N")) {
                boardVO.setBbscttCn(Converter.XSS(boardVO.getBbscttCn()));
            }

            // 등록 실행
            Object key = boardService.boardInsert(boardVO);
            if(Validate.isEmpty(key)) {
                message = MessageHelper.getMsg(request, "processFail");
                return alertAndBack(model, message);
            }
        } else {
            message = MessageHelper.getMsg(request, "validateFail");
            return alertAndBack(model, message);
        }

        String url = "";

        if(!"myboardQ".equals(request.getParameter("section")) && boardVO.getBbsCd() == 1003){ // 마이페이지 묻고답하기 아닐때
            url = "BD_board.list1.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        }else{
            url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        }

        message = MessageHelper.getMsg(request, "insertOk");
        return alertAndRedirect(model, message, url);
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
         BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
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
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);

        model.addAttribute("type", type);

        String url = getTemplateFolderName(request.getRequestURL().toString(), null, null, request);
        return url + "templates/common/PD_convert.form";
    }

    /**
     * 게시글 목록 변환 (RSS, ATOM, EXCEL, PDF)
     */
    @RequestMapping(value = "ND_convertAction.do", method = RequestMethod.GET)
    public String convertAction(ModelMap model, HttpServletRequest request, @ModelAttribute BoardConvertOptionVO boardConvertOptionVO,
        @RequestParam(required = true) String type) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";

        if(boardConvertOptionVO == null) {
            message = MessageHelper.getMsg(request, "invalidParam");
            alertAndClose(model, message);
        }

        OpHelper.bindSearchMap(boardConvertOptionVO, request);

        // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        if(Validate.isNotEmpty(boardConvertOptionVO.getQ_searchKeyType())) {
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

        String baseUrl = getTemplateFolderName(request.getRequestURL().toString(), null, null, request);

        if("rss".equals(type) || "atom".equals(type)) {
            FeedVO metaFeedVO = new FeedVO();
            metaFeedVO.setTitle(boardConfVO.getBbsNm());
            metaFeedVO.setLink(SERVER_ADDR + baseUrl + "BD_board.list.do?domainCd=" + boardConvertOptionVO.getDomainCd() + "&bbsCd=" + boardConvertOptionVO.getBbsCd());
            metaFeedVO.setDescription(boardConfVO.getBbsDc());
            List<FeedVO> itemList = new ArrayList<FeedVO>();
            for(BoardVO bean : list) {
                FeedVO _feedVO = new FeedVO();
                if(bean.getOthbcAt().equals("N")) {
                    _feedVO.setTitle(bean.getBbscttSj() + " (비공개)");
                    _feedVO.setLink("");
                } else {
                    _feedVO.setTitle(bean.getBbscttSj());
                    _feedVO.setLink(SERVER_ADDR + baseUrl + "BD_board.view.do?domainCd=" + boardConvertOptionVO.getDomainCd() + "&bbsCd=" + boardConvertOptionVO.getBbsCd() + "&bbscttSeq=" + bean.getBbscttSeq());
                    _feedVO.setDescription(bean.getCnSumry());
                }
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
     * 게시판 태그 클라우드폼
     */
    @RequestMapping(value = "PD_tagcloud.do", method = RequestMethod.GET)
    public String tagCloudForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardVO.getDomainCd() + "_" + boardVO.getBbsCd());
        model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);

        String url = getTemplateFolderName(request.getRequestURL().toString(), null, null, request);
        return url + "templates/common/PD_tagcloud";
    }

    /**
     * 게시판 클라우트 태그 데이터를 가져옴
     */
    @RequestMapping(value = "INC_tagcloud.do", method = RequestMethod.GET)
    public String tagCloudAction(ModelMap model, HttpServletRequest request, String domainCd, String bbsCd) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";

        if(Validate.isEmpty(bbsCd)) {
            message = MessageHelper.getMsg(request, "invalidParam");
            alertAndClose(model, message);
        }

        String jsonstr = boardService.tagCloud(Integer.valueOf(domainCd), Integer.valueOf(bbsCd));
        return responseJson(model, jsonstr);
    }

    /**
     * 카테고리 목록을 가져온다(게시물 이동폼)
     */
    @RequestMapping(value = "INC_board.ctg.list.do", method = RequestMethod.POST)
    public String ctgList(ModelMap model, HttpServletRequest request,
        @RequestParam(value = "domainCd", required = true) Integer domainCd,
        @RequestParam(value = "bbsCd", required = true) Integer bbsCd) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + domainCd + "_"+ bbsCd);
        if(boardConfVO == null) {
            return responseJson(model, true, new ArrayList<BoardCtgVO>(), "");
        } else {
            return responseJson(model, true, boardConfVO.getCtgList(), "");
        }
    }

    /**
     * 게시물 삭제
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_board.delete.do", method = RequestMethod.POST)
    public String boardDelete(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        setBoardService(request); // 게시판 유형 서비스 설정
        OpHelper.bindSearchMap(boardVO, request);
        String message = "";

        Integer cnt = boardService.boardDelete(boardVO, true);
        if(cnt != StringUtil.ONE) {
            message = MessageHelper.getMsg(request, "processFail");
            return alertAndBack(model, message);
        }

        String url = "";

        if("myboardQ".equals(request.getParameter("section"))){ // 마이페이지 묻고답하기(Q&A)
            url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&section=" + request.getParameter("section");
        }else if(!"myboardQ".equals(request.getParameter("section")) && boardVO.getBbsCd() == 1003){ // 마이페이지 묻고답하기 아닐때
            url = "BD_board.list1.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&section=" + request.getParameter("section");
        }else{
            url = "BD_board.list.do?domainCd=" + boardVO.getDomainCd() + "&bbsCd=" + boardVO.getBbsCd() + "&" + OpHelper.getSearchQueryString(request);
        }

        message = MessageHelper.getMsg(request, "deleteOk");
        return alertAndRedirect(model, message, url);
    }

    /**
     * 댓글 목록 조회
     */
    @RequestMapping(value = "INC_cmt.list.do", method = RequestMethod.GET)
    public String commentList(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO, PopVO vo) throws Exception {

        setBoardService(request); // 게시판 유형 서비스 설정
            OpHelper.bindSearchMap(boardCmtVO, request);

            BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardCmtVO.getDomainCd() + "_" + boardCmtVO.getBbsCd());

            Pager<BoardCmtVO> pager = boardService.commentList(boardCmtVO);

            model.addAttribute(BoardConfConstant.KEY_PAGER_VO, pager);
            model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);

            //게시판 정보
            BoardCmtVO dataVO = boardService.cmtBoardView(boardCmtVO);

            if(dataVO != null && Validate.isNotEmpty(dataVO)){
                model.addAttribute("cmtBoardVo", dataVO);
            }

            if( boardConfVO.getBbsCd() == 1010) {//비즈매칭
                UserLoginVO userLoginVO = OpHelper.getUserSession(request);
                vo.setUserId(userLoginVO.getUserId());
                model.addAttribute(GlobalConfig.KEY_DATA_VO + "2",popService.userView(vo));                
            }

            String url = getTemplateFolderName(request.getRequestURL().toString(), null, null, request);
            String domainNm = CmsUtil.getHostName(request.getServerName());

        if( boardConfVO.getBbsCd() == 1010) {//비즈매칭
            return url + domainNm +"/INC_bizMatchingCmt.list";
        }else{
            return url + domainNm +"/INC_cmt.list";
        }

    }

    /**
     * 댓글 등록 & 수정 액션
     */
    @RequestMapping(value = "ND_cmt.insert.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String commentInsert(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO, String type) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        Integer result = null;

        if(userLoginVo == null) { // 로그인이 안된경우
            return responseJson(model, "notLogin");

        }else if(userLoginVo != null  && "INSERT".equals(request.getParameter("type")) && boardCmtVO.getBbsCd() == 1010){ //로그인이 되었고 기존에 댓글을 달았는지 확인 (비즈매칭만)
            boardCmtVO.setUserKey(userLoginVo.getUserKey());
            result = (Integer) boardService.bizCommentCheck(boardCmtVO);
            if( result > 0){
                message = MessageHelper.getMsg(request, "commentbizChack");
                return responseJson(model, false, message);
            }
        }

        // 금칙어 존재여부 체크
        if(banCheck(boardCmtVO.getDomainCd(), boardCmtVO.getBbsCd(), boardCmtVO.getNttCmtCn())) {
            // 금칙어 존재여부 체크
            message = MessageHelper.getMsg(request, "banCheck");
            return responseText(model, message);
        }

        if(userLoginVo != null && boardCmtVO.getBbsCd() == 1010){ //로그인이 되었고 비즈매칭만 파일 업로드
           
            BoardConfVO boardConfVO = (BoardConfVO) Cache.get(BoardConfCache.BBS_CD_KEY + "_" + boardCmtVO.getDomainCd() + "_" + boardCmtVO.getBbsCd());
            // GUBUN_UPLOADER_FLASH 일때는 파일 업로드를 하지 않는다.
            List<FileVO> fileList = new ArrayList<FileVO>();
            if(boardConfVO.getUploadTy() == BoardConfConstant.GUBUN_UPLOADER_FORM) {
                fileList = UploadHelper.upload(request, "board");

                // 폼 업로드시 업로드 파일 용량을 체크한다.
                if(!checkUploadFileSize(fileList, boardConfVO)) {
                    if(boardService.fileDelete(fileList)) {
                        message = MessageHelper.getMsg(request, "fileSizeOver");
                        return alertAndBack(model, message);
                    } else {
                        message = MessageHelper.getMsg(request, "processFail");
                        return alertAndBack(model, message);
                    }
                }
            }
            boardCmtVO.setFileList(fileList);

        }

        //등록할때 HTML 클린
        boardCmtVO.setNttCmtCn(Converter.cleanHtml(boardCmtVO.getNttCmtCn()));

//        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
         if("UPDATE".equals(type)) {
            if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
                boardCmtVO.setUpdtId(userLoginVo.getUserId());
                boardCmtVO.setRegistId(userLoginVo.getUserId());
                boardCmtVO.setUserNm(userLoginVo.getUserNm());
                boardCmtVO.setRegisterNm(userLoginVo.getUserNm());
                boardCmtVO.setUserKey(userLoginVo.getUserKey());
            }

            result = (Integer) boardService.updateComment(boardCmtVO);

            if(result == null) {
                message = MessageHelper.getMsg(request, "processFail");
                return responseJson(model, false, message);
            } else {
                message = MessageHelper.getMsg(request, "updateOk");
                return responseJson(model, true, message);
            }
        } else if("INSERT".equals(type)) {
            boardCmtVO.setIpAdres(request.getRemoteAddr());

            if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserKey())) {
                boardCmtVO.setUpdtId(userLoginVo.getUserId());
                boardCmtVO.setRegistId(userLoginVo.getUserId());
                boardCmtVO.setUserNm(userLoginVo.getUserNm());
                boardCmtVO.setRegisterNm(userLoginVo.getUserNm());
                boardCmtVO.setUserKey(userLoginVo.getUserKey());
            }
            result = (Integer) boardService.insertComment(boardCmtVO);

            //이메일발송 vo
            RegisterUserVO vo = new RegisterUserVO();
            BoardVO boardEmailVO = new BoardVO();

            if(result > 0 && boardCmtVO.getBbsCd() == 1010){//댓글 등록완료(비즈매칭 메일발송)

                boardEmailVO.setDomainCd(boardCmtVO.getDomainCd());
                boardEmailVO.setBbsCd(boardCmtVO.getBbsCd());
                boardEmailVO.setBbscttSeq(boardCmtVO.getBbscttSeq());


                //현재게시물정보
                BoardVO boardViewVo = boardService.boardView(boardEmailVO);

                //게시물 등록자 정보조회
                BoardVO boardVO = boardService.userBoardSelect(boardEmailVO);

                if(boardVO != null && boardViewVo != null){
                    //메일보낼사람 정보
                    vo.setUserNm(boardVO.getUserNm());
                    vo.setUserTyCd(boardVO.getUserTyCd());
                    vo.setEmail(boardVO.getEmail());


                    //매칭정보
                    boardEmailVO.setBbscttCn(boardCmtVO.getNttCmtCn()); //매칭내용
                    boardEmailVO.setRegistId(boardCmtVO.getRegistId()); //매칭등록자아이디
                    boardEmailVO.setRegistDt(boardCmtVO.getRegistDt()); //매칭등록일
                    boardEmailVO.setBizMatchingEmail(boardCmtVO.getBizMatchingEmail()); //매칭등록자 회사명
                    boardEmailVO.setBizMatchingCttpc(boardCmtVO.getBizMatchingCttpc()); //매칭등록자 연락처
                    boardEmailVO.setBbscttSj(boardViewVo.getBbscttSj()); //게시물 제목


                    boardViewVo.setEstnColumn6(DateFormatUtil.getTodayMsec());
                    //종료일
                    String endDt = boardViewVo.getEstnColumn6().substring(0,4) +"-" + boardViewVo.getEstnColumn6().substring(4,6)+"-"
                        +boardViewVo.getEstnColumn6().substring(6,8)+" "+boardViewVo.getEstnColumn6().substring(8,10) +":"+boardViewVo.getEstnColumn6().substring(10,12);
                    boardEmailVO.setEstnColumn6(endDt);//게시물 종료일
                }

                boardEmailVO.setMailSection(32); // 이메일 사용 구분값
                emailCrtfcAction(request, model, boardEmailVO, vo); //이메일 전송

            }

            message = MessageHelper.getMsg(request, "insertOk");
            return responseJson(model, true, message);
        } else {
            message = MessageHelper.getMsg(request, "invalidParam");
            return responseJson(model, false, message);
        }
    }

    /**
     * 댓글 삭제 액션
     */
    @RequestMapping(value = "ND_comment.delete.do", method = RequestMethod.POST)
    public String commentDelete(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";
        BoardCmtVO dataVO = boardService.viewComment(boardCmtVO);
        if(dataVO == null) {
            message = MessageHelper.getMsg(request, "noData");
            return responseText(model, message);
        }

        boardCmtVO.setRefrnCmtSeq(dataVO.getRefrnCmtSeq());

        String result = "";
        result = boardService.deleteComment(boardCmtVO);

        if("TRUE".equals(result)) {
            return responseText(model, result);
        } else {
            return responseText(model, MessageHelper.getMsg(request, "processFail"));

        }
    }

    /**
     * 댓글 플래그 삭제 액션
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_comment.flag.delete.do", method = RequestMethod.POST)
    public String cmtFlagDelete(HttpServletRequest request, ModelMap model, BoardCmtVO boardCmtVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        Integer result = boardService.cmtFlagDelete(boardCmtVO);
        String message = "";

        if(result == null || result == 0) {
            message = MessageHelper.getMsg(request, "processFail");
            return responseText(model, message);
        } else {
            return responseText(model, result);
        }
    }

    /**
     * 댓글 수정 요청 폼
     * return true/false
     */
    @RequestMapping(value = "ND_comment.update.form.do", method = RequestMethod.POST)
    public String commentView(ModelMap model, HttpServletRequest request, @ModelAttribute BoardCmtVO boardCmtVO) throws Exception {
        setBoardService(request); // 게시판 유형 서비스 설정
        String message = "";

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);

        if(userLoginVo == null) { // 로그인이 안된경우
            return responseJson(model, "notLogin");
        }

        if(boardCmtVO.getDomainCd() == null) {
            message = MessageHelper.getMsg(request, "invalidParam");
            return responseJson(model, false, message);
        }

        BoardCmtVO dataVO = boardService.viewComment(boardCmtVO);
        //HTML제거
        dataVO.setNttCmtCn(Converter.cleanHtml(dataVO.getNttCmtCn()));
        message = MessageHelper.getMsg(request, "processOk");

        return responseJson(model, true, dataVO, message);

    }

     /**
      * 팝업 서비스선택
      *
      * @param request
      * @param model
      */
     @RequestMapping(value = "PD_product.do")
     public String popProduct(HttpServletRequest request, ModelMap model,@ModelAttribute ConsultOrderVO consultOrderVO, BoardVO boardVO) {

           setBoardService(request); // 게시판 유형 서비스 설정

           OpHelper.bindSearchMap(consultOrderVO, request);

           UserLoginVO userLoginVo = OpHelper.getUserSession(request);
           boardVO.setUserId(userLoginVo.getUserId());
           //언어코드 삽입
           boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));

           if(boardVO.getQ_searchKeyType() != null && boardVO.getQ_searchKeyType().contains("___")) {
               String[] search = boardVO.getQ_searchKeyType().split("___");
               boardVO.setQ_searchKey(search[0]);
               boardVO.setQ_searchType(search[1]);
           }

           Pager<ConsultOrderVO> pager = boardService.popProduct(consultOrderVO,boardVO);

           if(Validate.isNotEmpty(boardVO.getEstnColumn7())){
               model.addAttribute("PurchsNo",boardVO.getEstnColumn7());
           }
           model.addAttribute(GlobalConfig.KEY_PAGER, pager);

//           model.addAttribute(BoardConfConstant.KEY_CONF_VO, boardConfVO);
           String domainNm = CmsUtil.getHostName(request.getServerName());
           String url = getTemplateFolderName(request.getRequestURL().toString(), null, null, request);

           return url + domainNm +"/PD_product";
       }

    /**
     * 게시판 비즈매칭 선정여부
     */
    @RequestMapping(value = "ND_selectionUpdate.do", method = RequestMethod.POST)
    public String selectionUpdate(ModelMap model,  HttpServletRequest request, @ModelAttribute BoardVO boardVO,@ModelAttribute BoardCmtVO boardCmtVO) throws Exception {

        //로그인이 안되어 있으면 로그인 화면으로 가기(등록 화면시에만 적용 되도록 되어 있음)
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();

        //이메일발송 vo
        RegisterUserVO vo = new RegisterUserVO();

        if(userLoginVo == null) {
            String url = "/web/board/BD_board.view.do";

            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl = url;
            String returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd()+"&bbscttSeq="+boardVO.getBbscttSeq();
            String message = MessageHelper.getMsg(request, "requiredLogin");
            return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);
        }

        int affected = boardService.selectionUpdate(boardVO);
        BoardVO boardEmailVO = new BoardVO();
        if(affected < 1) {
            return responseJson(model,false);
        }else{
            //댓글 등록자 정보 조회
            BoardVO userVo = boardService.userBoardSelect(boardVO);

            vo.setUserNm(userVo.getUserNm());
            vo.setUserTyCd(userVo.getUserTyCd());
            vo.setEmail(userVo.getEmail());
            vo.setMbtlnum(userVo.getTelNo());

            if(boardVO.getBbsCd() == 1010 ){
                //게시판상세정보
                boardEmailVO = boardService.boardView(boardVO);

                //비즈매칭 선정후 메일발송
                boardEmailVO.setMailSection(33); // 이메일 사용 구분값
                emailCrtfcAction(request, model, boardEmailVO, vo); //이메일 전송
            }

            return responseJson(model,true);
        }
    }

     /**
      * 카테고리 팝업 메인
      */
     @RequestMapping(value = "PD_categoryPop.do")
     public String categoryPop(CategoryVO vo, ModelMap model, BoardVO boardVO,  HttpServletRequest request) {
         popService.categoryIndex(vo);
       //myboard 경로
         // 이전소스
         //String hostNm = CmsUtil.getHostName(request.getServerName());

         //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경
         //변경소스
         String hostNm = "korean";
         //}}
         String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
         return rtnUrl + "popup/PD_categoryPop";
     }

     /**
      * 카테고리 관리 목록 for treeList
      */
     @RequestMapping(value = "INC_categoryList.do")
     public String categoryList(CategoryVO vo, ModelMap model) {
         return responseJson(model, popService.categoryList(vo));
     }

     /**
      * ctgrySelect (카테고리 선택)
      * @param vo
      * @param model
      * @return
      */
     @RequestMapping(value = "ND_ctgrySelect.do", method=RequestMethod.POST)
     public String ctgrySelect(GoodsManageVO vo, ModelMap model) {
         return responseJson(model, service.ctgrySelect(vo));
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
//         registerService.mailCrtfcInsert(vo);

    	 //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
         // 추가소스
         String DomainName = GlobalConfig.DOMAIN_SUBNM;
         //}}

         String hostNm = ""; // 현재접속 서브도메인
         String rtnurl = ""; // 가입계속 시 들어오게 될 URL
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
              * 31 : 비즈매칭 요청등록
              * 32 : 비즈매칭 매칭등록
              * 33 : 비즈매칭 선정
              * 51 : Q&A질문등록
              * 52 : Q&A답변등록
              * */

             vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
              if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002) { // 한국어사이트

                 if(boardVO.getMailSection() == 31){ autoMap.put("automailId", AutoMailTemplate.KOR_BIZ_REG);
                 }else if(boardVO.getMailSection() == 32){ autoMap.put("automailId", AutoMailTemplate.KOR_BIZ_MATC);
                 }else if(boardVO.getMailSection() == 33){ autoMap.put("automailId", AutoMailTemplate.KOR_BIZ_SLCT);
                 }else if(boardVO.getMailSection() == 51){ autoMap.put("automailId", AutoMailTemplate.KOR_QNA_QREG);
                 }

             }

             // 전송할 메일 정보 입력
             autoMap.put("receiverName", vo.getUserNm()); // 수신자명
             autoMap.put("email", vo.getEmail()); // 수신이메일주소

             /*
              * 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl
              */
             HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
             hostNm = CmsUtil.getHostName(request.getServerName());
             if("".equals(hostNm) || "www".equals(hostNm)) {
                 hostNm = "korean";
             }

             // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
             oneToOneInfoMap.put("name", vo.getUserNm());

             if(boardVO.getMailSection() == 31){
                 oneToOneInfoMap.put("bizTitle", boardVO.getBbscttSj());            // 비즈매칭 제목
                 oneToOneInfoMap.put("bizEndDt", boardVO.getEstnColumn6());         // 비즈매칭 종료일
             }else if(boardVO.getMailSection() == 32){
            	 /* 이전소스
                 rtnurl = "http://" + hostNm + ".ceart.kr/" + "/web/board/BD_board.view.do?bbsCd=" + boardVO.getBbsCd() +"&domainCd="+boardVO.getDomainCd()+"&bbscttSeq="+boardVO.getBbscttSeq();*/

                 //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
                 // 변경소스
                 rtnurl = "http://" + DomainName + "/" + "/web/board/BD_board.view.do?bbsCd=" + boardVO.getBbsCd() +"&domainCd="+boardVO.getDomainCd()+"&bbscttSeq="+boardVO.getBbscttSeq();
                 //}}
                 oneToOneInfoMap.put("rtnurl", rtnurl);                             //비즈매칭 상세페이지 이동
                 oneToOneInfoMap.put("bizTitle", boardVO.getBbscttSj());            // 비즈매칭 제목
                 oneToOneInfoMap.put("bizEndDt", boardVO.getEstnColumn6());         // 비즈매칭 종료일
                 oneToOneInfoMap.put("bizContentes", boardVO.getBbscttCn());        // 비즈매칭 내용
                 oneToOneInfoMap.put("bizPhone",boardVO.getBizMatchingCttpc() );    // 비즈매칭 매칭등록자 연락처
                 oneToOneInfoMap.put("bizEmail", boardVO.getBizMatchingEmail());    // 비즈매칭 매칭등록자 이메일
                 oneToOneInfoMap.put("regId", boardVO.getRegistId());               // 비즈매칭 매칭등록자 아이디
                 oneToOneInfoMap.put("regDt", boardVO.getRegistDt());               // 비즈매칭 매칭등록 등록일
             }else if(boardVO.getMailSection() == 33){
            	 /* 이전소스
                 rtnurl = "http://" + hostNm + ".ceart.kr/" + "/web/board/BD_board.view.do?bbsCd=" + boardVO.getBbsCd() +"&domainCd="+boardVO.getDomainCd()+"&bbscttSeq="+boardVO.getBbscttSeq();*/

                 //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
                 // 변경소스
                 rtnurl = "http://" + DomainName + "/" + "/web/board/BD_board.view.do?bbsCd=" + boardVO.getBbsCd() +"&domainCd="+boardVO.getDomainCd()+"&bbscttSeq="+boardVO.getBbscttSeq();
                 //}}
                 oneToOneInfoMap.put("rtnurl",rtnurl);                              //비즈매칭 상세페이지 이동
                 oneToOneInfoMap.put("bizTitle",boardVO.getBbscttSj());             // 비즈매칭 제목
             }else if(boardVO.getMailSection() == 51){
                 //이전소스
                 //rtnurl = "http://intra.ceart.kr/login/mgr/ND_index.do";

                 //{{ BH, 2015.12.03, 도메인관리삭제로 인한 소스변경
                 // 변경소스
                 rtnurl = "http://"+GlobalConfig.DOMAIN_ADMNM+"/login/mgr/ND_index.do";
                 //}}
                 oneToOneInfoMap.put("rtnurl",rtnurl);                              // 관리자 메인(intra)이동
                 oneToOneInfoMap.put("name",boardVO.getUserNm());                      // 질문등록자 이름
                 oneToOneInfoMap.put("phone",boardVO.getTelNo());                      // 질문등록자 연락처
                 oneToOneInfoMap.put("email",boardVO.getEmail());                      // 질문등록자 이메일
                 oneToOneInfoMap.put("ctgNm",boardVO.getCtgNm());                   // 구분(부류코드)명
                 oneToOneInfoMap.put("title",boardVO.getBbscttSj());                // 문의글 제목
                 oneToOneInfoMap.put("othbcAt",boardVO.getOthbcAt());               // 문의글 공개여부
                 oneToOneInfoMap.put("contents",boardVO.getBbscttCn());             // 문의글 내용

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
             // autoMap.put("senderEmail", "발신자 이메일"); // 생략시 기본 설정값 적용 :
             // webmaster@ceart.kr
             // autoMap.put("mailTitle", "메일 제목"); // 생략시 기본 설정값 적용

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

             if(boardVO.getMailSection() == 33 || boardVO.getMailSection() == 31){//비즈매칭선정후 SMS 발송 /비즈매칭 등록후 SMS 발송
                 /** SMS발송시작 **/
                 if(vo.getMbtlnum() != null){
                     Map<String, Object> smsMap = new HashMap<String, Object>();
                     /*
                     smsMap.put("rcvNo", "수신번호");
                     smsMap.put("msg", "발신내용");      //메시지번호별 발송메시지 SmsTransHistConstant.java참고
                     smsMap.put("dutyCd", "업무코드");   //RM,CM,UM,CO...
                     */
                     //SMS발송 및 전송이력쌓기
                     SmsTransHistConstant shc = new SmsTransHistConstant();
                     //수신번호-필수
                     smsMap.put("rcvNo", vo.getMbtlnum());
                     //발신내용-필수
                     if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
                         if(boardVO.getMailSection() == 33){smsMap.put("msg", shc.getSmsMsg("233"));}
                         else if(boardVO.getMailSection() == 31){smsMap.put("msg", shc.getSmsMsg("231"));}

                     }else if(vo.getSbscrbSiteSeCd() == 3001 || vo.getSbscrbSiteSeCd() == 3002){   //영어사이트
                         if(boardVO.getMailSection() == 33){smsMap.put("msg", shc.getSmsMsg("333"));}
                         else if(boardVO.getMailSection() == 31){smsMap.put("msg", shc.getSmsMsg("331"));}

                     }else if(vo.getSbscrbSiteSeCd() == 4001 || vo.getSbscrbSiteSeCd() == 4002){   //스페인어사이트
                         if(boardVO.getMailSection() == 33){smsMap.put("msg", shc.getSmsMsg("433"));}
                         else if(boardVO.getMailSection() == 31){smsMap.put("msg", shc.getSmsMsg("431"));}
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
             }

             return result;
     }


}
