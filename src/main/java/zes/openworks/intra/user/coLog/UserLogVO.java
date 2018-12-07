/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.coLog;

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
 *  2012. 5. 22.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserLogVO extends PaggingVO {

    private static final long serialVersionUID = 3529638150726680935L;

    /** 관리자아이디 */
    private String mngrId;
    /** 관리자이름 */
    private String mngrNm;
    /** 접근일시 */
    private String accessDt;
    /** 사용자아이디 */
    private String userId;
    /** 사용자이름 */
    private String userNm;
    /** 로그메뉴명 */
    private String logMenuNm;
    /** 로그메뉴유형 */
    private String logMenuTy;
    /** 접근사유 */
    private String accessResn;
    /** 변경내용 */
    private String changeCn;
    /** 출력내용 */
    private String outptCn;
    /** 출력파일명 */
    private String outptFileNm;

    public String getMngrId() {
        return mngrId;
    }

    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    public String getMngrNm() {
        return mngrNm;
    }

    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    public String getAccessDt() {
        return accessDt;
    }

    public void setAccessDt(String accessDt) {
        this.accessDt = accessDt;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getLogMenuNm() {
        return logMenuNm;
    }

    public void setLogMenuNm(String logMenuNm) {
        this.logMenuNm = logMenuNm;
    }

    public String getLogMenuTy() {
        return logMenuTy;
    }

    public void setLogMenuTy(String logMenuTy) {
        this.logMenuTy = logMenuTy;
    }

    public String getAccessResn() {
        return accessResn;
    }

    public void setAccessResn(String accessResn) {
        this.accessResn = accessResn;
    }

    public String getChangeCn() {
        return changeCn;
    }

    public void setChangeCn(String changeCn) {
        this.changeCn = changeCn;
    }

    public String getOutptCn() {
        return outptCn;
    }

    public void setOutptCn(String outptCn) {
        this.outptCn = outptCn;
    }

    public String getOutptFileNm() {
        return outptFileNm;
    }

    public void setOutptFileNm(String outptFileNm) {
        this.outptFileNm = outptFileNm;
    }

}
