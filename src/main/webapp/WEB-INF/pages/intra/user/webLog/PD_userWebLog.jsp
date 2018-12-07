<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
    <title>접속이력</title>

	<op:jsTag type="spi" items="ui, highlight,validate,colorbox,extjs4"/>
	<op:jsTag type="openworks" items="ui"/>
	<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
    <script type="text/javascript">

    $().ready(function() {
        $("#${param.selectDateColor}").css("background-color","black");

    	if($("#dateSetYn").val() == "Y"){
	    	$("#dateSet").show();
    	}else{
	    	$("#dateSet").hide();
    	}

        $("div.blue_box_tx  a  button.gray").click(function() {
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
                $('#q_stDate').val(null);
                $('#q_enDate').val(null);
            }
        });

//         $('.gray').click(function() {
//             if ($('#q_stDate').val() > $('#q_enDate').val()) {
//                 jsWarningBox('시작일이 종료일보다 늦습니다.');
//                 return;
//             }
//             $('#dataForm').submit();
//         });

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

//         $("#chart01").html('');
//         Ext.create('widget.panel', {
//             height: 200,
//             width : 350,
//             title: '접속아이피현황',
//             renderTo: 'chart01',
//             layout: 'fit',
//             items: chart01
//         });

    });

    // 아이디 및 이름 검색
    var jsSearchAction = function() {

        $("#dataForm").validate({
            rules : {
                q_stDate : {date:true},
                q_enDate : {date:true}
            }
        });

        if ($('#q_stDate').val() > $('#q_enDate').val()) {
            jsWarningBox('시작일이 종료일보다 늦습니다.');
            return;
        }
        $('#q_currPage').val("1");
        $('#dataForm').action = "BD_userWebLog.do";
        $('#dataForm').submit();
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

    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
		$('#dataForm input[name=q_currPage]').val(p);
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

    Ext.require(['Ext.chart.*',
                 'Ext.data.*',
                 'Ext.layout.container.Fit']);

    var getData = function (idx) {
        var fileds = ['name', 'data'];
        var data = [new Array()];
        <c:forEach items="${dataList2}" var="data0">
        data[0].push({
            name : "<c:out value = "${data0.loginIp}"/>",
            data : <c:out value = "${data0.ipCount}"/>
        });
        </c:forEach>
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
                  this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / <c:out value = "${dataList1.loginIpTotal}"/> * 100) + '%');
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
                        'rgb(177, 177, 177)']
        }]
    });

	</script>
</head>

<body>
	<!-- 컨텐츠영역 -->
	<form id="dataForm" name="dataForm">
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	<input type="hidden" id="userNm" name="userNm" value="${param.userNm}"/>
	<input type="hidden" id="loginDtm" name="loginDtm" value="${param.loginDtm}"/>
	<input type="hidden" id="dateSetYn" name="dateSetYn" value="${param.dateSetYn}"/>
	<input type="hidden" id="selectDateColor" name="selectDateColor" value="${param.selectDateColor}"/>

	<div id="popup">
		<div>
		<p class="mar_b30">[<span class="tx_red">최근 접속일자</span>는
			<span class="tx_red">${param.loginDtm} (IP : ${loginIp})</span> 입니다.]
		</p>

		<!-- 그래프부분 -->
<%--
		<div class="mar_b30 w_100p">
			<div id='chart01' class='graph_half float_l'>
            </div>
		</div>
 --%>
		</div>
		<br/>
		<!-- 검색일자-->
		<div class="blue_box_tx tx_c" style="padding:10px 0 5px 0;">
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
			<span class="vt"><button type="button" onclick="jsSearchAction();" class="gray mar_l5 mar_b10">검색</button></span>
			<br/>
			<div  id="dateSet" >
				<fieldset >
					<legend>일시를 지정하여 검색하세요.</legend>
					<label><span class="tx_b">접속일자</span></label>
					<input type="text" name="q_stDate" id="q_stDate" onkeydown="dateAuto(this);" class="w120" title="올바른 날짜를 입력하세요." value="${param.q_stDate}" maxlength="10"/> ~
					<input type="text" name="q_enDate" id="q_enDate" onkeydown="dateAuto(this);" class="w120" title="올바른 날짜를 입력하세요." value="${param.q_enDate}" maxlength="10"/>

				</fieldset>
			</div>
		</div>

		<!-- //검색일자-->
		<op:pagerParam title="접속이력 목록" />
		<br/>

		<!-- 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
			<caption class="hidden"> 목록 </caption>
			<colgroup>
				<col width="30%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width=""/>
			</colgroup>
			<thead>
				<tr>
					<th>접속일시</th>
					<th>인증방식</th>
					<th>결과</th>
					<th class="lr_none">아이피</th>
				</tr>
			</thead>
			<tbody id="odd-color">
				<c:set var="index" value="${pager.indexNo}"/>
				<c:forEach items="${pager.list}" var="_bean" varStatus="status">
					<tr>
						<td>${_bean.loginDt}</td>
						<td>${_bean.regType}</td>
						<td>
							<c:if test="${_bean.loginResult eq '1'}">성공</c:if>
							<c:if test="${_bean.loginResult eq '0'}"><span class="tx_red" title=" 아이디비번오류"  style="cursor:pointer;"><b>아이디비번오류</b></span></c:if>
						</td>
						<td class="lr_none">${_bean.loginIp}</td>
					</tr>
				</c:forEach>
				<op:no-data obj="${pager.list}" colspan="5"/>
			</tbody>
		</table>
		<!-- //리스트 -->
		<br/>

		<!-- 페이징 -->
		<op:pager pager="${pager}" />
		<!-- //페이징 -->
        <div>
            <button type="button" class="s_blue mar_l30 mar_b5" style="float: right;" onclick="pwdConfirm(
                                                                                                           this
                                                                                                           , '개별회원이력 엑셀 출력'
                                                                                                           , 'O'
                                                                                                           , '/intra/user/webLog/INC_userWebLogExcel.do'
                                                                                                           , '700'
                                                                                                           , '750'
                                                                                                           , ''
                                                                                                           , ''
                                                                                                           , '∬q_stDate=${param.q_stDate}∬q_enDate=${param.q_enDate}∬userId=${param.userId}'
                                                                                                           , '리스트' );">엑셀출력</button>
        </div>
	</div>
	</form>
	<!-- //컨텐츠영역 -->
</body>
</html>