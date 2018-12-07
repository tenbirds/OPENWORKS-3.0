<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>서비스 모니터링 현황</title>
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
	        
	        startBlink();
	        
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
	        document.dataForm.elements["q_currPage"].value = "1";
	        document.dataForm.elements["q_init"].value = "0";
	        $("#dataForm").submit();
	    };
	
	    var jsClean = function(){
	        $("#q_beginDate").val("");
	        $("#q_endDate").val("");
	        $("#q_searchKey").val("");
	        $("#q_searchVal").val("");
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
	    
        /* 깜박이는 이미지 */
        function doBlink() {
            var blink = $(".blank");
            for (var i=0; i < blink.length; i++)
            	blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
        }
		
        function startBlink(styId) {
		    setInterval("doBlink()",300); //숫자가 낮을수록 속도 빠름
        }
        //]]>
    </script>
</head>
<body>
	<div id="contents">
		<!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_goodsMonitorHistory.do">
        	<input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>
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
                                      	<option value="1001" <c:if test="${searchMap.q_searchKey == '1001'}">selected="selected"</c:if>>서비스명</option>
                                      	<option value="1002" <c:if test="${searchMap.q_searchKey == '1002'}">selected="selected"</c:if>>스토어명</option>
                                      	<option value="1003" <c:if test="${searchMap.q_searchKey == '1003'}">selected="selected"</c:if>>판매자ID</option>
                                      	<option value="1004" <c:if test="${searchMap.q_searchKey == '1004'}">selected="selected"</c:if>>서비스코드</option>
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
        	<op:pagerParam title="서비스 모니터링 목록" />
		
	        <!-- //검색 -->
	        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
	        <!-- 리스트 -->
	        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
	            <caption class="hidden"> 목록 </caption>
	            <colgroup>
	                <col width="5%"/>
	                <col width="40%"/>
	                <col width="10%"/>
	                <col width="10%"/>
	                <col width="20%"/>
	                <col width="*%"/>
	            </colgroup>
	            <thead>
	                <tr>
	                    <th>번호</th>
	                    <th>서비스명</th>
	                    <th>모니터링 일자</th>
	                    <th>모니터링 시각</th>
	                    <th>스토어명<br />(판매자ID)</th>
	                    <th>서비스 상태</th>
	                </tr>
	            </thead>
	            <tbody id="odd-color">
	                <c:set var="index" value="${pager.indexNo}"/>
	                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		                <tr>
		                	<td>${index-status.index}</td>
		                    <td class="tx_l">
		                        ${baseVo.goodsNm}
		                    </td>
		                   	<td class="tx_c">
		                  		${baseVo.goodsMonitorDay}
		                   	</td>
		                   	<td class="tx_c">
		                  		${baseVo.goodsMonitorTime} 시
		                   	</td>
		                   	<td class="tx_c">
		                  		${baseVo.langStoreNm}<br />(<a href="#" id="userId" name="userId" onclick="jsUserView(this,'<c:out value="${baseVo.userId}" />');">${baseVo.userId}</a>)
		                   	</td>
		                    <td class="tx_c">
		                       	<c:if test="${baseVo.goodsServiceState == '200'}">
		                       	<span id="sty${index-status.index}" style="color:green;font-size:22px;">●</span> 정상
		                       	</c:if>
		                       	<c:if test="${baseVo.goodsServiceState != '200'}">
		                       	<span id="sty${index-status.index}" class="blank" style="color:red;font-size:22px;">●</span> 이상
		                       	</c:if>
		                    </td>
		                </tr>
	                </c:forEach>
	                <op:no-data obj="${pager}" colspan="6" />
	            </tbody>
	        </table>
	        <!-- 페이징 -->
	        <op:pager pager="${pager}" />
	        <!-- //페이징 -->
        </form>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>