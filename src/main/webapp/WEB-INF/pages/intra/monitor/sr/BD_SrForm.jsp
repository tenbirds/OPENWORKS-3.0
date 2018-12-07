<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오류 관리</title>

    <op:jsTag type="spi" items="colorbox, ui, validate, multifile"/>
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            jsSelected("domainCd", "${dataVo.domainCd}");
            jsSelected("transactorId", "${dataVo.transactorId}");
            jsSelected("srLevel", "${dataVo.srLevel}");

            $("#srFile").MultiFile({ max: 3 });

            $("#updateForm").validate({
                rules: {
                    <c:choose>
                        <c:when test="${not empty dataVo.workProcStatus}">
                            seqNo: {required : true},
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    domainCd: {required : true},
                    srTitle: {required : true},
                    srCont: {required : true},
                    srLevel: {required : true},
                    transactorId: {required : true}
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });

        });

        /*
         * select 태그로 담당자 선택시 설정
         */
        var jsSelectTransator = function() {
            var transactorInfo = $("#transactorId").val();

            if(transactorInfo == "N") {
                jsWarningBox("휴가/파견중인 담당자는 선택할 수 없습니다.");
                $("#transactorId").val("");
            };
        };

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="post" action="BD_SrList.do">
        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />
    </form>

    <c:set var="action" value="ND_InsertSr.do" />
    <c:set var="title" value="SR 등록" />

    <c:if test="${not empty dataVo}">
        <c:set var="action" value="ND_UpdateSr.do" />
        <c:set var="title" value="SR 수정" />
    </c:if>

    <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data" action="${action}">

        <input type="hidden" id="seqNo" name="seqNo" value="${dataVo.seqNo}" />
        <input type="hidden" id="workProcStatus" name="workProcStatus" value="<c:out value="${dataVo.workProcStatus}" default="1010" />" />

        <op:pagerParam view="view" />

        <h4>${title}</h4>

        <fieldset>
        <legend>글입력</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="${title}">
            <caption class="hidden">${title}</caption>
            <colgroup>
                <col width="15%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="domainCd">사이트명</label></th>
                    <td>
                        <select name="domainCd" id="domainCd" class="over">
                            <option value="">-- 사이트선택 --</option>
                            <c:forEach items="${domainList}" var="domainCd">
                                <option value="${domainCd.seqNo}">${domainCd.errorAttrNm}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="srTitle">제목</label></th>
                    <td><input type="text" id="srTitle" name="srTitle" class="w85_p" maxlength="100" title="제목을 입력해주세요" value="${dataVo.srTitle}" /></td>
                </tr>
                <tr>
                    <th><label for="srCont">요청내용</label></th>
                    <td><textarea id="srCont" name="srCont"  rows="15" class="w99_p" title="내용입력">${dataVo.srCont}</textarea></td>
                </tr>
                <tr>
                    <th><label for="srFileSeq">첨부파일</label></th>
                    <td>

                        <input type="hidden" name="srFileSeq" id="srFileSeq" value="${dataVo.srFileSeq}" />
                        <input type="file" id="srFile" name="srFile"  value="찾아보기" class="w470 multi" />

                        <c:if test="${fn:length(dataVo.srFileList) > 0}">
                            <p class="mar_t5 tx_blue_s">
                                - 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">체크박스를 선택</span>하세요.
                            </p>
                            <ul>
                                <c:forEach items="${dataVo.srFileList}" var="srFileVo">
                                    <li class="mar_b5">
                                        <input type="checkbox" name="srFileIds" value="${srFileVo.fileId }" />
                                        <a href="/component/file/ND_fileDownload.do?id=${srFileVo.fileId}" title="${srFileVo.fileDesc}">${srFileVo.localNm}</a>
                                        <span class="tx_gray">(download ${srFileVo.downCnt}, ${srFileVo.fileSize}, ${srFileVo.fileType})</span>
                                        <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${srFileVo.fileSeq}', '${srFileVo.fileId}');">
                                            <img src="/resources/monitor/images/btn/btn_history.gif" alt="이력보기" class="vm" />
                                        </button>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>

                    </td>
                </tr>
                <tr>
                    <th><label for="srLevel">요청등급</label></th>
                    <td>
                        <select id="srLevel" name="srLevel" title="요청등급을 선택해주세요">
                            <option value="">-- 요청등급 선택 --</option>
                            <option value="1010">긴급</option>
                            <option value="1020">보통</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="transactorId">담당자</label></th>
                    <td>
                        <select id="transactorId" name="transactorId" onchange="jsSelectTransator();" class="over">
                            <option value="">-- 담당자선택 --</option>
                            <c:forEach items="${dataList}" var="transactorVo">
                                <c:choose>
                                    <c:when test="${transactorVo.statusCd eq '1010'}">
                                        <option value="${transactorVo.transactorId}">${transactorVo.label}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="N" style="color:red">
                                            ${transactorVo.label}
                                            <c:choose>
                                                <c:when test="${transactorVo.statusCd eq '1020'}">(휴가중)</c:when>
                                                <c:when test="${transactorVo.statusCd eq '1030'}">(파견중)</c:when>
                                            </c:choose>
                                        </option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>

        <!-- 버튼 -->
        <div class="tx_r mar_t20">
            <c:if test="${empty dataVo or dataVo.workProcStatus eq '1010'}">
                <input type="image" alt="저장" src="/resources/monitor/images/btn/btn_save.gif" />
            </c:if>
            <input type="image" alt="목록" src="/resources/monitor/images/btn/btn_list.gif" onclick="jsList();return false;" />
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>