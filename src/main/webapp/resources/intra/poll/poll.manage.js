/*
 * 기본타입의 설문 기능 제어 스크립트
 */

//--------------------------------공통-------------------------------

    /*
     *  요청 처리
     */
    var jsRequest = function(formId, action, method) {
        $(formId).unbind("submit", null);
        $(formId).attr("onsubmit", null);
        $(formId).attr("action", action);
        $(formId).attr("method", method);
        $(formId).submit();
    };

//--------------------------------검색-------------------------------

    /*
     * 검색 버튼
     */ 
    var jsPollSearch = function() {
        var checkIdx = 0;
        var domainCd = $("#q_domainCd :selected").val();
        var openYn = $("#q_openYn :selected").val();
        var title = $("#q_title").val();
        var startDt = $("#q_startDt").val();
        var endDt = $("#q_endDt").val();

        if ("" != domainCd) checkIdx++;
        if ("" != openYn) checkIdx++;
        if ("" != $.trim(title)) checkIdx++;
        if ("" != $.trim(startDt)) checkIdx++;
        if ("" != $.trim(endDt)) checkIdx++;
        
        if(checkIdx > 0) {
            jsPollList(1);
        } else {
            alert("기본 검색조건을 1개이상 선택해야 합니다. ");
            return false;
        }
    };

    /*
     * 검색 초기화 버튼
     */
    var jsPollSearchReset = function() {
        $("#dataForm input[name=q_title]").val("");
        $("#dataForm input[name=q_startDt]").val("");
        $("#dataForm input[name=q_endDt]").val("");
        $("#dataForm select[name=q_domainCd]").val("");
        $("#dataForm select[name=q_openYn]").val("");
        
        // 검색 폼 값을 지우고 새로고침
        jsPollList(1);
    };

    /*
     *  검색 옵션 보기 토글
     */
    var jsToggleSearchOption = function (btn) {

        if ($("#SearchOptionDiv").is(":visible")){
            $("#SearchOptionDiv").slideUp(500, function(){
            });
        }else{
            $("#SearchOptionDiv").slideDown(500, function(){
            });
        }
    };

    /*
     *  검색 옵션  날짜 설정
     */
    var jsSetDay = function( smonth, sday, eday){   
        if(eval(smonth < 0)){
            $('#q_startDt').val("");
            $('#q_endDt').val("");
            return false;
        }
        sday = eval(sday) -1;
        var today = new Date();
        if($('#q_endDt').val() != ""){
            var dayVal = $('#q_endDt').val();
            if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");

            var vyear = dayVal.substring(0, 4);
            var vmonth = dayVal.substring(4, 6);
            var vday = dayVal.substring(6, 8);
            var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
            $('#q_startDt').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() - eval(smonth), sDay.getDate() - eval(sday)));
        }else if($('#q_startDt').val() != ""){
            var dayVal = $('#q_startDt').val();
            if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");

            var vyear = dayVal.substring(0, 4);
            var vmonth = dayVal.substring(4, 6);
            var vday = dayVal.substring(6, 8);
            var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
            $('#endDtVal').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() + eval(smonth), sDay.getDate() + eval(sday)));
        }else{      
            $('#q_startDt').datepicker('setDate', new Date(  today.getFullYear(), today.getMonth() - eval(smonth),  today.getDate() - eval(sday)));
            $('#q_endDt').datepicker('setDate', new Date( today.getFullYear(), today.getMonth(), today.getDate() - eval(eday)));
        }
    };

//--------------------------------목록 및 이동-------------------------------

    
    /*
     *  설문 목록(목록으로 갈 경우 검색용도가 아닌 모든 form 요소를 disabled 시킴) 
     */
    var jsPollList = function(page) {
        $("#dataForm").unbind("submit", null);
        if(page) 
            $("#dataForm input[name=q_currentPage]").val(page);

        $("input, select, textarea").each( 
            function() {
                $(this).attr("disabled","disabled");
            }
        );
        $("#dataForm :input[name^=q_]").each( 
            function() {
                $(this).removeAttr("disabled");
            }
        );

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
    var jsPollView = function(q_seq) {
        $("#dataForm input[name=q_seq]").val(q_seq);
        jsRequest("#dataForm", "BD_pollView.do", "get");
    };

    /*
     * 설문 등록 폼 이동
     */ 
    var jsPollInsertForm = function() {

        jsRequest("#dataForm", "BD_pollInsertForm.do", "get");
    }; 

//--------------------------------등록 / 수정-------------------------------

    /*
     *  설문 등록
     */
    var jsPollInsert = function() {

        $("#dataForm").validate({
            rules: {
                state:              { required : true },
                domainCd:          { required : true },
                title:              { required : true, rangelength : [10, 100] },
                purpose:         { required : true, rangelength : [10, 1000] },
                startTime:          { required : true, number : true, rangelength : [8, 8], 
                                    lessThen : ["#endTime", "시작일", "종료일"] },
                endTime:          { required : true, number : true, rangelength : [8, 8] },
                limitCnt:         { required : true, number : true },
                dupYn:          { required : true },
                openYn:          { required : true }
            },
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            submitHandler: function(form) {
                var dupYn = $(":radio[name=dupYn]:checked").val();
                var dupCheck = $(":radio[name=dupCheck]:checked").val();

                if(dupYn == "N" || (dupYn == "Y" && dupCheck)) {
                    form.submit();
                } else {
                    jsWarningBox("중복차단 방법을 선택해야 합니다.");
                    $("#dupCheckU").focus();
                    return false;
                }
            }
        });
    };

    /*
     *  설문 수정
     */
    var jsPollUpdate = function() {

        $("#dataForm").validate({
            rules: {
                state:              { required : true },
                domainCd:          { required : true },
                title:              { required : true, rangelength : [10, 100] },
                purpose:         { required : true, rangelength : [10, 1000] },
                startTime:          { required : true, number : true, rangelength : [8, 8], 
                                    lessThen : ["#endTime", "시작일", "종료일"] },
                endTime:          { required : true, number : true, rangelength : [8, 8] },
                limitCnt:         { required : true, number : true },
                dupYn:          { required : true, requirefrom : ["dupCheck", "Y", "중복차단방법"] },
                openYn:          { required : true }
            },
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            submitHandler: function(form) {

                /*
                var dupYn = $(":radio[name=dupYn]:checked").val();
                var dupCheck = $(":radio[name=dupCheck]:checked").val();

                if(dupYn == "N" || (dupYn == "Y" && dupCheck)) {
                 */
                form.submit();
                /*   
                } else {
                    jsWarningBox("중복차단 방법을 선택해야 합니다.");
                    $("#dupCheckU").focus();
                    return false;
                }
                */

            }
        });        

    };

    /*
     * 설문 삭제
     */
    var jsPollDelete = function() {
        
        jsRequest("#dataForm", "ND_pollDeleteAction.do", "post");
        
    };

    /*
     * 설문 그룹 / 항목 등록
     */
    var jsPollGroupInsert = function() {

        $("#dataGroupForm").validate({
            rules: {
                groupTitle:        { required : true, rangelength : [5, 100] },
                type:              { required : true },
                items:              { required : true },
                multiChoiceCnt:    { required : true, number : true },
                commentUseYn:     { required : true }
            },
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            submitHandler: function(form) {
                var multiChoiceCnt = $("#multiChoiceCnt").val();
                var commentUseYn = $(":radio[name=commentUseYn]:checked").val();

                if(multiChoiceCnt > 1 && commentUseYn == "Y") {
                    jsWarningBox("복수 선택수가 1보다 큰경우 기타의견을 사용할 수 없습니다.");
                    $("#commentUseYnN").focus();
                    return false;
                } else {
                    form.submit();
                }
            }
        });
        
    };

    /*
     * 상세  항목 등록 폼 토글 및 enabled 속성 제어(설문그룹 등록 중)
     */
    var jsAddType = function(type) {
        if(type == "C") {
            $("#addChoice").show();
            $("#addChoice :input").each(
                function() {
                    $(this).removeAttr("disabled");
                }
            );
            /*
            $("#addInput").hide();
            $("#addInput :input").each(
                function() {
                    $(this).attr("disabled", "disabled");
                }
            );
            */
        } else {
            /*
            $("#addInput").show();
            $("#addInput :input").each(
                function() {
                    $(this).removeAttr("disabled");
                }
            );
            */
            $("#addChoice").hide();
            $("#addChoice :input").each(
                function() {
                    $(this).attr("disabled", "disabled");
                }
            );
        }
    };

    /*
     *  선택형 설문의 항목 추가(설문그룹 등록 중)
     */
    var itemCnt = 2;
    var jsAddItem = function() {

        var addItemTag  = "<div id='itemDiv"+itemCnt+"'>";
            addItemTag += "<input type=\"text\" name=\"items\" id=\"items"+itemCnt+"\" value=\"\" />";
            addItemTag += " <button type=\"button\" class=\"s_blue\" onclick=\"jsDelItem('#itemDiv"+itemCnt+"');\" >삭제</button>";
            addItemTag += "</div>";

        $("#addItem").append(addItemTag);
        $("#items"+itemCnt).attr("maxlength", "100").css("width", "50%").focus();
        $("#itemDiv"+itemCnt).css("margin-top", "3px");

        itemCnt++;
    };

    /*
     *  선택형 설문의 항목 삭제(설문그룹 등록 중)
     *  @see jsAddItem
     */
    var jsDelItem = function(targetId) {

        $(targetId).remove();

    };

    /*
     * 중복허용 여부에 따른 중복체크 방법 설정 해제 
     */
    var jsDupCheck = function() {

        $("#dupYnN").click( function() {
            $(":radio[name=dupCheck]").each(
                function() {
                    $(this).removeAttr("checked").attr("disabled", "disabled");
                }
            );
        });
        
        $("#dupYnY").click( function() {
            $(":radio[name=dupCheck]").each(
                function() {
                    $(this).removeAttr("disabled", "disabled");
                }
            );
        });        
    };

    /*
     * 설문그룹 수정
     */
    function setPollGroupValidate(formId) {
        var formSeletor = "#"+formId;

        $(formSeletor).validate({
            rules: {
                groupTitle:        { required : true, rangelength : [5, 100] },
                items:              { required : true },
                multiChoiceCnt:    { required : true, number : true },
                commentUseYn:     { required : true }
            },
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            submitHandler: function(form) {
                $(form).ajaxSubmit({
                    url      : $(form).attr("action"),
                    type     : "POST",
                    dataType : "json",
                    success  : function(response) {
                        if(response.result) {
                            jsSuccessBox(response.message);
                            var multiChoiceCnt = $(formSeletor+"_multiChoiceCnt").val();
                            if(multiChoiceCnt > 1) {
                                if($(formSeletor+"_commentUseYnY").attr("checked")) {
                                    $(formSeletor+"_commentUseYnN").attr("checked", "checked");
                                    jsWarningBox("복수항목선택 가능 상태이므로 의견사용여부는 미사용으로 변경되었습니다.");
                                }
                            }
                        } else {
                            jsErrorBox(response.message);
                        }
                    },
                    error :  function(response) {
                        jsSysErrorBox(response.responseText);
                        return;
                    }
                });
            }
        });
    }

    /*
     * 설문 그룹 수정 Form에 유효성 체크 설정
     */
    var jsPollGroupModify = function() {

        $(".pollGroupForm").each(
            function() {
                setPollGroupValidate($(this).attr("id"));
            }
        );

    };

    /*
     * 설문그룹 삭제
     */
    var jsPollGroupDelete = function(seq, groupSeq) {
        
        var targetId = "#pollGroup_"+groupSeq;
        var requestUri = "ND_pollGroupDeleteAction.do";

        $.getJSON(requestUri, {seq: seq, groupSeq: groupSeq},
            function(response) {
                if(response.result) {
                    jsSuccessBox(response.message);
                    $(targetId).remove();
                } else {
                    jsErrorBox(response.message);
                }
            }
        );

        return;
    };

    
    /*
     *  단답형 답변 목록 및 기타의견 목록 팝업(colorbox)
     */
    var jsViewComment = function(targetId, seq, groupSeq, itemSeq) {

        var colorboxId = "#"+targetId+"_"+seq+"_"+groupSeq+"_"+itemSeq;
        var title = "";

        if(targetId.indexOf("short") >= 0)
            title = "단답형 응답보기";
        else
            title = "기타의견 보기";

        var link = "PD_pollCommentList.do?q_seq="+seq+"&q_groupSeq="+groupSeq+"&q_itemSeq="+itemSeq; 
        $(colorboxId).colorbox({
            title : title,
            href  : link,
            width : "600", height:"600",
            iframe : true}
        );
        
        $(colorboxId).unbind("click");
    };
