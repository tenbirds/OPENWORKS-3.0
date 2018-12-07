/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.banner;

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
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface BannerService {

    /**
     * 베너목록
     * bannerList 설명
     * 
     * @param vo
     * @return
     */
    Pager<BannerVO> bannerList(BannerVO vo);

    /**
     * bannerTypeList 설명
     * 
     * @param vo
     * @return
     */
    List<BannerVO> bannerTypeList(BannerVO vo);

    /**
     * bannerInsertAction 설명
     * 
     * @param vo
     * @return
     */
    int bannerInsertAction(BannerVO vo, HttpServletRequest request);

    /**
     * BannerUpdateForm 설명
     * 
     * @param vo
     * @return
     */
    BannerVO bannerUpdateForm(BannerVO vo);

    /**
     * BannerUpdate 설명
     * 
     * @param vo
     * @return
     */
    int bannerUpdate(BannerVO vo, HttpServletRequest request);

    /**
     * FileDel 설명
     * 
     * @param vo
     */
    int fileDel(BannerVO vo);

    /**
     * domainList 설명
     * 
     * @param vo
     * @return
     */
    List<BannerVO> domainList(BannerVO vo);

    
    /**
     * bannerLcSeList 설명
     * @param vo
     * @return
     */
    List<BannerVO> bannerLcSeList(BannerVO vo);
    
    
    /**
     * bannerDomainList 설명
     * 
     * @param vo
     * @return
     */
    List<BannerVO> bannerDomainList(BannerVO vo);

    /**
     * orderList 설명
     * 
     * @param vo
     * @return
     */
    List<BannerVO> orderList(BannerVO vo);

    /**
     * orderUpdate 설명
     * 
     * @param vo
     * @param request
     * @return
     */
    int orderUpdate(BannerVO vo, HttpServletRequest request);

    /**
     * bannerInsertAction 설명
     * 
     * @param vo
     */
    int bannerInsertAction(BannerVO vo);

    /**
     * useYnUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    int useYnUpdateAction(BannerVO vo);
    
    /**
     * bannerDeleteAction 설명
     * @param vo
     * @param request
     * @return
     */
    int bannerDeleteAction(BannerVO vo);

    /**
     * advrtsList 설명
     * @param avo
     * @return
     */
    List<AdvrtsVO> advrtsList(AdvrtsVO avo);

}
