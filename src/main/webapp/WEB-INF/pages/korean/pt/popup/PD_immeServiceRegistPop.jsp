<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>POPUP - 임의 서비스 등록</title>
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
	        $("#dataForm input[name=q_currPage]").val(page);
	        var userId = $("#userId").val();
	        document.dataForm.action = "/korean/pt/popup/PD_myServicePop2.do?userId="+userId;
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
	    
	    // 서비스 선택
	    var jsSelectGoods = function(goodsNm,goodsCode,suplerId,suplerStoreNm){
	        $(parent.document).find('#goodsArea${idx}').html(goodsNm + " ["+suplerStoreNm+"] ");
            $(parent.document).find('#goodsCode${idx}').val(goodsCode);
            $(parent.document).find('#suplerId').val(suplerId);
            $(parent.document).find('#sleInsttNm').val(suplerStoreNm);
            
	        parent.$.fn.colorbox.close();
	    };
	    
	    var jsListSearch2 = function(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	        var userId = $("#userId").val();

	        //alert( $("#immeGubun").val());
	        //return;
	        
	        document.dataForm.action = "/korean/pt/popup/PD_myServicePop2.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
	    
		var jsAuthTypeStrAdd = function(el){
	        var isChecked = $(el).is(':checked');

//	        alert(isChecked);
	
	        if(isChecked){
	        	$("#immeGubun").val("Y");
	        }
    	};

    	
	    // 저장, 수정 버튼 클릭
	    var jsImmeServiceRegist = function(type){
	        
	        if(checkEditor()){
	            var confirmMsg = "서비스를 저장하시겠습니까?";
				    if(confirm(confirmMsg)) {
				        jsCntrctSubmit();
				        jsClose();
				}
	        }
	    };
	
	    var jsCntrctSubmit = function(type){
	    	
            // 실제 저장 처리
            $("#dataForm").attr("action", "/intra/orderManage/cntrctManage/ND_immeServiceRegistInsertAction.do");
            $("#dataForm").submit();
	    }    	

	    // 저장 vaildation 체크
	    function checkEditor(){
			
	        if($('#goodsNm').val() == ''){
	            alert("서비스명을 입력하세요.");
	            $('#svcNm').focus();
	            return false;
	        }
	        return true;
	    }    	
    </script>
    
</head>



 <body class="winPopup serSel">
	<h2>임의 서비스 등록 <a href="#" onclick="jsClose();">닫기</a></h2>
	<div>
		<form name="dataForm" id="dataForm" method="POST">	        
	        <input type="hidden" name="q_currPage" id="q_currPage" value="${currPage}"/>  					 <!--  현재 페이지 -->
			<input type="hidden" name="userId"     id="userId"     value="${sessionScope['__usk'].userId}"/> <!--  이용자ID -->
			
			<!--// 검색영역 -->
			<div class="list_st1">
				<table class="tbl_st4">
					<tr>
					    <th >서비스명</th>
					    <td>
					    	<input type="text" name="goodsNm" id="goodsNm" value="" maxlength="100" />
					    </td>					    
					</tr>
				</table>
			</div>
		</form>
	</div>
	<div class="btnArea rig">				
		<a href="#" onclick="javascript:jsImmeServiceRegist(this); return false;"><span class="btns st3"> 등록</span></a>				
	</div>
	
  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  
  
 </body>
</html>