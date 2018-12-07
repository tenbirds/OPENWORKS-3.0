/*
 * Copyright (c) 2013 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;

import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *   
 *    수정일          수정자      수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 14.   김영상      신규
 *</pre>
 * @see
 */
@Repository
public class AutoMailDAO extends EgovAbstractMapper {
    
    /**
     * insertEmailSendReg email 보내기 등록 - TCN_EMAL_TRNS_H
     * @param autoMailVO
     * @return int
     */
    public int insertAutoMail(AutoMailVO autoMailVO) {
        return insert("_commonduty.insertAutoMail", autoMailVO);
    }
}
