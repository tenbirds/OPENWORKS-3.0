<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>서비스관리 | 판매하기 | 씨앗 마켓</title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<script type="text/javascript">
function jsFileDelete(inputId, inputIdFake){
    document.getElementById(inputIdFake).value="";
    $("input[name="+inputId+"]").val("");
}



function jsFileChk(inputId, inputIdFake){
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
		}
function jsOnlyNumber(event){
    var key = window.event ? event.keyCode : event.which;    

    if ((event.shiftKey == false) && ((key  > 47 && key  < 58) || (key  > 95 && key  < 106)
    || key  == 35 || key  == 36 || key  == 37 || key  == 39  // 방향키 좌우,home,end  
    || key  == 8  || key  == 46 || key == 9 )
    ) {
        return true;
    }else {
        return false;
    }            
}
var jsPage = function(type){
    $("form[name=dataForm]").attr("method","post");
	$("form[name=dataForm]").attr("action","/korean/pt/apply/BD_IaaSInsert.do");
	$("form[name=dataForm]").submit();
};
</script>
</head>
<body>
<c:set var="InfoRequest" value="${pagerRequest}"/>
<c:set var="InfoSupplier" value="${pagerSupplier}"/>
<c:set var="ISInfo" value="${dataListInfo}"/>
		<div class="conWrap">	
			<div class="supAdm answAdm detail">
			<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="BD_IaaSInsert.do">
			<p class="viewTit"><c:out value="${InfoRequest.cmpnyNm}"/></p>
			<input type="hidden" id="notifyNum" name="notifyNum" value="${InfoRequest.notifyNum}">
			<input type="hidden" id="notifySeq" name="notifySeq" value="${InfoRequest.notifySeq}">
			
				<!-- 요청자(이용자) 정보 -->
					<h3>요청자 정보</h3>
					<table class="tbl_st4 e4">
						<tr>
							<th class="requ"> 작성자</th>
							<td><c:out value="${InfoRequest.userNm}"/></td>
							<th class="requ"> 휴대전화</th>
							<td><c:out value="${InfoRequest.goodsChargerCttpc}"/></td>
						</tr>
						<tr>
							<th class="requ"> 기업/기관명</th>
							<td><c:out value="${InfoRequest.readDmndOrgn}"/></td>
							<th class="requ"> 이메일</th>
							<td><c:out value="${InfoRequest.emailId}"/></td>
						</tr>
						<tr>
							<th>직책</th>
							<td><c:out value="${InfoRequest.userPosition}"/></td>
							<th>대표전화</th>
							<td><c:out value="${InfoRequest.telnoNum}"/></td>
						</tr>
					</table>
					<!-- 요청자(이용자) 정보 끝-->
					<!-- IaaS 내용 시작 -->
					<!--  IaaSInfoRequestOne 시작 -->
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
				<c:forEach items="${dataListServer}" var="IaaSInfoServer" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfoServer.consumerYn eq 'Y'}">
								<tr>
									<td>${IaaSInfoServer.serverUse}</td>
									<td>${IaaSInfoServer.serverOs}</td>
									<td>${IaaSInfoServer.serverCpu}</td>
									<td>${IaaSInfoServer.serverMemory}</td>
									<td>${IaaSInfoServer.serverDisk}</td>
									<td>${IaaSInfoServer.serverQnty}</td>
								</tr>
							</c:when>
							<c:when test="${IaaSInfoServer.consumerYn eq 'N'}">
								<tr>
									<td><!-- type chack -->
							        <c:if test="${ null eq IaaSInfoServer.serverUse}">
										<input type="hidden" name="applytype" id="applytype" value="IaaSInsert">
									</c:if>
											
									<c:if test="${ null ne IaaSInfoServer.serverUse}">
										<input type="hidden" name="applytype" id="applytype" value="IaaSUpdate">
									</c:if>
									<input type="text" name = "serverUse" id  = "serverUse" value="${IaaSInfoServer.serverUse}"></td>
									<td><input type="text" name = "serverOs" id = "serverOs" value="${IaaSInfoServer.serverOs}"></td>
									<td><input type="text" name = "serverCpu" id = "serverCpu" value="${IaaSInfoServer.serverCpu}"></td>
									<td><input type="text" name = "serverMemory" id = "serverMemory" value="${IaaSInfoServer.serverMemory}"></td>
									<td><input type="text" name = "serverDisk" id = "serverDisk"  value="${IaaSInfoServer.serverDisk}"></td>
									<td><input type="text" name = "serverQnty" id = "serverQnty" value="${IaaSInfoServer.serverQnty}"></td>
								</tr>
						     </c:when>
					     </c:choose>
					</c:forEach>
			</tbody>
		</table>

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
					<c:forEach items="${dataListServer}" var="IaaSInfoServer" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfoServer.consumerYn eq 'Y'}">
								<tr>
									<td>${IaaSInfoServer.serverIp}</td>
									<td>${IaaSInfoServer.serverNetwork}</td>
									<td>${IaaSInfoServer.serverGslb}</td>
									<td>${IaaSInfoServer.serverLdbl}</td>
									<td>${IaaSInfoServer.serverSnap}</td>
									<td>${IaaSInfoServer.serverImg}</td>
								</tr>
							</c:when>
							<c:when test="${IaaSInfoServer.consumerYn eq 'N'}">
								<tr>
									<td>
									<input type="text" name = "serverIp" id = "serverIp" value="${IaaSInfoServer.serverIp}"></td>
									<td><input type="text" name = "serverNetwork" id = "serverNetwork" value="${IaaSInfoServer.serverNetwork}"></td>
									<td><input type="text" name = "serverGslb" id = "serverGslb" value="${IaaSInfoServer.serverGslb}"></td>
									<td><input type="text" name = "serverLdbl" id = "serverLdbl" value="${IaaSInfoServer.serverLdbl}"></td>
									<td><input type="text" name = "serverSnap" id = "serverSnap" value="${IaaSInfoServer.serverSnap}"></td>
									<td><input type="text" name = "serverImg" id = "serverImg" value="${IaaSInfoServer.serverImg}"></td>
								</tr>
						     </c:when>
					     </c:choose>
					</c:forEach>
			</tbody>
		</table>
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
				<c:forEach items="${dataListDb}" var="IaaSInfoDb" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfoDb.consumerYn eq 'Y'}">
								<tr>
									<td>${IaaSInfoDb.dbUse}</td>
									<td>${IaaSInfoDb.dbOs}</td>
									<td>${IaaSInfoDb.dbCpu}</td>
									<td>${IaaSInfoDb.dbMemory}</td>
									<td>${IaaSInfoDb.dbDisk}</td>
									<td>${IaaSInfoDb.dbQnty}</td>
								</tr>
							</c:when>
							<c:when test="${IaaSInfoDb.consumerYn eq 'N'}">
								<tr>
									<td>
									<input type="text" name = "dbUse" id= "dbUse" value="${IaaSInfoDb.dbUse}"></td>
									<td><input type="text" name = "dbOs"id = "dbOs" value="${IaaSInfoDb.dbOs}"></td>
									<td><input type="text" name = "dbCpu"  id = "dbCpu" value="${IaaSInfoDb.dbCpu}"></td>
									<td><input type="text" name = "dbMemory" id = "dbMemory" value="${IaaSInfoDb.dbMemory}"></td>
									<td><input type="text" name = "dbDisk" id = "dbDisk" value="${IaaSInfoDb.dbDisk}"></td>
									<td><input type="text" name = "dbQnty" id = "dbQnty" value="${IaaSInfoDb.dbQnty}"></td>
								</tr>
						     </c:when>
					     </c:choose>
					</c:forEach>
			</table>
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
				<c:forEach items="${dataListDb}" var="IaaSInfoDb" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfoDb.consumerYn eq 'Y'}">
								<tr>
									<td>${IaaSInfoDb.dbIp}</td>
									<td>${IaaSInfoDb.dbNetwork}</td>
									<td>${IaaSInfoDb.dbAddDisk}</td>
									<td>${IaaSInfoDb.dbBackStorg}</td>
									<td>${IaaSInfoDb.dbStorgSpace}</td>
									<td>${IaaSInfoDb.dbTransVlmn}</td>
								</tr>
							</c:when>
							<c:when test="${IaaSInfoDb.consumerYn eq 'N'}">
								<tr>
									<td>
									<input type="text" name = "dbIp" id = "dbIp" value="${IaaSInfoDb.dbIp}"></td>
									<td><input type="text" name = "dbNetwork" id = "dbNetwork" value="${IaaSInfoDb.dbNetwork}"></td>
									<td><input type="text" name = "dbAddDisk" id = "dbAddDisk" value="${IaaSInfoDb.dbAddDisk}"></td>
									<td><input type="text" name = "dbBackStorg" id = "dbBackStorg" value="${IaaSInfoDb.dbBackStorg}"></td>
									<td><input type="text" name = "dbStorgSpace" id = "dbStorgSpace" value="${IaaSInfoDb.dbStorgSpace}"></td>
									<td><input type="text" name = "dbTransVlmn" id = "dbTransVlmn" value="${IaaSInfoDb.dbTransVlmn}"></td>
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
				<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
								<tr>
									
									<td>${IaaSInfo.cdnTransVlmn}</td>
									<td>${IaaSInfo.cdnRequCnt}</td>
									<td>${IaaSInfo.webGoodsKind}</td>
									<td>${IaaSInfo.webAccess}</td>
									<td>${IaaSInfo.mntingVm}</td>
									<td>${IaaSInfo.mntingIdCnt}</td>
								</tr>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
								<tr>
									<td>
									<input type="hidden" name="applySeq" value="${IaaSInfo.applySeq}">
									<input type="text" name = "cdnTransVlmn" value="${IaaSInfo.cdnTransVlmn}"></td>
									<td><input type="text" name = "cdnRequCnt" value="${IaaSInfo.cdnRequCnt}"></td>
									<td><input type="text" name = "webGoodsKind" value="${IaaSInfo.webGoodsKind}"></td>
									<td><input type="text" name = "webAccess" value="${IaaSInfo.webAccess}"></td>
									<td><input type="text" name = "mntingVm" value="${IaaSInfo.mntingVm}"></td>
									<td><input type="text" name = "mntingIdCnt" value="${IaaSInfo.mntingIdCnt}"></td>
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
					<th>백업서버 수량 </th>
					<th>저장용량</th>					
					<th class="sepa">VPN</th>
					<th>SSL VPN</th>					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
								<tr>
									<td>${IaaSInfo.bakupCnt}</td>
									<td>${IaaSInfo.bakupStorg}</td>
									<td>${IaaSInfo.mangFunc}</td>
									<td>${IaaSInfo.sectyVpn}</td>
									<td>${IaaSInfo.sectySslvpn}</td>
									<td>${IaaSInfo.techSupt}</td>
								</tr>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
								<tr>
									<td>
									<input type="hidden" name="applySeq" value="${IaaSInfo.applySeq}">
									<input type="text" name = "bakupCnt" value="${IaaSInfo.bakupCnt}"></td>
									<td><input type="text" name = "bakupStorg" value="${IaaSInfo.bakupStorg}"></td>
									<td><input type="text" name = "mangFunc" value="${IaaSInfo.mangFunc}"></td>
									<td><input type="text" name = "sectyVpn" value="${IaaSInfo.sectyVpn}"></td>
									<td><input type="text" name = "sectySslvpn" value="${IaaSInfo.sectySslvpn}"></td>
									<td><input type="text" name = "techSupt" value="${IaaSInfo.techSupt}"></td>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.funcDmnd1}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="funcDmnd1" id="funcDmnd1" value="${IaaSInfo.funcDmnd1}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.funcDmnd2}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="funcDmnd2" id="funcDmnd2" value="${IaaSInfo.funcDmnd2}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.funcDmnd3}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="funcDmnd3" id="funcDmnd3" value="${IaaSInfo.funcDmnd3}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.funcDmnd4}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="funcDmnd4" id="funcDmnd4" value="${IaaSInfo.funcDmnd4}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.interfaceDmnd}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="interfaceDmnd" id="interfaceDmnd" value="${IaaSInfo.interfaceDmnd}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd1}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="sectyDmnd1" id="sectyDmnd1" value="${IaaSInfo.sectyDmnd1}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd2}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="sectyDmnd2" id="sectyDmnd2" value="${IaaSInfo.sectyDmnd2}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd3}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="sectyDmnd3" id="sectyDmnd3" value="${IaaSInfo.sectyDmnd3}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd4}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="sectyDmnd4" id="sectyDmnd4" value="${IaaSInfo.sectyDmnd4}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd5}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="sectyDmnd5" id="sectyDmnd5" value="${IaaSInfo.sectyDmnd5}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.qutyDmnd1}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="qutyDmnd1" id="qutyDmnd1" value="${IaaSInfo.qutyDmnd1}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.qutyDmnd2}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="qutyDmnd2" id="qutyDmnd2" value="${IaaSInfo.qutyDmnd2}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.optnDmnd1}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="optnDmnd1" id="optnDmnd1" value="${IaaSInfo.optnDmnd1}" /></dd>
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
							과금관리<br/>
							- 이용량, 과금액 실시간 모니터링 및 과금 기준의 유연한 변경기능 제공									
						</dt>
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.optnDmnd2}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="optnDmnd2" id="optnDmnd2" value="${IaaSInfo.optnDmnd2}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd1}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="prjtDmnd1" id="prjtDmnd1" value="${IaaSInfo.prjtDmnd1}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.prjtDmnd2}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="prjtDmnd2" id="prjtDmnd2" value="${IaaSInfo.prjtDmnd2}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.sectyDmnd1}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="prjtDmnd3" id="prjtDmnd3" value="${IaaSInfo.prjtDmnd3}" /></dd>
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
						<c:forEach items="${dataListInfo}" var="IaaSInfo" varStatus="status">
						<c:choose>
							<c:when test="${IaaSInfo.consumerYn eq 'Y'}">
									<br /><dd>${IaaSInfo.etcDmnd}</dd>
							</c:when>
							<c:when test="${IaaSInfo.consumerYn eq 'N'}">
									<dd><input type="text" name="etcDmnd" id="etcDmnd" value="${IaaSInfo.etcDmnd}" /></dd>
						     </c:when>
					     </c:choose>
						</c:forEach>
					</dl>
				</td>
			</tr>
		</table>

					<!-- Iaas 내용 끝 -->
				<h3>납품 요구조건</h3>
				<table class="tbl_st4">
					<tr>
						<th>희망 구매가</th>
							<td colspan="3"><fmt:formatNumber value="${InfoRequest.hopePuchAmt}" groupingUsed="true"/>원 &nbsp;/&nbsp; 
								<c:choose>
									<c:when test="${InfoRequest.vatGbn eq 'Y'}">
										<span>VAT포함</span>
									</c:when>
									<c:otherwise>
										<span>VAT미포함</span>
									</c:otherwise>
								</c:choose>	
						</td>
					</tr>
					<tr>
						<th class="requ">납품 기한</th>
						<td>
						<c:if test="${ null eq InfoRequest.delyDt}">
							합의후 결정
						</c:if>
						<c:if test="${ null ne InfoRequest.delyDt}">
							<c:out value="${InfoRequest.delyDt}"/>시
						</c:if>
						</td>
						<th class="requ">응답 만료일	</th>
						<td><c:out value="${InfoRequest.rplyDt}"/></td>
					</tr>
					<tr>
						<th>납품 장소</th>
						<td colspan="3"><c:out value="${InfoRequest.delyPlac}"/></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
						<c:if test="${ 0 eq InfoRequest.delyFile}">
							 미 첨부
						</c:if>
						<c:if test="${ 0 ne InfoRequest.delyFile}">
							<c:out value="${InfoRequest.delyFile}"/>
						</c:if>
						
						</td>
					</tr>
					<tr>
						<th>추가문의</th>
						<td colspan="3"><c:out value="${InfoRequest.notifyCont}"/></td>
					</tr>
				</table>
				<div class="replyWrap">
					<table class="tbl_st4">
						<tr>
							<th>제공금액</th>
							<td class="vat">
								<div class="unit">
									<i>원</i>				
									<div>
									<c:choose>
										     <c:when test="${ 0 eq InfoSupplier.splyAmt}">
												<input id="splyAmts" name ="splyAmts"type="text" onkeydown="return jsOnlyNumber(event);"/>
											</c:when>
											<c:when test="${ 0 ne InfoSupplier.splyAmt}">
												<input id="splyAmts" name ="splyAmts"type="text" onkeydown="return jsOnlyNumber(event);" value="${InfoSupplier.splyAmt}"/>
											</c:when>
									</c:choose>
									</div>
								</div>
								<c:choose>
									<c:when test="${InfoRequest.vatGbn eq 'Y'}">
										<input id="vatGbns" name ="vatGbns"type="hidden" value="Y"/>
										<span>VAT포함</span>
									</c:when>
									<c:otherwise>
										<input id="vatGbns" name ="vatGbns"type="hidden" value="N"/>
										<span>VAT미포함</span>
									</c:otherwise>
								</c:choose>	

							</td>
							
						</tr>
						<tr>
							<th>추가답변</th>
							<td><textarea id="addAnswers" name="addAnswers">${InfoSupplier.addAnswer}</textarea></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><textarea id="splyNotes"name="splyNotes">${InfoSupplier.splyNote}</textarea></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div class="uploadFile">
									<input type="text" readonly="readonly" name="optlCntrFileInput" id="optlCntrFileInput" title="파일명"/>
									<div>
										<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="javascript:jsFileDelete('splyFile', 'optlCntrFileInput');" alt="삭제" />							
						            	<span class="btns st3">
						            		파일선택
						            		<input type="file" name="splyFile" id="splyFile" class="splyFile" title="파일찾기" onchange="javascript:jsFileChk('splyFile', 'optlCntrFileInput');"/>
						            	</span>
					            	</div>
					            </div>
							</td>
						</tr>
					</table>
					<h3>제공자 정보</h3>
					<table class="tbl_st4 e4">
						<tr>
							<th class="requ">담당자</th>
							<td><c:out value="${InfoSupplier.userNm}"/></td>
							<th class="requ">휴대전화</th>
							<td><c:out value="${InfoSupplier.mbtlNumber}"/></td>
						</tr>
						<tr>
							<th>직책</th>
							<td><input  name="position"type="text" /></td>
							<th class="requ">이메일</th>
							<td><c:out value="${InfoSupplier.emailId}"/></td>
						</tr>
						<tr> 
							<th class="requ">회사명</th>
							<td><c:out value="${InfoSupplier.cmpnyNm}"/></td>
							<th class="requ">대표전화</th>
							<td><c:out value="${InfoSupplier.cmpnyReprsntTelno}"/></td>
						</tr>
					</table>
				</div>
					<div class="btnArea rig">
					<a href="javascript:" onclick="" class="btns st2 icn icnBck">반 려</a>
					<a href="javascript:" onclick="jsPage();" class="btns st4 icn icnSend">제 출</a>
					<a href="/korean/pt/apply/BD_ApplyList.do" class="btns st4 icn icnList">목록보기</a>
					</div>					
				</form>
			</div>	
		</div>
</body>
</html>
