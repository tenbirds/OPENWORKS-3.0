/**
 * Config 변수 선언
 */
var Config = {
    LIST_EL    : 'BoxList',
    DETAIL_EL  : 'BoxDetail',
    CURR_URL   : ''
};

/**
 * Ajax 페이지 조회
 */
var jsDetailView = function (loadElId, loadUrl, params) {
    Config.CURR_URL = loadUrl;
    $('#' + loadElId).load(loadUrl, params, function(result) {
        if ($('#searchUnit').val() === 'WEEK') {
            $('#compareBtn1').hide();
        } else if ($('#searchUnit').val() === 'MONTH') {
            $('#compareBtn1').hide();
            $('#compareBtn7').hide();
        }
        
        $("#sub_title").text($(".check_on > span").text());
        if ($.trim($("#sub_title").text()) === '' ) {
            $("#sub_title").text(links[0].text);
            $('#descArea').html(links[0].desc);
        }
        
        customerInit();
    });
};


var jsExcelView = function () {
    excelUrl = Config.CURR_URL.replace(/\.do$/, "EXCEL.do");
    $("#excelForm").attr("action", excelUrl).submit();
    
};

/**
 * Left 링크 목록 생성
 */
var setBoxList = function () {

    // 리스트 생성
    $('#' + Config.LIST_EL + ' .panList').html('');
//   alert(links.length);
        var htmlStr = '';
        for (var i = 0; i < links.length; i++) {

            htmlStr += '<li>';
            htmlStr += '    <span class="tx_b cs_pointer" link="' + links[i].link + '" idx="' + i + '">' + links[i].text + '</span>';
            htmlStr += '</li>';
        }
//alert(Config.LIST_EL);
        $('#' + Config.LIST_EL + ' .panList').html(htmlStr);
        
    

    // 이벤트 생성
    $('#' + Config.LIST_EL + ' > ul > li').hover(
           function () {
            if (!$(this).hasClass('check_on')) {
                $(this).addClass('check_click');
            }
        },
        function () {
            $(this).removeClass('check_click');
        }
    );
    $('#' + Config.LIST_EL + ' > ul > li').find('span.tx_b').click(function () {
        $(this).parent().parent().find('li').removeClass('check_on');
        $(this).parent().addClass('check_on');
        jsDetailView(Config.DETAIL_EL, $(this).attr('link'), getSearchData());
        $('#descArea').html(links[$(this).attr('idx')].desc);
    });


};


/**
 * Onload Event
 */
$(document).ready(function () {
    setBoxList();
    jsDetailView(Config.DETAIL_EL, links[0].link, {});

});

/**
 * 검색버튼 Event
 */
var search = function() {
    //alert();
    var checkCompareSearch = function() {
        
        if ($('#searchUnit').val() === 'WEEK') {
            if ($('#compareFlag').val() === '1') {
                $('#compareFlag').val('7');
            }
        } else if ($('#searchUnit').val() === 'MONTH') {
            if ($('#compareFlag').val() === '1' || $('#compareFlag').val() === '7') {
                $('#compareFlag').val('30');
            }
        }  
    };
    checkCompareSearch();
    jsDetailView(Config.DETAIL_EL, Config.CURR_URL, getSearchData());

};

/**
 * 비교버튼 클릭 Event
 */
var compareSearch = function(flag) {
  $('#compareFlag').val(flag);
  search();
};


/**
 * 페이지 이동
 */
var jsMovePage = function(pageNo) {
    var p = 1;
    if (pageNo == 'page') {
        p = $('input[name=page]').val();
    } else {
        p = pageNo;
    }
    
    jsDetailView(Config.DETAIL_EL, Config.CURR_URL, getSearchData(p));
};

/**
 * datepicker 초기화
 */
var initCalendar = function() {
    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
    
    $('#startDate').datepicker({
        showOn : 'button',
        defaultDate : null,
        buttonImage : CTX_PATH + '/resources/openworks/theme/default/images/icon/icon_cal.gif',
        buttonImageOnly : true,
    });
    $('#endDate').datepicker({
        showOn : 'button',
        defaultDate : null,
        buttonImage : CTX_PATH + '/resources/openworks/theme/default/images/icon/icon_cal.gif',
        buttonImageOnly : true,
    });
    
    var getDateStr = function(date) {
        var set2Str = function(vl) {
            return parseInt(vl,10) > 9 ? vl : '0' + vl;
        };
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };
    
    var getCalDate = function(date, months, days) {
        var newDate = date;
        if (typeof(date.getDate) != 'function') {
            newDate = new Date();
        }

        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);

        return newDate;

    };
    
    $("#d-0").click(function() {
        var today = new Date();
        $('#endDate').val(getDateStr(today));
        $('#startDate').val(getDateStr(today));
    });
    $("#d-1").click(function() {
        var today = new Date();
        $('#endDate').val(getDateStr(today));
        $('#startDate').val(getDateStr(getCalDate(today, 0, -1)));
    });
    $("#d-7").click(function() {
        var today = new Date();
        $('#endDate').val(getDateStr(today));
        $('#startDate').val(getDateStr(getCalDate(today, 0, -6))); // -6일을 계산해야 7일이 조회됨
    });
    $("#m-1").click(function() {
        var today = new Date();
        $('#endDate').val(getDateStr(today));
        $('#startDate').val(getDateStr(getCalDate(today, -1, 0)));
    });
    $("#m-3").click(function() {
        var today = new Date();
        $('#endDate').val(getDateStr(today));
        $('#startDate').val(getDateStr(getCalDate(today, -3, 0)));
    });
    
/*
            $("span.mar_l10  a  button.gray").click(function() {
                var sType = $(this).attr('id');
                var startDt = null;
                var endDt = null;
                switch(sType) {
                case '0' :
                    startDt = new Date();
                    $('#startDt').val(getDateStr(startDt));
                    endDt = new Date();
                    $('#endDt').val(getDateStr(endDt));
                    break;
                case '1D':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),0,1);
                    }else{
                        endDt = getCaldate2($("#startDt").val(),0,1);
                    }
                    break;
                case '7D':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),0,7);
                      }else{
                        endDt = getCaldate2($("#startDt").val(),0,7);
                      }
                    break;
                case '10D':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),0,10);
                      }else{
                        endDt = getCaldate2($("#startDt").val(),0,10);
                      }
                    break;
                case '15D':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),0,15);
                      }else{
                        endDt = getCaldate2($("#startDt").val(),0,15);
                      }
                    break;
                case '1M':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),1,0);
                      }else{
                        endDt = getCaldate2($("#startDt").val(),1,0);
                      }
                    break;
                case '3M':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),3,0);
                      }else{
                        endDt = getCaldate2($("#startDt").val(),3,0);
                      }
                    break;
                case '6M':
                    if($("#startDt").val() == getDateStr(new Date()) || $("#startDt").val() == ""){
                        endDt = getCalDate(new Date(),6,0);
                      }else{
                        endDt = getCaldate2($("#startDt").val(),6,0);
                      }
                    break;
 */    
    
};    