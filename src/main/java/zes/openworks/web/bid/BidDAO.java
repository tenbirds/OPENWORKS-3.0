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

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.openworks.component.file.FileDAO;


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
@Repository
@SuppressWarnings("unchecked")
public class BidDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    /**
     * selectBidNotifySeqAction (입찰공고정보 공고차수 채번)
     * @param tcnBidNotifyVO
     * @return int
     */
    public int selectBidNotifySeqAction(TcnBidNotifyVO tcnBidNotifyVO) {
        return (Integer) selectByPk("_bid.selectBidNotifySeq", tcnBidNotifyVO);
    }


    /**
     * insertBidNotifyAction (입찰공고정보 등록)
     * @param tcnBidNotifyVO
     * @return int
     */
    public int insertBidNotifyAction(TcnBidNotifyVO tcnBidNotifyVO) {
        // 첨부파일
        if(tcnBidNotifyVO.getDelyFileList() != null && tcnBidNotifyVO.getDelyFileList().size() > 0) {
            tcnBidNotifyVO.setDelyFile(fileDao.saveFile(tcnBidNotifyVO.getDelyFileList(), tcnBidNotifyVO.getDelyFile()));
        }
        // 첨부파일
        if(tcnBidNotifyVO.getOptlCntrFileList() != null && tcnBidNotifyVO.getOptlCntrFileList().size() > 0) {
            tcnBidNotifyVO.setOptlCntrFile(fileDao.saveFile(tcnBidNotifyVO.getOptlCntrFileList(), tcnBidNotifyVO.getOptlCntrFile()));
        }
        
        return insert("_bid.insertBidNotify", tcnBidNotifyVO);
    }

    /**
     * updateBidNotifyAction (입찰공고정보 수정)
     * @param tcnBidNotifyVO
     * @return int
     */
    public int updateBidNotifyAction(TcnBidNotifyVO tcnBidNotifyVO) {
        // 첨부파일 - 납품 첨부 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(tcnBidNotifyVO.getDelyFileList() != null && tcnBidNotifyVO.getDelyFileList().size() > 0) {
            if(tcnBidNotifyVO.getDelyFile() == 0){
                tcnBidNotifyVO.setDelyFile(fileDao.saveFile(tcnBidNotifyVO.getDelyFileList(), tcnBidNotifyVO.getDelyFile()));
            }
        }

        // 첨부파일 - 수의계약 첨부 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(tcnBidNotifyVO.getOptlCntrFileList() != null && tcnBidNotifyVO.getOptlCntrFileList().size() > 0) {
            if(tcnBidNotifyVO.getOptlCntrFile() == 0){
                tcnBidNotifyVO.setOptlCntrFile(fileDao.saveFile(tcnBidNotifyVO.getOptlCntrFileList(), tcnBidNotifyVO.getOptlCntrFile()));  
            }            
        }
        return update("_bid.updateBidNotify", tcnBidNotifyVO);
    }

    /**
     * insertNotifySplyAction (입찰공고 공급자 확인정보 등록)
     * @param tcnBidNotifyVO
     * @return int
     */
    public int insertNotifySplyAction(TcnBidNotifyVO tcnBidNotifyVO) {
        return insert("_bid.insertNotifySply", tcnBidNotifyVO);
    }

    /**
     * insertBidSaasAction (입찰공고 SaaS 정보 등록)
     * @param bidSaasInfoVO
     * @return int
     */
    public int insertBidSaasAction(BidSaasInfoVO bidSaasInfoVO) {
        return insert("_bid.insertBidSaas", bidSaasInfoVO);
    }

    /**
     * insertBidSaas2Action (입찰공고 SaaS2 정보 등록)
     * @param bidSaas2InfoVO
     * @return int
     */
    public int insertBidSaas2Action(BidSaas2InfoVO bidSaas2InfoVO) {
        return insert("_bid.insertBidSaas2", bidSaas2InfoVO);
    }

    /**
     * updateBidSaasAction (입찰공고 SaaS 정보 수정)
     * @param bidSaasInfoVO
     * @return int
     */
    public int updateBidSaasAction(BidSaasInfoVO bidSaasInfoVO) {
        return update("_bid.updateBidSaas", bidSaasInfoVO);
    }

    /**
     * deleteBidSaasDetailAction (입찰공고 SaaS 정보 삭제)
     * @param bidSaasInfoVO
     * @return int
     */
    public int deleteBidSaasDetailAction(BidSaasInfoVO bidSaasInfoVO) {
        return update("_bid.deleteBidSaasDetail", bidSaasInfoVO);
    }

    /**
     * insertBidSaasDetailAction (입찰공고 SaaS 상세정보 등록)
     * @param HashMap
     * @return int
     */
    public int insertBidSaasDetailAction(HashMap map) {
        return insert("_bid.insertBidSaasDetail", map);
    }
    
    /**
     * insertBidSaas2NeedAction (입찰공고 SaaS2 필요정보 등록)
     * @param paramMap1
     * @return
     */
    public int insertBidSaas2NeedAction(HashMap<String, Object> paramMap1) {
        return insert("_bid.insertBidSaas2Need", paramMap1);
    }

    /**
     * selectBidSaas2NeedSeq (입찰공고 SaaS2 필요정보 Seq)
     * @param paramMap1
     * @return
     */
    public int selectBidSaas2NeedSeq(HashMap<String, Object> paramMap1) {
        return (Integer) selectByPk("_bid.selectBidSaas2NeedSeq", paramMap1);
    }

    /**
     * insertBidSaas2OptionAction (입찰공고 SaaS2 옵션정보 등록)
     * @param paramMap2
     * @return
     */
    public int insertBidSaas2OptionAction(HashMap<String, Object> paramMap2) {
        return insert("_bid.insertBidSaas2Option", paramMap2);
    }

    /**
     * insertBidIaasAction (입찰공고 IaaS 정보 등록)
     * @param bidIaasInfoVO
     * @return int
     */
    public int insertBidIaasAction(BidIaasInfoVO bidIaasInfoVO) {
        return insert("_bid.insertBidIaas", bidIaasInfoVO);
    }

    /**
     * insertBidIaas2Action (입찰공고 IaaS2 정보 등록)
     * @param bidIaas2InfoVO
     * @return int
     */
    public int insertBidIaas2Action(BidIaas2InfoVO bidIaas2InfoVO) {
        return insert("_bid.insertBidIaas2", bidIaas2InfoVO);
    }

    /**
     * updateBidIaasAction (입찰공고 IaaS 정보 수정)
     * @param bidIaasInfoVO
     * @return int
     */
    public int updateBidIaasAction(BidIaasInfoVO bidIaasInfoVO) {
        return insert("_bid.updateBidIaas", bidIaasInfoVO);
    }

    /**
     * insertBidIaasServerAction (입찰공고 IaaS 상세정보(서버) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBidIaasServerAction(HashMap map) {
        return insert("_bid.insertBidIaasServer", map);
    }

    /**
     * insertBidIaas2ServerAction (입찰공고 IaaS2 상세정보(서버) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBidIaas2ServerAction(HashMap map) {
        return insert("_bid.insertBidIaas2Server", map);
    }

    /**
     * deleteBidIaasServerAction (입찰공고 IaaS 상세정보(서버) 삭제)
     * @param HashMap
     * @return int
     */
    public int deleteBidIaasServerAction(HashMap map) {
        return update("_bid.deleteBidIaasServer", map);
    }

    /**
     * insertBidIaasDbAction (입찰공고 IaaS 상세정보(DB) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBidIaasDbAction(HashMap map) {
        return insert("_bid.insertBidIaasDb", map);
    }

    /**
     * insertBidIaas2DbAction (입찰공고 IaaS2 상세정보(DB) 등록)
     * @param HashMap
     * @return int
     */
    public int insertBidIaas2DbAction(HashMap map) {
        return insert("_bid.insertBidIaas2Db", map);
    }

    /**
     * deleteBidIaasDbAction (입찰공고 IaaS 상세정보(DB) 삭제)
     * @param HashMap
     * @return int
     */
    public int deleteBidIaasDbAction(HashMap map) {
        return update("_bid.deleteBidIaasDb", map);
    }

    /**
     * insertBidPaasAction (입찰공고 PaaS 정보 등록)
     * @param bidPaasInfoVO
     * @return int
     */
    public int insertBidPaasAction(BidPaasInfoVO bidPaasInfoVO) {
        return insert("_bid.insertBidPaas", bidPaasInfoVO);
    }

    /**
     * insertBidPaas2Action (입찰공고 PaaS2 정보 등록)
     * @param bidPaas2InfoVO
     * @return int
     */
    public int insertBidPaas2Action(BidPaas2InfoVO bidPaas2InfoVO) {
        return insert("_bid.insertBidPaas2", bidPaas2InfoVO);
    }

    /**
     * updateBidPaasAction (입찰공고 PaaS 정보 수정)
     * @param bidPaasInfoVO
     * @return int
     */
    public int updateBidPaasAction(BidPaasInfoVO bidPaasInfoVO) {
        return insert("_bid.updateBidPaas", bidPaasInfoVO);
    }

    /**
     * tcnBidNotifyInfo (입찰공고 상세정보 조회)
     * @param tcnBidNotifyVO
     * @return Map<String, Object>
     */
    public Map<String, Object> tcnBidNotifyInfo(TcnBidNotifyVO tcnBidNotifyVO) {
        return (Map<String, Object>) selectByPk("_bid.tcnBidNotifyInfo", tcnBidNotifyVO);
    }

    /**
     * selectSuplerList (공고현황 공급자 확인정보 조회)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<BidSuplerListVO> selectSuplerList(BidSuplerListVO vo) {
        return list("_bid.selectSuplerList", vo);
    }
}
