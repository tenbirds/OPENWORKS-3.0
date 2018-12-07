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

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

/**
 * MS 오피스 파일중 워드 파일(doc 확장자)에 대한 개인정보 포함여부를 확인한다.
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
public class PrivacyDocFileFilter extends AbstractPrivacyFilter implements PrivacyFilter {

    public PrivacyDocFileFilter(File file) {
        this.file = file;
    }

    /*
     * 워드 파일내에서 개인정보를 포함한 값이 있는지 여부를 확인
     * @see zes.base.privacy.PrivacyFilter#doFilter()
     */
    @Override
    public boolean doFilter() {

        FileInputStream fileInput = null;
        try {
            fileInput = new FileInputStream(this.file);
            POIFSFileSystem fileSystem = new POIFSFileSystem(fileInput);

            HWPFDocument doc = new HWPFDocument(fileSystem);
            WordExtractor we = new WordExtractor(doc);

            return doPrivacyCheck(we.getText());

        } catch (Exception e) {
            logger.error("MS World File search Failed", e);
            return false;
        } finally {
            if(fileInput != null) {
                try {
                    fileInput.close();
                } catch (IOException e1) {
                    logger.error("MS World File search Failed", e1);
                }
            }
        }
    }
}
