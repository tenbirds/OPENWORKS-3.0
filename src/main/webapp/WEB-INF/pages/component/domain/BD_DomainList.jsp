<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>사이트 관리</title>

    <op:jsTag type="spi" items="validate, form, ui" />
    <op:jsTag type="openworks" items="validate" />

    <script type="text/javascript">
    //<CDATA[[

        var jsInsertDomainForm = function() {
            $('#treeDetailDiv').load("INC_InsertDomainForm.do", function(data) {
            });
        };

        var jsUpdateDomainForm = function(domainCd) {
            $('#treeDetailDiv').load("INC_UpdateDomainForm.do", {
                domainCd : domainCd
            }, function(data) {
            });
        };
        /** 담당자정보 삭제 */
        var jsClearChargeInfo = function() {
            $("#chargeDeptNm").val("");
            $("#chargerNm").val("");
            $("#chargerId").val("");
            $("#chargeDeptCode").val("");
        }

    //]]>
    </script>

</head>

<body>
    <div class="buser">
        <!-- 사이트 목록 -->
        <div class="b_list">
            <div class="tree_tit">사이트 목록</div>
            <div class="panel" id="BoxList" style="height: 350px;">
                <ul class="panList">
                    <c:forEach items="${dataList}" var="domainVo" varStatus="status">
                        <li><a href="javaScript:jsUpdateDomainForm('${domainVo.domainCd}');"> ${domainVo.domainDesc} </a></li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 버튼 -->
            <div class="btn_r">
                <ul>
                    <li><button type="button" class="w_blue" onclick="jsInsertDomainForm();">등록</button></li>
                </ul>
            </div>
        </div>
        <!-- //사이트 목록 -->

        <div id="treeDetailDiv" class="b_write">
            <h4 class="tx_13">사이트 등록</h4>
            <p>사이트 명을 선택하세요.</p>
        </div>
    </div>
</body>
</html>
