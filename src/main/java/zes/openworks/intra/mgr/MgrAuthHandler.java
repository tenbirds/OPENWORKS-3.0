/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.mgr;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;


/**
 * 
 *
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 15.    박수정   신규
 *</pre>
 * @see
 */
public class MgrAuthHandler implements ResultHandler {

    private String result;

    public String getResult() {
        return result;
    }

    @Override
    public void handleResult(ResultContext context) {

        MgrVO dataVo = (MgrVO)context.getResultObject();
        String[] authNms = dataVo.getAuthNms();
        
        StringBuffer strbf = new StringBuffer();
        for(String authNm : authNms ) {
            if(strbf.length() > 0) {
                strbf.append("/");
            }
            strbf.append(authNm);
        }
        
        result = strbf.toString();
    }

}
