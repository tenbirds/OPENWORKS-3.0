package zes.openworks.web.sale.bizMatching;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.loginCheck.LoginCheckReturn;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.common.controller.WebController;


@Controller
@RequestMapping(value = "/**/sale/bizMatching")
public class WebBizMatchingController extends GeneralController {

    @Autowired
    WebBizMatchingService bizService;
    
    @Autowired
    private CommonDutyService commonDutyService;
    
    @Autowired
    private PopService popService;
    
    /**
     * 비즈매칭 내역 index페이지
     * @param request
     * @param model
     * @param vo
     * @return 
     */
    @RequestMapping(value = "BD_index.do")
    public String goodsList(HttpServletRequest request, ModelMap model, BoardVO boardVO) {
        
        int rpp = 20;
        if(Validate.isNotEmpty(boardVO.getQ_rowPerPage())) {
            rpp = boardVO.getQ_rowPerPage();
        }
        
        OpHelper.bindSearchMap(boardVO, request, rpp);
        
      //로그인이 안되어 있으면 로그인 화면으로 가기(등록 화면시에만 적용 되도록 되어 있음)
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
     // 접속 사용자 도메인  값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
        
        if(userLoginVo != null) {
        }else{
            String url2 = rtnUrl+"sale/bizMatching/BD_index.do";
            
            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl = url2;
            String returnParam = "bbsCd="+boardVO.getBbsCd()+"&domainCd="+boardVO.getDomainCd();
            
            String message = MessageHelper.getMsg(request, "requiredLogin");
             return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);            
        }
        
        // 판매하기 권한 체크 20170111
        if(!userLoginVo.getUserTyCd().toString().endsWith("02")) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
            //return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");          
        }   
        
        
     // 게시판 항목설정에 따른 검색 대상 및 검색 유형 설정
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
        
        if(userLoginVo != null) {
            boardVO.setUserKey(userLoginVo.getUserId());
        }
        //언어코드 삽입
        boardVO.setLangCode(commonDutyService.getLangCd(boardVO.getDomainCd()));
        
        //비즈매칭 신규등록내역 조회
        List<BoardVO> newBizBoardList = bizService.newBizBoardList(boardVO);
        model.addAttribute("newboardList", newBizBoardList);

        // 비즈매칭 알림설정 목록 조회 
        List<BoardVO> categoryList = bizService.categoryList(boardVO);
        model.addAttribute("categoryList",categoryList);
        
        
        // 나의비즈매칭 활동내역 조회
        Pager<BoardVO> pager = bizService.myBizBoardList(boardVO);
        model.addAttribute(GlobalConfig.KEY_PAGER, pager);
        
        return rtnUrl+"sale/bizMatching/BD_index";
        
    }
    /**
     * 카테고리 팝업 메인
     */
    @RequestMapping(value = "PD_categoryPop.do")
    public String categoryPop(CategoryVO vo, ModelMap model, BoardVO boardVO,  HttpServletRequest request) {
        popService.categoryIndex(vo);
      //myboard 경로
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
        return rtnUrl + "popup/PD_categoryPop";
    }  
    
    /**
     * 카테고리 관리 목록 for treeList
     */    
    @RequestMapping(value = "INC_categoryList.do")
    public String categoryList(CategoryVO vo, ModelMap model,HttpServletRequest request) {    
     // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCd(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        return responseJson(model, popService.categoryList(vo));
    }
    
    /**
     * ctgryInsert
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "ND_ctgryInsert.do", method=RequestMethod.POST )
    public String ctgryInsert(BoardVO boardVO, ModelMap model ,HttpServletRequest request) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        boardVO.setUserId(userLoginVo.getUserId());
        
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        boardVO.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        boolean result =  bizService.categoryInsert(boardVO);
        
        String message = "";
        if(result == true){
            message = MessageHelper.getMsg(request, "insertOk");
            return responseJson(model, true ,message); 
        }else{
            message = MessageHelper.getMsg(request, "validateFail");
            return responseJson(model, false , message); 
        }
    }
    
    

}
