<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<html>
<head>
<title>메타폼 수정</title>
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
        $("#butSModify").click(function(){
	        $("#dataForm").ajaxSubmit({
	            url      : "PD_updateFormPopAction.do",
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
	        	메타정보수정
        </h2>
        <fieldset>
        <legend>메타정보수정</legend>
        <table id="metaFromTab" class="boardWrite" cellspacing="0" border="1" summary="메타폼 수정 합니다..">
            <caption class="hidden"> 메타정보수정 </caption>
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
                    <td colspan="4">
                    	<input type="text" 		name="metaMasterNmV" 	id="metaMasterNmV" 	value="${ metaMasterDetail.metaMasterNmV }" size="60"/>
                    	<input type="hidden" 	name="metaMasterSeqN" 	id="metaMasterSeqN" value="${ metaMasterDetail.metaMasterSeqN }" />
                    	<input type="hidden" 	name="useYnC" 			id="useYnC"		 	value="${ metaMasterDetail.useYnC }" />
                    	<input type="hidden" 	name="propertySeqN"		id="propertySeqN" 	value="${ metaPropertyDetail.propertySeqN }" />
                    	<input type="hidden" 	name="property"			id="property" 		value="${ metaPropertyDetail.property }" />
                    	<input type="hidden" 	name="propertyTypeC"	id="propertyTypeC" 	value="${ metaPropertyDetail.propertyTypeC }" />
                   	</td>
                </tr>
                <tr>
                    <th style="text-align:center;">속성명</th>
                    <th style="text-align:center;">속성코드</th>
                    <th style="text-align:center;">필수여부</th>
                    <th style="text-align:center;">데이터타입</th>
                    <th style="text-align:center;">삭제</th>                    
                </tr>                
                <c:forEach items="${metaValList}" var="metaValVO">
                <tr>
	               	<td><input type="text" name="metaPropNameV" id="metaPropNameV" size="22" value="${metaValVO.metaPropNameV} " /></td>
	               	<td><input type="text" name="metaPropCdV" id="metaPropCdV" size="13" value="${metaValVO.metaPropCdV}" /></td>
	               	<td>
	               		<select name="requireYnC" id="requireYnC">
		               		<option value="">선택하세요.</option>
		               		<option value="Y" <c:if test="${metaValVO.requireYnC eq 'Y'}">selected</c:if>>예</option>
		               		<option value="N" <c:if test="${metaValVO.requireYnC eq 'N'}">selected</c:if>>아니오</option>
	               		</select>
	               	</td>
	               	<td>
	               		<select name="dataKindC" id="dataKindC">
		               		<option value="">선택하세요.</option>
		               		<c:forEach items="${dataKindList}" var="dataKindList">
	               			<option value="${dataKindList.prvCd}" <c:if test="${metaValVO.dataKindC eq dataKindList.prvCd}">selected</c:if>>${ dataKindList.prvNm }</option>
	               			</c:forEach>
	               		</select>
	               	</td>
	            	<td>
	            		<c:if test="${metaValVO.requireYnC eq 'N'}">
	            		<a href="#">
	            		<button class="blue" id="rowDelete" onclick="JavaScript:funDeleteRow(this);">행삭제</button>
	            		</a>
	            		</c:if>
	            	</td>
            	</tr>     
            	</c:forEach>     
            </tbody>            
        </table>
        <textarea id="addRow" style="display:none">
        	<tr>
               	<td><input type="text" name="metaPropNameV" id="metaPropNameV" size="27" /></td>
               	<td><input type="text" name="metaPropCdV" id="metaPropCdV" size="16" /></td>
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
         		<c:if test="${ dataCount eq 0 }">
	         	<a href="#"><button class="blue" type="button" id="butAddRow" onclick="JavaScript:funAddRow();">행추가</button></a>
	         	</c:if>
	         	<c:if test="${ dataCount eq 0 }"> 
	         	<a href="#"><button class="blue" type="button" id="butSModify">수정</button></a>
	         	</c:if> 
	         	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
			</p>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>