<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<div class='mar_t20'>
    <h5>
        <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' />
        <span class='tx_red'><c:out value='${searchVo.startDateFmt}'/> ~ <c:out value='${searchVo.endDateFmt}'/></span>까지 분석된 접속통계입니다.
    </h5>
    <div id='_stackedBar' class='mar_t20 mar_b30'></div>
</div>