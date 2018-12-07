/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCertif;

import zes.base.pager.Pager;


public interface MyCertifService {

    
    /**
     * certifRequList (이용실적증명서 발급 신청을 위한 이용실적 내역 조회)
     * @param vo
     * @return
     */
    Pager<MyCertifGoodsVO> certifRequList(MyCertifGoodsVO vo);
    
    /**
     * certifApplyList (이용실적증명서 발급 신청 조회)
     * @param vo
     * @return
     */
    Pager<MyCertifApplyVO> certifApplyList(MyCertifApplyVO vo);
    
    
    /**
     * certifRequInsertAction (이용실적증명서 발급 신청 등록)
     * @param vo
     * @return
     */
    int certifRequInsertAction(MyCertifApplyVO vo);
    
    /**
     * certifApplyDetail (이용실적증명서 발급 신청 상세내용)
     * @param vo
     * @return
     */
    MyCertifApplyVO certifApplyDetail(MyCertifApplyVO vo);
    
    /**
     * certifApplyList (이용실적증명서 발급 신청 조회)
     * @param vo
     * @return
     */
    Pager<MyCertifGoodsVO> certifApplyGoodsList(MyCertifGoodsVO vo);
}
