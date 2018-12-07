//각 페이지별 페이지 로딩시 이벤트 함수
var onReadyEventFunctions = function(){

	if(OpenWorks.pageType == "VIEW"){
		//쿠키사용 필드 구분자
		OpenWorks.gubunja = '|:|';
		jsViewProcess();

	}else if((OpenWorks.pageType == "INSERT") 
			|| (OpenWorks.pageType == "UPDATE") 
			|| (OpenWorks.pageType == "REPLY")){

		// 화면단으로 이동
		//jsFormProcess();

	}else if(OpenWorks.pageType == "LIST"){
		//카테고리 저장용
		bbsCtgAry = new Array();
		jsListProcess();

	}else{
		jsErrorBox('Error page not Initialized properly !!');
	}
};


//================== 목록 페이지 로딩 이벤트 ==================
var jsListProcess = function(){

	//검색어 하이라이팅
//	if(OpenWorks.searchVal != "" && OpenWorks.searchKey != "" ) {
//		$("#contents_area").highlight(OpenWorks.searchVal);
//	}

	//검색 옵션값이 있을 경우 검색 옵션을 보여줌
	if(OpenWorks.startDt != "" && OpenWorks.endDt != "") {
		$("#SearchOptionDiv").show();
	}

	//카테고리 체인지 이벤트
	if(OpenWorks.useCategory == "Y") {
	    SharedOpenWorks.jsChangeCategoryEvent("LIST");
	}

	//필드 정렬 효과
	SharedOpenWorks.jsSetSortEffect();

	//검색 엔터 이벤트
	jsSetSearchEnterEvent();

	//요약 보이기(갤러리일 경우 디폴트 보이게 함)
	if(OpenWorks.boardType == "GALLERY") OpenWorks.showSummaryYn = "Y";

	if(OpenWorks.showSummaryYn == "Y") {
		$("#dataForm input[name=showSummaryYn]").val("Y");
		$("div.tx_blue_s").show();
	} else {
		$("#dataForm input[name=showSummaryYn]").val("N");
		$("div.tx_blue_s").hide();
	}

	if(OpenWorks.tagYn == "Y"){
		//태그 클라우드 창
		$("#tagCloud").bind("click", {}, function() {
			$.fn.colorbox({
				open  : true,
				title : "태그 클라우드",
				href  : "PD_tagcloud.do?domainCd=" + OpenWorks.domainCd + "&bbsCd=" + OpenWorks.bbsCd,
				width : "395", height:"260",
				iframe: true
			});
		});
	}
};


//================= 폼 페이지 로딩 이벤트 ==================
var jsFormProcess = function(){

	//파일 업로드 설정
	SharedOpenWorks.jsSetMultiFile();

	//제목 입력박스 도움말
	//SharedOpenWorks.jsInputTextHelpMsg("title", "제목을 입력하세요.", 30, "red");

	//폼 설정 체크
	SharedOpenWorks.jsSetFormValidate();

	//타이틀 엔터 이벤트 금지
	jsSetTitleEnterEvent();

	//제목입력줄 선택
	window.scroll(0, 0);
	$("#bbscttSj")[0].focus();
};


//================= 뷰 페이지 로딩 이벤트 ==================
var jsViewProcess = function(){

	$("#dataForm").attr("action", "BD_board.form.do");

	//만족도 평가
	//SharedOpenWorks.jsSetScoreFormValidate();

	//코멘트 목록
	if(OpenWorks.cmtYn == "Y") {
	    jsOpenComment();
	}

	//다음글이 목록 보기일경우
	if(OpenWorks.listViewCd == "1003") {
		//검색어 하이라이팅
//		if(OpenWorks.searchVal != "" && OpenWorks.searchKey != ""){
//		    $("#contents_area").highlight(OpenWorks.searchVal);
//		}

		//카테고리 체인지 이벤트
		if(OpenWorks.useCategory == "Y") {
		    SharedOpenWorks.jsChangeCategoryEvent("VIEW");
		}

		//요약 보이기
		if(OpenWorks.showSummaryYn == "Y"){
			$("#dataForm input[name=showSummaryYn]").val("Y");
			$("div.tx_blue_s").show();
		} else {
			$("#dataForm input[name=showSummaryYn]").val("N");
			$("div.tx_blue_s").hide();
		}

		//필드 정렬 효과
		SharedOpenWorks.jsSetSortEffect();

		// 페이지 이동 버튼 엔터 이벤트
		//jsSetGoTextKeyEvent();
	}
};


//================= 목록 사용 함수 =================//

//검색 옵션 보기 토글
var jsToggleSearchOption = function(btn){
	if($("#SearchOptionDiv").is(":visible")){
		$("#SearchOptionDiv").slideUp(500, function(){
			$("#q_startDt").val("");
			$("#q_endDt").val("");
		});
	}else{
		$("#SearchOptionDiv").slideDown(500, function(){
		});
	}
};

//atom, rss 다운로드
var jsConvertAction = function(type){

	var url = OpenWorks.serverNm + "?type=" + type + "&domainCd=" + OpenWorks.domainCd + "&bbsCd=" + OpenWorks.bbsCd;

	if(window.clipboardData) {
		var copyYn = window.confirm("URL : " + url + " \n클립보드에 복사하시겠습니까?");
		if(copyYn){
			window.clipboardData.setData("Text", url);
			alert('클립보드에 URL이 복사되었습니다. ');
		}
	} else if(window.netscape) {
		alert(url, {sticky:true});

		return false;
		//브라우져의 주소창에 about:config 를 치면 해당 설정 내용이 쭉 나타나는데 
		//그 중에서 Signed.applets.codebase_principal_support 라는 부분을 찾아서 
		//true로 바꿔주면 문제없이 작동할 것이다. 

		//dit is belangrijk maar staat nergens duidelijk vermeld: 
		//you have to sign the code to enable this, or see notes below 
		netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');

		//maak een interface naar het clipboard 
		var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard); 
		if(!clip) return; 

		//maak een transferable 
		var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable); 
		if(!trans) return; 

		//specificeer wat voor soort data we op willen halen; text in dit geval
		trans.addDataFlavor('text/unicode');

		//om de data uit de transferable te halen hebben we 2 nieuwe objecten nodig om het in op te slaan
		var str = new Object();
		var len = new Object();
		var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
		var copytext=url;
		str.data=copytext;
		trans.setTransferData("text/unicode",str,copytext.length*2);

		var clipid=Components.interfaces.nsIClipboard;
		if(!clip) return false;
		clip.setData(trans,null,clipid.kGlobalClipboard); 
		alert('클립보드에 URL이 복사되었습니다. ');
	}
};

//검색 엔터 이벤트
var jsSetSearchEnterEvent = function() {
	$("#searchVal").keyup(function(event) {
		if(event.keyCode == 13) {
			$(this).next().click();
			return false;
		}
	});
};

//타이틀 엔터 이벤트 금지
var jsSetTitleEnterEvent = function() {
	$("#bbscttSj").keypress(function(event) {
		if(event.keyCode == 13){
			return false;
		}
	});
};

//요약 보기 토글
var jsSummaryShow = function(){
	if($("#dataForm input[name=showSummaryYn]").val() == "Y"){
		$("div.tx_blue_s").slideUp(200, function(){
			$("#dataForm input[name=showSummaryYn]").val("N");
		});
	}else{
		$("div.tx_blue_s").slideDown(200, function(){
			$("#dataForm input[name=showSummaryYn]").val("Y");
		});
	}
};	

//지정 날짜 설정
var jsSetDay = function(smonth, sday, eday){   
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

var jsBizSetDay = function(smonth, sday, eday){   
    if(eval(smonth < 0)){
        $('#q_bizStartDt').val("");
        $('#q_bizEndDt').val("");
        return false;
    }
    sday = eval(sday) -1;
    var today = new Date();
    if($('#q_bizEndDt').val() != ""){
        var dayVal = $('#q_bizEndDt').val();
        if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");
        
        var vyear = dayVal.substring(0, 4);
        var vmonth = dayVal.substring(4, 6);
        var vday = dayVal.substring(6, 8);
        var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
        $('#q_bizStartDt').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() - eval(smonth), sDay.getDate() - eval(sday)));
    }else if($('#q_bizStartDt').val() != ""){
        var dayVal = $('#q_bizStartDt').val();
        if(dayVal.indexOf("-") > -1) dayVal = dayVal.replace(/[-]/g, "");
        
        var vyear = dayVal.substring(0, 4);
        var vmonth = dayVal.substring(4, 6);
        var vday = dayVal.substring(6, 8);
        var sDay = new Date( Number(vyear), Number(vmonth) -1 , Number(vday));
        $('#endDtVal').datepicker('setDate', new Date( sDay.getFullYear(), sDay.getMonth() + eval(smonth), sDay.getDate() + eval(sday)));
    }else{	  
        $('#q_bizStartDt').datepicker('setDate', new Date(  today.getFullYear(), today.getMonth() - eval(smonth),  today.getDate() - eval(sday)));
        $('#q_bizEndDt').datepicker('setDate', new Date( today.getFullYear(), today.getMonth(), today.getDate() - eval(eday)));
    }
};  

//================= 목록 함수 끝 =================//	



//================= 뷰 함수 =================//	

//추천 버튼  
var jsClickRecommAction = function(btn, domainCode, bbsCode, seq, readCookieHour){
	if((timeWait = jsCheckCookieTime("recommendCookie:" + bbsCode + ":" + seq)) > 0){
		alert(Message.msg.recomAlready);
		return false;
	}

	var confirm = window.confirm(Message.msg.recomConfirm);
	if(confirm != true) return;

	$.post("ND_recom.action.do", {
	    domainCd : domainCode,
		bbsCd : bbsCode,
		bbscttSeq : seq
	}, function(result){
		if(result > 0){
			if(OpenWorks.pageType == "VIEW") {
			    $(btn).val("추천:" + result);
			} else {
			    $(btn).val("추천");
			    jsSetCookieExpTime("recommendCookie:"+bbsCode+":"+seq, readCookieHour);
			}
		}else{
			alert('지금은 추천하실 수 없습니다.');
		}
	}, 'json');
};

//신고 버튼
var jsClickAccuseAction = function(btn, domainCode, bbsCode, seq, readCookieHour){
	if((timeWait = jsCheckCookieTime("accuseCookie:" + bbsCode + ":" + seq)) > 0){
		alert(timeWait + "시간 후 다시 신고하실 수 있습니다.");
		return false;
	}
	var confirm = window.confirm("이 게시물을 신고하시겠습니까?");
	if(confirm != true) return;
	$.post("ND_accuse.action.do", {
	    domainCd : domainCode,
		bbsCd : bbsCode,
		bbscttSeq : seq
	}, function(result){
		if(result > 0){
			$(btn).val("신고:" + result);
			jsSetCookieExpTime("accuseCookie:" + bbsCode + ":" + seq, readCookieHour);
		}else{
			alert('지금은 신고하실 수 없습니다.');
		}
	}, 'json');
};

//수정폼버튼(bbsCd, bbscttSeq로 구분 refrnSeq = null)
var jsUpdateForm = function(pageType){
	$("#dataForm input[name=refrnSeq]").val("");
	$("#dataForm input[name=pageType]").val(pageType);
	
    if(OpenWorks.section == "myboardB" || OpenWorks.section == "myboard" ||  OpenWorks.section == "myboardQ" ){
        jsRequest("dataForm", "/web/board/BD_board.update.form.do", "get");
    }else if(OpenWorks.bbsCd == 1003 &&( OpenWorks.section != "myboardB" || OpenWorks.section != "myboard" ) ){
        jsRequest("dataForm", "BD_board.update.form1.do", "get");
    }else{
        jsRequest("dataForm", "BD_board.update.form.do", "get");
    }
	
};

//답글폼버튼(bbsCd, refrnSeq로 구분 bbscttSeq = null)
var jsReplyForm = function(pageType, seq){
	//$("#dataForm input[name=seq]").val("");
	$("#dataForm input[name=pageType]").val(pageType);
	//$("#dataForm input[name=refrnSeq]").val(seq);
	//alert($("#dataForm input[name=refrnSeq]").val());
	jsRequest("dataForm", "BD_board.reply.form.do", "get");
};

//삭제 버튼
var jsDelete = function(){
    if(!confirm(Message.msg.deleteConfirm)) return false;
	var msg = "상세 보기 삭제";
	$("#dataForm input[name=delDesc]").val(msg);
	
	jsRequest("dataForm", "ND_board.delete.do", "post");
};


//코멘트 열기
var jsOpenComment = function() {
    var target ;
    
    var bbsCd = $("#dataForm input[name=bbsCd]").val();
    
    if(bbsCd != 1010){
        target = $("#attachedCommentsDiv");
    }else{
        target = $("#attachedCommentsDiv2");
    }
    $.get("INC_cmt.list.do", {
        domainCd : $("#dataForm input[name=domainCd]").val(),
        bbsCd : $("#dataForm input[name=bbsCd]").val(),
        bbscttSeq : $("#dataForm input[name=bbscttSeq]").val(),
        cmtSeq : $("#dataForm input[name=cmtSeq]").val(),
        q_currPage : 1
    }, function(result) {
        target.empty();
        target.append(result);
        target.slideDown(500);
    });
};

var SharedOpenWorks = {
	//카테고리 체인지 이벤트 등록
	jsChangeCategoryEvent : function(pageType){
		if(OpenWorks.useCategory == "Y"){
			if(pageType == "LIST")
				$("#q_ctgCd").bind("change", {}, function() {jsListReq(1);});
			if(pageType == "VIEW")
				$("#q_ctgCd").bind("change", {}, function() {jsViewReq(1);});
		}
	},

	//멀티파일 업로드
	jsSetMultiFile : function(){
		if(OpenWorks.fileYn == "Y"){
		    $('#dataForm input[name=multiFiles]').MultiFile({
		           accept: OpenWorks.filePermExtsn,
		           max: OpenWorks.maxFileCnt,
		           maxfile: OpenWorks.maxFileSize, //각 파일 최대 업로드 크기
		           maxsize: OpenWorks.totalFileSize,  //전체 파일 최대 업로드 크기
		           STRING: { 
		               remove: '<img id="fileDelImg" src="' + OpenWorks.closeFileIcon + '" class="vm" />',
		               denied: '[ $ext ]'+Message.msg.fileCannotUplaod ,           //확장자 제한 문구
		               duplicate: '[ $file ]\n'+Message.msg.fileAlreadyUpload,       //중복 파일 문구
		               toomany: Message.msg.fileToomany+" : $max )"
//		             toobig: "$file 은 크기가 매우 큽니다. (max $size)",
		           },
		           list: '#multiFilesListDiv',
		           onFileRemove: function(element, value, master_element){
		           },
		           afterFileRemove: function(element, value, master_element){
		               if(eval($("#uploadFileCnt").val()) > 0)
		                   $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
		               else $("#uploadFileCnt").val(0);

		               if(eval($("#uploadFileCnt").val()) < OpenWorks.maxFileCnt   )
		                   $.fn.MultiFile.reEnableEmpty();
		               $("#fileCnt").html($("#uploadFileCnt").val());
		           },
		           onFileAppend: function(element, value, master_element){
		               $("#dataForm input[name=multiFiles]").length;
		           },
		           afterFileAppend: function(element, value, master_element){
		               if(eval($("#uploadFileCnt").val()) < 0){
		                   $("#uploadFileCnt").val(1);
		               }else{
		                   $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) + 1);
		               }

		               if(eval($("#uploadFileCnt").val()) >= OpenWorks.maxFileCnt  )
		                   $.fn.MultiFile.disableEmpty();
		               //alert($("#uploadFileCnt").val());
		               $("#fileCnt").html($("#uploadFileCnt").val());
		           },
		               onFileSelect: function(element, value, master_element){
		           },
		               afterFileSelect: function(element, value, master_element){
		           }
		           
		       });
		       //폼 파일 업로더를 초기화 시킨후, 파일 갯수가 초과시엔 디스에이블 시킨다.
		       if(OpenWorks.maxFileCnt  <= eval($("#uploadFileCnt").val())){
		           $.fn.MultiFile.disableEmpty();
		       }
		}
	},

	//입력창 도움말
	jsInputTextHelpMsg : function(id, msg, len, color){
		var element = $("#" + id);
		var msgColor = "#a9ede7";

		if($.trim(element.val()) == ""){
			 element.css("color", msgColor);	
			 element.val(msg);
		}

		element.bind("blur", {}, function(){
			if($.trim(element.val()) == ""){
				element.css("color", msgColor);
				//element.val(msg);
			}else if(length > 0 && $.trim(element.val()).length > len){
				element.val($.trim(element.val()).substring(0,len));
			}
		}).bind("focus", {}, function(){
			if($.trim(element.val()) == "" || $.trim(element.val()) == msg){
				element.css("color", color);
				element.val("");
			}
		});
	},

	//필드 정렬시 정렬효과 보여줌
	jsSetSortEffect : function(){
		if(OpenWorks.sortName != "" && OpenWorks.sortOrder != ""){
			if((OpenWorks.boardType == "GALLERY") && (OpenWorks.listShowType == "gallery")){
				$('span[id=th-'+OpenWorks.sortName+']').addClass('sorted-'+OpenWorks.sortOrder);
			}else{
				$('thead th[id=th-'+OpenWorks.sortName+']').addClass('m_over');
				$('th[id=th-'+OpenWorks.sortName+'] span').addClass('sorted-'+OpenWorks.sortOrder);
			}
		}
	}

	//scoreForm 유효성 체크 (보기페이지에서 별점수)
	//jsSetScoreFormValidate : function(){
	//	$("#scoreForm").validate({
	//		submitHandler: function(form){
	//			$(form).ajaxSubmit({
	//				url	  : "ND_score.action.do",
	//				type	 : "POST",
	//				dataType : "json",
	//				beforeSubmit : function(arr, $form, options){
	//								if((timeWait = jsCheckCookieTime("scoreCookie:" + OpenWorks.bbsCd + ":" + OpenWorks.seq)) > 0){
	//									$("#scoreForm select[name=scoreSum]").val("0");
	//									alert(timeWait + "시간 후 다시 평가하실 수 있습니다.");
	//									return false;
	//								}else{
	//									var confirm = window.confirm("이 게시물을 평가하시겠습니까?");
	//									if(confirm != true) return false;
	//									return true;
	//								}
	//							},
	//				success  : function(data){
	//					if(data.value != 0){
	//						$("#boardScoreAvgSapn").html(data.value);
	//						jsSetCookieExpTime("scoreCookie:" + OpenWorks.bbsCd + ":" + OpenWorks.seq, OpenWorks.readCookieHour);
	//					}else{
	//						alert('지금은 평가하실 수 없습니다.');
	//					}
	//					$("#scoreForm select[name=scoreSum]").val("0");
	//				}
	//			});
	//			return false;
	//		}
	//	});
	//}
};


//================= 리퀘스트 함수 =================//	

//ajax를 제외한 모든 폼(dataForm)의 리퀘스트를 서버로 전송.
var jsRequest = function(formId, action, method){
	document.dataForm.action = action;
	document.dataForm.method = method;
	document.dataForm.submit();
};

//page번호로 목록 페이지를 호출한다.(bbsCd는 기본 셋팅값 사용)
var jsListReq = function(page) {
    $("#dataForm input[name=q_currPage]").val(page);
    
    if(OpenWorks.section == "myboardB" || OpenWorks.section == "myboard" ||  OpenWorks.section == "myboardQ" ){
        jsRequest("dataForm", "/web/board/BD_board.list.do", "get");
    }else if(OpenWorks.bbsCd == 1003 &&( OpenWorks.section != "myboardB" || OpenWorks.section != "myboard" ) ){
        jsRequest("dataForm", "BD_board.list1.do", "get");
    }else{
        jsRequest("dataForm", "BD_board.list.do", "get");
    }
};

//page번호로 상세보기 페이지를 호출한다.(bbscttSeq는 기본 셋팅값 사용)
var jsViewReq = function(page) {
	$("#dataForm input[name=q_currPage]").val(page);
	jsRequest("dataForm", "BD_board.view.do", "post");
};

//페이지별 리로드
var refreshPage = function(){
	if(OpenWorks.pageType == "LIST") jsListReq(1);
	else if(OpenWorks.pageType == "VIEW") jsViewReq(1);
};

//================= 쿠키관련 함수 =================//

//쿠키에 저장된 값으로 앞으로 얼마나 유효한지 확인
var jsCheckCookieTime = function(cookieName){
	var cukie = $.cookie(cookieName);
	if(cukie == null) return 0;	// 쿠키가 없다
	var nowTime = new Date();
	var expTime = new Date(eval(cukie));
	if((expTime.getTime() - nowTime.getTime()) > 0) return (Math.ceil((expTime.getTime() - nowTime.getTime())/1000/60/60));
	else return 0;
};

//쿠키이름과 시간설정
var jsSetCookieExpTime = function(cookieName, readCookieHour){
	var expDate = new Date();
	expDate.setTime(expDate.getTime() + (60 * 60 * 1000) * readCookieHour);
	$.cookie(cookieName, expDate.getTime(), { path: '/', expires: expDate });
};   
   
//================= 쿠키관련 함수 끝 =================//			 


//================= VIEW/LIST 공용 사용 함수 =================//

//pagerInfo 리셋시사용
var jsRppReset = function() {
	refreshPage();
};

//부류코드 검색
var jsCtgCdSelect = function(ctgCd,aditCtgCd){
    $("#q_ctgCd").val(ctgCd);
    $("#q_aditCtgCd").val(aditCtgCd);
    jsListReq(1);    
};

//검색 버튼
var jsSearch = function(){
	var searchKey = $("#q_searchKeyType");
	var searchVal = $("#q_searchVal");
	
	if("" == $.trim($("#q_searchVal").val()) &&  "" != $.trim(searchKey.val())){
		alert(Message.msg.chkSearchVal); 
		searchVal[0].focus();
		return false;
	}
	
	if("" == $.trim(searchKey.val())){
	    $("#q_searchVal").val("");
	}
	$("#dataForm input[name=q_sortName]").val("");
	$("#dataForm input[name=q_sortOrder]").val("");
	refreshPage();
};

//검색 초기화버튼
var jsSearchReset = function(){
	if(OpenWorks.useCategory == "Y") document.dataForm.elements["q_ctgCd"].value = "";
//	document.dataForm.elements["q_searchKeyType"].value = "";
	//$("#dataForm input[name=q_searchKey]").val("");
	$("#dataForm input[name=q_aditCtgCd]").val("");
	$("#dataForm input[name=q_searchKeyType]").val("");
	$("#dataForm input[name=q_searchVal]").val("");
	$("#dataForm input[name=q_startDt]").val("");
	$("#dataForm input[name=q_endDt]").val("");
	$("#dataForm input[name=q_bizStartDt]").val("");
	$("#dataForm input[name=q_bizEndDt]").val("");
	$("#dataForm input[name=q_sortName]").val("");
	$("#dataForm input[name=q_sortOrder]").val("");
	$("#dataForm input[name=q_init]").val("0");
	refreshPage();
};

//테이블 상단 정렬 클릭시
/*var jsSort = function(item){
	$("#dataForm input[name=q_sortName]").val(item);
	if($("#dataForm input[name=q_sortOrder]").val() == "ASC"){
		$("#dataForm input[name=q_sortOrder]").val("DESC");
	}else{
		$("#dataForm input[name=q_sortOrder]").val("ASC");
	}
	refreshPage();
};*/	

//내용보기 클릭시
var jsView = function(domainCd, bbsCd, bbscttSeq, regPwd, openYn){
	if(bbscttSeq == ""){
		alert(Message.msg.noPosts); 
		return;
	}
	
	$("#dataForm input[name=domainCd]").val(domainCd);
	$("#dataForm input[name=bbsCd]").val(bbsCd);
	$("#dataForm input[name=bbscttSeq]").val(bbscttSeq);
	$("#dataForm input[name=sction]").val("");
	
    if(OpenWorks.section == "myboardB" || OpenWorks.section == "myboard" ||  OpenWorks.section == "myboardQ" ){
        jsRequest("dataForm", "/web/board/BD_board.view.do", "post");
    }else if(OpenWorks.bbsCd == 1003 &&( OpenWorks.section != "myboardB" || OpenWorks.section != "myboard" ) ){
        jsRequest("dataForm", "BD_board.view1.do", "post");
    }else{
        jsRequest("dataForm", "BD_board.view.do", "post");
    }
	//비공개 글 && 세션 없음 && 비밀번호 존재일 때
/*	if((OpenWorks.isSession == false) && (regPwd != '') && (openYn == 'N')){
		$.fn.colorbox({
			open  : true,
			title : "글 비밀번호 입력",
			href  : "PD_pwd.form.do?domainCd="+ domainCd +"&bbsCd=" + bbsCd + "&bbscttSeq=" + bbscttSeq,
			width : "395", height : "275",
			iframe: true
		});
		return;
	}*/
	
	/*if((OpenWorks.loginGrade != "9") && (regPwd != '') && (openYn == 'N')){
		pwd = window.prompt("게시물 비밀번호를 입력하세요", "");
		if(pwd == null) return;
	}else{
		pwd = "";
	}
	$.post("BD_board.view.do", {
		bbsCd: $("#dataForm input[name=bbsCd]").val(),
		authType : "VIEW",
		seq : seq,
		regPwd : pwd
		}, function(result){
			if(result.value){
				$("#dataForm input[name=bbsCd]").val(bbsCd);
				$("#dataForm input[name=seq]").val(seq);
				$("#dataForm input[name=regPwd]").val(pwd);
				jsRequest("dataForm", "BD_board.view.do", "get");
			}else{
				jsWarningBox('내용보기 권한이 없습니다.');
				return false;
			}
	}, "json");*/
	
	
};

//등록 버튼폼(bbsCd로 구분 refrnSeq=null, bbscttSeq=null)
var jsInsertForm = function(pageType){
	$("#dataForm input[name=refrnSeq]").val("");
	$("#dataForm input[name=bbscttSeq]").val("");
	$("#dataForm input[name=pageType]").val(pageType);
	
	if(OpenWorks.bbsCd == 1003 && (OpenWorks.section != "myboardB" || OpenWorks.section != "myboard" ) ){
	    jsRequest("dataForm", "BD_board.insert.form1.do", "get");
    }else{
        jsRequest("dataForm", "BD_board.insert.form.do", "get");
    }
};


//================= VIEW/LIST 공용 사용 함수  끝 =================//


//목록보기 버튼
var jsList = function(page){
	//$("#dataForm").validate().resetForm();
    
//    $("#q_product").val("");
//    $("#q_searchKeyType").val("");
//    $("#q_searchKey").val("");
//    $("#q_searchVal").val("");
	$("#dataForm input[name=bbscttSj]").attr("disabled", "disabled");
	$("#dataForm [name=bbscttCn]").attr("disabled", "disabled");
	$("#dataForm").unbind("submit", null);
	jsListReq(page);
};

//태그 검색 시 태그 옵션 생성(목록)
var jsSetSearchOption = function(){
	var flag = true;
	$("#q_searchKeyType option").each(function(index){
		if($(this).val() == 'TAG___1005'){
			flag = false;
			return false;
		}
	});
	if(flag){
		$("#q_searchKeyType option").append("<option value='TAG___1005'>태그</option>");
	}
};

//태그 클릭 시 태그 목록 불러오기(뷰화면)
var jsShowBbsListByTag = function(tag){
    var pbody = document.body;

    jsSetSearchOption();

    $("input[name=q_searchVal]", pbody).val(tag);
    $("[name=q_searchKeyType]", pbody).val('TAG___1005');
    $("#dataForm input[name=q_currPage]", pbody).val(1);
    document.dataForm.action = "BD_board.list.do";
    document.dataForm.method = "get";
    document.dataForm.submit();
};


//입력폼 초기화
var jsResetForm = function(){
	$("form")[0].reset();
};