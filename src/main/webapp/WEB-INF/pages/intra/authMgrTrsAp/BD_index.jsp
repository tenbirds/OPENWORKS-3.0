<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
<title>권한 이양 요청</title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
    $().ready( function(){
        //검색 엔터 이벤트
        jsSetSearchEnterEvent();
    });

    var aTAInsForm = function(){
        location.href = "BD_authTransferAppInsForm.do";
    };

    var resTypeCdList = function(){
    	$("#dataForm").submit();
    };

    //검색 엔터 이벤트
    var jsSetSearchEnterEvent = function(){
        $("#q_searchVal").keyup(function(event){
            if(event.keyCode == 13){
                $(this).next().click();
                return false;
            }
        });
    };

    var jsView = function(seqNo , mgrId){
        location.href = "BD_view.do?seqNo="+ seqNo + "&mgrId=" +mgrId;
    };

    //처리결과 상세보기
    var resultView = function(el, seqNo , mgrId, targetMgrId, resTypeCd){
        if(resTypeCd == 'P'){
            $(el).colorbox({
                title : "권한이양 처리결과 - 승인",
                href  : "PD_resultViewP.do?seqNo="+ seqNo + "&mgrId=" + mgrId + "&targetMgrId=" + targetMgrId + "&resTypeCd=" + resTypeCd,
                width : "800",
                height: "735",
                iframe: true
            });
        }else if(resTypeCd == 'T'){
            $(el).colorbox({
                title : "권한이양 처리결과 - 수정승인",
                href  : "PD_resultViewT.do?seqNo="+ seqNo + "&mgrId=" + mgrId + "&targetMgrId=" + targetMgrId + "&resTypeCd=" + resTypeCd,
                width : "800",
                height: "735",
                iframe: true
            });
        }else if(resTypeCd == 'C'){
            $(el).colorbox({
                title : "권한이양 처리결과 - 반려",
                href  : "PD_resultViewC.do?seqNo="+ seqNo + "&mgrId=" + mgrId + "&targetMgrId=" + targetMgrId + "&resTypeCd=" + resTypeCd,
                width : "800",
                height: "735",
                iframe: true
            });
        }
    };

    var jsSearchAction = function(){
        if($("#q_searchVal").val() == ""){
            jsWarningBox("검색어를 입력하세요.");
            $("#q_searchVal").focus();
            return false;
        }
        if($("#q_searchKey").val() == ""){
            jsWarningBox("검색 조건을 선택하세요.");
            $("#q_searchKey").focus();
            return false;
        }

        if($("#q_searchVal").val() == "신청" && $("#q_searchKey").val() == "1001"){
            $('#q_searchVal').val('');
        }else if($("#q_searchVal").val() == "처리" && $("#q_searchKey").val() == "1001"){
            $('#q_searchVal').val('P');
        }else if($("#q_searchVal").val() == "반려" && $("#q_searchKey").val() == "1001"){
            $('#q_searchVal').val('C');
        }

        $("#dataForm").action = "BD_index.do";
        $("#q_currPage").val("1");
        $("#dataForm").submit();
    };

    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#q_currPage").val(p);

        $("#dataForm").action= "BD_index.do";
        $("#dataForm").submit();
    };
</script>
</head>
<body>
<form id="dataForm" name="dataForm" method="post">
	<input type="hidden" id="seqNo"      name="seqNo"        value="" />
	<input type="hidden" id="mgrId"       name="mgrId"       value="" />
	<input type="hidden" id="targetMgrId" name="targetMgrId" value="" />

	<op:pagerParam title="권한 이양 요청 목록" />
<!-- 	<fieldset> -->
<!-- 	    <legend>게시글의 현재 상태</legend> -->
<!-- 	    <div style="margin-left: 1.5%"> -->
<!-- 	        <label for="resTypeCds"><b>처리상태 : </b></label> -->
<!-- 	        <select name="resTypeCds" id="resTypeCds" onchange="resTypeCdList();" class="over"> -->
<%-- 	            <option value="Z">-- 선택 --</option> --%>
<%-- 	            <option value="Z" <c:if test="${param.resTypeCds eq 'Z'}">selected="selected"</c:if> >전체</option> --%>
<%-- 	            <option value="R" <c:if test="${param.resTypeCds eq 'R'}">selected="selected"</c:if> >신청</option> --%>
<%-- 	            <option value="P" <c:if test="${param.resTypeCds eq 'P'}">selected="selected"</c:if> >승인</option> --%>
<%-- 	            <option value="T" <c:if test="${param.resTypeCds eq 'T'}">selected="selected"</c:if> >수정승인</option> --%>
<%-- 	            <option value="C" <c:if test="${param.resTypeCds eq 'C'}">selected="selected"</c:if> >반려</option> --%>
<!-- 	        </select> -->
<!-- 	    </div> -->
<!-- 	</fieldset><br/> -->
</form>
<table class="boardList" summary="게시판 리스트입니다.">
    <colgroup>
        <col width="4%"/>
        <col width=""/>
        <col width="13%"/>
        <col width="8%"/>
        <col width="13%"/>
        <col width="8%"/>
    </colgroup>
    <thead>
	    <tr>
	        <th>번호</th>
	        <th>제목</th>
	        <th>작성일</th>
	        <th>처리일</th>
	        <th>상태</th>
	        <th class="lr_none">처리결과</th>
	    </tr>
    </thead>
    <tbody id="odd-color">
	    <c:set var="index" value="${pager.indexNo}"/>
	    <c:forEach items="${pager.list}" var="_bean" varStatus="status">
		    <tr>
		        <td>${index-status.index}</td>
		        <td class="tx_l">
		            <a href="#" title="권한요청관리 상세조회" onclick="jsView('${_bean.seqNo}','${_bean.mgrId}'); return false;">
		                ${_bean.mgrNm} -> <b>${_bean.targetMgrNm}</b> 으로 권한 이양을 신청합니다.
		            </a>
		        </td>
		        <td>${_bean.reqRegDtm}</td>
		        <td>${_bean.prcmRegDtm}</td>
		        <c:if test="${empty _bean.resTypeCd || _bean.resTypeCd eq'R'}">
		            <td>신청</td>
		        </c:if>
		        <c:if test="${_bean.resTypeCd eq 'P'}">
		            <td class="tx_red">승인</td>
		        </c:if>
		        <c:if test="${_bean.resTypeCd eq 'C'}">
		            <td class="tx_blue_n">반려</td>
		        </c:if>
		        <c:if test="${_bean.resTypeCd eq 'T'}">
		            <td class="tx_red">수정승인</td>
		        </c:if>
		        <td class="lr_none">
		          <c:if test="${_bean.resTypeCd eq 'P' || _bean.resTypeCd eq 'C' || _bean.resTypeCd eq 'T'}">
		              <a href="#" title="권한이양관리 상세조회" onclick="resultView(this, '${_bean.seqNo}', '${_bean.mgrId}', '${_bean.targetMgrId}', '${_bean.resTypeCd}'); return false;">
		                  <button class="s_blue">보기</button>
		              </a>
		          </c:if>
		        </td>
		    </tr>
	    </c:forEach>
    	<op:no-data obj="${pager}" colspan="6" />
    </tbody>
</table>
<br/>
<br/>
<!-- 버튼 -->
<div class="tx_r"><a href="#" class="btn"><button type="button" onclick="aTAInsForm();" class="blue">권한이양신청</button></a></div>
<!-- 페이징 -->
<div class="paging">
    <op:pager pager="${pager}" />
</div>


</body>
</html>