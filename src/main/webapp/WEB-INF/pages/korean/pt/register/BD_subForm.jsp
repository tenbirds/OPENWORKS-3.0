<%@page import="zes.core.lang.Validate"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>서브등록</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript">
	$().ready(function(){
	    $("#subForm").validate({
            rules: {
                userId				: { required : true }
	    	,	userNm             : { required: true }
	    	,	email             : { required: true }
// 	    	,	cmpnyBuseo			: { required: true }
            },
            submitHandler : function(form){
                $(form).ajaxSubmit({
                        url    : "BD_updateSubForm.do",
                        type : "POST",
                        dataType : "text",
                        success : function(response){
                            if (response == "true")  {
                                alert("등록되었습니다.");
                                self.location.href="BD_subList.do";
	                  		} else { 
	                  		  alert("등록이 실패했습니다.");
	        		               	return;
	                  		}
                       }
                });
            }
        });
	});//ready end
	
	var updateSubForm = function(){
	    if(!$("#userId").val()){
	        alert("회원을 선택해주세요");
	        return;
	    }
	    $("#subForm").submit();
	}
	
	var searchUser = function(el){
        $(el).colorbox({
            title  : "회원검색하기",
            href   : "PD_searchUser.do",
            width  : "680",
            height : "350",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
	}
</script>
</head>
<body>
<div class="join_info inputOffer">
<!-- <div class="supAdm subRegi"> -->
	<form id="subForm" name="subForm">		
				<p class="requ_info"><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>
				
				<h4>개인정보</h4>
				
				<table class="tbl_st4">
					<tr>
						<th class="requ">회원찾기</th>
						<td><a href="#" id="srhUser" onclick="searchUser(this);" class="btns st3"> 검 색 </a></td>
					</tr>
					<tr>
						<th class="requ">회원 ID</th>
						<td><input type="text" id="userId" name="userId" readonly="readonly"/></td>
					</tr>
					<tr>
						<th class="requ">이름</th>
						<td><input type="text" id="userNm" name="userNm" readonly="readonly"/></td>
					</tr>
					<tr>
						<th class="requ">이메일</th>
						<td><input type="text" id="email" name="email" readonly="readonly"/></td>
					</tr>
				</table>
				
				<h3>소속정보</h3>
				<table class="tbl_st4">
					<tr>
						<th>부서(팀)명</th>
						<td><input type="text" id="cmpnyBuseo" name="cmpnyBuseo"/></td>
					</tr>
				</table>
				
				<div class="btnArea rig">
					<a href="#"  onclick="updateSubForm(this);" class="btns st1 icn icnSave">저 장</a>
					<a href="BD_subList.do" class="btns st1 icn icnList">목록보기</a>
				</div>

			
		</form>	
</div>		
</body>
</html>