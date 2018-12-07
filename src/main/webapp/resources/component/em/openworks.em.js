
/**
 * 지정 날짜 설정
 */
var jsSetDay = function( smonth, sday, eday){   
    if(eval(smonth < 0)){
        $('#q_startDate').val("");
        $('#q_endDate').val("");
        return false;
    }
    sday = eval(sday) -1;
    var today = new Date();
    if($('#q_endDate').val() != ""){
        var dayVal = $('#q_endDate').val();
        if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");

        var vyear = dayVal.substring(0, 4);
        var vmonth = dayVal.substring(4, 6);
        var vday = dayVal.substring(6, 8);
        var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
        $('#q_startDate').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() - eval(smonth), sDay.getDate() - eval(sday)));
    }else if($('#q_startDate').val() != ""){
        var dayVal = $('#q_startDate').val();
        if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");

        var vyear = dayVal.substring(0, 4);
        var vmonth = dayVal.substring(4, 6);
        var vday = dayVal.substring(6, 8);
        var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
        $('#endDtVal').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() + eval(smonth), sDay.getDate() + eval(sday)));
    }else{      
        $('#q_startDate').datepicker('setDate', new Date(  today.getFullYear(), today.getMonth() - eval(smonth),  today.getDate() - eval(sday)));
        $('#q_endDate').datepicker('setDate', new Date( today.getFullYear(), today.getMonth(), today.getDate() - eval(eday)));
    }
};


/*
 * 검색 옵션 보기 토글
 */
var jsToggleSearchOption = function(btn){
    if($("#SearchOptionDiv").is(":visible")){
        $("#SearchOptionDiv").slideUp(500, function(){
            $("#q_startDate").val("");
            $("#q_endDate").val("");
        });
    }else{
        $("#SearchOptionDiv").slideDown(500, function(){
        });
    }
};

/*
 * 처리 완료시 발송될 메시지 미리 보기
 */
var jsMessageView = function() {
    var messageSeqNo = $("#messageSeqNo").val();
    if(messageSeqNo) {
        $.colorbox({
            title : "메시지 보기",
            href  : "/component/em/config/BD_MessageForm.do?q_messageSeqNo="+messageSeqNo,
            width : "100%" ,height:"100%",
            iframe: true
       });
    }
};

/*
 * 텝 클릭시 엑션 
 */
var jsErrorTabList = function(uri, code) {
    $("#q_errorProcStatus").val(code);
    $("#q_currPage").val(0);
    jsList(uri);
};

/*
 * 사용자별 오류 상세 목록
 */
var jsErrorDetlList = function(errorNo) {

    var url = "BD_ErrorDetlList.do?q_errorNo="+errorNo;
    var winName = "ERROR_DETL";

    window.open(url, winName, "menubar=no, status=no, toolbar=no, resizable=yes, scrollbars=yes");
};

