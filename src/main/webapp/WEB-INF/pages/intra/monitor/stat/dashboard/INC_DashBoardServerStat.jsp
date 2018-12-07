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
	
	<h5>${param.q_title}</h5>    

    <table cellspacing="0" border="0" summary="사이트명, 미배정, 배정, 처리중, 완료 목록입니다." class="boardList">
        <colgroup>
            <col width=""/>
            <col width="12%"/>
            <col width="12%"/>
            <col width="12%"/>
            <col width="12%"/>
        </colgroup>
        <thead>
            <tr>
                <th>사이트명</th>
                <th>미배정</th>
                <th>배정</th>
                <th>처리중</th>
                <th class="lr_none">완료</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${dataList}" var="dataVo" varStatus="status">
                <tr>
                    <td>${dataVo.title}</td>
                    <td>${dataVo.stat01}</td>
                    <td>${dataVo.stat02}</td>
                    <td>${dataVo.stat03}</td>
                    <td class="lr_none">${dataVo.stat04}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

