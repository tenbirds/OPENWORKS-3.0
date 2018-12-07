/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.taglib.ui;

import java.io.IOException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.Calendar;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;

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
 *  2012. 3. 15.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class DateTag extends SimpleTagSupport {

    private Object date = null; // 변환할 데이터(스트링 YYYYMMDDHHMMSS, YYYYMMDD형태)
    private Object today = null; // 비교할 기준 시간, 비어있을경우 오늘 현재 시간사용
    private String type = null; // [date, short, full] : 기본 표시일 경우 날짜 길이를 표시함
    private String empty = null; // 날짜 값이 없을 경우 표시 문자열
    private final String DEFAULT_EMPTY = "없음"; // 날짜값이 없을 경우 기본 표시 문자열

    // type == date : 무조건 yyyy-MM-DD 형태로 표시(날짜표시)
    // type == hour : 무조건 YYYY-MM-DD HH 로 표시(시까지만 표시)
    // type == min : 무조건 YYYY-MM-DD HH:MM 로 표시(분까지만 표시)
    // type == datetime : 무조건 yyyy-MM-DD HH:MM:SS 형태로 표시(날짜표시)
    // type == short : 1일이내 문자로표시, 1일이상 YYYY-MM-DD 형태로표시
    // type == full : 1일이내 문자로표시, 1일이상 YYYY-MM-DD HH:MM:SS 로 표시

    /**
     * 실제 태그 처리.
     */
    @Override
    public void doTag() throws JspException, IOException {

        String dateStr = "";
        String todayStr = "";
        String html = "";
        JspWriter writer = getJspContext().getOut();

        if(Validate.isEmpty(this.type)) {
            this.type = "date";
        }

        if(Validate.isEmpty(this.empty)) {
            this.empty = DEFAULT_EMPTY;
        }

        if(Validate.isEmpty(this.date) || !(this.date instanceof String)) {
            writer.write(this.empty);
            return;
        }

        dateStr = (String) this.date;
        if(dateStr.length() != 14 && dateStr.length() != 12 && dateStr.length() != 8) {
            throw new JspException("날짜값이 부정확합니다.!");
        }

        if(Validate.isNotEmpty(this.today) && (this.date instanceof String) && (((String) this.date).length() == 14)) {
            todayStr = (String) this.today;
        } else {
            todayStr = DateFormatUtil.getToday();
        }

        Calendar dateCal = getCalendar(dateStr);
        Calendar todayCal = getCalendar(todayStr);

        if("date".equals(this.type) || "datetime".equals(this.type) || "min".equals(this.type)
            || "hour".equals(this.type)) {
            html = standardDate(dateCal);
        } else {
            html = prettyDate(dateCal, todayCal);
        }

        writer.write(html);
    }

    /**
     * 입력된 문자열을 켈린터 객체로 변환
     * 
     * @param str
     * @return
     */
    private Calendar getCalendar(String str) {

        Calendar cal = Calendar.getInstance();

        cal.set(Calendar.YEAR, Integer.valueOf(str.substring(0, 4)));
        cal.set(Calendar.MONTH, Integer.valueOf(str.substring(4, 6)) - 1);
        cal.set(Calendar.DAY_OF_MONTH, Integer.valueOf(str.substring(6, 8)));

        if(str.length() > 8) {
            cal.set(Calendar.HOUR_OF_DAY, Integer.valueOf(str.substring(8, 10)));
            cal.set(Calendar.MINUTE, Integer.valueOf(str.substring(10, 12)));
            if(str.length() == 14) {
                cal.set(Calendar.SECOND, Integer.valueOf(str.substring(12, 14)));
            } else {
                cal.set(Calendar.SECOND, 0);
            }
        }

        return cal;
    }

    /**
     * 날짜 꾸미기(현재 시간과 등록된 시간의 차이를 구해 표시)
     * 
     * @param dateCal
     * @param todayCal
     * @return
     */
    private String prettyDate(Calendar dateCal, Calendar todayCal) {

        Long diff = (todayCal.getTimeInMillis() - dateCal.getTimeInMillis()) / 1000;
        Integer dayDiff = ConverToIntstr(diff / (86400));

        if(dayDiff < 0) {
            return "";
        }

        if(dayDiff == 0) {
            if(diff < 60) {
                return "방금";
            } else if(diff < 120) {
                return "1 분 전";
            } else if(diff < 3600) {
                return ConverToIntstr(Math.floor(diff / 60)) + " 분 전";
            } else if(diff < 7200) {
                return "1 시간 전";
            } else if(diff < 86400) {
                return ConverToIntstr(Math.floor(diff / 3600)) + " 시간 전";
            }
        }

        return standardDate(dateCal);
    }

    /**
     * <code>int</code> 형으로 변환
     * 
     * @param lval
     * @return
     */
    private Integer ConverToIntstr(Long lval) {
        NumberFormat nf = NumberFormat.getIntegerInstance();
        nf.setParseIntegerOnly(true);
        Number val = null;
        try {
            val = nf.parse(String.valueOf(lval));
        } catch (ParseException e) {
            val = -1;
        }
        return Integer.parseInt(nf.format(val));
    }

    /**
     * <code>int</code> 형으로 변환
     * 
     * @param lval
     * @return
     */
    private Integer ConverToIntstr(Double lval) {
        NumberFormat nf = NumberFormat.getIntegerInstance();
        nf.setParseIntegerOnly(true);
        Number val = null;
        try {
            val = nf.parse(String.valueOf(lval));
        } catch (ParseException e) {
            val = -1;
        }
        return Integer.parseInt(nf.format(val));
    }

    /**
     * 표준형 포멧을 반환
     * 
     * @param cal
     * @return
     */
    private String standardDate(Calendar cal) {

        if("full".equals(this.type) || "datetime".equals(this.type)) {
            return DateFormatUtil.getDateFull(cal.getTime());
        } else if("hour".equals(this.type)) {
            return DateFormatUtil.getDateFull(cal.getTime()).substring(0, 13);
        } else if("min".equals(this.type)) {
            return DateFormatUtil.getDateFull(cal.getTime()).substring(0, 16);
        } else {
            return DateFormatUtil.getDateShort(cal.getTime());
        }
    }

    /**
     * date을 설정
     * 
     * @param date 을(를) Object date로 설정
     */
    public void setDate(Object date) {
        this.date = date;
    }

    /**
     * today을 설정
     * 
     * @param today 을(를) Object today로 설정
     */
    public void setToday(Object today) {
        this.today = today;
    }

    /**
     * type을 설정
     * 
     * @param type 을(를) String type로 설정
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * empty을 설정
     * 
     * @param empty 을(를) String empty로 설정
     */
    public void setEmpty(String empty) {
        this.empty = empty;
    }

}
