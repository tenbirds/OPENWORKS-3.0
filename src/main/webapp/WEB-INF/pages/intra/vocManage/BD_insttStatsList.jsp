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
<title>VOC통계(VOC 기관별)</title>
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
            jsSearch();
            
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
    
    var jsSearch = function(){
        document.dataForm.action = "BD_insttStatsList.do";
        //document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
        $("#dataForm").submit();
    };
    
    var jsClean = function(){
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
        document.dataForm.elements["q_init"].value = ""; /* 2016.07.26 수정 */
    };
    var jsExcelList = function() {
      	location.href = "BD_statsExcel.do?" + $("#dataForm").serialize();
    }
//]]>
</script>
</head>
<body>
    <div id="contents">
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_insttStatsList.do">
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>
           <!-- <div class="search"> -->
                <!-- <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend> -->
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                    	<colgroup>
                        	<col width="100" />
                            <col width="400" />
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                       		<tr>
                                <th>조회기간</th>
                                <td colspan="3">
                                	<input class="w120" type="text" name="q_beginDate" id="q_beginDate" title="시작날짜선택" value="${searchMap.q_beginDate}"/> ~
                                    <input class="w120" type="text" name="q_endDate" id="q_endDate" title="종료날짜선택"value="${searchMap.q_endDate}"/>
                                    <span class="mar_l10" id="pruchsPeriod">
                                    	<a href="javascript:;"><button type="button" id="0"   class="gray">당일</button></a>
                                     	<a href="javascript:;"><button type="button" id="7D"   class="gray">7일</button></a>
                                     	<a href="javascript:;"><button type="button" id="1M"   class="gray">1개월</button></a>
                                     	<!-- <a href="javascript:;"><button type="button" id="3M"   class="gray">3개월</button></a> -->
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </br>
                     <label style="color: red;">※ 접수일자 기준(조회시작일 18시 ~ 조회종료일 18시까지</label>
                     </br>   
					<div style="text-align: center;">
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">조회</button>&nbsp;&nbsp;
                        <!-- <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button> -->
                    </div>
                <!-- </fieldset> -->
               
            <!-- </div> -->
            <%-- <h2 class="float_l"><span class="tx_red">(기준 : ${registBeginDate} ~ ${registEndDate} )</span></h2> --%>
    		<br/> 
	        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
	            <caption class="hidden"> 목록 </caption>
	            <colgroup>
	                <col width="10%"/>
	                <col width="10%"/>
	                <col width="10%"/>
	                <col width="10%"/>
	                <col width="10%"/>
	                <col width="10%"/>
	                <col width="10%"/>
	            </colgroup>
	            <thead>
	            	<tr>
	               		<th rowspan="2">회원구분</th>
		                <th rowspan="2">공공기관</th>
		                <th rowspan="2">중앙행정기관</th>
		                <th rowspan="2">지자체</th>
		                <th rowspan="2">제공기업</th>
		                <th rowspan="2">기타</th>
		                <th rowspan="2">합계</th>
	                </tr>
	            </thead>
	            <tbody id="odd-color">
	                <c:set var="index" value="${pager.indexNo}"/>
	                <op:no-data obj="${pager}" colspan="14" />
	                <tr>
	                	<td>회원</td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                </tr>
	                <tr>
	                	<td>비회원</td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                	<td></td>
	                </tr>
	                <tr>
	                	<th>합계</th>
	                	<th></th>
	                	<th></th>
	                	<th></th>
	                	<th></th>
	                	<th></th>
	                	<th></th>
	                </tr>
	            </tbody>
	        </table>
	        </br>
	        <div class="tx_r">
    			<a href="#" onclick="jsExcelList();"><button class="blue" type="button">엑셀다운로드</button></a>
    		</div>
        </form>
    </div>
</body>

</html>