<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>메타데이터 등록</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript">
//<CDATA[[
    $(document).ready(function(){
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#openPublicD').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
                
        $("#butSave").click(function(){  
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
	            url      : "PD_insertDataPopAction.do",
	            type     : "POST",	            
	            success  : function(response) {
	                if (response) {
	                    jsMessage(response);
	                    parent.jsSearch();
	                } else { 
	                    jsMessage(response);
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
    <div id="contents" style="width:680px;">
        <form id="dataForm" enctype="multipart/form-data" method="post">
        <!-- 기본정보 -->
        <h2 class="mar_t20">
	    	데이터등록
        </h2>
        <fieldset>
        <legend>메타정보등록</legend>
        <font color="red">*</font> 는 필수 입니다.
        <table id="metaFromTab" class="boardWrite" cellspacing="0" border="1" summary="메타폼 등록 입니다.">
            <caption class="hidden"> 데이터등록 </caption>
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
                    	<input type="text" name="metaTitleV" id="metaTitleV" size="70"/>
                    	<input type="hidden"	name="metaMasterNmV" 	id="metaMasterNmV" 	value="${ metaMasterDetail.metaMasterNmV }" size="60"/>
                    	<input type="hidden" 	name="metaMasterSeqN" 	id="metaMasterSeqN" value="${ metaMasterDetail.metaMasterSeqN }" />
                    	<input type="hidden" 	name="useYnC" 			id="useYnC"		 	value="${ metaMasterDetail.useYnC }" />
                    	<input type="hidden" 	name="propertySeqN"		id="propertySeqN" 	value="${ metaPropertyDetail.propertySeqN }" />
                    	<input type="hidden" 	name="property"			id="property" 		value="${ metaPropertyDetail.property }" />
                    	<input type="hidden" 	name="propertyTypeC"	id="propertyTypeC" 	value="${ metaPropertyDetail.propertyTypeC }" />
                    </td>
                </tr>
                <tr>
                    <th>분야</th>
                    <td colspan="3">
                    	<select name="fieldCdC" id="fieldCdC">
                    	<option value="">선택하세요.</option>
                    	<c:forEach items="${fieldList}" var="fieldList">
                    	<option value="${ fieldList.prvCd }">${ fieldList.prvNm }</option>
                    	</c:forEach>
                    	</select>                   	
                    </td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td colspan="3">
                    	<input type="text" name="metaDescV" id="metaDescV" size="70"/>                    	
                    </td>
                </tr>                
                <tr>
                    <th>공개일자</th>
                    <td colspan="3">	                    	
                    	<input type="text" name="openPublicD" id="openPublicD" size="30" class="w120" title="날짜선택"/>                    	
                    </td>
                </tr>
                <tr>
                    <th style="text-align:center;">속성명</th>
                    <th style="text-align:center;">속성코드</th>
                    <th style="text-align:center;">속성값</th>
                    <th style="text-align:center;">속성URL</th>                    
                </tr>
                <c:forEach items="${metaValList}" var="metaValVO">
                <tr>
	               	<td>
	               		<input type="hidden" name="metaPropSeqN" id="metaPropSeqN" value="${metaValVO.metaPropSeqN}" />
	               		<c:if test="${metaValVO.requireYnC eq 'Y'}"><font color="red">*</font></c:if>
	               		<c:if test="${metaValVO.requireYnC eq 'N'}">&nbsp;</c:if> 
	               		${metaValVO.metaPropNameV}
	               	</td>
	               	<td>${metaValVO.metaPropCdV}</td>
	               	<td>
	               		<c:if test="${metaValVO.dataKindC eq '1001'}">
	               		<input type="text" name="propertyValueV" id="propertyValueV" size="42"/>
	               		</c:if>
	               		<c:if test="${metaValVO.dataKindC eq '1002'}">
	               		<textarea name="propertyValueV" id="propertyValueV" cols="33"></textarea>	               		
	               		</c:if>	               		
	               		<c:if test="${metaValVO.dataKindC eq '1003'}">
	               		<input type="file" name="${metaValVO.metaPropSeqN}" id="${metaValVO.metaPropSeqN}" accept="jpg"/>
	               		</c:if>
	               		<input type="hidden" name="dataKindC" id="dataKindC" value="${metaValVO.dataKindC}" />
	               	</td>
	               	<td>
	               		<input type="text" name="propertyUrlV" id="propertyUrlV" value=""/>
	               	</td>
            	</tr>     
            	</c:forEach>        
            </tbody>            
        </table>
        </fieldset>
       	<p class="tx_c mar_t20">
         	<a href="#"><button class="blue" type="button" id="butSave">저장</button></a> 
         	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">목록</button></a>
		</p>
        </form>
    </div>
    <!-- 컨텐츠영역 -->
</body>
</html>