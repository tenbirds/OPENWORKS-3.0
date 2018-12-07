/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.apply;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.pop.PopService;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2016. 12. 26.    방기배       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/apply")
public class WebapplyManageController extends WebController{
    @Autowired
    WebapplyService service;
    @Autowired
    PopService popService;
    @Autowired
    CodeService codeService;
    
    public static final String BID_NOTIFY_PATH = "apply" + File.separator;
    
    
    
    
    
    
    @RequestMapping(value = "BD_ApplyList.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String applyList(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {

        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm);


        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        /* 로그인 체크 */
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/apply/BD_applyList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        int rpp = 5;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        
        /* 메인 화면(리스트) 데이터  */
        model.addAttribute(GlobalConfig.KEY_PAGER, service.applyList(vo));
        
        
        
        /* 그룹 코드 설정*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2043);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_ask", codeService.codeList(codeVO));
        
        codeVO.setGrpCd(2037);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_gbnCd", codeService.codeList(codeVO));
        
        return baseURL+"/BD_applyList";
    } 
    
    /*  
     * BD_applytotal.do
     * 상세정보(견적)요청서 관리 호출
     */
    @RequestMapping(value = "BD_applytotal.do" , method = RequestMethod.GET)
    public String applytotal(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {
       
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm);

        CodeVO codeVO = new CodeVO();
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        /* 로그인 체크 */
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/apply/BD_applyList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        /* 판매권한 체크*/
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        
        vo.setNotifySeq(vo.getNoifySeq());  
        
        /* 공통부분 요청자(수요자) 데이터 추출 */
        model.addAttribute(GlobalConfig.KEY_PAGER + "Request", service.bidRequestMasterInfo(vo));      
        model.addAttribute(GlobalConfig.KEY_PAGER + "Supplier", service.bidSupplierMasterInfo(vo));
        
        int bidType = vo.getGoodKndCd(); //리스트 공고종류에 따른 플래그 변수 

        /* PaaS */
        if(bidType == 1001){ // PaaS
            
            /* Paas 정보 추출  */
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "One", service.bidPaaSInfoOne(vo));
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "Two", service.bidPaaSInfoTwo(vo));
           
            return baseURL+"/BD_applyPSdetail";
            
            
            /*SaaS */
        }else if(bidType == 1002){ 
            
            /* 그룹 코드 설정 */   
            codeVO.setGrpCd(2041);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_unitSys", codeService.codeList(codeVO));
            codeVO.setGrpCd(2042);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_splyMothSys", codeService.codeList(codeVO));
           
            /* SaaS 데이터 추출 시스템 요구 상단 데이터*/
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "One", service.bidSaaSInfoOne(vo));
            
            /* SaaS 데이터 추출 시스템 요구 허단 List 형식 데이터*/
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "Two", service.bidSaaSInfoTwo(vo));
            
            return baseURL+"/BD_applySSdetail";
        }else if(bidType == 1003){ // IaaS
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "Db", service.bidIaaSInfoDB(vo));
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "Server", service.bidIaaSInfoServer(vo));
            model.addAttribute(GlobalConfig.KEY_DATA_LIST + "Info", service.bidIaaSInfo(vo));

            return baseURL+"/BD_applyISdetail";
        }
        return baseURL+"/BD_ApplyList.do";
    }
    
    
    
    
    
    
    
    @RequestMapping(value = "BD_PaaSInsert.do" , method = RequestMethod.POST)
    public String PaaSInsert(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        
        // 처리 파일 VO 선언
        List<FileVO> splyFiles = new ArrayList<FileVO>();       
        
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();
           if (inputNm.startsWith("splyFile")) {
                splyFiles.add(uploadFile.get(i));
            }
        }
        vo.setSplyFileList(splyFiles);     
        
        OpHelper.bindSearchMap(vo, request);
        
        /* 로그인 체크 */
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/apply/BD_applyList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }else{
            vo.setUserId(userLoginVO.getUserId());
        }
        
        /* Insert, Update 구별 */
        String[] applytype = vo.getApplytype().split(",");
        if(applytype[0].equals("PaaSInsert")){
            service.bidPaaSInsert(vo);
        }else if(applytype[0].equals("PaaSUpdate")){
            service.bidPaaSUpdate(vo);
           
        }
        
        /* 공동테이블 업데이트 */
        service.bidUpdate(vo);


        return alertAndRedirect(model, "견적 답변서를 전송하였습니다.", "/korean/pt/apply/BD_applyList.do");
    }
    
    
    @RequestMapping(value = "BD_IaaSInsert.do" , method = RequestMethod.POST)
    public String IaaSInsert(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {

        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm);
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_applyList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }
        
        OpHelper.bindSearchMap(vo, request);
        
        vo.setUserId(userLoginVO.getUserId());
       
        String[] applytype = vo.getApplytype().split(",");
        String[] serverUse = vo.getServerUse().split(",");
        String[] serverOs = vo.getServerOs().split(",");
        String[] serverCpu = vo.getServerCpu().split(",");
        String[] serverMemory = vo.getServerMemory().split(",");
        String[] serverDisk = vo.getServerDisk().split(",");
        String[] serverQnty = vo.getServerQnty().split(",");
        String[] serverNetwork = vo.getServerNetwork().split(",");
        String[] serverIp = vo.getServerIp().split(",");
        String[] serverGslb = vo.getServerGslb().split(",");
        String[] serverLdbl = vo.getServerLdbl().split(",");
        String[] serverSnap = vo.getServerSnap().split(",");
        String[] serverImg = vo.getServerImg().split(",");

        String[] dbUse = vo.getDbUse().split(",");
        String[] dbOs = vo.getDbOs().split(",");
        String[] dbCpu = vo.getDbCpu().split(",");
        String[] dbMemory = vo.getDbMemory().split(",");
        String[] dbDisk = vo.getDbDisk().split(",");
        String[] dbQnty = vo.getDbQnty().split(",");
        String[] dbIp = vo.getDbIp().split(",");
        String[] dbNetwork = vo.getDbNetwork().split(",");
        String[] dbAddDisk = vo.getDbAddDisk().split(",");
        String[] dbBackStorg = vo.getDbBackStorg().split(",");
        String[] dbStorgSpace = vo.getDbStorgSpace().split(",");
        String[] dbTransVlmn = vo.getDbTransVlmn().split(",");
        
        String Msg = "오류가 발생하였습니다.\r\n다시 시도해주시길 바랍니다.\r\n현상이 지속 되는 경우 관리자에게 문의 바랍니다.";
        
        /* 타입 구별 */
        if(applytype[0].equals("IaaSInsert")){
            
            /* 답변 수만큼 반복실행*/
            for(int i = 0; i < serverUse.length; i++){
                vo.setApplySeq(i+1);
                vo.setServerUse(serverUse[i]);
                vo.setServerOs(serverOs[i]);
                vo.setServerCpu(serverCpu[i]);
                vo.setServerMemory(serverMemory[i]);
                vo.setServerDisk(serverDisk[i]);
                vo.setServerQnty(serverQnty[i]);
                vo.setServerIp(serverIp[i]);
                vo.setServerNetwork(serverNetwork[i]);
                vo.setServerGslb(serverGslb[i]);
                vo.setServerLdbl(serverLdbl[i]);
                vo.setServerSnap(serverSnap[i]);
                vo.setServerImg(serverImg[i]);
                service.bidIaaSInsertIaaSDD(vo);
            }
            for(int i = 0; i < dbUse.length; i++){
                vo.setApplySeq(i+1);
                vo.setDbOs(dbOs[i]);
                vo.setDbCpu(dbCpu[i]);
                vo.setDbMemory(dbMemory[i]);
                vo.setDbDisk(dbDisk[i]);
                vo.setDbQnty(dbQnty[i]);
                vo.setDbIp(dbIp[i]);
                vo.setDbNetwork(dbNetwork[i]);
                vo.setDbAddDisk(dbAddDisk[i]);
                vo.setDbBackStorg(dbBackStorg[i]);
                vo.setDbStorgSpace(dbStorgSpace[i]);
                vo.setDbTransVlmn(dbTransVlmn[i]);
                service.bidIaaSInsertIaaSDS(vo);
            }
            service.bidIaaSInsertIaaSI(vo);
            service.bidUpdate(vo);
            Msg ="정상적으로 답변 입력이 처리되었습니다.";
        }else if(applytype[0].equals("IaaSUpdate")){
            for(int i = 0; i < serverUse.length; i++){
                vo.setApplySeq(i+1);
                vo.setServerUse(serverUse[i]);
                vo.setServerOs(serverOs[i]);
                vo.setServerCpu(serverCpu[i]);
                vo.setServerMemory(serverMemory[i]);
                vo.setServerDisk(serverDisk[i]);
                vo.setServerQnty(serverQnty[i]);
                vo.setServerIp(serverIp[i]);
                vo.setServerNetwork(serverNetwork[i]);
                vo.setServerGslb(serverGslb[i]);
                vo.setServerLdbl(serverLdbl[i]);
                vo.setServerSnap(serverSnap[i]);
                vo.setServerImg(serverImg[i]);
                service.bidIaaSUpdateIaaSDD(vo);
            }
                for(int i = 0; i < dbUse.length; i++){
                vo.setApplySeq(i+1);
                vo.setDbOs(dbOs[i]);
                vo.setDbCpu(dbCpu[i]);
                vo.setDbMemory(dbMemory[i]);
                vo.setDbDisk(dbDisk[i]);
                vo.setDbQnty(dbQnty[i]);
                vo.setDbIp(dbIp[i]);
                vo.setDbNetwork(dbNetwork[i]);
                vo.setDbAddDisk(dbAddDisk[i]);
                vo.setDbBackStorg(dbBackStorg[i]);
                vo.setDbStorgSpace(dbStorgSpace[i]);
                vo.setDbTransVlmn(dbTransVlmn[i]);
                service.bidIaaSUpdateIaaSDS(vo);
            }
            service.bidIaaSUpdateIaaSI(vo);
            service.bidUpdate(vo);
            Msg = "정상적으로 답변 수정이 처리되었습니다.";
        }else{
            Msg = "오류가 발생하였습니다.";
        }
        
        return alertAndRedirect(model, Msg, "/korean/pt/apply/BD_applyList.do");
    }
    
    
    
    @RequestMapping(value = "BD_SaaSInsert.do" , method = RequestMethod.POST)
    public String SaaSInsert(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {
        
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm);
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_applyList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);

        }else{
          vo.setRegistId(userLoginVO.getUserId());
        }
        OpHelper.bindSearchMap(vo, request);
        vo.setUserId(userLoginVO.getUserId());
        String[] Applytype = vo.getApplytype().split(",");
        String[] OptionNm = vo.getOptionNm().split(",");
        String[] UnitItem = vo.getUnitItem().split(",");
        String[] CaptyItem = vo.getCaptyItem().split(",");
        String[] AmountItem = vo.getAmountItem().split(",");
        String[] cmntItem = vo.getCmntItem().split(",");
        String Msg = "오류가 발생하였습니다.\r\n다시 시도해주시길 바랍니다.\r\n현상이 지속 되는 경우 관리자에게 문의 바랍니다.";
        if(Applytype[0].equals("SaaSInsert")){
            for(int i = 0; i < OptionNm.length; i++){
                vo.setApplySeq(i+1);
                vo.setOptionNm(OptionNm[i]);
                vo.setUnitItem(UnitItem[i]);
                vo.setCaptyItem(CaptyItem[i]);
                vo.setAmountItem1(Integer.parseInt(AmountItem[i]));
                vo.setCmntItem(cmntItem[i]);
                service.bidSaaSInsertSaaSD(vo);
            }
            Msg ="정상적으로 답변 입력이 처리되었습니다.";
            service.bidSaaSInsertSaaSI(vo);
            service.bidUpdate(vo);
        }else if(Applytype[0].equals("SaaSUpdate")){
            for(int i = 0; i < OptionNm.length; i++){
                vo.setApplySeq(i+1);
                vo.setOptionNm(OptionNm[i]);
                vo.setUnitItem(UnitItem[i]);
                vo.setCaptyItem(CaptyItem[i]);
                vo.setAmountItem1(Integer.parseInt(AmountItem[i]));
                vo.setCmntItem(cmntItem[i]);
                service.bidSaaSUpdateSaaSD(vo);
            }
            service.bidSaaSUpdateSaaSI(vo);
            service.bidUpdate(vo);
            Msg = "정상적으로 답변 수정이 처리되었습니다.";
        }else{
            Msg = "오류가 발생하였습니다.";
        }

        return alertAndRedirect(model, Msg, baseURL+"/BD_applyList.do");
    
    }
    
    
    
    
    @RequestMapping(value = "BD_popUpInsert.do")
    public String popInsert(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        vo.setUserId(userLoginVO.getUserId());
        
        String applytype = vo.getApplytype();
        String Msg = "";
        
        if(applytype.equals("PopInsert")){
            service.applyPopUpInsert(vo);
            Msg = "정상적으로 계약체결이 되었습니다.";
        }else if(applytype.equals("PopUpdate")){
            service.applyPopUpUpdate(vo);
            Msg = "정상적으로 계약체결이 수정되었습니다.";
        }
        
        return alertAndRedirect(model, Msg, "/korean/pt/apply/BD_applyList.do");
    }
    
    
    @RequestMapping(value = "BD_reApply.do")
    public String reApply(HttpServletRequest request, ModelMap model,ApplyManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        vo.setUserId(userLoginVO.getUserId());
        
        String Msg = "";
        
        service.applyPopUpInsert(vo);
        Msg = "정상적으로 반려 되었습니다.";

        
        return alertAndRedirect(model, Msg, "/korean/pt/apply/BD_applyList.do");
    }
     
}
