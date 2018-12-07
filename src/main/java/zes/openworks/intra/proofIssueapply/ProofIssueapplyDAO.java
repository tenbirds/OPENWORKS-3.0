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

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
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
 * 2018. 1. 12.    방기배       신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class ProofIssueapplyDAO extends EgovAbstractMapper{
    
    @Resource
    private FileDAO fileDao;

    /**
     * poofIssueledgerList 설명
     * @param vo
     * @param search
     * @return
     */
    public Pager<ProofIssueledgerVO> proofIssueapplyList(ProofIssueledgerVO vo) {
        
        List<ProofIssueledgerVO> dataList = list("_proofIssueapply.proofIssueapplyList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_proofIssueapply.proofIssueapplyListCount", vo.getDataMap()));
        
        /*
        for(ProofIssueledgerVO dataVo : dataList){
            // 계약서 파일 정보
            if (Validate.isNotEmpty(dataVo.getFileSeq())) {
                dataVo.setPdfProfIssuFile(fileDao.getFiles(dataVo.getFileSeq()));
            }
        }
        */
        
        return new Pager<ProofIssueledgerVO>(dataList, vo);
    }

    /**
     * proofIssueReportList 설명
     * @param vo
     * @return
     */
    public List<ProofIssueledgerVO> proofIssueReportList(ProofIssueledgerVO vo) {
        List<ProofIssueledgerVO> dataList = list("_proofIssueapply.proofIssueServiceList", vo.getDataMap());
        return dataList;
    }
    public List<ProofIssueledgerVO> proofIssueReportList2(ProofIssueledgerVO vo) {
        List<ProofIssueledgerVO> dataList = list("_proofIssueapply.proofIssueServiceList2", vo);
        return dataList;
    }

    /**
     * setIssuSttus1003 설명
     * @param vo
     * @return
     */
    public int setIssuSttus1002(ProofIssueledgerVO vo) {
        
        //return update("_proofIssueapply.setIssuSttus1002",vo.getDataMap()); // 여러개 보내는게아님..
        return update("_proofIssueapply.setIssuSttus1002",vo);
    }

    /**
     * proofIssueapply 설명
     * @param vo
     * @return
     */
    public ProofIssueledgerVO proofIssueapply(ProofIssueledgerVO vo) {
        
        return (ProofIssueledgerVO)selectByPk("_proofIssueapply.proofIssueapply", vo.getDataMap());
    }
    public ProofIssueledgerVO proofIssueapply2(ProofIssueledgerVO vo) {
        
        return (ProofIssueledgerVO)selectByPk("_proofIssueapply.proofIssueapply2", vo);
    }
    public ProofIssueledgerVO proofIssueapply3(ProofIssueledgerVO vo) {
        
        return (ProofIssueledgerVO)selectByPk("_proofIssueapply.proofIssueapply3", vo);
    }

    /**
     * setIssuSttus1003 설명
     * @param vo
     * @return
     */
    public int setIssuSttus1003(ProofIssueledgerVO vo) {
        
        return update("_proofIssueapply.setIssuSttus1003",vo);
    }

}
