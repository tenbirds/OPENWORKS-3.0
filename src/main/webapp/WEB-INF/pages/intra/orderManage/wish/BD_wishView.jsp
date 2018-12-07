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
<title>이용희망목록검색</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">

//<![CDATA[
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
        document.dataForm.action = "BD_wishView.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_beginDate").val("2000-01-01");
        $("#q_endDate").val("2100-12-31");
        $("#q_searchKey").val("");
        $("#q_searchVal").val("");
        document.dataForm.elements["q_init"].value = ""; /* 2016.07.26 수정 */
    };

    var jswishDetailList = function(el,id,gs){
     
        $(el).colorbox({
            title : "구매희망 목록",
            href  : "/intra/orderManage/wish/PD_wishListPop.do?userId=" + id +"&grpSeq=" + gs,
            width : "700",
            height: "600",
            iframe: true
        });
	};
    
    var jsExcelList = function() {
      	location.href = "ND_purchsListExcel.do?" + $("#dataForm").serialize();
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
    
//]]>
</script>
</head>
<body>
    <div id="contents">
        
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_wishView.do">
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>            
            <input type="hidden" name="q_seq" id="q_seq" value="" />
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                            <colgroup>
                                <col width="100" />
                                <col width="400" />
                                <col width="100" />
                                <col width="" />
                            </colgroup>
                            <tbody>
                           		 <tr>
                                    <th>검색조건</th>
                                    <td colspan="3">
                                    <!-- 검색조건 회원ID/사업명 -->
                                      <select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요"> 
                                          <option value="1001" <c:if test="${searchMap.q_searchKey == '1001'}">selected="selected"</c:if>>회원ID</option>
                                          <option value="1002" <c:if test="${searchMap.q_searchKey == '1002'}">selected="selected"</c:if> >사업명</option>
                                      </select>
                                        <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />" class="w215" title="검색어를 입력하세요." />
                                    </td>
                                </tr>
                                <tr>
                                    <th>적용일</th>
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
                                
                            </tbody>
                        </table>
                        
                      <div>
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                      </div>
                        
                </fieldset>
               
            </div>
            
            <op:pagerParam title="구매희망 목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="25%"/>
                <col width="50%"/>
                <col width="20%"/>
            </colgroup>
            <thead>
                <th>번호</th>
                <th>회원ID</th>
                <th>사업명</th>
                <th>적용일시</th>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td>
                          <a href="#" id="userId" name="userId"onclick="jsUserView(this,'<c:out value="${baseVo.userId}" />');">${baseVo.userId}</a>
                        </td>
                        <td>
                          <div class="tx_l">
                              <a href="#" id="auditlogNm" name="auditlogNm" onclick="jswishDetailList(this,'<c:out value="${baseVo.userId}" />','<c:out value="${baseVo.grpSeq}" />');">${baseVo.auditlogNm}</a>
                          </div>
                        </td>
                        <td>${baseVo.srcDt}</td>
                    </tr>
                    <input type="hidden" name="grpSeq" id="grpSeq" value="" />  
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
    </div>
</body>

</html>