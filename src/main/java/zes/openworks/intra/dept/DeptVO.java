/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

import zes.base.vo.TreeVO;

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
 *  2012. 4. 30.    유상원   부서 관리
 * </pre>
 * @see
 */
public class DeptVO extends TreeVO {

    private static final long serialVersionUID = 1300366641020419282L;

    /** 부서코드 */
    private String deptCode;
    /** 중복갯수 */
    private Integer deptCdDupCnt;
    /** 상위부서코드 */
    private String upperDeptCode;
    /** 부서명 */
    private String deptNm;
    /** 부서순서번호 */
    private Integer deptOrdrNo;
    /** 사용가부 */
    private String useYn;
    /** 등록일시 */
    private String registDt;
    /** 수정일시 */
    private String updtDt;
    /** 전화번호 */
    private String telno;
    /** 팩스번호 */
    private String fxnum;
    /** 주요업무 */
    private String mainDuty;
    /** 등록일 */
    private String regDt;
    /** 부서키 */
    private String deptKey;
    /** 수정일 */
    private String modiDt;
    /** 기존부서코드 */
    private String oldDeptCd;

    /** Jquery Autocomplite 표시문자 설정 */
    private String label;
    /** Jquery Autocomplite 항목 선택시 설정값 */
    private String value;

    public String getDeptCode() {
        return deptCode;
    }

    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }

    public Integer getDeptCdDupCnt() {
        return deptCdDupCnt;
    }

    public void setDeptCdDupCnt(Integer deptCdDupCnt) {
        this.deptCdDupCnt = deptCdDupCnt;
    }

    public String getUpperDeptCode() {
        return upperDeptCode;
    }

    public void setUpperDeptCode(String upperDeptCode) {
        this.upperDeptCode = upperDeptCode;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public Integer getDeptOrdrNo() {
        return deptOrdrNo;
    }

    public void setDeptOrdrNo(Integer deptOrdrNo) {
        this.deptOrdrNo = deptOrdrNo;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegistDt() {
        return registDt;
    }

    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getTelno() {
        return telno;
    }

    public void setTelno(String telno) {
        this.telno = telno;
    }

    public String getFxnum() {
        return fxnum;
    }

    public void setFxnum(String fxnum) {
        this.fxnum = fxnum;
    }

    public String getMainDuty() {
        return mainDuty;
    }

    public void setMainDuty(String mainDuty) {
        this.mainDuty = mainDuty;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getDeptKey() {
        return deptKey;
    }

    public void setDeptKey(String deptKey) {
        this.deptKey = deptKey;
    }

    public String getModiDt() {
        return modiDt;
    }

    public void setModiDt(String modiDt) {
        this.modiDt = modiDt;
    }

    public String getOldDeptCd() {
        return oldDeptCd;
    }

    public void setOldDeptCd(String oldDeptCd) {
        this.oldDeptCd = oldDeptCd;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
