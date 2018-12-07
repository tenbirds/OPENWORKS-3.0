<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
    //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // 툴팁 설정
            $(".attrNm").tooltip({ });
        });

    //]]>
    </script>

    <div class="deshboard_img">
        <c:set var="onOff" value="off" />
        <c:if test="${dataVo.stat01 gt 0}">
            <c:set var="onOff" value="on" />
        </c:if>
        <p><img src="/resources/monitor/images/icon/error01_${onOff}.png"  alt="장애발생 ${dataVo.stat01}건"/></p>

        <c:set var="onOff" value="off" />
        <c:if test="${dataVo.stat02 gt 0 or dataVo.stat03 gt 0}">
            <c:set var="onOff" value="on" />
        </c:if>
        <p><img src="/resources/monitor/images/icon/error02_${onOff}.png" alt="장애조치중 ${dataVo.stat02}건"/></p>

        <c:set var="onOff" value="off" />
        <c:if test="${dataVo.stat01 eq 0 and dataVo.stat02 eq 0 and dataVo.stat03 eq 0}">
            <c:set var="onOff" value="on" />
        </c:if>
        <p><img src="/resources/monitor/images/icon/error03_${onOff}.png" alt="장애없음"/></p>
    </div>

    <div class="deshboard_list">
        <h5>${param.q_title}</h5>
        <div class="graph_detail_text">
            <table class="graph_kind">
            <colgroup>
                <col width="50" />
                <col width="" />
                <col width="" />
                <col width="" />
                <col width="" />
                <col width="" />
            </colgroup>
            <tbody>
            <c:if test="${not empty dataList}">
                <tr>
                    <th></th>
                    <th>사이트명</th>
                    <th>IP : PORT</th>
                    <th>오류상태</th>
                    <th>처리상태</th>
                    <th>발생시각</th>
                </tr>
            </c:if>
            <c:forEach items="${dataList}" var="dataVo" varStatus="status">
            <c:set var="icon_idx" value="${status.count % 8}" />
                <tr>
                    <td><img src="/resources/monitor/images/contents/statistics_color_0${icon_idx}.gif" alt="" /></td>
                    <td class="">${dataVo.title}</td>
                    <td class="">${dataVo.label} : ${dataVo.label1}</td>
                    <td class="tx_blue">
                        <span class="tx_red">
                            <c:choose>
                                <c:when test="${dataVo.stat01 > 1}">
                                    재발(${dataVo.stat01}회)
                                </c:when>
                                <c:otherwise>
                                    신규
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span id="attrRes" class="attrNm">${dataVo.label3}</span>
                        <div id="attrResTip" class="attrNmTip" style="display:none;">
                            <c:choose>
                                <c:when test="${not empty dataVo.statDesc}">
                                    URL : ${dataVo.value}
                                    <br /><br />
                                    <op:nrToBr content="${dataVo.statDesc}" />
                                </c:when>
                                <c:otherwise>
                                    등록된 내용이 없습니다.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${dataVo.label2 eq '1010'}"><span class="tx_red">미배정</span></c:when>
                            <c:when test="${dataVo.label2 eq '1020'}"><span class="tx_blue_l">배정</span></c:when>
                            <c:when test="${dataVo.label2 eq '1030'}"><span class="tx_green">처리중</span></c:when>
                            <c:when test="${dataVo.label2 eq '1040'}">완료</c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                    </td>
                    <td>${dataVo.statDate}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty dataList}">
                <tr><td colspan="6"><span style="color:#3863BC;font-size:14px;font-weight:bold;">금일 장애발생 내역이 없습니다.</span></td></tr>
            </c:if>
            </tbody>
            </table>
        </div>
    </div>
