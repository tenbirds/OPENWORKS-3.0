/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myboard;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.loginCheck.LoginCheckReturn;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.login.UserLoginVO;

/**
 * 나의 게시글 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일              수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 23.    홍길동       JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/myboard")
public class MyboardController extends WebController {

    @Autowired
    private MyboardService myboardService;
    
    /**
     *  나의 게시글 목록
     * @return 
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public String index(BoardVO boardVO, HttpServletRequest request, ModelMap model) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        
        // 접속 사용자 도메인  값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        boardVO.setDomainCd(Integer.parseInt(domainCode));
        
        if(userLoginVo != null) {
            boardVO.setUserKey(userLoginVo.getUserKey());
        }else{
            String url2 = rtnUrl +"myboard/BD_index.do";
            
            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl = url2;
            String returnParam = "domainCd="+boardVO.getDomainCd();
            
            String message = MessageHelper.getMsg(request, "requiredLogin");
             return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);            
        }
        
        OpHelper.bindSearchMap(boardVO, request);

        //날짜 설정 없으면 디폴트 현재 날짜(마이페이지 메뉴들) 
        if(request.getParameter("section") != "" && request.getParameter("section") != null ){
            if(request.getParameter("q_init") == "" || request.getParameter("q_init") == "1" || request.getParameter("q_init") == null){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar c1 = Calendar.getInstance();
                Calendar c2 = Calendar.getInstance();
                c1.add(Calendar.MONTH, -1);
                
                boardVO.setQ_startDt(sdf.format(c1.getTime()));   
                boardVO.setQ_endDt(sdf.format(c2.getTime()));
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
        
        
        // 게시판 목록
        model.addAttribute("boardList", myboardService.totalboardList(boardVO)); // 게시판명 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, myboardService.myboardList(boardVO)); 
        
        return rtnUrl +"myboard/BD_index";
    }
    
    /**
     * 나의 게시글 목록 선택 삭제
     * 
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_board.delete.do", method = RequestMethod.POST)
    public String myBoardListDelete(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        OpHelper.bindSearchMap(boardVO, request);

        int result = myboardService.myBoardListDelete(boardVO);
        if(result <= StringUtil.ZERO) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }

        String url = "BD_index.do";
        return alertAndRedirect(model, MessageHelper.getMsg(request, "deleteOk"), url);
    }

    
    /**
     *  비즈매칭 내역
     * @return 
     */
    @RequestMapping(value = "BD_bizMatchIndex.do", method = RequestMethod.GET)
    public String bizMatchIndex(BoardVO boardVO, HttpServletRequest request, ModelMap model) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        
        // 접속 사용자 도메인  값 불러와서 가져오기
        // 이전소스
        //String hostNm = CmsUtil.getHostName(request.getServerName());
        
        //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경 
        //변경소스
        String hostNm = "korean";
        //}}
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        boardVO.setDomainCd(Integer.parseInt(domainCode));
        
        if(userLoginVo != null) {
            boardVO.setUserKey(userLoginVo.getUserKey());
        }else{
            String url2 = rtnUrl +"myboard/BD_index.do";
            
            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl = url2;
            String returnParam = "domainCd="+boardVO.getDomainCd();
            
            String message = MessageHelper.getMsg(request, "requiredLogin");
             return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);            
        }
        
        OpHelper.bindSearchMap(boardVO, request);

        
      //날짜 설정 없으면 디폴트 현재 날짜(마이페이지 메뉴들) 
        if(request.getParameter("section") != "" && request.getParameter("section") != null ){
            
            if(request.getParameter("q_init") == "" || request.getParameter("q_init") == "1" || request.getParameter("q_init") == null){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar c1 = Calendar.getInstance();
                Calendar c2 = Calendar.getInstance();
                c1.add(Calendar.MONTH, +1);
                if("myboardB".equals(request.getParameter("section"))){//비즈매칭내역
                    sdf.format(c1.getTime()).replaceAll("-","");
                    
                    boardVO.setQ_bizStartDt(sdf.format(c2.getTime()));   
                    boardVO.setQ_bizEndDt(sdf.format(c1.getTime()));
                }
            }
        }
        
        // 날짜 검색값 포맷
        if(Validate.isNotEmpty(boardVO.getQ_bizStartDt())) {
            String startDt = boardVO.getQ_bizStartDt();
            startDt = StringUtil.remove(startDt, "-");
            
            boardVO.setQ_bizStartDt(startDt + "000000");
        }
        if(Validate.isNotEmpty(boardVO.getQ_bizEndDt())) {
            String endDt = boardVO.getQ_bizEndDt();
            endDt = StringUtil.remove(endDt, "-");
            boardVO.setQ_bizEndDt(endDt + "232359");
        }
        
     // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        //(1006_제목+내용, 1002_제목,내용, 댓글내용, 1007_댓글작성자 , 1008_작성자
        if(Validate.isNotEmpty(boardVO.getQ_searchKeyType())) {
            if(boardVO.getQ_searchKeyType().equals("CMT_REG_ID_REG_NM")) {
                boardVO.setQ_searchType("1007");
            }else if(boardVO.getQ_searchKeyType().equals("CONTENTS_TITLE")) {
                boardVO.setQ_searchType("1006");
            }else if(boardVO.getQ_searchKeyType().equals("REG_ID_REG_NM")) {
                boardVO.setQ_searchType("1008");
            }else if(boardVO.getQ_searchKeyType().equals("BBSCTT_SJ_BBSCTT_CN")) {
                boardVO.setQ_searchType("1006");
            }
            if(boardVO.getQ_searchKeyType().contains("___")) {
                String[] search = boardVO.getQ_searchKeyType().split("___");
                boardVO.setQ_searchKey(search[0]);
                boardVO.setQ_searchType(search[1]);
            }
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, myboardService.myboardList(boardVO));
        
        return rtnUrl +"myboard/BD_bizMatchIndex";
    }
    
    /**
     *  조직관리 내역
     *  @param  2016.11.16
     *  @param  수정자 김남덕
     *  @param  DB Table 변경 중
     *  @return 조직관리 게시판 List
     */
    @RequestMapping(value = "BD_orgmanagIndex.do", method = RequestMethod.GET)
    public String orgmanagIndex(BoardVO boardVO, HttpServletRequest request, ModelMap model) {
    
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        
        String hostNm = "korean";
        //}}
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        boardVO.setDomainCd(Integer.parseInt(domainCode));
        
        if(userLoginVo != null) {
            boardVO.setUserKey(userLoginVo.getUserKey());
        }else{
            String url2 = rtnUrl +"myboard/BD_index.do";
            
            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl = url2;
            String returnParam = "domainCd="+boardVO.getDomainCd();
            
            String message = MessageHelper.getMsg(request, "requiredLogin");
             return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);            
        }
        
        OpHelper.bindSearchMap(boardVO, request);
        
     // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
        //(1006_제목+내용, 1002_제목,내용, 댓글내용, 1007_댓글작성자 , 1008_작성자
        if(Validate.isNotEmpty(boardVO.getQ_searchKeyType())) {
            if(boardVO.getQ_searchKeyType().equals("CMT_REG_ID_REG_NM")) {
                boardVO.setQ_searchType("1007");
            }else if(boardVO.getQ_searchKeyType().equals("CONTENTS_TITLE")) {
                boardVO.setQ_searchType("1006");
            }else if(boardVO.getQ_searchKeyType().equals("REG_ID_REG_NM")) {
                boardVO.setQ_searchType("1008");
            }else if(boardVO.getQ_searchKeyType().equals("BBSCTT_SJ_BBSCTT_CN")) {
                boardVO.setQ_searchType("1006");
            }
            if(boardVO.getQ_searchKeyType().contains("___")) {
                String[] search = boardVO.getQ_searchKeyType().split("___");
                boardVO.setQ_searchKey(search[0]);
                boardVO.setQ_searchType(search[1]);
            }
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, myboardService.myboardList(boardVO));
        
        return rtnUrl +"myboard/BD_orgmanagIndex";
    }
    
}
