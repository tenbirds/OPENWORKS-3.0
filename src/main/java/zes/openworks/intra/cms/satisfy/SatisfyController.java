/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.satisfy;

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
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.web.login.UserLoginVO;

/**
 * 사용자만족도 관리
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
 *  2012. 6. 22.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
public class SatisfyController extends IntraController {

    @Autowired
    SatisfyService satisfyService;

    /**
     * 사용자만족도 상세
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "/intra/cms/satisfy/PD_SatisfyView.do" })
    public void getSatisfy(HttpServletRequest request, ModelMap model, SatisfyVO satisfyVo)
        throws Exception {

        OpHelper.bindSearchMap(satisfyVo, request);

        satisfyVo = satisfyService.getSatisfy(satisfyVo);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, satisfyVo);
        model.addAttribute(GlobalConfig.KEY_PAGER, satisfyService.getSatisfyDetlList(satisfyVo));

    }

    /**
     * 사용자만족도 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "/intra/cms/satisfy/INC_SatisfyList.do" })
    public void getSatisfyList(HttpServletRequest request, ModelMap model, SatisfyVO satisfyVo) throws Exception {

        OpHelper.bindSearchMap(satisfyVo, request);

        List<SatisfyVO> dataList = satisfyService.getSatisfyList(satisfyVo);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, satisfyVo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, dataList);

    }

    /**
     * 사용자만족도 등록 액션
     */
    @RequestMapping(value = "/**/satisfy/ND_InsertAction.do", method = RequestMethod.POST)
    public String insertAction(HttpServletRequest request, ModelMap model, SatisfyVO satisfyVo) throws Exception {

        UserLoginVO userLoginVo = (UserLoginVO) request.getSession().getAttribute(GlobalConfig.USER_SESSION_KEY);

        if(Validate.isNotEmpty(userLoginVo)) {
            satisfyVo.setRegId(userLoginVo.getUserId());
            satisfyVo.setRegNm(userLoginVo.getUserNm());
        } else {
            satisfyVo.setRegId("NULL_GUEST");
            satisfyVo.setRegNm("비회원");
        }

        satisfyVo.setRegIp(request.getRemoteAddr());

        Object primaryKey = satisfyService.insertSatisfy(satisfyVo);

        if(primaryKey == null) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        } else {
            satisfyVo = satisfyService.getScoreAvg(satisfyVo);
            return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK);
        }

    }

    /**
     * 사용자만족도 통계
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "/**/satisfy/INC_getScore.do", method = RequestMethod.POST)
    public String getScore(HttpServletRequest request, ModelMap model, SatisfyVO satisfyVo) throws Exception {

        satisfyVo = satisfyService.getScoreAvg(satisfyVo);

        return responseJson(model, satisfyVo.getScoreAvg(), Messages.COMMON_PROCESS_OK);
    }

}
