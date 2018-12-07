// 현재 선택 메뉴 변수
var $currentTopMenu;

// 사용자단 공통 이벤트 설정
$().ready(function() {
    $(".usermenuColobox").colorbox();

    $(".usermenuOpen").click( function() {
        window.open($(this).attr("href"),$(this).attr("id"),'');
        return false;
    });

    $currentTopMenu = $("#currentTopMenu");
    onTopMenu($currentTopMenu);

    // 탑메뉴 헨들링
    $(".topnavi").each(function() {
        $(this).bind("mouseover focus", function() {
            offTopMenu();
            onTopMenu($(this));
/*
            $(this).next("ul").bind("mouseout blur", function() {
                offTopMenu();
                onTopMenu($currentTopMenu);
            });
*/
        });
    });
    //퀵메뉴관리
    $("#quick").load("/web/quick/ND_quickMenu.do", function(result) {
    });

});

// 메뉴 비활성화
var offTopMenu = function() {
    // 전체 비활성화
    $(".topnavi").each(function() {
        var $img = $(this).children("img");
        if($img) {
            $img.attr("src", $img.attr("src").replace("menu_on","menu_off"));
        }
        // 모든 서브 메뉴 비활성화
        var $sub = $(this).next("ul");
        if($sub.size() > 0) {
            $sub.css("display", "none");
        }
    });
};

// 메뉴 활성화
var onTopMenu = function($obj) {
    // 대상메뉴 활성화
    var $img = $obj.children("img");
    if($img && $img.attr("src")) {
        $img.attr("src", $img.attr("src").replace("menu_off","menu_on"));
    }
    // 대상 메뉴 서브 메뉴 활성화
    var $sub = $obj.next("ul");
    if($sub.size() > 0) {
        $sub.css("display", "block");
    }
};

// 화면 크기 조정
var nowZoom = 100;

function zoomOut() {
    nowZoom = nowZoom - 10;
    if(nowZoom <= 70) nowZoom = 70;
    zooms();
}

function zoomIn() {
    nowZoom = nowZoom + 10;
    if(nowZoom >= 200) nowZoom = 200;
    zooms();
}

function zoomReset(){
    nowZoom = 100;
}

function zooms(){
    $("#wrapper_all_web").css("zoom", nowZoom + "%");
}
