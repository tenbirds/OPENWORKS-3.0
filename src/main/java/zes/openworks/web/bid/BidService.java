/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bid;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import zes.base.pager.Pager;
import zes.base.vo.BaseVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO;


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
public interface BidService {

    /**
     * selectBidNotifySeqAction (입찰공고정보 공고차수 채번)
     * @param vo
     * @return
     */
    int selectBidNotifySeqAction(TcnBidNotifyVO tcnBidNotifyVO);
    
    /**
     * insertBidNotifyAction (입찰공고정보 등록)
     * @param vo
     * @return
     */
    int insertBidNotifyAction(TcnBidNotifyVO tcnBidNotifyVO);

    /**
     * updateBidNotifyAction (입찰공고정보 수정)
     * @param vo
     * @return
     */
    int updateBidNotifyAction(TcnBidNotifyVO tcnBidNotifyVO);

    /**
     * insertNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * @param vo
     * @return
     */
    int insertNotifySplyAction(TcnBidNotifyVO tcnBidNotifyVO);

    /**
     * insertBidSaasAction (입찰공고 SaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBidSaasAction(BidSaasInfoVO bidSaasInfoVO);

    /**
     * insertBidSaas2Action (입찰공고 SaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBidSaas2Action(BidSaas2InfoVO bidSaas2InfoVO);

    /**
     * updateBidSaasAction (입찰공고 SaaS 정보 수정)
     * @param vo
     * @return
     */
    int updateBidSaasAction(BidSaasInfoVO bidSaasInfoVO);

    /**
     * deleteBidSaasDetailAction (입찰공고 SaaS 정보 삭제)
     * @param vo
     * @return
     */
    int deleteBidSaasDetailAction(BidSaasInfoVO bidSaasInfoVO);
    
    /**
     * insertBidSaasDetailAction (입찰공고 SaaS 상세정보 등록)
     * @param vo
     * @return
     */
    int insertBidSaasDetailAction(HashMap map);
    
    /**
     * insertBidSaas2NeedAction (입찰공고 SaaS2 필요정보 등록)
     * @param vo
     * @return
     */
    int insertBidSaas2NeedAction(HashMap map);
    
    /**
     * selectBidSaas2DnSeq (입찰공고 SaaS2 필요정보 Seq)
     * @param paramMap1
     * @return
     */
    int selectBidSaas2NeedSeq(HashMap<String, Object> paramMap1);
    
    /**
     * insertBidSaas2OptionAction (입찰공고 SaaS2 옵션정보 등록)
     * @param vo
     * @return
     */
    int insertBidSaas2OptionAction(HashMap map);

    /**
     * insertBidIaasAction (입찰공고 IaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBidIaasAction(BidIaasInfoVO bidIaasInfoVO);

    /**
     * insertBidIaas2Action (입찰공고 IaaS2 정보 등록)
     * @param vo
     * @return
     */
    int insertBidIaas2Action(BidIaas2InfoVO bidIaas2InfoVO);

    /**
     * updateBidIaasAction (입찰공고 IaaS 정보 수정)
     * @param vo
     * @return
     */
    int updateBidIaasAction(BidIaasInfoVO bidIaasInfoVO);

    /**
     * insertBidIaasServerAction (입찰공고 IaaS 상세정보(서버) 등록)
     * @param vo
     * @return
     */
    int insertBidIaasServerAction(HashMap map);

    /**
     * insertBidIaas2ServerAction (입찰공고 IaaS2 상세정보(서버) 등록)
     * @param vo
     * @return
     */
    int insertBidIaas2ServerAction(HashMap map);

    /**
     * deleteBidIaasServerAction (입찰공고 IaaS 상세정보(서버) 삭제)
     * @param vo
     * @return
     */
    int deleteBidIaasServerAction(HashMap map);
    
    /**
     * insertBidIaasDbAction (입찰공고 IaaS 상세정보(DB) 등록)
     * @param vo
     * @return
     */
    int insertBidIaasDbAction(HashMap map);
    
    /**
     * insertBidIaas2DbAction (입찰공고 IaaS2 상세정보(DB) 등록)
     * @param vo
     * @return
     */
    int insertBidIaas2DbAction(HashMap map);

    /**
     * deleteBidIaasDbAction (입찰공고 IaaS 상세정보(DB) 삭제)
     * @param vo
     * @return
     */
    int deleteBidIaasDbAction(HashMap map);

    /**
     * insertBidPaasAction (입찰공고 PaaS 정보 등록)
     * @param vo
     * @return
     */
    int insertBidPaasAction(BidPaasInfoVO bidPaasInfoVO);

    /**
     * insertBidPaas2Action (입찰공고 PaaS2 정보 등록)
     * @param vo
     * @return
     */
    int insertBidPaas2Action(BidPaas2InfoVO bidPaas2InfoVO);

    /**
     * updateBidPaasAction (입찰공고 PaaS 정보 수정)
     * @param vo
     * @return
     */
    int updateBidPaasAction(BidPaasInfoVO bidPaasInfoVO);

    /**
     * tcnBidNotifyInfo (입찰공고 상세정보 조회)
     * @param vo
     * @return
     */
    Map<String, Object> tcnBidNotifyInfo(TcnBidNotifyVO tcnBidNotifyVO);

    /**
     * selectSuplerList (공고현황 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    List<BidSuplerListVO> selectSuplerList(BidSuplerListVO vo);
}
