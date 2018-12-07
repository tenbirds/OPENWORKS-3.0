/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.spring.view;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

import zes.base.vo.FileVO;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;

/**
 * 파일 다운로드 공통 VIEW 구현체
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
 *  2012. 3. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class DownloadView extends AbstractView {

    private final int ILLEGAL_ARGUMENT = 1;
    private final int NO_EXIST = 2;
    public static final String DEFAULT_CONTENT_TYPE = "application/octet-stream";

    public DownloadView() {
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
        HttpServletResponse response) throws Exception {

        String encodedFileNm = null;
        File file = null;

        Object object = model.get(GlobalConfig.FILE_DATA_KEY);
        if(object instanceof File) {
            file = (File) object;
            //encodedFileNm = new String(file.getName().getBytes("KSC5601"), "8859_1");
            //위구문 아래로 변경 후 아래 URLEncoder 추가
            encodedFileNm = file.getName();
        } else if(object instanceof FileVO) {
            FileVO baseFileVo = (FileVO) object;
            //encodedFileNm = new String(baseFileVo.getLocalNm().getBytes("KSC5601"), "8859_1");
            //위구문 아래로 변경 후 아래 URLEncoder 추가
            encodedFileNm = baseFileVo.getLocalNm();
            file = new File(GlobalConfig.UPLOAD_ROOT + baseFileVo.getFileUrl());
        } else {
            flushError(response, ILLEGAL_ARGUMENT, null);
            return;
        }

        if(file == null || !file.exists()) {
            flushError(response, NO_EXIST, encodedFileNm);
            return;
        }
        /*KS 추가 {*/
        String header = request.getHeader("User-Agent");
        if(header.contains("MSIE") || header.contains("Trident")) {
            encodedFileNm = URLEncoder.encode(encodedFileNm, "UTF-8");
            encodedFileNm = encodedFileNm.replaceAll("\\+", " ");
        } else if(header.contains("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < encodedFileNm.length(); i++) {
                char c = encodedFileNm.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFileNm = sb.toString();
        } else {
            encodedFileNm = new String(encodedFileNm.getBytes("UTF-8"),"ISO-8859-1");
        }
        /*}*/
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setContentLength((int) file.length());

        response.setHeader("Content-Disposition", "attachment;filename=\"" + encodedFileNm + "\";");
        setContentType(DEFAULT_CONTENT_TYPE);

        byte b[] = new byte[1024];

        BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
        BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
        int read = 0;

        try {
            while((read = fin.read(b)) != -1) {
                outs.write(b, 0, read);
            }

            outs.close();
        } catch (Exception e) {
            if(logger.isInfoEnabled()) {
                logger.warn("Download error : " + e);
            }
        } finally {
            if(fin != null) {
                fin.close();
            }
        }

        if(file.getName().startsWith("CompressDown_")) {
            try {
                file.delete();
            } catch (Exception e) {}
        }
    }

    /**
     * 오류 발생 시 메시지를 생성하고 alert을 통하여 메시지를 전달 후 history.back()을 호출한다.
     *
     * @param response
     * @param flag
     * @throws Exception
     */
    private void flushError(HttpServletResponse response, int flag, String fileName) throws Exception {

        String message = null;
        switch(flag) {
            case ILLEGAL_ARGUMENT:
                message = "요청 정보가 올바르게 전달되지 않았습니다.";
                break;
            case NO_EXIST:
                message = "[ " + fileName + " ] 파일이 삭제되었거나 존재하지 않습니다.";
                break;
            default:
                message = StringUtil.EMPTY;
                break;
        }

        StringBuffer alertScript = new StringBuffer();
        alertScript.append("<script type='text/javascript'>");
        alertScript.append("    alert('" + message + "');");
        alertScript.append("    history.back();");
        alertScript.append("</script>");

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(alertScript.toString());

    }
}
