<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 승인/거절 현황</title>
	<op:jsTag type="spi" items="jqeury,form,validate,colorbox, datepicker" />
	<op:jsTag type="openworks" items="form, validate, ui" />
    <script type="text/javascript">
  	//<![CDATA[
	    $(document).ready(function() {
			
	        //jsSetSearchEnterEvent();
	        
	        $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonText: "날짜선택",
                yearRange: "2010:+1",
                showOptions: { direction: "up"}
            });
	        $('#q_startReqDt').datepicker();
	        $('#q_endReqDt').datepicker();
	        
		    $("#ckMultiBoxAll").click(function() {  
	       		if($(this).is(':checked')) {        
	       			$("input[name=ckMultiBox]").prop("checked", true);   
	       		} else {        
	       			$("input[name=ckMultiBox]").prop("checked", false);    
	       		}
	       	}); 
		    
		    
		      //엑셀다운로드
// 	        $("#butExcel").click(function() {
// 	           // alert("butExcel");
// 	            if ($('#excelFr').length == 0) {
// 	                $('body').append('<iframe id="excelFr" style="display: none;"/>');
// 	            }

// 	            var url = 'INC_approvalExcelList.do';
// 	            $('#excelFr').attr('src',url);
// 	           // $('#dataForm').submit();
// 	        });
   	 	});
	    
     	//날짜 초기화
   		var jsClearRegdt =  function(){
   	  		$("#q_startReqDt").val("");  
   	  		$("#q_endReqDt").val("");  
   		};


    
	   // 페이지 이동
	   var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	   };
	    
	     // 검색 엔터 이벤트
        var jsSetSearchEnterEvent = function() {
            $("#q_searchWord").keydown(function(event){
                if(event.keyCode == 13) {
                    $(this).next().click();
                    return false;
                }
            });
        };
        // 커뮤니티 상태 정보 팝업 view 
        var jsPopupView = function(el, cmmntyId, langCode, userId, cmmntySttusCd) {
            if(cmmntySttusCd == '1002'){
	            $(el).colorbox({
	               	title : "커뮤니티 승인 정보",         
	     			href      : "PD_openInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId,
	     			width : "1200px",
	     	        height : "600px",
	               iframe : true
	           }); 
            }else if(cmmntySttusCd == '1003'){
                $(el).colorbox({
                 	title : "커뮤니티 거절 정보",         
         			href      : "PD_rejectInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId,
	     			width : "1200px",
	     	        height : "600px",
	               iframe : true
	           });   
            }else if(cmmntySttusCd == '1005'){
                $(el).colorbox({
                 	title : "커뮤니티 폐쇄 정보",         
         			href      : "PD_closeInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId,
	     			width : "1200px",
	     	        height : "600px",
	               iframe : true
	           }); 
            }
        };

        // 커뮤니티 회원 정보 팝업 view 
        var jsPopupMemberView = function(el, cmmntyId, langCode, userId) {
	            $(el).colorbox({
	               	title : "커뮤니티 회원 정보",         
	     			href      : "PD_memberShipInfoList.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId+"&q_mberStateTab=1001",
	     			width : "1200px",
	     	        height : "600px",
	               iframe : true
	           }); 
        };
        
        // 커뮤니티 폐쇄  
        var jsPopupClose = function ( cmmntyId, langCode, userId ) {
            $.colorbox({
	                  	title : "커뮤니티 폐쇄하기",         
	        			href      : "PD_approvalRejectClose.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId,
	        			width : "560px",
	        	        height : "430px",
	                  iframe : true
	              }); 
        };
        
        var jsMovePage = function(page) {
            var p = 1;
            if (page == 'page') {
                p = $('input[name=page]').val();
            } else {
                p = page;
            }
            $("#dataForm input[name=q_currPage]").val(p);
            $("#dataForm").submit();
        };    

        
        //통합검색바
        var jsSearchAction = function() {
            if($("#q_startReqDt").val() > $("#q_endReqDt").val() || $("#q_startReqDt").val().replace(/-/gi,"") > $("#q_endReqDt").val().replace(/-/gi,"")){
                alert("기간이 맞지 않습니다.");
                $("#q_startReqDt").focus();
                return false;
            }
//             if ( $("#q_searchKey").val() != "" ) {
//                 if ( $("#q_searchVal").val() == "" ) {
//                     jsWarningBox("검색어를 입력하세요.");
//                     $("#q_searchVal").focus();
//                     return false;
//                 }
//             }else{
//             	if ( $("#entSearch").val() != "") {
//             	    jsWarningBox("검색조건을 선택하세요.");
//             		$("#entSearch").focus();
//             		return false;
//             	}
//             }

            $('#q_currPage').val("1");
         	$('#dataForm').submit();
        };
        
        
        //엑셀다운로드
        var downExcel = function() {
            
            var data = $("#dataForm").serialize();
     		
            if ($('#excelFr').length == 0) {
                $('body').append('<iframe id="excelFr" style="display: none;"/>');
            }
            var url = 'INC_approvalExcelList.do?'+data;
            $('#excelFr').attr('src',url);
        };
        

	//]]>
	 </script>
</head>
<body>
	<!-- 컨텐츠영역 -->
	<div id="contents">
	<form name="dataForm" id="dataForm" method="post" action="BD_approvalRejectIndex.do">
	<input type="hidden" id="hidPopup" name="hidPopup" value=""/>
	<input type="hidden" name="multiCheck" id="multiCheck"  value="" />
		            <!-- 검색 -->
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        	<colgroup>
			                    <col width="10%" />
			                    <col width="15%" />
			                    <col width="7%" />
			                    <col width="13%" />
			                    <col width="10%" />
			                    <col width="*%" />
			                </colgroup>
			                <tbody>
	                        	<tr>
	                        		<th>지원언어</th>
	                        		<td>
				                        <select id="q_langCode" name="q_langCode" title="분류를 선택해주세요" class="over">
											<option value="">전체</option>
											<c:forEach items="${langCodeList}" var="langCode" varStatus="status">
											<option value="${langCode.langCode}"<c:if test="${langCode.langCode == param.q_langCode}" > selected="selected"</c:if>><c:out value="${langCode.langNm}"/></option>
											</c:forEach>
										</select> 
				                        </select>
				                    </td>
				                    <th>처리 상태</th>
				                   <td>	
				                    	<input type="checkbox" name="q_cmmntySttusCd1" id="q_cmmntySttusCd1" title="승인" value = "1002" <c:if test="${param.q_cmmntySttusCd1 == '1002'}">checked="checked"</c:if>/> 승인
				                    	<input type="checkbox" name="q_cmmntySttusCd2" id="q_cmmntySttusCd2" title="거절" value = "1003" <c:if test="${param.q_cmmntySttusCd2 == '1003'}">checked="checked"</c:if>/> 거절
				                    	<!--  커뮤니티 신청 진행 상태 1001 신청 1002 승인 1003 거절  1004 폐쇄 1005 폐쇄중 -->	
				                    </td>
	                        		<th>카테고리</th>
	                        		<td >
				                        <op:code id="q_cmmntyCtgryCd" grpCd="2011" type="select" defaultLabel="-- 전체 --" defaultValues="${param.q_cmmntyCtgryCd}" />
	                        		</td>
	                        	</tr>                        	
	                        	<tr>
	                        		<th>신청일</th>
	                        		<td colspan="3">
	                        			<input class="w80" type="text" value="<c:out value='${param.q_startReqDt}'/>" name="q_startReqDt" id="q_startReqDt" title="날짜선택"  readonly="readonly"/> ~ 
				                        <input class="w80" type="text" value="<c:out value='${param.q_endReqDt}'/>" name="q_endReqDt" id="q_endReqDt" title="날짜선택"  readonly="readonly"/>
				                        &nbsp;&nbsp;<button type="button" class="s_blue" onclick="jsClearRegdt();">초기화</button>
	                        		</td>
	                     			<th>키워드</th>
	                        		<td >
	                        			<select id="q_keyWordSearch" name="q_keyWordSearch" class="over">
				                            <option value="">-- 선택 --</option>
				                            <option <c:if test="${param.q_keyWordSearch == '1001'}">selected="selected"</c:if> value="1001">커뮤니티 이름</option>
				                            <option <c:if test="${param.q_keyWordSearch == '1002'}">selected="selected"</c:if> value="1002">커뮤니티 ID</option>
				                            <option <c:if test="${param.q_keyWordSearch == '1003'}">selected="selected"</c:if> value="1003">신청자 이름</option>
				                            <option <c:if test="${param.q_keyWordSearch == '1004'}">selected="selected"</c:if> value="1004">신청자 ID</option>
				                        </select>
				                        <input class="w215" type="text" value="${param.q_searchWord}" id="q_searchKeyWord" name="q_searchKeyWord" title="검색어를 입력하세요."/>
				                          <button type="button" class="gray mar_l5 mar_b5" onclick="jsSearchAction();">검색</button>&nbsp;&nbsp;
	                        		</td>
	                        	</tr>
	                        </tbody>
                        </table>
                </fieldset>
            </div>
            <!-- //검색 -->
            
            <op:pagerParam title="" />
            
                        <!-- 리스트 -->
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
<%--                 	<col width="4%"/> --%>
                    <col width="5%"/>
                    <col width="9%"/>
					<col width="7%"/>
					<col width="9%"/>
					<col width="*%"/>
					<col width="5%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                    <tr>
<!--                         <th>선택<br/><input type="checkbox" name="ckMultiBoxAll" id="ckMultiBoxAll" title="전체선택"/></th> -->
                        <th>NO</th>
                        <th>지원언어</th>
                        <th>카테고리</th>
                        <th>커뮤니티 ID</th>
                        <th>커뮤니티 이름</th>
                        <th>총 회원</th>
                        <th>신청자 이름 <br/> (ID)</th>
                        <th>신청일</th>
                        <th>처리일</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><c:out value='${pager.indexNo - status.index}'/></td>
                            <td><c:out value='${data.langNm}'/></td>
                            <td><c:out value='${data.cmmntyCtgryNm}'/></td>
                            <td><c:out value='${data.cmmntyId}'/></td>
                            <td>
                            <c:if test="${data.cmmntySttusCd == 1002 }">
                            	<c:if test="${data.langCode != '00'}">
                                <a href="http://<c:out value='${data.cmmntyUrl}'/>" id="popView1" target="_blank" ><c:out value='${data.cmmntyNm}'/></a>
                            	</c:if>
                            	<c:if test="${data.langCode == '00'}">
                                <a href="http://<c:out value='${data.cmmntyUrl}'/>" id="popView1" target="_blank" ><c:out value='${data.cmmntyNm}'/></a>
                            	</c:if>
                            </c:if>
                            <c:if test="${data.cmmntySttusCd != 1002 }"><c:out value='${data.cmmntyNm}'/></c:if>
                            </td>
                            <td>
                            	<a href="#" id="popView2" onclick="jsPopupMemberView(this,'<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.userId}'/>');"><c:out value='${data.cmMberCount}'/></a>
                            </td>
                           	<td><c:out value='${data.userNm}'/><br/>(<c:out value='${data.userId}'/>)</td>
                            <td><c:out value='${data.estblReqstDt}'/> </td>
                            <td><c:out value='${data.updtDt}'/></td>   
                            <td class="lr_none">
                            	<a href="#" id="popView3" onclick="jsPopupView(this,'<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.userId}'/>' , '<c:out value='${data.cmmntySttusCd}'/>');"><c:out value='${data.cmmntySttusNm}'/></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="10" />
                </tbody>
            </table>
            <!-- //리스트 -->
            <!-- 페이징 -->
            <op:pager pager="${pager}" />
            <!-- //페이징 -->
	            <!-- 버튼 -->
            <div>
                <div class="float_l">
<!--                 <input type="button" class="blue" id="butExcel" onclick="downExcel();" value="엑셀출력" style="cursor: pointer;"> -->
                </div>
                <div class="float_r">
<!--                     	<a href="#" class="btn"><button id="butCon" type="button" onclick="jsButConfirm(this);" class="blue">승인</button></a> -->
<!--                     	<a href="#" class="btn"><button id="butCan"type="button" onclick="jsButCancle(this);" class="blue">거절</button></a> -->
                </div>
            </div>
            </form>
        </div>
        <!-- //컨텐츠영역 -->
        <br/>
</body>
</html>