/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.popup;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.advertisement.AdvrtsVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 17.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("popupService")
public class PopupServiceImpl extends AbstractServiceImpl implements PopupService {

    @Resource
    private PopupDAO dao;

    @Override
    public Pager<PopupVO> popupList(PopupVO vo) {
        return dao.popupList(vo);
    }

    @Override
    public List<PopupVO> popupTypeList(PopupVO vo) {
        return dao.popupTypeList(vo);
    }

    @Override
    public int popupInsertAction(PopupVO vo, HttpServletRequest request) {
        int cnt = dao.popupInsertAction(vo);
        String[] domainCds = request.getParameter("domainCds1").split(",");
        for(String domainCd : domainCds) {
            vo.setDomainCd(Integer.parseInt(domainCd));
            dao.popupInsertDomainCd(vo);
        }
        return cnt;
    }

    @Override
    public int FileDel(PopupVO vo) {
        String filePath = dao.filePath(vo);
        FileUtil.delete(GlobalConfig.RESOURCE_ROOT + filePath);
        return dao.fileDel(vo);
    }

    @Override
    public int popupUpdate(PopupVO vo, HttpServletRequest request) {
        
        
        if(Integer.valueOf(vo.getMakeTyCd()).equals("1001")) {
            vo.setCnUrl("");
            vo.setFileNm("");
        } else if(Integer.valueOf(vo.getMakeTyCd()).equals("1002")) {
            vo.setCnHtml("");
            vo.setFileNm("");
        } else if(Integer.valueOf(vo.getMakeTyCd()).equals("1003")) {
            vo.setCnUrl("");
            vo.setCnHtml("");
        }

        int cnt = dao.popupUpdate(vo);
        dao.popupDomainDel(vo);
        String[] domainCds = request.getParameter("domainCds1").split(",");
        for(String domainCd : domainCds) {
            vo.setDomainCd(Integer.parseInt(domainCd));
            dao.popupInsertDomainCd(vo);
        }
        return cnt;
    }

    @Override
    public PopupVO popupUpdateForm(PopupVO vo) {
        return dao.popupUpdateForm(vo);
    }

    @Override
    public PopupVO viewPop(PopupVO vo) {
        return dao.viewPop(vo);
    }

    @Override
    public List<PopupVO> domainList(PopupVO vo) {
        return dao.domainList(vo);
    }

    @Override
    public List<PopupVO> popupDomainList(PopupVO vo) {
        return dao.popupDomainList(vo);
    }

    @Override
    public int useYnUpdateAction(PopupVO vo) {
        return dao.useYnUpdateAction(vo);
    }

    @Override
    public List<PopupVO> popup(PopupVO popupVO) {
        return dao.popup(popupVO);
    }

    @Override
    public PopupVO popupConfView(PopupVO popupVO) {
        return dao.popupConfView(popupVO);
    }

    @Override
    public int popupDeleteAction(PopupVO vo) {    
        return dao.popupDeleteAction(vo);
    }

    @Override
    public List<AdvrtsVO> advrtsList(AdvrtsVO avo) {
        return dao.advrtsList(avo);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#selectFrontInfo()
     */
    @Override
    public FrontInfoVO selectFrontInfo() {
        return dao.selectFrontInfo();
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.proofIssueapply.ProofIssueapplyService#updateFrontInfo()
     */
    @Override
    public int updateFrontInfo(FrontInfoVO vo) {
        return dao.updateFrontInfo(vo);
    }

}
