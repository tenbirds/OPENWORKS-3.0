/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter.batch;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
 * 2015. 8. 25.    방기배       신규
 *</pre>
 * @see
 */

@Repository
public class NewsLetterDeleteExpiredCrtfcBatchDao extends EgovAbstractMapper {
    /**
     * 뉴스레터 기간 만료된 인증 삭제
     */
    public void newsLetterExpiredCrtfcDelete(){
        delete("_newsletter.deleteExpired", null);
    }
    
    /**
     * 회원 테이블에 있는 이메일 뉴스레터에서 삭제
     */
    public void newsLetterMemberDelete(){
        delete("_newsletter.deleteMemberData", null);
    }
}
