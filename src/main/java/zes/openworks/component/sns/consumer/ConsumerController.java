/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.consumer;

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
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.spi.oscache.Cache;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.sns.SnsConst;
import zes.openworks.component.sns.SnsMessages;
import zes.openworks.component.sns.provider.ProviderVO;
import zes.openworks.intra.login.LoginVO;

/**
 * SNS 서비스 사용자로 등록한 접속 및 인증 키를 관리한다.
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
@RequestMapping(value = "/component/sns/consumer")
public class ConsumerController extends IntraController {

    @Autowired
    private ConsumerService consumerService;

    /**
     * 서비스별 사용자 정보 목록
     * 
     * @param model
     * @param request
     * @param consumerVo
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_consumerList.do")
    public void getConsumerList(ModelMap model, HttpServletRequest request, ConsumerVO consumerVo) throws Exception {

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, consumerService.getConsumerList(consumerVo));
    }

    /**
     * 서비스별 사용자 정보
     * 
     * @param model
     * @param request
     * @param consumerVo
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_consumer.do")
    public void getConsumer(ModelMap model, HttpServletRequest request, ConsumerVO consumerVo) throws Exception {

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(consumerVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        @SuppressWarnings("unchecked")
        List<ProviderVO> providerList = (List<ProviderVO>) Cache.get(SnsConst.SERVICE_LIST_KEY);

        model.addAttribute("PROVIDERS", providerList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, consumerService.getConsumer(consumerVo));
    }

    /**
     * 서비스별 사용자 정보 저장
     * 
     * @param model
     * @param request
     * @param consumerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertConsumer.do")
    public String insertConsumer(ModelMap model, HttpServletRequest request, ConsumerVO consumerVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        consumerVo.setRegId(loginVo.getMngrId());

        ValidateResultHolder holder = ValidateUtil.validate(consumerVo);
        if(!holder.isValid()) {
            return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_VALIDATE_FAIL);
        }

        // 중복등록 확인
        if(Validate.isNotEmpty(consumerService.getConsumer(consumerVo))) {
            return responseJson(model, SnsMessages.FALSE, SnsMessages.SNS_DUPLICATE);
        }

        Integer cnt = consumerService.insertConsumer(consumerVo);
        if(Validate.isEmpty(cnt)) {
            return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
        }
        return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_INSERT_OK);
    }

    /**
     * 서비스별 사용자 정보 수정
     * 
     * @param model
     * @param request
     * @param consumerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateConsumer.do", method = RequestMethod.POST)
    public String updateConsumer(ModelMap model, HttpServletRequest request, ConsumerVO consumerVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        consumerVo.setModId(loginVo.getMngrId());

        ValidateResultHolder holder = ValidateUtil.validate(consumerVo);
        if(!holder.isValid()) {
            return alertAndBack(model, SnsMessages.COMMON_VALIDATE_FAIL);
        }

        if(consumerService.updateConsumer(consumerVo)) {
            return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_UPDATE_OK);
        }
        return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
    }

    /**
     * 서비스별 사용자 정보 사용여부 수정
     * 
     * @param model
     * @param request
     * @param consumerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateUseYn.do", method = RequestMethod.POST)
    public String updateUseYn(ModelMap model, HttpServletRequest request, ConsumerVO consumerVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        consumerVo.setModId(loginVo.getMngrId());

        if(consumerService.updateUseYn(consumerVo)) {
            return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_UPDATE_OK);
        }
        return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
    }

    /**
     * 서비스별 사용자 정보 삭제
     * 
     * @param model
     * @param request
     * @param consumerVo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteConsumer.do", method = RequestMethod.POST)
    public String deleteConsumer(ModelMap model, HttpServletRequest request, ConsumerVO consumerVo) throws Exception {

        if(consumerService.deleteConsumer(consumerVo)) {
            return responseJson(model, SnsMessages.TRUE, SnsMessages.COMMON_DELETE_OK);
        }
        return responseJson(model, SnsMessages.FALSE, SnsMessages.COMMON_PROCESS_FAIL);
    }
}
