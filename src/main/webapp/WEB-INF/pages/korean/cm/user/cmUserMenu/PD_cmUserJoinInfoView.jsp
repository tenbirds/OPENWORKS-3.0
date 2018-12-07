<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 회원 <c:if test="${mberStateCd == '1003' || mberStateCd == '1000'}">정보</c:if><c:if test="${mberStateCd != '1003' }">가입</c:if></title>
	<op:jsTag type="openworks" items="cmweb-core"/>
	<op:jsTag type="spi" items="notice, form" />
	<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/style.css" />
	<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
	<script type="text/javascript">
	
	$(document).ready(function() {

	});
	
	 // 중복확인 버튼 클릭 이벤트
    var jsDulCheckAction = function (check) {
        var ncnm = $("#ncnm").val();
        var cmmntyId = $("#cmmntyId").val();
        var oldncnm = $("#oldncnm").val();
            if(ncnm == ""){
//                 alert("커뮤니티 닉네임을 입력해주세요.");
               alert(Message.msg.chkCmNcnmForm);
  	     	   $("#ncnm").focus();
  	     	   return;
  	     	}else if(ncnm != ""){
  		     	 if(!checkFilter(ncnm)){  
  		               $("#ncnm").focus(); 
  		               $("#ncnm").val(""); 
  		               return;
  		          }
  	     	}
            if(oldncnm == ncnm){
                if(confirm("같은 닉네임 "+ncnm+" 을 그대로 사용하시겠습니까?")){
                    $("#ncnm").val(oldncnm);
                    $("#ncnmCheck").val("Y");
                }
           }else{
		    	$.ajax({
		            url      : "INC_cmNcnmCheck.do",
		            type     : "POST", 
		            data     : {  ncnm : ncnm, cmmntyId : cmmntyId},
		            async    : false,  //false 일 경우 동기로 요청한다는 뜻임. async 비동기
		            success  : function (response) {
		                if (response != "0") {
		                	//alert("사용 할 수 없는 커뮤니티 닉네임입니다. \n 다시 입력해주십시오. \n "+ ncnm);
		                	alert(Message.msg.chkCmNcnmFail+  "\n"+ncnm);
		                    $("#ncnm").focus();
		                } else {
	// 	                    alert("사용 가능한 커뮤니티 닉네임입니다. \n" + ncnm);
		                    alert(Message.msg.chkCmNcnmOk+ "\n"+ncnm);
		                    $("#ncnmCheck").val("Y");
		                }
		            }
		        });
           }
    	};
    	
   	 var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	 };
	 // 특수 문자 입력 체크  
	 var checkFilter =    function (cmid){
		 var chkId = blankTrim(cmid);
		 var chktext = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
		 if(chktext.test(chkId)){
		     
		     alert(chkId+Message.msg.chkCmOpenFormSpecial);
		     //alert(chkId+" 특수문자는 입력하실 수 없습니다.");
		     return false;
		 }
		 return true;
	};
	// 공백 체크
	var blankTrim = function (name){
		return name.replace(/(\s*)/g, "");
	};
	
	 // 커뮤니티 회원 가입
	   var jsMemberSave = function(){
	       var parentUrl = parent.document.URL;
	     var mberStateCd = $("#mberStateCd").val();
	     var movepage = ""; 
	     if(validation.dataForm() === false){
	        return;
	   	 }
	    
	     if(mberStateCd == "1004"){
	         movepage = "INC_cmMemberShipJoinUpdate.do";
	     }else if(mberStateCd == "1003"){
	         movepage = "INC_cmMemberShipJoinUpdate.do";
	     }else{
	         movepage = "INC_cmMemberShipJoinInsert.do";
	     }
	     if(mberStateCd == "1003"){
	         if ( confirm("커뮤니티 회원 정보를 수정하시겠습니까?")) {
		         $("#dataForm").ajaxSubmit({
			        url      : movepage,
			        type     : "POST",
			        dataType : "text",
			        success  : function(response) {
	        			if (response == "true")  {
			                alert("커뮤니티 회원 정보가 수정되었습니다.");
			          		jsCloseWin();
			          		parent.location.reload(parentUrl);
	            		} else { 
	            		    alert("커뮤니티 회원 정보 수정 중 오류가 발생했습니다.");
			               	return;
	            		}
	       			}
	    		});
	         }
	       }else{
	         if ( confirm("커뮤니티 회원 가입 하시겠습니까?")) {
	             //alert(parent.document.URL);
	             
		         $("#dataForm").ajaxSubmit({
			        url      : movepage,
			        type     : "POST",
			        dataType : "text",
			        success  : function(response) {
	        			if (response == "true")  {
			                alert("커뮤니티 회원 가입 되었습니다.");
			                jsCloseWin();
			                parent.location.reload(parentUrl);
	            		} else { 
	            		    alert("커뮤니티 회원 가입 중 오류가 발생했습니다.");
			               	return;
	            		}
	       			}
	    		});
	         }
		    }
	  };
	  
		//글자수체크
	    var displayBytes2  = function ( rm, nm, id ){
	        var obj  = document.getElementById( id );
	            if (obj.value.bytes() > nm){
	                if (event.keyCode != '8'){
	                    //alert(nm+'바이트까지 입력이 가능합니다.');
	                    alert(nm+Message.msg.chkFormByteUntill );
	                }
	                obj.value = obj.value.substring(0, obj.value.length-10);
	            }else if(obj.value.bytes() < 4 && obj.value.bytes() > 0){
	                
	                //alert(rm+'바이트이상 입력하세요.');
	                alert(nm+Message.msg.chkFormByteOver );
	            } 
	            //eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
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
	    
	    var validation = {     
                /** ajax submit validation **/
        		   dataForm : function() {
       	            var oldncnm = $("#oldncnm").val();
    	            var ncnm = $("#ncnm").val();
        		       /** 지역변수 **/
        		        if(oldncnm != ncnm || ncnm =="" ){
	        		       if($("#ncnmCheck").val() == ""){
	        		           	//alert("커뮤니티 닉네임 사용가능 여부를 체크하셔야 합니다.");
	        		           	alert(Message.msg.chkCmNcnmFormCheck);
	                           	$("#ncnm").focus();
	        		            return false;
	        		       }
        		        }
        		      
        		   }
        	};

	</script>
</head>
<body>

<!-- 팝업 윈도우 크기 width:778px  -->
	<div id="pop_wrap">
	
		<div class="pop_container">
			<!-- popup header -->
			<div class="header">
				<h1>커뮤니티 <c:if test="${mberStateCd != '1003' }">가입 </c:if>정보</h1>
			</div>
			<!-- //header -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmmntyId}"/>" />
		<input type="hidden" id="cmmntySbscrbMthd" name="cmmntySbscrbMthd" value="<c:out value="${cmmntySbscrbMthd}"/>" /> 
		<input type="hidden" id="mberStateCd" name="mberStateCd" value="<c:out value="${mberStateCd}"/>" /> 
		<input type="hidden" id="ncnmCheck"  name="ncnmCheck" value="" />
		<input type="hidden" id="oldncnm"  name="oldncnm"  value="<c:out value="${cmUserMberInfo.ncnm}"/>"/>
			<!-- popup content -->
			<div class="section">
				<p><h2>개인</h2></p>
				</br>
				<table class="tbl_pop">
				<colgroup>
					<col style="width:20%;">
					<col style="width:65%;">
					<col >
				</colgroup>
				<tbody>
					<tr>
						<td class="tit">구분</td>
						<td ><c:if test="${userDefaultInfo.nationCode == '401' }">국내기업</c:if><c:if test="${userDefaultInfo.nationCode != '401'}">외국기업</c:if></td>
						<td>공개</td>
					</tr>
					<tr>
						<td class="tit">아이디</td>
						<td ><c:out value="${userDefaultInfo.userId}"/></td>
						<td><input type="checkbox" id="idOthbcAt" name="idOthbcAt" <c:if test="${cmUserMberInfo.idOthbcAt == 'N'}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr>
					<tr>
						<td class="tit">이름</td>
						<td ><c:out value="${userDefaultInfo.userNm}"/></td>
						<td><input type="checkbox" id="nmOthbcAt" name="nmOthbcAt" <c:if test="${cmUserMberInfo.nmOthbcAt == 'N' || empty cmUserMberInfo.nmOthbcAt}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr>
				<c:if test="${mberStateCd != '1000'}">
					<tr>
						<td class="tit">닉네임</td>
						<td ><input type="text" id="ncnm" name="ncnm" title="커뮤니티 이름 입력" value="<c:out value="${cmUserMberInfo.ncnm}"/>" style="width:300px;" onblur="javascript:displayBytes2(4, 15,'ncnm');" />
								<img id="ncnmCheckBut" name="ncnmCheckBut"  src="/resources/web/theme/default/images/btn/btn_use_check.gif" alt="사용가능체크" onclick="jsDulCheckAction('1');"  style="cursor: pointer;"/></td>
						<td>공개</td>
					</tr>
				</c:if>
	              	<%-- <tr>
						<td class="tit">전화번호</td>
						<td ><c:out value="${userDefaultInfo.telno}"/></td>
						<td><input type="checkbox" id="telnoOthbcAt" name="telnoOthbcAt" <c:if test="${cmUserMberInfo.telnoOthbcAt == 'N' || empty cmUserMberInfo.telnoOthbcAt}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr> --%>
					<tr>
						<td class="tit">휴대전화</td>
						<td ><c:out value="${userDefaultInfo.mbtlnum}"/></td>
						<td><input type="checkbox" id="mbtlnumOthbcAt" name="mbtlnumOthbcAt" <c:if test="${cmUserMberInfo.mbtlnumOthbcAt == 'N' || empty cmUserMberInfo.mbtlnumOthbcAt}">checked="checked"</c:if>" value="N"/>비공개</td>
					</tr>
					<tr>
						<td class="tit">이메일 주소</td>
						<td ><c:out value="${userDefaultInfo.email}"/></td>
						<td><input type="checkbox" id="emailOthbcAt" name="emailOthbcAt" <c:if test="${cmUserMberInfo.emailOthbcAt == 'N' || empty cmUserMberInfo.emailOthbcAt}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr>
				</tbody>
				</table>
				<br/>
				<p><h2>회사</h2></p>
				</br>
				<table class="tbl_pop">
				<colgroup>
					<col style="width:20%;">
					<col style="width:65%;">
					<col >
				</colgroup>
				<tbody>
					<tr>
						<td class="tit">회사명</td>
						<td ><c:out value="${userDefaultInfo.cmpnyNm}"/></td>
						<td><input type="checkbox" id="cmpnyNmOthbcAt" name="cmpnyNmOthbcAt" <c:if test="${cmUserMberInfo.cmpnyNmOthbcAt == 'N' || empty cmUserMberInfo.cmpnyNmOthbcAt}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr>
					<tr>
						<td class="tit">회사 대표번호</td><!-- Reprsnt -->
						<td ><c:out value="${userDefaultInfo.cmpnyTelno}"/></td>
						<td><input type="checkbox" id="reprsntTelnoOthbcAt" name="reprsntTelnoOthbcAt" <c:if test="${cmUserMberInfo.reprsntTelnoOthbcAt == 'N' || empty cmUserMberInfo.reprsntTelnoOthbcAt}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr>
					<%-- <tr>
						<td class="tit">회사 이메일 주소</td>
						<td ><c:out value="${userDefaultInfo.cmpnyEmail}"/></td>
						<td><input type="checkbox" id="cmpnyEmailOthbcAt" name="cmpnyEmailOthbcAt" <c:if test="${cmUserMberInfo.cmpnyEmailOthbcAt == 'N' || empty cmUserMberInfo.cmpnyEmailOthbcAt}">checked="checked"</c:if> value="N"/>비공개</td>
					</tr> --%>
				</tbody>
				</table>
				<br/>
				<c:if test="${mberStateCd == '1003' || mberStateCd == '1000'}">
				<p><h2>활동</h2></p>
		        <table class="tbl_pop">
				<colgroup>
					<col style="width:20%;">
					<col>
				</colgroup>
				<tbody>
				<c:if test="${mberStateCd == '1003'}">
					<tr>
						<td class="tit">가입일</td>
						<td ><c:out value="${cmUserMberInfo.sbscrbReqstDt}"/></td>
					</tr>
				</c:if>
					<tr>
						<td class="tit">최종방문일</td>
						<td><c:out value="${userVisitSelete.visitDt}"/></td>
					</tr>
					<tr>
						<td class="tit">방문수</td>
						<td><c:out value="${userVisitCount}"/></td>
					</tr>
					<tr>
						<td class="tit">작성글</td>
						<td><c:out value="${userBBS}"/></span></td>
					</tr>
					<tr>
						<td class="tit">댓글수</td>
						<td><c:out value="${userCMT}"/></td>
					</tr>
					</tbody>
		         </table>
		         </c:if>
				<div class="btn_area">
					<div class="btn_pop_c">						
						<div class="btn_navi">
						<c:if test="${mberStateCd != '1003' && mberStateCd != '1000'}">
							<a href="#none" onclick="jsMemberSave();"><span class="join">가입신청</span></a>
						</c:if>
						<c:if test="${mberStateCd == '1003'}">
						<a href="#none" onclick="jsMemberSave();"><span class="join">적용</span></a>
						</c:if>
						</div>
						<div class="btn_navi_g">
							<a href="#none" onclick="jsCloseWin();" ><span class="cancel">닫기</span></a>
						</div>
					</div>
				</div>
			</div>
			<!-- //popup content -->
	</form>
			<a class="w_close" href="#close" onclick="jsCloseWin();">
				<span>닫기</span>
			</a>
		</div>
	</div>
</body>
</html>
