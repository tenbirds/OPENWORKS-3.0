/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.zipcode;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class ZipcodeDAO extends EgovAbstractMapper {

    /**
     * 시도별 시군구목록 조회
     * 
     * @param
     * @return List<ZipcodeVO>
     */
    @SuppressWarnings("rawtypes")
    public List loadCtg(ZipcodeVO vo) {

        return list("_zipcode.ctgList", vo);
    }

    /**
     * 우편번호 목록 조회
     * 
     * @param
     * @return List<ZipcodeVO>
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<ZipcodeVO> zipcodeList(Map parameterMap) {

        return list("_zipcode.zipcodeList", parameterMap);
    }

    /**
     * 우편번호 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int zipcodeListCount(Map parameterMap) {
        return (Integer) selectByPk("_zipcode.zipcodeListCount", parameterMap);
    }

}
