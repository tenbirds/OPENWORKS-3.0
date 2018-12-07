<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>조달 나라장터 통합계약실적 목록</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<op:jsTag type="openworks" items="ckeditor" />
<script type="text/javascript">

//<![CDATA[
    $().ready(function () {

    	$.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
//        $('#q_naraDate').datepicker({
            //showOn : 'button',
            //defaultDate : null,
            //buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            //buttonImageOnly : true
        //});
     
        $("#q_beginDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });
        
        $("#q_endDate").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            }
        });

        //$("#q_naraDate").keyup(function(event){
            //if (!(event.keyCode >=37 && event.keyCode<=40)) {
                //var inputVal = $(this).val();
                //$(this).val(inputVal.replace(/[^a-z0-9\-]/gi,''));
            //}
        //});
        
                
    });//ready end

    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero

    var jsMovePage = function(page){
      	var p = 1;
      	if(page == 'page'){
          	p = $('input[name=page]').val();
      	}else{
          	p = page;
      	}
      	$("#dataForm input[name=q_currPage]").val(p);
      	$("#dataForm").submit();
    };

    var jsSearch = function(){
        document.dataForm.action = "BD_naraTotalCntrctInfoList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };

    var jsClean = function(){
        $("#q_userType").val("");
        $("#q_searchVal").val("");
        $("#q_beginDate").val("");
        $("#q_endDate").val("");        
        $("#q_naraDate").val("");
    };
    
    var jsExcelList = function() {
        $("#q_excel").val("2");
        location.href = "INC_naraCntrctExcel.do?" + $("#dataForm").serialize();
        $("#q_excel").val("");
    };

    
//    tcnCntrctInfoInterface                                    
//	tcnDvyfgInfoInterface    
    
    


    var naraInfoInterface = function(vl) {
		var msg;
        var url;
        
		if(vl == 'tcnCntrctInfoL'){
			msg = "계약정보를 연계하시겠습니까?";
			url = "ND_naraInfoInterface.do";
		} else if(vl == 'tcnDvyfgInfoL'){
			msg = "납품정보를 연계하시겠습니까?";
			url = "ND_tcnDvyfgInfoLInterface.do";
		}        
		
		var naraDate = $("#q_naraDate").val();
		

		if(confirm(msg)){
		    jQuery.ajaxSettings.traditional = true;
		
		    $.ajax({
		        url     : url,
		        type    : "POST",
		        data : { naraDate : naraDate },
		
		        success : function(result) {
		
		           if(result.result) {
		                jsSuccessBox(Message.msg.processOk);
		                self.location.reload();
		            }  else  {
		                if (result.message != "") {
		                    jsWarningBox(result.message);
		                } else {
		                    jsWarningBox(Message.msg.processFail);
		                }
		            }
		        }
		   });
		}
    };    
    
//]]>
</script>
</head>
<body>
    <div id="contents" style="width:2000px">
        
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_naraTotalCntrctInfoList.do">
            <div class="search" style="width:1200px">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                        <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건" style="width:1200px">
                            <colgroup>
                                <col width="120" />
                                <col width="100" />
                                <col width="100" />
                                 <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                	<th>검색조건</th>
                                    <td colspan="3">
                                    	<select id="q_userType" name="q_userType" >
                                    		<option value="10"  <c:if test="${searchMap.q_userType == '10'}">selected="selected"</c:if>>제공기업명</option>
                                    		<option value="20"  <c:if test="${searchMap.q_userType == '20'}">selected="selected"</c:if>>수요기관명</option>
                                    		<option value="30"  <c:if test="${searchMap.q_userType == '30'}">selected="selected"</c:if>>사업명</option>
                                    	</select>
                                    	<input type="text" class="w215" name="q_searchVal" id="q_searchVal" value="<c:out value="${searchMap.q_searchVal}" />"  title="검색어를 입력하세요." />
                                    </td>
                            	</tr>
                                <tr>
                                    <th>계약시작일</th>
                                    <td colspan="3">
                                    	<input class="w80" type="text"  name="q_beginDate" id="q_beginDate" title="시작날짜선택" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if>/> ~ 
                                    	<input class="w80" type="text"  name="q_endDate" id="q_endDate" title="시작날짜선택" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if>/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>나라장터연계</th>
                                    <td colspan="3">
                                    	<input class="w80" type="text"  name="q_naraDate" id="q_naraDate" title="시작날짜선택" <c:if test="${not empty searchMap.q_naraDate}"> value="${searchMap.q_naraDate}"</c:if>/>
										<button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="naraInfoInterface('tcnCntrctInfoL');">계약정보연계</button>&nbsp;&nbsp;                                    
										<button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="naraInfoInterface('tcnDvyfgInfoL');">납품정보연계</button>&nbsp;&nbsp;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                      <div>
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                        <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button>
                      </div>
                </fieldset>
            </div>
            <op:pagerParam title="조달통합계약실적목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>

                <col width="50px"/>
                <col width="*"/>
                <col width="45px"/>
                <col width="200px"/>
                <col width="120px"/>
                <col width="*"/>
                <col width="*"/>
                <col width="*"/>
                <col width="*"/>
                <col width="*"/>
                <col width="200px"/>
                <col width="*"/>
                <col width="100px"/>
                <col width="120px"/>
                <col width="*"/>
                <col width="*"/>
                <col width="*"/>
                <col width="*"/>
                <col width="*"/>
                                
            </colgroup>
            <thead>
            	<tr>
	                <th>번호</th>
	                <th>계약번호</th>
	                <th>물품일련번호</th>
	                <th>규격명</th>
	                <th>금액</th>
	                <th>제조사명</th>
	                <th>클라우드<BR />서비스코드</th>
	                <th>물품번호</th>
	                <th>제공기업명</th>
	                <th>수요기관명</th>
	                <th>사업명(계약건명)</th>
	                <th>계약일자(시작일/종료일)</th>
	                <th>계약금액(총액)</th>
	                <th>계약번호</th>
	                <th>납품요구번호</th>	                
	                <!-- th>품명설명</th -->	                
	                <!-- th>규격</th -->	                
	                <th>납품단가</th>	                
	                <th>납품단위</th>	                
	                <th>납품금액</th>	                
	                <th>납품기한</th>	                
	                <!-- th>납품장소</th -->	                
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td><c:out value="${index-status.index}"/></td>
                        <td><c:out value="${baseVo.cntrNum}"/></td>
                        <td><c:out value="${baseVo.lineNum}"/></td>
                        <td><c:out value="${baseVo.itemName}"/></td>
                        <td><fmt:formatNumber value="${baseVo.unitPric}" type="NUMBER" groupingUsed="true"/></td>
                        <td><c:out value="${baseVo.manuName}"/></td>
                        <td><c:out value="${baseVo.goodsCode}"/></td>
                        <td><c:out value="${baseVo.itemIdntfcNo}"/></td>
                        <td><c:out value="${baseVo.mainCntrctEntrpsNm}"/></td>
                        <td><c:out value="${baseVo.realOrgnNm}"/></td>
						<td style="text-align:left"><c:out value="${baseVo.cntrctNm}"/></td>
                        <td>
                        	<c:out value="${baseVo.cntrctDate}"/> ~ <c:out value="${baseVo.cntrctPd}"/>
                        </td>
                        <td style="text-align:right">
                        	<fmt:formatNumber value="${baseVo.cntrctThisTimeAmt}" type="NUMBER" groupingUsed="true"/>
                        </td>
                        <td><c:out value="${baseVo.cntrctNo}"/></td>
                        <td style="text-align:center"><c:out value="${baseVo.deliveryNum}"/></td>
                        
<!--                        <td style="text-align:left"><c:out value="${baseVo.itemDesptn}"/></td> 
                        <td style="text-align:center"><c:out value="${baseVo.itemQuantity}"/></td>   -->
                        <td style="text-align:right"><fmt:formatNumber value="${baseVo.unitPrice}" type="NUMBER" groupingUsed="true"/></td>
                        
                        <td style="text-align:center"><c:out value="${baseVo.itemUnit}"/></td>
						<td style="text-align:right"><fmt:formatNumber value="${baseVo.itemAmount}" type="NUMBER" groupingUsed="true"/></td>                        
                        <td style="text-align:center"><c:out value="${baseVo.deliveryDate}"/></td>
                        <!-- td style="text-align:left"><c:out value="${baseVo.deliveryPlace}"/></td -->
                        
                    </tr> 
                </c:forEach>
                <op:no-data obj="${pager}" colspan="12" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        
        <op:pager pager="${pager}" />
        <c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G' or MenuAssignType eq 'R'}">
            <div class="float_l">
	            <a href="javascript:;" onclick="jsExcelList(this);"><button class="w_blue" type="button">엑셀다운로드</button></a>
	        </div>
        </c:if>
    </div>
</body>

</html>