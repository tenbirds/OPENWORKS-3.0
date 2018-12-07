/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.alarm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.openworks.web.sale.goods.WebGoodsManageVO;

/**
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.7)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 12. 28.    sa   신규 생성
 * </pre>
 * @see
 */

public interface AlarmService {

    public List<AlarmVO> alarmList(AlarmVO vo);
    
    int alarmInsert(AlarmVO vo);
    
    int alarmUpdate(AlarmVO vo);
}
