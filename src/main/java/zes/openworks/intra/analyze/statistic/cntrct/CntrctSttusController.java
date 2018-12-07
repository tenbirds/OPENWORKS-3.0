package zes.openworks.intra.analyze.statistic.cntrct;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainService;
import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.explorer.ExplorerController;

@Controller
@RequestMapping(value = "/intra/analyze/statistic/cntrct")
public class CntrctSttusController extends GeneralController {
    @Autowired
    DomainService domainService;
    
    @Resource(name = "cntrctSttusService")
    CntrctSttusService service;
    
    /**
     * Explorer 관리 페이지 (프레임)
     */
    @RequestMapping(value = "ND_index.do", method = RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 통계 초기화면
     * BD_cntrctSttus 설명
     * @param request
     * @param model
     * @param vo
     * @throws Exception
     */
    @RequestMapping(value = "BD_cntrctSttus.do")
    public void BD_cntrctSttus(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);        
    }
    
    /**
     * 계약통계(요약)
     * cntrctSttusList 설명
     * @param request
     * @param model
     * @param vo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/cntrctSttusList.do", method = RequestMethod.POST)
    public String cntrctSttusList(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        HashMap<String, String> map = new HashMap<String, String>();
        
        String cntrctYear = request.getParameter("cntrctYear");
        String cntrctType = request.getParameter("cntrctType");
        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        String startDate = "2016.03";
        String endDate = ExplorerController.getFormatDate("yyyy.MM","NOW",0);

        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        map.put("flag", "cntrct");
        map.put("cntrctYear", cntrctYear);
        map.put("cntrctType", cntrctType);

        vo.setIssueDate(issueDate);
        vo.setBasicDate(basicDate);
        vo.setStartDate(startDate);
        vo.setEndDate(endDate);
        vo.setFlag("cntrct");

        vo.setCntrDataList(service.cntrctAmountViewList(map));        
        vo.setCntrTpList(service.cntrctTpList(map));
        vo.setCntrCorpList(service.cntrctCorpList(map));

        return responseJson(model, vo);
    }
    
    /**
     * 서비스 통계
     * BD_service 설명
     * @param request
     * @param model
     * @param vo
     * @throws Exception
     */
    @RequestMapping(value = "BD_service.do")
    public void BD_service(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        
        HashMap<String, String> map = new HashMap<String, String>();
        
        String svcNm     = request.getParameter("svcNm");
        String goodsKnd  = request.getParameter("goodsKnd");
        String sortList  = request.getParameter("sortList");
        String sortVl  = request.getParameter("sortVl");

        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","D",-1);
        String issueDate  = formatDate.replace("-", "");
        String basicDate  = formatDate + " 17:00";
        String startDate  = "2016.03";
        String endDate    = ExplorerController.getFormatDate("yyyy.MM","D",-2);

        map.put("sortList", sortList);
        map.put("sortVl", sortVl);
        
        map.put("svcNm", svcNm);
        map.put("goodsKnd", goodsKnd);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        List cntrctServiceList = service.cntrctServiceList(map);
        
        model.addAttribute("serviceCount", cntrctServiceList.size());
        model.addAttribute("cntrctServiceList", cntrctServiceList);
    }

    @RequestMapping(value = "PD_serviceList.do")
    public void PD_serviceDetailList(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        
        if (Validate.isEmpty(request.getParameter("goodsCode"))) {
            String userId = request.getParameter("userId");
            String goodsMakr = request.getParameter("goodsMakr");//URLDecoder.decode(request.getParameter("svcNm"), "UTF-8");
            
            vo.getDataMap().put("userId", userId);
            vo.getDataMap().put("goodsMakr", goodsMakr);
            
        }else {
            String goodsCode = request.getParameter("goodsCode");
            String svcNm = request.getParameter("svcNm");//URLDecoder.decode(request.getParameter("svcNm"), "UTF-8");
            
            vo.getDataMap().put("goodsCode", goodsCode);
            vo.getDataMap().put("svcNm", svcNm);

        }
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.serviceDetailList(vo));
    }
    
    @RequestMapping(value = "PD_contractList.do")
    public void PD_contractList(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        
        // 한글을 파라미터로 넘길때 코드변환이 필요!! - 한글이 아닌 코드로 넘기는게 좋은데..
        InetAddress inet = InetAddress.getLocalHost();
        String svrIP     = inet.getHostAddress();
        
        String purchsInsttNm = null;
        
        String userTyCd = request.getParameter("userTyCd");
        String basicDate = request.getParameter("basicDate");
        
        if ("192.168.85.26".equals(svrIP) || "192.168.85.31".equals(svrIP) || "192.168.85.32".equals(svrIP)) 
            purchsInsttNm = new String((request.getParameter("purchsInsttNm")).getBytes("8859_1"), "UTF-8"); // 로컬에서 테스트 할때(코드변환필요 한글,한글변환)..
        else
            purchsInsttNm = request.getParameter("purchsInsttNm"); // 서버에 반영할때(코드변환불필요)..
        
        //System.out.println(purchsInsttNm);
        vo.getDataMap().put("purchsInsttNm", purchsInsttNm);
        vo.getDataMap().put("userTyCd", userTyCd);
        vo.getDataMap().put("basicDate", basicDate);
        
        model.addAttribute("purchsInsttNm", purchsInsttNm);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.contractList(vo));
    }
    
    
    /**
     * 제공기업 통계
     * BD_supply 설명
     * @param request
     * @param model
     * @param vo
     * @throws Exception
     */
    @RequestMapping(value = "BD_supply.do")
    public void BD_supply(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        
        HashMap<String, String> map = new HashMap<String, String>();
        
        String smlpzChk  = request.getParameter("smlpzChk");
        String goodsMakr = request.getParameter("goodsMakr");        
        String sortVl    = request.getParameter("sortVl");
        
        
        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        //String startDate = "2016.03";
        //String endDate = ExplorerController.getFormatDate("yyyy.MM","NOW",0);

        map.put("smlpzChk",  smlpzChk);
        map.put("goodsMakr", goodsMakr);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        map.put("sortVl",    sortVl);
        
        List cntrctSupplyList = service.cntrctSupplyList(map); 
        
        model.addAttribute("supplyCount", cntrctSupplyList.size());
        model.addAttribute("cntrctSupplyList", cntrctSupplyList);
    }
    
    /**
     * 이용기관 통계
     * BD_useInstt 설명
     * @param request
     * @param model
     * @param vo
     * @throws Exception
     */
    @RequestMapping(value = "BD_useInstt.do")
    public void BD_useInstt(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        
        HashMap<String, String> map = new HashMap<String, String>();
        
        String userTy  = request.getParameter("userTy");
        String purchsInsttNm  = request.getParameter("purchsInsttNm");
        String sortList  = request.getParameter("sortList");
        String sortVl    = request.getParameter("sortVl");
        
        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        String startDate = "2016.03";
        String endDate = ExplorerController.getFormatDate("yyyy.MM","NOW",0);

        map.put("sortList", sortList);
        map.put("sortVl", sortVl);
        map.put("userTy", userTy);
        map.put("purchsInsttNm", purchsInsttNm);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        List cntrctUseInsttList =  service.cntrctUseInsttList(map);
        
        model.addAttribute("basicDate", basicDate);
        model.addAttribute("useInsttCnt", cntrctUseInsttList.size());
        model.addAttribute("cntrctUseInsttList", cntrctUseInsttList);
    }
    
    /**
     * 지원계약현황
     * BD_sportCntrct 설명
     * @param request
     * @param model
     * @param vo
     * @throws Exception
     */
    @RequestMapping(value = "BD_sportCntrct.do")
    public void BD_sportCntrct(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        
        HashMap<String, String> map = new HashMap<String, String>();
        
        String userTy  = request.getParameter("userTy");
        String purchsInsttNm  = request.getParameter("purchsInsttNm");
        String cntrDt  = request.getParameter("cntrDt");
        
        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate = formatDate.replace("-", "");
        String basicDate = formatDate + " 17:00";
        //String startDate = (vo.getCntrDt()==null) ? "2006-03": vo.getCntrDt() + "2006-03";
        String startDate = "2016.03";
        //String endDate = ExplorerController.getFormatDate("yyyy.MM","NOW",0);

        map.put("userTy", userTy);
        map.put("purchsInsttNm", purchsInsttNm);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        map.put("startDate", startDate);
        map.put("cntrDt", cntrDt);
        
        List cntrctSportList = service.cntrctSportList(map); 
        
        model.addAttribute("cntrctSportTotList", service.cntrctSportTotList(map));
        model.addAttribute("sportCount", cntrctSportList.size());
        model.addAttribute("cntrctSportList", cntrctSportList);
    }
    
    /**
     * 서비스 통계 엑셀 다운로드
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "/INC_serviceListExcel.do")
    public String serviceListExcel(ModelMap model, HttpServletRequest request, ResultVO vo) {
        OpHelper.bindSearchMap(vo, request);
        HashMap<String, String> map = new HashMap<String, String>();
        
        String svcNm     = request.getParameter("svcNm");
        String goodsKnd  = request.getParameter("goodsKnd");
        String sortList  = request.getParameter("sortList");
        String sortVl    = request.getParameter("sortVl");

        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate  = formatDate.replace("-", "");
        String basicDate  = formatDate + " 17:00";

        map.put("sortList", sortList);
        map.put("sortVl", sortVl);
        
        map.put("svcNm", svcNm);
        map.put("goodsKnd", goodsKnd);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        List cntrctServiceList = service.cntrctServiceList(map);
        
        model.put("serviceSize", cntrctServiceList.size());
        model.put("listFlag", "svc");
        model.put("fileName", "서비스 통계");
        model.put("cntrctServiceList", cntrctServiceList);
        
        CntrctSttusListSExcelVO cntrctSttusListSExcel = new CntrctSttusListSExcelVO();
        cntrctSttusListSExcel.setModel(model);
        return responseExcel(model, cntrctSttusListSExcel);
    }
    
    
    @RequestMapping(value = "/INC_supplyListExcel.do")
    public String supplyListExcel(ModelMap model, HttpServletRequest request, ResultVO vo) {
        OpHelper.bindSearchMap(vo, request);
        HashMap<String, String> map = new HashMap<String, String>();

        String svcNm     = request.getParameter("svcNm");
        String goodsKnd  = request.getParameter("goodsKnd");
        String sortList  = request.getParameter("sortList");
        String sortVl    = request.getParameter("sortVl");

        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate  = formatDate.replace("-", "");
        String basicDate  = formatDate + " 17:00";

        map.put("sortList", sortList);
        map.put("sortVl", sortVl);
        
        map.put("svcNm", svcNm);
        map.put("goodsKnd", goodsKnd);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        List cntrctSupplyList = service.cntrctSupplyList(map);
        
        model.put("supplySize", cntrctSupplyList.size());
        model.put("fileName", "제공기업 통계");
        model.put("listFlag", "sup");
        model.put("cntrctSupplyList", cntrctSupplyList);
        
        CntrctSttusListSExcelVO cntrctSttusListSExcel = new CntrctSttusListSExcelVO();
        cntrctSttusListSExcel.setModel(model);
        return responseExcel(model, cntrctSttusListSExcel);
    }
    
    
    @RequestMapping(value = "/INC_useInsttListExcel.do")
    public String useInsttListExcel(ModelMap model, HttpServletRequest request, ResultVO vo) {
        OpHelper.bindSearchMap(vo, request);
        HashMap<String, String> map = new HashMap<String, String>();

        String svcNm     = request.getParameter("svcNm");
        String goodsKnd  = request.getParameter("goodsKnd");
        String sortList  = request.getParameter("sortList");
        String sortVl    = request.getParameter("sortVl");

        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate  = formatDate.replace("-", "");
        String basicDate  = formatDate + " 17:00";

        map.put("sortList", sortList);
        map.put("sortVl", sortVl);
        
        map.put("svcNm", svcNm);
        map.put("goodsKnd", goodsKnd);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        List cntrctUseInsttList = service.cntrctUseInsttList(map);
        
        model.put("useInsttSize", cntrctUseInsttList.size());
        model.put("fileName", "이용기관 통계");
        model.put("listFlag", "use");
        model.put("cntrctUseInsttList", cntrctUseInsttList);
        
        CntrctSttusListSExcelVO cntrctSttusListSExcel = new CntrctSttusListSExcelVO();
        cntrctSttusListSExcel.setModel(model);
        return responseExcel(model, cntrctSttusListSExcel);
    }
    
    
    @RequestMapping(value = "/INC_sportCntrctListExcel.do")
    public String sportCntrctListExcel(ModelMap model, HttpServletRequest request, ResultVO vo) {
        OpHelper.bindSearchMap(vo, request);
        HashMap<String, String> map = new HashMap<String, String>();

        String svcNm     = request.getParameter("svcNm");
        String goodsKnd  = request.getParameter("goodsKnd");
        String sortList  = request.getParameter("sortList");
        String sortVl    = request.getParameter("sortVl");

        String formatDate = ExplorerController.getFormatDate("yyyy-MM-dd","NOW",0);
        String issueDate  = formatDate.replace("-", "");
        String basicDate  = formatDate + " 17:00";

        map.put("sortList", sortList);
        map.put("sortVl", sortVl);
        
        map.put("svcNm", svcNm);
        map.put("goodsKnd", goodsKnd);
        map.put("issueDate", issueDate);
        map.put("basicDate", basicDate);
        
        List cntrctSportList = service.cntrctSportList(map);
        
        model.put("sportSize", cntrctSportList.size());
        model.put("fileName", "지원계약 현황");
        model.put("listFlag", "spo");
        model.put("cntrctSportList", cntrctSportList);
        
        CntrctSttusListSExcelVO cntrctSttusListSExcel = new CntrctSttusListSExcelVO();
        cntrctSttusListSExcel.setModel(model);
        return responseExcel(model, cntrctSttusListSExcel);
    }
}