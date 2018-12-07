/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.wiki;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;

/**
*
* @Class Name : WikiServiceImpl
* @version 1.0
* @since OpenMarketPlace 프로젝트. (After JDK 1.6)
* @author 오픈마켓플레이스
* @Description : 씨앗마켓 위키 공통 ServiceImpl
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일                 수정자                수정내용
*--------------    ----------    -------------------------------
* 2016. 01. 04.    (주)엔키소프트      신규
* @see
*/
@Service
public class WikiServiceImpl extends AbstractServiceImpl implements WikiService {

    @Resource
    private WikiDAO dao;

    /**
     * 최신 등록 위키 상세
     * @param Map searchMap
     * @return 최신 등록 위키 상세
     * @exception
     */
    @Override
    public Map<String, Object> wikiView(Map searchMap) {
        return dao.wikiView(searchMap);
    }

    /**
     * 위키 등록 처리
     * @param Map procMap
     * @return
     */
    @Override
    public void wikiRegist(Map procMap) {
        dao.wikiRegist(procMap);
    }

    /**
     * 위키 항목 작성이력 조회
     * @param WikiVO wikiVO
     * @return 위키 항목 작성이력
     * @exception
     */
    @Override
    public Pager<WikiVO> wikiHistoryList(WikiVO wikiVO) {
        return dao.wikiHistoryList(wikiVO);
    }


    /**
     * 위키 되돌리기 처리
     * @param Map procMap
     * @return
     */
    @Override
    public int wikiUndoContents(Map procMap) {
        return dao.wikiUndoContents(procMap);
    }
}
