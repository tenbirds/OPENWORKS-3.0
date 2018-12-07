<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
    
    function saas_explode()
    {
         // select 디폴트값 설정
         <c:forEach items="${sass2I}" var="sass2I" varStatus="status">
             <c:choose>
                 <c:when test="${sass2I.consumerYn eq 'N'}">
                    settingSelect('saas_spanSupportMethod', 'saas_supportMethod', '${sass2I.supportMethod}');
                    settingSelect('saas_spanUserManagerSeparate', 'saas_userManagerSeparate', '${sass2I.userManagerSeparate}');
                    settingSelect('saas_spanMultiPlatform', 'saas_multiPlatform', '${sass2I.multiPlatform}');
                    
                    var str = "${sass2I.serviceSupplyMethod}" ;
                    var jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#saas_ServiceSupplyMethod_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    str = "${sass2I.encryption}" ;
                    jbSplit = str.split(',');
                    for ( var i in jbSplit ) 
                    {
                          $('#saas_Encryption_'+jbSplit[i]).attr("checked", true);                      
                    }
                    
                    <c:forEach items="${sass2Dn}" var="sass2Dn" varStatus="status"> // 필요사항 루프 
                    <c:choose>
                        <c:when test="${sass2Dn.consumerYn eq 'N' }">
                        
                       	settingSelect('saas_spanUnitCode1_${sass2Dn.needSeq}', 'saas_unitCode1_${sass2Dn.needSeq}', '${sass2Dn.unitCode}');
                       
                           
                               <c:forEach items="${sass2Do}" var="sass2Do" varStatus="status2">  // 옵션사항 루프                                
                               <c:choose>
                                   <c:when test="${sass2Do.consumerYn eq 'N' and sass2Dn.needSeq eq sass2Do.needSeq}">
                                   
                                   	settingSelect('saas_spanUnitCode2_${sass2Do.optionSeq}', 'saas_unitCode2_${sass2Do.optionSeq}', '${sass2Do.unitCode}');
                                   
                                   </c:when>
                               </c:choose>
                               </c:forEach>
                               
                        </c:when>
                    </c:choose>                       
                	</c:forEach>                    
                    
                </c:when>
            </c:choose>
        </c:forEach>
         
         
    }

    setTimeout(saas_explode, 1000);
    
</script>


<input type="hidden" name="serviceSupplyMethod" id="serviceSupplyMethod"  value="" />
<input type="hidden" name="encryption"          id="encryption"           value="" />
    			
<h3>시스템 요구조건</h3>
<table class="tbl_st1">
    <thead>
        <tr>
            <th>제공방법</th>
            <th>사용자/관리자분리</th>
            <th>서비스제공방식</th>
            <th>암호화</th>
            <th>다중플랫폼지원</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${sass2I}" var="sass2I" varStatus="status">
            <c:choose>
                <c:when test="${sass2I.consumerYn eq 'Y'}">
                    <tr>
                        <td>${sass2I.supportMethodNm}</td>
                        <td>${sass2I.userManagerSeparateNm}</td>
                        <td>${sass2I.serviceSupplyMethodNm}</td>
                        <td>${sass2I.encryptionNm}</td>
                        <td>${sass2I.multiPlatform}</td>
                    </tr>
                </c:when>
                <c:when test="${sass2I.consumerYn eq 'N'}">
                    <tr>
                        <td>                        
                            <span id="saas_spanSupportMethod" class="sel_box">
                                <select id="saas_supportMethod" name="supportMethod">
                                            
                                    <option value="">선택</option>
                                    <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
                                        <option value="${supplyMethodCode.PRVCD}">${supplyMethodCode.PRVNM}</option>    
                                    </c:forEach>
                                </select>
                            </span>                        
                        </td>
                        <td>
                            <span id="saas_spanUserManagerSeparate" class="sel_box">
                                <select id="saas_userManagerSeparate" name="userManagerSeparate">
                                    <option value="">선택</option>
                                    <c:forEach items="${userManagerSeparateList}" var="userManagerSeparate" varStatus="status">
                                        <option value="${userManagerSeparate.PRVCD}">${userManagerSeparate.PRVNM}</option>    
                                    </c:forEach>    
                                </select>
                            </span>
                        </td>
                        <td>
                            <c:forEach items="${serviceSupplyMethodList}" var="serviceSupplyMethod" varStatus="status">
                                <label><input type="checkbox" id="saas_ServiceSupplyMethod_${serviceSupplyMethod.PRVCD}" name="serviceSupplyMethod_${serviceSupplyMethod.PRVCD}" value="${serviceSupplyMethod.PRVCD}">${serviceSupplyMethod.PRVNM}</label><br />
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach items="${encryptionList}" var="encryption" varStatus="status">                                
                                <label><input type="checkbox" id="saas_Encryption_${encryption.PRVCD}" name="encryption_${encryption.PRVCD}" value="${encryption.PRVCD}">${encryption.PRVNM}</label><br />                            
                            </c:forEach>
                        </td>
                        <td>
                            <span id="saas_spanMultiPlatform" class="sel_box">
                                <select id="saas_multiPlatform" name="multiPlatform">
                                    <option value="">선택</option>
                                    <option value="Y">예</option>
                                    <option value="N">아니오</option>
                                </select>
                            </span>
                        </td>
                    </tr>
                </c:when>
            </c:choose>
        </c:forEach>
    </tbody>
</table>

<table class="tbl_st1 mt20">
    <thead>
        <tr>
            <th>기능명(필요)</th>
            <th>수량</th>
            <th>단위</th>
        </tr>
    </thead>
    <tbody>
        
        <c:forEach items="${sass2Dn}" var="sass2Dn" varStatus="status"> <!-- 필요사항 루프 -->
            
            <c:choose>
                <c:when test="${sass2Dn.consumerYn eq 'Y'}">
                    <tr class="saas"> 
                        <td>${sass2Dn.functionName}</td>
                        <td>${sass2Dn.amount}</td>
                        <td>${sass2Dn.unitCodeNm}</td>
                    </tr>
                </c:when>
                <c:when test="${sass2Dn.consumerYn eq 'N'}">
                    <tr>
                        <td><input type="text" name="functionName1" value="${sass2Dn.functionName}"/></td>
                        <td><input type="text" name="amount1" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" value="${sass2Dn.amount}"/></td>
                        <td>
                            <span id="saas_spanUnitCode1_${sass2Dn.needSeq}" class="sel_box">
                                <select id="saas_unitCode1_${sass2Dn.needSeq}" name="unitCode1">
                                    <option value="">선택</option>
                                    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
                                        <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
                                    </c:forEach>
                                </select>
                            </span>
                        </td>
                    </tr>
                </c:when>
            </c:choose>
              
            
            <c:if test="${sass2Dn.consumerYn eq 'N'}">
                <tr class="clsMain">                        
                
                    <td colspan="3">
                        <input type="hidden" name="hidenOptions1" value="test" />
                    
                        <table style="border: 1px solid #ddd; width:98%; margin: auto; float: right;">
                        <thead>
                            <tr>
                                <th>기능명(옵션)</th>
                                <th>수량</th>
                                <th>단위</th>
                            </tr>
                        </thead>
                        <tbody>
                        
                            <c:forEach items="${sass2Do}" var="sass2Do" varStatus="status2">  <!-- 옵션사항 루프 -->
                                <c:choose>
                                    <c:when test="${sass2Do.consumerYn eq 'Y' and sass2Dn.needSeq eq sass2Do.needSeq}">
                                        <tr> 
                                            <td>${sass2Do.functionName}</td>
                                            <td>${sass2Do.amount}</td>
                                            <td>${sass2Do.unitCodeNm}</td>
                                        </tr>
                                    </c:when>
                                    <c:when test="${sass2Do.consumerYn eq 'N' and sass2Dn.needSeq eq sass2Do.needSeq}">
                                        <tr>
                                            <td><input type="text" name="functionName2" value="${sass2Do.functionName}"/></td>
                                            <td><input type="text" name="amount2" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" value="${sass2Do.amount}"/></td>
                                            <td class="schArea">
                                                <span id="saas_spanUnitCode2_${sass2Do.optionSeq}" class="sel_box">
                                                    <select id="saas_unitCode2_${sass2Do.optionSeq}" name="unitCode2">
                                                        <option value="">선택</option>                                        
                                                        <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
                                                            <option value="${totUnitCode.PRVCD}">${totUnitCode.PRVNM}</option>    
                                                        </c:forEach>
                                                    </select>
                                                </span>
                                            </td>
                                        </tr>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </tbody>
                        </table>
                    </td>
                </tr>
            </c:if>
            
               
        </c:forEach> 
    
    </tbody>
    
</table>
