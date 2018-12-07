/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.vo;

import java.util.List;

/**
 * RSS, Atom Feed VO
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
public class FeedVO extends BaseVO {

    private static final long serialVersionUID = 4314981010698028031L;

    /** FEED 목록 */
    private List<FeedVO> itemList;

    /** 제목 */
    private String title;

    /** 요약 부분 */
    private String description;

    /** 본페이지 링크 */
    private String link;

    /** 작성자 */
    private String author;

    /** 작성일 */
    private String pubDate;

    /**
     * List<BaseFeedVO> itemList을 반환
     * 
     * @return List<BaseFeedVO> itemList
     */
    public List<FeedVO> getItemList() {
        return itemList;
    }

    /**
     * itemList을 설정
     * 
     * @param itemList 을(를) List<BaseFeedVO> itemList로 설정
     */
    public void setItemList(List<FeedVO> itemList) {
        this.itemList = itemList;
    }

    /**
     * String title을 반환
     * 
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    /**
     * title을 설정
     * 
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * String description을 반환
     * 
     * @return String description
     */
    public String getDescription() {
        return description;
    }

    /**
     * description을 설정
     * 
     * @param description 을(를) String description로 설정
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * String link을 반환
     * 
     * @return String link
     */
    public String getLink() {
        return link;
    }

    /**
     * link을 설정
     * 
     * @param link 을(를) String link로 설정
     */
    public void setLink(String link) {
        this.link = link;
    }

    /**
     * String author을 반환
     * 
     * @return String author
     */
    public String getAuthor() {
        return author;
    }

    /**
     * author을 설정
     * 
     * @param author 을(를) String author로 설정
     */
    public void setAuthor(String author) {
        this.author = author;
    }

    /**
     * String pubDate을 반환
     * 
     * @return String pubDate
     */
    public String getPubDate() {
        return pubDate;
    }

    /**
     * pubDate을 설정
     * 
     * @param pubDate 을(를) String pubDate로 설정
     */
    public void setPubDate(String pubDate) {
        this.pubDate = pubDate;
    }

}
