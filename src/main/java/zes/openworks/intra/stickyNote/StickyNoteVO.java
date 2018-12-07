/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.stickyNote;

import zes.base.vo.PaggingVO;

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
 *  2012. 5. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class StickyNoteVO extends PaggingVO {

    private static final long serialVersionUID = 5191888827553292087L;

    /** KEY */
    private Integer seq;
    /** 담당자 ID */
    private String mngrId;
    /** 내용 */
    private String contents;

    /** 메모 넓이 */
    private Integer width;
    /** 메모 높이 */
    private Integer height;
    /** 메모 X축 */
    private Integer posXis;
    /** 메모 Y축 */
    private Integer posYis;
    /** Z-INDEX */
    private Integer zindex;
    /** 배경이미지 */
    private String background;
    /** 등록일시 */
    private String regDt;

    /**
     * Integer seq을 반환
     * 
     * @return Integer seq
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * String mgrId을 반환
     * 
     * @return String mgrId
     */
    public String getMgrId() {
        return mngrId;
    }

    /**
     * String contents을 반환
     * 
     * @return String contents
     */
    public String getContents() {
        return contents;
    }

    /**
     * Integer width을 반환
     * 
     * @return Integer width
     */
    public Integer getWidth() {
        return width;
    }

    /**
     * Integer height을 반환
     * 
     * @return Integer height
     */
    public Integer getHeight() {
        return height;
    }

    /**
     * Integer posXis을 반환
     * 
     * @return Integer posXis
     */
    public Integer getPosXis() {
        return posXis;
    }

    /**
     * Integer posYis을 반환
     * 
     * @return Integer posYis
     */
    public Integer getPosYis() {
        return posYis;
    }

    /**
     * Integer zindex을 반환
     * 
     * @return Integer zindex
     */
    public Integer getZindex() {
        return zindex;
    }

    /**
     * String background을 반환
     * 
     * @return String background
     */
    public String getBackground() {
        return background;
    }

    /**
     * String regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * seq을 설정
     * 
     * @param seq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * mgrId을 설정
     * 
     * @param mgrId 을(를) String mgrId로 설정
     */
    public void setMngrId(String mgrId) {
        this.mngrId = mgrId;
    }

    /**
     * contents을 설정
     * 
     * @param contents 을(를) String contents로 설정
     */
    public void setContents(String contents) {
        this.contents = contents;
    }

    /**
     * width을 설정
     * 
     * @param width 을(를) Integer width로 설정
     */
    public void setWidth(Integer width) {
        this.width = width;
    }

    /**
     * height을 설정
     * 
     * @param height 을(를) Integer height로 설정
     */
    public void setHeight(Integer height) {
        this.height = height;
    }

    /**
     * posXis을 설정
     * 
     * @param posXis 을(를) Integer posXis로 설정
     */
    public void setPosXis(Integer posXis) {
        this.posXis = posXis;
    }

    /**
     * posYis을 설정
     * 
     * @param posYis 을(를) Integer posYis로 설정
     */
    public void setPosYis(Integer posYis) {
        this.posYis = posYis;
    }

    /**
     * zindex을 설정
     * 
     * @param zindex 을(를) Integer zindex로 설정
     */
    public void setZindex(Integer zindex) {
        this.zindex = zindex;
    }

    /**
     * background을 설정
     * 
     * @param background 을(를) String background로 설정
     */
    public void setBackground(String background) {
        this.background = background;
    }

    /**
     * regDt을 설정
     * 
     * @param regDt 을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

}
