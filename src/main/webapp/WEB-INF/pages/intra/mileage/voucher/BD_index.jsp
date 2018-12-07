<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<title>마일리지 관리</title>
<op:jsTag type="spi" items="form,colorbox,highlight,ui" />
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
<script type="text/javascript">

// 	if('${param.pwdYn}' != 'Y'){
//     	self.location.href = "/intra/user/BD_pwdForm.do?title1="+ "마일리지 관리"
//     	        			+ "&title2=" + "회원 정보 조회"
//     	        			+ "&menuType=" + "R" 
//     	        			+ "&returnUrl=" + "/intra/mileage/voucher/BD_index.do";
// 	}
	
	$().ready(function() { 
	    var checkSeqNo = "${param.checkSeqNo}";
		jsMovePage('${param.q_currPage}');
		
		
	    if(checkSeqNo != ''){
	        $("input[name=ckSelect_"+checkSeqNo+"]").parent().parent().addClass("bg_blue");
	    }
	    
	    
	    if('${param.h_dateSetBtn}' == 'Y'){
	        $('#divDateSpecify').show();
	    }
	    
	    if('${param.h_dateBtnSelect}' != "" || '${param.h_dateBtnSelect}' != null){
	        $('#'+'${param.h_dateBtnSelect}').css("background-color","black");
	    }
	    
	    $('#dateSetBtn').click(function () {
	        $('#divDateSpecify').slideToggle(250, function() {
	            $(".gray").css("background-color","#979797");
	            $('#h_dateBtnSelect').val("");
	            $('#q_startDt').val(null);
		        $('#q_endDt').val(null);
	            $('#divDateSpecify').blur();
	            
	            if($('#h_dateSetBtn').val() == "" || $('#h_dateSetBtn').val() == 'N'){
	                $('#divDateSpecify').show();
	                $('#h_dateSetBtn').val('Y');
	            }else{
	                $('#divDateSpecify').hide();
	                $('#h_dateSetBtn').val('N');
	            }
	                
	        });
	    });
	    $('#q_startDt').css("ime-mode", "disabled"); 
	     
	    var clareCalendar = {
			dateFormat: 'yy-mm-dd',
            showOn : 'button',
            defaultDate : null,
            buttonImage : '/resources/openworks/theme/default/images/icon/icon_cal.gif',
            buttonImageOnly : true,
	    };
	    
	    $('#q_startDt').datepicker(clareCalendar);
	    $('#q_endDt').datepicker(clareCalendar);
	    $('#q_startDt').css("ime-mode", "disabled"); 
	    $('#q_endDt').css("ime-mode", "disabled"); 
	});
	
	// 검색조건 기간 선택시 기간 설정 화면 show
	var dateSpecify = function(){
		$('#divDateSpecify').show();
	};
	
	//날짜 버튼 선택 시
	var jsSearchDate = function(id, monthDay, num){
	    var searchDate = null;
	    if(monthDay == "month"){
	        searchDate = getCalDate(new Date(),num,0);
	    }else if(monthDay == "day"){
	        searchDate = getCalDate(new Date(),0,num);
	    }else if(monthDay == "today"){
	        searchDate = new Date();
	    }else if(monthDay == "all"){
	        $('#q_startDt').val(null);
	        $('#q_endDt').val(null);
	        dateButton(id);
	        return false;
	    }
	    dateButton(id);
	    var dateStr = setDateStr(searchDate); 
	    $('#q_startDt').val(dateStr);
	    
	    dateStr = setDateStr(new Date());
	    $('#q_endDt').val(dateStr);
	};
	
	//날짜 버튼 클릭 시 버튼색 변경
	var dateButton = function(id){
    	$(".gray").css("background-color","#979797");
    	$("#"+id).css("background-color","black");
    	$('#h_dateBtnSelect').val(id);
    };
	
	// 화면에 나타날 날짜 표시 설정 yyyy-mm-dd
	var setDateStr = function(searchDate){
	    var year = ''+searchDate.getFullYear();
	    var month = setDate(searchDate.getMonth() + 1);
	    var day = setDate(searchDate.getDate()); 
	    
	    var dateStr = year+'-'+month+'-'+day;	
	    
	    return dateStr;
	};
	
	// 숫자가 두자리가 아닌경우 앞에 앞에 0붙임
	var setDate = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
    };
    
    // 날짜 버튼 선택시 현재날짜와 선택 날짜 계산
	var getCalDate = function(date, months, days) {
	    var searchDate = date;
        if (typeof(date.getDate) != 'function') {
            searchDate = new Date();
        }
        
        searchDate.setMonth(searchDate.getMonth() + months);
        searchDate.setDate(searchDate.getDate() + days);
        
        return searchDate;

    };
    
    //숫자만 입력 받게끔 하는 함수.
	function handlerNum(obj) {
	    //입력 허용 키
	    if ((event.keyCode >= 48 && event.keyCode <= 57) ||   //숫자열 0 ~ 9 : 48 ~ 57
	        (event.keyCode >= 96 && event.keyCode <= 105) ||  //키패드 0 ~ 9 : 96 ~ 105
			 event.keyCode == 8  || event.keyCode == 46 ||    //BackSpace, Delete
			 event.keyCode == 37 || event.keyCode == 39 ||    //좌 화살표, 우 화살표
			 event.keyCode == 35 || event.keyCode == 36 ||    //End 키, Home 키
			 event.keyCode == 9  || event.keyCode == 45)    {    //Tab 키
	        event.returnValue = true;
	    }else{
	        event.returnValue = false;
	    }
	    
	    if(event.keyCode != 8){
	        var qStDate = $("#q_startDt").val();
	    	var qEnDate = $("#q_endDt").val();
	    	if(qStDate.length > 10 || qEnDate.length >10){
	    		return;
	    	}

	    	if(qStDate.length == 4){
	    		$("#q_startDt").val(qStDate+"-");
	    	}else if(qStDate.length == 7){
	    		$("#q_startDt").val(qStDate+"-");
	    	}

	    	if(qEnDate.length == 4){
	    		$("#q_endDt").val(qEnDate+"-");
	    	}else if(qEnDate.length == 7){
	    		$("#q_endDt").val(qEnDate+"-");
	    	}
	    }
	 };
    
    // 서비스권 신청정보 팝업
	var appDetailView = function(el,seq,id){
	    $(el).colorbox({
            title  : "서비스권 신청정보",
            href   : "PD_voucherAppInfo.do?seqNo=" + seq + "&userId=" + id + "&" + $("#pagingform").serialize(),
            width  : "800",
            height : "650",
            iframe : true
        });
	};
	
	// 서비스권 발송 처리 상태 팝업
	var sndStatusView = function(el,seq,id){
	    $(el).colorbox({
            title  : "서비스권 발송 처리 상태",
            href   : "PD_voucherSndStatus.do?seqNo=" + seq + "&userId=" + id + "&" + $("#pagingform").serialize(),
            width  : "750",
            height : "650",
            iframe : true
        });
	};
	
	// 서비스권 지급 기준 설정 팝업
	var jsSetVoucherGive = function(el,userId, userNm) {
        $(el).colorbox({
            title  : "서비스권 지급 기준",
            href   : "PD_voucherGiveList.do",
            width  : "800",
            height : "700",
            iframe : true
    	});
	};
	
	// 선택승인 Action 
	var jsSelectApp = function(){
	    if(!updateChk()){
	        return false;
	    }
	    
	    var seqNoArray = [];
	    var userIdArray = [];
	    var userNmArray = [];
	    var reqAmountArray = [];
	    
	    $('input[name^=ckSelect_]:checked').each(function(i){
	        var seqNo = $(this).val();
	        seqNoArray[i] = seqNo; 
	        userIdArray[i] = $('#userId'+seqNo).val();
	        userNmArray[i] = $('#userNm'+seqNo).val();
	        reqAmountArray[i] = $('#reqAmount'+seqNo).val();
	    });

	    $.ajax({
			type: "POST",
			url: "ND_selectAppUpdate.do",
			data: {
			    	arrSeqNos      : seqNoArray,
			    	arrUserIds     : userIdArray,
			    	arrUserNms     : userNmArray,
			    	arrReqAmount   : reqAmountArray
				  },
			success: function(response){
			    jsSuccessBox(response);
			    jsMovePage($("#pagingform input[name=q_currPage]").val());
			},
		    error :  function(response) {
		        jsSysErrorBox(response.responseText);
		        return;
	        }
		});
	};
	
	
	
	// 선택승인 선택박스 체크 유무 확인
	var updateChk = function(){
	    var str=0;
	    $('input[name^=ckSelect_]:checked').each(function(i){
	        str++;
	    });
	    if(str == 0){
	        jsWarningBox('승인 선택 박스를 체크해주세요');
	        return false;
	    }
	    return true;
	};
	
    // 검색
    var jsSearch = function(){
		var searchKey =  $("#q_searchKey option:selected").val();
        
        if(searchKey != '' && $("#q_searchVal").val() == ''){
            jsWarningBox('검색어를 입력하세요.');
            return false;
        } else if(searchKey == '' && $("#q_searchVal").val() != '' ){
            jsWarningBox('검색항목을 선택하세요');
            return false;
        } else if($('#q_startDt').val() > $('#q_endDt').val()) {
            jsWarningBox('신청일자 시작일이 종료일보다 늦습니다.');
            return false;
        }
        
        $("#form input[name=q_currPage]").val("1");
        var tabFlag = 1;
        if($('#q_tabFlag').val() != null){
            tabFlag = $('#q_tabFlag').val();
        }
        var url = getTabUrl(tabFlag);
        var target = $("#subTabDiv");
        $.ajax(
                url, 
                {
            		data : {
			                q_tabFlag       : $('#q_tabFlag').val(),
			                q_searchKey     : $("#q_searchKey").val(),
			                q_searchVal     : $("#q_searchVal").val(),
			                q_currPage      : $("#q_currPage").val(),
			                q_searchPrcType : $("#q_searchPrcType").val(),
			                q_rowPerPage    : $("#q_rowPerPage").val(),
			                pwdYn           : $("#pwdYn").val()
            			},
            		success : function(responseText, textStatus, XMLHttpRequest){
                			target.html(responseText);
           				}
        		}
        );
    };
    
    
    // 페이지 이동
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#pagingform input[name=q_currPage]").val(p);
        
        var url = getTabUrl($('#q_tabFlag').val());
        var target = $("#subTabDiv");
        
        $.ajax(
                url, 
                {
            		data : {
			                q_tabFlag       : $('#q_tabFlag').val(),
			                q_searchKey     : $("#q_searchKey").val(),
			                q_searchVal     : $("#q_searchVal").val(),
			                q_currPage      : $("#q_currPage").val(),
			                q_searchPrcType : $("#q_searchPrcType").val(),
			                q_rowPerPage    : $("#q_rowPerPage").val(),
			                pwdYn           : $("#pwdYn").val()
            			},
            		async : false,
            		success : function(responseText, textStatus, XMLHttpRequest){
                			target.html(responseText);
           				}
        		}
        );
    };
    
    // 엑셀받기
    var jsVoucherlistExcel = function(obj){
        pwdConfirm(obj
				, '서비스권 신청 리스트 엑셀 출력'
				, 'O'
				, '/intra/mileage/voucher/INC_voucherListExcel.do'
				, ''
				, ''
				, ''
				, "∬q_searchKey=${param.q_searchKey}∬q_startDt=${param.q_startDt}∬q_endDt=${param.q_endDt}∬q_searchVal=${param.q_searchVal}∬q_searchPrcType=${param.q_searchPrcType}∬q_tabFlag="+$('#q_tabFlag').val()
				, '리스트' 
				, ''
				); 
    };
    
    // 서브탭 이동 Action
    var subTabMove = function(tab){
        
        var url = getTabUrl(tab);
        //dataString = $("#form").serialize();
        var target = $("#subTabDiv");
        $.ajax(
                url, 
                {
            		data : {
            		    	q_tabFlag : $('#q_tabFlag').val(),
            			},
            		success : function(responseText, textStatus, XMLHttpRequest){
                			target.html(responseText);
                			 $('.w120').val('');
                			 $(".ds").css("background-color","#979797");
                			 $('#q_searchVal').val('');
                			 $('#q_searchPrcType').val('');
                			 $('#q_searchKey').val('');
                			 $('#divDateSpecify').hide();
           				}
        		}
        );
    };
    
    // 서브탭 변경시 URL, FLAG 셋팅
    var getTabUrl = function(tab){
        var url='INC_reqList.do';
        if(tab == 1){
            url='INC_reqList.do';
            $('#q_tabFlag').val('1');
        }else if(tab == 2){
            url='INC_appList.do';
            $('#q_tabFlag').val('2');
        }else if(tab == 3){
            url='INC_prcList.do';
            $('#q_tabFlag').val('3');
        }else if(tab == 4){
            url='INC_voucherAllList.do';
            $('#q_tabFlag').val('4');
        }
        
        return url;
    };
</script>

</head>
 
<body>
<!-- 탭 -->
<ul class="tab">
	<li><a href="<c:url value="../mng/BD_index.do" />" >마일리지 항목 설정</a></li>
	<li><a href="<c:url value="../read/BD_index.do" />">회원 마일리지 조회</a></li>
	<li><a href="<c:url value="../status/BD_index.do" />">마일리지 통계</a></li>
	<li><a href="<c:url value="../voucher/BD_index.do" />" class="on">서비스권 신청</a></li>
</ul>
<!-- //탭 -->

<!-- <div style="position:absolute; top:2px; right:0; float:right; text-align: right;"> -->
<!-- 		</div> -->
		

<form name="form" id="form" method="post" action="BD_index.do">
	<input type="hidden" id="pwdYn" name="pwdYn" value="${param.pwdYn}"/>
	<input type="hidden" id="h_dateSetBtn" name="h_dateSetBtn" value="${param.h_dateSetBtn}"/>
	<input type="hidden" id="h_dateBtnSelect" name="h_dateBtnSelect" value="${param.h_dateBtnSelect}"/>
	
	<div style="right:0; float:right; text-align: right;" >
		<button type="button" onclick="jsSetVoucherGive(this);" class="s_blue mar_b5" >서비스권지급기준</button>
		<button type="button" onclick="jsVoucherlistExcel(this);" class="s_blue mar_b5" > 엑셀출력</button>
<!-- 		<button type="button" class="s_blue mar_b5"  -->
<%-- 		                              onclick="pwdConfirm(this --%>
<!-- 											, '서비스권 신청 리스트 엑셀 출력' -->
<!-- 											, 'O' -->
<!-- 											, '/intra/mileage/voucher/INC_voucherApplistExcel.do' -->
<!-- 											, '' -->
<!-- 											, '' -->
<!-- 											, '' -->
<%-- 											, '∬q_searchKey=${param.q_searchKey}∬q_startDt=${param.q_startDt}∬q_endDt=${param.q_endDt}∬q_searchVal=${param.q_searchVal}∬q_searchPrcType=${param.q_searchPrcType}∬q_tabFlag=${param.q_tabFlag}' --%>
<!-- 											, '리스트'  -->
<!-- 											, '' -->
<%-- 											);"> 엑셀출력 --%>
<!-- 	    </button> -->
    </div>
	<!-- 검색 -->
	<div class="search">
		<fieldset>
			<legend>조건을 선택하여 검색하세요.</legend>
			<div class="tx_c" style="position: relative;">
				<span id="searchPrcTypeSpan">
				<op:code id="q_searchPrcType" grpCd="69" type="select" defaultValues="${param.q_searchPrcType}" defaultLabel="-- 승인여부 --"/>
				</span>
				<op:code id="q_searchKey" grpCd="82" type="select" defaultValues="${param.q_searchKey}" />
				<span id="selectAll">
					<input class="w215" type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" title="검색어를 입력하세요." />
				</span>
				<button type="button" onclick="jsSearch();" class="gray mar_l5 mar_b5">검색</button>
			</div>
		</fieldset>
        
    	<!-- 신청일자-->
    	<div class="tx_c" style="margin:12px 0;">
    		<span class="tx_b">신청일자</span>
    		<button type="button" id="0" onclick="jsSearchDate(this.id,'today',0);" class="gray ds">당일</button>
    		<button type="button" id="1D" onclick="jsSearchDate(this.id,'day',-1);" class="gray ds">전일</button>
    		<button type="button" id="7D" onclick="jsSearchDate(this.id,'day',-7);" class="gray ds">7일</button>
    		<button type="button" id="10D" onclick="jsSearchDate(this.id,'day',-10);" class="gray ds">10일</button>
    		<button type="button" id="15D" onclick="jsSearchDate(this.id,'day',-15);" class="gray ds">15일</button>
    		<button type="button" id="1M" onclick="jsSearchDate(this.id,'month',-1);"class="gray ds">1개월</button>
    		<button type="button" id="3M" onclick="jsSearchDate(this.id,'month',-3);" class="gray ds">3개월</button>
    		<button type="button" id="6M" onclick="jsSearchDate(this.id,'month',-6);" class="gray ds">6개월</button>
    		<button type="button" id="ALL" onclick="jsSearchDate(this.id,'all');" class="gray ds">전체</button>
    		<button type="button" class="s_blue" id="dateSetBtn" name="dateSetBtn" value="${param.dateSetBtn}">기간지정</button>
    	</div>
        
    	<div id="divDateSpecify" class="tx_c" style="display: none;">
    		<fieldset>
    			<legend>신청일자</legend>
    			<label><span class="tx_b">신청일자</span></label>
    			<input class="w120" type="text" name="q_startDt" id="q_startDt" maxlength="10" onkeydown="handlerNum(this);" value="${param.q_startDt}" title="시작날짜선택"/>
    			<input class="w120" type="text" name="q_endDt" id="q_endDt" maxlength="10" onkeydown="handlerNum(this);" value="${param.q_endDt}" title="종료날짜선택"/>
    		</fieldset>
    	</div>
    	<!-- //검색일자-->
	</div>
	<!-- //검색 -->
	
	
	<ul class="tab_s">
		<li id="subTab1" <c:if test="${tabFlag eq '1' or empty tabFlag}">class="on"</c:if>><a href="#" onclick="subTabMove(1);">서비스권 승인</a></li>
		<li id="subTab2"><a href="#" onclick="subTabMove(2);">서비스권 발송</a></li>
		<li id="subTab3"><a href="#" onclick="subTabMove(3);">서비스권 신청 결과</a></li>
		<li id="subTab4"><a href="#" onclick="subTabMove(4);">전체</a></li>
	</ul>
	<div class="clear"></div>
	<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
	
</form>
<form name="pagingform" id="pagingform" method="post" >
	<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
	<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
	<input type="hidden" name="q_currPage" id="q_currPage"value="${param.q_currPage}" />
	<input type="hidden" name="q_searchPrcType" value="${param.q_searchPrcType}" />
	<input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
	<input type="hidden" name="pwdYn" value="${param.pwdYn}"/>
	<input type="hidden" id="q_tabFlag" name="q_tabFlag" value="${param.q_tabFlag }" />
</form>
<div id="subTabDiv">

</div>
</body>
</html>