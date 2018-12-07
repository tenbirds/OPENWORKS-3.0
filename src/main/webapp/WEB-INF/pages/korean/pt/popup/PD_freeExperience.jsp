<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>씨앗 마켓</title>	
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/main.css" />
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud/js/common.js"></script>
	<!--[if lt IE 9]>
		<script src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<![endif]-->
	
	<c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/index.do";
        }
    </c:if>
        
    <!-- 사용자 정의 함수 -->
    <script type="text/javascript">
    $().ready(function(){
        var p_popDiv = $('#p_popDiv').val();
        js_selectTab(p_popDiv);
    });
    
    // 무료체험 텝 선택
    var js_selectTab = function(popDiv){
        if(popDiv == "tBiz"){
            $('#mashupA').addClass('on');
            $('#tBizDiv').show();
            $('#ollehBizDiv').hide();
            $('#lgBizDiv').hide();
        }else if(popDiv == "ollehBiz"){
            $('#ollehA').addClass('on');
            $('#tBizDiv').hide();
            $('#ollehBizDiv').show();
            $('#lgBizDiv').hide();
        }else if(popDiv == "lgBiz"){
            $('#webhardA').addClass('on');
            $('#tBizDiv').hide();
            $('#ollehBizDiv').hide();
            $('#lgBizDiv').show();
        }
    };
    
    // 무료체험 텝 선택
    var jsNewTab = function(popDiv){
        // http://www.mashup-plus.com/smp/account/joinMember/joinExperience.do?experienceCd=DY55IU5YD9PLX8IMI2LE
        // http://www.webhard.co.kr/webII/page/free/freetrial.php?free_number=WTENKISOFTSM10
        window.opener.location.href = "http://www.mashup-plus.com/smp/account/joinMember/joinExperience.do?experienceCd=DY55IU5YD9PLX8IMI2LE";
        window.opener.location.target="_blank";
        self.close();

    };
    </script>

</head>
<body>
    <form id="paramForm" name="paramForm">
        <input type="hidden" name="p_popDiv" id="p_popDiv" value="${popDiv}"/>
    </form>

<!-- layer popup -->
<div class="layer-pop">
	<!-- <div class="bg"></div> -->
	<div class="pop-cont green">
		<!-- <button class="btn-close" onclick="javascript:self.close();">닫기</button> -->
		<h3>클라우드서비스 무료체험</h3>

		<div class="section tab-area">
			<ul>
			<li><a href="javascript:js_selectTab('tBiz');"      id="mashupA">MASHUP+</a></li>
			<li><a href="javascript:js_selectTab('ollehBiz');"  id="ollehA">olleh ucloud biz</a></li>
			<li><a href="javascript:js_selectTab('lgBiz');"     id="webhardA">Webhard</a></li>
			</ul>
		</div>
		
		<div id="tBizDiv" style="display:none;">
		    <div class="section ac">
			    <span class="mr10"><img src="/new_cloud/images/main/img-free-lgcns.png" alt="" /></span>
			    <span class="ml10"><img src="/new_cloud/images/main/img-free-mashup.png" alt="" /></span>
			    <p class="mt30 mb20">
				    <strong>기회와 기회를 이어주는 비즈니스 연결고리<br/>매시업플러스의 클라우드서비스를 무료로 체험할 수 있는 기회를 드립니다.</strong>
			    </p>
		    </div>
		    <div class="section border-box mr20 ml20 ac"><img src="/new_cloud/images/main/img-pop-mashup01.jpg" alt="" /></div>
		    <div class="btn-area mt30 mb30 ac">
			    <a href="http://www.mashup-plus.com/smp/account/joinMember/joinExperience.do?experienceCd=DY55IU5YD9PLX8IMI2LE" target="_blank" class="b-btn w80 type3"><strong><span class="mr10 ml10">무료체험 신청</span></strong></a>
		    </div>
		</div>
		<div id="ollehBizDiv" style="display:none;">
			<div class="section ac">
				<span class="mb10"><img src="/new_cloud/images/main/img-free-olleh01.png" alt="" /></span>
				<p class="mt30 mb20">
					<strong>강력한 보안! 손쉬운 서비스 이용!<br/>5,000 기업 고객으로 검증된 KT 클라우드!! 지금 무료로 사용해 보세요.<br/>http://ucloudbiz.olleh.com</strong>
				</p>
				<p>무료 체험 신청하시면  유클라우드 비즈를 통해<br/>서버, 스토리지, DB 등 클라우드 IT 인프라를 무료로 이용해 보실 수 있습니다.<br/>※회원가입 후 신청확인 메일로 무료이용 쿠폰이 발급됩니다. </p>
			</div>
			<div class="section mt20 ac"><img src="/new_cloud/images/main/img-free-olleh02.png" alt="" /></div>
			<div class="btn-area mt20 mb30 ac">
				<a href="https://ucloudbiz.olleh.com/portal/ktcloudportal.epc.free_couponadd.html" target="_blank" class="b-btn w80 type3"><strong><span class="mr10 ml10">무료체험 신청</span></strong></a>
			</div>
		</div>
		<div id="lgBizDiv" style="display:none;">
		    <div class="section ac">
			    <span class="mr10"><img src="/new_cloud/images/main/img-free-lgu.png" alt="" /></span>
			    <span class="ml10"><img src="/new_cloud/images/main/img-free-webhard.png" alt="" /></span>
			    <p class="mt30 mb20">
				    <strong>350만 고객이 선택한 비즈니스솔루션<br/>No.1 업무용 클라우드서비스, 웹하드를 무료로 체험할 수 있는 기회를 드립니다.</strong>
			    </p>
		    </div>
		    <div class="section mt30 mb30 mr20 ml20 ac"><img src="/new_cloud/images/main/img-pop-webhard01.jpg" alt="" /></div>
		    <div class="btn-area mt30 mb30 ac">
			    <a href="http://www.webhard.co.kr/webII/page/free/freetrial.php?free_number=WTENKISOFTSM10" target="_blank" class="b-btn w80 type3"><strong><span class="mr10 ml10">무료체험 신청</span></strong></a>
		    </div>
		</div>

	</div>
</div>
<!-- //layer popup -->

</body>
</html>
