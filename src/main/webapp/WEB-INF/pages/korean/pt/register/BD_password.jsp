<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="UTF-8" />
  <title>정보수정 - 일반 회원</title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
	$().ready(function() {
	    $("#userPwd").focus();
	    $("#userPwd").bind("keypress", {}, enterEvent);
	});
	
    var jsConfirm = function(){
        if($("#userPwd").val() == '') {
            alert(Message.msg.emptyPwd);
            $("#userPwd").focus();
            return false;
        }
        $('#dataForm').submit();
    };
    
    var enterEvent = function(e) {
        if(e.keyCode == 13) {
            return jsConfirm();
        }
    };
</script>
</head>
<body>
    <!-- container -->
		<div id="container" class="conWrap">
			<form id="dataForm" name="dataForm" action="ND_checkPassword.do" method="post">
				<!-- title-area -->
<!-- 				<div class="title-area"> -->
<!-- 					<h2 class="gray-border">회원정보 변경</h2> -->
<!-- 				</div> -->
				<!-- //title-area -->

				<div class="join_info modify">
				<h3 class="fcol_1">
					<i class="quot">비밀번호 재확인</i>
				</h3>
				<p>
					회원님의 정보를 안전하게 보호하기 위해<br />비밀번호를 다시 한번 확인 합니다.
				</p>
				
				<div class="certi">		
					<table class="tbl_st4" summary="회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.">
						<caption>비밀번호 재확인</caption>
						<colgroup>
							<col width="10%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
						<tr>
							<th scope="col"><label for="userId">아이디</label></th>
							<td><input type="text" value="${sessionScope['__usk'].userId}" readonly="readonly" id="userId" name="userId"/></td>							
						</tr>
						<tr>
							<th scope="col"><label for="userPwd">비밀번호</label></th>
							<td><input type="password"  name="userPwd" id="userPwd" autofocus="autofocus" id="" /></td>
						</tr>
						</tbody>
					</table>
					
					<div class="btnArea rig">
						<a href="/korean/pt/index.do" class="btns st2">취소</a>
						<a href="#" onclick="jsConfirm();" class="btns st1 icn icnCheck">확인</a>
					</div>
				</div>
				</div>
				</form>
		</div>
		<!-- //container -->
</body>
<%-- 
<body>
    <!-- container -->
		<div id="container" class="join-wrap">

			<!-- contents -->
			<div class="contents">
				<form id="dataForm" name="dataForm" action="ND_checkPassword.do" method="post">
				<!-- title-area -->
				<div class="title-area">
					<h2 class="gray-border">회원정보 변경</h2>
				</div>
				<!-- //title-area -->

				<p class="deco-tit ac">비밀번호 재확인</p>
				
				<div class="email-form">					
					<p class="ac">회원님의 정보를 안전하게 보호하기 위해<br/>비밀번호를 다시 한번 확인 합니다.</p>
					
					<ul class="email-form">
					<li>
						<dl>
							<dt>아이디</dt>
							<dd><input type="text" value="${sessionScope['__usk'].userId}" readonly="readonly" id="" /></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>비밀번호</dt>
							<dd><input type="password"  name="userPwd" id="userPwd" autofocus="autofocus" id="" /></dd>
						</dl>
					</li>
					</ul>
					<div class="btn-area mt20 ar">
						<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1015" class="b-btn cancel type1"><strong><span>취 소</span></strong></a>
						<a href="#" onclick="jsConfirm();" class="b-btn confirm type2"><strong><span>확 인</span></strong></a>
					</div>
				</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
</body>
--%>
</html>