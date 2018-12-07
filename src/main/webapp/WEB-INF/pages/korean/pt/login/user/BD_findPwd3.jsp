<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>비밀번호 찾기 3단계</title>
	<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
	<op:jsTag type="spi" items="form,validate" />
	<op:jsTag type="openworks" items="ui"/>
	<script type="text/javascript" src="/resources/openworks/login/js/validationOfPassword.js"></script>
	<script type="text/javascript">
		$().ready(function(){
		    <c:if test="${!empty hpSecs}">
		    	alert("휴대전화 인증에 성공하였습니다.");
		    </c:if>
		    <c:if test="${!empty ipinSecs}">
		    	alert("아이핀 인증에 성공하였습니다.");
		    </c:if>
		    <c:if test="${!empty bizNoSecs}">
		    	alert("사업자번호 인증에 성공하였습니다.");
		    </c:if>

	        $("#dataForm").validate({
	            rules: {
	                userPassword: {
	                    required: true, 	rangelength: [10, 16]
	                },
	                confirm_userPassword: {
	                    required: true, nowhitespace: true,	rangelength: [10, 16],
	                    equalTo: "#userPassword"
	                }
	            },
	            submitHandler: function(form) {
	                $(form).ajaxSubmit({
	                    url	    : "ND_passwordUpdateAction.do",
	                    type    : "POST",
	                    success : function(response) {
	                        if(response.indexOf("-1") > -1){
	                            alert(Message.msg.passwordSame);
	                        }else{
		                        if(eval(response)) {
		                            alert(Message.msg.processOk);
		                            top.location.href = "/korean/pt/index.do";
		                        } else {
		                            alert(Message.msg.processFail);
		                        }
	                        }
	                    },
	                    error :  function(response) {
	                        alert(response.responseText);
	                        return;
	                    }
	                });
	            }
	        });
		});
		
		function jsUpdateAction(){
		    $("#dataForm").submit();
		}
		
		//비밀번호 적합성 검사
		var pwdUseYn = function(){  
	        var pwd = $("#userPassword").val();
	        var userId = $("#userId").val();
	        var brthdy = $("#brthdy").val();
	        var email = $("#email1").val();
	        var mbtlnum = $("#mbtlnum").val();
	        if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
	            $("#userPassword").focus();
	            alert(Message.msg.passwordCheck2);
	            return false;
	        }
			//개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수
	        vrtn = validPwd(pwd, userId, brthdy, email, mbtlnum);
	        if(vrtn != ''){
	            $("#userPassword").focus();
	            alert(vrtn);
	            return false;
	        } else {
	            return true;
	        }
	    };
	</script>
</head>
<body>
	<%-- <!-- container -->
	<div id="container">
		<!-- contents -->
		<div id="contents">
			<section class="member margin">
				<div class="tab_idpw">
					<ul>
						<li class="off"><a href="BD_index.do">아이디 찾기</a></li>
						<li><a href="BD_findPwd.do">비밀번호 찾기</a></li>
					</ul>
				</div>
				<div class="step margin">
					<span><em class="step01">기본정보 입력</em></span>
					<span><em class="step02">인증정보 입력</em></span>
					<span class="end"><em class="step03 on">비밀번호 재발급</em></span>
				</div>

				<h3><span>비밀번호 찾기</span>비밀번호 재발급</h3>
				<p>새로운 비밀번호를 입력하신 후 사용해 주세요.</p>
				<form name="dataForm" id="dataForm" method="post">
					<fieldset class="pw">
						<legend><span>비밀번호 재발급 정보입력 서식</span></legend>
						<table class="tbl_list_input e_certify">
							<caption>
								<strong>비밀번호 정보 입력</strong>
								<details>
									<summary>아이디, 비밀번호, 비밀번호 확인 정보를 입력하는 서식입니다.</summary>
								</details>
							</caption>
							<colgroup>
								<col style="width:148px">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td><c:out value="${fUserId}" /></td>
									<input type="hidden" id="userId" name="userId" value="<c:out value='${fUserId}' />" />
								</tr>
								<tr>
									<th><label for="userPassword">비밀번호</label></th>
									<td class="rel">
										<a href="#tooltip" class="q_mark m01"></a>	
										<div class="q_guide" tabindex="0" style="width:415px;">
											<span class="q_edge" style="right:55%;"><img src="/resources/web/theme/default/images/common/bg/bg_tooltip_edge.gif" alt="툴팁"></span>
											<div>
												<strong>사용가능 비밀번호 조건</strong>
												<p>- 영문 대/소문자, 숫자, 특수문자를 포함한&nbsp;10자 이상~16자 이내&nbsp;(공백 입력불가)</p>
												<p>- 사용자는 영문자+숫자 혼용 사용</p>
												<p>- 다음과 같은 비밀번호 사용 불가<br />(이메일, 전화번호 ,휴대전화 ,생년월일 ,아이디, 연속된 숫자, 동일한 숫자)</p>
											</div>
										</div>
										<input type="password" id="userPassword" style="width:286px;" name="userPassword" title="비밀번호를 보안등급에 맞게 입력해주세요" value="" maxlength="16" onchange="pwdUseYn();" />
									</td>
								</tr>
								<tr>
									<th><label for="confirm_userPassword">비밀번호 확인</label></th>
									<td class="sub"><input type="password" id="confirm_userPassword" style="width:286px;" name="confirm_userPassword" title="비밀번호와 동일하게 입력해주세요" value="" maxlength="16" /></td>
								</tr>
							</tbody>
						</table>
						
						<div class="btn_area">
							<div class="btn_r">
								<div class="btn_navi">
									<a href="#none" onclick="jsUpdateAction();"><span class="confirm">확인</span></a>
								</div>
							</div>
						</div>
					</fieldset>
				</form>			
			</section>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container --> --%>
	<!-- container -->
		<div id="container" class="join-wrap">

			<!-- contents -->
			<div class="contents">
				
				<!-- section -->
				<div class="section">
					<!-- tab-type1 -->
					<div class="tab-type1">
						<ul>
						<li class="on"><a href="BD_findId.do">아이디 찾기</a></li>
						<li><a href="BD_findPwd.do">비밀번호 찾기</a></li>
						</ul>

						<div class="step">
							<span class="step02"><em>기본정보 입력</em></span>
							<span class="step03"><em>인증정보 입력</em></span>
							<span class="step04 on"><em>비밀번호 재발급</em></span>
						</div>
					</div>
					<!-- //tab-type1 -->
				</div>
				<!-- //section -->

				<!-- title-area -->
				<div class="title-area">
					<h2>비밀번호 재발급</h2>
					<p class="txt-explain ml20 mb20">새로운 비밀번호를 입력하신 후 사용해 주세요.</p>
				</div>
				<!-- //title-area -->

				<!-- section -->
				<div class="section">
					
					<div class="type-list">					
						<form name="dataForm" id="dataForm" method="post">
						<!-- 비밀번호 재발급 -->
						<div class="type-write">
							<table>
								<colgroup>
									<col style="width:150px;" />
									<col style="width:;" />
								</colgroup>
								<tbody>
									<tr>
										<th><span>아이디</span></th>
										<td>
											<c:out value="${fUserId}" /></td>
											<input type="hidden" id="userId" name="userId" value="<c:out value='${fUserId}'/>"/>
									</tr>
									<tr>
										<th><span>비밀번호</span></th>
										<td>
											<input type="password" id="userPassword" name="userPassword" title="비밀번호를 보안등급에 맞게 입력해주세요" value="" maxlength="16" onchange="pwdUseYn();" class="w304" />
										</td>
									</tr>
									<tr>
										<th><span>비밀번호 확인</span></th>
										<td>
											<input type="password" id="confirm_userPassword" name="confirm_userPassword" title="비밀번호와 동일하게 입력해주세요" value="" maxlength="16" class="w304" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						</form>
						<!-- //비밀번호 재발급 -->
					</div>

				</div>
				<!-- //section -->
				<!-- btn -->
				<div class="btn-area ar">
					<a href="#none" onclick="jsUpdateAction();" class="b-btn type2"><strong><span class="ml20 mr20">확인</span></strong></a>
				</div>
				<!-- //btn -->

			</div>
			<!-- //contents -->

		</div>
		<!-- //container -->
</body>
</html>