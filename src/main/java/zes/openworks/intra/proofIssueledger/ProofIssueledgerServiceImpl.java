/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueledger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 12.    방기배       신규
 *</pre>
 * @see
 */
@Service("ProofIssueledgerService")
public class ProofIssueledgerServiceImpl extends AbstractServiceImpl implements ProofIssueledgerService {

    @Resource
    ProofIssueledgerDAO dao;
    /* (poofIssueledgerList) 실적증명발급관리 리스트
     * @see zes.openworks.intra.proofIssueledger.ProofIssueledgerService#poofIssueledgerList(zes.openworks.intra.proofIssueledger.ProofIssueledgerVO)
     */
    @Override
    public Pager<ProofIssueledgerVO> poofIssueledgerList(ProofIssueledgerVO vo, String search) {
        return dao.poofIssueledgerList(vo, search);
    }
    
    /*
     * (poofIssueledgerList) 실적증명발급관리 증명서 발급 신청 시
     * 1004 : 관리자 승인으로 변경
     */
    @Override
    public int poofIssueledgerCodeUpdate(ProofIssueledgerVO vo) {
        return dao.poofIssueledgerCodeUpdate(vo);
    }
}
