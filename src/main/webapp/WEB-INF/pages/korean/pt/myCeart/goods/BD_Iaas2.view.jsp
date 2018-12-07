<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구조건</h3>

<c:if test="${fn:length(iass2Ds) > 0}">                
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
                    <td><i>${iass2Ds.serverUse}&nbsp;</i></td>
                    <td><i>${iass2Ds.serverOs}&nbsp;</i></td>
                    <td><i>${iass2Ds.serverCpu}&nbsp;</i></td>
                    <td><i>${iass2Ds.serverMemory}&nbsp;</i></td>
                    <td><i>${iass2Ds.serverDisk}&nbsp;</i></td>
                    <td><i>${iass2Ds.serverQnty}&nbsp;</i></td>
                </tr>
                </c:when>
            </c:choose>
        </c:forEach>
    </tbody>
     </table>
</c:if>


    <!-- 
    
    부가정보(서버) 
    
    -->
    <table class="tbl_st1 mt0">
        <thead>
            <tr>
                <th colspan="6">부가정보(서버)</th>
            </tr>
            <tr>
                <th>공인 IP 수량(개)</th>
                <th>네트워크 트래픽(GB)</th>
                <th>GSLB(개)</th>
                <th>로드밸런서(GB)</th>
                <th>스냅샷(GB)</th>
                <th>이미지(GB)</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
            <c:choose>
                <c:when test="${iass2I.consumerYn eq 'Y'}">
                <tr>
                    <td>${iass2I.serverIp}&nbsp;</td>
                    <td>${iass2I.serverNetwork}&nbsp;</td>
                    <td>${iass2I.serverGslb}&nbsp;</td>
                    <td>${iass2I.serverLdbl}&nbsp;</td>
                    <td>${iass2I.serverSnap}&nbsp;</td>
                    <td>${iass2I.serverImg}&nbsp;</td>
                </tr>
                </c:when>
                <c:when test="${iass2I.consumerYn eq 'N'}">
                <tr>
                    <td><i>${iass2I.serverIp}&nbsp;</i></td>
                    <td><i>${iass2I.serverNetwork}&nbsp;</i></td>
                    <td><i>${iass2I.serverGslb}&nbsp;</i></td>
                    <td><i>${iass2I.serverLdbl}&nbsp;</i></td>
                    <td><i>${iass2I.serverSnap}&nbsp;</i></td>
                    <td><i>${iass2I.serverImg}&nbsp;</i></td>
                </tr>
                </c:when>
            </c:choose>
        </c:forEach>
        </tbody>
    </table>

<c:if test="${fn:length(iass2Dd) > 0}">
    <table class="tbl_st1">
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
                         <td><i>${iass2Dd.dbUse}&nbsp;</i></td>
                         <td><i>${iass2Dd.dbOs}&nbsp;</i></td>
                         <td><i>${iass2Dd.dbCpu}&nbsp;</i></td>
                         <td><i>${iass2Dd.dbMemory}&nbsp;</i></td>
                         <td><i>${iass2Dd.dbDisk}&nbsp;</i></td>
                         <td><i>${iass2Dd.dbQnty}&nbsp;</i></td>
                    </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
        </tbody>
     </table>
</c:if>

    <!-- 
    
    부가정보(DB)
    
     -->    
    <table class="tbl_st1 mt0">
        <thead>
            <tr>
                <th colspan="4">부가정보(DB)</th>
            </tr>
            <tr>
                <th>공인 IP 수량(개)</th>
                <th>네트워크 트레픽(GB)</th>
                <th>추가 디스크(GB)</th>
                <th>백업 스토리지(GB)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                <c:choose>
                    <c:when test="${iass2I.consumerYn eq 'Y'}">
                    <tr>
                        <td>${iass2I.dbIp}&nbsp;</td>
                        <td>${iass2I.dbNetwork}&nbsp;</td>
                        <td>${iass2I.dbAddDisk}&nbsp;</td>
                        <td>${iass2I.dbBackStorg}&nbsp;</td>
                    </tr>
                    </c:when>
                    <c:when test="${iass2I.consumerYn eq 'N'}">
                    <tr>
                        <td><i>${iass2I.dbIp}&nbsp;</i></td>
                        <td><i>${iass2I.dbNetwork}&nbsp;</i></td>
                        <td><i>${iass2I.dbAddDisk}&nbsp;</i></td>
                        <td><i>${iass2I.dbBackStorg}&nbsp;</i></td>
                    </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
        </tbody>
    </table>


    <table class="tbl_st1 mt0">
        <thead>
            <tr>
                <th colspan="2">스토리지</th>
            </tr>
            <tr>
                <th>저장공간(GB)</th>
                <th>전송량(GB)</th>
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
                        <td><i>${iass2I.dbStorgSpace}&nbsp;</i></td>
                        <td><i>${iass2I.dbTransVlmn}&nbsp;</i></td>
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
                <th>전송량(GB)</th>
                <th>예상 요청 수(건)</th>
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
                        <td><i>${iass2I.cdnTransVlmn}&nbsp;</i></td>
                        <td><i>${iass2I.cdnRequCnt}&nbsp;</i></td>
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
                <th>처리속도(Mbps)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
                <c:choose>
                    <c:when test="${iass2I.consumerYn eq 'Y'}">
                    <tr>
                        <td>${iass2I.webGoodsKindNm}&nbsp;</td>
                        <td>${iass2I.webAccess}&nbsp;</td>
                    </tr>
                    </c:when>
                    <c:when test="${iass2I.consumerYn eq 'N'}">
                    <tr>
                        <td><i>${iass2I.webGoodsKindNm}&nbsp;</i></td>
                        <td><i>${iass2I.webAccess}&nbsp;</i></td>
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
                <th class="sepa">VM(GB)</th>
                <th>계정 수량(개)</th>
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
                        <td><i>${iass2I.mntingVm}&nbsp;</i></td>
                        <td><i>${iass2I.mntingIdCnt}&nbsp;</i></td>
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
                <th>백업서버 수량(개)</th>
                <th>저장용량(GB)</th>
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
                        <td><i>${iass2I.bakupCnt}&nbsp;</i></td>
                        <td><i>${iass2I.bakupStorg}&nbsp;</i></td>
                    </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
        </tbody>
    </table>
    
    <table class="tbl_st1">
        <thead>
            <tr>
                <th colspan="2">부가서비스_보안관리</th>
            </tr>
            <tr>                                   
                <th class="sepa">VPN(Mbps)</th>
                <th>SSL VPN(Users)</th>
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
                        <td><i>${iass2I.sectyVpn}&nbsp;</i></td>
                        <td><i>${iass2I.sectySslvpn}&nbsp;</i></td>
                    </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
        </tbody>
    </table>
    
    <table class="tbl_st1">
        <thead>
            <tr>
                <th>부가서비스_기타</th>
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
                        <td><i>${iass2I.addedEtc}&nbsp;</i></td>
                    </tr>
                    </c:when>
                </c:choose>
            </c:forEach>
        </tbody>
    </table>
    
