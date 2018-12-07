/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.boardCount;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
 *  2013. 5. 14.    sa   신규 생성
 * </pre>
 * @see
 */
@Service("boardCountService")
public class BoardCountServiceImpl extends AbstractServiceImpl implements BoardCountService {

    @Resource
    private BoardCountDAO dao;

    @Override
    public Object incMenuReadCount(Integer bbsCd) {

        /*
         * BoardCountVO vo =new BoardCountVO();
         * vo.setYmdDate(Integer.valueOf(DateFormatUtil.getTodayShort()));
         * vo.setDomainCd(1);
         * vo.setMenuCode("openworks");
         */

        return dao.incMenuReadCount(bbsCd);
    }

}
