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

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */
@Service("BidService")
public class BidServiceImpl extends AbstractServiceImpl implements BidService {

    @Resource BidDAO dao;

    /* (입찰공고정보 공고차수 채번)
     * @see zes.openworks.web.bid.BidService##selectBidNotifySeqAction(zes.openworks.web.bid.TcnBidNotifyVO)
     */
    @Override
    public int selectBidNotifySeqAction(TcnBidNotifyVO tcnBidNotifyVO){
        return dao.selectBidNotifySeqAction(tcnBidNotifyVO);
    }

    /* (입찰공고정보 등록)
     * @see zes.openworks.web.bid.BidService#insertBidNotifyAction(zes.openworks.web.bid.TcnBidNotifyVO)
     */
    @Override
    public int insertBidNotifyAction(TcnBidNotifyVO tcnBidNotifyVO){
        return dao.insertBidNotifyAction(tcnBidNotifyVO);
    }

    /* (입찰공고정보 수정)
     * @see zes.openworks.web.bid.BidService#updateBidNotifyAction(zes.openworks.web.bid.TcnBidNotifyVO)
     */
    @Override
    public int updateBidNotifyAction(TcnBidNotifyVO tcnBidNotifyVO){
        return dao.updateBidNotifyAction(tcnBidNotifyVO);
    }

    /* (입찰공고 공급자 확인정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidNotifyAction(zes.openworks.web.bid.TcnBidNotifyVO)
     */
    @Override
    public int insertNotifySplyAction(TcnBidNotifyVO tcnBidNotifyVO){
        return dao.insertNotifySplyAction(tcnBidNotifyVO);
    }

    /* (입찰공고 SaaS 정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidSaas(zes.openworks.web.bid.BidSaasInfoVO)
     */
    @Override
    public int insertBidSaasAction(BidSaasInfoVO bidSaasInfoVO){
        return dao.insertBidSaasAction(bidSaasInfoVO);
    }
    
    /* (입찰공고 SaaS2 정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidSaas(zes.openworks.web.bid.BidSaasInfoVO)
     */
    @Override
    public int insertBidSaas2Action(BidSaas2InfoVO bidSaas2InfoVO){
        return dao.insertBidSaas2Action(bidSaas2InfoVO);
    }

    /* (입찰공고 SaaS 정보 수정)
     * @see zes.openworks.web.bid.BidService##updateBidSaasAction(zes.openworks.web.bid.BidSaasInfoVO)
     */
    @Override
    public int updateBidSaasAction(BidSaasInfoVO bidSaasInfoVO){
        return dao.updateBidSaasAction(bidSaasInfoVO);
    }

    /* (입찰공고 SaaS 정보 삭제)
     * @see zes.openworks.web.bid.BidService##deleteBidSaasDetailAction(zes.openworks.web.bid.BidSaasInfoVO)
     */
    @Override
    public int deleteBidSaasDetailAction(BidSaasInfoVO bidSaasInfoVO){
        return dao.deleteBidSaasDetailAction(bidSaasInfoVO);
    }

    /* (입찰공고 SaaS 상세정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidSaasDetailAction(HashMap)
     */
    @Override
    public int insertBidSaasDetailAction(HashMap map){
        return dao.insertBidSaasDetailAction(map);
    }

    /* (입찰공고 SaaS2 필요정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidSaasDetailAction(HashMap)
     */
    @Override
    public int insertBidSaas2NeedAction(HashMap map){
        return dao.insertBidSaas2NeedAction(map);
    }
    
    
    /* (입찰공고 SaaS2 필요정보 Seq)
     * @see zes.openworks.web.bid.BidService#selectBidSaas2DnSeq(java.util.HashMap)
     */
    @Override
    public int selectBidSaas2NeedSeq(HashMap<String, Object> paramMap1) {
        return dao.selectBidSaas2NeedSeq(paramMap1);
    }


    /* (입찰공고 SaaS2 옵션정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidSaasDetailAction(HashMap)
     */
    @Override
    public int insertBidSaas2OptionAction(HashMap map){
        return dao.insertBidSaas2OptionAction(map);
    }

    /* (입찰공고 IaaS 정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidIaasAction(zes.openworks.web.bid.BidIaasInfoVO)
     */
    @Override
    public int insertBidIaasAction(BidIaasInfoVO bidIaasInfoVO){
        return dao.insertBidIaasAction(bidIaasInfoVO);
    }

    /* (입찰공고 IaaS2 정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidIaas2Action(zes.openworks.web.bid.BidIaas2InfoVO)
     */
    @Override
    public int insertBidIaas2Action(BidIaas2InfoVO bidIaas2InfoVO){
        return dao.insertBidIaas2Action(bidIaas2InfoVO);
    }

    /* (입찰공고 IaaS 정보 수정)
     * @see zes.openworks.web.bid.BidService##updateBidIaasAction(zes.openworks.web.bid.BidIaasInfoVO)
     */
    @Override
    public int updateBidIaasAction(BidIaasInfoVO bidIaasInfoVO){
        return dao.updateBidIaasAction(bidIaasInfoVO);
    }

    /* (입찰공고 IaaS 상세정보(서버) 등록)
     * @see zes.openworks.web.bid.BidService##insertBidIaasServerAction(HashMap)
     */
    @Override
    public int insertBidIaasServerAction(HashMap map){
        return dao.insertBidIaasServerAction(map);
    }

    /* (입찰공고 IaaS2 상세정보(서버) 등록)
     * @see zes.openworks.web.bid.BidService##insertBidIaas2ServerAction(HashMap)
     */
    @Override
    public int insertBidIaas2ServerAction(HashMap map){
        return dao.insertBidIaas2ServerAction(map);
    }

    /* (입찰공고 IaaS 상세정보(서버) 삭제)
     * @see zes.openworks.web.bid.BidService##deleteBidIaasServerAction(HashMap)
     */
    @Override
    public int deleteBidIaasServerAction(HashMap map){
        return dao.deleteBidIaasServerAction(map);
    }

    /* (입찰공고 IaaS 상세정보(DB) 등록)
     * @see zes.openworks.web.bid.BidService##insertBidIaasDbAction(HashMap)
     */
    @Override
    public int insertBidIaasDbAction(HashMap map){
        return dao.insertBidIaasDbAction(map);
    }

    /* (입찰공고 IaaS2 상세정보(DB) 등록)
     * @see zes.openworks.web.bid.BidService##insertBidIaas2DbAction(HashMap)
     */
    @Override
    public int insertBidIaas2DbAction(HashMap map){
        return dao.insertBidIaas2DbAction(map);
    }

    /* (입찰공고 IaaS 상세정보(DB) 삭제)
     * @see zes.openworks.web.bid.BidService##deleteBidIaasDbAction(HashMap)
     */
    @Override
    public int deleteBidIaasDbAction(HashMap map){
        return dao.deleteBidIaasDbAction(map);
    }

    /* (입찰공고 PaaS 정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidPaasAction(zes.openworks.web.bid.BidPaasInfoVO)
     */
    @Override
    public int insertBidPaasAction(BidPaasInfoVO bidPaasInfoVO){
        return dao.insertBidPaasAction(bidPaasInfoVO);
    }

    /* (입찰공고 PaaS2 정보 등록)
     * @see zes.openworks.web.bid.BidService##insertBidPaas2Action(zes.openworks.web.bid.BidPaas2InfoVO)
     */
    @Override
    public int insertBidPaas2Action(BidPaas2InfoVO bidPaas2InfoVO){
        return dao.insertBidPaas2Action(bidPaas2InfoVO);
    }

    /* (입찰공고 PaaS 정보 수정)
     * @see zes.openworks.web.bid.BidService##updateBidPaasAction(zes.openworks.web.bid.BidPaasInfoVO)
     */
    @Override
    public int updateBidPaasAction(BidPaasInfoVO bidPaasInfoVO){
        return dao.updateBidPaasAction(bidPaasInfoVO);
    }

    /* (입찰공고 상세정보 조회)
     * @see zes.openworks.web.bid.BidService##tcnBidNotifyInfo(zes.openworks.web.bid.TcnBidNotifyVO)
     */
    @Override
    public Map<String, Object> tcnBidNotifyInfo(TcnBidNotifyVO tcnBidNotifyVO){
        return dao.tcnBidNotifyInfo(tcnBidNotifyVO);
    }

    /**
     * (공고현황 공급자 확인정보 조회)
     * @see zes.openworks.web.bid.BidService#selectSuplerList(zes.openworks.web.bid.BidSuplerListVO)
     */
    @Override
    public List<BidSuplerListVO> selectSuplerList(BidSuplerListVO vo) {

        return dao.selectSuplerList(vo);
    }
}
