/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.bassDegreeManage;

import zes.base.vo.PaggingVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 3.    방기배       신규
 *</pre>
 * @see
 */
public class BassDegreeManageVO extends PaggingVO{
    
    private static final long serialVersionUID = 3132469776237583722L;
    
    /* 협약차수 관리 순서 */
    private int degreeSeq;
    /* 협약차수 관리 차수 */
    private int bassDegree;
    /* 협약차수 관리 차수 맥스*/
    private int bassDegreeMax;
    /* 협약차수 관리 계약 예정일 */
    private String bassDegreeStdt;
    /* 협약차수 관리 종료일 */
    private String bassDegreeEnddt;
    /* 협약차수 관리 종료일 맥스*/
    private String bassDegreeEnddtMax;
    
    
    
    /**
     * String bassDegreeEnddtMax을 반환
     * @return String bassDegreeEnddtMax
     */
    public String getBassDegreeEnddtMax() {
        return bassDegreeEnddtMax;
    }


    
    /**
     * bassDegreeEnddtMax을 설정
     * @param bassDegreeEnddtMax 을(를) String bassDegreeEnddtMax로 설정
     */
    public void setBassDegreeEnddtMax(String bassDegreeEnddtMax) {
        this.bassDegreeEnddtMax = bassDegreeEnddtMax;
    }


    /**
     * int bassDegreeMax을 반환
     * @return int bassDegreeMax
     */
    public int getBassDegreeMax() {
        return bassDegreeMax;
    }

    
    /**
     * bassDegreeMax을 설정
     * @param bassDegreeMax 을(를) int bassDegreeMax로 설정
     */
    public void setBassDegreeMax(int bassDegreeMax) {
        this.bassDegreeMax = bassDegreeMax;
    }

    /**
     * int degreeSeq을 반환
     * @return int degreeSeq
     */
    public int getDegreeSeq() {
        return degreeSeq;
    }
    
    /**
     * degreeSeq을 설정
     * @param degreeSeq 을(를) int degreeSeq로 설정
     */
    public void setDegreeSeq(int degreeSeq) {
        this.degreeSeq = degreeSeq;
    }
    
    /**
     * int bassDegree을 반환
     * @return int bassDegree
     */
    public int getBassDegree() {
        return bassDegree;
    }
    
    /**
     * bassDegree을 설정
     * @param bassDegree 을(를) int bassDegree로 설정
     */
    public void setBassDegree(int bassDegree) {
        this.bassDegree = bassDegree;
    }
    
    /**
     * int bassDegreeStdt을 반환
     * @return int bassDegreeStdt
     */
    public String getBassDegreeStdt() {
        return bassDegreeStdt;
    }
    
    /**
     * bassDegreeStdt을 설정
     * @param bassDegreeStdt 을(를) int bassDegreeStdt로 설정
     */
    public void setBassDegreeStdt(String bassDegreeStdt) {
        this.bassDegreeStdt = bassDegreeStdt;
    }
    
    /**
     * int bassDegreeEnddt을 반환
     * @return int bassDegreeEnddt
     */
    public String getBassDegreeEnddt() {
        return bassDegreeEnddt;
    }
    
    /**
     * bassDegreeEnddt을 설정
     * @param bassDegreeEnddt 을(를) int bassDegreeEnddt로 설정
     */
    public void setBassDegreeEnddt(String bassDegreeEnddt) {
        this.bassDegreeEnddt = bassDegreeEnddt;
    }
}
