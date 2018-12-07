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

/**
 * 텍스트(.txt) 파일 내에 개인정보가 포함되어 있는지를 확인
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
public class PrivacyTxtFileFilter extends AbstractPrivacyFilter implements PrivacyFilter {

    public PrivacyTxtFileFilter(File file) {
        this.file = file;
    }

    /*
     * 텍스트 파일내에서 개인정보를 포함한 값이 있는지 여부를 확인
     * @see zes.base.privacy.PrivacyFilter#doFilter()
     */
    @Override
    public boolean doFilter() {

        FileInputStream fileInput = null;

        try {
            fileInput = new FileInputStream(this.file);

            int size = fileInput.available();
            byte input[] = new byte[size];

            String str = null;
            while(fileInput.read(input) > -1) {
                str = new String(input);
            }

            return doPrivacyCheck(str);
        } catch (Exception e) {

        } finally {
            if(fileInput != null) {
                try {
                    fileInput.close();
                } catch (IOException e1) {}
            }
        }

        return false;
    }

}
