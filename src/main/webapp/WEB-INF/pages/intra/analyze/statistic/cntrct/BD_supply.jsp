<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
    <title>제공기업 통계</title>
    <op:jsTag type="spi" items="form,validate" />
    <op:jsTag type="openworks" />


<script type='text/javascript'>
    $().ready(function () {
        
    });

    var fnServiceList = function(el, vl1, vl2) {
        
        var userId = vl1;
        var encodeStr = escape(vl2);
        
        //var encodeStr = escape(vl);
        
        $(el).colorbox({
            title  : "님 비밀번호 변경하기",
            href   : "PD_serviceList.do?userId="+userId+"&goodsMakr="+encodeStr+"&goodsCode=&svcNm=",
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
        location.href = "/intra/analyze/statistic/cntrct/INC_supplyListExcel.do?" + $("#dataForm").serialize();
    }
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_supply.do">
        <input type="hidden" id="sortVl" name="sortVl" value="${param.sortList}"/>
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="100" />
                            <col width="100" />
                            <col width="410" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>기업 구분</th>
                                <td>
                                    <select id="smlpzChk" name="smlpzChk">
                                        <option value="">전체</option>
                                        <option value="중소기업" <c:if test="${param.smlpzChk eq '중소기업'}"> selected</c:if>>중소기업</option>
                                        <option value="중견기업" <c:if test="${param.smlpzChk eq '중견기업'}"> selected</c:if>>중견기업</option>
                                        <option value="대기업"  <c:if test="${param.smlpzChk eq '대기업'}"> selected</c:if>>대기업</option>
                                    </select>
                                </td>
                                <th>제공기업명</th>
                                <td><input type="text" id="goodsMakr" name="goodsMakr" style="width:400px;" value="${param.goodsMakr }"/></td>
                                <td><button type="button" class="blue mar_t10 mar_l5 mar_b5" style="margin-top: 3px;" onclick="jsSearch();">검색</button></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button> -->
                    
                </fieldset>
            </div>
            
        <!-- //검색 -->
        <div style="width:100%;margin-bottom: 10px;">
        	전체 ${supplyCount} 건 
        	<span style="margin:0 0 0 75%;">정렬기준&nbsp;
        		<select id="sortList" onchange="javascript:fnSortList(this.value);">
        			<option value="goodsMakr"    <c:if test="${param.sortVl eq 'goodsMakr'}"> selected </c:if>>제공기업명</option>
        			<option value="cntrctAmount" <c:if test="${param.sortVl eq 'cntrctAmount'}"> selected </c:if>>계약금액</option>
        		</select>
        		<button id="xlsDownload" class="gray vm" onclick="javascript:serviceListExcel(); return false;" style="cursor: pointer;">엑셀 다운로드</button>
        	</span>
        </div> 
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width=""/>
                <col width="15%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>      
                    <th rowspan="2">No.</th>
                    <th rowspan="2">제공기업명</th>
                    <th rowspan="2">기업구분</th>
                    <th rowspan="2">총 계약금액</th>
                    <th colspan="3">서비스 구분</th>
                </tr>
                <tr>
                    <th>SaaS</th>
                    <th>PaaS</th>
                    <th>IaaS</th>
                </tr>
            </thead>
            <tbody id="odd-color">
            <c:forEach var="dataList" items="${cntrctSupplyList}" varStatus="status">
                <c:set var="cntrctAmount" value="${cntrctAmount + dataList.cntrctAmount}"/>
                <c:set var="saasCnt" value="${saasCnt + dataList.saasCnt}"/>
                <c:set var="paasCnt" value="${paasCnt + dataList.paasCnt}"/>
                <c:set var="iaasCnt" value="${iaasCnt + dataList.iaasCnt}"/>
            </c:forEach>
                <tr>
                    <td class="sum" colspan="3">합계</td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${saasCnt}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${paasCnt}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${iaasCnt}" type="NUMBER" groupingUsed="true"/></td>
                </tr>
            
            <c:forEach var="dataList" items="${cntrctSupplyList}" varStatus="status">
                <tr>
                    <td>${status.index+1 }</td>
                    <td style="text-align:left"><span onclick="javascript:fnServiceList(this,'${dataList.userId}','${dataList.goodsMakr}')" class="dataSvcNm" style="cursor: pointer;">${dataList.goodsMakr }</span></td>
                    <td>${dataList.smlpzChk }</td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.cntrctAmount }" type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.saasCnt }" type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.paasCnt }" type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.iaasCnt }" type="NUMBER" groupingUsed="true"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>        
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>