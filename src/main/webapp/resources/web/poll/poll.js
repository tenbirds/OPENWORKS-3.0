/*
 * 기본타입의 설문 기능 제어 스크립트
 */

//--------------------------------공통-------------------------------

    /*
     *  요청 처리
     */
    var jsRequest = function(formId, action, method) {
        $(formId).attr("action", action);
        $(formId).attr("method", method);
        $(formId)[0].submit();
    };


//--------------------------------검색-------------------------------

    /*
     * 검색 버튼
     */ 
    var jsPollSearch = function() {
        jsPollList(1);
    };

    /*
     * 검색 초기화 버튼
     */
    var jsPollSearchReset = function() {
        $("#dataForm input[name=q_title]").val("");
        $("#dataForm input[name=q_startTime]").val("");
        $("#dataForm input[name=q_endTime]").val("");
        
        // 검색 폼 값을 지우고 새로고침
        jsPollList(1);
    };

    /*
     *  검색 옵션 보기 토글
     */
    var jsToggleSearchOption = function (btn) {
        if ($("#Search_Option_div").is(":visible")){
            $("#Search_Option_div").slideUp(500, function(){
                $(btn).removeClass("btn-search-option-close");
                $(btn).addClass("btn-search-option");
            });
        }else{
            $("#Search_Option_div").slideDown(500, function(){
                $(btn).removeClass("btn-search-option");
                $(btn).addClass("btn-search-option-close");
            });
        }
    };

    /*
     *  검색 옵션  날짜 설정
     */
    var jsSetDay = function( smonth, sday, eday) {
        if (eval(smonth < 0)) {
            $('#q_startTime').val("");
            $('#q_endTime').val("");
            return false;
        }
        sday = eval(sday) -1;
        var today = new Date();

        if ($('#q_endTime').val() != "") {
            var dayVal = $('#q_endTime').val();
            var vyear = dayVal.substring(0,4);        
            var vmonth = dayVal.substring(4,6);
            var vday = dayVal.substring(6,8);
            var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
            $('#q_startTime').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() - eval(smonth), sDay.getDate() - eval(sday)));
        } else if ( $('#q_startTime').val() != "" ) {
            var dayVal = $('#q_startTime').val();
            var vyear = dayVal.substring(0,4);
            var vmonth = dayVal.substring(4,6);
            var vday = dayVal.substring(6,8);
            var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
            $('#q_endTime').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() + eval(smonth), sDay.getDate() + eval(sday)));
        } else {
            $('#q_startTime').datepicker('setDate', new Date(  today.getFullYear(), today.getMonth() - eval(smonth),  today.getDate() - eval(sday)));
            $('#q_endTime').datepicker('setDate', new Date( today.getFullYear(), today.getMonth(), today.getDate() - eval(eday)));
        }
        
    };    

    
//--------------------------------목록 및 이동-------------------------------

    
    /*
     *  설문 목록
     */
    var jsPollList = function(page) {
        $("#dataForm").unbind("submit", null);
        if(page) 
            $("#dataForm input[name=q_currentPage]").val(page);
        jsRequest("#dataForm", "BD_pollList.do", "get");

        return false;
    };

    /*
     * 페이지당 목록 수 변경
     */
    var jsRppReset = function() {
        jsPollList(1);
    };

    /*
     *  설문 상세 보기
     */
    var jsPollView = function(seq) {
        $("#dataForm input[name=q_seq]").val(seq);
        jsRequest("#dataForm", "BD_pollView.do", "get");
    }; 

    /*
     *  설문 결과 보기
     */
    var jsPollResult = function(seq) {
        $("#dataForm input[name=q_seq]").val(seq);
        jsRequest("#dataForm", "BD_pollResult.do", "get");
    }; 

//-------------------------------- 등록 -------------------------------

    /*
     *  설문 등록
     */
    var jsPollResponse = function() {

        $("#dataForm").validate({
            rules: {
                domainCd:          { required : true }
            },
            errorPlacement: function(error, element) {
                if ( element.attr("name") == "purpose" ) {
                    error.insertBefore(element.parent());
                }
                else {
                    error.insertAfter(element);
                }
            },
            submitHandler: function(form) {
                form.submit();
            }
        });
    };

//----------------------------------- 설문 팝업 ----------------------------------

    /*
     *  단답형 답변 목록 및 기타의견 목록 팝업(colorbox)
     */
    var jsViewComment = function(targetId, seq, groupSeq, itemSeq) {
        var title = "";
        if(targetId.indexOf("short") >= 0)
            title = "단답형 응답보기";
        else
            title = "기타의견 보기";
        var link = "PD_pollCommentList.do?q_seq="+seq+"&q_groupSeq="+groupSeq+"&q_itemSeq="+itemSeq; 

        $.fn.colorbox({
            open  : true,
            title : title,
            href  : link,
            width : "600", height:"600",
            iframe : true
        });
    };
    