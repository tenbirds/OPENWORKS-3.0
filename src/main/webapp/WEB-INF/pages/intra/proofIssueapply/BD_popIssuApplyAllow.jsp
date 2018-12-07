<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
	<title>이용실적증명서 신청승인</title>
	<op:jsTag type="openworks" items="ui, validate, form" />
	<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
	
	<script type="text/javascript">
	
	$().ready(function () {
	    
	    $("#dataForm").validate({
            rules: {
                pdfProfIssuFile : { required : true}
	           ,sndngDe         : { required : true}
            }
           ,invalidHandler: function(event, validator){
           
            }
        });
	    
	    $("#contents_area").css("width","420px");
	    $("#contents_area").css("min-width","350px");
        $(".loc_m").css("left","217px");
        $(".loc_m").hide();
        
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#sndngDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        }); 
	});
	
	var jsSaveAction = function()
	{
        if ($("#dataForm").valid() == false) return;

        $("#dataForm").ajaxSubmit({
            url      : "BD_popIssuApplyAllowSave.do",
            type     : "POST",
            async    : false,
            success  : function(response)
			           {
                		  alert(response);	
                		  parent.$.fn.colorbox.close();	
			           }
        });
    };
	
	
	
	</script>
	
</head>
<body>

	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
	
		<input type="hidden" name="rouSn" value="${rouSn}"/>
	
		<table class="boardWrite" summary="검색 조건">
	        <caption class="hidden"> 목록 </caption>
	        <colgroup>
	            <col width="25%"/>
	            <col width="*"/>
	        </colgroup>
	        <tbody id="odd-color">
	            <tr>
	                <th>파일등록</th>
	                <td>				
						<!-- file upload -->
						<span style="float:left;" id="bassAgrmntFileBtn"> 
						      
							 <input type="file" name="pdfProfIssuFile" id="pdfProfIssuFile"  title="업로드 할 파일을 선택하세요." accept=".pdf"
								   onchange="jsFileChk('','pdfProfIssuFile', 'bassAgrmntfileInput', 10240, '1','${dataVo.bassAgrmntFileSeq}', 1); "/>
						     
						     
						</span>			
						<!-- //file upload -->				
					</td>
	            </tr>
	            <tr>
	                <th>발송일</th>
	                <td>
						<input class="w120" type="text" name="sndngDe" id="sndngDe" title="발송일을 선택하세요" maxlength="10" />
					</td>
	            </tr>
	        </tbody>
	    </table>
    
    </form>
	
	<div style="position:relative;float:right;margin-top:20px;">
           <button class="blue" type="button" name="submits" id="submits" onclick="jsSaveAction();">저장</button>
           <button class="blue" type="button" name="cancel" id="cancel" onclick="parent.$.fn.colorbox.close();">취소</button>
    </div>
	        
</body>
</html>