/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.analyze.tracking;

//import java.io.UnsupportedEncodingException;
//import java.net.URLDecoder;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
//import zes.core.spi.commons.configuration.Config;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 3.    김영상       신규
 *</pre>
 * @see
 */
@Service("webTrackingService")
public class WebTrackingServiceImpl extends AbstractServiceImpl implements WebTrackingService {
    @Resource
    private WebTrackingDAO dao;

    @Override
    public void analyzeTracking(WebTrackingVO vo) {

        dao.analyzeTracking(vo);

        /*// 처음접속인경우 클라이언트 정보를 기록한다
        if(vo.getAnlzPageViewCnt() == 1) {
            dao.analyzeTrackingClientPlatform(vo);

            // 북마크 이거나 다른 사이트에서 들어온 경우에만 기록한다
            if(vo.getAnlzReferer().indexOf(vo.getAnlzDomainNm()) < 0) {

                // 검색엔진 유입 로그
                setSearchEngineInfo(vo);
                dao.analyzeTrackingReferrer(vo);

            }
        }*/
    }

    /**
     * 검색엔진 유입정보 셋팅
     * 
     * @param vo
     *//*
    private void setSearchEngineInfo(WebTrackingVO vo) {

        if(vo.getAnlzSearchEngineYn().equals("Y")) {
            String url = vo.getAnlzReferer();
            String[] domains = Config.getStringArray("analyze.search-engines.domain");
            String[] names = Config.getStringArray("analyze.search-engines.name");
            String[] encodings = Config.getStringArray("analyze.search-engines.domain-encoding");
            String[] keys = Config.getStringArray("analyze.search-engines.search-key");

            String searchWord = "";
            String encoding = "";
            String domain = "";
            String name = "";
            for(int i = 0 ; i < domains.length ; i++) {
                if(url.indexOf(names[i]) >= 0) {
                    int idx = url.indexOf(keys[i]) + keys[i].length();
                    searchWord = url.substring(idx);
                    if(searchWord.indexOf("&") >= 0) {
                        searchWord = searchWord.substring(0, searchWord.indexOf("&"));
                    }
                    domain = domains[i];
                    name = names[i];
                    encoding = encodings[i];
                    break;
                }
            }
            vo.setAnlzSearchDomain(domain);
            vo.setAnlzSearchName(name);

            try {
                vo.setAnlzSearchWord(URLDecoder.decode(searchWord, encoding));
            } catch (UnsupportedEncodingException e) {
                vo.setAnlzSearchWord("");
            }
        }
    }*/
}
