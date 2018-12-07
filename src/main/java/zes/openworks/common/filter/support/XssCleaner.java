/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.filter.support;

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
 *  2013. 6. 2.    YESNO   신규 생성
 * </pre>
 * @see
 */
public class XssCleaner {

    private static String[] EVENTS = new String[] { "onload", "onclick", "onfocus", "onLoad", "onClick", "onFocus" };
    private static String[] SCRIPT = new String[] { "<script", "</script>" };
    private static String[] NO_SCRIPT = new String[] { "<ncript", "</ncript>" };

    /**
     * 모든 HTML TAG를 표시문자로 변환한다.
     * 
     * @param content
     * @return
     */
    public static String cleanTag(String content) {
        return cleanTag(content, "script");
    }

    public static String cleanTag(String content, String type) {

        if(type.equals("all")) {
            return cleanAll(content);
        }

        return cleanScript(content);
    }

    /**
     * 모든 HTML Tag를 단순 표시 문자로 변환
     * 
     * @param content
     * @return
     */
    private static String cleanAll(String content) {

        if(content == null) {
            return "";
        }

        StringBuffer buf = new StringBuffer();
        char[] c = content.toCharArray();
        int len = c.length;
        for(int i = 0 ; i < len ; i++) {
            if(c[i] == '&') {
                buf.append("&amp;");
            } else if(c[i] == '<') {
                buf.append("&lt;");
            } else if(c[i] == '>') {
                buf.append("&gt;");
            } else if(c[i] == '"') {
                buf.append("&quot;");
            } else if(c[i] == '\'') {
                buf.append("&#039;");
            } else {
                buf.append(c[i]);
            }
        }
        return buf.toString();
    }

    /**
     * JavaScript를 구동 시킬수 있는 <script /> 태그를 치환
     * 
     * @param content
     * @param target
     * @param replace
     * @return
     */
    private static String cleanScript(String content) {

        String cont = content.toLowerCase();
        int scriptCnt = SCRIPT.length;
        for(int i = 0 ; i < scriptCnt ; i++) {

            String target = SCRIPT[i];
            String replace = NO_SCRIPT[i];

            StringBuilder sb = new StringBuilder();

            int prePos = 0;
            int nxtPos = 0;
            int targetLength = target.length();
            while(nxtPos > -1) {
                nxtPos = cont.indexOf(target, prePos);

                if(nxtPos > -1) {
                    sb.append(content.substring(prePos, nxtPos));
                    sb.append(replace);

                    prePos = nxtPos + targetLength;
                }
            }

            int contLen = cont.length();
            if(prePos < contLen) {
                sb.append(content.substring(prePos));
            }

            content = sb.toString();
        }

        return cleanEvent(content);
    }

    /**
     * JavaScript 문법중 특정 이벤트 속성을 사용되지 않도록 변경.
     * 
     * @param content
     * @return
     */
    private static String cleanEvent(String content) {

        for(String event : EVENTS) {
            content = content.replaceAll(event, "false");
        }

        return content;
    }
}
