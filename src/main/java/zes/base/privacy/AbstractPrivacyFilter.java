/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.privacy;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <pre>
 * 파일 내에 아래 개인정보를 포함하고 있는지 제공된 정규표현식으로 검증한다.
 * 
 * 주민번호, 여권번호, 운전면허 번호, 핸드폰번호, 신용카드번호, 건강보험번호, 계좌번호
 * 
 * << 개정이력(Modification Information) >>
 * 
 *     수정일               수정자                  수정내용
 * --------------  --------  -------------------------------
 *  
 * 
 *  2013. 06. 04.       방기배         개인정보 필터링
 * </pre>
 */
public abstract class AbstractPrivacyFilter implements PrivacyFilter {

    /** SL4J 로깅 */
    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    /** 정규표현식 목록 */
    public static final List<Pattern> REG_EXPS = new ArrayList<Pattern>();
    /** 정규표현식 목록 갯수 */
    private static int REG_EXPS_CNT;
    /** 구분자 */
    public static final String SEPA = "[\\-~\\.\\s]";

    /** 주민등록번호 정규표현식 */
    public static final String SID_REGEXP = "([01]\\d{5}" + SEPA + "[1-4]\\d{6}|[2-9]\\d{5}" + SEPA + "+[1-2]\\d{6})";
    /** 여권번호 정규표현식 */
    public static final String PASSPORT_REGEXP = "[a-zA-Z]{2}" + SEPA + "\\d{7}";
    /** 운전면허번호 정규표현식 */
    public static final String DRIVER_REGEXP = "\\d{2}" + SEPA + "\\d{6}" + SEPA + "\\d{2}";
    /** 휴대전화번호 정규표현식 */
    public static final String MOB_REGEXP = "01[016789]" + SEPA + "\\d{3,4}" + SEPA + "\\d{4}";
    /** 신용카드번호 정규표현식 */
    public static final String CREDIT_REGEXP = "[34569]\\d{3}" + SEPA + "\\d{4}" + SEPA + "\\d{4}" + SEPA + "\\d{4}";
    /** 건강보험번호 정규표현식 */
    public static final String HEALTH_REGEXP = "[1257]" + SEPA + "\\d{10}";
    /** 계좌번호 정규표현식 */
    public static final String ACCOUNT_REGEXP = "(" +
        "\\d{2}" + SEPA + "\\d{2}" + SEPA + "\\d{6}|" +
        "\\d{3}" + SEPA + "(" +
        "\\d{5,6}" + SEPA + "\\d{3}|" +
        "\\d{6}" + SEPA + "\\d{5}|" +
        "\\d{2,3}" + SEPA + "\\d{6}|" +
        "\\d{2}" + SEPA + "\\d{7}|" +
        "\\d{2}" + SEPA + "\\d{4,6}" + SEPA + "\\d|" +
        "\\d{5}" + SEPA + "\\d{3}" + SEPA + "\\d{2}|" +
        "\\d{2}" + SEPA + "\\d{5}" + SEPA + "\\d{3}|" +
        "\\d{4}" + SEPA + "\\d{4}" + SEPA + "\\d{3}|" +
        "\\d{6}" + SEPA + "\\d{2}" + SEPA + "\\d{3}|" +
        "\\d{2}" + SEPA + "\\d{2}" + SEPA + "\\d{7}|" +
        "\\d{4}" + SEPA + "\\d{3}" + SEPA + "\\d{6}|" +
        "\\d{2}" + SEPA + "\\d{6}" + SEPA + "\\d" +
        ")|" +
        "\\d{5}" + SEPA + "\\d{2}" + SEPA + "\\d{6}|" +
        "\\d{6}" + SEPA + "\\d{2}" + SEPA + "\\d{5,6}" +
        ")";

    static {
        Pattern p1 = Pattern.compile(CREDIT_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p1);

        Pattern p2 = Pattern.compile(DRIVER_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p2);

        Pattern p3 = Pattern.compile(HEALTH_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p3);

        Pattern p4 = Pattern.compile(MOB_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p4);

        Pattern p5 = Pattern.compile(PASSPORT_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p5);

        Pattern p6 = Pattern.compile(SID_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p6);

        Pattern p7 = Pattern.compile(ACCOUNT_REGEXP, Pattern.CASE_INSENSITIVE);
        REG_EXPS.add(p7);

        REG_EXPS_CNT = REG_EXPS.size();
    }

    /** 문자열 또는 파일 경로 */
    protected String content;

    /** 파일 객체 **/
    protected File file;

    /**
     * 문자열에 개인정보가 포함되어 있는지 확인하고 결과를 반환한다.
     * 
     * @param content 검사대상 문자열 또는 경로를 포함한 전체 파일명
     * @return
     */
    protected boolean doPrivacyCheck(String content) {

        Pattern pattern;
        Matcher matcher;

        for(int i = 0 ; i < AbstractPrivacyFilter.REG_EXPS_CNT ; i++) {

            pattern = REG_EXPS.get(i);
            matcher = pattern.matcher(content);

            if(matcher.find()) {
                return true;
            }
        }
        return false;
    }
}
