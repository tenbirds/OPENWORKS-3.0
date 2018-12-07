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
    <op:jsTag type="spi" items="form,datepicker,colorbox" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">

        // 조회버튼 클릭
        function jsListSearch(page){
            $("#dataForm input[name=q_currPage]").val(page);
            document.dataForm.action = "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do";
        	document.dataForm.method = "POST";
        	document.dataForm.submit();
        }

        // 서비스 상세보기(답변과 같이 보는 화면으로 이동)
        function jsRequestDetailView(notifyNum, notifySeq, langStoreId)
        {
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            $('#langStoreId').val(langStoreId);
            
            document.dataForm.action = "/korean/pt/myCeart/BD_beforeRequestDetailView.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }

        /**
         * 목록 삭제 
         */
        var jsDelete = function(){
	         var requestData = "";
	         var chkYn = true;

			$("input[name=finishRequest]:checked").each(function() {
				var finishRequestVal = $(this).val();
				var strAry = finishRequestVal.split("|");
				requestData += finishRequestVal + "#";
			});
			
			if(chkYn){
				if(requestData == ''){
				    alert("삭제할 사전 견적을 선택하시기 바랍니다.");
				    chkYn = false;
				    return false;
				}
			}
			if(chkYn){
				if(confirm("선택하신 사전 견적을 삭제 하시겠습니까?")) {
					$('#requestData').val(requestData);
			
			   	    $("#dataForm").ajaxSubmit({
			               url      : "/korean/pt/myCeart/ND_myCeartBeforeRequestListDelete.do",
			               
			               type     : "POST",
			               dataType : "json",
			               success  : function(response){
			                   if(response.result) {
			                       alert("삭제되었습니다.");
			                       location.reload();
			                   } else {
			                       alert(response.message);
			                   }
			               }
			           });
				}
			}
     	}     
        
        
    
	/* function jsDetailView(el, notifyNum, notifySeq, langStoreId){
		
	    $(el).colorbox({
            title : "사전계약상세정보",
            href : "/korean/pt/myCeart/BD_beforeRequestDetailView.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq+"&langStoreId="+langStoreId,
            width : "920",
            height : "958",
            overlayClose : true,
            escKey : false,
            iframe : true
        });
	}   */
	 	
    </script>

</head>
<body>
	<form name="compareForm" id="compareForm">
		<input type="hidden" name="q_notifyNum"     id="q_notifyNum"   />   <!--  상세페이지용 -->
		<input type="hidden" name="q_notifySeq"     id="q_notifySeq"   />   <!--  상세페이지용 -->
		<input type="hidden" name="q_exclGoodsCode" id="q_exclGoodsCode"   />   <!--  상세페이지용 -->
	</form>
 		
	<div class="conWrap">
		<form name="dataForm" id="dataForm">
    	<input type="hidden" name="requestData"  id="requestData"  />                  <!--  계약체결 완료요청 대상 Data -->
      <input type="hidden" name="q_currPage"   id="q_currPage" value="${currPage}"/> <!--  현재 페이지 -->
      <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   />   <!--  상세페이지용 -->
      <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   />   <!--  상세페이지용 -->
      <input type="hidden" name="langStoreId"   id="langStoreId" />     <!--  상세페이지용 -->

			<div class="myceart buylist reque">
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01" >
							<option value="01" <c:if test="${searchDiv01 == '01'}">selected="true"</c:if> >공급사명</option>
							<option value="02" <c:if test="${searchDiv01 == '02'}">selected="true"</c:if> >서비스명</option>
						</select><label for="searchDiv01"></label>
					</span>
					
					<div>
						<input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}" title="검색"/> <label for="searchKeyWord"></label>
					</div>
					<a href="#none" onclick="javascript:jsListSearch(0);" class="btns st5" title="검 색">검 색</a>
				</div>				
				
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
						
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="javascript:jsListSearch(0);">
							    <option value="">전체</option>
							    <option value="Y">수신</option>
							    <option value="N">미수신</option>
							</select><label for="searchDiv02"></label>
						</span>
					</p>
					<table class="tbl_st1" summary="견적 관리 목록">
					<caption>견적 관리 목록</caption>
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
						<thead>
							<tr>
								<th scope="row">선택</th>
								<th scope="row">서비스</th>
								<th scope="row">견적요청일</th>
								<th scope="row">견적요청자</th>
								<th scope="row">견적수신</th>
								<!-- <th>내용</th> -->
							</tr>
						</thead>
						<tbody>
							<c:set var="index" value="${pager.indexNo}"/>
              <c:forEach items="${pager.list}" var="listData" varStatus="status">
							<tr>
								<td>
									<label><input type="checkbox" name="finishRequest" value="${listData.notifyNum}|${listData.notifySeq}|${listData.langStoreId}"/></label>
								</td>
								<%-- <td>${index-status.index}</td> --%>
								<td class="tit" goodsKndCd="${listData.goodsKndCd}">
									<i>${listData.langStoreNm} ${listData.langStoreId} </i>
									<!-- 서비스 상세보기(답변과 같이 보는 화면으로 이동) -->
									<a href="#none" class="sim_opcl" onclick="jsRequestDetailView('${listData.notifyNum}','${listData.notifySeq}','${listData.langStoreId}'); return false;" title="${listData.goodsNm}">${listData.goodsNm}</a>								
								</td>
								<td>${listData.nofyDt}</td>
							 	<td>${listData.userId}</td>
								<td>${listData.splyDt}</td>
								<%-- <td><i><a href="javascript:;" title="팝업창 열림" onclick="jsDetailView(this,'${listData.notifyNum}','${listData.notifySeq}','${listData.langStoreId}'); return false;">상세</a>	</i>
								</td> --%>
							</tr>
						</c:forEach>
                        <!-- 데이터가 없을 때 알림 문구 -->
                        <c:if test="${empty pager.list}">
                            <op:no-data obj="${pager}" colspan="7" />
                        </c:if>
						</tbody>
					</table>								
				</div>

		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
				<div class="btnArea rig">
					<a href="#" onclick="jsDelete();" class="btns st1 icn icnDel" style="min-width:54px">삭제</a> <br />
				</div>
		    </div>
	    </form>
	</div>
		
	<!-- popup - 내용 -->
	
   
</body>
</html>