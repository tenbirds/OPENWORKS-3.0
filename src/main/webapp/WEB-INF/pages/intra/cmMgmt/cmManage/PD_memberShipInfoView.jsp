<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>커뮤니티 회원 정보</title>
	<style type="text/css">
#containerLogo {position:relative; width:999px; height:170px; margin:0 auto; overflow:hidden}
#containerLogoTitle img {position:absolute; top:0; left:0} 
#containerLogo .result > * {position:absolute;}
 #containerLogo .result .inertxt {line-height:normal; }
	</style>
   <op:jsTag type="spi" items="jquery, form, notice, validate, ui, colorbox" />
	<op:jsTag type="openworks" items="ui" />
	<script type="text/javascript">
		//<![CDATA[
           
           	$(document).ready(function(){	

			});


    		var jsTrShowHide = function (fn){

    		    if(fn == "N"){
    	 	   		$("#logoT_1").show();
    		 	   	$("#logoT_2").hide();
    		    }else if(fn == "Y"){
    	 	   		$("#logoT_1").hide();
    		 	   	$("#logoT_2").show();
        		}
    		 	   
    		};
	</script>       	
</head>
<body>
<!-- 컨텐츠영역 -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="userId" name="userId" value="<c:out value="${cmMemberShipInfoView.cmmntyMberId}"/>" />
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmMemberShipInfoView.cmmntyId}"/>" />
		
	<div id="popup">
	
	<!-- 기본정보 -->
<!-- 
	     model.addAttribute("userEntrprsOption", cmManageService.userEntrprsOptionSelect(vo)); // 기업회원 추가 정보 // 2001    기업회원     2002    기업판매회원
         model.addAttribute("userOption", cmManageService.userOptionSelect(vo)); // 일반회원 추가 정보 //  1001 개인회원     1002 개인판매회원 
         일반회원등급	generalMber	관심회원등급	attentionMber		불량회원등급	badnessMber		블랙회원등급	BlackMber--> 
		<h2 class="mar_t20">개인</h2>
		<fieldset>
		<legend>커뮤니티 개인 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="신청자 기본 정보">
            		<caption class="hidden"> 커뮤니티 개인 정보</caption>
			<colgroup>
			  <col width="39%" />
			  <col width="61%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>구분</span></th>
					<td><span>
					<c:if test="${cmMemberShipInfoView.nationCode == '401' }">국내기업</c:if><c:if test="${cmMemberShipInfoView.nationCode != '401'}">외국기업</c:if></span></td>
				</tr>
				<tr>
					<th><span>아이디</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.cmmntyMberId}"/></span></td>
				</tr>
				<tr>
					<th><span>이름</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.userNm}"/></span></td>
				</tr>
				<tr>
					<th><span>닉네임</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.ncnm}"/></span></td>
				</tr>
              	<tr>
					<th><span>전화번호</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.telno}"/></span></td>
				</tr>
				<tr>
					<th><span>휴대전화</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.mbtlnum}"/></span></td>
				</tr>
				<tr>
					<th><span>이메일 주소</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.email}"/></span></td>
				</tr>
			</tbody>
          </table>
        </fieldset>
        <h2 class="mar_t20">회사</h2>
        <fieldset>
		<legend>회사 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="회사 정보">
            		<caption class="hidden"> 회사 정보 </caption>
			<colgroup>
			  <col width="39%" />
			  <col width="61%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>회사명</span></th>
					<td><span>
					<c:if test="${openCmManageView.userTyCd == '1001' ||  openCmManageView.userTyCd == '1002'}"><c:out value="${userOption.cmpnyNm}"/></c:if>
					<c:if test="${openCmManageView.userTyCd == '2001' ||  openCmManageView.userTyCd == '2002'}"><c:out value="${userEntrprsOption.cmpnyNm}"/></c:if>
					</span></td>
				</tr>
				<tr>
					<th><span>회사 대표번호</span></th>
					<td><span><c:if test="${openCmManageView.userTyCd == '1001' ||  openCmManageView.userTyCd == '1002'}"><c:out value="${userOption.cmpnyReprsntTelno}"/></c:if>
					<c:if test="${openCmManageView.userTyCd == '2001' ||  openCmManageView.userTyCd == '2002'}"><c:out value="${userEntrprsOption.cmpnyReprsntTelno}"/></c:if></span></td>
				</tr>
				<tr>
					<th><span>회사 이메일 주소</span></th>
					<td><span><c:if test="${openCmManageView.userTyCd == '1001' ||  openCmManageView.userTyCd == '1002'}"><c:out value="${userOption.cmpnyEmail}"/></c:if>
					<c:if test="${openCmManageView.userTyCd == '2001' ||  openCmManageView.userTyCd == '2002'}"><c:out value="${userEntrprsOption.cmpnyEmail}"/></c:if></span></td>
				</tr>
			</tbody>
         	</table>
        </fieldset>
       <h2 class="mar_t20">활동</h2>
        <fieldset>
		<legend>활동 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="회사 정보">
            		<caption class="hidden"> 활동 정보 </caption>
			<colgroup>
			  <col width="39%" />
			  <col width="61%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>가입일</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.sbscrbReqstDt}"/></span></td>
				</tr>
				<tr>
					<th><span>최종방문일</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.visitDt}"/></span></td>
				</tr>
				<c:if test="${cmMemberShipInfoView.mberStateCd == '1004' }">
				<tr>
					<th><span>탈퇴일</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.secsnDt}"/></span></td>
				</tr>
				<tr>
					<th><span>탈퇴 구분</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.enfrcSecsnNm}"/></span></td>
				</tr>
				</c:if>
				<tr>
					<th><span>방문수</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.cmVisitCount}"/></span></td>
				</tr>
				<tr>
					<th><span>작성글</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.cmMberBbsCount}"/></span></td>
				</tr>
				<tr>
					<th><span>댓글수</span></th>
					<td><span><c:out value="${cmMemberShipInfoView.cmMberBbsCmtCount}"/></span></td>
				</tr>
			</tbody>
         	</table>
        </fieldset>
        <p class="tx_c mar_t20">
        <div>
           <div>
           		<div class="float_r">
				<a href="#" class="btn"><button type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
				</div>
          </div>
		</div>
		</p>
	</div>
	</form>
</body>
</html>