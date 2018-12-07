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
    <title>관심 서비스 | 관심목록 | 마이페이지 | 씨앗 마켓</title>  
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="spi" items="form,validate, colorbox, datepicker" />
        
    <script type="text/javascript">
    $().ready(function() {
    	$("#dataForm").validate({
            rules: {
                q_beginDate : { dateISO: true },
                q_endDate : { dateISO: true }
            },
            messages: { 
                q_beginDate : {dateISO: "시작날짜가 형식에 맞지 않습니다." },
                q_endDate : {dateISO: "종료날짜가 형식에 맞지 않습니다." }
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
        $("table.tbl_st4 a.btns").click(function(){
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
//        document.dataForm.action = "BD_intrstPrdtList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_init"].value = "0";
//        document.dataForm.submit();
        $("#dataForm").attr("action", "BD_intrstPrdtList.do");
        $("#dataForm").submit();
    };

    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "../store/inc/BD_storeView.do";        
        document.dataForm.submit();
    };
    
    var jsClean = function(){
        $("[name=q_searchVal]").val("");                // 서비스명 검색어 입력란 초기화
        $("[name=q_goodsTyCd]").prop('checked', true);  // 서비스구분 체크박스 전체 선택
        $("#q_beginDate").val("");                      // 기간(From) 초기화
        $("#q_endDate").val("");                        // 기간(To) 초기화
/*
        $("#q_goodsTyCd").val("");
*/
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
      
      
    var jsIntrstDelete = function(vl){
        
        if(confirm(Message.msg.watchDelete)){
            $("#goodsCode").val(vl);            
            $("#dataForm").ajaxSubmit({
                url     : "ND_intrstPrdtDelete.do",            
                type    : "POST",
                dataType : "json",
                async    : false,
                success : function(response) {
                    if(response.result){
                        alert(Message.msg.watchDeleteOk);
                        self.location.reload();
                    } else {
                        alert(Message.msg.watchDeleteFail);
                    }
                }
           });
        }
    };
    
    </script>
</head>
<body>
	<div class="supAdm">
	<form id="dataForm" name="dataForm">
        <input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value="${param.q_currPage}" />" />
        <input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value="${param.q_sortName}" />" />
        <input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value="${param.q_sortOrder}" />" />
        <input type="hidden" name="q_init" id="q_init" value="<c:out value="${param.q_init}" />" />
        <input type="hidden" name="goodsCode" id="goodsCode" value="" />				
				
<%--
 		<!-- search -->
		<div class="schOpt on">				
			<table class="tbl_st4">
				<tr>
					<th>서비스명</th>
	                <td>
	                	<input type="text" id="p_name" title="서비스명 입력" name="q_searchVal" style="width:70%;" value="<c:out value="${searchMap.q_searchVal}" />">
	               		
	                	<input type="checkbox" name="q_goodsTyCd" id="solution" value="1002"  class="ml20" <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1002') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
	                	<label for="" class="ml5">소프트웨어</label>
	                	<input type="checkbox" name="q_goodsTyCd" id="consulting" value="1003" class="ml20" <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1003') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
	                	<label for="" class="ml5">IT 서비스</label> 
	                	
		                <label>
		                	<input type="checkbox" name="q_goodsTyCd" id="SaaS" value="1002"  <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1002') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
		                SaaS</label>
		                <label>
		                	<input type="checkbox" name="q_goodsTyCd" id="PaaS" value="1001"  <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1001') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
		                PaaS</label>
		                <label>
		                	<input type="checkbox" name="q_goodsTyCd" id="IaaS" value="1003" <c:if test="${fn:contains(searchMap.q_goodsTyCd, '1003') or fn:length(searchMap.q_goodsTyCd) == 0}">checked="checked"</c:if>>
		                IaaS</label>
	            	</td>
				</tr>
				<tr>
					<th>기간</th>
					<td class="term">
		                  <input type="text" id="q_beginDate" name="q_beginDate" title="검색 시작일 입력" style="width:100px"
		                    <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
		                 ~ 
		                <input type="text" id="q_endDate" name="q_endDate" title="검색 종료일 입력" style="width:100px"
		                <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
						<a href="javascript:;" id="0" class="btns st3">오늘</a>
						<a href="javascript:;" id="7D" class="btns st3">1주일</a>
						<a href="javascript:;" id="1M" class="btns st3">1개월</a>
						<a href="javascript:;" id="3M" class="btns st3">3개월</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="btnArea rig mtm20">
			<a href="javascript:;" onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a >
			<a href="javascript:;" onclick="jsClean(); jsSearch();" class="btns st5">전체보기</a>
		</div>
--%>
		
				
		<div class="list_st1">
			<p class="head">
				<span>총 <c:out value='${pager.totalNum}'/>개</span>
				<%-- <span class="sel_box">
					<select>
						<option>20개식</option>
						<option>40개식</option>
						<option>60개식</option>
						<option>100개식</option>					
					</select>
				</span> --%>
			</p>
			
			<!-- list -->
			<table class="tbl_st1" summary="관심목록">
				<caption>관심목록</caption>
				<colgroup>
					<col width="5%"/>
					<col width="*"/>
					<col width="20%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="row">번호</th>
						<th scope="row">서비스명</th>
						<th scope="row">서비스가격</th>
						<th scope="row">계약건수</th>
						<th scope="row">제공자</th>
						<!-- <th scope="col">관심설정일</th> -->
					</tr>
				</thead>
				<tbody>
					<c:set var="index" value="${pager.indexNo}"/>
       					<c:forEach items="${pager.list}" var="_bean" varStatus="status">
					<tr>
	                    <td>${index - status.index}</td>
	                    <!-- 썸네일이미지 -->
	                    <%-- <td>
	                        <c:if test="${_bean.sellStop == 'Y'}">
	                        <span class="soldout"></span>
	                        </c:if>
	                        <img src="${_bean.imageFile[0].fileUrl}" alt="${_bean.goodsNm}" width="80" height="60"/><!-- 썸네일 이미지 크기 90*90 -->
	                    </td> --%>
	                    <td class="title">
	                        <span>
		                        <c:if test="${_bean.sellStop == 'Y'}">
		                        <em>[판매 중지 서비스]</em>
		                        ${_bean.goodsNm}
		                        </c:if>
		                        <c:if test="${_bean.sellStop != 'Y'}">
		                        <a href="javascript:;" onclick="jsView('${_bean.goodsCode}');" >${_bean.goodsNm}</a>
		                        </c:if>
	                        </span>
	                    </td>
	                    <td class="money"><span>${_bean.goodsPc}</span></td>
	                    <td><span>${_bean.sellCnt}</span>
	                        <c:if test="${not empty _bean.evlScore}">
	                        <span class="grade">(${_bean.evlScore})</span>
	                        </c:if>
						</td>
	                    <td>
	                        <span><a href="javascript:;" title="팝업창 열림" onclick="jsRegistView(this,'<c:out value="${_bean.userId}"></c:out>')">${_bean.storeNm}</a></span>
	                    </td>
	                    <!-- 관심설정일 디자인 누락 확인요망 2015.12.14 -->
	                    <%-- <td class="date">
	                        <span>${_bean.intrstSetupDt}</span>
	                        <span class="btn_light_gray02">
	                            <a href="javascript:;" title="팝업창 열림" onclick="jsIntrstDelete('${_bean.goodsCode}')">설정 해제</a>
	                        </span>
	                    </td> --%>
	                </tr>
					</c:forEach>
					<op:no-data obj="${pager.list}" colspan="5" msg="관심 서비스가 없습니다."/>
				</tbody>
			</table>
			<!-- //list -->
		</div>
	
				
		<!-- paging  -->
		<div class="paging">
			<span><op:pager pager="${pager}" page="pager/webPager.jsp" /></span>
		</div> 
		<!--// paging  -->
		</form>		
	</div>
</body>
</html>