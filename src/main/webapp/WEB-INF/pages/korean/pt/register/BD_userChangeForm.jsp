<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%
	String BizNumb = (String) session.getAttribute("strNo");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>제공자 권한 신청</title>
	<op:jsTag type="openworks" items="form, validate, ckeditor" />
	<op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
	
<!-- KICA SecuKit NX -->
<link rel="stylesheet" type="text/css" href="/SecuKitNXS/WebUI/css/base.css" />
<script type="text/javascript" src="/SecuKitNXS/WebUI/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/SecuKitNXS/KICA/config/nx_config.js"></script>
<script type="text/javascript" src="/SecuKitNXS/KICA/config/LoadSecukitnx.js"></script>
<script type="text/javascript">
	window.onload = function () {
		// KICA WebUI append
		$('#KICA_SECUKITNXDIV_ID').append(KICA_SECUKITNXDIV);
		secunx_Loading();
	};
	function SecuKitNX_Ready(res) {
		if (res) {
			console.log('SecuKitNX Ready');
		}
	}
	
    // 함수 호출 결과값 리턴
    function SecuKitNXS_RESULT(cmd, res) {
        // Error Check
        var Err = 999;
        try {
            // Error Code가 포함되었는지 확인
            Err = res.ERROR_CODE;
        } catch (e) {
            console.log(e);
        }

        if (Err === undefined) {

            // cmd : 호출 함수명, res : 결과값(obj)
            var val = null;
            switch (cmd) {
                    // 신원확인
                case 'Check_SSN':
                    var ssn = document.getElementById('SSN').value.replace(/-/gi, "");     // 신원확인 정보 ( 개인 : 주민등록번호, 사업자 : 사업자번호)
                    var certID = certListInfo.getCertID();              // 선택된 인증서 ID
                    
                    var cmd = 'Check_SSN_Result.verifyVID';
                    var Data = {
                        'ssn': ssn,
                        'certID': certID
                    };
                    var param = JSON.stringify(Data);
                    secukitnxInterface.SecuKitNXS(cmd, param);
                    break;

                case 'Check_SSN_Result':
                    val = res.verifyVID;
                    jsInsertAction();
                    break;

                default: break;
            }

        } else {
            // Error Message 출력
            $('.nx-cert-select').hide(); $('#nx-pki-ui-wrapper').hide(); KICA_Error.init();
            KICA_Error.setError(res.ERROR_CODE, res.ERROR_MESSAGE);
            var errorMsg = KICA_Error.getError();
            alert(errorMsg);
        }
    }
</script>
<!-- //KICA SecuKit NX -->
	<script type="text/javascript">
	 /*$().ready(function() {
	        $("#dataForm").validate({
	            rules: {
            		cmpnyNm              : { required : true, maxlength : 50}
	        		,chargerNm           : { required : true, maxlength: 10}
	                ,telno           	 : { required : true}
	                ,mbtlnum             : { required : true}
	                ,email           	 : { required : true, email : true}
	                ,presentnPrearngeDe  : { required : true, date: true}
	                ,presentnDe          : { date: true}
	                ,cnclsComptDe        : { date: true}
	                ,sndngDe             : { date: true}
	                ,cnstntCo            : { required : true, number: true}
	                ,comouDe             : { required : true, formatDate: true}
	                ,agremStatCd         : { required : true}
	            }
	            ,messages: {
	
	        	}
				 });        
	    }); */
	    
	    // 파일등록
	    var jsCheckSSN = function() {
	           if(checkEditor()) {	            
	            $("input[type=file]").each(function() {
	                if (this.value == '') {
	                    $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                    $("#"+this.id).attr("disabled","disabled");
	                }
	            });
	            $("#telno").val($("#telno1").val() + "-" + $("#telno2").val() + "-" + $("#telno3").val());
	            
	            if(confirm("등록 하시겠습니까?")) {
 		            // 인증서 선택창 호출
				    processLogic.init();
			        processLogic.setProcessLogic('Check_SSN');
			        NX_ShowDialog(); // 공인인증
				}
			}
		};

	    var jsInsertAction = function() {
            $("#dataForm").attr("action", "ND_BassAgreminsertAction.do");
            $("#dataForm").submit();
        }
        
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
	                    htmlVal = $("#"+inputId).html();
	                    $("input[name="+inputId+"]").remove();
	                    $("#"+inputId).append(htmlVal);
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
		    
	      	var inputFile = document.getElementById(inputId);
	      	var filePath = inputFile.value;
					
	      	if (filePath == "") {
	          	return false;
	      	}
	      	
	      	var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt);
	      	
	      	$("#"+inputId+"Name").val(filePath);
	      	
	      	return;
	      	
	      	if (fileCountResult) {
	          	var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
	          	var fileExtPermit = "pdf";
	          	var htmlVal = "";
	          	
	          	if (fileExtPermit.indexOf(fileExt) <= 0) {
	              	alert(fileExt + Message.msg.fileCannotUplaod);
	              	htmlVal = "";
	              	htmlVal = $("#"+inputId).html();
	              	$("input[name="+inputId+"]").remove();
	              	$("#"+inputId).append(htmlVal);

	              	return false;
	          	}

	          	if (inputFile.files[0].size > (s * 1024) && s != 0) {
	             	alert(Message.msg.fileSizeOver);
	             	htmlVal = "";
	             	htmlVal = $("#"+inputId).html();
	             	$("input[name="+inputId+"]").remove();
	             	$("#"+inputId).append(htmlVal);
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
	
	    // 등록 vaildate
	    var checkEditor = function() {
	        var ret = true;
	        
	      // 회사명
		    if ($("#cmpnyNm").val()==null || $("#cmpnyNm").val().trim()=="") {
		        alert("회사명을 입력하여 주세요.");
		        $("#cmpnyNm").focus();
		        return false;
		    }
	        
	        if($("#bassAgrmntFile1").val()==null || $("#bassAgrmntFile1").val().trim()==""){
	            alert("협약서를 첨부하여 주십시오.");
//	            $("#bassAgrmntFile1Name").focus();
	            return false;
	        }
	        else if($("#rgsbukTrnscrFile1").val()==null || $("#rgsbukTrnscrFile1").val().trim()==""){
	            alert("등기부등본을 첨부하여 주십시오.");
//	            $("#rgsbukTrnscrFile1Name").focus();
	            return false;
	        }
	        else if($("#cdltDocFile1").val()==null || $("#cdltDocFile1").val().trim()==""){
	            alert("신용평가서를 첨부하여 주십시오.");
//	            $("#cdltDocFile1Name").focus();
	            return false;
	        }
	        else if($("#fnlttFile1").val()==null || $("#fnlttFile1").val().trim()==""){
	            alert("재무제표을 첨부하여 주십시오.");
//	            $("#fnlttFile1Name").focus();
	            return false;
	        }
	     
	     	// vaildate 체크 실패시 false 반환
	        if (!ret) {
	            return false;
	        }
	 
	        // vaildate 체크 성공시 true 반환
	        return true;
	    };
	
	    var jsInputFileReset = function(fileId, textId) {
	        var control = $("#" + fileId);
	        var text = $("#" + textId);
	        control.replaceWith( control = control.clone( true ) );
	        text.val("");
	    };
	    
	    var readURL = function (input) {    <%-- 업로드 파일 미리보기 --%>
	    if (input.files && input.files[0]) {
	        fileName = input.files[0].name; // 파일명
	        $("#multiFiles").text(fileName);
	        $("#compnyLogo").val(fileName);
	        ext = fileName.substring(fileName.lastIndexOf('.') + 1);//확장자
	        ext = ext.toLowerCase();
	        if(ext != 'gif' && ext != 'jpg' && ext !='jpeg' && ext !='png') {  <%-- 확장자 확인 --%>
	            $("#cmpylogoDelete").trigger("click");
	            alert(ext+Message.msg.fileCannotUplaod);
	        } else {
	            $("#Form").ajaxSubmit({
	                url      : "ND_uploadImgChk.do",
	                data     : { inputName     : 'multiFiles',
	                             maxWidthSize  : 0,
	                             maxHeightSize : 0,
	                             minWidthSize  : 200,
	                             minHeightSize : 100,
	                             maxFileSize   : 10240,
	                             fileExt : 'jpg,jpeg,gif,png'},
	                type     : "POST",
	                dataType : "text",
	                async    : false,
	                success  : function(response){
	                    if(response != "100") {
	                        alert(response);
	                        var control = $("#multiFiles");
	                        control.replaceWith(control = control.clone(true));
	                    }
	                }
	            });
	        }
	    }
	};
	
	var jscmpnyLocaList = function(status) {
        if($("select[name='"+status+"List'] option:selected").val() != ''){
             $("#"+status+"2").val($("select[name='"+status+"List'] option:selected").text());
             $("#"+status+"2").attr("readonly", true);
         } else {
             $("#"+status+"2").attr("readonly", false);
         }
    };
	
	</script>
</head>
<body>

<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
<!-- KICA WebUI 영역 -->
	<input type="hidden" name="SSN" id="SSN" value="${param.bizrno}" />
<!-- //KICA WebUI 영역 -->
	<input type="hidden" name="agr_pc"	id="agr_pc" value="true" />
	<input type="hidden" name="goodsCode" id="goodsCode" value="" />
	<input type="hidden" name="langNm" 	  id="langNm" 	 value="${param.langNm}" />
	<input type="hidden" name="langCode"  id="langCode"  value="00" />
	<input type="hidden" name="cmpnyNm"   id="cmpnyNm"   value="${param.cmpnyNm}"/>
	<input type="hidden" name="chargerNm" id="chargerNm" value="${loginData.userNm}"/>
	<input type="hidden" name="userId"    id="userId"    value="${loginData.userId}"/>
	<input type="hidden" name="telno"     id="telno"     value=""/>
	<input type="hidden" name="mbtlnum"   id="mbtlnum"   value="${loginData.mbtlnum}"/>
	<input type="hidden" name="email"     id="email"     value="${loginData.email}"/>
	<input type="hidden" name="presentnPrearngeDe"  id="presentnPrearngeDe" value=""/>
	<input type="hidden" name="agremOrder" id="agremOrder" value="1"/>
	<input type="hidden" name="agremEndDe" id="agremEndDe" value=""/>
	<input type="hidden" name="registId"  id="registId"  value="NIA"/>
	<input type="hidden" name="agremStatCd" id="agremStatCd" value="1001"/>
    <input type="hidden" name="bizrno"    id="bizrno"    value="${param.bizrno}">
  
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/offer_step_3.png" alt="정보입력" />			
			<h2>제공(판매) 권한 신청</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap join_info inputOffer">
		<p><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>

		<h4>필수정보</h4>
		
		<table class="tbl_st4">
			<tr>
				<th class="repu">담당자 명</th>
				<td>${loginData.userNm}</td>
			</tr>
		</table>
		
		<h4>기업정보</h4>
		<table class="tbl_st4">
			<tr>
				<th>기업 명</th>
				<td>${param.cmpnyNm}</td>
				<th>소재지</th>
				<td>
					<select id="cmpnyLoca" name="cmpnyLoca" style="width:70px;">
						<c:forEach items="${cmpnyLocaList}" var="cmLocal">
							<option value="${cmLocal.PRVCD}">&nbsp;&nbsp;${cmLocal.PRVNM}&nbsp;&nbsp;</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>회사로고</th>
				<td colspan="3">
					<div class="uploadFile">
						<input type="text" id="compnyLogo" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('multiFiles', 'compnyLogo');" id="cmpylogoDelete"/>							
			            	<span href="#" class="btns st3">
			            		파일선택
			            		<input type="file" name="multiFiles" id="multiFiles" class="mnlFile" accept=".gif,.jpg,.jpeg,.png" onchange="readURL(this);return false;" />
				    					<input type="hidden" name="fileDesc" id="multiFilesDesc" value=""/>
			            	</span>
		            	</div>
		            </div>
					<p class="desc">jpg, png (권장 160x120픽셀 ) 파일</p>
				</td>
			</tr>
			<tr>
				<th>대표전화</th>
				<td colspan="3" class="tel">
					<input type="text" name="telno1" id="telno1" maxlength="3"/> -
					<input type="text" name="telno2" id="telno2" maxlength="4"/> -
					<input type="text" name="telno3" id="telno3" maxlength="4"/>
				</td>
			</tr>
			<tr>
				<th>사업자 등록번호</th>
				<td colspan="3">
					${param.bizrno}
				</td>
			</tr>
		</table>
		
		<h4>구비서류 첨부<i>※ PDF파일로 업로드 하셔야 합니다.</i></h4>
		<table class="tbl_st4">
			<tr>
				<th class="requ">협약서(간인필수)</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="bassAgrmntFile1Name" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('bassAgrmntFile1', 'bassAgrmntFile1Name');"/>							
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="bassAgrmntFile1" id="bassAgrmntFile1" accept=".pdf" onchange="jsFileChk('bassAgrmntFile1', 10240, '1', -1, 5);"/>
				    			<input type="hidden" name="fileDesc" id="bassAgrmntFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>				
				</td>
			</tr>
			<tr>
				<th class="requ">등기부등본(법인등기부등본)</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="rgsbukTrnscrFile1Name" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('rgsbukTrnscrFile1', 'rgsbukTrnscrFile1Name');"/>
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="rgsbukTrnscrFile1" id="rgsbukTrnscrFile1" accept=".pdf" onchange="jsFileChk('rgsbukTrnscrFile1', 10240, '1', -1, 5);"/>
				    					<input type="hidden" name="fileDesc" id="rgsbukTrnscrFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>				
				</td>
			</tr>
			<tr>
				<th class="requ">신용평가서</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="cdltDocFile1Name" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제"  onclick="jsInputFileReset('cdltDocFile1', 'cdltDocFile1Name');" />							
			            	<span  class="btns st3">
			            		파일선택
			            		<input type="file" name="cdltDocFile1" id="cdltDocFile1" accept=".pdf" onchange="jsFileChk('cdltDocFile1', 10240, '1', -1, 5);"/>
				    					<input type="hidden" name="fileDesc" id="cdltDocFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>				
				</td>
			</tr>
			<tr>
				<th class="requ">재무제표(최근3년간)</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="fnlttFile1Name" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('fnlttFile1', 'fnlttFile1Name');"/>						
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="fnlttFile1" id="fnlttFile1" accept=".pdf" onchange="jsFileChk('fnlttFile1', 10240, '1', -1, 5);"/>
				    					<input type="hidden" name="fileDesc" id="fnlttFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>				
				</td>
			</tr>
			<tr>
				<th>벤처기업인증서</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="vnentrCrtfFile1Name" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('vnentrCrtfFile1', 'vnentrCrtfFile1Name');"/>							
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="vnentrCrtfFile1" id="vnentrCrtfFile1" accept=".pdf" onchange="jsFileChk('vnentrCrtfFile1', 10240, '1', -1, 5);"/>
				    					<input type="hidden" name="fileDesc" id="vnentrCrtfFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>				
				</td>
			</tr>
			<tr>
				<th>직접생산증명서</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="directPrdctnCrtfFile1Name" readonly="readonly" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제"  onclick="jsInputFileReset('directPrdctnCrtfFile1', 'directPrdctnCrtfFile1Name');"/>							
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="directPrdctnCrtfFile1" id="directPrdctnCrtfFile1" accept=".pdf" onchange="jsFileChk('directPrdctnCrtfFile1', 10240, '1', -1, 5);"/>
				    					<input type="hidden" name="fileDesc" id="directPrdctnCrtfFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>				
				</td>
			</tr>
		</table>
		
		<div class="btnArea rig">
			<a href="/korean/pt/index.do" class="btns st2">취소</a>
			<a href="#" onclick="jsCheckSSN();" class="btns st1 icn_r next">다음</a>
		</div>
	</div>
	<!--// content -->
	</form>
	<!-- KICA WebUI DIV 영역 -->
	<div id="KICA_SECUKITNXDIV_ID"></div>
	<!-- //KICA WebUI DIV 영역 -->
</body>
</html>