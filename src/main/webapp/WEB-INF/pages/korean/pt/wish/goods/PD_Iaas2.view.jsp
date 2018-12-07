<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구조건</h3>
                
                
        <table class="tbl_st3 mt10">
	        <caption></caption>
	        <colgroup>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="40%"/>
                <col width="40%"/>
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="3">&nbsp;</th>
                    <th>요구사항</th>
                    <th>답변</th>
                </tr>
                
                <c:forEach items="${iass2Ds_h}" var="iass2Ds_h" varStatus="status_sh">
	                <tr>
	                	<c:if test="${status_sh.first}">
						<th rowspan="6">서버 사항 ${status_nh.count}</th>
						</c:if>
	                    <th colspan="2">용도</th>
	                    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Ds.consumerYn eq 'Y' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
	                            <td>${iass2Ds.serverUse}</td>
	                        </c:when>
	                        <c:when test="${iass2Ds.consumerYn eq 'N' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
	                            <td>${iass2Ds.serverUse}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>
	                <tr>
                        <th colspan="2">OS</th>
	                    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Ds.consumerYn eq 'Y' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverOs}</td>
	                        </c:when>
	                        <c:when test="${iass2Ds.consumerYn eq 'N' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverOs}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>
	                <tr>
                        <th colspan="2">CPU(Vcore)</th>
	                    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Ds.consumerYn eq 'Y' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverCpu}</td>
	                        </c:when>
	                        <c:when test="${iass2Ds.consumerYn eq 'N' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverCpu}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>
	                <tr>
                        <th colspan="2">메모리(GB)</th>
	                    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Ds.consumerYn eq 'Y' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverMemory}</td>
	                        </c:when>
	                        <c:when test="${iass2Ds.consumerYn eq 'N' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverMemory}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>
	                <tr>
                        <th colspan="2">Disk(GB)</th>
	                    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Ds.consumerYn eq 'Y' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverDisk}</td>
	                        </c:when>
	                        <c:when test="${iass2Ds.consumerYn eq 'N' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverDisk}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>
	                <tr>
                        <th colspan="2">수량(CM)</th>
	                    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Ds.consumerYn eq 'Y' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverQnty}</td>
	                        </c:when>
	                        <c:when test="${iass2Ds.consumerYn eq 'N' and sass2Ds_h.serverSeq eq sass2Ds.serverSeq}">
                                <td>${iass2Ds.serverQnty}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>
                </c:forEach>
                
                
                <tr>                        
                       <th colspan="3">공인 IP 수량(개)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.serverIp}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.serverIp}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">네트워크 트래픽(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.serverNetwork}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.serverNetwork}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">GSLB(개)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.serverGslb}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.serverGslb}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">로드밸런서(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.serverLdbl}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.serverLdbl}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">스냅샷(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.serverSnap}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.serverSnap}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">이미지(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.serverImg}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.serverImg}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <c:forEach items="${iass2Dd_h}" var="iass2Dd_h" varStatus="status_dh">
	                <tr>                        
	                	<c:if test="${status_dh.first}">
						<th rowspan="6">DB 사항 ${status_nh.count}</th>
						</c:if>		                    
                        <th colspan="2">용도</th>
	                    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Dd.consumerYn eq 'Y' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbUse}</td>
	                        </c:when>
	                        <c:when test="${iass2Dd.consumerYn eq 'N' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbUse}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>                
	                
	                <tr>                        
                        <th colspan="2">OS</th>
	                    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Dd.consumerYn eq 'Y' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbOs}</td>
	                        </c:when>
	                        <c:when test="${iass2Dd.consumerYn eq 'N' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbOs}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>                
	                
	                <tr>                        
                        <th colspan="2">CPU(Vcore)</th>
	                    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Dd.consumerYn eq 'Y' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbCpu}</td>
	                        </c:when>
	                        <c:when test="${iass2Dd.consumerYn eq 'N' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbCpu}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>                
	                
	                <tr>                        
                        <th colspan="2">메모리(GB)</th>
	                    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Dd.consumerYn eq 'Y' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbMemory}</td>
	                        </c:when>
	                        <c:when test="${iass2Dd.consumerYn eq 'N' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbMemory}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>                
	                
	                <tr>                        
                        <th colspan="2">Disk(GB)</th>
	                    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Dd.consumerYn eq 'Y' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbDisk}</td>
	                        </c:when>
	                        <c:when test="${iass2Dd.consumerYn eq 'N' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbDisk}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>                
	                
	                <tr>                        
                        <th colspan="2">수량(CM)</th>
	                    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
	                    <c:choose>                
	                        <c:when test="${iass2Dd.consumerYn eq 'Y' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbQnty}</td>
	                        </c:when>
	                        <c:when test="${iass2Dd.consumerYn eq 'N' and sass2Dd_h.dbSeq eq sass2Dd.dbSeq}">
                                <td>${iass2Dd.dbQnty}</td>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </tr>                
	            </c:forEach>    

                <tr>                        
                       <th colspan="3">공인 IP 수량(개)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.dbIp}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.dbIp}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">네트워크 트래픽(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.dbNetwork}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.dbNetwork}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">추가 디스크(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.dbAddDisk}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.dbAddDisk}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                
                <tr>                        
                       <th colspan="3">백업 스토리지(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.dbBackStorg}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.dbBackStorg}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>


                
                <tr>                        
                       <th rowspan="2" colspan="2">스토리지</th>
                       <th>저장공간(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.dbStorgSpace}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.dbStorgSpace}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th>전송량(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.dbTransVlmn}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.dbTransVlmn}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th rowspan="2" colspan="2">CDN</th>
                       <th>전송량(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.cdnTransVlmn}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.cdnTransVlmn}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th>예상 요청 수(건)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.cdnRequCnt}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.cdnRequCnt}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th rowspan="2" colspan="2">웹방화벽</th>
                       <th>서비스유형</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.webGoodsKindNm}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.webGoodsKindNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th>처리속도(Mbps)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.webAccess}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.webAccess}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th rowspan="2" colspan="2">모니터링</th>
                       <th>VM(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.mntingVm}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.mntingVm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th>계정 수량(개)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.mntingIdCnt}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.mntingIdCnt}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th rowspan="2" colspan="2">백업</th>
                       <th>백업서버 수량(개)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.bakupCnt}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.bakupCnt}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th>저장용량(GB)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.bakupStorg}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.bakupStorg}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th rowspan="2" colspan="2">부가서비스<br/>보안관리</th>
                       <th>VPN(Mbps)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.sectyVpn}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.sectyVpn}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th>SSL VPN(Users)</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.sectySslvpn}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.sectySslvpn}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
                
                <tr>                        
                       <th colspan="3">부가서비스 기타</th>
                    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                    <c:choose>                
                        <c:when test="${iass2I.consumerYn eq 'Y'}">
                               <td>${iass2I.addedEtc}</td>
                        </c:when>
                        <c:when test="${iass2I.consumerYn eq 'N'}">
                               <td>${iass2I.addedEtc}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>                
        	</tbody>
        </table>

                