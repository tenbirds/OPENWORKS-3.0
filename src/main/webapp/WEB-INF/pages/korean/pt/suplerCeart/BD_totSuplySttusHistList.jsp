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
    <title>공급현황 상세 - 공급현황</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript">
	    //  목록보기 버튼
	    var returnList = function(){
	        document.dataForm.action = "/korean/pt/suplerCeart/BD_suplySttusList.do";    
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
    </script>

</head>
<body>
    <div class="conWrap">
        <form name="dataForm" id="dataForm" method="post">
            <input type="hidden" name="q_goodsTyCd"   id="q_goodsTyCd"   value="${q_goodsTyCd}"/>   <!--  목록 페이지 서비스구분 -->
            <input type="hidden" name="q_ctgryCd1"    id="q_ctgryCd1"    value="${q_ctgryCd1}"/>    <!--  목록 페이지 서비스대구분 -->
            <input type="hidden" name="q_ctgryCd2"    id="q_ctgryCd2"    value="${q_ctgryCd2}"/>    <!--  목록 페이지 서비스중구분 -->
            <input type="hidden" name="q_ctgryCd3"    id="q_ctgryCd3"    value="${q_ctgryCd3}"/>    <!--  목록 페이지 서비스소구분 -->
            <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/> <!--  목록 페이지 검색어 -->
            <input type="hidden" name="searchStartDt" id="searchStartDt" value="${searchStartDt}"/> <!--  목록 페이지 검색시작일 -->
            <input type="hidden" name="searchEndDt"   id="searchEndDt"   value="${searchEndDt}"/>   <!--  목록 페이지 검색종료일 -->
            <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>      <!--  현재 페이지 -->
			
			<div class="supAdm">
				<p class="viewTit">
					${p_goodsNm}[${p_suplerStoreNm}]
					
                    <a href="/korean/pt/store/software/BD_view.do?goodsCode=${p_goodsCode}&pageUrlNm=null&goodsTyCd=${p_goodKndCd}&ctgryPath=&_pathLang=korean'"class="btns st3">서비스 상세보기</a>
				</p>
				<h3>총 공급 이력</h3>
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>						
					</p>
					
					<table class="tbl_st1">
						<thead>
							<tr>
								<th>번호</th>
								<th>이용자</th>
								<th>계약기간</th>
								<th>공급가(\)</th>								
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
                            <c:forEach items="${pager.list}" var="listData" varStatus="status">
							<tr>
								<td>${index-status.index}</td>
								<td>${listData.commUserNm}</td>
								<td>${listData.cntrctBeginDe} ~ ${listData.cntrctEndDe}</td>
								<td><fmt:formatNumber value="${listData.cntrctamount}" groupingUsed="true"/></td>
							</tr>
                            </c:forEach>
                            <!-- 데이터가 없을 때 알림 문구 -->
                            <c:if test="${empty pager.list}">
                                <op:no-data obj="${pager}" colspan="4" />
                            </c:if>	
						</tbody>
					</table>
				</div>
				
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
				
				<div class="btnArea rig">
					<a href="#" class="f_l btns st1 icn icnXlx">엑셀다운로드</a>
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>
			</div>
		</form>
	</div>
	<!--// content -->
 </body>
</html>