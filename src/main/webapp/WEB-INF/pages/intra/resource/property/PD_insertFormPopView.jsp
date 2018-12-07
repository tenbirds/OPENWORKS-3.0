<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<html>
<head>
<title>메타폼 등록</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript">
//<![CDATA[
	var funAddRow = function(){	   
	    $("#metaFromTab").append($("#addRow").val());
	};
	
	var funDeleteRow = function(obj){
    	$(obj).parent().parent().parent().remove();
    };
    
    $(document).ready(function(){
        $("#butSave").click(function(){
	        $("#dataForm").ajaxSubmit({
	            url      : "PD_inserFormPopAction.do",
	            type     : "POST",
	            dataType : "json",
	            success  : function(response) {
	                if (response.result) {
	                    jsSuccessBox(response.message);
	                    parent.jsSearch();
	                } else { 
	                    jsErrorBox(response.message);
	                }
	            }
	        });
        });
    });
//]]>              
</script>               
</head>
<body>
<!-- 컨텐츠영역 -->
    <div id="popup" style="width:630px;">
        <form name="dataForm"id="dataForm">
        <!-- 기본정보 -->
        <h2 class="mar_t20">
	        	메타정보등록
        </h2>
        <fieldset>
        <legend>메타정보등록</legend>
        <table id="metaFromTab" class="boardWrite" cellspacing="0" border="1" summary="메타폼 등록 입니다.">
            <caption class="hidden"> 메타정보등록 </caption>
            <colgroup>
                <col width="27%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
                <col width="13%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>메타정보명</th>
                    <td colspan="4"><input type="text" name="metaMasterNmV" id="metaMasterNmV" size="60"/></td>
                </tr>
                <tr>
                    <th style="text-align:center;">속성명</th>
                    <th style="text-align:center;">속성코드</th>
                    <th style="text-align:center;">필수여부</th>
                    <th style="text-align:center;">데이터타입</th>
                    <th style="text-align:center;">삭제</th>                    
                </tr>          
            </tbody>            
        </table>
        <textarea id="addRow" style="display:none">
        	<tr>
               	<td><input type="text" name="metaPropNameV" id="metaPropNameV" size="22" /></td>
               	<td><input type="text" name="metaPropCdV" id="metaPropCdV" size="13" /></td>
               	<td>
               		<select name="requireYnC" id="requireYnC">
	               		<option value="">선택하세요.</option>
	               		<option value="Y">예</option>
	               		<option value="N">아니오</option>
               		</select>
               	</td>
               	<td>
               		<select name="dataKindC" id="dataKindC">
               			<option value="">선택하세요.</option>
               			<c:forEach items="${dataKindList}" var="dataKindList">
               			<option value="${dataKindList.prvCd}">${ dataKindList.prvNm }</option>
               			</c:forEach>
               		</select>
               	</td>
            	<td><a href="#"><button class="blue" id="rowDelete" onclick="JavaScript:funDeleteRow(this);">행삭제</button></a></td>
            </tr> 
        </textarea>
        </fieldset>
         	<p class="tx_c mar_t20">
	         	<a href="#"><button class="blue" type="button" id="butAddRow" onclick="JavaScript:funAddRow();">행추가</button></a> 
	         	<a href="#"><button class="blue" type="button" id="butSave">저장</button></a> 
	         	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
			</p>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>