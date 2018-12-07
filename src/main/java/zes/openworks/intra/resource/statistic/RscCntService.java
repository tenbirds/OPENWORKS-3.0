/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.resource.statistic;

import java.util.List;

/**
 * @version 1.0
 * @since openworks-openapi 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 5. 2.    boseok   신규 생성
 * </pre>
 * @see
 */
public interface RscCntService {

    List<RscCntResultVO> getResourceFieldStatistic(RscCntSearchVO vo);

    List<RscCntResultVO> getResourceThemeStatistic(RscCntSearchVO vo);

    List<RscCntResultVO> getResourceFieldStatisticChart(RscCntResultVO vo, RscCntResultVO sumVo);

    RscCntResultVO getResourceFieldStatisticCnt(RscCntResultVO vo);

    List<RscCntResultVO> getResourceUserStatistic(RscCntSearchVO vo);

    List<RscCntResultVO> getResourceUserStatisticPersonal(RscCntSearchVO vo);

    List<RscCntResultVO> getOpCodeList(RscCntSearchVO vo);
}
