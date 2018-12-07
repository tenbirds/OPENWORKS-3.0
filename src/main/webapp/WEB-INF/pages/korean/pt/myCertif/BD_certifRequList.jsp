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
    <title>구매내역 관리 - 마이씨앗</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <%-- <op:jsTag type="openworks" items="form" /> --%>
    <op:jsTag type="spi" items="datepicker" />
    <%-- <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script> --%>
        
    <script type="text/javascript">
	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "BD_certifRequList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }

        // 엑셀 다운로드
        var jsExcelList = function() {
            location.href = "BD_certifRequListExcel.do?" + $("#dataForm").serialize();
        };

        // 구매(실적)증명서 발급요청
        var jsAcmsltCrtfRequst = function(el) {
            var chkCnt=0
			$("input[name=cntrctSvcSns]:checked").each(function() {
				var requstChkVal = $(this).val();
				chkCnt ++;
			});

			if(chkCnt == 0 ){ 
			    alert("한개 이상의 서비스를 선택하세요."); return;
			}else{
			    
	            document.dataForm.action = "BD_certifRequForm.do";
	            document.dataForm.method = "POST";
	            document.dataForm.submit();
			    
/* 			    
			    $(el).colorbox({
		            title : "구매희망담기",
		            href : "/korean/pt/myCertif/BD_certifRequForm.do",
		            width : "920",
		            height : "500",
		            overlayClose : false,
		            escKey : true,
		            iframe : true
		        });
 */			    
			} 

			//if(confirm("선택하신 서비스에 대하여 증명서 발급요청을 하시겠습니까?")) {
	            //document.dataForm.action = "BD_certifRequForm.do";
	            //document.dataForm.method = "POST";
	            //document.dataForm.submit();
			//}
        }
        
	    // 검색기간 초기화
	    var jsSrcTermClear = function(){
	        $('#q_searchStartDt').val('');
	        $('#q_searchEndDt').val('');
	    }
    </script>

</head>
<body>
	<div class="certifRequList1">
		<form name="dataForm" id="dataForm">
		  <div class="schOpt on">	
				<table class="tbl_st4" summary="검색">
					<caption>검색</caption>
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
					</colgroup>
					<thead hidden="hidden">
						<tr>
							<th scope="row" colspan="2">카테고리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">카테고리</th>
							<td><span class="sel_box">
									<select name="searchDiv01" id="searchDiv01">
										<option value="1000" <c:if test="${1000 eq searchMap.searchDiv01}">selected="selected"</c:if> >사업명</option>
										<option value="1002" <c:if test="${1002 eq searchMap.searchDiv01}">selected="selected"</c:if>>서비스명</option>
										<option value="1001" <c:if test="${1001 eq searchMap.searchDiv01}">selected="selected"</c:if> >제공자</option>
									</select><label for="searchDiv01"></label>
								</span>
								<input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchMap.searchKeyWord}" style="width:570px;margin-left:10px" alt="검색"/>
								<label for="searchKeyWord"></label>
							</td>
						</tr>
						<tr>
							<th scope="row">이용기간</th>
							<td class="term">
								<input type="text" name="q_searchStartDt" id="q_searchStartDt" value="${param.q_searchStartDt}" title="시작날짜"/><label for="q_searchStartDt"></label> 
								~ 
								<input type="text" name="q_searchEndDt" id="q_searchEndDt" value="${param.q_searchEndDt}" title="종료날짜"/><label for="q_searchEndDt"></label>
								<!-- 
								<a href="#" onclick="jsSrcTerm('today'); return false;" class="btns st3">오늘</a>
								<a href="#" onclick="jsSrcTerm('week'); return false;" class="btns st3">1주일</a>
								<a href="#" onclick="jsSrcTerm('oneMonth'); return false;" class="btns st3">1개월</a>
								<a href="#" onclick="jsSrcTerm('threeMonth'); return false;" class="btns st3">3개월</a> 
								-->
								<a href="#none" onclick="jsSrcTermClear(); return false;" class="btns st3" title="초기화">초기화</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btnArea rig mtm20">
				<a href="#none" onclick="javascript:jsListSearch(0);" class="btns st5" title="검색">검 색</a>
			</div>
					
			<div class="list_st1">
				<p class="head">
					<span>총 ${pager.totalNum}개</span>
					<span><a href="#none" onclick="jsAcmsltCrtfRequst(this); return false;" class="btns st1 icn icnPaper" title="이용실적증명서 발급요청">이용실적증명서 발급요청</a></span>
				</p>
				<div class="scrollarea">
				<table class="tbl_st1" summary="이용실적증명서 발급 신청 목록">
				<caption>이용실적증명서 발급 신청 목록</caption>
					<colgroup>
						<col width="5%"/>
						<col width="*"/>
						<col width="20%"/>
						<col width="*"/>
						<col width="20%"/>
						<col width="5%"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="row">번호</th>
							<th scope="row">사업명</th>
							<th scope="row">이용기간</th>
							<!-- <th>계약서</th> -->
							<!-- th>구분</th -->
							<th scope="row">서비스명</th>
							<th scope="row">제공자</th>
							<th scope="row"><input type="checkbox" id="allCheck" name="allCheck" /><label for="allCheck"></label></th>
						</tr>
					</thead>
						<tbody>
							<c:set var="index" value="${pager.indexNo}"/>
							<c:set var="precntrctSn" value="0" /> 
							<c:forEach items="${pager.list}" var="listData" varStatus="status">
							<tr>
								<td>${index-status.index}</td>
								<c:if test="${listData.cntrctSn ne precntrctSn}">
								<td class="lef" rowspan="${listData.serviceCnt}">${listData.svcNm}</td>
								<td rowspan="${listData.serviceCnt}"> ${listData.cntrctBeginDe} ~  ${listData.cntrctEndDe}</td>
								<%-- <td rowspan="${listData.serviceCnt}">
									<c:if test="${listData.ctrtcSnId != null and listData.ctrtcSnId != ''}">
										<a href="/component/file/ND_fileDownload.do?id=${listData.ctrtcSnId}"><img src="/cloud_ver2/new_cloud/images/icn_ceart_contract.png" alt="계약서"></a>
									</c:if>
								</td> --%>
								</c:if><c:set var="precntrctSn" value="${listData.cntrctSn}" /> 
								<%-- td>${listData.goodsTyNm}</td --%>
								<td>${listData.goodsNm}</td>
								<td>${listData.suplerStoreNm}</td>
								<td><input type="checkbox" id="cntrctSvcSns${index-status.index}" name="cntrctSvcSns" value="${listData.cntrctSvcSn}"/><label for="cntrctSvcSns${index-status.index}"></label></td>
								<c:if test="${listData.serviceCnt > 1}"><c:set var="rowsView" value="false" /> </c:if> 
							</tr>
							</c:forEach>
							<!-- 데이터가 없을 때 알림 문구 -->
							<c:if test="${empty pager.list}">
								<op:no-data obj="${pager}" colspan="10" />
							</c:if>
						</tbody>
					</table>
					</div>
				</div>
			</form>
			<div class="btnarea">
				<a href="#none" onclick="jsExcelList(this);" class="btns st1 icn icnXlx" title="엑셀 다운로드">엑셀 다운로드</a>
			</div>
	</div>
  <!-- datepicker -->
  <script>
	$(document).ready(function() {
	    $("#q_searchStartDt, #q_searchEndDt").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });
	});
  </script>
  <!--// datepicker -->
	
</body>
</html>