<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 회원 현황</title>
	<op:jsTag type="spi" items="form,validate,colorbox, datepicker" />
	<op:jsTag type="openworks" items="form, validate, ui" />
    <script type="text/javascript">
  	//<![CDATA[
	    $(document).ready(function() {
	        $("#ckMultiBoxAll").click(function() {  
	       		if($(this).is(':checked')) {        
	       			$("input[name=ckMultiBox]").prop("checked", true);   
	       		} else {        
	       			$("input[name=ckMultiBox]").prop("checked", false);    
	       		}
	       	}); 
	        
   	 	});
	    

	    var checkSelectedValue = function (){
		    var valueArr = new Array();
		    var list = $("input[name='ckMultiBox']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){
		            valueArr.push(list[i].value);
		        }else{
		            
		        }
		    }
		    $("#multiCheck").val(valueArr);
		    $("#multiCkSize").val(valueArr.length);
		   
		};
		 // 다중 승인 
	   var jsButConfirm = function(){

       	 	if(validation.dataForm() === false){
   	        	return;
   	   	 	}
       	 	checkSelectedValue();
       	// 커뮤니티회원상태 :>>>1001:가입중		1002:가입거절		1003:정상		1004:탈퇴
       	 	var multiCkSize = $("#multiCkSize").val();
 	       	 if ( confirm("총 "+multiCkSize+"명을 가입 승인하시겠습니까?") ) {
 	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmMemberShipInfoUpdate.do?mberState=1003",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	            if (response == "true")  {
	   	                    jsSuccessBox("가입 승인 되었습니다.");
	   	                 	jrMove("PD_memberShipInfoList.do");
	   	                } else { 
	   	                	jsSuccessBox("가입 승인 중 오류가 발생했습니다.");
	   	                   	return;
	   	                }
	   	            }
	   	        });
 	       	 }
	   };
    	 // 다중 승인 거부
	   var jsButCancle = function(){
	       	if(validation.dataForm() === false){
	           return;
		   	}
	       	checkSelectedValue();
	     // 커뮤니티회원상태 :>>>1001:가입중		1002:가입거절		1003:정상		1004:탈퇴
			var multiCkSize = $("#multiCkSize").val();
	       	if ( confirm("총 "+multiCkSize+"명을 가입 거절 하시겠습니까?") ) {
	 	        $("#dataForm").ajaxSubmit({
	 	           url      : "INC_cmMemberShipInfoUpdate.do?mberState=1002",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	            	if (response == "true")  {
	   	                    jsSuccessBox("가입 거절 되었습니다.");
	   	                 	jrMove("PD_memberShipInfoList.do");
	   	                } else { 
	   	                	jsSuccessBox("가입 거절 중 오류가 발생했습니다.");
	   	                	
	   	                   	return;
	   	                }
	   	            }
	   	        });
	       	}
	   };
	   
	   var jsButWithdraw = function(){
	       if(validation.dataForm() === false){
	           return;
		   }
	       checkSelectedValue();
	       //커뮤니티회원강제탈퇴	: >>1001:운영자강제탈퇴		1002:관리자강제탈퇴
			// 커뮤니티회원상태 :>>>1001:가입중		1002:가입거절		1003:정상		1004:탈퇴
	       var multiCkSize = $("#multiCkSize").val();
	       	if ( confirm("총 "+multiCkSize+"명을 강제 탈퇴 하시겠습니까?") ) {
	 	        $("#dataForm").ajaxSubmit({
	 	           url      : "INC_cmMemberShipInfoUpdate.do?mberState=1004",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
		   	            if (response == "true")  {
		   	                jsSuccessBox("강제 탈퇴 되었습니다.");
		   	             	jrMove("PD_memberShipInfoList.do");
		   	            } else { 
		   	                	jsSuccessBox("강제 탈퇴 중 오류가 발생했습니다.");
		   	                   	return;
		   	           }
	   	         	}
	   	        });
	       	}
	   };
	   // 페이지 이동
	   var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	   };
	    
        // 커뮤니티  회원정보 팝업 view  <c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>
//         var jsMemberPopupView = function(cmmntyId, langCode, cmmntyMberId, mberStateCd) {
            
//            var features ="width=600, height=700, scrollbars=yes, top=200, left=700, toolbar=no";
//            var popupUrl = "PD_memberShipInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMberId="+cmmntyMberId+"&mberStateCd="+mberStateCd;
//            window.open( popupUrl , "커뮤니티 회원 정보", features);
//         };

		        // 커뮤니티  회원정보 팝업 view 
        var jsMemberPopupView = function(el, cmmntyId, langCode, cmmntyMberId, mberStateCd) {
            $(el).colorbox({
               	title : "커뮤니티 회원 정보",         
     			href      : "PD_memberShipInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMberId="+cmmntyMberId+"&mberStateCd="+mberStateCd,
     			width : "600px",
     	        height : "700px",
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
        
		// 회원구분 이동
        var topMberMove = function(mberStateCd){
            
            $("#q_mberStateTab").val(mberStateCd);
            $('#q_currPage').val("1");
            $('#dataForm').submit();
            
       	};

	//]]>
	 </script>
</head>
<body>
	<!-- 컨텐츠영역 -->
	<div id="contents">
	<form name="dataForm" id="dataForm" method="post" action="PD_memberShipInfoList.do">
	<input type="hidden" id="hidPopup" name="hidPopup" value=""/>
	<input type="hidden" name="multiCheck" id="multiCheck"  value="" />
	<input type="hidden" name="multiCkSize" id="multiCkSize"  value="" />
	<input type="hidden" name="cmmntyId" id="cmmntyId"  value="<c:out value='${openCmManageView.cmmntyId}'/>" />
	<input type="hidden" name="langCode" id="langCode"  value="<c:out value='${openCmManageView.langCode}'/>" />
	<input type="hidden" name="userId" id="userId"  value="<c:out value='${openCmManageView.userId}'/>" />
	<input type="hidden" name="q_mberStateTab" id="q_mberStateTab"  value="${param.q_mberStateTab}" />
		            <!-- 검색 -->
            <div class="search">
                <fieldset>
                    <legend>커뮤니티 정보</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="커뮤니티 정보">
                        	<colgroup>
			                    <col width="30%" />
			                    <col width="*%" />
			                </colgroup>
			                <tbody>
	                        	<tr>
	                        		<th>커뮤티니 이름</th>
	                        		<td><span><c:out value='${openCmManageView.cmmntyNm}'/></span></td>
	                        	</tr>    
	                       		 <tr>
				                    <th>커뮤니티 주소</th>
				                   <td><span>
				                   	<%-- 
				                   	<c:if test="${openCmManageView.langCode != '00'}">http://www.ceart.kr/<c:out value='${fn:toLowerCase(openCmManageView.langEngNm)}'/>/cm/user/<c:out value='${openCmManageView.cmmntyUrl}'/></c:if>
                            		<c:if test="${openCmManageView.langCode == '00'}">http://www.ceart.kr/web/cm/user/<c:out value='${openCmManageView.cmmntyUrl}'/></c:if> --%>
                            		
                           			<%--{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
			                    	  변경소스--%>
                            		<c:if test="${openCmManageView.langCode == '00'}">http://<%=GlobalConfig.DOMAIN_SUBNM %>/web/cm/user/<c:out value='${openCmManageView.cmmntyUrl}'/></c:if>
			                    	<%--}} --%>
                            		
                            		</span></td>
                            	</tr>
                            	<tr>
	                        		<th>가입방식</th>
	                        		<td >
										<span><input type="radio" id="cmmntySbscrbMthd_1" name="cmmntySbscrbMthd" value="1" <c:if test="${openCmManageView.cmmntySbscrbMthd eq '1'}">checked="checked"</c:if> disabled="disabled" />
							            <label for="useYn_Y">가입 신청 시 바로 가입할 수 있습니다.</label><br/>
							            <input type="radio" id="cmmntySbscrbMthd_2" name="cmmntySbscrbMthd" value="2" <c:if test="${openCmManageView.cmmntySbscrbMthd eq '2'}">checked="checked"</c:if>  disabled="disabled" />
							          <label for="useYn_N">가입 신청 시 운영자의 승인을 거쳐 가입할 수 있습니다.</label></span></td>
                    			</tr>
	                        </tbody>
                        </table>
                </fieldset>
            </div>
            <!-- //검색 -->
            
            <!-- 탭   2003	커뮤니티회원상태	1001:가입중	1002:가입거절		1003:정상	1004:탈퇴 -->
            <ul class="tab">
                <li><a href="#" id="1001" onclick="topMberMove('1001');" <c:if test="${param.q_mberStateTab== 1001 || empty param.q_mberStateTab}">class="on"</c:if>>가입회원</a></li>
                <li><a href="#" id="1003" onclick="topMberMove('1003');" <c:if test="${param.q_mberStateTab == 1003}">class="on"</c:if>>전체회원</a></li>                
                <li><a href="#" id="1004" onclick="topMberMove('1004');" <c:if test="${param.q_mberStateTab == 1004}">class="on"</c:if>>탈퇴회원</a></li>                
            </ul>
            <!-- //탭 -->
            
            
             <!-- 버튼 -->
            <div>
            <op:pagerParam title="회원 목록" />
                <div class="float_r">
                <c:if test="${param.q_mberStateTab == 1001}">
                    	<a href="#" class="btn"><button id="butCon" type="button" onclick="jsButConfirm();" class="blue">가입 승인</button></a>
                    	<a href="#" class="btn"><button id="butCan"type="button" onclick="jsButCancle();" class="blue">가입 거절</button></a>
                </c:if>
                    <c:if test="${param.q_mberStateTab == 1003}">	
                    	<a href="#" class="btn"><button id="butCan"type="button" onclick="jsButWithdraw();" class="blue">강제 탈퇴</button></a>
                    </c:if>
                </div>
                
            </div>
            <br/><br/>
            <!-- 가입 회원 리스트 -->
              <c:if test="${param.q_mberStateTab== 1001 || empty param.q_mberStateTab}">
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
                	<col width="5%"/>
                    <col width="5%"/>
                    <col width="*%"/>
					<col width="15%"/>
					<col width="15%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>선택<br/><input type="checkbox" name="ckMultiBoxAll" id="ckMultiBoxAll" title="전체선택"/></th>
                        <th>NO</th>
                        <th>닉네임</th>
                        <th>회원 구분</th>
                        <th>가입신청일</th>
                    </tr>
                </thead>

                <tbody id="odd-color">
                    <c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMberId}'/>"/></td>
                            <td><c:out value='${pager.indexNo - status.index}'/></td>
                            <td><a href="#" id="popView" onclick="jsMemberPopupView(this, '<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>');"><c:out value='${data.ncnm}'/></td>
                            <td><c:out value='${data.userTyNm}'/></td>
                            <td class="lr_none"><c:out value='${data.sbscrbReqstDt}'/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="5" />
                </tbody>
            </table>
           </c:if>
            <!-- //가입 회원 리스트 -->
            
           <!-- 전체 회원 리스트 -->
            <c:if test="${param.q_mberStateTab == 1003}">
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
                	<col width="5%"/>
                    <col width="5%"/>
                    <col width="*%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="10%"/>
					<col width="15%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>선택<br/><input type="checkbox" name="ckMultiBoxAll" id="ckMultiBoxAll" title="전체선택"/></th>
                        <th>NO</th>
                        <th>닉네임</th>
                        <th>방문수</th>
                        <th>작성글수</th>
                        <th>댓글수</th>
                        <th>회원 구분</th>
                        <th>최종방문일<br/>(가입일)</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMberId}'/>"/></td>
                            <td><c:out value='${pager.indexNo - status.index}'/></td>
                            <td><a href="#" id="popView" onclick="jsMemberPopupView(this, '<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>');"><c:out value='${data.ncnm}'/></a></td>
                            <td><c:out value='${data.cmVisitCount}'/></td><!--  방문수 -->
                            <td><c:out value='${data.cmMberBbsCount}'/></td>
                            <td><c:out value='${data.cmMberBbsCmtCount}'/>  </td>
                           	<td><c:out value='${data.userTyNm}'/></td>
                            <td class="lr_none"><c:out value='${data.visitDt}'/><br/>(<c:out value='${data.sbscrbConfmDt}'/>)</td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="8" />
                </tbody>
            </table>
       </c:if>
            <!-- //전체 회원 리스트 -->
             <!-- 탈퇴 회원 리스트 -->
            <c:if test="${param.q_mberStateTab == 1004}">
            <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
<%--                 	<col width="5%"/> --%>
                    <col width="5%"/>
                    <col width="*%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>닉네임</th>
                        <th>탈퇴 구분</th>
                        <th>회원 구분</th>
                        <th>탈퇴일</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><c:out value='${pager.indexNo - status.index}'/></td>
                            <td><a href="#" id="popView" onclick="jsMemberPopupView(this, '<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>');"><c:out value='${data.ncnm}'/></td>
                            <td><c:out value='${data.enfrcSecsnNm}'/></td>
                            <td><c:out value='${data.userTyNm}'/></td>
                            <td class="lr_none"><c:out value='${data.secsnDt}'/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="5" />
                </tbody>
            </table>
                   </c:if>
            <!-- //탈퇴 회원 리스트 -->
            <!-- 페이징 -->
            <op:pager pager="${pager}" />
            <!-- //페이징 -->
            </form>
        </div>
        <!-- //컨텐츠영역 -->
        <br/>
        <p class="tx_c mar_t20">
			<a href="#"><button type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
		</p>
</body>
</html>