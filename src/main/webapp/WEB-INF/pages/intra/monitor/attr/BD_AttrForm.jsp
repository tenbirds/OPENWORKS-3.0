<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>환경설정 관리</title>

    <op:jsTag type="spi" items="validate"/>
    <op:jsTag type="openworks" items="form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {

            $("#dataForm").validate({
                rules: {
                    errorAttr:{required : true}
                    <c:if test="${empty dataVo}">
                    , errorAttrNm:{required : true}
                    </c:if>
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });

        });

        //]]>
    </script>
</head>
<body>
    <c:set var="action" value="ND_InsertAttr.do" />
    <c:if test="${not empty dataVo}">
        <c:set var="action" value="ND_UpdateAttr.do" />
    </c:if>

    <form id="dataForm" name="dataForm" method="post" action="${action}">

        <input type="hidden" id="seqNo" name="seqNo" value="${dataVo.seqNo}" />

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />

        <table class="boardWrite" summary="오류관리 속성 등록/수정" >
            <caption class="title">환경설정 등록/수정</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>

            <tr>
                <th>속성</th>
                <c:choose>
                    <c:when test="${not empty dataVo}">
                        <td>
                            ${dataVo.errorAttrNm}
                            <input type="hidden" id="errorAttr" name="errorAttr" value="${dataVo.errorAttr}" />
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <select id="errorAttr" name="errorAttr">
                                <option value="">-- 속성선택 --</option>
                                <c:forEach items="${dataList}" var="attrVo">
                                    <option value="${attrVo.errorAttr}">${attrVo.errorAttrType}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </c:otherwise>
                </c:choose>
            </tr>
            <tr>
                <th>속성명</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty dataVo}">
                            ${dataVo.errorAttrNm}
                        </c:when>
                        <c:otherwise>
                            <input type="text" id="errorAttrNm" name=errorAttrNm value="" class="w99_p" />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>속성설명</th>
                <td>
                    <textarea id="errorAttrDesc" name="errorAttrDesc" rows="5" cols="30" class="w99_p">${dataVo.errorAttrDesc}</textarea>
                </td>
            </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="tx_r mar_t20">
            <button type="submit"><img src="/resources/monitor/images/btn/btn_save.gif" alt="저장"/></button>
            <button type="button" onclick="jsList('BD_AttrPageList.do');"><img src="/resources/monitor/images/btn/btn_list.gif" alt="목록"/></button>
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>