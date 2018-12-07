package zes.openworks.intra.store.goods;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
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

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.register.RegisterUserVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.goods.WebGoodsService;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  서비스관리 > 서비스관리
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.   김병욱     신규
 *</pre>
 * @see
 */
@SuppressWarnings("unchecked")
@Controller
@RequestMapping(value = "/intra/store/goods")
public class GoodsManageController extends IntraController  {

    @Autowired WebGoodsService service1;
    @Autowired GoodsManageService service;
    @Autowired PopService popService;
    @Autowired CommonDutyService commonService;
    @Autowired private CommonDutyService commonDutyService;
    
    @Autowired AutoMailService amservice;
    @Autowired SmsTransHistService smsService;
    @Autowired RegisterService registerService;
    
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
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void goodsList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    /**
     * 검토대기목록
     * GoodsExmntList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsExmntList.do")
    public void goodsExmntList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /* 새로운 서비스구분에 맞게 관리자사이트 대쉬보드 수정 */
        if(!Validate.isEmpty(request.getParameter("q_goodsTyCd"))){
            // q_init은 처음에 페이지가 실행될 때  받는 값이 널이거나, 1이면 검색 조건으로 오늘 날짜를 보낸다. 화면단에서 검색 넘길때는 오늘 날짜로 세팅되지 않기위해 0을 보낸다.            vo.getDataMap().put("q_init","0");
        }
        model.addAttribute("q_goodsTyCd", request.getParameter("q_goodsTyCd"));
        /* }} */

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsExmntList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
    }
    
    /**
     * 서비스변경 신청
     * goodsChangeList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsRequstList.do")
    public void goodsReustList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        if(request.getParameter("q_goodsRequstAt") == null){   
            vo.getDataMap().put("q_goodsRequstAt","N");
        }
       
        model.addAttribute("q_goodsTyCd", request.getParameter("q_goodsTyCd"));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsRequestList(vo));
    }

    /**
     * 서비스변경 신청
     * goodsChangeList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsRequstConfirmList.do")
    public void BD_goodsRequstConfirmList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        if(request.getParameter("q_goodsRequstAt") == null){   
            vo.getDataMap().put("q_goodsRequstAt","M");
        }
       
        model.addAttribute("q_goodsTyCd", request.getParameter("q_goodsTyCd"));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsRequestList(vo));
    }
    /**
     * 승인대기목록
     * GoodsConfnList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsConfnList.do")
    public void goodsConfnList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        /* 2016.05.16 BH.YANG 새로운 서비스구분에 맞게 관리자사이트 대쉬보드 수정 */
        //if(!Validate.isEmpty(request.getParameter("q_goodsTyCd"))){
            // q_init은 처음에 페이지가 실행될 때  받는 값이 널이거나, 1이면 검색 조건으로 오늘 날짜를 보낸다. 화면단에서 검색 넘길때는 오늘 날짜로 세팅되지 않기위해 0을 보낸다.
            vo.getDataMap().put("q_init","0");
        //}
       // model.addAttribute("q_goodsTyCd", request.getParameter("q_goodsTyCd"));
       // model.addAttribute("q_goodsTyCd",1002);
        
        /* }} */

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsConfnList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    /**
     * 삭제서비스 목록
     * GoodsDeleteList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsDeleteList.do")
    public void goodsDeleteList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsDeleteList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    /*
     * 전체상품모록관리 전시/비전시 처리
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_dspyUpdateAction.do", method = RequestMethod.POST)
    public String dspyUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        int affected = service.dspyUpdate(vo, request);
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }

        if(affected != StringUtil.ZERO) {

            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                vo.setGoodsCode(vo.getGoodsCodes()[i]);
               /* if(vo.getGoodsRegistSttus() == 1004){ //즉시검토완료
                    // 검토완료 메일보내기
                    goodsExmntCompleteMail(request,model,vo);
                }else*/
                if(vo.getGoodsRegistSttus() == 1007){//즉시 승인완료(전시처리 )
                    //서비스완료 메일보내기
                    goodsCompleteMail(request,model,vo);
                }
            }
            return responseJson(model, true);
        }
        
        return responseJson(model, true);
    }
    
    
    /*
     * 전체상품모록관리 전시/비전시 처리
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_svcChangeRequstUpdate.do", method = RequestMethod.POST)
    public String svcChangeRequstUpdate(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        
        int affected =0;
        if(vo.getRequstSe() != 1003 )
             affected = service.dspyUpdate(vo, request);
        else if(vo.getRequstSe() == 1003 ){
            vo.setGoodsCode(vo.getGoodsCodes()[0]);
            Integer orderCnt = service.orderCnt(vo);
            if (orderCnt > 0) {
                return alertAndBack(model, "현재 구매가 진행중인 건이 있어 삭제를 진행할 수 없습니다.");
            }
           
            affected = service.goodsDelete(vo, request);
           /* if(affected != 1) {
                String url = "BD_index.do";
                return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
            }*/
        }
        
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }      
        return responseJson(model, true);
    }
    
    /*요청한 기능 업데이트*/
    @AuthIntra(authType = AuthType.BASIC) 
    @RequestMapping(value = "ND_updateReuestProcessAt.do", method = RequestMethod.POST)
    public String ND_goodsRequstAt(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        vo.setMngrId(loginVo.getMngrId());
        
        int affected = service.updateReuestProcessAt(vo, request);
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }
        
      /*  if(affected != StringUtil.ZERO) {
            goodsRuestCompleteMail(request,model,vo); // 성공하면 메일/SMS 발송  삭제때문에 발송하고 처리함.
            return responseJson(model, true);
       }*/
        return responseJson(model, true);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_requestUpdateAction.do", method = RequestMethod.POST)
    public String requestUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        vo.setMngrId(loginVo.getMngrId());
        
        int affected = service.requestUpdate(vo, request);
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }
        if(affected != StringUtil.ZERO) {
            goodsRuestCompleteMail(request,model,vo); // 성공하면 메일/SMS 발송  삭제때문에 발송하고 처리함.
            return responseJson(model, true);
        }
        
        return responseJson(model, false);
    }
    /**
     * ctgryList (카테고리 목록)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_ctgryList.do", method=RequestMethod.POST)
    public String ctgryList(GoodsManageVO vo, ModelMap model){

        return responseJson(model, service.ctgryList(vo));
    }

    /**
     * 서비스 상세조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = {"BD_goodsDetail.do", "BD_goodsDetail_v2.do"})
    public void goodsView(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        
        String hostNm = "korean";

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        
        model.addAttribute("storeLang", vo.getLangCode());
        model.addAttribute("goodsMark", service.goodsMarkCodeList(vo)); // 인증
        
        String domainLangCode = commonDutyService.getLangCd(Integer.parseInt(new CommonDutyConstant().getDomainCode(hostNm)));
        model.addAttribute("nation", commonDutyService.countryList(domainLangCode));// 등록되어있는 국가 정보
        
        //        
        // 10007 비전시 1008 재임시저장 1009 재요청 1010 재반로
        /*vo.setExmntConfmCd(vo.getGoodsRegistSttus());
        service.changeView(vo);  //변경사유서 첨부파일 가져오기 */
        GoodsSpecVO gvo = new GoodsSpecVO();
        gvo.setGoodsCode(vo.getGoodsCode());
        model.addAttribute("specVo", service.goodsSpecInfo(gvo));

    }


    /**
     * 검토대기 서비스 상세 조회
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = {"BD_goodsExmntDetail.do", "BD_goodsExmntDetail_v2.do"})
    public void goodsExmntView(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        GoodsSpecVO gvo = new GoodsSpecVO();
        gvo.setGoodsCode(vo.getGoodsCode());
        model.addAttribute("specVo", service.goodsSpecInfo(gvo));
    }

    /**
     * 서비스 상세조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsConfnDetail.do")
    public void goodsConfnView(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        GoodsSpecVO gvo = new GoodsSpecVO();
        gvo.setGoodsCode(vo.getGoodsCode());
        model.addAttribute("suplycnt",  service.suplyCnt(vo));
        model.addAttribute("specVo", service.goodsSpecInfo(gvo));

    }
    
    

    /**
     * 서비스 상세조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_goodsPreViewPop.do")
    public void goodsPreViewPop(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        GoodsSpecVO gvo = new GoodsSpecVO();
        gvo.setGoodsCode(vo.getGoodsCode());
        model.addAttribute("specVo", service.goodsSpecInfo(gvo));
    }

    /**
     * 신규 서비스 즉시 승인
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = {"ND_goodsConfnUpdate.do"}, method=RequestMethod.POST )
    public String goodsUpdateConfn(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        // 로그인 정보 확인
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        // 검토/승인
        vo.setMngrId(loginVo.getMngrId());
        vo.setExmntConfmCd(vo.getGoodsRegistSttus());
        vo.setReturnResn("");
        Integer key = service.reasonAction(vo);

        goodsCompleteMail(request,model,vo);
        String url = "BD_goodsConfnList.do?" + OpHelper.getSearchQueryString(request);
       
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsExmntUpdate.do")
    public String goodsExmntUpdate (HttpServletRequest request, ModelMap model, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVo.getMngrId());

        Integer result = 0;
        String url = "BD_goodsExmntList.do?menuCd=197";
        
        result = service.reasonAction(vo); // 반려사유등록
        
        if(result != 1){
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }else{
            return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
        }
    }

    /**
     * 서비스수정
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsIndexUpdate.do", method=RequestMethod.POST)
    public String goodsUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo, GoodsSpecVO specVo) {
        String svcPc = "";
        String url="";
        String svcFlag = "";
        String formNm = "";
        Integer key = 0;
        
        // 호출 URL 확인 [ND_goodsExmntUpdate.do : 검토완료 / ND_goodsConfnUpdate.do : 승인완료]
        String urlIndex = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1);

        // 로그인 정보 확인
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        
       
        if (Validate.isNotEmpty(request.getParameter("svcPc"))) {
            svcPc = request.getParameter("svcPc").replace(",", "");
        }else{
            svcPc = "";
        }
        vo.setSvcPc(svcPc);
        
        if (Validate.isNotEmpty(request.getParameter("svcFlag"))) {
            svcFlag = request.getParameter("svcFlag");
        }else{
            svcFlag = "AA";
        }
        
        if ("dataForm1".equals(vo.getFormNm()) 
            || "dataForm2".equals(vo.getFormNm()) 
            || "dataForm3".equals(vo.getFormNm()) 
            || "dataForm4".equals(vo.getFormNm())
            || "dataForm14".equals(vo.getFormNm())) { //TST_GOOD_INFO_I
            // 파일 저장경로
            List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
    
            
            // 처리 파일 VO 선언
            List<FileVO> imageMainFile            = new ArrayList<FileVO>();        // 서비스 메인이미지
            List<FileVO> imageFile                = new ArrayList<FileVO>();        // 서비스 이미지File
            List<FileVO> goodsFile                = new ArrayList<FileVO>();        // ??
            List<List<FileVO>> markCrtfcFileList  = new ArrayList<List<FileVO>>();  // 인증구분 파일
            List<FileVO> priceFile                = new ArrayList<FileVO>();        // 가격표 첨부파일
            List<FileVO> mnlFile                  = new ArrayList<FileVO>();        // 서비스소개서
            List<FileVO> dnlFile                  = new ArrayList<FileVO>();        // 사용자메뉴얼
            List<FileVO> etcFile                  = new ArrayList<FileVO>();        // 기타 첨부파일
            
            /************************************************/
            /** STEP1) File VO 바인딩 - 시작 ********************/
            /************************************************/
            for(int i = 0 ; i < uploadFile.size() ; i++) {
                String inputNm = uploadFile.get(i).getInputNm();
    
                // STEP1-1) 이미지 파일 처리
                if (inputNm.startsWith("imageFile")) {
                    // STEP1-1-1) file1은 대표이미지
                    if(inputNm.equals("imageFile1")){
                        imageMainFile.add(uploadFile.get(i));
                    // STEP1-1-2) 이하 사용자화면 이미지
                    }else{
                        imageFile.add(uploadFile.get(i));
                    }
                }
    
                // STEP1-3) 인증구분 파일
                if (inputNm.startsWith("markCrtfcFile")) {
                    List<FileVO> markCrtfcFile  = new ArrayList<FileVO>();
                    markCrtfcFile.add(uploadFile.get(i));
                    //markCrtfcFile0    //클라우드서비스보안인증(CSAP)
                    //markCrtfcFile1    //CC인증
                    //markCrtfcFile3    //클라우드서비스 품질성능 확인
                    markCrtfcFileList.add(markCrtfcFile);
                }
    
                // STEP1-4) 가격표 파일
                if (inputNm.equals("priceFile1")) {
                    priceFile.add(uploadFile.get(i));
                }
    
                // STEP1-5) 서비스소개서 파일
                if (inputNm.startsWith("mnlFile")) {
                    mnlFile.add(uploadFile.get(i));
                }
    
                // STEP1-6) 사용자메뉴얼 파일
                if (inputNm.startsWith("dnlFile")) {
                    dnlFile.add(uploadFile.get(i));
                }
    
                // STEP1-7) 기타첨부파일 파일
                if (inputNm.startsWith("etcFile")) {
                    etcFile.add(uploadFile.get(i));
                }

            }
            
            // STEP1-8) GoodsManageVO(저장용) VO 에 바인딩
            vo.setImageMainFile(imageMainFile);     // 서비스 메인 이미지
            vo.setImageFile(imageFile);             // 사용자 화면이미지
            vo.setGoodsFile(goodsFile);             // ??
            vo.setMarkCrtfcFile(markCrtfcFileList); // 인증정보 이미지
            vo.setPriceFile(priceFile);             // 가격표 파일
            vo.setMnlFile(mnlFile);                 // 서비스소개서 파일
            vo.setDnlFile(dnlFile);                 // 사용자메뉴얼 파일
            vo.setEtcFile(etcFile);                 // 기타 첨부파일
            /************************************************/
            /** STEP1) File VO 바인딩 - 끝 *********************/
            /************************************************/
        
            // STEP1-8) GoodsManageVO(저장용) VO 에 바인딩
            vo.setImageMainFile(imageMainFile);     // 서비스 메인 이미지
            vo.setImageFile(imageFile);             // 사용자 화면이미지
            
            if ("dataForm3".equals(vo.getFormNm())) {
                Integer[] archtcSeArry = vo.getArchtcSeArry();
                Integer archtcSe = 0;
                if (Validate.isNotEmpty(archtcSeArry)) {
                    for (int i=0; i < archtcSeArry.length; i++)
                    {
                        archtcSe += archtcSeArry[i];
                    }
                }
                vo.setArchtcSe(archtcSe);
            }
            
            key = service.goodsUpdate(vo, request);
        
        }else{//TST_GOOD_SPEC_DESCRIBE_I
            String svcChargerEmail = "";
            String svcChargerTelno = "";
            String svcChargerMbtlNum = "";

            if ("dataForm13".equals(vo.getFormNm())) {
                if (Validate.isNotEmpty(request.getParameter("svcChargerEmail1")) 
                    && Validate.isNotEmpty(request.getParameter("svcChargerEmail2"))) {
                    svcChargerEmail = request.getParameter("svcChargerEmail1") + "@" + request.getParameter("svcChargerEmail2");
                    specVo.setSvcChargerEmail(svcChargerEmail);
                }
                if (Validate.isNotEmpty(request.getParameter("svcChargerTelno1")) 
                    && Validate.isNotEmpty(request.getParameter("svcChargerTelno2")) 
                    && Validate.isNotEmpty(request.getParameter("svcChargerTelno3"))) {
                    
                    svcChargerTelno = request.getParameter("svcChargerTelno1") + "-" + request.getParameter("svcChargerTelno2") + "-" + request.getParameter("svcChargerTelno3");
                    specVo.setSvcChargerTelno(svcChargerTelno);
                }
                if (Validate.isNotEmpty(request.getParameter("svcChargerMbtlNum1"))
                    && Validate.isNotEmpty(request.getParameter("svcChargerMbtlNum2"))
                    && Validate.isNotEmpty(request.getParameter("svcChargerMbtlNum3"))) {
                    svcChargerMbtlNum = request.getParameter("svcChargerMbtlNum1") + "-" + request.getParameter("svcChargerMbtlNum2") + "-" + request.getParameter("svcChargerMbtlNum3");
                    specVo.setSvcChargerMbtlNum(svcChargerMbtlNum);
                }
            }
            key = service.updateTstGoodSpecDescribeI(specVo);
        }
        
        
        if(Validate.isEmpty(key)) {
            return alertAndBack(model,MessageHelper.getMsg(request, "processFail"));
        } else if (key == -1) {
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsChangeStatus"));
        } 
        
        
        
        if (urlIndex.equals("ND_goodsIndexUpdate.do")) {
            if ("AA".equals(svcFlag)) {
                url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
            }else if ("AB".equals(svcFlag)) {
                url = "BD_goodsDetail.do?goodsCode=" + vo.getGoodsCode();
            }else if ("BB".equals(svcFlag)) {
                url = "BD_goodsExmntList.do?" + OpHelper.getSearchQueryString(request);
            }else if ("BC".equals(svcFlag)) {
                url = "BD_goodsExmntDetail.do?goodsCode="+vo.getGoodsCode()+"&"+OpHelper.getSearchQueryString(request);
            }
        }
        
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }
    

    
    /**
     * 서비스 등록폼
     */    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsForm.do")
    public void goodsForm(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);

        if(vo.getLangCode()==null){
            vo.setLangCode("00");
        }
//        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        model.addAttribute("goodsMark", service.goodsMarkCodeList(vo));
        model.addAttribute("goodsMetaLang", service.goodsMetaLang(vo));
    }

    /**
     * 서비스등록
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsInsertAction.do", method=RequestMethod.POST )
    public String goodsInsertAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        // 처리자 ID 가져오기
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());

        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);

        // 처리 파일 VO 선언
        List<FileVO> imageMainFile            = new ArrayList<FileVO>();        // 서비스 메인이미지
        List<FileVO> imageFile                = new ArrayList<FileVO>();        // 서비스 이미지File
        List<FileVO> goodsFile                = new ArrayList<FileVO>();        // ??
        List<List<FileVO>> markCrtfcFileList  = new ArrayList<List<FileVO>>();  // 인증구분 파일
        List<FileVO> priceFile                = new ArrayList<FileVO>();        // 가격표 첨부파일
        List<FileVO> mnlFile                  = new ArrayList<FileVO>();        // 서비스소개서
        List<FileVO> dnlFile                  = new ArrayList<FileVO>();        // 사용자메뉴얼
        List<FileVO> etcFile                  = new ArrayList<FileVO>();        // 기타 첨부파일

        /************************************************/
        /** STEP1) File VO 바인딩 - 시작 ********************/
        /************************************************/
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            // STEP1-1) 이미지 파일 처리
            if (inputNm.startsWith("imageFile")) {
                // STEP1-1-1) file1은 대표이미지
                if(inputNm.equals("imageFile1")){
                   imageMainFile.add(uploadFile.get(i));
                // STEP1-1-2) 이하 사용자화면 이미지
                }else{
                    imageFile.add(uploadFile.get(i));
                }
            }

            // STEP1-2) ????
/*
            if ("goodsFile".equals(inputNm)) {
                goodsFile.add(uploadFile.get(i));
            }
*/
            // STEP1-3) 인증구분 파일
            if (inputNm.startsWith("markCrtfcFile")) {
                List<FileVO> markCrtfcFile  = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            // STEP1-4) 가격표 파일
            if (inputNm.equals("priceFile1")) {
                priceFile.add(uploadFile.get(i));
            }

            // STEP1-5) 서비스소개서 파일
            if (inputNm.startsWith("mnlFile")) {
                mnlFile.add(uploadFile.get(i));
            }

            // STEP1-6) 사용자메뉴얼 파일
            if (inputNm.startsWith("dnlFile")) {
                dnlFile.add(uploadFile.get(i));
            }

            // STEP1-7) 기타첨부파일 파일
            if (inputNm.startsWith("etcFile")) {
                etcFile.add(uploadFile.get(i));
            }
        }

        // STEP1-8) GoodsManageVO(저장용) VO 에 바인딩
        vo.setImageMainFile(imageMainFile);     // 서비스 메인 이미지
        vo.setImageFile(imageFile);             // 사용자 화면이미지
        vo.setGoodsFile(goodsFile);             // ??
        vo.setMarkCrtfcFile(markCrtfcFileList); // 인증정보 이미지
        vo.setPriceFile(priceFile);             // 가격표 파일
        vo.setMnlFile(mnlFile);                 // 서비스소개서 파일
        vo.setDnlFile(dnlFile);                 // 사용자메뉴얼 파일
        vo.setEtcFile(etcFile);                 // 기타 첨부파일
        /************************************************/
        /** STEP1) File VO 바인딩 - 끝 *********************/
        /************************************************/


        /************************************************/
        /** STEP2) 아키텍쳐 바인딩 - 시작 **********************/
        /************************************************/
        Integer[] archtcSeArry = vo.getArchtcSeArry();
        Integer archtcSe = 0;
        if (Validate.isNotEmpty(archtcSeArry)) {
            for (int i=0; i < archtcSeArry.length; i++)
            {
                archtcSe += archtcSeArry[i];
            }
        }
        vo.setArchtcSe(archtcSe);
        /************************************************/
        /** STEP2) 아키텍쳐 바인딩 - 끝 ***********************/
        /************************************************/


        /************************************************/
        /** STEP3) 서비스등록 - 시작 **************************/
        /************************************************/
        Integer key = service.goodsInsert(vo, request);
        /************************************************/
        /** STEP3) 서비스등록 - 끝 ****************************/
        /************************************************/


        /************************************************/
        /** STEP4) 검토/승인 처리 - 시작 **********************/
        /************************************************/
        vo.setMngrId(loginVo.getMngrId());
        vo.setExmntConfmCd(vo.getGoodsRegistSttus());
        vo.setReturnResn("");
        key = service.reasonAction(vo);
        /************************************************/
        /** STEP4) 검토/승인 처리 - 끝 ************************/
        /************************************************/


        /************************************************/
        /** STEP5) 처리 결과 후처리 - 시작 **********************/
        /************************************************/
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }else{
            //서비스완료 메일보내기
            goodsCompleteMail(request,model,vo);
        }
        /************************************************/
        /** STEP5) 처리 결과 후처리 - 시작 **********************/
        /************************************************/


        String url = "BD_goodsForm.do";
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }


    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request, GoodsManageVO vo) {
//        setBoardService(request); // 게시판 유형 서비스 설정
        
        int affected = service.fileDeleteManager(fileVO, vo);

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
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsDeleteAction.do", method = RequestMethod.POST)
    public String goodsDeleteAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        Integer orderCnt = service.orderCnt(vo);
        if (orderCnt > 0) {
            return alertAndBack(model, "현재 구매가 진행중인 건이 있어 삭제를 진행할 수 없습니다.");
        }
        Integer cnt = service.goodsDelete(vo, request);
        if(cnt != 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 검토대기로 보내기
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_registUpdateAction.do", method = RequestMethod.POST)
    public String registUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        Integer cnt = service.registUpdate(vo, request);
        if(cnt != 1) {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * ctgrySelect (카테고리 선택)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_ctgrySelect.do", method=RequestMethod.POST)
    public String ctgrySelect(GoodsManageVO vo, ModelMap model) {

        return responseJson(model, service.ctgrySelect(vo));
    }

    @RequestMapping(value = "ND_fileCountChk.do", method = RequestMethod.POST)
    public String fileCountCheck(HttpServletRequest request, ModelMap model){
        Integer fileSeq = Integer.valueOf(request.getParameter("fileSeq"));
        Integer fCnt = Integer.valueOf(request.getParameter("fCnt"));
        Integer maxCnt = Integer.valueOf(request.getParameter("maxCnt"));

        String message = new String(); //retrun 메시지
        message = "";

        Integer cnt = service.fileCount(fileSeq);
        if ((cnt + fCnt) > maxCnt) {
            message = "최대 파일첨부 개수는 " + maxCnt + "개 입니다.";
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
        if (request.getParameter("fileExt")=="1") {
            fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai,zip";
        }
//        String fileExtPermit = request.getParameter("fileExt").toLowerCase();

        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다.

        long maxFileSize = Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024;

        int result = 100;   // 100 : 패스

        String message = new String(); //retrun 메시지

        // 파일 체크
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
                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 break;
            case 201:
                 message = "파일의 종류는 " + fileExtPermit + " 파일만 가능합니다.";
                 break;
            default:
                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
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
                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 break;
            case 201:
                message = "이미지 파일의 유형(확장자)은 jpg, gif, png 파일만 가능합니다.";
                break;
            case 301:
                 message = "이미지의 가로크기가 "+ minWidthSize +" 보다 작습니다.";
                 break;
            case 302:
                 message = "이미지의 세로크기가 "+ minHeightSize +" 보다 작습니다.";
                 break;
            case 303:
                 message = "이미지의 비율(4:3)이 맞지 않습니다.";
                 break;
            case 304:
                message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다..";
                break;
            case 305:
                message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다.";
                break;
            case 400:
                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 break;
            default:
                 message = "이미지가 확인되지 않았습니다.";
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
        int ret = service.techCtgryChk(vo);
        if (ret > 0) {
            return responseText(model, Boolean.TRUE);
        } else {
            return responseText(model, Boolean.FALSE);
        }
    }

    /**
     * 서비스변경코드로 내역추가
     */
//    @RequestMapping(value = "ND_chngHistCodeInsert.do", method = RequestMethod.POST)
//    public Integer chngHistCodeInsert(HttpServletRequest request, GoodsManageVO vo, ModelMap model){
//        LoginVO loginVo = OpHelper.getMgrSession(request);
//        vo.setUpdtId(loginVo.getMngrId());
//        return service.chngHistCodeInsert(vo);
//    }

    /**
     * 서비스변경이력 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_goodsChngHist.do")
    public String goodsChngHist( GoodsManageVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsChngHist(vo));
        return "/intra/store/PD_goodsChngHist";
    }
    
        
    /**
     * 서비스변경신청이력 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_goodsChngRegHist.do")
    public String PD_goodsChngRegHist( GoodsManageVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsChngRegHist(vo));
        return "/intra/store/PD_goodsChngRegHist";
    }
    
    /**
     * 서비스규격서이력 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_goodsSpecHist.do")
    public String goodsSpecHist( GoodsManageVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsSpecHist(vo));
        return "/intra/store/PD_goodsSpecHist";
    }

    /**
     * 카테고리 팝업 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_categoryPop.do")
    public String categoryPop(CategoryVO vo, ModelMap model) {
        popService.categoryIndex(vo);
        return "/intra/store/PD_categoryPop";
    }

    /**
     * 카테고리 관리 목록 for treeList
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_categoryList.do")
    public String categoryList(CategoryVO vo, ModelMap model) {
        return responseJson(model, popService.categoryList(vo));
    }

    /**
     * 판매자 목록(팝업)
     */
    @RequestMapping(value = "PD_sellerListPop.do")
    public void sellerListPop(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.sellerListPop(vo));
        model.addAttribute("langList", commonService.serviceLangList());
    }

    /**
     * 서비스관리 엑셀
     */
    @RequestMapping(value = "INC_goodsExcel.do")
    public String goodsListExcel(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        if(vo.getDataMap().get("q_excel").equals("1")){
            model.put("_goodsList", service.goodsList(vo));
            model.put("q_excelFileName", "전체서비스");
        } else if(vo.getDataMap().get("q_excel").equals("2")){
            model.put("_goodsList", service.goodsExmntList(vo));
            model.put("q_excelFileName", "검토대기 서비스");
        } else if(vo.getDataMap().get("q_excel").equals("3")){
            model.put("_goodsList", service.goodsConfnList(vo));
            model.put("q_excelFileName", "신규서비스 승인대기");
        }
        model.put("q_excel", vo.getDataMap().get("q_excel")); // 목록별 구분값

        GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);

        return responseExcel(model, GoodsManageExcel);
    }

    /**
     * 정보변경 이력 
     */
    @RequestMapping(value = "PD_svcChangeRequstPop.do")
    public void PD_svcChangeRequstPop(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        
        //요청구분(상품요청상태)(전시:1001(1006),비전시:1002(1007),삭제:1003)
        if(vo.getGoodsRegistSttus() == 1006)
            vo.setRequstSe(1001);
        else if(vo.getGoodsRegistSttus() == 1007)
            vo.setRequstSe(1002);
        else if(vo.getGoodsRegistSttus() == 9999)
            vo.setRequstSe(1003);
        
        model.addAttribute("goodsRegistSttus",  vo.getGoodsRegistSttus());
        model.addAttribute("requstSe",  vo.getRequstSe());
        
    }
    
  
    
    
    /**
     * 서비스 검토대기 반려사유 팝업
     */
    @RequestMapping(value = "PD_returnReasonPop.do")
    public void returnReasonPop(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);

        if(  vo.getConfmReturnSection() != null && Validate.isNotEmpty(vo.getConfmReturnSection())  && vo.getConfmReturnSection() == 1005){ // 승인반려사유보기 팝업
            if(vo.getExmntConfmCd() == 1005){
                vo.setExmntConfmCd(1005);
                model.addAttribute("dataReason", service.reasonView(vo));
                //검토관리자 정보 조회
                GoodsManageVO eManagerVO = service.eManagerInfo(vo);
                eManagerVO.setConfmReturnSection(1005);
                model.addAttribute("dataVO", eManagerVO);
            }

        }else{//반려팝업
            if(vo.getExmntConfmCd() == 1003 || vo.getExmntConfmCd() == 1010){ //검토대기페이지 팝업
                //판매자 정보 조회
                GoodsManageVO sellerInfoVO = service.sellerInfo(vo);
                sellerInfoVO.setExmntConfmCd(vo.getExmntConfmCd());
                sellerInfoVO.setExmntConfmHistSn(vo.getExmntConfmHistSn());
                model.addAttribute("dataVO",sellerInfoVO );
             
            }

            if(vo.getExmntConfmCd() == 1005){ // 승인대기페이지 팝업
                vo.setExmntConfmCd(1004);
                model.addAttribute("dataReason", service.reasonView(vo));
                //검토관리자 정보 조회
                GoodsManageVO eManagerVO = service.eManagerInfo(vo);
                eManagerVO.setExmntConfmCd(1005);
                model.addAttribute("dataVO", eManagerVO);
            }

        }
    }

    /**
     * 서비스 검토대기 반려사유 등록액션
     */
    @RequestMapping(value = "ND_reasonAction.do")
    public String reasonAction(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVo.getMngrId());

        Integer result = service.reasonAction(vo); // 반려사유등록

        if(result != 1){
            return responseText(model, "false");
        }else{
            return responseText(model, "true");
        }
    }

   
    
    /**
     * 서비스 변경 요청 완료 메일/SMS 보내기
     */
    public void goodsRuestCompleteMail(HttpServletRequest request,ModelMap model,  GoodsManageVO vo) {

        GoodsManageVO sellerGoodsVo = vo; // 판매자정보
        GoodsManageVO goodVo = vo; // 서비스정보

        RegisterUserVO registerVo = new RegisterUserVO();

        //서비스 변경 신청 조회
        sellerGoodsVo = service.requestUserInfo(vo);

        if(sellerGoodsVo != null && Validate.isNotEmpty(sellerGoodsVo.getGoodsChargerEmail())){
            registerVo.setUserNm(sellerGoodsVo.getGoodsChargerNm());
            registerVo.setEmail(sellerGoodsVo.getGoodsChargerEmail());
            registerVo.setMbtlnum(sellerGoodsVo.getGoodsChargerMbtlnum());
            registerVo.setUserTyCd(sellerGoodsVo.getUserTyCd());

            goodVo = service.goodsMailView(vo);
         // goodVo = service.goodsView(vo);
            goodVo.setMailSection(44);
            //이메일 전송
            emailCrtfcAction(request, model, goodVo, registerVo);
        }
    }

    
    /**
     * 즉시승인, 관리자 서비스등록시 서비스등록완료 메일/SMS 보내기
     */
    public void goodsCompleteMail(HttpServletRequest request,ModelMap model,  GoodsManageVO vo) {

        GoodsManageVO sellerGoodsVo = vo; // 판매자정보
        GoodsManageVO goodVo = vo; // 서비스정보

        RegisterUserVO registerVo = new RegisterUserVO();

        //판매자+서비스정보 조회
        sellerGoodsVo = service.sellerInfo(vo);

        if(sellerGoodsVo != null && Validate.isNotEmpty(sellerGoodsVo.getGoodsChargerEmail())){
            registerVo.setUserNm(sellerGoodsVo.getGoodsChargerNm());
            registerVo.setEmail(sellerGoodsVo.getGoodsChargerEmail());
            registerVo.setMbtlnum(sellerGoodsVo.getGoodsChargerMbtlnum());
            registerVo.setUserTyCd(sellerGoodsVo.getUserTyCd());

            goodVo = service.goodsView(vo);
            goodVo.setMailSection(43);
            //이메일 전송
            emailCrtfcAction(request, model, goodVo, registerVo);
        }
    }

    /**
     * 검토대기완료 메일 보내기
     */
    public void goodsExmntCompleteMail(HttpServletRequest request,ModelMap model,  GoodsManageVO vo) {

        GoodsManageVO goodVo = vo; // 서비스정보
        RegisterUserVO registerVo = new RegisterUserVO();

        //관리자 정보(승인권한관리자)
        vo.setAuthCode("omp_gdcf_adm");
        List<GoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보

        for(int i = 0 ; i < eManagerList.size() ; i++) {
            if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){

                registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                registerVo.setEmail(eManagerList.get(i).getEmail());

                goodVo = service.goodsView(vo);
                goodVo.setMailSection(42);
                //이메일 전송
                emailCrtfcAction(request, model, goodVo, registerVo);
            }
        }
    }

    /**
     * 이메일 발송 액션
     * emailCrtfcAction 설명
     * @param request
     * @param model
     * @param vo
     * @return
     */
    public boolean emailCrtfcAction(HttpServletRequest request, ModelMap model, GoodsManageVO goodsVo, RegisterUserVO vo) {

        //이력 쌓기
//        registerService.mailCrtfcInsert(vo);
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
            if("00".equals(goodsVo.getLangCode())) { // 한국어사이트
                if(goodsVo.getMailSection() == 42){autoMap.put("automailId", AutoMailTemplate.KOR_GOOD_CNFM);}
                if(goodsVo.getMailSection() == 43){autoMap.put("automailId", AutoMailTemplate.KOR_GOOD_REG);}
                if(goodsVo.getMailSection() == 44){autoMap.put("automailId", AutoMailTemplate.KOR_GOOD_CHG);}  //

                hostNm="korean";
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소
            /*
             * 메일 템플릿에 적용될 치환값 :
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("productTitle", goodsVo.getGoodsNm());
            oneToOneInfoMap.put("productContents",goodsVo.getGoodsSumry());

            oneToOneInfoMap.put("productImg", "http://" + GlobalConfig.DOMAIN_SUBNM + goodsVo.getImageFile().get(0).getFileUrl());
            String productUrl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/" + hostNm+"/pt/store/software/BD_view.do?goodsCode="+goodsVo.getGoodsCode();
            oneToOneInfoMap.put("productUrl", productUrl); // 상세페이지

            String httpStr = "";
            if ("www.ceart.kr".equals(GlobalConfig.DOMAIN_SUBNM)) {
                httpStr = "https://";
            }else {
                httpStr = "http://";
            }
            
            if(goodsVo.getMailSection() == 42){
                rtnurl = httpStr+GlobalConfig.DOMAIN_ADMNM+"/intra/explorer/ND_index.do";//관리자페이지

            }else if(goodsVo.getMailSection() == 43){
                rtnurl = httpStr+GlobalConfig.DOMAIN_SUBNM+"/"+hostNm+"/pt/sale/goods/BD_goodsList.do";//서비스관리목록페이지
                
            }else if(goodsVo.getMailSection() == 44){
                rtnurl = httpStr+GlobalConfig.DOMAIN_SUBNM+"/"+hostNm+"/pt/sale/goods/BD_goodsList.do";//서비스관리목록페이지
            }
            
            oneToOneInfoMap.put("rtnurl", rtnurl);

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
                /*  System.out.println("########################################################");
                  System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                  System.out.println("########################################################");*/
              } else {
                 /* System.out.println("########################################################");
                  System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                  System.out.println("########################################################");*/
              }

            /** SMS발송시작 **/
            if(goodsVo.getMailSection() == 43){
                if(vo.getMbtlnum() != null){
                    Map<String, Object> smsMap = new HashMap<String, Object>();

                    //SMS발송 및 전송이력쌓기
                    SmsTransHistConstant shc = new SmsTransHistConstant();
                    //수신번호-필수
                    smsMap.put("rcvNo", vo.getMbtlnum());
                    //발신내용-필수
                    if("00".equals(goodsVo.getLangCode())) { // 한국어사이트
                        smsMap.put("msg", shc.getSmsMsg("243"));
                    }
                    //업무코드
                    smsMap.put("dutyCd", "ST");
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
            }else if(goodsVo.getMailSection() == 44){
                if(vo.getMbtlnum() != null){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    //SMS발송 및 전송이력쌓기
                    SmsTransHistConstant shc = new SmsTransHistConstant();
                    //수신번호-필수
                    smsMap.put("rcvNo", vo.getMbtlnum());
                    //발신내용-필수
                    smsMap.put("msg", shc.getSmsMsg("572"));
                    smsMap.put("dutyCd", "ST");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                    model.addAttribute("smsRst", smsRst);
                }
            }
                /** SMS발송끝 **/
            return result;
    }



    /**
     * 모니터링서비스목록
     * GoodsMonitorList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsMonitorList.do")
    public void goodsMonitorList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        vo.setGoodsRegistSttus(1006);
        vo.getDataMap().put("q_goodsMonitorUrlChk", "Y");
        Pager<GoodsManageVO> goodsList = service.goodsList(vo);

        for(GoodsManageVO data : goodsList.getList()) {
            data.setGoodsServiceState(getResponseCode(data.getGoodsMonitorUrl()));
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, goodsList);

    }


    public static String getResponseCode(String urlString) {
        String rtnStr = "";
        try {
            URL u = new URL(urlString);
            HttpURLConnection huc =  (HttpURLConnection)  u.openConnection();
            huc.setRequestMethod("GET");
            huc.connect();
            rtnStr = Integer.toString(huc.getResponseCode());
        } catch (MalformedURLException e) {
            rtnStr = e.getMessage();
        } catch (IOException e) {
            rtnStr = e.getMessage();
        } catch (Exception e) {
            rtnStr = e.getMessage();
        }
        return rtnStr;
    }


    /**
     * 서비스 모니터링 내역
     * GoodsMonitorHistory 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsMonitorHistory.do")
    public void goodsMonitorHistory(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        Pager<GoodsManageVO> goodsMonitorHistory = service.goodsMonitorHistory(vo);

        model.addAttribute(GlobalConfig.KEY_PAGER, goodsMonitorHistory);

    }
 
    /**
     * 조달청서비스정보리스트
     * goodPpsList 설명
     * 201612
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsPpsList.do")
    public void goodsPpsList(HttpServletRequest request, ModelMap model, GoodsPPSVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsPpsList(vo));
 
    }

    /**
     * 조달청서비스정보 서비스코드 UPDATE
     * 201612
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsCdUpdateAction.do", method = RequestMethod.POST)
    public String goodsCdUpdateAction(HttpServletRequest request, ModelMap model, GoodsPPSVO vo) {
  
        int affected = service.goodsCdUpdate(vo, request);
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }

        return responseJson(model, true);
    }  


    /**
     * 
     * goodsReustList 설명
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_goodsFormPopUp.do")
    public void BD_goodsFormPopUp(HttpServletRequest request, ModelMap model, GoodsManageVO vo, WebGoodsManageVO goodsVo) {

        OpHelper.bindSearchMap(vo, request);
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        vo.setMngrId(loginVo.getMngrId());
        
        String goodsCode = request.getParameter("goodsCode");
        String goodsKndCd = request.getParameter("goodsKndCd");        
        String hostNm = "korean";
        
        vo.setGoodsCode(goodsCode);
        //vo.setGoodsCode("201802801");

        goodsVo.setGoodsCode(vo.getGoodsCode());
        vo.setGoodsKndCd( Integer.parseInt(goodsKndCd) );        
        
        model.addAttribute("goodsKndCd", vo.getGoodsKndCd());
        //model.addAttribute("goodsKndCd", 1002);        
        
        
        //if(request.getParameter("q_goodsRequstAt") == null){   
            //vo.getDataMap().put("q_goodsRequstAt","N");
        //}
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("GoodsCode", vo.getGoodsCode());
        parameterMap.put("goodsCode", vo.getGoodsCode());
        
        
        Integer tmpCnt = service.goodCodeTmpCount(vo);        
        
        model.addAttribute("tmpCnt", tmpCnt);
        
        model.addAttribute("goodsInfoTmp",  service1.goodsInfoTmp_2(parameterMap));
        model.addAttribute("goodsInfo",  service1.goodsInfo_2(parameterMap));                
        
        List<Map<String, Object>> goodsCateList = service1.goodsCateList(parameterMap);
        List<Map<String, Object>> goodsCateListTmp = service1.goodsCateListTmp(parameterMap);        
        
        model.addAttribute("goodsCateList",  goodsCateList);
        model.addAttribute("goodsCateListTmp", goodsCateListTmp);        
        
        goodsVo.setLangCode("00");
        
        model.addAttribute("dueStdrMumm", registerService.prvCodeList(goodsVo.getLangCode(), 2077)); // 과금기준(2077)

        GoodsSpecDescribeVO specInfoMapTmp;
        GoodsSpecDescribeVO specInfoMap;        
        
        specInfoMapTmp = service1.specInfoUpdate_2(parameterMap);
        specInfoMap = service1.specInfo_2(parameterMap);

        
        int passYnUpdate = service1.getPassYnUpdate(parameterMap);
        int passYn = service1.getPassYn(parameterMap);
        
        Map<String, Object> cDetailSvc = new HashMap<String, Object> () ; 
        if(passYnUpdate > 0){
            if (specInfoMapTmp.getcDetailSvc().length() > 0 ) {
                String[] cDetail = specInfoMapTmp.getcDetailSvc().split(",");
                List<Map<String, Object>> tstCateMgmtList = new ArrayList<Map<String, Object>>();
                
                for (int i=0; i< cDetail.length; i++ ) {
                    String cDetailStr = cDetail[i];
                    System.out.println("cDetailStr: " + cDetailStr);
                    cDetailSvc.put("cDetailStr", cDetailStr);
                    tstCateMgmtList.add(service1.tstCateMgmt(cDetailSvc));
                }
                model.addAttribute("tstCateMgmtUpdate", tstCateMgmtList);
            }
        }
        if(passYn > 0){

            if (specInfoMap.getcDetailSvc().length() > 0 ) {
                String[] cDetail = specInfoMap.getcDetailSvc().split(",");
                List<Map<String, Object>> tstCateMgmtList = new ArrayList<Map<String, Object>>();
                
                System.out.println("cDetail.length: " + cDetail.length);
                
                for (int i=0; i< cDetail.length; i++ ) {
                    String cDetailStr = cDetail[i];
                    System.out.println("cDetailStr: " + cDetailStr);
                    cDetailSvc.put("cDetailStr", cDetailStr);
                    tstCateMgmtList.add(service1.tstCateMgmt(cDetailSvc));
                }
                model.addAttribute("tstCateMgmt", tstCateMgmtList);
            }
        }
        
        model.addAttribute("specInfo",  specInfoMap);
        model.addAttribute("specInfoTmp",  specInfoMapTmp);        
        
        model.addAttribute("svcEntrprsSuplyTy", registerService.prvCodeList(goodsVo.getLangCode(), 2055)); // 공급유형(2055)
        model.addAttribute("entrprsSe",         registerService.prvCodeList(goodsVo.getLangCode(), 2075)); // 기업구분(2075)        
        model.addAttribute("metaCnstcMthds",      registerService.prvCodeList(goodsVo.getLangCode(), 2032)); // 구축방식(2032)        
        model.addAttribute("serviceOfferMethod",  registerService.prvCodeList(goodsVo.getLangCode(), 2034)); // 서비스유형(2034)        
        
        String domainLangCode = commonDutyService.getLangCd(Integer.parseInt(new CommonDutyConstant().getDomainCode(hostNm)));
        model.addAttribute("nation", commonDutyService.countryList(domainLangCode));// 등록되어있는 국가 정보

        model.addAttribute("goodsMetaList", service1.goodsMetaList(goodsVo));    // 메타인증정보(서비스관리기준(2030),구축방식,지원OS,A/S방침,호환성)
        model.addAttribute("goodsMetaListTmp", service1.goodsMetaListTmp(goodsVo));    // 메타인증정보(서비스관리기준(2030),구축방식,지원OS,A/S방침,호환성)        
        model.addAttribute("goodsMetaLang",  service1.goodsMetaLang(goodsVo));     // 지원언어        
        
        model.addAttribute("goodsMark", service1.goodsMarkCodeList(goodsVo)); // 인증
        model.addAttribute("goodsMarkTmp", service1.goodsMarkCodeListTmp(goodsVo)); // 인증        

        model.addAttribute("goodsMarkTmp", service1.goodsMarkCodeListTmp(goodsVo)); // 인증        
        
        model.addAttribute("gubun", vo.getGubun());        
        model.addAttribute("goodsCode", vo.getGoodsCode());
        model.addAttribute("exmntConfmHistSn", vo.getExmntConfmHistSn());        
        


        
       //System.out.println("1111");
        //model.addAttribute("q_goodsTyCd", request.getParameter("q_goodsTyCd"));
        //model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsRequestList(vo));

//        model.addAttribute("cntInfo", service.mainCntInfo());
//        model.addAttribute(GlobalConfig.KEY_PAGER, service.cntrctManageList(vo));        
        
    }
    
     
    
    /**
     * 
     * cfmItemContent 설명
     * @param vo
     * @param model
     * @param request
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_cfmItemContent.do", method = RequestMethod.POST)
    public String cfmItemContent(GoodsManageVO vo, ModelMap model, HttpServletRequest request) {

        int affected = 0;
        
        // 로그인 회원 체크
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        vo.setMngrId(loginVo.getMngrId());
        
        String strStat = vo.getStat();
        
        if("Y".equals(strStat)){ // 승인
            
            vo.setRequstSe(1001);
            affected = service.requestUpdate(vo, request);
        } else if("N".equals(strStat)){
            affected = service.cfmItemContentUpdate(vo,request); //반려
        }
        

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }      
 
    
}