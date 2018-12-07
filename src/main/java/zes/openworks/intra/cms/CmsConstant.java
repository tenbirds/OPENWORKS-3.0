/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import zes.core.spi.commons.configuration.Config;

/**
 * 사용자메뉴 상수 객체
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OP 1.0
 */
public final class CmsConstant {

    protected static final Logger logger = Logger.getLogger(CmsConstant.class);

    public static final Map<Integer, String> APPROVAL_STAT = new HashMap<Integer, String>();
    static {
        APPROVAL_STAT.put(Config.getInt("cms.approval.write[@code]"), Config.getString("cms.approval.write[@name]"));
        APPROVAL_STAT
            .put(Config.getInt("cms.approval.request[@code]"), Config.getString("cms.approval.request[@name]"));
        APPROVAL_STAT.put(Config.getInt("cms.approval.reject[@code]"), Config.getString("cms.approval.reject[@name]"));
        APPROVAL_STAT.put(Config.getInt("cms.approval.complete[@code]"),
            Config.getString("cms.approval.complete[@name]"));
    }

    /** Attach File 경로(첨부파일) */
    public static final String DECORATOR_ROOT = Config.getString("cms.basePath.decoratorRoot");
    /** 일반리소스 저장경로 */
    public static final String RESOURCE_ROOT = Config.getString("cms.basePath.resourceRoot");
    /** 메뉴파일 저장경로 */
    public static final String MENU_ROOT = Config.getString("cms.basePath.menuRoot");

    /** 메뉴유형 */
    public static final Map<String, String> MENU_TYPES = new HashMap<String, String>();
    /** 링크유형 */
    public static final Map<String, String> LINK_TYPES = new HashMap<String, String>();
    /** 권한유형 */
    private static final Map<String, String> AUTH_TYPES = new HashMap<String, String>();
    /** 하위메뉴표시유형 */
    public static final Map<String, String> CHILD_MENU_SHOW_TYPE = new HashMap<String, String>();

    /** 메뉴유형 */
    public static final List<Map<String, String>> MENU_TYPE_LIST = new ArrayList<Map<String, String>>();
    /** 링크유형 */
    public static final List<Map<String, String>> LINK_TYPE_LIST = new ArrayList<Map<String, String>>();
    /** 권한유형 */
    public static final List<Map<String, String>> AUTH_TYPE_LIST = new ArrayList<Map<String, String>>();

    /** 기본링크유형 */
    public static final String DEFAULT_LINK_TYPE = Config.getString("cms.defaultLinkType");
    /** 파일 인코딩 값 */
    public static final String FILE_ENCODING = "UTF-8";
    /** 파일 구분자 */
    public static final String FILE_SEPA = File.separator;
    /** 시스템 라인 구분자 */
    public static final String SYS_LINE_SEPA = Config.getString("line.separator");
    /** 윈도우 시스템 라인 구분자 */
    public static final String WIN_LINE_SEPA = "\r\n";
    /** UNIX/LINUX/MAC 시스템 라인 구분자 */
    public static final String UNIX_LINE_SEPA = "\n";
    /** 내용비교 라인수 1 */
    public static final Integer ONE_LINE = 1;
    /** 내용비교 라인수 2 */
    public static final Integer TWO_LINE = 2;

    /** site mesh decorator 설정 키 */
    public static final String DECORATOR_MENU = "menudecorator";
    public static final String DECORATOR_KEY = "decorator";
    public static final String DECORATOR_NAME = "web-decorator";
    /*{{ BH, 2015.11.19, 도메인관리 삭제로 인한 추가 */
    public static final String DOMAIN_NAME = "domain_name";
    //}}
    /* 각 상수값 설정 */
    static {

        String key = "";
        String splitKey = "";
        Map<String, String> tmpMap = null;

        // 메뉴유형
        Iterator<?> it = Config.getKeys("cms.menuTypes");
        while(it.hasNext()) {
            tmpMap = new HashMap<String, String>();

            key = String.valueOf(it.next());
            splitKey = key.substring(key.lastIndexOf(".") + 1);
            MENU_TYPES.put(splitKey, Config.getString(key));

            tmpMap.put("TYPE_CODE", splitKey);
            tmpMap.put("TYPE_NAME", Config.getString(key));
            MENU_TYPE_LIST.add(tmpMap);
        }
        // 링크유형
        it = Config.getKeys("cms.linkTypes");
        while(it.hasNext()) {
            tmpMap = new HashMap<String, String>();

            key = String.valueOf(it.next());
            splitKey = key.substring(key.lastIndexOf(".") + 1);
            LINK_TYPES.put(splitKey, Config.getString(key));

            tmpMap.put("TYPE_CODE", splitKey);
            tmpMap.put("TYPE_NAME", Config.getString(key));
            LINK_TYPE_LIST.add(tmpMap);
        }
        // 권한유형
        it = Config.getKeys("cms.authTypes");
        while(it.hasNext()) {
            tmpMap = new HashMap<String, String>();

            key = String.valueOf(it.next());
            splitKey = key.substring(key.lastIndexOf(".") + 1);
            AUTH_TYPES.put(splitKey, Config.getString(key));

            tmpMap.put("TYPE_CODE", splitKey);
            tmpMap.put("TYPE_NAME", Config.getString(key));
            AUTH_TYPE_LIST.add(tmpMap);
        }

    }

    /**
     * 상속 불가 및 외부에서 생성 불가.
     */
    private CmsConstant() {
    }

}
