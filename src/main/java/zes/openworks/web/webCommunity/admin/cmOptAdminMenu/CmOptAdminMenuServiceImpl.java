/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptAdminMenu;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 11. 3.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmOptAdminMenuService") 
public class CmOptAdminMenuServiceImpl extends AbstractServiceImpl implements CmOptAdminMenuService{

    
    @Resource
    private CmOptAdminMenuDAO dao;
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptAdminMenu.CmOptAdminMenuService#cmOptAdminMenuList(zes.openworks.web.webCommunity.admin.cmOptAdminMenu.CmOptAdminMenuVO)
     */
    @Override
    public List<CmOptAdminMenuVO> cmOptAdminMenuList(CmOptAdminMenuVO vo) {
        // TODO Auto-generated method stub
        String strParntsMenuCode = "";
        int intDomainCd =  0;
        String strLangCode = vo.getLangCode();
        if(strLangCode ==null){
            
            strLangCode  = "00";
            
        }
        if("00".equals(strLangCode)){
            strParntsMenuCode = "kor_cm_a";
            intDomainCd = 2;
        }else if ("01".equals(strLangCode)){
            strParntsMenuCode = "eng_cm_a";
            intDomainCd = 3;
        }else if ("06".equals(strLangCode)){
            strParntsMenuCode = "esp_cm_a";
            intDomainCd = 4;
        }
        
        vo.setParntsMenuCode(strParntsMenuCode);
        vo.setDomainCd(intDomainCd);
        
        return dao.cmOptAdminMenuList(vo);
    }

}
