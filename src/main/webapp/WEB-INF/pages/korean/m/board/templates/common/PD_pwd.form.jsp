<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
	<title>글 비밀번호 확인</title>

	<script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>
	<op:jsTag type="spi" items="jquery,notice,colorbox,printpreview" />
	<op:jsTag type="openworks" items="web-core" />

	<script type="text/javascript">
		$(function(){
			$("#registPassword")[0].focus();

			$("#dataForm").submit(function(){
				dataString = $("#dataForm").serialize();
				$.ajax({
					type: "POST",
					url: "ND_pwd.confirm.do",
					data: dataString,
					dataType: "json",
					success: function(response){
						if(!response.result){
							alert("비밀번호가 맞지 않습니다.");
						}else{
							parent.$("#dataForm input[name=bbsCd]").val("${param.bbsCd}");
							parent.$("#dataForm input[name=bbscttSeq]").val("${param.bbscttSeq}");
							parent.jsRequest("dataForm", "BD_board.view.do", "get");
							parent.$.fn.colorbox.close();
						}
					}
				});
				return false;
			});
		});
	</script>
</head>
  
<body>  

<form id="dataForm" name="dataForm" method="post" action="ND_pwd.confirm.do">
	<input type="hidden" name="bbsCd" value="${param.bbsCd}" />
	<input type="hidden" name="bbscttSeq" value="${param.bbscttSeq}" />

	<!-- 글 비밀번호 확인 폼 시작 -->
	<div id="popup" style="width:360px;"> 
		<div class="pop_pad">
			<h1><img src="/resources/web/theme/default/images/community/pop_tit_pwd.gif" alt="비밀번호입력"/></h1>
			 <fieldset>
			  <legend>비밀번호입력</legend>				
				<div class="p_pwd">
					<label for="pwd">비밀번호</label>
	                <input type="password" id="registPassword" name="registPassword" maxlength="20" title="비밀번호를 입력해주세요." />
					<input type="image" alt="검색" src="/resources/web/theme/default/images/btn/btn_g_confirm.gif" />
				</div>
			</fieldset>
			<p class="tx_c">* <span class="tx_blue_n">글 등록 시 사용한 비밀번호</span>를 입력하세요.</p>
		</div>
		<div id="bottom">
			<div class="close">
				<a href="#" onclick="parent.$.fn.colorbox.close();"><img src="/resources/web/theme/default/images/btn/pop_close.gif" alt="닫기" /></a>
			</div>
		</div>
	</div>
	<!-- 글 비밀번호 확인 폼 끝 -->

</form>

</body> 
  
</html>