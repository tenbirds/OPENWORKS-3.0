<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.web.common.CommonDutyConstant"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	// 변경소스
	request.setAttribute("SubDomain", "korean");
	//}}
	String nowURL = request.getRequestURI().toString();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 | 커뮤니케이션 | 씨앗 마켓</title>	
	<op:jsTag type="spi" items="form, validate" />
    <script type="text/javascript">
    $(document).ready(function(){	
        var cmmntyCtgryCd = "<c:out value='${cmmntyCtgryCd}'/>";
        var subdomain = "<c:out value='${SubDomain}'/>";
        var nowURL = "";
        if(cmmntyCtgryCd == ""){
            nowURL = "<%=nowURL%>";
          }else{
              nowURL = subdomain+"/pt/communication/community/BD_index<c:out value='${cmmntyCtgryCd}'/>.do?cmmntyCtgryCd=<c:out value='${cmmntyCtgryCd}'/>";
          }
        $("#nowURL").val(nowURL);
    });
   
 // 회원구분 이동
    var cmSortTabMove = function(cmSortTab){
        
         var cmmntyCtgryCd = "<c:out value='${cmmntyCtgryCd}'/>";
       	 var movepage = "";
         if(cmmntyCtgryCd == ""){
           movepage = "BD_index.do";
         }else{
         	movepage = "BD_index<c:out value='${cmmntyCtgryCd}'/>.do?cmmntyCtgryCd=<c:out value='${cmmntyCtgryCd}'/>";
         }
        $("#q_cmSortListTab").val(cmSortTab);
        $('#q_currPage').val("1");
        $('#dataForm').attr("action",movepage).submit();
   	};
   	
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#dataForm #q_cmSortListTab").val();
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };    
      //통합검색바
     var jsSearchAction = function() {
         var cmmntyCtgryCd = "<c:out value='${cmmntyCtgryCd}'/>";
         var movepage = "";
          if(cmmntyCtgryCd == ""){
            movepage = "BD_index.do";
          }else{
          	movepage = "BD_index<c:out value='${cmmntyCtgryCd}'/>.do?cmmntyCtgryCd=<c:out value='${cmmntyCtgryCd}'/>";
          }
          $('#q_currPage').val("1");
          $('#dataForm').attr("action",movepage).submit();
     };
 // 페이지 이동
	   var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	   };
	   
		var jsCmOpen = function(fn){
		    if(fn == "" ){
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "ND_loginCheckURL.do?cmmntyCtgryCd=<c:out value='${cmmntyCtgryCd}'/>",
	   	            type     : "POST",
	   	            dataType : "json",
	   	       		async : false,
	   	            success  : function(data) {
		   	            if (data.result == true)  {
	   	           			alert(data.message);
	   	           			
	   	           			location.href = data.value;
		   	            } 
	   	            }
	   	        });
		  //  }else if(fn == "1002" || fn == "2002" ){ 
		       
		    }else{
		        jrMove("BD_cmOpenForm.do");
		       // alert("판매자만 커뮤니티 개설할 수 있습니다!");
		    }
  	   	};
    </script>
<!-- 1001	개인회원	OP_USER	USER_TY_CD -->
<!-- 1002	개인판매회원		 -->
<!-- 2001	기업회원		 -->
<!-- 2002	기업판매회원		 -->
</head>
<body>

		<section class="listTit">
			<!-- 타이틀 영역 -->
			<div class="conWrap">
				<h2>커뮤니티</h2>
				<div>전체 커뮤니티  <a href="#none" onclick="jsCmOpen('<c:out value="${sessionScope['__usk'].userTyCd}"/>');" class="makeCommun">커뮤니티 개설</a>			
				</div>
			</div>
			<!--// 타이틀 영역 -->
		</section>
		
		<form name="dataForm" id="dataForm" method="post" >
		<input type="hidden" name="q_cmSortListTab" id="q_cmSortListTab"  value="<c:out value='${param.q_cmSortListTab}' default ='1001' />" />
		<input type="hidden" id="nowURL" name="nowURL" value=""/> 
		<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='${param.q_currPage}'/>"/>
		
	 	<section class="lay_lnb">
			<div class="conWrap">
			<nav>
				<!-- 좌측 카테고리 -->
				<ul>					
					<li class="on">
						<a href="/korean/pt/communication/community/BD_index.do">전체 커뮤니티</a>
					</li>
					<li>
					  <a href="#none" onclick="jsCmOpen('<c:out value="${sessionScope['__usk'].userTyCd}"/>');">커뮤니티 개설</a>
					</li>
				</ul>
				<!--// 좌측 카테고리 -->
			</nav>
			
			<div class="communList">
				<div class="schArea">
				    <span class="sel_box">
						<select id="q_keyWordSearch" name="q_keyWordSearch" title="검색대상 선택" style="width:150px;">
							<option value="1001" <c:if test="${param.q_keyWordSearch== 1001}">selected="selected"</c:if>>커뮤니티 이름+설명 </option>
							<option value="1002" <c:if test="${param.q_keyWordSearch== 1002}">selected="selected"</c:if>>개설자명</option>
						</select>
					</span>
					
					<div>
						<input type="text" title="카테고리내 검색 단어 입력" name="q_searchKeyWord" id="q_searchKeyWord" class="input" value="<c:out value='${param.q_searchKeyWord}'/>" >
					</div>
					<input type="submit" title="검색" value="검색"  name="sech" id="sech" class="btns st5" onclick="jsSearchAction();" />							
				</div>				
			
				<!-- section -->
				<div class="list_st1">		
					<p class="head">
						<span>총 <c:out value="${pager.totalNum}"/> 개 </span>						
					</p>
					
					<table>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
			        <c:forEach items="${pager.list}" var="data" varStatus="status">
						<tr>
							<th>
								<ul><fmt:parseDate value='${data.confmDt}' var='confmDt' pattern="yyyy-MM-dd HH:mm" scope="page"/>
									<li>개설일 : <fmt:formatDate value="${confmDt}" pattern="yyyy.MM.dd" /></li>
									<li>개설자 : <c:out value='${data.userNm}'/></li>
									<c:if test="${param.q_cmSortListTab== 1002}">
									<li>회원수 : <c:out value='${data.cmMberTopCount}'/></li>
									<li>게시글 : <c:out value='${data.cmBbsTopCount}'/></li>
									</c:if>
									<c:if test="${param.q_cmSortListTab != 1002}">
									<li>회원수 : <c:out value='${data.cmMberCount}'/></li>
									<li>게시글 : <c:out value='${data.cmBbsCount}'/></li>
									</c:if>
								</ul>
							</th>
							<td>
								<dl>
									<c:if test="${data.langCode != '00'}">
			                             <dt><a href="http://<c:out value='${data.cmmntyUrl}'/>" id="popView<c:out value='${status.count }'/>" target="_blank" ><c:out value='${data.cmmntyNm}'/></a></dt>
			                        </c:if>
			                     	<c:if test="${data.langCode == '00'}">
			                             <dt><a href="http://<c:out value='${data.cmmntyUrl}'/>" id="popView<c:out value='${status.count }'/>" target="_blank" ><c:out value='${data.cmmntyNm}'/></a></dt>
			                        </c:if>
									<dd><c:out value='${data.cmmntyDc}'/></dd>
								</dl>
							</td>
						</tr>
						<c:if test="${empty pager.list}">
							<tr>
								<td colspan="2">설된 커뮤니티가 없습니다.</td>
							</tr>
						</c:if>
					</c:forEach>	
					</table>					
				</div>
					
					<!-- paging -->
					<div class="paging">
						<c:if test="${param.q_cmSortListTab!= 1002}">
							<op:pager pager="${pager}" page="pager/webPager.jsp" />
						</c:if>
					</div>
					<!-- //paging -->	
			
				<!--// section -->
				</form>
			</div>
		</div>	
	</section>

	<!-- //contents -->		
</body>
</html>