/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.masub;

import java.util.List;
import java.util.Map;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.Email;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *       수정일             수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 18.     홍길동     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class MasterSubVO  extends PaggingVO {

    static final long serialVersionUID = -844244739945971999L;

    private String masterId;
    private Integer masubNum;
    private String userId;
    private String userNm;
    private String masubTitle;
    private String masubContent;
    private String masubEntrDate;
    private Integer masubSechCnt;
    private Integer replyNum;
    private Integer seq;
    private String writeUserId;
    private Integer replyCnt;
    private String replyContent;
    private String replyUserId;
    
    /**조회조건*/
    private String searchCode;
    private String searchName;
    private String title;
    private String user;
    
    private String status;
    private String maskRegistId;
     /**
     * String masterId을 반환
     * @return String masterId
     */
    public String getMasterId() {
        return masterId;
    }
    
    /**
     * masterId을 설정
     * @param masterId 을(를) String masterId로 설정
     */
    public void setMasterId(String masterId) {
        this.masterId = masterId;
    }
    
    /**
     * Integer masubNum을 반환
     * @return Integer masubNum
     */
    public Integer getMasubNum() {
        return masubNum;
    }
    
    /**
     * masubNum을 설정
     * @param masubNum 을(를) Integer masubNum로 설정
     */
    public void setMasubNum(Integer masubNum) {
        this.masubNum = masubNum;
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
     * String masubTitle을 반환
     * @return String masubTitle
     */
    public String getMasubTitle() {
        return masubTitle;
    }
    
    /**
     * masubTitle을 설정
     * @param masubTitle 을(를) String masubTitle로 설정
     */
    public void setMasubTitle(String masubTitle) {
        this.masubTitle = masubTitle;
    }
    
    /**
     * String masubContent을 반환
     * @return String masubContent
     */
    public String getMasubContent() {
        return masubContent;
    }
    
    /**
     * masubContent을 설정
     * @param masubContent 을(를) String masubContent로 설정
     */
    public void setMasubContent(String masubContent) {
        this.masubContent = masubContent;
    }
    
    /**
     * String masubEntrDate을 반환
     * @return String masubEntrDate
     */
    public String getMasubEntrDate() {
        return masubEntrDate;
    }
    
    /**
     * masubEntrDate을 설정
     * @param masubEntrDate 을(를) String masubEntrDate로 설정
     */
    public void setMasubEntrDate(String masubEntrDate) {
        this.masubEntrDate = masubEntrDate;
    }
    
    /**
     * Integer masubSechCnt을 반환
     * @return Integer masubSechCnt
     */
    public Integer getMasubSechCnt() {
        return masubSechCnt;
    }
    
    /**
     * masubSechCnt을 설정
     * @param masubSechCnt 을(를) Integer masubSechCnt로 설정
     */
    public void setMasubSechCnt(Integer masubSechCnt) {
        this.masubSechCnt = masubSechCnt;
    }
    
    /**
     * Integer replyNum을 반환
     * @return Integer replyNum
     */
    public Integer getReplyNum() {
        return replyNum;
    }
    
    /**
     * replyNum을 설정
     * @param replyNum 을(를) Integer replyNum로 설정
     */
    public void setReplyNum(Integer replyNum) {
        this.replyNum = replyNum;
    }

    
    /**
     * String searchCode을 반환
     * @return String searchCode
     */
    public String getSearchCode() {
        return searchCode;
    }

    
    /**
     * searchCode을 설정
     * @param searchCode 을(를) String searchCode로 설정
     */
    public void setSearchCode(String searchCode) {
        this.searchCode = searchCode;
    }

    
    /**
     * String searchName을 반환
     * @return String searchName
     */
    public String getSearchName() {
        return searchName;
    }

    
    /**
     * searchName을 설정
     * @param searchName 을(를) String searchName로 설정
     */
    public void setSearchName(String searchName) {
        this.searchName = searchName;
    }

    
    /**
     * String title을 반환
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    
    /**
     * title을 설정
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    
    /**
     * String user을 반환
     * @return String user
     */
    public String getUser() {
        return user;
    }

    
    /**
     * user을 설정
     * @param user 을(를) String user로 설정
     */
    public void setUser(String user) {
        this.user = user;
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
     * String status을 반환
     * @return String status
     */
    public String getStatus() {
        return status;
    }

    
    /**
     * status을 설정
     * @param status 을(를) String status로 설정
     */
    public void setStatus(String status) {
        this.status = status;
    }

    
    /**
     * Integer seq을 반환
     * @return Integer seq
     */
    public Integer getSeq() {
        return seq;
    }

    
    /**
     * seq을 설정
     * @param seq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    
    /**
     * String writeUserId을 반환
     * @return String writeUserId
     */
    public String getWriteUserId() {
        return writeUserId;
    }

    
    /**
     * writeUserId을 설정
     * @param writeUserId 을(를) String writeUserId로 설정
     */
    public void setWriteUserId(String writeUserId) {
        this.writeUserId = writeUserId;
    }

    
    /**
     * String replyCnt을 반환
     * @return String replyCnt
     */
    public Integer getReplyCnt() {
        return replyCnt;
    }

    
    /**
     * replyCnt을 설정
     * @param replyCnt 을(를) String replyCnt로 설정
     */
    public void setReplyCnt(Integer replyCnt) {
        this.replyCnt = replyCnt;
    }

    
    /**
     * String replyContent을 반환
     * @return String replyContent
     */
    public String getReplyContent() {
        return replyContent;
    }

    
    /**
     * replyContent을 설정
     * @param replyContent 을(를) String replyContent로 설정
     */
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    
    /**
     * String replyUserId을 반환
     * @return String replyUserId
     */
    public String getReplyUserId() {
        return replyUserId;
    }

    
    /**
     * replyUserId을 설정
     * @param replyUserId 을(를) String replyUserId로 설정
     */
    public void setReplyUserId(String replyUserId) {
        this.replyUserId = replyUserId;
    }

    
    /**
     * String maskRegistId을 반환
     * @return String maskRegistId
     */
    public String getMaskRegistId() {
        
        int registIdSize = this.getUserId().length();
        String registIdTemp = this.getUserId().substring(0, 3);
        String registMask = "";
        
        for(int i=0; i<registIdSize-3; i++){
            registMask += "*";
        }
        
        maskRegistId = registIdTemp + registMask; 

        return maskRegistId;
    }

    
    /**
     * maskRegistId을 설정
     * @param maskRegistId 을(를) String maskRegistId로 설정
     */
    public void setMaskRegistId(String maskRegistId) {
        this.maskRegistId = maskRegistId;
    }
    
    
}
