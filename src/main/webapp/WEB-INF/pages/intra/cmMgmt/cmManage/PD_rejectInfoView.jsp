<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<html>
<head>
	<title>커뮤니티 거절 정보</title>
	<style type="text/css">
#containerLogo {position:relative; width:990px; height:230px; margin:0 auto; overflow:hidden}
#containerLogoTitle img {position:absolute; top:0; left:0} 
#containerLogo .result > * {position:absolute;}
 #containerLogo .result .inertxt {line-height:normal; }
	</style>
   <op:jsTag type="spi" items="jquery, form, notice, validate, ui, multifile, colorbox, colorpicker" />
	<op:jsTag type="openworks" items="ui" />
	<script type="text/javascript">
		//<![CDATA[
           
           	$(document).ready(function(){	
           	    
        		
			});

    	    //////////////////////////////////////////////////////////// 
         	//]]>
	</script>       	
</head>
<body>
<!-- 컨텐츠영역 -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="userId" name="userId" value="<c:out value="${openCmManageView.userId}"/>" />
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${openCmManageView.cmmntyId}"/>" />
		<input type="hidden" id="cmmntySttusCd" name="cmmntySttusCd" value="<c:out value="${openCmManageView.cmmntySttusCd}"/>" /> 
		<input type="hidden" name="logoTitleWidthLc" value="<c:out value="${openCmManageView.logoTitleWidthLc}" default="0" />" />
		<input type="hidden" name="logoTitleVrticlLc" value="<c:out value="${openCmManageView.logoTitleVrticlLc}" default="0" />" />   
		
		<input type="hidden" id="cmmntyNmCheck"  name="cmmntyNmCheck" value="Y" />
		<input type="hidden" id="cmmntyUrlCheck"  name="cmmntyUrlCheck" value="Y" />
		
		<input type="hidden" name="inputName" id="inputName" value=""/>
		<input type="hidden" name="maxFileSize" id="maxFileSize" value=""/>
		<input type="hidden" name="maxWidthSize" id="maxWidthSize" value=""/>
		<input type="hidden" name="maxHeightSize" id="maxHeightSize" value=""/>
		<input type="hidden" name="fileExt" id="fileExt" value=""/>
	<div id="popup">
	
		<h2 class="mar_t20">신청자 기본 정보</h2>
		<fieldset>
		<legend>신청자 기본 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="신청자 기본 정보">
            		<caption class="hidden"> 신청자 기본 정보 </caption>
			<colgroup>
			  <col width="11%" />
			  <col width="39%" />
			  <col width="11%" />
			  <col width="39%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>이름</span></th>
					<td><c:out value="${openCmManageView.userNm}"/></td>
					<th>회원등급</th>
					<td><c:out value="${openCmManageView.userGradCode}"/></td>
				</tr>
              	<tr>
					<th><span>전화번호</span></th>
					<td><span><c:out value="${openCmManageView.telno}"/></span></td>
					<th>회원구분</th>
					<td><span><c:out value="${openCmManageView.userTyNm}"/></span></td>
				</tr>
				<tr>
					<th><span>휴대전화</span></th>
					<td><span><c:out value="${openCmManageView.mbtlnum}"/></span></td>
					<th>회사명</th>
					<td><span>
					<c:if test="${openCmManageView.userTyCd == '1001' ||  openCmManageView.userTyCd == '1002'}"><c:out value="${openCmManageView.entCmpnyNm}"/></c:if>
					<c:if test="${openCmManageView.userTyCd == '2001' ||  openCmManageView.userTyCd == '2002'}"><c:out value="${userEntrprsOption.cmpnyNm}"/></c:if>
					</span></td>
				</tr>
				<tr>
					<th><span>이메일 주소</span></th>
					<td><span><c:out value="${openCmManageView.email}"/></span></td>
					<th>스토어명</th>
					<td><span><c:out value="${openCmManageView.langStoreNm}"/></span></td>
				</tr>
				</tbody>
          </table>
        </fieldset>
        <h2 class="mar_t20">커뮤니티 정보</h2>
        <fieldset>
		<legend>커뮤니티 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="커뮤니티 정보">
            		<caption class="hidden"> 커뮤니티 정보 </caption>
			<colgroup>
			  <col width="11%" />
			  <col width="39%" />
			  <col width="11%" />
			  <col width="39%" />
			</colgroup>
			<tbody>
          	<tr>
					<th><span>커뮤니티 이름</span></th>
					<td><span><c:out value="${openCmManageView.cmmntyNm}"/></span></td>
					<th>지원 언어</th>
					<td><span><c:out value="${openCmManageView.langNm}"/></span></td>
				</tr>
				<tr>
					<th><span>커뮤니티 주소</span></th>
					<td><span>
						<%-- 이전소스
						<c:if test="${openCmManageView.langCode != '00'}">http://www.ceart.kr/<c:out value='${fn:toLowerCase(openCmManageView.langEngNm)}'/>/cm/user/<c:out value='${openCmManageView.cmmntyUrl}'/></c:if>
                    	<c:if test="${openCmManageView.langCode == '00'}">http://www.ceart.kr/web/cm/user/<c:out value='${openCmManageView.cmmntyUrl}'/></c:if></span></td> --%>
                    	
                    	<%--{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
                    	  변경소스--%>
                    	<c:if test="${openCmManageView.langCode == '00'}">http://<%=GlobalConfig.DOMAIN_SUBNM %>/web/cm/user/<c:out value='${openCmManageView.cmmntyUrl}'/></c:if></span></td>
                    	<%--}} --%>
                    	
					<th>커뮤니티 카테고리</th>
					<td><span><c:out value="${openCmManageView.cmmntyCtgryNm}" /></span></td>
				</tr>
				<tr>
					<th><span>커뮤니티 설명</span></th>
					<td colspan="3"><span><c:out value="${openCmManageView.cmmntyDc}"/></span></td>
				</tr>
				<tr>
					<th><span>가입 방식</span></th>
					<td colspan="3"> 
					<span><input type="radio" id="cmmntySbscrbMthd_1" name="cmmntySbscrbMthd" value="1" <c:if test="${openCmManageView.cmmntySbscrbMthd eq '1'}">checked="checked"</c:if> disabled="disabled" />
		                <label for="useYn_Y">가입 신청 시 바로 가입할 수 있습니다.</label><br/>
		                <input type="radio" id="cmmntySbscrbMthd_2" name="cmmntySbscrbMthd" value="2" <c:if test="${openCmManageView.cmmntySbscrbMthd eq '2'}">checked="checked"</c:if> disabled="disabled"  />
		                <label for="useYn_N">가입 신청 시 운영자의 승인을 거쳐 가입할 수 있습니다.</label></span></td>
				</tr>
				<tr id="logoT_1" >
					<th><span>로고 타이틀</span></th>
					<td colspan="3">
					<div id="containerLogo">
						<div class="result" >
							<img id="img1" src="<c:out value="${openCmManageView.logoFileUrl}" default="000000" />" alt="로고파일 대표 이미지 " style="width: 990px; height: 230px"/>
						</div>
					</div></td>
				</tr>
				
				<tr>
					<th><span>커뮤니티 개설<br/>신청 사유</span></th>
					<td colspan="3"><span>
					<c:out value="${openCmManageView.estblReqstResn}"/>
					</span></td>
				</tr>
				
				<tr>
					<th><span>커뮤니티 <br/> 거절 사유</span></th>
					<td colspan="3"><span>
					<c:out value="${openCmManageView.confmRejectResn}"/>
					</span></td>
				</tr>
        		</tbody>
         	</table>
        </fieldset>
        
        <p class="tx_c mar_t20">
			<a href="#"><button type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
		</p>
	</div>
	</form>
</body>
</html>