<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
	<link rel="stylesheet" type="text/css" href="/new_cloud_m/css/sub.css" />

    <script type="text/javascript">
    var jsMovePage = function(page) {
        if(page!=1){
            $("input[name=q_currPage]").val(page);
        }else{
            $("input[name=q_currPage]").val(1);
        }
        $("#dataForm").submit();

    };
    </script>    
<title>나의 커뮤니티</title>
</head>
<body>
<c:set var="index" value="${pager.indexNo}"/>
		<form id="dataForm" name="dataForm" method="post" action="BD_index.do">
		<input type="hidden" name="q_currPage" id="q_currPage" value="${param.q_currPage}" />           <!-- 페이지 유지를 위해 목록에서 넘어온값으로 세팅 -->
        <input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${param.q_rowPerPage}" />     <!-- 페이지 유지를 위해 목록에서 넘어온값으로 세팅 -->
		
		<!-- container -->
		<div id="container" >
			<!-- contents -->
			<div class="contents myCom">
				<div class="title-area">
	                <h2 id="menuNm">나의 커뮤니티</h2>
				</div>
				<span>총 ${pager.totalNum}개</span>
				<table>
					<thead>
						<tr>
							<th>커뮤니티 명</th>
							<th>제목 / 작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
						     <tr>
								<th><a href="/korean/cm/user/cmUserMain/BD_index.do?cmmntyId=${baseVo.cmmntyId}">${baseVo.cmmntyNm}</a></th>
								<td><a href="/korean/cm/user/cmUserBoard/cmBasicBoard/BD_cmBasicBoardView.do?cmmntyId=${baseVo.cmmntyId}&cmmntyMenuCode=${baseVo.cmmntyMenuCode}&cmmntyBbsSeq=${baseVo.cmmntyBbsSeq}">${baseVo.bbscttSj}</a>
	                             <br />■ 작성일 : ${baseVo.registDt}
								</td>
							</tr>
						</c:forEach> 
					<op:no-data obj="${pager}" colspan="2" />
					</tbody>					
				</table>
			</div>	
				<!-- 페이징 -->
				<op:pager pager="${pager}" page="pager/webPager.jsp"/>
           	    <!-- //페이징 -->	
		</div>
		</form>
		
		<!-- //container -->

</body>
</html>