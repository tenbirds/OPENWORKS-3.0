<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>게시물 목록</title>

    <op:jsTag type="spi" items="highlight" />
    <op:jsTag type="openworks" items="ui, form" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/samples/crud/samples.crud.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // select 박스 선택 값 설정
            jsSelected("q_searchKey", "${param.q_searchKey}");
        });

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_crud.list.do">

        <input type="hidden" name="q_seq" id="q_seq" value="" />

        <div class="search">
            <fieldset>
                <legend>게시물 검색</legend>
                <label class="skip" for="boardsearch">게시물 검색항목</label>
                <select name="q_searchKey" id="q_searchKey" class="over">
                    <option value="">-- 전체 --</option>
                    <option value="1001">제목</option>
                    <option value="1002">내용</option>
                    <option value="1003">작성자</option>
                </select>
                <label class="skip" for="searchText">검색단어 입력</label>
                <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
                <button class="gray mar_l5 mar_b5">검색</button>
                <button type="button" class="gray mar_l5 mar_b5" onclick="jsSearchReset();">초기화</button>
            </fieldset>
        </div>


        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="셈플게시물 목록" />

    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="기본게시판 목록으로 순번,분류,제목,작성자,작성일,조회 정보를 제공합니다.">
        <caption class="hidden">기본게시판 목록</caption>
        <colgroup>
            <col width="6%" />
            <col width="6%" />
            <col width="8%" />
            <col width="" />
            <col width="10%" />
            <col width="12%" />
            <col width="8%" />
            <col width="8%" />
        </colgroup>
        <thead>
            <tr>
                <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                <th><span class="sort" id="A.SEQ">순번</span></th>
                <th><span class="sort" id="A.CTG_CD">분류</span></th>
                <th><span class="sort" id="A.TITLE">제목</span></th>
                <th><span class="sort" id="A.REG_NM">작성자</span></th>
                <th><span class="sort" id="A.REG_DT">작성일</span></th>
                <th><span class="sort" id="A.READ_CNT">조회</span></th>
                <th class="lr_none"><span class="sort" id="A.REPLY_YN">답변</span></th>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                <tr>
                    <!--class="bg_yellow"-->
                    <td><input type="checkbox" value="${baseVo.seq}" name="seqs" /></td>
                    <td>${index-status.index}</td>
                    <td>${baseVo.ctgCd}</td>
                    <td class="tx_l">
                        <a onclick="jsView(${baseVo.seq});return false;" href="BD_crud.view.do?q_seq=${baseVo.seq}">${baseVo.title}</a>

                        <c:if test="${baseVo.fileCnt > 0}" >
                            <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
                        </c:if>
                        <c:if test="${baseVo.commCnt > 0}" >
                            <a href="#" class="t_reply" title="댓글이 ${baseVo.commCnt}개 존재합니다.">(${baseVo.commCnt})</a>
                        </c:if>
                    </td>
                    <td>${baseVo.regNm}</td>
                    <td>${baseVo.regDt}</td>
                    <td><span class="tx_blue">${baseVo.readCnt}</span></td>
                    <td class="lr_none">
                        <span class="tx_blue">
                            <c:choose>
                                <c:when test="${baseVo.replyYn eq 'Y'}">
                                    완료
                                </c:when>
                                <c:otherwise>
                                    대기
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="8" />


        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <!-- 버튼 -->
    <div>
        <div class="float_l">
            <button type="button" class="w_blue" onclick="jsDeleteList();">선택삭제</button>
        </div>
        <div class="float_r">
            <button type="button" class="w_blue" onclick="jsInsertForm();">신규등록</button>
        </div>
    </div>
    <!-- //버튼 -->

</body>
</html>