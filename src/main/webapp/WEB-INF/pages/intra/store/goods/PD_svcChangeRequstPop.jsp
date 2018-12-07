<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>전체서비스 목록/관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker"/>

<script type="text/javascript">
	/* parent.$("input[name=goodsCodes]:checked").each(function (i) {
	   if("${goodsRegistSttus}" == parent.$("#goodsStatuss" + this.value).val() ){
	       parent.$.fn.colorbox.close();
	      return;
	   }    
	}); */
	
	$().ready(function () {    
	  $('#dspyCnvrsPrearngeDt').datepicker({
	            showOn : 'button',
	            defaultDate : null,
	            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
	            buttonImageOnly : true
	        });
	});

	
	// 서비스변경요청제출
	var jsSvcChangeRequstPresentn = function(){
	    if($("#requstSe").val() == null || $("#requstSe").val() == ""){
	        alert("요청구분이 존재하지 않습니다.\r\n관리자에게 문의하세요.");
	        return false;
	    }
	    if($("#requstResn").val() == null || $("#requstResn").val() == ""){
	        alert("요청사유를 선택하세요.");
	        $("#requstResn").focus();
	        return false;
	    }
	    
	    var dspyCnvrsPrearngeDt = "";
	    <c:if test="${requstSe == 1002}">
	    if($("#dspyCnvrsPrearngeDt").val() == null || $("#dspyCnvrsPrearngeDt").val() == ""){
	        alert("작업완료 예정일을 선택하세요.");
	        $("#requstResn").focus();
	        return false;
	    }
	    
	    var nowDe = new Date();
	       dspyCnvrsPrearngeDt = $('#dspyCnvrsPrearngeDt').val().replace(/-/gi,"");
	    var nowDt = nowDe.getFullYear() + '' + prependZero(nowDe.getMonth()+1,2) + '' + prependZero(nowDe.getDate(),2);
	    if(dspyCnvrsPrearngeDt <= nowDt){
	        alert("작업완료 예정일은 오늘 이후로 지정해야 합니다.");
	        $('#dspyCnvrsPrearngeDt').focus();
	        return false;
	    }
	 
	    </c:if>
	    
	    <c:if test="${requstSe != 1003}">
	    var goodsCodes = new Array();
        var goodsStatuss = new Array();
        var ActvtyMsg;
	    parent.$("input[name=goodsCodes]:checked").each(function (i) {
            goodsCodes[i] = $(this).val();
            goodsStatuss[i] = parent.$("#goodsStatuss" + this.value).val();
      	});
	    </c:if>
	    <c:if test="${requstSe == 1003}">
	    var goodsCodes =  parent.$("#goodsCode").val();
	    var goodsStatuss ="";
	    </c:if>	 
	  
 	  var requstResn =  $("#requstResn").val();
 	  jQuery.ajaxSettings.traditional = true;
 	 
 	 $.ajax({
	        url      : "PD_svcChangeRequstUpdate.do",
	        type     : "POST",
	        data 	 : { goodsCodes : goodsCodes, goodsRegistSttus:${goodsRegistSttus}, requstSe : ${requstSe}, goodsStatuss : goodsStatuss, requstResn : requstResn,dspyCnvrsPrearngeDt : dspyCnvrsPrearngeDt },
	        dataType : "json",
	        success : function(result) {

                if(result.result) {
                    alert(Message.msg.processOk);
                    <c:if test="${requstSe == 1003}">
                    parent.jsList('BD_index.do');
                    </c:if>
                    <c:if test="${requstSe != 1003}">
                    parent.location.reload();
                    </c:if>
                }  else  {
                    if (result.message != "") {
                        alert("실패");
                        jsWarningBox(result.message);
                    } else {
                        jsWarningBox(Message.msg.processFail);
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
    
</script>
</head>
<body>
	<!-- content -->

		
	<form id="dataForm" action="" method="post">
			 <table class="boardWrite">	
				<tr>
					<th>처리구분</th>
					<td>
						<op:code id="requstSe" grpCd="2047" defaultValues="${requstSe}"  option="disabled" type="select" defaultLabel="전체"  />
					</td>
				</tr>
				<tr>
					<th>처리사유</th>
					<td>
					<c:if test="${requstSe == 1001}">
						<op:code id="requstResn" grpCd="2048"  type="select" defaultLabel="전체"  />
					</c:if>
					<c:if test="${requstSe == 1002}">
						<op:code id="requstResn" grpCd="2049"  type="select" defaultLabel="전체"  />
					</c:if>
					<c:if test="${requstSe == 1003}">
						<op:code id="requstResn" grpCd="2050"  type="select" defaultLabel="전체"  />
					</c:if>
					</td>
				</tr>
				<c:if test="${requstSe == 1002}">
				<tr>
					<th>작업완료 예정일</th>
					<td> 
						<input type="text" name="dspyCnvrsPrearngeDt" id="dspyCnvrsPrearngeDt" readonly="readonly" title="전시전환예정일" />
					</td>
				</tr>
				</c:if>
			</table>
			<div class="float_r">
			<button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSvcChangeRequstPresentn();">반영</button>&nbsp;&nbsp;
			</div>
		</form>
	
</body>
</html>		
						
