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
public interface PopService {

    /**
     * userView (회원 정보)
     * @param vo
     * @return
     */
    PopVO userView(PopVO vo);

    /**
     * tempUserView (비회원 정보)
     * @param vo
     * @return
     */
    PopVO tempUserView(PopVO vo);
    
    /**
     * regstCnView (신청내용)
     * @param vo
     * @return
     */
    PopVO regstCnView(PopVO vo);

    /**
     * reqstCnUpdateAction (신청 내용 확인)
     * @param vo
     * @return
     */
    int reqstCnUpdateAction(PopVO vo);

    PopVO purchsView(PopVO vo);

    /**
     *
     * categoryIndex (카테고리팝업)
     * @param vo
     */
    void categoryIndex(CategoryVO vo);

    /**
     *
     * categoryList (카테고리팝업의 트리)
     * @param vo
     * @return
     */
    List<TreeVO> categoryList(CategoryVO vo);

     
    /**
     * orderPop 설명
     * @param vo
     * @return
     */
    PopVO orderPop(PopVO vo);

    /**
     * purchInsert 설명
     * @param vo
     * @return
     */
    String purchInsert(PopVO vo);

    PremiumVO goodsPreview(PremiumVO vo);

    /**
     * metaPop 설명
     * @param vo
     * @return
     */
    List<PopVO> metaPop(PopVO vo);

    /**
     * subDomain 설명
     * @param langCode
     * @return
     */
    String subDomain(String langCode);
    
    /**
    *
    * categoryIndex (카테고리팝업)
    * @param vo
    */
   void categoryUserIndex(CategoryVO vo);

   /**
    *
    * categoryUserPop( 비즈매칭 전문가선택 POP)
    * @param vo
    * @return
    */
   List<PopVO> categoryUserPop(PopVO vo);

    /**
     * ceartBdGoodsCompList 상품비교 팝업 리스트
     * @param dataMap
     * @return
     */
   List<HashMap<String, Object>>  ceartBdGoodsCompList(HashMap<String, String> dataMap);
    
   List<HashMap<String, Object>> ceartWishGoodsCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap);
    
   List<OrganPagerVo> searchOrganList(SuplerCntrctVO vo);
    
   List<SuplerCntrctVO> realUserOrganList(SuplerCntrctVO vo);
    
    //실제이용실적기관 등록 
    int realUserOrganInsert(SuplerCntrctVO vo);
    
    //실제이용실적기관 삭제
    int realUserOrganDelete(SuplerCntrctVO vo);

    /**
     * estimatePaasCompList 설명
     * @param arrNotifySeq 
     * @param arrNotifyNum 
     * @param arrGoodCd 
     * @param chkGoodsCnt 
     * @param dataMap
     * @return
     */
   List<HashMap<String, Object>> estimatePaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap);

    /**
     * estimateSaasCompList 설명
     * @param dataMap
     * @return
     */
    List<HashMap<String, Object>> estimateSaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap);

    /**
     * estimateIaasCompList 설명
     * @param dataMap
     * @return
     */
    List<HashMap<String, Object>> estimateIaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap);
}
