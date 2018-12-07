<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<title>휴일 관리(리스트)</title>
<op:jsTag type="spi" items="validate,ui,form,highlight"/>
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->

    <script type="text/javascript">

  //<![CDATA[
    $().ready(function () {
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

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
            case '0' :
                searchStart = new Date();
                $('#q_startDt').val(getDateStr(searchStart));
                searchEndDt = new Date();
                break;
            case '7D':
                if($("#q_startDt").val() == getDateStr(new Date()) || $("#q_startDt").val() == ""){
                    searchEndDt = getCalDate(new Date(),0,7);
                  }else{
                      searchEndDt = getCaldate2($("#q_startDt").val(),0,7);
                  }
                break;
            case '30D':
                if($("#q_startDt").val() == getDateStr(new Date()) || $("#q_startDt").val() == ""){
                    searchEndDt = getCalDate(new Date(),1,0);
                  }else{
                      searchEndDt = getCaldate2($("#q_startDt").val(),1,0);
                  }
                break;
            default:
                break;
            }
            if ($('#q_startDt').val() == '') {
                $('#q_startDt').val(getDateStr(new Date()));
            }
            $('#q_endDt').val(getDateStr(searchEndDt));

        });


    });
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action= "BD_index.do";
        document.dataForm.submit();
    };

    var jsInsertPop = function(el){
        $(el).colorbox({
            title : "휴일등록 메뉴",
            href  : "PD_insertPop.do",
            width : "650",
            height: "700",
            iframe: true
           });
    };

    var getDateStr = function(date) {
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };
    var set2Str = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
    };
    var getCalDate = function(date, months, days) {
        var newDate = date;
        if (typeof(date.getDate) != 'function') {
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;
    };

    var getCaldate2 = function(date,months,days){
        if(date.length == 8){
            var a = date;
            var date2 = a.substring(0,4) + '-' + a.substring(4,6) + '-' + a.substring(6,8);

            var newDate = new XDate(date2);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        }else{
            var newDate = new XDate(date);
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        }
    };

    var jsSearch = function(){
        if($("#q_startDt").val().length == 10){
            $("#q_startDt").val($("#q_startDt").val().replace(/-/gi,""));
        };
        if($("#q_endDt").val().length == 10){
            $("#q_endDt").val($("#q_endDt").val().replace(/-/gi,""));
        };

        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    var jsUpdatePop = function(el,vl,zl){
        $(el).colorbox({
            title : "휴일 수정 메뉴",
            href  : "PD_updatePop.do?seq="+zl+"&gbn="+vl ,
            width : "650",
            height: "700",
            iframe: true
           });

    };

    var jsDeleteChoose = function(){
        var seqA = '';
        var seqB = '';
        $('input.seq_A:checked').each(function (i) {
            seqA += ',' + $(this).val();
        });
        $('input.seq_B:checked').each(function (i) {
            seqB += ',' + $(this).val();
        });
        if(seqA == '' && seqB == ''){
            jsWarningBox("삭제할 휴일을 선택해 주세요");
            return false;
        }
        $.ajax({
            url      : "ND_DeleteChoose.do",
            type     : "POST",
            data     : {
                seqA       : seqA.substring(1),
                seqB       : seqB.substring(1)
            },
            async    : false,
            success  : function (response) {
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.deleteOk);
                        document.dataForm.action= "BD_index.do";
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
    var jsAllView = function(){
        $('#q_startDt').val('20000101');
        $('#q_endDt').val('21001231');
        $('#dataForm').action = "BD_index.do";
        $('#dataForm').submit();
    };



        //]]>
    </script>
</head>
<body>
<div id="contents">
    <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
    <input type="hidden" name="startDt1" id="startDt1"/>
    <input type="hidden" name="endDt1" id="endDt1"/>

    <!-- 검색 -->
    <div class="search">
        <fieldset>

            <label>검색일자 :</label>
            <input class="w120" type="text" value="${param.q_startDt }" name="q_startDt" id="q_startDt" title="날짜선택" /> ~ <input class="w120" type="text" value="${param.q_endDt }" name="q_endDt" id="q_endDt" title="날짜선택"/>
            <span class="mar_l10" id="schedulePeriod">
            <button class="gray mar_l5 mar_b5" type="button" id="0">일일</button>
            <button class="gray mar_l5 mar_b5" type="button" id="7D">주간</button>
            <button class="gray mar_l5 mar_b5" type="button" id="30D">월간</button>
            </span>
            &nbsp;&nbsp;&nbsp;제목 : <input class="w215" type="text" value="${param.q_searchVal }" name="q_searchVal" id="q_searchVal" title="검색어를 입력하세요." />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="s_blue mar_l5 mar_b5" type="button" onclick="jsSearch();">검색</button>
        </fieldset>
    </div>
    <!-- //검색 -->

    <div>
        <ul class="tab">
            <li><a href="BD_cal.do">캘린더형</a></li>
            <li><a href="BD_index.do" class="on">리스트형</a></li>
        </ul>
    </div>

    <!-- 페이지당 목록선택-->
    <op:pagerParam title="배너 목록" />
    </form>

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="5%"/>
            <col width="5%"/>
            <col width=""/>
            <col width="6%"/>
            <col width="8%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="5%"/>
            <col width="8%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="14%"/>
        </colgroup>
        <thead>
            <tr>
                <th>선택</th>
                <th>번호</th>
                <th>휴일명</th>
                <th colspan="8">기간</th>
                <th class="lr_none">휴일 종류</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
            <input type="hidden" name="gbn" value="${baseVo.gbn}"/>
            <input type="hidden" name="repeatYearYn" value="${baseVo.repeatYearYn }"/>
            <tr>
                <td><input type="checkbox" name="seq" id="seq" class="seq_${baseVo.gbn }" value="${baseVo.seq }" onclick="jsToggleCheck(this);"/></td>
                <td>${index-status.index}</td>
                <td class="tx_l"><a href="#" onclick="jsUpdatePop(this,'${baseVo.gbn}','${baseVo.seq }');"><span <c:if test="${baseVo.gbn eq 'B'}">class="tx_red"</c:if>>${baseVo.title }</span></a></td>
                    <c:choose>
                        <c:when test="${baseVo.repeatYearYn eq 'Y'}">
                            <td class="lr_none tx_red">매년</td>
                            <td class="lr_none"></td>
                            <td class="lr_none">${fn:substring(baseVo.startDt,4,6)}월</td>
                            <td class="lr_none">${fn:substring(baseVo.startDt,6,8)}일</td>
                            <td class="lr_none">~</td>
                            <td class="lr_none"></td>
                            <td class="lr_none">${fn:substring(baseVo.endDt,4,6)}월</td>
                            <td>${fn:substring(baseVo.endDt,6,8)}일</td>
                        </c:when>
                        <c:when test="${baseVo.repeatYearYn eq 'M'}">
                            <td class="lr_none tx_blue">매월</td>
                            <td class="lr_none"></td>
                            <td class="lr_none"></td>
                            <td class="lr_none">${fn:substring(baseVo.startDt,6,8)}일</td>
                            <td class="lr_none">~</td>
                            <td class="lr_none"></td>
                            <td class="lr_none"></td>
                            <td>${fn:substring(baseVo.endDt,6,8)}일</td>
                        </c:when>
                        <c:otherwise>
                            <td class="lr_none"></td>
                            <td class="lr_none">${fn:substring(baseVo.startDt,0,4)}년</td>
                            <td class="lr_none">${fn:substring(baseVo.startDt,4,6)}월</td>
                            <td class="lr_none">${fn:substring(baseVo.startDt,6,8)}일</td>
                            <td class="lr_none">~</td>
                            <td class="lr_none">${fn:substring(baseVo.endDt,0,4)}년</td>
                            <td class="lr_none">${fn:substring(baseVo.endDt,4,6)}월</td>
                            <td>${fn:substring(baseVo.endDt,6,8)}일</td>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${baseVo.gbn eq 'B'}">
                            <td class="lr_none tx_red">
                                            법정공휴일
                            </td>
                        </c:when>
                        <c:when test="${baseVo.gbn eq 'A'}">
                            <td class="lr_none">
                                            임시공휴일
                            </td>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
            </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- //리스트 -->
    <op:pager pager="${pager}" />
<!-- //페이징 -->
    <div class="tx_r">
	    <button class="btn blue" type="button" onclick="jsAllView();">전체 휴일 보기</button>&nbsp;&nbsp;&nbsp;
	    <button class="btn blue" type="button" onclick="jsDeleteChoose();">선택 삭제</button>&nbsp;&nbsp;&nbsp;
	    <button class="btn blue" type="button" onclick="jsInsertPop(this);">휴일 등록</button>
    </div>
</div>
<!-- //컨텐츠영역 -->
</body>
</html>