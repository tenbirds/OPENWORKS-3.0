<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>구매/신청관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">

//<![CDATA[

var ctgryCd1 = "<c:out value='${searchMap.q_ctgryCd1}' />";
var ctgryCd2 = "<c:out value='${searchMap.q_ctgryCd2}' />";
var ctgryCd3 = "<c:out value='${searchMap.q_ctgryCd3}' />";

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
        <c:if test="${not empty searchMap.q_goodsTyCd}">
            jsCtgryList(1,null);
        </c:if> 

        $("#langCodes").click(function(){
            if($(this).is(":checked")){
                $('input[name="q_langCodes"]:checked').each(function (i) {
                    $(this).attr("checked",false);
                });
            } 
        });$('input[name="q_langCodes"]').click(function() {
            if($(this).is(':checked')) {
                $("#langCodes").attr("checked",false);
            }
        });

        // 기간,발표일 달력 생성
        $("span#pruchsPeriod  a  button.gray").click(function(){
            /* 2016.07.26 수정 */
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
            document.dataForm.elements["q_init"].value = "0";
            
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
        
        /* 2016.07.26 수정 */
        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            $("#q_beginDate").val("");
            $("#q_endDate").val("");
        }
        
    });//ready end
    
    /* 2016.07.26 수정 */
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

    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero

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
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_goodsTyCd").val("");
        $("#q_sleMthdCd").val("");
        $("#q_beginDate").val("2000-01-01");
        $("#q_endDate").val("2100-12-31");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");

        $("#q_ctgryCd1").val("");
        $("#q_ctgryCd2").val("");
        $("#q_ctgryCd3").val("");

        $('input[name="q_langCodes"]:checked').each(function (i) {
            $(this).attr("checked",false);
        });
        document.dataForm.elements["q_init"].value = ""; /* 2016.07.26 수정 */
    };

    var jsCtgryList = function(el ,vl){
        var url = "ND_ctgryList.do?";
        url+= "goodsTyCd=" + $("#q_goodsTyCd").val();
        url+= "&ctgryCd=" + vl
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

    var jsGoodsView = function(seq,urlNm,lang){
      	if(lang == "00"){
      	    lang = "korean"
      	}else if(lang == "01"){
      	    lang = "english"
      	}else if(lang == "06"){
      	    lang = "spanish"
      	}      
      
      	var openNewWindow = window.open("about:blank");
      	
    	//이전소스
      	//openNewWindow.location.href = "http://" + lang + ".ceart.kr/" + lang + "/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm; 
      	
      	//{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
        // 변경소스
      	openNewWindow.location.href = "http://<%=GlobalConfig.DOMAIN_SUBNM %>"+"/" + lang + "/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm;   
      	//}}
    };
    
    var jsExcelList = function() {
      	location.href = "ND_purchsListExcel.do?" + $("#dataForm").serialize();
    };
    
    
    var jsOrderView = function(el,no){
      	$(el).colorbox({
          	title : "신청내용정보",
          	href  : "/intra/orderManage/purchs/PD_reqstCnView.do?purchsNo=" + no,
          	width : "500",
          	height: "600",
          	iframe: true
      	});
    };
    
    var jsUserView = function(el,id){
      	$(el).colorbox({
          	title : "사용자 정보",
          	href  : "/intra/orderManage/purchs/PD_userView.do?userId=" + id,
          	width : "500",
          	height: "450",
        	iframe: true
    	});
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
  
  	var jsSourceDwon = function(filePath,fileNm){
    	location.href = "/component/file/ND_directDownload.do?fn=" + fileNm + "&fp=" + filePath;
  	};
  
//]]>
</script>
</head>
<boyd>
    <div id="contents">
        
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
        	<input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>  <!-- 2016.07.26 수정 -->
            <input type="hidden" name="q_seq"     id="q_seq"     value="" />
            <input type="hidden" name="langCodes" id="langCodes" value="" />
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                            <colgroup>
                                <col width="100" />
                                <col width="500" />
                                <col width="100" />
                                <col width="" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>카테고리</th>
                                    <td>
                                        <op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${searchMap.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
                                        <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1"disabled="disabled" onchange="jsCtgryList(2,this.value)" class="over">
                                            <option value="">선택</option>
                                        </select>
                                        <%-- <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" disabled="disabled" onchange="jsCtgryList(3,this.value)" class="over">
                                            <option value="">선택</option>
                                        </select> --%>
                                        <%-- <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" disabled="disabled" class="over">
                                            <option value="">선택</option>
                                        </select> --%>
                                    </td>
                                    <th>판매방식</th>
                                    <td>
                                        <op:code id="q_sleMthdCd" grpCd="1007" defaultValues="${searchMap.q_sleMthdCd}" type="select" defaultLabel="전체"  />
                                    </td>
                                    <%-- 
                                    <th>서비스언어</th>
                                    <td>
                                        <p class="mar_t5" id="langCheck">
                                            <input type="checkbox" name="langCodes" id="langCodes" value=""
                                            <c:if test="${fn:length(searchMap.q_langCodes) == 0}">checked="checked"</c:if> />전체&nbsp;
                                            <c:forEach items="${codeList}" var="_bean" varStatus="status">
                                                <input type="checkbox" name="q_langCodes" id="q_langCode_${_bean.langCode}"
                                                    <c:if test="${fn:contains(searchMap.q_langCodes,_bean.langCode)}">checked="checked"</c:if>
                                                value="${_bean.langCode}"/> ${_bean.langNm}&nbsp;
                                            </c:forEach>
                                        </p>
                                    </td>
                                     --%>
                                </tr>
                                <tr>
                                    <th>주문일</th>
                                    <td colspan="3">
                                        <input class="w120" type="text" name="q_beginDate" id="q_beginDate" title="시작날짜선택" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if>/> ~
                                        <input class="w120" type="text" name="q_endDate" id="q_endDate" title="종료날짜선택" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if>/>
                                        <span class="mar_l10" id="pruchsPeriod">
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
                                          <option value="1001" <c:if test="${searchMap.q_searchKey == '1001'}">selected="selected"</c:if> > 서비스명</option>
                                          <option value="1002" <c:if test="${searchMap.q_searchKey == '1002'}">selected="selected"</c:if>>스토어명</option>
                                          <option value="1003" <c:if test="${searchMap.q_searchKey == '1003'}">selected="selected"</c:if>>이용자ID</option>
                                      </select>
                                        <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />" class="w215" title="검색어를 입력하세요." />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                      <div>
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                      </div>
                        
                </fieldset>
               
            </div>
            
            <op:pagerParam title="구매/신청 목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width=""/>
                <col width="8%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="7%"/>
            </colgroup>
            <thead>
                <th>번호</th>
                <th>구분</th>
                <th>주문번호<br />(언어)</th>
                <th>주문일시</th>
                <th>서비스명</th>
                <th>가격</th>
                <th>판매방식</th>
                <th>이용자</th>
                <th>스토어명<br />(판매자ID)</th>
                <th class="lr_none">완료여부</th>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td>
                          ${baseVo.ctgryClNm}                        
                        </td>
                        <td><c:out value="${baseVo.purchsNo}" /><br />(<c:out value="${baseVo.langNm}" />)</td>
                        <td><c:out value="${baseVo.orderDt}" /></td>
                        
                        <td>
                          <div class="tx_l">
                            <c:if test="${baseVo.goodsRegistSttus == '1006'}">
                              <a href="#" onclick="jsGoodsView('<c:out value="${baseVo.goodsCd}" />','','<c:out value="${baseVo.langCode}" />');"><c:out value="${baseVo.goodsNm}" /></a>
                            </c:if>
                            <c:if test="${baseVo.goodsRegistSttus != '1006'}">
                              <c:out value="${baseVo.goodsNm}" />
                            </c:if>
                          </div>
                        </td>
                        <td>
                          <c:out value="${baseVo.goodsPc}" />
                        </td>
                        <td>
                            <c:if test="${baseVo.sleMthdCd == '1002'}">
                              <a href="#" onclick="jsOrderView(this,'<c:out value="${baseVo.purchsNo}" />');"><button class="blue" type="button">신청내용보기</button></a>
                            </c:if>
                            <c:if test="${baseVo.sleMthdCd == '1001'}">
                              <c:if test="${not empty baseVo.goodsDwldUrl}">
                                <a href="#" onclick="jsSourceDwon('<c:out value="${baseVo.goodsDwldUrl}" />','<c:out value="${baseVo.goodsDwldNm}" />');"><button class="blue" type="button">다운로드</button></a>  
                              </c:if>
                            </c:if>
                        </td>
                        <td>
                          <a href="#" onclick="jsUserView(this,'<c:out value="${baseVo.ordrrId}" />');"><c:out value="${baseVo.ordrrNm}" /><br/>(<c:out value="${baseVo.ordrrId}" />)</a>
                        </td>
                        <td>
                          <a href="#" onclick="jsStoreView(this,'<c:out value="${baseVo.userId}" />');"><c:out value="${baseVo.storeNm}" /><br/>(<c:out value="${baseVo.userId}" />)</a>
                        </td>
                        <td>  <c:out value="${baseVo.orderCnfirmAt}" /></td>
                        
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        
         <div class="tx_r">
            <a href="#" onclick="jsExcelList();"><button class="blue" type="button">엑셀다운로드</button></a>
         </div>
        
    </div>
</boyd>

</html>