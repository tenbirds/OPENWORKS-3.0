/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.spring.view;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.feed.AbstractAtomFeedView;

import zes.base.vo.FeedVO;
import zes.core.utils.DateFormatUtil;
import zes.openworks.common.GlobalConfig;

import com.sun.syndication.feed.atom.Content;
import com.sun.syndication.feed.atom.Entry;
import com.sun.syndication.feed.atom.Feed;

/**
 * AtomFeed View 구현체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class AtomView extends AbstractAtomFeedView {

    @Override
    protected void buildFeedMetadata(Map<String, Object> model, Feed feed, HttpServletRequest request) {

        FeedVO feedVo = (FeedVO) model.get(GlobalConfig.OBJ_DATA_KEY);

        feed.setTitle(feedVo.getTitle());
        feed.setId(feedVo.getLink());

    }

    @Override
    protected List<Entry> buildFeedEntries(Map<String, Object> model, HttpServletRequest request,
        HttpServletResponse response) throws Exception {

        FeedVO baseFeedVo = (FeedVO) model.get(GlobalConfig.OBJ_DATA_KEY);
        List<FeedVO> itemList = baseFeedVo.getItemList();

        List<Entry> feedItems = new ArrayList<Entry>(itemList.size());
        for(FeedVO feedVo : itemList) {

            Date pubDate = DateFormatUtil.toKrDateShort(feedVo.getPubDate());

            Entry entry = new Entry();
            entry.setId(feedVo.getLink());
            entry.setTitle(feedVo.getTitle());
            entry.setUpdated(pubDate);

            Content summary = new Content();
            summary.setValue(feedVo.getDescription());
            entry.setSummary(summary);

            feedItems.add(entry);
        }

        return feedItems;
    }
}