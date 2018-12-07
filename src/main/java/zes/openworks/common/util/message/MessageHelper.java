/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.util.message;

import javax.servlet.http.HttpServletRequest;

import zes.core.spi.commons.configuration.Config;
import zes.openworks.intra.cms.support.CmsUtil;


/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 4. 11.    김영상       신규
 *</pre>
 * @see
 */
public class MessageHelper {

    /**
     * getMsg 설명
     * @param request
     * @param string
     * @return
     */
    public static String getMsg(HttpServletRequest request, String string) {
        String hostNm = "";
        String key = "";
        String upKey = "";
        hostNm = request.getServerName() == null ? "" : CmsUtil.getHostName(request.getServerName());
        if(!"".equals(hostNm)){
            if("intra".equals(hostNm) || "korean".equals(hostNm)){
                upKey = "msg";
            }else{
                upKey = hostNm+"Msg";
            }
            key = upKey + "." + string;
        }
        return Config.getString(key);
    }
}
