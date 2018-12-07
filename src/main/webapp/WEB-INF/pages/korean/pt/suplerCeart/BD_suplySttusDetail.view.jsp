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
	    
	    // 총 공급 이력 보기
	    var jsTotSuplySttusHist = function(){
	        document.dataForm.action = "/korean/pt/suplerCeart/BD_totSuplySttusHistList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
    </script>

</head>
<body>
    <div class="conWrap">
        <form name="dataForm" id="dataForm" method="post">
        
            <input type="hidden" name="q_goodsTyCd"     id="q_goodsTyCd"     value="${q_goodsTyCd}"/>   <!--  목록 페이지 서비스구분 -->
            <input type="hidden" name="q_ctgryCd1"      id="q_ctgryCd1"      value="${q_ctgryCd1}"/>    <!--  목록 페이지 서비스대구분 -->
            <input type="hidden" name="q_ctgryCd2"      id="q_ctgryCd2"      value="${q_ctgryCd2}"/>    <!--  목록 페이지 서비스중구분 -->
            <input type="hidden" name="q_ctgryCd3"      id="q_ctgryCd3"      value="${q_ctgryCd3}"/>    <!--  목록 페이지 서비스소구분 -->
            <input type="hidden" name="searchKeyWord"   id="searchKeyWord"   value="${searchKeyWord}"/> <!--  목록 페이지 검색어 -->
            <input type="hidden" name="searchStartDt"   id="searchStartDt"   value="${searchStartDt}"/> <!--  목록 페이지 검색시작일 -->
            <input type="hidden" name="searchEndDt"     id="searchEndDt"     value="${searchEndDt}"/>   <!--  목록 페이지 검색종료일 -->
            <input type="hidden" name="q_currPage"      id="q_currPage"      value="${currPage}"/>      <!--  현재 페이지 -->
            <input type="hidden" name="p_goodsCode"     id="p_goodsCode"     value="${baseList.goodsCode}"/>      <!--  상세페이지용 서비스코드 -->
            <input type="hidden" name="p_goodsNm"       id="p_goodsNm"       value="${baseList.goodsNm}"/>        <!--  상세페이지용 서비스명 -->
            <input type="hidden" name="p_suplerStoreNm" id="p_suplerStoreNm" value="${baseList.suplerStoreNm}"/>  <!--  상세페이지용 제공자회사명 -->
            <input type="hidden" name="p_goodKndCd"     id="p_goodKndCd"     value="${baseList.goodKndCd}"/>      <!--  상세페이지용 서비스구분 -->

			<div class="supAdm">
				<p class="viewTit">
					${baseList.goodsNm}[${baseList.suplerStoreNm}]
                    <a href="/korean/pt/store/software/BD_view.do?goodsCode=${baseList.goodsCode}&pageUrlNm=null&goodsTyCd=${baseList.goodKndCd}&ctgryPath=&_pathLang=korean'"class="btns st3">서비스 상세보기</a>
					<a href="#" onclick="jsTotSuplySttusHist();" class="btns st3">총 공급 이력</a>
				</p>
				
				<h3>이용자 정보</h3>				
				
				<table class="tbl_st4">
					<tr>
						<th>이름</th>
						<td colspan="3">${baseList.endsUserNm}</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>${baseList.endsUserMbtlnum}</td>
						<th>이메일</th>
						<td>${baseList.endsUserEmail}</td>
					</tr>
					<tr>
						<th>기업/기관명</th>
						<td colspan="3">${baseList.endsUserStoreNm}</td>
					</tr>
					<tr>
						<th>담당자전화</th>
						<td colspan="3">${baseList.endsUserReprsntTelno}</td>
					</tr>
				</table>
				
				<h3>공급 이력</h3>
				<div class="list_st1">
					<p class="head">
						<span>총 ${fn:length(dataList)} 개</span>						
					</p>
					
					<table class="tbl_st1">
						<thead>
							<tr>
								<th>번호</th>
								<th>계약기간</th>
								<th>금액(\)</th>							
								<th>계약서 파일</th>
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${fn:length(dataList)}"/>
                            <c:forEach items="${dataList}" var="dataList" varStatus="status">
							<tr>
								<td>${index-status.index}</td>
								<td>${dataList.cntrctBeginDe} ~ ${dataList.cntrctEndDe}</td>
								<td><fmt:formatNumber value="${dataList.cntrctamount}" groupingUsed="true"/></td>
								<td>
								    <c:if test="${dataList.ctrtcSnId != ''}">
								        <a href="/component/file/ND_fileDownload.do?id=${dataList.ctrtcSnId}" class="downLoad">다운로드</a>
								    </c:if>
								</td>							
							</tr>
                            </c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="btnArea rig">
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>
			</div>
	    </form>
	</div>
	<!--// content -->
 </body>
</html>