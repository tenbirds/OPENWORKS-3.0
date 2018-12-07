/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.tracking;

import zes.base.vo.BaseVO;

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
 *  2012. 5. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class TrackingVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 4231302486822912398L;

    /** 접속 도메인명 */
    private String anlzDomainNm = "";

    /** 세션아이디 */
    private String anlzSessionId = "";

    /** IP */
    private String anlzIp = "";

    /** URL */
    private String anlzUrl = "";

    /** 이전페이지 */
    private String anlzReferer = "";

    /** 통계 계산여부 */
    private String anlzStatisticYn = "N";

    /** 사용자 아이디 */
    private String anlzUserId = "";

    /** http 프로토콜(protocol)에서 클라이언트에 의해 보내지는 사용도구(user-agent)의 헤더 값 */
    private String anlzUserAgent = "";

    /** 클라이언트 모니터의 해상도(Width) */
    private String anlzScreenWidth = "";

    /** 클라이언트 모니터의 해상도(Heitht) */
    private String anlzScreenHeight = "";

    /** 접속한 서버명 : 최초접속여부 처리용 변수 */
    private String serverName = "";

    /** 클라이언트 모니터의 색상 Bit수 */
    private String anlzScreenColorDepth = "";

    /** 페이지 Title */
    private String anlzPageTitle = "";

    /** 사이트 최초접속여부 */
    private String anlzFirstVisitYn = "N";

    /** 검색엔진 여부 */
    private String anlzSearchEngineYn = "N";

    /** 모바일 여부 */
    private String anlzMobileYn = "N";

    /** 페이지 뷰 횟수 */
    private Integer anlzPageViewCnt = 0;

    /** 최초접속여부(시) */
    private String anlzFirstVisitHourYn = "N";

    /** 최초접속여부(일) */
    private String anlzFirstVisitDateYn = "N";

    /** 최초접속여부(주) */
    private String anlzFirstVisitWeekYn = "N";

    /** 최초접속여부(월) */
    private String anlzFirstVisitMonthYn = "N";

    /** 브라우저 이름 */
    private String anlzBrowserName = "";

    /** 브라우저 버전 */
    private String anlzBrowserVersion = "";

    /** 클라이언트 OS */
    private String anlzOSName = "";

    /** 검색엔진 이름 */
    private String anlzSearchName = "";

    /** 검색엔진 도메인 */
    private String anlzSearchDomain = "";

    /** 검색 키워드 */
    private String anlzSearchWord = "";

    /** 재방문기간 */
    private int anlzReVisitPeriod = 0;

    /**
     * int anlzReVisitPeriod을 반환
     * 
     * @return int anlzReVisitPeriod
     */
    public int getAnlzReVisitPeriod() {
        return anlzReVisitPeriod;
    }

    /**
     * anlzReVisitPeriod을 설정
     * 
     * @param anlzReVisitPeriod 을(를) int anlzReVisitPeriod로 설정
     */
    public void setAnlzReVisitPeriod(int anlzReVisitPeriod) {
        this.anlzReVisitPeriod = anlzReVisitPeriod;
    }

    /**
     * String anlzSessionId을 반환
     * 
     * @return String anlzSessionId
     */
    public String getAnlzSessionId() {
        return anlzSessionId;
    }

    /**
     * anlzSessionId을 설정
     * 
     * @param anlzSessionId 을(를) String anlzSessionId로 설정
     */
    public void setAnlzSessionId(String anlzSessionId) {
        this.anlzSessionId = anlzSessionId;
    }

    /**
     * String anlzIp을 반환
     * 
     * @return String anlzIp
     */
    public String getAnlzIp() {
        return anlzIp;
    }

    /**
     * anlzIp을 설정
     * 
     * @param anlzIp 을(를) String anlzIp로 설정
     */
    public void setAnlzIp(String anlzIp) {
        this.anlzIp = anlzIp;
    }

    /**
     * String anlzUrl을 반환
     * 
     * @return String anlzUrl
     */
    public String getAnlzUrl() {
        return anlzUrl;
    }

    /**
     * anlzUrl을 설정
     * 
     * @param anlzUrl 을(를) String anlzUrl로 설정
     */
    public void setAnlzUrl(String anlzUrl) {
        this.anlzUrl = anlzUrl;
    }

    /**
     * String anlzReferer을 반환
     * 
     * @return String anlzReferer
     */
    public String getAnlzReferer() {
        return anlzReferer;
    }

    /**
     * anlzReferer을 설정
     * 
     * @param anlzReferer 을(를) String anlzReferer로 설정
     */
    public void setAnlzReferer(String anlzReferer) {
        this.anlzReferer = anlzReferer;
    }

    /**
     * String anlzStatisticYn을 반환
     * 
     * @return String anlzStatisticYn
     */
    public String getAnlzStatisticYn() {
        return anlzStatisticYn;
    }

    /**
     * anlzStatisticYn을 설정
     * 
     * @param anlzStatisticYn 을(를) String anlzStatisticYn로 설정
     */
    public void setAnlzStatisticYn(String anlzStatisticYn) {
        this.anlzStatisticYn = anlzStatisticYn;
    }

    /**
     * String anlzUserId을 반환
     * 
     * @return String anlzUserId
     */
    public String getAnlzUserId() {
        return anlzUserId;
    }

    /**
     * anlzUserId을 설정
     * 
     * @param anlzUserId 을(를) String anlzUserId로 설정
     */
    public void setAnlzUserId(String anlzUserId) {
        this.anlzUserId = anlzUserId;
    }

    /**
     * String anlzUserAgent을 반환
     * 
     * @return String anlzUserAgent
     */
    public String getAnlzUserAgent() {
        return anlzUserAgent;
    }

    /**
     * anlzUserAgent을 설정
     * 
     * @param anlzUserAgent 을(를) String anlzUserAgent로 설정
     */
    public void setAnlzUserAgent(String anlzUserAgent) {
        this.anlzUserAgent = anlzUserAgent;
    }

    /**
     * String anlzScreenWidth을 반환
     * 
     * @return String anlzScreenWidth
     */
    public String getAnlzScreenWidth() {
        return anlzScreenWidth;
    }

    /**
     * anlzScreenWidth을 설정
     * 
     * @param anlzScreenWidth 을(를) String anlzScreenWidth로 설정
     */
    public void setAnlzScreenWidth(String anlzScreenWidth) {
        this.anlzScreenWidth = anlzScreenWidth;
    }

    /**
     * String anlzScreenHeight을 반환
     * 
     * @return String anlzScreenHeight
     */
    public String getAnlzScreenHeight() {
        return anlzScreenHeight;
    }

    /**
     * anlzScreenHeight을 설정
     * 
     * @param anlzScreenHeight 을(를) String anlzScreenHeight로 설정
     */
    public void setAnlzScreenHeight(String anlzScreenHeight) {
        this.anlzScreenHeight = anlzScreenHeight;
    }

    /**
     * String serverName을 반환
     * 
     * @return String serverName
     */
    public String getServerName() {
        return serverName;
    }

    /**
     * serverName을 설정
     * 
     * @param serverName 을(를) String serverName로 설정
     */
    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    /**
     * String anlzScreenColorDepth을 반환
     * 
     * @return String anlzScreenColorDepth
     */
    public String getAnlzScreenColorDepth() {
        return anlzScreenColorDepth;
    }

    /**
     * anlzScreenColorDepth을 설정
     * 
     * @param anlzScreenColorDepth 을(를) String anlzScreenColorDepth로 설정
     */
    public void setAnlzScreenColorDepth(String anlzScreenColorDepth) {
        this.anlzScreenColorDepth = anlzScreenColorDepth;
    }

    /**
     * String anlzPageTitle을 반환
     * 
     * @return String anlzPageTitle
     */
    public String getAnlzPageTitle() {
        return anlzPageTitle;
    }

    /**
     * anlzPageTitle을 설정
     * 
     * @param anlzPageTitle 을(를) String anlzPageTitle로 설정
     */
    public void setAnlzPageTitle(String anlzPageTitle) {
        this.anlzPageTitle = anlzPageTitle;
    }

    /**
     * String anlzFirstYn을 반환
     * 
     * @return String anlzFirstYn
     */
    public String getAnlzFirstVisitYn() {
        return anlzFirstVisitYn;
    }

    /**
     * anlzFirstYn을 설정
     * 
     * @param anlzFirstYn 을(를) String anlzFirstYn로 설정
     */
    public void setAnlzFirstVisitYn(String anlzFirstVisitYn) {
        this.anlzFirstVisitYn = anlzFirstVisitYn;
    }

    /**
     * String anlzSearchEngineYn을 반환
     * 
     * @return String anlzSearchEngineYn
     */
    public String getAnlzSearchEngineYn() {
        return anlzSearchEngineYn;
    }

    /**
     * anlzSearchEngineYn을 설정
     * 
     * @param anlzSearchEngineYn 을(를) String anlzSearchEngineYn로 설정
     */
    public void setAnlzSearchEngineYn(String anlzSearchEngineYn) {
        this.anlzSearchEngineYn = anlzSearchEngineYn;
    }

    /**
     * String anlzMobileYn을 반환
     * 
     * @return String anlzMobileYn
     */
    public String getAnlzMobileYn() {
        return anlzMobileYn;
    }

    /**
     * anlzMobileYn을 설정
     * 
     * @param anlzMobileYn 을(를) String anlzMobileYn로 설정
     */
    public void setAnlzMobileYn(String anlzMobileYn) {
        this.anlzMobileYn = anlzMobileYn;
    }

    /**
     * Integer anlzPageViewCnt을 반환
     * 
     * @return Integer anlzPageViewCnt
     */
    public Integer getAnlzPageViewCnt() {
        return anlzPageViewCnt;
    }

    /**
     * anlzPageViewCnt을 설정
     * 
     * @param anlzPageViewCnt 을(를) Integer anlzPageViewCnt로 설정
     */
    public void setAnlzPageViewCnt(Integer anlzPageViewCnt) {
        this.anlzPageViewCnt = anlzPageViewCnt;
    }

    /**
     * String anlzFirstVisitHourYn을 반환
     * 
     * @return String anlzFirstVisitHourYn
     */
    public String getAnlzFirstVisitHourYn() {
        return anlzFirstVisitHourYn;
    }

    /**
     * anlzFirstVisitHourYn을 설정
     * 
     * @param anlzFirstVisitHourYn 을(를) String anlzFirstVisitHourYn로 설정
     */
    public void setAnlzFirstVisitHourYn(String anlzFirstVisitHourYn) {
        this.anlzFirstVisitHourYn = anlzFirstVisitHourYn;
    }

    /**
     * String anlzFirstVisitDateYn을 반환
     * 
     * @return String anlzFirstVisitDateYn
     */
    public String getAnlzFirstVisitDateYn() {
        return anlzFirstVisitDateYn;
    }

    /**
     * anlzFirstVisitDateYn을 설정
     * 
     * @param anlzFirstVisitDateYn 을(를) String anlzFirstVisitDateYn로 설정
     */
    public void setAnlzFirstVisitDateYn(String anlzFirstVisitDateYn) {
        this.anlzFirstVisitDateYn = anlzFirstVisitDateYn;
    }

    /**
     * String anlzFirstVisitWeekYn을 반환
     * 
     * @return String anlzFirstVisitWeekYn
     */
    public String getAnlzFirstVisitWeekYn() {
        return anlzFirstVisitWeekYn;
    }

    /**
     * anlzFirstVisitWeekYn을 설정
     * 
     * @param anlzFirstVisitWeekYn 을(를) String anlzFirstVisitWeekYn로 설정
     */
    public void setAnlzFirstVisitWeekYn(String anlzFirstVisitWeekYn) {
        this.anlzFirstVisitWeekYn = anlzFirstVisitWeekYn;
    }

    /**
     * String anlzFirstVisitMonthYn을 반환
     * 
     * @return String anlzFirstVisitMonthYn
     */
    public String getAnlzFirstVisitMonthYn() {
        return anlzFirstVisitMonthYn;
    }

    /**
     * anlzFirstVisitMonthYn을 설정
     * 
     * @param anlzFirstVisitMonthYn 을(를) String anlzFirstVisitMonthYn로 설정
     */
    public void setAnlzFirstVisitMonthYn(String anlzFirstVisitMonthYn) {
        this.anlzFirstVisitMonthYn = anlzFirstVisitMonthYn;
    }

    /**
     * String anlzDomainNm을 반환
     * 
     * @return String anlzDomainNm
     */
    public String getAnlzDomainNm() {
        return anlzDomainNm;
    }

    /**
     * anlzDomainNm을 설정
     * 
     * @param anlzDomainNm 을(를) String anlzDomainNm로 설정
     */
    public void setAnlzDomainNm(String anlzDomainNm) {
        this.anlzDomainNm = anlzDomainNm;
    }

    /**
     * String anlzBrowserName을 반환
     * 
     * @return String anlzBrowserName
     */
    public String getAnlzBrowserName() {
        return anlzBrowserName;
    }

    /**
     * anlzBrowserName을 설정
     * 
     * @param anlzBrowserName 을(를) String anlzBrowserName로 설정
     */
    public void setAnlzBrowserName(String anlzBrowserName) {
        this.anlzBrowserName = anlzBrowserName;
    }

    /**
     * String anlzBrowserVersion을 반환
     * 
     * @return String anlzBrowserVersion
     */
    public String getAnlzBrowserVersion() {
        return anlzBrowserVersion;
    }

    /**
     * anlzBrowserVersion을 설정
     * 
     * @param anlzBrowserVersion 을(를) String anlzBrowserVersion로 설정
     */
    public void setAnlzBrowserVersion(String anlzBrowserVersion) {
        this.anlzBrowserVersion = anlzBrowserVersion;
    }

    /**
     * String anlzOSName을 반환
     * 
     * @return String anlzOSName
     */
    public String getAnlzOSName() {
        return anlzOSName;
    }

    /**
     * anlzOSName을 설정
     * 
     * @param anlzOSName 을(를) String anlzOSName로 설정
     */
    public void setAnlzOSName(String anlzOSName) {
        this.anlzOSName = anlzOSName;
    }

    /**
     * String anlzSearchName을 반환
     * 
     * @return String anlzSearchName
     */
    public String getAnlzSearchName() {
        return anlzSearchName;
    }

    /**
     * anlzSearchName을 설정
     * 
     * @param anlzSearchName 을(를) String anlzSearchName로 설정
     */
    public void setAnlzSearchName(String anlzSearchName) {
        this.anlzSearchName = anlzSearchName;
    }

    /**
     * String anlzSearchDomain을 반환
     * 
     * @return String anlzSearchDomain
     */
    public String getAnlzSearchDomain() {
        return anlzSearchDomain;
    }

    /**
     * anlzSearchDomain을 설정
     * 
     * @param anlzSearchDomain 을(를) String anlzSearchDomain로 설정
     */
    public void setAnlzSearchDomain(String anlzSearchDomain) {
        this.anlzSearchDomain = anlzSearchDomain;
    }

    /**
     * String anlzSearchWord을 반환
     * 
     * @return String anlzSearchWord
     */
    public String getAnlzSearchWord() {
        return anlzSearchWord;
    }

    /**
     * anlzSearchWord을 설정
     * 
     * @param anlzSearchWord 을(를) String anlzSearchWord로 설정
     */
    public void setAnlzSearchWord(String anlzSearchWord) {
        this.anlzSearchWord = anlzSearchWord;
    }

}
