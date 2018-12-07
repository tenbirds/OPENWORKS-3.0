/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.wiki;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.core.bind.VoBinder;

/**
*
* @Class Name : WikiDAO
* @version 1.0
* @since OpenMarketPlace 프로젝트. (After JDK 1.6)
* @author 오픈마켓플레이스
* @Description : 씨앗마켓 위키 공통 DAO
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일                 수정자                수정내용
*--------------    ----------    -------------------------------
* 2016. 01. 04.    (주)엔키소프트      신규
* @see
*/
@Repository
@SuppressWarnings("unchecked")
public class WikiDAO extends EgovAbstractMapper {
    /**
     * 최신 등록 위키 상세
     * @param WikiVO searchMap
     * @return 최신 등록 위키 상세
     * @exception
     */
    public Map<String, Object> wikiView(Map searchMap) {
        return (Map<String, Object>)selectByPk("_wiki.wikiView", searchMap);
    }

    /**
     * 위키 등록 처리
     * @param Map procMap
     * @return
     */
    public void wikiRegist(Map procMap) {
        insert("_wiki.wikiRegist", procMap);
    }


    /**
     * 위키 항목 작성이력 조회
     * @param WikiVO wikiVO
     * @return 위키 항목 작성이력
     * @exception
     */
    @SuppressWarnings("unchecked")
    public Pager<WikiVO> wikiHistoryList(WikiVO wikiVO) {

        Map<String, Object> parameterMap = wikiVO.getDataMap();

        VoBinder.methodBind(parameterMap, wikiVO);

        int listTotalCount = ((Integer) (selectByPk("_wiki.wikiHistoryCount", parameterMap))).intValue();
        List<WikiVO> dataList = list("_wiki.wikiHistoryList", parameterMap);
        wikiVO.setTotalNum(listTotalCount);

        return new Pager<WikiVO>(dataList, wikiVO);
    }


    /**
     * 위키 되돌리기 처리
     * @param Map procMap
     * @return
     */
    public int wikiUndoContents(Map procMap) {
        return update("_wiki.wikiUndoContents", procMap);
    }


}
