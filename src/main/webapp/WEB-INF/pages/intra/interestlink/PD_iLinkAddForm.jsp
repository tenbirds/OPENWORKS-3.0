<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>즐겨찾기 등록</title>
<op:jsTag type="spi" items="extjs,form, validate" />

<script type="text/javascript">
//<![CDATA[
    var INTEREST_LIST_URL = "";
    $().ready(function () {
        $("#iLinkForm").validate({
            rules: {
                interestDesc: { required:true, minlength:2, maxlength:30 },
                link:         { required:true, minlength:5, maxlength:200 }
            },
            submitHandler : function(form) {
                if ($('select[name=category]').val() == '신규') {
                    var newCategory = $('input[name=newCategory]').val();
                    $('select[name=category]').append('<option value="'+newCategory+'">'+newCategory+'</option>');
                    $('select[name=category]').val(newCategory);
                }

                $("#iLinkForm").ajaxSubmit({
                    url      : "ND_iLinkInsertAction.do",
                    type     : "POST",
                    async    : false,
                    success  : function (response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.insertOk);
                                parent.$('#sForm').submit();
                                parent.parent.rightPanel.location.reload();
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
            }
        });
       
        var doAjax = function (nodeEls) {
            var htmlStr = '';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<option value="'+nodeEls[i]+'">'+nodeEls[i]+'</option>';
            }
            $('select[name=category]').each(function () {
                $(this).append(htmlStr);
                $(this).val($(this).siblings('input[name=categoryH]').val());
            });
        };

        $.ajax({
            type:        "POST",
            url:         "ND_categoryList.do",
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       false,
            success:     function(data) { doAjax(data); },
            error:       function () { alert('정상적으로 처리되지 않았습니다.'); }
        });
   
    });

    // 카테고리 변경 이벤트
    var jsChangeCategory = function (el) {
        if ($(el).val() == '신규') {
            $(el).next().show();
        } else {
            $(el).next().hide();
        }
    };

 //]]>
</script>
</head>

<body>

<form id="iLinkForm" method="post" action="INC_iLinkInsertAction.do">
<table class="boardWrite">
    <colgroup>
        <col width="120px" />
        <col width="" />
    </colgroup>
    <tbody>
        <tr>
            <th>카테고리</th>
            <td class="lr_none">
                <input type="hidden" name="categoryH" />
                <select name="category" onchange="jsChangeCategory(this);">
                    <option value="">선택</option>
                    <option value="신규">신규</option>
                </select>
                <span style="display: none;" ><input type="text" name="newCategory" /></span>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td class="lr_none"><input type="text" name="interestDesc" size="20" value="" /></td>
        </tr>
        <tr>
            <th>링크</th>
            <td class="lr_none"><textarea name="link" rows="3" cols="28">${param.link}</textarea></td>
        </tr>
    </tbody>
</table>

<div class="tx_r mar_t5 mar_b5">
    <button class="blue">등록</button>
</div>
</form>

</body>
</html>