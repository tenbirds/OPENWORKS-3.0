/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManage;

import java.awt.image.BufferedImage;
import java.io.IOException;
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
import zes.base.support.OpHelper;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.login.LoginVO;
//import zes.openworks.web.common.CommonDutyConstant;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 10. 14.    	 boseok       	신규
 * 
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/cmMgmt/cmManage")
public class CmManageController extends IntraController{

    
    @Autowired
    CmManageService cmManageService;
    
    @Autowired
    CodeService codeService;
    
    @Autowired
    SmsTransHistService smsService;
    @Autowired
    AutoMailService amservice;
    /**
     * 커뮤니티 개설신청 현황 조회
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        
        vo.setCmmntySttusCd(1001); //  1001:신청     1002:승인     1003:승인보류 1004: 커뮤니티 폐쇄
        model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageService.openCmManageList(vo));
        
    }
    
    /**
     *   커뮤니티 개설신청 다중 승인 조회 팝업 (PD_openInfoView.do) 
     *   커뮤니티 개설신청 거절 (PD_openInfoReject.do) 
     *   커뮤니티 페쇄 상세  ( PD_closeInfoView.do)
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = {"PD_openInfoView.do","PD_openInfoReject.do","PD_closeInfoView.do","PD_approvalRejectClose.do","PD_rejectInfoView.do"} )
    public void openCmManageViewPopUp( HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
         
         OpHelper.bindSearchMap(vo, request);
         cvo.setLangCode("");// 언어코드 모두 가져오기 위해  NULL 처리
         model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 

         model.addAttribute("userEntrprsOption", cmManageService.userEntrprsOptionSelect(vo)); // 기업회원 추가 정보 // 2001    기업회원     2002    기업판매회원
         model.addAttribute("userOption", cmManageService.userOptionSelect(vo)); // 일반회원 추가 정보 //  1001 개인회원     1002 개인판매회원 
         
         model.addAttribute("openCmManageView", cmManageService.openCmManageView(vo)); // 기본정보
         model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
         
    }
    
    /**
     *  커뮤니티 개설신청 승인 및 거절 처리
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_openCmManageUpdate.do")
    public String openCmManageUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

        String confirm =  request.getParameter("confirm") != null ? request.getParameter("confirm").toString() : "";
        
        String StrResult1 = ""; 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());

        if("Y".equals(confirm)){
            StrResult1 = cmManageService.openCmManageApprovalUpdate(request, vo); // 개설 신청 승인
        }else{
            StrResult1 = cmManageService.openCmManageRejectUpdate(vo); // 개설 신청 거절
        }
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    

    /**
     *   커뮤니티 개설신청 다중 승인 조회 팝업 (PD_openInfoMutilView.do) 
     *   커뮤니티 개설신청 다중 승인 거절 팝업 (PD_openInfoMutilReject.do) 
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = {"PD_openInfoMutilView.do","PD_openInfoMutilReject.do"} )
    public void openCmManageMutilViewPopUp( HttpServletRequest request, ModelMap model, CmManageVO vo){
         
        
        String formcheck =  request.getParameter("formcheck") != null ? request.getParameter("formcheck").toString() : "Y";
         OpHelper.bindSearchMap(vo, request);
        //List <String> listCkMultiBox  = vo.getCkMultiBox();
         
         String[] strSplit1;
         String ckMultiBoxValue =vo.getMultiCheck();
         strSplit1 = ckMultiBoxValue.split(",");
         
         model.addAttribute("formcheck", formcheck);
         model.addAttribute("ckmultiSize", strSplit1.length);
         model.addAttribute("openCmManageMutilView", cmManageService.openCmManageMutilView(vo)); // 기본정보
         model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
    }
        
    /**
     *  커뮤니티 이름 URL 중복 체크
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmNmUrlCheck.do" )
    public String getOpenCmManageCheck(HttpServletRequest request, CmManageVO vo, ModelMap model){
        
        
        return responseText(model, cmManageService.getOpenCmManageCheck(vo));
    }

    /**
     *  커뮤니티 개설신청 다중 승인 및 거절 처리
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_OpenCmManageMultiUpdate.do")
    public String openCmManageMultiUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

        String confirm =  request.getParameter("confirm") != null ? request.getParameter("confirm").toString() : "";
        
        String StrResult1 = ""; 
        
        String hostNm = CmsUtil.getHostName(request.getServerName());
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());
        List <String> listCkMultiBox  = vo.getCkMultiBox();
        String[] strSplit;
        String ckMultiBoxValue ="";
        
        if("Y".equals(confirm)){
            
            StrResult1 = cmManageService.openCmManageApprovalMultiUpdate(request, vo); // 개설 신청 승인
            
            if("Y".equals(StrResult1)){
                if(listCkMultiBox != null) {
                    for(int i=0; i<listCkMultiBox.size(); i++ ){
                        CmManageVO cmvo = new CmManageVO();
                        
                        ckMultiBoxValue =  listCkMultiBox.get(i);
                        strSplit = ckMultiBoxValue.split("_"); //   <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.userId}'/>            
                        cmvo.setCmmntyId(strSplit[0]);
                        cmvo.setLangCode(strSplit[1]);
                        cmvo.setUserId(strSplit[2]);
                        CmManageVO copen = cmManageService.openCmManageView(cmvo);
                        
                        /** E-메일발송 시작 **/
                        Map<String, Object> autoMap = new HashMap<String, Object>();
                        boolean result = false;
                        /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
                        //int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
                        if("00".equals(cmvo.getLangCode()))  { // 한국어사이트
                            autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_ERSY);
                        } else{
                            autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_ERSY);
                        }
                        
                        // 전송할 메일 정보 입력
                        autoMap.put("receiverName", copen.getUserNm()); // 수신자명
                        autoMap.put("email", copen.getEmail()); // 수신이메일주소
        
                        /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
                        HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                        if("".equals(hostNm) || "www".equals(hostNm)) {
                            hostNm = "korean";
                        }
                        
                        oneToOneInfoMap.put("rtnurl", copen.getCmmntyUrl()); 
                        oneToOneInfoMap.put("cmUrl", copen.getCmmntyUrl()); 
                        oneToOneInfoMap.put("cmName", copen.getCmmntyNm()); 
                        oneToOneInfoMap.put("phone", copen.getMbtlnum()); 
                        oneToOneInfoMap.put("cmCategory", copen.getCmmntyCtgryNm()); 
                        oneToOneInfoMap.put("cmContents", copen.getCmmntyDc()); 
                        oneToOneInfoMap.put("cmRequestReason", copen.getEstblReqstResn());
        
                        // 치환정보 맵 입력
                        autoMap.put("oneToOneInfo", oneToOneInfoMap);
        
                        // 선택 입력 항목
                        autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓
        
                        // EMAIL 발송
                        result = amservice.sendAutoMail(autoMap);
                        if(result) {
                            /*System.out.println("########################################################");
                            System.out.println("####커뮤니티개설 승인 E-MAIL : " + copen.getEmail() + "," + copen.getUserNm() + "에게 발송 성공#########");
                            System.out.println("########################################################");*/
                        } else {
                           /* System.out.println("########################################################");
                            System.out.println("####커뮤니티개설 승인 E-MAIL : " + copen.getEmail() + "," + copen.getUserNm() + "에게 발송 실패#########");
                            System.out.println("########################################################");*/
                        }
                        /** E-메일발송 끝 **/
                        /** SMS발송시작 **/
                        if(copen.getMbtlnum() != null){
                            Map<String, Object> smsMap = new HashMap<String, Object>();
                            
                            //SMS발송 및 전송이력쌓기
                            SmsTransHistConstant shc = new SmsTransHistConstant();   
                            //수신번호-필수
                            smsMap.put("rcvNo", copen.getMbtlnum());
                            //발신내용-필수
                            if("00".equals(cmvo.getLangCode()))  { // 한국어사이트
                                smsMap.put("msg", shc.getSmsMsg("262"));
                            } else if("01".equals(cmvo.getLangCode())) {  // 영어사이트
                                smsMap.put("msg", shc.getSmsMsg("362"));
                            } else if("06".equals(cmvo.getLangCode())) { // 스페인어사이트
                                smsMap.put("msg", shc.getSmsMsg("462"));
                            }else{
                                smsMap.put("msg", shc.getSmsMsg("262"));
                            }
                            //업무코드
                            smsMap.put("dutyCd", "CM");
                            boolean smsRst = smsService.smsTransHist(smsMap);
                            if(smsRst){
                               /* System.out.println("########################################################");
                                System.out.println("####커뮤니티개설 승인 SMS : "+copen.getMbtlnum()+","+copen.getUserNm()+"에게 발송 성공#########");
                                System.out.println("########################################################");*/
                            }else{
                                /*System.out.println("########################################################");
                                System.out.println("####커뮤니티개설 승인 SMS : "+copen.getMbtlnum()+","+copen.getUserNm()+"에게 발송 실패#########");
                                System.out.println("########################################################");*/
                            }
                        }
                        /** SMS발송끝 **/
                    }//for end
                }// if end
            }// if end
        }else{
            StrResult1 = cmManageService.openCmManageRejectMultiUpdate(vo); // 개설 신청 거절
            if("Y".equals(StrResult1)){
                if(listCkMultiBox != null) {
                    for(int i=0; i<listCkMultiBox.size(); i++ ){
                        CmManageVO cmvo = new CmManageVO();
                        
                        ckMultiBoxValue =  listCkMultiBox.get(i);
                        strSplit = ckMultiBoxValue.split("_"); //   <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.userId}'/>            
                        cmvo.setCmmntyId(strSplit[0]);
                        cmvo.setLangCode(strSplit[1]);
                        cmvo.setUserId(strSplit[2]);
                        
                        CmManageVO copen = cmManageService.openCmManageView(cmvo);
                        
                        /** E-메일발송 시작 **/
                        Map<String, Object> autoMap = new HashMap<String, Object>();
                        boolean result = false;
                        /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
                        //int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
                        if("00".equals(cmvo.getLangCode()))  { // 한국어사이트
                            autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_ERSN);
                        }else{
                            autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_ERSN);
                        }
        
                        // 전송할 메일 정보 입력
                        autoMap.put("receiverName", copen.getUserNm()); // 수신자명
                        autoMap.put("email", copen.getEmail()); // 수신이메일주소
        
                        /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
                        HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                        if("".equals(hostNm) || "www".equals(hostNm)) {
                            hostNm = "korean";
                        }
                        
                        oneToOneInfoMap.put("rtnurl", copen.getCmmntyUrl()); 
                        oneToOneInfoMap.put("cmUrl", copen.getCmmntyUrl()); 
                        oneToOneInfoMap.put("cmName", copen.getCmmntyNm()); 
                        oneToOneInfoMap.put("phone", copen.getMbtlnum()); 
                        oneToOneInfoMap.put("cmCategory", copen.getCmmntyCtgryNm()); 
                        oneToOneInfoMap.put("cmContents", copen.getCmmntyDc()); 
                        oneToOneInfoMap.put("cmRequestReason", copen.getEstblReqstResn());
                        oneToOneInfoMap.put("ectionReason", copen.getConfmRejectResn());
                        
                        // 치환정보 맵 입력
                        autoMap.put("oneToOneInfo", oneToOneInfoMap);
        
                        // 선택 입력 항목
                        autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓
        
                        // EMAIL 발송
                        result = amservice.sendAutoMail(autoMap);
                        if(result) {
                           /* System.out.println("########################################################");
                            System.out.println("####커뮤니티개설 거절 E-MAIL : " + copen.getEmail() + "," + copen.getUserNm() + "에게 발송 성공#########");
                            System.out.println("########################################################");*/
                        } else {
                           /* System.out.println("########################################################");
                            System.out.println("####커뮤니티개설 거절 E-MAIL : " + copen.getEmail() + "," + copen.getUserNm() + "에게 발송 실패#########");
                            System.out.println("########################################################");*/
                        }
                        /** E-메일발송 끝 **/
                        /** SMS발송시작 **/
                        if(copen.getMbtlnum() != null){
                            Map<String, Object> smsMap = new HashMap<String, Object>();
                            
                            //SMS발송 및 전송이력쌓기
                            SmsTransHistConstant shc = new SmsTransHistConstant();   
                            //수신번호-필수
                            smsMap.put("rcvNo", copen.getMbtlnum());
                            //발신내용-필수
                            if("00".equals(cmvo.getLangCode()))  { // 한국어사이트
                                smsMap.put("msg", shc.getSmsMsg("263"));
                            } else if("01".equals(cmvo.getLangCode())) {  // 영어사이트
                                smsMap.put("msg", shc.getSmsMsg("363"));
                            } else if("06".equals(cmvo.getLangCode())) { // 스페인어사이트
                                smsMap.put("msg", shc.getSmsMsg("463"));
                            }else{
                                smsMap.put("msg", shc.getSmsMsg("263"));
                            }
                            //업무코드
                            smsMap.put("dutyCd", "CM");
                            boolean smsRst = smsService.smsTransHist(smsMap);
                            if(smsRst){
                               /* System.out.println("########################################################");
                                System.out.println("####커뮤니티개설 거절 SMS : "+copen.getMbtlnum()+","+copen.getUserNm()+"에게 발송 성공#########");
                                System.out.println("########################################################");*/
                            }else{
                                /*System.out.println("########################################################");
                                System.out.println("####커뮤니티개설 거절 SMS : "+copen.getMbtlnum()+","+copen.getUserNm()+"에게 발송 실패#########");
                                System.out.println("########################################################");*/
                            }
                        }
                        /** SMS발송끝 **/
                    }//for end
                }// if end
            }
        }
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    
    /**
     * 커뮤니티 승인/거절 현황 조회
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_approvalRejectIndex.do")
    public void approvalRejectList(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        
        vo.setCmmntySttusCdNotIn("1"); // 1 기본 조건 실행 AND    b.CMMNTY_STTUS_CD NOT IN (1001 , 1004, 1005) 
        model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageService.openCmManageList(vo));
        
    }
    
    /**
     *  커뮤니티 승인/거절 현황 조회 승인 수정 적용  , 커뮤니티 폐쇄
     * @throws Exception 
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = {"INC_applyCmManageUpdate.do","INC_closeCmManageUpdate.do"})
    public String  applyCloseCmManageUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) throws Exception {
        
        String applyClose =  request.getParameter("applyClose") != null ? request.getParameter("applyClose").toString() : "";
        
        String StrResult1 = ""; 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());
        //vo.set
        if("Y".equals(applyClose)){
            StrResult1 = cmManageService.applyCmManageApprovalUpdate(request, vo); // 커뮤니티 승인 정보 수정
        }else{
            StrResult1 = cmManageService.closeCmManageUpdate(request, vo) ; // 커뮤니티폐쇄
        }
      
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    } 
    
    /**
     * 커뮤니티 회원 현황 조회
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_memberShipInfoList.do")
    public void popupMemberShipInfoList(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        
        //model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
        model.addAttribute("openCmManageView", cmManageService.openCmManageView(vo)); // 기본정보
        
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageService.cmMberInfoList(vo));
        
    }
    
    
    /**
     *  커뮤니티 회원 정보 수정 : 가입 승인, 가입 거절 , 강제 탈퇴
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmMemberShipInfoUpdate.do")
    public String  cmMemberShipInfoUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo)  {
        
        String mberState =  request.getParameter("mberState") != null ? request.getParameter("mberState").toString() : "1001";
        
        String StrResult1 = ""; 
        
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());
        //커뮤니티회원강제탈퇴 : >>1001:운영자강제탈퇴        1002:관리자강제탈퇴
        // 커뮤니티회원상태 :>>>1001:가입중        1002:가입거절       1003:정상     1004:탈퇴
        vo.setMberStateCd(Integer.parseInt(mberState));
        if("1003".equals(mberState)){
            StrResult1 = cmManageService.cmMemberShipInfoUpdate(request, vo); // 1003:정상 
        }else if("1002".equals(mberState)){
            StrResult1 = cmManageService.cmMemberShipInfoUpdate(request, vo); // 1002:가입거절 
        }else if("1004".equals(mberState)){
            vo.setEnfrcSecsnCd(1002); // 강제탈퇴코드 1001:운영자강제탈퇴    1002:관리자강제탈퇴
            StrResult1 = cmManageService.cmMemberShipInfoUpdate(request, vo); // 1004:탈퇴 
        }
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    } 
    
    
    /**
     *   커뮤니티 회원 정보 조회 팝업 (PD_memberShipInfoView.do) 
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_memberShipInfoView.do")
    public void cmMemberShipInfoViewPopUp( HttpServletRequest request, ModelMap model, CmManageVO vo){
         
         OpHelper.bindSearchMap(vo, request);

         
         vo.setUserId(vo.getCmmntyMberId()); // 회원 아이디
         model.addAttribute("userEntrprsOption", cmManageService.userEntrprsOptionSelect(vo)); // 기업회원 추가 정보 // 2001    기업회원     2002    기업판매회원
         model.addAttribute("userOption", cmManageService.userOptionSelect(vo)); // 일반회원 추가 정보 //  1001 개인회원     1002 개인판매회원 
         
         model.addAttribute("cmMemberShipInfoView", cmManageService.cmMemberShipInfoView(vo)); // 기본회원정보
         model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
         
    }
    /**
     * 커뮤니티 폐쇄 현황 조회
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_closeIndex.do")
    public void closeIndex(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        
        //vo.setCmmntySttusCd(1004); //  1001:신청     1002:승인     1003:승인보류 1004: 커뮤니티 폐쇄 1005: 커뮤니티 폐쇄 중
        vo.setCmmntySttusCdNotIn("2"); // 1004 1005 세팅 위해 설정
        model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageService.openCmManageList(vo));
        
    }
    
    
    /**
     * 커뮤니티 메뉴 관리
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_menuIndex.do")
    public void menuIndex(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        CmManageVO cmvo = new CmManageVO();
        String strLangCodeTab =  request.getParameter("q_langCodeTab") != null ? request.getParameter("q_langCodeTab").toString() : "00"; // 언어코드가 없으면 기본으로 한글로 세팅
        vo.setLangCode(strLangCodeTab); // 언어코드 
        cmvo.setLangCode("00"); // 언어코드 한국어로 지정
        List<CmManageVO>  cmManagelist =  cmManageService.cmMenuManageSelect(vo);
        List<CmManageVO>  cmManageKorealist =  cmManageService.cmMenuManageSelect(cmvo); // 언어코드 커뮤니티 목록이 없을때 사용
        model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
        model.addAttribute("cmManagelistTotalCnt", cmManagelist.size()); //메뉴 카운트
        model.addAttribute("cmManagelist", cmManagelist); //메뉴 목록
        model.addAttribute("cmManageKorealist", cmManageKorealist); //한국어 메뉴 목록
        
    }
    
    /**
     *  커뮤니티 메뉴 관리 수정
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmMenuUpdate.do")
    public String openCmMenuUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

        
        String StrResult1 = ""; 
        
        String strLangCodeTab =  request.getParameter("q_langCodeTab") != null ? request.getParameter("q_langCodeTab").toString() : ""; 
        
        vo.setLangCode(strLangCodeTab); // 언어코드 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());

        StrResult1 = cmManageService.cmMenuManageUpdate(vo); // 커뮤니티 메뉴 목록 수정
        
        if("Y".equals(StrResult1)){
            return responseJson(model, Boolean.TRUE, Messages.COMMON_UPDATE_OK );
        }else{
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL );
        }
        
    }
    
    /**
     *  커뮤니티 메뉴 관리 등록
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmMenuInsert.do")
    public String openCmMenuInsert( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

        
        String StrResult1 = ""; 
        
        String strLangCodeTab =  request.getParameter("q_langCodeTab") != null ? request.getParameter("q_langCodeTab").toString() : ""; 
        
        vo.setLangCode(strLangCodeTab); // 언어코드 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());

        StrResult1 = cmManageService.cmMenuManageInsert(vo); // 커뮤니티 새로 추가된 언어 메뉴 목록 등로 
        
        if("Y".equals(StrResult1)){
            return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK );
        }else{
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL );
        }
        
    }

    /**
     * 업로드 이미지 픽셀 및 크기 체크
     */
    @RequestMapping(value = "ND_uploadImgChk.do", method = RequestMethod.POST)
    public String uploadIMGCheck(HttpServletRequest request, ModelMap model){
        String inputName = request.getParameter("inputName");
        String fileExtPermit = request.getParameter("fileExt");
        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다. 
        long maxFileSize = (long) (Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024); 
        
        Float maxWidthSize = (float)Integer.parseInt(request.getParameter("maxWidthSize").isEmpty() != true ? request.getParameter("maxWidthSize") : "0");
        Float maxHeightSize = (float)Integer.parseInt(request.getParameter("maxHeightSize").isEmpty() != true ? request.getParameter("maxHeightSize") : "0");
        
        int result = 100;   // 100 : 패스
        String message = new String(); //retrun 메시지
        
        // 이미지 파일 체크
        @SuppressWarnings("unchecked")
        List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);
        
        if(files != null && !request.getParameter("maxFileSize").isEmpty()) {
            for(int i=0; i < files.size(); i++){
                MultipartFile fileVo = files.get(i);
                if(fileVo.getName().equals(inputName)) {
                    
                    String fileType = FileUtil.extension(fileVo.getOriginalFilename());
                    
                    if(fileExtPermit.indexOf(fileType) == -1) {
                        result = 201; //허용하지 않는 파일유형(확장자)
                        break;
                    }
                    
                    Long fileSize = fileVo.getSize();
                    
                    if(maxFileSize > 0 && fileSize > maxFileSize) {                    
                        result = 200; //파일 제한용량초가
                        break;
                    }else{  
                        if(maxWidthSize > 0 || maxHeightSize > 0) { //가로나 세로 제한값이 있을 때
                            try {
                                //BufferedImage bi = ImageIO.read(new File(GlobalConfig.WEBAPP_ROOT + fileVo.getFileUrl()));
                                BufferedImage bi = ImageIO.read(fileVo.getInputStream());
                                
                                Float imgW = (float)bi.getWidth();
                                Float imgH = (float)bi.getHeight();
                                
                                if(maxWidthSize > 0 && (maxWidthSize+10) < imgW) { //가로제한 값이 있고 제한값보다 클때
                                   result = 301; //가로크기가 제한크기보다 클때  
                                }
                                
                                if(maxHeightSize > 0 && (maxHeightSize+10) < imgH) { //세로제한 값이 있고 제한값보다 클 때
                                   result = 302; //세로크기가 제한크기보다 클때                                
                                }
                                
                               // Float ratioValue1 = (float) (maxWidthSize / maxHeightSize);
                               // Float ratioValue2 = (float) (imgW / imgH);
                                
//                                //(maxWidthSize > 0 && maxHeightSize > 0 ) && !ratioValue1.equals(ratioValue2)
//                                if((maxWidthSize > 0 && maxHeightSize > 0 ) && (((ratioValue1-ratioValue2) > 0.05) || ((ratioValue2-ratioValue1) > 0.05))) {
//                                    result = 303; // 가로/세로 비율이 맞지 않음   
//                                }
                                
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
        }else{
            result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때           
        }
        
        switch (result) {
            case 100:
                 message = "100";
                 break;
            case 200: 
                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize") != null ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 break;
            case 201:
                message = "이미지 파일의 유형(확장자)은 jpg, png 파일만 가능합니다.";
                break;     
            case 301:
                 message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다."; 
                 break;
            case 302:
                 message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다."; 
                 break;
//            case 303:
//                 message = "이미지의 비율이 맞지 않습니다."; 
//                 break;
            case 400:
                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 break;
            default:
                 message = "이미지가 확인되지 않았습니다.";
                 break;
                    
        }
        
        return responseText(model, message);       
        
    }
}
