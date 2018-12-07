<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오류 관리</title>

    <op:jsTag type="spi" items="colorbox, ui, validate, tooltip"/>
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
            jsSelected("messageSeqNo", "${dataVo.messageSeqNo}");

            //검색 날짜 입력
            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            // 작업시작일 종료일 달력 설정
            $(".dp").datepicker();

            // 툴팁 설정
            $(".attrNm").tooltip({ });

            // 담당자 설정 Autocomplete
            $("#transactorNm").autocomplete({
                minLength: ($.browser.mozilla ? 1: 2),
                delay: ($.browser.mozilla ? 800: 10),
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/mgr/ND_mgrSearchList.do" />",
                        type: "POST",
                        dataType: "json",
                        data: {
                            q_rowPerPage: 20,
                            useYn: "Y",
                            mgrNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function( event, ui ) {
                    if(ui.item.statusCd == "1010") {
                        $("#transactorId").val(ui.item.mgrId);
                    } else {
                        jsWarningBox("휴가/파견중인 담당자는 선택할 수 없습니다.");
                        $("#transactorId").val("");
                        $("#transactorNm").val("");
                        return false;
                    }
                }
            });

            $("#updateForm").validate({
                rules: {
                    errorNo: {required : true},
                    errorProcStatus: {required : true}
                    <c:choose>
                        <c:when test="${dataVo.errorProcStatus eq '1010'}">
                            ,transactorNm: {required : true}
                            ,transactorId: {required : true}
                        </c:when>
                        <c:when test="${dataVo.errorProcStatus eq '1020'}">
                            ,workStDt: {required : true}
                            ,workEdDt: {required : true}
                        </c:when>
                    </c:choose>
                },
                submitHandler: function(form) {

                    if($("#errorProcStatus").val() == "1040" && $.trim($("#errorProcCont").val()) == "") {
                        jsErrorBox("완료처리시 오류처리내용을 입력해야 합니다.");
                        return false;
                    }

                    if($("#errorProcStatus").val() == "1030" && $.trim($("#guideCont").val()) == "") {
                        jsErrorBox("처리중 상태로 변경시 이용안내(임시조치방안)를 입력해야 합니다.");
                        return false;
                    }
                    
                    form.submit();
                }
            });

        });

        /*
         * select 태그로 담당자 선택시 설정
         */
        var jsSelectTransator = function() {
            var transactorInfo = $("#selTransactorNm").val();

            if(transactorInfo != "N") {
                var tArr = transactorInfo.split("||");
                var tnArr = tArr[1].split("/");
    
                if(tArr[0] != "") {
                    $("#transactorId").val(tArr[0]);
                    $("#transactorNm").val($.trim(tnArr[1]));
                }
            } else {
                jsWarningBox("휴가/파견중인 담당자는 선택할 수 없습니다.");
                $("#transactorId").val("");
                $("#transactorNm").val("");
            };
        };

        //]]>
    </script>
</head>
<body>
    <%-- 처리자 정보 --%>
    <c:set var="transactorVo" value="${dataVo.transactor}" />

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="post" action="BD_ErrorList.do">

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" ignores="q_errorNo, q_transactorId" />

    </form>

    <h4 class="tx_13">처리정보</h4>
    <!-- 처리정보 내용보기 -->
    <table class="boardWrite" cellspacing="0" border="0" summary="오류내용 기본정보">
        <caption class="hidden">오류내용 상세정보</caption>
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>오류번호</th>
                <td>${dataVo.errorNo}</td>
                <th>오류발생수</th>
                <td>
                    <span style="font-weight: bold;">${dataVo.errorCnt} 회</span>
                    <button type="button" class="vm" onclick="jsErrorDetlList('${dataVo.errorNo}');"><img src="/resources/monitor/images/btn/btn_user_info.gif" class="vm" alt="사용자별상세정보"/></button>
                </td>
            </tr>
            <tr>
                <th>최초오류발생일</th>
                <td>${dataVo.errorStDt}</td>
                <th>최종오류발생일</th>
                <td>
                    ${dataVo.errorEdDt}
                    <c:if test="${not empty dataVo.errorTermDt}">
                        (<span style="color:red;">${dataVo.errorTermDt}</span>일간)
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>담당자</th>
                <td colspan="3">
                    ${dataVo.transactorNm}
                    <c:if test="${not empty dataVo.transactorNm}">
                        ( 이메일 : ${transactorVo.email}, 업무전화 : ${transactorVo.telNo}, 휴대전화 : ${transactorVo.mobNo} )
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>처리상태</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.errorProcStatus eq '1020'}">배정</c:when>
                        <c:when test="${dataVo.errorProcStatus eq '1030'}">처리중</c:when>
                        <c:when test="${dataVo.errorProcStatus eq '1040'}">완료</c:when>
                        <c:otherwise>미배정</c:otherwise>
                    </c:choose>
                </td>
                <th>처리일시</th>
                <td>
                    <c:if test="${not empty dataVo.errorAssignDt}" >
                        <span style="font-weight: bold;">배정일</span> : ${dataVo.errorAssignDt}
                    </c:if>
                    <c:if test="${dataVo.errorProcStatus eq '1040'}" >
                        <br />
                        <span style="font-weight: bold;">완료일</span> : ${dataVo.errorProcDt} (<span style="color:red;">${dataVo.errorProcTerm}</span>일 소요)
                    </c:if>
                </td>
            </tr>

            <tr>
                <th>담당자전달사항</th>
                <td colspan="3"><op:nrToBr content="${dataVo.transmitCont}" /></td>
            </tr>
            <tr>
                <th>이용안내<br />(임시조치방안)</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${not empty dataVo.guideCont}">
                            <op:nrToBr content="${dataVo.guideCont}" />
                        </c:when>
                        <c:otherwise>
                            미등록
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <c:if test="${dataVo.errorProcStatus eq '1040'}">
                <tr>
                    <th>오류처리내용</th>
                    <td colspan="3"><op:nrToBr content="${dataVo.errorProcCont}" /></td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <!-- //처리정보 내용보기 -->

    <h4 class="mar_t30">기본정보</h4>
    <!-- 기본정보 내용보기 -->
    <table class="boardWrite" cellspacing="0" border="0" summary="오류내용 기본정보">
        <caption class="hidden">오류내용 상세정보</caption>
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>사이트</th>
                <td>
                    <span id="attrDomain" class="attrNm">${dataVo.domainNm}</span>
                    <div id="attrDomainTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.domainDesc}">
                                <op:nrToBr content="${dataVo.domainDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
                <th>서버주소</th>
                <td>${dataVo.serverIp} (PORT : ${dataVo.serverPort})</td>
            </tr>

            <tr>
                <th>상태코드</th>
                <td>
                    <span id="attrRes" class="attrNm">${dataVo.errorResNm}</span>
                    <div id="attrResTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.errorResDesc}">
                                <op:nrToBr content="${dataVo.errorResDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
                <th>오류유형</th>
                <td>${dataVo.errorTypeNm}</td>
            </tr>

            <tr>
                <th>오류주소</th>
                <td colspan="3">
                    <span id="attrUri" class="attrNm">${dataVo.errorUriNm}</span>
                    <div id="attrUriTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.errorUriDesc}">
                                <op:nrToBr content="${dataVo.errorUriDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>

            <tr>
                <th>오류발생파일</th>
                <td>
                    <span id="attrFile" class="attrNm">${dataVo.errorFileNm}</span>
                    <div id="attrFileTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.errorFileDesc}">
                                <op:nrToBr content="${dataVo.errorFileDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
                <th>오류발생함수</th>
                <td>${dataVo.errorMethod}</td>
            </tr>

            <tr>
                <th>오류클레스</th>
                <td>
                    <span id="attrClass" class="attrNm">${dataVo.errorClassNm}</span>
                    <div id="attrClassTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.errorClassDesc}">
                                <op:nrToBr content="${dataVo.errorClassDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
                <th>오류줄번호</th>
                <td>${dataVo.errorLine}</td>
            </tr>

            <tr>
                <th>오류메시지</th>
                <td colspan="3"><op:nrToBr content="${dataVo.errorMessage}" /></td>
            </tr>

            <c:if test="${not empty dataVo.errorBaseInfo}">
                <tr>
                    <th>상세메시지</th>
                    <td colspan="3"><textarea readonly="readonly" style="width:99%;height:200px;">${dataVo.errorBaseInfo}</textarea></td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <!-- //기본정보 내용보기 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t20">
        <input type="image" alt="목록" src="/resources/monitor/images/btn/btn_list.gif" onclick="jsList();return false;" />
    </div>
    <!-- //버튼 -->

    <c:choose>

        <c:when test="${dataVo.errorProcStatus eq '1010'}">

            <h4>담당자 배정</h4>

            <form name="updateForm" id="updateForm" method="get" action="ND_UpdateError.do">
        
                <input type="hidden" id="errorNo" name="errorNo" value="${dataVo.errorNo}" />
                <input type="hidden" id="errorProcStatus" name="errorProcStatus" value="1020" />
        
                <op:pagerParam view="view" ignores="q_errorNo" />
        
                <table class="boardWrite" cellspacing="0" border="0" summary="담당자 배정">
                    <caption class="hidden">담당자 배정</caption>
                    <colgroup>
                        <col width="15%" />
                        <col width="85%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>담당자</th>
                            <td>
                                <select id="selTransactorNm" name="selTransactorNm" onchange="jsSelectTransator();" class="over">
                                    <option value="">-- 담당자선택 --</option>
                                    <c:forEach items="${dataList}" var="transactorVo">
                                        <c:choose>
                                            <c:when test="${transactorVo.statusCd eq '1010'}">
                                                <option value="${transactorVo.transactorId}||${transactorVo.label}">${transactorVo.label}</option>
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

                                이름 : <input type="text" name="transactorNm" id="transactorNm" value="${dataVo.transactorNm}" title="이름을 입력하세요" />

                                담당자ID : <input type="text" name="transactorId" id="transactorId" value="${dataVo.transactorId}" readonly="readonly" title="담당자를 선택하세요." />
        
                                <p class="mar_t5 tx_blue_s">담당자를 선택하거나, 이름을 입력하여 검색 후 선택하세요.</p>
                            </td>
                        </tr>
                        <tr>
                            <th>전달사항</th>
                            <td><textarea name="transmitCont" id="transmitCont" rows="5" class="w99_p">${dataVo.transmitCont}</textarea></td>
                        </tr>
                        <tr>
                            <th>완료통보 메시지</th>
                            <td>
                                <select id="messageSeqNo" name="messageSeqNo" class="over">
                                    <option value="">-- 메시지 선택 --</option>
                                    <c:forEach items="${messageList}" var="messageVo">
                                        <option value="${messageVo.messageSeqNo}">${messageVo.title}</option>
                                    </c:forEach>
                                </select>

                                <button type="button" onclick="jsMessageView();" class="vm">
                                    <img src="/resources/monitor/images/btn/btn_con_view.gif" />
                                </button>

                            </td>
                        </tr>
                    </tbody>
                </table>


                <!-- 버튼 -->
                <div class="tx_r mar_t20">
                    <input type="image" alt="저장" src="/resources/monitor/images/btn/btn_save.gif" />
                    <input type="image" alt="목록" src="/resources/monitor/images/btn/btn_list.gif" onclick="jsList();return false;" />
                </div>
                <!-- //버튼 -->

            </form>

        </c:when>

        <c:when test="${dataVo.errorProcStatus eq '1020' or dataVo.errorProcStatus eq '1030'}">

            <h4>처리현황</h4>

            <form name="updateForm" id="updateForm" method="get" action="ND_UpdateError.do">
        
                <input type="hidden" id="errorNo" name="errorNo" value="${dataVo.errorNo}" />
        
                <op:pagerParam view="view" ignores="q_errorNo" />
        
                <table class="boardWrite" cellspacing="0" border="0" summary="처리현황">
                    <caption class="hidden">처리현황</caption>
                    <colgroup>
                        <col width="15%" />
                        <col width="85%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>담당자전달사항</th>
                            <td>${dataVo.transmitCont}</td>
                        </tr>
                        <tr>
                            <th>처리상태</th>
                            <td>
                                <select name="errorProcStatus" id="errorProcStatus" title="처리상태를 선택하세요." class="over">
                                    <c:if test="${dataVo.errorProcStatus eq '1020'}">
                                    <option value="1030">처리중</option>
                                    </c:if>
                                    <option value="1040">완료</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>처리시작/완료예정일</th>
                            <td>
                                <c:choose>
                                    <c:when test="${dataVo.errorProcStatus eq '1020'}">
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
                            <th>이용안내<br />(임시조치방안)</th>
                            <td><textarea name="guideCont" id="guideCont" rows="5" class="w99_p" title="이용안내를 입력하세요.">${dataVo.guideCont}</textarea></td>
                        </tr>
                        <tr>
                            <th>오류처리내용<br />(완료처리시)</th>
                            <td><textarea name="errorProcCont" id="errorProcCont" rows="5" class="w99_p" title="오류처리내용을 입력하세요.">${dataVo.errorProcCont}</textarea></td>
                        </tr>
                        <tr>
                            <th>완료통보 메시지</th>
                            <td>
                                <select id="messageSeqNo" name="messageSeqNo" class="over">
                                    <option value="">-- 메시지 선택 --</option>
                                    <c:forEach items="${messageList}" var="messageVo">
                                        <option value="${messageVo.messageSeqNo}">${messageVo.title}</option>
                                    </c:forEach>
                                </select>

                                <button type="button" onclick="jsMessageView();" class="vm">
                                    <img src="/resources/monitor/images/btn/btn_con_view.gif" />
                                </button>

                                <p class="mar_t5 tx_blue_s">처리완료 통보가 필요 없는 경우 선택하지 마세요.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- 버튼 -->
                <div class="tx_r mar_t20">
                    <input type="image" alt="저장" src="/resources/monitor/images/btn/btn_save.gif" />
                    <input type="image" alt="목록" src="/resources/monitor/images/btn/btn_list.gif" onclick="jsList();return false;" />
                </div>
                <!-- //버튼 -->
        
            </form>

        </c:when>
        <c:otherwise></c:otherwise>
    </c:choose>

</body>
</html>