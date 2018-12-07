<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h3>조회기간 : <strong>${dataVo.searchTermStr}</strong> [총 <span class="emphasis">${dataVo.dayDiff}</span> 일 간의 통계]</h3>

<table class="boardWrite" summary="게시물 통계 overview">
	<caption>게시물 통계 overview</caption>
	<colgroup>
		<col width="200px" />
		<col width="" />
	</colgroup>
    <tr>
        <th>등록 게시물수</th>
        <td>
            <strong>${dataVo.totalCreate}</strong>개 [평균 : <strong>${dataVo.average}</strong>개/일]
        </td>
    </tr>
    <tr>
        <th>삭제 게시물수</th>
        <td>
            <strong>${dataVo.totlaDelete}</strong> 개
        </td>
    </tr>
    <tr>
        <th>등록 커멘트수</th>
        <td>
            <strong>${dataVo.totalComment}</strong> 개
        </td>
    </tr>
    <tr>
        <th>등록 첨부 파일수</th>
        <td>
            <strong>${dataVo.totalFileCnt}</strong> 개
        </td>
    </tr>
    <tr>
        <th>첨부 파일 다운 횟수</th>
        <td>
            <strong>${dataVo.totalFileDownCnt}</strong> 회
        </td>
    </tr>
    <tr>
        <th>첨부 파일 다운 용량</th>
        <td>
            <strong>${dataVo.totalFileDownSize}</strong>
        </td>
    </tr>
</table>