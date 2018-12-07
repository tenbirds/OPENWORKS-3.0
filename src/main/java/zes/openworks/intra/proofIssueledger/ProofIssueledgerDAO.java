/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueledger;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
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
@Repository
@SuppressWarnings("unchecked")
public class ProofIssueledgerDAO extends EgovAbstractMapper{
    
    
    public Pager<ProofIssueledgerVO> poofIssueledgerList(ProofIssueledgerVO vo, String search){
        
        List<ProofIssueledgerVO> dataList = list("_proofIssueledger.poofIssueledgerList", vo.getDataMap());
       
        vo.setTotalNum((Integer) selectByPk("_proofIssueledger.poofIssueledgerListCount", vo.getDataMap()));
        
        return new Pager<ProofIssueledgerVO>(dataList, vo);

    }
    
    
    /**
     * poofIssueledgerCodeUpdate (실적증명발급 증명서 발급 시
     * @param vo
     * @return
     */
  
    public int poofIssueledgerCodeUpdate(ProofIssueledgerVO vo){
        
        
        return update("_proofIssueledger.poofIssueledgerCodeUpdate", vo.getDataMap());
    }

}


