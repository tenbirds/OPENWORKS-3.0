/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandManage;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.web.dmandExamin.DmandExaminVO;


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
* 2017. 09. 07.   손은국   신규
*</pre>
* @see
*/

public interface DmandManageService {

    /**
     * 수요조사 목록
     * @param vo
     * @return
     */
    Pager<DmandManageVO> dmandManageList(DmandManageVO vo);
    Pager<DmandManageVO> dmandManageList2018(DmandManageVO vo);    

    /**
     * 제출현황 목록
     * @param vo
     * @return
     */
    Pager<DmandManageVO> dmandPresentnList(DmandManageVO vo);
    Pager<DmandManageVO> dmandPresentnList2018(DmandManageVO vo);    

    /**
     * 제출현황 목록
     * @param vo
     * @return
     */
    List<DmandManageVO> dmandPresentnUnsubMission(DmandManageVO vo);
    List<DmandManageVO> dmandPresentnUnsubMission2018(DmandManageVO vo);

    /**
     * 수요통계(요약) 목록
     * @param vo
     * @return
     */
    Pager<DmandManageVO> dmandStatsList(DmandManageVO vo);
    /**
     * 수요통계(기관유형) 목록
     * @param vo
     * @return
     */
    Pager<DmandManageVO> dmandNsttList(DmandManageVO vo);
    /**
     * 제출현황 전체 갯수
     * @param vo
     * @return
     */
    List<DmandManageVO> presentnTotalCount(DmandManageVO vo);
    List<DmandManageVO> presentnTotalCount2018(DmandManageVO vo);    
    
    /**
     * 수요조사 기간 추출
     * @param vo
     * @return
     */
    List<DmandManageVO> dmandRegustMngr(DmandManageVO vo);
}
