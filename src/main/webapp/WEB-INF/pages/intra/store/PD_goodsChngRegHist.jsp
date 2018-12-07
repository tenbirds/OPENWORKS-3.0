<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>이력관리</title>
    <op:jsTag type="spi" items="form, highlight" />
    <script type="text/javascript">
    </script>
</head>
<body>
    <div class="w_100p">
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
            <caption class="hidden"> 목록 </caption>
           <colgroup>
                <col width="8%"/>
                <col width="8%"/>
                <col width="14%"/>
                <col width="14%"/>
                <col width="14%"/>
                 <col width="14%"/>
                <col width="14%"/>
                <col width="10%"/>
            </colgroup> 
            <thead>
                <tr>
					<th>번호</th>
					<th>상태</th>
					<th>요청날짜</th>
					<th>요청ID</th>
					<th>승인날짜</th>
					<th>승인ID</th>	
					<th>가격변경</th>
					<th>변경사유서</th>
				</tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${fn:length(dataVo)}"/>
                <c:forEach items="${dataVo}" var="_histVo" varStatus="status">
                    <tr>
							<td>${fn:length(dataVo) -status.index}</td>
							<td><c:if test="${_histVo.EXMNT_CONFM_CD == 1007}" >승인</c:if>
								<c:if test="${_histVo.EXMNT_CONFM_CD == 1009}" >미승인</c:if>
							</td>
							<td>${_histVo.REQU_DT}</td>
							<td>${_histVo.REQU_ID}</td>
							<td>${_histVo.EXMNT_CONFM_DT}</td>	
							<td>${_histVo.MNGR_ID}</td>
							<td>
							<c:if test="${not empty _histVo.GOODS_CHNG_PC}" >
							전:${_histVo.GOODS_BEFORE_PC}, 후:${_histVo.GOODS_CHNG_PC}</c:if>
							<c:if test="${empty _histVo.GOODS_CHNG_PC}" >변경사항 없음.</c:if>
							</td>
							<td>
							<c:if test="${_histVo.GOODS_CHNG_FILE > 0}" >
							<a href="/component/file/ND_fileDownload.do?id=${_histVo.GOODS_CHNG_FILE_ID[0].fileId}" class="downLoad">사유서파일</a>
							</c:if>
							</td>
						</tr>
                </c:forEach>
                <op:no-data obj="${dataVo}" colspan="8" msg="변경된 이력내역이 존재하지 않습니다."/>
            </tbody>
        </table>
        <!-- //리스트 -->
        <div align="center" class="mar_t10">
            <input type="button" class="w80 mar_r10" onclick="parent.$.fn.colorbox.close();" value="확인"></input>
            
        </div>
    </div>
</body>
</html>