<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<html>
<head>
    <title>레이아웃 관리</title>

    <op:jsTag type="spi" items="validate, form" />
    <op:jsTag type="openworks" items="form" />

    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.js" />"></script>

    <script type="text/javascript">
    //<CDATA[[

        $().ready(function() {

            $("#dataForm").validate({
                rules: {
                    domainCd : { required : true, range : [1,40]},
                    layoutCode : { required: true, alphabetic: true, nowhitespace: true, minlength: 3, maxlength: 20 },
                    layoutDesc : { required: true, minlength: 6, maxlength: 20 },
                    layoutContent : { required: true }
                },
                submitHandler: function(form) {
                    $(form).ajaxSubmit({
                        url      : "ND_InsertLayoutAction.do",
                        type     : "post",
                        dataType : "json",
                        success  : function(response) {
                            if (response.result) {
                                jsSuccessBox(response.message);
                                jsList("BD_LayoutList.do","dataForm");
                            } else { 
                                jsErrorBox(response.message);
                            }
                        }
                    });
                }
            });
        });

    //]]>
    </script>
</head>

<body>

    <form id="dataForm" name="dataForm" method="post" action="ND_InsertLayoutAction.do">

        <input type="hidden" name="q_domainCd" id="q_domainCd" value="${dataVo.domainCd}" />

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
                <select name="domainCd" id="domainCd" class="select">
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
                <th>레이아웃코드</th>
                <td>
                    <input type="text" id="layoutCode" name="layoutCode" maxlength="20" value="${dataVo.layoutCode}" />
                    <span class="tx_blue_s">(영문 3~20 자)</span>
                </td>
            </tr>

            <tr>
                <th>레이아웃명</th>
                <td>
                    <input type="text" id="layoutDesc" name="layoutDesc" value="${dataVo.layoutDesc}" maxlength="20" style="width:30%;" />
                    <span class="tx_blue_s">(6~20 자)</span>
                </td>
            </tr>

            <tr>
                <th>레이아웃내용</th>
                <td>
                    <textarea id="layoutContent" name="layoutContent" rows="25" cols="50" style="width:100%;">${dataVo.layoutContent}</textarea>
                </td>
            </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="submit" value="등록" class="w_blue" /></li>
                <li><input type="button" value="목록" class="blue" onclick="jsList('BD_LayoutList.do','dataForm');" /></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>