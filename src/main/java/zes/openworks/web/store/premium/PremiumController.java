/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store.premium;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.CookieUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.component.file.FileDAO;
import zes.openworks.component.file.FileService;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.pop.PopVO;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.register.RegisterUserVO;
import zes.openworks.web.store.StoreincService;

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
 *  2014. 11. 6.    이슬버미       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/store/premium")
public class PremiumController extends WebController {

    @Resource
    private FileDAO fileDao;
    @Autowired
    PremiumService service;
    @Autowired
    StoreincService storeService;
    @Autowired
    PopService popService;
    @Autowired
    private CommonDutyService codService;
    @Autowired
    FileService fileService;
    @Autowired
    private AutoMailService amservice;
    @Autowired
    private RegisterService registerService;

    @RequestMapping(value = "/BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
         
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        vo.setGoodsTyCd(1001);
        if  (Validate.isEmpty(vo.getCtgryCode())) {
            vo.setCtgryCode("0");
        }
        if  (Validate.isNotEmpty(vo.getCtgryCode())) {
//            String ctgryInit="";
//            ctgryInit = service.ctgryInit(vo);
//            if (Validate.isEmpty(ctgryInit)) {
//                return;
//            }
//            vo.setCtgryCode(ctgryInit);
//
             model.addAttribute("ctgry", service.ctgry(vo));
//
//            ctgryInit = service.ctgryInit(vo);
//            if (Validate.isEmpty(ctgryInit)) {
//                return;
//            }
//            vo.setCtgryCode(ctgryInit);
//            model.addAttribute("ctgryInit", ctgryInit);
            model.addAttribute("ctgryInit", vo.getCtgryCode());
            //String ctgryPath = service.ctgryPath(vo);
            if (Validate.isNotEmpty(service.ctgryPath(vo))) {
//                model.addAttribute("ctgryPath", ctgryPath.split(","));
                model.addAttribute("ctgryPath", service.ctgryPath(vo));

//                return;
            }

            model.addAttribute("ctgryList", service.ctgryList(vo));
        }
        model.addAttribute("bestList", service.bestList(vo));
        model.addAttribute("rcmdList", service.rcmdList(vo));
        model.addAttribute("bestSellerList", service.bestSellerList(vo));

        vo.getDataMap().put("langCode", vo.getLangCode());
        vo.getDataMap().put("ctgryCode", vo.getCtgryCode());
        vo.getDataMap().put("goodsTyCd", vo.getGoodsTyCd());

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));
    }

    @RequestMapping(value = "/BD_view.do")
    public ModelMap view(HttpServletRequest request, ModelMap model, PremiumVO vo, HttpServletResponse response) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);

        OpHelper.bindSearchMap(vo, request);

        // 조회수 증가를 위한 쿠키 체크
         if(CookieUtil.isIncreateReadCnt(vo.getGoodsCode(), 2, request, response)) {
             service.rdcntUpdate(vo);
         }

        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setLoginUserId(userLoginVo.getUserId());
            service.rcntUpdate(vo);
        }

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        vo.setGoodsTyCd(1001);
        vo.setBbsCd(1008); //사용스토리 게시판코드
        vo.setDomainCd(Integer.parseInt(domainCd));
        model.addAttribute("ctgryPath", service.ctgryPath(vo));
        //타겟 링크
        model.addAttribute("pageUrlNm", vo.getPageUrlNm());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        return model;
    }

    @RequestMapping(value = "/ND_purch.do", method = RequestMethod.POST)
    public String purchInsert(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }else{
            registerVo.setUserId(userLoginVo.getUserId());
            registerVo.setUserTyCd(userLoginVo.getUserTyCd());
            registerVo.setEmail(userLoginVo.getEmail());
            registerVo.setUserNm(userLoginVo.getUserNm());
        }

        vo.setLoginUserId(userLoginVo.getUserId());
        vo.setMbtlnum(userLoginVo.getMbtlnum());
        vo.setPurchsNo(service.getPurchsNo(vo));
        
        if(service.purchInsert(vo) == StringUtil.ONE) {

            //판매자+서비스정보 조회
            GoodsManageVO sellerGoodsVo = service.sellerInfo(vo);
            registerVo.setUserNm(sellerGoodsVo.getGoodsChargerNm());
            registerVo.setEmail(sellerGoodsVo.getGoodsChargerEmail());

            //구매자정보 조회
            PopVO popVO = new PopVO();
            popVO.setPurchsNo(vo.getPurchsNo());
            PopVO purchaserVo = popService.regstCnView(popVO);
            purchaserVo.setGoodsCode(sellerGoodsVo.getGoodsCode());
            purchaserVo.setGoodsNm(sellerGoodsVo.getGoodsNm());
            purchaserVo.setGoodsSumry(sellerGoodsVo.getGoodsSumry());
            purchaserVo.setImageFile(sellerGoodsVo.getImageFile());

            //이메일 전송
            emailCrtfcAction(request, model, purchaserVo, registerVo);

            return responseJson(model, Boolean.TRUE, MessageHelper.getMsg(request, "orderOk"));
        }
        return responseJson(model, Boolean.FALSE);
    }

    @RequestMapping(value = "/ND_purchDownload.do", method = RequestMethod.POST)
    public String purchDownload(HttpServletRequest request, ModelMap model, PremiumVO vo, HttpServletResponse response) throws IOException {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        List<FileVO> goodsFile = new ArrayList<FileVO>();

        vo.setLoginUserId(userLoginVo.getUserId());

        vo.setPurchsNo(service.getPurchsNo(vo));
        if(service.purchInsert(vo) == StringUtil.ONE) {
            goodsFile = fileDao.getFiles(vo.getGoodsFileSeq());
            vo.setGoodsFile(goodsFile);
            String fileId = vo.getGoodsFile().get(0).getFileId();
            FileVO fileVo = fileService.getFile(fileId);
            if(fileVo != null) {
                fileService.updateFileDown(request, fileId);
            }

            return responseDownload(model, fileVo);
//            response.sendRedirect("/component/file/ND_fileDownload.do?id=" + fileId);
//            RequestDispatcher dispatcher = request.getRequestDispatcher("url");
//            dispatcher.forward(request, response);
//            return responseJson(model, Boolean.TRUE);
//                MessageHelper.getMsg(request, "orderOk"));
        }

        return responseJson(model, Boolean.FALSE);
    }

    @RequestMapping(value = "/ND_itst.do", method = RequestMethod.POST)
    public String itstUpdate(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        vo.setLoginUserId(userLoginVo.getUserId());
        if(service.itstUpdate(vo) == StringUtil.ONE) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "watchOk"));
        }
        return responseJson(model, Messages.FALSE, "watchFail");
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
    public boolean emailCrtfcAction(HttpServletRequest request, ModelMap model, PopVO premiumVo, RegisterUserVO vo) {
        //이력쌓기
        registerService.mailCrtfcInsert(vo);
        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL
        boolean result = false;
        

        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
        // 변경소스
        HttpSession hs = request.getSession();
        String DomainName = String.valueOf(hs.getAttribute("domain_name")); 
        //}}
        
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
                autoMap.put("automailId", AutoMailTemplate.KOR_ODER_RQST);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소

            /*
             * 메일 템플릿에 적용될 치환값 :
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            
            //hostNm = CmsUtil.getHostName(request.getServerName());
            if("".equals(hostNm) || "www".equals(hostNm)) {
                hostNm = "korean";
            }

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("product", premiumVo.getGoodsNm()); // 서비스명
            oneToOneInfoMap.put("productTitle", premiumVo.getGoodsNm());
            oneToOneInfoMap.put("productContents",premiumVo.getGoodsSumry());

            if(premiumVo.getUserTyCd().startsWith("10")){
                //구매신청자가 개인인경우
                oneToOneInfoMap.put("name", premiumVo.getUserNm());
                oneToOneInfoMap.put("phone", premiumVo.getOrderMbtlnum());
                oneToOneInfoMap.put("email", premiumVo.getOrderEmail());
            }else{
                //구매신청자가 기업인경우
                oneToOneInfoMap.put("name", premiumVo.getOrderChargerNm());
                oneToOneInfoMap.put("phone", premiumVo.getOrderCmpnyReprsntTelno());
                oneToOneInfoMap.put("email", premiumVo.getOrderChargerEmail());
            }
            oneToOneInfoMap.put("message",premiumVo.getOrderDlivMssage());
            oneToOneInfoMap.put("productImg", "http://" + DomainName  + premiumVo.getImageFile().get(0).getFileUrl());
            
            // 이전소스
            //String productUrl = "http://" + hostNm + ".ceart.kr/" + hostNm+"/pt/store/premium/BD_view.do?goodsCode="+premiumVo.getGoodsCode();
            
            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
            // 변경소스
            String productUrl = "http://"+DomainName +"/" + hostNm+"/pt/store/premium/BD_view.do?goodsCode="+premiumVo.getGoodsCode();
            //}}
            oneToOneInfoMap.put("productUrl", productUrl); // 상세페이지
            // 이전소스
            //rtnurl = "http://" + hostNm + ".ceart.kr/" + hostNm+"/pt/sale/orderManage/BD_orderList.do";
            
            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
            // 변경소스
            rtnurl = "http://" +DomainName+"/" + hostNm+"/pt/sale/orderManage/BD_orderList.do";
            //}}
            oneToOneInfoMap.put("rtnurl", rtnurl);

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
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }

            return result;
    }
}
