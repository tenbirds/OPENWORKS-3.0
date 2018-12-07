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
    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.common.js" />"></script>

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
                        url      : "ND_UpdateLayoutAction.do",
                        type     : "post",
                        dataType : "json",
                        success  : function(response) {
                            if (response.result) {
                                jsSuccessBox(response.message);
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

    <form id="dataForm" name="dataForm" method="post" action="ND_UpdateLayoutAction.do">

        <input type="hidden" name="q_domainCd" id="q_domainCd" value="${dataVo.domainCd}" />

        <input type="hidden" id="domainCd" name="domainCd" value="${dataVo.domainCd}" />
        <input type="hidden" id="domainNm" name="domainNm" value="${dataVo.domainNm}" />
        <input type="hidden" id="portNo" name="portNo" value="$--{dataVo.portNo}" />

        <input type="hidden" id="layoutCode" name="layoutCode" value="${dataVo.layoutCode}" />
        <input type="hidden" id="layoutPreviewUrl" value="<c:url value="/intra/cms/layout/PD_LayoutPreView.do"/>" />

        <table class="boardWrite" summary="레이아웃 등록" >
            <caption class="title">레이아웃 정보</caption>
            <colgroup>
                <col width="20%"/>
                <col width="80%" />
            </colgroup>
            <tbody>
            <tr>
                <th>사이트명</th>
                <td>${dataVo.domainNm} (사이트코드 : ${dataVo.domainCd})</td>
            </tr>
            <tr>
                <th>레이아웃코드</th>
                <td>
                    ${param.layoutCode}
                    <button type="button" class="s_blue" onclick="jsLayoutPreview();">미리보기</button>
                </td>
            </tr>
            <tr>
                <th>레이아웃명</th>
                <td>
                    <input type="text" id="layoutDesc" name="layoutDesc" value="${dataVo.layoutDesc}" maxlength="20" class="text" style="width:30%;" />
                    <span class="tx_blue_s">(6~20 자)</span>
                </td>
            </tr>
            <tr>
                <th>레이아웃내용</th>
                <td>
                    <textarea id="layoutContent" name="layoutContent" rows="25" cols="50" style="width:100%;"><c:out value="${dataVo.layoutContent}" /></textarea>
                </td>
            </tr>
            </tbody>
        </table>


        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><input type="submit" value="수정" class="w_blue" /></li>
                <li><input type="button" value="목록" class="blue" onclick="jsList('BD_LayoutList.do','dataForm');" /></li>
            </ul>
        </div>

    </form>

</body>
</html>