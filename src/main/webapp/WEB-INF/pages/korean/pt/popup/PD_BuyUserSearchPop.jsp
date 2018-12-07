<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>POPUP - 이용자선택</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
 	
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <script type="text/javascript">
	    // 닫기
	    var jsClose = function(){
	        parent.$.fn.colorbox.close();
	    };
	    
	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	        
	        if($("#searchKeyWord").val()==""){
	            alert("조회조건을 입력해 주시기 바랍니다.");
	            return;
	        }
	        
	        $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "/korean/pt/popup/PD_BuyUserSearchPop.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
	    
	    // 서비스 선택
	    var jsSelectGoods = function(commUserId,commUserNm,cmpnyNm){
	        $(parent.document).find('#userArea').html(commUserNm + " ["+cmpnyNm+"] ");
	        $(parent.document).find('#commUserId').val(commUserId);
            $(parent.document).find('#commUserNm').val(commUserNm);
            $(parent.document).find('#purchsInsttNm').val(cmpnyNm);
            
	        parent.$.fn.colorbox.close();
	        
	    };
	    
	    // 이용자 수기 입력
	    var jsInputBuyUser = function(){
	        $(parent.document).find('#buyuserInfo').show();
	        $(parent.document).find('#commUserType').val('none');
	        jsClose();
	    };
	    
	    // 구매담당자 수기입력 
	    
    </script>
</head>

 <body class="winPopup serSel">
	<h2>이용자선택 <a href="#" onclick="jsClose();">닫기</a></h2>
	<div>
		<form name="dataForm" id="dataForm">	        
	        <input type="hidden" name="q_currPage"  id="q_currPage"  value="${currPage}"/> <!--  현재 페이지 -->
			<div class="schArea">
				<span class="sel_box">
					 <select id="searchDiv01" name="searchDiv01">
						<option value="1001" <c:if test="${searchDiv01 == '1001'}">selected="true"</c:if> >구매기관</option>
						<option value="1002" <c:if test="${searchDiv01 == '1002'}">selected="true"</c:if> >구매담당자</option>	
					</select> 
				</span>
				<div>
					<input type="text" id="searchKeyWord" name="searchKeyWord" value="${searchKeyWord}" />
				</div>
				<a href="#search" class="btns st5" onclick="jsListSearch(1);">검 색</a>
			</div>
			
			<!--// 검색영역 -->
			<div class="list_st1">
				<p class="head">
					<span>총 ${pager.totalNum}개</span>
				</p>
				<table class="tbl_st1">
					<thead>
						<tr>
						    <th>번호</th>
							<th>구매기관</th>
							<th>구매담당자</th>
							<th>선택</th>					
						</tr>
					</thead>
					<tbody>
					    <c:set var="index" value="${pager.indexNo}"/>
					    <c:forEach items="${pager.list}" var="baseList" varStatus="status">
						<tr>
						    <td>${index-status.index}</td>
						    <td>${baseList.cmpnyNm}</td>
							<td>${baseList.commUserNm}</td>
							<td><a href="#" onclick="jsSelectGoods('${baseList.commUserId}','${baseList.commUserNm}','${baseList.cmpnyNm}'); return false;" class="btns st3">선택</a></td>
						</tr>
					    </c:forEach>
		                <!-- 데이터가 없을 때 알림 문구 -->
		                <c:if test="${empty pager.list}">
		                <tr>
		                	<td colspan="4">
		                		구매기관(이용자) 정보가 검색되지 않으면 구매기관정보를 직접등록합니다. <br/> <br/>
		                		<a href="#" onclick="jsInputBuyUser();" class="btns st3">직접등록 바로가기</a>
		                    </td>
		                </tr>
		                </c:if>
					</tbody>
				</table>
				
				
			</div>
		</form>
	</div>

    <!-- 페이징 -->
    <div class="paging">
        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
    </div>
    <!-- //페이징 -->

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  
  
 </body>
</html>