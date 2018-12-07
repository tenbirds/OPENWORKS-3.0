/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardtemp;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 6. 7.    Administrator   신규 생성
 *</pre>
 * @see
 */
public class BoardTempVO extends PaggingVO {

    static final long serialVersionUID = -4912268371906466687L;

    /** 게시판 템플릿 아이디 */
    private String tmplatId; 
    /** 게시판 템플릿 유형 */
    private String tmplatTy;
    /** 게시판 템플릿 이름 */
    private String tmplatNm;
    /** 게시판 템플릿 소스 파일경로 */
    private String tmplatFilePath;
    /** 게시판 템플릿 스크린샷 파일경로 */
    private String screenshotFilePath;
    /** 등록아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;

    /** 기존 게시판 템플릿 아이디 */
    private String oldtemplateId;

    public String getTmplatId() {
        return tmplatId;
    }

    public void setTmplatId(String tmplatId) {
        this.tmplatId = tmplatId;
    }

    public String getTmplatTy() {
        return tmplatTy;
    }

    public void setTmplatTy(String tmplatTy) {
        this.tmplatTy = tmplatTy;
    }

    public String getTmplatNm() {
        return tmplatNm;
    }

    public void setTmplatNm(String tmplatNm) {
        this.tmplatNm = tmplatNm;
    }

    public String getTmplatFilePath() {
        return tmplatFilePath;
    }

    public void setTmplatFilePath(String tmplatFilePath) {
        this.tmplatFilePath = tmplatFilePath;
    }

    public String getScreenshotFilePath() {
        return screenshotFilePath;
    }

    public void setScreenshotFilePath(String screenshotFilePath) {
        this.screenshotFilePath = screenshotFilePath;
    }

    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getRegistDt() {
        return registDt;
    }

    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    public String getUpdtId() {
        return updtId;
    }

    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getOldtemplateId() {
        return oldtemplateId;
    }

    public void setOldtemplateId(String oldtemplateId) {
        this.oldtemplateId = oldtemplateId;
    }

    
    
}