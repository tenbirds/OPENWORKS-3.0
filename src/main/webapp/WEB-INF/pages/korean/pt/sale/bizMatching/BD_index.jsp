<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>

<title></title>
	<op:jsTag type="spi" items="validate,form,colorbox,datepicker"/>
		<!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">
    var jsView = function(domainCd,bbsCd,bbscttSeq) {
        $("#dataForm1 input[name=q_currPage]").val(1);
        $("#dataForm input[name=bbscttSeq]").val(bbscttSeq);
        jsRequest("dataForm", "/web/board/BD_board.view.do", "get");
    };
    
    var jsMovePage = function(page) {
        var p = 1;
        if(page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#dataForm #q_currPage").val(p);
        $("#dataForm").submit();

    };
    
    var jsRequest = function(formId, action, method){
        document.dataForm.action = action;
        document.dataForm.method = method;
        document.dataForm.submit();
    };
    </script>
</head>
<body>
	<!-- container -->
	<div id="container" class="join-wrap">
	<!-- contents -->
		<div class="knowHub list">
		<h3>
			<i class="quot">회원님의 비즈매칭 내역 입니다.</i>
		</h3>		
		<c:set var="index" value="${pager.indexNo}"/>	
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
			<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" />
			<input type="hidden" name="bbsCd"  value="<c:out value='${param.bbsCd}' />" />
			<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
			
			<!--  총 갯수 출력 -->
			<op:pagerParam page="param/webListPagerParam.jsp" />
				
			<!-- select box -->
			<div class="mt-15 fr">
				<div class="select-area">						
					<div class="sech_form">
						<div class="cont_wrap">
							<div class="selected">
			     				<div class="select list" style="width:100px;">
				          			<select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" style="width: 100px; z-index: 5; position: absolute; left: -100000px; height: auto;" onchange="this.form.submit()" >
						            	<option value="20" <c:if test="${20 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>20 개씩</option>
							            <option value="40" <c:if test="${40 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>40 개씩</option>
							            <option value="60" <c:if test="${60 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>60 개씩</option>
							            <option value="100" <c:if test="${100 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>100 개씩</option>
					          		</select>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>		
						<!-- section -->
			<div class="section">
				<!-- list -->
				<div class="type-list">
				<table class="tbl_view" >
					<caption>
						<strong>테이블</strong>
						<details>
						    <summary>테이블</summary>
						</details>
					</caption>
	                <colgroup>
	                    <col style="width:1%"/>
	                    <col style="width:25%"/>
	                    <col style="width:17%"/>
	                    <col style="width:1%"/>
	                    <col style="width:1%"/>
	                    <col style="width:1%"/>
	                    <col style="width:9%"/>
	                    <col style="width:10%"/>
	                </colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>희망답변자</th>
									<th>상태</th>								
									<th>종료일</th>
									<th>매칭수</th>
									<th>문의자</th>
									<th>작성일</th>
								</tr>
							</thead>
					        <tbody>
<!-- ${dataVo.userId} -->				
							<c:forEach var="item" items="${fn:split(dataVo.estnColumn1,',')}" varStatus="status">
										<c:if test="${!status.first eq dataVo.userId && status.first  eq dataVo.userId}">
											<span><c:out value="${item}"/></span>
										</c:if>
							</c:forEach>	        
 					        <c:forEach items="${newboardList}" var="dataVo"  varStatus="status">
						        <tr>
						        	<td>${index-status.index}</td>
						            <td class="title">
						               <a href="#" onclick="jsView('<c:out value='${dataVo.domainCd}'/>','<c:out value='${dataVo.bbsCd}'/>', '<c:out value='${dataVo.bbscttSeq}'/>','<c:out value='${dataVo.registPassword}'/>', '<c:out value='${dataVo.othbcAt}'/>'); return false;" >
						               <c:out value='${fn:substring(dataVo.bbscttSj,0,40)}'/><c:if test="${dataVo.bbscttSjLength > 40}">...</c:if></a>
						            </td>
						            <td>
                                    		<c:if test="${dataVo.estnColumn2 ne '' && dataVo.estnColumn2 ne null}">
	                                    		<c:choose>
	                                                <c:when test="${fn:indexOf(dataVo.estnColumn2,',') >= 0}">
														<a href="#" class="more"><c:out value="${fn:split(dataVo.estnColumn2,',')[0]}"/>(외<c:out value="${fn:length(fn:split(dataVo.estnColumn2,',')) - 1}"/>명)</a>
														<div>
															<img src="/cloud_ver2/new_cloud/images/bgIcn_arr_up.png" alt="" />
															<c:forEach var="item" items="${fn:split(dataVo.estnColumn2,',')}" varStatus="status">
																<c:if test="${!status.first}">
																<span><c:out value="${item}"/></span>
																</c:if>
															</c:forEach>
														</div>
													</c:when>
	                                                <c:otherwise>
	                                                	<c:out value="${dataVo.estnColumn2}"/>
	                                                </c:otherwise>
	                                            </c:choose>
											</c:if>
										</td>
						           	<td>
                                            <c:if test="${dataVo.bizProgression eq 'COM'}"><span class="condi_a">완료</span></c:if>
                                            <c:if test="${dataVo.bizProgression eq 'INC'}"><span class="condi_b">완료</span></c:if>
                                            <c:if test="${dataVo.bizProgression eq 'PRO'}"><span class="condi_d">진행중</span></c:if>
                                    </td>
						            <td class="end_date">
						            <c:out value='${dataVo.estnColumn6}'/>
						            </td>
						            <td>
						            <c:out value='${dataVo.commentCnt}'/>
						            </td>
						            <td>${dataVo.registerNm}</td>
						            <td class="date_b"><c:out value='${dataVo.registDt}'/></td>
						        </tr>
					        </c:forEach>
					        <!-- 페이징 처리 -->
					        <c:if test="${empty newboardList }">
					       	 	<tr ><td style="text-align: center;" colspan="8">비즈매칭 신규 등록내역이 없습니다.</td></tr>
					        </c:if>
				        	</tbody>
		       			</table>
		             <!-- 페이징 처리 -->
		        	<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
		             <!-- 페이징 처리 끝 -->
				</form>
				<!-- 페이징 처리에 필요 -->
				<form id="dataForm1" name="dataForm1">
				<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" />
				<input type="hidden" name="bbsCd"  value="<c:out value='${param.bbsCd}' />" />
				<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
				<input type="hidden" name="q_currPage" id="q_currPage" value="1"/>
				</form>
	    </div>
</body>
</html>