<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>주소검색</title>
		<%
			request.setCharacterEncoding("UTF-8");//해당시스템의인코딩타입이UTF-8일경우
			//request.setCharacterEncoding("EUC-KR");//해당시스템의인코딩타입이EUC-KR일경우
			String inputYn= request.getParameter("inputYn");
			String roadFullAddr= request.getParameter("roadFullAddr");
			String roadAddrPart1 = request.getParameter("roadAddrPart1");
			String roadAddrPart2 = request.getParameter("roadAddrPart2");
			String engAddr= request.getParameter("engAddr");
			String jibunAddr= request.getParameter("jibunAddr");
			String zipNo= request.getParameter("zipNo");
			String addrDetail= request.getParameter("addrDetail");
			String admCd= request.getParameter("admCd");
			String rnMgtSn= request.getParameter("rnMgtSn");
			String bdMgtSn= request.getParameter("bdMgtSn");
		%>
		<script language="javascript">
			function init(){
				var url= location.href;
				var confmKey= "U01TX0FVVEgyMDE2MTAxMDExNDUxOTE1NjM2"; // 연계신청시부여받은승인키입력(테스트용승인키: TESTJUSOGOKR)
				var resultType= "4";//도로명주소검색결과화면출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
				var inputYn= "<%=inputYn%>";
				if(inputYn!= "Y") {
					document.form.confmKey.value= confmKey;
					document.form.returnUrl.value= url;
					document.form.resultType.value= resultType;
					document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망(행정망의경우별도문의)
					document.form.submit();
				} else {
				
				    opener.$("#"+ opener.$("#zipCodeId").val()).val('<%=zipNo%>');
				    //parent.$("#"+ parent.$("#zipCodeId").val()+"2").val(zipcode[1]);
					opener.$("#"+ opener.$("#baseAddrId").val()).val('<%=roadAddrPart1%>');
					opener.$("#"+ opener.$("#detailAddrId").val()).val('<%=addrDetail%>');
					//parent.$("#"+ parent.$("#detailAddrId").val()).focus();
					
					//parent.$.fn.colorbox.close();
					<%-- opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>"); --%>
					window.close();
				}
			}
		</script>
	</head>
	<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
	</form>
	</body>
</html>