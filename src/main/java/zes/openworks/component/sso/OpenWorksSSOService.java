/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sso;

import zes.openworks.intra.login.LoggingWebLoginVO;
import zes.openworks.intra.login.LoginVO;

/**
 * @version 1.0
 * @since openworks-openapi 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 8. 9.    손해석       신규
 * </pre>
 * @see
 */
public interface OpenWorksSSOService {

    LoginVO openWorksSSO(LoginVO vo);

    /**
     * logging 설명
     * 
     * @param vo
     */
    void logging(LoggingWebLoginVO vo);

}
