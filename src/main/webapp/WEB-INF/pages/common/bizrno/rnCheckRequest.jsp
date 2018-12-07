<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% /* 2018-07-05 실제 나이스쪽으로 인터페이스는 되고 있으나 상태값에 따른 로직이 없음 주석처리함
	@ include file="nice.nuguya.oivs.jsp"
	*/
%>
<%
	//#######################################################################################
	//#####
	//#####	기업기업실명확인 서비스 소스 (실명확인요청)						한국신용정보(주)
	//#####	( PHPScript 처리 )
	//#####
	//#####	================================================================================
	//#####
	//#####	* 본 페이지는 귀사의 서버에 복사해서 관리하십시오.
	//#####	  페이지를 수정하거나 변경하지 마십시오. (서비스 장애의 원인이 됩니다)
	//#####
	//#######################################################################################

	//=======================================================================================
	//=====	MAIN PROCESS
	//=======================================================================================

	/****************************************************************************************
	 *****	▣ 회원사 ID 설정 : 계약시에 발급된 회원사 ID를 설정하십시오. ▣
	 ****************************************************************************************/

	String strNiceId = "Nhkjbh";

	/****************************************************************************************
	 *****	▣  NiceCheck.htm 에서 넘겨 받은 SendInfo 값을 복호화 하여 
	 *****		주민번호,성명 등 각각의 값을 세팅한다 ▣
	 ****************************************************************************************/

	 /* 2018-07-05 실제 나이스쪽으로 인터페이스는 되고 있으나 상태값에 따른 로직이 없음 주석처리함 */
	//OivsObject oivsObject = new OivsObject();
	//oivsObject.clientData = request.getParameter( "SendInfo" );
	//oivsObject.desClientData();

	// 복호화 된 값은 아래 주석을 풀어 확인 가능합니다. 
	// (기존 회원 체크는 이 부분에서 하시면 됩니다.)


	/****************************************************************************************
	 *****	▣ 기업실명확인 서비스를 호출한다. ▣
	 ****************************************************************************************/
	 
	 /* 2018-07-05 실제 나이스쪽으로 인터페이스는 되고 있으나 상태값에 따른 로직이 없음 주석처리함 */
	//oivsObject.niceId = strNiceId;
	//oivsObject.callService();
/*
	//==================================================================================================================
	//				응답에 대한 결과 및 변수들에 대한 설명
	//------------------------------------------------------------------------------------------------------------------
	//
	//	< 한국신용정보 온라인 식별 서비스에서 제공하는 정보 >
	//
	//	oivsObject.message			: 오류 또는 정보성 메시지
	//	oivsObject.retCd			: 결과 코드(메뉴얼 참고)
	//	oivsObject.retDtlCd			: 결과 상세 코드(메뉴얼 참고)
	//
	//=================================================================================================================
*/


    //String biz_no = oivsObject.bizNo;

	String biz_no = request.getParameter("bizNo");	
	String bizName = request.getParameter("bizName");	


//out.println("biz_no : " + biz_no);
//out.println("bizName : " + bizName);

    String biz_gb = biz_no.substring(3, 5);
    
	String biz_gb1 = "";
	String biz_gb2 = "";
	if(Integer.parseInt(biz_gb) >= 81 && Integer.parseInt(biz_gb) <= 86) {
		biz_gb1 = "2";
		if(biz_gb.equals("81") || biz_gb.equals("85") || biz_gb.equals("86") || biz_gb.equals("87") || biz_gb.equals("88")) {
			biz_gb2 = "20";
		} else if (biz_gb.equals("82")) {
			biz_gb2 = "21";
		} else if (biz_gb.equals("84")) {
			biz_gb2 = "22";
		} else if (biz_gb.equals("83")) {
			biz_gb2 = "23";
		}
	} else {
		biz_gb1 = "1";
		if(Integer.parseInt(biz_gb) >= 1 && Integer.parseInt(biz_gb) <= 79) {
			biz_gb2 = "10";
		} else if(Integer.parseInt(biz_gb) >= 90 && Integer.parseInt(biz_gb) <= 99) {
			biz_gb2 = "11";
		} else if(biz_gb.equals("80") || biz_gb.equals("89")) {
			biz_gb2 = "12";
		}
	}

	String classify = session.getAttribute("classify") != null ? session.getAttribute("classify").toString() : "";
	String idpwse = session.getAttribute("idpwse") != null ? session.getAttribute("idpwse").toString() : "";
	session.setAttribute("bizNo", biz_no);

	//session.setAttribute("bizNm", oivsObject.bizNm);
	session.setAttribute("bizNm", bizName);
%>

<html>
	<head>
		<title>한국신용정보주식회사 기업기업실명확인 서비스 결과</title>
		<script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
		<!--	==========================================================	-->
		<!--	한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)	-->
		<!--	==========================================================	-->
		<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
		<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
		<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
	    
	</head>
	<body bgcolor="#FFFFFF">
		<form id="certfcForm" name="certfcForm" method="post">	
			<input type="hidden" id="strRetCd" name="strRetCd" value="<% // =oivsObject.retCd %>" />
			<input type="hidden" id="strRetDtlCd" name="strRetDtlCd" value="<% // =oivsObject.retDtlCd%>" />
			<input type="hidden" name="userTyCd" value="${param.userTyCd}"/>
			<input type="hidden" name="nationCode" value="${param.nationCode}"/>
			<input type="hidden" name="sbscrbTyCd" value="1004" />

			<input type="text" name="bizNo" value="<%=request.getParameter("bizNo")%>" />			
			<input type="text" name="bizName" value="<%=request.getParameter("bizName")%>" />		

			<input type="text" name="bizNo" value="${bizNo}" />			
			<input type="text" name="bizName" value="${bizName}" />		
        </form>
	</body>
</html>
<script type="text/javascript">
	var strIdpwse = '<%=idpwse%>';
	var strClsfy = '<%=classify%>';
	var strDom = '<c:out value="${SubDomain}" />';
	if(strIdpwse != "" && strClsfy == "2"){		//아이디 패스워드찾기
	    if(strIdpwse == "P"){	//패스워드찾기
	        document.certfcForm.action = "/"+strDom+"/pt/login/user/BD_findPwd3.do";
		}else{	//아이디찾기
		    document.certfcForm.action = "/"+strDom+"/pt/login/user/BD_findId3.do";
		} 
	}else{
	    if(strClsfy == ""){
			//회원가입+판매자전환
			document.certfcForm.action = "/"+strDom+"/pt/register/BD_index.do";
		}
	}
	//결과를 처리한다.
	document.certfcForm.submit();
</script>