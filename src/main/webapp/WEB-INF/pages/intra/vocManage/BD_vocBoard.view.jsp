<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>VOC 상세</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="form, highlight, ui, validate, cookie" />
</head>
<body>
    bd_vocBoard.view.jsp 도착<br />
    ${vocView}<br />
    bd_vocBoard.view.jsp 도착<br />
    <table class="boardWrite" cellspacing="0" border="0" summary=" 게시글 정보입니다.">
			<caption class="hidden">상세보기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<c:forEach var="vocItem"  items="${vocView}" varStatus="status">
                <tr>
                	<td><c:out value="333" /></td>        <!-- 고객명 -->
				</tr> 
            </c:forEach>
			<tr>
				<th>111</th>
				<td>434</td>
			</tr>
			<tr>
				<th>222</th>
				<td>${vocItem.userNm}</td>
			</tr>
	 </table>
	 
	 

	<!-- 사용자 스크립트 시작  -->	
	<script type="text/javascript">

	$().ready(function(){

		//게시판 설정값들을 초기화 합니다.
		
	});
	
	// 취소
	vocList = function() {
	    alert("이전페이지로, 목록보기로 이동");
	    
	};
	
	// 저장, 등록
	vocInsert = function() {
	    alert("입력한 내용 저장");
	    alert("1 : "+ $("#memberAt option:selected").text() );
	    alert("2 : "+ $("#userNm").val() );
	    alert("3 : "+ $("#insttTyNm option:selected").text() );
	    
	    var isInsert = vocInsertValidation();
	    if(isInsert){
	        alert("정상적인 데이터");
	    } else {
	        alert("비 정상적인 데이터");
	    }
	    
	};
	
	// 저장, 등록
	vocInsertValidation = function() {
	  	//==============================================================
	  	// 1. 필수값 체크
	    //==============================================================
	    // 회원구분
	    var memberAtValue = $("#memberAt option:selected").text();
	    if(fn_isNull(memberAtValue)){
	        alert("회원구분은 필수선택사항입니다.");
	        return false;
	    }
	    // 기관분류
	    var insttTyNmValue = $("#insttTyNm option:selected").text();
	    if(fn_isNull(insttTyNmValue)){
	        alert("기관분류는 필수선택사항입니다.");
	        return false;
	    }
	    
	    // 연락처
	    var telnoValue = $("#telno").val();
	    if(fn_isNull(telnoValue)){
	        alert("연락처는 필수입력사항입니다.");
	        return false;
	    }
	    // VOC종류
	    var vocInqryTyValue = $("#vocInqryTy option:selected").text();
	    if(fn_isNull(vocInqryTyValue)){
	        alert("VOC 종류는 필수선택사항입니다.");
	        return false;
	    }
	    // 문의내용
	    var vocInqryCnValue = $("#vocInqryCn").val();
	    if(fn_isNull(vocInqryCnValue)){
	        alert("VOC 문의내용은 필수입력사항입니다.");
	        return false;
	    }
	    
	    //==============================================================
	    // 2. 정합성 테스트
	    //==============================================================
	    // 1. 연락처 형식 -> 암호화 때문에 꼭 필요
	    var telnoValue = $("#telno").val();
	    var telNum_reg = /^[0-9]+([-]?[0-9])*$/g; // 연락처 형식 정규식
	    if(!fn_isNull(telnoValue)){
	        if(telNum_reg.test(telnoValue)) {
		    	if(telnoValue.length < 50){
		        	isValid = true;
		    	} else {
		        	alert("길이는 50을 초과할 수 없습니다.");
		        	return false;
		    	}
	        } else {
	            alert("정확한 유선번호 형식이 아닙니다. 예) 000-0000-0000, 또는 00-000-0000");
		        return false;
			}
	    }
	    // 2. 처리완료가 체크된 경우, 답변이 없을때 알림
	    
	    var vocAnswerValue = $("#vocAnswer").is(":checked"); // 처리완료 체크박스
	    var vocAnswerCnValue = $("#vocAnswerCn").val(); // 답변
	    
	    if(vocAnswerValue){
	        alert("처리완료 체크박스가 체크되어 있음!!");
	        if(fn_isNull(vocAnswerCnValue)){
	            alert("답변 내용이 없습니다.");
	            return false;
	        }
	    }
	    
	    // 위의 과정을 쭉 지나왔다면 정상적인 데이터이므로 true 리턴
	    return true;
	    
	};
	
	// 벨리데이션 체크(1. 필수값 체크) 값이 있는지 없는지 체크하는 함수(널이면:true, 널이 아니면:false)
    fn_isNull = function(strValue) {
        if( strValue == "" 
                || strValue == null 
                || strValue == undefined 
                || ( strValue != null 
                        && typeof strValue 
                        == "object" 
                        && !Object.keys(strValue).length )) { 
            return true; 
		} else { 
		    return false; 
		}
    };

	</script>
	<!-- 사용자 스크립트 끝  -->
	<div class="po_rel">
		<h4>voc 등록</h4>
		<div class="h4_r">
			<span class="tx_red tx_b">*</span> 표시는 필수입력사항입니다.
		</div>
	</div>

	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return false;">
		<op:pagerParam view="view" />
		<input type="hidden" name="value1" value='1' />
		<input type="hidden" name="value2" value='2' />

		<!-- 내용쓰기 -->
		<fieldset>
			<legend>글입력</legend>
			<table class="boardWrite" cellspacing="0" border="0" summary="게시판 내용 작성페이지입니다.">
				<caption class="hidden">게시판 글입력 페이지</caption>
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>
							<label for="memberAt">회원구분 <span class="tx_red tx_b">*</span></label>
						</th>
						<td>
							회원, 비회원, ${vocVo.memberAt} 이 Y이면 회원, N이면 비회원
							<c:choose>
								<c:when test="${vocVo.memberAt eq 'Y'}">
									<label for="memberAt">회원</label>
								</c:when>
								<c:otherwise>
									<label for="memberAt">비회원</label>
								</c:otherwise>
							</c:choose>
						</td>
						<th>
							<label for="userNm">고객명</label>
						</th>
						<td>
							${vocVo.userNm}
							<c:choose>
								<c:when test="${not empty vocVo.insttTyCd eq '1001'}">
									<label for="insttTyCd">공공기관</label>
								</c:when>
								<c:otherwise>
									<label for="insttTyCd">다시설정해주세요.</label>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>
							<label for="insttTyCd">기관분류<span class="tx_red tx_b">*</span></label>
						</th>
						<td>
							<!-- 공통코드를 가져와서 읽는 방식으로 변경 필요 -->
							${vocVo.insttTyCd}, ${vocVo.insttTyNm}
							<c:choose>
								<c:when test="${vocVo.insttTyCd eq '1001'}">
									<label for="insttTyCd">공공기관</label>
								</c:when>
								<c:when test="${vocVo.insttTyCd eq '1002'}">
									<label for="insttTyCd">중앙행정기관</label>
								</c:when>
								<c:when test="${vocVo.insttTyCd eq '1003'}">
									<label for="insttTyCd">지자체</label>
								</c:when>
								<c:when test="${vocVo.insttTyCd eq '1004'}">
									<label for="insttTyCd">제공기업</label>
								</c:when>
								<c:when test="${vocVo.insttTyCd eq '1005'}">
									<label for="insttTyCd">기타(개인)</label>
								</c:when>
								<c:otherwise>
									<label for="insttTyCd">다시설정해주세요.</label>
								</c:otherwise>
							</c:choose>
						</td>
						<th><label for="pstinstNm">소속</label></th>
						<td><input type="text" name="pstinstNm" id="pstinstNm" value="" /><valid:msg name="pstinstNm" /></td>
					</tr>
					<tr>
						<th><label for="telno">연락처<span class="tx_red tx_b">*</span></label></th>
						<td colspan="3"><input type="text" name="telno" id="telno" value="" /><valid:msg name="telno" /></td>
					</tr>
					<tr><!-- 공백 -->
						<td colspan="4"></td>
					</tr>
					<tr>
						<th><label for="title">접수일자</label></th>
						<td colspan="3"><input type="text" name="title" id="title" value="" />
							<valid:msg name="title" />
							<span class="tx_red tx_b">* 실제 문의 접수 일자 적용</span>
						</td>
					</tr>
					<tr>
						<th>
							<label for="vocInqryTy">VOC 종류<span class="tx_red tx_b">*</span></label>
						</th>
						<td colspan="3">
							<select id="vocInqryTy" name="vocInqryTy" title="VOC 종류를 선택해주세요" class="over">
								<option value="" selected="selected"></option>
								<option value="" >회원가입</option>
								<option value="">회원탈퇴</option>
								<option value="">협약체결</option>
								<option value="">서비스등록/수정</option>
								<option value="">서비스문의</option>
								<option value="">기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><label for="vocInqryCn">문의내용 <span class="tx_red tx_b">*</span></label></th>
						<td colspan="3">
							<div id="contentsErrorDiv"></div>
							<textarea name="vocInqryCn" id="vocInqryCn" rows="15" class="w99_p" title="내용을 입력해주세요">${dataVo.contents}</textarea>
							<valid:msg name="vocInqryCn" />
						</td>
					</tr>
					<tr>
						<th><label for="vocAnswerCn">답변</label></th>
						<td colspan="3">
							<input type="checkbox" name="vocAnswer" id="vocAnswer" /><label for="vocAnswer"> 처리완료</label>
							<br /><br />
							<textarea name="vocAnswerCn" id="vocAnswerCn" rows="15" class="w99_p" title="내용을 입력해주세요">${dataVo.contents}</textarea>
							<valid:msg name="vocAnswerCn" />
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		<!-- //내용쓰기 -->

		<!-- 버튼 -->
		<div class="btn_r">
			<ul>
				<li><input type="button" value="저장" class="w_blue" onclick="vocInsert();" /></li>
				<li><input type="button" value="취소" class="blue" onclick="vocList();" /></li>
			</ul>
		</div>
		<!-- //버튼 -->
	</form> 

	 
	 
	 
	 
	 
</body>

</html>