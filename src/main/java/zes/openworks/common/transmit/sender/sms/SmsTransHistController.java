/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.sms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 21.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/common/send/")
public class SmsTransHistController extends IntraController {
    @Autowired
    private SmsTransHistService service;
    
    @RequestMapping(value = "ND_testSmsTrans.do")
        public String senderAction(HttpServletRequest request, ModelMap model) throws Exception {
        Map<String, Object> smsMap = new HashMap<String, Object>();

        smsMap.put("rcvNo", "수신번호");
        smsMap.put("msg", "발신내용");      //메시지번호별 발송메시지 SmsTransHistConstant.java참고
        smsMap.put("dutyCd", "업무코드");   //RM,CM,UM,CO...
        
        try {
            //발송 및 전송이력쌓기
            boolean result = service.smsTransHist(smsMap);
    
            if(result){
                return responseText(model, Messages.TRUE); 
            }else{
                return responseText(model, Messages.FALSE);
            }
        }catch(Exception e){
            return responseText(model, Messages.FALSE);
        }
    }
}
