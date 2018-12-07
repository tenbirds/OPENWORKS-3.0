<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원검색</title>
    <op:jsTag type="openworks" items="web-core"/>
    <op:jsTag type="spi" items="form,validate,colorbox" />
    <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript">
	$().ready(function(){

    });
    var jsCancel = function() {
        parent.$.fn.colorbox.close();
    }
    var jsSearch = function(){
        if($("#userId").val() == ''){
            alert("아이디를 입력해주세요");
            return false;
        }
        if($("#email1").val() == '' || $("#email2").val() == ''){
            alert("이메일을 입력해주세요");
            return false;
        }
        if($("#email1").val() != '' && $("#email2").val() != ''){
            $("#email").val($("#email1").val().trim()+"@"+$("#email2").val().trim());
            var regExp = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$" ;
            if(!$("#email").val().match(regExp)){
                alert("이메일형식이 맞지 않습니다");
                return false;
            }
        }
		
        document.searchUserForm.action = "PD_searchUserList.do";
        document.searchUserForm.submit();
    }
 	
    var jsMemberSelect = function(userId,userNm,email){
	     if ( confirm("회원을 선택하시겠습니까?")) {
	         parent.$("#userId").val(userId);
	         parent.$("#userNm").val(userNm);
	         parent.$("#email").val(email);
             parent.$.fn.colorbox.close();
             parent.jsCtgrySel();
	 	}
   }
    </script>
</head>
<body class="winPopup buying">
	<form id="searchUserForm" name="searchUserForm">
        <input type="hidden" name="masterId"   id="masterId" value="<c:out value="${dataVo.userId}" />"/>
	<h2>회원검색 <a href="#" onclick="jsCancel();">닫기</a></h2>
	<div>
		<table class="tbl_st4 e4">
			<tr>
				<th>회원 ID</th>
				<td><input type="text" id="userId" name="userId"/></td>						
			</tr>					
			<tr>
				<th>회원이메일</th>
				<td class="email">
					<input type="text"  id="email1" name="email1"/> @ <input type="text"  id="email2" name="email2"/>
					<input type="hidden"  id="email" name="email"/>
					<a href="#" onclick="jsSearch();return false;" class="btns st3"> 조 회 </a>
				</td>
			</tr>					
		</table>
		
		<h3>선택된 기업</h3>
		<table class="tbl_st1">
			<thead>
				<tr>
					<th>회원 ID</th>
					<th>회원 명</th>
					<th>선택</th>					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userList}" var="data" >
				<tr>
					<td><c:out value='${data.userId}'/></td>
					<td><c:out value='${data.userNm}'/></td>
					<td><a href="#" class="btns st3" onclick="jsMemberSelect('${data.userId}','${data.userNm}','${data.email}');">선택</a></td>
				</tr>
				</c:forEach>
				<c:if test="${empty userList}">
					<tr>
						<td colspan="11">등록된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</form>
 </body>
</html>