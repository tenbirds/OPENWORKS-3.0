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

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.extractor.XSSFExcelExtractor;

/**
 * MS 오피스 파일중 엑셀 파일(.xlsx)에 대한 개인정보 포함여부를 확인한다.
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
public class PrivacyXlsxFileFilter extends AbstractPrivacyFilter implements PrivacyFilter {

    public PrivacyXlsxFileFilter(File file) throws Exception {
        this.file = file;
    }

    /*
     * 엑셀 파일내에서 개인정보를 포함한 셀 값이 있는지 여부를 확인
     * @see
     * zes.base.privacy.PrivacyFilter#doFilter(java.lang.String)
     */
    @Override
    public boolean doFilter() {

        FileInputStream fileInput = null;

        try {
            fileInput = new FileInputStream(this.file);
            OPCPackage pkg = OPCPackage.open(fileInput);

            XSSFExcelExtractor xe = new XSSFExcelExtractor(pkg);
            xe.setFormulasNotResults(true);
            xe.setIncludeSheetNames(true);

            return doPrivacyCheck(xe.getText());

        } catch (Exception e) {
            logger.error("MS Excel(.xlsx) File search Failed", e);
            return false;
        } finally {
            if(fileInput != null) {
                try {
                    fileInput.close();
                } catch (Exception e) {}
            }
        }

    }
}
