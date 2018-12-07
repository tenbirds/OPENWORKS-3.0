/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.support;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.intra.cms.CmsConstant;

/**
 * CMS 유틸리티
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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CmsUtil {

    /** 로깅 */
    private static Logger logger = LoggerFactory.getLogger(CmsUtil.class);

    private static final int SUCCESS_CODE = 200;
    private static final String SUCCESS_MSG = "SUCCESS";
    /** 연결 대기 시간 10초 */
    private static final int CONN_TIME_OUT = 10000;

    public static final String WAS_ROOT = GlobalConfig.WEBAPP_ROOT;
    private static final String HEADER = "<%@ page contentType=\"text/html;charset=utf-8\" %>\n";

    /**
     * 새 디렉토리를 생성한다. 상위디렉토리가 없으면 생성한다.
     * 
     * @param dirs 생성할 디렉토리 전체경로
     * @return 성공적으로 생성했다면 true.
     */
    public static boolean mkdirs(String dirs) {
        return mkdirs(new File(dirs));
    }

    /**
     * 새 디렉토리를 생성한다. 상위디렉토리가 없으면 생성한다.
     * 
     * @param dirs 생성할 디렉토리 파일 객체
     * @return 성공적으로 생성했다면 true.
     */
    public static boolean mkdirs(File dirs) {
        return dirs.mkdirs();
    }

    /**
     * 새 디렉토리를 생성한다.
     * 
     * @param dir 생성할 디렉토리 전체경로
     * @return 성공적으로 생성했다면 true.
     */
    public static boolean mkdir(String dir) {
        return mkdir(new File(dir));
    }

    /**
     * 새 디렉토리를 생성한다.
     * 
     * @param dir 생성할 디렉토리 파일 객체
     * @return 성공적으로 생성했다면 true.
     */
    public static boolean mkdir(File dir) {
        return dir.mkdir();
    }

    /**
     * 업로드 콘트롤을 통해 업로드된 파일을 삭제한다.
     * 
     * @param filePath 문자열
     */
    public static void deleteFile(String filePath) {

        String fullPath = WAS_ROOT;

        File file;
        if(Validate.isNotEmpty(filePath)) {
            String strFile = fullPath + filePath;
            strFile.replace("/", File.separator);

            file = new File(strFile);
            if(file.isFile()) {
                file.delete();
            }
        }
    }

    /**
     * 사이트명 중에서 host 명에 해당하는 문자열을 반환
     * 
     * @param domainNm
     * @return 호스트명
     */
    public static String getHostName(String domainNm) {
        
        /* 이전소스
           String hostNm = "";
           if(domainNm.indexOf(".") >= 0) {
           hostNm = domainNm.substring(0, domainNm.indexOf("."));
        }*/
        
        //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경 
        // 변경소스
        String hostNm = "korean";
        //}}
        
        return hostNm;
    }

    public static String getSiteName(String reqUri) {
        String siteNm = "www";
        String urls[];
        if(!"".equals(reqUri) && !"/".equals(reqUri)) {
            urls = reqUri.split("/");
            if(reqUri.indexOf("/") == 0) {
                siteNm = urls[1];
            } else {
                siteNm = urls[0];
            }
        }

        return siteNm;
    }
    
    /**
    * 돌려보낼 domain과 url생성
    * getRtnDomUrl 설명
    * 
    * @param String
    */
   public static String getRtnDomain(String reqUri) {
       String siteNm = "";
       String urls[];
       if(!"".equals(reqUri) && !"/".equals(reqUri)) {
           urls = reqUri.split("/");
           siteNm = urls[2];
       }
       return siteNm;
   }
   
   /**
    /**
     * 파일 확장자를 얻음.
     * 
     * @param filename 파일명
     * @return 파일 확장자
     */
    public static String getExtension(String filename) {
        int lastDot = filename.lastIndexOf('.');

        if(lastDot >= 0) {
            return filename.substring(lastDot + 1);
        } else {
            return StringUtil.EMPTY;
        }
    }

    /**
     * HTML 내용을 생성한다.
     * 
     * @param title 제목
     * @param headContent head tag 사이의 컨텐츠
     * @param bodyContent body tag 사이의 컨텐츠
     * @return
     */
    public static String makeHtml(String title, String headContent, String bodyContent) {

        StringBuilder sb = new StringBuilder();

        sb.append(Config.getString("cms.htmlOp"));
        // title 설정
        sb.append(title);
        sb.append(Config.getString("cms.metaOp"));
        // <head></head> 태그 사이에 들어갈 내용
        if(Validate.isNotEmpty(headContent)) {
            sb.append(headContent.trim());
        }
        sb.append(Config.getString("cms.bodyOp"));
        // <body></body> 태그 사이에 들어갈 내용
        sb.append(bodyContent.trim());
        sb.append(Config.getString("cms.htmlEd"));

        return sb.toString();
    }

    /**
     * 승인처리 시 컨텐츠 정보를 받아서 컨텐츠 파일 생성
     * 
     * @param menuCode
     * @param basePath
     * @param title
     * @param headContent
     * @param bodyContent
     * @throws Exception
     */
    public static void makeContent(String menuCode, String basePath, String title, String headContent,
        String bodyContent) throws Exception {

        String menuContent = makeHtml(title, headContent, bodyContent);

        String savePath = WAS_ROOT + basePath;
        savePath = StringUtil.replace(savePath, CmsConstant.FILE_SEPA + CmsConstant.FILE_SEPA,
            CmsConstant.FILE_SEPA);
        savePath = StringUtil.replace(savePath, "/", CmsConstant.FILE_SEPA);
        savePath = StringUtil.replace(savePath, "//", CmsConstant.FILE_SEPA);
        savePath = savePath.endsWith(CmsConstant.FILE_SEPA) ? savePath : savePath + CmsConstant.FILE_SEPA;

        String saveFile = savePath + menuCode + ".jsp";
        // UTF-8 page content 적용
        boolean headerYn = true;

        mkdirs(savePath);
        writeContents(saveFile, menuContent, headerYn);

    }

    /**
     * 레이아웃 파일 생성
     * 
     * @param layoutContent
     * @param filePath
     * @throws Exception
     */
    public static void makeLayout(String layoutContent, String filePath) throws Exception {

        String savePath = WAS_ROOT + filePath;
        savePath = StringUtil.replace(savePath, CmsConstant.FILE_SEPA + CmsConstant.FILE_SEPA, CmsConstant.FILE_SEPA);
        savePath = StringUtil.replace(savePath, "/", CmsConstant.FILE_SEPA);
        savePath = StringUtil.replace(savePath, "//", CmsConstant.FILE_SEPA);
        savePath = StringUtil.replace(savePath, (CmsConstant.FILE_SEPA + CmsConstant.FILE_SEPA), CmsConstant.FILE_SEPA);

        String dirPath = savePath.substring(0, savePath.lastIndexOf(CmsConstant.FILE_SEPA));

        // UTF-8 page content 적용 않함
        boolean headerYn = false;
        mkdirs(dirPath);

        writeContents(savePath, layoutContent, headerYn);

    }

    /**
     * 파일 내용 쓰기
     * 
     * @param file
     * @param contents
     * @return
     */
    public static boolean writeContents(File file, String contents) {

        try {
            contents = HEADER + contents;

            FileUtil.writeString(file, contents, CmsConstant.FILE_ENCODING);

            return true;
        } catch (IOException e) {
            if(logger.isDebugEnabled()) {
                logger.debug("file write failed", e);
            }
            return false;
        }
    }

    /**
     * 파일 내용 쓰기 headerYn : UTF-8 page content 적용여부
     * 
     * @param fullPath
     * @param contents
     * @param headerYn
     * @return
     */
    public static boolean writeContents(String fullPath, String contents, boolean headerYn) {

        try {
            File file = new File(fullPath);

            if(headerYn) {
                contents = HEADER + contents;
            }

            FileUtil.writeString(file, contents, CmsConstant.FILE_ENCODING);

            return true;
        } catch (IOException e) {
            if(logger.isDebugEnabled()) {
                logger.debug("file write failed", e);
            }
            return false;
        }
    }

    /**
     * 복수 사이트인 경우 각 사이트의 CMS 컨텐츠를 동기화 한다.
     * 
     * @param domainCd
     * @param menuCode
     * @param domainGroup
     * @return
     */
    public static String synchronize(Integer domainCd, String menuCode, String layoutCode,
        List<DomainGroupVO> domainGroup) {

        StringBuilder result = new StringBuilder();

        if(Validate.isEmpty(domainGroup)) {
            return result.append("오류 : 싱크대상 사이트이 없습니다.").toString();
        }

        StringBuilder url;
        int statusCode;

        int domainCnt = domainGroup.size();

        StringBuilder sb = new StringBuilder();
        String line = null;

        HttpClient httpclient = null;
        HttpHost httpHost = null;
        HttpParams params = null;
        HttpPost post = null;
        HttpResponse response = null;
        HttpEntity entityResponse = null;

        UrlEncodedFormEntity entity = null;
        List<NameValuePair> nameValuePairs = null;

        InputStream is = null;
        BufferedReader reader = null;

        for(int i = 0 ; i < domainCnt ; i++) {

            DomainGroupVO domainGroupVO = domainGroup.get(i);

            url = new StringBuilder();
            if(Validate.isNotEmpty(domainGroupVO.getGroupPortNo())) {
                httpHost = new HttpHost(domainGroupVO.getGroupIpAddr(), domainGroupVO.getGroupPortNo());
            } else {
                httpHost = new HttpHost(domainGroupVO.getGroupIpAddr());
            }

            if(Validate.isNotEmpty(domainGroupVO.getContextPath())) {
                url.append(domainGroupVO.getContextPath());
            }

            if(Validate.isEmpty(layoutCode)) {
                url.append("/cms/synchronize/ND_SyncContent.do");
            } else {
                url.append("/cms/synchronize/ND_SyncLayout.do");
            }

            try {
                httpclient = new DefaultHttpClient();

                params = httpclient.getParams();
                HttpConnectionParams.setConnectionTimeout(params, CONN_TIME_OUT);
                HttpConnectionParams.setSoTimeout(params, CONN_TIME_OUT);

                nameValuePairs = new ArrayList<NameValuePair>();
                nameValuePairs.add(new BasicNameValuePair("domainCd", String.valueOf(domainCd)));
                nameValuePairs.add(new BasicNameValuePair("menuCode", menuCode));
                nameValuePairs.add(new BasicNameValuePair("layoutCode", layoutCode));

                entity = new UrlEncodedFormEntity(nameValuePairs, "UTF-8");

                post = new HttpPost(url.toString());
                post.setEntity(entity);

                response = httpclient.execute(httpHost, post);
                entityResponse = response.getEntity();

                is = entityResponse.getContent();

                reader = new BufferedReader(new InputStreamReader(is, "UTF-8"), 1024);

                sb = new StringBuilder();

                line = null;

                while((line = reader.readLine()) != null) {
                    sb.append(line).append("\n");
                }

                statusCode = response.getStatusLine().getStatusCode();

                if(statusCode == SUCCESS_CODE && sb.toString().trim().equals(SUCCESS_MSG)) {
                    result.append(domainGroupVO.getGroupIpAddr()).append(" 동기화 완료");
                } else {
                    result.append(domainGroupVO.getGroupIpAddr()).append(" 동기화 실패 ")
                        .append(response.getStatusLine().getReasonPhrase());
                }

            } catch (Exception e) {
                if(logger.isDebugEnabled()) {
                    logger.debug("content synchronized failed", e);
                }
                result.append(domainGroupVO.getGroupIpAddr()).append(" 동기화 실패 오류.")
                    .append(CmsConstant.WIN_LINE_SEPA + e.getMessage());
            } finally {
                try {
                    if(is != null) {
                        is.close();
                    }
                } catch (IOException e) {
                    // do nothing
                }
            }
        }

        return result.toString();
    }

}
