<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<%@ page import="java.util.*" %>
<%@ page import="zes.core.spi.oscache.ICache" %>
<%@ page import="zes.core.spi.oscache.CacheFactory" %>
<%@ page import="org.springframework.util.ClassUtils" %>

<%
    Map<Class<?>, ICache> chacheMap = CacheFactory.getMap();
    Iterator<Class<?>> keys = chacheMap.keySet().iterator();
%>

<html>
<head>
    <title>캐시 새로고침</title>

    <op:jsTag type="spi" items="form, validate" />

    <script type="text/javascript">
        $(document).ready(function(){
            $("#dataForm").validate({
                rules: {
                    domainCd: { required: true },
                    cacheName: { required: true }
                },
                submitHandler: function(form) {

                    $(form).ajaxSubmit({
                        url      : "ND_ReloadAction.do",
                        type     : "POST",
                        dataType : "json",
                        success  : function(response) {
                            if (response.result) {
                                jsSuccessBox(response.message);
                                $("#cacheName").val("");
                            } else { 
                                jsErrorBox(response.message);
                            }
                        },
                        error :  function(response) {
                            jsSysErrorBox(response.responseText);
                            return;
                        }
                    });
                } 
            });
        });
    </script>
</head>
 
<body>

<form name="dataForm" id="dataForm">

    <div id="helpDiv" class="show">
        <ol>
            <li>시스템에 저장된 캐시 정보를 다시 로드합니다.</li>
            <li>대상 캐시정보를 선택한 후 다시 읽기 버튼을 클릭하세요.</li>
        </ol>
    </div>

    <table class="boardWrite" summary="레이아웃 등록" >
        <caption class="title">레이아웃 정보</caption>
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tbody>
        <tr>
            <th>사이트선택</th>
            <td>
            <select name="domainCd" id="domainCd" class="select" title="사이트를 선택해주세요">
                <option value="">-- 사이트 선택 --</option>
                <c:forEach items="${baseList}" var="domainVo">
                    <option value="${domainVo.domainCd}" 
                        <c:if test="${domainCd eq domainVo.domainCd}">selected="selected"</c:if>>
                        ${domainVo.domainDesc}</option>
                </c:forEach>
            </select>
            </td>
        </tr>
        <tr>
            <th>캐시선택</th>
            <td>
                <select name="cacheName" id="cacheName" class="select" title="캐시 정보를 선택해주세요">
                    <option value="">-- 캐시 정보 선택 --</option>
                <%    
                    while (keys.hasNext()) {
                        ICache cache = (ICache)chacheMap.get(keys.next());
                        String cacheClass = ClassUtils.getShortName(cache.getClass());
                %>
                    <option value="<%= cacheClass %>"><%= cache.getName() %></option>
                <%
                    }
                %>
                </select>
            </td>
        </tr>
        </tbody>
    </table>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button class="blue">다시 읽기</button></li>
        </ul>
    </div>

</form>

</body>
</html>