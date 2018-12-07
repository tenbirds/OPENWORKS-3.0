<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>SNS관리</title>
<op:jsTag type="spi" items="validate,ui,form,highlight" />
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript"
	src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->

<script type="text/javascript">
    //<![CDATA[
    $().ready(function() {
        
    });
    
    var jsMovePage = function(page) {
        var p = 1;
        if(page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action = "BD_index.do";
        document.dataForm.submit();
    };
	
    //등록팝업
    var jsInsertPop = function(el) {
        $(el).colorbox({
            title : "SNS등록 메뉴",
            href : "PD_insertPop.do",
            width : "650",
            height : "450",
            iframe : true
        });
    };

   
   
    //검색
    var jsSearch = function() {
    
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
	
    //수정팝업
    var jsUpdatePop = function(el, v1, v2) {        
        $(el).colorbox({
            title : "SNS 수정 메뉴",
            href : "PD_updatePop.do?grp_cd="+ v1 +"&prv_cd=" + v2,
            width : "650",
            height : "550",
            iframe : true
        });

    };

    //선택삭제
    var jsDeleteChoose = function() {
        var prv_cd = '';

        $('input.chk_seq:checked').each(function(i) {
            prv_cd += ',' + $(this).val();
        });

        if(prv_cd == '') {
            jsWarningBox("삭제할 SNS을 선택해 주세요");
            return false;
        }

        $.ajax({
            url : "ND_DeleteChoose.do",
            type : "POST",
            data : {
                prv_cd : prv_cd.substring(1)
            },
            async : false,
            success : function(response) {
                if(jsMessage(response)) {
                    document.dataForm.action = "BD_index.do";
                    document.dataForm.submit();
                }
            }
        });

    };
  	

    //]]>
</script>
</head>
<body>
	<div id="contents">
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">


			<!-- 검색 -->
			<div class="search">
				<fieldset>
					<legend>검색하세요.</legend>
					<select id="q_searchKey" name="q_searchKey" value="${param.q_searchKey }" class="over">
						<option
							<c:if test="${param.q_searchKey eq  'search_tit'}">    selected="selected" </c:if>
							value="search_tit">선택하세요.</option>
						<option
							<c:if test="${param.q_searchKey eq  'search_nm'}">    selected="selected" </c:if>
							value="search_nm">SNS명</option>
						<option
							<c:if test="${param.q_searchKey eq  'search_writer'}"> selected="selected" </c:if>
							value="search_writer">등록자</option>
					</select>
					<input class="w215" type="text" value="${param.q_searchVal }" name="q_searchVal" id="q_searchVal" title="검색어를 입력하세요." />
 					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<button class="s_blue mar_l5 mar_b5" onclick="jsSearch();">검색</button>
					<button class="s_blue mar_l5 mar_b5" type="button"
						onclick="jsInsertPop(this);">SNS등록</button>
					<button class="s_blue mar_l5 mar_b5" type="button"	onclick="jsDeleteChoose();">선택 삭제</button>					

				</fieldset>
			</div>
			<!-- //검색 -->			
		
			<!-- 페이지당 목록선택-->
			<op:pagerParam title="배너 목록" />
		</form>


		<!-- 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
			<caption class="hidden">목록</caption>
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="">							
				<col width="8%">
				<col width="9%">
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>번호</th>
					<th>제목</th>				
					<th>등록자</th>
					<th class="lr_none">등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="index" value="${pager.indexNo}" />
				<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
					<tr>
						<td><input type="checkbox" name="chk_seq" id="chk_seq" class="chk_seq" value="${baseVo.prv_cd}" /></td>
						<td>${baseVo.num}</td>
						<td class="tx_l"><a href="#"	onclick="jsUpdatePop(this,'${baseVo.grp_cd }','${baseVo.prv_cd }');">${baseVo.sns_name }</a></td> 
						<td>${baseVo.reg_id}</td>
						<td class="lr_none">${baseVo.reg_dt}</td>
					</tr>					
				</c:forEach>
			</tbody>
		</table>
		<!-- //리스트 -->
		
		<!-- 페이징 --> 
		<op:pager pager="${pager}" />
		<!-- //페이징 -->
				
		<div class="tx_r">
			<button class="btn blue" type="button" onclick="jsInsertPop(this);">SNS등록</button>
			<!-- //작은탭 -->
		</div>
	</div>
	<!-- //컨텐츠영역 -->
</body>
</html>