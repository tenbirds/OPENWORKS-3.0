/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.privacy;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.pdfbox.cos.COSDocument;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;

/**
 * PDF 파일(pdf 확장자)에 대한 개인정보 포함여부를 확인한다.
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일               수정자                  수정내용
 * --------------  --------  -------------------------------
 *  
 * 
 *  2013. 06. 04.       방기배         개인정보 필터링
 * </pre>
 */
public class PrivacyPdfFileFilter extends AbstractPrivacyFilter implements PrivacyFilter {

    public PrivacyPdfFileFilter(File file) {
        this.file = file;
    }

    /*
     * PDF 파일내에서 개인정보를 포함한 값이 있는지 여부를 확인
     * @see zes.base.privacy.PrivacyFilter#doFilter()
     */
    @Override
    public boolean doFilter() {

        FileInputStream fileInput = null;
        COSDocument cd = null;

        try {
            fileInput = new FileInputStream(this.file);
            PDFParser parser = new PDFParser(fileInput);
            parser.parse();

            cd = parser.getDocument();

            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(new PDDocument(cd));

            cd.close();

            return doPrivacyCheck(text);

        } catch (Exception e) {
            logger.error("PDF(.pdf) File search Failed", e);
            return false;
        } finally {
            if(cd != null) {
                try {
                    cd.close();
                } catch (IOException e1) {}
            }
            if(fileInput != null) {
                try {
                    fileInput.close();
                } catch (IOException e1) {}
            }
        }
    }

}
