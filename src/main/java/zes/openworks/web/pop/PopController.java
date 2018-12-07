/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.pop;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.component.file.FileService;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.popup.PopupService;
import zes.openworks.intra.popup.PopupVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.intra.store.goods.GoodsSpecDescribeVO;
import zes.openworks.web.apply.ApplyManageVO;
import zes.openworks.web.apply.WebapplyService;
import zes.openworks.web.bid.BidService;
import zes.openworks.web.bidSttus.BidSttusService;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.main.MainConstant;
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.myCeart.MyCeartVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.goods.WebGoodsService;
import zes.openworks.web.store.premium.PremiumVO;
import zes.openworks.web.suplerCeart.SuplerCeartService;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;
import zes.openworks.web.userGuide.UserGuideService;
import zes.openworks.web.wish.myWish.MyWishService;
import zes.openworks.web.wish.myWish.MyWishVO;
/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 25.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/{pathLang}/pt/popup" })
public class PopController extends WebController {

    @Autowired
    private PopupService service;

    @Autowired
    private PopService popService;

    @Autowired
    CommonDutyService commonService;
    @Autowired
    FileService fileService;
    
    @Autowired
    MyWishService wishservice;
    
    @Autowired
    WebapplyService applyService;

    @Autowired
    WebGoodsService webGoodsService;

    @Autowired
    MyCeartService myCeartService;

    @Autowired
    BidService bidService;

    @Autowired
    SuplerCeartService suplerCeartService;

    /** 입찰공고 서비스 */
    @Autowired
    BidSttusService bidSttusService;

    /** 공통코드 관련 서비스 */
    @Autowired
    CodeService codeService;
    
    @Autowired
    UserGuideService userGuideService ;
    
    
    
    /** 파일 저장 경로 - 견적,공고 */
    public static final String BID_NOTIFY_PATH = "bid" + File.separator;

    /** 파일 저장 경로 - 계약서 */
    public static final String CNTRCT_FILE_PATH = "cntrct" + File.separator;

    @RequestMapping(value = "/INC_popup.do")
    public void quickMenu(HttpServletRequest request, ModelMap model,@PathVariable String pathLang) {
        //도메인별 도메인코드를 설정
        String hostNm = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = "";
        if(!"".equals(hostNm)){
            domainCd = new MainConstant().getDomainCode(hostNm);
        }else{
            domainCd = "2"; //기본 한국어로 세팅
        }

        // 팝업창
        List<PopupVO> popup = new ArrayList<PopupVO>();
        PopupVO popupVO = new PopupVO();
        popupVO.setDomainCd(new Integer(domainCd));
        popup = service.popup(popupVO);
        model.addAttribute("popup", popup);
    }

    @RequestMapping(value = "/PD_popupView.do", method = RequestMethod.GET)
    public String popupView(HttpServletRequest request, ModelMap model,
        @RequestParam(value = "seq", required = true) Integer seq,
        @RequestParam(value = "domainCd", required = true) Integer domainCd,
        @RequestParam(value = "makeType", required = true) Integer makeType,
        @RequestParam(value = "divName", required = false) String divName,
        @PathVariable String pathLang) throws Exception {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        PopupVO popupVO = new PopupVO();
        popupVO.setPopupSn(seq);
        popupVO.setDomainCd(domainCd);
        popupVO = service.popupConfView(popupVO);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, popupVO);
        if(popupVO.getPopupTyCd() == 1001) {
            return baseURL + "/PD_windowFrame";
        } else {
            return baseURL + "/PD_layerFrame";
        }
    }

    /**
     * regstCnView (신청내용 - 구매자 정보만)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_reqstCnView.do", method = RequestMethod.GET)
    public void regstCnView(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.regstCnView(vo));
    }

    @RequestMapping(value = "/ND_reqstCnUpdateAction.do", method = RequestMethod.POST)
    public String ND_reqstCnUpdateAction(HttpServletRequest request, ModelMap model, PopVO vo) {

        int affected = popService.reqstCnUpdateAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);

    }

    /**
     * regstCnView (신청내용 - 구매자 & 판매자 정보)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_purchsView.do", method = RequestMethod.GET)
    public void purchsView(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.regstCnView(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO + "2", popService.purchsView(vo));
    }

    /**
     * userView (회원정보)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_userView.do", method = RequestMethod.GET)
    public void userView(HttpServletRequest request, ModelMap model, PopVO vo ,@PathVariable String pathLang) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO,popService.userView(vo));
    }

    /**
     * 카테고리 팝업 메인
     */
    @RequestMapping(value = "/PD_categoryPop.do")
    public void categoryPop(CategoryVO vo, ModelMap model,@PathVariable String pathLang) {
        popService.categoryIndex(vo);
    }

    /**
     * 카테고리 관리 목록 for treeList
     */
    @RequestMapping(value = "/INC_categoryList.do")
    public String categoryList(CategoryVO vo, ModelMap model,@PathVariable String pathLang) {
        return responseJson(model, popService.categoryList(vo));
    }

    /**
     * orderPop (신청팝업)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_orderPop.do", method = RequestMethod.GET)
    public String orderPop(HttpServletRequest request, ModelMap model, PopVO vo, @PathVariable String pathLang) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setUserId(userLoginVo.getUserId());
            model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.orderPop(vo));
                       
            /* 이전소스
            return request.getRequestURI().substring(0, request.getRequestURI().lastIndexOf("/")) + "/PD_orderPop";*/
  
            //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경 
            // 변경소스
            return "/korean/pt/popup/PD_orderPop";
            //}}
        }
        return alertAndClose(model, MessageHelper.getMsg(request, "requiredLogin"));
    }

    /**
     * purchInsert (신청팝업)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/ND_purch.do", method = RequestMethod.GET)
    public void purchInsert(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.purchInsert(vo));
    }

    /**
     * goodsPreview (서비스미리보기)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = {"/PD_goodsPreview.do","/PD_cnsltPreview.do"})
    public String goodsPreview(HttpServletRequest request, ModelMap model, PremiumVO vo, @PathVariable String pathLang) {
        List<FileVO> uploadFile = UploadHelper.upload(request);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();
            if (inputNm.startsWith("imageFile")) {
                imageFile.add(uploadFile.get(i));
            }
        }

        vo.setImageFile(imageFile);

        PremiumVO premiumVo = popService.goodsPreview(vo);
        vo.setStoreImageFile(premiumVo.getStoreImageFile());
        vo.setCngdMarkFile(premiumVo.getCngdMarkFile());

        model.addAttribute(GlobalConfig.KEY_DATA_VO, vo);
        String subDomain = popService.subDomain(vo.getLangCode());
        String urlIndex = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1, request.getRequestURI().indexOf("."));

        return "/" + subDomain + "/pt/popup/" + urlIndex;
    }

    public String Language(HttpServletRequest request) {
        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        if (hostNm.equals("intra")) {
            hostNm = "korean";
        }
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }
    /**
     * metaPop(서비스메타코드)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_metaPop.do", method = RequestMethod.GET)
    public void metaPop(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {
        //vo.setCodeLangCode(Language(request));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.metaPop(vo));
    }
    
    /**
     * metaPop('3-4. 서비스형 소프트웨어(SCS) 관련 규격 정보'에서 '컨설팅 가능 상세 서비스' 를 '선택')
     * _userguide.getCtgryList
     *     
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_ctgryListPop.do", method = RequestMethod.GET)
    public void ctgryListPop(HttpServletRequest request, ModelMap model, @PathVariable String pathLang) throws Exception 
    {
        Map<String, Object> ctvo = new HashMap<String, Object>();
        ctvo.put("ctgryCode", "0");
        ctvo.put("langCode", "00");
        model.addAttribute(GlobalConfig.KEY_DATA_VO, userGuideService.getCtgryList(ctvo));
    }
    
    
    /**
     * freeExperience (서비스 무료체험 팝업)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_freeExperience.do", method = RequestMethod.GET)
    public void freeExperience(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {
        model.addAttribute("popDiv", request.getParameter("popDiv"));
    }
    
  
    /*구매희망목록*/    
    @RequestMapping(value = "/PD_wishOrderPop.do ", method = RequestMethod.GET)
    public void hopePurch(HttpServletRequest request, ModelMap model, MyWishVO vo,@PathVariable String pathLang) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVO.getUserId());
        if(vo.getGoodsTyCd() != null && !vo.getGoodsTyCd().equals("") &&  vo.getGoodsTyCd().length() == 4){
            
            String mode = request.getParameter("mode");
            List<MyWishVO> myWishList = wishservice.myWishList(vo);
            model.addAttribute(GlobalConfig.KEY_BASE_LIST,myWishList);
            model.addAttribute("mode", mode);
        }
    }
    
    /*서비스변경요청*/    
    @RequestMapping(value = "/PD_svcChangeRequstPop.do ", method = RequestMethod.GET)
    public void svcChangeRequst(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo,@PathVariable String pathLang) {
        
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVO.getUserId());
        
        CodeVO codeVO;
        
        //요청구분(전시:1001,비전시:1002,삭제:1003)
        codeVO = new CodeVO();
        codeVO.setGrpCd(2047);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_requstSe", codeService.codeList(codeVO));
        
        //요청구분에 따른 요청사유 조회
        codeVO = new CodeVO();
        if(vo.getRequstSe() == 1001) {
            codeVO.setGrpCd(2048);
        } else if(vo.getRequstSe() == 1002) {
            codeVO.setGrpCd(2049);
        } else {
            codeVO.setGrpCd(2050);
        }
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_requstResn", codeService.codeList(codeVO));
        
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
    }
    
    /**
     * requstResnList (요청구분별 요청사유 목록)
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "ND_requstResnList.do", method = RequestMethod.POST)
    public String ctgryList(WebGoodsManageVO vo, ModelMap model) {
        //요청구분
        CodeVO codeVO = new CodeVO();
        if(vo.getRequstSe() == 1001) {
            codeVO.setGrpCd(2048);
        } else if(vo.getRequstSe() == 1002) {
            codeVO.setGrpCd(2049);
        } else {
            codeVO.setGrpCd(2050);
        }
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        return responseJson(model, codeService.codeList(codeVO));
    }
    
    
    /*공급자씨앗 답변 관리*/    
    @RequestMapping(value = "/PD_applyPop.do ", method = RequestMethod.GET)
    public void applyPop(HttpServletRequest request, ModelMap model, ApplyManageVO vo,@PathVariable String pathLang) {
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        OpHelper.bindSearchMap(vo, request);
        vo.setNotifyNum(vo.getNoifyNum());
        vo.setNotifySeq(vo.getNoifySeq());
        vo.setUserId(userLoginVO.getUserId());
        model.addAttribute("applyPopUp", applyService.applyPopUp(vo));
    }
    
    /*서비스규격*/    
    @RequestMapping(value = "/PD_goodsSpecPop.do ", method = RequestMethod.GET)
    public String GoodsSpecDescribe(HttpServletRequest request, ModelMap model, GoodsSpecDescribeVO vo,@PathVariable String pathLang) 
    {
        if (!Validate.isEmpty( vo.getGoodsCode() ))
        {          
            //vo.setGoodsCode("201701655"); ///////////////////////////////////////임시..... 2018.06.26
            vo = webGoodsService.goodsSpecDescribeInfo(vo); 
            model.addAttribute("specVo", vo);
            
            
            String strCsap = vo.getKisaCrtfcAt();
            if(vo.getKisaCrtfcAt() == null){
                model.addAttribute("strCsapVo", "NO");
            } else {
                model.addAttribute("strCsapVo", "YES");
            }
            
            
            
        }
        
        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;
        
        return baseURL + "/PD_goodsSpecPop_v2";
    }
    /*
    public void GoodsSpec(HttpServletRequest request, ModelMap model, GoodsSpecVO vo,@PathVariable String pathLang) {
     
        if(vo.getGoodsCode() != null && !vo.getGoodsCode().equals("") ){
            vo = webGoodsService.goodsSpecInfo(vo); 
            model.addAttribute("specVo", vo); 
        }
    }
    */

    /*계약대상 선정 팝업*/    
    @RequestMapping(value = "/PD_contractChoicePop.do", method = RequestMethod.GET)
    public void contractChoice(HttpServletRequest request, ModelMap model, MyCeartVO vo, @PathVariable String pathLang) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVO.getUserId());

        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        
        
        if(vo.getNotifyNum() != null && !vo.getNotifyNum().equals("") &&  vo.getNotifySeq() != 0  ){            
            // 공고/견적 상세 조회
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, myCeartService.buyingRequestInfo(vo));
            model.addAttribute(GlobalConfig.KEY_DATA_LIST, myCeartService.buyingRequestDetailList(vo));
        }
    }

    /*
     * 상세정보(견적) 계약대상 선정
     * */
    @RequestMapping(value = "/ND_contractChoice.do", method = RequestMethod.POST)
    public String contractChoice(ModelMap model, HttpServletRequest request, MyCeartVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_buyingRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> evalSheetFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("evalSheetFile")) {
                evalSheetFile.add(uploadFile.get(i));
            }
        }
        vo.setEvalSheetFileList(evalSheetFile);

        // 입찰공고 공급자 정보 저장용 바인딩
        OpHelper.bindSearchMap(vo, request);
        
        int confirmCnt = myCeartService.updateContractChoice(vo);

        if(confirmCnt <= 0){
            return confirmAndRedirectPopup(model, "계약대상 선정에 실패 하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
        }
        
        return confirmAndRedirectPopup(model, "계약대상을 선정 하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }

    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    /*계약대상 평가서 팝업*/    
    @RequestMapping(value = "/PD_contractChoiceReportPop.do", method = RequestMethod.GET)
    public void contractChoiceReport(HttpServletRequest request, ModelMap model, MyCeartVO vo, @PathVariable String pathLang) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVO.getUserId());

        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        
        // 평가서가 등록된 내역만 조회
        vo.setBidPgesStat("1006");
        vo.setBidSussGbn("Y");
        
        if(vo.getNotifyNum() != null && !vo.getNotifyNum().equals("") &&  vo.getNotifySeq() != 0  ){            
            // 공고/견적 상세 조회
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, myCeartService.buyingRequestChoiceReport(vo));
        }
    }

    /**
     * categoryUserPop( 비즈매칭 전문가선택 POP)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/PD_categoryUserPop.do", method = RequestMethod.GET)
    //public void metaPop(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {
    public void categoryUserPop(HttpServletRequest request, ModelMap model, PopVO vo,@PathVariable String pathLang) {
        //vo.setCodeLangCode(Language(request));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.categoryUserPop(vo));
    }

    /**
     * 
     * PD_cntrctCmplPop (계약체결 완료처리 팝업 호출)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_cntrctCmplPop.do", method = RequestMethod.GET)
    public void PD_cntrctCmplPop(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo, @PathVariable String pathLang) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        String suplerId = request.getParameter("suplerId");
        
        if(!suplerId.equals(null) && !suplerId.equals("null")){
            vo.setSuplerId(suplerId);
            model.addAttribute("TypeCheck", true);
        }else{
            vo.setSuplerId(userLoginVO.getUserId());
            model.addAttribute("TypeCheck", false);
        }
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        
        if(vo.getNotifyNum() != null && !vo.getNotifyNum().equals("") &&  vo.getNotifySeq() != 0  )
        {
            List<SuplerCntrctVO> suplerCntrctVO = suplerCeartService.contractCompleteInfo(vo);
            
            if (suplerCntrctVO.size() > 0)
            {
                // 계약체결 완료처리 데이터 조회
                model.addAttribute(GlobalConfig.KEY_BASE_LIST, suplerCntrctVO.get(0));
            }            
        }
    }

    /**
     * ND_cntrctCmplAction (계약체결 완료처리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_cntrctCmplAction.do", method = RequestMethod.POST)
    public String ND_cntrctCmplAction(ModelMap model, HttpServletRequest request, SuplerCntrctVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_buyingRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, CNTRCT_FILE_PATH);
        List<FileVO> ctrtcSn = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("ctrtcSn")) {
                ctrtcSn.add(uploadFile.get(i));
            }
        }
        vo.setCtrtcSnList(ctrtcSn);

        // 계약관리정보 저장용 바인딩
        OpHelper.bindSearchMap(vo, request);
        
        int confirmCnt = 0;
        String rtnMsg = "";
        if(vo.getCntrctSn()!=0){
            confirmCnt = suplerCeartService.updateCntrctCmplAction(vo);
            rtnMsg = "계약변경";
        }else{
            confirmCnt = suplerCeartService.insertCntrctCmplAction(vo);
            rtnMsg = "계약체결 완료처리";
        }

        // 입찰종류여부
        String bidGbnCd = vo.getBidGbnCd();
        String rtnUrl = "";
        if(bidGbnCd.equals("1001")){
            rtnUrl = "/korean/pt/suplerCeart/BD_bidPartcptnList.do";
        }if(bidGbnCd.equals("1002")){
            rtnUrl = "/korean/pt/suplerCeart/BD_buyingRequestList.do";
        }
        
        if(confirmCnt <= 0){
            return confirmAndRedirectPopup(model, rtnMsg + "에 실패 하였습니다.", rtnUrl);
        }
        
        return confirmAndRedirectPopup(model, rtnMsg + "에 성공 하였습니다.", rtnUrl);
    }

    /**
     * 
     * PD_suplerServicePop (공급자의 제품군 서비스 찾기 팝업)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_suplerServicePop.do", method = RequestMethod.GET)
    public void PD_suplerServicePop(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setSuplerId(userLoginVO.getUserId());
        vo.setGoodKndCd(request.getParameter("goodKndCd"));
        
        if(vo.getSuplerId() != null && !vo.getSuplerId().equals("") &&  vo.getGoodKndCd() != null && !vo.getGoodKndCd().equals("") ){
            // 해당 로그인 공급자의 서비스구분에 대한 서비스목록 조회
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, bidSttusService.suplerServiceList(vo));
        }
    }

    /**
     * 
     * PD_wholeServicePop (씨앗 전체 서비스 찾기 팝업)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_wholeServicePop.do")
    public void PD_wholeServicePop(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {

        OpHelper.bindSearchMap(vo, request, 5);// 팝업 이므로 한 페이지에 5개의 서비스만 표기
        vo.setLangCode(Language(request));
        
        /*공통코드 설정 - 서비스구분*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1005);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_goodKndCd", codeService.codeList(codeVO));

        // 씨앗 전체 서비스 찾기 팝업
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.wholeServiceList(vo));
        
        // 조회조건 반환
        model.addAttribute("idx",      request.getParameter("idx"));
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        
    }
    
    /**
     * 
     * PD_wholeServicePop (자신의 서비스 찾기 팝업)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_myServicePop.do")
    public void PD_myServicePop(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {

        OpHelper.bindSearchMap(vo, request, 5);// 팝업 이므로 한 페이지에 5개의 서비스만 표기
        vo.setLangCode(Language(request));
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(!Validate.isEmpty(userLoginVO)) {
            vo.setSuplerId(userLoginVO.getMasterId());
        }
        
        //vo.setSuplerId(request.getParameter("userId"));
        
        /*공통코드 설정 - 서비스구분*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1005);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_goodKndCd", codeService.codeList(codeVO));

        // 씨앗 전체 서비스 찾기 팝업
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.wholeServiceList(vo));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        model.addAttribute("idx",           request.getParameter("idx"));
        
    }

    /**
     * 
     * PD_wholeServicePop (자신의 서비스 찾기 팝업)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_myServicePop2.do")
    public void PD_myServicePop2(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {

        OpHelper.bindSearchMap(vo, request, 5);// 팝업 이므로 한 페이지에 5개의 서비스만 표기
        vo.setLangCode(Language(request));
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(!Validate.isEmpty(userLoginVO)) {
            vo.setSuplerId(userLoginVO.getMasterId());
        }
        
        //vo.setSuplerId(request.getParameter("userId"));
        
        /*공통코드 설정 - 서비스구분*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1005);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        //model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_goodKndCd", codeService.codeList(codeVO));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_goodKndCd", codeService.codeList2(codeVO));        


        
        // 씨앗 전체 서비스 찾기 팝업
            model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.wholeServiceList2(vo));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        model.addAttribute("idx",           request.getParameter("idx"));

        model.addAttribute("goodsCode", vo.getGoodsCode());
        model.addAttribute("goodsNm", vo.getGoodsNm());
        model.addAttribute("suplerId", vo.getSuplerId()); 
        model.addAttribute("imme", vo.getImmeGubun());        

        
    }
    @RequestMapping(value = "/PD_immeServiceRegistPop.do")
    public void PD_immeServiceRegistPop(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {

        OpHelper.bindSearchMap(vo, request, 5);// 팝업 이므로 한 페이지에 5개의 서비스만 표기
        vo.setLangCode(Language(request));
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(!Validate.isEmpty(userLoginVO)) {
            vo.setSuplerId(userLoginVO.getMasterId());
        }
        
    }

    /**
     * 
     * PD_UserSeachPop (구매자검색 팝업)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_BuyUserSearchPop.do") 
    public void PD_BuyUserSearchPop(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {

        OpHelper.bindSearchMap(vo, request, 5);// 팝업 이므로 한 페이지에 5개의 서비스만 표기
        vo.setLangCode(Language(request));
        
       
        // 구매자 찾기 팝업 -- 쿼리 18초 걸림 3001번 회사명 가져오는 테이블 데이터가 12만건정도 (조회조건 입력으로 우선 변경처리)
        if(vo.getSearchKeyWord() != null && !vo.getSearchKeyWord().equals("")){
            model.addAttribute(GlobalConfig.KEY_PAGER, suplerCeartService.buyUserList(vo));
        }
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

    }
        
    
    /**
     * 
     * wishGoodsPop 상품 비교 팝업(이용희망목록 팝업)
     * @param request
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "PD_wishGoodsPop.do")
    public String wishGoodsPop(HttpServletRequest request, CategoryVO vo, ModelMap model) 
    {
        String goodsCds   = request.getParameter("goodsCds"); // goodsCd 의 리스트
        String notifyNums = request.getParameter("notifyNums"); 
        String notifySeqs = request.getParameter("notifySeqs"); 
        String grpSeq     = request.getParameter("grpSeq");
        String userId     = "";//userLoginVO.getUserId();
        int chkGoodsCnt   = 0; // 선택한 상품의 갯수
        
        String[] arrGoodCd    = goodsCds.split(",");
        String[] arrNotifyNum = notifyNums.split(",");
        String[] arrNotifySeq = notifySeqs.split(",");
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        //List ceartBdGoodsCompList = null;
        
        if (Validate.isEmpty(userLoginVO))
        {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl, "parent");
        }
        else
        {
            userId = userLoginVO.getUserId();
        }

        if (Validate.isEmpty(request.getParameter("checkCnt")))
        {
            chkGoodsCnt = 0;
        }
        else
        {
            chkGoodsCnt = Integer.parseInt(request.getParameter("checkCnt")); // 선택한 상품의 갯수
        }
        
        String goodsTyCd = request.getParameter("goodsTyCd") ;
        
        HashMap<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("userId",     userId);
        dataMap.put("grpSeq",     grpSeq);
        dataMap.put("goodsCds",   goodsCds);
        
        dataMap.put("notifyNums", notifyNums);
        dataMap.put("notifySeqs", notifySeqs);        
        dataMap.put("goodsTyCd",  goodsTyCd);
        
        List<HashMap<String, Object>> bgGoodsList = popService.ceartWishGoodsCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap); // 서비스 사항비교 (1탭)
        
        List<HashMap<String, Object>> estimateList = null ; 

        // 견적서비교 (2탭)
        if  ("1001".equals(goodsTyCd)) { estimateList = popService.estimatePaasCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap); } // Paas
        if  ("1002".equals(goodsTyCd)) { estimateList = popService.estimateSaasCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap); } // Saas        
        if  ("1003".equals(goodsTyCd)) { estimateList = popService.estimateIaasCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap); } // Iaas

        model.addAttribute("estimateCnt",  estimateList.size());  // 선택한 상품중 견적서가 있는 상품수
        
        model.addAttribute("bgGoodsCnt",   chkGoodsCnt);  // 선택한 상품의 수
        model.addAttribute("bgGoodsList" , bgGoodsList);  // 서비스 사항비교 (1탭)
        model.addAttribute("estimateList", estimateList); // 견적서비교 (2탭) 
        model.addAttribute("goodsTyCd",    request.getParameter("goodsTyCd")); // 상품타입
        
        //return responseJson(model, bgGoodsList);
        return "/korean/pt/popup/PD_wishGoodsPop";
    }
    
    /**
     * 
     * bdGoodsPop 상품 비교 팝업
     * @param request
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "PD_dbGoodsPop.do")
    public String bdGoodsPop(HttpServletRequest request, CategoryVO vo, ModelMap model) {
        String reqItem = request.getParameter("items");//getParameterMap("items");
        String reqSessionId = request.getParameter("si");
        String userId = "";//userLoginVO.getUserId();
        int checkCnt = 0;
        
        HashMap<String, String> dataMap = new HashMap<String, String>();
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        //List ceartBdGoodsCompList = null;
        
        if(Validate.isEmpty(userLoginVO)) {
            userId = reqSessionId;
        }else {
            userId = userLoginVO.getUserId();
        }

        if(Validate.isEmpty(request.getParameter("checkCnt"))) {
            checkCnt = 0;
        }else {
            checkCnt = Integer.parseInt(request.getParameter("checkCnt"));
        }

        dataMap.put("item", reqItem);
        dataMap.put("userId", userId);
        dataMap.put("reqSessionId", reqSessionId);
        
        List<HashMap<String, Object>> bgGoodsList = popService.ceartBdGoodsCompList(dataMap);
        
        model.addAttribute("bgGoodsCnt", checkCnt);
        model.addAttribute("bgGoodsList", bgGoodsList);
        //return responseJson(model, bgGoodsList);
        return "/korean/pt/popup/PD_dbGoodsPop";
    }
    
    @RequestMapping(value = "PD_organSearchList.do")
    public void organSearchList(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        OpHelper.bindSearchMap(vo, request); // param to vo
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
       /* if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
        }*/
        
        //전체기관명 검색
        if(vo.getDataMap().get("q_searchKey") !=null && !vo.getDataMap().get("q_searchKey") .equals("")){
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, popService.searchOrganList(vo));
        }
        
       //실제이용실적이력조회 
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, popService.realUserOrganList(vo));
        model.addAttribute("cntrctSn", vo.getCntrctSn());
    }
    @RequestMapping(value = "PD_organSearchList2.do")
    public void organSearchList2(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        OpHelper.bindSearchMap(vo, request); // param to vo
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
       /* if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
        }*/
        
        //전체기관명 검색
        if(vo.getDataMap().get("q_searchKey") !=null && !vo.getDataMap().get("q_searchKey") .equals("")){
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, popService.searchOrganList(vo));
        }
        
       //실제이용실적이력조회 
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, popService.realUserOrganList(vo));
        model.addAttribute("cntrctSn", vo.getCntrctSn());
    }
    
    @RequestMapping(value = "BD_RealOrganInsert.do")
    public String BD_RealOrganInsert(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        int result =popService.realUserOrganInsert(vo);
        if(result > 0 )
            return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
        else 
            return responseJson(model, Boolean.FALSE, Messages.COMMON_DELETE_OK);
    }

    @RequestMapping(value = "BD_RealOrganInsert2.do")
    public String BD_RealOrganInsert2(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
//        if(Validate.isEmpty(userLoginVO)) {
//            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
//            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
//        }
        
        int result =popService.realUserOrganInsert(vo);
        if(result > 0 )
            return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
        else 
            return responseJson(model, Boolean.FALSE, Messages.COMMON_DELETE_OK);
    }

    @RequestMapping(value = "BD_RealOrganDelete.do")
    public String BD_RealOrganDelete(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        int result = popService.realUserOrganDelete(vo);
        if(result > 0 )
            return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
        else 
            return responseJson(model, Boolean.FALSE, Messages.COMMON_DELETE_OK);
    }
    @RequestMapping(value = "BD_RealOrganDelete2.do")
    public String BD_RealOrganDelete2(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        int result = popService.realUserOrganDelete(vo);
        if(result > 0 )
            return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
        else 
            return responseJson(model, Boolean.FALSE, Messages.COMMON_DELETE_OK);
    }
    
    

}
