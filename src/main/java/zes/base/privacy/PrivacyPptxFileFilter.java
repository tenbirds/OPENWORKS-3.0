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
import org.apache.poi.xslf.extractor.XSLFPowerPointExtractor;

/**
 * MS 오피스 파일중 Power Point 파일(pptx 확장자)에 대한 개인정보 포함여부를 확인한다.
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
public class PrivacyPptxFileFilter extends AbstractPrivacyFilter implements PrivacyFilter {

    public PrivacyPptxFileFilter(File file) throws Exception {
        this.file = file;
    }

    /*
     * Power Point 파일내에서 개인정보를 포함한 값이 있는지 여부를 확인
     * @see
     * zes.base.privacy.PrivacyFilter#doFilter(java.lang.String)
     */
    @Override
    public boolean doFilter() {

        FileInputStream fileInput = null;

        try {
            fileInput = new FileInputStream(this.file);
            OPCPackage pkg = OPCPackage.open(fileInput);

            XSLFPowerPointExtractor pe = new XSLFPowerPointExtractor(pkg);

            return doPrivacyCheck(pe.getText());

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
