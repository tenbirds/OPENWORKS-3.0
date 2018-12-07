/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.provider;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.sns.SnsConfig;
import zes.openworks.component.sns.SnsMessages;
import zes.openworks.intra.login.LoginVO;

/**
 * SNS 서비스 제공자 연계 정보 관리
 * 연계에 필요한 URL, 인증 방식, 서비스 제공자 등 정보를 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 8. 14.    방기배       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/component/sns/provider")
public class ProviderController extends IntraController {

    @Autowired
    private ProviderService providerService;

    /**
     * SNS 서비스 제공자 정보 목록
     * 
     * @param model
     * @param request
     * @param providerVo
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_providerList.do")
    public void getProviderList(ModelMap model, HttpServletRequest request, ProviderVO providerVo) throws Exception {

        model.addAttribute("AUTHTYPE", SnsConfig.AUTHTYPE);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, providerService.getProviderList(providerVo));
    }

    /**
     * SNS 서비스 제공자 정보
     * 
     * @param model
     * @param request
     * @param providerVo
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_provider.do")
    public void getProvider(ModelMap model, HttpServletRequest request, ProviderVO providerVo) throws Exception {

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(providerVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        model.addAttribute("PROVIDERS", SnsConfig.PROVIDERS);
        model.addAttribute("AUTHTYPES", SnsConfig.AUTHTYPES);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, providerService.getProvider(providerVo));
    }

    /**
     * SNS 서비스 제공자 저장
     * 
     * @param model
     * @param request
     * @param providerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertProvider.do")
    public String insertProvider(ModelMap model, HttpServletRequest request, ProviderVO providerVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        providerVo.setRegId(loginVo.getMngrId());

        ValidateResultHolder holder = ValidateUtil.validate(providerVo);
        if(!holder.isValid()) {
            return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_VALIDATE_FAIL);
        }

        // 중복등록 확인
        if(Validate.isNotEmpty(providerService.getProvider(providerVo))) {
            return responseJson(model, SnsMessages.FALSE, SnsMessages.SNS_DUPLICATE);
        }

        Integer seqNo = providerService.insertProvider(providerVo);
        if(Validate.isEmpty(seqNo)) {
            return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
        }
        return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_INSERT_OK);
    }

    /**
     * SNS 서비스 제공자 수정
     * 
     * @param model
     * @param request
     * @param providerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateProvider.do", method = RequestMethod.POST)
    public String updateProvider(ModelMap model, HttpServletRequest request, ProviderVO providerVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        providerVo.setModId(loginVo.getMngrId());

        ValidateResultHolder holder = ValidateUtil.validate(providerVo);
        if(!holder.isValid()) {
            return alertAndBack(model, SnsMessages.COMMON_VALIDATE_FAIL);
        }

        if(providerService.updateProvider(providerVo)) {
            return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_UPDATE_OK);
        }
        return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
    }

    /**
     * SNS 서비스 제공자 사용여부 수정
     * 
     * @param model
     * @param request
     * @param providerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateUseYn.do", method = RequestMethod.POST)
    public String updateUseYn(ModelMap model, HttpServletRequest request, ProviderVO providerVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        providerVo.setModId(loginVo.getMngrId());

        if(providerService.updateUseYn(providerVo)) {
            return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_UPDATE_OK);
        }
        return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
    }

    /**
     * SNS 서비스 제공자 삭제
     * 
     * @param model
     * @param request
     * @param providerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteProvider.do", method = RequestMethod.POST)
    public String deleteProvider(ModelMap model, HttpServletRequest request, ProviderVO providerVo) throws Exception {

        if(providerService.deleteProvider(providerVo)) {
            return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_DELETE_OK);
        }
        return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
    }
}
