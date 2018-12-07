/*
 * Copyright (c) 2013 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

//Mail API
import com.andwise.tm6.api.jars.automail.AutomailAPI;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 *
 *
 * @version 1.0
 * @since kwea_new 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일            수정자    수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 14.    김영상     신규
 *</pre>
 * @see
 */
@Service("SenderService")
public class AutoMailServiceImpl extends AbstractServiceImpl implements AutoMailService {

    /** Contrroller 로깅 */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private AutoMailDAO dao;

    /** 메일 등록일 */
    public static final SimpleDateFormat ISO_SHORT_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * EMAIL 보내기 등록 서비스
     * @param HashMap
     * @return int
     */
    @SuppressWarnings("unchecked")
    @Override
    public boolean sendAutoMail(Map<String, Object> data) {

        InetAddress inet;
        String svrIP = "";
        try {
            inet = InetAddress.getLocalHost();
            svrIP = inet.getHostAddress();
        } catch (UnknownHostException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        // 썬더오토메일 VO
        AutoMailVO autoMailVO = new AutoMailVO();

        //logger.info("##### 1");

        // 기본값은 config/commons/global-config.xml 파일 내의 autoMail 속성 참조
        // 이메일 템플릿 번호
        AutoMailTemplate automailId = (AutoMailTemplate)data.get("automailId");
        autoMailVO.setAtmcEmailId(automailId.value());

        //logger.info("##### 2");

        // 발송자 이름
        String senderName = setNullValue(data.get("senderName"));
        if(senderName.length() > 0) {
            autoMailVO.setTrnsmiterNm(senderName);
        }

        //logger.info("##### 3");

        // 발송자 이메일
        String senderEmail = setNullValue(data.get("senderEmail"));
        if(senderEmail.length() > 0) {
            autoMailVO.setTrnsmiterEmail(senderEmail);
        }

        //logger.info("##### 4");

        // 이메일 제목
        String mailTitle = setNullValue(data.get("mailTitle"));
        if(mailTitle.length() > 0) {
            autoMailVO.setEmailTitle(mailTitle);
        }

        //logger.info("##### 5");

        // 수신자 이름
        String receiverName = setNullValue(data.get("receiverName"));
        if(receiverName.length() > 0) {
            autoMailVO.setRcverNm(receiverName);
        }

        //logger.info("##### 6");

        // 수신자 이메일
        String email = setNullValue(data.get("email"));
        if(email.length() > 0) {
            autoMailVO.setRcverEmail(email);
        }

        //logger.info("##### 7");

        HashMap<String, String> tempMap = (HashMap<String, String>)data.get("oneToOneInfo");

        //logger.info("##### 8");

        String oneToOneInfo = "";
        // 반복문의 처음인지 체크 변수
        boolean first = true;
        Set<String> keySet = tempMap.keySet();
        for (String key : keySet) {
            if (first == false) {
                oneToOneInfo += "æ[$" + key + "]Ð"+ tempMap.get(key);
            } else {
                oneToOneInfo += "[$" + key + "]Ð" + tempMap.get(key);
            }
            first = false;
        }

        autoMailVO.setOnetooneInfo(oneToOneInfo);

        logger.debug("\n\n\n\n\n");
        logger.debug(autoMailVO + "");
        logger.debug("\n\n\n\n\n");

        //API를 통해 메일전송
        if(
            svrIP.equals("202.30.77.182") 
            || svrIP.equals("202.30.77.183")
        ){
            sendMail(autoMailVO);
        }

        logger.debug("\n\n\n\n\n");
        logger.debug(autoMailVO + "");
        logger.debug("\n\n\n\n\n");

        //히스토리 테이블에 내역 등록
        dao.insertAutoMail(autoMailVO);

        return Boolean.TRUE;
    }

    /**
     * null일 경우 "" 반환
     * @param obj
     * @return
     */
    private String setNullValue(Object obj) {
        if (obj == null)
            return "";
        else
            return obj.toString();
    }

    // API를 이용한 메일 전송
    private AutoMailVO sendMail(AutoMailVO autoMailVO){
        //템플릿 번호로 암호화 키를 셋팅
        AutoMailTemplateNumEncrypt templateNumEncrypt = new AutoMailTemplateNumEncrypt();
        //해당 템플릿 번호에 대한 암호화 키를 가져온다.
        String templateStr = templateNumEncrypt.getTemplateEncNo(Integer.toString(autoMailVO.getAtmcEmailId()));


        AutomailAPI automailAPI = new AutomailAPI();

        automailAPI.setApiURL("http://202.30.77.181:8090/tm6/app/api/automail/send");   //썬더메일UI URL
        automailAPI.setAutomailIDEncrypt(templateStr);                                  //템플릿번호(암호화키)
        automailAPI.setMailTitle(autoMailVO.getEmailTitle());                           //메일 제목
        //automailAPI.setMailContent("[$name]의 생일 [$birthday]을 축하합니다.");       //메일 내용
        automailAPI.setSenderName(autoMailVO.getTrnsmiterNm());                         //보내는 사람 이름
        automailAPI.setSenderEmail(autoMailVO.getTrnsmiterEmail());                     //보내는 사람 이메일
        automailAPI.setReceiverName(autoMailVO.getRcverNm());                           //받는 사람 이름
        automailAPI.setReceiverEmail(autoMailVO.getRcverEmail());                       //받는 사람 이메일
        automailAPI.setReturnMail(autoMailVO.getTrnsmiterEmail());                      //반송 이메일
        automailAPI.setOnetooneInfo(autoMailVO.getOnetooneInfo());                      //일대일치환 정보
        //automailAPI.setReserveDate("2015-07-22 15:00:00");                            //예약발송 일시
        automailAPI.sendEmail();                                                        //메일 발송

        autoMailVO.setResultCode(automailAPI.getCode());                                //발송결과 코드
        autoMailVO.setResultMsg(automailAPI.getMsg());                                  //발송결과 메세지

        return autoMailVO;
    }
}
