<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<op:jsTag type="spi" items="colorbox,datepicker"/>

<script type="text/javascript">

    $().ready(function () {
        <%--  
        $('#q_beginDate').datepicker({
            dateFormat: 'yy-mm-dd',
            showOn : 'button'
        });

        $('#q_endDate').datepicker({
            dateFormat: 'yy-mm-dd',
            showOn : 'button'
        });
        --%>
        
        $("#q_beginDate, #q_endDate").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });

        // 기간,발표일 달력 생성
        $("table.tbl_st4 a.btns").click(function(){
            var sType = $(this).attr('id');
            var date = $('#q_endDate').val().replace(/\/|\-/g, "");
            var yy = parseInt(date.substr(0, 4), 10);
            var mm = parseInt(date.substr(4, 2), 10);
            var dd = parseInt(date.substr(6, 2), 10);
            var endDt = new Date(yy, mm - 1, dd);
            var nowDt = new Date();
            
            switch(sType){
                case '0' :
                    $('#q_beginDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
                    $('#q_endDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
                    break;
                case '7D':
                    endDt.setDate(endDt.getDate() - 7);
                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
                    break;
                case '1M':
                    endDt.setMonth(endDt.getMonth() - 1);                    
                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
                    break;
                case '3M':
                    endDt.setMonth(endDt.getMonth() - 3);
                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
                    break;
                default:
                    break;
            }
        });
       
    });
    

    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero
    
    var jsSearch = function(){
        document.dataForm.action = "BD_eventList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
    
    var jsAllSearch = function(){
        $("#q_searchVal").val("");
        $("#q_eventStatus1").attr("checked", true);
        $("#q_eventStatus2").attr("checked", true);
        $("#q_eventStatus3").attr("checked", true);
        $("#q_dateTy").val("1001");
        $("#q_beginDate").val("2000-01-01");
        $("#q_endDate").val("2100-12-31");
        
        jsSearch();
    };
    
    
    var jsView = function(eventSn,flag){
        //조회수
        $.post("ND_rcntUpdateAction.do",{eventSn:eventSn},
        function(response){
            try {
                if(eval(response)){
                    post_to_url("BD_eventView.do",{"eventSn":eventSn,"flag":flag});
                }else{
                    alert(Message.msg.processFail);
                }
            } catch (e) {
                alert(e);
                return;
            }
        });
    };
    
    //Submit 전속 전송  (주소,파라메터,메소드)
    function post_to_url(path, params, method) {
        method = method || "post"; // Post:Get 전송 기본설정은 Post
        
        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);


        // 예  {"userId":"abcd","mgrId":"abcd"}
        for(var key in params) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);
     
            form.appendChild(hiddenField);
        }
     
        document.body.appendChild(form);
        form.submit();
    }
    
    
    
    //페이지 이동
    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#inquiryForm input[name=q_currPage]").val(p);
        $("#inquiryForm").submit();
    };
 
</script>
</head>
<body>
	<div class="supAdm">
	<form name="dataForm" id="dataForm" method="get" action="BD_eventList.do">
		<input type="hidden" id="q_currPage" name="q_currPage"/>				
		<div class="schOpt on">				
			<table class="tbl_st4" summary="응모이벤트 검색">
				<caption>응모이벤트 검색</caption>
				<colgroup>
					<col width="10%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">이름</th>
					<td>
						<label><input type="text" id="q_searchVal" name="q_searchVal" style="width:65%;" value="${searchMap.q_searchVal}"/></label>
						<label><input type="checkbox" name="q_eventStatus" id="q_eventStatus1" value="1001" <c:if test="${empty searchMap.q_eventStatus || fn:contains(searchMap.q_eventStatus,'1001')}">checked="checked"</c:if> />진행중</label>
					  <label><input type="checkbox" name="q_eventStatus" id="q_eventStatus2" value="1002" <c:if test="${fn:contains(searchMap.q_eventStatus,'1002')}">checked="checked"</c:if> />응모종료</label>
					  <label><input type="checkbox" name="q_eventStatus" id="q_eventStatus3" value="1003" <c:if test="${fn:contains(searchMap.q_eventStatus,'1003')}">checked="checked"</c:if> />결과발표</label>
					</td>
				</tr>
				<tr>
					<th scope="col">기간</th>
					<td class="term">
						<span class="sel_box">
							<select name="q_dateTy" id="q_dateTy" title="기간 선택" style="width: 80px; position: absolute; left: -100000px; height: auto;">
              	<option value="1001" <c:if test="${empty searchMap.q_dateTy ||  searchMap.q_dateTy eq '1001'}">selected="selected"</c:if>>응모기간</option>
                <option value="1002" <c:if test="${searchMap.q_dateTy eq '1002'}">selected="selected"</c:if>>결과발표일</option>
							</select><label for="q_dateTy"></label>
						</span>	
						<label><input type="text" name="q_beginDate" id="q_beginDate" readonly="readonly" title="시작날짜선택" style="width:100px" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> /></label>
						~										
						<label><input type="text" name="q_endDate" id="q_endDate" readonly="readonly" title="종료날짜선택" style="width:100px" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> /></label>
						<span style=" float:right;">
						<a href="javascript:;" id="0" class="btns st3">오늘</a>
						<a href="javascript:;" id="7D" class="btns st3">1주일</a>
						<a href="javascript:;" id="1M" class="btns st3">1개월</a>
						<a href="javascript:;" id="3M" class="btns st3">3개월</a>
						</span>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="btnArea rig mtm20">
			<a href="#" onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a >
			<a href="#" onclick="jsAllSearch();" class="btns st5">전체보기</a>
		</div>
		
		<div class="list_st1">
			<p class="head">
				<span>
                    <op:pagerParam page="param/webListPagerParam.jsp" />
                </span>
               <%--  <span class="sel_box">
					<select>
						<option>20개식</option>
						<option>40개식</option>
						<option>60개식</option>
						<option>100개식</option>					
					</select>
				</span> --%>
			</p>
			
			<!-- list -->
			<table class="tbl_st1" summary="응모이벤트 목록">
				<caption>응모이벤트 목록</caption>
				<colgroup>
					<col width="5%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="25%"/>
					<col width="5%"/>
					<col width="5%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="row">번호</th>
						<th scope="row">이름</th>
						<th scope="row">진행상태</th>
						<th scope="row">응모기간</th>
						<th scope="row">결과 발표일</th>
						<th scope="row">조회수</th>
						<th scope="row">참여자수</th>
					</tr>
				</thead>
				<tbody>
				    <c:set var="index" value="${pager.indexNo}"/>
				    <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
				        <tr>
				            <td>${index-status.index}</td><!-- 번호 -->
				            <td class="title"><a href="#" onclick="jsView(${baseVo.eventSn},'${baseVo.flag}')">${baseVo.eventTitle}</a></td><!-- 이름 -->
				            <td>${baseVo.eventStatus}</td><!-- 진행상태 -->
                                     <td>${baseVo.beginDate} ~ ${baseVo.endDate}</td>
                                     <td>${baseVo.presnatnDate}</td>
                                     <td>${baseVo.eventRdcnt}</td>
                                     <td>${baseVo.commentRcnt}</td>
				        </tr>
				    </c:forEach>
				    <op:no-data obj="${pager}" colspan="7" />
				</tbody>
			</table>
			<!-- //list -->
		</div>

		<!-- paging  -->
		<div class="paging">
			<span><op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" /></span>
		</div> 
		<!--// paging  -->	
		
		
		</form>			
	</div>



</body>