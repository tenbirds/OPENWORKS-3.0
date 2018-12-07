/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import zes.base.spring.GeneralController;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.boardconf.BoardConfService;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.login.LoginVO;

/**
 * 게시판 로그 Controller
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2012. 6. 25.     손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/boardlog")
public class BoardLogController extends GeneralController {

    @Autowired
    private BoardConfService boardConfService;
    @Autowired
    private BoardLogService boardLogService;
	@Autowired
	DomainService domainService;

    /**
     * 초기 페이지
     */
	@SuppressWarnings("rawtypes")
    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, @RequestParam(value = "domainCd", required = false) Integer domainCd, @RequestParam(value = "bbsCd", required = false) Integer bbsCd) throws Exception {

        //담당자 권한 확인
        LoginVO loginVo = IntraController.getLoginSession(request);
        if(loginVo != null) {
            HashMap authMap = getLoginAuth(loginVo);
            model.addAttribute("auth", authMap);
        }
        
        // 사이트 목록
        DomainVO domainVo = new DomainVO();
        domainVo.setUseYn("Y");
        model.addAttribute("domainList", domainService.getDomainList(domainVo));
        
        if(Validate.isNotEmpty(domainCd)){
            BoardConfVO boardConfVo = new BoardConfVO();
            boardConfVo.setDomainCd(domainCd);
            boardConfVo.setBbsCd(bbsCd);
        
//            List<BoardConfVO> boardConfList = boardConfService.boardConfList();
            //언어에 따른 게시판 목록 불러오기
            List<BoardConfVO> boardConfList = boardLogService.boardConfList(boardConfVo);
            
            if(Validate.isEmpty(bbsCd)) {
                bbsCd = BoardLogUtil.defaultBbsCd(boardConfList);
            }
            
            //게시판에 따른 분류 불러오기
            List<BoardConfVO> boardCtgNmsList = boardLogService.boardCtgNmsList(boardConfVo);
            String ctgCd="";
            if(Validate.isNotEmpty(boardCtgNmsList)) {
                ctgCd = request.getParameter("ctgCd");
            }
    
            model.addAttribute(GlobalConfig.KEY_DATA_LIST, boardConfList);
            model.addAttribute("bbsCd", bbsCd);
            model.addAttribute("ctgList", boardCtgNmsList);
            model.addAttribute("domainCd", domainCd);
            model.addAttribute("ctgCd", ctgCd);
        
        }

    }

    /**
     * 게시판 전체 통계
     */
    @RequestMapping(value = "INC_overviewLog.do")
    public ModelAndView overviewLog(ModelAndView view, @RequestParam(value = "ctgCd", required = false) Integer ctgCd,@RequestParam(value = "domainCd", required = false) Integer domainCd, @RequestParam(value = "bbsCd", required = false) Integer bbsCd) throws Exception {
        List<BoardConfVO> boardConfList = boardConfService.boardConfList();
        
        if(Validate.isEmpty(domainCd)) {
            domainCd = BoardLogUtil.defaultDomainCd(boardConfList);
        }
        if(Validate.isEmpty(bbsCd)) {
            bbsCd = BoardLogUtil.defaultBbsCd(boardConfList);
        }

        Map<String, String> dataMap = boardLogService.overviewLog(domainCd, bbsCd, ctgCd);
        view.addObject(GlobalConfig.KEY_DATA_VO, dataMap);
        
        return view;
    }

    /**
     * 게시물별 상세 통계
     */
    @RequestMapping(value = "INC_boardLog.do")
    public String boardLog(ModelMap model, @ModelAttribute BoardLogSearchVO searchVO) throws Exception {
        
        List<BoardConfVO> boardConfList = boardConfService.boardConfList();

        if(Validate.isEmpty(searchVO.getDomainCd())) {
            searchVO.setDomainCd(BoardLogUtil.defaultDomainCd(boardConfList));
        }
        if(Validate.isEmpty(searchVO.getBbsCd())) {
            searchVO.setBbsCd(BoardLogUtil.defaultBbsCd(boardConfList));
        }
        if(Validate.isEmpty(searchVO.getTypeCd())) {
            searchVO.setTypeCd(BoardLogConstant.TYPE_MONTH);
        }

        BoardLogData boardLogData = boardLogService.boardLog(searchVO);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, boardLogData);
        model.addAttribute("searchVO", searchVO);
        model.addAttribute("termCdList", BoardLogConstant.TERM_CD_LIST);

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            return "intra/boardlog/INC_boardYearLog";
        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            return "intra/boardlog/INC_boardMonthLog";
        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            return "intra/boardlog/INC_boardDayLog";
        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            return "intra/boardlog/INC_boardHourLog";
        } else {
            return "intra/boardlog/INC_boardYearLog";
        }
    }

    /**
     * 덧글별 상세 통계
     */
    @RequestMapping(value = "INC_cmtLog.do")
    public String commentLog(ModelMap model, @ModelAttribute BoardLogSearchVO searchVO) throws Exception {
        
        List<BoardConfVO> boardConfList = boardConfService.boardConfList();

        if(Validate.isEmpty(searchVO.getDomainCd())) {
            searchVO.setDomainCd(BoardLogUtil.defaultDomainCd(boardConfList));
        }
        if(Validate.isEmpty(searchVO.getBbsCd())) {
            searchVO.setBbsCd(BoardLogUtil.defaultBbsCd(boardConfList));
        }
        if(Validate.isEmpty(searchVO.getTypeCd())) {
            searchVO.setTypeCd(BoardLogConstant.TYPE_MONTH);
        }

        BoardLogData boardLogData = boardLogService.commentLog(searchVO);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, boardLogData);
        model.addAttribute("searchVO", searchVO);
        model.addAttribute("termCdList", BoardLogConstant.TERM_CD_LIST);

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            return "intra/boardlog/INC_cmtYearLog";
        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            return "intra/boardlog/INC_cmtMonthLog";
        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            return "intra/boardlog/INC_cmtDayLog";
        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            return "intra/boardlog/INC_cmtHourLog";
        } else {
            return "intra/boardlog/INC_cmtYearLog";
        }
    }

    /**
     * 파일별 상세 통계
     */
    @RequestMapping(value = "INC_fileLog.do")
    public String fileLog(ModelMap model, @ModelAttribute BoardLogSearchVO searchVO) throws Exception {
        
        List<BoardConfVO> boardConfList = boardConfService.boardConfList();

        if(Validate.isEmpty(searchVO.getDomainCd())) {
            searchVO.setDomainCd(BoardLogUtil.defaultDomainCd(boardConfList));
        }
        if(Validate.isEmpty(searchVO.getBbsCd())) {
            searchVO.setBbsCd(BoardLogUtil.defaultBbsCd(boardConfList));
        }
        if(Validate.isEmpty(searchVO.getTypeCd())) {
            searchVO.setTypeCd(BoardLogConstant.TYPE_MONTH);
        }

        BoardLogData fileDownLog = boardLogService.fileDownLog(searchVO);
        BoardLogData fileUploadLog = boardLogService.fileUploadLog(searchVO);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, fileDownLog);
        model.addAttribute("dataVo2", fileUploadLog);

        model.addAttribute("searchVO", searchVO);
        model.addAttribute("termCdList", BoardLogConstant.TERM_CD_LIST);

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            return "intra/boardlog/INC_fileYearLog";
        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            return "intra/boardlog/INC_fileMonthLog";
        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            return "intra/boardlog/INC_fileDayLog";
        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            return "intra/boardlog/INC_fileHourLog";
        } else {
            return "Iintra/boardlog/NC_fileYearLog";
        }
    }
    
    @RequestMapping(value = "ND_bbsList.do")
    public String bbsList(ModelMap model, @RequestParam(value = "domainCd", required = false) Integer domainCd) throws Exception {
       
        BoardConfVO boardConfVo = new BoardConfVO();
        boardConfVo.setDomainCd(domainCd);
        
        //언어에 따른 게시판 목록 불러오기
        List<BoardConfVO> boardConfList = boardLogService.boardConfList(boardConfVo);
        
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, boardConfList);
        model.addAttribute("domainCd", domainCd);
        model.addAttribute("bbsCd", "");
        
        return responseJson(model, boardConfList);
    }
    
    
}
