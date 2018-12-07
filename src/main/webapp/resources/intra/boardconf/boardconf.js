/**
 * 목록
 */
var jsList = function(){
	location.href = "BD_boardconf.list.do?" + jsSearchQueryString("dataForm");
};

/**
 * 검색
 */
var jsSearch = function(){
    
    document.dataForm.action = "BD_boardconf.list.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.method = "get";
    document.dataForm.submit();
};

/**
 * 검색 초기화
 */
var jsSearchReset = function() {
    document.dataForm.action = "BD_boardconf.list.do";
    document.dataForm.elements["currentPage"].value = "0";
    document.dataForm.elements["q_sortName"].value = "";
    document.dataForm.elements["q_sortOrder"].value = "";
    /* ---------- 2014. 9. 20 추가 */
    document.dataForm.elements["q_domain_cd"].value = "";
    document.dataForm.elements["q_searchVal"].value = "";
    document.dataForm.elements["q_searchType"].value = "";
    
    document.dataForm.submit();
};

/**
 * 상세
 */
var jsView = function(domainCd, bbsCd){
    $("#domainCd").val(domainCd);
	$("#bbsCd").val(bbsCd);
	location.href = "BD_boardconf.view.do?" + jsSearchQueryString("dataForm");
};

/**
 * 등록 폼
 */
var jsInsertForm = function(){
	$("#q_seq").val("");
	location.href = "BD_boardconf.insert.form.do?" + jsSearchQueryString("dataForm");	
};

/**
 * 수정 폼
 */
var jsUpdateForm = function(domainCd, bbsCd) {
	$("#q_domainCd").val(domainCd);
	$("#q_bbsCd").val(bbsCd);
	location.href = "BD_boardconf.update.form.do?" + jsSearchQueryString("dataForm");
};

/**
 * 삭제
 */
var jsDelete = function(){
	$("#dataForm").attr("action", "ND_boardconf.delete.do");
	$("#dataForm").submit();
};

/**
 * 목록 삭제
 */
var jsDeleteList = function(){
	var url = "ND_boardconf.list.delete.do?";
	var selectedBbsCds = new Array();
	//var domainCd;
	//var bbsCd;
	$(".checkbox:checked").each(function (i){
		selectedBbsCds[i] = $(this).val();
        
		url += "bbsCds=" + $(this).val() + "&";
//		url += "domainCd=" + domainCd + "&" + "bbsCd=" + bbsCd + "&";
	});

	if(selectedBbsCds.length == 0){
		jsWarningBox("삭제 대상 게시판을 1개 이상 선택하세요.");
		return false;
	}else{
		if(confirm("선택한 " + selectedBbsCds.length + "개의 게시판을 정말 삭제하시겠습니까?\n\n게시물이 있는 경우 삭제하실 수 없으며 삭제 후 복구는 불가능합니다.")){
			$.post(url,
			function(response){
				if(isNaN(response)){
					alert(response);
				}else{
					alert(selectedBbsCds.length + "개 중 " + response + "개의 게시판을 성공적으로 삭제했습니다.");
				}
				
				document.location.reload();
			});
			//$("#dataForm").attr("action", "ND_boardconf.list.delete.do");
			//$("#dataForm").submit();
		}
	}
};

/**
 * 사용/미사용 전환
 */
var jsYnAction = function(el, domainCd, bbsCd, gubunCd){
	var element = $(el).children();
	var fieldYn = element.attr("yn") == "Y" ? "N" : "Y";

	var isProcessing = true;
	if(element.attr("id") == "useYn" && fieldYn == "N"){
		if(!confirm("사용여부를 미사용으로 설정 시에는 본 게시판이 서비스되지 않습니다.\n\n계속 진행하시겠습니까?")){
			isProcessing = false;
		}
	}

	if(isProcessing){
		element.text("....");

		$.post("ND_ynUpdateAction.do", { 
		        domainCd : domainCd,
			bbsCd   : bbsCd,
			gubunCd : gubunCd,
			fieldColumn : element.attr("id"),
			fieldYn : fieldYn
		},
		function(result){
			element.removeClass();
			if(fieldYn == "Y"){
				element.text("사 용");
				element.attr("class", "icon-use");
				element.attr("yn", "Y");
			}else{
				element.text("미사용");
				element.attr("class", "icon-not-use");
				element.attr("yn", "N");
			}
		}, "json");
	}
};

/**
 * tab reload
 */
var jsReloadTab = function(){
    if(confTabz){
        confTabz.refresh();
    }
};

/**
 * 게시판 관리창
 */
var jsViewBbs = function(domainCd, bbsCd){
	$("button[name=boardViewBtn]").colorbox({
		title : "게시판",
		href  : "<c:url value='/intra/board/ND_board.list.do?domainCd="+domainCd+"'&bbsCd= />"+bbsCd,
		width : "100%", height:"100%", 
		iframe: true
	});
};

/**
 * 입력 변경 사항 체크
 */
var jsChkValueChange = function(type, nm, val){
    var thisVal = "";
    if(type == "text" || type == "textarea"){
        thisVal = $("#" + nm).val();
    }else if(type == "select"){
        thisVal = $("#" + nm + " option:selected").val();
    }else if(type == "radio" || type == "checkbox"){
        thisVal = $("input[name=" + nm + "]:checked").val();
    }
    if(thisVal != val) changeFlag = true;
};


