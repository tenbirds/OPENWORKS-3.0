/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.spring.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import zes.base.vo.IPdfVO;
import zes.openworks.common.GlobalConfig;

import com.lowagie.text.Document;
import com.lowagie.text.pdf.PdfWriter;

/**
 * IPdfVO 구현 VO 객체를 전달받아 PDF 파일을 다운로드 한다.
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
 * @see zes.base.vo.IPdfVO
 */
public class PdfView extends AbstractPdfView {

    @Override
    protected void buildPdfMetadata(Map<String, Object> model, Document document, HttpServletRequest request) {
    }

    @Override
    protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
        HttpServletRequest request, HttpServletResponse response) throws Exception {

        IPdfVO basePdfVo = (IPdfVO) model.get(GlobalConfig.OBJ_DATA_KEY);

        if(basePdfVo != null) {
            basePdfVo.createPdfDocument(document, model);
        }
    }
}
