/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import zes.core.spi.oscache.Cache;
import zes.core.spi.oscache.ICache;
import zes.openworks.intra.help.HelpVO;

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
 *  2013. 5. 2.    neteran   신규 생성
 * </pre>
 * @see
 */
public class MenuHelpCache implements ICache {

    public static final String CACHE_KEY = "__helpInfo";

    public void createCache(SqlSession sqlSession, Integer domainCd) {

        List<HelpVO> helpInfoList = sqlSession.selectList("_help.helpInfo", domainCd);
        Map<String, HelpVO> helpMap = new HashMap<String, HelpVO>();
        if(helpInfoList.size() > 0) {
            for(HelpVO helpVo : helpInfoList) {
                if(helpMap.containsKey(helpVo.getMenuCd())) {
                    HelpVO preHelp = helpMap.get(helpVo.getMenuCd());
                    String nextHelp = preHelp.getContents() + "<br />" + helpVo.getContents();
                    helpVo.setContents(nextHelp);
                    helpMap.put(String.valueOf(helpVo.getMenuCd()), helpVo);
                } else {
                    helpMap.put(String.valueOf(helpVo.getMenuCd()), helpVo);
                }
            }

            Cache.put(CACHE_KEY, helpMap);

        }

    }

    @Override
    public void reloadCache(SqlSession sqlSession) {
        reloadCache(sqlSession, null);
    }

    @Override
    public void reloadCache(SqlSession sqlSession, Integer domainCd) {
        createCache(sqlSession, null);
    }

    @Override
    public String getName() {

        return "도움말 정보";
    }

    @Override
    public void createCache(SqlSession sqlSession) {
        createCache(sqlSession, null);
    }

}
