<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>게시물 상세</title>

    <op:jsTag type="spi" items="colorbox, highlight, ui"/>
    <op:jsTag type="openworks" items="ui, form" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/samples/crud/samples.crud.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
    
        });

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="post" action="BD_crud.list.do">

        <input type="hidden" name="seq" id="seq" value="${baseVo.seq}" />
        <input type="hidden" name="q_replySeq" id="q_replySeq" value="" />

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />

    </form>

    <!-- 내용보기 -->
    <table class="boardView" cellspacing="0" border="0" summary="${baseVo.title} 게시글 정보입니다.">
        <caption class="hidden">${baseVo.title} 상세보기</caption>
        <colgroup>
            <col width="100%" />
        </colgroup>
        <thead>
            <tr>
                <th>
                    <div class="float_l w_92p">
                        <span class="tx_blue_w">[${baseVo.ctgCd}]</span>
                        ${baseVo.title}
                    </div>
                    <div class="float_r w_10p tx_r">
                        <c:choose>
                            <c:when test="${baseVo.openYn eq 'Y'}">공개</c:when>
                            <c:otherwise>비공개</c:otherwise>
                        </c:choose>
                        <a href="#" class="public">미공개</a>
                    </div>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="info">
                    <!--작성자 정보및 내용헤더정보 -->
                    <div class="con_info">
                        <dl>
                            <dt>작성자 :</dt>
                            <dd>${baseVo.regNm}</dd>
                            <dt>조회 :</dt>
                            <dd>${baseVo.readCnt}</dd>
                            <dt>등록일 :</dt>
                            <dd>${baseVo.regDt}
                                <c:if test="${not empty baseVo.modiDt}"> 
                                    (최종 수정 : ${baseVo.modiDt}) by ${baseVo.modiNm}
                                </c:if>
                            </dd>
                            <dt>IP :</dt>
                            <dd>${baseVo.ipAddr}</dd>
                        </dl>
                    </div>
                    <!--//작성자 정보및 내용헤더정보 -->
                </td>
            </tr>
            <tr>
                <td class="con">
                    ${baseVo.contents}
                </td>
            </tr>
            <tr>
                <td class="file">
                    <div>첨부파일</div>
                    <ul>
                        <c:choose>
                            <c:when test="${fn:length(baseVo.fileList) > 0}">
                                <c:forEach items="${baseVo.fileList}" var="fileVo">
                                    <li>
                                        <img src="/resources/openworks/theme/default/images/icon/icon_file_jpg.gif" class="vm" alt="파일 첨부" />
                                        <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a>
                                        <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
                                        <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${fileVo.fileSeq}', '${fileVo.fileId}');">이력보기</button>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li>첨부파일이 없습니다.</li>
                            </c:otherwise>
                        </c:choose>

                    </ul>
                </td>
            </tr>
        </tbody>
    </table>
    <!-- //내용보기 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="button" value="목록" class="blue" onclick="jsList();" /></li>
            <li><input type="button" value="등록" class="w_blue" onclick="jsInsertForm();" /></li>
            <li><input type="button" value="수정" class="w_blue" onclick="jsUpdateForm();" /></li>
            <li><input type="button" value="답글" class="w_blue" onclick="jsReplyInsertForm();" /></li>
            <li><input type="button" value="삭제" class="w_blue" onclick="jsDelete();"/></li>
        </ul>
    </div>
    <!-- //버튼 -->

    <c:forEach items="${dataList}" var="dataVo">
        <!-- 내용보기 -->
        <table class="boardWrite" cellspacing="0" border="0" summary="게시판 답변내용 작성페이지입니다.">
            <caption class="hidden">게시판 답변글입력 페이지</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>답변자</th>
                    <td>${dataVo.replyNm}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>${dataVo.replyContents}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td class="file">
                        <ul>
                            <c:choose>
                                <c:when test="${fn:length(dataVo.fileList) > 0}">
                                    <c:forEach items="${dataVo.fileList}" var="fileVo">
                                        <li>
                                            <img src="/resources/openworks/theme/default/images/icon/icon_file_jpg.gif" class="vm" alt="파일 첨부" />
                                            <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a>
                                            <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
                                            <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${fileVo.fileSeq}', '${fileVo.fileId}');">이력보기</button>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li>첨부파일이 없습니다.</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
        <!-- //내용보기 -->

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="button" value="수정" class="w_blue" onclick="jsReplyUpdateForm(${dataVo.replySeq});" /></li>
                <li><input type="button" value="삭제" class="w_blue" onclick="jsReplyDelete(${dataVo.replySeq});"/></li>
                <li><input type="button" value="목록" class="blue" onclick="jsList();" /></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </c:forEach>

</body>
</html>