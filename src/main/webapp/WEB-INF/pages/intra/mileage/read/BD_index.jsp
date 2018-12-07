<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
	<head>
		<title>마일리지 관리</title>
        <op:jsTag type="openworks" items="ui, form" />
		<script type="text/javascript" src="/resources/intra/js/user.pwdConfirm.js"></script>
		<script type="text/javascript">
		
    	if('${param.pwdYn}' != 'Y'){
	    	self.location.href = "/intra/user/BD_pwdForm.do?title1="+ "마일리지 관리"
	    	        			+ "&title2=" + "회원 정보 조회"
	    	        			+ "&menuType=" + "R" 
	    	        			+ "&returnUrl=" + "/intra/mileage/read/BD_index.do";
    	}
    	
		$().ready(function() {
		    if('${param.q_sortOrder}' == 'DESC') $("#mileageDesc").css("color", "#d86640");
		    else if('${param.q_sortOrder}' == 'ASC') $("#mileageAsc").css("color", "#d86640");
		    
		    $('#searchBtn').click(function() {
		        if( $('#q_boardsearch option:selected').val() != "" ){
			        if ( $("#q_textSearch").val() == "" ) {
			            jsWarningBox("검색어를 입력하세요."); 
	    	            $("#q_textSearch").focus(); 
	    	            return;
		        	}
	        	}else{
	        	    $("#q_textSearch").val("");
	        	}
		        
	            $('#q_currPage').val("1"); 
	            $('#search').action = "BD_index.do";
	            $('#search').submit();
	        });
		});
		
		var jsMovePage = function(page) {
	        var p = 1;
	        if (page == 'page') {
	            p = $('input[name=page]').val();
	        } else {
	            p = page;
	        }
	        $("#q_currPage").val(p);
	        $("#search").action= "BD_index.do";
	        $("#search").submit();
	    };
    	var jsList = function() {
            $('#search').action = "BD_index.do";
            $('#search').submit();
    	};
        
        var jsDownExcel = function() {
            if ($('#excelFr').length == 0) {
                $('body').append('<iframe id="excelFr" style="display: none;"/>');
            }

            var url = 'INC_mileageMngListExcel.do?q_searchKey='+jsAccuTypeVal()+'&q_searchKey2='+jsSearchKey2Val()+ '&q_searchVal='+$("#q_searchVal").val();
            $('#excelFr').attr('src',url);
        };
        
        </script>
        
        <style type="text/css">
            .cs_pointer:hover,
            .cs_pointer:focus { color: #d86640; }
        </style>
	</head>

	<body>
		<!-- 탭영역 시작-->
		<div>
		    <ul class="tab">
		        <li><a href="<c:url value="../mng/BD_index.do" />">마일리지 항목 설정</a></li>
		        <li><a href="<c:url value="../read/BD_index.do" />" class="on">회원 마일리지 조회</a></li>
		        <li><a href="<c:url value="../status/BD_index.do" />">마일리지 통계</a></li>
		        <li><a href="<c:url value="../voucher/BD_index.do" />">서비스권 신청</a></li>
		    </ul>
		</div>
		<!-- //탭여역 끝 -->
		
		<!-- 컨텐츠영역 시작 -->
		<div id="contents">
			<form id="search" name="search" method="post" action="BD_index.do">
			<input type="hidden" id="pwdYn" name="pwdYn" value="${param.pwdYn}"/>			
						
			<!--검색 영역  시작-->
            <div class="float_r mar_b10">
				<button class="s_blue mar_l5" type="button" onclick="pwdConfirm(this, '마일리지 엑셀 출력', 'O', '/intra/mileage/read/INC_mileageReadExcel.do', '900', '700', '${_bean.userId}'
                , '∬q_textSearch=${param.q_textSearch}∬q_boardsearch=${param.q_boardsearch}∬q_currPage=${param.q_currPage}∬q_rowPerPage=${param.q_rowPerPage}', '리스트' );">엑셀출력</button>
            </div>
			<div class="search">
			
				<fieldset>
					<legend>게시글을 검색하세요.</legend>
                    <label for="q_boardsearch">검색 구분</label>
						<select id="q_boardsearch" name="q_boardsearch" class="over">
							<option value="">--선택--</option>
							<option <c:if test="${param.q_boardsearch == 'selectAll'}">selected="selected"</c:if> value="selectAll">전체</option>
							<option <c:if test="${param.q_boardsearch == 'name'}">selected="selected"</c:if> value="name">성명</option>
							<option <c:if test="${param.q_boardsearch == 'id'}">selected="selected"</c:if> value="id">아이디</option>
						</select>
						<input class="w215" type="text" value="${not empty param.q_boardsearch ? param.q_textSearch : ''}" id="q_textSearch" name="q_textSearch" title="검색어를 입력하세요." />
						<button class="gray mar_l5 mar_b5" type="button" id="searchBtn">검색</button>
				</fieldset>
			</div>
			<!-- 검색영역 끝 -->
			
			<op:pagerParam title="마일리지 관리"/>
			
			<!-- 리스트 영역  시작-->
			<table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
				<caption class="hidden"> 목록 </caption>
					<colgroup>
						<col width="5%" />
						<col width="10%" /> 
						<col width="10%" />
						<col width="20%" />
						<col width="*" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>성명</th>
							<th>
                                <span class="sort cs_pointer" id="AMOUNT">마일리지</span>
                            </th>
							<th>마일리지그룹</th>
							<th>최근 마일리지<br/>적립일자</th>
							<th class="lr_none">소멸예정 마일리지<br/>(1개월내)</th>
							<!-- <th>정기 소멸마일리지<br/>(2011-12-31)</th> -->
						</tr>
						</thead>
						<tbody id="odd-color">
						<c:set var="index" value="${pager.indexNo}"/>
						<c:forEach items="${pager.list}" var="_bean" varStatus="status">
							<tr>
								<td>${index-status.index}</td>
								<td>
                                    <a href="#" onclick="pwdConfirm(this, '마일리지 조회', 'R', '/intra/mileage/read/PD_mileageView.do', '850', '700', '${_bean.userId}', '∬userNm=${_bean.userNm}', '리스트' );">${_bean.userId}</a>
                                </td>
 								<td>
                                    <a href="#" onclick="pwdConfirm(this, '마일리지 조회', 'R', '/intra/mileage/read/PD_mileageView.do', '850', '700', '${_bean.userId}', '∬userNm=${_bean.userNm}', '리스트' );">${_bean.userNm}</a>
                                </td>
								<td><fmt:formatNumber value="${_bean.lastMileageAmount}" type="number" /></td>
								<td>${_bean.mileageGrpNm}</td>
								<td><fmt:parseDate pattern="yyyyMMddHHmmss" value="${_bean.regDtm}" var="accuDt" /><fmt:formatDate value="${accuDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
<%-- 								<td class="lr_none tx_r"><fmt:formatNumber value="${_bean.mmRemoveMileage}" type="number" /></td> --%>
								<td class="lr_none tx_r"></td>
							</tr>
						</c:forEach>
						<c:if test="${empty pager.list}">
							<op:no-data obj="${pager}" colspan="7"/>
						</c:if>
					</tbody>
					</table>
				<!-- 리스트 영역 끝 -->
				<!-- 페이징 영역 시작-->
					<op:pager pager="${pager}" />	
				<!-- //페이징 영역 끝 -->	
			</form>
		</div>
	</body>
</html>