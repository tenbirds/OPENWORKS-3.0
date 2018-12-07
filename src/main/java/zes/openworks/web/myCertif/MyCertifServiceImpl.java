/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCertif;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.bind.VoBinder;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 11. 24.    SKYOU      신규
 *</pre>
 * @see
 */
@Service("MyCertifService")
public class MyCertifServiceImpl extends AbstractServiceImpl implements MyCertifService {

    @Resource MyCertifDAO dao;

    /* 이용실적 내역조회
     * @see zes.openworks.web.myCertif.MyCertifService#certifRequList(zes.openworks.web.myCertif.MyCertifVO)
     */
    @Override
    public Pager<MyCertifGoodsVO> certifRequList(MyCertifGoodsVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCertifGoodsVO> dataList = null;
        if(vo.getCntrctSvcSns() != null && vo.getCntrctSvcSns().length > 0) {
            parameterMap.put("cntrctSvcSns", vo.getCntrctSvcSns());
        }
        
        
        dataList  = dao.certifRequList(parameterMap);
        vo.setTotalNum(dao.certifRequListCount(parameterMap));
        
        return new Pager<MyCertifGoodsVO>(dataList, vo);
    }

    /* 이용실적증명서 발급 조회
     * @see zes.openworks.web.myCertif.MyCertifService#certifApplyList(zes.openworks.web.myCertif.MyCertifApplyVO)
     */
    @Override
    public Pager<MyCertifApplyVO> certifApplyList(MyCertifApplyVO vo) {
        // TODO Auto-generated method stub
        
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<MyCertifApplyVO> dataList = dao.certifApplyList(parameterMap);
        vo.setTotalNum(dao.certifApplyListCount(parameterMap));

        return new Pager<MyCertifApplyVO>(dataList, vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCertif.MyCertifService#certifRequInsertAction(zes.openworks.intra.orderManage.cntrctManage.CntrctManageVO)
     */
    @Override
    public int certifRequInsertAction(MyCertifApplyVO vo) {
        // TODO Auto-generated method stub
        return dao.certifRequInsertAction(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCertif.MyCertifService#certifApplyDetail(zes.openworks.web.myCertif.MyCertifApplyVO)
     */
    @Override
    public MyCertifApplyVO certifApplyDetail(MyCertifApplyVO vo) {
        // TODO Auto-generated method stub
        return dao.certifApplyDetail(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.myCertif.MyCertifService#certifApplyGoodsList(zes.openworks.web.myCertif.MyCertifApplyVO)
     */
    @Override
    public Pager<MyCertifGoodsVO> certifApplyGoodsList(MyCertifGoodsVO vo) {
        // TODO Auto-generated method stub
       // Map<String, Object> parameterMap = vo.getDataMap();
       // VoBinder.methodBind(parameterMap, vo);
        List<MyCertifGoodsVO> dataList = null;
        dataList = dao.certifApplyGoodsList(vo);
        vo.setTotalNum(dao.certifApplyGoodsListCount(vo));
        return new Pager<MyCertifGoodsVO>(dataList,vo);
    }
    
    
    
}
