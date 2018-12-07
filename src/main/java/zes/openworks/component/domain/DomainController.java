/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.domain;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 사이트 관리
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
 *  2012. 6. 5.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/component/domain")
public class DomainController extends IntraController {

    @Autowired
    DomainService domainService;

    /**
     * 사이트 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_DomainList.do", "PD_DomainList.do" })
    public void getDomainList(ModelMap model, DomainVO domainVo) throws Exception {

        List<DomainVO> dataList = domainService.getDomainList(domainVo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, dataList);
    }

    /**
     * 사이트 등록 폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_InsertDomainForm.do")
    public void insertDomainForm(ModelMap model, DomainVO domainVo) throws Exception {

        // 검증 데이터
        ValidateResultHolder holder = ValidateUtil.validate(domainVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);
    }

    /**
     * 사이트 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_InsertAction.do", method = RequestMethod.POST)
    public String insertDomainAction(HttpServletRequest request, ModelMap model, DomainVO domainVo)
        throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(domainVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            domainVo.setRegId(loginVo.getMngrId());

            domainService.insertDomain(domainVo);
        } else {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_VALIDATE_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK);
    }

    /**
     * 사이트 수정 폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_UpdateDomainForm.do")
    public void updateDomainForm(ModelMap model, DomainVO domainVo) throws Exception {

        // 검증 데이터
        ValidateResultHolder holder = ValidateUtil.validate(domainVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        DomainVO dataVo = domainService.getDomain(domainVo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVo);
    }

    /**
     * 사이트 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_UpdateAction.do", method = RequestMethod.POST)
    public String updateDomainAction(HttpServletRequest request, ModelMap model, DomainVO domainVo)
        throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(domainVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            domainVo.setModId(loginVo.getMngrId());

            domainService.updateDomain(domainVo);

        } else {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_VALIDATE_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 사이트 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_DeleteAction.do", method = RequestMethod.POST)
    public String deleteDomainAction(ModelMap model, DomainVO domainVo) throws Exception {

        int affected = domainService.deleteDomain(domainVo);

        if(affected == 0) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
    }

}
