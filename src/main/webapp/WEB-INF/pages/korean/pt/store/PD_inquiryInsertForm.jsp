<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="zes.openworks.web.store.StoreincVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>문의하기 등록</title>

<op:jsTag type="openworks" items="store-core" />
<op:jsTag type="spi" items="form,validate" />
<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />

<script type="text/javascript">
     
    $().ready(function () {
    
        parent.calcHeight('inquiryFrame');
        $("#dataForm").validate({
            rules: {
                inqrySj               :        { required:true,maxByte:100},
                inqryCn               :        { required:true,maxByte:2000 },
                answerRecptnEmail     :        { required:true,email:true,maxByte:50}
            },
            messages : {
                inqrySj : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                inqryCn : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)")},
                answerRecptnEmail : {maxByte : jQuery.format("{0} Byte를 초과할 수 없습니다. (한글:3byte, 영문:1byte)"),
                                     email: "'@'문자가 표현된 이메일 주소를 입력하세요. [ex:tester@abc.com]"
                    }
            },
            submitHandler : function(form) {
                var dataForm = parent.$("#dataForm");
                 $(form).ajaxSubmit({
                        url : "ND_inquiryInsertAction.do",
                        type : "POST",
                        dataType : "text",
                        data : {
                            userId : dataForm.find("#userId").val(),
                            langCode: dataForm.find("#langCode").val(),
                            goodsCode: dataForm.find("#goodsCode").val(),
                            inqrId: '${userSession}'
                        },
                        success : function(response){                            
                            try {
                                if(response == "<%=StoreincVO.MSG.INSERT_OK%>") {
	                                alert(Message.msg.incInquiryInsertOk );
	                                location.href="INC_inquiry.do?tab=inquiry&goodsCode="+dataForm.find("#goodsCode").val();
	                            } else {
	                                alert(Message.msg.processFail);
	                            }
                        	} catch(e) {
                            	alert(e);
                            	return;
                        	}
                    }
                });
            }
        });

    }); //ready end
    
    var jsList = function(){        
        var pdataForm = parent.$("#dataForm");
        //alert( "INC_inquiry.do?goodsCode="+pdataForm.find("#goodsCode").val());
        document.dataForm.action = "INC_inquiry.do?goodsCode="+pdataForm.find("#goodsCode").val();
        document.dataForm.submit();
    }
    
</script>
</head>
<body class="winPopup qna">

	<form id="dataForm" name="dataForm" method="post">
	<input type="hidden" name="tab" value=inquiry>
	<input type="hidden" name="q_currPage" id="q_currPage" value="1" />
	<input type="hidden" name="q_pagePerPage" id="q_pagePerPage" value="10" />
	<input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="10" />
		
		<!-- <div class="btn-area ar">
			<a href="#" onclick="jsList('1');"  class="b-btn mr10 list type1"><strong><span>목록</span></strong></a>
		</div> -->
			
		<!-- Q&amp;A 쓰기 --> 
		<table class="tbl_st4 qnaWrite">
			<tr>
				<th>제목</th>
				<td><input type="text" id="inqrySj" name="inqrySj" title="문의하기 제목을 입력하세요"  /></td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td>
					<textarea name="inqryCn" id="inqryCn" title="문의하기 내용을 입력해 주세요" ></textarea>
				</td>
			</tr>
			<tr>
				<th>답변수신메일</th>
				<td><input type="text" id="answerRecptnEmail" name="answerRecptnEmail" title="이메일 주소를 입력하세요"/></td>
			</tr>
			<tr>
				<th>공개여부</th>
				<td>
					<input type="radio" id="othbcAt_N" name="othbcAt" value="N" checked="checked" /> <label for="open_y">공개</label>
					<input type="radio" id="othbcAt_Y" name="othbcAt" value="Y"/> <label for="open_n">비공개</label>
				</td>
			</tr>							
		</table> 
		<div class="btnArea cen">
			<input type="reset" onclick="history.back(-1);"  value="취소" class="btns st2" />
			<input type="submit" value="문의하기" class="btns st1" id="submitClick" />
		</div>		
  </form>
</div>  
  
</body>
</html>
