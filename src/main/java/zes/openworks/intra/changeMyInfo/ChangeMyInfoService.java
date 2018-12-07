/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.changeMyInfo;

import java.util.List;

import zes.openworks.intra.mgr.MgrVO;


/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 10.    김영상       신규
 *</pre>
 * @see
 */
public interface ChangeMyInfoService {
    
    /**
     * 나의 정보 상세 조회
     */
    MgrVO viewMyInfo(MgrVO vo);

    /**
     * 나의 정보 수정 액션
     */
    int updateMyInfo(MgrVO vo);

    /**
     * 나의 비밀번호 수정 액션
     */
    int updateMyPwd(MgrVO vo);

    /**
     * 담당자 정보 아이디로 권한코드,권한명,권한타입코드 가져오기
     */
    List<MgrVO> currentlyList(MgrVO vo);
}
