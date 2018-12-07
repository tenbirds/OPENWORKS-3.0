/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.webLog;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.vo.IExcelVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.user.UserVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 22.    유상원   회원 접속 이력 관리
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/user/webLog")
public class UserWebLogController extends IntraController {

    @Autowired
    private UserWebLogService service;

    /**
     * 회원 접속 이력 관리 - 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_userWebLogList.do")
    public ModelMap userWebLogList(ModelMap model, HttpServletRequest request, UserVO vo, UserWebLogVO logVo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        // 검색 옵션 목록
        CodeVO codeVo = new CodeVO();
        codeVo.setGrpCd(71);
        model.addAttribute("regTypeList", service.codePrvList(codeVo)); // 회원가입유형 목록
                                                                    // (회원가입유형
                                                                    // 그룹코드:71)
        model.addAttribute("userGradeList", service.userGradeList()); // 회원등급 목록

        model.addAttribute(GlobalConfig.KEY_PAGER, service.userWebLogList(vo));
        // 금일 로그인(접속) 통계
//        UserWebLogVO list1 = service.getStatistic1(logVo);
//        model.addAttribute("dataList1", list1);

        return model;
    }

    /**
     * 회원 접속 이력 관리 - 상세 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_userWebLog.do")
    public ModelAndView userWebLog(ModelAndView model, HttpServletRequest request, UserWebLogVO vo, UserWebLogVO logVo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        model.addObject(GlobalConfig.KEY_PAGER, service.userWebLog(vo));
        model.addObject("loginIp", service.userLoginIp(vo));

        // 접속회원 아이피통계
        UserWebLogVO data1 = service.getStatistic3(logVo);
        model.addObject("dataList1", data1);
        List<UserWebLogVO> list2 = service.getStatistic2(logVo);
        model.addObject("dataList2", list2);

        return model;
    }

    /**
     * 비밀번호 확인 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_pwdLogConfirm.do")
    public void pwdConfirm(HttpServletRequest request, ModelMap model) {
        String paramVal = request.getParameter("paramVal");
        if(paramVal.equals(null) || paramVal.equals("")) {
            paramVal = "";
        } else {
            paramVal = paramVal.replaceAll("∬", "&");
        }

        model.addAttribute("paramVal", paramVal);
    }

    /**
     * 회원접속이력관리 엑셀출력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_userWebLogListExcel.do")
    public String userWebLogListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute UserVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.put("_webLogList", service.userWebLogListExcel(vo));
        IExcelVO userWebLogListExcel = new UserWebLogListExcelVO();
        return responseExcel(model, userWebLogListExcel);
    }

    /**
     * 회원접속이력관리상세 엑셀출력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_userWebLogExcel.do")
    public String userWebLogExcel(ModelMap model, HttpServletRequest request, @ModelAttribute UserWebLogVO vo) {
        OpHelper.bindSearchMap(vo, request);
        vo.setUserId(request.getParameter("userId"));
        model.put("_webLog", service.userWebLogExcel(vo));

        IExcelVO userWebLogExcel = new userWebLogExcelVO();
        return responseExcel(model, userWebLogExcel);
    }
}
