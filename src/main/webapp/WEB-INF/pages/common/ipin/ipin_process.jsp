<%@ page contentType="text/html;charset=UTF-8" %>

<%
	/*********************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 사용자 인증 정보 처리 페이지
		
				   수신받은 데이터(인증결과)를 메인화면으로 되돌려주고, close를 하는 역활을 합니다.
	**********************************************************************************************/
	
	// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다. (ipin_main.jsp 페이지에서 암호화된 데이타와는 다릅니다.)
	String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
	
	// ipin_main.jsp 페이지에서 설정한 데이타가 있다면, 아래와 같이 확인가능합니다.
	String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
	String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
	String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");
    
    
    // 암호화된 사용자 정보가 존재하는 경우
    if (!sResponseData.equals("") && sResponseData != null)
    {

%>

<html>
<head>
	<title>NICE평가정보 가상주민번호 서비스</title>
	<script language='javascript'>
		
		// 당사에서는 최상위를 설정하기 위해 'parent.opener.parent.document.'로 정의하였습니다.
		// 따라서 귀사에 프로세스에 맞게 정의하시기 바랍니다.
		<%--parent.opener.parent.document.vnoform.enc_data.value = "<%= sResponseData %>";--%>
		opener.document.vnoform.enc_data.value = "<%= sResponseData %>";
		<%--//parent.opener.parent.document.vnoform.param_r1.value = "<%= sReservedParam1 %>";--%>
		opener.document.vnoform.param_r1.value = "<%= sReservedParam1 %>";
		<%--//parent.opener.parent.document.vnoform.param_r2.value = "<%= sReservedParam2 %>";--%>
		opener.document.vnoform.param_r2.value = "<%= sReservedParam2 %>";
		<%--//parent.opener.parent.document.vnoform.param_r3.value = "<%= sReservedParam3 %>";--%>
		opener.document.vnoform.param_r3.value = "<%= sReservedParam3 %>";
		//parent.opener.parent.document.vnoform.target = "Parent_window";
		opener.document.vnoform.target = "Parent_window";
		// 인증 완료시에 인증결과를 수신하게 되는 귀사 클라이언트 결과 페이지 URL
		//parent.opener.parent.document.vnoform.action = "ipin_result.do";
		opener.document.vnoform.action = "/common/ipin/ipin_result.do";
		//parent.opener.parent.document.vnoform.submit();
		opener.document.vnoform.submit();
		
		self.close();
		
	</script>
</head>
<body>

<%
	} else {
%>

<html>
<head>
	<title>NICE평가정보 가상주민번호 서비스</title>
	<script language='javascript'>
	 	self.close();
	</script>
<body>
<%
	}
%>
<%!
	public static String requestReplace (String paramValue, String gubun) {
        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%>

</body>
</html>