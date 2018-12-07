<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.web.common.CommonDutyConstant"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	request.setAttribute("SubDomain", "korean");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
<c:if test="${empty sessionScope['__usk']}">
	    alert(Message.msg.requiredLogin); 
	    // 이전소스
	    //location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/pt/login/user/BD_index.do";
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/pt/login/user/BD_index.do";
</c:if>
</script>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>개설 커뮤니티 | 판매하기 | 씨앗 마켓</title>	
	<op:jsTag type="spi" items="form, validate, datepicker" />
	<script type="text/javascript">
	$(document).ready(function() {
		
        //jsSetSearchEnterEvent();
      
       $.datepicker.setDefaults({
            dateFormat:"yy-mm-dd",
            showOn : 'button',
            buttonImageOnly : true,
            buttonImage : '<c:url value="/cloud_ver2/new_cloud/images/icn_calen.png" />',
            buttonText: "날짜선택",
            yearRange: "2010:+1",
            showOptions: { direction: "up"}
        });
      
        $('#q_startDt').datepicker();
        $('#q_endDt').datepicker();
        <%-- 
        $("#q_startDt, #q_endDt").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });  --%> 
	 });
	
	
	//지정 날짜 설정
	var jsSetDay = function(smonth, sday, eday){   
	  if(eval(smonth < 0)){
		  $('#q_startDt').val("");
		  $('#q_endDt').val("");
		  return false;
	  }
	  sday = eval(sday) -1;
	  var today = new Date();
	  if($('#q_endDt').val() != ""){
		  var dayVal = $('#q_endDt').val();
		  if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");

		  var vyear = dayVal.substring(0, 4);
		  var vmonth = dayVal.substring(4, 6);
		  var vday = dayVal.substring(6, 8);
		  var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
		  $('#q_startDt').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() - eval(smonth), sDay.getDate() - eval(sday)));
	  }else if($('#q_startDt').val() != ""){
		  var dayVal = $('#q_startDt').val();
		  if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");

		  var vyear = dayVal.substring(0, 4);
		  var vmonth = dayVal.substring(4, 6);
		  var vday = dayVal.substring(6, 8);
		  var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
		  $('#endDtVal').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() + eval(smonth), sDay.getDate() + eval(sday)));
	  }else{	  
		  $('#q_startDt').datepicker('setDate', new Date(  today.getFullYear(), today.getMonth() - eval(smonth),  today.getDate() - eval(sday)));
		  $('#q_endDt').datepicker('setDate', new Date( today.getFullYear(), today.getMonth(), today.getDate() - eval(eday)));
	  }
	};  
	
	 //페이징 
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    }; 
   //전체보기
    var jsSearchAllAction = function() {
	 	$("#q_nmSearch").val(""); 
	 	$("#q_startDt").val(""); 
	 	$("#q_endDt").val(""); 
	 	jsSearchAction();
    }
   
    //통합검색바
    var jsSearchAction = function() {
        /* 20150731 if 조건 잘못되어 or>and로 수정함 시작 */
		if($("#q_startDt").val() == "" && $("#q_endDt").val() != ""){
		/* 20150731 if 조건 잘못되어 or>and로 수정함 끝 */
		    alert("검색 시작일 입력해 주세요.");
            $("#q_startDt").focus();
            return false;
		}
		/* 20150731 if 조건 잘못되어 or>and로 수정함 시작 */
		if($("#q_startDt").val() != "" && $("#q_endDt").val() == ""){
		/* 20150731 if 조건 잘못되어 or>and로 수정함 끝 */
		    alert("검색 종료일 입력해 주세요.");
            $("#q_endDt").focus();
            return false;
		}
		/* 20150731 if문 위치 맨위에서 맨아래로 수정함 시작 */
		if($("#q_startDt").val() > $("#q_endDt").val() || $("#q_startDt").val().replace(/-/gi,"") > $("#q_endDt").val().replace(/-/gi,"")){
            alert("기간이 맞지 않습니다.");
            $("#q_startDt").focus();
            return false;
        }
		/* 20150731 if문 위치 맨위에서 맨아래로 수정함 끝 */
		
        $('#q_currPage').val("1");
     	$('#dataForm').submit();
    };
	</script>
</head>

<body>
	<div class="supAdm">
	<form name="dataForm" id="dataForm" method="post" action="BD_myCmOpenList.do">
		<input type="hidden" id="cmmntyId"   name="cmmntyId"   value=""/>
		<input type="hidden" id="q_currPage" name="q_currPage" value="<c:out value='${param.q_currPage}'/>"/>
		
		<!-- search -->
		<div class="schOpt on">				
			<table class="tbl_st4">
				<tr>
					<th>이름</th>
					<td><input type="text" id="q_nmSearch" name="q_nmSearch" title="검색어 입력" value="<c:out value='${param.q_nmSearch}'/>" /></td>
				</tr>
				<%-- <tr>
					<th>개설일</th>
					<td>
						<div class="term">
						  <input type="text" name="q_startDt" id="q_startDt" readonly="readonly" title="검색 시작일 입력" style="width:100px" value="<c:out value='${param.q_startDt}'/>"/>
						 ~
						  <input type="text"  name="q_endDt" id="q_endDt" readonly="readonly" title="검색 종료일 입력" style="width:100px" value="<c:out value='${param.q_endDt}'/>"/>
						  <a href="#" class="btns st3" onclick="jsSetDay(0, 1, 0);">오늘</a>
							<a href="#" class="btns st3" onclick="jsSetDay(0, 7, 0);">1주일</a>
							<a href="#" class="btns st3" onclick="jsSetDay(1, 1, 0);">1개월</a>
							<a href="#" class="btns st3" onclick="jsSetDay(3, 1, 0);">3개월</a>
						</div>
					</td>
				</tr> --%>
			</table>
		</div>
		<div class="btnArea rig mtm20">
			<a href="#" onclick="jsSearchAction();" class="btns st5 icn icnSearch">검색</a >
			<a href="#" onclick="jsSearchAllAction();" class="btns st5">전체보기</a>
		</div>
		<!-- //search -->
		
		<div class="list_st1">
			<p class="head">
				<span>총 <c:out value='${pager.totalNum}'/>개</span>
				<%-- <span class="sel_box">	
					<select>
						<option>20개식</option>
						<option>40개식</option>
						<option>60개식</option>
						<option>100개식</option>					
					</select>
				</span> --%>
			</p>
			
			<!-- list -->
			<table class="tbl_st1">
				<thead>
					<tr>
						<th>순위</th>
						<th>커뮤니티 이름</th>
						<th>개설일</th>
						<th>회원수</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
					<c:forEach items="${pager.list}" var="data" varStatus="status">
					<tr>
						<td><c:out value='${pager.indexNo - status.index}'/></td>
						<c:if test="${data.cmmntySttusCd == 1002 || data.cmmntySttusCd  == 1005}">	
						
						<td class="title"><a href="http://<c:out value='${data.cmmntyUrl}'/>" id="popView1" target="_blank" ><c:out value='${data.cmmntyNm}'/></a></td>
						</c:if>
						<c:if test="${data.cmmntySttusCd == 1004 || data.cmmntySttusCd == 1001 || data.cmmntySttusCd == 1003}">	
						<td class="title"><c:out value='${data.cmmntyNm}'/></td>
						</c:if>
						<td><c:out value='${fn:substring(data.confmDt,0,10)}'/></td>
						<td><c:out value='${data.cmMberCount}'/></td>
						<td>
							<c:if test="${data.cmmntySttusCd == 1002 || data.cmmntySttusCd  == 1005}">		
								<a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/admin/cmOptMain/BD_index.do?cmmntyId=<c:out value='${data.cmmntyId}'/>" class="btns st3">관리</a>
							<c:if test="${ data.cmmntySttusCd == 1005}">
								<c:out value='${data.cmmntySttusNm}'/>
							</c:if>
							</c:if>
							<c:if test="${data.cmmntySttusCd == 1004 || data.cmmntySttusCd == 1001 || data.cmmntySttusCd == 1003}">
								<c:out value='${data.cmmntySttusNm}'/>
							</c:if>
						</td>
						
					</tr>
					</c:forEach>
					<!-- 커뮤니티 신청 진행 상태 1001 신청 1002 승인 1003 거절  1004 폐쇄 1005 폐쇄중 -->
					<c:if test="${empty pager.list }">
					<tr>
						<td colspan="5">등록된 데이터가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		<!-- //list -->
		</div>
		
		<!-- paging  -->
		<div class="paging">
			<span><op:pager pager="${pager}" page="pager/webPager.jsp" /></span>
		</div>
		<!--// paging  -->		
		</form>		
	</div>
</body>
</html>
