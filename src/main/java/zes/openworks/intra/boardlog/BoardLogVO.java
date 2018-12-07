/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import zes.base.vo.BaseVO;

/**
 * 게시판 로그 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2012. 6. 25.     홍길동      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardLogVO extends BaseVO implements Comparable<BoardLogVO> {

    static final long serialVersionUID = 7477086373933589868L;

    /** 라벨 */
    private String label;
    /** 라벨2 */
    private String label2;
    /** 값 */
    private int value;
    /** 넓이 */
    private int width;
    /** 비율 */
    private int ratio;

    public BoardLogVO() {
    };

    public BoardLogVO(String label, int value) {
        this.label = label;
        this.value = value;
    };

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getLabel2() {
        return label2;
    }

    public void setLabel2(String label2) {
        this.label2 = label2;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getRatio() {
        return ratio;
    }

    public void setRatio(int ratio) {
        this.ratio = ratio;
    }

    @Override
    public int compareTo(BoardLogVO o) {
        BoardLogVO boardLogVO = o;
        return (Integer.valueOf(label).compareTo(Integer.valueOf(boardLogVO.getLabel()).intValue()));
    }
}
