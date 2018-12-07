/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueapply;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.openworks.intra.proofIssueledger.ProofIssueledgerVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-3.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 1. 12.    이홍석       신규
 *</pre>
 * @see
 */
@Service("ProofIssueapplyService")
public class ProofIssueapplyServiceImpl extends AbstractServiceImpl implements ProofIssueapplyService {

    @Resource
    ProofIssueapplyDAO dao;
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#poofIssueapplyList(zes.openworks.web.myCertif.MyCertifApplyVO, java.lang.String)
     */
    @Override
    public Pager<ProofIssueledgerVO> proofIssueapplyList(ProofIssueledgerVO vo) {

        return dao.proofIssueapplyList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#proofIssueReportList(zes.openworks.intra.proofIssueledger.ProofIssueledgerVO)
     */
    @Override
    public List<ProofIssueledgerVO> proofIssueReportList(ProofIssueledgerVO vo) {
        return dao.proofIssueReportList(vo);
    }
    @Override
    public List<ProofIssueledgerVO> proofIssueReportList2(ProofIssueledgerVO vo) {
        return dao.proofIssueReportList2(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#setIssuSttus1003(java.lang.String)
     */
    @Override
    public int setIssuSttus1002(ProofIssueledgerVO vo) {

        return dao.setIssuSttus1002( vo );        
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#proofIssueapply(zes.openworks.intra.proofIssueledger.ProofIssueledgerVO)
     */
    @Override
    public ProofIssueledgerVO proofIssueapply(ProofIssueledgerVO vo) {
        
        return dao.proofIssueapply(vo);
    }
    
    @Override
    public ProofIssueledgerVO proofIssueapply2(ProofIssueledgerVO vo) {
        
        return dao.proofIssueapply2(vo);
    }
    @Override
    public ProofIssueledgerVO proofIssueapply3(ProofIssueledgerVO vo) {
        
        return dao.proofIssueapply3(vo);
    }
    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#setIssuSttus1003(zes.openworks.intra.proofIssueledger.ProofIssueledgerVO)
     */
    @Override
    public int setIssuSttus1003(ProofIssueledgerVO vo) {
        
        return dao.setIssuSttus1003( vo );
    }

    //@Resource ProofIssueapplyDAO dao;

}
