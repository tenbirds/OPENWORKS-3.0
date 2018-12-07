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
    <title></title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
        // 조회버튼 클릭
        function jsListSearch(page){
            $("#dataForm input[name=q_currPage]").val(page);
            document.dataForm.action = "/korean/pt/suplerCeart/BD_beforeRequestList.do";
    	    document.dataForm.method = "POST";
    	    document.dataForm.submit();
        }

        // 엑셀 다운로드
        var jsExcelList = function() {
            location.href = "/korean/pt/suplerCeart/INC_EXCEL.do?" + $("#dataForm").serialize();
        };

        // 서비스 상세보기
        function jsRequestDetailView(notifyNum, notifySeq, endsUserId)
        {
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            $('#p_endsUserId').val(endsUserId);
            
            document.dataForm.action = "/korean/pt/suplerCeart/BD_beforeRequestDetailView.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }
        
    </script>

</head>
<body>
    <div class="conWrap">
        <form name="dataForm" id="dataForm">
            <input type="hidden" name="q_currPage"    id="q_currPage" value="${currPage}"/> <!--  현재 페이지 -->
            <input type="hidden" name="p_notifyNum"   id="p_notifyNum" />  <!-- (상세보기용) 공고번호 -->
            <input type="hidden" name="p_notifySeq"   id="p_notifySeq" />  <!-- (상세보기용) 공고차수 -->
            <input type="hidden" name="p_endsUserId"  id="p_endsUserId" /> <!-- (상세보기용) 이용자ID -->
		
			<div class="supAdm answAdm">
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01" >
							<option value="1001" <c:if test="${searchDiv01 == '1001'}">selected="true"</c:if> >서비스명</option>
							<option value="1002" <c:if test="${searchDiv01 == '1002'}">selected="true"</c:if> >문의기관</option>							
						</select><label for="searchDiv01"></label>
					</span>
					
					<div>
						<label><input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/></label>
					</div>
					<a href="#" onclick="javascript:jsListSearch(0);" class="btns st5">검 색</a>
				</div>

				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum} 개</span>
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="javascript:jsListSearch(0);" >
								<option value="">전체</option>
								<option value="1005">접수</option>
								<option value="1004">발송</option>
								<option value="1006">삭제</option>
							    <!--<c:forEach items="${codeList_askApplyCd}" var="askApplyCd" varStatus="status">
							        <option value="${askApplyCd.prvCd}" <c:if test="${searchDiv02 == askApplyCd.prvCd}">selected="true"</c:if> >${askApplyCd.prvNm}</option>
							    </c:forEach>-->
							</select><label for="searchDiv02"></label>
						</span>
					</p>
					
					<table class="tbl_st1" summary="견적 답변관리 목록">
						<caption>견적 답변관리</caption>
						<colgroup>
							<col width="5%"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="20%"/>
							<col width="10%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="row">번호</th>
								<th scope="row">구분</th>
								<th scope="row">서비스</th>
								<th scope="row">기업/기관</th>
								<th scope="row">답변 만료일</th>
								<th scope="row">답변 상태</th>
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
                            <c:forEach items="${pager.list}" var="listData" varStatus="status">
							    <tr>
								    <td>${index-status.index}</td>
								    <td>${listData.goodsKndCd}</td>
								    <td>
								        <i>${listData.auditlogNm}</i>
								        
									    <a href="#" onclick="javascript:jsRequestDetailView('${listData.notifyNum}','${listData.notifySeq}','${listData.endsUserId}'); return false;">
									    	${listData.goodsNm}
									    </a>									
								    </td>
								    <!-- td>황길동</td -->
								    <td>${listData.realDmndOrgn}</td>
								    <td>${listData.rplyDt}</td>
								    <td>${listData.askApplyNm}</td>
							    </tr>
                            </c:forEach>
                            <!-- 데이터가 없을 때 알림 문구 -->
                            <c:if test="${empty pager.list}">
                                <op:no-data obj="${pager}" colspan="9" />
                            </c:if>
						</tbody>
					</table>								
				</div>
					
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
				
			</div>
	    </form>
	</div>
	<!--// content -->
</body>
</html>