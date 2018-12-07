<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="conWrap detailRequ iaas">
	<h3>시스템요구</h3>
	<table id="serverTable01" class="tbl_st1">
		<thead>
			<tr>
				<th colspan="7">서버</th>
			</tr>
			<tr>
				<th>용도</th>
				<th>OS</th>
				<th>CPU(Vcore)</th>
				<th>메모리(GB)</th>
				<th>Disk(GB)</th>
				<th colspan="2">수량(CM)</th>
			</tr>
		</thead>
		<tbody>
	    <c:forEach items="${iassDs}" var="iassDs" varStatus="i">
	        <c:choose>
                <c:when test="${iassDs.consumerYn eq 'Y'}">
	                <c:choose>
                        <c:when test="${i.index eq 0}">
			<tr>
				<td><input type="text" name="serverUse" value="${iassDs.serverUse}"/></td>
				<td><input type="text" name="serverOs" value="${iassDs.serverOs}"/></td>
				<td><input type="text" name="serverCpu" value="${iassDs.serverCpu}"/></td>
				<td><input type="text" name="serverMemory" value="${iassDs.serverMemory}"/></td>
				<td><input type="text" name="serverDisk" value="${iassDs.serverDisk}"/></td>
				<td><input type="text" name="serverQnty" value="${iassDs.serverQnty}"/></td>
				<td><a href="#" onclick="jsIaasAddRow(); return false;" class="btns st3">행추가</a></td>
			</tr>
                        </c:when>
                        <c:when test="${i.index > 0}">
	        <tbody>
			    <tr>
				    <td><input type="text" name="serverUse" value="${iassDs.serverUse}"/></td>
				    <td><input type="text" name="serverOs" value="${iassDs.serverOs}"/></td>
				    <td><input type="text" name="serverCpu" value="${iassDs.serverCpu}"/></td>
				    <td><input type="text" name="serverMemory" value="${iassDs.serverMemory}"/></td>
				    <td><input type="text" name="serverDisk" value="${iassDs.serverDisk}"/></td>
				    <td><input type="text" name="serverQnty" value="${iassDs.serverQnty}"/></td>
				    <td><a href="#" onclick="jsIaaSServerDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
			    </tr>	
		    </tbody>
                        </c:when>
                    </c:choose>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 기본 한줄 표기 -->
        <c:if test="${empty iassDs}">
			<tr>
				<td><input type="text" name="serverUse" value=""/></td>
				<td><input type="text" name="serverOs" /></td>
				<td><input type="text" name="serverCpu" /></td>
				<td><input type="text" name="serverMemory" /></td>
				<td><input type="text" name="serverDisk" /></td>
				<td><input type="text" name="serverQnty" /></td>
				<td><a href="#" onclick="jsIaasAddRow(); return false;" class="btns st3">행추가</a></td>
			</tr>
        </c:if>
		</tbody>
	</table>
	<textarea id="serverAddRow01" style="display:none">
	    <tbody>
			<tr>
				<td><input type="text" name="serverUse" /></td>
				<td><input type="text" name="serverOs" /></td>
				<td><input type="text" name="serverCpu" /></td>
				<td><input type="text" name="serverMemory" /></td>
				<td><input type="text" name="serverDisk" /></td>
				<td><input type="text" name="serverQnty" /></td>
				<td><a href="#" onclick="jsIaaSServerDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
			</tr>	
		</tbody>
	</textarea>

	<table id="serverTable02" class="tbl_st1">
		<thead>
			<tr>
				<th colspan="6">서버</th>
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
	    <c:forEach items="${iassDs}" var="iassDs" varStatus="i">
	        <c:choose>
                <c:when test="${iassDs.consumerYn eq 'Y'}">
	                <c:choose>
                        <c:when test="${i.index eq 0}">
		    <tr>
			    <td><input type="text" name="serverIp"      id="serverIp" value="${iassDs.serverIp}"/></td>
			    <td><input type="text" name="serverNetwork" id="serverNetwork" value="${iassDs.serverNetwork}"/></td>
			    <td><input type="text" name="serverGslb"    id="serverGslb" value="${iassDs.serverGslb}"/></td>
			    <td><input type="text" name="serverLdbl"    id="serverLdbl" value="${iassDs.serverLdbl}"/></td>
			    <td><input type="text" name="serverSnap"    id="serverSnap" value="${iassDs.serverSnap}"/></td>
			    <td><input type="text" name="serverImg"     id="serverImg" value="${iassDs.serverImg}"/></td>
		    </tr>
                        </c:when>
                        <c:when test="${i.index > 0}">
	        <tbody>
			    <tr>
				    <td><input type="text" name="serverIp"      id="serverIp" value="${iassDs.serverIp}"/></td>
				    <td><input type="text" name="serverNetwork" id="serverNetwork" value="${iassDs.serverNetwork}"/></td>
				    <td><input type="text" name="serverGslb"    id="serverGslb" value="${iassDs.serverGslb}"/></td>
				    <td><input type="text" name="serverLdbl"    id="serverLdbl" value="${iassDs.serverLdbl}"/></td>
				    <td><input type="text" name="serverSnap"    id="serverSnap" value="${iassDs.serverSnap}"/></td>
				    <td><input type="text" name="serverImg"     id="serverImg" value="${iassDs.serverImg}"/></td>
			    </tr>
		    </tbody>
                        </c:when>
                    </c:choose>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 기본 한줄 표기 -->
        <c:if test="${empty iassDs}">
			<tr>
				<td><input type="text" name="serverIp"      id="serverIp" /></td>
				<td><input type="text" name="serverNetwork" id="serverNetwork" /></td>
				<td><input type="text" name="serverGslb"    id="serverGslb" /></td>
				<td><input type="text" name="serverLdbl"    id="serverLdbl" /></td>
				<td><input type="text" name="serverSnap"    id="serverSnap" /></td>
				<td><input type="text" name="serverImg"     id="serverImg" /></td>
			</tr>
        </c:if>

		</tbody>
	</table>
	<textarea id="serverAddRow02" style="display:none">
	    <tbody>
			<tr>
				<td><input type="text" name="serverIp"      id="serverIp" /></td>
				<td><input type="text" name="serverNetwork" id="serverNetwork" /></td>
				<td><input type="text" name="serverGslb"    id="serverGslb" /></td>
				<td><input type="text" name="serverLdbl"    id="serverLdbl" /></td>
				<td><input type="text" name="serverSnap"    id="serverSnap" /></td>
				<td><input type="text" name="serverImg"     id="serverImg" /></td>
			</tr>	
		</tbody>
	</textarea>

	<table id="dbTable01" class="tbl_st1">
		<thead>
			<tr>
				<th colspan="7">DB</th>
			</tr>
			<tr>
				<th>용도</th>
				<th>OS</th>
				<th>CPU(Vcore)</th>
				<th>메모리(GB)</th>
				<th>Disk(GB)</th>
				<th colspan="2">수량(CM)</th>
			</tr>
		</thead>
		<tbody>
	    <c:forEach items="${iassDd}" var="iassDd" varStatus="j">
	        <c:choose>
                <c:when test="${iassDd.consumerYn eq 'Y'}">
	                <c:choose>
                        <c:when test="${j.index eq 0}">
			<tr>
				<td><input type="text" name="dbUse" id="dbUse" value="${iassDd.dbUse}"/></td>
				<td><input type="text" name="dbOs" id="dbOs" value="${iassDd.dbOs}"/></td>
				<td><input type="text" name="dbCpu" id="dbCpu" value="${iassDd.dbCpu}"/></td>
				<td><input type="text" name="dbMemory" id="dbMemory" value="${iassDd.dbMemory}"/></td>
				<td><input type="text" name="dbDisk" id="dbDisk" value="${iassDd.dbDisk}"/></td>
				<td><input type="text" name="dbQnty" id="dbQnty" value="${iassDd.dbQnty}"/></td>
				<td><a href="#" onclick="jsDbAddRow(); return false;" class="btns st3">행추가</a></td>
			</tr>
                        </c:when>
                        <c:when test="${j.index > 0}">
		    <tbody>
				<tr>
					<td><input type="text" name="dbUse" id="dbUse" value="${iassDd.dbUse}"/></td>
					<td><input type="text" name="dbOs" id="dbOs" value="${iassDd.dbOs}"/></td>
					<td><input type="text" name="dbCpu" id="dbCpu" value="${iassDd.dbCpu}"/></td>
					<td><input type="text" name="dbMemory" id="dbMemory" value="${iassDd.dbMemory}"/></td>
					<td><input type="text" name="dbDisk" id="dbDisk" value="${iassDd.dbDisk}"/></td>
					<td><input type="text" name="dbQnty" id="dbQnty" value="${iassDd.dbQnty}"/></td>
					<td><a href="#" onclick="jsDbDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
				</tr>	
			</tbody>
                        </c:when>
                    </c:choose>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 기본 한줄 표기 -->
        <c:if test="${empty iassDd}">
			<tr>
				<td><input type="text" name="dbUse" id="dbUse" /></td>
				<td><input type="text" name="dbOs" id="dbOs" /></td>
				<td><input type="text" name="dbCpu" id="dbCpu" /></td>
				<td><input type="text" name="dbMemory" id="dbMemory" /></td>
				<td><input type="text" name="dbDisk" id="dbDisk" /></td>
				<td><input type="text" name="dbQnty" id="dbQnty" /></td>
				<td><a href="#" onclick="jsDbAddRow(); return false;" class="btns st3">행추가</a></td>
			</tr>
        </c:if>
		</tbody>
	</table>

	<textarea id="dbAddRow01" style="display:none">
	    <tbody>
			<tr>
				<td><input type="text" name="dbUse" id="dbUse" /></td>
				<td><input type="text" name="dbOs" id="dbOs" /></td>
				<td><input type="text" name="dbCpu" id="dbCpu" /></td>
				<td><input type="text" name="dbMemory" id="dbMemory" /></td>
				<td><input type="text" name="dbDisk" id="dbDisk" /></td>
				<td><input type="text" name="dbQnty" id="dbQnty" /></td>
				<td><a href="#" onclick="jsDbDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
			</tr>	
		</tbody>
	</textarea>

	<table id="dbTable02" class="tbl_st1">
		<thead>
			<tr>
				<th colspan="4">DB</th>
				<th colspan="2">스토리지</th>
			</tr>
			<tr>
				<th>공인 IP 수량</th>
				<th>네트워크 트래픽</th>
				<th>추가 디스크</th>
				<th>백업 스토리지</th>
				<th class="sepa">저장공간</th>
				<th>전송량</th>
			</tr>
		</thead>
		<tbody>
	    <c:forEach items="${iassDd}" var="iassDd" varStatus="j">
	        <c:choose>
                <c:when test="${iassDd.consumerYn eq 'Y'}">
	                <c:choose>
                        <c:when test="${j.index eq 0}">
			<tr>
				<td><input type="text" name="dbIp" id="dbIp" value="${iassDd.dbIp}"/></td>
				<td><input type="text" name="dbNetwork" id="dbNetwork" value="${iassDd.dbNetwork}"/></td>
				<td><input type="text" name="dbAddDisk" id="dbAddDisk" value="${iassDd.dbAddDisk}"/></td>
				<td><input type="text" name="dbBackStorg" id="dbBackStorg" value="${iassDd.dbBackStorg}"/></td>
				<td class="sepa"><input type="text" name="dbStorgSpace" id="dbStorgSpace" value="${iassDd.dbStorgSpace}"/></td>
				<td><input type="text" name="dbTransVlmn" id="dbTransVlmn" value="${iassDd.dbTransVlmn}"/></td>
			</tr>
                        </c:when>
                        <c:when test="${j.index > 0}">
		    <tbody>
				<tr>
					<td><input type="text" name="dbIp" id="dbIp" value="${iassDd.dbIp}"/></td>
					<td><input type="text" name="dbNetwork" id="dbNetwork" value="${iassDd.dbNetwork}"/></td>
					<td><input type="text" name="dbAddDisk" id="dbAddDisk" value="${iassDd.dbAddDisk}"/></td>
					<td><input type="text" name="dbBackStorg" id="dbBackStorg" value="${iassDd.dbBackStorg}"/></td>
					<td class="sepa"><input type="text" name="dbStorgSpace" id="dbStorgSpace" value="${iassDd.dbStorgSpace}"/></td>
					<td><input type="text" name="dbTransVlmn" id="dbTransVlmn" value="${iassDd.dbTransVlmn}"/></td>
				</tr>	
			</tbody>
                        </c:when>
                    </c:choose>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 기본 한줄 표기 -->
        <c:if test="${empty iassDd}">
			<tr>
				<td><input type="text" name="dbIp" id="dbIp" /></td>
				<td><input type="text" name="dbNetwork" id="dbNetwork" /></td>
				<td><input type="text" name="dbAddDisk" id="dbAddDisk" /></td>
				<td><input type="text" name="dbBackStorg" id="dbBackStorg" /></td>
				<td class="sepa"><input type="text" name="dbStorgSpace" id="dbStorgSpace" /></td>
				<td><input type="text" name="dbTransVlmn" id="dbTransVlmn" /></td>
			</tr>
        </c:if>
		</tbody>
	</table>

	<textarea id="dbAddRow02" style="display:none">
	    <tbody>
			<tr>
				<td><input type="text" name="dbIp" id="dbIp" /></td>
				<td><input type="text" name="dbNetwork" id="dbNetwork" /></td>
				<td><input type="text" name="dbAddDisk" id="dbAddDisk" /></td>
				<td><input type="text" name="dbBackStorg" id="dbBackStorg" /></td>
				<td class="sepa"><input type="text" name="dbStorgSpace" id="dbStorgSpace" /></td>
				<td><input type="text" name="dbTransVlmn" id="dbTransVlmn" /></td>
			</tr>	
		</tbody>
	</textarea>

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
			<tr>
				<td><input type="text" name="cdnTransVlmn" id="cdnTransVlmn" value="${iassI[0].cdnTransVlmn}"/></td>
				<td><input type="text" name="cdnRequCnt" id="cdnRequCnt" value="${iassI[0].cdnRequCnt}"/></td>
				<td class="sepa"><input type="text" name="webGoodsKind" id="webGoodsKind" value="${iassI[0].webGoodsKind}"/></td>
				<td><input type="text" name="webAccess" id="webAccess" value="${iassI[0].webAccess}"/></td>
				<td class="sepa"><input type="text" name="mntingVm" id="mntingVm" value="${iassI[0].mntingVm}"/></td>
				<td><input type="text" name="mntingIdCnt" id="mntingIdCnt" value="${iassI[0].mntingIdCnt}"/></td>
			</tr>
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
				<th>백업서버 수량 </th>
				<th>저장용량</th>					
				<th class="sepa">VPN</th>
				<th>SSL VPN</th>					
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="bakupCnt" id="bakupCnt" value="${iassI[0].bakupCnt}"/></td>
				<td><input type="text" name="bakupStorg" id="bakupStorg" value="${iassI[0].bakupStorg}"/></td>
				<td class="sepa"><input type="text" name="mangFunc" id="mangFunc" value="${iassI[0].mangFunc}"/></td>
				<td class="sepa"><input type="text" name="sectyVpn" id="sectyVpn" value="${iassI[0].sectyVpn}"/></td>
				<td><input type="text" name="sectySslvpn" id="sectySslvpn" value="${iassI[0].sectySslvpn}"/></td>
				<td class="sepa"><input type="text" name="techSupt" id="techSupt" value="${iassI[0].techSupt}"/></td>
			</tr>
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
					<dd><input type="text" name="funcDmnd1" id="funcDmnd1" value="${iassI[0].funcDmnd1}"/></dd>
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
					<dd><input type="text" name="funcDmnd2" id="funcDmnd2" value="${iassI[0].funcDmnd2}"/></dd>
				</dl>
			</td>
		</tr>
		<tr>
			<th>3</th>
			<td>
				<dl>
					<dt>다양한 단말기ㆍ브라우저ㆍ운영체계 지원</dt>
					<dd><input type="text" name="funcDmnd3" id="funcDmnd3" value="${iassI[0].funcDmnd3}"/></dd>
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
					<dd><input type="text" name="funcDmnd4" id="funcDmnd4" value="${iassI[0].funcDmnd4}"/></dd>
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
					<dd><input type="text" name="interfaceDmnd" id="interfaceDmnd" value="${iassI[0].interfaceDmnd}"/></dd>
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
					<dd><input type="text" name="sectyDmnd1" id="sectyDmnd1" value="${iassI[0].sectyDmnd1}"/></dd>
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
					<dd><input type="text" name="sectyDmnd2" id="sectyDmnd2" value="${iassI[0].sectyDmnd2}"/></dd>
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
					<dd><input type="text" name="sectyDmnd3" id="sectyDmnd3" value="${iassI[0].sectyDmnd3}"/></dd>
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
					<dd><input type="text" name="sectyDmnd4" id="sectyDmnd4" value="${iassI[0].sectyDmnd4}"/></dd>
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
					<dd><input type="text" name="sectyDmnd5" id="sectyDmnd5" value="${iassI[0].sectyDmnd5}"/></dd>
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
					<dd><input type="text" name="qutyDmnd1" id="qutyDmnd1" value="${iassI[0].qutyDmnd1}"/></dd>
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
					<dd><input type="text" name="qutyDmnd2" id="qutyDmnd2" value="${iassI[0].qutyDmnd2}"/></dd>
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
					<dd><input type="text" name="optnDmnd1" id="optnDmnd1" value="${iassI[0].optnDmnd1}"/></dd>
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
					<dd><input type="text" name="optnDmnd2" id="optnDmnd2" value="${iassI[0].optnDmnd2}"/></dd>
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
					<dd><input type="text" name="prjtDmnd1" id="prjtDmnd1" value="${iassI[0].prjtDmnd1}"/></dd>
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
					<dd><input type="text" name="prjtDmnd2" id="prjtDmnd2" value="${iassI[0].prjtDmnd2}"/></dd>
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
					<dd><input type="text" name="prjtDmnd3" id="prjtDmnd3" value="${iassI[0].prjtDmnd3}"/></dd>
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
					<dd><input type="text" name="etcDmnd" id="etcDmnd" value="${iassI[0].etcDmnd}"/></dd> 
				</dl>
			</td>
		</tr>
	</table>
</div>
<!--// content -->