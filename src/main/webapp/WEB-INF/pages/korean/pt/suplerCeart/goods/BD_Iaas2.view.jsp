<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

				<h3>시스템 요구조건</h3>
				
				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="6">서버</th>
						</tr>
						<tr>
							<th>용도</th>
							<th>OS</th>
							<th>CPU(Vcore)</th>
							<th>메모리(GB)</th>
							<th>Disk(GB)</th>
							<th>수량(CM)</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2Ds.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2Ds.serverUse}&nbsp;</td>
									<td>${iass2Ds.serverOs}&nbsp;</td>
									<td>${iass2Ds.serverCpu}&nbsp;</td>
									<td>${iass2Ds.serverMemory}&nbsp;</td>
									<td>${iass2Ds.serverDisk}&nbsp;</td>
									<td>${iass2Ds.serverQnty}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2Ds.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="serverUse"    value="${iass2Ds.serverUse}"/></td>
									<td><input type="text" name="serverOs"     value="${iass2Ds.serverOs}"/></td>
									<td><input type="text" name="serverCpu"    value="${iass2Ds.serverCpu}"/></td>
									<td><input type="text" name="serverMemory" value="${iass2Ds.serverMemory}"/></td>
									<td><input type="text" name="serverDisk"   value="${iass2Ds.serverDisk}"/></td>
									<td><input type="text" name="serverQnty"   value="${iass2Ds.serverQnty}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>					

				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="6">DB</th>
						</tr>
						<tr>
							<th>용도</th>
							<th>OS</th>
							<th>CPU(Vcore)</th>
							<th>메모리(GB)</th>
							<th>Disk(GB)</th>
							<th>수량(CM)</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2Dd.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2Dd.dbUse}&nbsp;</td>
									<td>${iass2Dd.dbOs}&nbsp;</td>
									<td>${iass2Dd.dbCpu}&nbsp;</td>
									<td>${iass2Dd.dbMemory}&nbsp;</td>
									<td>${iass2Dd.dbDisk}&nbsp;</td>
									<td>${iass2Dd.dbQnty}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2Dd.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="dbUse"    value="${iass2Dd.dbUse}"/></td>
									<td><input type="text" name="dbOs"     value="${iass2Dd.dbOs}"/></td>
									<td><input type="text" name="dbCpu"    value="${iass2Dd.dbCpu}"/></td>
									<td><input type="text" name="dbMemory" value="${iass2Dd.dbMemory}"/></td>
									<td><input type="text" name="dbDisk"   value="${iass2Dd.dbDisk}"/></td>
									<td><input type="text" name="dbQnty"   value="${iass2Dd.dbQnty}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>

<!-- 		            
	상세견적서 쪽이므로 신경쓰지말것

    private String serverIp;             /** 서버 IP */    
    private String serverNetwork;        /** 서버 네트웍트래픽 */    
    private String serverGslb;           /** 서버 GSLB */    
    private String serverLdbl;           /** 서버 로드밸런스 */    
    private String serverSnap;           /** 서버 스냅샷 */    
    private String serverImg;            /** 서버 이미지 */
		            
	private String dbIp;                 /** DB IP */
    private String dbNetwork;            /** DB 네트웍트래픽 */
    private String dbAddDisk;            /** DB 추가디스크 */
    private String dbBackStorg;          /** DB 백업스토리지 */
 -->    	            

				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="2">스토리지</th>
						</tr>
						<tr>
							<th>저장공간</th>
							<th>전송량</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.dbStorgSpace}&nbsp;</td>
									<td>${iass2I.dbTransVlmn}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="dbStorgSpace" value="${iass2I.dbStorgSpace}"/></td>
									<td><input type="text" name="dbTransVlmn"  value="${iass2I.dbTransVlmn}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>

				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="2">CDN</th>
						</tr>
						<tr>              
							<th>전송량</th>
							<th>예상 요청 수</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.cdnTransVlmn}&nbsp;</td>
									<td>${iass2I.cdnRequCnt}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="cdnTransVlmn" id="cdnTransVlmn" value="${iass2I.cdnTransVlmn}"/></td>
									<td><input type="text" name="cdnRequCnt"   id="cdnRequCnt"   value="${iass2I.cdnRequCnt}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>

				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="2">웹방화벽</th>
						</tr>
						<tr>              
							<th class="sepa">서비스유형</th>
							<th>처리속도</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.webGoodsKind}&nbsp;</td>
									<td>${iass2I.webAccess}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="webGoodsKind" id="webGoodsKind" value="${iass2I.webGoodsKind}"/></td>
									<td><input type="text" name="webAccess"    id="webAccess"    value="${iass2I.webAccess}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>

				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="2">모니터링</th>
						</tr>
						<tr>              
							<th class="sepa">VM</th>
							<th>계정 수량</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.mntingVm}&nbsp;</td>
									<td>${iass2I.mntingIdCnt}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="mntingVm"     id="mntingVm"     value="${iass2I.mntingVm}"/></td>
									<td><input type="text" name="mntingIdCnt"  id="mntingIdCnt"  value="${iass2I.mntingIdCnt}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>


				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="2">백업</th>
						</tr>
						<tr>						       
							<th>백업서버 수량</th>
							<th>저장용량</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.bakupCnt}&nbsp;</td>
									<td>${iass2I.bakupStorg}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="bakupCnt"    id="bakupCnt"    value="${iass2I.bakupCnt}"/></td>
									<td><input type="text" name="bakupStorg"  id="bakupStorg"  value="${iass2I.bakupStorg}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>
				
				<table class="tbl_st1">
					<thead>
						<tr>
							<th colspan="2">부가서비스</th>
						</tr>
						<tr>
							       
							<th class="sepa">VPN</th>
							<th>SSL VPN</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.sectyVpn}&nbsp;</td>
									<td>${iass2I.sectySslvpn}&nbsp;</td>
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="sectyVpn"    id="sectyVpn"    value="${iass2I.sectyVpn}"/></td>
									<td><input type="text" name="sectySslvpn" id="sectySslvpn" value="${iass2I.sectySslvpn}"/></td>
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>

				<table class="tbl_st1">
					<thead>
						<tr>
							<th>기타</th>
						</tr>
					</thead>
					<tbody>
					    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
		                	<c:choose>
		                        <c:when test="${iass2I.consumerYn eq 'Y'}">
								<tr>
									<td>${iass2I.addedEtc}&nbsp;</td>
									
								</tr>
		                        </c:when>
		                        <c:when test="${iass2I.consumerYn eq 'N'}">
								<tr>
									<td><input type="text" name="bakupCnt"    id="bakupCnt"    value="${iass2I.addedEtc}"/></td>
									
								</tr>
		                        </c:when>
		                    </c:choose>
			            </c:forEach>
					</tbody>
				</table>
				
				