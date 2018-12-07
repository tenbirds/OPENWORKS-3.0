/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.sms;

import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.GlobalConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


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
@Service("smsTransHistService")
public class SmsTransHistServiceImpl extends AbstractServiceImpl implements SmsTransHistService  {
    
    private static String senderTel = Config.getString("sender.senderTel");
    
    @Resource
    private SmsTransHistDAO dao;

    @Override
    public boolean smsTransHist(Map<String, Object> smsMap) {
        String transYn = "";   //발송성공여부
        String celno = setNullValue(smsMap.get("rcvNo"));
        String dutyCd = setNullValue(smsMap.get("dutyCd"));
        String msg = setNullValue(smsMap.get("msg"));
        int j = 0;
        if("".equals(celno) || "".equals(msg)){
            return false;
        }else{
            //80Byte씩 잘라서 나눠보내기
//            String[] smsArr = cutStringArr(msg, 80);
//            for(int i = 0; i < smsArr.length; i++){
                //SMS발송 호출
                if("real".equals(GlobalConfig.SERVICE_MODE)){
                    NiaSmsTrans sms = new NiaSmsTrans();
                    transYn = "N";
                    sms.open();
//                    if(sms.smsTextTrans(smsArr[i], celno)){
                    if(sms.smsTextTrans(msg, celno)){
                        transYn = "Y";
                        j++;
                    }
                    sms.close();
                }else{
                    transYn = "Y";
                }
                //성공 시 이력 쌓기
                if("Y".equals(transYn)){
                    SmsTransHistVO sVo = new SmsTransHistVO();
                    sVo.setRcverMbtlnum(celno);
                    sVo.setSndngMssage(msg);
                    sVo.setSndngDutySeCode(dutyCd);
                    sVo.setSenderTelno(senderTel);
                    dao.insertSmsTransHist(sVo);
                }
//            }
        }
        if(j == 0){
            return false;
        }
        return true;
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
    
    /**
     *  len길이로 잘라 String배열로 반환함
     *
     *  @param 
     *  @return 
     * @throws UnsupportedEncodingException 
    *//*
    private static String[] cutStringArr(String str, int len) {
        byte[] by = str.getBytes();
        int arrSize = (by.length-1)/80;
        
        String[] retArrStr = new String[arrSize+1];
        
        int count = 0;
        int chkArr = 0;
        int startSubStr = 0;
        int endSubStr = 80;
        int chkLength = by.length;
        int i = 0;
        
        while(chkLength > 0){
            
            if(chkLength == 0) break;
            
            if((by[i] & 0x80) == 0x80){
                count++;
            }
            
            if(((i != 0) && (i%len == 0)) || ((chkLength-1) == i)){
                
                if(chkLength <= len){
                    retArrStr[chkArr] = new String(by, startSubStr, chkLength);
                    
                    chkLength = 0;
                    break;
                }else{
                    if(((by[i -1] & 0x80) == 0x80) && ((count%2) == 0)){
                        retArrStr[chkArr] = new String(by, startSubStr, endSubStr-1);
                        
                        by = (new String(by, endSubStr-1, chkLength-endSubStr-1)).getBytes();
                    }else{
                        retArrStr[chkArr] = new String(by, startSubStr, endSubStr);
                        
                        by = (new String(by, endSubStr, chkLength-endSubStr)).getBytes();
                        
                    }
                    
                    chkLength = by.length;
                
                    i = -1;
                }               
                chkArr++;
                count = 0;
            }
            i++;
        }
        return retArrStr; 
    }*/
}
