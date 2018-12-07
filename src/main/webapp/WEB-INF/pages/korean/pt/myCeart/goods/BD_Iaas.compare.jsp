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
        <c:forEach items="${iassDs}" var="iassDs" varStatus="status">
            <c:choose>
                <c:when test="${iassDs.consumerYn eq 'Y'}">
                    <tr>
	                    <td>${iassDs.serverUse}&nbsp;</td>
                        <td>${iassDs.serverOs}&nbsp;</td>
                        <td>${iassDs.serverCpu}&nbsp;</td>
                        <td>${iassDs.serverMemory}&nbsp;</td>
                        <td>${iassDs.serverDisk}&nbsp;</td>
                        <td>${iassDs.serverQnty}&nbsp;</td>
                    </tr>
                </c:when>
                <c:when test="${iassDs.consumerYn eq 'N' and langStoreId==iassDs.langStoreId}">
                    <tr>
	                    <td><i>${iassDs.serverUse}&nbsp;</i></td>
                        <td><i>${iassDs.serverOs}&nbsp;</i></td>
                        <td><i>${iassDs.serverCpu}&nbsp;</i></td>
                        <td><i>${iassDs.serverMemory}&nbsp;</i></td>
                        <td><i>${iassDs.serverDisk}&nbsp;</i></td>
                        <td><i>${iassDs.serverQnty}&nbsp;</i></td>
                    </tr>
                </c:when>
            </c:choose>
        </c:forEach>
        <!-- 데이터가 없을 때 알림 문구 -->
        <c:if test="${empty iassDs}">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
		    <td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
		</tr>
        </c:if>
	</tbody>
</table>

<table class="tbl_st1 mt0">
	<thead>
		<tr>
			<th colspan="6">서 버</th>
		</tr>
		<tr>
			<th>공인 IP 수량</th>
			<th>네트워크 트래픽</th>
			<th>GSLB</th>
			<th>로드밸런서</th>
			<th>스냅샷</th>
			<th>이미지</th>
		</tr>
	</thead>
	<tbody>
        <c:forEach items="${iassDs}" var="iassDs" varStatus="status">
            <c:choose>
                <c:when test="${iassDs.consumerYn eq 'Y'}">
                    <tr>
						<td>${iassDs.serverIp}&nbsp;</td>
						<td>${iassDs.serverNetwork}&nbsp;</td>
						<td>${iassDs.serverGslb}&nbsp;</td>
						<td>${iassDs.serverLdbl}&nbsp;</td>
						<td>${iassDs.serverSnap}&nbsp;</td>
						<td>${iassDs.serverImg}&nbsp;</td>
                    </tr>
                </c:when>
                <c:when test="${iassDs.consumerYn eq 'N' and langStoreId==iassDs.langStoreId}">
                    <tr>
						<td><i>${iassDs.serverIp}&nbsp;</i></td>
						<td><i>${iassDs.serverNetwork}&nbsp;</i></td>
						<td><i>${iassDs.serverGslb}&nbsp;</i></td>
						<td><i>${iassDs.serverLdbl}&nbsp;</i></td>
						<td><i>${iassDs.serverSnap}&nbsp;</i></td>
						<td><i>${iassDs.serverImg}&nbsp;</i></td>
                    </tr>
                </c:when>
            </c:choose>
        </c:forEach>
        <!-- 데이터가 없을 때 알림 문구 -->
        <c:if test="${empty iassDs}">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
		    <td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
		</tr>
        </c:if>
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
        <c:forEach items="${iassDd}" var="iassDd" varStatus="status">
            <c:choose>
                <c:when test="${iassDd.consumerYn eq 'Y'}">
                    <tr>
						<td>${iassDd.dbUse}&nbsp;</td>
						<td>${iassDd.dbOs}&nbsp;</td>
						<td>${iassDd.dbCpu}&nbsp;</td>
						<td>${iassDd.dbMemory}&nbsp;</td>
						<td>${iassDd.dbDisk}&nbsp;</td>
						<td>${iassDd.dbQnty}&nbsp;</td>
                    </tr>
                </c:when>
                <c:when test="${iassDd.consumerYn eq 'N' and langStoreId==iassDd.langStoreId}">
                    <tr>
						<td><i>${iassDd.dbUse}&nbsp;</i></td>
						<td><i>${iassDd.dbOs}&nbsp;</i></td>
						<td><i>${iassDd.dbCpu}&nbsp;</i></td>
						<td><i>${iassDd.dbMemory}&nbsp;</i></td>
						<td><i>${iassDd.dbDisk}&nbsp;</i></td>
						<td><i>${iassDd.dbQnty}&nbsp;</i></td>
                    </tr>
                </c:when>
            </c:choose>
        </c:forEach>
        <!-- 데이터가 없을 때 알림 문구 -->
        <c:if test="${empty iassDd}">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
		    <td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
		</tr>
        </c:if>
	</tbody>
</table>

<table class="tbl_st1 mt0">
	<thead>
		<tr>
			<th colspan="4">DB</th>
			<th colspan="2">스토리지</th>
		</tr>
		<tr>
			<th>공인 IP 수량</th>
			<th>네트워크 트레픽</th>
			<th>추가 디스크</th>
			<th>백업 스토리지</th>
			<th class="sepa">저장공간</th>
			<th>전송량</th>
		</tr>
	</thead>
	<tbody>
        <c:forEach items="${iassDd}" var="iassDd" varStatus="status">
            <c:choose>
                <c:when test="${iassDd.consumerYn eq 'Y'}">
                    <tr>
						<td>${iassDd.dbIp}&nbsp;</td>
						<td>${iassDd.dbNetwork}&nbsp;</td>
						<td>${iassDd.dbAddDisk}&nbsp;</td>
						<td>${iassDd.dbBackStorg}&nbsp;</td>
						<td class="sepa">${iassDd.dbStorgSpace}&nbsp;</td>
						<td>${iassDd.dbTransVlmn}&nbsp;</td>
                    </tr>
                </c:when>
                <c:when test="${iassDd.consumerYn eq 'N' and langStoreId==iassDd.langStoreId}">
                    <tr>
						<td><i>${iassDd.dbIp}&nbsp;</i></td>
						<td><i>${iassDd.dbNetwork}&nbsp;</i></td>
						<td><i>${iassDd.dbAddDisk}&nbsp;</i></td>
						<td><i>${iassDd.dbBackStorg}&nbsp;</i></td>
						<td class="sepa"><i>${iassDd.dbStorgSpace}&nbsp;</i></td>
						<td><i>${iassDd.dbTransVlmn}&nbsp;</i></td>
                    </tr>
                </c:when>
            </c:choose>
        </c:forEach>
        <!-- 데이터가 없을 때 알림 문구 -->
        <c:if test="${empty iassDd}">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
		    <td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
			<td><i>&nbsp;</i></td>
		</tr>
        </c:if>
	</tbody>
</table>

<table class="tbl_st1">
	<thead>
		<tr>
			<th colspan="2">CDN</th>
			<th colspan="2">웹방화벽</th>
			<th colspan="2">모니터링</th>
		</tr>
		<tr>              
			<th>전송량</th>
			<th>예상 요청 수</th>
			<th class="sepa">서비스유형</th>
			<th>처리속도</th>
			<th class="sepa">VM</th>
			<th>계정 수량</th>
		</tr>
	</thead>
	<tbody>
        <c:forEach items="${iassI}" var="iassI" varStatus="status">
            <c:choose>
                <c:when test="${iassI.consumerYn eq 'Y'}">
                    <tr>
						<td>${iassI.cdnTransVlmn}&nbsp;</td>
						<td>${iassI.cdnRequCnt}&nbsp;</td>
						<td class="sepa">${iassI.webGoodsKind}&nbsp;</td>
						<td>${iassI.webAccess}&nbsp;</td>
						<td class="sepa">${iassI.mntingVm}&nbsp;</td>
						<td>${iassI.mntingIdCnt}&nbsp;</td>
                    </tr>
                </c:when>
                <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                    <tr>
						<td><i>${iassI.cdnTransVlmn}&nbsp;</i></td>
						<td><i>${iassI.cdnRequCnt}&nbsp;</i></td>
						<td class="sepa"><i>${iassI.webGoodsKind}&nbsp;</i></td>
						<td><i>${iassI.webAccess}&nbsp;</i></td>
						<td class="sepa"><i>${iassI.mntingVm}&nbsp;</i></td>
						<td><i>${iassI.mntingIdCnt}&nbsp;</i></td>
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
			<th rowspan="2">관리기능</th>
			<th colspan="2">보안관리</th>
			<th rowspan="2">시스템 설치 및<br /> 운영에 대한<br /> 기술지원 등</th>
		</tr>
		<tr>
			       
			<th>백업서버 수량</th>
			<th>저장용량</th>
			<th class="sepa">VPN</th>
			<th>SSL VPN</th>
		</tr>
	</thead>
	<tbody>
        <c:forEach items="${iassI}" var="iassI" varStatus="status">
            <c:choose>
                <c:when test="${iassI.consumerYn eq 'Y'}">
                    <tr>
						<td>${iassI.bakupCnt}&nbsp;</td>
						<td>${iassI.bakupStorg}&nbsp;</td>
						<td class="sepa">${iassI.mangFunc}&nbsp;</td>
						<td class="sepa">${iassI.sectyVpn}&nbsp;</td>
						<td>${iassI.sectySslvpn}&nbsp;</td>
						<td class="sepa">${iassI.techSupt}&nbsp;</td>
                    </tr>
                </c:when>
                <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                    <tr>
						<td><i>${iassI.bakupCnt}&nbsp;</i></td>
						<td><i>${iassI.bakupStorg}&nbsp;</i></td>
						<td class="sepa"><i>${iassI.mangFunc}&nbsp;</i></td>
						<td class="sepa"><i>${iassI.sectyVpn}&nbsp;</i></td>
						<td><i>${iassI.sectySslvpn}&nbsp;</i></td>
						<td class="sepa"><i>${iassI.techSupt}&nbsp;</i></td>
                    </tr>
                </c:when>
            </c:choose>
        </c:forEach>
	</tbody>
</table>

<h3>기능요구</h3>

<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>
					가상화 및 클라우드 환경 구성<br />
					- 웹 환경에서 가상 자원(서버, 스토리지 등)을 다양한 조합(CPU, 메모리, OS, 스토리지, 네트워크 등)으로 신속하게  생성변경하는 기능 제공
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.funcDmnd1}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.funcDmnd1}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>2</th>
		<td>
			<dl>
				<dt>
					오토 스케일링 지원<br />
					- 이용자 증가, 서비스 기능 추가에 따른 IaaS 확장이나 변경발생시 정상적으로 유지될 수 있는 시스템 구조 제공 <br />
					 ※오토스케일링, 스케일업, 스케일아웃 등
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.funcDmnd2}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.funcDmnd2}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>3</th>
		<td>
			<dl>
				<dt>다양한 단말기ㆍ브라우저ㆍ운영체계 지원</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.funcDmnd3}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.funcDmnd3}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>4</th>
		<td>
			<dl>
				<dt>
					공통요건<br />
					- 제공자가 제공하는 IaaS서비스는 이용자가 명시한 규격과 동일하거나 상향된 사양의 서비스 제공<br />
					- 공개 SW가 제공될 경우 공공기관의 이용에 관리적, 기술적, 법적하자 관리<br />
					- 공개 SW에 대한 유지관리, 기술지원 방안 제공<br />
					※웹서버(WEB), 웹어플리케이션서버(WAS), 데이터베이스 관리시스템(DBMS) 등<br />
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.funcDmnd4}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.funcDmnd4}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

<h3>인터페이스 요구</h3>
<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>자사 및 타사 서비스를 연계하여 서비스 변경‧신규 서비스 생성기능 제공</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.interfaceDmnd}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.interfaceDmnd}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

<h3>보안 요구</h3>
<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>
					보안관제 및 관리방안<br />
					- 관리적, 기술적, 물리적 보안
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.sectyDmnd1}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.sectyDmnd1}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>2</th>
		<td>
			<dl>
				<dt>
					보안지침 준수<br />
					- 수요기관이 요구하는 보안규정 및 지침 준수
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.sectyDmnd2}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.sectyDmnd2}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>3</th>
		<td>
			<dl>
				<dt>
					데이터 보안<br />
					- DB 및 파일에 대한 보안유지, 백업, 이미징
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.sectyDmnd3}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.sectyDmnd3}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>4</th>
		<td>
			<dl>
				<dt>
					보안인증<br />
					- 네트워크, DB, 가상화, 접근통제 등에 대한 CC인증 보유<br />
					※IT보안인증사무국 지정 CC인증제품 유형에 해당하는 품목
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.sectyDmnd4}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.sectyDmnd4}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>5</th>
		<td>
			<dl>
				<dt>
					클라우드컴퓨팅서비스 정보보호에 관한 기준 준수<br />
					- 클라우드컴퓨팅서비스 정보보호에 관한 기준 및 공공기관용 추가 보호조치 등 항목 준수
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.sectyDmnd5}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.sectyDmnd5}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

<h3>품질 요구</h3>
<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>
					클라우드컴퓨팅서비스 품질성능에 관한 기준<br />
					- 클라우드컴퓨팅서비스 품질성능에 관한 기준의 세부기준 지표
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.qutyDmnd1}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.qutyDmnd1}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>2</th>
		<td>
			<dl>
				<dt>
					SLA(서비스수준협약)을 통해 품질보증, 손해배상
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.qutyDmnd2}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.qutyDmnd2}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

<h3>운영 요구</h3>
<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>
					모니터링 및 통계 제공<br />
					- 시스템 부하, CPU, 메모리, OS, 스토리지, 네트워크 등의 상태 실시간 모니터링 및 운영통계 제공
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.optnDmnd1}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.optnDmnd1}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>2</th>
		<td>
			<dl>
				<dt>
					과금관리<br />
					- 이용량, 과금액 실시간 모니터링 및 과금 기준의 유연한 변경기능 제공									
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.optnDmnd2}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.optnDmnd2}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

<h3>프로젝트 지원요구</h3>
<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>
					제공자의 안정성 보장<br />
					- 제공자의 재무상태 확인할 수 있어야 하며 기술보증과 이를 수행할 조직 및 인력 구성									
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.prjtDmnd1}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.prjtDmnd1}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>2</th>
		<td>
			<dl>
				<dt>
					이용자 교육<br />
					- 이용자가 서비스를 원활하게 사용할 수 있도록 교육 및 교육자료 제공
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.prjtDmnd2}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.prjtDmnd2}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>3</th>
		<td>
			<dl>
				<dt>
					고객의견 · 요구대응<br />
					- 이용자가 서비스 이용 중 발생하는 문제에 대해 지원을 받을 수 있는 콜센터 및 기술지원 제공
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.prjtDmnd3}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.prjtDmnd3}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

<h3>기타 요구</h3>
<table class="tbl_st4">
	<tr>
		<th>1</th>
		<td>
			<dl>
				<dt>
					수요기관이 필요한 기타 요구사항 입력
				</dt>
			    <c:forEach items="${iassI}" var="iassI" varStatus="status">
                	<c:choose>
                        <c:when test="${iassI.consumerYn eq 'Y'}">
                        <dd>${iassI.etcDmnd}</dd>
                        </c:when>
                        <c:when test="${iassI.consumerYn eq 'N' and langStoreId==iassI.langStoreId}">
                        <dd><i>${iassI.etcDmnd}&nbsp;</i></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

