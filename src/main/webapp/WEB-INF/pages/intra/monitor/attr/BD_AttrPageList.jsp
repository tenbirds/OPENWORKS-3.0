<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>메시지 관리</title>

    <op:jsTag type="spi" items="ui" />
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

            jsSelected("q_errorAttr", "${param.q_errorAttr}");
        });

        /**
         * 메시지 상세/수정
         */
        var jsAttrForm = function(seqNo) {

            jsView("BD_AttrForm.do?seqNo="+seqNo);
        };

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_AttrPageList.do">

        <div class="search">
            <fieldset>
                <legend>오류관리 속성 검색</legend>

                <label class="skip" for="q_errorAttr">오류관리 속성선택</label>
                <select name="q_errorAttr" id="q_errorAttr" class="over">
                    <option value="">-- 속성선택 --</option>
                    <c:forEach items="${dataList}" var="attrVo">
                        <option value="${attrVo.errorAttr}">${attrVo.errorAttrType}</option>
                    </c:forEach>
                </select>

                <label class="skip" for="q_errorAttrNm">속성명검색</label>
                속성명 : <input type="text" name="q_errorAttrNm" id="q_errorAttrNm" value="${param.q_errorAttrNm}" class="w120" title="속성명을 입력하세요." />

                <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
            </fieldset>
        </div>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="오류관리 속성 목록" />

    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="오류관리 속성 목록">
        <caption class="hidden">오류관리 속성 목록</caption>
        <colgroup>
            <col style="width:60px" />
            <col style="width:200px" />
            <col style="" />
            <col style="width:120px" />
            <col style="width:120px" />
        </colgroup>
        <thead>
            <tr>
                <th><span>번호</span></th>
                <th><span>속성유형</span></th>
                <th><span>속성명</span></th>
                <th><span>수정자</span></th>
                <th class="lr_none"><span>수정일</span></th>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}" />

            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td class="">${dataVo.errorAttrType}</td>
                    <td class="tx_l"><a href="#" onclick="jsAttrForm('${dataVo.seqNo}');">${dataVo.errorAttrNm}</a></td>
                    <td>${dataVo.modNm}</td>
                    <td class="lr_none">${dataVo.modDt}</td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="54" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t20">
        <button type="button" onclick="jsAttrForm('');"><img src="/resources/monitor/images/btn/btn_new_regist.gif" alt="신규등록"/></button>
    </div>
    <!-- //버튼 -->

</body>
</html>