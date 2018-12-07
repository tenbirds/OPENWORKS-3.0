<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<html>
<head>
<title>메타데이터 수정</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript">
//<![CDATA[	
    $(document).ready(function(){
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#openPublicD').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        
        $("#butMod").click(function(){
            if($("#metaTitleV").val().split(' ').join('') == ""){
            	alert("메타데이터명을 입력해 주세요.");
            	$("#metaTitleV").focus();
            	return;
            }
            
            if($("select[id=fieldCdC]").val()==""){
                alert("분야를 선택해 주세요.");
                $("#fieldCdC").focus();
                return;
            }
            
            if($("#metaDescV").val().split(' ').join('') == ""){
            	alert("설명을 입력해 주세요.");
            	$("#metaDescV").focus();
            	return;
            }
            
            if($("#openPublicD").val().split(' ').join('') == ""){
            	alert("공개일자를 입력해 주세요.");
            	$("#openPublicD").focus();
            	return;
            }
            
	        $("#dataForm").ajaxSubmit({
	            url      : "PD_updateDataPopAction.do",
	            type     : "POST",	            
	            success  : function(response) {
	                if (response) {
	                    jsMessage(response.message);
	                    parent.jsSearch();
	                } else { 
	                    jsMessage(response.message);
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
    <div id="popup" style="width:680px;">
        <form name="dataForm"id="dataForm" enctype="multipart/form-data" method="post">
        <!-- 기본정보 -->
        <h2 class="mar_t20">
	        	데이터 수정
        </h2>
        <fieldset>
        <legend>데이터 수정</legend>
        <font color="red">*</font> 는 필수 입니다.
        <table id="metaFromTab" class="boardWrite" cellspacing="0" border="1" summary="메타폼 등록 입니다.">
            <caption class="hidden"> 데이터수정 </caption>
            <colgroup>
                <col width="20%" />
                <col width="15%" />
                <col width="40%" />
                <col width="25%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>메타데이타명</th>
                    <td colspan="3">
                    	<input type="text" 		name="metaTitleV" 		id="metaTitleV"  		value="${ dataFormDetail.metaTitleV }" size="70"/>
                    	<input type="hidden"	name="metaDataFormSeqN" id="metaDataFormSeqN" 	value="${ dataFormDetail.metaDataFormSeqN }"/>
                    	<input type="hidden"	name="metaMasterNmV" 	id="metaMasterNmV" 		value="${ metaMasterDetail.metaMasterNmV }"/>
                    	<input type="hidden" 	name="metaMasterSeqN" 	id="metaMasterSeqN" 	value="${ metaMasterDetail.metaMasterSeqN }" />
                    </td>
                </tr>
                <tr>
                    <th>분야</th>
                    <td colspan="3">
                    	<select name="fieldCdC" id="fieldCdC">
                    	<option>선택하세요.</option>
                    	<c:forEach items="${fieldList}" var="fieldList">
                    	<option value="${ fieldList.prvCd }" <c:if test="${ fieldList.prvCd eq dataFormDetail.fieldCdC  }">selected</c:if>>${ fieldList.prvNm }</option>
                    	</c:forEach>
                    	</select>                      	
                    </td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td colspan="3">
                    	<input type="text" name="metaDescV" id="metaDescV" size="70" value="${ dataFormDetail.metaDescV }"/>                    	
                    </td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td colspan="3">
                    	<select name="useYnC" id="useYnC">
                    	<option value="Y" <c:if test="${ dataFormDetail.useYnC eq 'Y' }">selected</c:if>>사용</option>
                    	<option value="N" <c:if test="${ dataFormDetail.useYnC ne 'Y' }">selected</c:if>>미사용</option>
                    	</select>                    	
                    </td>
                </tr>                
                <tr>
                    <th>공개일자</th>
                    <td colspan="3">
                    	<input type="text" name="openPublicD" id="openPublicD" size="30" value="${ dataFormDetail.openPublicD }"  class="w120" title="날짜선택"/>                    	
                    </td>
                </tr>
                <tr>
                    <th style="text-align:center;">속성명</th>
                    <th style="text-align:center;">속성코드</th>
                    <th style="text-align:center;">속성값</th>
                    <th style="text-align:center;">속성URL</th>                    
                </tr>
                <c:forEach items="${dataValDetailList}" var="dataValVO">
                <tr>
	               	<td>
	               		<!-- 메타데이터 일련번호  -->
	               		<input type="hidden" name="metaPropSeqN" id="metaPropSeqN" value="${dataValVO.metaPropSeqN}" />
	               		<c:if test="${dataValVO.requireYnC eq 'Y'}"><font color="red">*</font></c:if>
	               		<c:if test="${dataValVO.requireYnC eq 'N'}">&nbsp;</c:if> 
	               		${dataValVO.metaPropNameV}
	               	</td>
	               	<td>${dataValVO.metaPropCdV}</td>
	               	<td>
	               	<c:if test="${dataValVO.dataKindC eq '1001'}">
	               		<input type="text" name="propertyValueV" id="propertyValueV" value="${ dataValVO.propertyValueV }" size="42"/>
	               	</c:if>
	               	<c:if test="${dataValVO.dataKindC eq '1002'}">
	               		<textarea name="propertyValueV" id="propertyValueV" cols="33">${dataValVO.propertyValueV}</textarea>
	               	</c:if>
	               	<c:if test="${dataValVO.dataKindC eq '1003'}">
	               		<c:if test="${!empty dataValVO.propertyValueV}">
	               		<a href="${dataValVO.propertyValueV}" target="_blank">[이미지보기]</a><br/>
	               		</c:if>
	               		<input type="file" name="${dataValVO.metaPropSeqN}" id="${dataValVO.metaPropSeqN}" accept="jpg"/>
	               	</c:if>
	               	<input type="hidden" name="dataKindC" id="dataKindC" value="${dataValVO.dataKindC}" />
	               	</td>
	               	<td>
	               		<input type="text" name="propertyUrlV" id="propertyUrlV" value="${ dataValVO.propertyUrlV }" />
	               	</td>
            	</tr>     
            	</c:forEach>        
            </tbody>            
        </table>
        </fieldset>
         	<p class="tx_c mar_t20">
	         	<a href="#"><button class="blue" type="button" id="butMod">수정</button></a> 
	         	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
			</p>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>