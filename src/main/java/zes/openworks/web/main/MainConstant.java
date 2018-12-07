/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.main;

import java.util.HashMap;
import java.util.Map;

/**
 * 사용자 메인 Constant
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2014. 11. 20.     김영상      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public final class MainConstant {

    /** 공지사항 게시판 코드 */
    public final static Integer NOTICE_BBS_CD = 1001;
    /** 행사 및 이벤트 게시판 코드 */
    public final static Integer EVENT_BBS_CD = 1007;
    /** 성공스토리 게시판 코드, 2015.10.02 */
    public final static Integer SUCCESS_STORY_BBS_CD = 1009;
    /** 공지사항 목록 정보를 가진 객체명 */
    public static final String KEY_NOTICE_LIST = "noticeList";
    /** 공지사항 목록 정보를 가진 객체명 */
    public static final String KEY_EVENT_LIST = "eventList";
    /** 지식허브 목록 정보를 가진 객체명 */
    public static final String KEY_KNWLDG_HUB_LIST = "knwldgHubList";

    /** 프리미엄추천서비스 목록 정보를 가진 객체명 */
    public static final String KEY_RECOMP_LIST = "recomPgdList";
    /** 솔루션서비스 목록 정보를 가진 객체명 */
    public static final String KEY_RECOMS_LIST = "recomSgdList";
    /** 컨설팅서비스 목록 정보를 가진 객체명 */
    public static final String KEY_RECOMC_LIST = "recomCgdList";
    /** 신청수 TOP10 목록 정보를 가진 객체명 */
    public static final String KEY_RTOP_LIST = "reqTop10List";
    /** 판매자 TOP10 목록 정보를 가진 객체명 */
    public static final String KEY_STOP_LIST = "selTop10List";
    /** 평가 TOP10 목록 정보를 가진 객체명 */
    public static final String KEY_ETOP_LIST = "evlTop10List";
    /** 신규 서비스 목록 정보를 가진 객체명 */
    public static final String KEY_NTOP_LIST = "newTop10List";
    /** 신규 서비스 목록 정보를 가진 객체명 */
    public static final String KEY_NGOODS_LIST = "newGoodsList";
    /** 신규 TOP10 목록 정보를 가진 객체명 */
    public static final String KEY_EGOODS_LIST = "exprnGoodsList";
    /** 성공스토리 목록 정보를 가진 객체명, 2015.10.02 */
    public static final String KEY_SUCCESS_STORY_LIST = "successStoryList";
    /** 신규 TOP3 입찰 정보를 가진 객체명 */
    public static final String KEY_BID_LIST = "bidInfoMainList";
    /** 신규 TOP5 진행중입찰정보 */
    public static final String KEY_BIDNOTIFY_INGLIST = "bidNotifyIngList";
    /** 신규 TOP5 마감입찰정보 */
    public static final String KEY_BIDNOTIFY_ENDLIST = "bidNofiyEndList";
    
    public static final String KEY_BIZ_LIST = "bizMatchMainList";
    
    /** 게시물 최근 목록 보기 글 갯수 */
    public static final Integer RECENT_ARTICLE_COUNT = 5;
    /** 행사 및 이벤트 목록 보기 글 갯수 */
    public static final Integer MAIN_EVENT_COUNT = 5;
    /** 지식허브 목록 보기 글 갯수 */
    public static final Integer MAIN_KNWLDG_HUB_CNT = 2;
    /** 성공스토리 목록 보기 글 갯수 */
    public static final Integer MAIN_SUCCES_STY_CNT = 1;
    /** 게시물 제목이 길 경우 자를 글자수(Byte) */
    public static final Integer CUT_TITLE_NUM = 0;
    /** 이벤트 최근 목록 보기 글 갯수 */
    public static final Integer RECENT_EVENT_COUNT = 3;
    /** 이벤트 제목이 길 경우 자를 글자수(Byte) */
    public static final Integer CUT_TITLE_EVENT_NUM = 20;


    /** 도메인과 도메인코드 매핑정보 */

    /*
    String domainName[] = {"intra", "korean", "english", "spanish"};
    String domainCode[] = {"1", "2", "3", "4"};*/

    /*{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 */
    String domainName[] = {"intra", "korean","www"};
    String domainCode[] = {"1", "2","2"};
    //}}
    Map<String,String> domainMap = new HashMap<String,String>();

    public MainConstant(){
        for(int i = 0 ; i < domainName.length ; i ++){
            domainMap.put(domainName[i],domainCode[i]);
        }
    }

    public String getDomainCode(String subDomain){
        return domainMap.get(subDomain);
    }

}
