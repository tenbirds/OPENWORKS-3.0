<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
	$(document).ready(function(){
	});
</script>

<div class="tbl-view">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" summary="선택한 컨텐츠 정보">
        <caption class="title">선택한 컨텐츠 정보</caption>
        <tr>
            <th>ID</th>
            <td class="emphasis" style="color:red">${param.fileNm}</td>
        </tr>
        <tr>
            <th>파일 경로</th>
            <td>${dataVo.childMenuUrl}</td>
        </tr>
        <tr>
            <th>파일 크기</th>
            <td>${dataVo.cssContents}</td>
        </tr>
        <tr>
            <th>최종 수정일</th>
            <td>${dataVo.jsContents}${dataVo.approvalDt}</td>
        </tr>
        <tr>
            <th>파일 명</th>
            <td>${dataVo.applyYn}${dataVo.approvalSt}
            ${dataVo.approvalId}${dataVo.approvalNm}</td>
        </tr>
    </table>
</div>

<div style="margin-top: 10px;">
    <textarea name="menuContents" id="menuContents" class="hidden">${dataVo.menuContents}</textarea>
</div>
