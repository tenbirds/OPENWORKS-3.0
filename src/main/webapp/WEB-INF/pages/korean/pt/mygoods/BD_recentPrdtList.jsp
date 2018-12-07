<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>구매내역 | 쇼핑내역 | 마이페이지 | 씨앗 마켓</title>  
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="spi" items="form,validate,datepicker,colorbox" />
    
    <script type="text/javascript">
    $().ready(function() {
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_beginDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImageOnly : true
        });
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImageOnly : true
        });        
    })
    
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
    
        var jsView = function(vl){
            $("#goodsCode").val(vl);
            document.dataForm.action = "../store/inc/BD_storeView.do";        
            document.dataForm.submit();
        };
    
        var jsSearch = function(){
            document.dataForm.action = "BD_purchsList.do";
            document.dataForm.elements["q_currPage"].value = "1";
            document.dataForm.elements["q_init"].value = "0";
            document.dataForm.submit();
        };
    
        var jsClean = function(){
            $("#q_goodsTyCd").val("");            
            $("#q_beginDate").val("");
            $("#q_endDate").val("");
            $("#q_searchVal").val("");            
        };
        
        var jsRegistView = function(el,id){
            $(el).colorbox({
                title : "회원정보",
                href : "/korean/pt/popup/PD_userView.do?userId=" + id,
                width : "500",
                height: "450",
                iframe: true
            });
          };

    </script>
</head>
<body>
    <form id="dataForm" name="dataForm">
        <input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value="${param.q_currPage}" />" />
        <input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value="${param.q_sortName}" />" />
        <input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value="${param.q_sortOrder}" />" />
        <input type="hidden" name="q_init" id="q_init" value="<c:out value="${param.q_init}" />" />
        <input type="hidden" name="goodsCode" id="goodsCode" value="" />
<%--
        <section>
            <!-- 구매내역 검색 영역 -->
            <fieldset>
            <legend><span>검색조건 입력</span></legend>
            <table class="tbl_list_input">
            <caption>
                <strong>구매내역 검색</strong>
                <details>
                    <summary>검색 조건을 입력하는 서식입니다.</summary>
                </details>
            </caption>
            <colgroup>
                <col style="width:17%">
                <col>
            </colgroup>
            <tr>
                <th scope="row">서비스</th>
                <td><input type="text" id="p_name" title="서비스명 입력" style="width:310px;margin-right:10px;" name="q_searchVal">
                    <input type="checkbox" name="q_goodsTyCd" id="premium" value="1001" <c:if test="${searchMap.q_goodsTyCd == 1001}">checked="checked"</c:if>>
                    <span class="pad_l"><label for="premium">표준프레임워크호환 서비스</label></span>
                    <input type="checkbox" name="q_goodsTyCd" id="solution" value="1002" <c:if test="${searchMap.q_goodsTyCd == 1002}">checked="checked"</c:if>>
                    <span class="pad_l"><label for="solution">솔루션</label></span>
                </td>
            </tr>
            <tr>
                <th scope="row">기간</th>
                <td>
                    <div class="calendar_input">
                        <input type="text" class="input" id="q_beginDate" name="q_beginDate" title="검색 시작일 입력" style="width:118px;">
                        <button title="시작일 레이어 달력 열림">검색 시작일</button>
                    </div>
                    <span class="divide"> ~ </span>
                    <div class="calendar_input end">
                    <input type="text" class="input" id="q_endDate" name="q_endDate" title="검색 종료일 입력" style="width:118px;">
                    <button title="종료일 레이어 달력 열림">검색 종료일</button>
                    </div>
                    <span class="btn_light_gray02"><a href="">오늘</a></span>
                    <span class="btn_light_gray02"><a href="">1주일</a></span>
                    <span class="btn_light_gray02"><a href="">1개월</a></span>
                    <span class="btn_light_gray02"><a href="">3개월</a></span>
                </td>
            </tr>
            </table>
    
            <div class="search_input_btn">
                <div class="btn_navi">
                    <a href="javascript:;" onclick="jsSearch();"><span class="find">검색</span></a>
                </div>
                <div class="btn_navi_g">
                    <a href=""><span class="total">전체보기</span></a>
                </div>
            </div>
            </fieldset>
            <!-- //구매내역 검색 영역 -->
        </section>
 --%>
        <!-- 검색 리스트 영역 -->
        <!-- contents -->
			<div class="contents">
				<!-- title-area -->
				<div class="title-area">
					<h2>최근 본 서비스</h2>
				</div>
				<!-- //title-area -->
				
				<!-- section -->
				<div class="section">
					<h3 class="stitle"></h3>
					<p class="total-count">총 <strong>${pager.totalNum}</strong>개</p>
					<!-- list -->
					<div class="type-list">
						<table>
							<caption>자주찾는 질문</caption>
							<colgroup>
							<col style="width:100px;"/>
							<col style="width:*;"/>
							<col style="width:100px;"/>
							<col style="width:100px;"/>
							<col style="width:100px;"/>
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>서비스명</th>
									<th>단가(\)</th>
									<th>계약건수</th>
									<th>판매자</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="index" value="${pager.indexNo}"/>
				                    <c:forEach items="${pager.list}" var="_bean" varStatus="status">
				                        <tr>
				                            <td>${index - status.index}</td>
				                            <%-- <td><img src="${_bean.imageFile[0].fileUrl}" alt="${_bean.goodsNm}" width="90" height="68"><!-- 썸네일 이미지 크기 90*90 --></td> --%>
				                            <td class="title">
				                                <span><a href="javascript:;" onclick="jsView('${_bean.goodsCode}');">${_bean.goodsNm}</a></span>
				                            </td>
				                            <td>${_bean.goodsPc}</td>
				                            <td>
				                                <span>${_bean.sellCnt}</span>
				                                <c:if test="${not empty _bean.evlScore}">
				                                <span class="grade">(${_bean.evlScore})</span>
				                                </c:if>
				<%--                                 <span><a href="" title="팝업창 열림">${_bean.cmpnyNm}</a></span> --%>
				<%--                                 <c:if test="${ not empty _bean.cmmntyId}"> --%>
				<!--                                 <span class="btn_light_gray02"> -->
				<!--                                     <a href="" title="새창 열림">커뮤니티</a> -->
				<!--                                 </span> -->
				<%--                                 </c:if> --%>
				                            </td>
				<%--                             <td class="date"><span>${_bean.orderDt}</span></td> --%>
				                            <td>
				                                <span><a href="javascript:;" title="팝업창 열림" onclick="jsRegistView(this,'<c:out value="${_bean.userId}"></c:out>')">${_bean.storeNm}</a></span>
				                            </td>
				                        </tr>
				                    </c:forEach>
				                    <op:no-data obj="${pager.list}" colspan="5" msg="최근 본 서비스가 없습니다."/>
							</tbody>
						</table>
					</div>
					<!-- //list -->

					<!-- paging -->
					<op:pager pager="${pager}" page="pager/webPager.jsp"/>
					<!-- //paging -->
				</div>
				<!-- //section -->
			</div>
			<!-- //contents -->    
    </form>
</body>
</html>