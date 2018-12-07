<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>지식 | 씨앗위키 | 작성이력</title>  
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud/js/common.js"></script>

    <!-- 사용자 정의 script -->
    <script type="text/javascript">
        // 위키 작성내용 되돌리기
        var jsUndoContents = function(wikiSn){
         
            var ret = confirm("해당 내용으로 되돌리시겠습니까?");

            if (ret == true) {
                $('#p_wikiSn').val(wikiSn); // 되돌리기할 위키 순번
                
                var srcForm = $("form[name=srcForm]").serialize();

                $.ajax({
                    type: "POST",
                    async:false,  // 리턴값이 올때까지 다음 처리 대기
                    url: "/korean/pt/wiki/BD_undoContents.do",
                    data: srcForm,
                    dataType: "text",
                    success:function(response){
                        if(response != ""){
                            alert(response);
                            // 정상 적용시 메인 페이지로 이동
                            jsPageMove();
                        }else{
                            ret = true;
                        }
                    }
                });
            }   

        };
        
        // 메인페이지로 이동
        var jsPageMove = function(){
            $('#p_wikiSn').val(""); // 되돌리기 이후에는 첫 글이 조회되어야 하므로
            $("form[name=srcForm]").attr("method","post");
        	$("form[name=srcForm]").attr("action","/korean/pt/wiki/BD_index.do");
        	$("form[name=srcForm]").submit();
        }
        
        // 보기버튼 클릭 이벤트(이력 내용 상세 보기)
        var jsDetailView = function(wikiSn){
            $('#p_wikiSn').val(wikiSn); // 상세보기할 위키 순번
            
            $("form[name=srcForm]").attr("method","post");
        	$("form[name=srcForm]").attr("action","/korean/pt/wiki/BD_index.do");
        	$("form[name=srcForm]").submit();
        }
    </script>
    <!-- //사용자 정의 script -->
    
</head>
<body>
    <!-- 파라미터 전달용 form -->
    <form id="srcForm" name="srcForm">
        <input type="hidden" name="p_userId" id="p_userId" value="${sessionScope['__usk'].userId}"/> <!-- 현재 처리할 사용자ID -->
        <input type="hidden" name="p_wikiSn" id="p_wikiSn" />                                        <!-- 처리할 위키 순번 -->
    </form>
    
    
	<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">
			<h2>씨앗위키</h2>
		</div>
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section">
			<!-- list -->
			<div class="type-list no-bor">
				<table>
					<caption>리스트</caption>
					<colgroup>
					<col style="width:;"/>
					</colgroup>
					<thead>
						<tr>
							<th class="al"><strong class="txt-point">작성이력</strong></th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${pager.list}" var="_wikiHistoryList" varStatus="status">
						<tr>
							<td>
							    <!-- 최근 글일 경우 -->
							    <c:if test="${_wikiHistoryList.rowNo == '1'}">
							    <p class="txt-icon on">
									<em>${_wikiHistoryList.registDt}</em>
									<em>${_wikiHistoryList.registerNm}</em>
									<em><a href="javascript:jsDetailView('${_wikiHistoryList.wikiSn}');">현재</a></em>
								</p>
							    </c:if>
							    <!-- //최근 글일 경우 -->

								<!-- 최근 글이 아닐 경우 -->
								<c:if test="${_wikiHistoryList.rowNo != '1'}">
							    <p class="txt-icon">
									<em>${_wikiHistoryList.registDt}</em>
									<em>${_wikiHistoryList.registerNm}</em>
									<em><a href="javascript:jsDetailView('${_wikiHistoryList.wikiSn}');">보기</a></em>
									
									<!-- 내가 등록한 글일 경우만 되돌리기 버튼 보이기 -->
									<c:if test="${sessionScope['__usk'].userId == _wikiHistoryList.registId}">
									    <a href="javascript:jsUndoContents('${_wikiHistoryList.wikiSn}');" class="s-btn type1"><strong><span>되돌리기</span></strong></a>
									</c:if>
									<!-- //내가 등록한 글일 경우만 되돌리기 버튼 보이기 -->
								</p>
							    </c:if>
							    <!-- //최근 글이 아닐 경우 -->
							    
							</td>
						</tr>
					    </c:forEach>

					    <op:no-data obj="${pager}"/>
					</tbody>
				</table>
			</div>
			<!-- //list -->

			<!-- paging -->
			<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
			<!-- //paging -->
		</div>
		<!-- //section -->

	</div>
	<!-- //contents -->
	  
</body>
</html>