/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;

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
 * 2014. 11. 14.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/common/send/")
public class AutoMailController extends IntraController {
    
    @Autowired
    private AutoMailService service;
    
    /**
     *  email
     */
    @RequestMapping(value = "ND_testAutoMail.do")
    public String senderAction(HttpServletRequest request, ModelMap model) throws Exception {

        Map<String, Object> autoMap = new HashMap<String, Object>();
        // 필수 입력 항목
        /*
           ---------------------------------------------------------   
              메일템플릿 번호
           ---------------------------------------------------------   
           //AutoMailTemplate.java참고
           ---------------------------------------------------------   
        */
        // 전송할 메일 아이디 입력
        autoMap.put("automailId", "메일템플릿 번호명"); 
        autoMap.put("receiverName", "수신자명");
        autoMap.put("email", "수신자이메일"); 
        
        // 메일 템플릿에 적용될 치환값
        /*
                회원가입안내메일 : name
                신규비밀번호     : name, new_password
                질문 답변        : name
                경고메일         : name, warn_content, link_addr, link_title
         */
        HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
        // 치환내용 입력
        // 메일 종류에 따라 선택적으로 입력
        oneToOneInfoMap.put("name", "메일 템플릿에 치환될 내용 - name");  
        oneToOneInfoMap.put("warn_content", "메일 템플릿에 치환될 내용 - content");  
        oneToOneInfoMap.put("link_addr", "메일 템플릿에 치환될 내용 - addr");  
        oneToOneInfoMap.put("link_title", "메일 템플릿에 치환될 내용 - title");  
        
        // 치환정보 맵 입력
        autoMap.put("oneToOneInfo", oneToOneInfoMap);
        
        // 선택 입력 항목
        autoMap.put("senderName", "ceartMarket");       // 생략시 기본 설정값 적용 : 씨앗마켓
        //autoMap.put("senderEmail", "발신자 이메일");     // 생략시 기본 설정값 적용 : webmaster@ceart.kr
        //autoMap.put("mailTitle", "메일 제목");          // 생략시 기본 설정값 적용

        try {
            boolean result = service.sendAutoMail(autoMap);

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