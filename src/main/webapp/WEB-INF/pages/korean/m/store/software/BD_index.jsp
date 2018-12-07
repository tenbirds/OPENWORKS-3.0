<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>솔루션 서비스</title>
 <script type="text/javascript">
 	$(document).ready(function(){
/*  	    
 	    $('[name="ctgryParentCode"]').on("change", function(){
 	        $('#ctgryParentNm').text($(this).find("option[value='" + $(this).val() + "']").text());
 	    });
 */ 	    
 });
 	var jsMovePage = function(page) {
        //createItem();
        $("#dataForm input[name=q_currPage]").val(page);
        document.dataForm.action = "BD_index.do";
        document.dataForm.method = "post";
        document.dataForm.submit();
    };

    
    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "../inc/BD_storeView.do";
        document.dataForm.submit();
    };

            
    var jsSelectSort = function(num, goodsTyCd) {
        createItem();
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_sortName"].value = num; 
        document.dataForm.submit();
    };
    
    
    var jsSelectSearch = function(code, txt) {
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1"; 
        document.dataForm.elements["ctgryCode"].value = code;
        document.dataForm.elements["ctgryParentCode"].value = code;
        document.dataForm.submit();
    };
    
    var jsFilterSearch = function() {
        
        /* if($("input[type='checkbox']:checked").length < 1){
        	alert('1개이상 선택하세요');
        	return;
        } */
        createItem();
        document.dataForm.action = "BD_index.do";
	    document.dataForm.elements["q_currPage"].value = "1";
	    document.dataForm.submit();
    };
    
    var jsInitFilter = function() {
        var checkObjs = $("input[type='checkbox']:checked");
        checkObjs.prop("checked", false);
        jsFilterSearch();
    }
   
    //Submit 전속 전송  (주소,파라메터,메소드)
    function post_to_url(path, params, method) {
        method = method || "post"; // Post:Get 전송 기본설정은 Post

        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);

        for(var key in params) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);

            form.appendChild(hiddenField);
        }

        document.body.appendChild(form);
        form.submit();
    };
	
    function createItem(){     
        var items = [];
        var itemsName = [];
        var selectItem12Len = $('input:checkbox[name="selectItem12"]:checked').length;
        if(selectItem12Len > 0) {
            $('input:checkbox[name=selectItem12]:checked').each(function () {
               	items.push($(this).val());
               	
               	if ($(this).val() == '1001') {
               	    itemsName.push('IaaS');               	    
               	}
               	if ($(this).val() == '1002') {
               	    itemsName.push('SaaS');
               	}
               	if ($(this).val() == '1003') {
               	    itemsName.push('PaaS');
               	}
               	if ($(this).val() == '1004') {
               	    itemsName.push('SCS');
               	}
            });
            $("#selectItem3").val(items);
            //$("#selectNames").text(itemsName);
        }else{
            $("#selectItem3").remove();
        }
        
        
        if($('input:checkbox[name="selectItem5"]:checked').length > 0)
            $("#creteItem").html("<input type='hidden' name='selectItem5' value='3'>");
        else 
            $("#creteItem").html("");
    }
    //탭 클릭시 동작 처리
    </script>

</head>
<body>
	<form name="dataForm" id="dataForm" method="post" action="BD_index.do" onsubmit="return false">
<%--
		<input type="hidden" id="q_currPage"	name="q_currPage" 	value="${searchMap.q_currPage}" />
  	<input type="hidden" id="q_sortName"  name="q_sortName" 	value="${searchMap.q_sortName}" />
    <input type="hidden" id="q_sortOrder" name="q_sortOrder"	value="${searchMap.q_sortOrder}" />
		<input type="hidden" id="ctgryCode"		name="ctgryCode"		value="${ctgryInit}" /> 
		<input type="hidden" id="goodsCode"		name="goodsCode"		value="" />
		<input type="hidden" id="goodsTyCd"		name="goodsTyCd"   	value="${goodsTyCd}">
		<input type="hidden" id="selectItem3"	name="selectItem3"	value="" /> 
--%>
		<input type="hidden" id="q_currPage"  	   name="q_currPage"      value="${searchMap.q_currPage}" />
		<input type="hidden" id="q_sortName"  	   name="q_sortName"      value="${searchMap.q_sortName}" />
		<input type="hidden" id="q_sortOrder" 	   name="q_sortOrder"     value="${searchMap.q_sortOrder}" />
		<input type="hidden" id="ctgryCode"   	   name="ctgryCode"       value="${ctgry.ctgryCode}" />
		<input type="hidden" id="goodsCode"   	   name="goodsCode"       value="" />
		<input type="hidden" id="section"     	   name="section"         value="" />
		<input type="hidden" id="ctgryParentCode"  name="ctgryParentCode" value="">
		<input type="hidden" id="goodsTyCd"   	   name="goodsTyCd"       value="${goodsTyCd}">
		<input type="hidden" id="userId"           name="userId"          value="">	
		<input type="hidden" id="goodsCheck"  	   name="goodsCheck"      value="" />
		<input type="hidden" id="selectItem3"  	   name="selectItem3"     value="" />
    	
    	<!-- section -->
		<div class="section  filBtn">
			<!-- filter section -->
			<div>
				<c:set var="selecItemNames" value="" /> 
				<a href="#" class="s-btn filter-pop type2"><strong><span>필터링 보기</span></strong></a>
				<div class="filter-pop" style="display:none;">
					<div>
						<h2>필터링 선택</h2>
						<dl>
							<dt>공공기관 이용 필터</dt>
								<c:forEach items="${organUserList}" var="_organUserList" varStatus="status">
								<dd>
									<c:if test="${_organUserList.prvCd eq '1001'}">
									<c:set var="codeval" value="1004" />
									<input type="checkbox" id="selectItem13" name="selectItem13" value="${codeval}" <c:if test="${fn:contains(selectItem13,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
									</c:if>
									<c:if test="${_organUserList.prvCd ne '1001'}">
									<c:set var="codeval" value="2060${_organUserList.prvCd}" />
									<input type="checkbox" id="selectItem2" name="selectItem2" value="${codeval}" <c:if test="${fn:contains(selectItem2,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
									</c:if> 
								<label>${_organUserList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>서비스 구분</dt>
							<dd>
								<input type="checkbox" id="selectItem12" name="selectItem12" value="1003" <c:if test="${fn:contains(param.selectItem3,'1003')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / IaaS" /></c:if> />
						 		<label>IaaS</label>
							</dd>
							<dd>
								<input type="checkbox" id="selectItem12" name="selectItem12" value="1002" <c:if test="${fn:contains(param.selectItem3,'1002')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SaaS" /></c:if> />
								<label>SaaS</label>
							</dd>
							<dd>
								<input type="checkbox" id="selectItem12" name="selectItem12" value="1001" <c:if test="${fn:contains(param.selectItem3,'1001')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / PaaS" /></c:if> /> 
						 		<label>PaaS</label>
						 	</dd>
						 	<dd>
								<input type="checkbox" id="selectItem12" name="selectItem12" value="1004" <c:if test="${fn:contains(param.selectItem3,'1004')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SCS" /></c:if> /> 
						 		<label>SCS</label>
							</dd>
						</dl>
						<dl>
							<dt>클라우드 구축방식</dt>
							<c:forEach items="${buildMethodList}" var="_buildMethodList" varStatus="status">
							<c:set var="codeval" value="2032${_buildMethodList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem7" name="selectItem7" value="${codeval}"  <c:if test="${fn:contains(selectItem7,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_buildMethodList.prvNm} " /> </c:if>/> 
								<label>${_buildMethodList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>인증정보</dt>
							<c:forEach items="${certificationList}" var="_certificationList" varStatus="status">
							<c:set var="codeval" value="${_certificationList.prvCd}" />
							<dd>
								<input type="checkbox" id=selectItem4 name="selectItem4" value="${codeval}" <c:if test="${fn:contains(selectItem4,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_certificationList.prvNm} " /> </c:if>/> 
								<label>${_certificationList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>서비스기술지원</dt>
							<c:forEach items="${serviceManageList}" var="_serviceManageList" varStatus="status">
							<c:set var="codeval" value="2030${_serviceManageList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem5" name="selectItem5" value="${codeval}" <c:if test="${fn:contains(selectItem5,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_serviceManageList.prvNm} " /></c:if>/> 
								<label>${_serviceManageList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>호환성 지원</dt>
							<c:forEach items="${compatibilityList}" var="_compatibilityList" varStatus="status">
							<c:set var="codeval" value="2031${_compatibilityList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem6" name="selectItem6" value="${codeval}" <c:if test="${fn:contains(selectItem6,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_compatibilityList.prvNm} " /> </c:if>/> 
								<label>${_compatibilityList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>개발지원</dt>
							<c:forEach items="${deploySupportList}" var="_deploySupportList" varStatus="status">
							<c:set var="codeval" value="2056${_deploySupportList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem8" name="selectItem8" value="${codeval}" <c:if test="${fn:contains(selectItem8,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_deploySupportList.prvNm} " /></c:if>/>
								<label>${_deploySupportList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>교육, 기술지원</dt>
							<c:forEach items="${eduTechSupportList}" var="_eduTechSupportList" varStatus="status">
							<c:set var="codeval" value="2057${_eduTechSupportList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem9" name="selectItem9" value="${codeval}" <c:if test="${fn:contains(selectItem9,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_eduTechSupportList.prvNm} " /> </c:if>/> 
								<label>${_eduTechSupportList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>관리정보제공</dt>
							<c:forEach items="${mangerInfotList}" var="_mangerInfotList" varStatus="status">
							<c:set var="codeval" value="2058${_mangerInfotList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem10" name="selectItem10" value="${codeval}" <c:if test="${fn:contains(selectItem10,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_mangerInfotList.prvNm} " /> </c:if>/>
								<label>${_mangerInfotList.prvNm}</label>
							</dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>기업구분</dt>
							<dd>
								<input type="checkbox" id="selectItem1" name="selectItem1" value="Y" <c:if test="${fn:contains(selectItem1,'Y')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중소기업 " /> </c:if> /> 
								<label>중소기업</label>
							</dd>
							<dd>
								<input type="checkbox" id="selectItem1" name="selectItem1" value="M" <c:if test="${fn:contains(selectItem1,'M')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중견기업 " /> </c:if> /> 
								<label>중견기업</label>
							</dd>
							<dd>
								<input type="checkbox" id="selectItem1" name="selectItem1" value="B" <c:if test="${fn:contains(selectItem1,'B')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 대기업 " /> </c:if> /> 
								<label>대기업</label>
							</dd>
						</dl>
						<dl>
							<dt>고객지원</dt>
							<c:forEach items="${customSupportList}" var="_customSupportList" varStatus="status">
							<c:set var="codeval" value="2059${_customSupportList.prvCd}" />
							<dd>
								<input type="checkbox" id="selectItem11" name="selectItem11"  value="${codeval}"  <c:if test="${fn:contains(selectItem11,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_customSupportList.prvNm} " /> </c:if> />
						 		<label>${_customSupportList.prvNm}</label>
						 	</dd>
						</c:forEach>
						</dl>
<%-- 						
						<dl>
							<dt>중소기업</dt>							
							<dd><input type="checkbox" id="selectItem1" name="selectItem1" <c:if test="${selectItem1 == 'on'}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중소기업 " /></c:if>/> <label>중소기업</label></dd>
						</dl>
						<dl>
							<dt>무료/체험</dt>
							<c:forEach items="${freeExperienceList}" var="_freeExperienceList" varStatus="status">
							<dd><c:set var="codeval" value="2027${_freeExperienceList.prvCd}" />
								<input type="checkbox" id="selectItem2" name="selectItem2" value="${codeval}" 
								<c:if test="${fn:contains(selectItem2,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_freeExperienceList.prvNm} " />
								</c:if>/><label>${_freeExperienceList.prvNm}</label></dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>계약단위</dt>							
							<c:forEach items="${contractUnitList}" var="_contractUnitList" varStatus="status">
							<dd><c:set var="codeval" value="2028${_contractUnitList.prvCd}" />
								<input type="checkbox" id="selectItem3" name="selectItem3" value="${codeval}" 
								<c:if test="${fn:contains(selectItem3,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_contractUnitList.prvNm} " />
								</c:if>/><label>${_contractUnitList.prvNm}</label></dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>인증</dt>
							<c:forEach items="${certificationList}" var="_certificationList" varStatus="status">
							<dd><c:set var="codeval" value="${_certificationList.prvCd}" />
								<input type="checkbox" id="selectItem4" name="selectItem4" value="${codeval}" 
								<c:if test="${fn:contains(selectItem4,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_certificationList.prvNm} " />
								</c:if>/><label>${_certificationList.prvNm}</label></dd>
							</c:forEach>
						</dl>						
						<dl>
							<dt>서비스 관리</dt>
							<c:forEach items="${serviceManageList}" var="_serviceManageList" varStatus="status">
							<dd><c:set var="codeval" value="2030${_serviceManageList.prvCd}" />
								<input type="checkbox" id="selectItem5" name="selectItem5" value="${codeval}" 
								<c:if test="${fn:contains(selectItem5,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_serviceManageList.prvNm} " />
								</c:if>/><label>${_serviceManageList.prvNm}</label></dd>
							</c:forEach>
						</dl>						
						<dl>
							<dt>호환성(표준)</dt>							
							<c:forEach items="${compatibilityList}" var="_compatibilityList" varStatus="status">
							<dd><c:set var="codeval" value="2031${_compatibilityList.prvCd}" />
								<input type="checkbox" id="selectItem6" name="selectItem6" value="${codeval}" 
								<c:if test="${fn:contains(selectItem6,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_compatibilityList.prvNm} " />
								</c:if>/><label>${_compatibilityList.prvNm}</label></dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>구축방식</dt>
							<c:forEach items="${buildMethodList}" var="_buildMethodList" varStatus="status">
							<dd><c:set var="codeval" value="2032${_buildMethodList.prvCd}" />
								<input type="checkbox" id="selectItem7" name="selectItem7" value="${codeval}" 
								<c:if test="${fn:contains(selectItem7,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_buildMethodList.prvNm} " />
								</c:if>/><label>${_buildMethodList.prvNm}</label></dd>
							</c:forEach>
						</dl>
						<dl>
							<dt>지원언어</dt>
							<c:forEach items="${languageList}" var="_languageList" varStatus="status">
							<dd><c:set var="codeval" value="1019${_languageList.prvCd}" />
								<input type="checkbox" id="selectItem8" name="selectItem8"  value="${codeval}" 
								<c:if test="${fn:contains(selectItem8,codeval)}">checked="checked"
						 		<c:set var="selecItemNames" value="${selecItemNames} / ${_languageList.prvNm} " />
						 		</c:if> /><label>${_languageList.prvNm}</label></dd>
							</c:forEach>
						</dl>
 --%>
						<%-- <dl>
							<dt>CSQC Level</dt>							
							<c:forEach items="${csqcLevelList}" var="_csqcLevelList" varStatus="status">
							<dd><c:set var="codeval" value="2033${_csqcLevelList.prvCd}" />
								<input type="checkbox" id="selectItem9" name="selectItem9"  value="${codeval}" 
								<c:if test="${fn:contains(selectItem9,codeval)}">checked="checked"
						 		<c:set var="selecItemNames" value="${selecItemNames} / ${_csqcLevelList.prvNm} " />
						 		</c:if> /><label>${_csqcLevelList.prvNm}</label></dd>
							</c:forEach>
						</dl> --%>
						<div class="border ar">
							<a href="#" class="b-btn w80 ac type2"  onClick="jsInitFilter();"><strong><span>선택초기화</span></strong></a>
							<a href="#" class="b-btn w65 ac type2"  onClick="jsFilterSearch();return false;"><strong><span>적용</span></strong></a>
						</div>
					</div>
				</div>
			</div>
			<!-- //filter section -->
			
    		<ul class="multi-section-half">
				<li>
					<div class="select-box dis-block mr05">
						<label for="list">Category 전체</label>
						<select class="list"  name="ctgryParentCodeList" onChange="jsSelectSearch(this.value, this.text);" >
							<option value="" >전체</option>
							<c:forEach items="${ctgryParentList}" var="_ctgryParentList" varStatus="status">
								<option value="${_ctgryParentList.ctgryCode}" <c:if test="${_ctgryParentList.ctgryCode == ctgryParentInit}">selected="selected" </c:if>>${_ctgryParentList.langCtgryNm}</option>			    
							</c:forEach>
						</select>
					</div>
				</li>
			</ul>
		</div>
		<!-- //section -->
		

			
			<!-- contents -->
			<div class="section border">			
			 	<dl class="search-result">
				   	<!-- 결과 갯수 영역 -->
					<dt>
						<span id="ctgryParentNm">
<%-- 						
							<c:if test="${goodsTyCd == '1002'}">SaaS</c:if>
				            <c:if test="${goodsTyCd == '1001'}">PaaS</c:if>
				            <c:if test="${goodsTyCd == '1003'}">IaaS</c:if> 
				            &gt;
 --%>				            
							전체 (<strong>${pager.totalNum}</strong> 개) 
				        </span>
				        <strong><c:if test="${not empty selecItemNames}">:	${fn:replace(fn:substring(selecItemNames,3,fn:length(selecItemNames)),'/','/')}</c:if></strong>
					</dt>
					<!-- //결과 갯수 영역 -->
					<dd class="ar">
						<!-- sorting -->
						<p class="select-box">
							<label for="list">최신 등록순</label>
							<select  name="q_searchKeyType" id="q_searchKeyType"  onChange="jsSelectSort(this.value,'${goodsTyCd}');" class="list">
								<option value="1" <c:if test="${ empty searchMap.q_sortName or searchMap.q_sortName == '1' }">selected="selected"</c:if>>최신 등록순</option>
								<option value="3" <c:if test="${ !empty searchMap.q_sortName and searchMap.q_sortName == '3' }">selected="selected"</c:if>>조회순</option>
								<option value="5" <c:if test="${ !empty searchMap.q_sortName and searchMap.q_sortName == '5' }">selected="selected"</c:if>>계약건수 순</option>
							</select>
						</p>
						<!-- //sorting -->						
					</dd>
				</dl>
			</div>
			<!-- section -->
	 <c:if test="${empty ctgry.langCtgryNm}"><c:set var="path" value="0," /></c:if>
	<c:if test="${not empty ctgry.langCtgryNm}">
	    <c:forEach items="${ctgryPath.fullPath.split(', ')}" var="_ctgryPath" varStatus="status">
	       <c:if test="${not status.first}"><c:set var="path" value="${path}${ctgryPath.fullPathCode.split(', ')[status.index]}," /></c:if>
	    </c:forEach>
	</c:if>					
    <input type="hidden" name="ctgryPath" id="ctgryPath"	 value="${path}" >
			
			<div class="section">
				<!-- list -->
				<div class="type-thumb">
					<c:forEach items="${pager.list}" var="_goodsList" varStatus="status">
						<ul>
						<li class="cont">
							<dl>
								<dt>
									<span>${_goodsList.langStoreNm}</span>
									<a href="#" onclick="jsView('${_goodsList.goodsCode}');">${_goodsList.goodsNm}</a>
								</dt>
								<dd><a href="#" onclick="jsView('${_goodsList.goodsCode}');"><c:if test="${fn:length(_goodsList.goodsSumry) >= 60}"><c:out value="${fn:substring(_goodsList.goodsSumry,0,60)}"/>...</c:if>
								<c:if test="${fn:length(_goodsList.goodsSumry) < 60}">${_goodsList.goodsSumry}</c:if></a></dd>
							</dl>
						</li>
						<li class="add">
							<strong><c:forEach items="${goodsCateList}" var="_goodsCateList" varStatus="status">
									 <c:if test="${_goodsList.goodsCode == _goodsCateList.goodsCode}">${_goodsCateList.langCtgryNm}</c:if>
									</c:forEach></strong>
							<span><c:forEach items="${_goodsList.markFile}" var="fileVo" varStatus="status1">
                                     <c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
                                         <img alt="마크이미지" src="${fileVo2.fileUrl}" style="width: 33px; height: 33px;"/>
                                     </c:forEach>
                                  </c:forEach></span>
						</li>
						</ul>
					 </c:forEach>					 
					 <c:if test="${empty pager.list}">
      		            <ul><li class="add"><dl>데이터가 존재하지 않습니다.</dl></li></ul>      		            
                      </c:if>
			    </div>
			</div>    
			<!-- //section -->
			<!-- paging -->
			<op:pager pager="${pager}" page="pager/webPager.jsp"/>
			<!-- //paging -->
		</form>
<script type="text/javascript">
  var select = $(".select-box select");
  select.each(function(){
      var select_name = $(this).children("option:selected").text();
      $(this).siblings("label").text(select_name);
  });
</script>    
</body>
</html>
