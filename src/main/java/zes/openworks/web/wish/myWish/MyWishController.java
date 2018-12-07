package zes.openworks.web.wish.myWish;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.myCeart.vo.HistoryGoodsSearchVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNofyVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNotifySplyVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2IVO;
import zes.openworks.web.myCeart.vo.MyCeartPaas2VO;
import zes.openworks.web.myCeart.vo.MyCeartPurchsDtlsVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DnVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DoVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2IVO;
import zes.openworks.web.myCeart.vo.MyCeartScs2VO;
import zes.openworks.web.suplerCeart.SuplerCeartService;
/**
 *
 * @Class Name : WikiController
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 * @Description : 씨앗마켓 위키 공통 Controller
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       	      수정자   	         수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = "/**/wish")
public class MyWishController extends GeneralController {
    
    @Autowired
    MyCeartService myCeartService;    
    
    @Autowired
    SuplerCeartService suplerCeartService;
    
    @Autowired
    MyWishService service;
    
    @Autowired
    private CodeService commservice;

    /** 파일 저장 경로 */
    public static final String BID_NOTIFY_PATH = "bid" + File.separator;

    @RequestMapping(value = "/BD_index.do")    
    public String BD_index(HttpServletRequest request, ModelMap model, MyWishVO vo) 
    {
        MyCeartPurchsDtlsVO myVo = new MyCeartPurchsDtlsVO();
        
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
            //UserTyCd을 구별을 위한 로그인 회원 set
            myVo.setEndsUserId(userLoginVO.getUserId());
        }
        
        // 로그인 회원 타입코드
        model.addAttribute("userTyCd", myCeartService.purchsDtlsUserTyCd(myVo));
        
        OpHelper.bindSearchMap(vo, request);
        
        List<MyWishVO> myWishList = service.myWishList(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST,myWishList);

        // '계약확정' 여부.. 
        String goodsCd2   = vo.getGoodsCd2();            
        String cntrct_chk = (String) request.getParameter("cntrct_chk");
        
        if ((goodsCd2!=null) && (!"".equals(goodsCd2)) && "Y".equals(cntrct_chk))
        {
            String[] values = StringUtil.trim(goodsCd2).split(",");
            
            if (Validate.isNotEmpty(values)) 
            {
                MyWishVO myvo = new MyWishVO();
                for (int i = 0 ; i < values.length ; i++) 
                {
                    myvo.setUserId( vo.getUserId() );
                    myvo.setGrpSeq( vo.getGrpSeq() );
                    myvo.setGoodsCd( values[i] );

                    service.myWishSetCntrctChk(myvo);
                }
            }
        }
        
        if (vo.getGrpSeq() == null) // 사업명을 선택하지않고 초기로 들어올때
        {
            if (myWishList.size() > 0) // 이용희망목록이 하나이상 있다면..
            {   
                vo.setGrpSeq(myWishList.get(0).getGrpSeq());
                vo.setGoodsTyCd(myWishList.get(0).getGoodsTyCd());
                vo.setConfrmChk(myWishList.get(0).getConfrmChk());
    
                model.addAttribute("q_userId",    vo.getUserId());
                model.addAttribute("p_grpSeq",    vo.getGrpSeq());
                //model.addAttribute("p_goodsTyCd", vo.getGoodsTyCd());
                //model.addAttribute("p_confrmChk", vo.getConfrmChk()); // 확정여부
                
                //model.addAttribute(GlobalConfig.KEY_BASE_VO,service.myWishInfo(vo));
                model.addAttribute(GlobalConfig.KEY_PAGER, service.myWishStoreList(vo)); // 보관 서비스 목록 (이용희망목록)
                //model.addAttribute("pager2", service.myWishConfirmList(vo));           // 확정 서비스 목록 (이용대상 확정) _ 2018.04  부터 폐기
                model.addAttribute("confrmDt", service.myWishConfrmDt(vo));              // 최종 확정 일자
            }
        }
        else // 사업명을 선택하고 들어올때
        {
            model.addAttribute("q_userId",    vo.getUserId());
            model.addAttribute("p_grpSeq",    vo.getGrpSeq());
            
            model.addAttribute(GlobalConfig.KEY_PAGER, service.myWishStoreList(vo)); // 보관 서비스 목록 (이용희망목록)
            //model.addAttribute("pager2", service.myWishConfirmList(vo));           // 확정 서비스 목록 (이용대상 확정) _ 2018.04  부터 폐기
            model.addAttribute("confrmDt", service.myWishConfrmDt(vo));              // 최종 확정 일자
        }
        

        return "/korean/pt/wish/BD_index";
    }
    
    
    /*
     * 구매희망목록 - 도입사업 삭제
     * */
    @RequestMapping(value = "ND_myWishDeleteAction.do", method = RequestMethod.POST)
    public String myWishDeleteAction(ModelMap model, HttpServletRequest request, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        int deleteCnt = 0;

        deleteCnt += service.myWishDeleteAction(vo);
        
        if(deleteCnt > 0) {
            return responseText(model, Messages.TRUE );
        }

        return responseText(model, Messages.FALSE);
    }

    /*
     * 구매희망목록 - 보관목록 서비스 삭제처리
     * */
    @RequestMapping(value = "ND_myWishStoreGoodsDeleteAction.do", method = RequestMethod.POST)
    public String myWishStoreGoodsDeleteAction(ModelMap model, HttpServletRequest request, MyWishVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        String goods_array = request.getParameter("goodArray");
        
        if (goods_array != null)
        {        
            if(goods_array != null || !"".equals(goods_array) )
            {
                String[] goods_cd = request.getParameter("goodArray").split("\\|");
                int confirmCnt = 0;
    
                for(int i=0; i<goods_cd.length; i++){
                    OpHelper.bindSearchMap(vo, request);
                    vo.setGoodsCd(goods_cd[i]); // 개별 서비스 코드 셋팅
    
                    confirmCnt += service.myWishStoreGoodsDeleteAction(vo);
                }
                
                if(confirmCnt > 0) {
                    return responseText(model, Messages.TRUE );
                }
            }
        }

        return responseText(model, Messages.FALSE);
    }

    /*
     * 구매희망목록 - 보관목록 서비스 확정처리
     * */
    @RequestMapping(value = "ND_myWishConfirmAction.do", method = RequestMethod.POST)
    public String myWishConfirmAction(ModelMap model, HttpServletRequest request, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        String goods_array = request.getParameter("goodArray");
        
        if(goods_array != null || !"".equals(goods_array) ){
            String[] goods_cd = request.getParameter("goodArray").split("\\|");
            int confirmCnt = 0;

            for(int i=0; i<goods_cd.length; i++){
                OpHelper.bindSearchMap(vo, request);
                vo.setGoodsCd(goods_cd[i]); // 개별 서비스 코드 셋팅
                confirmCnt += service.myWishConfirmAction(vo);
            }
            
            if(confirmCnt > 0) {
                return responseText(model, Messages.TRUE );
            }
        }

        return responseText(model, Messages.FALSE);
    }

    
    /*
     * 구매희망목록 - 보관목록 서비스 수의계약
     * */
    @RequestMapping(value = "ND_myWishOptional.do", method = RequestMethod.POST)
    public String myWishOptional(ModelMap model, HttpServletRequest request, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        SuplerServiceVO svo = suplerCeartService.buyUserInfo(userLoginVO.getUserId());
        if(svo != null)
            vo.setLangStoreNm(svo.getCmpnyNm());
        else 
            vo.setLangStoreNm("");
        
        int confirmCnt = 0;
        confirmCnt = service.myWishOptional(vo);
        if(confirmCnt > 0) {
            return responseText(model, Messages.TRUE );
        }
        return responseText(model, Messages.FALSE);
    }
    
    /**
     * wishListPopup (구매희망 엑셀 다운로드)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value="ND_myWishExcelDown.do", method=RequestMethod.GET)
    public String myWishExcelDown(HttpServletRequest request, ModelMap model, MyWishVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute("wishListInfo", service.myWishInfo(vo));
        model.addAttribute("wishListExcel", service.myWishDetailListExcel(vo));
        return "/korean/pt/wish/ND_myWishExcelDown";
    }

    /**
     * 구매희망목록 - 보관목다운로드
     * */
    @RequestMapping(value="/wishStoreExcel.do")
    public String suplySttusExcel(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.put("q_excel", "01"); // 목록별 구분값(01:보관목록 / 02:확정목록)
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", service.myWishStoreList(vo));
        model.put("q_excelFileName", "구매희망 보관목록");

        MyWishExcelVO myWishExcel = new MyWishExcelVO();
        myWishExcel.setModel(model);
        myWishExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, myWishExcel);
    }

    /**
     * 구매희망목록 - 확정목록다운로드
     * */
    @RequestMapping(value="/wishConfirmExcel.do")
    public String wishConfirmExcel(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.put("q_excel", "02"); // 목록별 구분값(01:보관목록 / 02:확정목록)
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", service.myWishConfirmList(vo));
        model.put("q_excelFileName", "구매희망 확정목록");

        MyWishExcelVO myWishExcel = new MyWishExcelVO();
        myWishExcel.setModel(model);
        myWishExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, myWishExcel);
    }
    
    /*
     * 구매희망목록 - 보관목록 서비스 삭제처리
     * */
    @RequestMapping(value = "ND_myWishConfirmGoodsDeleteAction.do", method = RequestMethod.POST)
    public String myWishConfirmGoodsDeleteAction(ModelMap model, HttpServletRequest request, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        String goods_array = request.getParameter("goodArray");
        
        if(goods_array != null || !"".equals(goods_array) ){
            String[] goods_cd = request.getParameter("goodArray").split("\\|");
            int confirmCnt = 0;

            for(int i=0; i<goods_cd.length; i++){
                OpHelper.bindSearchMap(vo, request);
                vo.setGoodsCd(goods_cd[i]); // 개별 서비스 코드 셋팅

                confirmCnt += service.myWishConfirmGoodsDeleteAction(vo);
            }
            
            if(confirmCnt > 0) {
                return responseText(model, Messages.TRUE );
            }
        }

        return responseText(model, Messages.FALSE);
    }
    
    /*
     * [이용희망목록] '재요청' 버튼 클릭!!
     * 
     * 이전에 사전견적요청서리스트 팝업을 띄운다
     * 
     * */
    @RequestMapping(value = "/PD_historyBeforeEstimate.do")                              
    public String PD_beforeRequestAgain( HttpServletRequest request, ModelMap model, WishViewVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl,"parent");                   
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        // logseq의 이용희망목록건에 해당하는 요청된 사전견적서 1건을 가지고 온다.
        List<MyCeartBeforeNofyVO> myCeartBeforeNofyVO = service.beforeEstimate(vo);
                
        if (myCeartBeforeNofyVO.size() > 0) // 있다면..
        {
            MyWishVO myWishVO = new MyWishVO();
            myWishVO.setUserId( userLoginVO.getUserId() );
            myWishVO.setGoodsCd( myCeartBeforeNofyVO.get(0).getGoodsCode() );
            
            List<MyWishVO> a =  myCeartService.myWishHistory(myWishVO);
            
            model.addAttribute(GlobalConfig.KEY_PAGER, a);
        }
        
        return "/korean/pt/wish/PD_historyBeforeEstimate";   
    }
        
    /*
     * [이용희망목록] 검색이력 '보기' 버튼 클릭!!
     * 
     * 이전에 사전견적요청서리스트 팝업을 띄운다
     * 
     * */
    @RequestMapping(value = "/PD_historyGoodsSearch.do")                              
    public String PD_historyGoodsSearch( HttpServletRequest request, ModelMap model, WishViewVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl,"parent");                   
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
               
        
        String langCd = "00";
        
        CodeVO cvo = new CodeVO();
        cvo.setLangCode(langCd);
        cvo.setUseYn("Y");        
        
        String keyword = null ;
        
        StringBuffer sb = new StringBuffer();
        int nCnt = 0;
        
        List<HistoryGoodsSearchVO> historyGoodsSearch = service.historyGoodsSearch(vo);
        for (HistoryGoodsSearchVO historyGoodsSearchVO : historyGoodsSearch) // 무조건 한번아니면 0번..
        {
            
            keyword = historyGoodsSearchVO.getKeyword() ;   // 검색어..            
            
            String filtercon =  historyGoodsSearchVO.getFiltercon(); // 필터 조건            
            
            // selectItem1:;selectItem2:20601003;selectItem3:;selectItem4:;selectItem5:;selectItem6:;selectItem7:;selectItem8:;selectItem9:;selectItem10:;selectItem11:;
            String selectItems[] = filtercon.split(";");
            for (String item : selectItems)
            {
                String itemVals[] = item.split(":");                                    
                  
                if  (itemVals.length == 2) // 이름과 값이 같이 있는 경우에만..
                {
                    String itmName = itemVals[0];
                    String itmValue = itemVals[1];
                    
                    if  ("selectItem1".equals(itmName))
                    {
                        nCnt = 0;
                        sb.append( "기업구분: " );
                        
                        String values[] = itmValue.split(",");
                        for (String value : values)
                        {
                            if (nCnt > 0) sb.append(", ");
                            
                            if ("Y".equals(value)) sb.append( "중소기업" );
                            if ("M".equals(value)) sb.append( "중견기업" );
                            if ("B".equals(value)) sb.append( "대기업" );
                            
                            nCnt++;
                        }
                    }
                    if  ("selectItem2".equals(itmName) || 
                         "selectItem3".equals(itmName) || 
                         "selectItem7".equals(itmName) || 
                         "selectItem4".equals(itmName) || 
                         "selectItem5".equals(itmName) || 
                         "selectItem6".equals(itmName) || 
                         "selectItem8".equals(itmName) || 
                         "selectItem9".equals(itmName) || 
                         "selectItem10".equals(itmName) || 
                         "selectItem11".equals(itmName)                                 
                        )
                    {
                        nCnt = 0;
                        
                        if  ("selectItem2".equals(itmName)) sb.append( "공공기관 이용 필터: " );
                        if  ("selectItem3".equals(itmName)) sb.append( "제공기업 공급 유형: " );
                        if  ("selectItem7".equals(itmName)) sb.append( "클라우드 구축방식: " );
                        if  ("selectItem4".equals(itmName)) sb.append( "클라우드 인증정보: " );
                        if  ("selectItem5".equals(itmName)) sb.append( "서비스기술지원: " );
                        if  ("selectItem6".equals(itmName)) sb.append( "호환성 지원 : " );
                        if  ("selectItem8".equals(itmName)) sb.append( "개발지원: " );
                        if  ("selectItem9".equals(itmName)) sb.append( "교육, 기술지원: " );
                        if  ("selectItem10".equals(itmName)) sb.append( "관리정보제공: " );
                        if  ("selectItem11".equals(itmName)) sb.append( "고객지원: " );
                        
                        List<CodeVO> organUserList = null ;
                        String values[] = itmValue.split(",");
                        int old_grp_code = 0 ;
                        
                        for (String value : values)
                        {
                            int grp_code = Integer.valueOf( value.substring(0, 4) ) ;
                            int idv_code = Integer.valueOf( value.substring(4, 8) ) ;
                             
                            if  (old_grp_code != grp_code)
                            {
                                cvo.setGrpCd( grp_code );
                                organUserList = commservice.codeList(cvo) ;
                                
                                old_grp_code = grp_code;
                            }
                            
                            for (CodeVO codeVO : organUserList)
                            {
                                if  (codeVO.getPrvCd() == idv_code)
                                {
                                    if (nCnt > 0) sb.append(", ");
                                    sb.append( codeVO.getPrvNm() );
                                    
                                    nCnt++;
                                }
                            }
                        }
                    }
                }
            }
        }
       
        model.addAttribute("myWishVO", service.myWishStore(vo));
        model.addAttribute("keyword", keyword);
        model.addAttribute("filtercon", sb.toString());
        
        return "/korean/pt/wish/PD_historyGoodsSearch";   
    }

    /*
     * [이용희망목록]  '보기' 버튼 클릭!!
     * 
     * 요구와 답변을 함께 볼수 있도록 팝업을 띄운다 ( 마이씨앗 > 사전견적관리 와 동일?)
     * 
     * */
    @RequestMapping(value = "/PD_wishViewEstimateReply.do")                              
    public String PD_wishViewEstimateReply( HttpServletRequest request, ModelMap model, WishViewVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl,"parent");
                   
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        // 입찰공고 마스터 조회
        MyCeartBeforeNofyVO beforeNofyVO = new MyCeartBeforeNofyVO();
        beforeNofyVO.setNotifyNum(vo.getNotifyNum());
        beforeNofyVO.setNotifySeq(vo.getNotifySeq());
        
        List<MyCeartBeforeNofyVO> requestMstInfo = myCeartService.myCeartBeforeNotifyInfo(beforeNofyVO);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));
        
        // 공급자의 확인정보 조회
        MyCeartBeforeNotifySplyVO beforeNotifySplyVO = new MyCeartBeforeNotifySplyVO();
        beforeNotifySplyVO.setNotifyNum(vo.getNotifyNum());
        beforeNotifySplyVO.setNotifySeq(vo.getNotifySeq());
        beforeNotifySplyVO.setUserId(vo.getLangStoreUserId());
        
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, myCeartService.myCeartBeforeNotifySplyInfo(beforeNotifySplyVO).get(0));
        
        // 해당 견적의 서비스 구분
        String goodKndCd =  requestMstInfo.get(0).getGoodKndCd();

        if(goodKndCd.equals("1001")) // PaaS2
        {
            MyCeartPaas2VO paas2VO = new MyCeartPaas2VO();
            paas2VO.setNotifyNum(vo.getNotifyNum());
            paas2VO.setNotifySeq(vo.getNotifySeq());
            paas2VO.setUserId(vo.getUserId());
            paas2VO.setLangStoreId(vo.getLangStoreUserId());
            
            model.addAttribute("pass2", myCeartService.myCeartBeforeInfoByPass2(paas2VO)); // PaaS 정보 조회
        }
        else if(goodKndCd.equals("1002")) // SaaS2
        {
            MyCeartSaas2IVO saas2IVO = new MyCeartSaas2IVO();
            saas2IVO.setNotifyNum(vo.getNotifyNum());
            saas2IVO.setNotifySeq(vo.getNotifySeq());
            saas2IVO.setUserId(vo.getUserId());
            saas2IVO.setLangStoreId(vo.getLangStoreUserId());
            
            model.addAttribute("sass2I", myCeartService.myCeartBeforeInfoBySass2I(saas2IVO)); // SaaS2 정보 조회            

            MyCeartSaas2DnVO saas2DnVO = new MyCeartSaas2DnVO();
            saas2DnVO.setNotifyNum(vo.getNotifyNum());
            saas2DnVO.setNotifySeq(vo.getNotifySeq());
            saas2DnVO.setUserId(vo.getUserId());
            saas2DnVO.setLangStoreId(vo.getLangStoreUserId());
            
            List<MyCeartSaas2DnVO> myCeartSaas2DnVO = myCeartService.myCeartBeforeInfoBySass2Dn(saas2DnVO) ;
            List<MyCeartSaas2DnVO> myCeartSaas2DnVO_h = new  ArrayList<MyCeartSaas2DnVO>();
            
            Iterator<MyCeartSaas2DnVO> iterator2Dn = myCeartSaas2DnVO.iterator();
            while (iterator2Dn.hasNext())
            {
                MyCeartSaas2DnVO tmp = iterator2Dn.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartSaas2DnVO_h.add(tmp);
            }
            model.addAttribute("sass2Dn_h", myCeartSaas2DnVO_h); // SaaS2 상세Need정보 조회
            model.addAttribute("sass2Dn",   myCeartSaas2DnVO);   // SaaS2 상세Need정보 조회

            MyCeartSaas2DoVO saas2DoVO = new MyCeartSaas2DoVO();
            saas2DoVO.setNotifyNum(vo.getNotifyNum());
            saas2DoVO.setNotifySeq(vo.getNotifySeq());
            saas2DoVO.setUserId(vo.getUserId());
            saas2DoVO.setLangStoreId(vo.getLangStoreUserId());

            List<MyCeartSaas2DoVO> myCeartSaas2DoVO = myCeartService.myCeartBeforeInfoBySass2Do(saas2DoVO) ;
            List<MyCeartSaas2DoVO> myCeartSaas2DoVO_h = new  ArrayList<MyCeartSaas2DoVO>();
            
            Iterator<MyCeartSaas2DoVO> iterator2Do = myCeartSaas2DoVO.iterator();
            while (iterator2Do.hasNext())
            {
                MyCeartSaas2DoVO tmp = iterator2Do.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartSaas2DoVO_h.add(tmp);
            }
            model.addAttribute("sass2Do_h", myCeartSaas2DoVO_h); // SaaS2 상세Need정보 조회
            model.addAttribute("sass2Do", myCeartSaas2DoVO); // SaaS2 상세Option정보 조회
        }
        else if(goodKndCd.equals("1003"))  // IaaS2
        {
            MyCeartIaas2IVO iaas2IVO   = new MyCeartIaas2IVO();
            iaas2IVO.setNotifyNum(vo.getNotifyNum());
            iaas2IVO.setNotifySeq(vo.getNotifySeq());
            iaas2IVO.setUserId(vo.getUserId());
            iaas2IVO.setLangStoreId(vo.getLangStoreUserId());
            
            model.addAttribute("iass2I",  myCeartService.myCeartBeforeInfoByIass2I(iaas2IVO));   // IaaS2 정보 조회
            
            MyCeartIaas2DsVO iaas2DsVO = new MyCeartIaas2DsVO();
            iaas2DsVO.setNotifyNum(vo.getNotifyNum());
            iaas2DsVO.setNotifySeq(vo.getNotifySeq());
            iaas2DsVO.setUserId(vo.getUserId());
            iaas2DsVO.setLangStoreId(vo.getLangStoreUserId());
            
            List<MyCeartIaas2DsVO> myCeartIaas2DsVO = myCeartService.myCeartBeforeInfoByIass2Ds(iaas2DsVO);
            List<MyCeartIaas2DsVO> myCeartIaas2DsVO_h = new ArrayList<MyCeartIaas2DsVO>();
            
            Iterator<MyCeartIaas2DsVO> Iterator2Ds = myCeartIaas2DsVO.iterator();
            while (Iterator2Ds.hasNext())
            {
                MyCeartIaas2DsVO tmp = Iterator2Ds.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartIaas2DsVO_h.add(tmp);
            }            
            model.addAttribute("iass2Ds_h", myCeartIaas2DsVO_h); // IaaS2 Server 정보 조회
            model.addAttribute("iass2Ds",   myCeartIaas2DsVO);   // IaaS2 Server 정보 조회
            
            MyCeartIaas2DdVO iaas2DdVO = new MyCeartIaas2DdVO();
            iaas2DdVO.setNotifyNum(vo.getNotifyNum());
            iaas2DdVO.setNotifySeq(vo.getNotifySeq());
            iaas2DdVO.setUserId(vo.getUserId());
            iaas2DdVO.setLangStoreId(vo.getLangStoreUserId());
            
            
            List<MyCeartIaas2DdVO> myCeartIaas2DdVO = myCeartService.myCeartBeforeInfoByIass2Dd(iaas2DdVO);
            List<MyCeartIaas2DdVO> myCeartIaas2DdVO_h = new ArrayList<MyCeartIaas2DdVO>();
            
            Iterator<MyCeartIaas2DdVO> Iterator2Dd = myCeartIaas2DdVO.iterator();
            while (Iterator2Dd.hasNext())
            {
                MyCeartIaas2DdVO tmp = Iterator2Dd.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartIaas2DdVO_h.add(tmp);
            }            
            model.addAttribute("iass2Dd_h", myCeartIaas2DdVO_h); // IaaS2 DB 정보 조회
            model.addAttribute("iass2Dd",   myCeartIaas2DdVO);   // IaaS2 DB 정보 조회
        }
        else if(goodKndCd.equals("1004")) // Scs2
        {            
            MyCeartScs2VO scs2VO = new MyCeartScs2VO();
            scs2VO.setNotifyNum(vo.getNotifyNum());
            scs2VO.setNotifySeq(vo.getNotifySeq());
            scs2VO.setUserId(vo.getUserId());
            scs2VO.setLangStoreId(vo.getLangStoreUserId());
            
            model.addAttribute("scs2", myCeartService.myCeartBeforeInfoByScs2(scs2VO)); // Scs 정보 조회
        }
        
        return "/korean/pt/wish/PD_wishViewEstimateReply";
        /*
        // /korean/pt/wish/PD_wishViewEstimateReply
        // /korean/pt/wish/goods/PD_Paas2.view.jsp
        // /korean/pt/wish/goods/PD_Saas2.view.jsp
        // /korean/pt/wish/goods/PD_Iaas2.view.jsp
        // /korean/pt/wish/goods/PD_Scs2.view.jsp
        */
    }    
}
