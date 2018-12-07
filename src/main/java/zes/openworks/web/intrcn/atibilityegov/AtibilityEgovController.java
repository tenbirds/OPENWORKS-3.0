/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.intrcn.atibilityegov;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import egovframework.mgt.fci.reqiem.service.FciRequestIemVO;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.intrcn.rmi.RmiRequestLinkClient;
import zes.openworks.web.login.UserLoginVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  표준프레임워크 > 호환성 신청 및 확인
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 31.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/intrcn/atibilityegov")
public class AtibilityEgovController extends WebController{

    @Autowired AutoMailService amservice;

    @Autowired AtibilityEgovService service;

    @Autowired CodeService codeService;

    @Autowired
    private CommonDutyService codtservice;

    /**
     * index (호환성 목록)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/BD_index.do" , method = RequestMethod.GET)
    public String index(HttpServletRequest request, ModelMap model, AtibilityEgovVO vo, @PathVariable String pathLang) throws Exception{


        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;


        //로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL +"/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + pathLang + "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            vo.setRegistId(userLoginVO.getUserId());
        }

        //판매 회원 확인
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        OpHelper.bindSearchMap(vo, request);

        //언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())){
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }

        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.cmptbClCdList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, getAtibilityEgovList(service.atibilityEgovList(vo)));

        return baseURL + "/BD_index";

    }


    /**
     * compatibilityForm (완료 페이지)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_applyFinish.do", method = RequestMethod.GET)
    public String applyFinishForm(HttpServletRequest request, ModelMap model, AtibilityEgovVO vo , @PathVariable String pathLang) {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        return baseURL + "/BD_applyFinish";
    }

    /**
     * compatibilityForm (판매권한 페이지)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_memberChange.do", method = RequestMethod.GET)
    public String memberChangeForm(HttpServletRequest request, ModelMap model, AtibilityEgovVO vo , @PathVariable String pathLang) {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        return baseURL+ "/BD_memberChange";
    }


    /**
     * eventForm (호환성 등록/수정 화면)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = { "BD_insertForm.do", "BD_updateForm.do" }, method = RequestMethod.POST)
    public String eventForm(HttpServletRequest request, ModelMap model, AtibilityEgovVO vo , @PathVariable String pathLang) {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        //로그인확인
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){

            String returnUrl = "?returnUrl=" + baseURL +"/BD_index.do";
            return confirmAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + pathLang + "/pt/login/user/BD_index.do" + returnUrl);
        }

        //판매 회원 확인
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        //언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())){
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }

        //분류코드 가져오기
        CodeVO codeVo = new CodeVO();
        codeVo.setGrpCd(1002);
        codeVo.setLangCode(vo.getLangCd());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, codeService.codeList(codeVo));

        return baseURL + "/BD_insertForm";
    }



    /**
     * atibilityEgovView (호환성 절차 상세)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_view.do"  , method = RequestMethod.POST)
    public String atibilityEgovView(HttpServletRequest request, ModelMap model, AtibilityEgovVO vo, @PathVariable String pathLang)  {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVO)){
            vo.setRegistId(userLoginVO.getUserId());
        }
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setLangCd(codtservice.getLangCd(Integer.parseInt(domainCd)));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.atibilityEgovView(vo));

        return baseURL + "/BD_view";

    }


    /**
     * atibilityEgovInsertAction (호환성 등록)
     * @param model
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "ND_insertAction.do" , method = RequestMethod.POST)
    public String atibilityEgovInsertAction(ModelMap model, HttpServletRequest request, AtibilityEgovVO vo, @PathVariable String pathLang){

            UserLoginVO userLoginVO = OpHelper.getUserSession(request);
            if(Validate.isNotEmpty(userLoginVO)){
                vo.setRegistId(userLoginVO.getUserId());
            }

            //표준 프레임워크 기간에 등록
            //개발 서버에서는 사용하지 않음
            if("real".equals(GlobalConfig.SERVICE_MODE)) {
                String CmptbCnfirmRegstNo = getInsertCheckRequest(vo);                
                if(Validate.isEmpty(CmptbCnfirmRegstNo)){
                    return responseText(model, Messages.FALSE);
                }
                vo.setCmptbCnfirmReqstId(CmptbCnfirmRegstNo);
            }else{
                //임시 키 발급
                SimpleDateFormat sdf = new SimpleDateFormat("yyyymmddHHmmssSSS");
                Calendar c1 = Calendar.getInstance();
                vo.setCmptbCnfirmReqstId("temp_"+ sdf.format(c1.getTime()));
            }

            //DB에 등록
            int affected = service.atibilityEgovInsertAction(vo);
            if(affected == StringUtil.ONE) {

                //이메일 보내기
                commentMailSend(vo,pathLang,request);

                return responseText(model, Messages.TRUE);
            }
            return responseText(model, Messages.FALSE);

    }


    /**
     * getInsertCheckRequest (FMI FCI 등록)
     * @param vo
     * @return
     * @throws Exception
     */
    private String getInsertCheckRequest(AtibilityEgovVO vo) {
        try {
            RmiRequestLinkClient rmiClient = new RmiRequestLinkClient();
            return rmiClient.insertCheckRequest(getFciRequestVo(vo));
        } catch (Exception e) {            
            e.getStackTrace(); return null;
        }
    }

    /**
     * getAtibilityEgovList (FMI FCI 상태 매핑)
     * @param pager
     * @return
     * @throws Exception
     */
    private Pager<AtibilityEgovVO> getAtibilityEgovList(Pager<AtibilityEgovVO>  pager) throws Exception{


        //ID 추출하여 requestIdList 값 담기
        List<AtibilityEgovVO> list = pager.getList();
        String[] requestIdList = new String[list.size()];

        //배열에 담기
        for(int i = 0 ; i < list.size() ; i++) {
            requestIdList[i] = String.valueOf(list.get(i).getCmptbCnfirmRegstSeq()) ;
        }

        //요청 받은 상태 코드 매핑
        if(list.size() > StringUtil.ZERO){

            //개발 서버에서는 사용하지 않음
            if("real".equals(GlobalConfig.SERVICE_MODE)) {

                RmiRequestLinkClient rmiClient = new RmiRequestLinkClient();
                List<Map<String, String>>  rmiList = rmiClient.getRequestStatusList(requestIdList);
                if(Validate.isNotEmpty(rmiList)){
                    for (int i = 0; i < rmiList.size(); i++) {
                        list.get(i).setCmptbStatus(rmiList.get(i).get("codeName"));
                    }
                }
            }
        }

        return pager;
    }

    private boolean commentMailSend(AtibilityEgovVO vo,String pathLang, HttpServletRequest request){

        try {

            UserLoginVO userLoginVO = OpHelper.getUserSession(request);

            // 이메일 템플릿 번호
            AutoMailTemplate tempNum = null;
            Map<String, Object> emailMap = new HashMap<String, Object>();
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
            // 추가소스
            String DomainName = GlobalConfig.DOMAIN_SUBNM;
            //}}

            if(pathLang.equals(GlobalConfig.LANG_KOREAN)){
                tempNum = AutoMailTemplate.KOR_CPTB_RQST;
                oneToOneInfoMap.put("rtnurl", "http://"+DomainName+"/korean/pt/intrcn/atibilityegov/BD_index.do");
            }
            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스제거
            /*else if(pathLang.equals(GlobalConfig.LANG_ENGLISH)){
                tempNum = AutoMailTemplate.ENG_CPTB_RQST;
                oneToOneInfoMap.put("rtnurl", "http://english.ceart.kr/english/pt/intrcn/atibilityegov/BD_index.do");
            }else if(pathLang.equals(GlobalConfig.LANG_SPANISH)){
                tempNum = AutoMailTemplate.ESP_CPTB_RQST;
                oneToOneInfoMap.put("rtnurl", "http://spanish.ceart.kr/spanish/pt/intrcn/atibilityegov/BD_index.do");
            }*/
            //}}

            // 발신자 이름
            emailMap.put("senderName", userLoginVO.getUserNm());

            // 발신자 이메일
            emailMap.put("senderEmail", userLoginVO.getEmail());

            // 이메일 제목
            emailMap.put("mailTitle", vo.getCmptbAnalsTrgetNm());

            //메일템플릿 번호명
            emailMap.put("automailId", tempNum);
            //치환정보 맵 입력
            emailMap.put("oneToOneInfo", oneToOneInfoMap);

            return   amservice.sendAutoMail(emailMap);

        } catch (Exception e) {
            e.getStackTrace();
            return false;
        }

    }


    private FciRequestIemVO getFciRequestVo(AtibilityEgovVO vo){
        FciRequestIemVO fciRequestIemVO = new FciRequestIemVO();

        //표준 코드변환
        HashMap<Integer, String> cmptbClCdKey = new HashMap<Integer, String>();
        cmptbClCdKey.put(1001, "011"); //기반SW
        cmptbClCdKey.put(1002, "012"); //연동SW
        cmptbClCdKey.put(1003, "013"); //지원SW

        fciRequestIemVO.setFciClCode(cmptbClCdKey.get(vo.getCmptbClCd()));
        fciRequestIemVO.setFciRequstBizNm(vo.getCmptbAnalsTrgetNm());
        fciRequestIemVO.setFciProvider(vo.getBsnnNm());
        fciRequestIemVO.setFciAppcntName(vo.getAnalsApplcntNm());
        fciRequestIemVO.setFciLocplcTelno(vo.getApplcntTelno());
        fciRequestIemVO.setFciLocplcFxnum(vo.getApplcntFxnum());
        fciRequestIemVO.setFciZip(vo.getAnalsPlaceZip());
        fciRequestIemVO.setFciLocplcZip(vo.getAnalsPlaceZip());
        fciRequestIemVO.setFciPostSn(String.valueOf(StringUtil.ZERO));
        fciRequestIemVO.setFciMainAdres(vo.getAnalsPlaceBassAdres());
        fciRequestIemVO.setFciDetailAdres(vo.getAnalsPlaceDetailAdres());
        fciRequestIemVO.setFciEmailAdres(vo.getApplcntEmail());
        fciRequestIemVO.setFciPrjctDc(vo.getAnalsTrgetDc());
        fciRequestIemVO.setFciPrjctVersion(vo.getVer());
        fciRequestIemVO.setFciDt(vo.getAnalsReqstDe());


        StringBuffer iemCheck = new StringBuffer();
        StringBuffer iemRequstCn = new StringBuffer();

        //아키텍처
        if(Validate.isNotEmpty(vo.getArchtcIemAt())){
            iemCheck.append("FCI111").append("#");
            iemRequstCn.append(vo.getArchtcImeReqstSumry()).append("#");
        }
        //가이드
        if(Validate.isNotEmpty(vo.getGuideIemAt())){
            iemCheck.append("FCI112").append("#");
            iemRequstCn.append(vo.getGuideImeReqstSumry()).append("#");
        }
        //표준프레임워크호환성
        if(Validate.isNotEmpty(vo.getEgovFrameIemAt())){
            iemCheck.append("FCI113").append("#");
            iemRequstCn.append(vo.getEgovFrameIemSumry()).append("#");
        }

        String strIemCheck = iemCheck.substring(0, (iemCheck.length() == 0 ?  0 : iemCheck.length()  -1));
        String strImeRequstCn = iemRequstCn.substring(0, (iemRequstCn.length() == 0 ?  0 : iemRequstCn.length()  -1));


        fciRequestIemVO.setIemCheck(strIemCheck);
        fciRequestIemVO.setIemRequstCn(strImeRequstCn);

        return fciRequestIemVO;
    }


}
