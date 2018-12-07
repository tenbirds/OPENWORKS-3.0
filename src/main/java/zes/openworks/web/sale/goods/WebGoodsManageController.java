package zes.openworks.web.sale.goods;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.advertisement.AdvrtsVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeCtgVO;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.intra.store.goods.GoodsManageExcelVO;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.intra.store.goods.GoodsSpecDescribeVO;
import zes.openworks.intra.store.goods.GoodsSpecVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.dmandExamin.DmandExaminVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.register.RegisterUserVO;

@Controller
@RequestMapping(value = "/**/pt/sale/goods")
public class WebGoodsManageController extends WebController {

    @Autowired
    WebGoodsService service;
    @Autowired
    PopService popService;
    @Autowired
    CodeService codeService;
    @Autowired
    private CommonDutyService commonDutyService;
    @Autowired
    private AutoMailService amservice;
    @Autowired
    GoodsManageService gmservice;
    @Autowired
    private RegisterService registerService;

    public static final String DMANDEXAMIN_EXCEL = "goodsSpec" + File.separator;
    
    /** 파일 저장 경로 */
    public static final String GOODS_IMG_STORE = "goods" + File.separator;

    /**
     * 전체서비스목록
     * GoodsList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_goodsList.do")
    public String goodsList(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo ) {

        // 이전소스
        //String hostNm = CmsUtil.getHostName(request.getServerName());
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          vo.setRegistId(userLoginVO.getUserId());
          vo.setUserId(userLoginVO.getMasterId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }
        
        List<WebGoodsManageVO> storeLangList = service.storeLangList(vo);
        if(storeLangList.size() < 1)
            return alertAndRedirect(model, "상품상점이 활성화 되지 않았습니다. 협약서 연장(재)신청하여 승인 확인하시기 바랍니다. ", "/korean/pt/sale/BD_index.do");
      
        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);
        vo.setLangCode("00");
        //vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        vo.getDataMap().put("q_userId", userLoginVO.getMasterId());

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));
        //언어
        //model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

        //노출
        CodeCtgVO codeCtgVO = new CodeCtgVO();
        codeCtgVO.setGrpCd(1008);
        codeCtgVO.setCtgCd("DSPYN");
        codeCtgVO.setLangCode(vo.getLangCode());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_expsr", codeService.prvNmForCtgCd(codeCtgVO));

        //인증
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1011);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_crtfc", codeService.codeList(codeVO));

        return baseURL + "/BD_goodsList";
    }

    /**
     * 대기목록
     * waitingList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_waitingList.do")
    public String goodsExmntList(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        //언어 적용 Url
        // 이전소스
        //String hostNm = CmsUtil.getHostName(request.getServerName());
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_waitingList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }
        
        vo.setUserId(userLoginVO.getMasterId());
        List<WebGoodsManageVO> storeLangList = service.storeLangList(vo);
        if(storeLangList.size() < 1)
            return alertAndRedirect(model, "상품상점이 활성화 되지 않았습니다. 협약서 연장(재)신청하여 승인 확인하시기 바랍니다. ", "/korean/pt/sale/BD_index.do");
       
        
        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);
        //vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        vo.getDataMap().put("q_userId", userLoginVO.getMasterId());

        //상태검색조건이 없는경우
        if( vo.getQ_goodsRegistSttuses() == null ){
            Integer[] goodsRegistSttus;
            goodsRegistSttus = new Integer[] {1001,1002,1003,1004,1005,1008,1009,1010}; // 임시저장,검토대기,검토반려,승인대기,승인반려,재수정,재수정반려
            vo.getDataMap().put("goodsRegistSttus", goodsRegistSttus);
        }else{
            vo.getDataMap().put("goodsRegistSttus",vo.getQ_goodsRegistSttuses() );
        }

        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        vo.setInUpaGubun("OK");
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsExmntList(vo));

        //언어
        //model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

        //상태
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_sttus", service.sttusList(vo));

        //인증
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1011);
        codeVO.setLangCode(vo.getLangCode());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_crtfc", codeService.codeList(codeVO));

        return baseURL + "/BD_waitingList";

    }

    /**
     * 삭제서비스 목록
     * GoodsDeleteList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_deleteList.do")
    public String goodsDeleteList(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_deleteList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);
        vo.getDataMap().put("q_userId", userLoginVO.getMasterId());

        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsDeleteList(vo));

        //언어
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

        //인증
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1011);
        codeVO.setLangCode(vo.getLangCode());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_crtfc", codeService.codeList(codeVO));

        return baseURL + "/BD_deleteList";

    }

    @RequestMapping(value = "ND_dspyUpdateAction.do", method = RequestMethod.POST)
    public String dspyUpdateAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUpdtId(userLoginVo.getUserId());

        int affected = service.dspyUpdate(vo, request);
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }
        if(affected != StringUtil.ZERO) {
            return responseJson(model, true);
        }
        return responseText(model, false);
    }
    
  

    /**
     * ctgryList (카테고리 목록)
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "ND_ctgryList.do", method = RequestMethod.POST)
    public String ctgryList(WebGoodsManageVO vo, ModelMap model) {

        return responseJson(model, service.ctgryList(vo));
    }

    /**
     * 서비스 상세조회
     * @return
     */
    @RequestMapping(value = {"BD_goodsView.do", "BD_waitingView.do"})
    public String goodsView(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

      //언어 적용 Url
        // 이전소스
        //String hostNm = CmsUtil.getHostName(request.getServerName());
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }
        
        vo.setUserId(userLoginVO.getMasterId());
        List<WebGoodsManageVO> storeLangList = service.storeLangList(vo);
        if(storeLangList.size() < 1)
            return alertAndRedirect(model, "상품상점이 활성화 되지 않았습니다. 협약서 연장(재)신청하여 승인 확인하시기 바랍니다. ", "/korean/pt/sale/BD_index.do");

        vo.setUpdtId(userLoginVO.getUserId());
        OpHelper.bindSearchMap(vo, request);

        String domainLangCode = commonDutyService.getLangCd(Integer.parseInt(new CommonDutyConstant().getDomainCode(hostNm)));
        model.addAttribute("nation", commonDutyService.countryList(domainLangCode));// 등록되어있는 국가 정보
        model.addAttribute("goodsMark", service.goodsMarkCodeList(vo)); // 인증
        vo = service.goodsView(vo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, vo);
        model.addAttribute("histVo", service.goodsChngHist(vo)); //히스토리 리스트 
        
        //변경사유서 양식 
        if(vo.getGoodsRegistSttus().equals(1008) || vo.getGoodsRegistSttus().equals(1009)){
            //10007 비전시 1008 재임시저장 1009 재요청 
            vo.setExmntConfmCd(vo.getGoodsRegistSttus());
            gmservice.changeView(vo);  //변경사유서 첨부파일 가져오기 
        }
        String strPgNm = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/"), request.getRequestURI().lastIndexOf(".do"));

        return baseURL + "/" + strPgNm;
    }

    
    /**
     * 서비스수정
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_goodsUpdateAction.do", method = RequestMethod.POST)
    public String goodsUpdateAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUpdtId(userLoginVo.getUserId());
        
        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList = new ArrayList<List<FileVO>>();
        List<FileVO> mnlFile = new ArrayList<FileVO>();
        List<FileVO> dnlFile = new ArrayList<FileVO>(); //사용자메뉴얼 추가
        List<FileVO> etcFile= new ArrayList<FileVO>();  //기타 첨부파일 추가
        List<FileVO> priceFile = new ArrayList<FileVO>(); //가격표 첨부파일 추가
        List<FileVO> imageMainFile = new ArrayList<FileVO>(); //서비스메인이미지 수정 추가
        List<FileVO> gcFile = new ArrayList<FileVO>();  //변경사유서 첨부 
        
        
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) { // 서비스메인이미지 수정 추가
                if(inputNm.equals("imageFile1"))imageMainFile.add(uploadFile.get(i));
                else imageFile.add(uploadFile.get(i));
            }

            if("goodsFile".equals(inputNm)) goodsFile.add(uploadFile.get(i));

            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if(inputNm.startsWith("mnlFile")) mnlFile.add(uploadFile.get(i));
            if(inputNm.startsWith("dnlFile")) dnlFile.add(uploadFile.get(i));  //사용자메뉴얼 추가
            if(inputNm.startsWith("etcFile"))  etcFile.add(uploadFile.get(i)); //기타첨부파일 추가
            if(inputNm.startsWith("priceFile"))  priceFile.add(uploadFile.get(i)); //가격표 첨부파일 추가
            if(inputNm.startsWith("gcFile"))  gcFile.add(uploadFile.get(i));
        }

        vo.setImageFile(imageFile);
        vo.setGoodsFile(goodsFile);
        vo.setMarkCrtfcFile(markCrtfcFileList);
        vo.setMnlFile(mnlFile);  
        vo.setDnlFile(dnlFile); //사용자메뉴얼 추가
        vo.setEtcFile(etcFile); //기타첨부파일 추가
        vo.setPriceFile(priceFile); // 가격표 첨부파일 추가
        vo.setImageMainFile(imageMainFile); //서비스메인이미지 수정 추가
        vo.setGcFile(gcFile);   //변경사유서 
        
        // 수정 실행
        Integer key = service.goodsUpdate(vo, request);
   
       // if(gcFile.size() > 0){
        
        if(vo.getGoodsRegistSttus().equals(1007) || vo.getGoodsRegistSttus().equals(1008)  || vo.getGoodsRegistSttus().equals(1009) || vo.getGoodsRegistSttus().equals(1010)){
            vo.setMngrId(userLoginVo.getUserId());
            vo.setExmntConfmCd(vo.getGoodsRegistSttus());
            vo.setReturnResn("");
            service.changeAction(vo); 
        }
        
        if(Validate.isEmpty(key)) {
            return alertAndBack(model,MessageHelper.getMsg(request, "processFail"));
        } else if (key == -1) {
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsChangeStatus"));
        }else{
           /* WebGoodsManageVO goodVo = vo;
            RegisterUserVO registerVo = new RegisterUserVO();
           
            if(vo.getGoodsRegistSttus() == 1002){
                // 검토/승인/이력
                vo.setMngrId(userLoginVo.getUserId());
                vo.setExmntConfmCd(vo.getGoodsRegistSttus());
                vo.setReturnResn("");
                gmservice.reasonAction(vo);

                //관리자 정보(검토권한 관리자)
                vo.setAuthCode("omp_gdex_adm");
                List<WebGoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보

                goodVo = service.goodsView(vo);//서비스조회

                for(int i = 0 ; i < eManagerList.size() ; i++) {
                    if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){
                        registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                        registerVo.setEmail(eManagerList.get(i).getEmail());
                        emailCrtfcAction(request, model, goodVo, registerVo);    //이메일 전송
                    }
                }
            }*/
        }

        //임시저장은 서비스등록을 계속 진행할 수 있도록 한다.
        String url = "";
        String mode = request.getParameter("mode");
        if (mode.equals("nextMove")){
            url = "BD_goodsSpecForm.do?goodsCode=" + vo.getGoodsCode();
        } else{  
            if(vo.getGoodsRegistSttus() == 1001 || vo.getGoodsRegistSttus() == 1008){
                url = "BD_goodsView.do?goodsCode=" + vo.getGoodsCode();
                //url = "BD_goodsView.do?" + OpHelper.getSearchQueryString(request);
            }else{
                url = "BD_waitingList.do?" + OpHelper.getSearchQueryString(request);
            }
        }
        return alertAndRedirect(model, MessageHelper.getMsg(request, "updateOk"), url);
    }
    
    @RequestMapping(value = "ND_goodsConfirmAction.do", method = RequestMethod.POST)
    public String goodsConfirmAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUpdtId(userLoginVo.getUserId());

        //등록 신청 요청코드 
        if(vo.getGoodsRegistSttus() == 1002 || vo.getGoodsRegistSttus() == 1009){
            
            Integer key = service.goodsUpdateConfirm(vo, request);
            WebGoodsManageVO goodVo = vo;
            RegisterUserVO registerVo = new RegisterUserVO();
            vo.setExmntConfmCd(vo.getGoodsStatus());   // 임시저장 에서 확인요 업데이트 
          
            if (vo.getGoodsRegistSttus() == 1002)  {
                vo.setExmntConfmCd(vo.getGoodsRegistSttus());
                gmservice.reasonAction(vo);
            }
            
            if (vo.getGoodsRegistSttus() == 1009)
                gmservice.confirmAction(vo);

           /* 검토자 대상 메일 발송 
            if (vo.getGoodsRegistSttus() == 1002)     //관리자 정보(검토권한 관리자) => 신규등록 
                vo.setAuthCode("omp_gdex_adm");
            else if(vo.getGoodsRegistSttus() == 1009) //관리자 정보(검토권한 관리자) => 재등록
                vo.setAuthCode("omp_gdex_adm");
              
            List<WebGoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보
            goodVo = service.goodsView(vo);
            registerVo.setSbscrbSiteSeCd(2001);
            for(int i = 0 ; i < eManagerList.size() ; i++) {
                if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){

                    registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                    registerVo.setEmail(eManagerList.get(i).getEmail());
                    //이메일 전송
                    emailCrtfcAction(request, model, goodVo, registerVo);
                }
            }*/
            
        }
       
        String url = "";
        if(vo.getGoodsRegistSttus() == 1003 ){
            url = "BD_goodsView.do?goodsCode=" + vo.getGoodsCode();
        }else{
            url = "BD_waitingList.do?" + OpHelper.getSearchQueryString(request);
        }
       
        return alertAndRedirect(model, MessageHelper.getMsg(request, "processOk"), url);
    }

    @RequestMapping(value = "BD_goodsContent.do")
    //public void BD_goodsContent(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {}    
    public String BD_goodsContent(HttpServletRequest request, ModelMap model, GoodsManageVO vo) 
    {        
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;
        
        return baseURL + "/BD_goodsContent_v2"; 
    }
    
    /**
     * 서비스 등록폼
     */
    @RequestMapping(value = "BD_goodsForm.do")
    public String goodsFrom(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo)
    {
        // 언어 적용 Url
        String hostNm = "korean";
        String baseURL = getBaseUrl(model, hostNm);

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            goodsVo.setRegistId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do");
        }

        goodsVo.setUserId(userLoginVO.getMasterId());
        goodsVo.setUpdtId(userLoginVO.getUserId());
        goodsVo.setRegistId(userLoginVO.getUserId());
        List<WebGoodsManageVO> storeLangList = service.storeLangList(goodsVo);
        if(storeLangList.size() < 1)
            return alertAndRedirect(model, "상품상점이 활성화 되지 않았습니다. 협약서 연장(재)신청하여 승인 확인하시기 바랍니다. ", "/korean/pt/register/BD_suppliIndex.do");

        OpHelper.bindSearchMap(goodsVo, request);
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        String siteLang = commonDutyService.getLangCd(Integer.parseInt(domainCode));
        model.addAttribute("nation", commonDutyService.countryList(siteLang));// 등록되어있는 국가 정보

        boolean siteLangOk = false;
        for(int i = 0 ; i < storeLangList.size() ; i++) {
            if(siteLang.equals(storeLangList.get(i).getLangCode())) {
                siteLangOk = true;
            }
        }
        model.addAttribute("storeLangList", storeLangList); // 스토어언어조회
        if(Validate.isEmpty(goodsVo.getLangCode())) {
            if(siteLangOk) {
                goodsVo.setLangCode(siteLang);
            } else {
                goodsVo.setLangCode(storeLangList.get(0).getLangCode());
            }
        }
        
        
        model.addAttribute("storeLang",      goodsVo.getLangCode());
        model.addAttribute("storeLangNm",    service.storeLangNm(goodsVo.getLangCode()));
        model.addAttribute("goodsStoreList", service.goodsStoreList(goodsVo));    // 제공자정보
        model.addAttribute("goodsMark",      service.goodsMarkCodeList(goodsVo)); // 인증
        model.addAttribute("goodsMetaLang",  service.goodsMetaLang(goodsVo));     // 지원언어
        model.addAttribute("goodsMetaPrice", service.goodsMetaPrice(goodsVo));    // 가격서비스
        
        model.addAttribute("goodsMetaList", service.goodsMetaList(goodsVo));    // 메타인증정보(서비스관리기준(2030),구축방식,지원OS,A/S방침,호환성)
        
        // 1-1
        model.addAttribute("goodsKndCd",  registerService.prvCodeList(goodsVo.getLangCode(), 1005)); // 서비스구분(1005)
        model.addAttribute("svcPcUntCd",  registerService.prvCodeList(goodsVo.getLangCode(), 2085)); // 통화단위(2085)
        model.addAttribute("dueStdrMumm", registerService.prvCodeList(goodsVo.getLangCode(), 2077)); // 과금기준(2077)
        
        
        // 2-2
        model.addAttribute("metaCnstcMthds",      registerService.prvCodeList(goodsVo.getLangCode(), 2032)); // 구축방식(2032)
        model.addAttribute("serviceOfferMethod",  registerService.prvCodeList(goodsVo.getLangCode(), 2034)); // 서비스유형(2034)
        //model.addAttribute("archtcSe",            registerService.prvCodeList(goodsVo.getLangCode(), 2013)); // 아키텍쳐(2013) 이렇게 하면 안됌..
        
        // 4-1
        model.addAttribute("svcEntrprsSuplyTy", registerService.prvCodeList(goodsVo.getLangCode(), 2055)); // 공급유형(2055)
        model.addAttribute("entrprsSe",         registerService.prvCodeList(goodsVo.getLangCode(), 2075)); // 기업구분(2075)
        
        
        //return baseURL + "/BD_goodsForm"; // 기존 로직 
        
        String session_GoodsCode = request.getParameter("goodsCode");   //(String)request.getSession().getAttribute("goodsCode") ;

        String curStep = request.getParameter("curStep");        
        if  (curStep==null)
        {
            curStep = "1";
            
            model.addAttribute("curStep", curStep);
        }
        
        
        String nxtStep = request.getParameter("nxtStep");
        String updateYnGubun = request.getParameter("updateYnGubun");       
        
        if(updateYnGubun != null){
            specVo.setUpdateYn(updateYnGubun);
        }
        
        if  (nxtStep == null) nxtStep = curStep;

        int passYn = 0;
        
        if  (!Validate.isEmpty( session_GoodsCode )) // 세션에 저장된 goodsCode를 가져오는 경우..
        {
            Map<String, Object> parameterMap = new HashMap<String, Object>();
            parameterMap.put("GoodsCode", session_GoodsCode);
            parameterMap.put("goodsCode", session_GoodsCode);
            parameterMap.put("langCode", "00");
            
            String updateYn = specVo.getUpdateYn();
            
            // select 한건을 구한다.
            if("update".equals(updateYn)){
                model.addAttribute("goodsInfo",  service.goodsInfoTmp(parameterMap));
                
            } else {
                model.addAttribute("goodsInfo",  service.goodsInfo(parameterMap));                
            }

            
            List goodsCateList;
            
            if("update".equals(updateYn)){
                goodsCateList = service.goodsCateListTmp(parameterMap);
            } else {
                goodsCateList = service.goodsCateList(parameterMap);                
            }

            model.addAttribute("goodsCateList",  goodsCateList);

            
            GoodsSpecDescribeVO specInfoMap;
            
            if("update".equals(updateYn)){
                specInfoMap = service.specInfoUpdate(parameterMap);
                passYn = service.getPassYnUpdate(parameterMap);

            } else {
                specInfoMap = service.specInfo(parameterMap);
                passYn = service.getPassYn(parameterMap);                
            }
            
            Map<String, Object> cDetailSvc = new HashMap<String, Object> () ; 
            if(passYn > 0 ){
                if (specInfoMap.getcDetailSvc().length() > 0 ) {
                    String[] cDetail = specInfoMap.getcDetailSvc().split(",");
                    List tstCateMgmtList = new ArrayList();
                    
                    //System.out.println("cDetail.length: " + cDetail.length);
                    
                    for (int i=0; i< cDetail.length; i++ ) {
                        String cDetailStr = cDetail[i];
                        //System.out.println("cDetailStr: " + cDetailStr);
                        cDetailSvc.put("cDetailStr", cDetailStr);
                        tstCateMgmtList.add(service.tstCateMgmt(cDetailSvc));
                    }
                    //System.out.println("tstCateMgmtList: " + tstCateMgmtList.size());
                    model.addAttribute("tstCateMgmt", tstCateMgmtList);
                }
            }
            model.addAttribute("specInfo",  specInfoMap);
            model.addAttribute("session_GoodsCode", session_GoodsCode);
        }
        
        String active = null;
        String onoff = null;        

        model.addAttribute("updateYn", specVo.getUpdateYn());
        model.addAttribute("curStep", nxtStep);        
        model.addAttribute("nxtStep", curStep);
        System.out.println("nxtStep: " + nxtStep);
        System.out.println("curStep: " + curStep);
        
//        if("".equals(updateYnGubun)){
            
//        }
        
        if  ("1".equals(nxtStep)) { active = "active"; onoff = "on"; } else { active = ""; onoff = "off";}   
        model.addAttribute("active1", active); 
        model.addAttribute("onoff1", onoff);        
        if  ("2".equals(nxtStep)) { active = "active"; onoff = "on"; } else { active = ""; onoff = "off";}  
        model.addAttribute("active2", active); 
        model.addAttribute("onoff2", onoff); 
        
        if  ("3".equals(nxtStep)) { active = "active"; onoff = "on";} else { active = ""; onoff = "off";} 
        model.addAttribute("active3", active); 
        model.addAttribute("onoff3", onoff); 
       
        if  ("4".equals(nxtStep)) { active = "active"; onoff = "on";} else { active = ""; onoff = "off";}  
        model.addAttribute("active4", active); 
        model.addAttribute("onoff4", onoff); 

        if  ("5".equals(nxtStep)) { active = "active"; onoff = "on";} else { active = ""; onoff = "off";}   
        model.addAttribute("active5", active); 
        model.addAttribute("onoff5", onoff);

        
        //  단계이동이 최초로 되면 INSERT 임시저장
        if  (!nxtStep.equals(curStep))
        {            
            if("update".equals(specVo.getUpdateYn())){
                //goodsVo.setGoodsRegistSttus(1001); // 임시저장  
            } else {
                goodsVo.setGoodsRegistSttus(1001); // 임시저장
            }
            
            // 새로운 goodsCode 세션에 제품 코드가 없다면....
            if  ( Validate.isEmpty( goodsVo.getGoodsCode() ) )
            {
                String newGoodsCode = service.goodsCode(goodsVo);  //  ( SELECT TO_CHAR(SYSDATE, 'YYYYMM') || GOODS_SEQ.NEXT_VALUE )
                
                goodsVo.setGoodsCode( newGoodsCode );                
                specVo.setGoodsCode( newGoodsCode );                
                
                //  새로운 goodsCode 세션에 제품 코드가 저장됨  ..
                request.getSession().setAttribute("goodsCode",newGoodsCode);
            }
            
            
            if("update".equals(specVo.getUpdateYn())){

                if  ("1".equals(nxtStep)) {
                    service.mergeGoodsInfoSpecInfoUpdate(curStep, goodsVo, specVo);
                }

            } else {
                if  ("1".equals(nxtStep)) {
                    service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
                }
            }            
        }
    
        return baseURL + "/BD_goodsForm_v2";
    }

    /**
     * 서비스등록
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_goodsActionStep1.do")
    public String goodsInsertActionStep1(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo) 
    {
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        String updateYn = goodsVo.getUpdateYn();
        
        if(Validate.isEmpty(userLoginVo)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          goodsVo.setRegistId(userLoginVo.getUserId());
          goodsVo.setUpdtId(userLoginVo.getUserId());
          //vo.setUserId(userLoginVo.getUserId());
          goodsVo.setUserId(userLoginVo.getMasterId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }
        
        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList = new ArrayList<List<FileVO>>();
        List<FileVO> mnlFile = new ArrayList<FileVO>();
        List<FileVO> dnlFile = new ArrayList<FileVO>(); //사용자메뉴얼 추가
        List<FileVO> etcFile= new ArrayList<FileVO>();  //기타 첨부파일 추가
        List<FileVO> priceFile = new ArrayList<FileVO>(); //가격표 첨부파일 추가
        List<FileVO> imageMainFile = new ArrayList<FileVO>(); //서비스메인이미지 수정 추가
        List<FileVO> gcFile = new ArrayList<FileVO>();  //변경사유서 첨부 
        
        
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) { // 서비스메인이미지 수정 추가 

                if (inputNm.equals("imageFile1")){ 
                    imageMainFile.add(uploadFile.get(i)); // 서비스 대표 이미지
                    goodsVo.setInputNm(inputNm);
                } else {
                    imageFile.add(uploadFile.get(i));     // 사용화면 이미지 
                }
            }

            if("goodsFile".equals(inputNm)) goodsFile.add(uploadFile.get(i));

            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if(inputNm.startsWith("mnlFile")) mnlFile.add(uploadFile.get(i));
            if(inputNm.startsWith("dnlFile")) dnlFile.add(uploadFile.get(i));  //사용자메뉴얼 추가
            if(inputNm.startsWith("etcFile"))  etcFile.add(uploadFile.get(i)); //기타첨부파일 추가
            if(inputNm.startsWith("priceFile"))  priceFile.add(uploadFile.get(i)); //가격표 첨부파일 추가
            if(inputNm.startsWith("gcFile"))  gcFile.add(uploadFile.get(i));
        }

        goodsVo.setImageFile(imageFile); // 사용화면 이미지 수정 추가
        goodsVo.setGoodsFile(goodsFile);
        goodsVo.setMarkCrtfcFile(markCrtfcFileList);
        goodsVo.setMnlFile(mnlFile);  
        goodsVo.setDnlFile(dnlFile); //사용자메뉴얼 추가
        goodsVo.setEtcFile(etcFile); //기타첨부파일 추가
        goodsVo.setPriceFile(priceFile); // 가격표 첨부파일 추가
        goodsVo.setImageMainFile(imageMainFile); //서비스메인이미지 수정 추가
        goodsVo.setGcFile(gcFile);   //변경사유서 
        

        String goodsCode = null ;
        String curStep = request.getParameter("curStep");
        String goodsStatus = request.getParameter("goodsRegistSttus");
        
        
        if (Validate.isEmpty(goodsVo.getGoodsCode()))  // 새로운 서비스를 등록할 경우..
        {
            goodsCode = service.goodsCode(goodsVo) ; // 새로운 goodsCode ( SELECT TO_CHAR(SYSDATE, 'YYYYMM') || GOODS_SEQ.NEXT_VALUE )
        }
        else // 기존에 서비스를 불러와서 할 경우
        {
            goodsCode = request.getParameter("goodsCode");//(String)request.getSession().getAttribute("GoodsCode");
        }
        
        goodsVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        goodsVo.setSleMthdCd(1002);      // 판매방식코드 1002
        Integer key = 0;
        //specVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        //specVo.setGoodsNum("1");
        //goodsVo.getDataMap().put("goodsStatus", goodsStatus);
         
        Integer goodsImageFileSeq = -1;
        if(!Validate.isEmpty(request.getParameter("goodsImageFileSeq"))) {
            goodsImageFileSeq = Integer.valueOf(request.getParameter("goodsImageFileSeq"));
        }
        
        goodsVo.setGoodsImageFileSeq(goodsImageFileSeq);
        
        if (Validate.isEmpty(request.getParameter("goodsCode"))) {
            // 신규 서비스 
            key = service.goodsInsert(goodsVo, request);    //INSERT INTO TST_GOOD_INFO_I
            
            /**
             2018-08-29 1단계에 있는 등록 내용은 tst_good_info_i로 모두 저장함
             아래 규격서 테이블 저장 부분은 주석처리              
             */
            //service.insertGoodsSpecDescribe(specVo);
        }else {
         // 서비스 수정 
            //goodsVo.setUpdateYn(specVo.getUpdateYn());
            
            goodsVo.setCertMarkCdGubun("N");
            
            key = service.goodsUpdate(goodsVo, request); 
            
            
            /**
             2018-08-29 1단계 수정시 규격서 부분 주석 처리 시작  
             */
            //if("update".equals(updateYn)){
                //service.mergeGoodsInfoSpecInfoUpdate(curStep, goodsVo, specVo);
            //} else {
                //service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
            //}
            /**
            2018-08-29 1단계 수정시 규격서 부분 주석 처리 종료  
            */

            //service.insertGoodsSpecDescribe(specVo);
        }
         
        WebGoodsManageVO goodVo = goodsVo;
        if (Validate.isEmpty(key)) 
        {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1002) // 서비스 등록 상태 - 임시저장(1001),등록신청(1002)
            {
                /*
                // 검토/승인/이력
                vo.setMngrId(userLoginVo.getUserId());
                vo.setExmntConfmCd(vo.getGoodsRegistSttus());
                vo.setReturnResn("");
                gmservice.reasonAction(vo);

                //관리자 정보(검토권한 관리자)
                vo.setAuthCode("omp_gdex_adm");
                List<WebGoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보

                goodVo = service.goodsView(vo);//서비스조회

                for(int i = 0 ; i < eManagerList.size() ; i++) {
                    if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){
                        registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                        registerVo.setEmail(eManagerList.get(i).getEmail());                      
                        emailCrtfcAction(request, model, goodVo, registerVo);   //이메일 전송
                    }
                }
                */
            }
        }

        String url = "";  
        String mode = request.getParameter("mode");
        
        if (mode.equals("nextMove")) {
         // 임시저장후 규격서등록으로 이동
            //url = "BD_goodsSpecForm.do?goodsCode=" + goodsVo.getGoodsCode();
            model.addAttribute("active1", "");
            model.addAttribute("active2", "active");
            model.addAttribute("updateYnGubun", updateYn);            
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=2&updateYnGubun="+updateYn;
            
        } else{
            
            if(goodsVo.getGoodsRegistSttus() == 1001) {
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode()+"&updateYnGubun="+updateYn;
            }else{
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
        
        //specVo.setUpdateYn(updateYn);
        
        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), url);
    }

    
    @RequestMapping(value = "ND_goodsActionStep2.do")
    public String goodsInsertActionStep2(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo) {
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        String updateYn = goodsVo.getUpdateYn();
        
        if(Validate.isEmpty(userLoginVo)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          goodsVo.setRegistId(userLoginVo.getUserId());
          goodsVo.setUpdtId(userLoginVo.getUserId());
          //vo.setUserId(userLoginVo.getUserId());
          goodsVo.setUserId(userLoginVo.getMasterId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }
        
        //파일 셋팅
        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile = new ArrayList<FileVO>();
        
        List<List<FileVO>> markCrtfcFileList = new ArrayList<List<FileVO>>();
        Map markCrtfcFileMap = new HashMap();
        
        List<FileVO> mnlFile = new ArrayList<FileVO>();
        List<FileVO> dnlFile = new ArrayList<FileVO>(); //사용자메뉴얼 추가
        List<FileVO> etcFile= new ArrayList<FileVO>();  //기타 첨부파일 추가
        List<FileVO> priceFile = new ArrayList<FileVO>(); //가격표 첨부파일 추가
        List<FileVO> imageMainFile = new ArrayList<FileVO>(); //서비스메인이미지 수정 추가
        List<FileVO> gcFile = new ArrayList<FileVO>();  //변경사유서 첨부 
        
        String inputNm = "";
        
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) { // 서비스메인이미지 수정 추가
                if(inputNm.equals("imageFile1"))imageMainFile.add(uploadFile.get(i));
                else imageFile.add(uploadFile.get(i));
            }

            if("goodsFile".equals(inputNm)) goodsFile.add(uploadFile.get(i));

            // STEP1-3) 인증구분 파일
            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);

                //goodsVo.setInputNms(inputNm);
                
                
                
//                if(inputNm.equals("markCrtfcFile0")){
                    //FileVO.setFileSeq(1004);
                //} else if(inputNm.equals("markCrtfcFile1")){
                    //
                //} else if(inputNm.equals("markCrtfcFile3")){
                    //
                //}
                    
                
                
                
                //클라우드서비스보안인증(CSAP) : markCrtfcFile0 
                //CC인증 : markCrtfcFile1                
                //나라장터종합쇼핑몰 : markCrtfcFile2                
                //클라우드서비스 품질성능 확인 : markCrtfcFile3                
                
                //1004    클라우드서비스보안인증(CSAP)
                //1001    CC인증    
                //1005    나라장터종합쇼핑몰   
                //1007    클라우드서비스 품질성능 확인
                
                //goodsVo.getGoodsCode();
                
                

                
                
            }
            
            if(inputNm.startsWith("mnlFile")) mnlFile.add(uploadFile.get(i));
            if(inputNm.startsWith("dnlFile")) dnlFile.add(uploadFile.get(i));  //사용자메뉴얼 추가
            if(inputNm.startsWith("etcFile"))  etcFile.add(uploadFile.get(i)); //기타첨부파일 추가
            if(inputNm.startsWith("priceFile"))  priceFile.add(uploadFile.get(i)); //가격표 첨부파일 추가
            if(inputNm.startsWith("gcFile"))  gcFile.add(uploadFile.get(i));
        }

        
        goodsVo.setImageFile(imageFile);
        goodsVo.setGoodsFile(goodsFile);
        goodsVo.setMarkCrtfcFile(markCrtfcFileList);
        goodsVo.setMnlFile(mnlFile);  
        goodsVo.setDnlFile(dnlFile); //사용자메뉴얼 추가
        goodsVo.setEtcFile(etcFile); //기타첨부파일 추가
        goodsVo.setPriceFile(priceFile); // 가격표 첨부파일 추가
        goodsVo.setImageMainFile(imageMainFile); //서비스메인이미지 수정 추가
        goodsVo.setGcFile(gcFile);   //변경사유서 

        
        
        String goodsCode = null ;
        String curStep = request.getParameter("curStep");
        String goodsStatus = request.getParameter("goodsRegistSttus");
        
        if (Validate.isEmpty(goodsVo.getGoodsCode())){
         // 새로운 서비스를 등록할 경우..
            goodsCode = service.goodsCode(goodsVo) ; // 새로운 goodsCode ( SELECT TO_CHAR(SYSDATE, 'YYYYMM') || GOODS_SEQ.NEXT_VALUE )
        }else {
         // 기존에 서비스를 불러와서 할 경우
            goodsCode = request.getParameter("goodsCode");//(String)request.getSession().getAttribute("GoodsCode");
        }
        
        
        Integer key = 0;
        
        goodsVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        goodsVo.setSleMthdCd(1002);      // 판매방식코드 1002
        //specVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        //specVo.setGoodsNum("1");
        //goodsVo.getDataMap().put("goodsStatus", goodsStatus);
        goodsVo.setCertMarkCdGubun("Y");
        key = service.goodsUpdate(goodsVo, request);
        
/*        if (Validate.isEmpty(request.getParameter("goodsCode"))) {
            // 신규 서비스 
            key = service.goodsInsert(goodsVo, request);    //INSERT INTO TST_GOOD_INFO_I 
            service.insertGoodsSpecDescribe(specVo);
        }else {
         // 서비스 수정 
            key = service.goodsUpdate(goodsVo, request);
            service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
            //service.insertGoodsSpecDescribe(specVo);
        }
        */
        
        String url = "";  
        String mode = request.getParameter("mode");
        
        if (mode.equals("nextMove")) {
            // 임시저장후 규격서등록으로 이동
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=3&updateYnGubun="+updateYn;            
        } else {
            if(goodsVo.getGoodsRegistSttus() == 1001) {
             // '임시저장' 인경우
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep="+curStep+"&updateYnGubun="+updateYn;
            }else{
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
        
        //specVo.setUpdateYn(updateYn);
        
        model.addAttribute("active1", "");
        model.addAttribute("active2", "active");
        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), url);
    }
    
    
    @RequestMapping(value = "ND_goodsActionStep3.do")
    public String goodsInsertActionStep3(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo) 
    {
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        String updateYn = specVo.getUpdateYn();        
        
        if(Validate.isEmpty(userLoginVo)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          goodsVo.setRegistId(userLoginVo.getUserId());
          goodsVo.setUpdtId(userLoginVo.getUserId());
          //vo.setUserId(userLoginVo.getUserId());
          goodsVo.setUserId(userLoginVo.getMasterId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }
        
        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList = new ArrayList<List<FileVO>>();
        List<FileVO> mnlFile = new ArrayList<FileVO>();
        List<FileVO> dnlFile = new ArrayList<FileVO>(); //사용자메뉴얼 추가
        List<FileVO> etcFile= new ArrayList<FileVO>();  //기타 첨부파일 추가
        List<FileVO> priceFile = new ArrayList<FileVO>(); //가격표 첨부파일 추가
        List<FileVO> imageMainFile = new ArrayList<FileVO>(); //서비스메인이미지 수정 추가
        List<FileVO> gcFile = new ArrayList<FileVO>();  //변경사유서 첨부 
        
        
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) { // 서비스메인이미지 수정 추가
                if(inputNm.equals("imageFile1"))imageMainFile.add(uploadFile.get(i));
                else imageFile.add(uploadFile.get(i));
            }

            if("goodsFile".equals(inputNm)) goodsFile.add(uploadFile.get(i));

            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if(inputNm.startsWith("mnlFile"))   mnlFile.add(uploadFile.get(i));     //사용메뉴얼(업로드)
            if(inputNm.startsWith("dnlFile"))   dnlFile.add(uploadFile.get(i));     //사용자메뉴얼 추가
            if(inputNm.startsWith("etcFile"))   etcFile.add(uploadFile.get(i));     //기타첨부파일 추가
            if(inputNm.startsWith("priceFile")) priceFile.add(uploadFile.get(i));   //가격표 첨부파일 추가
            if(inputNm.startsWith("gcFile"))    gcFile.add(uploadFile.get(i));
        }

        goodsVo.setImageFile(imageFile);
        goodsVo.setGoodsFile(goodsFile);
        goodsVo.setMarkCrtfcFile(markCrtfcFileList);
        goodsVo.setMnlFile(mnlFile);  
        goodsVo.setDnlFile(dnlFile); //사용자메뉴얼 추가
        goodsVo.setEtcFile(etcFile); //기타첨부파일 추가
        goodsVo.setPriceFile(priceFile); // 가격표 첨부파일 추가
        goodsVo.setImageMainFile(imageMainFile); //서비스메인이미지 수정 추가
        goodsVo.setGcFile(gcFile);   //변경사유서 
        

        String goodsCode = null ;
        String curStep = request.getParameter("curStep");
        String goodsStatus = request.getParameter("goodsRegistSttus");
        
        
        if (Validate.isEmpty(goodsVo.getGoodsCode()))  // 새로운 서비스를 등록할 경우..
        {
            goodsCode = service.goodsCode(goodsVo) ; // 새로운 goodsCode ( SELECT TO_CHAR(SYSDATE, 'YYYYMM') || GOODS_SEQ.NEXT_VALUE )
        }
        else // 기존에 서비스를 불러와서 할 경우
        {
            goodsCode = request.getParameter("goodsCode");//(String)request.getSession().getAttribute("GoodsCode");
        }
        
        System.out.println("setCtgryCodes: " + request.getParameter("setCtgryCodes"));
        
        goodsVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        goodsVo.setSleMthdCd(1002);      // 판매방식코드 1002
        Integer key = 0;
        specVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        specVo.setGoodsNum("1");
        //goodsVo.getDataMap().put("goodsStatus", goodsStatus);
        
        
        if (Validate.isEmpty(request.getParameter("goodsCode"))) {
            // 신규 서비스 
            key = service.goodsInsert(goodsVo, request);    //INSERT INTO TST_GOOD_INFO_I 
            service.insertGoodsSpecDescribe(specVo);
        }else {
         // 서비스 수정 
            goodsVo.setUpdateYn(specVo.getUpdateYn());
            
            //key = service.goodsUpdate(goodsVo, request);
            key = 1;
            
            if("update".equals(updateYn)){
                service.mergeGoodsInfoSpecInfoUpdate(curStep, goodsVo, specVo);
            } else {
                service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
            }
            //service.insertGoodsSpecDescribe(specVo);
        }
        
        WebGoodsManageVO goodVo = goodsVo;
        if (Validate.isEmpty(key)) 
        {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1002) // 서비스 등록 상태 - 임시저장(1001),등록신청(1002)
            {
                /*
                // 검토/승인/이력
                vo.setMngrId(userLoginVo.getUserId());
                vo.setExmntConfmCd(vo.getGoodsRegistSttus());
                vo.setReturnResn("");
                gmservice.reasonAction(vo);

                //관리자 정보(검토권한 관리자)
                vo.setAuthCode("omp_gdex_adm");
                List<WebGoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보

                goodVo = service.goodsView(vo);//서비스조회

                for(int i = 0 ; i < eManagerList.size() ; i++) {
                    if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){
                        registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                        registerVo.setEmail(eManagerList.get(i).getEmail());                      
                        emailCrtfcAction(request, model, goodVo, registerVo);   //이메일 전송
                    }
                }
                */
            }
        }

        String url = "";  
        String mode = request.getParameter("mode");
/*        
        if (mode.equals("nextMove")) {
            // 임시저장후 규격서등록으로 이동
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=3&updateYnGubun="+updateYn;            
        } else {
            if(goodsVo.getGoodsRegistSttus() == 1001) {
             // '임시저장' 인경우
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep="+curStep+"&updateYnGubun="+updateYn;
            }else{
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
*/        
        
        
        if (mode.equals("nextMove")) // 임시저장후 규격서등록으로 이동  
        {
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=4&updateYnGubun="+updateYn;
        } 
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1001) // '임시저장' 인경우
            {
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep="+curStep+"&updateYnGubun="+updateYn;
            }
            else
            {
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
        
        specVo.setUpdateYn(updateYn);
        
        model.addAttribute("active1", "");
        model.addAttribute("active2", "");
        model.addAttribute("active3", "active");
        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), url);
    }
    
    @RequestMapping(value = "ND_goodsActionStep4.do")
    public String goodsInsertActionStep4(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo)
    {
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        String updateYn = specVo.getUpdateYn();        
        
        if(Validate.isEmpty(userLoginVo)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          goodsVo.setRegistId(userLoginVo.getUserId());
          goodsVo.setUpdtId(userLoginVo.getUserId());
          //vo.setUserId(userLoginVo.getUserId());
          goodsVo.setUserId(userLoginVo.getMasterId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }
        
        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList = new ArrayList<List<FileVO>>();
        List<FileVO> mnlFile = new ArrayList<FileVO>();
        List<FileVO> dnlFile = new ArrayList<FileVO>(); //사용자메뉴얼 추가
        List<FileVO> etcFile= new ArrayList<FileVO>();  //기타 첨부파일 추가
        List<FileVO> priceFile = new ArrayList<FileVO>(); //가격표 첨부파일 추가
        List<FileVO> imageMainFile = new ArrayList<FileVO>(); //서비스메인이미지 수정 추가
        List<FileVO> gcFile = new ArrayList<FileVO>();  //변경사유서 첨부 
        
        
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) { // 서비스메인이미지 수정 추가
                if(inputNm.equals("imageFile1"))imageMainFile.add(uploadFile.get(i));
                else imageFile.add(uploadFile.get(i));
            }

            if("goodsFile".equals(inputNm)) goodsFile.add(uploadFile.get(i));

            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if(inputNm.startsWith("mnlFile"))   mnlFile.add(uploadFile.get(i));
            if(inputNm.startsWith("dnlFile"))   dnlFile.add(uploadFile.get(i));  //사용자메뉴얼 추가
            if(inputNm.startsWith("etcFile"))   etcFile.add(uploadFile.get(i)); //기타첨부파일 추가
            if(inputNm.startsWith("priceFile")) priceFile.add(uploadFile.get(i)); //가격표 첨부파일 추가
            if(inputNm.startsWith("gcFile"))    gcFile.add(uploadFile.get(i));
        }

        goodsVo.setImageFile(imageFile);
        goodsVo.setGoodsFile(goodsFile);
        goodsVo.setMarkCrtfcFile(markCrtfcFileList);
        goodsVo.setMnlFile(mnlFile);  
        goodsVo.setDnlFile(dnlFile); //사용자메뉴얼 추가
        goodsVo.setEtcFile(etcFile); //기타첨부파일 추가
        goodsVo.setPriceFile(priceFile); // 가격표 첨부파일 추가
        goodsVo.setImageMainFile(imageMainFile); //서비스메인이미지 수정 추가
        goodsVo.setGcFile(gcFile);   //변경사유서 
        
        String goodsCode = null ;
        String curStep = request.getParameter("curStep");
        String goodsStatus = request.getParameter("goodsRegistSttus");
        
        
        
        
        if (Validate.isEmpty(goodsVo.getGoodsCode()))  // 새로운 서비스를 등록할 경우..
        {
            goodsCode = service.goodsCode(goodsVo) ; // 새로운 goodsCode ( SELECT TO_CHAR(SYSDATE, 'YYYYMM') || GOODS_SEQ.NEXT_VALUE )
        }
        else // 기존에 서비스를 불러와서 할 경우
        {
            goodsCode = request.getParameter("goodsCode");//(String)request.getSession().getAttribute("GoodsCode");
        }
        
        System.out.println("setCtgryCodes: " + request.getParameter("setCtgryCodes"));
        
        goodsVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        goodsVo.setSleMthdCd(1002);      // 판매방식코드 1002
        Integer key = 0;
        specVo.setGoodsCode(goodsCode); // 새로운 goodsCode
        specVo.setGoodsNum("1");
        //goodsVo.getDataMap().put("goodsStatus", goodsStatus);
        
        Integer priceDnFileSeq = -1;
        Integer mnlDnFileSeq = -1;
            
        if (!Validate.isEmpty(request.getParameter("priceDnFileSeq"))) {
            priceDnFileSeq = Integer.valueOf(request.getParameter("priceDnFileSeq"));
        }
        if (!Validate.isEmpty(request.getParameter("mnlDnFileSeq"))) {
            mnlDnFileSeq = Integer.valueOf(request.getParameter("mnlDnFileSeq"));
        }
        
        String svcChargerNm = request.getParameter("svcChargerNm");
        String svcChargerTelno = request.getParameter("svcChargerCttpc1") + "-" + request.getParameter("svcChargerCttpc2") + "-" + request.getParameter("svcChargerCttpc3");
        String svcChargerEmail = request.getParameter("svcChargerEmail1") + "@" + request.getParameter("svcChargerEmail2");
        String svcChargerMbtlNum = request.getParameter("svcChargerMbtlNum1") + "-" + request.getParameter("svcChargerMbtlNum2") + "-" + request.getParameter("svcChargerMbtlNum3"); 
        String svcChargerCttpc = request.getParameter("svcChargerCttpc");
        
        specVo.setSvcChargerNm(svcChargerNm);           // 서비스 담당자 이름                        
        specVo.setSvcChargerTelno(svcChargerTelno);     // 서비스 담당자 전화번호
        specVo.setSvcChargerEmail(svcChargerEmail);     // 서비스 담당자 이메일   
        specVo.setSvcChargerMbtlNum(svcChargerMbtlNum); //서비스담당자 핸드폰
        specVo.setSvcChargerCttpc(svcChargerCttpc);     //국가번호
        
        if (Validate.isEmpty(request.getParameter("goodsCode"))) {
            // 신규 서비스 
            key = service.goodsInsert(goodsVo, request);    //INSERT INTO TST_GOOD_INFO_I 
            service.insertGoodsSpecDescribe(specVo);
        }else {
         // 서비스 수정 
            goodsVo.setPriceDnFileSeq(priceDnFileSeq);
            goodsVo.setMnlDnFileSeq(mnlDnFileSeq);
            // 서비스 수정 
            goodsVo.setUpdateYn(specVo.getUpdateYn());

            
            goodsVo.setCertMarkCdGubun("N");
            key = service.goodsUpdate(goodsVo, request);
//            service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
            
            if("update".equals(updateYn)){
                service.mergeGoodsInfoSpecInfoUpdate(curStep, goodsVo, specVo);
            } else {
                service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
            }

            
            //service.insertGoodsSpecDescribe(specVo);
        }
        
        WebGoodsManageVO goodVo = goodsVo;
        if (Validate.isEmpty(key)) 
        {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1002) // 서비스 등록 상태 - 임시저장(1001),등록신청(1002)
            {
                /*
                // 검토/승인/이력
                vo.setMngrId(userLoginVo.getUserId());
                vo.setExmntConfmCd(vo.getGoodsRegistSttus());
                vo.setReturnResn("");
                gmservice.reasonAction(vo);

                //관리자 정보(검토권한 관리자)
                vo.setAuthCode("omp_gdex_adm");
                List<WebGoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보

                goodVo = service.goodsView(vo);//서비스조회

                for(int i = 0 ; i < eManagerList.size() ; i++) {
                    if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){
                        registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                        registerVo.setEmail(eManagerList.get(i).getEmail());                      
                        emailCrtfcAction(request, model, goodVo, registerVo);   //이메일 전송
                    }
                }
                */
            }
        }
        
        String url = "";  
        String mode = request.getParameter("mode");
        
        
/*
        if (mode.equals("nextMove")) // 임시저장후 규격서등록으로 이동  
        {
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=4&updateYnGubun="+updateYn;
        } 
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1001) // '임시저장' 인경우
            {
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep="+curStep+"&updateYnGubun="+updateYn;
            }
            else
            {
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
 * */        
        
        
        if (mode.equals("nextMove")) // 임시저장후 규격서등록으로 이동  
        {
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=5&updateYnGubun="+updateYn;
        } 
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1001) // '임시저장' 인경우
            {
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep="+curStep+"&updateYnGubun="+updateYn;
            }
            else
            {
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
        
        specVo.setUpdateYn(updateYn);
        
        model.addAttribute("active1", "");
        model.addAttribute("active2", "");
        model.addAttribute("active3", "");
        model.addAttribute("active4", "active");
        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), url);
    }

    
    @RequestMapping(value = "ND_goodsActionStep5.do")
    public String goodsInsertActionStep5(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo)
    {
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        String updateYn = specVo.getUpdateYn();        
        
        if(Validate.isEmpty(userLoginVo)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          goodsVo.setRegistId(userLoginVo.getUserId());
          goodsVo.setUpdtId(userLoginVo.getUserId());
          //vo.setUserId(userLoginVo.getUserId());
          goodsVo.setUserId(userLoginVo.getMasterId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }
        
        
        String url = "";
        String curStep = request.getParameter("curStep");
        /*
        String mode = request.getParameter("mode");
        
        if (mode.equals("nextMove")) // 임시저장후 규격서등록으로 이동  
        {
            url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep=5";
        } 
        else
        {
            if(goodsVo.getGoodsRegistSttus() == 1001) // '임시저장' 인경우
            {
                //url = "BD_goodsView.do?goodsCode=" + goodsVo.getGoodsCode();
                url ="BD_goodsForm.do?goodsCode=" + goodsVo.getGoodsCode() + "&nxtStep="+curStep;
            }
            else
            {
                url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
            }
        } 
        
        model.addAttribute("active1", "");
        model.addAttribute("active2", "");
        model.addAttribute("active3", "");
        model.addAttribute("active4", "active");*/
        
        goodsVo.setGoodsRegistSttus(1002); /* 승인대기 */
        
        if("update".equals(updateYn)){
            service.mergeGoodsInfoSpecInfoUpdate(curStep, goodsVo, specVo);
        } else {
            service.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);
        }        
        
        url = "BD_waitingList.do"; // '승인대기' 화면으로 이동한다.
        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), url);
    }
    
    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request, WebGoodsManageVO goodsVo) {
        // setBoardService(request); // 게시판 유형 서비스 설정
        
        int markingInfoDeleteCount = service.deleteTstGoodMarkIInt(goodsVo, request);
        
        int affected = service.fileDelete(fileVO);

        if(affected < 1) {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, affected);
    }

    /**
     * 사용자 본인이 2-3. 서비스 인증정보 해당사항 없음에 대해서 삭제처리함 
     * ND_markingInfoDelete 설명
     * @param request
     * @param model
     * @param goodsVo
     * @return
     */
    @RequestMapping(value = "ND_markingInfoDelete.do", method = RequestMethod.POST)
    public String ND_markingInfoDelete(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo) {
        // setBoardService(request); // 게시판 유형 서비스 설정
        //int affected = service.fileDelete(goodsVo);

        int markingInfoDeleteCount = service.deleteTstGoodMarkIInt(goodsVo, request);

        if(markingInfoDeleteCount < 1) {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, markingInfoDeleteCount);
    }

    /**
     * 삭제
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_goodsDeleteAction.do", method = RequestMethod.POST)
    public String goodsDeleteAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUpdtId(userLoginVo.getUserId());

        Integer orderCnt = service.orderCnt(vo);
        if (orderCnt > 0) {
            return alertAndBack(model, "현재 구매가 진행중인 건이 있어 삭제를 진행할 수 없습니다.");
        }
        Integer cnt = service.goodsDelete(vo, request);
        if(cnt != 1) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }

        String url = "BD_waitingList.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, MessageHelper.getMsg(request, "deleteOk"), url);
    }

    /**
     * 검토대기로 보내기
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_registUpdateAction.do", method = RequestMethod.POST)
    public String registUpdateAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);

        vo.setUpdtId(userLoginVo.getUserId());

        Integer cnt = service.registUpdate(vo, request);
        if(cnt != 1) {
            return alertAndBack(model, MessageHelper.getMsg(request, "validateFail"));
        }

        String url = "BD_waitingList.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, MessageHelper.getMsg(request, "updateOk"), url);
    }

    /**
     * ctgrySelect (카테고리 선택)
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "ND_ctgrySelect.do", method = RequestMethod.POST)
    public String ctgrySelect(WebGoodsManageVO vo, ModelMap model) {

        return responseJson(model, service.ctgrySelect(vo));
    }

    @RequestMapping(value = "ND_fileCountChk.do", method = RequestMethod.POST)
    public String fileCountCheck(HttpServletRequest request, ModelMap model) {
        Integer fileSeq = Integer.valueOf(request.getParameter("fileSeq"));
        Integer maxCnt = Integer.valueOf(request.getParameter("maxCnt"));
        Integer fCnt ;
        if(Validate.isNotEmpty(request.getParameter("fCnt"))){
            fCnt = Integer.valueOf(request.getParameter("fCnt"));
        }else{
            fCnt = 0;
        }

        String message = new String(); // retrun 메시지
        message = "";
        Integer cnt = service.fileCount(fileSeq);
        if((cnt + fCnt) > maxCnt) {
//            message = "최대 파일첨부 개수는 " + maxCnt + "개 입니다.";
            message = MessageHelper.getMsg(request, "chkCmBoardFileEnd");
        }

        return responseText(model, message);
    }

    /**
     * 업로드 파일 종류 및 크기 체크
     */
    @RequestMapping(value = "ND_uploadFileChk.do", method = RequestMethod.POST)
    public String uploadFileCheck(HttpServletRequest request, ModelMap model){

        String fileExtPermit = "";
        String inputName = request.getParameter("inputName");
        if (request.getParameter("fileExt") == "1") {
            fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai";
        }
//        String fileExtPermit = request.getParameter("fileExt").toLowerCase();

        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다.

        long maxFileSize = Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024;

        int result = 100;   // 100 : 패스

        String message = new String(); //retrun 메시지

        // 파일 체크
        @SuppressWarnings("unchecked")
        List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);
        String fileType = "";
        if(files != null && !request.getParameter("maxFileSize").isEmpty()) {
            for(int i=0; i < files.size(); i++){
                MultipartFile fileVo = files.get(i);
                if(fileVo.getSize() > 0) {
                    if(fileVo.getName().equals(inputName)) {

                        fileType = FileUtil.extension(fileVo.getOriginalFilename()).toLowerCase();

                        if(fileExtPermit.indexOf(fileType) == -1) {
                            result = 201; //허용하지 않는 파일유형(확장자)
                            break;
                        }

                        Long fileSize = fileVo.getSize();

                        if(maxFileSize > 0 && fileSize > maxFileSize) {
                            result = 200; //파일 제한용량초가
                            break;
                        }
                    }//End if
                }
            }
        }else{
            result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때
        }

        switch (result) {
            case 100:
                 message = "100";
                 break;
            case 200:
//                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 message = MessageHelper.getMsg(request, "fileSizeOver");
                 break;
            case 201:
//                 message = "파일의 종류는 " + fileExtPermit + " 파일만 가능합니다.";
                 message = fileType + MessageHelper.getMsg(request, "fileCannotUplaod");
                 break;
            default:
//                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 message = MessageHelper.getMsg(request, "chkImageError");
                 break;
        }

        return responseText(model, message);

    }

    /**
     * 업로드 이미지 픽셀 및 크기 체크
     */
    @RequestMapping(value = "ND_uploadImgChk.do", method = RequestMethod.POST)
    public String uploadIMGCheck2(HttpServletRequest request, ModelMap model){

//        String imgType = request.getParameter("imgType");

        String inputName = request.getParameter("inputName");
        String fileExtPermit = request.getParameter("fileExt").toLowerCase();

        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다.
        long maxFileSize = Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024;

        Float maxWidthSize = (float)Integer.parseInt(request.getParameter("maxWidthSize").isEmpty() != true ? request.getParameter("maxWidthSize") : "0");
        Float maxHeightSize = (float)Integer.parseInt(request.getParameter("maxHeightSize").isEmpty() != true ? request.getParameter("maxHeightSize") : "0");

        Float minWidthSize = (float)Integer.parseInt(request.getParameter("minWidthSize").isEmpty() != true ? request.getParameter("minWidthSize") : "0");
        Float minHeightSize = (float)Integer.parseInt(request.getParameter("minHeightSize").isEmpty() != true ? request.getParameter("minHeightSize") : "0");

        int result = 100;   // 100 : 패스

        String message = new String(); //retrun 메시지

        // 이미지 파일 체크
        @SuppressWarnings("unchecked")
        List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);

        if(files != null && !request.getParameter("maxFileSize").isEmpty()) {
            for(int i=0; i < files.size(); i++){
                MultipartFile fileVo = files.get(i);
                if(fileVo.getSize() > 0) {
                    if(fileVo.getName().equals(inputName)) {

                        String fileType = FileUtil.extension(fileVo.getOriginalFilename()).toLowerCase();

                        if(fileExtPermit.indexOf(fileType) == -1) {
                            result = 201; //허용하지 않는 파일유형(확장자)
                            break;
                        }

                        Long fileSize = fileVo.getSize();

                        if(maxFileSize > 0 && fileSize > maxFileSize) {
                            result = 200; //파일 제한용량초가
                            break;
                        }else{
                            if(minWidthSize > 0 || minHeightSize > 0) { //가로나 세로 제한값이 있을 때
                                try {
                                    //BufferedImage bi = ImageIO.read(new File(GlobalConfig.WEBAPP_ROOT + fileVo.getFileUrl()));
                                    BufferedImage bi = ImageIO.read(fileVo.getInputStream());

                                    Float imgW = (float)bi.getWidth();
                                    Float imgH = (float)bi.getHeight();

                                    if((minWidthSize > 0) && (minWidthSize > imgW)) { //최소가로제한 값이 있고 제한값보다 작을때
                                        result = 301; //가로크기가 제한크기보다 작을때
                                     }

                                    if((minHeightSize > 0) && (minHeightSize > imgH)) { //최소세로제한 값이 있고 제한값보다 작을때
                                        result = 302; //세로크기가 제한크기보다 작을때
                                     }

                                    if((maxWidthSize > 0) && (maxWidthSize < imgW)) { //최대가로제한 값이 있고 제한값보다 클때
                                       result = 304; //가로크기가 제한크기보다 클때
                                    }

                                    if((maxHeightSize > 0) && (maxHeightSize < imgH)) { //최대세로제한 값이 있고 제한값보다 클 때
                                       result = 305; //세로크기가 제한크기보다 클때
                                    }

                                    Float ratioValue1 = (float) (minWidthSize / minHeightSize);
                                    Float ratioValue2 = (float) (imgW / imgH);

                                    //if (maxWidthSize > 0 && maxHeightSize > 0 ) && !ratioValue1.equals(ratioValue2)
                                    if((minWidthSize > 0 && minHeightSize > 0 ) && (((ratioValue1-ratioValue2) > 0.05) || ((ratioValue2-ratioValue1) > 0.05))) {
                                        result = 303; // 가로/세로 비율이 맞지 않음
                                    }

                                }catch (IOException e) {
                                    if(logger.isDebugEnabled()) {
                                        logger.debug("file check failed : ", e);
                                    }

                                    result = 400; // 400 : 이미지 사이즈 확인 오류발생
                                    break;
                                }
                            }
                        }//End for
                    }//End if
                }
            }
        }else{
            result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때
        }

        switch (result) {
            case 100:
                 message = "100";
                 break;
            case 200:
//                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 message = MessageHelper.getMsg(request, "chkFileCapacity");
                 break;
            case 201:
//                message = "이미지 파일의 유형(확장자)은 jpg, png 파일만 가능합니다.";
                message = MessageHelper.getMsg(request, "chkImageExt");

                break;
            case 301:
//                 message = "이미지의 가로크기가 "+ minWidthSize +" 보다 작습니다.";
                 message = MessageHelper.getMsg(request, "chkImageWidth");

                 break;
            case 302:
//                 message = "이미지의 세로크기가 "+ minHeightSize +" 보다 작습니다.";
                 message = MessageHelper.getMsg(request, "chkImageHeight");
                 break;
            case 303:
                 message = MessageHelper.getMsg(request, "chkImage01");
                 break;
            case 304:
//                message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다..";
                message = MessageHelper.getMsg(request, "chkImageWidth");
                break;
            case 305:
//                message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다.";
                message = MessageHelper.getMsg(request, "chkImageHeight");
                break;
            case 400:
//                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 message = MessageHelper.getMsg(request, "chkImageError");
                 break;
            default:
                 message = MessageHelper.getMsg(request, "chknNotImage");
//                 message = "이미지가 확인되지 않았습니다.";
                 break;

        }

        return responseText(model, message);

    }

    /**
     * 기술카테고리 포함 여부
     */
    @RequestMapping(value = "ND_techCtgryChk.do", method = RequestMethod.POST)
    public String techCtgryChk(HttpServletRequest request, ModelMap model){
        GoodsManageVO vo = new GoodsManageVO();
        vo.setCtgryCds(request.getParameterValues("ctgryCds"));
        vo.setTechCtgry(request.getParameter("techCtgry"));
        int ret = gmservice.techCtgryChk(vo);
        if (ret > 0) {
            return responseText(model, Boolean.TRUE);
        } else {
            return responseText(model, Boolean.FALSE);
        }
    }

    /**
     * 카테고리 팝업 메인
     */
    @RequestMapping(value = "PD_categoryPop.do")
    public String categoryPop(CategoryVO vo, ModelMap model ,  HttpServletRequest request) {
        popService.categoryIndex(vo);
        /* 이전소스
        String hostNm = CmsUtil.getHostName(request.getServerName());*/

        //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경
        // 변경소스
        String hostNm ="korean";
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
     * 서비스 반려사유 팝업
     */
    @RequestMapping(value = "PD_returnReasonPop.do")
    public void returnReasonPop(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        //vo.setExmntConfmCd(1003);   //검토반려
        
        if(vo.getGoodsStatus() == null)
            vo.setExmntConfmCd(1003);   //검토반려
        else  vo.setExmntConfmCd(vo.getGoodsStatus()); 
        
        // 반려사유
        GoodsManageVO dataVo = service.returnReason(vo);
        model.addAttribute("dataVO",dataVo );

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
    public boolean emailCrtfcAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo, RegisterUserVO vo) {

        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL

        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
        // 추가소스
        String DomainName = GlobalConfig.DOMAIN_SUBNM;
        //}}
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

            vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
            if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_GOOD_EMNT);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소

            /*
             * 메일 템플릿에 적용될 치환값 :
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            hostNm = CmsUtil.getHostName(request.getServerName());
            if("".equals(hostNm) || "www".equals(hostNm)) {
                hostNm = "korean";
            }

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("productTitle", goodsVo.getGoodsNm());
            oneToOneInfoMap.put("productContents",goodsVo.getGoodsSumry());

            oneToOneInfoMap.put("productImg", "http://" + DomainName  + goodsVo.getImageFile().get(0).getFileUrl());
            // 이전소스
            String productUrl = "http://" + DomainName  + "/" + hostNm+"/pt/store/software/BD_view.do?goodsCode="+goodsVo.getGoodsCode();

            oneToOneInfoMap.put("productUrl", productUrl); // 상세페이지

            // 이전소스
            //rtnurl = "http://intra.ceart.kr/intra/explorer/ND_index.do";
            rtnurl = "http://"+GlobalConfig.DOMAIN_ADMNM+"/intra/explorer/ND_index.do";
            oneToOneInfoMap.put("rtnurl", rtnurl);//관리자페이지

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "클라우드스토어 씨앗"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
               /* System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }

            return result;
    }

    /**
     * 서비스관리 엑셀
     */
    @RequestMapping(value = "INC_goodsExcel.do")
    public String goodsListExcel(ModelMap model, HttpServletRequest request, WebGoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);

        //언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String baseURL = getBaseUrl(model,hostNm) ;
        String pageURL = "";
        if(vo.getDataMap().get("q_excel").equals("7")){
            pageURL = "/BD_goodsList.do";
        } else if(vo.getDataMap().get("q_excel").equals("8")){
            pageURL = "/BD_waitingList.do";
        }

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + baseURL + pageURL;
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }
       
        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        vo.getDataMap().put("q_userId", userLoginVO.getUserId());

        if(vo.getDataMap().get("q_excel").equals("7")){
            model.put("_goodsList", service.goodsList(vo));
            model.put("q_excelFileName", "서비스목록");
        } else if(vo.getDataMap().get("q_excel").equals("8")){
            //상태검색조건이 없는경우
            if(Validate.isEmpty(vo.getQ_goodsRegistSttuses())){
                Integer[] goodsRegistSttus;
                goodsRegistSttus = new Integer[] {1001,1002,1003,1004,1005,1008,1009,1010}; // 임시저장,검토대기,검토반려,승인대기,승인반려
                vo.getDataMap().put("goodsRegistSttus", goodsRegistSttus);
            }else{
                vo.getDataMap().put("goodsRegistSttus",vo.getQ_goodsRegistSttuses() );
            }

            vo.setLangCode(commonDutyService.getLangCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request))));

            model.put("_goodsList", service.goodsExmntList(vo));
            model.put("q_excelFileName", "서비스승인대기");
        }
        model.put("q_excel", vo.getDataMap().get("q_excel")); // 목록별 구분값

        GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);

        return responseExcel(model, GoodsManageExcel);
    }
    
    
    /**
     * 서비스 규격 등록폼
     */    
    @RequestMapping(value = "BD_goodsSpecForm.do")
    public String goodsSpecForm(HttpServletRequest request, ModelMap model, GoodsSpecDescribeVO vo) {
     
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsSpecForm.do?goodsCode"+vo.getGoodsCode();
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
            vo.setUserId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }
        
        
        if(vo.getGoodsCode() == null )
            return alertAndRedirect(model, MessageHelper.getMsg(request, "invalidParam"),"/korean/pt/index.do");
        
        /*vo.setUserId(userLoginVO.getUserId());
        vo.setUpdtId(userLoginVO.getUserId());
        vo.setRegistId(userLoginVO.getUserId());  */
        
        model.addAttribute("goodsKndCd",service.getGoodsKindCode(vo.getGoodsCode())); 
        
        //model.addAttribute("specVo", service.goodsSpecInfo(vo));   
        model.addAttribute("specDescribeVo", service.goodsSpecDescribeInfo(vo));
        model.addAttribute("goodsCode",vo.getGoodsCode());
        
        model.addAttribute("entrprsSeList",            registerService.prvCodeList("00", 2075)); // 공통코드의 기업구분 코드(2075)        
        model.addAttribute("svcTyList",                registerService.prvCodeList("00", 2076)); // 공통코드의 서비스유형 코드(2076)
        model.addAttribute("svcEntrprsSuplyTyList",    registerService.prvCodeList("00", 2055)); // 공통코드의 서비스 제공 기업의 공급유형 코드(2055)
        model.addAttribute("dueStdrMummList",          registerService.prvCodeList("00", 2077)); // 공통코드의 과금 기준(최소) 코드(2077)
        model.addAttribute("vatInclsAtList",           registerService.prvCodeList("00", 2078)); // 공통코드의 VAT포함여부 코드(2078)
        model.addAttribute("dataCnterHbrdLcInfoList",  registerService.prvCodeList("00", 2079)); // 공통코드의 데이터센터 국내, 외 위치 정보 코드(2079)
        
        
        //return baseURL + "/BD_goodsSpecForm";
        return baseURL + "/BD_goodsSpecDescribeForm";
    }
    
    
    @RequestMapping(value = "BD_goodsSpecView.do")
    public String goodsSpecView(HttpServletRequest request, ModelMap model, /*GoodsSpecVO*/GoodsSpecDescribeVO vo) {
     
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsSpecView.do?goodsCode"+vo.getGoodsCode();
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setUserId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }
        
       if(vo.getGoodsCode() == null  || vo.getGoodsCode().equals("") || vo.getGoodsCode().length() != 9 )
            return alertAndRedirect(model, MessageHelper.getMsg(request, "invalidParam"),"/korean/pt/index.do");
        
       
       WebGoodsManageVO gvo = new WebGoodsManageVO();
       gvo.setGoodsCode(vo.getGoodsCode());
       gvo.setUserId(vo.getUserId());
       model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(gvo));
       ///model.addAttribute("specVo", service.goodsSpecInfo(vo));
       model.addAttribute("specDescribeVo", service.goodsSpecDescribeInfo(vo));
        /*vo.setUserId(userLoginVO.getUserId());
        vo.setUpdtId(userLoginVO.getUserId());
        vo.setRegistId(userLoginVO.getUserId());  */
       model.addAttribute("goodsCode",vo.getGoodsCode());
       
       //return baseURL + "/BD_goodsSpecView";
       return baseURL + "/BD_goodsSpecDescribeView";
    }
    
    /**
     * 서비스 규격 
     * @param request
     * @param model
     */
    @RequestMapping(value = "BD_goodsSpecSaveAction.do", method = RequestMethod.POST)
    public String goodsSpecSaveAction(HttpServletRequest request, ModelMap model,  GoodsSpecVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        if (Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/sale/goods/BD_goodsSpecForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);

        } else {

            vo.setUserId(userLoginVO.getUserId());
        }
        
        if(vo.getGoodsCode() == null )
            return alertAndRedirect(model, MessageHelper.getMsg(request, "invalidParam"),"/korean/pt/index.do");
        
        List<FileVO> uploadFile = UploadHelper.upload(request, DMANDEXAMIN_EXCEL);
        List<FileVO> specExcelFile = new ArrayList<FileVO>();

        int specNum = service.goodsSpecNum(vo);
        if (specNum > 0)
            vo.setGoodsNum(String.valueOf(specNum));
        else 
            vo.setGoodsNum("1");
        
        /*for(int i = 0 ; i < uploadFile.size() ; i++) {*/
        // UPLOAD 파일 1개        
            String inputNm = uploadFile.get(0).getInputNm();
            if(inputNm.startsWith("dmandExaminFile")) {     // 엑셀 입력 이름 
                specExcelFile.add(uploadFile.get(0));
                File excelFile = uploadFile.get(0).getFile();
                readExclAndDataSave(excelFile, userLoginVO.getUserId(), vo.getGoodsCode(), vo.getGoodsNum());
            }
        /*}*/
        
        vo.setSpecExcelFile(specExcelFile);
        Integer key = service.excelFileSaveAction(vo);
        
        if (Validate.isEmpty(key)) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        } else {        
            return alertAndRedirect(model, MessageHelper.getMsg(request, "saveOk"), "/korean/pt/sale/goods/BD_goodsSpecView.do?goodsCode="+vo.getGoodsCode());
        }
    }
    
    
    /**
     * 서비스 규격 
     * @param request
     * @param model
     */
    @RequestMapping(value = "BD_goodsSpecDescribeSaveAction.do", method = RequestMethod.POST)
    public String goodsSpecDescribeSaveAction(HttpServletRequest request, ModelMap model,  GoodsSpecDescribeVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        if (Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/sale/goods/BD_goodsSpecForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);

        } else {

            vo.setUserId(userLoginVO.getUserId());
        }
        
        if(vo.getGoodsCode() == null )
            return alertAndRedirect(model, MessageHelper.getMsg(request, "invalidParam"),"/korean/pt/index.do");
        

        int specNum = service.goodsSpecDescribeNum(vo);
        if (specNum > 0)
            vo.setGoodsNum(String.valueOf(specNum));
        else 
            vo.setGoodsNum("1");
        
        service.insertGoodsSpecDescribe(vo);
        
        return alertAndRedirect(model, MessageHelper.getMsg(request, "saveOk"), "/korean/pt/sale/goods/BD_goodsSpecView.do?goodsCode="+vo.getGoodsCode());        
    }
    
    /**
     * 엑셀 데이터 저장
     * @param file
     * @param userId
     */
    private void readExclAndDataSave(File file, String userId, String goodsCode, String goodsNum) {

        DmandExaminVO dmandExaminVO;

        //dmandExaminVO.setDmandExaminSn(dmandExaminSn);

        XSSFRow row;
        XSSFCell cell;

        try {
            FileInputStream inputStream = new FileInputStream(file);
            XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
            //sheet수 취득
            int sheetCn = workbook.getNumberOfSheets();

            for (int cn = 0; cn < sheetCn; cn++){
                if (cn < 1) {
                   
                    //0번째 sheet 정보 취득
                    XSSFSheet sheet = workbook.getSheetAt(cn);

                    //취득된 sheet에서 rows수 취득
                    int rows = sheet.getPhysicalNumberOfRows();
                    
                    //취득된 row에서 취득대상 cell수 취득
                    int cells = sheet.getRow(cn).getPhysicalNumberOfCells() + 39; //

                    Map map  = new HashMap();
                    for (int r = 3; r < rows; r++) {
                        row = sheet.getRow(r); // row 가져오기

                        if (row != null) {
                          //  for (int c = 0; c < cells; c++) {
                                cell = row.getCell(2);  // cell가져오기
                                if (cell != null) {
                                    // 엑셀에서 읽어오기     
                                    String cellVal = excelDataExport(workbook, cell);
                                    map.put("goodsSpec"+(r-2), cellVal.trim());
                                } else {
                                  
                                }
                          //  } // for(c) 문
                        }
                    } // for(r) 문 END
                    
                    map.put("goodsUse", "Y");
                    map.put("userId", userId);
                    map.put("goodsCode", goodsCode);
                    map.put("goodsNum", goodsNum);
                    
                    service.inserGoodsSpecExcel(map);
                }
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    private String excelDataExport(XSSFWorkbook workbook, XSSFCell cell) {

        FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator(); // 수식 계산 시 필요

        DecimalFormat df = new DecimalFormat();

        String value = null;
        switch (cell.getCellType()) {
            case XSSFCell.CELL_TYPE_FORMULA:
                if(!(cell.toString().equalsIgnoreCase("")) ){
                    if(evaluator.evaluateFormulaCell(cell)==XSSFCell.CELL_TYPE_NUMERIC){
                        double fddata = cell.getNumericCellValue();
                        value = df.format(fddata);
                    }else if(evaluator.evaluateFormulaCell(cell)==XSSFCell.CELL_TYPE_STRING){                    
                        value = cell.getStringCellValue();
                    }else if(evaluator.evaluateFormulaCell(cell)==XSSFCell.CELL_TYPE_BOOLEAN){
                        boolean fbdata = cell.getBooleanCellValue();
                        value = String.valueOf(fbdata);
                    }
                    return value;
                    //break;
                }
            case XSSFCell.CELL_TYPE_NUMERIC:
                if(DateUtil.isCellDateFormatted(cell)) {
                    value = cell.getDateCellValue().toString();
                } else {
                    value = Integer.toString((int)cell.getNumericCellValue());
                }
                return value;
                //break;

            case XSSFCell.CELL_TYPE_STRING:
                value = cell.getStringCellValue();
                return value;
                //break;
            case XSSFCell.CELL_TYPE_BLANK:
                value = " ";
                return value;
                //break;
            case XSSFCell.CELL_TYPE_ERROR:
                value = String.valueOf(cell.getErrorCellValue());
                return value;
                //break;
            default:
        }
        System.out.print(value + "\t");

        return value;
    }
    
    /*서비스변경요청 요청버튼 클릭(등록) 이벤트*/
    @RequestMapping(value = "/ND_SvcChangeRequstPresentn.do",  method = RequestMethod.POST)
    public String svcChangeRequstPresentn(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {
       
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }       
       
        vo.setUserId(userLoginVo.getUserId());        
        if(service.insertSvcChangeRequstAction(vo) == StringUtil.ONE) {            
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "svcChangeRequstPresentnOk"));
        }
        
        return responseJson(model, Messages.FALSE, "svcChangeRequstPresentnFail");
    }


    @RequestMapping(value = "BD_goodsStatAction.do")
    public String goodsStatAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        vo.setUpdtId(userLoginVO.getUserId());

        
        //int affected = service.dspyUpdate(vo, request);
        int affected = service.goodsStatAction(vo, request);
        
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }

        return responseJson(model, true);
    }    

//    @RequestMapping(value = "ND_cfmItemContent.do", method = RequestMethod.POST)
//    public String cfmItemContent(HttpServletRequest request, ModelMap model, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo){
//
//        String hostNm = "korean";
//        String baseURL = getBaseUrl(model,hostNm) ;
//        Integer affected = 0;
//        
//        // 로그인 회원 체크
//        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
//        RegisterUserVO registerVo = new RegisterUserVO();
//
//        String updateYn = specVo.getUpdateYn();
//        
//        if(Validate.isEmpty(userLoginVo)) {
//            String returnUrl = "?returnUrl=" + baseURL + "/BD_goodsForm.do";
//            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
//        }else{
//          goodsVo.setRegistId(userLoginVo.getUserId());
//          goodsVo.setUpdtId(userLoginVo.getUserId());
//          goodsVo.setUserId(userLoginVo.getMasterId());
//        }
//
//        // 판매하기 권한 체크
//        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
//            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
//        }
//        
//        String goodsCode = null ;
//  
//        goodsCode = request.getParameter("goodsCode");//(String)request.getSession().getAttribute("GoodsCode");
//
//        goodsVo.setGoodsCode(goodsCode); // 새로운 goodsCode
//        
//        goodsVo.setUpdateYn(specVo.getUpdateYn());
//
//        
//        //key = service.goodsUpdate(goodsVo, request);
//            
//        WebGoodsManageVO goodVo = goodsVo;
//
//        //affected = service.goodsUpdate(goodsVo, request);
//        
//        
//        if (affected == -1) {
//            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
//        }
//
//        return responseJson(model, true);
//    }

  
    /**
     * 
     * cfmItemContent 설명
     * @param vo
     * @param model
     * @param request
     * @return
     */

    @RequestMapping(value = "BD_webGoodsFormPopUp.do", method = RequestMethod.GET)
    public String cfmItemContentInfo(WebGoodsManageVO vo, ModelMap model, HttpServletRequest request) {


        String goodsCode = request.getParameter("goodsCode");
        String goodsKndCd = request.getParameter("goodsKndCd");        
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;
        
        vo.setGoodsCode(goodsCode);
        vo.setGoodsKndCd(Integer.parseInt(goodsKndCd));
        
        //vo.setGoodsCode("201802801");
        model.addAttribute("goodsKndCd", Integer.parseInt(goodsKndCd));
        //model.addAttribute("goodsKndCd", 1002);        
        
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("GoodsCode", vo.getGoodsCode());
        parameterMap.put("goodsCode", vo.getGoodsCode());        
        
        model.addAttribute("goodsInfoTmp",  service.goodsInfoTmp_2(parameterMap));
        model.addAttribute("goodsInfo",  service.goodsInfo_2(parameterMap));         
        
        
        model.addAttribute("goodsInfoTmp",  service.goodsInfoTmp_2(parameterMap));
        model.addAttribute("goodsInfo",  service.goodsInfo_2(parameterMap));                
        
        List goodsCateList = service.goodsCateList(parameterMap);
        List goodsCateListTmp = service.goodsCateListTmp(parameterMap);        
        
        model.addAttribute("goodsCateList",  goodsCateList);
        model.addAttribute("goodsCateListTmp", goodsCateListTmp);        
        
        vo.setLangCode("00");
        
        model.addAttribute("dueStdrMumm", registerService.prvCodeList(vo.getLangCode(), 2077)); // 과금기준(2077)

        GoodsSpecDescribeVO specInfoMapTmp;
        GoodsSpecDescribeVO specInfoMap;        
        
        specInfoMapTmp = service.specInfoUpdate_2(parameterMap);
        specInfoMap = service.specInfo_2(parameterMap);
        
        int passYnUpdate = service.getPassYnUpdate(parameterMap);
        int passYn = service.getPassYn(parameterMap);
        
        
        Map<String, Object> cDetailSvc = new HashMap<String, Object> () ; 
        if(passYnUpdate > 0){
            if (specInfoMapTmp.getcDetailSvc().length() > 0 ) {
                String[] cDetail = specInfoMapTmp.getcDetailSvc().split(",");
                List tstCateMgmtList = new ArrayList();
                
                System.out.println("cDetail.length: " + cDetail.length);
                
                for (int i=0; i< cDetail.length; i++ ) {
                    String cDetailStr = cDetail[i];
                    System.out.println("cDetailStr: " + cDetailStr);
                    cDetailSvc.put("cDetailStr", cDetailStr);
                    tstCateMgmtList.add(service.tstCateMgmt(cDetailSvc));
                }
                model.addAttribute("tstCateMgmtUpdate", tstCateMgmtList);
            }        
        }  
        if(passYn > 0){
            if (specInfoMap.getcDetailSvc().length() > 0 ) {
                String[] cDetail = specInfoMap.getcDetailSvc().split(",");
                List tstCateMgmtList = new ArrayList();
                
                System.out.println("cDetail.length: " + cDetail.length);
                
                for (int i=0; i< cDetail.length; i++ ) {
                    String cDetailStr = cDetail[i];
                    System.out.println("cDetailStr: " + cDetailStr);
                    cDetailSvc.put("cDetailStr", cDetailStr);
                    tstCateMgmtList.add(service.tstCateMgmt(cDetailSvc));
                }
                model.addAttribute("tstCateMgmt", tstCateMgmtList);
            }
        }
        
        model.addAttribute("specInfo",  specInfoMap);
        model.addAttribute("specInfoTmp",  specInfoMapTmp);        
        
        model.addAttribute("svcEntrprsSuplyTy", registerService.prvCodeList(vo.getLangCode(), 2055)); // 공급유형(2055)
        model.addAttribute("entrprsSe",         registerService.prvCodeList(vo.getLangCode(), 2075)); // 기업구분(2075)        
        model.addAttribute("metaCnstcMthds",      registerService.prvCodeList(vo.getLangCode(), 2032)); // 구축방식(2032)        
        model.addAttribute("serviceOfferMethod",  registerService.prvCodeList(vo.getLangCode(), 2034)); // 서비스유형(2034)        
        
        String domainLangCode = commonDutyService.getLangCd(Integer.parseInt(new CommonDutyConstant().getDomainCode(hostNm)));
        model.addAttribute("nation", commonDutyService.countryList(domainLangCode));// 등록되어있는 국가 정보

        model.addAttribute("goodsMetaList", service.goodsMetaList(vo));    // 메타인증정보(서비스관리기준(2030),구축방식,지원OS,A/S방침,호환성)
        model.addAttribute("goodsMetaListTmp", service.goodsMetaListTmp(vo));    // 메타인증정보(서비스관리기준(2030),구축방식,지원OS,A/S방침,호환성)        
        model.addAttribute("goodsMetaLang",  service.goodsMetaLang(vo));     // 지원언어        
        
        model.addAttribute("goodsMark", service.goodsMarkCodeList(vo)); // 인증
        model.addAttribute("goodsMarkTmp", service.goodsMarkCodeListTmp(vo)); // 인증        

        model.addAttribute("goodsMarkTmp", service.goodsMarkCodeListTmp(vo)); // 인증        
        
        
        model.addAttribute("goodsCode", vo.getGoodsCode());
        model.addAttribute("exmntConfmHistSn", vo.getExmntConfmHistSn());
        
        
        return baseURL + "/BD_goodsFormPopUpWeb";
        
    }      
  
    
}