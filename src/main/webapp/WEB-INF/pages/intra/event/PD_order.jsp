<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title></title>
    <op:jsTag type="spi" items="validate,ui,form"/>
    <script type="text/javascript">
    $().ready(function () {

        $("#dataForm").validate({
            submitHandler: function(form) {
                    var seqs = '';
                    var domainCds = $('select[name="domainCd"] option:selected').val();
                    $("select option.sa").each(function (i) {
                        seqs += ',' + $(this).attr('eventSn');
                    });
                    $(form).ajaxSubmit({
                        url      : "ND_orderUpdate.do",
                        type     : "POST",
                        data     : {seqs : seqs.substring(1),
                                    domainCds : domainCds
                                    },
                        success  : function(response) {
                            jsSuccessBox(response);
                            parent.$.fn.colorbox.close();
                        },
                        error :  function(response) {
                            jsSysErrorBox(response.responseText);
                            return;
                        }
                    });
            }
        });
    });

    var jsSelect = function(){
        if($('select[name="eventTyCd"] option:selected').val() == ''){
            jsWarningBox("이벤트타입을 선택해주세요");
            return false;
        }
        if($('select[name="domainCd"] option:selected').val() == ''){
            jsWarningBox("사이트를 선택해주세요");
            return false;
        }
                $(".blue_box_tx").html("");
        $.ajax({

            url: 'INC_orderList.do',
            dataType:    "json",
            type     : "POST",
            data: {
                eventTyCd : $('select[name="eventTyCd"] option:selected').val(),
                domainCd : $('select[name="domainCd"] option:selected').val()

            },
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function(json) {
                for(var i=0; i < json.length; i++){
                    var jsonVal = json[i];
                    var domainHtml = liHtml(jsonVal.eventTitle,jsonVal.domainCd,jsonVal.eventSortNo,jsonVal.eventSn,jsonVal.gubun);
                    $(".blue_box_tx").append(domainHtml);
                }
            }
        });

    };
    var liHtml = function(eventTitle,domainCd,eventSortNo,eventSn,gubun){
        var gbn = '';
        if(gubun == '1'){
            gbn = '진행중';
        }else{
            gbn = '대기중';
        }
        var domainHtml = '';
            domainHtml += '<option class="sa" domainCd="'+domainCd+'" eventSortNo="'+eventSortNo+'" eventSn="'+eventSn+'">['+gbn+']&nbsp;&nbsp;&nbsp;'+ eventTitle+'</option>';
        return domainHtml;
    };
    function menuMove(id,mode) {
        // mode can be  'up', 'down'
        var obj = document.getElementById(id);
        var idx = obj.selectedIndex;
        if (idx < 0) idx = obj.selectedIndex = 0;

        var opt = obj.options[obj.selectedIndex];

        switch (mode) {
            case 'up':
            if (idx > 0) obj.insertBefore(opt, obj.options[idx-1]);
            break;
            case 'down':
            if (idx < obj.options.length-1) obj.insertBefore(obj.options[idx+1], opt);
            break;
        }
    }
    </script>
</head>
<body>
<!-- 컨텐츠영역 -->
<div id="popup" style="width:600px;">
<form id="dataForm" name="dataForm">
    <fieldset>
    <legend>해당 기능구분과 사이트를 선택 하세요</legend>
    <label for="domain">※ 이벤트 구분 선택 : </label>
    <op:code id="eventTyCd" grpCd="1006" defaultValues="${param.eventTyCd}" type="select"/>
    &nbsp;&nbsp;&nbsp;
    <label for="domain">사이트 선택 : </label>
    <select id="domainCd" title="도메인을 선택해주세요" name="domainCd">
        <option value="">사이트를 선택해주세요</option>
        <c:forEach items="${dataVo}" var="_bean">
            <option value="${_bean.domainCd }">${_bean.domainDc}</option>
        </c:forEach>
    </select>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button type="button" class="blue" onclick="jsSelect();">선택</button>
    </fieldset>

    <h2 class="mar_t20">제목을 선택하신 후 <span class="tx_red">상하버튼</span>으로 위치를 변경한 후에 저장하세요.</h2>
    <select id="s" style="width:600px; overflow: auto; font-size: 16px;" size="20" class="blue_box_tx">
    </select>

<br />
    <div style="width:100%;">
    <div class="float_l">
    <a href="javascript:menuMove('s','up')"><img src="../../resources/openworks/theme/default/images/btn/btn_up.gif" alt="위로이동"/></a>
    <a href="javascript:menuMove('s','down')"><img src="../../resources/openworks/theme/default/images/btn/btn_down.gif" alt="아래로이동"/></a>
    </div>
    <div class="float_r"><a href="#"><button class="w_blue">저장</button></a></div>
    </div>
</form>
</div>
 <!-- //컨텐츠영역 -->
</body>
</html>