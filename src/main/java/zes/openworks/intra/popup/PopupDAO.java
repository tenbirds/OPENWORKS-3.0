/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.popup;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.intra.advertisement.AdvrtsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
@Repository
public class PopupDAO extends EgovAbstractMapper {

    /**
     * popupList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<PopupVO> popupList(PopupVO vo) {
        List<PopupVO> dataList = list("_popup.popupList", vo.getDataMap());
        for(PopupVO dataVo : dataList) {
            List<PopupVO> domainList = list("_popup.popupDomainList", dataVo);
            dataVo.setDomainCdList(domainList);

        }
        vo.setTotalNum((Integer) selectByPk("_popup.popupCount", vo.getDataMap()));

        return new Pager<PopupVO>(dataList, vo);

    }

    /**
     * popupTypeList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PopupVO> popupTypeList(PopupVO vo) {

        return list("_popup.popupTypeList", vo);
    }

    /**
     * popupInsertAction 설명
     * 
     * @param vo
     * @return
     */
    public int popupInsertAction(PopupVO vo) {

        return insert("_popup.popupInsert", vo);
    }

    /**
     * popupUpdate 설명
     * 
     * @param vo
     * @return
     */
    public PopupVO popupUpdateForm(PopupVO vo) {
        return (PopupVO) selectByPk("_popup.popupUpdateForm", vo);
    }

    /**
     * filePath 설명
     * 
     * @param vo
     * @return
     */
    public String filePath(PopupVO vo) {

        return (String) selectByPk("_popup.popupFilePath", vo);
    }

    /**
     * fileDel 설명
     * 
     * @param vo
     * @return
     */
    public int fileDel(PopupVO vo) {

        return update("_popup.delfile", vo);
    }

    /**
     * popupUpdate 설명
     * 
     * @param vo
     * @return
     */
    public int popupUpdate(PopupVO vo) {

        return update("_popup.popupUpdate", vo);
    }

    /**
     * viewPop 설명
     * 
     * @param vo
     * @return
     */
    public PopupVO viewPop(PopupVO vo) {
        return (PopupVO) selectByPk("_popup.popupUpdateForm", vo);
    }

    /**
     * domainList 설명
     * 
     * @param domainVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PopupVO> domainList(PopupVO vo) {
        return list("_popup.domainList", vo);
    }

    /**
     * popupInsertDomainCd 설명
     * 
     * @param vo
     * @return
     */
    public int popupInsertDomainCd(PopupVO vo) {
        return update("_popup.popupInsertDomainCd", vo);
    }

    /**
     * popupDomainList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PopupVO> popupDomainList(PopupVO vo) {

        return list("_popup.popupDomainList", vo);
    }

    /**
     * popupDomainDel 설명
     * 
     * @param vo
     */
    public int popupDomainDel(PopupVO vo) {
        return delete("_popup.popupDomainDel", vo);

    }

    /**
     * useYnUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    public int useYnUpdateAction(PopupVO vo) {
        int _result = update("_popup.useYnUpdate", vo);
        return _result;
    }

    /**
     * pop 설명
     * 
     * @param popupVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PopupVO> popup(PopupVO popupVO) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("domainCd", popupVO.getDomainCd());
        return list("_popup.popup", parameterMap);
    }

    /**
     * popupConfView 설명
     * 
     * @param popupVO
     * @return
     */
    public PopupVO popupConfView(PopupVO popupVO) {
        PopupVO dataBean = (PopupVO) selectByPk("_popup.popupConfView", popupVO);
        return dataBean;
    }
    
    /**
     * popupDeleteAction 설명
     * @param vo
     * @return
     */
    public int popupDeleteAction(PopupVO vo){
        int affected = 0;
        if(Validate.isNotEmpty(vo.getPopupSns())){
            
            for(String popupSeqs : vo.getPopupSns()) {
                PopupVO popupVo  = new PopupVO();
                popupVo.setPopupSn(Integer.valueOf(popupSeqs));
                
                            delete("_popup.popupDomainDel", popupVo);
                affected += delete("_popup.popupDel", popupVo);
                            
            }
        }

        return affected;
        
    }

    /**
     * advrtsList 설명
     * @param avo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<AdvrtsVO> advrtsList(AdvrtsVO avo) {
        return list("_advtsm.advrtsList", avo);
    }

    
    /**
     * selectFrontInfo 설명
     * @param  
     * @return
     */    
    public FrontInfoVO selectFrontInfo() {
        
        
        return (FrontInfoVO)selectByPk("_popup.selectFrontInfo", null);
        
    }

    /**
     * updateFrontInfo 설명
     * @param vo 
     * @return
     */
    public int updateFrontInfo(FrontInfoVO vo) {
        
        return update("_popup.updateFrontInfo",vo);
    }

}
