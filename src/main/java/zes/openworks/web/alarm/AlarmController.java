/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */

package zes.openworks.web.alarm;

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
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.StringUtil;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.g2b.bidAno.BidAnoService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.MyCeartVO;
import zes.openworks.web.wish.WishOrderVO;

/**
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.7)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 12. 28.    sa   신규 생성
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/Alarm")
public class AlarmController extends WebController {
    
    
    @Autowired AlarmService service;
    
    /**
     * 코드정보 목록 조회
     */
   // @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_aramList.do", method = RequestMethod.POST)
    public String grList(HttpServletRequest request,  ModelMap model, AlarmVO vo) {
       
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        } 
        
        vo.setConfrmId(userLoginVo.getUserId());
        return responseJson(model, service.alarmList(vo));
    }


    @RequestMapping(value = "BD_aramCheck.do", method = RequestMethod.GET)
    public String aramCheck(HttpServletRequest request,  ModelMap model, AlarmVO vo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        try{
            String returnUrl = request.getParameter("returnUrl");
            String bbsCd = request.getParameter("bbsCd");
            String param ="";
            Integer sn = Integer.valueOf(request.getParameter("sn"));
            
            if(returnUrl == null || returnUrl.equals(""))
               return alertAndRedirect(model, MessageHelper.getMsg(request, "validateFail"), "/");
            
            if(bbsCd != null && !bbsCd.equals(""))
                param = "&bbsCd="+bbsCd;
                
            vo.setConfrmId(userLoginVo.getUserId());
            vo.setAlarmSeq(sn);
            service.alarmUpdate(vo);
          
            return "redirect:" + returnUrl+param;
            
        }catch(Exception e){
            e.printStackTrace();
            return alertAndRedirect(model, MessageHelper.getMsg(request, "validateFail"), "/");
        }
        
    }
    
}
