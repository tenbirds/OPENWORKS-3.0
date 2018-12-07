/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.utils.StringUtil;
import zes.openworks.common.util.random.RandomNumber;

/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 8. 24.    방기배       신규
 *</pre>
 * @see
 */

@Repository
public class NewsLetterDao extends EgovAbstractMapper {
    /**
     * 이메일 중복 체크
     */
    public int emailDupleCheck(NewsLetterVO vo) {
        return (Integer) selectByPk("_newsletter.emailDupleCheck", vo);
    }

    /**
     * 인증메일 정보 저장
     */
    public Map<String, Object> emailCrtfcSave(NewsLetterVO vo) {
        Crypto cry = CryptoFactory.getInstance("SEED");

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("userNm", vo.getUserNm());
        parameterMap.put("email", vo.getEmail());
        parameterMap.put("crtfcKeyValue", cry.encrypt(userTempKey(6, 4)));
        parameterMap.put("emailCrtfcYnCd", 1002);
        parameterMap.put("langCode", vo.getLangCode());

        int dupEmail = (Integer)selectByPk("_newsletter.emailDupleCheck2", parameterMap);

        if(dupEmail == StringUtil.ZERO){
            if(vo.getRequestMode().equals("RQST")){
                //데이터가 없고, 비회원 뉴스레터 신청이면 1002 상태로 insert
                parameterMap.put("affected", insert("_newsletter.emailCrtfcInsert", parameterMap));
            }else{
                //데이터가 없고, 비회원 뉴스레터 거부이면 인증키, 인증시간만 update
                parameterMap.put("affected", insert("_newsletter.emailCrtfcUpdate", parameterMap));
            }
        }else{
            //데이터가 있을수 있는 경우는 스케쥴러(newsLetterDeleteExpiredCrtfcBatchProcessor)와의 시간 오차로 발생한 데이터 임. 즉 3일이상 4일미만의 데이터 임.
            //이 데이터는 인증키, 인증시간만 업데이터 한다.
            //parameterMap.put("affected", 999);
            parameterMap.put("affected", insert("_newsletter.emailCrtfcUpdate", parameterMap));
        }

        return parameterMap;
    }

    /**
     * 이메일 인증 체크
     */
    public int emailCrtfcCheck(Map<String, Object> parameterMap) {
        return (Integer) selectByPk("_newsletter.emailCrtfcCheck", parameterMap);
    }
    
    /**
     * 뉴스레터 신청 완료
     */
    public void newsLetterRequestComplete(Map<String, Object> parameterMap) {
        update("_newsletter.newsLetterUpdate", parameterMap);
    }
    
    /**
     * 뉴스레터 취소 완료
     */
    public void newsLetterCancelComplete(Map<String, Object> parameterMap) {
        delete("_newsletter.newsLetterDelete", parameterMap);
    }
    
    /**
     * 뉴스레터 이메일 안에서 수신거부시 키값 비교
     */
    public int newsLetterRejectFromEmailCheck(Map<String, Object> parameterMap) {
        //int cnt = delete("_newsletter.newsLetterRejectCheck", parameterMap);
        //return cnt;
        return (Integer) selectByPk("_newsletter.newsLetterRejectCheck", parameterMap);
    }

    /**
     * 뉴스레터 이메일 안에서 수신거부
     */
    public int newsLetterRejectFromEmail(Map<String, Object> parameterMap) {
       int affectedRow = delete("_newsletter.newsLetterDelete", parameterMap);
       
       return affectedRow;
    }
    
    /**
     * 임시 비밀번호 생성
     * EX : AA1234567
     * 8자리로 구성하며 앞 두자리는 임의의 영문자 나머지는 숫자로 구성
     */
    private String userTempKey(int alplen, int numlen) {
        String alp = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String num = "0123456789";
        String newkey = "";
        int max = alplen + numlen;
        int n = 0;
        int a_len = alp.length();
        int n_len = num.length();

        for(int i = 0 ; i < max ; i++) {
            if(i < alplen) {
                n = RandomNumber.getInt(a_len);
                newkey = newkey + alp.charAt(n);
            }
            else {
                n = RandomNumber.getInt(n_len);
                newkey = newkey + num.charAt(n);
            }
        }
        return newkey;
    }
}
