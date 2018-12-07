<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
    <title>회원접속이력관리</title>
    <op:jsTag type="spi" items="ui, highlight,validate,extjs4,form"/>
    <op:jsTag type="openworks" items="ui"/>

    <script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>

    <script type="text/javascript">
    (function ($) {
        var pwdYn = "${param.pwdYn}";
        if(pwdYn != 'Y'){
            self.location.href = "/intra/user/BD_pwdForm.do?title1="+ "회원접속이력관리"+"&title2="+"회원접속 이력"+"&menuType="+"R"+"&returnUrl="+"/intra/user/webLog/BD_userWebLogList.do";
        }
    })($);


     $().ready(function() {

         $("#${param.selectDateColor}").css("background-color","black");

         if ($("#searchCal_openYn").val() == "Y") {

            $("#searchCal").show();
         } else {

            $("#searchCal").hide();
         }

        if($("#dateSetYn").val() == "Y"){
            $("#dateSet").show();
        }else{
            $("#dateSet").hide();
        }

        $("#dateSet1  a  button.gray").click(function() {
            $('#q_enDate').val(getDateStr(new Date()));
            var sType = $(this).attr('id');
            var stDate = null;
            switch(sType) {
            case '0' :
                stDate = new Date();
                $("#selectDateColor").val("0");
                dateButton();
                break;
            case '1D':
                stDate = getCalDate(new Date(),0,-1);
                $("#selectDateColor").val("1D");
                dateButton();
                break;
            case '7D':
                stDate = getCalDate(new Date(),0,-7);
                $("#selectDateColor").val("7D");
                dateButton();
                break;
            case '10D':
                stDate = getCalDate(new Date(),0,-10);
                $("#selectDateColor").val("10D");
                dateButton();
                break;
            case '15D':
                stDate = getCalDate(new Date(),0,-15);
                $("#selectDateColor").val("15D");
                dateButton();
                break;
            case '1M':
                stDate = getCalDate(new Date(),-1,0);
                $("#selectDateColor").val("1M");
                dateButton();
                break;
            case '3M':
                stDate = getCalDate(new Date(),-3,0);
                $("#selectDateColor").val("3M");
                dateButton();
                break;
            case '6M':
                stDate = getCalDate(new Date(),-6,0);
                $("#selectDateColor").val("6M");
                dateButton();
                break;
            case 'ALL':
                stDate = new Date();
                $("#selectDateColor").val("ALL");
                dateButton();
                break;
            default:
                stDate = new Date();
                break;
            }
            $('#q_stDate').val(getDateStr(stDate));
            if ($('#q_enDate').val() == '') {
                $('#q_enDate').val(getDateStr(new Date()));
            }

            if (sType == 'ALL') {
                $('#q_stDate').val("");
                $('#q_enDate').val("");
            }
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_stDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true,
        });
        $('#q_enDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true,
        });
//        <c:if test="${not empty dataList1}">
        $("#chart01").html('');
        Ext.create('widget.panel', {
            height: 400,
            width : 700,
            title: '금일로그인통계',
            renderTo: 'chart01',
            layout: 'fit',
            items: chart01
        });
        $("#chart02").html('');
        Ext.create('widget.panel', {
            height: 400,
            width : 700,
            title: '금일접속회원유형통계',
            renderTo: 'chart02',
            layout: 'fit',
            items: chart02
        });
        $("#chart03").html('');
        Ext.create('widget.panel', {
            height: 400,
            width : 700,
            title: '금일접속남녀성별',
            renderTo: 'chart03',
            layout: 'fit',
            items: chart03
        });
        $("#chart04").html('');
        Ext.create('widget.panel', {
            height: 400,
            width : 700,
            title: '금일접속연령대별',
            renderTo: 'chart04',
            layout: 'fit',
            items: chart04
        });
//        </c:if>

        $('#graphStats').hide();
        $('#toggleBtn1').hide();

     });

    var getCalDate = function(date, months, days) {
        var newDate = date;
        if (typeof(date.getDate) != 'function') {
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;

    };

    var getDateStr = function(date) {
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
    };

    var dateSet = function(){
        $(".gray").css("background-color","#979797");
        $("#selectDateColor").val("");
        if($("#dateSetYn").val() == "Y"){
            $("#dateSet").hide();
            $('#q_stDate').val('');
            $('#q_enDate').val('');
            $("#dateSetYn").val("N");
        }else{
            $("#dateSet").show();
            $('#q_stDate').val('');
            $('#q_enDate').val('');
            $('#q_stDate').focus();
            $("#dateSetYn").val("Y");
        }
    };

    var dateButton = function(){
        $(".gray").css("background-color","#979797");
        $("#"+$("#selectDateColor").val()).css("background-color","black");
    };

    //통합검색바
    var jsSearchAction = function() {
            $("#dataForm").validate({
                rules : {
                    q_stDate : {date:true},
                    q_enDate : {date:true}
                }
            });

            if ( $("#q_searchKey").val() != "") {
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

            if ($('#q_stDate').val() > $('#q_enDate').val()) {
                jsWarningBox('시작일이 종료일보다 늦습니다.');
                return;
            }

        $('#q_currPage').val("1");
         $('#dataForm').submit();
    };

    var searchCal = function() {
        $("#searchCal_openYn").val("Y");
        $("#searchCal").show();
    };


    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#q_currPage").val(p);
        $("#dataForm").submit();
    };

    var submitEvent = function() {
        if(event.keyCode == 13) {
            jsSearchAction();
        }
    };

    var dateAuto = function(obj){
        // cursor를 문장 끝으로 이동
        if(obj.createTextRange){
            var FieldRange = obj.createTextRange();
            FieldRange.moveStart('character', obj.value.length);
            FieldRange.collapse();
            FieldRange.select();
        }

        //입력 허용 키
        if ((event.keyCode >= 48 && event.keyCode <= 57) ||   //숫자열 0 ~ 9 : 48 ~ 57
            (event.keyCode >= 96 && event.keyCode <= 105) ||  //키패드 0 ~ 9 : 96 ~ 105
             event.keyCode == 8  || event.keyCode == 46 ||    //BackSpace, Delete
             event.keyCode == 35 || event.keyCode == 36 ||    //End 키, Home 키
             event.keyCode == 9  || event.keyCode == 45)    {    //Tab 키
            event.returnValue = true;
        }else{
            event.returnValue = false;
        }
        if(event.keyCode != 8){
            var qStDate = $("#q_stDate").val();
            var qEnDate = $("#q_enDate").val();
            if(qStDate.length > 10 || qEnDate.length >10){
                return;
            }

            if(qStDate.length == 4){
                $("#q_stDate").val(qStDate+"-");
            }else if(qStDate.length == 7){
                $("#q_stDate").val(qStDate+"-");
            }

            if(qEnDate.length == 4){
                $("#q_enDate").val(qEnDate+"-");
            }else if(qEnDate.length == 7){
                $("#q_enDate").val(qEnDate+"-");
            }
        }
    };
<%--
    <c:if test="${not empty dataList1}">
    Ext.require(['Ext.chart.*',
                 'Ext.data.*',
                 'Ext.layout.container.Fit']);

    var getData = function (idx) {
        var fileds = ['name', 'data'];
        var data = [new Array(),new Array(),new Array(),new Array()];

            data[0].push({
                name : '로그인',
                data : <c:out value = "${dataList1.loginUserCount}"/>
            });

            data[0].push({
                name : '비로그인',
                data : <c:out value = "${dataList1.notLoginUserCount}"/>
            });

            data[1].push({
                name : 'G-PIN',
                data : <c:out value = "${dataList1.gpinUserCount}"/>
            });
            data[1].push({
                name : '공인인증',
                data : <c:out value = "${dataList1.certificateUserCount}"/>
            });
            data[1].push({
                name : '실명인증',
                data : <c:out value = "${dataList1.generalUserCount}"/>
            });
            data[1].push({
                name : '기타',
                data : <c:out value = "${dataList1.etcUserCount}"/>
            });
            data[3].push({
                name : '10대',
                data : <c:out value = "${dataList1.teenCount}"/>
            });
            data[3].push({
                name : '20대',
                data : <c:out value = "${dataList1.twentyCount}"/>
            });
            data[3].push({
                name : '30대',
                data : <c:out value = "${dataList1.thirtyCount}"/>
            });
            data[3].push({
                name : '40대',
                data : <c:out value = "${dataList1.fortyCount}"/>
            });
            data[3].push({
                name : '50대',
                data : <c:out value = "${dataList1.fiftyCount}"/>
            });
            data[3].push({
                name : '60대',
                data : <c:out value = "${dataList1.sixtyCount}"/>
            });
            data[3].push({
                name : '기타연령',
                data : <c:out value = "${dataList1.seventyEtcCount}"/>
            });
            data[2].push({
                name : '남성',
                data : <c:out value = "${dataList1.manCount}"/>
            });
            data[2].push({
                name : '여성',
                data : <c:out value = "${dataList1.womanCount}"/>
            });
            data[2].push({
                name : '등록안됨',
                data : <c:out value = "${dataList1.etcSexCount}"/>
            });

        return Ext.create('Ext.data.JsonStore', {
            fields : fileds,
            data   : data[idx]
        });
    };

    var chart01 = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        store: getData(0),
        shadow: true,
        legend: {
            position: 'left'
        },
        insetPadding: 15,
        theme: 'Base:gradients',
        series: [{
            type: 'pie',
            field: 'data',
            showInLegend: true,
            donut: false,
            tips: {
              trackMouse: true,
              width: 140,
              height: 25,
              renderer: function(storeItem, item) {
                this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / <c:out value = "${dataList1.entireUserCount}"/> * 100) + '%' + '[' +storeItem.get('data') +' 명 ]');
              }
            },
            highlight: {
              segment: {
                margin: 10
              }
            },
            label: {
                field: 'name',
                display: 'rotate',
                contrast: true,
                font: '12px Arial'
            },
            colorSet : ['rgb(205, 62, 62)',
                        'rgb(226, 145, 41)'
                        ]
        }]
    });
    var chart02 = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        store: getData(1),
        shadow: true,
        legend: {
            position: 'left'
        },
        insetPadding: 15,
        theme: 'Base:gradients',
        series: [{
            type: 'pie',
            field: 'data',
            showInLegend: true,
            donut: false,
            tips: {
              trackMouse: true,
              width: 140,
              height: 25,
              renderer: function(storeItem, item) {
                this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / <c:out value = "${dataList1.memberTypeCount}"/> * 100) + '%' + '[' +storeItem.get('data') +' 명 ]');
              }
            },
            highlight: {
              segment: {
                margin: 10
              }
            },
            label: {
                field: 'name',
                display: 'rotate',
                contrast: true,
                font: '12px Arial'
            },
            colorSet : ['rgb(205, 62, 62)',
                        'rgb(226, 145, 41)',
                        'rgb(156, 177, 17)',
                        'rgb(17, 177, 69)']
        }]
    });
    var chart03 = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        store: getData(2),
        shadow: true,
        legend: {
            position: 'left'
        },
        insetPadding: 15,
        theme: 'Base:gradients',
        series: [{
            type: 'pie',
            field: 'data',
            showInLegend: true,
            donut: false,
            tips: {
              trackMouse: true,
              width: 140,
              height: 25,
              renderer: function(storeItem, item) {
                this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / <c:out value = "${dataList1.sexTypeCount}"/> * 100) + '%' + '[' +storeItem.get('data') +' 명 ]');
              }
            },
            highlight: {
              segment: {
                margin: 10
              }
            },
            label: {
                field: 'name',
                display: 'rotate',
                contrast: true,
                font: '12px Arial'
            },
            colorSet : ['rgb(205, 62, 62)',
                        'rgb(226, 145, 41)',
                        'rgb(156, 177, 17)']
        }]
    });
    var chart04 = Ext.create('Ext.chart.Chart', {
        xtype: 'chart',
        animate: true,
        store: getData(3),
        shadow: true,
        legend: {
            position: 'left'
        },
        insetPadding: 15,
        theme: 'Base:gradients',
        series: [{
            type: 'pie',
            field: 'data',
            showInLegend: true,
            donut: false,
            tips: {
              trackMouse: true,
              width: 140,
              height: 25,
              renderer: function(storeItem, item) {
                this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / <c:out value = "${dataList1.ageTypeCount}"/> * 100) + '%' + '[' +storeItem.get('data') +' 명 ]');
              }
            },
            highlight: {
              segment: {
                margin: 10
              }
            },
            label: {
                field: 'name',
                display: 'rotate',
                contrast: true,
                font: '12px Arial'
            },
            colorSet : ['rgb(205, 62, 62)',
                        'rgb(226, 145, 41)',
                        'rgb(156, 177, 17)',
                        'rgb(17, 177, 69)',
                        'rgb(156, 177, 17)',
                        'rgb(17, 177, 69)',
                        'rgb(38, 93, 193)'
                        ]
        }]
    });
    </c:if>
 --%>
    var graphOpenY =  function (){
        $('#graphStats').show();
        $('#toggleBtn').hide();
        $('#toggleBtn1').show();
    };
    var graphOpenN =  function (){
        $('#graphStats').hide();
        $('#toggleBtn').show();
        $('#toggleBtn1').hide();
    };
</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
    <form id="dataForm" name="dataForm">
    <input type="hidden" id="graph_openYn" name="graph_openYn" value="${param.graph_openYn}"/>
    <input type="hidden" id="dateSetYn" name="dateSetYn" value="${param.dateSetYn}"/>
    <input type="hidden" id="pwdYn" name="pwdYn" value="${param.pwdYn}"/>
    <input type="hidden" id="selectDateColor" name="selectDateColor" value="${param.selectDateColor}"/>
    <div id="contents">
<%--
        <!-- 통계그래프열고닫기 -->
        <div class="tx_r mar_b30">
            <a href="#"><button type="button" id="toggleBtn" class="blue" onclick="graphOpenY();">통계 그래프  열기</button></a>
            <a href="#"><button type="button" id="toggleBtn1" class="w_blue" onclick="graphOpenN();">통계 그래프 감추기</button></a>
        </div>
        <!-- 그래프부분 -->
        <div class="mar_b30 w_100p" id = "graphStats">
        <c:if test="${empty dataList1}">
            <div align="center">금일 접속한 회원이 없습니다.</div>
        </c:if>
        <c:if test="${not empty dataList1}">
        <div id='chart01' class='graph_half float_l'>
            </div>
            <div id='chart02' class='graph_half float_r'>
            </div>
            <div id='chart03' class='graph_half float_l'>
            </div>
            <div id='chart04' class='graph_half float_r'>
            </div>
            </c:if>
        </div>
        <!--// 그래프부분 -->
 --%>
        <!-- 검색 -->
        <div class="search">
        <div style="margin-bottom:10px;">
            <fieldset>
                <legend>조건을 선택하여 검색하세요.</legend>
                <op:code id="q_searchKey0" grpCd="5" defaultLabel="회원유형" defaultValues="${param.q_searchKey0}"/>
                <op:code id="q_searchKey1" grpCd="71" defaultLabel="회원가입유형" defaultValues="${param.q_searchKey1}"/>
                <select id="q_searchKey2" name="q_searchKey2" class="over">
                    <option value="">회원등급선택</option>
                    <option <c:if test="${param.q_searchKey2 == '1000'}">selected="selected"</c:if> value="1000">전체</option>
                    <c:forEach items="${userGradeList}" var="_bean" varStatus="status">
                        <option<c:if test="${_bean.userGradCode eq param.q_searchKey2}"> selected="selected"</c:if> value="${_bean.userGradCode}">${_bean.userGradNm}</option>
                    </c:forEach>
                </select>
                <select id="q_searchKey" name="q_searchKey" class="over">
                    <option value="">선택</option>
                    <option <c:if test="${param.q_searchKey == 1001}">selected="selected"</c:if> value="1001">전체</option>
                    <option <c:if test="${param.q_searchKey == 1002}">selected="selected"</c:if> value="1002">성명</option>
                    <option <c:if test="${param.q_searchKey == 1003}">selected="selected"</c:if> value="1003">ID</option>
                </select>
                <input class="w215" type="text" value="${param.q_searchVal}"  id="q_searchVal"  name="q_searchVal" title="검색어를 입력하세요." />
                <button type="button" onclick="jsSearchAction();" class="gray mar_l5 mar_b5" >검색</button>
            </fieldset>
        </div>
        <!-- //검색 -->

        <!-- 검색일자-->
        <div  id="dateSet1" style="margin-bottom:10px;">
            <a href="#"><button type="button" id="0"   class="gray">당일</button></a>
            <a href="#"><button type="button" id="1D"  class="gray">전일</button></a>
            <a href="#"><button type="button" id="7D"  class="gray">7일</button></a>
            <a href="#"><button type="button" id="10D" class="gray">10일</button></a>
            <a href="#"><button type="button" id="15D" class="gray">15일</button></a>
            <a href="#"><button type="button" id="1M"  class="gray">1개월</button></a>
            <a href="#"><button type="button" id="3M"  class="gray">3개월</button></a>
            <a href="#"><button type="button" id="6M"  class="gray">6개월</button></a>
            <a href="#"><button type="button" id="ALL" class="gray">전체</button></a>
            <a href="#"><button type="button" id="DATESET" onclick="dateSet()" class="s_blue">기간지정</button></a>
        </div>

        <div id="dateSet" style="padding:10px 0 5px 0;">
            <fieldset>
                <legend>일시를 지정하여 검색하세요.</legend>
                <label><span class="tx_b">검색일자</span></label>
                <input type="text" name="q_stDate" id="q_stDate" onkeydown="dateAuto(this);" class="w120" title="올바른 날짜를 입력하세요." value="${param.q_stDate}" maxlength="10"/> ~
                <input type="text" name="q_enDate" id="q_enDate" onkeydown="dateAuto(this);" class="w120" title="올바른 날짜를 입력하세요." value="${param.q_enDate}" maxlength="10"/>
            </fieldset>
        </div>
        </div>
        <!-- //검색일자-->
        <op:pagerParam title="회원접속이력 목록" />
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="8%"/>
                <col width="8%"/>
                <col width="15%"/>
                <col width="15%"/>
                <col width="9%"/>
                <col width="12%"/>
                <col width=""/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>ID</th>
                    <th>성명</th>
                    <th>가입일시</th>
                    <th>최근접속일시</th>
                    <th>로그인회수</th>
                    <th>회원등급</th>
                    <th class="lr_none">회원가입유형</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td class="tx_l">
                            <a href="#" onclick="pwdConfirm(this
                                                            , '${_bean.userNm}님의 접속이력'
                                                            ,'R'
                                                            ,'../user/webLog/PD_userWebLog.do'
                                                            ,'900'
                                                            ,'700'
                                                            ,'${_bean.userId}'
                                                            ,'∬userNm=${_bean.userNm}∬loginDtm=${_bean.recentLoginDt}'
                                                            ,''
                                                            ,''
                                                            );">${_bean.userId}</a>
                        </td>
                        <td class="tx_l">${_bean.userNm}</td>
                        <td>${_bean.registDt}</td>
                        <td>${_bean.recentLoginDt}</td>
                        <td class="tx_r"><fmt:formatNumber value="${_bean.loginCnt}" type="number" /></td>
                        <td>${_bean.userGradNm}</td>
                        <td class="lr_none tx_l">${_bean.userTyNm}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager.list}" colspan="8"/>
            </tbody>
        </table>
        <!-- //리스트 -->
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
    </div>
    <div class="tx_r">
            <button type="button" class="s_blue mar_l30 mar_b5" onclick="pwdConfirm(
                                                                                    this
                                                                                    , '회원접속이력 엑셀 출력'
                                                                                    , 'O'
                                                                                    , '/intra/user/webLog/INC_userWebLogListExcel.do'
                                                                                    , '1000'
                                                                                    , '850'
                                                                                    , ''
                                                                                    ,'∬q_searchKey0=${param.q_searchKey0}∬q_searchKey1=${param.q_searchKey1}∬q_searchKey2=${param.q_searchKey2}∬q_searchKey=${param.q_searchKey}∬q_searchVal=${param.q_searchVal}∬q_stDate=${param.q_stDate}∬q_enDate=${param.q_enDate}'
                                                                                    , '리스트'
                                                                                    ,'' );">엑셀출력</button>
    </div>
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>