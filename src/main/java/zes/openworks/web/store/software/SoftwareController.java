/*
] * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store.software;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.Converter;
import zes.core.utils.CookieUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.component.file.FileDAO;
import zes.openworks.component.file.FileService;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.myGoods.MyGoodsService;
import zes.openworks.web.myGoods.MyGoodsVO;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.pop.PopVO;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.register.RegisterUserVO;
import zes.openworks.web.store.StoreincService;
import zes.openworks.web.store.premium.PremiumService;
import zes.openworks.web.store.premium.PremiumVO;
/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)엨키소프트
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2015. 11. 24.  소프트서비스       SKYOU
 *   * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/pt/store/software")
public class SoftwareController extends WebController {

    @Resource
    private FileDAO fileDao;
    @Autowired
    PremiumService service;
    @Autowired
    StoreincService storeService;
    @Autowired
    PopService popService;
    @Autowired
    private CommonDutyService codService;
    @Autowired
    FileService fileService;
    @Autowired
    private AutoMailService amservice;
    @Autowired
    private RegisterService registerService;
    @Autowired
    private CodeService commservice;
    @Autowired
    MyGoodsService myGoodsService;
    @Autowired
    MyCeartService myCeartService;
    
    
    @RequestMapping(value = "/BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, PremiumVO vo) {
       
        // 2015.12.23 수정
        int goodsTyCd = Integer.parseInt(request.getParameter("goodsTyCd"));
        model.addAttribute("goodsTyCd", goodsTyCd);

        int rpp = 50;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        // 접속 사용자 도메인 값 불러와서 가져오기
        // 이전소스
        //String hostNm = CmsUtil.getHostName(request.getServerName());
        String hostNm = "korean";
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        // 2015.12.23 수정
        vo.setGoodsTyCd(goodsTyCd);

        if  (Validate.isEmpty(vo.getCtgryCode())) {
            vo.setCtgryCode("0");
        }

        model.addAttribute("ctgry", service.ctgry(vo));
        model.addAttribute("ctgryParentInit", Converter.XSS(vo.getCtgryParentCode()));  //2depth 카테고리
        model.addAttribute("ctgryInit", Converter.XSS(vo.getCtgryCode()));              //3depth 카테고리

        if (Validate.isNotEmpty(service.ctgryPath(vo))) {
          model.addAttribute("ctgryPath", service.ctgryPath(vo));
        }
        model.addAttribute("ctgryList", service.ctgryList(vo));

        vo.getDataMap().put("langCode", Converter.XSS(vo.getLangCode()));
        vo.getDataMap().put("ctgryCode", Converter.XSS(vo.getCtgryCode()));
        vo.getDataMap().put("goodsTyCd", vo.getGoodsTyCd());
        
        vo.getDataMap().put("frameChk", Converter.XSS(vo.getFrameChk()));
        
        vo.getDataMap().put("selectItem1", vo.getSelectItem1());    //중소기업
        vo.getDataMap().put("selectItem2", vo.getSelectItem2());    //무료/체험
        vo.getDataMap().put("selectItem3", vo.getSelectItem3());    //계약단위
        vo.getDataMap().put("selectItem4", vo.getSelectItem4());    //인증
        vo.getDataMap().put("selectItem5", vo.getSelectItem5());    //서비스 관리
        vo.getDataMap().put("selectItem6", vo.getSelectItem6());    //호환성(표준)
        vo.getDataMap().put("selectItem7", vo.getSelectItem7());    //구축방식
        vo.getDataMap().put("selectItem8", vo.getSelectItem8());    //지원언어
        vo.getDataMap().put("selectItem9", vo.getSelectItem9());    //교육, 기술지원
        vo.getDataMap().put("selectItem10", vo.getSelectItem10());  //관리정보제공
        vo.getDataMap().put("selectItem11", vo.getSelectItem11());  //고객지원
        vo.getDataMap().put("selectItem13", vo.getSelectItem13());  //공공기관 이용 필터
        
        /**/
        if( vo.getSelectItem2() != null  || vo.getSelectItem5() != null || /*vo.getSelectItem6() != null  || */
            vo.getSelectItem7() != null  /*|| vo.getSelectItem8() != null*/ /*|| vo.getSelectItem9() != null  */
            /*|| vo.getSelectItem10() != null*/ /*|| vo.getSelectItem11() != null*/) {
           vo.getDataMap().put("selectItems", "chk");
        }else{
            vo.getDataMap().put("selectItems", null);
        }
/*        
        selectItem11    //고객지원
        selectItem10    // 관리정보제공
        selectItem9     // 교육, 기술지원
        selectItem8     // 개발지원
        selectItem6     // 호환성 지원
        selectItem5     // 서비스기술지원
        selectItem7     // 클라우드 구축방식
*/        
        if (Validate.isNotEmpty(vo.getSelectItem11())) {
            
            String selectItem11[] = null;
            for (int i=0; vo.getSelectItem11().length > i; i++) {
                selectItem11 = vo.getSelectItem11();
                
                if ("20591001".equals(selectItem11[i]) ) {
                    vo.getDataMap().put("selectItem111", selectItem11[i]);
                }else if ("20591002".equals(selectItem11[i]) ) {
                    vo.getDataMap().put("selectItem112", selectItem11[i]);
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getSelectItem10())) {
            String selectItem10[] = null;
            if (vo.getSelectItem10().length > 0) {
                
                for (int i=0; vo.getSelectItem10().length > i; i++) {
                    selectItem10 = vo.getSelectItem10();
                    
                    if ("20581001".equals(selectItem10[i]) ) {
                        vo.getDataMap().put("selectItem101", selectItem10[i]);
                    }
                    if ("20581002".equals(selectItem10[i]) ) {
                        vo.getDataMap().put("selectItem102", selectItem10[i]);
                    }
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getSelectItem9())) {
            String selectItem9[] = null;
            
            if (vo.getSelectItem9().length > 0) {
                
                for (int i=0; vo.getSelectItem9().length > i; i++) {
                    selectItem9 = vo.getSelectItem9();

                    //System.out.println("selectItem9[" + i + "]: " + selectItem9[i]);
                    if ("20571001".equals(selectItem9[i]) ) {
                        vo.getDataMap().put("selectItem91", selectItem9[i]);
                    }
                    if ("20571002".equals(selectItem9[i]) ) {
                        vo.getDataMap().put("selectItem92", selectItem9[i]);
                    }
                    if ("20571003".equals(selectItem9[i]) ) {
                        vo.getDataMap().put("selectItem93", selectItem9[i]);
                    }
                    if ("20571004".equals(selectItem9[i]) ) {
                        vo.getDataMap().put("selectItem94", selectItem9[i]);
                    }
                    if ("20571005".equals(selectItem9[i]) ) {
                        vo.getDataMap().put("selectItem95", selectItem9[i]);
                    }
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getSelectItem8())) {
            String selectItem8[] = null;
            
            for (int i=0; vo.getSelectItem8().length > i; i++) {
                selectItem8 = vo.getSelectItem8();
                if ("20561001".equals(selectItem8[i]) ) {   //소스공개
                    vo.getDataMap().put("selectItem81", selectItem8[i]);
                }
                if ("20561002".equals(selectItem8[i]) ) {   //외부 API access 지원
                    vo.getDataMap().put("selectItem82", selectItem8[i]);
                }
                if ("20561003".equals(selectItem8[i]) ) {   //DB 마이그레이션
                    vo.getDataMap().put("selectItem83", selectItem8[i]);
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getSelectItem7())) {
            String selectItem7[] = null;
            
            for (int i=0; vo.getSelectItem7().length > i; i++) {
                selectItem7 = vo.getSelectItem7();
                
                if ("20321003".equals(selectItem7[i]) ) {   //hybridCloudAt
                    vo.getDataMap().put("selectItem71", selectItem7[i]);
                }
                if ("20321001".equals(selectItem7[i]) ) {   //privateCloudAt
                    vo.getDataMap().put("selectItem72", selectItem7[i]);
                }
                if ("20321002".equals(selectItem7[i]) ) {   //publicCloudAt
                    vo.getDataMap().put("selectItem73", selectItem7[i]);
                }
                
            }
        }
        
        if (Validate.isNotEmpty(vo.getSelectItem6())) {
            String selectItem6[] = null;
            for (int i=0; vo.getSelectItem6().length > i; i++) {
                selectItem6 = vo.getSelectItem6();
                
                if ("20311001".equals(selectItem6[i]) ) {
                    vo.getDataMap().put("selectItem61", selectItem6[i]);
                }
                if ("20311005".equals(selectItem6[i]) ) {
                    vo.getDataMap().put("selectItem62", selectItem6[i]);
                }
                if ("20311006".equals(selectItem6[i]) ) {
                    vo.getDataMap().put("selectItem63", selectItem6[i]);
                }
                if ("20311004".equals(selectItem6[i]) ) {
                    vo.getDataMap().put("selectItem64", selectItem6[i]);
                }
                if ("20311007".equals(selectItem6[i]) ) {
                    vo.getDataMap().put("selectItem65", selectItem6[i]);
                }
            }
        }
        
        if (Validate.isNotEmpty(vo.getSelectItem5())) {
            String selectItem5[] = null;
            
            for (int i=0; vo.getSelectItem5().length > i; i++) {
                selectItem5 = vo.getSelectItem5();
                
                if ("20301002".equals(selectItem5[i]) ) {   //클러스터링  
                    vo.getDataMap().put("selectItem51", selectItem5[i]);
                }
                if ("20301003".equals(selectItem5[i]) ) {   //자동확장
                    vo.getDataMap().put("selectItem52", selectItem5[i]);
                }
                if ("20301009".equals(selectItem5[i]) ) {   //SLA 적용 
                    vo.getDataMap().put("selectItem53", selectItem5[i]);
                }
                if ("20301010".equals(selectItem5[i]) ) {   // 셀프서비스 프로비저닝 지원
                    vo.getDataMap().put("selectItem54", selectItem5[i]);
                }
                
            }
            
        }
        
        Pager<PremiumVO> goodsListVo = service.goodsList(vo);
        
        Integer goodsListCnt = vo.getTotalNum();
        
        //System.out.println("goodsListCnt: " + goodsListCnt);
        
        model.addAttribute("goodsListCnt", goodsListCnt);
        model.addAttribute(GlobalConfig.KEY_PAGER, goodsListVo);

        // 조회한 서비스별 카테고리 재조회[1개 서비스가 다수 카테고리를 가질수 있음.]
        /* 서비스리스트별 카테고리 보여주기 삭제 
        String goodsCode = "";

        List<PremiumVO> goodsList = goodsListVo.getList();
     
        /*for(int i=0; i < goodsList.size(); i++){
            PremiumVO goodsVo = goodsList.get(i);
            goodsCode = goodsCode + "@" + goodsVo.getGoodsCode() + "@";
        }
        goodsCode = goodsCode.replaceAll("@@", "','");
        goodsCode = goodsCode.replaceAll("@", "'");

        if(goodsCode.length() != 0 ){
            PremiumVO searchVo = new PremiumVO();
            searchVo.setGoodsCode(goodsCode);
            // 서비스별 카테고리 정보 조회
            model.addAttribute("goodsCateList", service.goodsCateList(searchVo));
        }*/

        
        //체크한 필터링 항목 전달
        model.addAttribute("selectItem1",  Arrays.toString(vo.getSelectItem1() ));  //중소기업
        model.addAttribute("selectItem2",  Arrays.toString(vo.getSelectItem2() ));  //무료/체험  =>공공기관 이용 필터
        model.addAttribute("selectItem3",  Arrays.toString(vo.getSelectItem3() ));  //계약단위 =>제공기업 공급 유형
        model.addAttribute("selectItem4",  Arrays.toString(vo.getSelectItem4() ));  //인증
        model.addAttribute("selectItem5",  Arrays.toString(vo.getSelectItem5() ));  //서비스 관리 =>서비스기술지원 명칭변경
        model.addAttribute("selectItem6",  Arrays.toString(vo.getSelectItem6() ));  //호환성(표준)
        model.addAttribute("selectItem7",  Arrays.toString(vo.getSelectItem7() ));  //구축방식=>구축방식
        model.addAttribute("selectItem8",  Arrays.toString(vo.getSelectItem8() ));  //지원언어=>개발지원
        model.addAttribute("selectItem9",  Arrays.toString(vo.getSelectItem9() ));  //CSQC Level=>교육, 기술지원
        model.addAttribute("selectItem10", Arrays.toString(vo.getSelectItem10()));  //관리정보제공
        model.addAttribute("selectItem11", Arrays.toString(vo.getSelectItem11()));  //고객지원
        model.addAttribute("selectItem13", Arrays.toString(vo.getSelectItem13()));  //클라우드서비스보안인증(CSAP)

        /**************************************************************/
        /************************** 좌측 메뉴 정보 **************************/
        /**************************************************************/
        //왼쪽메뉴(카테고리)
        vo.setCtgryCode("0");
        
        List<Map<String, Object>>  ctgryList = service.ctgryList(vo); 
        model.addAttribute("ctgryParentList", ctgryList );
        
        Integer totCnt =0 ;
        for (Map<String, Object> ctgry : ctgryList)
        {
            if  (ctgry.get("ctgryCnt")!=null)
                totCnt += (Integer)ctgry.get("ctgryCnt");
        }
        model.addAttribute("ctgryTotalCount", totCnt ); // 전체갯수를 구한다. 2018.04.12 

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
        String reqSessionId = request.getSession().getId();//request.getParameter("sessionId");
        String userId = "";//userLoginVO.getUserId();
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isEmpty(userLoginVO)) {
            userId = reqSessionId;
        }else {
            userId = userLoginVO.getUserId();
        }

        HashMap<String, String> dataMap = new HashMap<String, String>();  
        if(!Validate.isEmpty(reqSessionId)) {
            dataMap.put("userId", userId);
            dataMap.put("sessionId", reqSessionId);
        }

        //서비스 비교 목록
        List bgGoodsList = myCeartService.selectBgGoodsList(dataMap);
        
        model.addAttribute("bgGoodsCnt", bgGoodsList.size());
        model.addAttribute("bgGoodsList", bgGoodsList);
        
        model.addAttribute("frameChk", vo.getFrameChk());
    }


    @RequestMapping(value = "/BD_view.do")
    public ModelMap view(HttpServletRequest request, ModelMap model, PremiumVO vo, HttpServletResponse response) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);

        OpHelper.bindSearchMap(vo, request);

        // 조회수 증가를 위한 쿠키 체크
        if(CookieUtil.isIncreateReadCnt(vo.getGoodsCode(), 2, request, response)) {
            service.rdcntUpdate(vo);
        }

        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setLoginUserId(userLoginVo.getUserId());
            service.rcntUpdate(vo);
        }

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        //vo.setGoodsTyCd(1002);
        vo.setBbsCd(1008); //사용스토리 게시판코드
        vo.setDomainCd(Integer.parseInt(domainCd));

        //model.addAttribute("ctgryPath", service.ctgryPath(vo));
        model.addAttribute("ctgryPath", vo.getCtgryPath());

        //타겟 링크
        MyGoodsVO myvo =  new MyGoodsVO();
        myvo.setUserId(vo.getLoginUserId());
        myvo.setGoodsCode(vo.getGoodsCode());
        myvo.setLangCode("00");
        model.addAttribute("pageUrlNm", Converter.XSS(vo.getPageUrlNm()));
        model.addAttribute("goodsTyCd", vo.getGoodsTyCd());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        model.addAttribute("suplycnt",  service.suplyCnt(myvo));
        model.addAttribute("intrstcnt",  myGoodsService.intrstCnt(myvo));
        model.addAttribute("ppsList",  myGoodsService.selectGoodsPPS(myvo));
        
        model.addAttribute(GlobalConfig.KEY_PAGER, storeService.incRelation(vo));
     
        return model;

    }

    @RequestMapping(value = "/BD_view_v2.do")
    public ModelMap view_v2(HttpServletRequest request, ModelMap model, PremiumVO vo, HttpServletResponse response) 
    {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);

        OpHelper.bindSearchMap(vo, request);

        // 조회수 증가를 위한 쿠키 체크
        if(CookieUtil.isIncreateReadCnt(vo.getGoodsCode(), 2, request, response)) {
            service.rdcntUpdate(vo);
        }

        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setLoginUserId(userLoginVo.getUserId());
            service.rcntUpdate(vo);
        }

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        //vo.setGoodsTyCd(1002);
        vo.setBbsCd(1008); //사용스토리 게시판코드
        vo.setDomainCd(Integer.parseInt(domainCd));

        //model.addAttribute("ctgryPath", service.ctgryPath(vo));
        model.addAttribute("ctgryPath", vo.getCtgryPath());

        //타겟 링크
        MyGoodsVO myvo =  new MyGoodsVO();
        myvo.setUserId(vo.getLoginUserId());
        myvo.setGoodsCode(vo.getGoodsCode());
        myvo.setLangCode("00");
        model.addAttribute("pageUrlNm", Converter.XSS(vo.getPageUrlNm()));
        model.addAttribute("goodsTyCd", vo.getGoodsTyCd());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        model.addAttribute("suplycnt",  service.suplyCnt(myvo));
        model.addAttribute("intrstcnt",  myGoodsService.intrstCnt(myvo));
        model.addAttribute("ppsList",  myGoodsService.selectGoodsPPS(myvo));
        
        model.addAttribute(GlobalConfig.KEY_PAGER, storeService.incRelation(vo));
     
        return model;

    }


    @RequestMapping(value = "/ND_purch.do", method = RequestMethod.POST)
    public String purchInsert(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterUserVO registerVo = new RegisterUserVO();

        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }else{
            registerVo.setUserId(userLoginVo.getUserId());
            registerVo.setUserTyCd(userLoginVo.getUserTyCd());
            registerVo.setEmail(userLoginVo.getEmail());
            registerVo.setUserNm(userLoginVo.getUserNm());
        }

        vo.setLoginUserId(userLoginVo.getUserId());
        vo.setMbtlnum(userLoginVo.getMbtlnum());

        vo.setPurchsNo(service.getPurchsNo(vo));
        if(service.purchInsert(vo) == StringUtil.ONE) {

            //판매자+서비스정보 조회
            GoodsManageVO sellerGoodsVo = service.sellerInfo(vo);
            registerVo.setUserNm(sellerGoodsVo.getGoodsChargerNm());
            registerVo.setEmail(sellerGoodsVo.getGoodsChargerEmail());
            

            //구매자정보 조회
            PopVO popVO = new PopVO();
            popVO.setPurchsNo(vo.getPurchsNo());
            PopVO purchaserVo = popService.regstCnView(popVO);
            purchaserVo.setGoodsCode(sellerGoodsVo.getGoodsCode());
            purchaserVo.setGoodsNm(sellerGoodsVo.getGoodsNm());
            purchaserVo.setGoodsSumry(sellerGoodsVo.getGoodsSumry());
            purchaserVo.setImageFile(sellerGoodsVo.getImageFile());

            //이메일 전송
            emailCrtfcAction(request, model, purchaserVo, registerVo, vo.getGoodsTyCd());

            return responseJson(model, Boolean.TRUE, MessageHelper.getMsg(request, "orderOk"));
        }
        return responseJson(model, Boolean.FALSE);
    }

    @RequestMapping(value = "/ND_purchDownload.do", method = RequestMethod.POST)
    public String purchDownload(HttpServletRequest request, ModelMap model, PremiumVO vo, HttpServletResponse response) throws IOException {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        List<FileVO> goodsFile = new ArrayList<FileVO>();

        vo.setLoginUserId(userLoginVo.getUserId());

        vo.setPurchsNo(service.getPurchsNo(vo));
        if(service.purchInsert(vo) == StringUtil.ONE) {
            goodsFile = fileDao.getFiles(vo.getGoodsFileSeq());
            vo.setGoodsFile(goodsFile);
            String fileId = vo.getGoodsFile().get(0).getFileId();
            FileVO fileVo = fileService.getFile(fileId);
            if(fileVo != null) {
                fileService.updateFileDown(request, fileId);
            }

            return responseDownload(model, fileVo);
//            response.sendRedirect("/component/file/ND_fileDownload.do?id=" + fileId);
//            RequestDispatcher dispatcher = request.getRequestDispatcher("url");
//            dispatcher.forward(request, response);
//            return responseJson(model, Boolean.TRUE);
//                MessageHelper.getMsg(request, "orderOk"));
        }

        return responseJson(model, Boolean.FALSE);
    }

    @RequestMapping(value = "/ND_itst.do", method = RequestMethod.POST)
    public String itstUpdate(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        vo.setLoginUserId(userLoginVo.getUserId());
        
        //System.out.println("service.itstUpdate(vo): " + service.itstUpdate(vo));
        if(service.itstUpdate(vo) == StringUtil.ONE) {
            if(service.itstCount(vo) == StringUtil.ONE) {
                return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "watchOk"));
            }
            else
            {
                return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "watchDeleteOk"));
            }
        }
        else
        {
            return responseJson(model, Messages.FALSE, "watchFail");            
        }
    }


    /**
     * 이메일 발송 액션
     * emailCrtfcAction 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    public boolean emailCrtfcAction(HttpServletRequest request, ModelMap model, PopVO premiumVo, RegisterUserVO vo, Integer goodsType) {

    	registerService.mailCrtfcInsert(vo);
        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL

        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
        // 변경소스
        String DomainName = GlobalConfig.DOMAIN_SUBNM;
        //}}

        boolean result = false;
            Map<String, Object> autoMap = new HashMap<String, Object>();
            /*
             * 필수 입력 항목
             * ---------------------------------------------------------
             * 메일템플릿 번호
             * ---------------------------------------------------------
             * //AutoMailTemplate.java참고
             * ---------------------------------------------------------
             */

            vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
            if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_ODER_RQST);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소

            /*
             * 메일 템플릿에 적용될 치환값 :
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            hostNm = CmsUtil.getHostName(request.getServerName());
            if("".equals(hostNm) || "www".equals(hostNm)) {
                hostNm = "korean";
            }

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("product", premiumVo.getGoodsNm()); // 서비스명
            oneToOneInfoMap.put("productTitle", premiumVo.getGoodsNm());
            oneToOneInfoMap.put("productContents",premiumVo.getGoodsSumry());

            if(premiumVo.getUserTyCd().startsWith("10")){
                //구매신청자가 개인인경우
                oneToOneInfoMap.put("name", premiumVo.getUserNm());
                oneToOneInfoMap.put("phone", premiumVo.getOrderMbtlnum());
                oneToOneInfoMap.put("email", premiumVo.getOrderEmail());
            }else{
                //구매신청자가 기업인경우
                oneToOneInfoMap.put("name", premiumVo.getOrderChargerNm());
                oneToOneInfoMap.put("phone", premiumVo.getOrderCmpnyReprsntTelno());
                oneToOneInfoMap.put("email", premiumVo.getOrderChargerEmail());
            }
            oneToOneInfoMap.put("message",premiumVo.getOrderDlivMssage());
            oneToOneInfoMap.put("productImg", "http://" + DomainName  + premiumVo.getImageFile().get(0).getFileUrl());
            String productUrl = "http://" + DomainName  + "/" +  hostNm+"/pt/store/software/BD_view.do?goodsCode="+premiumVo.getGoodsCode()+"&goodsTyCd="+goodsType;
            oneToOneInfoMap.put("productUrl", productUrl); // 상세페이지
            // 이전소스
            //rtnurl = "http://" + hostNm + ".ceart.kr/" + hostNm+"/pt/sale/orderManage/BD_orderList.do";

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
            // 변경소스
            rtnurl = "http://" + DomainName + "/" + hostNm+"/pt/sale/orderManage/BD_orderList.do";
            //}}
            oneToOneInfoMap.put("rtnurl", rtnurl);

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
               /* System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }

            return result;
    }
}
