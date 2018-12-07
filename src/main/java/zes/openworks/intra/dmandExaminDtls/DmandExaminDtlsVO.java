/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDtls;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2016. 10. 06.   최강식   신규
*</pre>
* @see
*/

public class DmandExaminDtlsVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -6451278581008446726L;

    /** 유저ID **/
    private String userId;
    /** 유저명 **/
    private String userNm;
    /** 상위 기관명 **/
    private String upperPblinsttNm;
    /** 기관명 **/
    private String pblinsttNm;
    /** 전화번호 **/
    private String mbtlnum;
    /** 파일순번 **/
    private Integer fileSeq;
    /** 수요조사일자 **/
    private String dmandExaminDt;
    /** 수요조사파일리스트 **/
    private List<FileVO> dmandExaminFile;


    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * String userNm을 반환
     * @return String userNm
     */
    public String getUserNm() {
        return userNm;
    }

    /**
     * userNm을 설정
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    /**
     * String upperPblinsttNm을 반환
     * @return String upperPblinsttNm
     */
    public String getUpperPblinsttNm() {
        return upperPblinsttNm;
    }


    /**
     * upperPblinsttNm을 설정
     * @param upperPblinsttNm 을(를) String upperPblinsttNm로 설정
     */
    public void setUpperPblinsttNm(String upperPblinsttNm) {
        this.upperPblinsttNm = upperPblinsttNm;
    }

    /**
     * String pblinsttNm을 반환
     * @return String pblinsttNm
     */
    public String getPblinsttNm() {
        return pblinsttNm;
    }

    /**
     * pblinsttNm을 설정
     * @param pblinsttNm 을(를) String pblinsttNm로 설정
     */
    public void setPblinsttNm(String pblinsttNm) {
        this.pblinsttNm = pblinsttNm;
    }


    /**
     * Integer fileSeq을 반환
     * @return Integer fileSeq
     */
    public Integer getFileSeq() {
        return fileSeq;
    }


    /**
     * fileSeq을 설정
     * @param fileSeq 을(를) Integer fileSeq로 설정
     */
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }


    /**
     * String dmandExaminDt을 반환
     * @return String dmandExaminDt
     */
    public String getDmandExaminDt() {
        return dmandExaminDt;
    }


    /**
     * dmandExaminDt을 설정
     * @param dmandExaminDt 을(를) String dmandExaminDt로 설정
     */
    public void setDmandExaminDt(String dmandExaminDt) {
        this.dmandExaminDt = dmandExaminDt;
    }

    /**
     * List<FileVO> dmandExaminFile을 반환
     * @return List<FileVO> dmandExaminFile
     */
    public List<FileVO> getDmandExaminFile() {
        return dmandExaminFile;
    }

    /**
     * dmandExaminFile을 설정
     * @param dmandExaminFile 을(를) List<FileVO> dmandExaminFile로 설정
     */
    public void setDmandExaminFile(List<FileVO> dmandExaminFile) {
        this.dmandExaminFile = dmandExaminFile;
    }

    /**
     * String mbtlnum을 반환
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }

    /**
     * mbtlnum을 설정
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

}
