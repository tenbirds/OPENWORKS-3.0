<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>광고주 목록</title>
    <op:jsTag type="spi" items="validate,ui,form,highlight,extjs,colorbox," />
    <op:jsTag type="openworks" items="form,validate" />
	<script type="text/javascript">
	//<![CDATA[
	    $().ready(function() {
	        
	    });
	    
	    var jsMovePage = function(page) {
	        var p = 1;
	        if(page == 'page') {
	            p = $('input[name=page]').val();
	        } else {
	            p = page;
	        }
	        document.dataForm.elements["q_currPage"].value = p;
	        document.dataForm.action = "BD_index.do";
	        document.dataForm.method = "get";
	        document.dataForm.submit();
	    };   
	
	    //검색
	    var jsSearch = function() {
	        document.dataForm.action = "BD_index.do";
	        document.dataForm.elements["q_currPage"].value = "1";
	        document.dataForm.method = "get";
	        document.dataForm.submit();
	    };
	   
	    //광고주 정보조회
	    var jsAdvtsmViewForm = function(id) {
	        $("#advrtsClientSeq").val(id);        
	        $("#dataForm").attr("action", "BD_updateForm.do");
	        document.dataForm.method = "post";
	        document.dataForm.submit();
	    };
	    
	  	//광고주정보 등록
	    var jsInsertAdvtsmForm = function() {
	        $("#dataForm").attr("action", "BD_insertForm.do");
	        document.dataForm.method = "get";
	        document.dataForm.submit();
	    };
	    
	    
	//]]>
	</script>
</head>
<body>
    <div id="contents">
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
			<input type="hidden" name="advrtsClientSeq" id="advrtsClientSeq" value="" />

            <!-- 검색 -->
            <table class="boardWrite" summary="레이아웃 등록" >
		        <caption class="title">레이아웃 정보</caption>
		        <colgroup>
		            <col width="20%" />
		            <col width="40%" />
		            <col width="10%" />
		            <col width="30%" />
		        </colgroup>
		        <tbody>
			        <tr>
			            <th>광고의뢰 업체명</th>
			            <td>
			            	<input type="text" size="40" id="q_advrtsReqestEntrpsNm" name="q_advrtsReqestEntrpsNm" value="${param.q_advrtsReqestEntrpsNm}" />
			            </td>
			            <th>삭제여부</th>
			            <td>
			            	<select id=q_del_yn_sel name="q_del_yn_sel" class="over">
	                            <option <c:if test="${param.q_del_yn_sel eq 'A'}">selected="selected"</c:if> value="A">전체</option>
	                            <option <c:if test="${param.q_del_yn_sel eq 'Y'}">selected="selected"</c:if> value="Y">미사용</option>
	                            <option <c:if test="${(param.q_del_yn_sel eq 'N') or (empty param.q_del_yn_sel)}">selected="selected"</c:if> value="N">사용</option>
                        	</select>
			            </td>
			        </tr>
		        </tbody>
		    </table>
		    <p>&nbsp;</p>
		    <div class="tx_r">
            	<button class="s_blue mar_l5 mar_b5" onclick="jsSearch();">검색</button>
            </div>
            <!-- //검색 -->
            
            <br />
            <!-- 페이지당 목록선택-->
            <op:pagerParam title="광고주 목록" />
        </form>
		<br />
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden">목록</caption>
            <colgroup>
				<col width="8%">
				<col>
				<col width="12%">
                <col width="16%">
                <col width="15%">
                <col width="15%">
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>광고의뢰 업체명</th>
                    <th>광고 담당자명</th>
                    <th>광고 담당자<br/>이메일</th>
                    <th>광고 담당자<br/>전화번호</th>
                    <th class="lr_none">광고 담당자<br/>휴대폰번호</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="index" value="${pager.indexNo}" />
                <c:if test="${!empty pager.list}">
	                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	                    <tr>
	                        <td>${pager.indexNo - status.index}</td>	                        
	                        <td class="tx_l"><u><a href="#" onclick="jsAdvtsmViewForm('${baseVo.advrtsClientSeq}');">${baseVo.advrtsReqestEntrpsNm}</a></u></td>
	                        <td>${baseVo.advrtsChargerNm}</td>
	                        <td>${baseVo.advrtsChargerEmail}</td>
	                        <td>${baseVo.advrtsChargerTelno}</td>
	                        <td class="lr_none">${baseVo.advrtsChargerMbtlnum}</td>
	                    </tr>
	                </c:forEach>
	        	</c:if>
	        	<c:if test="${empty pager.list}">
	        		<tr>
                    	<td class="lr_none" colspan="6">검색결과가 없습니다.</td>
                    </tr>
	        	</c:if>
            </tbody>
        </table>
        <!-- //리스트 -->
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
                
        <div class="tx_r">
            <a href="#none"><button class="btn blue" type="button" Onclick="jsInsertAdvtsmForm()">광고주등록</button></a>
            <!-- //작은탭 -->
        </div>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>