package zes.openworks.web.sale.cnsl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeCtgVO;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.intra.store.goods.GoodsManageExcelVO;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.register.RegisterUserVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.goods.WebGoodsService;

@Controller
@RequestMapping(value = "/**/pt/sale/cnsl")
public class WebCnslManageController extends WebController {

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
    @RequestMapping(value = "BD_cnslList.do")
    public String goodsList(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        //언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String baseURL = getBaseUrl(model,hostNm) ;
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_cnslList.do";
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
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        vo.getDataMap().put("q_goodsTyCd", "1003");

        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));

        //언어
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

        //노출
        CodeCtgVO codeCtgVO = new CodeCtgVO();
        codeCtgVO.setGrpCd(1008);
        codeCtgVO.setCtgCd("DSPYN");
        codeCtgVO.setLangCode(vo.getLangCode());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_expsr", codeService.prvNmForCtgCd(codeCtgVO));

        return baseURL + "/BD_cnslList";

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
        String hostNm = CmsUtil.getHostName(request.getServerName());
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
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }

        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        vo.getDataMap().put("q_goodsTyCd", "1003");

        //상태검색조건이 없는경우
        if( vo.getQ_goodsRegistSttuses() == null ){
            Integer[] goodsRegistSttus;
            goodsRegistSttus = new Integer[] {1001,1002,1003,1004,1005}; // 임시저장,검토대기,검토반려,승인대기,승인반려
            vo.getDataMap().put("goodsRegistSttus", goodsRegistSttus);
        }else{
            vo.getDataMap().put("goodsRegistSttus",vo.getQ_goodsRegistSttuses() );
        }

        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsExmntList(vo));

        //언어
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

        //상태
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_sttus", service.sttusList(vo));

        //노출
        CodeCtgVO codeCtgVO = new CodeCtgVO();
        codeCtgVO.setGrpCd(1008);
        codeCtgVO.setCtgCd("DSPYN");
        codeCtgVO.setLangCode(vo.getLangCode());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_expsr", codeService.prvNmForCtgCd(codeCtgVO));

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

      //언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
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
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        vo.getDataMap().put("q_goodsTyCd", "1003");

        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsDeleteList(vo));

        //언어
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

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
        return responseJson(model, false);
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
    @RequestMapping(value = "BD_cnslView.do")
    public String cnslView(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        //언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_cnslList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        vo.setUpdtId(userLoginVO.getUserId());
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));

        String domainLangCode = commonDutyService.getLangCd(Integer.parseInt(new CommonDutyConstant().getDomainCode(hostNm)));
        model.addAttribute("nation", commonDutyService.countryList(domainLangCode));// 등록되어있는 국가 정보

        return baseURL + "/BD_cnslView";
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
        //{{SKYOU 2015.12.21  사용자메뉴얼 추가
        List<FileVO> dnlFile = new ArrayList<FileVO>();
        //}}

        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) {
                imageFile.add(uploadFile.get(i));
            }

            if("goodsFile".equals(inputNm)) {
                goodsFile.add(uploadFile.get(i));
            }

            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);

            }

            if(inputNm.startsWith("mnlFile")) {
                mnlFile.add(uploadFile.get(i));
            }

            //{{SKYOU 2015.12.21  사용자메뉴얼 추가
            if(inputNm.startsWith("dnlFile")) {
                dnlFile.add(uploadFile.get(i));
            }
            //}}
        }

        vo.setImageFile(imageFile);
        vo.setGoodsFile(goodsFile);
        vo.setMarkCrtfcFile(markCrtfcFileList);
        vo.setMnlFile(mnlFile);

        //{{SKYOU 2015.12.21  사용자메뉴얼 추가
        vo.setDnlFile(dnlFile);
        //}}

        // 등록 실행
        Integer key = service.goodsUpdate(vo, request);
        if(Validate.isEmpty(key)) {
            return alertAndBack(model,MessageHelper.getMsg(request, "processFail"));
        } else if (key == -1) {
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsChangeStatus"));
        }else{
            WebGoodsManageVO goodVo = vo;
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

                        //이메일 전송
                        emailCrtfcAction(request, model, goodVo, registerVo);
                    }
                }
            }
        }

        String url = "BD_waitingList.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, MessageHelper.getMsg(request, "updateOk"), url);
    }

    /**
     * 서비스 등록폼
     */
    @RequestMapping(value = "BD_cnslForm.do")
    public String goodsFrom(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        //언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_cnslForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        vo.setUserId(userLoginVO.getUserId());
        vo.setUpdtId(userLoginVO.getUserId());
        vo.setRegistId(userLoginVO.getUserId());

//        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
//        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        OpHelper.bindSearchMap(vo, request);


        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        String siteLang = commonDutyService.getLangCd(Integer.parseInt(domainCode));

        model.addAttribute("nation", commonDutyService.countryList(siteLang));// 등록되어있는 국가 정보

        List<WebGoodsManageVO> storeLangList = service.storeLangList(vo);
        boolean siteLangOk = false;
        for(int i = 0; i < storeLangList.size() ; i++) {
            if (siteLang.equals(storeLangList.get(i).getLangCode())) {
                siteLangOk = true;
            }
        }
        model.addAttribute("storeLangList", storeLangList); // 스토어언어조회

        if (Validate.isEmpty(vo.getLangCode())) {
            if (siteLangOk) {
                vo.setLangCode(siteLang);
            } else {
                vo.setLangCode(storeLangList.get(0).getLangCode());
            }
        }
        model.addAttribute("storeLang", vo.getLangCode());

        model.addAttribute("storeLangNm", service.storeLangNm(vo.getLangCode()));
        model.addAttribute("goodsStoreList", service.goodsStoreList(vo)); // 판매자정보
        model.addAttribute("goodsMetaPrice", service.goodsMetaPrice(vo)); // SKYOU 2015.12.18 가격서비스

        return baseURL + "/BD_cnslForm";
    }

    /**
     * 서비스등록
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_goodsInsertAction.do", method = RequestMethod.POST)
    public String goodsInsertAction(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {

        //언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String baseURL = getBaseUrl(model,hostNm) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        if(Validate.isEmpty(userLoginVo)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_cnslForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVo.getUserId());
          vo.setUpdtId(userLoginVo.getUserId());
          vo.setUserId(userLoginVo.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVo.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noAuth"),"/" + hostNm + "/pt/sale/BD_noGradeMember.do");
        }

        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList = new ArrayList<List<FileVO>>();
        List<FileVO> mnlFile = new ArrayList<FileVO>();
        //{{SKYOU 2015.12.21  사용자메뉴얼 추가
        List<FileVO> dnlFile = new ArrayList<FileVO>();
        //}}
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("imageFile")) {
                imageFile.add(uploadFile.get(i));
            }

            if("goodsFile".equals(inputNm)) {
                goodsFile.add(uploadFile.get(i));
            }

            if(inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if(inputNm.startsWith("mnlFile")) {
                mnlFile.add(uploadFile.get(i));
            }

            //{{SKYOU 2015.12.21  사용자메뉴얼 추가
            if(inputNm.startsWith("dnlFile")) {
                dnlFile.add(uploadFile.get(i));
            }
            //}}
        }

        vo.setImageFile(imageFile);
        vo.setGoodsFile(goodsFile);
        vo.setMarkCrtfcFile(markCrtfcFileList);
        vo.setMnlFile(mnlFile);
        //{{SKYOU 2015.12.21  사용자메뉴얼 추가
        vo.setDnlFile(dnlFile);
        //}}

        // 등록 실행
        vo.setGoodsCode(service.goodsCode(vo));
        vo.setSleMthdCd(1002);
        Integer key = service.goodsInsert(vo, request);

        WebGoodsManageVO goodVo = vo;
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }else{

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

                        //이메일 전송
                        emailCrtfcAction(request, model, goodVo, registerVo);
                    }
                }
            }
        }

        String url = "BD_waitingList.do";
        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), url);
    }

    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request) {
        // setBoardService(request); // 게시판 유형 서비스 설정
        int affected = service.fileDelete(fileVO);

        if(affected < 1) {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, affected);
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

        String url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model,  MessageHelper.getMsg(request, "updateOk") , url);
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
        if(request.getParameter("fileExt")=="1") {
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
//                 message = "이미지의 비율(4:3)이 맞지 않습니다.";
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
     * 카테고리 팝업 메인
     */
    @RequestMapping(value = "PD_categoryPop.do")
    public String categoryPop(CategoryVO vo, ModelMap model ,  HttpServletRequest request) {
        popService.categoryIndex(vo);
        String hostNm = CmsUtil.getHostName(request.getServerName());
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
        vo.setExmntConfmCd(1003);   //검토반려
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

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
            // 추가소스
            String DomainName = GlobalConfig.DOMAIN_SUBNM;
            //}}

            if("".equals(hostNm) || "www".equals(hostNm)) {
                hostNm = "korean";
            }

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("productTitle", goodsVo.getGoodsNm());
            oneToOneInfoMap.put("productContents",goodsVo.getGoodsSumry());

            oneToOneInfoMap.put("productImg", goodsVo.getImageFile().get(0).getFileUrl());

            // 이전소스
            //String productUrl = "http://" + hostNm + "ceart.kr/" + hostNm+"/pt/store/premium/BD_view.do?goodsCode="+goodsVo.getGoodsCode();

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
            // 변경소스
            String productUrl = "http://" + DomainName + "/" + hostNm+"/pt/store/premium/BD_view.do?goodsCode="+goodsVo.getGoodsCode();
            //}}
            oneToOneInfoMap.put("productUrl", productUrl); // 상세페이지

            // 이전소스
            //rtnurl = "http://intra.ceart.kr/intra/explorer/ND_index.do";

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
            // 변경소스
            rtnurl = "http://"+GlobalConfig.DOMAIN_ADMNM+"/intra/explorer/ND_index.do";
            //}}
            oneToOneInfoMap.put("rtnurl", rtnurl);//관리자페이지

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
               /* System.out.println("########################################################");
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
        if(vo.getDataMap().get("q_excel").equals("9")){
            pageURL = "/BD_cnslList.do";
        } else if(vo.getDataMap().get("q_excel").equals("10")){
            pageURL = "/BD_waitingList.do";
        }

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + baseURL + pageURL;
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        vo.getDataMap().put("q_goodsTyCd", "1003");

        if(vo.getDataMap().get("q_excel").equals("9")){
            model.put("_goodsList", service.goodsList(vo));
            model.put("q_excelFileName", "IT전문가 서비스 관리");
        } else if(vo.getDataMap().get("q_excel").equals("10")){

            OpHelper.bindSearchMap(vo, request);
            vo.getDataMap().put("q_userId", userLoginVO.getUserId());
            vo.getDataMap().put("q_goodsTyCd", "1003");

            //상태검색조건이 없는경우
            if(Validate.isEmpty(vo.getQ_goodsRegistSttuses())){
                Integer[] goodsRegistSttus;
                goodsRegistSttus = new Integer[] {1001,1002,1003,1004,1005}; // 임시저장,검토대기,검토반려,승인대기,승인반려
                vo.getDataMap().put("goodsRegistSttus", goodsRegistSttus);
            }else{
                vo.getDataMap().put("goodsRegistSttus",vo.getQ_goodsRegistSttuses() );
            }

            vo.setLangCode(commonDutyService.getLangCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request))));

            model.put("_goodsList", service.goodsExmntList(vo));
            model.put("q_excelFileName", "IT전문가 서비스 등록대기");
        }
        model.put("q_excel", vo.getDataMap().get("q_excel")); // 목록별 구분값

        GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);

        return responseExcel(model, GoodsManageExcel);
    }
}