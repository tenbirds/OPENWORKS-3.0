/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;


/**
 *
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일          수정자       수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 14.    김영상       신규
 *</pre>
 * @see
 */
public enum AutoMailTemplate {
    /** 회원 **/
    KOR_CTFC_EMAL(365),     //회원가입이메일인증
    KOR_MBER_SCRB(391),     //회원가입완료
    KOR_ID_SECH(366),       //회원아이디찾기
    KOR_NEW_PSWD(367),      //비밀번호찾기
    KOR_MBER_SCSN(368),     //회원탈퇴
    /** 스토어 **/
    KOR_ODER_RQST(369),     //구매신청하기
    KOR_GOOD_IQRY(370),     //서비스문의하기
    KOR_GOOD_ANSR(371),     //서비스문의답변하기
    KOR_GOOD_ACUS(372),     //서비스문의신고하기
    /** 스토어-비즈매칭 **/
    KOR_BIZ_REG(373),       //비즈매칭 요청등록
    KOR_BIZ_MATC(374),      //비즈매칭 매칭등록
    KOR_BIZ_SLCT(375),      //비즈매칭 선정
    /** 판매하기 **/
    KOR_GOOD_EMNT(376),     //서비스검토요청
    KOR_GOOD_CNFM(377),     //서비스승인요청
    KOR_GOOD_REG(378),      //서비스등록완료
    KOR_GOOD_CHG(401),      //서비스요청완료
    
    /** 고객센터 **/
    KOR_QNA_QREG(379),      //Q&A질문등록
    KOR_QNA_AREG(380),      //Q&A답변등록
    /** 커뮤니티 **/
    KOR_CMNT_ESTB(381),     //커뮤니티개설
    KOR_CMNT_ERSY(382),     //커뮤니티신청결과(승인)
    KOR_CMNT_ERSN(383),     //커뮤니티신청결과(거절)
    KOR_CMNT_SCRY(384),     //커뮤니티가입신청
    KOR_CMNT_SCRN(385),     //커뮤니티가입신청취소
    KOR_CMNT_SRSY(386),     //커뮤니티가입결과(승인)
    KOR_CMNT_SRSN(387),     //커뮤니티가입결과(거절)
    KOR_CMNT_CLSU(388),     //커뮤니티폐쇄(회원알림)
    KOR_CMNT_CLSA(389),     //커뮤니티폐쇄(관리자알림)
    /** 호환성 신청완료 **/
    KOR_CPTB_RQST(390),   //EGOV표준프레임워크 호환성신청
    /** 뉴스레터 **/
    KOR_NL_RQST_CTFC_MAL(392),    //뉴스레터(신청) 2015-08-25
    KOR_NL_CANCL_CTFC_MAL(393),     //뉴스레터(취소) 2015-08-25
    /** 휴면계정 **/
    KOR_DRMN_CNVR(394),           //휴면계정전환안내 2015-11-10
    KOR_DRMN_COMP(395),           //휴면전환처리완료안내 2015-12-02
    KOR_DRMN_RCVR(396),           //휴면복구완료안내 2015-12-02 미사용
 
    KOR_BID_02REQ(397),       //견적서요청(한국어) 
    KOR_BID_03REQ(398),       //견적요청답변(한국어)
    KOR_BID_04REQ(399),      //지명입찰요청(한국어)
    KOR_BID_05REQ(400),      //지명입찰공고 응찰(한국어)
    
    /*이용실적발급*/
    KOR_ISSU_CNFM(402);     //서비스승인요청

    private final int no;

    AutoMailTemplate(int no) {
        this.no = no;
    }

    public int value() {
        return no;
    }
}
