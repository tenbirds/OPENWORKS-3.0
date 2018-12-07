<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>호환성 신청 | 표준프레임워크 | 소개 | 씨앗 마켓</title>
	<script type="text/javascript">
	    var jsList = function(){
	        location.href = "BD_index.do";
	    };
	    
	    var jsBack = function(event){
	      history.go(-1);
	      event.preventDefault();
	  };
	    
	</script>
</head>
<body>
	<!-- 검색 리스트 영역 -->
	<section>            
	    <!-- 목록 시작 -->
	    <table class="tbl_list_input orgmargin">
	        <caption>
	            <strong>호환성 신청 및 확인 상세</strong>
	            <details>
	                <summary>정보를 제공합니다.</summary>
	            </details>
	        </caption>
	        <colgroup>
	            <col style="width:200px">
	            <col>
	            
	        </colgroup>
	        <thead>
	        </thead>
	        <tbody>
	            <tr>
	                <td>호환성 분석 대상명</td>
	                <td>${dataVo.cmptbAnalsTrgetNm}</td>
	            </tr>
	            <tr>
	                <td>호환성 분류</td>
	                <td>${dataVo.cmptbClNm}</td>
	            </tr>
	            <tr>
	                <td>사업자(업체)명</td>
	                <td>${dataVo.bsnnNm}</td>
	            </tr>
	            <tr>
	                <td>호환성 분석 신청자</td>
	                <td>${dataVo.analsApplcntNm}</td>
	            </tr>
	            <tr>
	                <td>신청자 전화번호</td>
	                <td>${dataVo.applcntTelno}</td>
	            </tr>
	            <tr>
	                <td>신청자 이메일</td>
	                <td>${dataVo.applcntEmail}</td>
	            </tr>
	             <tr>
	                <td>신청자 팩스번호</td>
	                <td>${dataVo.applcntFxnum}</td>
	            </tr>
	            <tr>
	                <td>분석 대상 설명</td>
	                <td>${dataVo.analsTrgetDc}</td>
	            </tr>
	            <tr>
	                <td>버전</td>
	                <td>${dataVo.ver}</td>
	            </tr>
	            <tr>
	                <td>분석신청 날짜</td>
	                <td>${dataVo.analsReqstDe}</td>
	            </tr>
	            <tr>
	                <td>우편번호</td>
	                <td>${dataVo.analsPlaceZip}</td>
	            </tr>
	            <tr>
	                <td>분석장소</td>
	                <td>${dataVo.analsPlaceBassAdres} ${dataVo.analsPlaceDetailAdres}</td>
	            </tr>
	        </tbody>
	    </table>
	    
	    <table class="tbl_list type_A">
	      <caption>
	        <strong>호환성 신청</strong>
	        <details>
	          <summary>선택, 항목명, 항목설명, 신청요약 정보를 제공합니다.</summary>
	        </details>
	      </caption>
	      <colgroup>
	        <col style="width:10%">
	        <col style="width:20%">
	        <col style="width:35%">
	        <col style="width:*">
	      </colgroup>
	      <thead>
	        <tr>
	          <th scope="col">선택</th>
	          <th scope="col">항목명</th>
	          <th scope="col">항목설명</th>
	          <th scope="col">신청요약</th>
	        </tr>
	      </thead>
	      <tbody>
	        <tr>
	          <td><input type="checkbox" disabled="disabled"   title="아키텍처" <c:if test="${dataVo.archtcIemAt eq 'Y'}"> checked="checked" </c:if>></td>
	          <td>아키텍처</td>
	          <td>표준프레임워크 아키텍처 및 환경제약사항 준수</td>
	          <td>
	            <textarea class="textarea"  readonly="readonly" title="아키텍처를 입력해 주세요">${dataVo.archtcImeReqstSumry}</textarea>
	          </td>
	        </tr>
	        <tr>
	          <td><input type="checkbox" disabled="disabled" title="가이드" <c:if test="${dataVo.guideIemAt eq 'Y'}"> checked="checked" </c:if>></td>
	          <td>가이드</td>
	          <td>솔루션(SW)가이드 제공 여부를 확인함</td>
	          <td>
	            <textarea class="textarea" readonly="readonly" title="가이드를 입력해 주세요" >${dataVo.guideImeReqstSumry}</textarea>
	          </td>
	        </tr>
	        <tr>
	          <td><input type="checkbox" disabled="disabled" title="표준프레임워크호환성" <c:if test="${dataVo.egovFrameIemAt eq 'Y'}"> checked="checked" </c:if>></td>
	          <td>표준프레임워크호환성</td>
	          <td>표준프레임워크 호환성 점검</td>
	          <td>
	            <textarea class="textarea" readonly="readonly" title="표준프레임워크호환성을 입력해 주세요" >${dataVo.egovFrameIemSumry}</textarea>
	          </td>
	        </tr>
	      </tbody>
	    </table>
	    
	    <!-- //목록 끝 -->
	    
	    <div class="btn_area">
	        <div class="btn_l">
	            <div class="btn_navi_g">
	                <a href="#" onclick="jsBack(event);"><span class="total">목록</span></a>
	            </div>
	        </div>
	    </div>    
	</section>
	<!-- //검색 리스트 영역 -->
</body>
</html>