/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.privacy;

/**
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
public interface PrivacyFilter {

    /**
     * 개인정보가 존재하는지 필터링 한다.
     * 실제 문자열 또는 파일명 등 개인정보 필터링 대상을 설정한다.
     * 
     * @param cont 개인정보 조회대상 문자열
     * @return
     */
    public boolean doFilter();

}
