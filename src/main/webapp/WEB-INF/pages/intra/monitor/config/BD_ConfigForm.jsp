<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>환경설정 관리</title>

    <op:jsTag type="spi" items="ui, selectbox, validate, form"/>
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

            jsChecked("errorInformType", "${dataVo.errorInformType}");
            jsChecked("errorInformMethod", "${dataVo.errorInformMethod}");
            jsSelected("domainCd", "${dataVo.domainCd}");

            /** 운영자 설정 Autocomplete */
            $("input[name=adminNm]").autocomplete({
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
                    $("#adminIdList").addOption(ui.item.mgrId, ui.item.label);
                },
                close: function(event, ui) {
                    $("#adminNm").val("");
                }
            });

            $("#dataForm [name=errorInformType]").click(function() {
                if($(this).val() == "1030") {
                    $("#informCycle").removeAttr("disabled");
                } else {
                    $("#informCycle").val("");
                    $("#informCycle").attr("disabled", "disabled");
                }
            });
            
            $("#dataForm").validate({
                rules: {
                    domainCd: {required : true},
                    errorInformType:{required : true},
                    errorInformMethod:{requirefrom : ['errorInformType','1020','알림 설정시']},
                    errorInformMethod:{requirefrom : ['errorInformType','1030','알림 설정시']},
                    informCycle:{range:[1,999]},
                    adminIdList: {required : true}
                },
                submitHandler: function(form) {

                    $("#adminIdList option").each(
                        function() {
                            $(this).attr("selected", "selected");
                        }
                    );

                    $(form).ajaxSubmit({
                        type     : "post",
                        dataType : "json",
                        success  : function(response) {
                            if (response.result) {
                                jsSuccessBox(response.message);
                            } else { 
                                jsErrorBox(response.message);
                            }
                        }
                    });
                }
            });

        });

        //]]>
    </script>
</head>
<body>
    <c:set var="action" value="ND_InsertConfig.do" />
    <c:if test="${not empty dataVo}">
        <c:set var="action" value="ND_UpdateConfig.do" />
    </c:if>

    <form id="dataForm" name="dataForm" method="post" action="${action}">

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />

        <table class="boardWrite" summary="환경설정 등록/수정" >
            <caption class="title">환경설정 등록/수정</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>

            <c:choose>
                <c:when test="${not empty dataVo}">
                    <tr>
                        <th>사이트</th>
                        <td>
                            ${dataVo.domainNm}
                            <input type="hidden" id="domainCd" name="domainCd" value="${dataVo.domainCd}" />
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <th>사이트</th>
                        <td>${dataVo.domainCd}
                            <select id="domainCd" name="domainCd">
                                <option value="">-- 사이트선택 --</option>
                                <c:forEach items="${domainList}" var="domainVo">
                                    <option value="${domainVo.seqNo}">${domainVo.errorAttrNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            <tr>
                <th>알림유형</th>
                <td>
                    <input type="radio" id="errorInformType1" name="errorInformType" value="1010" /> 알리지않음&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="errorInformType2" name="errorInformType" value="1020" /> 최초한번&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="errorInformType3" name="errorInformType" value="1030" /> 항상알림&nbsp;
                    ( 중복오류 알림주기 <input type="text" id="informCycle" name="informCycle" value="${dataVo.informCycle}" style="width:20px;" <c:if test="${empty dataVo.informCycle}">disabled="disabled"</c:if> /> 분마다 )
                </td>
            </tr>

            <tr>
                <th>알림방법</th>
                <td>
                    <input type="radio" id="errorInformMethodS" name="errorInformMethod" value="SMS" /> 문자메시지&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="errorInformMethodE" name="errorInformMethod" value="EMAIL" /> 이메일&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="errorInformMethodSE" name="errorInformMethod" value="SMS_EMAIL" /> 문자메시지 + 이메일
                </td>
            </tr>
            <tr id="authMgrTr">
                <th>운영자</th>
                <td>
                    <div>
                        <select name="adminIdList" id="adminIdList" size="4" multiple="multiple" style="width: 300px; background-color: #E1E1E1; height: 65px;">
                            <c:forEach items="${dataList}" var="adminVo">
                                <option value="${adminVo.adminId}" selected="selected">${adminVo.adminDeptNm}  /  ${adminVo.adminNm}</option>
                            </c:forEach>
                        </select>

                        <button type="button" onclick="$('#adminIdList').removeOption(/./, true);" class="vm" style="border:0px;vertical-align:bottom;">
                            <img src="/resources/monitor/images/btn/btn_del03.gif" />
                        </button>

                    </div>
                    <div class="mar_t10">
                        [운영자명] : <input type="text" name="adminNm" id="adminNm" value="" class="text"/>
                        <p class="mar_t5 tx_blue_s">운영자 이름을 입력하세요.</p>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="tx_r mar_t20">
            <button type="submit"><img src="/resources/monitor/images/btn/btn_save.gif" alt="저장"/></button>
            <button type="button" onclick="jsList('BD_ConfigList.do');"><img src="/resources/monitor/images/btn/btn_list.gif" alt="목록"/></button>
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>