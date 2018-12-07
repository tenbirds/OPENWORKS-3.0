<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>구매내역 | 쇼핑내역 | 마이페이지 | 씨앗 마켓</title>  
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,validate, colorbox, datepicker" />
        
    <script type="text/javascript">
    $().ready(function() {
    	$("#dataForm").validate({
            rules: {
                q_beginDate : { dateISO: true, date: true },
                q_endDate : { dateISO: true, date: true }
            },
            messages: { 
                q_beginDate : {dateISO: "시작날짜가 형식에 맞지 않습니다.",
                                  date: "시작날짜가 형식에 맞지 않습니다."},
                q_endDate : {dateISO: "종료날짜가 형식에 맞지 않습니다.", 
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
        
        // 체크박스 제어
        $("#goodsTyCds").click(function(){
          if($(this).is(":checked")){
              $('input[name="q_goodsTyCds"]:checked').each(function (i) {
                  $(this).attr("checked",false);
              });
          } 
        });$('input[name="q_goodsTyCds"]').click(function() {
            if($(this).is(':checked')) {
                $("#goodsTyCds").attr("checked",false);
            }
        });
        
        if ($('#q_init').val() == '1' || $('#q_init').val()=='') {
            // 기간,발표일 달력 생성
            if($('#q_beginDate').val() == ''){
                var beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth() - 1);
                $('#q_beginDate').val(getDateStr(getCalDate(new Date(),-1,0)));
            }
            if($('#q_endDate').val() == ''){
                $('#q_endDate').val(getDateStr(new Date()));
            }
        }
        
      //기간,발표일 달력 생성
        $("table.tbl_list_input a.b-btn").click(function(){
            var sType = $(this).attr('id');
            var q_beginDate = null;
            var q_endDate = null;
            
            if ($("#q_endDate").val()==''){
                $('#q_endDate').val(getDateStr(new Date()));                     
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
          dateFormat: 'yy-mm-dd',
          showOn : 'button'
        });
        $('#q_endDate').datepicker({
          dateFormat: 'yy-mm-dd',
          showOn : 'button'
        });
        
    }); //ready
    
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
    
    //페이지 이동
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
//        document.dataForm.action = "BD_purchsList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
//        document.dataForm.submit();
        $("#dataForm").attr("action", "BD_purchsList.do");
        $("#dataForm").submit();
    };

    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "../store/inc/BD_storeView.do";        
        document.dataForm.submit();
    };
    
    var jsClean = function(){
        $("#q_goodsTyCd").val("");	        
        $("#q_beginDate").val("");
        $("#q_endDate").val("");
        $("#q_searchVal").val("");	        
    };
    
    var jsRegistView = function(el,id){
        $(el).colorbox({
            title : "회원정보",
            href : "/korean/pt/popup/PD_userView.do?userId=" + id,
            width : "500",
            height: "450",
            iframe: true
        });
    };
      
      
    var jsOrderView = function(el,num,code){
        $(el).colorbox({
            title : "신청내용",
            href : "/korean/pt/popup/PD_purchsView.do?purchsNo="+num+"&goodsCode="+code,
            width : "900",
            height: "600",
            iframe: true
        });
    };
    </script>
</head>
<body>
				
	 <div class="supAdm answAdm">			
    <form id="dataForm" name="dataForm">
        <input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value="${param.q_currPage}" />" />
        <input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value="${param.q_sortName}" />" />
        <input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value="${param.q_sortOrder}" />" />
        <input type="hidden" name="q_init" id="q_init" value="<c:out value="${param.q_init}" />" />
        <input type="hidden" name="goodsCode" id="goodsCode" value="" />
        
        
        <!-- section -->
		<div class="section">
			<div class="tab-search">
				<table class="tbl_list_input">
					<caption>검색</caption>
					<colgroup>
					<col style="width:130px;"/>
					<col style="width:;"/>
					</colgroup>
					<tbody>
						<tr>
							<th>서비스</th>
							<td><input type="text" class="w650"  id="p_name" title="서비스명 입력"  name="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />"/>
								<!-- span class="pad_l"><label for="p_name"></label></span>
				                <input type="checkbox" name="q_goodsTyCd" id="prem" value="1001" <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1001') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
				                <span class="pad_l"><label for="prem">표준프레임워크호환 서비스</label></span>
				                <input type="checkbox" name="q_goodsTyCd" id="solu" value="1002" <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1002') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
				                <span class="pad_l"><label for="solu">솔루션/서비스</label></span -->
							</td>
						</tr>
						<tr>
							<th>기간</th>
							<td>
								 <div class="calendar_input">
					                    <input type="text" class="input" id="q_beginDate" name="q_beginDate" title="검색 시작일 입력" readonly="readonly" style="width:100px;"
					                    <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
					                    <span class="pad_l"><label for="q_beginDate"></label></span>
					            </div>
								<span class="divide"> ~ </span>
				                <div class="calendar_input end">
				                <input type="text" class="input" id="q_endDate" name="q_endDate" title="검색 종료일 입력" readonly="readonly"  style="width:100px;"
				                <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
				                <span class="pad_l"><label for="q_endDate"></label></span>
				                </div>     
								 
								 <a href="javascript:;" id="0"  class="b-btn mr05 type1"><strong><span>오늘</span></strong></a>
								 <a href="javascript:;" id="7D" class="b-btn mr05 type1"><strong><span>1주일</span></strong></a>
								 <a href="javascript:;" id="1M" class="b-btn mr05 type1"><strong><span>1개월</span></strong></a>
								 <a href="javascript:;" id="3M" class="b-btn mr05 type1"><strong><span>3개월</span></strong></a>

							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //section -->
		
		<!-- btn-area -->
		<div class="btn-area mt10 ar">
			<a href="javascript:;" onclick="jsSearch();" class="b-btn search type2"><strong><span class="find">검 색</span></strong></a><a href="javascript:;" onclick="jsClean(); jsSearch();" class="b-btn ml10 type1"><strong><span>전체보기</span></strong></a>
		</div>
		<!-- //btn-area -->
		
		<!-- section -->
		<div class="section">
			<h3 class="stitle"></h3>
			<p class="total-count">총 <strong>${pager.totalNum}</strong>개</p>
			<!-- list -->
			<div class="type-list">
				<table>
					<caption>자주찾는 질문</caption>
					<colgroup>
					<col style="width:100px;"/>
					<col style="width:*;"/>
					<col style="width:100px;"/>
					<col style="width:100px;"/>
					<col style="width:100px;"/>
					<col style="width:120px;"/>
					</colgroup>
					<thead>
						<tr>
							<th>구매문의번호</th>
							<th>서비스명</th>
							<th>단가(\)</th>
							<th>확인 유무<br/>신청내용</th>
							<th>판매자</th>
							<th>구매일</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="index" value="${pager.indexNo}"/>
						<c:forEach items="${pager.list}" var="_bean" varStatus="status">
		                <tr>
		                    <!-- <td>${index - status.index}</td>  //-->
		                    <td>${_bean.purchsNo}</td>
		                    <!-- <td><img src="${_bean.imageFile[0].fileUrl}" alt="${_bean.goodsNm}" width="90" height="68"><!-- 썸네일 이미지 크기 90*90 ></td>  //-->
		                    <td class="title">
		                        <span><a href="javascript:;" onclick="jsView('${_bean.goodsCode}');">${_bean.goodsNm}</a></span>		                        
		                    </td>
		                    <td>${_bean.goodsPc}</td>
		                    <td>
		                        <span class="condi_a">${_bean.orderCnfirmAt}</span><br/>
		                        <span class="btn_light_gray02">
		                            <a href="javascript:;" title="팝업 창 열림" onclick="jsOrderView(this,'${_bean.purchsNo}','${_bean.goodsCode}')">상세보기</a>
		                        </span>
		                    </td>
		                    <td>                                
		                        <span><a href="javascript:;" title="팝업창 열림" onclick="jsRegistView(this,'<c:out value="${_bean.userId}"></c:out>')">${_bean.storeNm}</a></span>
		                        <%-- <c:if test="${ not empty _bean.cmmntyId}">
		                        <span class="btn_light_gray02">
		                            <a href="/community/${_bean.cmmntyId}" target="_blank" title="새창 열림">커뮤니티</a>
		                        </span>
		                        </c:if> --%>
		                    </td>
		                    <td><span>${_bean.orderDt}</span></td>
		                </tr>
	                	</c:forEach>
	                	<op:no-data obj="${pager.list}" colspan="6" msg="구매내역이 없습니다."/>
	                  
					</tbody>
				</table>
			</div>
			<!-- //list -->

			<!-- paging -->
			<op:pager pager="${pager}" page="pager/webPager.jsp"/>
			<!-- //paging -->
			</form>
		</div>
		<!-- //section -->
	
	
</body>
</html>