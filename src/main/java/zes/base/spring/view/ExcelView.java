/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.spring.view;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import zes.base.vo.IExcelVO;
import zes.openworks.common.GlobalConfig;

/**
 * IExcelVO 구현 VO 객체를 전달받아 Excel 파일을 다운로드 한다.
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
 * @see org.apache.poi.hssf.usermodel.HSSFWorkbook
 * @see AbstractExcelView
 */
public class ExcelView extends AbstractExcelView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

        IExcelVO excelVo = (IExcelVO) model.get(GlobalConfig.OBJ_DATA_KEY);

        if(excelVo != null) {
            /* KS 추가 {{ */
            String header = request.getHeader("User-Agent");
            String encodedFileNm = excelVo.getFileName();
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
            /* }} */
            //String encodedFileNm = new String(excelVo.getFileName().getBytes("KSC5601"), "8859_1");

            response.setHeader("Content-Disposition", "attachment; fileName=\"" + encodedFileNm + ".xls\";");

            excelVo.createExcelDocument(workbook, model);
        }
    }

}
