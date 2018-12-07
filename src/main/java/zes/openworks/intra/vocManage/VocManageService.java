/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.vocManage;

import java.util.List;
import zes.openworks.intra.vocManage.VocManageVO;


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
* 2017. 10. 23.   이준범   신규
*</pre>
* @see
*/

public interface VocManageService {

    /**
     * voc 목록
     * @param vo
     * @return
     */
    List<VocManageVO> vocManageList(VocManageVO vo);
    
    /**
     * voc 상세정보
     * @param vo
     * @return
     */
    List<VocManageVO> vocManageView(VocManageVO vo);
    
}
