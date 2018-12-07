/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDc;

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
* 2016. 10. 01.   최강식   신규
*</pre>
* @see
*/

public class DmandExaminDcVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -1792009649683439216L;
    /**  */


    /** 신청순번 **/
    private Integer partcptSn;
    /** 유저ID **/
    private String userId;
    /** 유저명 **/
    private String userNm;
    /** 상위 기관명 **/
    private String upperPblinsttNm;

    /** 기관명 **/
    private String pblinsttNm;
    /** 핸드폰번호 **/
    private String mbtlnum;
    /** 이메일 **/
    private String email;
    /** 신청구분(서울:1001/대구:1002) **/
    private Integer partcptSe;
    /** 신청일자 **/
    private String partcptReqstDt;


    /**
     * Integer partcptSn을 반환
     * @return Integer partcptSn
     */
    public Integer getPartcptSn() {
        return partcptSn;
    }

    /**
     * partcptSn을 설정
     * @param partcptSn 을(를) Integer partcptSn로 설정
     */
    public void setPartcptSn(Integer partcptSn) {
        this.partcptSn = partcptSn;
    }

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

    /**
     * String email을 반환
     * @return String email
     */
    public String getEmail() {
        return email;
    }

    /**
     * email을 설정
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Integer partcptSe을 반환
     * @return Integer partcptSe
     */
    public Integer getPartcptSe() {
        return partcptSe;
    }

    /**
     * partcptSe을 설정
     * @param partcptSe 을(를) Integer partcptSe로 설정
     */
    public void setPartcptSe(Integer partcptSe) {
        this.partcptSe = partcptSe;
    }

    /**
     * String partcptReqstDt을 반환
     * @return String partcptReqstDt
     */
    public String getPartcptReqstDt() {
        return partcptReqstDt;
    }

    /**
     * partcptReqstDt을 설정
     * @param partcptReqstDt 을(를) String partcptReqstDt로 설정
     */
    public void setPartcptReqstDt(String partcptReqstDt) {
        this.partcptReqstDt = partcptReqstDt;
    }

}
