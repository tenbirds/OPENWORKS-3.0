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
		
	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	//변경소스
	request.setAttribute("SubDomain", "korean");
	//}}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript">
	<c:if test="${empty sessionScope['__usk']}">
	alert(Message.msg.requiredLogin); 
	// 이전소스
	//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/pt/login/user/BD_index.do";
	
	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	// 변경소스
	location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/pt/login/user/BD_index.do";
	//}}
	
	</c:if>
</script>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 | 커뮤니티 | 마이페이지 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate, datepicker" />
	<script type="text/javascript">
	$(document).ready(function() {
		<%--  
		 $.datepicker.setDefaults({
            dateFormat:"yy-mm-dd",
            showOn : 'button',
            buttonImageOnly : true,
            buttonImage : '<c:url value="/new_cloud/images/icon-btn/btn-calendar.gif" />',
            buttonText: "날짜선택",
            yearRange: "2010:+1",
            showOptions: { direction: "up"}
        });
		 
        $('#q_startDt').datepicker();
        $('#q_endDt').datepicker();
        --%>
        <%-- datepicker --%>
		  $("#q_startDt, #q_endDt").datepicker({
		          showOn: "both", 
		          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
		          buttonImageOnly: false,
		          buttonText: "달력"
		    });
		  <%--datepicker --%> 
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
	//커뮤니티 탈퇴
    var jsMemberSecede = function(cmmntyId){
        
	     if ( confirm("커뮤니티를 탈퇴 하시겠습니까?")) {
	         $("#cmmntyId").val(cmmntyId);
	         $("#dataForm").ajaxSubmit({
		        url      : "INC_cmMemberShipSecedeUpdate.do",
		        type     : "POST",
		        dataType : "text",
		        success  : function(response) {
      			if (response == "true")  {
		                alert("커뮤니티 탈퇴가 완료 되었습니다.");
		                $("#dataForm").attr("action","BD_myCmJoinList.do").submit();
          		} else { 
          		    alert("커뮤니티 탈퇴 중 오류가 발생했습니다.");
		               	return;
          		}
     			}
  		});
	 	}
    };
    
    //커뮤니티 가입 취소 
    var jsMemberCancel = function(cmmntyId){
       
	     if ( confirm("커뮤니티 회원 가입 취소 하시겠습니까?")) {
	         $("#cmmntyId").val(cmmntyId);
	         $("#dataForm").ajaxSubmit({
		        url      : "INC_cmMemberShipCancelDelete.do",
		        type     : "POST",
		        dataType : "text",
		        success  : function(response) {
      			if (response == "true")  {
		                alert("커뮤니티 회원 가입 취소 되었습니다.");
		                $("#dataForm").attr("action","BD_myCmJoinList.do").submit();
          		} else { 
          		    alert("커뮤니티 회원 가입 취소 중 오류가 발생했습니다.");
		               	return;
          		}
     			}
  		});
	 	}
    };
    //통합검색바
    var jsSearchAction = function() {
        if($("#q_startDt").val() > $("#q_endDt").val() || $("#q_startDt").val().replace(/-/gi,"") > $("#q_endDt").val().replace(/-/gi,"")){
            alert("기간이 맞지 않습니다.");
            $("#q_startDt").focus();
            return false;
        }
		if($("#q_startDt").val() == "" && $("#q_endDt").val() != ""){
		    alert("검색 시작일 입력해 주세요.");
            $("#q_startDt").focus();
            return false;
		}
		if($("#q_startDt").val() != "" && $("#q_endDt").val() == ""){
		    alert("검색 종료일 입력해 주세요.");
            $("#q_endDt").focus();
            return false;
		}
        $('#q_currPage').val("1");
     	$('#dataForm').submit();
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
	 	$("#q_mberStateTab1").val(""); 
	 	$("#q_mberStateTab2").val(""); 
	 	$("#q_mberStateTab3").val(""); 
	 	$("#q_mberDateSearch").val(""); 
	 	$("#q_startDt").val(""); 
	 	$("#q_endDt").val(""); 
	 	jsSearchAction();
    }
	</script>
</head>


<body>
	<div class="supAdm">
	<form name="dataForm" id="dataForm" method="post" action="BD_myCmJoinList.do">
   		<input type="hidden" id="cmmntyId" name="cmmntyId" value=""/>
   		
   		<!-- search -->
		<div class="schOpt">
			<table class="tbl_st4">
				<tr>
					<th>이름/설명</th>
					<td><input type="text" style="width:70%;" id="q_nmSearch" name="q_nmSearch" value="${param.q_nmSearch}"/>
				        <label for="ing"><input type="checkbox" name="q_mberStateTab1" id="q_mberStateTab1" value="1001" <c:if test="${param.q_mberStateTab1 == '1001'}"> checked="checked"</c:if> />진행중</label>
				        <label for="join"><input type="checkbox" name="q_mberStateTab2" id="q_mberStateTab2" value="1003" <c:if test="${param.q_mberStateTab2 == '1003'}"> checked="checked"</c:if> />정상</label>
				        <label for="withdraw"><input type="checkbox" name="q_mberStateTab3" id="q_mberStateTab3" value="1004" <c:if test="${param.q_mberStateTab3 == '1004'}"> checked="checked"</c:if> />탈퇴</label>
					</td>
				</tr>
				<tr>
					<th>기간</th>
					<td class="term">
						<span class="sel_box">
							<select name="q_mberDateSearch" id="q_mberDateSearch" title="기간 선택" >
			                    <option value="1001" <c:if test="${param.q_mberDateSearch == '1001'}"> selected="selected" </c:if>>개설일</option>
			                    <option value="1002" <c:if test="${param.q_mberDateSearch == '1002'}"> selected="selected" </c:if>>최종 방문일</option>
			                    <option value="1003" <c:if test="${param.q_mberDateSearch == '1003'}"> selected="selected" </c:if>>가입일</option>
			                    <option value="1004" <c:if test="${param.q_mberDateSearch == '1004'}"> selected="selected" </c:if>>탈퇴일</option>
							</select>
						</span>
							<input type="text" class="input" name="q_startDt" id="q_startDt" readonly="readonly" title="시작날짜선택" style="width:100px" value="<c:out value='${param.q_startDt}'/>" />
							~
							<input type="text" class="input" name="q_endDt" id="q_endDt" readonly="readonly" title="종료날짜선택" style="width:100px" value="<c:out value='${param.q_endDt}'/>" />
							<span style=" float:right;">
							<a href="#" class="btns st3" onclick="jsSetDay(0, 1, 0);">오늘</a>
							<a href="#" class="btns st3" onclick="jsSetDay(0, 7, 0);">1주일</a>
							<a href="#" class="btns st3" onclick="jsSetDay(1, 1, 0);">1개월</a>
							<a href="#" class="btns st3" onclick="jsSetDay(3, 1, 0);">3개월</a>
							</span>
					</td>
				</tr>
			</table>
		</div>
		<div class="btnArea rig mtm20">
			<a href="#" onclick="jsSearchAction();" class="btns st5 icn icnSearch">검색</a >
			<a href="#" onclick="jsSearchAllAction();" class="btns st5">전체보기</a>
		</div>
		<!-- //search -->
	
	

		<div class="list_st1">
			<h3 class="stitle"></h3>
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
				<caption>자주찾는 질문</caption>
				<thead>
					<tr>
						<th>번호</th>
						<th>커뮤니티</th>
						<!-- <th>닉네임</th>
						<th>상태</th> -->
						<th>최종 방문일</th>
						<!-- <th>개설일</th> -->
						<th>가입일<br/>(탈퇴일)</th>
						<th>방문수</th>
						<th>회원수</th>
						<th>게시글</th>
						<th>상태 변경</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
					<c:forEach items="${pager.list}" var="data" varStatus="status">
					<tr>
						<td><c:out value='${pager.indexNo - status.index}'/></td>
						<td class="title"><a href="http://<c:out value='${data.cmmntyUrl}'/>" id="popView1" target="_blank" ><c:out value='${data.cmmntyNm}'/></a></td>
						<%-- <td><c:out value='${data.ncnm}'/></td>
						<td><c:out value='${data.mberStateNm}'/></td> --%>
						<td><c:out value='${data.visitDt}'/></td>
						<%-- <td><c:out value='${data.confmDt}'/></td> --%>
						<td><c:out value='${data.sbscrbReqstDt}'/>
						<c:if test="${data.secsnDt ne null}">
							<br />(<c:out value='${data.secsnDt}'/>)
						</c:if>
						</td>
						<td><c:out value='${data.cmVisitCount}'/></td>
						<td><c:out value='${data.cmMberCount}'/></td>
						<td><c:out value='${data.cmMberBbsCmtCount}'/></td>
						<td>
							<c:if test='${data.mberStateCd ==1003}'><a href="#" class="s-btn type1" onclick="jsMemberSecede('<c:out value='${data.cmmntyId}'/>');"  class="btns st3">탈퇴</a></c:if>
							<c:if test='${data.mberStateCd ==1001}'><a href="#" class="s-btn type1" onclick="jsMemberCancel('<c:out value='${data.cmmntyId}'/>');"  class="btns st3">취소</a></c:if>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty pager.list }">
					<tr>
						<td colspan="8">등록된 데이터가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
			<!-- //list -->
		</div>
		

		<!-- paging -->
		<div class="paging">
			<span><op:pager pager="${pager}" page="pager/webPager.jsp" /></span>
		</div>
		<!-- //paging -->
		
	</form>
	</div>
</body>


</html>
