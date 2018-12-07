<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 폐쇄 현황</title>
	<op:jsTag type="spi" items="form,validate,colorbox, datepicker" />
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
	        $('#q_startClsDt').datepicker();
	        $('#q_endClsDt').datepicker();
	        
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
   	  		$("#q_startClsDt").val("");  
   	  		$("#q_endClsDt").val("");  
   		};
	    var checkSelectedValue = function (){
		    var valueArr = new Array();
		    var list = $("input[name='ckMultiBox']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){
		            valueArr.push(list[i].value);
		        }
		    }
		    $("#multiCheck").val(valueArr);
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
        // 커뮤니티 폐쇄 정보 팝업 view 
        var jsPopupView = function(el, cmmntyId, langCode, userId) {
            $(el).colorbox({
               	title : "커뮤니티 폐쇄 정보",         
     			href      : "PD_closeInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&userId="+userId,
     			width : "1200px",
     	        height : "600px",
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
        
        var validation = {     
                /** ajax submit validation **/
        		   dataForm : function() {
        		       /** 지역변수 **/
        		       if($("input[name=ckMultiBox]").is(':checked') == false){
        		           		alert("최소 한개이상은 체크하셔야 합니다.");
                           	$("input[name=ckMultiBox]").focus();
        		           return false;
        		       }	
        		   }
        	};
        
        //통합검색바
        var jsSearchAction = function() {
            if($("#q_startClsDt").val() > $("#q_endClsDt").val() || $("#q_startClsDt").val().replace(/-/gi,"") > $("#q_endClsDt").val().replace(/-/gi,"")){
                alert("기간이 맞지 않습니다.");
                $("#q_startClsDt").focus();
                return false;
            }

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
	<form name="dataForm" id="dataForm" method="post" action="BD_closeIndex.do">
	<input type="hidden" id="hidPopup" name="hidPopup" value=""/>
<!-- 	<input type="hidden" name="multiCheck" id="multiCheck"  value="" /> -->
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
											<option value="${langCode.langCode}"<c:if test="${langCode.langCode == param.q_langCode}" > selected="selected"</c:if>>${langCode.langNm}</option>
											</c:forEach>
										</select> 
				                        </select>
				                    </td>
				                    <th>폐쇄자</th>
				                   <td>	
				                    	<input type="checkbox" name="q_clsUser" id="q_clsUser" title="신청자" value = "N" <c:if test="${param.q_clsUser == 'N'}">checked="checked"</c:if>/> 신청자
				                    	<input type="checkbox" name="q_clsManager" id="q_clsManager" title="관리자" value = "Y" <c:if test="${param.q_clsManager == 'Y'}">checked="checked"</c:if>/> 관리자
				                    </td>
	                        		<th>카테고리</th>
	                        		<td >
				                        <op:code id="q_cmmntyCtgryCd" grpCd="2011" type="select" defaultLabel="-- 전체 --" defaultValues="${param.q_cmmntyCtgryCd}" />
	                        		</td>
	                        	</tr>                        	
	                        	<tr>
	                        		<th>신청일</th>
	                        		<td colspan="3">
	                        			<input class="w80" type="text" value="<c:out value='${param.q_startClsDt}'/>" name="q_startClsDt" id="q_startClsDt" title="날짜선택"  readonly="readonly"/> ~ 
				                        <input class="w80" type="text" value="<c:out value='${param.q_endClsDt}'/>" name="q_endClsDt" id="q_endClsDt" title="날짜선택"  readonly="readonly"/>
				                        &nbsp;&nbsp;<button type="button" class="s_blue" onclick="jsClearRegdt();">초기화</button>
	                        		</td>
	                     			<th>키워드</th>
	                        		<td >
	                        			<select id="q_keyWordSearch" name="q_keyWordSearch" class="over">
				                            <option value="">-- 전체 --</option>
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
            
            <op:pagerParam title="전체" />
            
                        <!-- 리스트 -->
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
<%--                 	<col width="4%"/> --%>
                    <col width="5%"/>
                    <col width="9%"/>
					<col width="5%"/>
					<col width="9%"/>
					<col width="*%"/>
					<col width="4%"/>
					<col width="4%"/>
                    <col width="9%"/>
                    <col width="6%"/>
                    <col width="7%"/>
                    <col width="7%"/>
                    <col width="7%"/>
                    <col width="6%"/>
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
                        <th>총 게시물</th>
                        <th>신청자 이름 <br/> (ID)</th>
                        <th>상태</th>
                        <th>신청일</th>
                        <th>처리일</th>
                        <th>폐쇄일</th>
                        <th>폐쇄자</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
<%--                             <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.userId}'/>"/></td> --%>
                            <td><c:out value='${pager.indexNo - status.index}'/></td>
                            <td><c:out value='${data.langNm}'/></td>
                            <td><c:out value='${data.cmmntyCtgryNm}'/></td>
                            <td><c:out value='${data.cmmntyId}'/></td>
                            <td>
                                <a href="#" id="popView" onclick="jsPopupView(this,'<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.userId}'/>');"><c:out value='${data.cmmntyNm}'/></a>
                            </td>
                            <td><c:out value='${data.cmMberCount}'/></td>
                            <td><c:out value='${data.cmBbsCount}'/></td>
                           	<td><c:out value='${data.userNm}'/><br/>(<c:out value='${data.userId}'/>)</td>
                           	<td><c:out value='${data.cmmntySttusNm}'/></td>
                            <td><c:out value='${data.cmmntyClsReqstDt}'/> </td>
                            <td><c:out value='${data.updtDt}'/></td>   
                            <td><c:out value='${data.cmmntyClsDt}'/></td>   
                            <td class="lr_none"> <c:out value='${data.cmmntyClsManagerNm}'/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="12" />
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
<!--                 <div class="float_r"> -->
<!--                     	<a href="#" class="btn"><button id="butCon" type="button" onclick="jsButConfirm(this);" class="blue">승인</button></a> -->
<!--                     	<a href="#" class="btn"><button id="butCan"type="button" onclick="jsButCancle(this);" class="blue">거절</button></a> -->
<!--                 </div> -->
            </div>
            </form>
        </div>
        <!-- //컨텐츠영역 -->
        <br/>
</body>
</html>