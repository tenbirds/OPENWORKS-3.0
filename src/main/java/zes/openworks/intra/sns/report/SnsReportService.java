/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.sns.report;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 4. 29.    구선모   셍성
 * </pre>
 * @see
 */
public interface SnsReportService {

    /**
     * snsReportList 설명
     * 
     * @param vo
     * @return
     */
    Pager<SnsReportVO> snsReportList(SnsReportVO vo);

    /**
     * snsReportDelUpdate 설명
     * 
     * @param vo
     * @return
     */
    int snsReportDelUpdate(HttpServletRequest request, String userId);

    /**
     * getMenuCodeList 설명
     * 
     * @param vo
     * @return
     */
    List<SnsReportVO> getMenuCodeList(SnsReportVO vo);
}
