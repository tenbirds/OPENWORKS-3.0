/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.grade;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 회원 등급 관리
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
@RequestMapping(value = "/intra/user/grade")
public class UserGradeController extends IntraController {

    @Autowired
    UserGradeService userGradeService;

    /**
     * 회원 등급 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_UserGradeList.do" })
    public void getUserGradeList(ModelMap model, UserGradeVO userGradeVo) throws Exception {

        List<UserGradeVO> dataList = userGradeService.getUserGradeList(userGradeVo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, dataList);
    }

    /**
     * 회원 등급 코드 존재 여부 확인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_CheckGradeCd.do")
    public String checkGradeCd(ModelMap model, UserGradeVO userGradeVo) throws Exception {

        UserGradeVO dataVo = userGradeService.getUserGrade(userGradeVo);

        if(Validate.isNull(dataVo)) {
            return responseJson(model, Boolean.TRUE);
        }
        return responseJson(model, Boolean.FALSE);
    }

    /**
     * 회원 등급 등록 폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_InsertUserGradeForm.do")
    public void insertUserGradeForm(ModelMap model, UserGradeVO userGradeVo) throws Exception {

        // 검증 데이터
        ValidateResultHolder holder = ValidateUtil.validate(userGradeVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);
    }

    /**
     * 회원 등급 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_InsertAction.do", method = RequestMethod.POST)
    public String insertUserGradeAction(HttpServletRequest request, ModelMap model, UserGradeVO userGradeVo)
        throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(userGradeVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            userGradeVo.setRegistId(loginVo.getMngrId());

            userGradeService.insertUserGrade(userGradeVo);
        } else {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_VALIDATE_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK);
    }

    /**
     * 회원 등급 수정 폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_UpdateUserGradeForm.do")
    public void updateUserGradeForm(ModelMap model, UserGradeVO userGradeVo) throws Exception {

        // 검증 데이터
        ValidateResultHolder holder = ValidateUtil.validate(userGradeVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        UserGradeVO dataVo = userGradeService.getUserGrade(userGradeVo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVo);
    }

    /**
     * 회원 등급 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_UpdateAction.do", method = RequestMethod.POST)
    public String updateUserGradeAction(HttpServletRequest request, ModelMap model, UserGradeVO userGradeVo)
        throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(userGradeVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            userGradeVo.setUpdtId(loginVo.getMngrId());

            userGradeService.updateUserGrade(userGradeVo);

        } else {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_VALIDATE_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 회원 등급 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_DeleteAction.do", method = RequestMethod.POST)
    public String deleteUserGradeAction(ModelMap model, UserGradeVO userGradeVo) throws Exception {

        int affected = userGradeService.deleteUserGrade(userGradeVo);

        if(affected == 0) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
    }

}
