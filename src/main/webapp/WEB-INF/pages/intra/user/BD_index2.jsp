<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
    <head>
        <title>탈퇴회원관리</title>
        <op:jsTag type="spi" items="validate, ui, highlight"/>
        <op:jsTag type="openworks" items="ui"/>

        <script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
        <script type="text/javascript">
        //<![CDATA[
        (function ($) {
            var pwdYn = "${param.pwdYn}";
            if(pwdYn != 'Y'){
                self.location.href = "BD_pwdForm.do?title1="+ "탈퇴회원관리"+"&title2="+"회원정보 조회"+"&menuType="+"R"+"&returnUrl="+"BD_index2.do";
            }
        })($);

        $().ready(function() {

            // 검색 엔터 이벤트
            jsSetSearchEnterEvent();
            
            $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

            $('#startDt').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonImageOnly : true
            });
            $('#endDt').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonImageOnly : true
            });
            <c:forEach items="${searchMap.q_searchKey0}" var="searchKey">
            $("input:checkbox[name='q_searchKey0']:checkbox[value='${fn:trim(searchKey)}']").attr("checked",true);
            </c:forEach>
            $("#dataForm").validate({
                rules: {
                    q_stDate2 : { dateISO: true, date: true },
                    q_enDate2 : { dateISO: true, date: true }
                },
                messages: {
                    q_stDate2 : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                      date: "시작날짜가 형식에 맞지 않습니다."},
                    q_enDate2   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
                                      date: "종료날짜가 형식에 맞지 않습니다."}
                },
                submitHandler : function(form) {
                    if ($("#startDt").val()=='' &&  $("#endDt").val()!='') {
                        alert("시작날짜가 존재하지 않습니다.");
                        return false;
                    }
                    if ($("#startDt").val()!='' &&  $("#endDt").val()=='') {
                        alert("종료날짜가 존재하지 않습니다.");
                        return false;
                    }
                    if ($("#startDt").val() > $("#endDt").val()) {
                        alert("종료날짜가 시작날짜 보다 작습니다.");
                        return false;
                    }
                    if($("#startDt").val() > $("#endDt").val()){
                        jsWarningBox("탈퇴일 조회 시작일이 종료일보다 먼저이어야 합니다.");
                        $("#startDt").focus();
                        return false;
                    }
                    form.submit();
                }
            });
        });

        var jsDateReset = function() {
            $('#startDt').val("");
            $('#endDt').val("");
        };

        var jsReloadTab = function() {
            tabs.refresh();
        };
        
        var jsMoveTab = function(index) {
            tabs.moveTab(index);
        };

        // 검색 엔터 이벤트
        var jsSetSearchEnterEvent = function() {
            $("#q_searchVal").keydown(function(event){
                if(event.keyCode == 13) {
                    $(this).next().click();
                    return false;
                }
            });
        };

        //통합검색바
        var jsSearchAction = function() {
            if ( $("#q_searchKey").val() != "" ) {
                if ( $("#q_searchVal").val() == "" ) {
                    jsWarningBox("검색어를 입력하세요.");
                    $("#q_searchVal").focus();
                    return false;
                }
            }else{
                if ( $("#q_searchVal").val() != "") {
                    jsWarningBox("검색조건을 선택하세요.");
                    $("#q_searchKey").focus();
                    return false;
                }
            }
            if($("#stDate").val() < $("#edDate").val()){
                jsWarningBox("회원가입일 조회 시작일이 종료일보다 먼저이어야 합니다.");
                $("#stDate").focus();
                return false;
            }
            $('#q_currPage').val("1");
            $('#dataForm').submit();
        };

        var jsMovePage = function(page) {
            var p = 1;
            if (page == 'page') {
                p = $('input[name=page]').val();
            } else {
                p = page;
            }
            $("#q_currPage").val(p);
            $("#dataForm").action= "BD_index.do";
            $("#dataForm").submit();
        };

        var submitEvent = function() {
            if(event.keyCode == 13) {
                jsSearchAction();
            }
        };

        var userListExel = function(el, paramVal){
            $(el).colorbox({
                title : "엑셀 출력 항목 선택",
                href : "PD_checkUserListExel.do?paramVal=" +paramVal,
                width : "850",
                height : "550",
                iframe : true
            });
        };
        //]]>
        </script>
    </head>

    <body>
        <form id="dataForm" name="dataForm">
        <input type="hidden" id="pwdYn" name="pwdYn" value="${param.pwdYn}"/>
        <!-- 컨텐츠영역 -->
        <div id="contents">
            <div class="mar_b30">
            <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                <caption class="hidden"> 검색 조건 </caption>
                <colgroup>
                    <col width="10%" />
                    <col width="40%" />
                    <col width="10%" />
                    <col width="40%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>가입경로</th>
                        <td>
                            <op:code id="q_searchKey1" grpCd="1001" defaultValues="${param.q_searchKey1}"/>
                        </td>
                        <th>회원구분</th>
                        <td>
                            <op:code type="checkbox" id="q_searchKey0" grpCd="5" />
                        </td>
                    </tr>
                    <tr>
                        <th>탈퇴일</th>
                        <td colspan="3">
                            <input class="w180" type="text" name="q_stDate2" id="startDt" title="날짜선택" value="${not empty param.q_stDate2 ? param.q_stDate2 : ''}" />
                            <input class="w180" type="text" name="q_enDate2" id="endDt" title="날짜선택" value="${not empty param.q_enDate2 ? param.q_enDate2 : ''}" />
                            <button type="button" class="gray mar_l5 mar_b5" onclick="jsDateReset();">초기화</button>
                        </td>
                    </tr>
                    <tr>
                        <th>키워드</th>
                        <td colspan="3">
                            <select id="q_searchKey" name="q_searchKey" class="over">
                                <option value="">선택</option>
                                <option <c:if test="${param.q_searchKey == 1000}">selected="selected"</c:if> value="1000"> 전체</option>
                                <option <c:if test="${param.q_searchKey == 1001}">selected="selected"</c:if> value="1001"> 성명</option>
                                <option <c:if test="${param.q_searchKey == 1002}">selected="selected"</c:if> value="1002"> ID</option>
                            </select>
                            <input class="w215" type="text" value="${param.q_searchVal}" id="q_searchVal" name="q_searchVal" title="검색어를 입력하세요."/>
                            <button type="button" class="gray mar_l5 mar_b5" onclick="jsSearchAction();">검색</button>
                        </td>

                    </tr>
                </tbody>
            </table>
            </div>

            <op:pagerParam title="회원탈퇴 목록" />
            <!-- 리스트 -->
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
<%--                     <col width="2%"/> --%>
                    <col width="3%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="17%"/>
                    <col width="20%"/>
                    <col width="20%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                    <tr>
<!--                         <th><input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('ck', this);" /></th> -->
                        <th>번호</th>
                        <th>ID</th>
                        <th>회원구분</th>
                        <th>사용권한</th>
                        <th>회사명</th>
                        <th>가입일</th>
                        <th>탈퇴일</th>
                        <th class="lr_none">탈퇴구분</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <c:set var="index" value="${pager.indexNo}"/>
                    <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                        <tr>
<%--                             <td><input type="checkbox" value="${_bean.userId}" name="ck" class="checkbox" onclick="jsToggleCheck(this);"/></td> --%>
                            <td>${index-status.index}</td>
                            <td class="tx_l">${_bean.userId}</td>
                            <td class="tx_l">
                                <c:if test="${fn:startsWith(_bean.userTyCd, '10')}">개인</c:if>
                                <c:if test="${fn:startsWith(_bean.userTyCd, '20')}">기업</c:if>
                            </td>
                            <td class="tx_l">
                                <c:if test="${fn:endsWith(_bean.userTyCd, '01')}">구매</c:if>
                                <c:if test="${fn:endsWith(_bean.userTyCd, '02')}">구매 판매</c:if>
                            </td>
                            <td class="tx_l">${_bean.cmpnyNm}</td>
                            <td class="tx_l">${_bean.registDt}</td>
                            <td class="tx_l">${_bean.secsnDt}</td>
                            <td class="lr_none tx_l">${_bean.userSttusNm}</td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="13"/>
                </tbody>
            </table>
            <!-- //리스트 -->
            <!-- 페이징 -->
            <op:pager pager="${pager}"/>
            <!-- //페이징 -->
            <!-- 버튼 -->
            <div>
                <div class="float_r">
                    <button class="w_blue" type="button" onclick="userListExel(this, '∬q_searchKey0=${param.q_searchKey0}∬q_searchKey1=${param.q_searchKey1}∬q_searchKey2=${param.q_searchKey2}∬q_searchKey=${param.q_searchKey}∬q_searchVal=${param.q_searchVal}∬q_userSttusCd=1002');">엑셀출력</button>
                </div>
            </div>
        </div>
        <!-- //컨텐츠영역 -->
        </form>
    </body>
</html>