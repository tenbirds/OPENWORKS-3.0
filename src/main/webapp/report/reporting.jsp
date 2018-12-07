<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="zes.core.utils.Converter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PREVIEW</title>
<!-- <script src="cxviewer.js"></script> -->
<script LANGUAGE=javascript>
function rdopen()
{
  document.write('<OBJECT id=rdpdf50 classid="clsid:0D0862D3-F678-48B5-876B-456457E668BC" width=0% height=0% codebase="cab/rdpdf50.cab#version=2,2,0,89"></OBJECT>');
	document.write('<OBJECT id=cxviewer classid="clsid:04931AA4-5D13-442f-AEE8-0F1184002BDD" codebase="cab/cxviewer60u.cab#version=6,3,3,194" width=100% height=100%></OBJECT>');
	//cxviewer.ApplyLicense("http://202.30.77.183:8080/DataServer/rdagent.jsp");  
	cxviewer.ApplyLicense("http://202.30.77.182:8080/DataServer/rdagent.jsp");
// 	cxviewer.ApplyLicense("http://202.30.77.190:8080/DataServer/rdagent.jsp");
	
  var section = '<%=Converter.XSS(request.getParameter("reportSection"))%>';
  var langCodes = '<%=Converter.XSS(request.getParameter("q_langCodes"))%>';
  
  if ( langCodes == "L" ){ langCodes="";}else{ langCodes = langCodes.substring(1);}
    var beginDate				= '<%=Converter.XSS(request.getParameter("q_beginDate"))%>';
    var endDate					= '<%=Converter.XSS(request.getParameter("q_endDate"))%>';
    var domain					= '<%=Converter.XSS(request.getParameter("domain"))%>';
    var searchText			= '<%=Converter.XSS(request.getParameter("searchText"))%>';
    var pagingStartNum	= '<%=Converter.XSS(request.getParameter("pagingStartNum"))%>';
    var pagingEndNum		= '<%=Converter.XSS(request.getParameter("pagingEndNum"))%>';
    var yyyymmdd				= '<%=Converter.XSS(request.getParameter("yyyymmdd"))%>';
    var goodsCode				= '<%=Converter.XSS(request.getParameter("goodsCode"))%>';
    var commUserId			= '<%=Converter.XSS(request.getParameter("commUserId"))%>';
    var notifyNum				= '<%=Converter.XSS(request.getParameter("notifyNum"))%>';
    var notifySeq				= '<%=Converter.XSS(request.getParameter("notifySeq"))%>';
    var cntrctSn				= '<%=Converter.XSS(request.getParameter("cntrctSn"))%>';

    
    switch(section){//서비스등록 통계
	    case '1001' :
	    		var goodsTyCd = '<%=request.getParameter("q_goodsTyCd")%>';
	        cxviewer.FileOpen ("productRegistration.mrd", '/rp  ['+langCodes+'] ['+beginDate+'] ['+endDate+'] ['+goodsTyCd+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '1002' ://서비스별 구매 통계
	        cxviewer.FileOpen ("productPurchase.mrd" , '/rp  ['+langCodes+'] ['+beginDate+'] ['+endDate+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '1003' ://관심서비스 통계
	        cxviewer.FileOpen ("productsInterest.mrd" , '/rp  ['+langCodes+'] ['+beginDate+'] ['+endDate+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '1004' ://광고/배너 통계
	        cxviewer.FileOpen ("advertisingBanner.mrd" , '/rp  ['+langCodes+'] ['+beginDate+'] ['+endDate+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '1005' : //이벤트 통계
	        cxviewer.FileOpen ("event.mrd" , '/rp  ['+langCodes+'] ['+beginDate+'] ['+endDate+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '2001' : //주간보고
	        cxviewer.FileOpen ("weeklyReport.mrd" , '/rv  domain['+domain+'] beginDate['+beginDate+'] endDate['+endDate+'] searchText['+searchText+'] pagingStartNum['+pagingStartNum+'] pagingEndNum['+pagingEndNum+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '2002' : //일일보고
	        cxviewer.FileOpen ("dailyReport.mrd" , '/rv  endDate['+endDate+'] yyyymmdd['+yyyymmdd+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '3001' : //규격서보기    
	        cxviewer.FileOpen ("specificationsReport.mrd" , '/rv  goodsCode['+goodsCode+']  /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '4001' : //실적증명서    
	        cxviewer.FileOpen ("resultCertificateReport.mrd" , '/rv  cntrctSn['+cntrctSn+'] commUserId['+commUserId+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '5001' : //답변서 PaaS (goodsCode는 '코드1', '코드2' 이런식으로 In절에서 바로 쿼리 작동하게 변수 넘기셔야 합니다. ) 
	        cxviewer.FileOpen ("responsePaaSReport.mrd" , '/rv  notifyNum['+notifyNum+'] notifySeq['+notifySeq+'] goodsCode['+goodsCode+'] userId['+commUserId+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
	    case '5002' : //답변서 SaaS
	        cxviewer.FileOpen ("responseSaaSReport.mrd" , '/rv  notifyNum['+notifyNum+'] notifySeq['+notifySeq+'] goodsCode['+goodsCode+'] userId['+commUserId+'] /rfn [http://202.30.77.182:8080/DataServer/rdagent.jsp] /rsn [CEART_REPORTING]');
	        ; break;
    }
    
}
</script>
</head>
<body onload="rdopen ()" leftmargin="0px" rightmargin="0px" topmargin="0px" bottommargin="0px">
</body>
</html>
