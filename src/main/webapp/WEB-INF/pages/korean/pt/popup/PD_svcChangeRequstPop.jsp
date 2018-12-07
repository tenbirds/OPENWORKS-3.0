<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>서비스상태변경요청</title>
    
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
    <link rel='stylesheet' type="text/css" href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    
    <op:jsTag type="spi" items="datepicker"/>
    
    <script type="text/javascript" src="/resources/cmmnty/common/js/fakeselect.js"></script>

    
    <script type="text/javascript">
    
    $(window).load(function() {
		
        <c:if test="${baseVo.requstSe != 1003}">
        $("#goodsCode").val(parent.$(':input[name=goodsCodes]:radio:checked').val());
        $("#exmntConfmCd").val(parent.$("#goodsStatuss" + $("#goodsCode").val()).val());
        </c:if>
        <c:if test="${baseVo.requstSe == 1003}">
        $("#goodsCode").val(parent.$("#goodsCode").val());
        $("#exmntConfmCd").val(parent.$("#goodsStatus").val());
        </c:if>
        <c:if test="${baseVo.requstSe == 1002}">
        $("#dspyCnvrsPrearngeDt").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });
        </c:if>
    });
    
    // 서비스변경요청제출
    var jsSvcChangeRequstPresentn = function(){
        if($("#requstSe").val() == null || $("#requstSe").val() == ""){
            alert("요청구분이 존재하지 않습니다.\r\n관리자에게 문의하세요.");
            jsClose();
            return false;
        }
        if($("#requstResn").val() == null || $("#requstResn").val() == ""){
            alert("요청사유를 선택하세요.");
            $("#requstResn").focus();
            return false;
        }
        <c:if test="${baseVo.requstSe == 1002}">
        if($("#dspyCnvrsPrearngeDt").val() == null || $("#dspyCnvrsPrearngeDt").val() == ""){
            alert("작업완료 예정일을 선택하세요.");
            $("#requstResn").focus();
            return false;
        }
        
        var nowDe = new Date();
        var dspyCnvrsPrearngeDt = $('#dspyCnvrsPrearngeDt').val().replace(/-/gi,"");
        var nowDt = nowDe.getFullYear() + '' + prependZero(nowDe.getMonth()+1,2) + '' + prependZero(nowDe.getDate(),2);
        if(dspyCnvrsPrearngeDt <= nowDt){
            alert("작업완료 예정일은 오늘 이후로 지정해야 합니다.");
            $('#dspyCnvrsPrearngeDt').focus();
            return false;
        }
        </c:if>
        
        $("#dataForm").ajaxSubmit({
            url      : "/korean/pt/sale/goods/ND_SvcChangeRequstPresentn.do",
            type     : "POST",
            dataType : "json",
            success  : function(response){
                if(response.result){
                    alert(Message.msg.orderOk);
                    <c:if test="${baseVo.requstSe != 1003}">
                    parent.location.reload();
                    </c:if>
                    <c:if test="${baseVo.requstSe == 1003}">
	                    if($("#exmntConfmCd").val() == '1007'){
	                        parent.location.href = "/korean/pt/sale/goods/BD_goodsList.do";
	                    } else {
	                        parent.location.href = "/korean/pt/sale/goods/BD_waitingList.do";   
	                    }
                    </c:if>
                } else {
                    if(response.message == "requiredLogin"){
                        if(confirm(Message.msg.requiredLogin)){
                            returnUrl = "/korean/pt/sale/goods/BD_goodsList.do";
                            top.parent.location.href = "/korean/pt/login/user/BD_index.do?returnUrl="+returnUrl;
                        }
                    } else{
                        alert(Message.msg.processError);
                    }
                }
                
            }
        });
        
    };
    
    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero
    
 	// 카테고리 검색
    var jsRequstResnList = function(){
      
 	  var url = "ND_requstResnList.do?";
      url+= "requstSe=" + $("#requstSe").val();

      //선택값초기화
      var innerHtml = '<option value="">선택</option>';
      $("#requstResn").html("").append(innerHtml).trigger("change");
      
      $.post(url , 
      function(response){
          if(response.length > 0){
              
              var innerHtml2 = '';
              for (var i = 0; i < response.length; i++) {
                  innerHtml2 += '<option value="'+response[i].prvCd+'">'+response[i].prvNm+'</option>';
              }
              $("#requstResn").append(innerHtml2);
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
	<h2>서비스상태변경요청 <a href="#"  onclick="jsClose();">닫기</a></h2>
	<div id="divSave">
		<form id="dataForm" action="" method="post">
		<input type="hidden" name="goodsCode" id="goodsCode" value="" />
		<input type="hidden" name="requstSe" id="requstSe" value="${baseVo.requstSe}" />
		<input type="hidden" name="exmntConfmCd" id="exmntConfmCd" value="" />
		<div>
			<table class="tbl_st4">			
				<tr>
					<th>요청구분</th>
					<td>
						<c:forEach items="${codeList_requstSe}" var="requstSeCodeVO">
							<c:if test="${requstSeCodeVO.prvCd == baseVo.requstSe}">${requstSeCodeVO.prvNm}</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>요청사유</th>
					<td> 
						<select name="requstResn" style="width:250px;" id="requstResn">
							<option value="">선택</option>
							<c:forEach items="${codeList_requstResn}" var="requstResnCodeVO">
								<option value="${requstResnCodeVO.prvCd}">${requstResnCodeVO.prvNm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<c:if test="${baseVo.requstSe == 1002}">
				<tr>
					<th>작업완료 예정일</th>
					<td> 
						<input type="text" name="dspyCnvrsPrearngeDt" id="dspyCnvrsPrearngeDt" readonly="readonly" title="전시전환예정일" style="width: 95px; height:32px;"/>
					</td>
				</tr>
				</c:if>
			</table>
		</div>
		</form>
	</div>	
	<div class="btnArea" id="divBtn">
		<a href="#" onclick="jsSvcChangeRequstPresentn();" class="btns st1">요청</a>		
	</div>	
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
 </body>

</body>
</html>

