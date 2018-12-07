<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
    <title>서비스 통계</title>
    <op:jsTag type="spi" items="form,validate" />
    <op:jsTag type="openworks" />

<script type='text/javascript'>
    $(document).ready(function(){

    });
     
    var fnServiceList = function(el, vl1, vl2) {
        
        var goodsCode = vl1;
        var encodeStr = escape(vl2);
        
        //var encodeStr = escape(vl);
        
        $(el).colorbox({
            title  : "님 비밀번호 변경하기",
            href   : "PD_serviceList.do?goodsCode="+goodsCode+"&svcNm="+encodeStr,
            width  : "90%",
            height : "80%",
            iframe : true
        });
    };

    
    var jsSearch = function () {
        document.dataForm.submit();
    }
    
    var fnSortList = function(vl) {
        $("#sortVl").val(vl)
        document.dataForm.submit();
    }
    
    
    var serviceListExcel = function() {
        location.href = "/intra/analyze/statistic/cntrct/INC_serviceListExcel.do?" + $("#dataForm").serialize();
    }
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_service.do">
        <input type="hidden" id="sortVl" name="sortVl" value="${param.sortList}"/>
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="70" />
                            <col width="410" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>조회조건</th>
                                <!-- th>서비스 구분</th -->
                                <td>
                                    <select id="goodsKnd" name="goodsKnd">
                                        <option value="" selected="selected">전체</option>
                                        <option value="SaaS" <c:if test="${param.goodsKnd eq 'SaaS'}"> selected</c:if>>SaaS</option>
                                        <option value="PaaS" <c:if test="${param.goodsKnd eq 'PaaS'}"> selected</c:if>>PaaS</option>
                                        <option value="IaaS" <c:if test="${param.goodsKnd eq 'IaaS'}"> selected</c:if>>IaaS</option>
                                    </select>
                                </td>
                                <!-- th>서비스명</th -->
                                <td><input type="text" id="svcNm" name="svcNm" style="width:400px;" value="${param.svcNm}"/></td>
                                <td>
                                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" style="margin-top: 3px;" onclick="jsSearch();">검색</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <!-- <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button> -->
                    
                </fieldset>
            </div>
            
        <!-- //검색 -->
        <div style="width:100%; margin: 0 0 10px 0;">
        	전체 ${serviceCount} 건 
        	<span style="margin:0 0 0 76%;">정렬기준 
        		<select id="sortList" onchange="javascript:fnSortList(this.value);">
        			<option value="cntrctAmount" <c:if test="${param.sortVl eq 'cntrctAmount'}"> selected </c:if>>계약금액</option>
        			<option value="svcNm"        <c:if test="${param.sortVl eq 'svcNm'}"> selected </c:if>>서비스명</option>
        		</select>
        		<button id="xlsDownload" class="gray vm" onclick="javascript:serviceListExcel(); return false;" style="cursor: pointer;">엑셀 다운로드</button>
        	</span>
        </div>
<!--         <div style="position: relative;top: -19px;text-align:right;">
               <button id="xlsDownload" class="gray vm" onclick="javascript:serviceListExcel(); return false;" style="cursor: pointer;">엑셀 다운로드</button>
           </div> -->
            
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="10%"/>
                <col width=""/>
                <col width="8%"/>
                <col width="17%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>      
                    <th rowspan="2">No.</th>
                    <th rowspan="2">서비스명</th>
                    <th rowspan="2">서비스 구분</th>
                    <th rowspan="2">총 계약금액</th>
                    <th colspan="3">이용기관(이용자)</th>
                </tr>
                <tr>
                    <th>공공회원</th>
                    <th>기업회원</th>
                    <th>개인회원</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:forEach var="dataList" items="${cntrctServiceList}" varStatus="status">
                    <c:set var="cntrctAmount" value="${cntrctAmount + dataList.cntrctAmount }"/>
                    <c:set var="privAmount"   value="${privAmount + dataList.privAmount }"/>
                    <c:set var="corpAmount"   value="${corpAmount + dataList.corpAmount }"/>
                    <c:set var="orgAmount"    value="${orgAmount + dataList.orgAmount }"/>
                </c:forEach>
                <tr>
                    <td class="sum" colspan="3">합계</td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${privAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${corpAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${orgAmount}" type="NUMBER" groupingUsed="true"/></td>
                </tr>
            <c:forEach var="dataList" items="${cntrctServiceList}" varStatus="status">
                <tr>
                    <td>${status.index+1}</td>
                    <td style="text-align:left">
                        <span onclick="javascript:fnServiceList(this,'${dataList.goodsCode}','${dataList.svcNm}')" class="dataSvcNm" style="cursor: pointer;">${dataList.svcNm}</span>
                    </td>
                    <td>${dataList.goodsKnd}</td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.privAmount}"   type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.corpAmount}"   type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.orgAmount}"    type="NUMBER" groupingUsed="true"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>        
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>