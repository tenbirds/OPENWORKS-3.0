<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
    <title>이용기관 통계</title>
    <op:jsTag type="spi" items="form,validate" />
    <op:jsTag type="openworks" />


<script type='text/javascript'>
    $().ready(function () {
        
    });

    var jsSearch = function () {
        document.dataForm.submit();
    }
    
    var fnSortList = function(vl) {
        $("#sortVl").val(vl)
        document.dataForm.submit();
    }
    
    var serviceListExcel = function() {
        location.href = "/intra/analyze/statistic/cntrct/INC_useInsttListExcel.do?" + $("#dataForm").serialize();
    }
    
    var fnContractList = function(el,userTyCd,purchsInsttNm,basicDate) {
        
        $(el).colorbox({
            title  : "상세 계약내용리스트",
            href   : "PD_contractList.do?userTyCd="+userTyCd+"&purchsInsttNm="+purchsInsttNm+"&basicDate="+basicDate,
            width  : "90%",
            height : "80%",
            iframe : true
        });
    }
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_useInstt.do">
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
                                <th>이용자 구분</th>
                                <td>
                                    <select id="userTy" name="userTy">
                                        <option value="">전체</option>
                                        <option value="공공" <c:if test="${param.userTy eq '공공'}"> selected</c:if>>공공기관</option>
                                        <option value="기업" <c:if test="${param.userTy eq '기업'}"> selected</c:if>>기업회원</option>
                                        <option value="개인" <c:if test="${param.userTy eq '개인'}"> selected</c:if>>개인</option>
                                    </select>
                                </td>
                                <th>이용기관명</th>
                                <td><input type="text" id="purchsInsttNm" name="purchsInsttNm" style="width:400px;" value="${param.purchsInsttNm }"/></td>
                                <td><button type="button" class="blue mar_t10 mar_l5 mar_b5" style="margin-top: 3px;" onclick="jsSearch();">검색</button></td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <!-- <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button> -->
                    
                </fieldset>
            </div>
            
        <!-- //검색 -->
        
        <div style="float: left;">전체${useInsttCnt} 건</div>
        <div style="float: right;">
        	<span style="">정렬기준&nbsp;
        		<select id="sortList" onchange="javascript:fnSortList(this.value);">
        			<option value="purchsInsttNm"	<c:if test="${param.sortVl eq 'purchsInsttNm'}"> selected </c:if>>이용기관</option>
        			<option value="cntrctAmount"	<c:if test="${param.sortVl eq 'cntrctAmount'}">  selected </c:if>>계약금액</option>
        		</select>
        	<button id="xlsDownload" class="gray vm" onclick="javascript:serviceListExcel(); return false;" style="cursor: pointer;">엑셀 다운로드</button>
        	</span>
        </div>
        <br/><br/>
        
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="15%"/>
                <col width=""/>
                <col width="15%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>      
                    <th>No.</th>
                    <th>이용자 구분</th>
                    <th>이용기관명(이용자명)</th>
                    <th>총 계약금액</th>
                    <th>계약 건수</th>
                </tr>
            </thead>
            <tbody id="odd-color">
            <c:forEach var="dataList" items="${cntrctUseInsttList}" varStatus="status">
                <c:set var="cntrctAmount" value="${cntrctAmount + dataList.cntrctAmount }" />
                <c:set var="cntrctNum" value="${cntrctNum + dataList.cntrctNum }" />
            </c:forEach>
                <tr>
                    <td class="sum" colspan="3">합계</td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td class="sum" style="text-align:right"><fmt:formatNumber value="${cntrctNum}" type="NUMBER" groupingUsed="true"/></td>
                </tr>
                
            <c:forEach var="dataList" items="${cntrctUseInsttList}" varStatus="status">
                <tr>
                    <td>${status.index+1}</td>
                    <td>${dataList.userTy}</td>                    
                    <td style="text-align:left">
                    	<span onclick="javascript:fnContractList(this,${dataList.userTyCd},'${dataList.purchsInsttNm}','${basicDate}')" class="dataSvcNm" style="cursor: pointer;">${dataList.purchsInsttNm}</span>
                    </td>                    
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.cntrctAmount}" type="NUMBER" groupingUsed="true"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${dataList.cntrctNum}" type="NUMBER" groupingUsed="true"/></td>
                </tr>
             </c:forEach>   
            </tbody>
        </table>
    </form>        
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>