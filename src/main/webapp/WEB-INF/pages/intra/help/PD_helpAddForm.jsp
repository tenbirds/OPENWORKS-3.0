<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>도움말 등록</title>
    <op:jsTag type="spi" items="jquery, form, validate, colorbox" />
    <script type="text/javascript">
        $().ready(function () {

            $("#helpForm").validate({
                rules: {
                    menuCd : { required:true },
                    helpNm:   { required:true, minlength:2, maxlength:100 },
                    contents: { required:true, minlength:2, maxlength:100 }
                }
            });

            var doAjax = function (nodeEls) {
                
                var emptStr = '>>>>>';
                var htmlStr = '<option value="">메뉴를 선택하여 주세요.</option>';
                for (var i = 0; i < nodeEls.length; i++) {
                    htmlStr += '<option value="'+nodeEls[i].menuCd+'">'+emptStr.substring(1, nodeEls[i].menuLevel)+' '+nodeEls[i].menuNm+'</option>';
                }
                $('select[name=menuCd]').each(function () {
                    $(this).append(htmlStr);
                });
            };

            $.ajax({
                type:        "POST",
                url:         "INC_menuList.do",
                dataType:    "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                async:       false,
                success:     function(data) { doAjax(data); },
                error:       function () { alert('정상적으로 처리되지 않았습니다.'); }
            });
        });

        var jsSaveHelp = function () {
            if ($("#helpForm").valid() == false) return;

            $("#helpForm").ajaxSubmit({
                url      : "INC_saveHelpAction.do",
                type     : "POST",
                async    : false,
                success  : function (response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.insertOk);
                            parent.$('#sForm').submit();
                            parent.$.colorbox.close();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }
            });
        };
    </script>
</head>

<body>

<form id="helpForm">
<table class="boardWrite">
    <colgroup>
        <col width="15%"/>
        <col width=""/>
    </colgroup>
    <tbody>
        <tr>
            <th>메&nbsp; &nbsp; &nbsp; &nbsp;뉴</th>
            <td class="lr_none"><select name="menuCd" style="width: 300px"></select></td>
        </tr>
        <tr>
            <th>도움말 명</th>
            <td class="lr_none"><input type="text" name="helpNm" value="" size="93" /></td>
        </tr>
        <tr>
            <th>도움말 내용</th>
            <td class="lr_none"><textarea name="contents" rows="20" cols="70"></textarea></td>
        </tr>
    </tbody>
</table>

<div class="tx_r mar_t5 mar_b5">
    <a href="#" onclick="jsSaveHelp();"><button type="button" class="blue">등록</button></a>
</div>
</form>

</body>
</html>