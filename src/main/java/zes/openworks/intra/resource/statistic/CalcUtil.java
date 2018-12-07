/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.resource.statistic;

import java.util.ArrayList;
import java.util.List;

// import org.eclipse.jetty.util.log.Log;

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
 *  2012. 5. 17.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CalcUtil {

    public static float getRateValue(int val1, int val2) {

        return getRateValue((float) val1, (float) val2);

    }

    public static float getRateValue(float val1, float val2) {

        val2 = (val2 != 0) ? val2 : 1;

        return Math.round(val1 / val2 * 10000) / 100.0f;
    }

    public static void getRateList(List<RscCntResultVO> list, RscCntResultVO sumVO) {
        for(RscCntResultVO _vo : list) {
            if(_vo != null && sumVO != null && _vo.getValue() != null) {
                _vo.setRateValue(getRateValue((float) _vo.getValue(), sumVO.getValue()));
                _vo.setRateMobileValue(getRateValue((float) _vo.getMobileValue(), sumVO.getMobileValue()));
            }
        }
    }

    /**
     * 합계값 계산
     * setSumValues 설명
     * 
     * @param sourceList
     * @return
     */
    public static RscCntResultVO setSumValues(List<RscCntResultVO> sourceList) {

        if(sourceList.size() == 0) {
            return null;
        }

        RscCntResultVO vo = new RscCntResultVO();
        List<Integer> values = new ArrayList<Integer>(sourceList.get(0).getValues().size());
        List<Integer> mobileValues = new ArrayList<Integer>(sourceList.get(0).getMobileValues().size());

        for(int i = 0 ; i < sourceList.size() ; i++) {
            RscCntResultVO _vo = sourceList.get(i);

            vo.setValue(vo.getValue() + _vo.getValue());
            vo.setMobileValue(vo.getMobileValue() + _vo.getMobileValue());
            vo.setValue2(vo.getValue2() + _vo.getValue2());
            vo.setMobileValue2(vo.getMobileValue2() + _vo.getMobileValue2());
            vo.setValue3(vo.getValue3() + _vo.getValue3());
            vo.setMobileValue3(vo.getMobileValue3() + _vo.getMobileValue3());
            vo.setValue4(vo.getValue4() + _vo.getValue4());
            vo.setMobileValue4(vo.getMobileValue4() + _vo.getMobileValue4());
            vo.setValue5(vo.getValue5() + _vo.getValue5());
            vo.setMobileValue5(vo.getMobileValue5() + _vo.getMobileValue5());

            for(int x = 0 ; x < _vo.getValues().size() ; x++) {

                if(i == 0) {
                    values.add(x, _vo.getValues().get(x));
                    mobileValues.add(x, _vo.getMobileValues().get(x));
                } else {
                    values.set(x, values.get(x) + _vo.getValues().get(x));
                    mobileValues.set(x, mobileValues.get(x) + _vo.getMobileValues().get(x));
                }
            }

        }
        vo.setValues(values);
        vo.setMobileValues(mobileValues);
        return vo;
    }

    /**
     * 합계의 증감 계산
     * 
     * @param vo
     * @param idx values값 중에 증감을 계산할 항목의 index
     */
    public static void setSumValuesVariation(RscCntResultVO vo, int idx) {
        vo.setVariation(vo.getValue() - vo.getValues().get(idx));
        vo.setMobileVariation(vo.getMobileValue() - vo.getMobileValues().get(idx));
    }
}
