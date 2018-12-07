/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.pop;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.vo.TreeVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.register.OrganPagerVo;
import zes.openworks.web.store.premium.PremiumVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 21.    이슬버미       신규
 *</pre>
 * @see
 */
@Service
public class PopServiceImpl  extends AbstractServiceImpl implements PopService {

    @Resource PopDAO dao;


    /* (회원정보)
     * @see zes.openworks.web.pop.PopService#userView(zes.openworks.web.pop.PopVO)
     */
    @Override
    public PopVO userView(PopVO vo) {
        return dao.userView(vo);
    }
    
    /* (비회원정보)
     * @see zes.openworks.web.pop.PopService#userView(zes.openworks.web.pop.PopVO)
     */
    @Override
    public PopVO tempUserView(PopVO vo) {
        return dao.tempUserView(vo);
    }

    /* (신청내용)
     * @see zes.openworks.web.pop.PopService#regstCnView(zes.openworks.web.pop.PopVO)
     */
    @Override
    public PopVO regstCnView(PopVO vo) {
        return dao.regstCnView(vo);
    }

    @Override
    public int reqstCnUpdateAction(PopVO vo) {
        return dao.reqstCnUpdateAction(vo);
    }

    @Override
    public PopVO purchsView(PopVO vo) {
        return dao.purchsView(vo);
    }

    /*
     * (카테고리팝업)
     */
    @Override
    public void categoryIndex(CategoryVO vo) {
    }

    /*
     * (카테고리팝업의 카테고리트리)
     */
    @Override
    public List<TreeVO> categoryList(CategoryVO vo) {
        return dao.categoryList(vo);
    }

  
    /* (신청하기)
     * @see zes.openworks.web.pop.PopService#regstCnView(zes.openworks.web.pop.PopVO)
     */
    @Override
    public PopVO orderPop(PopVO vo) {
        return dao.orderPop(vo);
    }

    /* (신청하기)
     * @see zes.openworks.web.pop.PopService#regstCnView(zes.openworks.web.pop.PopVO)
     */
    @Override
    public String purchInsert(PopVO vo) {
        return dao.purchInsert(vo);
    }

    /**
     * 서비스 미리보기
     */
    @Override
    public PremiumVO goodsPreview(PremiumVO vo) {
        return dao.goodsPreview(vo);
    }

    /**
     * 서비스 메타팝업
     */
    @Override
    public List<PopVO> metaPop(PopVO vo) {
        return dao.metaPop(vo);
    }

    /**
     * 언어별 서브도메인
     */
    @Override
    public String subDomain(String langCode) {
        return dao.subDomain(langCode);
    }
    /*
     * (카테고리팝업)
     */
    @Override
    public void categoryUserIndex(CategoryVO vo) {
    }

    /*
     * categoryUserPop( 비즈매칭 전문가선택 POP)
     */
    @Override
    public List<PopVO> categoryUserPop(PopVO vo) {
        return dao.categoryUserPop(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.pop.PopService#ceartBdGoodsCompList(java.util.HashMap)
     */
    @Override
    public List<HashMap<String, Object>> ceartBdGoodsCompList(HashMap<String, String> dataMap) {
        
        return dao.ceartBdGoodsCompList(dataMap);
    }
    @Override
    public List<HashMap<String, Object>> ceartWishGoodsCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) 
    {
        return dao.ceartWishGoodsCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap);
    }
    @Override
    public List<OrganPagerVo> searchOrganList(SuplerCntrctVO vo) {
        return dao.searchOrganList(vo);
    }
    @Override
    public List<SuplerCntrctVO> realUserOrganList(SuplerCntrctVO vo) {
        return dao.realUserOrganList(vo);
    }
    @Override
    public int realUserOrganInsert(SuplerCntrctVO vo){
        return dao.realUserOrganInsert(vo);
    }
    @Override
    public int realUserOrganDelete(SuplerCntrctVO vo) {
        return dao.realUserOrganDelete(vo);
    }    

    @Override
    public List<HashMap<String, Object>> estimatePaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) {
        return dao.estimatePaasCompList(chkGoodsCnt,arrGoodCd,arrNotifyNum,arrNotifySeq,dataMap);
    }

    @Override
    public List<HashMap<String, Object>> estimateSaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) {
        return dao.estimateSaasCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap);
    }

    @Override
    public List<HashMap<String, Object>> estimateIaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) {
        return dao.estimateIaasCompList(chkGoodsCnt, arrGoodCd, arrNotifyNum, arrNotifySeq, dataMap);
    }
}   
