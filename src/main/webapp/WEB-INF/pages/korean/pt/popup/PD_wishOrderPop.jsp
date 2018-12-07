<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>신청하기</title>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>
	<script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script> 
     
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/validate/jquery.validate.css" />
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/jquery.validate.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/additional-methods.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/jquery.validate.settings.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/validate/jquery.validate.messages.js"></script>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/form/jquery.form.js"></script>

    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <script type="text/javascript">
    
    $(window).load(function() {
      
        <c:if test="${mode eq 'list'}"> 
        /*리스트항목에서 가져오기*/
        // $("#filterCon").val(parent.$("#selecItemNames").val().replace('/ ','')); //히스토리 설계에 따라 변동됨으로 삭제 
        //  $("#goodsCodes").val(parent.$("#goodsCodeList").val().replace(',','')); //히스토리 설계에 따라 변동됨으로 삭제

        var selectItem1 = new Array;
        var selectItem2 = new Array;
        var selectItem3 = new Array;
        var selectItem4 = new Array;
        var selectItem5 = new Array;
        var selectItem6 = new Array;
        var selectItem7 = new Array;
        var selectItem8 = new Array;
        var selectItem9 = new Array;
        var selectItem10 = new Array;
        var selectItem11 = new Array;
     
        parent.$('input[name=selectItem1]:checked').each(function(){ selectItem1.push($(this).val()); });
        parent.$('input[name=selectItem2]:checked').each(function(){ selectItem2.push($(this).val()); });
        parent.$('input[name=selectItem3]:checked').each(function(){ selectItem3.push($(this).val()); });
        parent.$('input[name=selectItem4]:checked').each(function(){ selectItem4.push($(this).val()); });
        parent.$('input[name=selectItem5]:checked').each(function(){ selectItem5.push($(this).val()); });
        parent.$('input[name=selectItem6]:checked').each(function(){ selectItem6.push($(this).val()); });
        parent.$('input[name=selectItem7]:checked').each(function(){ selectItem7.push($(this).val()); });
        parent.$('input[name=selectItem8]:checked').each(function(){ selectItem8.push($(this).val()); });
        parent.$('input[name=selectItem9]:checked').each(function(){ selectItem9.push($(this).val()); });
        parent.$('input[name=selectItem10]:checked').each(function(){ selectItem10.push($(this).val()); });
        parent.$('input[name=selectItem11]:checked').each(function(){ selectItem11.push($(this).val()); });
        
        var filterCon   =  'selectItem1:'+selectItem1+';'
				        +  'selectItem2:'+selectItem2+';'
				        +  'selectItem3:'+selectItem3+';'
				        +  'selectItem4:'+selectItem4+';'
				        +  'selectItem5:'+selectItem5+';'
				        +  'selectItem6:'+selectItem6+';'
				        +  'selectItem7:'+selectItem7+';'
				        +  'selectItem8:'+selectItem8+';'
				        +  'selectItem9:'+selectItem9+';'
				        +  'selectItem10:'+selectItem10+';'
				        +  'selectItem11:'+selectItem11+';' ;
        
        $("#filterCon").val(filterCon); // 필터선택정보가 취합된다...        
        $("#ctgryCode").val(parent.$("#ctgryCode").val());
        $("#keyWord").val(parent.$("#realQuery").val());
        $("#goodsTyCd").val(parent.$("#goodsTyCd").val());
       
        var $good_jop = "";
        parent.$(".goods_check").each(function(){
            if($(this).is(":checked")){
                $good_jop += ","+$(this).val();
            }
        });

        if($good_jop =="") {alert('체크된 서비스가 없습니다.'); jsClose();}
        $("#goodsCodesSel").val($good_jop.replace(',',''));
        $("#goodsCodes").val($good_jop.replace(',',''));
        </c:if>
        
        
        <c:if test="${mode eq 'compare'}">
        /*리스트항목에서 가져오기*/
         $good_jop = "";
         parent.$(".goods_code").each(function(){
            if($(this).is(":checked")){
                $good_jop += ","+$(this).val();
            }
        });
      
        if($good_jop =="") {alert('체크된 서비스가 없습니다.'); jsClose();}
        $("#goodsCodesSel").val($good_jop.replace(',',''));
        $("#goodsCodes").val($good_jop.replace(',',''));
        </c:if>
        
        <c:if test="${mode eq 'form'}">
        $("#goodsTyCd").val(parent.$("#goodsTyCd").val());
        $("#goodsCodes").val(parent.$("#goodsCode").val());
        $("#goodsCodesSel").val(parent.$("#goodsCode").val());
        </c:if>
    });
    
    // '목록에 담기' 클릭
    var jsWishOrder = function(){
        
        if($("#grpSeq").val() == null || $("#grpSeq").val() == ""){
            alert("사업명이 존재하지 않습니다. 사업명을 생성하세요.");
            $("#auditlogNm").focus();
            return false;
        }      
        
        $("#dataForm").ajaxSubmit({
            url      : "/korean/store/ND_WishOrder.do",
            type     : "POST",
            dataType : "json",
            success  : function(response){
                $("#viewAuditlogNm").append('\"' + $("#grpSeq :selected").text() + '\"');
                $("#divSave").hide();
                $("#divBtn").hide();
           		$("#divView").show();
            }
        });        
    };
    
    // 사업명생성
    var jsWishInfor = function(){
    	
    	  if($("#auditlogNm").val() == null || $("#auditlogNm").val() == ""){
              alert("사업명을 입력해주세요.");
              $("#auditlogNm").focus();
              return false;
          }
    	  
    	
    	
    	  $("#dataForm").ajaxSubmit({
              url      : "/korean/store/ND_WishInfor.do",
              type     : "POST",
              dataType : "json",
              success  : function(response){
                  location.reload();
              }
          });
    	
    };
    
    // 닫기
    var jsClose = function(){
        parent.$.fn.colorbox.close();
    };
	</script>
</head>


 <body class="winPopup listAdd">
	 <h2>이용희망목록에 담기 <a href="#"  onclick="jsClose();">닫기</a></h2>
	 <div id="divSave">
		<form id="dataForm" action="" method="post">
			<input type="hidden" name="goodsTyCd"     id="goodsTyCd">
			<input type="hidden" name="ctgryCode"     id="ctgryCode">
			<input type="hidden" name="filterCon"     id="filterCon">
			<input type="hidden" name="keyWord"       id="keyWord">
			<input type="hidden" name="goodsCodes"    id="goodsCodes">
			<input type="hidden" name="goodsCodesSel" id="goodsCodesSel">

			<div>
				<table class="tbl_st4">			
				<%-- <c:if test="${mode eq 'list'}">  --%>
					<tr>
						<th>사업명 생성</th>
						<td>
							<div><input type="text" name="auditlogNm" id="auditlogNm"  maxlength="500" placeholder=" 사업명을 입력하세요" class="w650" /></div>
							<button  onclick="jsWishInfor(); return false;">만들기</button>
						</td>
					</tr>
				<%-- </c:if>	 --%>
					<tr>
						<th>사업명 선택</th>
						<td> <span class="sel_box">
							<select name="grpSeq" id="grpSeq">
							<c:forEach items="${baseList}" var="myWishVo">
								<option value="${myWishVo.grpSeq}">${myWishVo.auditlogNm}</option>
							</c:forEach>
							</select></span>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>	
	<div class="btnArea" id="divBtn">
		<a href="#" onclick="jsWishOrder();" class="btns st1">목록에 담기</a>		
	</div>
	<div id="divView" style="display:none;">
		<div>
			<p>선택한 서비스를 사업명 <strong id="viewAuditlogNm"></strong>의 이용희망목록에 담았습니다.</p>
		</div>
		<div class="btnArea">
			<a href="/korean/pt/wish/BD_index.do" class="btns st1" target="_parent">이용희망목록 보기</a>		
		</div>
	</div>	
		
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
 </body>

</body>
</html>

