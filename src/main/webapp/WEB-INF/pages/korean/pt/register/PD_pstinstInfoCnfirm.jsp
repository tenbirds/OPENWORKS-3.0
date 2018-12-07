<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%  response.setHeader("Cache-control","no-cache"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>회원의 소속기관정보 확인</title>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>
	<script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
	<script type="text/javascript" src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<script type="text/javascript" src="/resources/cmmnty/common/js/fakeselect.js"></script>
    
    <script type="text/javascript" src="/resources/openworks/spi/jquery/form/jquery.form.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/validate/jquery.validate.css" />
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/jquery.validate.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/additional-methods.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/jquery.validate.settings.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/jquery.validate.messages.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/colobox/themes/theme5/colorbox.css" />
    
    
    <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" />
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript">
    $().ready(function(){
        
    });
    var jsGoUpdt = function() {
        parent.jsInfoUpdt();
    };
    var jsCancel = function() {
        parent.$.colorbox.close();
    };
    
    var jsPblinsttNmCnfirm = function(){
        var url = "ND_pblinsttNmCnfirmAction.do";
		$("#dataForm").ajaxSubmit({
			url		: url,
			type	: "GET",
			cache   : false,
			async	: false,
			success	: function (result) {
			    if(result > 0){
			        parent.thisEl = true;
			        jsCancel();
			        return false;
				}else{
				    alert('기관정보확인 업데이트 오류:\r\n담당자에게 문의하시기바랍니다.');
				    return false;
				}	
			},
			error : function(result) {
				alert(result.statusText+":"+result.status+":"+result.responseText);
				return false;
            }
		});
    };
    </script>
</head>

<body class="winPopup pwChng">
<form id="dataForm" name="dataForm">
    <h2>회원의 소속기관정보 확인<a href="#" onclick="jsCancel();">닫기</a></h2>
    <div style="padding:10px 10px 10px 10px;">
		<p style="line-height:20px;">
			수요예보조사 참여를 위해 현재 회원님의 소속기관정보와 일치하는지 확인이 필요합니다.<br />
			<i>※ 소속기관정보와 일치한다면 ‘수요예보조사 참여’를 선택하시기 바랍니다.<br />
               ※ 소속기관정보를 변경하시려면 ‘회원정보 변경’ 하시기 바랍니다.  
            </i>
		<p>
        
		<table class="tbl_st4">
			<tr>
				<th>기관명</th>
				<td>${loginData.orgnNm}</td>						
			</tr>					
		</table>
                
		<br />
		<div class="btnArea" style="padding-top:5px;">
			<a href="#"  onclick="jsGoUpdt();return false;" class="btns st4" style="width:150px;">회원정보 변경</a>        
			<a href="#"  onclick="jsPblinsttNmCnfirm();" class="btns st1" style="width:150px;">수요예보조사 참여</a>
		</div>
		
	</div>
	</form>
</body>
</html>


