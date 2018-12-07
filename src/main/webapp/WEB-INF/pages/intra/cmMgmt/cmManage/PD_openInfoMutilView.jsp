<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>커뮤니티 <c:if test="${ formcheck == 'Y' }">승인</c:if><c:if test="${ formcheck == 'N' } ">거절</c:if> </title>
    <op:jsTag type="spi" items="form,validate,colorbox" />
	<op:jsTag type="openworks" items="form, validate, ui" />
	<script type="text/javascript">
		//<![CDATA[
           
           	$(document).ready(function(){	

			});
            
		// 승인
       	   var jsApproval = function(){ 
       	    
	   	       	 if ( confirm("커뮤니티 개설신청을 승인 하시겠습니까?") ) {
	   		 	        $("#dataForm").ajaxSubmit({
	   		   	            url      : "INC_OpenCmManageMultiUpdate.do?confirm=Y",
	   		   	            type     : "POST",
	   		   	            dataType : "text",
	   		   	            success  : function(response) {
	   		   	                if (response == "true") {
	   		   	                    jsSuccessBox("승인 되었습니다.");
	   		   	              		jsCloseWin();
	   		   	              		parent.location.reload(); 
	   		   	                } else { 
	   		   	                    jsErrorBox(response.message);
	   		   	                   	return;
	   		   	                }
	   		   	            }
	   		   	        });
	   	       	 }
   	   		};
         // 거절  
   	     var jsReject = function(){
    	    	if(validation.dataForm() === false){
    	        	return;
    	   		}
    	    
	   	       	 if ( confirm("커뮤니티 개설신청을 거절 하시겠습니까?") ) {
	   		 	        $("#dataForm").ajaxSubmit({
	   		   	            url      : "INC_OpenCmManageMultiUpdate.do?confirm=N",
	   		   	            type     : "POST",
	   		   	            dataType : "text",
	   		   	            success  : function(response) {
	   		   	                if (response == "true") {
	   		   	                    jsSuccessBox("거절 되었습니다.");
	   		   	              		jsCloseWin();
	   		   	              		parent.location.reload(); 
	   		   	                } else { 
	   		   	                    jsErrorBox(response.message);
	   		   	                   	return;
	   		   	                }
	   		   	            }
	   		   	        });
	   	       	 }
	   		};
       	   var validation = {     
                   /** ajax submit validation **/
           		   dataForm : function() {
           		       /** 지역변수 **/
           		       if($("#confmRejectResn").val() == ""){
           		           		alert("승인 거절 사유를 작성하세요!");
                              	$("confmRejectResn").focus();
           		           return false;
           		       }	
           		   }
           	};
   	   
       	   
       	//글자수체크
           var displayBytes  = function ( nm, id ){
               var obj  = document.getElementById( id );
               if($("#type").val() == "pdt_nm") {
                   if (obj.value.bytes() > nm){
                       if (event.keyCode != '8'){
                           alert(nm+'바이트까지 입력이 가능합니다.');
                       }
                       obj.value = obj.value.substring(0, obj.value.length-10);
                   } 
                   
                   eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
                   
               }else{
               	eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
               }
           };
           //글자수체크 bytes 계산 속성 추가
           String.prototype.bytes = function(){
               var str = this;
               var size = 0;
               for (var i=0; i<str.length; i++){
               	size += (str.charCodeAt(i) > 128) ? 2 : 1;
               }
               return size;
           };
         	//]]>
	</script>
</head>
<body>
<!-- 컨텐츠영역 -->
	<form name="dataForm" id="dataForm" method="post">
	<div id="popup">
		  <!-- 리스트 -->
		   <fieldset>
		   <legend>커뮤니티 다중 선택 정보</legend>
            <table class="boardList" cellspacing="0" border="0" summary="커뮤니티 개설 승인 다중선택 정보.">
                <caption class="hidden"> 커뮤니티 다중 선택 정보 </caption>
                <colgroup>
                	<col width="100%"/>
                </colgroup>
                <thead>
                <tr>
                	<td><h2 class="float_l tx_b">선택정보</h2></td>
                </tr>
                	<tr>
                        <th>커뮤니티 이름</th>
                  </tr>
                </thead>
                <tbody id="odd-color">
                    <c:forEach items="${openCmManageMutilView}" var="data" varStatus="status">
                        <tr>
                            <td class="lr_none tx_l"><c:out value='${data.cmmntyNm}'/></td>
                             <input type="hidden" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.userId}'/>"/>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </fieldset>
          <br/>
            <div>
            	<tr>
            		  <c:if test="${ formcheck == 'Y'}"><td> 위 <span class="tx_red"><font size="5px"><c:out value='${ckmultiSize}'/></font></span> 개 계정에 대해 승인 처리 하시겠습니까? </td></c:if>
            		  <c:if test="${ formcheck == 'N'}"><td> 위 <span class="tx_red"><font size="5px"><c:out value='${ckmultiSize}'/></font></span> 개 계정에 대해 거절 처리 하시겠습니까? </td></c:if>
            	</tr>
            </div>
        <br/>
       <c:if test="${ formcheck == 'N' }">
       <!-- 사유 -->
<!-- 	<h4 class="tx_13">거절 사유</h4> -->
        <fieldset>
        <legend>커뮤니티 거절 사유</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 거절 사유 </caption>
            <colgroup>
                <col width="100%" />
            </colgroup>
            <tbody>
                <tr>
                    <td>
                    <h2 class="mar_t10 tx_b">거절 사유</h2>
                    <p class="mar_t5"><span class="tx_red"> ( 계정 별 개별 사유를 입력하고자 할 경우에는 개별 거절을 이용하시기 바랍니다. )</span></p>
                    <textarea id="confmRejectResn" name="confmRejectResn"  rows="8" class="w99_p" onkeyup="javascript:displayBytes(2000,'confmRejectResn');"  onblur="javascript:displayBytes(2000,'confmRejectResn');" ></textarea><br />
                     <p class="mar_t5"> - 필수 입력 항목입니다.  &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; <span id="confmRejectResn_bytes">0</span>/2000 byte</p>
                     <p class="mar_t5"> - 2000Byte를 초과할 수 없습니다.</p>
                   
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>
            <!-- //사유 -->
        </c:if>
        <!-- //리스트 -->
        <p class="tx_c mar_t20">
        <c:if test="${ formcheck == 'Y' }">
        	<a href="#"><button type="button" onclick="jsApproval()" class="blue">확인</button></a>
        </c:if>
        <c:if test="${ formcheck == 'N' }">
			<a href="#"><button type="button" onclick="jsReject()" class="blue">확인</button></a>
		</c:if>
			<a href="#"><button type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
		</p>
	</div>
	</form>
</body>
</html>