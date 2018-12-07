<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한 변경 관리</title>
    <op:jsTag type="openworks" items="ui" />
    <script type="text/javascript">
    var jsSearchAction2 = function(){
         document.dataForm.action = "BD_index.do";
         document.dataForm.elements["q_currPage"].value = "1";
         document.dataForm.submit();
    };

    var jsView = function(seq , mgrId){
        document.dataForm.action = "BD_view.do";
        document.dataForm.elements["seqNo"].value = seq;
        document.dataForm.elements["mgrId"].value = mgrId;
        document.dataForm.submit();
    };

    var jsViewPop = function (el, vl,cl) {
        $(el).colorbox({
            title : "권한삭제요청 처리결과 - 승인",
            href  : "PD_resultPop.do?mgrId="+vl+"&seqNo="+cl ,
            width : "850",
            height: "550",
            iframe: true
        });
    };

    var jsViewPop2 = function (el, vl, cl) {
        $(el).colorbox({
            title : "권한삭제요청 처리결과 - 반려",
            href  : "PD_returnPop.do?mgrId="+vl+"&seqNo="+cl ,
            width : "850",
            height: "550",
            iframe: true
        });
    };

    var jsMovePage = function(cpage) {
        document.dataForm.elements["q_currPage"].value = cpage;
        document.dataForm.action= "BD_index.do";
        document.dataForm.submit();
    };
    </script>
</head>

<body>
<!-- 컨텐츠영역 -->
    <div class="buser">
    <div>
        <ul class="tab">
            <li><a href="<c:url value="/intra/authMgrAddReq/BD_index.do" />">권한추가(${dataVo.listCountA}건)</a></li>
            <li><a href="<c:url value="BD_index.do" />" class="on">권한삭제(${baseVo.listCountD}건)</a></li>
        </ul>
    </div>

    <form name="dataForm" method="post">
        <input type="hidden" name="seqNo" value="" />
        <input type="hidden" name="mgrId" value="" />
        <!-- 검색 -->
        <div class="search">
            <fieldset>
                <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
                <div>
                    <select name="q_searchKey2" id="q_searchKey2" class="over" onchange="jsSearchAction2();">
                        <option value="">-- 상태 --</option>
                        <option value="A" <c:if test="${param.q_searchKey2 eq 'A'}">selected="selected"</c:if>>신청</option>
                        <option value="P" <c:if test="${param.q_searchKey2 eq 'P'}">selected="selected"</c:if>>승인</option>
                        <option value="C" <c:if test="${param.q_searchKey2 eq 'C'}">selected="selected"</c:if>>반려</option>
                    </select>
                    <select name="q_searchKey" id="q_searchKey" class="over">
                        <option value="">-- 전체 --</option>
                        <option value="1002" <c:if test="${param.q_searchKey eq '1002'}">selected="selected"</c:if>>작성자</option>
                        <option value="1003" <c:if test="${param.q_searchKey eq '1003'}">selected="selected"</c:if>>ID</option>
                    </select>
                    <input class="w215" type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" />
                    <button class="gray mar_l5 mar_b5" type="button" onclick="jsSearchAction();">검색</button>
                </div>
            </fieldset>
        </div>
        <op:pagerParam title="권한 삭제요청 목록" />
    </form>
        <!-- //검색 -->
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="4%"/>
                <col width=""/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>부서명</th>
                    <th>신청일</th>
                    <th>처리일</th>
                    <th>상태</th>
                    <th class="lr_none">처리결과</th>
                </tr>
            </thead>
            <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="_bean" varStatus="status">
            <tr>
                <td>${_bean.seqNo}</td>
                <td class="tx_l"><a href="#" title="권한요청관리 상세조회" onclick="jsView('${_bean.seqNo}','${_bean.mgrId }' ); return false;">
                ${_bean.mgrNm }의 권한
                    <c:if test="${_bean.reqTypeCd eq 'A'}">추가</c:if>
                    <c:if test="${_bean.reqTypeCd eq 'C'}">변경</c:if>
                    <c:if test="${_bean.reqTypeCd eq 'D'}">삭제</c:if>
                    <c:if test="${_bean.reqTypeCd eq 'T'}">이양</c:if>
                요청 합니다.</a></td>
                <td>${_bean.deptNm }</td>
                <td>${_bean.reqModiDtm }</td>
                <td>${_bean.prcModiDtm }</td>
                    <c:if test="${empty _bean.resTypeCd || _bean.resTypeCd eq'R'}">
                        <td>신청</td>
                    </c:if>
                    <c:if test="${_bean.resTypeCd eq 'P'}">
                        <td class="tx_red">승인</td>
                    </c:if>
                    <c:if test="${_bean.resTypeCd eq 'C'}">
                        <td class="tx_blue_n">반려</td>
                    </c:if>
                <td class="lr_none">
                  <c:if test="${_bean.resTypeCd eq 'P'}">
                      <a href="#" title="권한요청관리 상세조회" onclick="jsViewPop(this,'${_bean.mgrId}','${_bean.seqNo }');"><button type="button" class="s_blue">보기</button></a>
                  </c:if>
                  <c:if test="${_bean.resTypeCd eq 'C'}">
                      <a href="#" title="권한요청관리 상세조회" onclick="jsViewPop2(this,'${_bean.mgrId}','${_bean.seqNo }');"><button type="button" class="s_blue">보기</button></a>
                  </c:if>
                </td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager}" colspan="9" />
            </tbody>
        </table>
        <!-- //리스트 -->
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
        <!-- //권한삭제요청관리 -->
    </div>
<!-- //컨텐츠영역 -->
</body>
</html>