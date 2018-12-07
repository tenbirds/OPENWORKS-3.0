package zes.openworks.intra.orderManage.cntrctManage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.suplerCeart.SuplerCeartService;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  주문관리 > 구매/신청 관리
 *
 * 수정일          수정자    수정내용
 *--------------  --------  -------------------------------
 * 2016. 02. 15.   엔키      신규
 *</pre>
 * @see
 */

@Controller 
@RequestMapping(value = "/intra/orderManage/cntrctManage")
public class CntrctManageController extends IntraController {

    @Autowired private CntrctManageService service;

    @Autowired private SuplerCeartService service1;
    
    /** 파일 저장 경로 */
    public static final String SUPLER_FILE_PATH = "supler" + File.separator;

    
    
    
    
    /**
     * wishView (계약관리목록)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cntrctManageList.do", method = RequestMethod.GET)
    public void cntrctManageList(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute("cntInfo", service.mainCntInfo());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.cntrctManageList(vo));
    }

    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = {"BD_cntrctManageDetail.do"})
        public void cntrctManageDetail(HttpServletRequest request, ModelMap model, CntrctManageVO vo, SuplerCntrctVO vvo) {
        
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        
        String hostNm = "korean";

        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.cntrctManageDetail(vo));
        
        String strCntrctSn = vo.getStrCntrctSn();
        String rlCntrctInsttAt = request.getParameter("rlCntrctInsttAt");
        
        if(strCntrctSn != null && !strCntrctSn.equals("")){
            model.addAttribute("ImmeServiceRegistYN", "N");
        } else {
            model.addAttribute("ImmeServiceRegistYN", "Y");
        }
        
        
        if(strCntrctSn != null && !strCntrctSn.equals("")){

            CntrctManageVO pvo = (CntrctManageVO)service.cntrctManageDetail(vo);            
            if((pvo.getRealOrgNm() != null && !pvo.getRealOrgNm().equals("")) || (rlCntrctInsttAt !=null && rlCntrctInsttAt.equals("Y"))) {   
                rlCntrctInsttAt = "Y"; pvo.setRlCntrctInsttAt("Y"); 
            }
            
            model.addAttribute(GlobalConfig.KEY_BASE_VO, pvo);
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.cntrctManageDetailList(vo));
        } 
    }
    
    /**
     * 관리자 - 계약실적 수기등록
     * cntrctManageRegist 설명
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = {"BD_cntrctManageRegistForm.do"})
        public void cntrctManageRegistForm(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {
        
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        
        String hostNm = "korean";

        //model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        //model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        //model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        //model.addAttribute("currPage",      vo.getQ_currPage());

/*
          
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        
        String hostNm = "korean";

        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.cntrctManageDetail(vo));
        
        CntrctManageVO pvo = (CntrctManageVO)service.cntrctManageDetail(vo);
        
        model.addAttribute(GlobalConfig.KEY_BASE_VO, pvo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.cntrctManageDetailList(vo));        

 */        
        
    }

/*
    @RequestMapping(value = "/BD_myCntrctForm.do")
    public String BD_myCntrctForm(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setCommUserId(userLoginVO.getUserId());
        }
        String rlCntrctInsttAt = request.getParameter("rlCntrctInsttAt");
        if(request.getParameter("p_cntrctSn") != null && !request.getParameter("p_cntrctSn").equals("")){
            vo.setCntrctSn(Integer.parseInt(request.getParameter("p_cntrctSn")));
            // 계약서 정보 및 실제이용자정보조회
            SuplerCntrctVO pvo = (SuplerCntrctVO)service.cntrctDetail(vo);
            if((pvo.getRealOrgNm() != null && !pvo.getRealOrgNm().equals("")) || (rlCntrctInsttAt !=null && rlCntrctInsttAt.equals("Y"))) 
              {   rlCntrctInsttAt = "Y"; pvo.setRlCntrctInsttAt("Y"); }
            
            model.addAttribute(GlobalConfig.KEY_BASE_VO, pvo);
            // 계약체결서비스
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.cntrctDtlGoodsList(vo));
        }

        // 조회조건 반환
        model.addAttribute("rlCntrctInsttAt", rlCntrctInsttAt );
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      vo.getQ_currPage());
        return "/korean/pt/suplerCeart/BD_myCntrct.form";
    } 
     
 */
    
    @RequestMapping(value = "/ND_suplerCntrctManageRegistAction.do", method = RequestMethod.POST)
    public String suplerCntrctManageRegistAction(ModelMap model, HttpServletRequest request, SuplerCntrctVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        
        String hostNm = "korean";

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, SUPLER_FILE_PATH);
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
        //계야기관과 동일하지 안음을 체크 안하면 관련 데이타 초기화 
        if(vo.getRlCntrctInsttAt() == null){
            vo.setUserSe("");   //이용자구분
            vo.setSportAt("");  //지원사업여부 
        }else  if(vo.getRlCntrctInsttAt() != null && vo.getRlCntrctInsttAt().equals("Y")){
            if(vo.getUserSe()!= null && vo.getUserSe().equals("2")) //민간기업 선택시 
                vo.setSportAt("");  //지원사업여부
        }

        
        
        if(vo.getCntrctSn()!=0 || vo.getRegistMthdCode() == 1002){
            vo.setUpdtId("ceartmanager01");            
            confirmCnt = service.updateCntrctCmpl2(vo);            
        }else{
            vo.setRegistId("ceartmanager01");
            confirmCnt = service.insertCntrctCmpl(vo);
        }
        
        // 조회조건 반환
/*      model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      vo.getQ_currPage());*/
       // if(confirmCnt <= 0){
       // return alertAndRedirect(model, "저장에 실패하였습니다.", "/korean/pt/suplerCeart/BD_myCntrctForm.do?");
       // }
       
        String rlCntrctInsttAt = request.getParameter("p_rlCntrctInsttAt");
        if(rlCntrctInsttAt != null && rlCntrctInsttAt.equals("Y"))
            return alertAndRedirect(model, "계약번호가 생성 저장이 완료 되었습니다. 실제이용자정보를 등록하시 바랍니다.", "/korean/pt/suplerCeart/BD_myCntrctForm.do?cntrctSn="+vo.getCntrctSn()+"&p_cntrctSn="+vo.getCntrctSn()+"&rlCntrctInsttAt=Y");
        else 
            return alertAndRedirect(model, "저장이 완료 되었습니다.", "BD_cntrctManageList.do");
    }
    
    @RequestMapping(value = "/ND_immeServiceRegistInsertAction.do", method = RequestMethod.POST)
    public String immeServiceRegistInsertAction(ModelMap model, HttpServletRequest request, SuplerCntrctVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        
        String hostNm = "korean";
        int confirmCnt = 0;

        confirmCnt = service.InsertImmeServiceRegist(vo);

        return alertAndRedirect(model, "저장이 완료 되었습니다.", "BD_cntrctManageDetail.do");
    }
    
    
    
    /**
     * 서비스관리 엑셀
     */
    @RequestMapping(value = "INC_cntrctExcel.do")
    public String cntrctListExcel(ModelMap model, HttpServletRequest request, CntrctManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.put("q_excelFileName", "계약관리목록");
        vo.getDataMap().put("q_excel","q_excel");
        model.put("_cntrctList", service.cntrctManageList(vo));
        
        CntrctManageExcelVO cntrctManageExcel = new CntrctManageExcelVO();
        cntrctManageExcel.setModel(model);
        return responseExcel(model, cntrctManageExcel);
        
   /*     GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);
        return responseExcel(model, GoodsManageExcel);*/
    }
    /**
     * 서비스관리 엑셀
     */
    @RequestMapping(value = "INC_naraCntrctExcel.do")
    public String naraCntrctExcel(ModelMap model, HttpServletRequest request, CntrctManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.put("q_excelFileName", "조달청_나라장터_통합계약실적_목록");
        vo.getDataMap().put("q_excel","q_excel");
        model.put("_cntrctList", service.naraTotalCntrctInfoList(vo));
        
        //CntrctManageExcelVO cntrctManageExcel = new CntrctManageExcelVO();
        NaraCntrctManageExcelVO naraCntrctManageExcel = new NaraCntrctManageExcelVO();
        naraCntrctManageExcel.setModel(model);
        return responseExcel(model, naraCntrctManageExcel);
        
   /*     GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);
        return responseExcel(model, GoodsManageExcel);*/
    }
    /**
     * cntrctManageDeleteAction (계약관리 삭제)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String cntrctManageDeleteAction(ModelMap model, CntrctManageVO vo) {

        int affected = service.cntrctManageDeleteAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);

    }
    
    

    /**
     * updateCntrctUseAction (계약관리/계약실적 여부에 따라 업데이트)
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_UpdateCntrctUseAction.do", method = RequestMethod.GET)
    public String cntrctManageUpdateUseAction(ModelMap model, CntrctManageVO vo) {
        int affected = service.cntrctManageUdpateUseAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 조달청 나라장터 연계정보 - 계약실적목록
     * naraTotalCntrctInfoList 설명
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_naraTotalCntrctInfoList.do", method = RequestMethod.GET)
    public void naraTotalCntrctInfoList(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute("cntInfo", service.mainCntInfo());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.naraTotalCntrctInfoList(vo));
    }

    /**
     * updateCntrctUseAction (계약관리/계약실적 여부에 따라 업데이트)
     */
/*    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_naraInfoInterface.do", method = RequestMethod.GET)
    public String naraInfoInterface(ModelMap model, CntrctManageVO vo) {
        int affected = service.cntrctManageUdpateUseAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }*/

    
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_naraInfoInterface.do", method = RequestMethod.POST)
    public String naraInfoInterface(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

//        int affected = service.cntrctManageUdpateUseAction(vo);
        int affected = service.naraInfoInterface(vo);

        //int affected = 0;
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }

        return responseJson(model, true);
    }    
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_tcnDvyfgInfoLInterface.do", method = RequestMethod.POST)
    public String tcnDvyfgInfoLInterface(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

//        int affected = service.cntrctManageUdpateUseAction(vo);
        int affected = service.tcnDvyfgInfoLInterface(vo);        
        
        

        //int affected = 0;
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }

        return responseJson(model, true);
    }    
}