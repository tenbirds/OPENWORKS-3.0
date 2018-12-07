<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>전체서비스 목록/관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
    var ctgryCd1 = "${param.q_ctgryCd1}";
    var ctgryCd2 = "${param.q_ctgryCd2}";
    var ctgryCd3 = "${param.q_ctgryCd3}";

    $().ready(function () {
        $("#dataForm").validate({
            rules: {
                q_beginDate : { dateISO: true, date: true },
                q_endDate : { dateISO: true, date: true },
                q_beginDate2 : { dateISO: true, date: true },
                q_endDate2 : { dateISO: true, date: true }
            },
            messages: {
                q_beginDate : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                  date: "시작날짜가 형식에 맞지 않습니다."},
                q_endDate   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
                                  date: "종료날짜가 형식에 맞지 않습니다."},
                q_beginDate2 : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                   date: "시작날짜가 형식에 맞지 않습니다."},
                q_endDate2   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
                                   date: "종료날짜가 형식에 맞지 않습니다."}
            },
            submitHandler : function(form) {
//                 if (! $("#q_beginDate").dateValidator()) {
//                     alert("시작날짜가 형식에 맞지 않습니다.");
//                     return false;
//                 }
//                 if (! $("#q_endDate").dateValidator()) {
//                     alert("시작날짜가 형식에 맞지 않습니다.");
//                     return false;
//                 }

                if ($("#q_beginDate").val()=='' &&  $("#q_endDate").val()!='') {
                    alert("시작날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate").val()!='' &&  $("#q_endDate").val()=='') {
                    alert("종료날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate").val() > $("#q_endDate").val()) {
                    alert("종료날짜가 시작날짜 보다 작습니다.");
                    return false;
                }

                if ($("#q_beginDate2").val()=='' &&  $("#q_endDate2").val()!='') {
                    alert("시작날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate2").val()!='' &&  $("#q_endDate2").val()=='') {
                    alert("종료날짜가 존재하지 않습니다.");
                    return false;
                }
                if ($("#q_beginDate2").val() > $("#q_endDate2").val()) {
                    alert("종료날짜가 시작날짜 보다 작습니다.");
                    return false;
                }
                form.submit();
            }
        });

//          $( "#q_endDate" ).rules( "add", {
//              dateISO: true,

//             messages: {
//                 dateISO: "날짜equired input"
//             }
//           });

        //최초에 값이 존재 하는지 찾는다.. 없으면 패스!!
        <c:if test="${not empty param.q_goodsTyCd}">
            jsCtgryList(1,null);
        </c:if>

        $("input[name=chk-all]").click(function() {
            var isChecked = this.checked;
            $("input[name=goodsCodes]").each(function() {
                this.checked = isChecked;
            });
        });

        $("#langCodes").click(function(){
            if($(this).is(":checked")){
                $('input[name="q_langCodes"]:checked').each(function (i) {
                    $(this).attr("checked",false);
                });
            }
        });
        $('input[name="q_langCodes"]').click(function(){
            $("#langCodes").attr("checked",false);
        });

        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            // 기간,발표일 달력 생성
            /* 2016.07.26 수정 */
            /* if($('#q_beginDate').val() == ''){
                var beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth() - 1);
                $('#q_beginDate').val(getDateStr(getCalDate(new Date(),-1,0)));
            }
            if($('#q_endDate').val() == ''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
            if($('#q_beginDate2').val() == ''){
                var beginDate2 = new Date();
                beginDate2.setMonth(beginDate2.getMonth() - 1);
                $('#q_beginDate2').val(getDateStr(getCalDate(new Date(),-1,0)));
            }
            if($('#q_endDate2').val() == ''){
                $('#q_endDate2').val(getDateStr(new Date()));
            } */
        }

        $("span#registPeriod  a  button.gray").click(function(){
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;

            if ($("#q_endDate").val()==''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
            if (! $("#q_endDate").dateValidator()) {
                alert("종료날짜가 형식에 맞지 않습니다.");
                return false;
            }
            switch(sType){
                case '0' :
                    q_beginDate = new Date();
                    $('#q_beginDate').val(getDateStr(q_beginDate));
                    q_endDate = new Date();
                    $('#q_endDate').val(getDateStr(q_endDate));
                    break;
                case '7D':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),0,-7);
                    break;
                case '1M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-1,0);
                    break;
                case '3M':
                    q_beginDate = getCalDate(new Date($("#q_endDate").val()),-3,0);
                    break;
                default:
                    $("#q_beginDate").val("2000-01-01");
                    $("#q_endDate").val("2100-12-31");
                    break;
            }
            $('#q_beginDate').val(getDateStr(q_beginDate));

//             if($('#q_endDate').val() != "21001231"){
//                 $('#q_endDate').val(getDateStr(q_endDate));
//             }
//             if($('#q_beginDate').val() == ''){
//                 $('#q_beginDate').val(getDateStr(new Date()));
//             }
        });

        $("span#registPeriod2  a  button.gray").click(function(){
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;

            if ($("#q_endDate2").val()==''){
                $('#q_endDate2').val(getDateStr(new Date()));
            }
            if (! $("#q_endDate2").dateValidator()) {
                alert("종료날짜가 형식에 맞지 않습니다.");
                return false;
            }
            switch(sType){
                case '02' :
                    q_beginDate = new Date();
                    $('#q_beginDate2').val(getDateStr(q_beginDate));
                    q_endDate = new Date();
                    $('#q_endDate2').val(getDateStr(q_endDate));
                    break;
                case '7D2':
                    q_beginDate = getCalDate(new Date($("#q_endDate2").val()),0,-7);
                    break;
                case '1M2':
                    q_beginDate = getCalDate(new Date($("#q_endDate2").val()),-1,0);
                    break;
                case '3M2':
                    q_beginDate = getCalDate(new Date($("#q_endDate2").val()),-3,0);
                    break;
                default:
                    $("#q_beginDate").val("2000-01-01");
                    $("#q_endDate").val("2100-12-31");
                    break;
            }
            $('#q_beginDate2').val(getDateStr(q_beginDate));

//             if($('#q_endDate').val() != "21001231"){
//                 $('#q_endDate').val(getDateStr(q_endDate));
//             }
//             if($('#q_beginDate').val() == ''){
//                 $('#q_beginDate').val(getDateStr(new Date()));
//             }
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate, #q_beginDate2').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDate, #q_endDate2').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

        $("#q_beginDate, #q_beginDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
        $("#q_endDate, #q_endDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
    });//ready end
	
    /*  기능별 스크립트 정의 */

    var getCalDate = function(date, months, days){
        var newDate = date;
        if(typeof(date.getDate) != 'function'){
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;

    };

    var getDateStr = function(date){
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl){
        return parseInt(vl, 10) > 9 ? vl : '0' + vl;
    };

    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };

    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "/intra/store/goods/BD_goodsDetail.do";
        document.dataForm.submit();
    };

    var jsSearch = function(){
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
        //$("#dataForm").attr("action", "PD_servicePop.do");
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
        $("#q_beginDate2").val("");
        $("#q_endDate2").val("");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");
        /* 20161202 나라장터 등록여부 검색조건추가 전체(ALL),등록(Y),미등록(N) */       
        $("#q_gtwobChk").val("");

        $("#q_ctgryCd1").val("");
        $("#q_ctgryCd2").val("");
        $("#q_ctgryCd3").val("");

        $('input[name="q_langCodes"]:checked').each(function (i) {
            $(this).attr("checked",false);
        });

        $("#q_goodsRegistSttus").val("");
        $("#q_crtfc").val("");
    };

    var jsCtgryList = function(el ,vl){
        var url = "/intra/store/goods/ND_ctgryList.do?";
        url+= "goodsTyCd=" + $("#q_goodsTyCd").val();
        url+= "&ctgryCd=" + vl;
        url+= "&ctgryDp=" + el;

        //선택값초기화
        var innerHtml = '<option value="">선택</option>';
        switch(el){
            case 1 : $("#q_ctgryCd1,#q_ctgryCd2,#q_ctgryCd3").html("").append(innerHtml).attr("disabled",true);
            case 2 : $("#q_ctgryCd2,#q_ctgryCd3").html("").append(innerHtml).attr("disabled",true);
            default : break;
        }

        if(vl == ""){return;}


        $.post(url ,
        function(response){
            if(response.length > 0){
                var innerHtml2 = '';
                $("#q_ctgryCd"+el).attr("disabled",false);
                for (var i = 0; i < response.length; i++) {
                    innerHtml2 += '<option value="'+response[i].ctgryCd+'">'+response[i].ctgryNm+'</option>';
                }
                $("#q_ctgryCd"+el).append(innerHtml2);
            }

            switch(el){
            case 1 :
                if($("#q_ctgryCd1 option").length > 1){
                    $("#q_ctgryCd1").attr("disabled",false).val(ctgryCd1).attr("selected", "selected").trigger("change"); ctgryCd1 = "";
                }
            case 2 :
                if($("#q_ctgryCd2 option").length > 1){
                    $("#q_ctgryCd2").attr("disabled",false).val(ctgryCd2).attr("selected", "selected").trigger("change"); ctgryCd2 = "";
                }
            case 3 :
                if($("#q_ctgryCd3 option").length > 1){
                    $("#q_ctgryCd3").attr("disabled",false).val(ctgryCd3).attr("selected", "selected"); ctgryCd3 = "";
                }
            default : break;
        }

        });
    };
    
    var jsDspy = function(el,dspyAt) {
        
        var goodsStatuss = new Array();
        var flg = 0 ;
        var ActvtyMsg;
        var Hpx = "150";
        $("input[name=goodsCodes]:checked").each(function (i) {
            goodsStatuss[i] = $("#goodsStatuss" + this.value).val();
            if(dspyAt == $("#goodsStatuss" + this.value).val() ){
                flg ++;
                return;
            }   
     	 });
        
        $(".float_l a").removeClass("cboxElement");
        if(goodsStatuss.length == 0){
            jsWarningBox("대상 항목을 1개 이상 선택하세요.");
            return false;
        }
        
        if( flg > 0){
            if (dspyAt==1006)
                ActvtyMsg = "전시";
            else  if (dspyAt==1007)
                ActvtyMsg = "비전시";
            
            jsWarningBox(ActvtyMsg +" 처리될 항목을 선택 했습니다.");
            return false;
        }else {
           if (dspyAt==1007)
            Hpx = "350";
         
	        $(el).colorbox({
	          	title : "정보변경",
	          	href  : "PD_svcChangeRequstPop.do?goodsRegistSttus="+dspyAt,
	          	width : "500",
	          	height:  Hpx,
	        	iframe: true
	    	});	
	       
        }
   };


     var jsStoreView = function(el,id){
         $(el).colorbox({
             title : "판매자 정보",
             href  : "/intra/orderManage/purchs/PD_storeView.do?userId=" + id,
             width : "700",
             height: "600",
             iframe: true
         });
      };

    var jsExcelList = function() {
        $("#q_excel").val("1");
        location.href = "INC_goodsExcel.do?" + $("#dataForm").serialize();
        $("#q_excel").val("");
    };
    
    
	var jsSelectList = function (el) {
		var codeitems = []; 
		var nameitems = [];
		var kinditems = [];
		var checkCnt = 0;
		var sessionid = '${sessionScope.tempId}';
		$('input:checkbox[name=goodsCodes]:checked').each(function () {
			var itemArry = $(this).val().split("|");
			var itemStr = itemArry[1].replace(',', '~');
			itemStr = itemStr.replace(', ', '~');
			
			codeitems.push(itemArry[0]);
			nameitems.push(itemStr);
			kinditems.push(itemArry[2]);
		});
		checkCnt = codeitems.length;
		if (checkCnt == 0 ) {
			alert('비교하실 서비스는 적어도 1개 이상 선택 하셔야 합니다.');
			return false;
		}
		$('input:checkbox[name=goodsCodes]:checked').attr("checked", false);
		//$("#goodsNm", opener.document).val(nameitems);
		
		var htmlVal = "";
		var nameitemsStr = "";
		for (var i = 0; i < nameitems.length; i++) {
			htmlVal = "";
			nameitemsStr = nameitems[i].replace(',', '~');
			nameitemsStr = nameitemsStr.replace(', ', '~');
			htmlVal="<tr id='goodsCd_"+codeitems[i]+"'><td>"+nameitems[i]+"<input type='button' id='goodsCd_"+codeitems[i]+"' value='X' onclick='jsCategoryDelete(this);'/></td></tr>";
			parent.$('table#goodsCtgry').append(htmlVal);
		}
		
		var goodsCode 	= $("#goodsCode", parent.document).val();
		var goodsNm 	  = $("#goodsNm", parent.document).val();
		var goodsKndCd 	= $("#goodsKndCd", parent.document).val();

		if (goodsCode.length > 0) {
			goodsCode = goodsCode +","+ codeitems;
		}else{
			goodsCode = codeitems;
		}
		
		if (goodsNm.length > 0) {
			goodsNm = goodsNm +","+ nameitems;
		}else{
			goodsNm = nameitems;
		}
		
		if (goodsKndCd.length > 0) {
			goodsKndCd = goodsKndCd +","+ kinditems;
		}else{
			goodsKndCd = kinditems
		}
		
		//goodsNm = goodsNm.replace(",", "^");
		//alert(goodsName);
		
/* 		
		goodsName = goodsNm;
		
*/
		parent.$("#goodsNm").val(goodsNm);
		parent.$("#goodsCode").val(goodsCode);
		parent.$("#goodsKndCd").val(goodsKndCd);
		
		parent.$.fn.colorbox.close();
		
	}
//]]>
</script>

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
    <div id="contents">
        <!-- 검색 -->
        <!-- 20150822 buffer overflow 공격 감지로 get -> post 변경 시작 -->
        <form name="dataForm" id="dataForm" method="post" action="PD_servicePop.do">
        <!-- 20150822 buffer overflow 공격 감지로 get -> post 변경 끝 -->
            <input type="hidden" name="q_excel"   id="q_excel" 	 value="" />
            <input type="hidden" name="q_init" 	  id="q_init" 	 value="${param.q_init}"/>
            <input type="hidden" name="q_currPage" 	  id="q_currPage" 	 value="${param.q_currPage}"/>
            <input type="hidden" name="goodsCode" id="goodsCode" value="" />
            <input type="hidden" name="langCodes" id="langCodes" value="" />
            <input type="hidden" name="q_langCodes" id="q_langCodes" value="00" />
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>카테고리</th>
                                <td>
                                    <op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                    <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" disabled="disabled" onchange="jsCtgryList(2,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                    <%-- <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" disabled="disabled" onchange="jsCtgryList(3,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                    <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" disabled="disabled">
                                        <option value="">선택</option>
                                    </select> --%>
                                </td>
                            </tr>
                            <tr>
                                <th>상세검색</th>
                                <td>
                                    <select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요">
                                        <option value="1001">서비스명</option>
                                        <option value="1002">스토어명</option>
                                        <option value="1003">판매자ID</option>
                                        <option value="1004">서비스코드</option>
                                    </select>
                                    <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;

                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>

                </fieldset>
            </div>

            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <%-- <op:pagerParam title="서비스 전체 목록" /> --%>

        <!-- //검색 -->
        <!-- 리스트 -->
<!--         <form name="dataForm2" id="dataForm2" method="post"> -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="3%"/>
                <col width="7%"/>
                <col width="11%"/>
                <col width=""/>
                <%-- <col width="10%"/> --%>
                <col width="15%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                    <th>구분</th>
                    <th>서비스코드</th>
                    <th>서비스명</th>
                    <!-- <th>전시</th> -->
                    <th>스토어명</th>
                    <th>판매자명</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td>
                        	<c:if test="${baseVo.goodsRegistSttus < 1008}">
                        		<input type="checkbox" 	name="goodsCodes" 	value="${baseVo.goodsCode}|${baseVo.goodsNm}|${baseVo.goodsKndCd}"	/>
                        		<input type="hidden" 		name="goodsNm" 			value="${baseVo.goodsNm}"   />
                        		<input type="hidden" 		name="goodsStatuss" value="${baseVo.goodsRegistSttus}" id="goodsStatuss${baseVo.goodsCode}"/>
                        		<input type="hidden" 		name="goodsKndCd" 	value="${baseVo.goodsKndCd}" id="goodsKndCd"/>
                        	</c:if>
                        </td>
                        <td>
                            <p class="mar_t5">
                                <c:forEach items="${baseVo.goodsType}" var="_goodsType" varStatus="status">
                                    ${_goodsType.GOODSTYNM}
                                    <c:if test="${ not status.last }"><br /></c:if>
                                </c:forEach>
                            </p>
                        </td>
                        <td>
                            ${baseVo.goodsCode}
                        </td>
                        <td>
                            <div class="tx_l">
                               <c:forEach items="${baseVo.markFile}" var="fileVo" varStatus="status1">
                               <c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
                                   <img src="${fileVo2.fileUrl}" class="vm" style="width:33px; height:33px"></img>
                                   <c:if test="${not status2.last}">&nbsp;</c:if>
                               </c:forEach>
                               </c:forEach>
                                <a onclick='jsView("${baseVo.goodsCode}");' href="javascript:;">${baseVo.goodsNm}</a>
                            </div>
                        </td>
                        <%-- <td>${baseVo.goodsRegistSttusNm}</td> --%>
                        <td>${baseVo.langStoreNm}</td>
                        <!-- 2016.11.18 수정 -->
                        <td><a href="javascript:;" onclick="jsStoreView(this,'${baseVo.userId}');">${baseVo.userId}</a></td>
                       <%--  <td>${baseVo.nationGrp }</td> --%>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="12" />
            </tbody>
        </table>

        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

        <!-- 버튼 -->        
        <div>
<!--         
            <div class="float_l">
                <a href="javascript:;" onclick="jsDspy(this,1006);"><button class="w_blue" type="button">선택항목 전시</button></a>
                <a href="javascript:;" onclick="jsDspy(this,1007);"><button class="w_blue" type="button">선택항목 비전시</button></a>
            </div>
 -->            
            <div class="float_r">
                <button class="w_blue" type="button" onclick="jsSelectList(this);">서비스 적용</button>
            </div>
        </div>
        <!--  //버튼 -->
    </form>
    </div>

    <!-- //컨텐츠영역 -->
</body>
</html>