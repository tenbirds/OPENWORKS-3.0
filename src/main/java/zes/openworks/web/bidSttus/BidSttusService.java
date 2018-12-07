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

import zes.base.pager.Pager;
import zes.base.vo.BaseVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.web.bidSttus.vo.BidSttusListVO;
import zes.openworks.web.bidSttus.vo.BidSttusNotifySplyVO;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.issue.IssueVO;
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
public interface BidSttusService {

    /**
     * bidSttusList (입찰공고 현황 리스트 조회)
     * @param vo
     * @return
     */
    Pager<BidSttusListVO> bidSttusList(BidSttusListVO vo);

    /**
     * suplerBidSttusInfo (공고현황 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<SuplerCeartNotifySplyVO> suplerBidSttusInfo(SuplerCeartNotifySplyVO vo);

    /**
     * suplerServiceList (공급자의 서비스 구분에 대한 서비스 목록 조회)
     * @param vo
     * @return
     */
    List<SuplerServiceVO> suplerServiceList(SuplerServiceVO vo);

    /**
     * insertNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * @param vo
     * @return
     */
    int insertNotifySplyAction(BidSttusNotifySplyVO vo);

    /**
     * updateNotifySplyAction (입찰공고 공급자 확인정보 수정)
     * @param vo
     * @return
     */
    int updateNotifySplyAction(BidSttusNotifySplyVO vo);
}
