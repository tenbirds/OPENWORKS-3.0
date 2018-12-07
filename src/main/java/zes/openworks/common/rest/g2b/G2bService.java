/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b;

import zes.openworks.common.rest.g2b.vo.G2bResponseVO;
import zes.openworks.common.rest.g2b.vo.G2bVO;


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
 * 2014. 12. 11.    이슬버미       신규
 *</pre>
 * @see
 */
public interface G2bService {

    

    /**
     * getInsttAcctoBidPblancListServc (나라장터 기관별 입찰공고/재공고 용역 목록을 조회)
     * @param Vo
     
       sDate        20130825        조회날짜(시작) 
       eDate        20131025        조회날짜(끝) 
       orderCode    한국국제협력단  발주기관 
       demandCode   조달청          수요기관명 
       dateType     1               공고/개찰일(0/1) 
 
   
     * @return
     * @throws Exception 
     */
    G2bResponseVO getInsttAcctoBidPblancListServc(G2bVO vo) throws Exception;

    
    
    /**
     * getInsttCntrctInfoListServcCntrctSttus (나라장터 계약현황 기관별 용역 목록을 조회)
     * @param Vo

        sDate       20130923    조회날짜(시작) 
        eDate       20130923    조회날짜(끝) 
        contractNum 제9506부대  계약기관명 
        demandNum   제9506부대  수요기관명 

     * 
     * @return
     * @throws Exception 
     */
    G2bResponseVO getInsttCntrctInfoListServcCntrctSttus(G2bVO vo) throws Exception;
}
