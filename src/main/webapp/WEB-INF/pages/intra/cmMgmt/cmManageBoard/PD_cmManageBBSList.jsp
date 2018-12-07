<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 회원 현황</title>
	<op:jsTag type="spi" items="jquery,form,validate,colorbox" />
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
		 // 다중 게시물을 완전 삭제 // 주석 처리 
	   var jsBBSDelete = function(){
	       var docUrl = document.URL;
       	 	if(validation.dataForm() === false){
   	        	return;
   	   	 	}
       	 	checkSelectedValue();
       	 	var multiCkSize = $("#multiCkSize").val();
 	       	 if ( confirm("총 "+multiCkSize+"게시물을 완전 삭제 하시겠습니까?") ) {
 	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmManageBBSDelete.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	            if (response == "true")  {
	   	                    jsSuccessBox("게시물을 완전 삭제 되었습니다.");
	   	                 	jrMove("PD_cmManageBBSList.do");
	   	                } else { 
	   	                	jsSuccessBox("게시물을 완전 삭제 중 오류가 발생했습니다.");
	   	                   	return;
	   	                }
	   	            }
	   	        });
 	       	 }
		};
	   
		 // 다중 게시물을 일반 삭제
		   var jsBBSDelUpdate = function(){
		       var docUrl = document.URL;
	       	 	if(validation.dataForm() === false){
	   	        	return;
	   	   	 	}
	       	 	checkSelectedValue();
	       	 	var multiCkSize = $("#multiCkSize").val();
	 	       	 if ( confirm("총 "+multiCkSize+"게시물을 삭제 하시겠습니까?") ) {
	 	 	        $("#dataForm").ajaxSubmit({
		   	            url      : "ND_cmManageBBSDelUpdate.do",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	            if (response == "true")  {
		   	                    jsSuccessBox("게시물이 삭제 되었습니다.");
		   	                 	jrMove("PD_cmManageBBSList.do");
		   	                } else { 
		   	                	jsSuccessBox("게시물을삭제 중 오류가 발생했습니다.");
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
	
       	var jsSelectChange = function(){
       	    var selectValue =  $("#q_cmmntyMenuCode").val();

       	 	var selectValueSplit = selectValue.split("_");
       	 	$("#dataForm #cmmntyMenuCode").val(selectValueSplit[0]);
       	    $("#dataForm #cmmntyBbsTyCd").val(selectValueSplit[1]);
            $("#q_currPage").val("1");
         	$("#dataForm").submit();
       	};
       	
       	
       	/* 게시판 타입 1001:기본형		1002:FAQ형		1003:갤러리형		1004:답변형 */
      // 	 cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId, cmmntyBbsTyCd

        var jsBBSPopupView = function(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId, cmmntyBbsTyCd) {
               $.colorbox({
                  	title : "커뮤니티 게시판 정보",         
        			href      : "PD_cmManageBBSView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsSeq="+cmmntyBbsSeq+"&registId="+registId+"&cmmntyBbsTyCd="+cmmntyBbsTyCd,
        			width : "900px",
        	        height : "700px",
                  iframe : true
              }); 
        };
        
        var jsBBSInsertForm = function(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId, cmmntyBbsTyCd) {
            $.colorbox({
               	title : "커뮤니티 게시판 등록/수정 정보",         
     			href      : "PD_cmManageBBSForm.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsSeq="+cmmntyBbsSeq+"&registId="+registId+"&cmmntyBbsTyCd="+cmmntyBbsTyCd,
     			width : "900px",
     	        height : "700px",
               iframe : true
           }); 
     	};
	//]]>
	 </script>
</head>
<body>
	<!-- 컨텐츠영역 -->
	<div id="contents">
	<form name="dataForm" id="dataForm" method="post" action="PD_cmManageBBSList.do">
	<input type="hidden" id="hidPopup" name="hidPopup" value=""/>
	<input type="hidden" name="multiCheck" id="multiCheck"  value="" />
	<input type="hidden" name="multiCkSize" id="multiCkSize"  value="" />
	<input type="hidden" name="cmmntyId" id="cmmntyId"  value="<c:out value='${openCmManageView.cmmntyId}'/>" />
	<input type="hidden" name="langCode" id="langCode"  value="<c:out value='${openCmManageView.langCode}'/>" />
	<input type="hidden" name="userId" id="userId"  value="<c:out value='${openCmManageView.userId}'/>" />
	<input type="hidden" name="q_mberStateTab" id="q_mberStateTab"  value="<c:out value='${param.q_mberStateTab}'/>" />
	<input type="hidden" name="cmmntyMenuCode" id="cmmntyMenuCode"  value="<c:out value='${cmmntyMenuCode}'/>" />
	<input type="hidden" name="cmmntyBbsTyCd" id="cmmntyBbsTyCd"  value="<c:out value='${cmmntyBbsTyCd}'/>" />
		            <!-- 검색 -->
            <div class="search">
                <fieldset>
                    <legend>커뮤니티 정보</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="커뮤니티 정보">
                        	<colgroup>
			                    <col width="20%" />
			                    <col width="30%" />
			                    <col width="20%" />
			                    <col width="30%" />
			                </colgroup>
			                <tbody>
	                        	<tr>
	                        		<th>커뮤티니 이름</th>
	                        		<td><span><c:out value='${openCmManageView.cmmntyNm}'/></span></td>
	                        		<th>지원 언어</th>
	                        		<td><span><c:out value='${openCmManageView.langNm}'/></span></td>
	                        	</tr>    
	                       		 <tr>
				                    <th>커뮤니티 ID</th>
				                   <td><span><c:out value='${openCmManageView.cmmntyId}'/></span></td>
				                   <th>카테고리</th>
				                   <td><span><c:out value='${openCmManageView.cmmntyCtgryNm}'/></span></td>
                            	</tr>
	                        </tbody>
                        </table>
                </fieldset>
            </div>
            <!-- //검색 -->
             <h2 class="mar_t5">커뮤니티 게시물 목록 &nbsp;&nbsp;&nbsp;&nbsp;<span class="tx_13 tx_normal"> 선택 게시판 <select id="q_cmmntyMenuCode" name="q_cmmntyMenuCode" title="분류를 선택해주세요" class="over" onchange="jsSelectChange()">
											<option value="">게시판 선택</option>
											<c:forEach items="${cmMberMenuSelect}" var="selectData" varStatus="status">
											<option value="<c:out value='${selectData.cmmntyMenuCode}'/>_<c:out value='${selectData.cmmntyBbsTyCd}'/>"<c:if test="${selectData.cmmntyMenuCode == cmmntyMenuCode}" > selected="selected"</c:if>><c:out value="${selectData.cmmntyMenuNm}"/></option>
											</c:forEach>
										</select></span></h2>
            <op:pagerParam title="전체" />
            <!-- 게시판 목록 -->
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
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>다운로드수</th>
                        <th>댓글수</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody id="odd-color">
                    <c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMenuCode}'/>_<c:out value='${data.cmmntyBbsSeq}'/>_<c:out value='${data.registId}'/>"/></td>
                            <td><c:out value='${pager.indexNo - status.index}'/></td>
                            <c:if test='${empty data.fileList[0].fileUrl}'>
							<td class="tx_l"><a href="#none"  id="popView" onclick="jsBBSPopupView('<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>','<c:out value='${data.cmmntyBbsTyCd}'/>');" >
							<c:if test="${ data.noticeBbscttAt  == 'Y'}"><strong>[ 공지 ]</strong></c:if> <c:out value='${data.bbscttSj}'/></a> </td>
							</c:if>
							<c:if test='${not empty data.fileList[0].fileUrl}'>
							<td class="tx_l"><a href="#none"  id="popView" onclick="jsUserBoardView('<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>','<c:out value='${data.cmmntyBbsTyCd}'/>');" >
							<c:if test="${ data.noticeBbscttAt  == 'Y'}"><strong>[ 공지 ]</strong></c:if> <c:out value='${data.bbscttSj}'/></a>
							<a href="/component/file/ND_fileDownload.do?id=<c:out value='${data.fileList[0].fileId}'/>" title="<c:out value='${data.fileList[0].fileDesc}'/>"><img src="/resources/cmmnty/default/images/common/ico/ico_image.gif" alt="<c:out value='${data.fileList[0].localNm}'/>"></a></td>
							</c:if>
                            <td><c:out value='${data.wrterNcnm}'/></td><!--  작성자 -->
                            <td><c:out value='${data.registDt}'/></td>
                            <td><c:out value='${data.downCnt}'/></td>
                           	<td><c:out value='${data.cmBbsCmtCount}'/></td>
                            <td class="lr_none"><c:out value='${data.rdcnt}'/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="8" />
                </tbody>
            </table>
            <!-- 페이징 -->
            <op:pager pager="${pager}" />
            <!-- //페이징 -->
            </form>
        </div>
        <!-- //컨텐츠영역 -->
        <br/>
         <p class="tx_c mar_t20">
        <div>
           <div>
	          <div class="float_l">
	          		<a href="#none" class="btn"><button type="button" onclick="jsBBSDelUpdate();" class="blue">삭제</button></a>
	          </div>
           		<div class="float_r">
           		<a href="#none" class="btn"><button type="button" onclick="jsBBSInsertForm('<c:out value='${openCmManageView.cmmntyId}'/>','<c:out value='${openCmManageView.langCode}'/>', '<c:out value='${cmmntyMenuCode}'/>','','','<c:out value='${cmmntyBbsTyCd}'/>');" class="blue">등록</button></a>

<!--            		<a href="#none" class="btn"><button type="button" onclick="jsBBSDelete();" class="blue">완전삭제</button></a> -->
				<a href="#none" class="btn"><button type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
				</div>
          </div>
		</div>
		</p>
</body>
</html>