/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.popup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
import zes.openworks.intra.advertisement.AdvrtsVO;

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
public interface PopupService {

    /**
     * popupList 설명
     * 
     * @param vo
     * @return
     */
    Pager<PopupVO> popupList(PopupVO vo);

    /**
     * popupTypeList 설명
     * 
     * @param vo
     * @return
     */
    List<PopupVO> popupTypeList(PopupVO vo);

    /**
     * bannerInsertAction 설명
     * 
     * @param vo
     * @return
     */
    int popupInsertAction(PopupVO vo, HttpServletRequest request);

    /**
     * FileDel 설명
     * 
     * @param vo
     * @return
     */
    int FileDel(PopupVO vo);

    /**
     * popupUpdate 설명
     * 
     * @param vo
     * @return
     */
    int popupUpdate(PopupVO vo, HttpServletRequest request);

    /**
     * popupUpdateForm 설명
     * 
     * @param vo
     * @return
     */
    PopupVO popupUpdateForm(PopupVO vo);

    /**
     * viewPop 설명
     * 
     * @param vo
     * @return
     */
    PopupVO viewPop(PopupVO vo);

    /**
     * domainList 설명
     * 
     * @param domainVo
     * @return
     */
    List<PopupVO> domainList(PopupVO vo);

    /**
     * popupdomainList 설명
     * 
     * @param vo
     * @return
     */
    List<PopupVO> popupDomainList(PopupVO vo);

    /**
     * useYnUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    int useYnUpdateAction(PopupVO vo);

    /**
     * pop 설명
     * 
     * @param popupVO
     * @return
     */
    List<PopupVO> popup(PopupVO popupVO);

    /**
     * popupConfView 설명
     * 
     * @param popupVO
     * @return
     */
    PopupVO popupConfView(PopupVO popupVO);
    
    
    
    /**
     * popupDeleteAction 설명
     * @param vo
     * @param request
     * @return
     */
    int popupDeleteAction(PopupVO vo);

    /**
     * advrtsList 설명
     * @param avo
     * @return
     */
    List<AdvrtsVO> advrtsList(AdvrtsVO avo);
        
    
    /**
     * selectFrontInfo 설명
     * @return
     */
    FrontInfoVO selectFrontInfo();

    /**
     * updateFrontInfo 설명
     * @param vo 
     * @return
     */
    int updateFrontInfo(FrontInfoVO vo);

    
}
