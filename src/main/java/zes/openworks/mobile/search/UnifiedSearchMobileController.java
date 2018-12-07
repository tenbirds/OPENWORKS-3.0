/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.mobile.search;

import java.net.InetAddress;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.core.lang.Validate;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author 와이즈넛
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 3.    문상석       신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = { "/**/m/search" })
public class UnifiedSearchMobileController extends WebController{

    @Autowired
    private CodeService commservice;
    
    @Autowired
    private CommonDutyService codService;
    
    /**
     * index (통합검색 호출)
     * @return korean/m/search/BD_index
     */
    @RequestMapping(value = "BD_index.do")
    public void mobileIndex(HttpServletRequest request, ModelMap model, UnifiedSearchMobileVO vo) throws Exception {
        // 검색어 입력 파라미터 셋틍
        String hostNm = "korean";
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));        
        
        // 한글을 파라미터로 넘길때 코드변환이 필요!! - 한글이 아닌 코드로 넘기는게 좋은데..
        InetAddress inet = InetAddress.getLocalHost();
        String svrIP     = inet.getHostAddress();
        
        // 한글,한글변환
        String totalKeyword = null;
        
        //if ("192.168.85.26".equals(svrIP) || "192.168.85.31".equals(svrIP) || "192.168.85.32".equals(svrIP)) 
            //totalKeyword = new String((request.getParameter("totalKeyword")).getBytes("8859_1"), "UTF-8");
        //else
        totalKeyword = request.getParameter("totalKeyword");
        
        String query = request.getParameter("query");

        if(totalKeyword == null){
            totalKeyword = query;
        }
        model.addAttribute("totalKeyword", removeKey(totalKeyword));
        
        //신규 필터 적용
        model.addAttribute("sMeta1",  Arrays.toString(vo.getsMeta1()));    //기업구분
        model.addAttribute("sMeta2",  Arrays.toString(vo.getsMeta2()));    //공공기관 이용 필터
        model.addAttribute("sMeta3",  Arrays.toString(vo.getsMeta3()));    //제공기업 공급 유형
        model.addAttribute("sMeta4",  Arrays.toString(vo.getsMeta4()));    //클라우드 인증정보
        model.addAttribute("sMeta5",  Arrays.toString(vo.getsMeta5()));    //서비스기술지원
        model.addAttribute("sMeta6",  Arrays.toString(vo.getsMeta6()));    //호환성(표준)
        model.addAttribute("sMeta7",  Arrays.toString(vo.getsMeta7()));    //클라우드 구축방식
        model.addAttribute("sMeta8",  Arrays.toString(vo.getsMeta8()));    //지원언어
        model.addAttribute("sMeta9",  Arrays.toString(vo.getsMeta9()));    //교육, 기술지원
        model.addAttribute("sMeta10", Arrays.toString(vo.getsMeta10()));   //관리정보제공
        model.addAttribute("sMeta11", Arrays.toString(vo.getsMeta11()));   //고객지원
        model.addAttribute("sMeta12", Arrays.toString(vo.getsMeta12()));   //고객지원
        model.addAttribute("sMeta13", Arrays.toString(vo.getsMeta13()));   //SCS. SaaS, IaaS, PaaS

        /**************************************************************/
        /************************** 좌측 메뉴 정보 **************************/
        /**************************************************************/
        //왼쪽메뉴(카테고리)
        //vo.setCtgryCode("0");
        //model.addAttribute("ctgryParentList", service.ctgryList(vo));

        CodeVO cvo = new CodeVO();
        cvo.setLangCode(langCd);
        cvo.setUseYn("Y");
        // 무료/체험
        /*cvo.setGrpCd(2027);
        model.addAttribute("freeExperienceList", commservice.codeList(cvo));*/

        // 계약단위
       /* cvo.setGrpCd(2028);
        model.addAttribute("contractUnitList", commservice.codeList(cvo));*/

        // 인증
        cvo.setGrpCd(1011);
        model.addAttribute("certificationList", commservice.codeList(cvo));

        // 서비스 관리
        cvo.setGrpCd(2030);
        model.addAttribute("serviceManageList", commservice.codeList(cvo));

        // 호환성(표준)
        cvo.setGrpCd(2031);
        model.addAttribute("compatibilityList", commservice.codeList(cvo));

        // 구축방식
        cvo.setGrpCd(2032);
        model.addAttribute("buildMethodList", commservice.codeList(cvo));

        // 지원언어
        /*cvo.setGrpCd(1019);
        model.addAttribute("languageList", commservice.codeList(cvo));*/

        // CSQC Level
        /*cvo.setGrpCd(2033);
        model.addAttribute("csqcLevelList", commservice.codeList(cvo));*/
        
        
        /*****************신규필터링***********************/
        // 클라우스 서비스  제공기업 공급 유형
        cvo.setGrpCd(2055);
        model.addAttribute("supplyTypeList", commservice.codeList(cvo));
        
        //개발지원
        cvo.setGrpCd(2056);
        model.addAttribute("deploySupportList", commservice.codeList(cvo));

        //교육, 기술지원
        cvo.setGrpCd(2057);
        model.addAttribute("eduTechSupportList", commservice.codeList(cvo));
        
        //교육, 기술지원
        cvo.setGrpCd(2058);
        model.addAttribute("mangerInfotList", commservice.codeList(cvo));
        
        //고객지원
        cvo.setGrpCd(2059);
        model.addAttribute("customSupportList", commservice.codeList(cvo));
        
        //공공기관 이용 필터
        cvo.setGrpCd(2060);
        model.addAttribute("organUserList", commservice.codeList(cvo));
    }

    @RequestMapping(value = "BD_searchapi.do")
    public void api(HttpServletRequest request, ModelMap model) {
          
    }
    
    @RequestMapping(value = "relative.do")
    public void relative(HttpServletRequest request, ModelMap model) {
          
    }
    
    @RequestMapping(value = "popword.do")
    public void popword(HttpServletRequest request, ModelMap model) {
          
    }
    
    private String removeKey(String key){
        String[] arr_char = {"'","\"","<",">"};

        if(Validate.isNotEmpty(key)){
            for(int i=0 ; i<arr_char.length ; i++)
            {
                key = key.replace(arr_char[i], "");
            }
        }
        return key;
    }
}
