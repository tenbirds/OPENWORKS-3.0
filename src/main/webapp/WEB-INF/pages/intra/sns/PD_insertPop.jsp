<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>일정등록</title>
    <op:jsTag type="spi" items="validate,ui,form"/>
    <script type="text/javascript">

    var mode = "";

      
    $().ready(function () {
        
    	$("#prv_cd").focus();
    	
    	$("#insert").bind("click", function () {
            mode = 'insert';
        });
        $("#reInsert").bind("click", function () {
            mode = 'reInsert';
        });
        
        $("#dataForm").validate({
            rules: {
                 
                prv_cd            :      { required:true},
                consumer_key      :      { required:true},
                consumer_secret   :      { required:true},
                callback_url      :      { required:true}
                 

            },
            submitHandler : function(form) {
             /*
                
                if($("#prv_cd").val() == "")
                {   
                    alert("SNS를 선택하세요.");
                	$("#prv_cd").focus();
                    return false;
                }
                if($("#consumer_key").val() == "")
                {
                    alert("consumer Key 입력하세요.");
                    $("#consumer_key").focus();
                    return false;
                }
                     
                if($("#consumer_secret").val() == "")
                {
                    alert("consumer secret 입력하세요.");
                    $("#consumer_secret").focus();
                    return false;
                }
                     
                if($("#callback_url").val() == "")
                {
                    alert("callback url입력하세요.");
                    $("#callback_url").focus();
                    return false;
                }
                     
               */ 
                                
                if($("#grp_cd").val() != ""){
                    _url = "ND_updateAction.do";
                }else{
                    _url = "ND_insertAction.do";
                }
                $(form).ajaxSubmit({
                    url : _url,
                    type : "POST",
                    success : function(response) {

                        jsMessage(response);
                        if(mode == 'reInsert'){                            
                            location.reload();
                        }else{
                        	parent.location.reload();
                        }
                    }
               });
            }

        });
    });


 
   var jsDelete = function(el,vl,v2){
       if ( confirm("삭제 하시겠습니까?") ) {
           $.post("ND_deleteAction.do", {
               grp_cd : vl,              
               prv_cd : v2
               }, function(response) {
                   alert(response);
                   parent.location.reload();
               }
           );
       }
   };
   


    </script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <div id="popup" style="width:550px;">
        <form name="dataForm"id="dataForm">
        
        <input type="hidden" id="grp_cd" name="grp_cd" value="${baseVo.grp_cd }" />
        
                       
        <!-- 기본정보 -->
        <h2 class="mar_t20">
         <c:choose>
	         <c:when test="${empty baseVo }">SNS등록</c:when>
	         <c:otherwise>SNS수정</c:otherwise>
         </c:choose>  
        </h2>

        <fieldset>
        <legend>SNS등록</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="SNS등록을 하실 수 있습니다.">
            <caption class="hidden"> SNS등록 </caption>
            <colgroup>
                <col width="35%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><span class="tx_red_s">*</span> <label for="sub">SNS</label></th>
                    <td>	
                       <c:choose>
	            			<c:when test="${empty baseVo }">
		                 		<select name="prv_cd" id="prv_cd" class="select">
					                <option value="">  SNS 선택  </option>
						                <c:forEach items="${dataList}" var="codeList">
						                    <option value="${codeList.prv_cd}" 
		 				                        <c:if test="${baseVo.prv_cd eq codeList.prv_cd}">selected="selected" </c:if>> 
		 				                        ${codeList.sns_name}</option>
		 				                </c:forEach> 
		          				</select>
		          			</c:when>
		          			<c:otherwise>
		          				<input type="text" id="sns_name" class="w85_p" name="sns_name" value="${baseVo.sns_name }" disabled="disabled" />
		          				<input type="hidden" id="prv_cd" name="prv_cd" value="${baseVo.prv_cd }" />
		          			</c:otherwise>
	          			</c:choose>
                    
                    </td>
                </tr>
               <tr>
                    <th><span class="tx_red_s">*</span> <label for="sub">Consumer Key</label></th>
                    <td><input type="text" id="consumer_key" class="w85_p" name="consumer_key" value="${baseVo.consumer_key }" /></td>
                </tr>
                 <tr>
                    <th><span class="tx_red_s">*</span> <label for="sub">Consumer Secret</label></th>
                    <td><input type="text" id="consumer_secret" class="w85_p" name="consumer_secret" value="${baseVo.consumer_secret }" /></td>
                </tr>
                 <tr>
                    <th><span class="tx_red_s">*</span> <label for="sub">Callback URL</label></th>
                    <td><input type="text" id="callback_url" class="w85_p" name="callback_url" value="${baseVo.callback_url }" /></td>
                </tr>
              
			<c:if test="${not empty baseVo}">
                <tr>
                    <th><label for="reg_id">등록자</label></th>
                    <td>${baseVo.reg_id}</td>
                </tr>
                <tr>
                    <th><label for="reg_dt">등록일자</label></th>
                    <td>${baseVo.reg_dt}</td>
                </tr>
                <tr>
                    <th><label for="modi_id">수정자</label></th>
                    <td>${baseVo.modi_id}</td>
                </tr>
                <tr>
                    <th><label for="modi_dt">수정일자</label></th>
                    <td>${baseVo.modi_dt}</td>
                </tr>                
           </c:if>
                
                
            </tbody>
        </table>
        </fieldset>
        <!-- //기본정보 -->
        <c:choose>
            <c:when test="${not empty baseVo }">
                <p class="tx_c mar_t20">
                	<a href="#"><button class="blue"  type="submit" id="">수정</button></a> 
                	<a href="#"><button class="blue" type="button" onclick="jsDelete(this,'${baseVo.grp_cd }','${baseVo.prv_cd }');">삭제</button></a> 
                	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a></p>
            </c:when>
            <c:otherwise>
                <p class="tx_c mar_t20">
                	<a href="#"><button class="blue" type="submit" id="insert">등록</button></a> 
                	<a href="#"><button class="blue" id="reInsert">등록후 계속</button></a> 
                	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
               </p>
            </c:otherwise>
        </c:choose>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>