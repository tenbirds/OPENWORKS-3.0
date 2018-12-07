<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<%-- 항목 표시 수 --%>
<c:set var="thCnt" value="0" />
<!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="30px"/>  <!-- 체크박스 -->
                <col width="50px"/>  <!-- No. -->
                <col width="100px"/> <!-- 접수일자 -->
                <col width="100px"/> <!-- 회원구분 -->
                <col width="100px"/> <!-- 고객명 -->
                <col width="120px"/> <!-- 연락처 -->
                <col width="120px"/> <!-- 기관분류 -->
                <col width="120px"/> <!-- 소속 -->
                <col width="100px"/> <!-- voc종류 -->
                <col width="20%"/>  <!-- 문의내용 -->	
                <col width="20%"/>  <!-- 답변 -->
                <col width="100px"/> <!-- 처리상태 -->
                <col width="50px"/>  <!-- 비고 -->
            </colgroup>
            <thead>
            	<tr>
            		<th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
            		<th>No.</th>
	                <th>접수일자</th>
	                <th>회원구분</th>
	                <th>고객명</th>
	                <th>연락처</th>
	                <th>기관분류</th>
	                <th>소속</th>
	                <th>VOC종류</th>
					<th>문의내용</th>
	                <th>답변</th>
	                <th>처리상태</th>
	                <th>비고</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${fn:length(vocList)}"/>
                <c:forEach var="vocItem"  items="${vocList}" varStatus="status">
                    <tr>
						<td><input type="checkbox" name="vocBbscttSn" value="${vocItem.vocBbscttSn}"/></td>
						<td><c:out value="${index-status.index}" /></td>	<!-- No. -->
						<td><c:out value="${vocItem.recptDe}" /></td>       <!-- 접수일자 -->
						<td><c:out value="${vocItem.memberAt}" /></td>      <!-- 회원구분 -->
						<td><c:out value="${vocItem.userNm}" /></td>        <!-- 고객명 -->
						<td><c:out value="${vocItem.telno}" /></td>         <!-- 연락처 -->
						<td><c:out value="${vocItem.insttTyNm}" /></td>     <!-- 기관분류 -->
						<td><c:out value="${vocItem.pstinstNm}" /></td>     <!-- 소속 -->
						<td><c:out value="${vocItem.vocInqryTy}" /></td>    <!-- VOC종류 -->
						<td>
							<a href="#" class="contentTip" onclick="vocDetail('${vocItem.vocBbscttSn}');">
								<c:out value="${vocItem.vocInqryCn}" />
							</a>
						</td>		<!-- 문의내용 -->				
						<td><c:out value="${vocItem.vocAnswerCn}" /></td>   <!-- 답변 -->
						<td><c:out value="${vocItem.vocProgressSttus}" /></td><!-- 처리상태 -->
						<td>추가</td>                                  		<!-- 비고 --> 
					</tr> 
                </c:forEach>
            </tbody>
        </table>
		<form name="vocDetailForm" id="vocDetailForm" method="get" action="BD_vocBoard.view.do">
			<input type="hidden" name="vocBbscttSn" id="vocBbscttSn" value="" />
		</form>
<script type="text/javascript">
	
	// voc 상세보기
	vocDetail = function(seq) {
	    alert("상세보기 이벤트");
	    alert("순번은 : "+seq);
	    document.vocDetailForm.submit();
	    // 순번을 파라미터로 추가하여 폼 전송
	    // form.submit();
	};
	
</script>
