<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>파일 정보 수정</title>

    <op:jsTag type="spi" items="jquery, form, validate" />

    <script type="text/javascript">

        $().ready(function() {

            $("#dataForm").validate({
                rules: {
                    orderNo: {required: true, number: true},
                    localNm: {required: true}
                },
                submitHandler: function(form) {
                    $(form).ajaxSubmit({
                        dataType : "json",
                        success  : function(response) {
                            jsJsonBox(response, "순번을 수정한경우 화면을 새로 고침을 해야 합니다.");
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

    <form name="dataForm" id="dataForm" method="post" action="/component/file/ND_fileUpdate.do">

    <table class="boardList">
        <colgroup>
            <col width="60" />
            <col width="200" />
            <col width="" />
        </colgroup>
        <tr>
            <th>순번</th>
            <th>파일명</th>
            <th>파일설명</th>
        </tr>
        
        <tbody>
        <c:forEach items="${dataList}" var="fileVo" varStatus="status">
            <tr>
                <td>
                    <input type="hidden" name="fileId" id="fileId" value= "${fileVo.fileId}"/>
                    <input type="text" name="orderNo" id="orderNo" value= "${fileVo.orderNo}" style="width:30px;text-align:right;"/>
                </td>
                <td>
                    <input type="text" name="localNm" id="localNm" value= "${fileVo.localNm}" style="width:150px;text-align:right;" />.${fileVo.fileExt}
                </td>
                <td>
                    <textarea name="fileDesc" id="fileDesc" style="width:95%;height:50px;">${fileVo.fileDesc}</textarea>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty dataList}">
            <op:no-data obj="${dataList}" colspan="3" />
        </c:if>
        </tbody>
    </table>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="submit" value="수정" class="w_blue" /></li>
            <li><input type="reset" value="취소" class="blue" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

    </form>

</body>
</html>