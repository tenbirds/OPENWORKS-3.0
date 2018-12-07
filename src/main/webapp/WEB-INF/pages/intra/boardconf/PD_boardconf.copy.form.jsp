<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<html>
<head>
	<title>게시판 복사</title>

	<op:jsTag type="spi" items="validate" />
	
	<script type="text/javascript" src="/resources/intra/boardconf/boardconf.js"></script>

	<!-- 유효성 검증 BEAN Annotation 기반 자동 설정 -->
	<valid:script type="msgbox" />

	<script type="text/javascript">
		$().ready(function(){
		    
			var oldBbsCd = parent.jsCheckedArray()[0];
			var domainCd = oldBbsCd.split("|")[0];
			var bbsCd = oldBbsCd.split("|")[1];
			
			var oldBbsNm = parent.$("#" + bbsCd + "_bbsNm").text();
			var oldbbsDc = parent.$("#" + bbsCd + "_bbsDc").text();

			$("#domainCd").val(domainCd);
			$("#bbsCd").val(bbsCd);
			$("#bbsNm").val(oldBbsNm + "_복사본");
			$("#bbsDc").val(oldbbsDc);
			$("#orgBbsNm").text(oldBbsNm);

			$("#dataForm").submit(function(){
				dataString = $("#dataForm").serialize();
				$.ajax({
					type: "POST",
					url: "ND_boardconf.copy.do",
					data: dataString,
					dataType: "json",
					success: function(response){
						if(isNaN(response)){
							alert(response);
						}else{
							alert("게시판을 성공적으로 복사하여 생성했습니다.");
							parent.$.fn.colorbox.close();
							parent.location.reload();
						}
					}
				});				
				return false;
			});
		});

	</script>
</head>

<body>

<form id="dataForm" method="post" action="ND_boardconf.copy.do">
	<input type="hidden" name="domainCd" id="domainCd" value="" />
	<input type="hidden" name="bbsCd" id="bbsCd" value="" />

	<!-- 게시판 복사 폼 시작 -->
	<div class="pop_tit">
		<h1>게시판 복사 생성</h1>
		<a href="#" onclick="parent.$.fn.colorbox.close();"><img src="/resources/openworks/theme/default/images/btn/btn_close.gif" alt="창닫기"/></a>
	</div>

	<ul class="blet">
		<li>게시판 설정을 복사하여 신규 게시판을 생성합니다.</li>
		<li>아래 입력항목에서 게시판 명과 게시판 개요를 수정한 후 복사 버튼을 클릭하세요.</li>
	</ul>

	<table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="게시판 복사 생성">
		<caption>게시판 복사 생성</caption> 
		<colgroup>						  
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tr>
			<th><label for="bbsNm">게시판 명</label> <span class="tx_red tx_b">*</span></th>
			<td>
				<input type="text" id="bbsNm" name="bbsNm" class="w215" maxlength="30" value="" />
				<span class="tx_blue_s">최대 30자</span>
				<valid:msg name="bbsNm" />
			</td>
		</tr>
		<tr>
			<th><label for="bbsDc">게시판 개요</label></th>
			<td>
				<textarea name="bbsDc" id="bbsDc" rows="4" class="w99_p"></textarea>
				<span class="tx_blue_s">최대 300자</span>
				<valid:msg name="bbsDc" />
			</td>
		</tr>
	</table>
	<!-- 게시판 복사 끝 -->
			
	<!-- 게시판 하단 영역 시작 -->
	<p class="tx_c mar_t20">
		<input type="submit" value="확인" class="blue" />
		<input type="button" value="취소" class="blue" onclick="parent.$.fn.colorbox.close();" />
	</p>
	<!-- 게시판 하단 영역 끝 -->

</form>

</body>
</html>