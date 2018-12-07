/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.listener;

import java.io.Serializable;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 13.    유상원   회원 관리
 * </pre>
 * @see
 */
public class LoginSessionBinding implements HttpSessionBindingListener,Serializable {

    private final Log log = LogFactory.getLog(this.getClass());

    @SuppressWarnings("rawtypes")
    public static Hashtable loginUsers = new Hashtable();

    /**
     * 세션 등록 시 호출
     * 
     * @see javax.servlet.http.HttpSessionBindingListener#valueBound(javax.servlet.http.HttpSessionBindingEvent)
     */
    @Override
    @SuppressWarnings("unchecked")
    public void valueBound(HttpSessionBindingEvent event) {
        HttpSession session = event.getSession();
        if(session != null) {
            loginUsers.put(event.getSession().getId(), 1);
        }
    }

    /**
     * 세션 제거 시 호출
     * 
     * @see javax.servlet.http.HttpSessionBindingListener#valueUnbound(javax.servlet.http.HttpSessionBindingEvent)
     */
    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        try {
            HttpSession session = event.getSession();
            if(session != null) {
                loginUsers.remove(event.getSession().getId());
            }
        } catch (Exception e) {
            log.error(e);
        }
    }

}
