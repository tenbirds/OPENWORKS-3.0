<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title></title>

    <op:jsTag type="spi" items=" datepicker, cookie" />
<%--    <op:jsTag type="openworks" items="ui" /> --%>

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>

    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">

    //카테고리 저장용
    bbsCtgAry = new Array();

    $().ready(function(){
        
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
   
        //게시판 설정값들을 초기화 합니다.
        if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
        OpenWorks.pageType      = "LIST";
        OpenWorks.boardNm       = "<c:out value='${boardConfVo.bbsNm}'/>";
        OpenWorks.boardType     = "<c:out value='${boardConfVo.kndCd}'/>";
        OpenWorks.useCategory   = "<c:out value='${boardConfVo.ctgYn}'/>";
        OpenWorks.fileYn        = "<c:out value='${boardConfVo.fileYn}'/>";
        OpenWorks.filePermExtsn = "<c:out value='${boardConfVo.filePermExtsn}'/>";
        OpenWorks.captchaYn     = "<c:out value='${boardConfVo.captchaYn}'/>";
        OpenWorks.tagYn         = "<c:out value='${boardConfVo.tagYn}'/>";
        OpenWorks.bbsNm         = "<c:out value='${boardConfVo.bbsNm}'/>";
        OpenWorks.bbsCd         = "<c:out value='${boardConfVo.bbsCd}'/>";
        OpenWorks.domainCd      = "<c:out value='${boardConfVo.domainCd}'/>";
        OpenWorks.searchVal     = "<c:out value='${param.q_searchVal}'/>";
        OpenWorks.searchKey     = "<c:out value='${param.q_searchKey}'/>";
        OpenWorks.sortName      = "<c:out value='${param.q_sortName}'/>";
        OpenWorks.sortOrder     = "<c:out value='${param.q_sortOrder}'/>";
        OpenWorks.startDt       = "<c:out value='${param.q_startDt}'/>";
        OpenWorks.endDt         = "<c:out value='${param.q_endDt}'/>";
        OpenWorks.showSummaryYn = "<c:out value='${param.showSummaryYn}'/>";
        OpenWorks.section       = "<c:out value='myboard'/>";
        OpenWorks.serverNm      = "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
        OpenWorks.isSession     = "<c:out value='${!empty __usk}'/>";

        onReadyEventFunctions();

        //검색 날짜 입력
        $('#q_endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '/cloud_ver2/new_cloud/images/icn_calen.png',
            buttonImageOnly : true
        });
        
        $('#q_startDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '/cloud_ver2/new_cloud/images/icn_calen.png',
            buttonImageOnly : true
        });
        
        var set2Str = function(vl){
            return parseInt(vl, 10) > 9 ? vl : '0' + vl;
        };
        var getDateStr = function(date){
            return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
        };
        
        var getCalDate = function(date, months, days){
            var newDate = date;
            if(typeof(date.getDate) != 'function'){
                newDate = new Date();
            }
        
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
        
            return newDate;
        
        };
        
        if ($('#q_init').val() == '1' || $('#q_init').val() == '') {
            // 기간,발표일 달력 생성
            if($('#q_startDt').val() == ''){
                var beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth() - 1);
                $('#q_startDt').val(getDateStr(getCalDate(new Date(),-1,0)));
            }
            if($('#q_endDt').val() == ''){
                $('#q_endDt').val(getDateStr(new Date()));
            }
        }
        
    });
    
  //page번호로 목록 페이지를 호출한다.(bbsCd는 기본 셋팅값 사용)
    var jsListReq = function(page) {
        $("#dataForm input[name=q_currPage]").val(page);
        jsRequest("dataForm", "BD_index.do", "get");
    };
    
    var jsSearch = function(){
         document.dataForm.elements["q_init"].value = "0";
         jsListReq(1);
     };
    
     var jsMyView = function(domainCd, bbsCd, bbscttSeq, regPwd, openYn){
        if(bbscttSeq == ""){
     		alert(Message.msg.noPosts); 
     		return;
     	}
     	
     	$("#dataForm input[name=domainCd]").val(domainCd);
     	$("#dataForm input[name=bbsCd]").val(bbsCd);
     	$("#dataForm input[name=bbscttSeq]").val(bbscttSeq);
     	$("#dataForm input[name=sction]").val("");
     	if(domainCd == 2 && bbsCd == 1003) { // 묻고 답하기
     	    jsRequest("dataForm", "/web/board/BD_board.view1.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1010) { // 비즈매칭
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1004) { // 지식나눔
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1007) { // 행사 및 이벤트
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1009) { // 성공스토리
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1011) { // 기타입찰정보
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1012) { // 뉴스레터
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	} else if(domainCd == 2 && bbsCd == 1019) { // 씨앗공지
     	    jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
     	}
     	
     	
     	/* 
         if(OpenWorks.section == "myboardB" || OpenWorks.section == "myboard" ||  OpenWorks.section == "myboardQ" ){
             jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
         }else if(OpenWorks.bbsCd == 1003 &&( OpenWorks.section != "myboardB" || OpenWorks.section != "myboard" ) ){
             jsRequest("dataForm", "BD_board.view1.do", "post");
         }else{
             jsRequest("dataForm", "BD_board.view.do", "post");
         }
         */
     };
    </script>
    <!-- 사용자 스크립트 끝 -->
</head>

<body>
	<!-- 검색 폼 -->
	<form name="dataForm" id="dataForm" method="get" onsubmit="return false;" >
	    <!-- 기본 검색 사항 -->
	    <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" />
	    <input type="hidden" name="bbsCd"  value="<c:out value='${param.bbsCd}'/>" />
	    <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
	    <input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}'/>" />
	    <input type="hidden" name="pageType" value="<c:out value='' />" />
	    <input type="hidden" name="delDesc" id="delDesc" value="<c:out value='' />" />
	    <input type="hidden" name="q_ctgCd" id="q_ctgCd" value="<c:out value='' />" />
	    <input type="hidden" name="section" id="section" value="<c:out value='myboard'/>"/>
	    <input type="hidden" name="q_init" id="q_init" value="<c:out value='${param.q_init}'/>" />
		<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<!-- //title-area -->
	    
	    <!-- 구매내역 검색 영역 -->
	    <fieldset>
	        <legend><span>검색조건 입력</span></legend>
		<div class="myDoc my">	
				<div class="schOpt">
					<table class="tbl_st4">

		        <caption>
		            <strong>내가 쓴 글 내역 검색</strong>
		            <details>
		                <summary>검색 조건을 입력하는 서식입니다.</summary>
		            </details>
		        </caption>
		        <colgroup>
				<col style="width:130px;"/>
				<col style="width:;"/>
				</colgroup>
				<tbody>
		        <tr>
					<th>분류</th>
					<td>
					<!-- select box -->
							<span class="sel_box">
								<select id="q_bbsCd" name="q_bbsCd" title="내가 쓴 글 분류 선택 " style="width: 130px;">
									<option value="">전체보기</option>
								    <c:forEach items="${boardList}" var="boardVo" varStatus="status"> 
								    	<option value="${boardVo.bbsCd}" <c:if test="${param.q_bbsCd eq boardVo.bbsCd}"> selected="selected" </c:if>><c:out value='${boardVo.bbsNm}'/></option>
								    </c:forEach>
								</select>
							</span>
							<!-- //select box -->
					</td>
				</tr>
				<tr>
		            <th>기간(문의일)</th>
		            <td class="term">
		                 <input type="text" id="q_startDt" name="q_startDt" value="<c:out value='${param.q_startDt}'/>" maxlength='8'  title="검색 시작일 입력" style="width:100px;">
		                 ~ 
		                 <input type="text" id="q_endDt" name="q_endDt" value="<c:out value='${param.q_endDt}'/>" maxlength='8' title="검색 종료일 입력" style="width:100px;">
		                 <a href="" onclick="jsSetDay(0, 1, 0); return false;" class="btns st3">오늘</a>
						 <a href="" onclick="jsSetDay(0, 7, 0); return false;" class="btns st3">1주일</a>
						 <a href="" onclick="jsSetDay(1, 1, 0); return false;" class="btns st3">1개월</a>
						 <a href="" onclick="jsSetDay(3, 1, 0); return false;" class="btns st3">3개월</a>
		            </td>
		        </tr>
				</tbody>
	        </table>
	        </div>
	        </div>  
	    </fieldset>
	    <!-- //구매내역 검색 영역 -->
		<!-- btn-area -->
	<div class="btnArea rig mtm20">

			<a href="#" onclick="jsSearch(1); return false;" class="btns st5 icn icnSearch">검 색</a>
			<a href="#" onclick="jsSearchReset(); return false;"  class="btns st5">전체보기</a>
		</div>
		<!-- //btn-area -->

	<!-- section -->

	<div class="section">
		<h3 class="stitle"></h3>
		
		<p class="total-count">총 <strong><c:out value='${pager.totalNum}'/></strong>개</p>
	
	<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='${searchMap.q_currPage}'/>"/>
	<input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value='${searchMap.q_sortName}'/>" />
	<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value='${searchMap.q_sortOrder}'/>"/>    
	
	    
	<%-- 항목 표시 수 --%>
	<c:set var="thCnt" value="0" />
	
	 <!-- tbl_write -->
	 <div class="type-list">
	 <table class="tbl_st1">
	    <caption>
	        <strong>내가쓴글 내역 목록</strong>
	        <details>
	            <summary>번호, 답변상태, 카테고리, 문의제목, 문의성격, 문의일 답변일 정보를 제공합니다</summary>
	        </details>
	    </caption>
	    <colgroup>
		<col style="width:80px;"/>
		<col style="width:100px;"/>
		<col style="width:*;"/>
		<col style="width:100px;"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
		</thead>
	    <tbody>
	        <!-- 공지 제외 게시물 목록 -->
	        <c:set var="index" value="${pager.indexNo}"/>
	        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	            <tr>
	                <!-- 번호(필수) -->
	                <td>${index-status.index}</td>
	                <td><c:out value='${baseVo.bbsNm}'/></td>      
	                <!-- 제목 항목 -->
	                <td class="title">
	                    <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                        onclick="jsMyView('${baseVo.domainCd}','${baseVo.bbsCd}', '${baseVo.bbscttSeq}', '${baseVo.registPassword}', '${baseVo.othbcAt}'); return false;">
	                        ${fn:substring(baseVo.bbscttSj,0,50)}<c:if test="${baseVo.bbscttSjLength > 50}">...</c:if>
	<%-- 	                             <c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if> --%>
	                        <c:if test="${baseVo.fileCnt > 0}">
	                            <img alt="첨부된 이미지" class="ico" src="/resources/web/theme/default/images/common/ico/ico_image.gif">
	                        </c:if>
	                    </a>
	                </td>
	                <td class="date"><c:out value='${baseVo.registDt}'/></td>
	            </tr>
	        </c:forEach>
	
	        <!-- 데이터가 없을 때 알림 문구 -->
	        <c:if test="${empty pager.list}">
	            <op:no-data obj="${pager}" colspan="4" />
	        </c:if>
	
	    </tbody>
	</table>
	</div>
    <!-- //list -->

	<!-- paging -->
	<div class="paging">
		<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
	</div>
	<!-- //paging -->
	</div>
	<!-- //section -->
</div>
<!-- //contents -->	
</form>
</body>
</html>