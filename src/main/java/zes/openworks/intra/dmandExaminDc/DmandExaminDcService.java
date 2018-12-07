/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDc;

import java.util.List;

import zes.base.pager.Pager;


/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2016. 10. 01.   최강식   신규
*</pre>
* @see
*/

public interface DmandExaminDcService {

    /**
     * 설명회 신청 목록
     * @param vo
     * @return
     */
    Pager<DmandExaminDcVO> dmandExaminDcList(DmandExaminDcVO vo);

    /**
     * 엑셀 다운로드
     * @param vo
     * @return
     */
    List<DmandExaminDcVO> dmandExaminDcListExcel(DmandExaminDcVO vo);

}
