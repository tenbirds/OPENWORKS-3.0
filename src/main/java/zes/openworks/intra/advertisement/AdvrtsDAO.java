/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.advertisement;

import java.util.List;
import org.springframework.stereotype.Repository;
import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 7.    김영상       신규
 *</pre>
 * @see
 */
@Repository
public class AdvrtsDAO extends EgovAbstractMapper {
    /**
     * 광고주정보 목록
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<AdvrtsVO> advrtsList(AdvrtsVO vo) {

        List<AdvrtsVO> dataList = list("_advtsm.list", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_advtsm.listCount", vo.getDataMap()));
        return new Pager<AdvrtsVO>(dataList, vo);
    }

    /**
     * 광고주정보 등록
     * 
     * @param vo
     * @return
     */
    public int advrtsInsert(AdvrtsVO vo) {

        return insert("_advtsm.advtsmInsert", vo);
    }

    /**
     * 광고주정보 수정
     * 
     * @param vo
     * @return
     */
    public int advrtsUpdate(AdvrtsVO vo) {

        return update("_advtsm.advtsmUpdate", vo);
    }

    /**
     * 광고주정보 조회
     * 
     * @param vo
     * @return
     */
    public AdvrtsVO advrtsUpdateForm(AdvrtsVO vo) {

        return (AdvrtsVO) selectByPk("_advtsm.updateForm", vo);
    }
    
    /**
     * 광고주 사용/미사용 처리
     * 
     * @param vo
     * @return
     */
    public int advrtsDelete(AdvrtsVO vo) {

        return delete("_advtsm.advtsmDelUpdate", vo);
    }
}
