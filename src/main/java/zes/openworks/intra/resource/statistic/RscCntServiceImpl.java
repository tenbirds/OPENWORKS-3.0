/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.resource.statistic;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

// import org.eclipse.jetty.util.log.Log;

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
@Service("rscCntService")
public class RscCntServiceImpl extends BaseServiceImpl implements RscCntService {

    @Resource
    private RscCntDAO dao;

    @Override
    public List<RscCntResultVO> getResourceFieldStatistic(RscCntSearchVO vo) {

        defaultSearchDate(vo);

        // Log.info(":>>>>>>>>>111111>>>!!!!!!!!!!!!~~~~~~~getStartDateFmt~~~"+vo.getStartDateFmt());
        // Log.info(":>>>>>>>>>>22222222>>!!!!!!!!!!!!~~~~~~~getEndDateFmt~~~"+vo.getEndDateFmt());
        List<RscCntResultVO> list1 = dao.getResourceFieldStatistic(vo);
        return list1;
    }

    @Override
    public List<RscCntResultVO> getResourceThemeStatistic(RscCntSearchVO vo) {

        defaultSearchDate(vo);

        // Log.info(":>>>>>>>>>111111>>>!!!!!!!!!!!!~~~~~~~getPrvCode~~~"+vo.getPrvCode());
        // Log.info(":>>>>>>>>>>22222222>>!!!!!!!!!!!!~~~~~~~getEndDateFmt~~~"+vo.getEndDateFmt());
        List<RscCntResultVO> list1 = dao.getResourceThemeStatistic(vo);
        return list1;
    }

    @Override
    public List<RscCntResultVO> getResourceFieldStatisticChart(RscCntResultVO vo, RscCntResultVO sumVo) {

        // defaultSearchDate(vo);
        vo.setValue(sumVo.getValue());
        List<RscCntResultVO> list1 = dao.getResourceFieldStatisticChart(vo);
        if(list1.size() > 7) {
            list1.remove(list1.size() - 1);
            RscCntResultVO etcVo = new RscCntResultVO();
            int tempValue = 0;
            float tempRate = 0.0f;
            for(RscCntResultVO _vo : list1) {
                tempValue += _vo.getValue();
                tempRate += _vo.getRateValue();
            }
            etcVo.setTitle("기타");
            etcVo.setValue(sumVo.getValue() - tempValue);
            etcVo.setRateValue(Math.round((100 - tempRate) * 100) / 100.0f);

            list1.add(etcVo);
        }

        return list1;
    }

    @Override
    public RscCntResultVO getResourceFieldStatisticCnt(RscCntResultVO vo) {

        defaultSearchDate(vo);
        // defaultPagingData(vo);

        return dao.getResourceFieldStatisticCnt(vo);

    }

    @Override
    public List<RscCntResultVO> getResourceUserStatistic(RscCntSearchVO vo) {
        defaultSearchDate(vo);
        List<RscCntResultVO> list1 = dao.getResourceUserStatistic(vo);
        return list1;

    }

    @Override
    public List<RscCntResultVO> getResourceUserStatisticPersonal(RscCntSearchVO vo) {
        defaultSearchDate(vo);
        List<RscCntResultVO> list1 = dao.getResourceUserStatisticPersonal(vo);
        return list1;
    }

    @Override
    public List<RscCntResultVO> getOpCodeList(RscCntSearchVO vo) {

        List<RscCntResultVO> list1 = dao.getOpCodeList(vo);
        return list1;

    }
}
