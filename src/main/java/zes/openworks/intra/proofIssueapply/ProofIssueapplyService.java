/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueapply;

import java.util.List;

import com.opensymphony.module.sitemesh.Page;

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
public interface ProofIssueapplyService {

    /**
     * poofIssueapplyList 설명
     * @param vo
     * @param parameter
     * @return
     */
    Pager<ProofIssueledgerVO> proofIssueapplyList(ProofIssueledgerVO vo);

    /**
     * proofIssueReportList 설명
     * @param vo
     * @return
     */
    List<ProofIssueledgerVO> proofIssueReportList(ProofIssueledgerVO vo);
    List<ProofIssueledgerVO> proofIssueReportList2(ProofIssueledgerVO vo);    
    
    /**
     * setIssuSttus1003 설명
     * @param vo
     */
    int setIssuSttus1002(ProofIssueledgerVO vo);

    /**
     * proofIssueapply 설명
     * @param vo
     * @return
     */
    ProofIssueledgerVO proofIssueapply(ProofIssueledgerVO vo);
    ProofIssueledgerVO proofIssueapply2(ProofIssueledgerVO vo);    
    ProofIssueledgerVO proofIssueapply3(ProofIssueledgerVO vo);    
    

    /**
     * setIssuSttus1003 설명
     * @param vo
     */
    int setIssuSttus1003(ProofIssueledgerVO vo);

    
}
