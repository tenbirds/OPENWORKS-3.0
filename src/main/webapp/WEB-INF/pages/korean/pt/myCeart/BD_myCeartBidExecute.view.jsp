<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>상세정보(견적)요청서 Saas</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript">
        window.onload = function(){
            $('#noBidCause').attr('readonly',true);

            // 개찰결과 변경에 따른 유찰사유란 readonly
            $(":radio[name='bidPgesStat']").click(function(){
                var chkVal = $(":radio[name='bidPgesStat']:checked").val();
                if(chkVal == '1004'){
                    $('#noBidCause').val('');
                    $('#noBidCause').attr('readonly',true);
                }else if(chkVal == '1005'){
                    $('#noBidCause').val('');
                    $('#noBidCause').attr('readonly',false);
                }
            });
        };

	    //  목록보기 버튼
	    function returnList(){
	        document.searchForm.action = "/korean/pt/myCeart/BD_myCeartBidList.do";
		    document.searchForm.method = "POST";
		    document.searchForm.submit();
	    }

	    //  낙찰선언 페이지 전환
	    function returnSuccessView(){
	        document.dataForm.action = "/korean/pt/myCeart/BD_myCeartBidExecute.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
	    
	    // 개찰 등록
	    function jsOpenAction(){
	        if($('#baffNm').val() == ""){
	            alert("집행관을 입력하세요.");
	            $('#baffNm').focus();
	            return false;
	        }

            // 납품기한 일자
            if($("#realOpenDt").val() == null || $("#realOpenDt").val() == ""){
                alert("실재개찰일자를 입력하세요.");
                $("#realOpenDt").focus();
                return false;
            }
            // 납품기한 일자
            if($("#realOpenTm option:selected").val() == null || $("#realOpenTm option:selected").val() == ""){
                alert("실재개찰시간을 입력하세요.");
                $("#realOpenTm").focus();
                return false;
            }

            if(confirm("개찰내역을 저장하시겠습니까?")){
        	    $("#dataForm").ajaxSubmit({
                    url      : "/korean/pt/myCeart/ND_myCeartBidExecuteAction.do",
                    type     : "POST",
                    dataType : "json",
                    success  : function(response){
                        if($('input:radio[name=bidPgesStat]:checked').val() == "1004"){
                            if(response){
                                alert("개찰이 완료되었습니다.");
                                returnSuccessView();
                            }else{
                                alert("개찰처리가 실패하였습니다.");
                            }

                        }else{
                            if(response){
                                alert("유찰처리가 완료되었습니다.");
                                returnList();
                            }else{
                                alert("유찰처리가 실패하였습니다.");
                            }
                        }
                        
                    }
                });
            }
	    }

        // 비교버튼 클릭 이벤트
        function jsSetCompare(notifyNum, notifySeq){
            jsSetCompareClear();
            
            $('.serCompare').removeClass('hidden').addClass('on');

		    $.ajax({
		        url : "/korean/pt/myCeart/BD_goodsCompareList.do",
	 	        cache: false,
		        type: "POST",
		        dataType: "JSON",
		        async: false,
		        data : {notifyNum:notifyNum, notifySeq:notifySeq},
		        success: function(data){

		            $('#q_notifyNum').val(notifyNum);
		            $('#q_notifySeq').val(notifySeq);

		            if(data.goodsList.length > 0){		                
		                for(var i = 0; i <= data.goodsList.length; i++){
		                    var goodsCode   = data.goodsList[i].goodsCode;
		                    var goodsName   = data.goodsList[i].goodsName;
		                    var langStoreNm = data.goodsList[i].langStoreNm;
		                    var goodImage =  data.goodsList[i].goodsFileUrl;

		                    var productInfro="<span id='compareItem_"+goodsCode+"'><a href='#'><img src='"+goodImage+"' alt='' /><i>"+goodsName+"</i></a>";
		                    productInfro +="<span>"+langStoreNm+"&nbsp; <button onClick='jsSetCompareDelte(\""+goodsCode+"\"); return false;'>삭제</button></span>";
		                    productInfro +="<input type='hidden' name='compGoodsCode' value='"+goodsCode+"'/>";
		                    productInfro +="</span>";
		                    $('.itemWrap').append(productInfro);
		                }
		            }
		    	}
	 		});
        }

        // 비교하기 영역 초기화
        function jsSetCompareClear(){
            $('#q_notifyNum').val('');
            $('#q_notifySeq').val('');
            $('.itemWrap').html('');
        }

        // 선택한 비교하기 서비스 삭제
        function jsSetCompareDelte(goodId){
            var exclGoodsCode = $('#q_exclGoodsCode').val();
            if(exclGoodsCode == ''){
                $('#q_exclGoodsCode').val(goodId);
            }else{
                $('#q_exclGoodsCode').val(exclGoodsCode+"|"+goodId);
            }

            $('#compareItem_'+goodId).html('');
            
        }
        
        // 비교하기 상세 페이지 호출
        function jsCompareDetail(el){
            
            if($('#q_notifyNum').val()=='' || $('#q_notifySeq').val()==''){
                alert("비교할 대상이 존재하지 않습니다.");
                return false;
            }

            var compGoodsCode = "";
            if($('input[name=compGoodsCode]').size() == 0){
                alert("비교할 대상이 존재하지 않습니다.");
                return false;                
            }else{
                $("input[name=compGoodsCode]").each(function(i){
                    if(compGoodsCode == ''){
                        compGoodsCode = $("input[name=compGoodsCode]").eq(i).val();
                    }else{
                        compGoodsCode = compGoodsCode + "|" + $("input[name=compGoodsCode]").eq(i).val();    
                    }
                });
            }

            var href = "/korean/pt/myCeart/PD_compareDetail.do?p_notifyNum="+$('#q_notifyNum').val()+"&p_notifySeq="+ $('#q_notifySeq').val()+"&q_compGoodsCode="+compGoodsCode;
            var type = "estiComp";
	        pop =  window.open(href, type, "width=1520,height=820,scrollbars=yes,resizable=yes,toolbar=no");
	        if(pop)    pop.focus();
        }
    </script>

</head>
<body>
    <form name="compareForm" id="compareForm">
        <input type="hidden" name="q_notifyNum"     id="q_notifyNum"   />   <!--  상세페이지용 -->
        <input type="hidden" name="q_notifySeq"     id="q_notifySeq"   />   <!--  상세페이지용 -->
        <input type="hidden" name="q_exclGoodsCode" id="q_exclGoodsCode"   />   <!--  상세페이지용 -->
    </form>
    <form name="searchForm" id="searchForm">
        <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>     <!--  목록 페이지 조회조건1 -->
        <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     <!--  목록 페이지 조회조건2 -->
        <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   <!--  목록 페이지 검색어 -->
        <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>        <!--  현재 페이지 -->
        <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   value="${baseList.notifyNum}"/>  <!--  공고번호 -->
        <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   value="${baseList.notifySeq}"/>  <!--  공고차수 -->
    </form>
    
	<div class="conWrap">
        <form name="dataForm" id="dataForm">
            <input type="hidden" name="p_bidPgesStat"  id="p_bidPgesStat"  value="${baseList.bidPgesStat}"/> <!--  공고상태코드 -->
            <input type="hidden" name="p_notifyNum"    id="p_notifyNum"    value="${baseList.notifyNum}"/>   <!--  공고번호 -->
            <input type="hidden" name="p_notifySeq"    id="p_notifySeq"    value="${baseList.notifySeq}"/>   <!--  공고순번 -->
        
			<div class="myceart view">
				<div class="tab_link e2">
					<a href="#" id="executeTitle1" class="on">개찰</a>
					<a href="#" id="executeTitle2" >낙찰선언</a>
				</div>
	
				<h3>입찰결과</h3>
				<table class="tbl_st4 e4">
					<tr>
						<th>입찰공고문</th>
						<td colspan="3">${baseList.bidNotifyNm}</td>
					</tr>
					<tr>
						<th>공고번호</th>
						<td colspan="3">${baseList.notifyNum}-${baseList.notifySeq}</td>
					</tr>
					<tr>
						<th class="requ">집행관</th>
						<td><input type="text" name="baffNm" id="baffNm" value="${baseList.baffNm}"/></td>
						<th class="requ">실제개찰일시</th>
						<td class="term">
							<input type="text" id="realOpenDt" name="realOpenDt" value="${baseList.realOpenDt}"/>
							<span class="sel_box">
								<select id="realOpenTm" name="realOpenTm">
					                <option value="">선택</option>
                                       <c:forEach var="i" begin="9" end="18">
                                           <c:set var="timeOption" value="${0+i}" />
                                           <option value="${timeOption}" <c:if test="${baseList.realOpenTm == timeOption}">selected="selected"</c:if>>${timeOption} 시</option>
                                       </c:forEach>									
								</select>
							</span>
							시
						</td>
					</tr>
				</table>
	
				<h3>응찰현황</h3>
				<table class="tbl_st1">
					<thead>
						<tr>
							<th>No</th>
							<th>사업자번호</th>
							<th>업체명</th>
							<th>응찰금액(원)</th>
							<th>응찰일시</th>
							<th>비교</th>
						</tr>
					</thead>
					<tbody>
					    <c:set var="pass_cnt" value="0"/>
	                    <c:forEach items="${pager}" var="bidTenderList" varStatus="status">
	                        <c:set var="spanCnt" value="0"/>
						    <tr>
							    <td>${status.count}</td>
							    <td>${bidTenderList.bizrno}</td>
							    <td>${bidTenderList.langStoreNm}</td>
							    <td><fmt:formatNumber value="${bidTenderList.splyAmt}" groupingUsed="true"/></td>
							    <td>${bidTenderList.bidEntrDt}</td>
                                <c:choose>
                                    <c:when test="${pass_cnt eq 0}">                    
                                        <c:forEach items="${pager}" var="rowSpanContent" varStatus="status1">
                                            <c:if test="${bidTenderList.notifyNum eq rowSpanContent.notifyNum and bidTenderList.notifySeq eq rowSpanContent.notifySeq}">
                                                <c:set var="spanCnt" value="${spanCnt+1}"/>
                                            </c:if>
                                        </c:forEach>
								            <td rowspan="<c:out value='${spanCnt}'/>">
								                <a href="#" onclick="jsSetCompare('${bidTenderList.notifyNum}','${bidTenderList.notifySeq}'); return false;" class="btns st3 btnPare">비교</a>
								            </td>
								        <c:set var="spanCnt" value="${spanCnt-1}"/>
                                        <c:set var="pass_cnt" value="${spanCnt}"/>
								    </c:when>
								    <c:otherwise>
								        <c:set var="pass_cnt" value="${pass_cnt-1}"/>
								    </c:otherwise>
								</c:choose>
						    </tr>
						    <c:set var="spanCnt" value="${spanCnt-1}"/>
	                    </c:forEach>
					</tbody>
				</table>
				
				<h3>개찰상태</h3>
				<table class="tbl_st4">
					<tr>
						<th>개찰결과</th>
						<td>
							<label><input type="radio" name="bidPgesStat" value="1004" <c:if test="${baseList.bidPgesStat == '1002' or baseList.bidPgesStat == '1004'}">checked='checked'</c:if> /> 개찰완료</label>
							<label><input type="radio" name="bidPgesStat" value="1005" <c:if test="${baseList.bidPgesStat == '1005'}">checked='checked'</c:if>/> 유찰</label>
						</td>
					</tr>
					<tr>
						<th>유찰사유</th>
						<td><textarea name="noBidCause" id="noBidCause"></textarea></td>
					</tr>
				</table>
				<div class="btnArea rig">
					<a href="#" onclick="javascript:jsOpenAction(); return false;" class="btns st1 icn icnSave">등록</a>
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>
		    </div>
        </form>
	</div>

	<!-- popup - 서비스 비교 -->
	<article class="popup serCompare">
		<h2>서비스 비교(10) <a href="#">닫기</a><i>* 최대 10개 까지 비교 가능합니다</i></h2>
		<div class="itemWrap">
		</div>
		<ul>
			<li><button onclick="javascript:jsCompareDetail(this); return false;"><i>선택서비스 비교</i></button></li>
			<li><button onclick="javascript:jsSetCompareClear(); return false;">전체 비우기</button></li>
		</ul>
	</article>
	<!--// popup - 구매요청 -->

    <script>
	$(document).ready(function() {
	    $( "#realOpenDt" ).datepicker({
	        showOn: "both", 
	        buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	        buttonImageOnly: false,
	        buttonText: "달력"
	    });

	});
    </script>
  <!--// datepicker -->
</body>
</html>