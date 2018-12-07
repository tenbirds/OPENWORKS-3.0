/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.banner;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.intra.advertisement.AdvrtsVO;
import zes.openworks.intra.popup.PopupVO;
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
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class BannerDAO extends EgovAbstractMapper {

    /**
     * 베너목록
     * bannerList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<BannerVO> bannerList(BannerVO vo) {
        vo.getDataMap().put("bannerTyCd", vo.getBannerTyCd());
        List<BannerVO> dataList = list("_banner.bannerList", vo.getDataMap());
        for(BannerVO dataVo : dataList) {
            List<PopupVO> domainList = list("_banner.bannerDomainList", dataVo);
            dataVo.setDomainCdList(domainList);
        }
        vo.setTotalNum((Integer) selectByPk("_banner.bannerCount", vo.getDataMap()));

        return new Pager<BannerVO>(dataList, vo);
    }

    /**
     * bannerTypeList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> bannerTypeList(BannerVO vo) {
        return list("_banner.bannerTypeList", vo);
    }

    /**
     * bannerInsertAction 설명
     * 
     * @param vo
     * @return
     */
    public int bannerInsertAction(BannerVO vo) {
        return insert("_banner.bannerInsert", vo);
    }

    /**
     * bannerUpdateForm 설명
     * 
     * @param vo
     * @return
     */
    public BannerVO bannerUpdateForm(BannerVO vo) {
        return (BannerVO) selectByPk("_banner.bannerUpdateForm", vo);
    }

    /**
     * fileDel 설명
     * 
     * @param vo
     * @return
     */
    public int fileDel(BannerVO vo) {

        return update("_banner.delfile", vo);
    }

    /**
     * filePath 설명
     * 
     * @param seq
     * @return
     */
    public String filePath(BannerVO vo) {
        return (String) selectByPk("_banner.bannerFilePath", vo);
    }

    /**
     * bannerUpdate 설명
     * 
     * @param vo
     * @return
     */
    public int bannerUpdate(BannerVO vo) {
        return update("_banner.bannerUpdate", vo);
    }

    /**
     * domainList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> domainList(BannerVO vo) {

        return list("_banner.domainList", vo);
    }

    /**
     * bannerLcSeList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> bannerLcSeList(BannerVO vo) {

        return list("_banner.bannerLcSeList", vo);
    }

    /**
     * popupInsertDomainCd 설명
     * 
     * @param vo
     */
    public int bannerInsertDomainCd(BannerVO vo) {
        return update("_banner.bannerInsertDomainCd", vo);
    }

    /**
     * eventInsertLsSeCd 설명
     * @param vo
     * @return
     */
    public int bannerInsertLsSeCd(BannerVO vo) {
        return update("_banner.bannerInsertLsSeCd", vo);
    }
    
    /**
     * bannerDomainDel 설명
     * 
     * @param vo
     */
    public int bannerDomainDel(BannerVO vo) {
        return delete("_banner.bannerDomainDel", vo);
    }

    /**
     * bannerLcInfoDel 설명
     * @param vo
     * @return
     */
    public int bannerLcInfoDel(BannerVO vo) {
        return delete("_banner.bannerLcInfoDel", vo);
    }
    
    /**
     * bannerDomainList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> bannerDomainList(BannerVO vo) {

        return list("_banner.bannerDomainList", vo);
    }

    /**
     * orderList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BannerVO> orderList(BannerVO vo) {

        return list("_banner.orderList", vo);
    }

    /**
     * orderUpdate 설명
     * 
     * @param vo
     */
    public int orderUpdate(BannerVO vo) {
        return update("_banner.orderUpdate", vo);

    }

    /**
     * useYnUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    public int useYnUpdateAction(BannerVO vo) {
        int _result = update("_banner.useYnUpdate", vo);
        return _result;
    }

    /**
     * orderDelete 설명
     * 
     * @param vo
     */
    public int orderDelete(BannerVO vo) {
        return delete("_banner.orderDelete", vo);

    }
    
    /**
     * bannerDeleteAction 설명
     * @param vo
     * @return
     */
    public int bannerDeleteAction(BannerVO vo){
        int affected = 0;
        if(Validate.isNotEmpty(vo.getBannerSns())){
            
            for(String bannerSeqs : vo.getBannerSns()) {
                BannerVO bannerVo  = new BannerVO();
                bannerVo.setBannerSn(Integer.valueOf(bannerSeqs));
                
                            delete("_banner.bannerLcInfoDel", bannerVo);
                            delete("_banner.bannerDomainDel", bannerVo);
                affected += delete("_banner.bannerDel", bannerVo);
                            
            }
        }

        return affected;
        
    }
    
    public int bannerAtDeleteAction(BannerVO vo){
        int affected = 0;
        
        if(Validate.isNotEmpty(vo.getBannerSns())){            
            for(String bannerSeqs : vo.getBannerSns()) {
                BannerVO bannerVo  = new BannerVO();
                
                bannerVo.setBannerSn(Integer.valueOf(bannerSeqs));                            
                affected += update("_banner.bannerAtDel", bannerVo);
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
}
