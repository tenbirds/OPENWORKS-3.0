/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.search;

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
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.store.premium.PremiumService;
import zes.openworks.web.store.premium.PremiumVO;


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
@RequestMapping(value = { "/**/pt/search" })
public class UnifiedSearchController extends WebController{

    @Autowired
    PremiumService service;

    @Autowired
    private CodeService commservice;

    @Autowired
    private CommonDutyService codService;

    @Autowired
    MyCeartService myCeartService;
    

    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, UnifiedSearchVO vo, PremiumVO pvo) throws Exception  {

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

        //체크한 필터링 항목 전달
/*        
        model.addAttribute("sMeta1", vo.getsMeta1());                    //중소기업
        model.addAttribute("sMeta2", Arrays.toString(vo.getsMeta2()));   //무료/체험
        model.addAttribute("sMeta3", Arrays.toString(vo.getsMeta3()));   //계약단위
        model.addAttribute("sMeta4", Arrays.toString(vo.getsMeta4()));   //인증
        model.addAttribute("sMeta5", Arrays.toString(vo.getsMeta5()));   //서비스 관리
        model.addAttribute("sMeta6", Arrays.toString(vo.getsMeta6()));   //호환성(표준)
        model.addAttribute("sMeta7", Arrays.toString(vo.getsMeta7()));   //구축방식
        model.addAttribute("sMeta8", Arrays.toString(vo.getsMeta8()));   //지원언어
        model.addAttribute("sMeta9", Arrays.toString(vo.getsMeta9()));   //CSQC Level
*/
        
                
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


/*
        if(vo.getsMeta2()  != null || vo.getsMeta3()  != null || vo.getsMeta5()  != null ||
           vo.getsMeta6()  != null || vo.getsMeta7()  != null || vo.getsMeta8()  != null ||
           vo.getsMeta9()  != null || vo.getsMeta13() != null || vo.getsMeta10() != null ||
           vo.getsMeta11() != null) 
        {
            vo.getDataMap().put("selectItems", "chk");
        }else{
            vo.getDataMap().put("selectItems", null);
        }
*/        
        /*        
        selectItem11    //고객지원               sMeta11
        selectItem10    // 관리정보제공        sMeta10
        selectItem9     // 교육, 기술지원     sMeta9
        selectItem8     // 개발지원             sMeta8
        selectItem7     // 클라우드 구축방식  sMeta7
        selectItem6     // 호환성 지원          sMeta6
        selectItem5     // 서비스기술지원      sMeta5
        
*/    

        if (Validate.isNotEmpty(vo.getsMeta11())) { //고객지원
            String sMeta11[] = null;
            for (int i=0; vo.getsMeta11().length > i; i++) {
                sMeta11 = vo.getsMeta11();
                System.out.println("sMeta11[" + i + "]: " + sMeta11[i]);
                if ("20591001".equals(sMeta11[i]) ) {
                    vo.setCSTMR_CNTER_OPER_AT("Y");
                }else if ("20591002".equals(sMeta11[i]) ) {
                    vo.setAPI_SPORT_AT("Y");
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getsMeta10())) {    //관리정보제공
            String sMeta10[] = null;
            if (vo.getsMeta10().length > 0) {
                
                for (int i=0; vo.getsMeta10().length > i; i++) {
                    sMeta10 = vo.getsMeta10();
                    
                    if ("20581001".equals(sMeta10[i]) ) {
                        vo.setSVC_MANAGE_STTUS_INFO_SUPLY("Y");
                    }
                    if ("20581002".equals(sMeta10[i]) ) {
                        vo.setSVC_USE_LOG_SUPLY_AT("Y");
                    }
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getsMeta9())) { //교육, 기술지원
            String sMeta9[] = null;    
            
            if (vo.getsMeta9().length > 0) {
                
                for (int i=0; vo.getsMeta9().length > i; i++) {
                    sMeta9 = vo.getsMeta9();

                    if ("20571001".equals(sMeta9[i]) ) {
                        vo.setUSER_EDC_SPORT_AT("Y");
                    }
                    if ("20571002".equals(sMeta9[i]) ) {
                        vo.setVISIT_EDC_SPORT_AT("Y");
                    }
                    if ("20571003".equals(sMeta9[i]) ) {
                        vo.setUSER_MNL_SUPLY_AT("Y");
                    }
                    if ("20571004".equals(sMeta9[i]) ) {
                        vo.setVISIT_TCHNLGY_SPORT_AT("Y");
                    }
                    if ("20571005".equals(sMeta9[i]) ) {
                        vo.setVISIT_ELSE_TCHNLGY_SPORT_AT("Y");
                    }
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getsMeta8())) { //개발지원
            String sMeta8[] = null;
            
            for (int i=0; vo.getsMeta8().length > i; i++) {
                sMeta8 = vo.getsMeta8();
                if ("20561001".equals(sMeta8[i]) ) {   //소스공개
                    vo.setS_SOURC_OTHBC_AT("Y");
                }
                if ("20561002".equals(sMeta8[i]) ) {   //외부 API access 지원
                    vo.setS_API_ACCESS_SPORT_AT("Y");
                }
                if ("20561003".equals(sMeta8[i]) ) {   //DB 마이그레이션
                    vo.setS_DB_MIGRATION_SPORT_AT("Y");
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getsMeta7())) {
            String sMeta7[] = null;
            
            for (int i=0; vo.getsMeta7().length > i; i++) {
                sMeta7 = vo.getsMeta7();
                
                if ("20321003".equals(sMeta7[i]) ) {   //hybridCloudAt
                    vo.setHYBRID_CLOUD_AT("Y");
                }
                if ("20321001".equals(sMeta7[i]) ) {   //privateCloudAt
                    vo.setPRIVATE_CLOUD_AT("Y");
                }
                if ("20321002".equals(sMeta7[i]) ) {   //publicCloudAt
                    vo.setPUBLIC_CLOUD_AT("Y");
                }
                
            }
        }
        
        if (Validate.isNotEmpty(vo.getsMeta6())) {
            String sMeta6[] = null;
            for (int i=0; vo.getsMeta6().length > i; i++) {
                sMeta6 = vo.getsMeta6();
                
                if ("20311001".equals(sMeta6[i]) ) {
                    vo.setS_MULTI_PLTFOM_SPORT_AT("Y");
                }
                if ("20311005".equals(sMeta6[i]) ) {
                    vo.setS_OPEN_STD_SPORT_AT("Y");
                }
                if ("20311006".equals(sMeta6[i]) ) {
                    vo.setS_GVRN_FRMWRK_SPORT_AT("Y");
                }
                if ("20311004".equals(sMeta6[i]) ) {
                    vo.setS_OPEN_SOURC_SW_AT("Y");
                }
                if ("20311007".equals(sMeta6[i]) ) {
                    vo.setS_PAASTA_AT("Y");
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getsMeta5())) {
            String sMeta5[] = null;
            
            for (int i=0; vo.getsMeta5().length > i; i++) {
                sMeta5 = vo.getsMeta5();
                
                if ("20301002".equals(sMeta5[i]) ) {   //클러스터링  
                    vo.setCLUSTERING_SPORT_AT("Y");
                }
                if ("20301003".equals(sMeta5[i]) ) {   //자동확장
                    vo.setATMC_ESTN_SPORT_AT("Y");
                }
                if ("20301009".equals(sMeta5[i]) ) {   //SLA 적용 
                    vo.setSLA_APPLC_AT("Y");
                }
                if ("20301010".equals(sMeta5[i]) ) {   // 셀프서비스 프로비저닝 지원
                    vo.setSFSRV_PROVISIONING_SPORT_AT("Y");
                }
            }
            
        }
        
        
        /**************************************************************/
        /************************** 좌측 메뉴 정보 **************************/
        /**************************************************************/
        //왼쪽메뉴(카테고리)
        //vo.setCtgryCode("0");
        //model.addAttribute("ctgryParentList", service.ctgryList(vo));

        CodeVO cvo = new CodeVO();
        cvo.setLangCode(langCd);
        cvo.setUseYn("Y");
        // 중소기업

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
        
        /**************************************************************/
        /************************** 좌측 메뉴 정보 **************************/
        /**************************************************************/
        
        
        /**
         * HISTORY 등록
         */
        //System.out.println("/**************************************************************/");
        //System.out.println("query: " + query);
        //System.out.println("/**************************************************************/");
        
        String reqSessionId = request.getSession().getId();//request.getParameter("sessionId");
        String userId = "";//userLoginVO.getUserId();
        
        HashMap<String, String> dataMap = new HashMap<String, String>();  
        if(!Validate.isEmpty(reqSessionId)) {
            dataMap.put("userId", userId);
            dataMap.put("sessionId", reqSessionId);
        }

        //서비스 비교 초기값 셋팅
        List bgGoodsList = myCeartService.selectBgGoodsList(dataMap);
        model.addAttribute("bgGoodsCnt", bgGoodsList.size());
        model.addAttribute("bgGoodsList", bgGoodsList);
        
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
