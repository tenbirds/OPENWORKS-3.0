<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>판매자 서비스</title>

<script type="text/javascript">
	$().ready(function() {
		var section = "${param.section}";
		if (section != null && section != "") {
			$('.category').addClass('hide');
			$('#category' + section.substr(-1)).removeClass('hide');
			$('.tab_array ul > li > a').removeClass('on');
			$("#" + section).addClass('on');
			$("#section").val(section);
		}
	});

	var jsMovePage = function(page) {

		$("#dataForm input[name=q_currPage]").val(page);
		document.dataForm.action = "BD_goodsOfSeller.do";
		document.dataForm.method = "post";
		document.dataForm.submit();

	};

	var jsView = function(vl) {
		$("#goodsCode").val(vl);
		document.dataForm.action = "inc/BD_storeView.do";
		document.dataForm.submit();
		//         post_to_url("BD_view.do",{"goodsCode":"20141111","pageUrlNm":"premium"});
	};

	var jsSearch = function() {
		document.dataForm.action = "BD_goodsOfSeller.do";
		document.dataForm.elements["q_currPage"].value = "1";
		document.dataForm.submit();
	};

	//Submit 전속 전송  (주소,파라메터,메소드)
	function post_to_url(path, params, method) {
		method = method || "post"; // Post:Get 전송 기본설정은 Post

		var form = document.createElement("form");
		form.setAttribute("method", method);
		form.setAttribute("action", path);

		// 예  {"userId":"abcd","mgrId":"abcd"}
		for ( var key in params) {
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", key);
			hiddenField.setAttribute("value", params[key]);

			form.appendChild(hiddenField);
		}

		document.body.appendChild(form);
		form.submit();
	};

	function selectSort(num) {

		document.dataForm.action = "BD_goodsOfSeller.do";
		document.dataForm.elements["q_currPage"].value = "1";
		document.dataForm.elements["q_sortName"].value = num;
		document.dataForm.submit();
	};
</script>

</head>
<body>

	<form name="dataForm" id="dataForm" method="post"
		action="BD_goodsOfSeller.do">
		<input type="hidden" name="q_currPage" id="q_currPage"
			value="${searchMap.q_currPage}" /> <input type="hidden"
			name="q_sortName" id="q_sortName" value="${searchMap.q_sortName}" />
		<input type="hidden" name="q_sortOrder" id="q_sortOrder"
			value="${searchMap.q_sortOrder}" /> <input type="hidden"
			name="goodsCode" id="goodsCode" value="" /> <input type="hidden"
			name="userId" id="userId" value="<c:out value='${store.USERID}'/>" />
		<input type="hidden" name="section" id="section" value="" />

		<!-- content -->
		<section class="listTit">
			<!-- 타이틀 영역 -->
			<div class="conWrap">
				<h2>제공자서비스</h2>
				<div>
					<i><b>${store.Count.SaaSCount}</b>개의 SaaS, <b>${store.Count.PaaSCount}</b>개의
						PaaS, <b>${store.Count.IaaSCount}</b>개의 IaaS 
				</div>
			</div>
			<!--// 타이틀 영역 -->
		</section>

		<section class="lay_lnb swList">
			<div class="conWrap">
				<nav>
					<!-- 판매자 정보 -->
					<dl class="seller">
						<dt>
							<c:if test="${not empty store.img[0]}">
								<img src="${store.img[0].fileUrl}"
									alt="${store.LANGSTORENM } 로고" width="152">
							</c:if>
							<c:if test="${empty store.img[0]}">
								<img src="/new_cloud/images/sub/img-logo-default.jpg">
							</c:if>
							${store.LANGSTORENM }
						</dt>
						<dd>
							<op:nrToBr content="${store.LANGSTOREINTRCN }" />
						</dd>
					</dl>
					<!--// 판매자 정보 -->
				</nav>
				<div>
					<!-- 검색 조건 -->
					<span class="sel_box"> <select name="q_searchKeyType"
						id="q_searchKeyType" onChange="selectSort(this.value);"
						style="width: 105px; position: absolute; right: -100000px; height: auto;">
							<option value="3"
								<c:if test="${ empty searchMap.q_sortName or searchMap.q_sortName == '3' }">selected="selected"</c:if>>조회순</option>
							<option value="4"
								<c:if test="${ empty searchMap.q_sortName or searchMap.q_sortName == '4' }">selected="selected"</c:if>>구매
								문의순</option>
							<option value="1"
								<c:if test="${ empty searchMap.q_sortName or searchMap.q_sortName == '1' }">selected="selected"</c:if>>최신
								등록순</option>
					</select>
					</span>
					<!--// 검색 조건 -->


					<!-- 이전화면 -->
					<!-- <a href="javascript:history.back(-1);"  class="sbtn back"><strong><span>이전화면</span></strong></a> -->
					<!-- //이전화면 -->

					<!-- section -->
					<table class="tbl_st7">
						<thead>
							<tr>
								<th></th>
								<th>서비스명</th>
								<th>설명</th>
								<th>서비스등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty pager.list}">
								<c:forEach items="${pager.list}" var="_goodsList"
									varStatus="status">
									<c:set var="goosCodes"
										value="${goosCodes},${_goodsList.goodsCode}" />
									<c:set var="goodImage" value="${_goodsList.itemImgUrl}" />

									<tr>
										<th rowspan="2"></th>
										<th rowspan="2"><a href="#"
											onclick="jsView('${_goodsList.goodsCode}');">${_goodsList.goodsNm}
												<c:if test="${not empty dataVo.itemImgUrl}">
													<c:set var="goodImage" value="${_goodsList.itemImgUrl}" />X
											</c:if> <c:if test="${ empty _goodsList.itemImgUrl}">
													<c:set var="goodImage"
														value="${_goodsList.imageFile[0].fileUrl}" />
												</c:if> <img src="${goodImage}" alt="${_goodsList.goodsNm}">
										</a></th>
										<td><a href="#"
											onclick="jsView('${_goodsList.goodsCode}');"><c:if
													test="${fn:length(_goodsList.goodsSumry) >= 140}">
													<c:out value="${fn:substring(_goodsList.goodsSumry,0,140)}" />...</c:if>
												<c:if test="${fn:length(_goodsList.goodsSumry) < 140}">${_goodsList.goodsSumry}</c:if></a>
										</td>
										<td><i>${_goodsList.registDt}</i></td>
									</tr>
									<tr>
										<td>
											<!-- 마크 이미지 있을경우 --> <c:if
												test="${not empty _goodsList.cngdMarkFile}">
												<img alt="${_goodsList.cngdMarkList[0].CNTC_GOODS_NM}"
													src="${_goodsList.cngdMarkFile[0].fileUrl}" />
											</c:if> <c:forEach items="${_goodsList.markFile}" var="fileVo"
												varStatus="status1">
												<c:forEach items="${fileVo}" var="fileVo2"
													varStatus="status2">
													<img alt="마크이미지" src="${fileVo2.fileUrl}" width="33"
														height="33" />
												</c:forEach>
											</c:forEach> <!-- //마크 이미지 있을경우 -->
										</td>
										<td>
											<%-- <label for="prodCompareCheck_"><a href="javascript:" onClick="_serCompare('${_goodsList.goodsCode}')" class="btnPare">비교</a> --%>
											</lable> <input type="hidden" id="goodsNm_${_goodsList.goodsCode}"
											value="${_goodsList.goodsNm}"> <input type="hidden"
											id="storeNm_${_goodsList.goodsCode}"
											value="${_goodsList.langStoreNm}"> <input
											type="hidden" id="goodImage_${_goodsList.goodsCode}"
											value="${goodImage}">
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<op:no-data obj="${pager}" colspan="3" />
						</tbody>
					</table>
					<!-- //list -->

					<!-- paging -->
					<div class="paging">
						<op:pager pager="${pager}" page="pager/webPager.jsp" />
					</div>
					<!-- //paging -->

					<div class="btnArea rig">
						<a href="#" onClick="history.back(-1);" class="btns st4 icn icnPre">이전보기</a>
					</div>
				</div>
				<!-- //section -->
				</section>

			</div>
			<!-- //container -->
	</form>

</body>
</html>