<!--	#######################################################################################		-->
<!--	#####																						-->
<!--	#####	기업실명확인 서비스 샘플 페이지 소스						한국신용정보(주)		-->
<!--	#####																						-->
<!--	#####	===============================================================================		-->
<!--	#####																						-->
<!--	#####	* 본 페이지는 귀사의 화면에 맞게 수정하십시오.										-->
<!--	#####	  단, Head 영역에 설정된 Javascript를 수정하거나 변경하시면 사용할 수 없습니다.		-->
<!--	#####																						-->
<!--	#######################################################################################		-->

<html>
	<head>
		<title>한국신용정보주식회사 기업실명확인 서비스 샘플 페이지</Title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

		<!--	==========================================================	-->
		<!--	한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)	-->
		<!--	==========================================================	-->
		<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
		<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
		<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>

	</head>

	<script language="javascript">
		document.onkeydown = onKeyDown;

		function onKeyDown( event )
		{
			var e = event;
			if ( event == null ) e = window.event;

			if ( e.keyCode == 13 ) goIDCheck();
		}

		function loadAction()
		{
			document.pageForm.bizNo.focus();
		}

		function validate()
		{
			var bizNm = document.pageForm.bizNm;
			var bizNo = document.pageForm.bizNo;
			var infoFlag = document.pageForm.infoFlag;

			//	사업자/법인번호에서 '-'를 제거한다.
			bizNo.value = bizNo.value.replace( /-/g, '' );

			if ( bizNo.value == "" )
			{
				alert( getCheckMessage( "S41" ) );
				bizNo.value = "";
				bizNo.focus();
				return false;
			}

			if ( bizNm.value == "" )
			{
				alert( getCheckMessage( "S42" ) );
				bizNm.focus();
				return false;
			}

			if ( checkString( bizNm.value ) == false )
			{
				alert( getCheckMessage( "S43" ) );
				bizNm.focus();
				return false;
			}

			if ( checkNumeric( bizNo.value ) == false )
			{
				alert( getCheckMessage( "S44" ) );
				bizNo.focus();
				return false;
			}

			if ( infoFlag[1].checked )
			{
				if ( checkBizNo( bizNo.value ) == false )
				{
					alert( getCheckMessage( "S45" ) );
					bizNo.focus();
					return false;
				}
			}

			return true;
		}

		function goIDCheck()
		{
			if ( validate() == true )
			{
				var strNm = document.pageForm.bizNm.value;
				var strNo = document.pageForm.bizNo.value;
				var strRsn = document.pageForm.inqRsn.value;
				var infoFlag = document.pageForm.infoFlag;
				var strInfoFlag = "3";

				if ( infoFlag[0].checked )
					strInfoFlag = infoFlag[0].value;
				else
					strInfoFlag = infoFlag[1].value;

				document.inputForm.SendInfo.value = makeBizSendInfo( strNo, strNm, strRsn, strInfoFlag );

				var form = document.inputForm;
				form.submit();
			}

			return;
		}

	</script>

	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:loadAction();" >

		<!--	귀사의 도메인으로 설정하십시오. (http://www.귀사의도메인/RNCheckRequest.jsp)	-->
		<!--	다음 페이지로 전달된 form입니다. 추가로 넘길 파라미터가 있으시면 아래 폼에 추가해 주시면 됩니다.-->
		<form name="inputForm" method="POST" action="./RNCheckRequest.jsp">	
			<input type="hidden" id="SendInfo" name="SendInfo"></input>
		</form>

		
		<table align="center" width="50%" border="0" cellSpacing="1" cellpadding="8" bgcolor="#afafaf">
		<form name="pageForm" method="POST">
		<!--	조회사유를 설정하십시오 ( '10'-회원가입, '20'-기존회원 확인, '30'-성인인증, '40'-비회원 확인, '50'-기타 사유 )	-->
		<input type="hidden" id="inqRsn" name="inqRsn" value="10">
			<tr bordercolor="#000000">
	  			<td height="31" colspan="3" bgcolor="#f4f4f4">
					<b>한국신용정보(주) 기업명/법인명 확인 서비스 샘플 페이지 </b>
				</td>
			</tr>

			<tr>
				<td align="right" bgcolor="#CCCCCC">사업자번호/법인번호</td>
			  	<td colspan="2" bgcolor="#FFFFFF">
			  		<input type="password" id="bizNo" name="bizNo" maxlength="13" size="30" value="2148174186">
			  	</td>
			</tr>

			<tr>
				<td align="right" bgcolor="#CCCCCC">기업명/법인명</td>
			  	<td colspan="2" bgcolor="#FFFFFF">
			  		<input type="text" id="bizNm" name="bizNm" size="30" style="ime-mode:active" value="한국신용정보">
			  	</td>
			</tr>
			<tr valign="top" bordercolor="#000000">
				<td  align="center" bgcolor="#CCCCCC">서비스선택</td>
				<td bgcolor="#ffffff">
					 법인번호<Input Type="radio" name="infoFlag" value="3" checked>&nbsp;&nbsp;&nbsp( 13자리 : 999999-9999999)&nbsp;&nbsp <br/>
					 사업자번호<Input Type="radio" name="infoFlag" value="2">&nbsp;&nbsp;(10자리 : 999-99-99999)
				</td>
			</tr>

			<tr valign="top" bgcolor="#FFFFFF">
			  <td colspan="3" align="center"><input name="Confirm" type="button" id="Confirm" value="확인" onclick="javascript:goIDCheck();"></td>
			</tr>
		</form>
		</table>

	</body>
</html>