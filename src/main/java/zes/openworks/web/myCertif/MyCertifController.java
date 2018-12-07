package zes.openworks.web.myCertif;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.vo.MyCeartExcelVO;


@Controller
@RequestMapping(value = {"/**/myCertif"})
public class MyCertifController extends GeneralController {
    
    @Autowired
    CommonDutyService commonService;
    
    @Autowired
    MyCertifService myCertifService;
    
    /*
     * 이용실적증명서 발급을 위한 이용실적 조회(BD_certifRequList)
     * */
    @RequestMapping(value = "/BD_certifRequList.do")
    public String BD_certifRequList(HttpServletRequest request, ModelMap model, MyCertifGoodsVO vo) {

        // 로그인 회원 체크
       UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCertif/BD_certifRequList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setCommUserId(userLoginVO.getUserId());
            vo.setCommonBuseoCode(userLoginVO.getBuseoCode());
          //  vo.setBuseoCode(userLoginVO.get)
        }
        
        if(!userLoginVO.getUserTyCd().toString().startsWith("30"))
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth4"), "/korean/pt/index.do");
            
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, myCertifService.certifRequList(vo));
        
        /*  
        // 로그인 회원 타입코드 
        model.addAttribute("UserTyCd",   myCeartService.purchsDtlsUserTyCd(vo));
        */
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        
        return "/korean/pt/myCertif/BD_certifRequList";
    }
    
    /*
     * 이용실적증명서 발급을 위한 이용실적 엑셀조회(BD_certifRequListExcel)
     * */
       @RequestMapping(value = "/BD_certifRequListExcel.do")
    public String BD_certifRequListExcel(HttpServletRequest request, ModelMap model, MyCertifGoodsVO vo) {

        // 로그인 회원 체크
       UserLoginVO userLoginVO = OpHelper.getUserSession(request);
       if(Validate.isEmpty(userLoginVO)) {
           String returnUrl = "?returnUrl=/korean/pt/myCertif/BD_certifRequList.do";
           return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
       } else {
           vo.setCommUserId(userLoginVO.getUserId());
         //  vo.setBuseoCode(userLoginVO.get)
       }
       
       if(!userLoginVO.getUserTyCd().toString().startsWith("30"))
           return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth3"), "/korean/pt/index.do");
       
        OpHelper.bindSearchMap(vo, request);
        model.put("q_excel", "02"); // 목록별 구분값(01:상세정보(견적)요청서 / 02:구매내역관리 목록)
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", myCertifService.certifRequList(vo));
        model.put("q_excelFileName", "기관별 이용실적  목록");
       
        MyCertifExcelVO myCertifExcel = new MyCertifExcelVO();
        myCertifExcel.setModel(model);
        myCertifExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, myCertifExcel);
    }
    /*
     * 이용실적증명서 발급 조회(BD_certifRequForm)
     * */
    @RequestMapping(value = "/BD_certifRequForm.do",  method = {RequestMethod.POST, RequestMethod.GET})
    public String BD_certifRequForm(HttpServletRequest request, ModelMap model, MyCertifGoodsVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCertif/BD_certifRequForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_certifRequForm.do" + returnUrl);
        } else {
            vo.setCommUserId(userLoginVO.getUserId());
            vo.setCommonBuseoCode(userLoginVO.getBuseoCode());            
        }
        
        if(!userLoginVO.getUserTyCd().toString().startsWith("30"))
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth3"), "/korean/pt/index.do");
        
        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myCertifService.certifRequList(vo));
        return "/korean/pt/myCertif/BD_certifRequForm";
    }
    
    /*
     * 이용실적증명서 발급 신청 등록(BD_certifRequInsert)
     * */
    @RequestMapping(value = "BD_certifRequInsert.do", method = RequestMethod.POST)
    public String BD_certifRequInsert(HttpServletRequest request, ModelMap model, MyCertifApplyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCertif/BD_certifRequForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_certifRequForm.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
            vo.setRegistId(userLoginVO.getUserId());
        }
        
        if(!userLoginVO.getUserTyCd().toString().startsWith("30"))
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth3"), "/korean/pt/index.do");
        
        Integer key = myCertifService.certifRequInsertAction(vo);

        if(Validate.isEmpty(key)) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }
        return alertAndRedirect(model, "이용실적증명 발급이 신청되었습니다.\\n발급에는 약 5일 정도 소요됩니다.", "BD_certifApplyList.do");
    }
    
    /*
     * 이용실적증명서 발급 조회(BD_certifApplyList)
     * */
    @RequestMapping(value = "/BD_certifApplyList.do")
    public String BD_certifApplyList(HttpServletRequest request, ModelMap model, MyCertifApplyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCertif/BD_certifApplyList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }else
            vo.setUserId(userLoginVO.getUserId());
            vo.setBuseoCode(userLoginVO.getBuseoCode());
            vo.setUserTyCd(userLoginVO.getUserTyCd());
        
        if(!userLoginVO.getUserTyCd().toString().startsWith("30"))
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth3"), "/korean/pt/index.do");
        
        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myCertifService.certifApplyList(vo)); 
       /* model.addAttribute("currPage",      vo.getQ_currPage());*/
        
        return "/korean/pt/myCertif/BD_certifApplyList";
    }
    
    /*
     * 이용실적증명서 발급 상세조회(BD_certifApplyDetail)
     * */
    @RequestMapping(value = "/BD_certifApplyDetail.do",  method = RequestMethod.GET)
    public String BD_certifApplyDetail(HttpServletRequest request, ModelMap model, MyCertifApplyVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCertif/BD_certifApplyDetail.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_certifRequForm.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        if(!userLoginVO.getUserTyCd().toString().startsWith("30"))
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth3"), "/korean/pt/index.do");
        
        OpHelper.bindSearchMap(vo, request);
        vo = myCertifService.certifApplyDetail(vo);
        if(vo != null){
            /*인증발금신청상세*/
            model.addAttribute(GlobalConfig.KEY_DATA_VO,vo);
            /*서비스 리스트*/
            MyCertifGoodsVO gvo = new MyCertifGoodsVO(); 
            gvo.setCommUserId(vo.getUserId());
            gvo.setRouSn(vo.getRouSn());
            model.addAttribute(GlobalConfig.KEY_PAGER, myCertifService.certifApplyGoodsList(gvo));
        }
        return "/korean/pt/myCertif/BD_certifApplyDetail";
    }
    
}