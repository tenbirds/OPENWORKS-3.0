<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>서비스 변경승인 (NIA)</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
	var ctgryCd  = "${q_goodsTyCd}";
	var ctgryCd1 = "${param.q_ctgryCd1}";

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
        

        //최초에 값이 존재 하는지 찾는다.. 없으면 패스!!
        <c:if test="${not empty param.q_goodsTyCd}">
            jsCtgryList(1,null);
        </c:if> 


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


    var jsSearch = function(){
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
        $("#dataForm").attr("action", "BD_goodsRequstConfirmList.do");
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");
        $("#q_goodsRequstAt").val("");
        
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
	        case 1 : $("#q_ctgryCd1").html("").append(innerHtml).attr("disabled",true);
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
	        default : break;
	    }
	        
	    });

	};	
	    var jsDspy = function(dspyAt) {
	        var url = "ND_requestUpdateAction.do";
	        var goodsCodePk =  $("input[name=goodsCodePk]:checked");
	        var goodsCode =  $("input[name="+goodsCodePk.val()+"-goodsCode]");
	        var exmntConfmHistSn =  $("input[name="+goodsCodePk.val()+"-exmntConfmHistSn]");
	        var requstSe =  $("input[name="+goodsCodePk.val()+"-requstSe]"); 
	       
	        if(goodsCodePk.length == 0){
	            jsWarningBox("대상 항목을 1개 이상 선택하세요.");
	            return false;
	        }else{
	            var ActvtyMsg =  $("#"+goodsCodePk.val()+"-requstSeNm").text();
		        var goodsNm =  $("#"+goodsCodePk.val()+"-goodsNm").text();
		        
	            if(confirm("선택한 " + goodsNm + " 항목을 " + ActvtyMsg + "로 승인 하시겠습니까?")){
	                jQuery.ajaxSettings.traditional = true;
	                
	                $.ajax({
	                    url     : "ND_requestUpdateAction.do",
	                    type    : "POST",
	                    data : { goodsCode : goodsCode.val(), exmntConfmHistSn : exmntConfmHistSn.val() , requstSe : requstSe.val()},
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
          
            <c:if test="${param.q_goodsRequstAt == null}">
           	 jsSelected("q_goodsRequstAt", "N");
           	</c:if>
           	
           	<c:if test="${param.q_goodsRequstAt != null}">
            jsSelected("q_goodsRequstAt", "${param.q_goodsRequstAt}");
           	</c:if>
        });
        //]]>
    </script>
</head>
<body>
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_goodsRequstConfirmList.do">
          <input type="hidden" name="q_init" 	  id="q_init" 	 value="${param.q_init}"/>
          <input type="hidden" name="langCodes" id="langCodes" value="" />
            <div class="search">
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
                                    <c:if test="${q_goodsTyCd != ''}">
                                    <op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                    </c:if>
                                   <c:if test="${q_goodsTyCd == ''}">
                                    <op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                    </c:if>
                                   <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" disabled="disabled" onchange="jsCtgryList(2,this.value)">
                                        <option value="">선택</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                            	 <th>승인유형</th>
                                <td colspan="3">
                                    <select  id="q_goodsRequstAt" name="q_goodsRequstAt">
                                    	<option value="M">검토</option>
                                    	<option value="Y">승인</option>
                                    </select>
                                </td> 
                            </tr>
                            <tr>
                                <th>신청일</th>
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
                                <th>상세검색</th>
                                <td colspan="3">
                                    <select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요"> 
                                        <option value="1001">서비스명</option>
                                        <option value="1003">신청자ID</option>
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
		
        <op:pagerParam title="서비스변경 목록" />
    	</form> 
        <!-- //검색 -->
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="3%"/>
                <col width="5%"/>
                <col width="95px"/>
                <col width=""/>
                <col width="55px"/>
                <col width="100px"/>
                <col width="50px"/>
                 <col width="50px"/>
                 <col width="115px"/>
                <col width="115px"/>
            </colgroup>
            <thead>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>서비스코드</th>
                    <th>서비스명</th>
                    <th>변경</th>
                    <th>변경내용</th>
                   
                    <th>전시전환 예정일</th>
                    <th>상태</th>
                     <th>신청일(신청자)</th>
                    <th>검토일(검토자)</br>승인일(승인자)</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                      <td> <c:if test="${baseVo.requstProcessAt eq 'M'}"> 
                    	  <input type="radio" name="goodsCodePk" value="${baseVo.goodsCode}${baseVo.exmntConfmHistSn}"/>
                    	  <input type="hidden"  name="${baseVo.goodsCode}${baseVo.exmntConfmHistSn}-goodsCode"  value="${baseVo.goodsCode}"/>
                    	  <input type="hidden"  name="${baseVo.goodsCode}${baseVo.exmntConfmHistSn}-exmntConfmHistSn"  value="${baseVo.exmntConfmHistSn}"/>
                    	  <input type="hidden"  name="${baseVo.goodsCode}${baseVo.exmntConfmHistSn}-requstSe"  value="${baseVo.requstSe}"/>
                    	  </c:if> 
                        </td>
                        <td>${index-status.index}</td>
                        <td>${baseVo.goodsCode}</td>
                        <td id="${baseVo.goodsCode}${baseVo.exmntConfmHistSn}-goodsNm" class="tx_l">${baseVo.goodsNm}</td>
                        <td id="${baseVo.goodsCode}${baseVo.exmntConfmHistSn}-requstSeNm">${baseVo.requstSeNm}<c:if test="${baseVo.exmntConfmCd eq 1007 and baseVo.goodsChngSeq> 0}">기본정보</c:if></td>
                        <td class="tx_l">${baseVo.requstResnCn}
                        <c:if test="${baseVo.goodsChngSeq > 0}" >
							<a href="/component/file/ND_fileDownload.do?id=${baseVo.goodsFile[0].fileId}" class="downLoad">사유서파일</a>
							</c:if>
                        </td>
                        <td>${baseVo.dspyCnvrsPrearngeDt}</td>
                        <td><c:if test="${baseVo.requstProcessAt eq 'N'}">요청</c:if>
                         	 <c:if test="${baseVo.requstProcessAt eq 'M'}">검토</c:if>
                         	 <c:if test="${baseVo.requstProcessAt eq 'Y'}">승인</c:if>
                         	 <c:if test="${baseVo.exmntConfmCd eq 1007 and baseVo.goodsChngSeq> 0}">승인</c:if>
                         </td>
                        <td class="tx_l">${baseVo.registDt}(${baseVo.registId})</td> 
                        <td class="tx_l">
                        <c:if test="${baseVo.exmntDt != null}">검토:${baseVo.exmntDt}(${baseVo.exmntId})<br/></c:if>
                        <c:if test="${baseVo.requstProcessAt eq 'Y' or (baseVo.exmntConfmCd eq 1007  and baseVo.goodsChngSeq> 0) }">승인:${baseVo.exmntConfmDt}(${baseVo.mngrId})</c:if>
                        </td>
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
	        <div class="float_r">
	            <!-- <a href="javascript:;" onclick="jsDspy(1004);"><button class="w_blue" type="button">검토반료</button></a> -->
	            <a href="javascript:;" onclick="jsDspy(1004);"><button class="w_blue" type="button">승인</button></a>
	        </div>
        </div>
        <!--  //버튼 -->
         
    </div>
    <!-- //컨텐츠영역 -->    
</body>
</html>