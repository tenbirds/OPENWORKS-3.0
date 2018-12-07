/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.pop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.register.OrganPagerVo;
import zes.openworks.web.store.premium.PremiumVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;

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
 *  2014. 11. 21.    이슬버미       신규
 * </pre>
 * @see
 */
@Repository
public class PopDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;
    
    /**
     * getCodeNames 그룹코드에 해당하는 코드의 내용을 리스트로 구한다.
     * @param groupcd
     * @param indvdiz_cds
     * @return
     */
    private List<String> getCodeNames(int groupcd, Object indvdiz_cds) 
    {
        if (indvdiz_cds != null) 
        {
            String cds = String.valueOf(indvdiz_cds) ;
            if  (!"".equals(cds))
            {
                Map<String, Object> parameterMap = new HashMap<String, Object>();
                parameterMap.put("groupCd",    groupcd);                             
                parameterMap.put("indvdizCds", cds);           
                
                List<String> termLst = (List<String>)list("_myCeart.opCodeIndvdlzNames", parameterMap);
                
                return termLst;
            }
            else
            {
                return null;
            }
        }
        else
        {
            return null;
        }        
    }
    
    /**
     * getCommanString 리스트의 문자열을 콤머로 연결한다.
     * @param termLst
     * @return
     */
    private String getCommanString(List<String> termLst) 
    {
        if (!Validate.isEmpty(termLst)) 
        {
            StringBuilder commaSepValueBuilder = new StringBuilder();
            for ( int j = 0; j< termLst.size(); j++)
            {
                commaSepValueBuilder.append(termLst.get(j));
               
                if ( j != termLst.size()-1)
                {
                    commaSepValueBuilder.append(",");
                }
            }
    
            return commaSepValueBuilder.toString();
        }
        else
        {
            return null;
        }
    }
    

    public PopVO userView(PopVO vo) {
        return (PopVO) selectByPk("_webpop.userView", vo);
    }
    
    public PopVO tempUserView(PopVO vo) {
        return (PopVO) selectByPk("_webpop.tempUserView", vo);
    }

    public PopVO regstCnView(PopVO vo) {

        return (PopVO) selectByPk("_webpop.regstCnView", vo);
    }

    public int reqstCnUpdateAction(PopVO vo) {
        return update("_webpop.reqstCnUpdateAction", vo);
    }

    public PopVO purchsView(PopVO vo) {

        return (PopVO) selectByPk("_webpop.purchsView", vo);
    }

    private final String HIGH_TREE_CD = String.valueOf(GlobalConfig.HIGH_TREE_CD);

    /**
     * categoryList 설명
     *
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<TreeVO> categoryList(CategoryVO vo) {
        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(HIGH_TREE_CD);
        }
        if (vo.getChkBox()) {
            return list("_webpop.treeList", vo);

        } else {
            return list("_category.treeList", vo);
        }
    }

    /**
     * orderPop 설명
     *
     * @param vo
     * @return
     */
    public PopVO orderPop(PopVO vo) {

        if(Validate.isNotEmpty(vo.getPurchsNo())) {
            return (PopVO) selectByPk("_webpop.regstCnView", vo);
        }
        return (PopVO) selectByPk("_webpop.userView", vo);
    }

    /**
     * purchInsert 설명
     *
     * @param vo
     * @return
     */
    public String purchInsert(PopVO vo) {
        // TODO Auto-generated method stub
        return null;
    }

    public PremiumVO goodsPreview(PremiumVO vo){

        vo.setStoreImageFile(fileDao.getFiles((Integer)selectByPk("_webpop.storeImageSeq", vo)));

        List<Map<String, Object>> markFiles = new ArrayList<Map<String, Object>>();
        Map<String, Object> markFiles1 = new HashMap<String, Object>();
        if(Validate.isNotEmpty(vo.getGoodsMarkCds())){
            for(Integer goodsMarkCd : vo.getGoodsMarkCds()){
                markFiles1.put(String.valueOf(goodsMarkCd), fileDao.getFiles((Integer)selectByPk("_webpop.markImageSeq", goodsMarkCd)));
                markFiles.add(markFiles1);
            }
        }

        vo.setGoodsMarkList(markFiles);

        return vo;
    }

    /**
     * metaPop 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PopVO> metaPop(PopVO vo) {
        return list("_webpop.metaPop", vo);
    }

    /**
     * subDomain 설명
     * @param langCode
     * @return
     */
    public String subDomain(String langCode) {
        return (String) selectByPk("_webpop.subDomain", langCode);
    }
    
    /**
     * categoryUserList 설명
     *
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")

    public List<PopVO> categoryUserPop(PopVO vo) {
        return list("_webpop.categoryUserPop", vo);
    }

    /**
     * ceartBdGoodsCompList 설명
     * @param dataMap
     * @return
     */
    public List<HashMap<String, Object>> ceartBdGoodsCompList(HashMap<String, String> dataMap) {
        return list("_webpop.goodsCompInfoView", dataMap);
    }   
    
    public List<HashMap<String, Object>> ceartWishGoodsCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) 
    {
        List<HashMap<String, Object>> lstVo = new ArrayList<HashMap<String,Object>>();
        
        for (int i=0 ; i<chkGoodsCnt ; i++)
        {
            dataMap.put("goodsCd", arrGoodCd[i]);            
            if (!"0".equals( arrNotifySeq[i]) )
            {
                dataMap.put("notifyNum", arrNotifyNum[i]);
                dataMap.put("notifySeq", arrNotifySeq[i]);
            }
            else
            {
                dataMap.put("notifyNum", null);
                dataMap.put("notifySeq", null);
            }
            
            lstVo.addAll( list("_webpop.goodsWishCompInfoView", dataMap) );
        }
        
        return lstVo;
    }
    
    /*계약별기관검색*/
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<OrganPagerVo> searchOrganList(SuplerCntrctVO vo) {
        return list("_webpop.searchOrganList", vo);
    }
    
    public int realUserOrganInsert(SuplerCntrctVO vo) {
        return   insert("_webpop.realUserOrganInsert", vo);
    }

    /*실제이용자정보*/
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<SuplerCntrctVO> realUserOrganList(SuplerCntrctVO vo) {
        return list("_webpop.realUserOrganList", vo);
    }
    
    public int realUserOrganDelete(SuplerCntrctVO vo) {
        return  delete("_webpop.realUserOrganDelete", vo);
        
    }

    /**
     * estimatePaasCompList 설명
     * @param dataMap
     * @return
     */
    public List<HashMap<String, Object>> estimatePaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) 
    {
        List<HashMap<String, Object>> lstVo = new ArrayList<HashMap<String,Object>>();
        
        for (int i=0 ; i<chkGoodsCnt ; i++)
        {
            dataMap.put("goodsCd", arrGoodCd[i]);
            if (!"0".equals( arrNotifySeq[i]) )
            {
                dataMap.put("notifyNum", arrNotifyNum[i]);
                dataMap.put("notifySeq", arrNotifySeq[i]);
            }
            else
            {
                dataMap.put("notifyNum", null);
                dataMap.put("notifySeq", null);
            }
            
            lstVo.addAll( list("_webpop.estimatePaasCompList", dataMap) ); // 상품갯수만큼
        }        
        
        List<String> termLst = null;
        
        int len = lstVo.size();
        for(int i = 0; i<len ; i++)
        {
            HashMap<String, Object> vo = lstVo.get(i);
            
            // 호스팅 방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2064, vo.get("HOSTINGMETHOD"));
            vo.put("HOSTINGMETHOD_NM", getCommanString(termLst));
            
            // 스케일링 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2066, vo.get("SCALING"));
            vo.put("SCALING_NM", getCommanString(termLst));
            
            // 플래폼 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2067, vo.get("PLATFORM"));
            vo.put("PLATFORM_NM", getCommanString(termLst));

            // 런타임 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2068, vo.get("RUNTIMES"));
            vo.put("RUNTIMES_NM", getCommanString(termLst));
            
            // 미들웨어 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2069, vo.get("MIDDLEWARES"));
            vo.put("MIDDLEWARES_NM", getCommanString(termLst));
            
            // 프레임워크 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2070, vo.get("FRAMEWORKS"));
            vo.put("FRAMEWORKS_NM", getCommanString(termLst));
            
            // 서비스 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2071, vo.get("SERVICES"));
            vo.put("SERVICES_NM", getCommanString(termLst));
            
            // 애드온 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2072, vo.get("ADDONS"));
            vo.put("ADDONS_NM", getCommanString(termLst));
            
            // 위치 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2073, vo.get("GEOLOCATIONS"));
            vo.put("GEOLOCATIONS_NM", getCommanString(termLst));
        }
        
        return lstVo;
    }

    /**
     * estimateSaasCompList 설명
     * @param dataMap
     * @return
     */
    public List<HashMap<String, Object>> estimateSaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap) 
    {
        List<HashMap<String, Object>> lstVo = new ArrayList<HashMap<String,Object>>();
        
        for (int i=0 ; i<chkGoodsCnt ; i++)
        {
            dataMap.put("goodsCd", arrGoodCd[i]);            
            if (!"0".equals( arrNotifySeq[i]) )
            {
                dataMap.put("notifyNum", arrNotifyNum[i]);
                dataMap.put("notifySeq", arrNotifySeq[i]);
            }
            else
            {
                dataMap.put("notifyNum", null);
                dataMap.put("notifySeq", null);
            }
            
            lstVo.addAll( list("_webpop.estimateSaasICompList", dataMap) ); // 상품갯수만큼
        }        
        
        List<String> termLst = null;
        
        int len = lstVo.size();
        for(int i = 0; i<len ; i++)
        {
            HashMap<String, Object> vo = lstVo.get(i);
            
            // 제공방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2042, vo.get("SUPPORT_METHOD"));
            vo.put("SUPPORT_METHOD_NM", getCommanString(termLst));     
            
            // 사용자/관리자분리 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2061, vo.get("USER_MANAGER_SEPARATE"));
            vo.put("USER_MANAGER_SEPARATE_NM", getCommanString(termLst));
            
            // 서비스 제공방식 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2062, vo.get("SERVICE_SUPPLY_METHOD"));
            vo.put("SERVICE_SUPPLY_METHOD_NM", getCommanString(termLst));
            
            // 암호화 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2063, vo.get("ENCRYPTION"));
            vo.put("ENCRYPTION_NM", getCommanString(termLst));
            
            // 필요사항 _ 단위 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2041, vo.get("NEED_UNITCODE"));
            vo.put("NEED_UNITCODE_NM", getCommanString(termLst));
            
            // 옵션사항 _ 단위 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2041, vo.get("OPTION_UNITCODE"));
            vo.put("OPTION_UNITCODE_NM", getCommanString(termLst));
        }
        
        return lstVo;
    }

    /**
     * estimateIaasCompList 설명
     * @param dataMap
     * @return
     */
    public List<HashMap<String, Object>> estimateIaasCompList(int chkGoodsCnt, String[] arrGoodCd, String[] arrNotifyNum, String[] arrNotifySeq, HashMap<String, String> dataMap)
    {    
        List<HashMap<String, Object>> lstVo = new ArrayList<HashMap<String,Object>>();
        
        for (int i=0 ; i<arrNotifyNum.length ; i++)
        {
            dataMap.put("goodsCd", arrGoodCd[i]);
            if (!"0".equals( arrNotifySeq[i]) )
            {
                dataMap.put("notifyNum", arrNotifyNum[i]);
                dataMap.put("notifySeq", arrNotifySeq[i]);
            }
            else
            {
                dataMap.put("notifyNum", null);
                dataMap.put("notifySeq", null);
            }
            
            lstVo.addAll( list("_webpop.estimateIaasICompList", dataMap) ); // 상품갯수만큼                                        
        }        
        
        List<String> termLst = null;
        
        int len = lstVo.size();
        for(int i = 0; i<len ; i++)
        {
            HashMap<String, Object> vo = lstVo.get(i);
            
            // 웹방화벽 - 상품유형 : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2074, vo.get("WEB_GOODS_KIND"));
            vo.put("WEB_GOODS_KIND_NM", getCommanString(termLst));
        }
        
        return lstVo;
    }
}
