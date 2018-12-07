/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.introduction;

import java.util.List;

import zes.base.pager.Pager;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 3. 7.    이홍석       신규
 *</pre>
 * @see
 */
public interface IntroductionService 
{
    /**
     * 협약기업정보 리스트 _ 페이지 단위
     * @return
     */
    public Pager<AgremManageVO> agremManage(AgremManageVO vo);

    /**
     * 총서비스 갯수
     * @param vo 
     * @return
     */
    public int totalService(AgremManageVO vo);

    /**
     * 서비스(상품) 목록
     * @param vo
     * @return
     */
    public List<AgremManageServiceVO> listService(AgremManageServiceVO vo);

    /**
     * getServiceNum 설명
     * @param vo
     * @return
     */
    public int getServiceNum(AgremManageServiceVO vo);

}
