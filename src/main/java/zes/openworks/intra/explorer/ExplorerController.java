/*
 * This software is the confidential and proprietary information of ZES Inc.
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.explorer;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.menu.MenuService;
import zes.openworks.intra.menu.MenuVO;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;

/**
 * 관리자 메인 화면 구조 관리 컨트롤러
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/explorer")
public class ExplorerController extends GeneralController {

    @Autowired
    private MenuService service;

    @Autowired
    private ExplorerService explorerService;
    
    @Autowired 
    GoodsManageService goodsManageService;

    /**
     * Explorer 관리 페이지 (프레임)
     */
    @RequestMapping(value = "ND_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * Explorer 관리 페이지 (메인)
     */
    @RequestMapping(value = "ND_indexMain.do", method = RequestMethod.GET)
    public void indexMain(HttpServletRequest request, ModelMap model) {
        //권한정보
        @SuppressWarnings("rawtypes")
        HashMap authMap = getLoginAuth((LoginVO)OpHelper.getMgrSession(request));
        model.addAttribute("auth", authMap);
        
        LoginVO loginVo = (LoginVO) (request.getSession().getAttribute(GlobalConfig.MGR_SESSION_KEY));
        MenuVO vo = new MenuVO();
        if(loginVo != null) {
            vo.setMngrId(loginVo.getMngrId());
        }

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.myMenuListAll(vo));
    }

    /**
     * Explorer 관리 페이지 (메인)
     */
    @RequestMapping(value = "ND_extjsMain.do", method = RequestMethod.GET)
    public void extjsMain() {
    }

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회) -- 커스텀 디자인용
     */
    @RequestMapping(value = "ND_left.do", method = RequestMethod.GET)
    public void myMenus(MenuVO vo, HttpServletRequest request, ModelMap model) {

        LoginVO loginVo = (LoginVO) (request.getSession().getAttribute(GlobalConfig.MGR_SESSION_KEY));

        if(loginVo != null) {
            vo.setMngrId(loginVo.getMngrId());
        }

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.myMenuListAll(vo));
    }

    /**
     * 쪽지 알림 페이지
     */
    @RequestMapping(value = "ND_noteMain.do", method = RequestMethod.GET)
    public void noteMain() {
    }

    /**
     * 관리자대쉬보드 페이지
     */
    @RequestMapping(value = "BD_dashboard.do", method = RequestMethod.GET)
    public void dashboard(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        
        //권한정보
        @SuppressWarnings("rawtypes")
        HashMap authMap = getLoginAuth((LoginVO)OpHelper.getMgrSession(request));
        model.addAttribute("auth", authMap);
    }
    
    /**
     * //씨앗현황, 회원 현황, 협약서비스 현황
     * dashboardCeartJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/BD_dashboardCeartJson.do", method = RequestMethod.POST)
    public String dashboardCeartJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();

        String formatDate = getFormatDate("yyyy-MM-dd","D",-1);
        String beforeDate  = getFormatDate("yyyy-MM-dd","D",-2);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        
        map.put("issueDate",  issueDate);
        map.put("basicDate",  basicDate);
        map.put("endDate",   beforeDate + " 17:00");
        
        map.put("nowDate",    formatDate);
        map.put("beforeDate", beforeDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        vo.setFormatDate(formatDate);
        vo.setNowDate(formatDate);
        vo.setBeforeDate(beforeDate);
        vo.setEndDate(beforeDate + " 17:00");
        
        //씨앗 현황 통계 전체
        vo = (explorerService.ceartPresentCondition(vo));
        //System.out.println("issueDate: " + issueDate);
        //model.addAttribute("presentConditionVo", explorerService.ceartPresentCondition(vo));
        model.addAttribute("basicDate", basicDate);
        return responseJson(model, vo);
    }
    
    /**
     * 씨앗현황
     * goodsServiceStateJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/BD_goodsServiceStateJson.do", method = RequestMethod.POST)
    public String goodsServiceStateJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        List<ExplorerVO> goodsList = explorerService.goodsList(vo);
        
        String goodsServiceState = "false";
        for(ExplorerVO data : goodsList) {
            data.setGoodsServiceState(getResponseCode(data.getGoods_monitor_url()));
            
            //System.out.println("getGoodsServiceState: " + data.getGoodsServiceState());
            
            if (data.getGoodsServiceState() == "200") {
                goodsServiceState = "true";
            }else {
                goodsServiceState = "false";
            }
        }
        vo.setGoodsServiceState(goodsServiceState);
        
        return responseJson(model, vo);
    }
    
    /**
     * 업무현황
     * dashboardWorkJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/dashboardWorkJson.do", method = RequestMethod.POST)
    public String dashboardWorkJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
 
        String formatDate = getFormatDate("yyyy-MM-dd","D",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        
        vo = (explorerService.ceartWorkCondition(vo));
        return responseJson(model, vo);
    }
    
    /**
     * 총 계약건수
     * totalCntrAmountJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/totalCntrAmountJson.do", method = RequestMethod.POST)
    public String totalCntrAmountJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();       

        String formatDate = getFormatDate("yyyy-MM-dd","D",-1);
        String beforeDate  = getFormatDate("yyyy-MM-dd","D",-2);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        
        map.put("issueDate",  issueDate);
        map.put("basicDate",  basicDate);
        map.put("endDate",   beforeDate + " 17:00");
        
        map.put("nowDate",    formatDate);
        map.put("beforeDate", beforeDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        vo.setFormatDate(formatDate);
        vo.setNowDate(formatDate);
        vo.setBeforeDate(beforeDate);
        vo.setEndDate(beforeDate + " 17:00");
        
        //String formatDate = getFormatDate("yyyy-MM","NOW",0);
        vo = explorerService.totalCntrAmount(vo);
        model.addAttribute("basicDate", getFormatDate("yyyy-MM","D",-1));
        model.addAttribute("beforDate", getFormatDate("yyyy-MM","Y",-2));
        
        return responseJson(model, vo);
    }
    
    /**
     * 계약금액 TOP 10
     * totalCntrTopListJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/totalCntrTopListJson.do", method = RequestMethod.POST)
    public String totalCntrTopListJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String formatDate = getFormatDate("yyyy-MM-dd","NOW",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        
        vo.setDataList(explorerService.totalCntrTopList(map));
        
        return responseJson(model, vo);
    }
    
    @RequestMapping(value = "/totalCntrCountTopListJson.do", method = RequestMethod.POST)
    public String totalCntrCountTopListJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String formatDate = getFormatDate("yyyy-MM-dd","NOW",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        
        vo.setDataList(explorerService.totalCntrCountTopList(map));
        
        return responseJson(model, vo);
    }
    
    /**
     * 계약금액 누적통계
     * cntrctAmountViewJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/cntrctAmountViewJson.do", method = RequestMethod.POST)
    public String cntrctAmountViewJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String formatDate = getFormatDate("yyyy-MM-dd","NOW",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        String startDate = "2016.03";
        String endDate = getFormatDate("yyyy.MM","NOW",0);
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        vo.setStartDate(startDate);
        vo.setEndDate(endDate);
        
        
        vo.setDataList(explorerService.cntrctAmountViewList(map));
/*        
        System.out.println(getFormatDate("yyyyMMddHHmmss","NOW",0));
        System.out.println(getFormatDate("yyyy MM dd HH mm ss","NOW",0));
        System.out.println(getFormatDate("yyyy년MM월dd일 HH:mm:ss","NOW",0));
        System.out.println(getFormatDate("yyyyMMdd","NOW",0));
        
        System.out.println(getFormatDate("yyyy MM dd","Y",-1)); //오늘 일자에서 1년 빼기
        System.out.println(getFormatDate("yyyy MM dd","Y",10)); //오늘 일자에서 10년 더하기
        System.out.println(getFormatDate("yyyy MM dd","M",-1)); //오늘 일자에서 한달 빼기
        System.out.println(getFormatDate("yyyy MM dd","M",10)); //오늘 일자에서 10달 더하기
        System.out.println(getFormatDate("yyyy MM dd","D",-1)); //오늘 일자에서 하루 빼기
        System.out.println(getFormatDate("yyyy MM dd","D",10)); //오늘 일자에서 하루 더하기
*/

        return responseJson(model, vo);
    }
    
    @RequestMapping(value = "/cntrctCountViewJson.do", method = RequestMethod.POST)
    public String cntrctCountViewJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String formatDate = getFormatDate("yyyy-MM-dd","NOW",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        String startDate = "2016.03";
        String endDate = getFormatDate("yyyy.MM","NOW",0);
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        vo.setStartDate(startDate);
        vo.setEndDate(endDate);
        
        
        vo.setDataList(explorerService.cntrctCountViewList(map));
/*        
        System.out.println(getFormatDate("yyyyMMddHHmmss","NOW",0));
        System.out.println(getFormatDate("yyyy MM dd HH mm ss","NOW",0));
        System.out.println(getFormatDate("yyyy년MM월dd일 HH:mm:ss","NOW",0));
        System.out.println(getFormatDate("yyyyMMdd","NOW",0));
        
        System.out.println(getFormatDate("yyyy MM dd","Y",-1)); //오늘 일자에서 1년 빼기
        System.out.println(getFormatDate("yyyy MM dd","Y",10)); //오늘 일자에서 10년 더하기
        System.out.println(getFormatDate("yyyy MM dd","M",-1)); //오늘 일자에서 한달 빼기
        System.out.println(getFormatDate("yyyy MM dd","M",10)); //오늘 일자에서 10달 더하기
        System.out.println(getFormatDate("yyyy MM dd","D",-1)); //오늘 일자에서 하루 빼기
        System.out.println(getFormatDate("yyyy MM dd","D",10)); //오늘 일자에서 하루 더하기
*/

        return responseJson(model, vo);
    }
    
    /**
     * 계약금액 서비스 비율
     * cntrctRatioJson 설명
     * @param vo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/cntrctRatioJson.do", method = RequestMethod.POST)
    public String cntrctRatioJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String formatDate = getFormatDate("yyyy-MM-dd","NOW",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        String startDate = "2016.03";
        String endDate = getFormatDate("yyyy.MM","NOW",0);
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        
        vo = (explorerService.cntrctRatio(vo));
        
        double saasCnt = vo.getSaasCnt();
        double paasCnt = vo.getPaasCnt();
        double iaasCnt = vo.getIaasCnt();
        double scsCnt  = vo.getScsCnt();
        double cntSum  = vo.getCntSum();
        //double
        
        double saasRatio = ((saasCnt/cntSum)*100);
        double paasRatio = ((paasCnt/cntSum)*100);
        double iaasRatio = ((iaasCnt/cntSum)*100);
        double scsRatio  = ((scsCnt/cntSum)*100);
       
        vo.setSaasRatio(Math.ceil(saasRatio));
        vo.setPaasRatio(Math.ceil(paasRatio));
        vo.setIaasRatio(Math.ceil(iaasRatio));
        vo.setIaasRatio(Math.ceil(scsRatio));
        
        return responseJson(model, vo);
    }
    
    
    @RequestMapping(value = "/cntrctCountRatioJson.do", method = RequestMethod.POST)
    public String cntrctCountRatioJson(ExplorerVO vo, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String formatDate = getFormatDate("yyyy-MM-dd","D",-1);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        String startDate = "2016.03";
        String endDate = getFormatDate("yyyy.MM","NOW",0);
        
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        
        vo = (explorerService.cntrctCountRatio(vo));
        
        double saasCnt = vo.getSaasCnt();
        double paasCnt = vo.getPaasCnt();
        double iaasCnt = vo.getIaasCnt();
        double scsCnt  = vo.getScsCnt();
        double cntSum  = vo.getCntSum();
        
        double saasRatio = ((saasCnt/cntSum)*100);
        double paasRatio = ((paasCnt/cntSum)*100);
        double iaasRatio = ((iaasCnt/cntSum)*100);
        double scsRatio  = ((scsCnt/cntSum)*100);
       
        vo.setSaasRatio(Math.ceil(saasRatio));
        vo.setPaasRatio(Math.ceil(paasRatio));
        vo.setIaasRatio(Math.ceil(iaasRatio));
        vo.setIaasRatio(Math.ceil(scsRatio));
        
        return responseJson(model, vo);
    }
    
    /**
     * 현재 날자를 지정한 형식대로 얻는다
     * 
     * @param format : yyyyMMdd, yyyyMMddHHmmss term_gubun : Y,M,D,NOW term : 계산할일수
     * @return
     */
    public static String getFormatDate(String format, String term_gubun,int term) {
        String ret_date = "";
        Calendar cur_date = Calendar.getInstance(); // 현재 날짜
        SimpleDateFormat formatter; // 날짜 포맷

        term_gubun = term_gubun.toUpperCase();
        if ("".equals(term_gubun))
            term_gubun = "NOW";

        try {
            if (term_gubun.equals("Y") || term_gubun.equals("M")
                    || term_gubun.equals("D") || term_gubun.equals("NOW")) {
                formatter = new SimpleDateFormat(format);

                if (term_gubun.equals("Y")) {
                    cur_date.add(Calendar.YEAR, term);
                } else if (term_gubun.equals("M")) {
                    cur_date.add(Calendar.MONTH, term);
                } else if (term_gubun.equals("D")) {
                    cur_date.add(Calendar.DAY_OF_MONTH, term);
                }

                ret_date = formatter.format(cur_date.getTime());
            }
            return ret_date.trim();
        } catch (Exception e) {
            System.out.println("[MessageUtil::getDateFormt] Error = " + e);
        }
        return "";
    }


    
    public static String getResponseCode(String urlString) {
        String rtnStr = "";
        try {
            URL u = new URL(urlString);
            HttpURLConnection huc =  (HttpURLConnection)  u.openConnection();
            huc.setRequestMethod("GET");
            huc.connect();
            rtnStr = Integer.toString(huc.getResponseCode());
        } catch (MalformedURLException e) {
            rtnStr = e.getMessage();
        } catch (IOException e) {
            rtnStr = e.getMessage();
        } catch (Exception e) {
            rtnStr = e.getMessage();
        }
        return rtnStr;
    }
    
    public String yesterDay(String date){
        long chStart = 0;  
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        String basicDate = ""; 

        if(date != ""){
          date = date.replaceAll("-","");
          try {
            chStart = df.parse(date).getTime();
            chStart -= 86400000;
            Date aa = new Date(chStart);
            date = df.format(aa);

            String basicYear = date.substring(0, 4);
            String basicMonth = date.substring(4, 6);
            String basicDay = date.substring(6, 8);
            basicDate = basicYear+"년 "+basicMonth+"월 "+basicDay+"일  17:00";

          } catch (ParseException e) {
            e.printStackTrace();
          }
        }
         return basicDate;
      }
}