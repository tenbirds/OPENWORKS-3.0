<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<op:jsTag type="spi" items="form,colorbox" />
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript">

var jsSubmit = function() {
    
    if($("#returnResn").val().length == 0) {
        alert("반려사유를 입력해주세요"); 
        return;
    }else if($("#returnResn").val().length > 2000) {
        alert("반려사유는 최대 2000자 까지 입력가능합니다."); 
        return;
    }
    
    if(confirm("해당 서비스를 반려 하시겠습니까?")){
	    $(dataForm).ajaxSubmit({
	     url      : "ND_reasonAction.do",
	     type     : "POST",
	     dataType : "text",
	     success  : function(response) {
	          if (response) {
	              alert("반려사유가 입력되었습니다.");
				  parent.$.fn.colorbox.close();
				  if($("#exmntConfmCd").val() == 1003 ){
					  parent.location.href='BD_goodsExmntList.do';
				  }else{
					  parent.location.href='BD_goodsConfnList.do';
				  }
	          }else{
	              alert("반려사유 입력이 실패되었습니다.");
	          }
	     }
	  });
    }
};
</script>
</head>
<body>
 <!-- 검토반려(return) : infoR / 승인반려(confm) : infoC   => 승인반려경우 검토관리자정보가 없는경우 사용 /  infoS   => 승인반려사유보기 -->
<c:set var="info" value="${empty dataVO.mngrId or empty dataVO.mngrNm ? 'infoR':'infoC' }"/> 
<c:set var="confmSection" value="${dataVO.confmReturnSection eq 1005 ? 'infoS':'infoC' }"/> 

<c:choose>
    <c:when test="${dataVO.exmntConfmCd eq 1003 or info eq 'infoR' and confmSection eq 'infoC'}"><c:set var="name" value="판매자"/></c:when>
    <c:when test="${info eq 'infoC' and confmSection eq 'infoC' }"><c:set var="name" value="검토관리자"/></c:when>
    <c:when test="${confmSection eq 'infoS' }"><c:set var="name" value="승인관리자"/></c:when>
</c:choose>

    <form action="ND_reasonAction.do" id="dataForm" name="dataForm">
        <input type="hidden" id="langCode" name="langCode" value="${dataVO.langCode}"/> 
        <input type="hidden" id="goodsCode" name="goodsCode" value="${dataVO.goodsCode}"/> 
        <input type="hidden" id="exmntConfmCd" name="exmntConfmCd" value="${dataVO.exmntConfmCd}"/> 
        <input type="hidden" id="exmntConfmHistSn" name="exmntConfmHistSn" value="${dataVO.exmntConfmHistSn}"/>
        
	    <div id="popup" class="popup">
	        <fieldset>
	            <legend>${name}정보 </legend>
	            <strong>* ${name}정보 </strong>
	            
		            <table class="boardWrite" cellspacing="0" border="0" summary="${name}의 정보를 확인할수있습니다.">
		                <caption class="hidden">${name}정보</caption>
		                <colgroup>
		                    <col width="20%" />
		                    <col width="30%" />
		                    <col width="20%" />
		                    <col width="30%" />
		                </colgroup>
		                <tbody id="odd-color">
				            <c:if test="${dataVO.exmntConfmCd eq 1003 or info eq 'infoR'}"> <!-- 검토반려 -->
			                    <tr>
			                        <th>상점명</th>
			                        <td colspan="3">${dataVO.langStoreNm}</td>
			                    </tr>
			                    <tr>
			                        <th>담당자</th>
			                        <td>${dataVO.goodsChargerNm}</td>
			                        <th>ID</th>
			                        <td>${dataVO.userId}</td>
			                    </tr>
			                    <tr>
			                        <th>연락처(담당자)</th>
			                        <td>${dataVO.goodsChargerCttpc}</td>
			                        <th>휴대전화(담당자)</th>
			                        <td>${dataVO.goodsChargerMbtlnum}</td>
			                    </tr>
			                    <tr>
			                        <th>E-mail(담당자)</th>
			                        <td colspan="3">${dataVO.goodsChargerEmail}</td>
			                    </tr>
				            </c:if>
	                        <c:if test="${dataVO.exmntConfmCd eq 1005 or info eq 'infoC'}"> <!-- 승인반려 -->
	                            <tr>
	                                <th>${name}</th>
	                                <td>${dataVO.mngrNm}</td>
	                                <%-- <th>ID</th>
	                                <td>${dataVO.mngrId}</td> --%>
	                                <th>부서명</th>
	                                <td>${dataVO.deptNm}</td>
	                                <%-- <th>부서번호</th>
	                                <td>${dataVO.telno}</td> --%>
	                            </tr>
	                        </c:if>
		                </tbody>
		            </table>
                <br/>
                <c:if test="${confmSection eq 'infoS' }">
	                <strong><h2 style="margin: 10px;">${name} 반려사유</h2></strong>
			        <div style="border: 1px solid; width: 90%;height: 100px;margin: 10px;font-size: larger;text-align: left;padding: 5px;"><c:out value='${dataVO.returnResn}'/></div>
                </c:if>
                <c:if test="${confmSection ne 'infoS' }">
	                <strong>* ${dataVO.exmntConfmCd eq 1003? '승인':'승인'} 반려사유 입력</strong>
		            <textarea rows="30" cols="106" id="returnResn" name="returnResn"></textarea>
                </c:if>
	        </fieldset>
	    </div>
	    <p class="tx_c mar_t20">
            <c:if test="${confmSection eq 'infoS' }">
	           <a href="#"><button type="button" onclick="parent.jQuery.colorbox.close();" class="blue" >확인</button></a>
            </c:if>
            <c:if test="${confmSection ne 'infoS' }">
	           <a href="#"><button type="button" onclick="jsSubmit();" class="blue" > ${dataVO.exmntConfmCd eq 1003? '승인':'승인'}반려</button></a>
            </c:if>
             <a href="#"><button type="button" onclick="parent.jQuery.colorbox.close();" class="blue" >닫기</button></a>
	    </p>
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>