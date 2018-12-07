/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.zipcode;

import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    강동성
 * </pre>
 * @see
 */
public class ZipcodeVO extends PaggingVO {

    private static final long serialVersionUID = -603359138938368246L;

    /** 법정동코드 **/
    private String bubjungCd;
    /** 시도명 **/
    private String sidoNm;
    /** 시군구명 **/
    private String sigunguNm;
    /** 법정읍면동명 **/
    private String bubjungDong;
    /** 법정리명 **/
    private String bubjungLi;
    /** 산여부(0:토지, 1:산) **/
    private String sanGb;
    /** 지번본번 **/
    private Integer jibunBon;
    /** 지번부번 **/
    private Integer jibunBu;
    /** 도로명코드(시군구5 + 도로명번호7) **/
    private String doroCd;
    /** 도로명 **/
    private String doroNm;
    /** 지하여부(0:지상, 1:지하, 2:공중) **/
    private String jihaGb;
    /** 건물본번 **/
    private Integer bdBon;
    /** 건물부번 **/
    private Integer bdBu;
    /** 건축물대장 건물명 **/
    private String bdNm;
    /** 상세건물명 **/
    private String detailBd;
    /** 건물관리번호(레이아웃 고유식별컬럼) **/
    private String bdNo;
    /** 읍면동일련번호 **/
    private String dongSeq;
    /** 행정동코드 **/
    private String hangjungCd;
    /** 행정동명 **/
    private String hangjungNm;
    /** 우편번호 **/
    private String zipcode;
    /** 우편번호일련번호 **/
    private String zipSeq;
    /** 다량배달처명 **/
    private String deliveryBd;
    /** 이동사유코드 **/
    private String moveReasonCd;
    /** 변경일자 **/
    private String modifyDt;
    /** 변경전 도로명주소 **/
    private String bfAddr;
    /** 시군구용 건물명(참고용) **/
    private String sigunguBdNm;
    /** 공동주택여부(0:비공동주택, 1:공동주택) **/
    private String multiBdGb;

    private String sidoCd;
    private String sigunguCd;

    private String jibunAddr;
    private String doroAddr;
    private String doroAddr2;

    /**
     * String bubjungCd을 반환
     * 
     * @return String bubjungCd
     */
    public String getBubjungCd() {
        return bubjungCd;
    }

    /**
     * bubjungCd을 설정
     * 
     * @param bubjungCd 을(를) String bubjungCd로 설정
     */
    public void setBubjungCd(String bubjungCd) {
        this.bubjungCd = bubjungCd;
    }

    /**
     * String sidoNm을 반환
     * 
     * @return String sidoNm
     */
    public String getSidoNm() {
        return sidoNm;
    }

    /**
     * sidoNm을 설정
     * 
     * @param sidoNm 을(를) String sidoNm로 설정
     */
    public void setSidoNm(String sidoNm) {
        this.sidoNm = sidoNm;
    }

    /**
     * String sigunguNm을 반환
     * 
     * @return String sigunguNm
     */
    public String getSigunguNm() {
        return sigunguNm;
    }

    /**
     * sigunguNm을 설정
     * 
     * @param sigunguNm 을(를) String sigunguNm로 설정
     */
    public void setSigunguNm(String sigunguNm) {
        this.sigunguNm = sigunguNm;
    }

    /**
     * String bubjungDong을 반환
     * 
     * @return String bubjungDong
     */
    public String getBubjungDong() {
        return bubjungDong;
    }

    /**
     * bubjungDong을 설정
     * 
     * @param bubjungDong 을(를) String bubjungDong로 설정
     */
    public void setBubjungDong(String bubjungDong) {
        this.bubjungDong = bubjungDong;
    }

    /**
     * String bubjungLi을 반환
     * 
     * @return String bubjungLi
     */
    public String getBubjungLi() {
        return bubjungLi;
    }

    /**
     * bubjungLi을 설정
     * 
     * @param bubjungLi 을(를) String bubjungLi로 설정
     */
    public void setBubjungLi(String bubjungLi) {
        this.bubjungLi = bubjungLi;
    }

    /**
     * String sanGb을 반환
     * 
     * @return String sanGb
     */
    public String getSanGb() {
        return sanGb;
    }

    /**
     * sanGb을 설정
     * 
     * @param sanGb 을(를) String sanGb로 설정
     */
    public void setSanGb(String sanGb) {
        this.sanGb = sanGb;
    }

    /**
     * Integer jibunBon을 반환
     * 
     * @return Integer jibunBon
     */
    public Integer getJibunBon() {
        return jibunBon;
    }

    /**
     * jibunBon을 설정
     * 
     * @param jibunBon 을(를) Integer jibunBon로 설정
     */
    public void setJibunBon(Integer jibunBon) {
        this.jibunBon = jibunBon;
    }

    /**
     * Integer jibunBu을 반환
     * 
     * @return Integer jibunBu
     */
    public Integer getJibunBu() {
        return jibunBu;
    }

    /**
     * jibunBu을 설정
     * 
     * @param jibunBu 을(를) Integer jibunBu로 설정
     */
    public void setJibunBu(Integer jibunBu) {
        this.jibunBu = jibunBu;
    }

    /**
     * String doroCd을 반환
     * 
     * @return String doroCd
     */
    public String getDoroCd() {
        return doroCd;
    }

    /**
     * doroCd을 설정
     * 
     * @param doroCd 을(를) String doroCd로 설정
     */
    public void setDoroCd(String doroCd) {
        this.doroCd = doroCd;
    }

    /**
     * String doroNm을 반환
     * 
     * @return String doroNm
     */
    public String getDoroNm() {
        return doroNm;
    }

    /**
     * doroNm을 설정
     * 
     * @param doroNm 을(를) String doroNm로 설정
     */
    public void setDoroNm(String doroNm) {
        this.doroNm = doroNm;
    }

    /**
     * String jihaGb을 반환
     * 
     * @return String jihaGb
     */
    public String getJihaGb() {
        return jihaGb;
    }

    /**
     * jihaGb을 설정
     * 
     * @param jihaGb 을(를) String jihaGb로 설정
     */
    public void setJihaGb(String jihaGb) {
        this.jihaGb = jihaGb;
    }

    /**
     * Integer bdBon을 반환
     * 
     * @return Integer bdBon
     */
    public Integer getBdBon() {
        return bdBon;
    }

    /**
     * bdBon을 설정
     * 
     * @param bdBon 을(를) Integer bdBon로 설정
     */
    public void setBdBon(Integer bdBon) {
        this.bdBon = bdBon;
    }

    /**
     * Integer bdBu을 반환
     * 
     * @return Integer bdBu
     */
    public Integer getBdBu() {
        return bdBu;
    }

    /**
     * bdBu을 설정
     * 
     * @param bdBu 을(를) Integer bdBu로 설정
     */
    public void setBdBu(Integer bdBu) {
        this.bdBu = bdBu;
    }

    /**
     * String bdNm을 반환
     * 
     * @return String bdNm
     */
    public String getBdNm() {
        return bdNm;
    }

    /**
     * bdNm을 설정
     * 
     * @param bdNm 을(를) String bdNm로 설정
     */
    public void setBdNm(String bdNm) {
        this.bdNm = bdNm;
    }

    /**
     * String detailBd을 반환
     * 
     * @return String detailBd
     */
    public String getDetailBd() {
        return detailBd;
    }

    /**
     * detailBd을 설정
     * 
     * @param detailBd 을(를) String detailBd로 설정
     */
    public void setDetailBd(String detailBd) {
        this.detailBd = detailBd;
    }

    /**
     * String bdNo을 반환
     * 
     * @return String bdNo
     */
    public String getBdNo() {
        return bdNo;
    }

    /**
     * bdNo을 설정
     * 
     * @param bdNo 을(를) String bdNo로 설정
     */
    public void setBdNo(String bdNo) {
        this.bdNo = bdNo;
    }

    /**
     * String dongSeq을 반환
     * 
     * @return String dongSeq
     */
    public String getDongSeq() {
        return dongSeq;
    }

    /**
     * dongSeq을 설정
     * 
     * @param dongSeq 을(를) String dongSeq로 설정
     */
    public void setDongSeq(String dongSeq) {
        this.dongSeq = dongSeq;
    }

    /**
     * String hangjungCd을 반환
     * 
     * @return String hangjungCd
     */
    public String getHangjungCd() {
        return hangjungCd;
    }

    /**
     * hangjungCd을 설정
     * 
     * @param hangjungCd 을(를) String hangjungCd로 설정
     */
    public void setHangjungCd(String hangjungCd) {
        this.hangjungCd = hangjungCd;
    }

    /**
     * String hangjungNm을 반환
     * 
     * @return String hangjungNm
     */
    public String getHangjungNm() {
        return hangjungNm;
    }

    /**
     * hangjungNm을 설정
     * 
     * @param hangjungNm 을(를) String hangjungNm로 설정
     */
    public void setHangjungNm(String hangjungNm) {
        this.hangjungNm = hangjungNm;
    }

    /**
     * String zipcode을 반환
     * 
     * @return String zipcode
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * zipcode을 설정
     * 
     * @param zipcode 을(를) String zipcode로 설정
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    /**
     * String zipSeq을 반환
     * 
     * @return String zipSeq
     */
    public String getZipSeq() {
        return zipSeq;
    }

    /**
     * zipSeq을 설정
     * 
     * @param zipSeq 을(를) String zipSeq로 설정
     */
    public void setZipSeq(String zipSeq) {
        this.zipSeq = zipSeq;
    }

    /**
     * String deliveryBd을 반환
     * 
     * @return String deliveryBd
     */
    public String getDeliveryBd() {
        return deliveryBd;
    }

    /**
     * deliveryBd을 설정
     * 
     * @param deliveryBd 을(를) String deliveryBd로 설정
     */
    public void setDeliveryBd(String deliveryBd) {
        this.deliveryBd = deliveryBd;
    }

    /**
     * String moveReasonCd을 반환
     * 
     * @return String moveReasonCd
     */
    public String getMoveReasonCd() {
        return moveReasonCd;
    }

    /**
     * moveReasonCd을 설정
     * 
     * @param moveReasonCd 을(를) String moveReasonCd로 설정
     */
    public void setMoveReasonCd(String moveReasonCd) {
        this.moveReasonCd = moveReasonCd;
    }

    /**
     * String modifyDt을 반환
     * 
     * @return String modifyDt
     */
    public String getModifyDt() {
        return modifyDt;
    }

    /**
     * modifyDt을 설정
     * 
     * @param modifyDt 을(를) String modifyDt로 설정
     */
    public void setModifyDt(String modifyDt) {
        this.modifyDt = modifyDt;
    }

    /**
     * String bfAddr을 반환
     * 
     * @return String bfAddr
     */
    public String getBfAddr() {
        return bfAddr;
    }

    /**
     * bfAddr을 설정
     * 
     * @param bfAddr 을(를) String bfAddr로 설정
     */
    public void setBfAddr(String bfAddr) {
        this.bfAddr = bfAddr;
    }

    /**
     * String sigunguBdNm을 반환
     * 
     * @return String sigunguBdNm
     */
    public String getSigunguBdNm() {
        return sigunguBdNm;
    }

    /**
     * sigunguBdNm을 설정
     * 
     * @param sigunguBdNm 을(를) String sigunguBdNm로 설정
     */
    public void setSigunguBdNm(String sigunguBdNm) {
        this.sigunguBdNm = sigunguBdNm;
    }

    /**
     * String multiBdGb을 반환
     * 
     * @return String multiBdGb
     */
    public String getMultiBdGb() {
        return multiBdGb;
    }

    /**
     * multiBdGb을 설정
     * 
     * @param multiBdGb 을(를) String multiBdGb로 설정
     */
    public void setMultiBdGb(String multiBdGb) {
        this.multiBdGb = multiBdGb;
    }

    /**
     * String sidoCd을 반환
     * 
     * @return String sidoCd
     */
    public String getSidoCd() {
        return sidoCd;
    }

    /**
     * sidoCd을 설정
     * 
     * @param sidoCd 을(를) String sidoCd로 설정
     */
    public void setSidoCd(String sidoCd) {
        this.sidoCd = sidoCd;
    }

    /**
     * String sigunguCd을 반환
     * 
     * @return String sigunguCd
     */
    public String getSigunguCd() {
        return sigunguCd;
    }

    /**
     * sigunguCd을 설정
     * 
     * @param sigunguCd 을(를) String sigunguCd로 설정
     */
    public void setSigunguCd(String sigunguCd) {
        this.sigunguCd = sigunguCd;
    }

    /**
     * String jibunAddr을 반환
     * 
     * @return String jibunAddr
     */
    public String getJibunAddr() {
        return jibunAddr;
    }

    /**
     * jibunAddr을 설정
     * 
     * @param jibunAddr 을(를) String jibunAddr로 설정
     */
    public void setJibunAddr(String jibunAddr) {
        this.jibunAddr = jibunAddr;
    }

    /**
     * String doroAddr을 반환
     * 
     * @return String doroAddr
     */
    public String getDoroAddr() {
        return doroAddr;
    }

    /**
     * doroAddr을 설정
     * 
     * @param doroAddr 을(를) String doroAddr로 설정
     */
    public void setDoroAddr(String doroAddr) {
        this.doroAddr = doroAddr;
    }

    /**
     * String doroAddr2을 반환
     * 
     * @return String doroAddr2
     */
    public String getDoroAddr2() {
        return doroAddr2;
    }

    /**
     * doroAddr2을 설정
     * 
     * @param doroAddr2 을(를) String doroAddr2로 설정
     */
    public void setDoroAddr2(String doroAddr2) {
        this.doroAddr2 = doroAddr2;
    }

}
