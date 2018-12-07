<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
    <title>지원계약 현황</title>
    <op:jsTag type="spi" items="form,validate" />
    <op:jsTag type="openworks" />


<script type='text/javascript'>
    $().ready(function () {
        
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
    
    var serviceListExcel = function() {
        location.href = "/intra/analyze/statistic/cntrct/INC_sportCntrctListExcel.do?" + $("#dataForm").serialize();
    }
    
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_sportCntrct.do">
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>계약년도</th>
                                <td>
                                    <select id="cntrDt" name="cntrDt">
                                        <option value="">전체</option>
                                        <option value="2018" <c:if test="${param.cntrDt eq '2018'}"> selected</c:if>>2018년</option>
                                        <option value="2017" <c:if test="${param.cntrDt eq '2017'}"> selected</c:if>>2017년</option>
                                        <option value="2016" <c:if test="${param.cntrDt eq '2016'}"> selected</c:if>>2016년</option>
                                    </select>
                                </td>
                            </tr>
<%--                             
                            <tr>
                                <th>기업명</th>
                                <td><input type="text" id="purchsInsttNm" name="purchsInsttNm" style="width:400px;" value="${param.purchsInsttNm }"/></td>
                            </tr>
 --%>                            
                        </tbody>
                    </table>
                    <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                    <!-- <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button> -->
                    
                </fieldset>
            </div>
        <!-- //검색 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="15%"/>
                <col width="15%"/>
                <col width="15%"/>
            </colgroup>
            <thead>
                <tr>      
                    <th>계약년도</th>
                    <th>사업체결 수</th>
                    <th>지원계약 수</th>
                    <th>총 계약금액</th>
                </tr>
            </thead>
            <tbody id="odd-color">
            <c:forEach var="dataList" items="${cntrctSportTotList}" varStatus="status">
                <tr>                
                    <td>${dataList.cntrDt}</td>
                    <td style="text-align: center;"><span style="text-align: right;display:inline-block;width: 33%;">${dataList.svcNmCnt}</span></td>
                    <td style="text-align: center;"><span style="text-align: right;display:inline-block;width: 33%;"><fmt:formatNumber value="${dataList.cntrCount}" type="NUMBER" groupingUsed="true"/></span></td>
                    <td style="text-align: center;"><span style="text-align: right;display:inline-block;width: 33%;"><fmt:formatNumber value="${dataList.cntrctAmount}" type="NUMBER" groupingUsed="true"/></span></td>
                </tr>
             </c:forEach>
            </tbody>
        </table>
        <br/>
        
       <div style="width:100%:">전체 ${sportCount} 건
        	<span style="margin:10px 0 10px 86%;">
        		<button id="xlsDownload" class="gray vm" onclick="javascript:serviceListExcel(); return false;" style="cursor: pointer;">엑셀 다운로드</button>
        	</span>
        </div>
        <table class="boardList" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width=""/>
                <col width="6%"/>
                <col width=""/>
                <col width="10%"/>
                <col width=""/>
                <col width="7%"/>
                <col width=""/>
                <col width="6%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>      
                    <th>No.</th>
                    <th>사업명</th>
                    <th>서비스 구분</th>
                    <th>서비스 명</th>
                    <th>제공자명</th>
                    <th>계약기관</th>
                    <th>계약체곌일</th>
                    <th>계약기간</th>
                    <th>지원계약 수</th>
                    <th>주 계약금액</th>
                </tr>
            </thead>
            <tbody id="odd-color">
            <c:forEach var="dataList" items="${cntrctSportList}" varStatus="status">
                <tr>
                    <td>${fn:length(cntrctSportList)-status.index}</td>
                    <td style="text-align:left">
                        <span onclick="javascript:fnServiceList(this,'${dataList.goodsCode}','${dataList.svcNm}')" class="dataSvcNm" style="cursor: pointer;">${dataList.svcNm}</span>
                    </td>
                    <td>${dataList.goodsKnd}</td>
                    <td style="text-align:left">${dataList.sleInsttNm}</td>
                    <td style="text-align:left">${dataList.goodsMakr}</td>
                    <td style="text-align:left">${dataList.purchsInsttNm}</td>
                    <td>${dataList.cntrDt}</td>
                    <td>${dataList.cntrctBeginDe} ~ ${dataList.cntrctEndDe}</td>
                    <td><fmt:formatNumber value="${dataList.cntrCount}" type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                </tr>
             </c:forEach>   
            </tbody>
        </table>
    </form>        
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>