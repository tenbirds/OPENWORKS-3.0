/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.zipcode;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
 *  2012. 5. 11.
 * </pre>
 * @see
 */
@Service("zipcodeService")
public class ZipcodeServiceImpl extends AbstractServiceImpl implements ZipcodeService {

    @Resource
    private ZipcodeDAO dao;

    /**
     * 시도별 시군구목록 조회
     * 
     * @param
     * @return List
     */
    @Override
    @SuppressWarnings("rawtypes")
    public List loadCtg(ZipcodeVO vo) {
        return dao.loadCtg(vo);
    }

    /**
     * 우편번호 목록 조회
     * 
     * @param
     * @return Pager<ZipcodeVO>
     */
    @Override
    public Pager<ZipcodeVO> zipcodeList(ZipcodeVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        List<ZipcodeVO> dataList = null;
        String sidoSigungu = vo.getSidoCd() + vo.getSigunguCd();
        parameterMap.put("q_sidoSigungu", sidoSigungu);

        if(Validate.isEmpty(parameterMap.get("q_searchVal")) == false) {
            dataList = dao.zipcodeList(parameterMap);
            vo.setTotalNum(dao.zipcodeListCount(parameterMap));
        } else {
            dataList = new ArrayList<ZipcodeVO>();
            vo.setTotalNum(dataList.size());
        }

        return new Pager<ZipcodeVO>(dataList, vo);
    }

}
