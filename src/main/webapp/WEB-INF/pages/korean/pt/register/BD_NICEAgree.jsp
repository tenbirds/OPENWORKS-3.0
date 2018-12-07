<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE>
<html lang="ko">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공인인증서 인증 - 판매 권한 신청</title>
<script type="text/javascript">

var jsRegist = function() {
    if(!$("#agr_pc").is(':checked')){
        alert(Message.msg.agreeTerms);
        $("#agr_pc").focus();
        return false;
    }
    
    $("#dataForm").submit();
};

</script>
</head>
<body>

	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/offer_step_4.png" alt="공인인증서 인증" />
			<h2>제공(판매) 권한 신청</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	<form id="dataForm" name="dataForm" action="${ND_niceAgreeAction.do}" method="post">
	<div class="conWrap certiPc">
		<h3>
			<i class="quot">협약서 날인을 공인인증서 인증으로 대체하며<br /> 클라우드서비스 공급 권한을 신청 합니다.</i>
		</h3>
		
		<div>
			<input type="checkbox" id="agr_pc" /> <label for="agr_pc">공인인증서 인증 동의</label>
			<a href="#" onclick="jsRegist();">공인 인증서 인증</a>	
		</div>
	</div>
	<!--// content -->
	</form>
</body>
</html>