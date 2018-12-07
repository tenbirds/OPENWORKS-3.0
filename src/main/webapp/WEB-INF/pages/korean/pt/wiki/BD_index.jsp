<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>지식 | 씨앗위키 | 위키대문</title>  
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud/js/common.js"></script>
	
	<!-- 사용자 정의 script -->
    <script type="text/javascript">
        var jsPageMove = function(dataCnt){
            var procDiv = "";
            // 데이터가 없을경우 등록 파라미터구분으로 셋팅
            if(dataCnt == 0){
                procDiv = "I";
            // 데이터가 있을경우 수정 파라미터구분으로 셋팅
            }else{
                procDiv = "U";
            }
            $('#p_procDiv').val(procDiv); // 처리구분
            $("form[name=srcForm]").attr("method","get");
        	$("form[name=srcForm]").attr("action","/korean/pt/wiki/BD_write.do");
        	$("form[name=srcForm]").submit();
        };
    </script>

</head>
<body>
    <!-- 파라미터 전달용 form -->
    <form id="srcForm" name="srcForm">
        <input type="hidden" name="p_procDiv" id="p_procDiv" />
    </form>
	
	<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">
			<h2>씨앗위키</h2>
			<a href="javascript:jsPageMove('${wikiWiew.wikiSn}');" class="b-btn position-ar type3">
			    <strong><span class="ml10 mr10"><c:if test="${fn:length(wikiWiew) == 0}">작성하기</c:if>
			                                    <c:if test="${fn:length(wikiWiew) != 0}">수정하기</c:if></span></strong>
			</a>
		</div>
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section">
			<!-- view -->
			<div class="type-view">
				<table>
					<caption>view</caption>
					<colgroup>
					<col style="width:;"/>
					</colgroup>	
					
					<!-- WIKI 작성내용이 없을 경우 -->
					<c:if test="${fn:length(wikiWiew) == 0}">
					<tbody>								
						<tr>
							<td>
								<div class="txt-cont">
									<p>등록된 내용이 없습니다.</p>
								</div>
							</td>
						</tr>
					</tbody>
					</c:if>
					<!-- //WIKI 작성내용이 없을 경우 -->
					
					<!-- WIKI 작성내용이 있을 경우 -->
					<c:if test="${fn:length(wikiWiew) != 0}">
					<thead>
						<tr>
							<th>
								<p class="txt-line">
									<em>작성일 : ${wikiWiew.registDt}</em>
									<em>작성자 : ${wikiWiew.registerNm}</em>
									<em><strong><a href="/korean/pt/wiki/BD_history.do">작성이력보기</a></strong></em>
								</p>
							</th>
						</tr>
					</thead>
					<tbody>								
						<tr>
							<td>
								<div class="txt-cont">
									<p>${wikiWiew.wikiCn}</p>
								</div>
							</td>
						</tr>
					</tbody>
					</c:if>
                    <!-- //WIKI 작성내용이 있을 경우 -->
				</table>
			</div>
			<!-- //view -->
		</div>
		<!-- //section -->
	</div>
	<!-- //contents -->
</body>
</html>