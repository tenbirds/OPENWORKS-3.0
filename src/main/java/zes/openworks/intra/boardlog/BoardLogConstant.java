/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.Map;
import java.util.TreeMap;

/**
 * 게시판 통계 Constant
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
 *  2012. 6. 25.     홍길동      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardLogConstant {

    /** 게시물 현황 */
    public final static Integer TYPE_BBS = 1001;
    /** 게시물 커멘트 현황 */
    public final static Integer TYPE_CMT = 1002;
    /** 게시물 첨부파일 현황 */
    public final static Integer TYPE_FILE = 1003;

    /** 년도별 통계 */
    public final static Integer TYPE_YEAR = 1001;
    /** 월별 통계 */
    public final static Integer TYPE_MONTH = 1002;
    /** 일별 통계 */
    public final static Integer TYPE_DAY = 1003;
    /** 시간별 통계 */
    public final static Integer TYPE_HOUR = 1004;

    /** 게시판 통계 기간별 유형 목록 */
    public final static Map<Integer, String> TERM_CD_LIST = new TreeMap<Integer, String>();
    static {
        TERM_CD_LIST.put(TYPE_YEAR, "연도별");
        TERM_CD_LIST.put(TYPE_MONTH, "월별");
        TERM_CD_LIST.put(TYPE_DAY, "일별");
        TERM_CD_LIST.put(TYPE_HOUR, "시간별");
    }

    /** 게시판 통계 데이터별 유형 목록 */
    public final static Map<Integer, String> CD_TYPE_LIST = new TreeMap<Integer, String>();
    static {
        CD_TYPE_LIST.put(TYPE_BBS, "게시물 현황");
        CD_TYPE_LIST.put(TYPE_CMT, "댓글 현황");
        CD_TYPE_LIST.put(TYPE_FILE, "첨부파일 현황");
    }
}
