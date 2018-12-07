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
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="-1" />
    <title>회원정보 수정 요청</title>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/colobox/themes/theme5/colorbox.css" />
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
    }
    var jsCancel = function() {
        parent.$.colorbox.close();
    }
    </script>
</head>

<body class="winPopup pwChng">
<form id="passwordForm" name="passwordForm">
        <input type="hidden" name="userId"   id="userId"   value=""/>
    <h2>회원정보 수정 요청 <a href="#" onclick="jsCancel();">닫기</a></h2>
    <div style="padding:10px 10px 10px 10px;">
		<p style="line-height:20px;">
			기관정보 확인되지 않아 수요예보조사 실행이 불가능 합니다. <br />
			기관정보 업데이트를 위해 회원정보로 이동합니다. 
		<p>
		<br />
		<div class="btnArea" style="padding-top:5px;">
			<a href="#"  onclick="jsGoUpdt();return false;" class="btns st1" style="width:110px;">회원정보 이동</a>
		</div>
		
	</div>
	</form>
</body>
</html>


