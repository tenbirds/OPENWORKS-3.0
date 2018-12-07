<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
Calendar cal = Calendar.getInstance();
int nowYear = 0;
nowYear = cal.get(Calendar.YEAR);
int year = nowYear;
%>


<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>일정관리(리스트)</title>
<op:jsTag type="spi" items="validate,ui,form,highlight" />
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript"
    src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->

<script type="text/javascript">
    //<![CDATA[
    $().ready(function() {
        $.datepicker.setDefaults({
            dateFormat : 'yy-mm-dd'
        });

        $('#q_startDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

        $("span#schedulePeriod button.gray").click(function() {
            var sType = $(this).attr('id');
            var searchStart = null;
            var searchEndDt = null;

            switch(sType) {
            case '0':
                searchStart = new Date();
                $('#q_startDt').val(getDateStr(searchStart));
                searchEndDt = new Date();
                break;
            case '7D':
                if($("#q_startDt").val() == getDateStr(new Date()) || $("#q_startDt").val() == "") {
                    searchEndDt = getCalDate(new Date(), 0, 7);
                } else {
                    searchEndDt = getCaldate2($("#q_startDt").val(), 0, 7);
                }
                break;
            case '30D':
                if($("#q_startDt").val() == getDateStr(new Date()) || $("#q_startDt").val() == "") {
                    searchEndDt = getCalDate(new Date(), 1, 0);
                } else {
                    searchEndDt = getCaldate2($("#q_startDt").val(), 1, 0);
                }
                break;
            default:
                break;
            }

            if($('#q_startDt').val() == '') {
                $('#q_startDt').val(getDateStr(new Date()));
            }

            $('#q_endDt').val(getDateStr(searchEndDt));
        });
        
        
        var subTabIdx = "${param.subTabIdx}";
          
        if(subTabIdx == '' || subTabIdx == null)          subTabIdx = "1";            
          
        var s = document.getElementById("subTab" + subTabIdx);
        var a = document.getElementById("subA" + subTabIdx);
        s.style.cssText = "background-color:#db894d !important;";
        a.style.cssText = "color:#fff !important;";

    });
    
    var jsMovePage = function(page) {
        var p = 1;
        if(page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action = "BD_index.do";
        document.dataForm.submit();
    };
    
    //등록팝업
    var jsInsertPop = function(el) {
        $(el).colorbox({
            title : "일정등록 메뉴",
            href : "PD_insertPop.do",
            width : "650",
            height : "700",
            iframe : true
        });
    };

    var getDateStr = function(date) {
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };
    
    var set2Str = function(vl) {
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };
    
    //달력1
    var getCalDate = function(date, months, days) {
        var newDate = date;
        if(typeof (date.getDate) != 'function') {
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;
    };

    //달력2
    var getCaldate2 = function(date, months, days) {
        if(date.length == 8) {
            var a = date;
            var date2 = a.substring(0, 4) + '-' + a.substring(4, 6) + '-' + a.substring(6, 8);

            var newDate = new XDate(date2);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        } else {
            var newDate = new XDate(date);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        }
    };

    //검색
    var jsSearch = function() {
    
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
    
    //수정팝업
    var jsUpdatePop = function(el, vl) {        
        $(el).colorbox({
            title : "일정 수정 메뉴",
            href : "PD_updatePop.do?Plan_seq=" + vl,
            width : "650",
            height : "700",
            iframe : true
        });

    };

    //선택삭제
    var jsDeleteChoose = function() {
        var plan_seq = '';

        $('input.chk_seq:checked').each(function(i) {
            plan_seq += ',' + $(this).val();
        });

        if(plan_seq == '') {
            jsWarningBox("삭제할 일정을 선택해 주세요");
            return false;
        }

        $.ajax({
            url : "ND_DeleteChoose.do",
            type : "POST",
            data : {
                plan_seq : plan_seq.substring(1)
            },
            async : false,
            success : function(response) {
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.deleteOk);
                        document.dataForm.action = "BD_index.do";
                        document.dataForm.submit();
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }
            }
        });

    };

    
    var closeBaseStatus = function(){
        var subTabIdx = "${param.subTabIdx}";
            
            if(subTabIdx == '' || subTabIdx == null)
                subTabIdx = "1";
            
            var subTabUrl = document.getElementById("subA"+subTabIdx).href;
            
            dataForm.action = subTabUrl;
            dataForm.submit();
        };

    //]]>
</script>
</head>
<body>
    <div id="contents">
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">


            <!-- 검색 -->
            <div class="search">
                <fieldset>
                    <legend>검색하세요.</legend>
                    <select id="q_searchKey" name="q_searchKey"
                        value="${param.q_searchKey }" class="over">
                        <option
                            <c:if test="${param.q_searchKey eq  'board_tit'}">    selected="selected" </c:if>
                            value="board_tit">선택하세요.</option>
                        <option
                            <c:if test="${param.q_searchKey eq  'board_con'}">    selected="selected" </c:if>
                            value="board_con">제목</option>
                        <option
                            <c:if test="${param.q_searchKey eq  'board_writer'}"> selected="selected" </c:if>
                            value="board_writer">등록자</option>
                    </select> <input class="w215" type="text" value="${param.q_searchVal }"
                        name="q_searchVal" id="q_searchVal" title="검색어를 입력하세요." />
                    &nbsp;&nbsp;&nbsp;<label>검색일자 :</label> <input class="w120"
                        type="text" value="${param.q_startDt }" name="q_startDt"
                        id="q_startDt" title="날짜선택" /> ~ <input class="w120" type="text"
                        value="${param.q_endDt }" name="q_endDt" id="q_endDt" title="날짜선택" />

                    <span class="mar_l10" id="schedulePeriod">
                        <button class="gray mar_l5 mar_b5" type="button" id="0">일일</button>
                        <button class="gray mar_l5 mar_b5" type="button" id="7D">주간</button>
                        <button class="gray mar_l5 mar_b5" type="button" id="30D">월간</button>
                    </span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                    <button class="s_blue mar_l5 mar_b5" onclick="jsSearch();">검색</button>
                    <button class="s_blue mar_l5 mar_b5" type="button"
                        onclick="jsInsertPop(this);">일정등록</button>
                    <button class="s_blue mar_l5 mar_b5" type="button"
                        onclick="jsDeleteChoose();">선택 삭제</button>

                </fieldset>
            </div>
            <!-- //검색 -->
            
            
            <!-- 탭 -->
            <ul class="tab">
                <li><a href="BD_index.do"  class="on" /> 전체일정</a></li>
                <li><a href="BD_day.do"               /> 일일일정</a></li>
                <li><a href="BD_week.do"              /> 주간일정</a></li>                
            </ul>
            <!-- //탭 -->            
            <!-- 작은탭 -->
            <ul class="tab_s">
                <li id="subTab1"><a href="BD_index.do"  id="subA1">리스트</a></li>
                <li id="subTab2"><a href="BD_cal.do"    id="subA2">달력형</a></li>                
            </ul>        
            <!-- //작은탭 -->
            <br /><br /><br />
            <!-- 페이지당 목록선택-->
            <op:pagerParam title="배너 목록" />
        </form>


        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden">목록</caption>
            <colgroup>
                <col width="5%">
                    <col width="5%">
                        <col width="">
                            <col width="9%">
                                <col width="9%">
                                    <col width="8%">
                                        <col width="9%">
            </colgroup>
            <thead>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>시작일</th>
                    <th>종료일</th>
                    <th>등록자</th>
                    <th class="lr_none">등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="index" value="${pager.indexNo}" />
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="chk_seq" id="chk_seq"
                            class="chk_seq" value="${baseVo.plan_seq}" /></td>
                        <td>${baseVo.num}</td>
                        <td class="tx_l"><a href="#"
                            onclick="jsUpdatePop(this,'${baseVo.plan_seq }');">${baseVo.title
                                }</a></td>
                        <td>${baseVo.start_dt}</td>
                        <td>${baseVo.end_dt}</td>
                        <td>${baseVo.reg_id}</td>
                        <td class="lr_none">${baseVo.reg_dt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- //리스트 -->
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
                
        <div class="tx_r">
            <button class="btn blue" type="button" onclick="jsInsertPop(this);">일정등록</button>
            <!-- //작은탭 -->
        </div>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>