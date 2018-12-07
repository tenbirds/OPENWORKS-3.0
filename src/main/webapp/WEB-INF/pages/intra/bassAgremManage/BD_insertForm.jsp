<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>기본협약서등록</title>
	<op:jsTag type="openworks" items="form, validate, ckeditor" />
	<op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
	
	<script type="text/javascript">
		$().ready(function() {
		    /* $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

	        $('#presentnPrearngeDe').datepicker({
	            showOn : 'button',
	            defaultDate : null,
	            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
	            buttonImageOnly : true
	        });
	        $('#presentnDe').datepicker({
	            showOn : 'button',
	            defaultDate : null,
	            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
	            buttonImageOnly : true
	        });
	        $('#cnclsComptDe').datepicker({
	            showOn : 'button',
	            defaultDate : null,
	            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
	            buttonImageOnly : true
	        });
	        $('#sndngDe').datepicker({
	            showOn : 'button',
	            defaultDate : null,
	            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
	            buttonImageOnly : true
	        }); */
		    
	        $("#dataForm").validate({
	            rules: {
	                cmpnyNm              : { required : true, maxlength : 50}
	                ,chargerNm           : { required : true, maxlength: 10}
	                ,telno           	 : { required : true}
	                ,mbtlnum             : { required : true}
	                ,email           	 : { required : true, email : true}
	                /* ,presentnPrearngeDe  : { required : true, date: true}
	                ,presentnDe          : { date: true}
	                ,cnclsComptDe        : { date: true}
	                ,sndngDe             : { date: true}
	                ,agremOrder          : { required : true} */
	                /* ,cnstntCo            : { required : true, number: true}
	                ,comouDe             : { required : true, formatDate: true}
	                ,agremStatCd         : { required : true} */
	            }
	            ,messages: {
	
	        	}
			});        
	    });
	    
	    // 서비스등록
	    var jsInsertAction = function() {
	        if(checkEditor()) {
	            $("input[type=file]").each(function() {
	                if (this.value == '') {
	                    $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                    $("#"+this.id).attr("disabled","disabled");
	                }
	            });
	            if(confirm("등록 하시겠습니까?")) {
		            $("#dataForm").attr("action", "ND_insertAction.do");
		            $("#dataForm").submit();
	            }
	        }
	    };
	
	    
	  	//파일갯수
	    var jsFileCount = function(inputId, fileSeq, maxCnt){
	        return true;
	
	        if (fileSeq == "") {
	            fileSeq = -1;
	        }
	        var ret = false;
	        var fCnt = 0;
	        $("input[type=file][class~="+inputId.substring(0, inputId.length - 1)+"]").each(function() {
	            if (this.value!=null && this.value!="") {
	                fCnt++;
	            }
	        });
	
	        $.ajax({
	            url  : "ND_fileCountChk.do",
	            data : { fileSeq : fileSeq, fCnt : fCnt, maxCnt : maxCnt },
	            type : "POST",
	            dataType : "text",
	            async    : false,
	            success : function(response) {
	
	                if (response != "") {
	                    alert(response);
	                    var htmlVal = "";
	                    htmlVal = $("span#"+inputId+"Div").html();
	                    $("input[name="+inputId+"]").remove();
	                    $("span#"+inputId+"Div").append(htmlVal);
	                    ret = false;
	                }
	                else {
	                    ret = true;
	                }
	            }
	
	        });
	        return ret;
	    };
	
		//파일종류
		var jsFileChk = function(inputId, s, fileExt, fileSeq, maxCnt) {
	    	return;
	
	      	var inputFile = document.getElementById(inputId);
	      	var filePath = inputFile.value;
	
	      	if (filePath == "") {
	          	return false;
	      	}
	
	      	var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt);
	
	      	if (fileCountResult) {
	          	var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
	          	var fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai,zip";
	          	var htmlVal = "";
	
	          	if (fileExtPermit.indexOf(fileExt) <= 0) {
	              	alert(fileExt + Message.msg.fileCannotUplaod);
	              	htmlVal = "";
	              	htmlVal = $("span#"+inputId+"Div").html();
	              	$("input[name="+inputId+"]").remove();
	              	$("span#"+inputId+"Div").append(htmlVal);
	
	              	return false;
	          	}
	
	          	if (inputFile.files[0].size > (s * 1024) && s != 0) {
	             	alert(Message.msg.fileSizeOver);
	             	htmlVal = "";
	             	htmlVal = $("span#"+inputId+"Div").html();
	             	$("input[name="+inputId+"]").remove();
	             	$("span#"+inputId+"Div").append(htmlVal);
	             	return false;
	          	}
	      	}
	  	};
	
	  	//첨부된 파일중 ajax를 이용하여 파일 삭제
	    var jsFileDelete = function(element, seq, id){
	        if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
	            return false;
	
	        var url = "ND_fileDelete.do";
	        $.post(url,
	            { fileId : id, fileSeq : seq },
	            function(result){
	                if(result == 1){
	                    $(element).parent().remove();
	                    self.location.reload();	
	                }else{
	                    alert('파일을 삭제하지 못했습니다.');
	                }
	            }, 'json');
	    };
	
	    /**
	     * 목록
	     */
	    var jsList = function(action) {
	        if(confirm("등록을 취소하시겠습니까?")) {
		        self.location.href = action;
	        }
	    };
	
	    
	    // 등록 vaildate
	    var checkEditor = function() {
	        var ret = true;
	        
	     	// 담당자
	        if ($("#userId").val()==null || $("#userId").val().trim()=="") {
	            alert("담당자를 선택해서 입력하여 주세요.");
	            document.getElementById("userIdBtn").focus();
	            return false;
	        }
	     
	     	// 담당자
	        if ($("#chargerNm").val()==null || $("#chargerNm").val().trim()=="") {
	            alert("담당자를 입력하여 주세요.");
	            document.getElementById("chargerNm").focus();
	            return false;
	        }
	     
	        // 회사명
	        if ($("#cmpnyNm").val()==null || $("#cmpnyNm").val().trim()=="") {
	            alert("회사명을 입력하여 주세요.");
	            document.getElementById("cmpnyNm").focus();
	            return false;
	        }
	        
	     	// 전화번호
	        if ($("#telno").val()==null || $("#telno").val().trim()=="") {
	            alert("전화번호를 입력하여 주세요.");
	            document.getElementById("telno").focus();
	            return false;
	        }
	     
	     	// 핸드폰
	        if ($("#mbtlnum").val()==null || $("#mbtlnum").val().trim()=="") {
	            alert("핸드폰을 입력하여 주세요.");
	            document.getElementById("mbtlnum").focus();
	            return false;
	        }
	     
	     	// 이메일
	        if ($("#email").val()==null || $("#email").val().trim()=="") {
	            alert("이메일을 입력하여 주세요.");
	            document.getElementById("email").focus();
	            return false;
	        }
	     
	     	// 제출예정일
	        /* if ($("#presentnPrearngeDe").val()==null || $("#presentnPrearngeDe").val().trim()=="") {
	            alert("제출예정일을 입력하여 주세요.");
	            document.getElementById("presentnPrearngeDe").focus();
	            return false;
	        } */
	      
	        // vaildate 체크 실패시 false 반환
	        if (!ret) {
	            return false;
	        }
	
	        // vaildate 체크 성공시 true 반환
	        return true;
	    };
	
	    var jsInputFileReset = function(fileId) {
	        var control = $("#" + fileId);
	        control.replaceWith( control = control.clone( true ) );
	    };
	    
	    var jsSellerList = function(el) {
            $(el).colorbox({
                title : "담당자 목록",
                href : "PD_sellerListPop.do",
                width : "1000",
                height : "800",
                overlayClose : false,
                escKey : true,
                iframe : true
            });
        };
        
        

	</script>
</head>
<body>

	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">

	<!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
	<op:pagerParam view="view" />

	<input type="hidden" name="goodsCode" id="goodsCode" value="" />
	<input type="hidden" name="langNm" 	  id="langNm" 	 value="${param.langNm}" />
	<input type="hidden" name="langCode"  id="langCode"  value="<c:if test="${param.langCode eq null}">00</c:if><c:if test="${param.langCode ne null}">${param.langCode}</c:if>" />
	<table class="boardWrite mar_t20">
		<colgroup>
			<col width="150" />
			<col width="200" />
			<col width="150" />
			<col width="200" />
			<col width="150" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr><td colspan="6"><h4>협약기업 정보</h4></td></tr>
		    <tr>
				<th><span class="tx_red_s">*</span>담당자</th>
				<td colspan="5">
					<input name="chargerNm" id="chargerNm" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="20"></input>
					<input name="userId" id="userId" type="hidden" value="" maxlength="20"></input>
					<input type="button" id="userIdBtn" value="담당자 선택" onclick="jsSellerList(this);"></input>
				</td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>회사명</th>
				<td colspan="5">
					<input name="cmpnyNm" id="cmpnyNm" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="50"></input>
				</td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>전화번호</th>
				<td>
					<input name="telno" id="telno" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="13"></input>
				</td>
				<th><span class="tx_red_s">*</span>핸드폰</th>
				<td>
					<input name="mbtlnum" id="mbtlnum" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="13"></input>
				</td>
				<th><span class="tx_red_s">*</span>이메일</th>
				<td>
					<input name="email" id="email" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="50"></input>
				</td>
			</tr>
			<!-- <tr>
				<th><span class="tx_red_s">*</span>제출예정일</th>
				<td>
					<input name="presentnPrearngeDe" id="presentnPrearngeDe" class="w120" type="text" value="" style="ime-mode:active" maxlength="10"></input>
				</td>
				<th>제출일</th>
				<td colspan="3">
					<input name="presentnDe" id="presentnDe" class="w120" type="text" value="" style="ime-mode:active" maxlength="10"></input>
				</td>
			</tr>
			<tr>
				<th>체결완료일</th>
				<td>
					<input name="cnclsComptDe" id="cnclsComptDe" class="w120" type="text" value="" style="ime-mode:active" maxlength="10"></input>
				</td>
				<th>발송일</th>
				<td colspan="3">
					<input name="sndngDe" id="sndngDe" class="w120" type="text" value="" style="ime-mode:active" maxlength="10"></input>
				</td>
			</tr> -->
			<tr>
				<!-- <th><span class="tx_red_s">*</span>차수</th>
				<td>
					<input name="agremOrder" id="agremOrder" class="w_92px" type="text" value="1" style="ime-mode:active" maxlength="1"></input>
				</td>
				<th><span class="tx_red_s">*</span>협약종료일</th>
				<td>
					<input name="agremEndDe" id="agremEndDe" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="10" readonly="readonly"></input>
				</td> -->
				<th>협약번호</th>
				<td colspan="5">
					<input name="agremNo" id="agremNo" class="w_92px" type="text" value="" style="ime-mode:active" maxlength="8"></input>
				</td>
			</tr>
		</tbody>
	</table>

	<table class="boardWrite mar_t20">
		<colgroup>
			<col width="150" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr><td colspan="2"><h4>제출서류</h4></td></tr>
			<tr>
			    <th>기본협약서</th>
                <td>
				    <input type="file" name="bassAgrmntFile1" id="bassAgrmntFile1" class="mnlFile w_92px" onchange="jsFileChk('bassAgrmntFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="bassAgrmntFile1Desc" value=""/>
				   <!--  <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('bassAgrmntFile1');"/> -->
				</td>
			</tr>
			<tr>
			    <th>등기부등본</th>
                <td>
				    <input type="file" name="rgsbukTrnscrFile1" id="rgsbukTrnscrFile1" class="mnlFile w_92px" onchange="jsFileChk('rgsbukTrnscrFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="rgsbukTrnscrFile1Desc" value=""/>
				    <!-- <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('rgsbukTrnscrFile1');"/> -->
				</td>
			</tr>
			<tr>
			    <th>벤처기업증명서</th>
                <td>
				    <input type="file" name="vnentrCrtfFile1" id="vnentrCrtfFile1" class="mnlFile w_92px" onchange="jsFileChk('vnentrCrtfFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="vnentrCrtfFile1Desc" value=""/>
				    <!-- <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('vnentrCrtfFile1');"/> -->
				</td>
			</tr>
			<tr>
			    <th>직접생산증명서</th>
                <td>
				    <input type="file" name="directPrdctnCrtfFile1" id="directPrdctnCrtfFile1" class="mnlFile w_92px" onchange="jsFileChk('directPrdctnCrtfFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="directPrdctnCrtfFile1Desc" value=""/>
				    <!-- <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('directPrdctnCrtfFile1');"/> -->
				</td>
			</tr>
			<tr>
			    <th>신용평가서</th>
                <td>
				    <input type="file" name="cdltDocFile1" id="cdltDocFile1" class="mnlFile w_92px" onchange="jsFileChk('cdltDocFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="cdltDocFile1Desc" value=""/>
				    <!-- <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('cdltDocFile1');"/> -->
				</td>
			</tr>
			<tr>
			    <th>재무제표</th>
                <td>
				    <input type="file" name="fnlttFile1" id="fnlttFile1" class="mnlFile w_92px" onchange="jsFileChk('fnlttFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="fnlttFile1Desc" value=""/>
				    <!-- <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('fnlttFile1');"/> -->
				</td>
			</tr>
			
		</tbody>
	</table>

	<!-- 버튼 -->
	<div class="mar_t20 mar_b50">
		<div class="float_l">
			<input type="button" value="취소" class="blue" onclick="jsList('BD_index.do');" />
		</div>
		<div class="float_r">
			<input type="button" value="등록" class="blue" onclick="jsInsertAction();" />
		</div>
	</div>
	<!-- //버튼 -->
	</form>
</body>
</html>
