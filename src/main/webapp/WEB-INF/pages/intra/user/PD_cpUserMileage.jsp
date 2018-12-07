<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>

    <title>마일리지정보 - 사업자</title>
    <op:jsTag type="spi" items="validate,form" />
    
    <script type="text/javascript">

	var cpUserUpdateForm = function(){
		
	    self.location.href = "PD_cpUserUpdateForm.do?userId="+$("#userId").val();					

	};    
    
	var cpUserUpdateAddForm = function(){
		
	    //jsWarningBox("기본정보를 입력하신후 추가정보를 입력해주세요.");
	    self.location.href = "PD_cpUserUpdateAddForm.do?userId="+$("#userId").val();		

	};    
    
	</script>
    
</head>
 
<body>
	<!-- 컨텐츠영역 -->
	<form id="dataForm" name="dataForm">	
	<input type="text" id="userId" name="userId" value="${param.userId}" />	
<%-- 	<input type="text" id="userId" name="userId" value="${dataVo.userId}" />	 --%>
	<div id="popup">
		<div class="pop_tit">
			<h1>사업자회원등록</h1>		
		</div>
		
		<!-- 탭 -->
		<ul class="tab">
			<li><a href="#" onclick="cpUserUpdateForm();">기본정보</a></li>
			<li><a href="#" onclick="cpUserUpdateAddForm();">추가정보</a></li>
			<li><a href="#" class="on">마일리지정보</a></li>
		</ul>
		<!-- //탭 -->
		
		<!-- 마일리지정보 -->
		<h2 class="mar_t20">마일리지정보</h2>
		
		<fieldset>
		<legend>마일리지정보</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="마일리지정보를 등록 하실 수 있습니다.">
			<caption class="hidden"> 마일리지정보 </caption>
			<colgroup>
				<col width="15%" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="school">마일리지명</label></th>
					<td><input type="text" id="job" class="w120" name="sub" title="마일리지명을 입력해주세요" value="" /></td>
				</tr>
				<tr>
					<th>마일리지타입</th>
					<td>관리자입력</td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="mil">부여마일리지</label></th>
					<td><select id="phone" name="sul">
							<option value="">적립</option>
							<option value="">차감</option>
						</select>
						<input type="text" id="mil" class="w80" name="sub" title="포인트를 입력해주세요" value="" /> 포인트</td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="gik">부여사유</label></th>
					<td><textarea id="con" name=""  rows="8" class="w99_p"></textarea></td>
				</tr>
			</tbody>
		</table>
		</fieldset>
		<p class="tx_r mar_t20"><a href="#"><button type="button" class="blue">등록</button></a></p>
		<!-- //마일리지정보 -->

		<!-- 마일리지이력 -->
		<h2 class="mar_t20">마일리지이력</h2>
		<div class="mar_b20">
		<table class="boardWrite" cellspacing="0" border="0" summary="인원수 정보">
			<caption class="hidden"> 인원수 </caption>
			<colgroup>
				<col width="15%" />
				<col width="30%" />
				<col width="25%" />
				<col width="30%" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="2">총 마일리지</th>
					<td rowspan="2" class="tx_red_s">5,800점</td>
					<th>소멸예정 마일리지(1개월내)</th>
					<td>50점</td>
				</tr>
				<tr>
					
					<th>정기 소멸예정 마일리지</th>
					<td>100점</td>
				</tr>
			</tbody>
		</table>
		</div>
		<p class="tx_r mar_t20 mar_b30"><a href="#"><button type="button" class="blue">엑셀출력</button></a></p>

		<!-- 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
			<caption class="hidden"> 목록 </caption>
			<colgroup>
				<col width="5%"/>
				<col width=""/>
				<col width="14%"/>
				<col width="8%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>마일리지명</th>
					<th>마일리지타입</th>
					<th>점수</th>
					<th>적립일시</th>
					<th class="lr_none">적립사유</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>10</td>
					<td>공모전 포상 마일리지</td>
					<td>관리자입력</td>
					<td>1,000</td>
					<td>2011-11-15 00:50:23</td>
					<td class="lr_none">
						<div class="po_rel">
							<a href="#">[보기]</a>
							<!-- 적립사유 레이어 -->
							<div class="mo_why" style="text-align:left;left:-250px;">
								<h5>마일리지 적립사유</h5>
								<p>공모전 응모 마일리지로 수상자엥게 각 1,000의 마일리지를 부여합니다.</p>
							</div>
						</div>
					</td>
				</tr>
				<tr class="bg_yellow">
					<td>10</td>
					<td>공모전 포상 마일리지</td>
					<td><span class="tx_red">서비스권신청</span></td>
					<td>1,000</td>
					<td>2011-11-15 00:50:23</td>
					<td class="lr_none">
						<div class="po_rel" style="display:none;text-align:left;left:-250px;">
							<a href="#">[보기]</a>
							<!-- 적립사유 레이어 -->
							<div class="mo_why">
								<h5>마일리지 적립사유</h5>
								<p>공모전 응모 마일리지로 수상자엥게 각 1,000의 마일리지를 부여합니다.</p>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //리스트 -->
		<!-- 페이징 -->
		<div class="paging">
			<a href="#" class="p_gray" title="처음페이지로 가기">First</a> <a href="#" class="p_gray"  title="이전페이지로 가기">Prev</a> <span>1</span> <a href="#" title="2페이지">2</a> <a href="#" title="2페이지">3</a> <a href="#" class="p_gray" title="다음페이지로 가기">Next</a> <a href="#" class="p_gray" title="마지막페이지로 가기">End</a>

			<fieldset>
				<legend></legend>
				<input class="w55" type="text" value="" name="textSearch" title="이동할페이지를 입력하세요"/> page
				<button type="button" class="gray mar_l5">이동</button>
			</fieldset> 
		</div>
		<!-- //페이징 -->
		
	</div>
	</form>
	<!-- //컨텐츠영역 -->
</body>
</html>