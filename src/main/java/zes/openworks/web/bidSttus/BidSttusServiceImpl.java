/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bidSttus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.base.vo.BaseVO;
import zes.core.bind.VoBinder;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.web.bid.BidSaasInfoVO;
import zes.openworks.web.bidSttus.vo.BidSttusListVO;
import zes.openworks.web.bidSttus.vo.BidSttusNotifySplyVO;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.myCeart.MyCeartVO;
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.myCeart.vo.MyCeartGoodsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartNotifySplyVO;
import zes.openworks.web.myCeart.vo.MyCeartPaasVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasDVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartTenderVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDdVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;
import zes.openworks.web.wish.myWish.MyWishVO;


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
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */
@Service("BidSttusService")
public class BidSttusServiceImpl extends AbstractServiceImpl implements BidSttusService {

    @Resource BidSttusDAO dao;

    /**
     * (상세정보(견적)요청서 목록)
     * @see zes.openworks.web.bidSttus.BidSttusService#bidSttusList(zes.openworks.web.bidSttus.vo.BidSttusListVO)
     */
    @Override
    public Pager<BidSttusListVO> bidSttusList(BidSttusListVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<BidSttusListVO> dataList = null;

        dataList = dao.bidSttusList(parameterMap);
        vo.setTotalNum(dao.bidSttusListCount(parameterMap));

        return new Pager<BidSttusListVO>(dataList, vo);
    }

    /**
     * (입찰공고 공급자 확인정보 조회)
     * @see zes.openworks.web.bidSttus.BidSttusService#suplerBidSttusInfo(zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO)
     */
    @Override
    public List<SuplerCeartNotifySplyVO> suplerBidSttusInfo(SuplerCeartNotifySplyVO vo) {

        return dao.suplerBidSttusInfo(vo);
    }

    /**
     * (공급자의 서비스 구분에 대한 서비스 목록 조회)
     * @see zes.openworks.web.bidSttus.BidSttusService#suplerServiceList(zes.openworks.web.suplerCeart.vo.SuplerServiceVO)
     */
    @Override
    public List<SuplerServiceVO> suplerServiceList(SuplerServiceVO vo) {

        return dao.suplerServiceList(vo);
    }

    /**
     * (입찰공고 공급자 확인정보 등록)
     * @see zes.openworks.web.bidSttus.BidSttusService##insertNotifySplyAction(zes.openworks.web.bidSttus.vo.BidSttusNotifySplyVO)
     */
    @Override
    public int insertNotifySplyAction(BidSttusNotifySplyVO vo){
        return dao.insertNotifySplyAction(vo);
    }

    /**
     * (입찰공고 공급자 확인정보 수정)
     * @see zes.openworks.web.bidSttus.BidSttusService##updateNotifySplyAction(zes.openworks.web.bidSttus.vo.BidSttusNotifySplyVO)
     */
    @Override
    public int updateNotifySplyAction(BidSttusNotifySplyVO vo){
        return dao.updateNotifySplyAction(vo);
    }
}
