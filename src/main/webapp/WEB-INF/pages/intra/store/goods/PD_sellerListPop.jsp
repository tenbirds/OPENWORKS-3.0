<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<op:jsTag type="spi" items="ui, highlight, form,colorbox" />
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript">
var jsSellerChoice = function() {
    choiceNo = $("input[name='sellerChk']:checked").val();
    if(typeof(choiceNo) == 'string'){
	    parent.$("#userId").val($("#sellerInfo0"+choiceNo).text()).focus(); //판매자아이디
	    parent.$("#sellerInfo1").val($("#sellerInfo1"+choiceNo).val()); //회사명
	    parent.$("#sellerInfo2").val($("#sellerInfo2"+choiceNo).val()); //판매자 구분
	    parent.$("#sellerInfo3").val($("#sellerInfo3"+choiceNo).val()); //판매자 유형
	    parent.$("#sellerInfo4").text($("#sellerInfo4"+choiceNo).text()); //스토어 명
	    parent.$("#goodsChargerNm").val($("#sellerInfo5"+choiceNo).text()); //담당자
	    parent.$("#goodsChargerEmail").val($("#sellerInfo6"+choiceNo).val()); //담당자 이메일
	    parent.$("#goodsChargerCttpc").val($("#sellerInfo7"+choiceNo).val()); //담당자 전화번호
	    parent.$("#goodsHmpgUrl").val($("#sellerInfo8"+choiceNo).val()); //홈페이지URL
	    parent.$("#langCode").val($("#sellerInfo9"+choiceNo).val()); //언어코드
	    parent.$("#langNm").val($("#sellerInfo10"+choiceNo).val()); //언어명
	    parent.$.fn.colorbox.close();
//	    parent.document.dataForm.action = "BD_goodsForm.do";
        parent.document.dataForm.submit();
    } else {
        jsWarningBox("판매자를 선택해 주세요.");
    }
};

var jsMovePage = function(page) {
    var p = 1;
    if (page == 'page') {
        p = $('input[name=page]').val();
    } else {
        p = page;
    }
    $("#q_currPage").val(p);
    $("#dataForm").submit();
};

var jsSearchAction = function() {
    if ( $("#q_searchKey").val() != '' && $("#q_searchVal").val() == '' ) {
        jsWarningBox("검색어를 입력하세요.");
        $("#q_searchVal").focus();
        return false;
    } else if ( $("#q_searchKey").val() == '' && $("#q_searchVal").val() != "") {
        jsWarningBox("검색조건을 선택하세요.");
        $("#q_searchKey").focus();
        return false;
    } else {
	    $('#q_currPage').val("1");
	    $('#dataForm').submit();
    }
};
</script>
</head>
<body>
    <form id="dataForm" action="PD_sellerListPop.do">
        <op:pagerParam title="판매자 목록" />
        <div class="mar_b30">
	        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
	            <caption class="hidden"> 검색 조건 </caption>
	            <tbody>
	                <tr>
	                    <th>
	                        <select id="q_searchKey0" name="q_searchKey0">
	                            <c:forEach items="${langList}" var="list">
	                               <option value="${list.LANGCD}" ${param.q_searchKey0 == list.LANGCD ? 'selected="selected"' : ''}>${list.LANGNM}</option>
	                            </c:forEach>
                            </select>
	                        <select id="q_searchKey" name="q_searchKey" class="over">
	                            <option value="">선택</option>
	                            <option <c:if test="${param.q_searchKey == 1001}">selected="selected"</c:if> value="1001"> 판매자 ID</option>
	                            <option <c:if test="${param.q_searchKey == 1002}">selected="selected"</c:if> value="1002"> 판매자명</option>
	                            <option <c:if test="${param.q_searchKey == 1003}">selected="selected"</c:if> value="1003"> 회사명</option>
	                        </select>
	                        <input class="w60_p" type="text" value="<c:out value="${param.q_searchVal}" />" id="q_searchVal" name="q_searchVal" title="검색어를 입력하세요."/>
	                        <button type="button" class="gray mar_l5 mar_b5" onclick="jsSearchAction();">검색</button>
	                    </th>
	                </tr>
	            </tbody>
	        </table>
        </div>
	    <div id="popup" class="popup">
	        <fieldset>
	            <legend>판매자 선택</legend>
	            <table class="boardList" cellspacing="0" border="0" summary="회원 구분정보를 확인하실 수 있습니다.">
	                <caption class="hidden">회원 구분</caption>
	                <colgroup>
	                    <col width="5%" />
	                    <col width="30%" />
	                    <col width="30%" />
	                    <col width="30%" />
	                    <col width="5%" />
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>NO</th>
	                        <th>판매자 ID</th>
	                        <th>판매자명</th>
	                        <th>스토어명</th>
	                        <th class="lr_none">선택</th>
	                    </tr>
	                </thead>
	                <tbody id="odd-color">
	                    <c:set var="index" value="${pager.indexNo}"/>
	                    <c:forEach items="${pager.list}" var="_bean" varStatus="status">
		                    <tr>
		                        <td>${index-status.index}</td>
	                            <td id="sellerInfo0${index-status.index}" class="tx_l">${_bean.userId}</td>
	                            <td id="sellerInfo5${index-status.index}" class="tx_l">${_bean.userNm}</td>
	                            <td id="sellerInfo4${index-status.index}" class="tx_l">${_bean.langStoreNm}</td>
	                            <td class="lr_none tx_l"><input type="radio" name="sellerChk" value="${index-status.index}"/></td>
	                            <input id="sellerInfo1${index-status.index}" type="hidden" value="${_bean.langStoreNm}" />
	                            <input id="sellerInfo2${index-status.index}" type="hidden" value="${_bean.nationCode == 410 ? '국내' : '해외'}" />
	                            <input id="sellerInfo3${index-status.index}" type="hidden" value="${fn:startsWith(_bean.userTyCd, '10') ? '개인' : '기업'}" />
	                            <input id="sellerInfo6${index-status.index}" type="hidden" value="${_bean.reprsntEmail}" />
	                            <input id="sellerInfo7${index-status.index}" type="hidden" value="${_bean.reprsntTelno}" />
	                            <input id="sellerInfo8${index-status.index}" type="hidden" value="${_bean.storeUrl}" />
	                            <input id="sellerInfo9${index-status.index}" type="hidden" value="${_bean.langCode}" />
	                            <input id="sellerInfo10${index-status.index}" type="hidden" value="${_bean.langNm}" />
		                    </tr>
	                    </c:forEach>
	                    <op:no-data obj="${pager.list}" colspan="5"/>
	                </tbody>
	            </table>
	        </fieldset>
	    </div>
	    <!-- 페이징 -->
	    <op:pager pager="${pager}"/>
	    <!-- //페이징 -->
	    <p class="tx_c mar_t20">
	        <a href="javascript:;">
	            <button type="button" onclick="parent.$.fn.colorbox.close();" class="blue">취소</button>
	        </a>
	        <a href="javascript:;">
	            <button type="button" onclick="jsSellerChoice();" class="blue">등록</button>
	        </a>
	    </p>
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>