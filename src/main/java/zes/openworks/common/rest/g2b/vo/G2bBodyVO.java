/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b.vo;

import com.thoughtworks.xstream.annotations.XStreamAlias;

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
 *  2014. 12. 11.    이슬버미       신규
 * </pre>
 * @see
 */
public class G2bBodyVO {

    @XStreamAlias("items")
    G2bItemsVO items;

    @XStreamAlias("numOfRows")
    String numOfRows;

    @XStreamAlias("pageNo")
    String pageNo;

    @XStreamAlias("totalCount")
    Integer totalCount;

    /**
     * G2bItemsVO items을 반환
     * 
     * @return G2bItemsVO items
     */
    public G2bItemsVO getItems() {
        return items;
    }

    /**
     * items을 설정
     * 
     * @param items 을(를) G2bItemsVO items로 설정
     */
    public void setItems(G2bItemsVO items) {
        this.items = items;
    }

    /**
     * String numOfRows을 반환
     * 
     * @return String numOfRows
     */
    public String getNumOfRows() {
        return numOfRows;
    }

    /**
     * numOfRows을 설정
     * 
     * @param numOfRows 을(를) String numOfRows로 설정
     */
    public void setNumOfRows(String numOfRows) {
        this.numOfRows = numOfRows;
    }

    /**
     * String pageNo을 반환
     * 
     * @return String pageNo
     */
    public String getPageNo() {
        return pageNo;
    }

    /**
     * pageNo을 설정
     * 
     * @param pageNo 을(를) String pageNo로 설정
     */
    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    /**
     * String totalCount을 반환
     * 
     * @return Integer totalCount
     */
    public Integer getTotalCount() {
        return totalCount;
    }

    /**
     * totalCount을 설정
     * 
     * @param totalCount 을(를) Integer totalCount로 설정
     */
    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

}
