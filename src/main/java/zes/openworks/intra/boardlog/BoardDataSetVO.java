/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.ArrayList;
import java.util.List;

import zes.base.vo.BaseVO;

/**
 * 게시판 로그 데이터셋 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일               수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 25.     홍길동     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardDataSetVO extends BaseVO {

    static final long serialVersionUID = -8811750719254168927L;

    /** 데이터셋 이름 */
    private String dataSetNm;
    /** Y축 이름 */
    private String axisY;
    /** Y축 이름 */
    private String color;
    /** 데이터셋 */
    private List<Integer> dataList;
    /** 최대 */
    private Integer maxCnt = 0;
    /** 전체평균 */
    private String avgCnt = "0";
    /** 0이상평균 */
    private String zeroAvgCnt = "0";
    /** 최소 */
    private Integer minCnt = 0;
    /** 전체 */
    private Integer totalCnt = 0;
    /** 최대인덱스 */
    private List<String> maxIndexList = new ArrayList<String>();
    /** 최소인덱스 */
    private List<String> minIndexList = new ArrayList<String>();

    public String getDataSetNm() {
        return dataSetNm;
    }

    public void setDataSetNm(String dataSetNm) {
        this.dataSetNm = dataSetNm;
    }

    public String getAxisY() {
        return axisY;
    }

    public void setAxisY(String axisY) {
        this.axisY = axisY;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public List<Integer> getDataList() {
        return dataList;
    }

    public void setDataList(List<Integer> dataList, List<String> categoryList) {
        this.dataList = dataList;
        Integer zeroOverCnt = 0;

        for(Integer val : dataList) {
            if(val.intValue() > this.maxCnt.intValue()) {
                this.maxCnt = val;
            }
            if(val.intValue() < this.minCnt.intValue()) {
                this.minCnt = val;
            }
            if(val.intValue() > 0) {
                zeroOverCnt++;
            }
            this.totalCnt += val;
        }
        if(dataList.size() == 0) {
            this.avgCnt = "0.0";
        } else {
            this.avgCnt = String.format("%.1f", Float.valueOf(totalCnt) / Float.valueOf(dataList.size()));
        }
        if(zeroOverCnt == 0) {
            this.zeroAvgCnt = "0.0";
        } else {
            this.zeroAvgCnt = String.format("%.1f", Float.valueOf(totalCnt) / Float.valueOf(zeroOverCnt));
        }

        for(int i = 0 ; i < dataList.size() ; i++) {
            Integer val = dataList.get(i);
            if((val.intValue() == this.maxCnt.intValue()) && (val.intValue() > 0)) {
                this.maxIndexList.add(categoryList.get(i));
            }
            if((val.intValue() == this.minCnt.intValue()) && (val.intValue() > 0)) {
                this.minIndexList.add(categoryList.get(i));
            }
            this.totalCnt += val;
        }
    }

    public Integer getMaxCnt() {
        return maxCnt;
    }

    public String getAvgCnt() {
        return avgCnt;
    }

    public Integer getMinCnt() {
        return minCnt;
    }

    public Integer getTotalCnt() {
        return totalCnt;
    }

    public List<String> getMaxIndexList() {
        return maxIndexList;
    }

    public List<String> getMinIndexList() {
        return minIndexList;
    }

    public String getZeroAvgCnt() {
        return zeroAvgCnt;
    }
}
