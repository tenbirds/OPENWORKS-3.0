/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueledger;

import zes.base.pager.Pager;
import java.util.List;
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
public interface ProofIssueledgerService {
    
    /**
     * poofIssueledgerList (실적증명발급관리)
     * @param vo
     * @return
     */
    Pager<ProofIssueledgerVO> poofIssueledgerList(ProofIssueledgerVO vo, String search);
    
    
    /**
     * poofIssueledgerCodeUpdate (실적증명발급 증명서 발급 시
     * @param vo
     * @return
     */
    int poofIssueledgerCodeUpdate(ProofIssueledgerVO vo);

}
