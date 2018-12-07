/*
 * 공통 초기화 기능
 */
$(document).ready(function() {

    /* 화면 다시 로드 */
    $("#op-gb-reload").click(function() {
        self.location.reload();
    });

    /* 화면 인쇄 */
    if($().printPreview) {
        $("#op-gb-print").printPreview();
    }

    /* 관심 목록 */
    $("#op-gb-interest").click(function () {
        $(this).colorbox({
            title : '즐겨찾기등록'
           ,href  : "/intra/interestlink/PD_iLinkAddForm.do?link=" + link
           ,width : "400" ,height:"300"
           ,iframe: true
        });
    });

    /* 도움말 보기 */
    $("#op-gb-help").click(function () {
        $El = $(this);
        $('#helpDiv').slideToggle(250, function() {
            $('#helpLink').blur();
        });
    });

});

/** 관리자단 테마 적용 */
var jsChangeAdminTheme = function() {
    var currentTheme = Config.global.adminTheme;
    var href = currentTheme + "/css/openworks_all.css";
    var cssLink = $('<link href="'+href+'" type="text/css" rel="Stylesheet" class="ui-theme" />');

    $("head").append(cssLink);
};

/** 사용자단 테마 적용 */
var jsChangeWebTheme = function() {
    var currentTheme = Config.global.webTheme;
    var href = currentTheme + "/css/user_all.css";
    var cssLink = $('<link href="'+href+'" type="text/css" rel="Stylesheet" class="ui-theme" />');

    $("head").append(cssLink);
};

/**
 * 파일 다운이력
 */
var jsShowFileHistory = function(fileSeq, fileId) {
    var url = CTX_PATH + "/component/file/PD_fileLogList.do?fileSeq="+fileSeq+"&fileId="+fileId;
    var option = {
        href:url,
        width:"807px",
        height:"500px",
        iframe:true
    };
    $.fn.colorbox(option);
};

/**
 * 객체 속성보기 (디버깅용)
 * 예 : viewProp(대상 Object);
 */
var viewProp = function () {
    var allHtml = "";

    for (var x = 0 ; x < arguments.length ; x++) {
        var obj = arguments[x];

        var names = "<table border='1' cellspacing='1' cellpadding='1'><tr>";
        if (obj.toString().substr(0,8) === '[object ') {
            names += "<td>name</td><td>value</td></tr>";
            var arr = new Array();
            for (var name in obj) {
                arr.push(name);
            }
            arr.sort();
            for (var i = 0 ; i < arr.length ; i++) {
                var key = arr[i];
                names += "<tr><td>";
                names += key;
                names +='</td><td>' ;
                names += obj[key];
                names += '</td></tr>';
            }
            names += "</table>";
            arr = null;
        } else {
            names += "<td>value</td></tr>";
            names += "<tr><td>";
            names += obj;
            names += '</td></tr>';
        }
        allHtml += names + "<br/>";
    }

    var pop = window.open("", "viewProperty", "", "");
    pop.focus();
    pop.document.body.innerHTML = allHtml.fixed();

};