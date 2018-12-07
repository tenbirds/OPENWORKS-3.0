<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<title>권한 삭제 요청(신청자)</title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
    var jsDelView = function(){
        self.location.href = "BD_delView.do";
    };

    var jsViewPop = function (el, cl){
        $(el).colorbox({
            title : "권한삭제요청 처리결과 - 승인",
            href  : "PD_resultPop.do?seqNo=" + cl,
            width : "850",
            height: "550",
            iframe: true
        });
    };

    var jsViewPop2 = function (el, cl){
        $(el).colorbox({
            title : "권한삭제요청 처리결과 - 반려",
            href  : "PD_returnPop.do?seqNo=" + cl,
            width : "850",
            height: "550",
            iframe: true
        });
    };

    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action= "BD_index.do";
        document.dataForm.submit();
    };
</script>
</head>

<body>

<div>
    <ul class="tab">
        <li><a href="<c:url value="/intra/authMgrAddAp/BD_index.do" />">권한 추가 요청(${dataVo.listCountA}건)</a></li>
        <li><a href="<c:url value="BD_index.do" />" class="on">권한 삭제 요청(${baseVo.listCountD}건)</a></li>
    </ul>
</div>

<div class="buser">

	<form name="dataForm" method="post">
        <input type="hidden" name="seqNo" value="" />
        <input type="hidden" name="mgrId" value="" />
    	<op:pagerParam title="권한 삭제 요청 목록(신청자)" />
    </form>

    <!-- //검색 -->
    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="4%"/>
            <col width=""/>
            <col width="12%"/>
            <col width="12%"/>
            <col width="12%"/>
            <col width="12%"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>요청일</th>
                <th>처리일</th>
                <th>상태</th>
                <th class="lr_none">처리결과</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td class="tx_l">${_bean.mgrNm }의 권한을
                        <c:if test="${_bean.reqTypeCd eq 'A'}">추가</c:if>
                        <c:if test="${_bean.reqTypeCd eq 'C'}">변경</c:if>
                        <c:if test="${_bean.reqTypeCd eq 'D'}">삭제</c:if>
                        <c:if test="${_bean.reqTypeCd eq 'T'}">이양</c:if>
                    요청 합니다.</td>
                    <td>${_bean.reqModiDtm }</td>
                    <td>${_bean.prcModiDtm }</td>
                    <c:if test="${empty _bean.resTypeCd || _bean.resTypeCd eq'R'}">
                        <td>
                        신청
                        </td>
                    </c:if>
                    <c:if test="${_bean.resTypeCd eq 'P'}">
                        <td class="tx_red">
                            승인
                        </td>
                    </c:if>
                    <c:if test="${_bean.resTypeCd eq 'C'}">
                        <td class="tx_blue_n">
                        반려
                        </td>
                    </c:if>
                    <td class="lr_none">
                        <c:if test="${_bean.resTypeCd eq 'P'}">
                            <button type="button" class="s_blue" onclick="jsViewPop(this,'${_bean.seqNo }');">보기</button>
                        </c:if>
                        <c:if test="${_bean.resTypeCd eq 'C'}">
                            <button type="button" class="s_blue" onclick="jsViewPop2(this,'${_bean.seqNo }');">보기</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager}" colspan="6" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
    <!-- 버튼 -->
    <div class="tx_r"><a href="#" class="btn" onclick="jsDelView();"><button class="blue">권한 삭제 신청</button></a></div>
    <!-- //권한삭제요청관리 -->
</div>
<!-- //컨텐츠영역 -->
</body>
</html>