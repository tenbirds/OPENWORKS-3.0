/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.privacy;

/**
 * 단순 문자열에서 개인정보 포함 여부 확인
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
public class PrivacyStringFilter extends AbstractPrivacyFilter implements PrivacyFilter {

    public PrivacyStringFilter(String content) {
        this.content = content;
    }

    /*
     * 단순 문자열내에 개인정보가 포함되어있는지 검사
     * @see zes.base.privacy.PrivacyFilter#doFilter()
     */
    @Override
    public boolean doFilter() {

        return doPrivacyCheck(this.content);
    }

}
