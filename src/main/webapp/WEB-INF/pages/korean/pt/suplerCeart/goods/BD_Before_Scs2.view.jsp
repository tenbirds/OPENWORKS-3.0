<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script type="text/javascript">
    
    function paas_explode()
    {
         // select 디폴트값 설정
         <c:forEach items="${scs2}" var="scs2" varStatus="status">
             <c:choose>
                 <c:when test="${scs2.consumerYn eq 'N'}">
                    
                    
                    var str = "${scs2.cnslRelm}" ;
                    var jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                    	$('#cnslRelm_'+jbSplit[i]).attr("checked", true);
                    }
                    
                    str = "${scs2.cnslScope}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#cnslScope_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${scs2.excArea}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#excArea_'+jbSplit[i]).attr("checked", true);                      
                    }
                                        
                </c:when>
            </c:choose>
        </c:forEach>
         
         
    }

    setTimeout(paas_explode, 1000);
    
    
    var jsMetaPop = function(el, codeGroupCd, cdStart, cdEnd)
    {
        var codeLangCode = $("input[name=langCode]").val();
        $(el).colorbox({
            title 		: "",
            href         : "/korean/pt/popup/PD_metaPop.do?codeLangCode=" + codeLangCode + "&codeGroupCd=" + codeGroupCd + "&cdStart=" + cdStart + "&cdEnd=" + cdEnd,
            width        : "880",
            height       : "500",
            overlayClose : false,
            escKey       : true,
            iframe       : true
        });
    };
    
    var jsChkCnslRelm = function(el)
    {
    	if  ($(el).val() == '1004')
   		{
    		if  ($(el).prop("checked")) $("#cnslRelmEtc").attr("disabled", false); 
    		else
   			{
    			$("#cnslRelmEtc").val("");
    			$("#cnslRelmEtc").attr("disabled", true); 
   			}
   		}
    }
    
    var jsChkExcArea = function(el) 
    {
    	//debugger;
    	if  ($(el).val() == '1099')
		{
    		<!-- 2036 -->
            <c:forEach items="${excAreaList}" var="_excArea" varStatus="status">
            <c:if test="${_excArea.PRVCD ne 1099}"> $("#excArea_${_excArea.PRVCD}").prop("checked",false) ; </c:if> 
            </c:forEach>
		}        		
    	if  ($(el).val() != '1099')
		{
    		$("#excArea_1099").prop("checked",false) ; 
		}        		
    }
</script>


<input type="hidden" name="scaling"     id="scaling"     value="" />
<input type="hidden" name="runtimes"    id="runtimes"    value="" />
<input type="hidden" name="middlewares" id="middlewares" value="" />
<input type="hidden" name="frameworks"  id="frameworks"  value="" />
<input type="hidden" name="services"    id="services"    value="" />
<input type="hidden" name="addons"      id="addons"      value="" />

<input type="hidden" name="langCode"    id="langCode"    value="00"/>

<input type="hidden" name="cnslRelm"  id="cnslRelm"  value="" /> <!-- 컨설팅 영역 -->
<input type="hidden" name="cnslScope" id="cnslScope" value="" /> <!-- 컨설팅 범위 -->
<input type="hidden" name="excArea"   id="excArea"   value="" /> <!-- 컨설팅 수행가능지역 -->    

	
	<h3>컨설팅 요구사항</h3>
	<table class="tbl_st4 mt10" summary="컨설팅 요구사항">
		<caption>컨설팅 요구사항</caption>
		<colgroup>
			<col width="20%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
		  	<th colspan="2" scope="col">컨설팅 영역</th>
		  </tr>
		</thead>
		<tfoot hidden="hidden">
			<tr>
		  	<th colspan="2" scope="col">컨설팅 영역</th>
		  </tr>
		</tfoot>
		<tbody>
			<tr>
				<td>컨설팅 영역</td>
				<td>
					<dl>
					<c:forEach items="${scs2}" var="scs2" varStatus="status">
					<c:choose>
					<c:when test="${scs2.consumerYn eq 'Y'}">
					<dd>${scs2.cnslRelmNm} ${scs2.cnslRelmEtc}</dd>
					</c:when>
					<c:when test="${scs2.consumerYn eq 'N'}">
					<dd>
					 <!-- 2082 -->
					<c:forEach items="${cnslRelmList}" var="_cnslRelm" varStatus="status">
					<input type="checkbox" class="cnslRelm" id="cnslRelm_${_cnslRelm.PRVCD}" name="cnslRelm_${_cnslRelm.PRVCD}" value="${_cnslRelm.PRVCD}" onclick="jsChkCnslRelm(this)" />
					<label for="cnslRelm_${_cnslRelm.PRVCD}">${_cnslRelm.PRVNM}</label>
					</c:forEach>
					<input type="text" style="width : 200px;"  id="cnslRelmEtc" name="cnslRelmEtc" value="" disabled="disabled" />
					<label for="cnslRelmEtc" hidden="hidden">cnslRelmEtc</label>
					</dd>
					</c:when>
					</c:choose>
					</c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>컨설팅 범위</td>
				<td>
					<dl>
					<c:forEach items="${scs2}" var="scs2" varStatus="status">
					<c:choose>
					<c:when test="${scs2.consumerYn eq 'Y'}">
					<dd>${scs2.cnslScopeNm}</dd>
					</c:when>
					<c:when test="${scs2.consumerYn eq 'N'}">
					<dd>
					 <!-- 2083 -->
					<c:forEach items="${cnslScopeList}" var="_cnslScope" varStatus="status">
					<input type="checkbox" class="cnslScope" id="cnslScope_${_cnslScope.PRVCD}" name="cnslScope_${_cnslScope.PRVCD}" value="${_cnslScope.PRVCD}" />
					<label for="cnslScope_${_cnslScope.PRVCD}">${_cnslScope.PRVNM}</label>
					</c:forEach>
					</dd>
					</c:when>
					</c:choose>
					</c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>컨설팅 수행 가능 지역</td>
				<td>
					<dl>
					<c:forEach items="${scs2}" var="scs2" varStatus="status">
					<c:choose>
					<c:when test="${scs2.consumerYn eq 'Y'}">
					<dd>${scs2.excAreaNm}</dd>
					</c:when>
					<c:when test="${scs2.consumerYn eq 'N'}">
					<dd>
					 <!-- 2083 -->
					<c:forEach items="${excAreaList}" var="_excArea" varStatus="status">
					<input type="checkbox" class="excArea" id="excArea_${_excArea.PRVCD}" name="excArea_${_excArea.PRVCD}" value="${_excArea.PRVCD}" onclick="jsChkExcArea(this);" />
					<label style="margin-right:8px;" for="excArea_${_excArea.PRVCD}">${_excArea.PRVNM}</label>
					</c:forEach>
					</dd>
					</c:when>
					</c:choose>
					</c:forEach>
					</dl>
				</td>
			</tr>
		</tbody>
	</table>
	
	<h3>컨설팅 의뢰내용</h3>
	<table class="tbl_st4 mt10" summary="컨설팅 의뢰내용">
		<caption>컨설팅 의뢰내용</caption>
		<colgroup>
			<col width="20%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
		  	<th colspan="2" scope="col">컨설팅 의뢰내용</th>
		  </tr>
		</thead>
		<tfoot hidden="hidden">
			<tr>
		  	<th colspan="2" scope="col">컨설팅 의뢰내용</th>
		  </tr>
		</tfoot>
		<tbody>
			<tr>
				<td>도입전반 (성능/사용량)</td>
				<td>
					<dl>
					    <c:forEach items="${scs2}" var="scs2" varStatus="status">
		                	<c:choose>
		                        <c:when test="${scs2.consumerYn eq 'Y'}">
		                            <dd>${scs2.indcWhole}</dd>
		                        </c:when>
		                        <c:when test="${scs2.consumerYn eq 'N'}">
		                        	<dd>
		                        		<input type="text" id="indcWhole" name="indcWhole"  value="${scs2.indcWhole}"/>
		                        		<label for="indcWhole" hidden="hidden">도입전반 (성능/사용량)</label>
		                        	</dd>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>Setup &amp; Migration</td>
				<td>
					<dl>
					    <c:forEach items="${scs2}" var="scs2" varStatus="status">
		                	<c:choose>
		                        <c:when test="${scs2.consumerYn eq 'Y'}">
		                            <dd>${scs2.setupMgr}</dd>
		                        </c:when>
		                        <c:when test="${scs2.consumerYn eq 'N'}">
		                        	<dd>
		                        		<input type="text" id="setupMgr" name="setupMgr"  value="${scs2.setupMgr}"/>
		                        		<label for="setupMgr" hidden="hidden">Setup &amp; Migration</label>
		                        	</dd>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>운영</td>
				<td>
					<dl>
					    <c:forEach items="${scs2}" var="scs2" varStatus="status">
		                	<c:choose>
		                        <c:when test="${scs2.consumerYn eq 'Y'}">
		                            <dd>${scs2.oper}</dd>
		                        </c:when>
		                        <c:when test="${scs2.consumerYn eq 'N'}">
		                        	<dd>
		                        		<input type="text" id="oper" name="oper"  value="${scs2.oper}"/>
		                        		<label for="oper" hidden="hidden">운영</label>
		                        	</dd>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>품질보증/테스트</td>
				<td>
					<dl>
					    <c:forEach items="${scs2}" var="scs2" varStatus="status">
		                	<c:choose>
		                        <c:when test="${scs2.consumerYn eq 'Y'}">
		                            <dd>${scs2.qlityTest}</dd>
		                        </c:when>
		                        <c:when test="${scs2.consumerYn eq 'N'}">
		                        	<dd>
		                        		<input type="text" id="qlityTest" name="qlityTest"  value="${scs2.qlityTest}"/>
		                        		<label for="qlityTest" hidden="hidden">품질보증/테스트</label>
		                        	</dd>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>보안</td>
				<td>
					<dl>
					    <c:forEach items="${scs2}" var="scs2" varStatus="status">
		                	<c:choose>
		                        <c:when test="${scs2.consumerYn eq 'Y'}">
		                            <dd>${scs2.scrty}</dd>
		                        </c:when>
		                        <c:when test="${scs2.consumerYn eq 'N'}">
		                        	<dd>
		                        		<input type="text" id="scrty" name="scrty"  value="${scs2.scrty}"/>
		                        		<label for="scrty" hidden="hidden">보안</label>
		                        	</dd>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</dl>
				</td>
			</tr>
			<tr>
				<td>교육</td>
				<td>
					<dl>
					    <c:forEach items="${scs2}" var="scs2" varStatus="status">
		                	<c:choose>
		                        <c:when test="${scs2.consumerYn eq 'Y'}">
		                            <dd>${scs2.education}</dd>
		                        </c:when>
		                        <c:when test="${scs2.consumerYn eq 'N'}">
		                        	<dd>
		                        		<input type="text" id="education" name="education"  value="${scs2.education}"/>
		                        		<label for="education" hidden="hidden">교육</label>
		                        	</dd>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</dl>
				</td>
			</tr>
		</tbody>
	</table>
