<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>신규서비스 승인(NIA)</title>
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
                q_endDate : { dateISO: true, date: true }
            },
            messages: { 
                q_beginDate : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                  date: "시작날짜가 형식에 맞지 않습니다."},
                q_endDate   : {dateISO: "종료날짜가 형식에 맞지 않습니다.",
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
	        /* if($('#q_beginDate').val() == ''){
	            var beginDate = new Date();
	            beginDate.setMonth(beginDate.getMonth() - 1);
	            $('#q_beginDate').val(getDateStr(getCalDate(new Date(),-1,0)));
	        }
	        if($('#q_endDate').val() == ''){
	            $('#q_endDate').val(getDateStr(new Date()));
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

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        
        $("#q_beginDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
        $("#q_endDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
    });//ready end
<!-- 기능별 스크립트 정의 -->    

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
        document.dataForm.action = "BD_goodsConfnDetail.do";
        document.dataForm.submit();
    };

    var jsSearch = function(){
//        document.dataForm.action = "BD_goodsConfnList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
//         document.dataForm.submit();
        $("#dataForm").attr("action", "BD_goodsConfnList.do");
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");

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


	    var url = "ND_ctgryList.do?";
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
	    var jsDspy = function(dspyAt) {
	        var goodsCodes = new Array();
	        var goodsStatuss = new  Array();
	        var ActvtyMsg;
	        
	        $("input[name=goodsCodes]:checked").each(function (i) {
	            goodsCodes[i] = $(this).val();
	      	    goodsStatuss[i] = $("#goodsStatuss" + this.value).val();
	        });
	        
	        if(goodsCodes.length == 0){
	            jsWarningBox("대상 항목을 1개 이상 선택하세요.");
	            return false;
	        }else{
	            if (dspyAt==1007) {
	                ActvtyMsg = "승인 완료"
	                    }
	            else
	                {ActvtyMsg = "비활성"};
	            if(confirm("선택한 " + goodsCodes.length + "개의 항목을 " + ActvtyMsg + " 하시겠습니까?")){
	                jQuery.ajaxSettings.traditional = true;
	                
	                $.ajax({
	                    url     : "ND_dspyUpdateAction.do", 
	                    type    : "POST",
	                    data : { goodsCodes : goodsCodes, goodsRegistSttus : dspyAt, goodsStatuss : goodsStatuss },
	                    success : function(result) {
	                        
	                       if(result.result) {
                                jsSuccessBox(Message.msg.processOk);
                                self.location.reload();
                            }  else  {
                                if (result.message != "") {
                                    jsWarningBox(result.message);
                                } else {
                                    jsWarningBox(Message.msg.processFail);
                                }
                            }
	                    }
	               });
	            }
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
        $("#q_excel").val("3");
        location.href = "INC_goodsExcel.do?" + $("#dataForm").serialize();
        $("#q_excel").val("");
    };
    
    var jsContentDiffView = function(el, goodsCode, goodsKndCd, gubun){

       	$(el).colorbox({
           	title : "사용자 정보",
           	//href  : "/intra/orderManage/purchs/PD_tempUserView.do?goodsCode=" + goodsCode,
           	href  : "BD_goodsFormPopUp.do?goodsCode="+goodsCode+"&goodsKndCd="+goodsKndCd+"&gubun="+gubun+"&exmntConfmHistSn=",
           	width : "1250",
           	height: "500",
         	iframe: true
     	});
     };    
        
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
        <form name="dataForm" id="dataForm" method="get" action="BD_goodsConfnList.do">
            <input type="hidden" name="q_excel"   id="q_excel" 	 value="" />
            <input type="hidden" name="q_init" 	  id="q_init" 	 value="${param.q_init}"/>
            <input type="hidden" name="goodsCode" id="goodsCode" value="" />
            <input type="hidden" name="langCodes" id="langCodes" value="" />
           <%--  <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>카테고리</th>
                                <td colspan="3">
                                    <op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                    <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" disabled="disabled" onchange="jsCtgryList(2,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                    <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" disabled="disabled" onchange="jsCtgryList(3,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                    <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" disabled="disabled">
                                        <option value="">선택</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>판매방식</th>
                                <td colspan="3">
                                    <op:code id="q_sleMthdCd" grpCd="1007" defaultValues="${param.q_sleMthdCd}" type="select" defaultLabel="전체"  />
                                </td>
                                
                                <th>서비스언어</th>
                                <td>
                                    <p class="mar_t5" id="langCheck">
                                        <input type="checkbox" name="langCodes" id="langCodes" value=""
                                        <c:if test="${fn:length(param.q_langCodes) == 0}">checked="checked"</c:if> >전체</input>
                                        <c:forEach items="${codeList}" var="_bean" varStatus="status">
                                            <input type="checkbox" name="q_langCodes" id="q_langCode_${status.count}"
                                                <c:if test="${fn:contains(searchMap.q_langCodes,_bean.langCode)}">checked="checked"</c:if>
                                            value="${_bean.langCode}"/> ${_bean.langNm}&nbsp;
                                        </c:forEach>
                                    </p>
                                </td>
                                
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td colspan="3">
                                    <input class="w120" type="text" name="q_beginDate" id="q_beginDate" title="시작날짜선택" maxlength="10"<c:if test="${not empty param.q_beginDate}"> value="${param.q_beginDate}"</c:if>/> ~
                                    <input class="w120" type="text" name="q_endDate" id="q_endDate" title="종료날짜선택" maxlength="10"<c:if test="${not empty param.q_endDate}"> value="${param.q_endDate}"</c:if>/>
                                    <span class="mar_l10" id="registPeriod">
                                        <a href="javascript:;"><button type="button" id="0"   class="gray">오늘</button></a>
                                        <a href="javascript:;"><button type="button" id="7D"   class="gray">일주일</button></a>
                                        <a href="javascript:;"><button type="button" id="1M"   class="gray">1개월</button></a>
                                        <a href="javascript:;"><button type="button" id="3M"   class="gray">3개월</button></a>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>인증 구분</th>
                                <td colspan="3">       
<!--                                     <input type="hidden" name="q_goodsRegistSttus" id="q_goodsRegistSttus" value="1002" /> -->
                                    <op:code id="q_crtfc" grpCd="1011" defaultValues="${param.q_crtfc}" type="select" defaultLabel="전체"  />
                                </td>
                            </tr>                                
                            <tr>
                                <th>상세검색</th>
                                <td colspan="3">                                        
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
            </div> --%>
            
            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="신규서비스 승인목록" />
                
        <!-- //검색 -->
        
        <!-- 리스트 -->
<!--    <form name="dataForm2" id="dataForm2" method="post"> -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="3%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="10%"/>
                <col width=""/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                    <th>번호</th>
                    <th>구분</th>
                    <th>서비스코드</th>
                    <th>서비스명</th>
                    <th>스토어명</th>
                    <th>판매자유형</th>
                    <th>운영팀 검토일</th>
                    <th>승인완료 목표일</th>
                    <th>지연일</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td><input type="checkbox" name="goodsCodes" value="${baseVo.goodsCode}"/>
                        <input type="hidden" name="goodsStatuss" value="${baseVo.goodsRegistSttus}" id="goodsStatuss${baseVo.goodsCode}"/></td>
                        <td>${index-status.index}</td>
                        <td>
                            <p class="mar_t5">
                                <c:forEach items="${baseVo.goodsType}" var="_goodsType" varStatus="status">
                                    ${_goodsType.GOODSTYNM}
                                    <c:if test="${ not status.last }"><br /></c:if>
                                </c:forEach>
                            </p>
                        </td>
                        <td>
                        	<a href="javascript:;" onclick="jsContentDiffView(this,'${baseVo.goodsCode}','${baseVo.goodsKndCd}','N');">${baseVo.goodsCode}</a>

                        </td>
                        <td>
                            <div class="tx_l">
                               <c:forEach items="${baseVo.markFile}" var="fileVo" varStatus="status1">
	                           <c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
	                               <img src="${fileVo2.fileUrl}" class="vm" style="width: 33px; height: 33px;"></img>
	                               <c:if test="${not status2.last}">&nbsp;</c:if>
	                           </c:forEach>
	                           </c:forEach>
                                <a onclick='jsView("${baseVo.goodsCode}");' href="javascript:;">${baseVo.goodsNm} [<a onclick='jsView("${baseVo.goodsCode}");' href="javascript:;">미리보기</a>]
                                </a>
                            </div>
                        </td>
                        <td>
	                        <a href="javascript:;" onclick="jsStoreView(this,'${baseVo.userId}');"><span > ${baseVo.langStoreNm} </span></a>
                        </td>
                        <td>${baseVo.userTyGrp }</td>
                        <td>${baseVo.exmntConfmDt}</td>
                        <td>${baseVo.confmLimitDt}</td>
                        <td><c:if test="${empty baseVo.confmDay || baseVo.confmDay <= 0}">-</c:if><c:if test="${baseVo.confmDay >= 1}">D+${baseVo.confmDay}</c:if></td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
        
        <!-- 버튼 -->
        <div>
	        <div class="float_l">
	             <a href="javascript:;" onclick="jsDspy(1007);"><button class="w_blue" type="button">선택항목 일괄 승인</button></a>
	        </div>
	        <div class="float_r">
	            <a href="javascript:;" onclick="jsExcelList(this);"><button class="w_blue" type="button">엑셀다운로드</button></a>
	        </div>
        </div>
        <!--  //버튼 -->
    </form>
    </div>

    <!-- //컨텐츠영역 -->
</body>
</html>