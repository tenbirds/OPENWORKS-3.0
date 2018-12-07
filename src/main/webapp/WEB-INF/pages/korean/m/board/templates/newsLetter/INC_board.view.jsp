<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!-- section -->
<div class="section">
	<!-- view -->
	<div class="type-view">
		<!-- 내용보기 -->
		<table class="tbl_detail_view">
			<colgroup>
				<col style="width:;"/>
				<col style="width:;"/>
		    </colgroup>
		    <thead>
				<tr>
					<th colspan="2"><c:out value='${dataVo.bbscttSj}'/></th>
				</tr>
			</thead>
		    <tbody>
		        <tr>		          
		            <td class="al"><c:out value='${dataVo.maskRegistId}'/> | 조회수 <c:out value='${dataVo.rdcnt}'/></td>
		            <td class="ar"><c:out value='${dataVo.registDt}'/></td>		            
		        </tr>
		        <tr>
		            <td colspan="2" class="txt_view borb">
		                <c:out value='${dataVo.bbscttCn}' escapeXml="false" />
		            </td>
		        </tr>
		    </tbody>
		</table>
	</div>
	<!-- //view -->   
	<!-- 버튼 -->
	<div class="btn-area mt20">
		<div class="btn_navi"><a href="#" class="b-btn list fl type1" onclick="jsList('<c:out value='${param.q_currPage}'/>');"><strong><span class="list">목 록</span></strong></a></div>
	</div>
	<!-- //버튼 -->
	<!-- 목록 보여주기 시작 -->
	<form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
	    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
	    <op:pagerParam view="view"/>
	
	    <!-- 다음/이전을 다음/이전으로 보기 -->
	    <c:if test="${boardConfVo.listViewCd == 1002}">
	        <%@include file="/WEB-INF/pages/web/board/templates/common/korean/INC_prev.next.list.jsp" %>
	    </c:if>
	    <!-- 다음/이전을 다음/이전으로 보기 끝 -->
	
	    <input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}'/>" />
	    <input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>" />
	    <input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}'/>" />
	    <input type="hidden" name="ctgCd" id="ctgCd" value="<c:out value='${dataVo.ctgCd}' />" />
	    <input type="hidden" name="pageType" id="pageType" value="<c:out value=''/>" />
	</form>
</div>