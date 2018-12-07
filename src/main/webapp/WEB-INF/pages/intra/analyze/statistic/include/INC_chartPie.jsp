<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class='mar_t20'>
    <h5>
        <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' />
        <span class='tx_red'><c:out value='${searchVo.startDateFmt}'/> ~ <c:out value='${searchVo.endDateFmt}'/></span>까지 분석된 접속통계입니다.
    </h5>
    
    
    <div id="_chartPie" class="float_l tx_c" style="width:50%;"></div>    
    
    <div class="graph_detail_text" style="width:45%;">
    
        <ul id='_chartData'>
            <c:forEach items="${dataList}" var="topData" varStatus="topList">
                <li>
                    <div class="float_l">
                        <img src="<c:url value="/resources/openworks/theme/default/images/contents/statistics_color_${topList.count }.gif"/>" alt="" class="vm" />
                        <strong>${topData.title}</strong>
                        <c:set var="title" value="${fn:split(topData.title, '>')}" />
                        <strong style="display: none;" class="_chartTitle">
                           <c:if test="${empty title[1]}">
                               <c:set var="title2" value="${fn:split(topData.title, ':')}" />
                               ${empty title2[0] ? topData.title : title2[fn:length(title2)-1]}
                           </c:if>
                           <c:if test="${not empty title[1]}">
                               ${title[fn:length(title)-1]}
                           </c:if>
                        </strong>
                    </div>
                    <div class="float_r w160">
                        <span class="tx_blue float_l">[<span class="_chartData"><c:out value="${topData.value}"/></span>]</span>
                        <span class="tx_red float_r"><c:out value="${topData.rateValue}"/>%</span>
                    </div>
                </li>
            </c:forEach>
        </ul>
    
    </div>

</div>
