/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter;

import java.util.Map;

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
public interface NewsLetterService {
    int emailDupleCheck(NewsLetterVO vo);   //이메일 중복 체크
    
    Map<String, Object> emailCrtfcSave(NewsLetterVO vo);   //뉴스레터 신청
    
    int emailCrtfcCheck(Map<String, Object> parameterMap);  //이메일 인증 체크
    
    void newsLetterRequestComplete(Map<String, Object> parameterMap);  //뉴스레터 신청 완료
    
    void newsLetterCancelComplete(Map<String, Object> parameterMap);  //뉴스레터 취소 완료
    
    int newsLetterRejectFromEmailCheck(Map<String, Object> parameterMap);  //뉴스레터 이메일에서 수신거부시 키값 비교
    
    int newsLetterRejectFromEmail(Map<String, Object> parameterMap);  //뉴스레터 이메일에서 수신거부
}
