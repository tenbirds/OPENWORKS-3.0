/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base;

import java.io.File;

import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.CommonsConfigurationListener;
import zes.core.spi.commons.configuration.Config;

/**
 * 전역 설정 값을 클레스 타입으로 설정하여 사용.
 * <p />
 * config/webapp/global-config.xml 파일 내용 참조
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 1.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see CommonsConfigurationListener
 * @see Config
 */
public class BaseConfig {

    /* ----------------------------------------------------------- */
    /* -------------------- SYSTEM INFO CONFIG ------------------- */
    /* ----------------------------------------------------------- */
    public static final String APP_NAME = Config.getString("system.appNm");
    public static final String APP_VERSION = Config.getString("system.appVersion");
    public static final String APP_BUILD = Config.getString("system.appBuild");
    public static final String SYSTEM_NM = Config.getString("system.systemNm");
    public static final String CLIENT_NM = Config.getString("system.clientNm");
    public static final String ADM_DEPT_NM = Config.getString("system.adminDeptNm");
    public static final String ADM_MGR_NM = Config.getString("system.adminMgrNm");
    public static final String ADM_TEL_NO = Config.getString("system.adminTelNo");
    public static final String ADM_INN_NO = Config.getString("system.adminInnerNo");

    /* ----------------------------------------------------------- */
    /* ----------------------- LOCATION INFO --------------------- */
    /* ----------------------------------------------------------- */

    /** 서버 루트 경로 */
    public static final String WEBAPP_ROOT;
    /** 첨부파일 저장위치 */
    public static final String UPLOAD_ROOT;
    /** 정적컨텐츠 저장위치 */
    public static final String RESOURCE_ROOT;
    /*
     * 별도의 설정이 있는 경우 사용하며, 없는 경우는 서버 기본값으로 설정
     * 설정파일 : /src/main/resources/config/commons/global-config.xml
     */
    static {
        String webappRoot = Config.getString("locations.webapproot");
        if(Validate.isEmpty(webappRoot)) {
            String webAppRootKey = Config.getString("locations.webAppRootKey");
            WEBAPP_ROOT = Config.getString(webAppRootKey, "webapp.root");
        } else {
            WEBAPP_ROOT = webappRoot;
        }

        String uploadRoot = Config.getString("locations.uploadRoot");
        if(Validate.isEmpty(uploadRoot)) {
            UPLOAD_ROOT = WEBAPP_ROOT;
        } else {
            UPLOAD_ROOT = uploadRoot;
        }

        String resourceRoot = Config.getString("locations.resourceRoot");
        if(Validate.isEmpty(resourceRoot)) {
            RESOURCE_ROOT = WEBAPP_ROOT;
        } else {
            RESOURCE_ROOT = resourceRoot;
        }
    }

    public static final String UPLOAD_FOLDER_PATH = Config.getString("locations.uploadFolderPath");
    public static final String RESOURCE_FOLDER_PATH = Config.getString("locations.resourceFolderPath");
    public static final String DEFAULT_UPLOAD_FOLDER_NAME = Config.getString("locations.defaultUploadFolderPath");
    public static final String INCLUDE_TAGLIB_BASE = Config.getString("locations.includeTaglibRoot");

    /* ----------------------------------------------------------- */
    /* --------------------- GLOBAL CONFIG ----------------------- */
    /* ----------------------------------------------------------- */
    /** 인코딩 케릭터 셋 */
    public static final String ENCODING = Config.getString("global.encoding", "utf-8");
    /** 기본 날짜 포멧 */
    public static final String DATE_PATTREN = Config.getString("global.datePattern", "YYYY-MM-DD");
    /** 기본 암호화 방식 */
    public static final String DEFAULT_CRYPTO = Config.getString("global.crypto", "SEED");
    /** 관리자단 테마 */
    public static final String ADMIN_THEME = Config.getString("global.adminTheme", "/resources/openworks/theme/default");
    /** 사용자단 테마 */
    public static final String WEB_THEME = Config.getString("global.webTheme", "/resources/web/theme/default");
    /** 검색용 파라미터 Prefix */
    public static final String PREFIX_SEARCH_PARAM = Config.getString("global.prefixSearchParam", "q_");
    /** 파일 경로 구분자 */
    public static final String FILE_SEPARATOR = Config.getString("file.separator");
    /** 파일경로 구분자(윈도우 <-> UNIX 계열 반대되는 구분자 replace 등에 사용) */
    public static final String REPLACE_FILE_SEPARATOR;
    static {
        String separator = File.separator;
        if(separator.equals("/")) {
            REPLACE_FILE_SEPARATOR = "\\";
        } else {
            REPLACE_FILE_SEPARATOR = "/";
        }
    }

    /* ----------------------------------------------------------- */
    /* ----------------------- CODE CONFIG ----------------------- */
    /* ----------------------------------------------------------- */
    /** 트리구조 기본 최상위 코드 */
    public static final Integer HIGH_TREE_CD = Config.getInt("default.highTreeCd", 0);
    /** 메뉴 기본 최상위 코드 */
    public static final Integer HIGH_MENU_CD = Config.getInt("default.highMenuCd", 0);
    /** 부서 기본 최상위 코드 */
    public static final Integer HIGH_DEPT_CD = Config.getInt("default.hightDeptCd", 0);

    /* ----------------------------------------------------------- */
    /* --------------------- SESSION CONFIG ---------------------- */
    /* ----------------------------------------------------------- */
    /** 관리자 세션키 */
    public static final String MGR_SESSION_KEY = Config.getString("session.mgrSessionKey", "__msk");
    /** 사용자 세션키 */
    public static final String USER_SESSION_KEY = Config.getString("session.userSessionKey", "__usk");

    /* ----------------------------------------------------------- */
    /* ----------------------- URL CONFIG ------------------------ */
    /* ----------------------------------------------------------- */
    public static final String SYNC_URL = Config.getString("url.syncUrl", "/component/synchronize/MD_Synchronize.do");
    /** 관리자 URL prefix */
    public static final String MGR_URL_PREFIX = Config.getString("url.mgrUrlPrefix", "/intra/");
    /** 사용자 URL prefix */
    public static final String USER_URL_PREFIX = Config.getString("url.userUrlPrefix", "/web/");
    /** 관리자 로그인 URL */
    public static final String MGR_MAIN = Config.getString("url.mgrMain", "/intra/explorer/ND_index.do");
    /** 관리자 로그인 URL */
    public static final String MGR_LOGIN = Config.getString("url.mgrLogin", "/login/mgr/ND_Login.do");
    /** 관리자 세션만료 URL */
    public static final String MGR_LOST_SESSION = Config.getString("url.mgrLostSession", "/login/mgr/ND_LostSession.do");
    /** 사용자 로그인 URL */
    public static final String USER_MAIN = Config.getString("url.webMain", "/web/index.do");
    /** 사용자 로그인 URL */
    public static final String USER_LOGIN = Config.getString("url.webLogin", "/login/web/ND_Login.do");
    /** 사용자 세션만료 URL */
    public static final String USER_LOST_SESSION = Config.getString("url.webLostSession", "/login/web/ND_LostSession.do");

    /* ----------------------------------------------------------- */
    /* ----------------------- Model Object ---------------------- */
    /* ----------------------------------------------------------- */

    /** 데이터갯수 */
    public static final String KEY_DATA_CNT = "dataCnt";
    /** 사이트 목록 */
    public static final String KEY_DOMAIN_LIST = "domainList";
    /** 주요정보를 가진 객체명 */
    public static final String KEY_BASE_VO = "baseVo";
    /** 데이터 정보를 가진 객체명 */
    public static final String KEY_DATA_VO = "dataVo";
    /** 검색정보를 가진 BEAN 객체명 */
    public static final String KEY_SEARCH_VO = "searchVo";
    /** 검색정보를 가진 Map 객체명 */
    public static final String KEY_SEARCH_MAP = "searchMap";
    /** 기본정보 목록을 가진 객체명 */
    public static final String KEY_BASE_LIST = "baseList";
    /** 데이터 목록 정보를 가진 객체명 */
    public static final String KEY_DATA_LIST = "dataList";

    /** 검색결과 목록 정보를 가진 객체명 */
    public static final String KEY_SEARCH_LIST = "searchList";
    /** 공지사항 목록 정보를 가진 객체명 */
    public static final String KEY_NOTICE_LIST = "noticeList";
    /** 페이징 객체 키값 */
    public static final String KEY_PAGER = "pager";
    /** Spring View 객체명 */
    public static final String KEY_VIEW_OBJECT = "viewObject";
    /** 검증 객체 명 */
    public static final String KEY_VALIDATE = "validate";
    /** 검증결과 객체명 */
    public static final String KEY_VALIDATE_RESULT_KEY = "validateResult";
    /** 코드 목록 정보를 가진 객체명 */
    public static final String KEY_CODE_LIST = "codeList";

    /* ----------------------------------------------------------- */
    /* ---------------------- BEAN VIEW NAME --------------------- */
    /* ----------------------------------------------------------- */
    public static final String JSON_VIEW_NAME = "jsonView";
    public static final String TEXT_VIEW_NAME = "textView";
    public static final String HTML_VIEW_NAME = "htmlView";
    public static final String DOWNLOAD_VIEW_NAME = "downloadView";
    public static final String RSS_VIEW_NAME = "rssView";
    public static final String ATOM_VIEW_NAME = "atomView";
    public static final String EXCEL_VIEW_NAME = "excelView";
    public static final String PDF_VIEW_NAME = "pdfView";

    /* ----------------------------------------------------------- */
    /* ---------------------- JSP VIEW NAME ---------------------- */
    /* ----------------------------------------------------------- */
    public static final String ALERT_AND_BACK = Config.getString("jspView.alertAndBack");
    public static final String ALERT_AND_CLOSE = Config.getString("jspView.alertAndClose");
    public static final String ALERT_AND_REDIRECT = Config.getString("jspView.alertAndRedirect");
    public static final String CONFIRM_AND_REDIRECT = Config.getString("jspView.confirmAndRedirect");
    public static final String SEND_SCRIPT = Config.getString("jspView.sendScript");

    /* ----------------------------------------------------------- */
    /* ----------------------- DATA KEY NAME --------------------- */
    /* ----------------------------------------------------------- */
    public static final String TEXT_DATA_KEY = "__tdk";
    public static final String HTML_DATA_KEY = "__hdk";
    public static final String JSON_DATA_KEY = "__jdk";
    public static final String OBJ_DATA_KEY = "__odk";
    public static final String FILE_DATA_KEY = "__fdk";
    public static final String FILE_LIST_KEY = "__flk";

    /* ----------------------------------------------------------- */
    /* -------------------------- PAGING ------------------------- */
    /* ----------------------------------------------------------- */
    public static final int DEFAULT_ROW_PER_PAGE = Config.getInt("pager.rowPerPage", 10);
    public static final int DEFAULT_PAGE_PER_PAGE = Config.getInt("pager.pagePerPage", 10);
    public static final int[] DEFAULT_PAGE_NUMS = { 5, 10, 15, 30, 50, 100, 200, 300 };

    /* ----------------------------------------------------------- */
    /* ------------------------------ DB ------------------------ */
    /* ----------------------------------------------------------- */
    public static final String DB_TYPE = Config.getString("default.dbType", "cubrid");

    /* ----------------------------------------------------------- */
    /* -------------------------- HTML TAG ----------------------- */
    /* ----------------------------------------------------------- */
    public static final String SELECT_TEXT = Config.getString("html.selectText", "-- 선택 --");
    
    
    public static final String DOMAIN_MAINNM = Config.getString("domain.mainUrl");
    public static final String DOMAIN_SUBNM = Config.getString("domain.subUrl");
    public static final String DOMAIN_ADMNM = Config.getString("domain.admUrl");
    
    
    public static final String G2B_XML_AFTER = Config.getString("locations.g2bXmlAfter");
    public static final String G2B_XML_URL = Config.getString("locations.g2bXmlUrl");
    public static final String G2B_XML_BAK = Config.getString("locations.g2bXmlBak");
    public static final String G2B_XML_LOCAL = Config.getString("locations.g2bXmlLocal");    
    public static final String G2B_XML_LOCAL2 = Config.getString("locations.g2bXmlLocal2");    
    public static final String G2B_XML_REALAPPLY = Config.getString("locations.g2bXmlRealApply");    
 

    
}
