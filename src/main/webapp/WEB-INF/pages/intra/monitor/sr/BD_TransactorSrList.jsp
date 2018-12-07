<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>운영 관리</title>

    <op:jsTag type="spi" items="highlight, ui, validate, multifile" />
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
            //검색 날짜 입력
            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });

            $('#q_startDate').datepicker();
            $('#q_endDate').datepicker();

            $(".dp").datepicker();
        });

        var jsSimpleSubmit = function(seqNo) {
            $("#updateForm"+seqNo).validate({
                rules: {
                    workProcStatus: {required : true},
                    workStDt: {required : true},
                    workEdDt: {required : true},
                    workLevel: {required : true},
                    workCont: {requirefrom:["workProcStatus","1020", "처리중"]},
                    workProcCont: {requirefrom:["workProcStatus","1030", "완료"]}
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });
            $("#updateForm"+seqNo).submit();
        };

        <c:if test="${not empty SUB_SUPER}">
            var jsSrView = function(seqNo) {
                if(!seqNo) {
                    seqNo = "";
                }
                jsView("BD_SrForm.do?q_seqNo="+seqNo);
            };
        </c:if>

        var jsSimpleView = function(seqNo) {
            $("#tr"+seqNo).show();
        };

        var jsSimpleClose = function(seqNo) {
            $("#tr"+seqNo).hide();
        };

        //]]>
    </script>
</head>
<body>

    <ul class="tab">
        <li><a href="#" onclick="jsSrTabList('BD_TransactorSrList.do', 1010);return false;" <c:if test="${empty param.q_workProcStatus or param.q_workProcStatus eq '1010'}" >class="on"</c:if>>배정 (${baseVo.stat01})</a></li>
        <li><a href="#" onclick="jsSrTabList('BD_TransactorSrList.do', 1020);return false;" <c:if test="${param.q_workProcStatus eq '1020'}" >class="on"</c:if>>처리중 (${baseVo.stat02})</a></li>
        <li><a href="#" onclick="jsSrTabList('BD_TransactorSrList.do', 1030);return false;" <c:if test="${param.q_workProcStatus eq '1030'}" >class="on"</c:if>>완료 (${baseVo.stat03})</a></li>
        <li><a href="#" onclick="jsSrTabList('BD_TransactorSrList.do', 1000);return false;" <c:if test="${param.q_workProcStatus eq '1000'}" >class="on"</c:if>>전체 (${baseVo.stat04})</a></li>
    </ul>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_TransactorSrList.do">

        <input type="hidden" name="q_workProcStatus" id="q_workProcStatus" value="${searchMap.q_workProcStatus}" />

        <div class="search">
            <fieldset>
                <legend>SR 목록 검색</legend>

                <div>
                    <label class="skip" for="q_errorResCd">사이트선택</label>
                    <select name="q_domainCd" id="q_domainCd" class="over">
                        <option value="">-- 사이트선택 --</option>
                        <c:forEach items="${domainList}" var="domainCd">
                            <option value="${domainCd.seqNo}">${domainCd.errorAttrNm}</option>
                        </c:forEach>
                    </select>

                    조회기간 : 
                    <label class="skip" for="q_startDate">SR 등록일</label>
                    <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                    <label class="skip" for="q_endDate">SR 등록일</label> 
                    <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />&nbsp;

                    <input type="image" alt="날짜선택" src="/resources/monitor/images/btn/btn_date.gif" onclick="jsToggleSearchOption(this);return false;" />
                    <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
                </div>

                <!-- 검색 옵션 시작 -->
                <div id="SearchOptionDiv" class="mar_t5">
                    <button type="button" class="gray" onclick="jsSetDay(0, 1, 0);">오늘</button>
                    <button type="button" class="gray" onclick="jsSetDay(0, 2, 0);">1일</button>
                    <button type="button" class="gray" onclick="jsSetDay(0, 7, 0);">7일</button>
                    <button type="button" class="gray" onclick="jsSetDay(0, 10, 0);">10일</button>
                    <button type="button" class="gray" onclick="jsSetDay(0, 15, 0);">15일</button>
                    <button type="button" class="gray" onclick="jsSetDay(1, 1, 0);">1개월</button>
                    <button type="button" class="gray" onclick="jsSetDay(3, 1, 0);">3개월</button>
                    <button type="button" class="gray" onclick="jsSetDay(6, 1, 0);">6개월</button>
                    <button type="button" class="gray" onclick="jsSetDay(-1, 1, 0);">전체</button>
                </div>
                <!-- 검색 옵션 끝 -->

            </fieldset>
        </div>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <c:choose>
            <c:when test="${empty param.q_workProcStatus or param.q_workProcStatus eq '1010'}"><c:set var="workStatus" value="배정"/></c:when>
            <c:when test="${param.q_workProcStatus eq '1020'}"><c:set var="workStatus" value="처리중"/></c:when>
            <c:when test="${param.q_workProcStatus eq '1030'}"><c:set var="workStatus" value="완료"/></c:when>
            <c:when test="${param.q_workProcStatus eq '1000'}"><c:set var="workStatus" value="전체"/></c:when>
        </c:choose>
        <op:pagerParam title="${workStatus} 목록" />

    </form>
    <!-- //검색 -->

    <c:choose>
        <c:when test="${empty param.q_workProcStatus or param.q_workProcStatus eq '1010'}"><c:set var="cols" value="7"/></c:when>
        <c:when test="${param.q_workProcStatus eq '1020'}"><c:set var="cols" value="10"/></c:when>
        <c:when test="${param.q_workProcStatus eq '1030'}"><c:set var="cols" value="11"/></c:when>
        <c:otherwise><c:set var="cols" value="11"/></c:otherwise>
    </c:choose>

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="SR ${workStatus} 목록">
        <caption class="hidden">SR ${workStatus} 목록</caption>
        <colgroup>
            <col width="5%" />
            <col width="12%" />
            <col width="" />
            <col width="6%" />
            <col width="6%" />
            <col width="8%" />

            <c:if test="${not empty param.q_workProcStatus and param.q_workProcStatus ne '1010'}">
                <col width="6%" />
                <col width="6%" />
                <col width="8%" />
            </c:if>
            <c:if test="${param.q_workProcStatus eq '1030' or param.q_workProcStatus eq '1000'}">
                <col width="10%" />
            </c:if>

            <col width="10%" />
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>사이트명</th>
                <th>제목</th>
                <th>요청자</th>
                <th>요청등급</th>
                <th>요청일</th>

                <c:if test="${not empty param.q_workProcStatus and param.q_workProcStatus ne '1010'}">
                    <th>난이도</th>
                    <th>작업내용</th>
                    <th>
                        시작예정일<br />완료예정일
                    </th>
                </c:if>
                <c:if test="${param.q_workProcStatus eq '1030' or param.q_workProcStatus eq '1000'}">
                    <th>완료일</th>
                </c:if>

                <th class="lr_none">내용보기</th>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody>
            <c:set var="index" value="${pager.indexNo}" />

            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">

                <tr>
                    <td id="td${dataVo.seqNo}">${index-status.index}</td>
                    <td>${dataVo.domainNm}</td>
                    <td>${dataVo.srTitle}</td>
                    <td>${dataVo.srNm}</td>
                    <td>
                        <c:choose>
                            <c:when test="${dataVo.srLevel eq '1010'}">긴급</c:when>
                            <c:when test="${dataVo.srLevel eq '1020'}">보통</c:when>
                            <c:otherwise>없음</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${dataVo.srDt}</td>

                    <c:if test="${not empty param.q_workProcStatus and param.q_workProcStatus ne '1010'}">
                        <td>
                            <c:choose>
                                <c:when test="${dataVo.workLevel eq '1010'}">상</c:when>
                                <c:when test="${dataVo.workLevel eq '1020'}">중</c:when>
                                <c:when test="${dataVo.workLevel eq '1030'}">하</c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty dataVo.workCont}">유</c:when>
                                <c:when test="${empty dataVo.workCont}">무</c:when>
                            </c:choose>
                        </td>
                        <td>
                            ${dataVo.workStDt}<br />${dataVo.workEdDt}
                        </td>
                    </c:if>
                    <c:if test="${param.q_workProcStatus eq '1030' or param.q_workProcStatus eq '1000'}">
                        <td>
                            ${dataVo.workProcDt}
                            <c:if test="${not empty dataVo.workProcDt}">
                                (<span style="color:red;font-weight: bold;">${dataVo.srProcTerm}</span>일)
                            </c:if>
                        </td>
                    </c:if>

                    <td class="lr_none">
                        <button type="button" onclick="jsSimpleView('${dataVo.seqNo}');"><img alt="간략보기" src="/resources/monitor/images/btn/btn_s_view.gif" /></button>
                    </td>
                </tr>

                <c:choose>

                    <c:when test="${dataVo.workProcStatus eq '1010' or dataVo.workProcStatus eq '1020'}">
                        <tr class="bg_yellow" id="tr${dataVo.seqNo}" style="display:none;">
                            <td colspan="${cols}" class="pad_a8 lr_none">
                                <form name="updateForm${dataVo.seqNo}" id="updateForm${dataVo.seqNo}" method="post" enctype="multipart/form-data" action="/intra/monitor/sr/ND_TransactorUpdateError.do">

                                    <input type="hidden" id="seqNo" name="seqNo" value="${dataVo.seqNo}" />

                                    <fieldset>
                                    <legend>수정하기</legend>
                                    <table class="sim_view" cellspacing="0" border="0" summary="간략보기 내용입니다.">
                                        <caption class="hidden"> 간략보기설명</caption>
                                        <colgroup>
                                            <col width="20%" />
                                            <col width="" />
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th>요청내용</th>
                                                <td><op:nrToBr content="${dataVo.srCont}" /></td>
                                            </tr>
                                            <tr>
                                                <th>(요청)첨부파일</th>
                                                <td>
                                                    <ul>
                                                    <c:forEach items="${dataVo.srFileList}" var="srFileVo">
                                                        <li>
                                                            <a href="/component/file/ND_fileDownload.do?id=${srFileVo.fileId}" title="${srFileVo.fileDesc}">${srFileVo.localNm}</a>
                                                            <span class="tx_gray">(download ${srFileVo.downCnt}, ${srFileVo.fileSize}, ${srFileVo.fileType})</span>
                                                            <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${srFileVo.fileSeq}', '${srFileVo.fileId}');">
                                                                <img src="/resources/monitor/images/btn/btn_history.gif" alt="이력보기" class="vm" />
                                                            </button>
                                                        </li>
                                                    </c:forEach>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>처리상태</th>
                                                <td>
                                                    <input type="radio" name="workProcStatus" id="workProcStatusP" value="1020" <c:if test="${dataVo.workProcStatus eq '1020'}">checked="checked"</c:if> title="처리상태를 선택하세요." />
                                                    <label for="public">처리중</label>
                                                    <input type="radio" name="workProcStatus" id="workProcStatusC" value="1030" <c:if test="${dataVo.workProcStatus eq '1030'}">checked="checked"</c:if> />
                                                    <label for="public1">완료</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>처리시작/완료예정일</th>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${dataVo.workProcStatus eq '1010'}">
                                                            <input class="w80 dp" type="text" value="${dataVo.workStDt}" id="workStDt" name="workStDt" title="작업시작예정일을 입력하세요." />
                                                            <input class="w80 dp" type="text" value="${dataVo.workEdDt}" id="workEdDt" name="workEdDt" title="작업완료예정일을 입력하세요." />
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${dataVo.workStDt} ~ ${dataVo.workEdDt}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>난이도</th>
                                                <td><select id="workLevel" name="workLevel" title="난이도를 선택하세요.">
                                                    <option value="">-- 난이도 선택 --</option>
                                                    <option value="1010" <c:if test="${dataVo.workLevel eq '1010'}">selected="selected"</c:if>>상</option>
                                                    <option value="1020" <c:if test="${dataVo.workLevel eq '1020'}">selected="selected"</c:if>>중</option>
                                                    <option value="1030" <c:if test="${dataVo.workLevel eq '1030'}">selected="selected"</c:if>>하</option>
                                                </select></td>
                                            </tr>
                                            <tr>
                                                <th>작업내용</th>
                                                <td><textarea id="workCont" name="workCont"  rows="6" class="w99_p" title="작업내용을 입력하세요.">${dataVo.workCont}</textarea></td>
                                            </tr>
                                            <tr>
                                                <th>작업완료내용</th>
                                                <td><textarea id="workProcCont" name="workProcCont"  rows="6" class="w99_p" title="작업완료내용을 입력하세요.">${dataVo.workProcCont}</textarea></td>
                                            </tr>
                                            <tr>
                                                <th>작업완료URL</th>
                                                <td><input class="w60_p" type="text" id="workUrl" name="workUrl" value="${dataVo.workUrl}" title="작업완료URL을 입력하세요." /></td>
                                            </tr>
                                            <tr>
                                                <th>(완료)첨부파일</th>
                                                <td>
                                                    <input type="hidden" name="workFileSeq" id="workFileSeq" value="${dataVo.workFileSeq}" />
                                                    <input type="file" id="workFile" class="w470 multi" name="workFile"  value="찾아보기" />

                                                    <c:if test="${fn:length(dataVo.workFileList) > 0}">
                                                        <p class="mar_t5 tx_blue_s">
                                                            - 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">체크박스를 선택</span>하세요.
                                                        </p>
                                                        <ul>
                                                        <c:forEach items="${dataVo.workFileList}" var="workFileVo">
                                                            <li class="mar_b5">
                                                                <input type="checkbox" name="workFileIds" value="${workFileVo.fileId }" />
                                                                <a href="/component/file/ND_fileDownload.do?id=${workFileVo.fileId}" title="${workFileVo.fileDesc}">${workFileVo.localNm}</a>
                                                                <span class="tx_gray">(download ${workFileVo.downCnt}, ${workFileVo.fileSize}, ${workFileVo.fileType})</span>
                                                                <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${workFileVo.fileSeq}', '${workFileVo.fileId}');">
                                                                    <img src="/resources/monitor/images/btn/btn_history.gif" alt="이력보기" class="vm" />
                                                                </button>
                                                            </li>
                                                        </c:forEach>
                                                        </ul>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    </fieldset>
                                    <div class="tx_r mar_t10">
                                        <button type="button" onclick="jsSimpleSubmit('${dataVo.seqNo}');"><img alt="수정" src="/resources/monitor/images/btn/btn_modify_01.gif" /></button>
                                        <button type="button" onclick="jsSimpleClose('${dataVo.seqNo}');"><img alt="닫기" src="/resources/monitor/images/btn/btn_close.gif" /></button>
                                    </div>
                                </form>
                            </td>
                        </tr>
                    </c:when>

                    <c:when test="${dataVo.workProcStatus eq '1030'}">

                        <tr class="bg_yellow" id="tr${dataVo.seqNo}" style="display:none;">
                            <td colspan="${cols}" class="pad_a8 lr_none">
                                <table class="sim_view" cellspacing="0" border="0" summary="간략보기 내용입니다.">
                                    <caption class="hidden"> 간략보기설명</caption>
                                    <colgroup>
                                        <col width="20%" />
                                        <col width="" />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>요청내용</th>
                                            <td><op:nrToBr content="${dataVo.srCont}" /></td>
                                        </tr>
                                        <tr>
                                            <th>(요청)첨부파일</th>
                                            <td>
                                                <ul>
                                                <c:forEach items="${dataVo.srFileList}" var="srFileVo">
                                                    <li>
                                                        <a href="/component/file/ND_fileDownload.do?id=${srFileVo.fileId}" title="${srFileVo.fileDesc}">${srFileVo.localNm}</a>

                                                        <span class="tx_gray">(download ${srFileVo.downCnt}, ${srFileVo.fileSize}, ${srFileVo.fileType})</span>
                                                        <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${srFileVo.fileSeq}', '${srFileVo.fileId}');">
                                                            <img src="/resources/monitor/images/btn/btn_history.gif" alt="이력보기" class="vm" />
                                                        </button>
                                                    </li>
                                                </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>처리상태</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${dataVo.workProcStatus eq '1010'}">처리중</c:when>
                                                    <c:when test="${dataVo.workProcStatus eq '1020'}">완료</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>시작예정일/완료예정일</th>
                                            <td>${dataVo.workStDt} ~ ${dataVo.workEdDt}</td>
                                        </tr>
                                        <tr>
                                            <th>난이도</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${dataVo.workLevel eq '1010'}">상</c:when>
                                                    <c:when test="${dataVo.workLevel eq '1020'}">중</c:when>
                                                    <c:when test="${dataVo.workLevel eq '1030'}">하</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>작업내용</th>
                                            <td><op:nrToBr content="${dataVo.workCont}" /></td>
                                        </tr>
                                        <tr>
                                            <th>작업완료일</th>
                                            <td>
                                                ${dataVo.workProcDt}
                                                <c:if test="${not empty dataVo.workProcDt}">
                                                    (<span style="color:red;font-weight: bold;">${dataVo.srProcTerm}</span>일)
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>작업완료내용</th>
                                            <td><op:nrToBr content="${dataVo.workProcCont}" /></td>
                                        </tr>
                                        <tr>
                                            <th>작업완료URL</th>
                                            <td>${dataVo.workUrl}</td>
                                        </tr>
                                        <tr>
                                            <th>(완료)첨부파일</th>
                                            <td>
                                                <c:if test="${fn:length(dataVo.workFileList) > 0}">
                                                    <ul>
                                                    <c:forEach items="${dataVo.workFileList}" var="workFileVo">
                                                        <li>
                                                            <a href="/component/file/ND_fileDownload.do?id=${workFileVo.fileId}" title="${workFileVo.fileDesc}">${workFileVo.localNm}</a>

                                                            <span class="tx_gray">(download ${workFileVo.downCnt}, ${workFileVo.fileSize}, ${workFileVo.fileType})</span>
                                                            <button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${workFileVo.fileSeq}', '${workFileVo.fileId}');">
                                                                <img src="/resources/monitor/images/btn/btn_history.gif" alt="이력보기" class="vm" />
                                                            </button>
                                                        </li>
                                                    </c:forEach>
                                                    </ul>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="tx_r mar_t10">
                                    <button type="button" onclick="jsSimpleClose('${dataVo.seqNo}');"><img alt="닫기" src="/resources/monitor/images/btn/btn_close.gif" /></button>
                                </div>
                            </td>
                        </tr>

                    </c:when>
                </c:choose>

            </c:forEach>

            <op:no-data obj="${pager}" colspan="${cols}" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <c:if test="${not empty SUB_SUPER}">
        <!-- 버튼 -->
        <div class="tx_r mar_t20">
            <button type="button" onclick="jsSrView();"><img src="/resources/monitor/images/btn/btn_regist.gif" alt="등록"/></button>
        </div>
        <!-- //버튼 -->
    </c:if>
</body>
</html>