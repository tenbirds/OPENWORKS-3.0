/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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

@Service("newsLetterService")
public class NewsLetterServiceImpl extends AbstractServiceImpl implements NewsLetterService {
    @Resource
    private NewsLetterDao newsLetterDao;
    
    @Override
    public int emailDupleCheck(NewsLetterVO vo) {
        return newsLetterDao.emailDupleCheck(vo);
    }
    
    @Override
    public Map<String, Object> emailCrtfcSave(NewsLetterVO vo) {
        return newsLetterDao.emailCrtfcSave(vo);
    }
    
    @Override
    public int emailCrtfcCheck(Map<String, Object> parameterMap) {
        return newsLetterDao.emailCrtfcCheck(parameterMap);
    }
    
    @Override
    public void newsLetterRequestComplete(Map<String, Object> parameterMap) {
        newsLetterDao.newsLetterRequestComplete(parameterMap);
    }
    
    @Override
    public void newsLetterCancelComplete(Map<String, Object> parameterMap) {
        newsLetterDao.newsLetterCancelComplete(parameterMap);
    }
    
    @Override
    public int newsLetterRejectFromEmailCheck(Map<String, Object> parameterMap) {
        return newsLetterDao.newsLetterRejectFromEmailCheck(parameterMap);
    }
    
    @Override
    public int newsLetterRejectFromEmail(Map<String, Object> parameterMap) {
        return newsLetterDao.newsLetterRejectFromEmail(parameterMap);
    }
}
