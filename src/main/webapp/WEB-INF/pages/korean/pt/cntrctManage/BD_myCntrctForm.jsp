<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>등록페이지</title>
<op:jsTag type="openworks" items="form, validate" />
<op:jsTag type="spi" items="form, validate, datepicker" />
<script type="text/javascript">
	$().ready(function(){
	    //계약 시작일자 달력셋팅
	    $('#cntrctBeginDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/new_cloud/images/icon-btn/btn-calendar.gif" />',
            buttonImageOnly : true
        });
	  	//계약 종료일자 달력셋팅
	    $('#cntrctEndDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/new_cloud/images/icon-btn/btn-calendar.gif" />',
            buttonImageOnly : true
        });
	    
        // submit값 체크
        $("#dataForm").validate({
            rules: {
                svcNm         : { required : true, maxlength : 100}
               ,cntrctBeginDe : { required : true, date : true}
               ,cntrctEndDe   : { required : true, date : true}
               ,cntrctamount  : { required : true, number : true}
               ,purchsInsttNm : { required : true, maxlength : 50}
               ,sleInsttNm    : { required : true, maxlength : 50}
            }
           ,invalidHandler: function(event, validator){
            }
        });

    });
    
 	
    // 등록버튼 클릭
    var jsMyCntrctInsertAction = function() {
        
        if(checkFormValue()){
            if(confirm("등록 하시겠습니까?")){
                $("input[type=file]").each(function(){
                    if(this.value == ''){
                        $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                        $("#"+this.id).attr("disabled","disabled");
                    }
                });
                $("#dataForm").attr("action", "ND_myCntrctInsertAction.do");
                $("#dataForm").submit();
            }else{
            }
        }else{
        }
 
    };
    
	// 입력값 체크
    var checkFormValue = function(){
        //서비스명
        if($("#svcNm").val() == null || $("#svcNm").val() == ""){
            alert("서비스명을 입력해주세요.");
            $("#svcNm").focus();
            return false;
        }
        
      	//계약시작일자
        if($("#cntrctBeginDe").val() == null || $("#cntrctBeginDe").val() == ""){
            alert("계약시작일자를 입력해주세요.");
            $("#cntrctBeginDe").focus();
            return false;
        }
		
      	//계약종료일자
        if($("#cntrctEndDe").val() == null || $("#cntrctEndDe").val() == ""){
            alert("계약종료일자 입력해주세요.");
            $("#cntrctEndDe").focus();
            return false;
        }
      	
      	//계약 시작/종료일자 값 비교
        if($("#cntrctBeginDe").val() > $("#cntrctEndDe").val()){
            alert("계약시작일자가 종료일자보다 클 수 없습니다.");
            $("#cntrctBeginDe").focus();
            return false;
        }
      
      	//계약금액
        if($("#cntrctamount").val() == null || $("#cntrctamount").val() == ""){
            alert("계약금액을 입력해주세요.");
            $("#cntrctamount").focus();
            return false;
        }
      	
      	//구매기관
        if($("#purchsInsttNm").val() == null || $("#purchsInsttNm").val() == ""){
            alert("구매기관을 입력해주세요.");
            $("#purchsInsttNm").focus();
            return false;
        }
      	
      	//판매기관
        if($("#sleInsttNm").val() == null || $("#sleInsttNm").val() == ""){
            alert("판매기관을 입력해주세요.");
            $("#sleInsttNm").focus();
            return false;
        }
            
        //계약서 파일
        if($("input[name=ctrtcFile1]").val() == null || $("input[name=ctrtcFile1]").val() == ""  ){
            alert("계약서를 등록해주세요.");
            document.getElementById("ctrtcFileBtn").focus();
            return false;
        }
        
        return true;
    };
    
    //파일종류 및 용량 체크
    var jsFileChk = function(inputId, inputIdFake, s, fileExt, fileSeq, maxCnt){
        document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
        
        var inputFile = document.getElementById(inputId);
        var filePath = inputFile.value;

        if(filePath == ""){
            return false;
        }

        var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
        var fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai,zip";
        var htmlVal = "";

        if(fileExtPermit.indexOf(fileExt) <= 0){
            alert(fileExt + Message.msg.fileCannotUplaod);
            jsInputFileReset(inputId, inputIdFake);
            return false;
        }

        if(inputFile.files[0].size > (s * 1024) && s != 0){
            alert(Message.msg.fileSizeOver);
            jsInputFileReset(inputId, inputIdFake);
            return false;
        }

        document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();            
        
    };

    // 숫자값 체크
    function fnb_isNumeric(sz_arg){
        var OK = false;
        var i_loop;

        if(sz_arg.length > 0){
            for(i_loop = 0; i_loop < sz_arg.length; i_loop++){
                if(sz_arg.charAt(i_loop) < '0' || sz_arg.charAt(i_loop) > '9')
                    break;
            }
            if(i_loop == sz_arg.length)
                OK = true;
        }
        return OK;
    }
	
    // 첨부파일 삭제 X버튼 클릭
    var jsInputFileReset = function(fileId, textId){
        $("#" + textId).val("");
        var control = $("#" + fileId);
        control.replaceWith( control = control.clone( true ) );
    };
    
    // 목록이동 버튼 클릭
    var jsMyCntrctList = function() {
        document.location.href = "BD_myCntrctIndex.do";
    };
    
    // 취소버튼 클릭
    var jsCancel = function(){
        if(confirm("등록을 취소하시겠습니까?")){
            location.reload();
        }
        return false;
    };
    
    // 숫자만 입력(onKeyDown)
    var onlyNumber = function(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	};
	
	// 숫자가 아닌 문자 제거(onKeyUp)
    var removeChar = function(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) {
			return;
		} else {
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
	};
    
</script>
</head>
<body>
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">
			<h2>계약서 등록</h2>
		</div>
		<!-- //title-area -->
	    <!-- section -->
		<div class="section">
		    <!-- 등록 서식 영역 -->
		    <section>
		        <fieldset>
		            <legend><span>계약서등록서식</span></legend>
	                <div class="tab-search type-write">
						<table>
							<caption>계약서 등록</caption>
							<colgroup>
							<col style="width:140px;"/>
							<col style="width:160px;"/>
							<col style="width:30px;"/>
							<col style="width:*;"/>
							</colgroup>
							<tbody>
								<tr>
									<th><span class="point"><strong class="txt-point">서비스명</strong></span></th>
									<td><input name="svcNm" id="svcNm" type="text" value="" class="w445" maxlength="100" /></td>
								</tr>
								<tr>
									<th><span class="point"><strong class="txt-point">계약기간</strong></span></th>
									<td>
										<strong class="fl mt10 mr10">시작일</strong>
										<div class="calendar_input">
											<input type="text" class="input" id="cntrctBeginDe" name="cntrctBeginDe" value="" title="계약시작일자" style="width:100px;" readonly="readonly"/>
										</div>
										<strong class="fl mt10 mr10 ml10">~ 종료일</strong>
										<div class="calendar_input">
											<input type="text" class="input" id="cntrctEndDe" name="cntrctEndDe" value="" title="계약종료일자" style="width:100px;" readonly="readonly"/>
										</div>
									</td>
								</tr>
								<tr>
									<th><span class="point"><strong class="txt-point">계약금액</strong></span></th>
									<td><input name="cntrctamount" id="cntrctamount" type="text" value="" class="input" style="width:184px;" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="ime-mode:disabled;" maxlength="9" /></td>
								</tr>
								<tr>
									<th><span class="point"><strong class="txt-point">구매기관</strong></span></th>
									<td><input name="purchsInsttNm" id="purchsInsttNm" type="text" value="" class="input" style="width:184px;" maxlength="50" /></td>
								</tr>
								<tr>
									<th><span class="point"><strong class="txt-point">판매기관</strong></span></th>
									<td><input name="sleInsttNm" id="sleInsttNm" type="text" value="" class="input" style="width:184px;" maxlength="50" /></td>
								</tr>
								<tr>
									<th><span class="point"><strong class="txt-point">계약서파일</strong></span></th>
									<td>
										<ul>
										<li>
											<div class="fl">
												<strong class="dis-block fl mt10 mr10">파일 업로드</strong>
												<div class="file-area fr">
													<!-- file upload -->
													<input type="text" id="ctrtcFileInput1" readonly="readonly" title="파일명" class="fileup">
													<span class="file_del"><img onclick="jsInputFileReset('ctrtcFile1','ctrtcFileInput1');" src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제"></span>
													<div class="fake_input">
														<a id="ctrtcFileBtn" href="#" class="b-btn type1"><strong><span>파일선택</span></strong></a>
														<span id="ctrtcFile1Span">
															<input type="file" name="ctrtcFile1" id="ctrtcFile1" class="ctrtcFile" title="파일찾기" onchange="jsFileChk('ctrtcFile1', 'ctrtcFileInput1', 10240, '1', -1, 5);">
															<input type="hidden" name="fileDesc" id="ctrtcFile1Desc" value=""/>
														</span>
													</div>
													<!-- //file upload -->
												</div>
											</div>
										</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</fieldset>
			</section>
		</div>
		<!-- //section -->
		<div class="btn-area mt20">
			<p class="fl">
				<a href="javascript:;" onclick="jsMyCntrctList(); return false;" class="b-btn list type1"><strong><span>목록</span></strong></a>
			</p>
			<p class="fr">
				<a href="javascript:;" onclick="jsMyCntrctInsertAction(); return false;" class="b-btn registry type2"><strong><span>저장</span></strong></a>
				<a href="javascript:;" onclick="jsCancel(); return false;" class="b-btn cancel type1"><strong><span>취소</span></strong></a>
			</p>
		</div>
	</div>
	<!-- //contents -->
    <!-- //등록 서식 영역 -->
</form>
</body>
</html>