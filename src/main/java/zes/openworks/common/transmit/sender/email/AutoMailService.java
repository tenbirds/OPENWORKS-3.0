/*
 * Copyright (c) 2013 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;

import java.util.Map;


/**
 * 
 *
 * @version 1.0
 * @since kwea_new 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일          수정자      수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 14.   김영상      신규
 *</pre>
 * @see
 */
public interface AutoMailService {
    
    
    /**
     * email 보내기 등록 서비스
     * @param HashMap
     * @return int
     */
    public boolean sendAutoMail(Map<String, Object> sendMap);

}
