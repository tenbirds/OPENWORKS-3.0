<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script type="text/javascript">
    
    function paas_explode()
    {
         // select 디폴트값 설정
         <c:forEach items="${pass2}" var="pass2" varStatus="status">
             <c:choose>
                 <c:when test="${pass2.consumerYn eq 'N'}">
                    settingSelect('paas_spanHostingMethod', 'paas_hostingMethod', '${pass2.hostingMethod}');
                    settingSelect('paas_spanPlatform', 'paas_platform', '${pass2.platform}');
                    settingSelect('paas_spanGeolocations', 'paas_geolocations', '${pass2.geolocations}');
                    
                    
                    var str = "${pass2.scaling}" ;
                    var jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#paas_scaling_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${pass2.runtimes}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#pass_runtimes_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${pass2.middlewares}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#pass_middlewares_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${pass2.frameworks}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#pass_frameworks_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${pass2.services}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#pass_services_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${pass2.addons}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#pass_addons_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    if  ("${pass2.extendFunction}" == "Y") 
                    {
                          $('#pass_extendFunction').attr("checked", true);                      
                    }
                    
                    
                    
                                        
                </c:when>
            </c:choose>
        </c:forEach>
         
         
    }

    setTimeout(paas_explode, 1000);
    
</script>


<input type="hidden" name="scaling"     id="scaling"     value="" />
<input type="hidden" name="runtimes"    id="runtimes"    value="" />
<input type="hidden" name="middlewares" id="middlewares"  value="" />
<input type="hidden" name="frameworks"  id="frameworks"  value="" />
<input type="hidden" name="services"    id="services"    value="" />
<input type="hidden" name="addons"      id="addons"      value="" />
	
<h3>시스템 요구조건</h3>
<table class="tbl_st4 mt10">
	<tr>
		<th>호스팅방식</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.hostingMethodNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
	                            <!-- 2064 -->
		                        <span id="paas_spanHostingMethod" class="sel_box">
		                            <select id="paas_hostingMethod" name="hostingMethod">
		                                <option value="">선택</option>
		                                <!-- 2064 -->
		                                <c:forEach items="${hostingMethodList}" var="hostingMethod" varStatus="status">
		                                    <option value="${hostingMethod.PRVCD}">${hostingMethod.PRVNM}</option>    
		                                </c:forEach>
		                            </select>
		                        </span>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>스케일링</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.scalingNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
	                            <!-- 2066 -->
		                        <c:forEach items="${scalingList}" var="scaling" varStatus="status">
		                            <label><input type="checkbox" id="paas_scaling_${scaling.PRVCD}" name="scaling_${scaling.PRVCD}" value="${scaling.PRVCD}">${scaling.PRVNM}</label>
		                        </c:forEach>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>플랫폼</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.platformNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
		                        <span id="paas_spanPlatform" class="sel_box">
		                            <select id="paas_platform" name="platform">
		                                <option value="">선택</option>
		                                <!-- 2064 -->
		                                <c:forEach items="${platformList}" var="platform" varStatus="status">
		                                    <option value="${platform.PRVCD}">${platform.PRVNM}</option>    
		                                </c:forEach>
		                            </select>
		                        </span>
                            
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>런타임</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.runtimesNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
	                            <!-- 2068 -->
		                        <c:forEach items="${runtimesList}" var="runtimes" varStatus="status">
		                            <label><input type="checkbox" id="pass_runtimes_${runtimes.PRVCD}" name="runtimes_${runtimes.PRVCD}" value="${runtimes.PRVCD}">${runtimes.PRVNM}</label>
		                        </c:forEach>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>미들웨어</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.middlewaresNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
                            	<!-- 2069 -->
		                        <c:forEach items="${middlewaresList}" var="middlewares" varStatus="status">
		                            <label><input type="checkbox" id="pass_middlewares_${middlewares.PRVCD}" name="middlewares_${middlewares.PRVCD}" value="${middlewares.PRVCD}">${middlewares.PRVNM}</label>
		                        </c:forEach>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>프레임워크</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.frameworksNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
                            	<!-- 2070 -->
		                        <c:forEach items="${frameworksList}" var="frameworks" varStatus="status">
		                            <label><input type="checkbox" id="pass_frameworks_${frameworks.PRVCD}" name="frameworks_${frameworks.PRVCD}" value="${frameworks.PRVCD}">${frameworks.PRVNM}</label>
		                        </c:forEach>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>서비스</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.servicesNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
                            	<!-- 2071 -->
		                        <c:forEach items="${servicesList}" var="services" varStatus="status">
		                            <label><input type="checkbox" id="pass_services_${services.PRVCD}" name="services_${services.PRVCD}" value="${services.PRVCD}">${services.PRVNM}</label>
		                        </c:forEach>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>애드온</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.addonsNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
                            	<!-- 2072 -->
		                        <c:forEach items="${addonsList}" var="addons" varStatus="status">
		                            <label><input type="checkbox" id="pass_addons_${addons.PRVCD}" name="addons_${addons.PRVCD}" value="${addons.PRVCD}">${addons.PRVNM}</label>
		                        </c:forEach>                            
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>확장기능여부</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.extendFunction}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
                            	<label><input type="checkbox" id="pass_extendFunction" name="extendFunction" value="Y"/> 확장기능</label>
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>위치</th>
		<td>
			<dl>
			    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                	<c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <dd>${pass2.geolocationsNm}</dd>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <dd>
                            	<!-- 2073 -->
		                        <span id="paas_spanGeolocations" class="sel_box">
		                            <select id="paas_geolocations" name="geolocations">
		                                <option value="">선택</option>
		                                <!-- 2064 -->
		                                <c:forEach items="${geolocationsList}" var="geolocations" varStatus="status">
		                                    <option value="${geolocations.PRVCD}">${geolocations.PRVNM}</option>    
		                                </c:forEach>
		                            </select>
		                        </span>                            
                            </dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

