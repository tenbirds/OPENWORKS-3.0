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
    <title>위키 미리보기</title>  
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud/js/common.js"></script>
	
	<!-- 사용자 정의 script -->
    <script type="text/javascript">

    </script>

</head>
<body>

	<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">
			<h2>씨앗위키</h2>
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
					
					<!-- WIKI 작성내용이 있을 경우 -->
					<tbody>								
						<tr>
							<td>
								<div class="txt-cont">
									<p><script>document.write(window.opener.$("#p_wikiCn").val());</script></p>
									
								</div>
							</td>
						</tr>
					</tbody>
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