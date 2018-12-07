<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8" />
  <title>정보수정 - 2차 협약 신청</title>
  <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
    
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	
  <op:jsTag type="openworks" items="ui, validate, form" />
  <op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

	<script type="text/javascript">
		$().ready(function() {
	       $("#dataForm").validate({
	            rules: {
	                telno1           	 : { required : true, number: true}
	               ,telno2           	 : { required : true, number: true}
	               ,telno3           	 : { required : true, number: true}
	            }
	            ,messages: {}
				 });
	       
			// 등기부등본
	       	$("#ckRgsbukTrnscrFile").change(function()
	       	{
				if  ($("#ckRgsbukTrnscrFile").is(":checked")) // 체크되면..
	           	{
	            	// 이전 협약의 첨부자료를 세팅
	               	$("#rgsbukTrnscrfileInput1").val('${bassAgremView.rgsbukTrnscrFile[0].localNm}') ;
	               	$("#hdRgsbukTrnscrFile").val('${bassAgremView.rgsbukTrnscrFile[0].fileId}') ;
	           	}
	           	else
	           	{
	           	    // 새로운 첨부파일을 받을 준비를 한다.
	            	jsInputFileReset('','','rgsbukTrnscrFile1','rgsbukTrnscrfileInput1');
	            	$("#hdRgsbukTrnscrFile").val('');
	           	}
	       	});
			// 신용평가서
	       	$("#ckCdltDocFile").change(function()
   	       	{
   				if  ($("#ckCdltDocFile").is(":checked")) // 체크되면..
   	           	{
   	            	// 이전 협약의 첨부자료를 세팅
   	               	$("#cdltDocfileInput1").val('${bassAgremView.cdltDocFile[0].localNm}') ;
   	             	$("#hdCdltDocFile").val('${bassAgremView.cdltDocFile[0].fileId}') ;
   	           	}
   	           	else
   	           	{
   	           	    // 새로운 첨부파일을 받을 준비를 한다.
   	            	jsInputFileReset('','','cdltDocFile1','cdltDocfileInput1');
   	            	$("#hdCdltDocFile").val('');
   	           	}
   	       	});
			// 재무제표
	       	$("#ckFnlttFile").change(function()
   	       	{
   				if  ($("#ckFnlttFile").is(":checked")) // 체크되면..
   	           	{
   	            	// 이전 협약의 첨부자료를 세팅
   	               	$("#fnlttfileInput1").val('${bassAgremView.fnlttFile[0].localNm}') ;
   	             	$("#hdFnlttFile").val('${bassAgremView.fnlttFile[0].fileId}') ;
   	           	}
   	           	else
   	           	{
   	           	    // 새로운 첨부파일을 받을 준비를 한다.
   	            	jsInputFileReset('','','fnlttFile1','fnlttfileInput1');
   	            	$("#hdFnlttFile").val('');
   	           	}
   	       	});
			// 벤쳐기업증명서			
	       	$("#ckVnentrCrtfFile").change(function()
   	       	{
   				if  ($("#ckVnentrCrtfFile").is(":checked")) // 체크되면..
   	           	{
   	            	// 이전 협약의 첨부자료를 세팅
   	               	$("#vnentrCrtffileInput1").val('${bassAgremView.vnentrCrtfFile[0].localNm}') ;
   	             	$("#hdVnentrCrtfFile").val('${bassAgremView.vnentrCrtfFile[0].fileId}') ;
   	           	}
   	           	else
   	           	{
   	           	    // 새로운 첨부파일을 받을 준비를 한다.
   	            	jsInputFileReset('','','vnentrCrtfFile1','vnentrCrtffileInput1');
   	            	$("#hdVnentrCrtfFile").val('');
   	           	}
   	       	});
			// 직접생산증명서
	       	$("#ckDirectPrdctnCrtfFile").change(function()
   	       	{
   				if  ($("#ckDirectPrdctnCrtfFile").is(":checked")) // 체크되면..
   	           	{
   	            	// 이전 협약의 첨부자료를 세팅
   	               	$("#directPrdctnCrtffileInput1").val('${bassAgremView.directPrdctnCrtfFile[0].localNm}') ;
   	             	$("#hdDirectPrdctnCrtfFile").val('${bassAgremView.directPrdctnCrtfFile[0].fileId}') ;
   	           	}
   	           	else
   	           	{
   	           	    // 새로운 첨부파일을 받을 준비를 한다.
   	            	jsInputFileReset('','','directPrdctnCrtfFile1','directPrdctnCrtffileInput1');
   	            	$("#hdDirectPrdctnCrtfFile").val('');
   	           	}
   	       	});
	       	
	    });
	    
	    // '2차 협약' 클릭
	    var jsSaveAction = function() {
	        if(checkEditor()) {	
	            $("input[type=file]").each(function() {
	                if (this.value == '') {
	                    $("#"+this.id).attr("disabled","disabled");
	                }
	            });
	            $("#telno").val($("#telno1").val() + "-" + $("#telno2").val() + "-" + $("#telno3").val());
	            if(confirm("2차 협약을 요청 하시겠습니까?")) {
	                $("#dataForm").attr("action", "BD_suppliInsertAction.do");
	                $("#dataForm").submit();
				}
			}
		};

	   var jsLsitAction = function() {
            $("#dataForm").attr("action", "BD_suppliIndex.do");
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
	                    //var htmlVal = "";
	                   // htmlVal = $("#"+inputId).html();
	                    //$("input[name="+inputId+"]").remove();
	                    //$("#"+inputId).append(htmlVal);
	                    ret = false;
	                }
	                else {
	                    ret = true;
	                }
	            }
	
	        });
	        return ret;
	    };
	
	   // '파일선택'버튼
	   var jsFileChk = function(chkbox, fileId, inputId, s, fileSeq, maxCnt) {
		    
	      	var inputFile = document.getElementById(fileId);
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
	                jsInputFileReset('','',inputId,inputIdFake);
	                return false;
	            }
	            
	    		if (inputFile.files[0].size > (s * 1024) && s != 0) {
	                alert(Message.msg.fileSizeOver);
	                jsInputFileReset('','',inputId,inputIdFake);
	            	return false;
	            }
	    		
	    		$("#"+inputId).val(filePath);
	    		
	    		if  (chkbox != "") 
	    		{
	    			$("#"+chkbox).attr('checked', false);
	    		}
	    	}
	      	
	  	};
	
	  	//첨부된 파일중 ajax를 이용하여 파일 삭제
	    var jsFileDelete = function(element, seq, id){
	        if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
	            return false;
					
	        var url = "BD_fileDelete.do";
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
	        
	        if($("#cmpnyLoca").val()==null || $("#cmpnyLoca").val().trim()==""  || $("#cmpnyLoca").val()=="1099"){
	            alert("소재지를 선택하여 주십시오.");
	            $("#cmpnyLoca").focus();
	            return false;
	        }
	        
	        if($("#telno1").val() == "" || $.trim($("#telno2").val()) == "" || $.trim($("#telno3").val()) == "" ){
                alert('대표번호를 입력해주세요.');
                $("#telno1").focus();
                return false;
	        }
			
	        if ((($("input[name=bassAgrmntFile1]").val() == null || $("input[name=bassAgrmntFile1]").val() == "") || $("#bassAgrmntfileInput1").val() == ""  ))
	        {
	            alert("협약서를 첨부하여 주십시오.");
	            $("#bassAgrmntFile1Btn").focus();
	            return false;
	        }
	        else if (((($("#rgsbukTrnscrFile1").val()==null ||  $("input[name=rgsbukTrnscrFile1]").val() == "") || $("#rgsbukTrnscrfileInput1").val() == ""))
                     && !$("#ckRgsbukTrnscrFile").is(":checked")) // 체크가 안되어있다면..
            {
	                alert("등기부등본을 첨부하여 주십시오.");
		            $("#rgsbukTrnscrFile1Btn").focus();
		            return false;
                	            
	        }
	        else if (((($("#cdltDocFile1").val()==null ||  $("input[name=cdltDocFile1]").val() == "") && $("#cdltDocfileInput1").val() == ""))
	             && !$("#ckCdltDocFile").is(":checked")) // 체크가 안되어있다면..
            {
		            alert("신용평가서를 첨부하여 주십시오.");
		            $("#cdltDocFile1Btn").focus();
		            return false;
            }
	        else if (((($("#fnlttFile1").val()==null ||  $("input[name=fnlttFile1]").val() == "") &&  $("#fnlttfileInput1").val() == ""))
	            && !$("#ckFnlttFile").is(":checked")) // 체크가 안되어있다면..
            {
		            alert("재무제표을 첨부하여 주십시오.");
		            $("#fnlttFile1Btn").focus();
		            return false;
	        }	     	
	     	
	        // vaildate 체크 성공시 true 반환
	        return true;
	    };
	
	    var jsInputFileReset = function(chkbox, hidden, fileId, textId) {
	        var control = $("#" + fileId);
	        var text = $("#" + textId);
	        control.replaceWith( control = control.clone( true ) );
	        text.val("");
	        
	        if  (chkbox != "") 
    		{
    			$("#"+chkbox).attr('checked', false);
    		}
	        if  (hidden != "") 
    		{
    			$("#"+hidden).val('');
    		}
	    };
	    
	    var readURL = function (input) {    <%-- 업로드 파일 미리보기 --%>
	    
	    if (input.files && input.files[0]) {
	        fileName = input.files[0].name; // 파일명
	        $("#multiFilesInput").val(fileName);
	        ext = fileName.substring(fileName.lastIndexOf('.') + 1);//확장자
	        ext = ext.toLowerCase();
	      
	        if(ext != 'gif' && ext != 'jpg' && ext !='jpeg' && ext !='png') {  <%-- 확장자 확인 --%>
	            $("#cmpylogoDelete").trigger("click");
	            alert(ext+Message.msg.fileCannotUplaod);
	        } else {
	          /*   $("#dataForm").ajaxSubmit({
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
	                success  : function(response){ */
	                    var response="100";
	                    $("img#img1").remove();
	                    if(response != "100") {
	                        alert(response);
	                        var control = $("#multiFiles");
	                        control.replaceWith(control = control.clone(true));
	                        $("#multiFilesInput").val('');
	                    } else if(response == "100") {
	                      
	                        if(window.FileReader){
	                            /*IE 10 이상에서는 FileReader 이용*/
	                            var reader = new FileReader();
	                            reader.onload = function(e){
	                                if(e.target.result.indexOf("image/gif") > 0 || e.target.result.indexOf("image/jpg") > 0 || e.target.result.indexOf("image/jpeg") > 0 || e.target.result.indexOf("image/png") > 0){
	                                    var html ='';
	                                    html += "<img src=\""+e.target.result+"\" alt=\"업로드 이미지 미리보기\" id=\"img1\"/>";
	                                    $("#imgPrev1 .thumbimg").append(html);
	                                }
	                            };
	                            reader.readAsDataURL(input.files[0]); 
	                        }else{
	                            
	                          var html ='';
	                            html += "<img src=\"" + "\"   alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" id=\"img1\"/>";
	                            $("#imgPrev1 .thumbimg").append(html);
	                        }
	                        
	                    }
	               /*  } 
	            });*/
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
	
  //서비스이미지 용량,크기,비율 확인(이미지아이디, 최대넓이, 최대높이, 최소넓이, 최소높이, 용량, 확장자, seq, imgType, fileSeq, 파일첨부갯수)
    var jsPreview = function(inputId, w, h, sw, sh, s, fileExt ,seq, imgType, fileSeq, maxCnt, fileThis) {

        var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt,seq);
		
        if (fileCountResult) {
            var source = $("input[name="+inputId+"]").val();
            
            var lastDot = source.lastIndexOf('.');
            var ext = source.substring(lastDot + 1);
            if(fileExt.indexOf(ext.toLowerCase()) == -1){
                alert( "지원하지 않는 이미지 형식입니다.\n jpg, gif, png 형식만 가능합니다." );
                jsInputFileReset('','',inputId,fileThis);
            }else{
    			readURL(fileThis);
            }
        }
    };
    
    // '양식다운로드' 클릭
    var jsDownloadForm = function() {
        
        window.location = '/resources/download/Agreement2.hwp';
    }
    

	</script>  
 </head>

 <body>

<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
<!-- KICA WebUI 영역 -->
	<input type="hidden" name="SSN" id="SSN" value="${param.bizrno}" />
<!-- //KICA WebUI 영역 -->
	<input type="hidden" name="agr_pc"	id="agr_pc" value="true" />
	<input type="hidden" name="goodsCode" id="goodsCode" value="" />
	<input type="hidden" name="cmpnyNm"   id="cmpnyNm"   value="${svcStror.langStoreNm}"/> <%-- ${param.cmpnyNm} --%>
	<input type="hidden" name="chargerNm" id="chargerNm" value="${svcStror.storeChargerNm}"/>
	<input type="hidden" name="userId"    id="userId"    value="${loginData.userId}"/>
	<input type="hidden" name="telno"     id="telno"     value=""/>
	<input type="hidden" name="mbtlnum"   id="mbtlnum"   value="${loginData.mbtlnum}"/>
	<input type="hidden" name="email"     id="email"     value="${loginData.email}"/>
    <input type="hidden" name="bizrno"    id="bizrno"    value="${svcStror.bizrno}">
	<input type="hidden" name="presentnPrearngeDe"  id="presentnPrearngeDe" value=""/>
	<input type="hidden" name="agremOrder" id="agremOrder" value="${degreeInfo.bassDegree}"/>
	<input type="hidden" name="agremEndDe" id="agremEndDe" value="${degreeInfo.bassDegreeEnddt}"/>
	<input type="hidden" name="agremStatCd" id="agremStatCd" value="1001"/>
	<!-- content -->
	<section class="lay_lnb">
		<div class="conWrap">
			
			<div class="join_info inputOffer">	
				<p><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>
		
				<h4>필수정보</h4>
				
				<table class="tbl_st4">
					<tr>
						<th>담당자명</th>
						<td>${svcStror.storeChargerNm}</td>
					</tr>
				</table>
				
				<h4>기업정보</h4>
				<table class="tbl_st4">
					<tr>
						<th>기업 명</th>
						<td>${svcStror.langStoreNm}</td>
						<th class="requ">소재지</th>
						<td><select id="cmpnyLoca" name="cmpnyLoca" style="width:100px;">
								<c:forEach items="${cmpnyLocaList}" var="cmLocal">
								
								<c:choose>
							    <c:when test="${cmLocal.PRVCD eq bassAgremView.cmpnyLoca }"> <%-- 1차 협약때 소재지가 있다면 디폴트로 설정한다. --%> 
								    <option value="${cmLocal.PRVCD}" selected="true">${cmLocal.PRVNM}</option>
							    </c:when>
							    <c:otherwise>
							    	<option value="${cmLocal.PRVCD}">${cmLocal.PRVNM}</option>	
							    </c:otherwise>
							    </c:choose>
				            		
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>회사로고</th>
						<td colspan="3" class="thumb">							
							<span id="imgPrev1">
								<p class="thumbimg">
								<c:if test="${not empty svcStror.fileList[0]}">
										<img src="${svcStror.fileList[0].fileUrl}" alt="${svcStror.fileList[0].localNm}" id="img1">
								</c:if>
								</p>
							</span>
							<div class="uploadFileWrap">
								    <input type="hidden" name="multiFileSeq" value="${svcStror.storeImageFileSeq}" /> 
									 <c:if test="${empty svcStror.fileList[0]}">
									<div class="uploadFile">
										<!-- file upload -->
										<input type="text" id="multiFilesInput"  readonly="readonly" title="파일명" value="${svcStror.fileList[0].localNm}" >
										<div>
											<img onclick="jsInputFileReset('','','multiFiles','multiFilesInput');$('img#img1').remove()" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
											<span class="btns st3" id="multiFilesBtn"> 파일선택 
											<input type="file" name="multiFiles" id="multiFiles" title="파일찾기"
												 onchange="jsPreview('multiFiles${i}', 0, 0, 400, 300, 1024, 'jpg,gif,png',1,'Img', -1, 5,this);" 
												/>
											</span>
										</div>
										<!-- //file upload -->
									</div>
									</c:if>
									 <c:if test="${not empty svcStror.fileList[0]}">
									 <input type="hidden" name="multiFilesVal1" value="${svcStror.fileList[0].fileId}">
										<div class="uploaded">
											<span>
												<a href="/component/file/ND_fileDownload.do?id=${svcStror.fileList[0].fileId }"
													title="${svcStror.fileList[0].localNm}" class="aDeisable">${svcStror.fileList[0].localNm}
													(${svcStror.fileList[0].fileSize}, ${svcStror.fileList[0].fileType})
												</a>
												 <a href="#none" onclick="jsFileDelete(this, ${svcStror.fileList[0].fileSeq}, '${svcStror.fileList[0].fileId}'); return false;">삭제</a> 
											</span>
										</div>
									</c:if>         
								<p class="desc">jpg, png (권장 160x120픽셀 )파일</p>
							</div>
						</td>
					</tr>
					<tr>
						<th class="requ">대표전화</th>
						<td colspan="3" class="tel">
							<input type="text" name="telno1" id="telno1" value="${svcStror.reprsntTelno1}" maxlength="3"/> -
							<input type="text" name="telno2" id="telno2" value="${svcStror.reprsntTelno2}" maxlength="4"/> -
							<input type="text" name="telno3" id="telno3" value="${svcStror.reprsntTelno3}" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>사업자 등록번호</th>
						<td colspan="3">
							${svcStror.bizrno}
						</td>
					</tr>
				</table>
				
				<h4>구비서류 첨부<i>※ PDF파일로 업로드 하셔야 합니다.</i></h4>
				
				<div style="margin-bottom: 10px;">
					<div style="border:1px solid white; line-height:40px; float:left;padding-right: 10px;">
						<span style="vertical-align:middle;font-size: 25px;font-weight: bold;color: red;">필독</span>
					</div>				
					<!-- span style="text-decoration: underline;">제출협약서의 협약체결일 일자는 신청일로 작성 하시기 바랍니다.</span-->					  
					<span style="text-decoration: underline;">2차협약서 작성시 연장 신청의경우 협약일을 3월1일로 작성하여 주시기 바랍니다</span>
					<span style="text-decoration: underline;">또한 협약서에 관인을 꼭 찍어주시기 바랍니다.</span><br />
					<span style="text-decoration: underline;">2016년도에 체결한 기업(개인)은 재무제표와 신용평가서는 필히 업데이트 하시기 바랍니다.</span>
				</div>
				
				<table class="tbl_st4">
					<tr>
						<th class="requ">협약서</th>
						<td>
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<div class="uploadFile" <c:if test="${not empty bassAgrem.bassAgrmntFile[i-1]}">style="display:none;"</c:if>>
									<!-- file upload -->
									<input type="text" id="bassAgrmntfileInput${i}" style="width: 520px;" readonly="readonly" title="파일명">
									<div>
										<img style="float:left;" onclick="jsInputFileReset('','','bassAgrmntFile${i}','bassAgrmntfileInput${i}');" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
										<span style="float:left;" class="btns st3" id="bassAgrmntFile${i}Btn"> 파일선택 
											<input type="file" name="bassAgrmntFile${i}" id="bassAgrmntFile${i}"  title="파일찾기" accept=".pdf"
												   <c:if test="${not empty dataVo.bassAgrmntFile[i-1]}">disabled</c:if>
												   onchange="jsFileChk('','bassAgrmntFile${i}', 'bassAgrmntfileInput${i}', 10240, '1','${dataVo.bassAgrmntFileSeq}', 1); " 
											/>
										</span>
										<span style="float:left;width:100px;cursor: pointer;" class="btns st3" id="spnDownloadForm" onclick="jsDownloadForm();">양식다운로드</span>
									</div>
									<!-- //file upload -->
								</div>
								<input type="hidden" name="bassAgrmntFileVal${i}" value="${bassAgrem.bassAgrmntFile[i-1].fileId}">
								<c:if test="${not empty bassAgrem.bassAgrmntFile[i-1]}">
									<div class="uploaded">
										<span >
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.bassAgrmntFile[i-1].fileId }"
												title="${bassAgrem.bassAgrmntFile[i-1].localNm}" class="aDeisable">${bassAgrem.bassAgrmntFile[i-1].localNm}
												(${bassAgrem.bassAgrmntFile[i-1].fileSize}, ${bassAgrem.bassAgrmntFile[i-1].fileType})
											</a> 
											<a href="#none" onclick="jsFileDelete(this, ${bassAgrem.bassAgrmntFile[i-1].fileSeq}, '${bassAgrem.bassAgrmntFile[i-1].fileId}'); return false;">삭제</a>
										</span>
									</div>
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th class="requ">등기부등본</th>
						<td>
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<div class="uploadFile" <c:if test="${not empty bassAgrem.rgsbukTrnscrFile[i-1]}">style="display:none;"</c:if>>
									
									<input id="ckRgsbukTrnscrFile" type="checkbox" name="ckRgsbukTrnscrFile"  <c:if test="${empty bassAgremView.rgsbukTrnscrFile[0]}">disabled</c:if>>
									<label for="ckRgsbukTrnscrFile">1차 협약과동일</label>
									<input type="hidden" name="hdRgsbukTrnscrFile" value="${bassAgremView.rgsbukTrnscrFile[0].fileId}">
									
									
									<!-- file upload -->
									<input type="text" id="rgsbukTrnscrfileInput${i}" style="width: 520px;" readonly="readonly" title="파일명">
									<div>
										<img onclick="jsInputFileReset('ckRgsbukTrnscrFile','hdRgsbukTrnscrFile','rgsbukTrnscrFile${i}','rgsbukTrnscrfileInput${i}');" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
										<span class="btns st3" id="rgsbukTrnscrFile${i}Btn"> 파일선택 
											<input type="file" name="rgsbukTrnscrFile${i}" id="rgsbukTrnscrFile${i}"  title="파일찾기" accept=".pdf"
												   <c:if test="${not empty dataVo.rgsbukTrnscrFile[i-1]}">disabled</c:if>
												   onchange="jsFileChk('ckRgsbukTrnscrFile','rgsbukTrnscrFile${i}', 'rgsbukTrnscrfileInput${i}', 10240, '1','${dataVo.rgsbukTrnscrFile}', 1); " 
											/>
										</span>
									</div>
									<!-- //file upload -->
								</div>
								<input type="hidden" name="rgsbukTrnscrFileVal${i}" value="${bassAgrem.rgsbukTrnscrFile[i-1].fileId}">
								
							</c:forEach>			            
						</td>
					</tr>
					<tr>
						<th class="requ">신용평가서</th>
						<td>
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<div class="uploadFile" <c:if test="${not empty bassAgrem.cdltDocFile[i-1]}">style="display:none;"</c:if>>
									
									<input id="ckCdltDocFile" type="checkbox" name="ckCdltDocFile" <c:if test="${empty bassAgremView.cdltDocFile[0]}">disabled</c:if>>
									<label for="ckCdltDocFile">1차 협약과동일</label>
									<input type="hidden" name="hdCdltDocFile" value="${bassAgremView.cdltDocFile[0].fileId}">
									
									<!-- file upload -->
									<input type="text" id="cdltDocfileInput${i}" style="width: 520px;" readonly="readonly" title="파일명">
									<div>
										<img onclick="jsInputFileReset('ckCdltDocFile','hdCdltDocFile','cdltDocFile${i}','cdltDocfileInput${i}');" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
										<span class="btns st3" id="cdltDocFile${i}Btn"> 파일선택 
											<input type="file" name="cdltDocFile${i}" id="cdltDocFile${i}" title="파일찾기" accept=".pdf"
												   <c:if test="${not empty dataVo.cdltDocFile[i-1]}">disabled</c:if>
												   onchange="jsFileChk('ckCdltDocFile','cdltDocFile${i}', 'cdltDocfileInput${i}', 10240, '1','${dataVo.rgsbukTrnscrFile}', 1); " 
											/>
										</span>
									</div>
									<!-- //file upload -->
								</div>
								<input type="hidden" name="cdltDocFileVal${i}" value="${bassAgrem.cdltDocFile[i-1].fileId}">
								
							</c:forEach>		            
						</td>
					</tr>
			 	<tr>
						<th class="requ">재무제표</th>
						<td>
						
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<div class="uploadFile" <c:if test="${not empty bassAgrem.fnlttFile[i-1]}">style="display:none;"</c:if>>
									
									<input id="ckFnlttFile" type="checkbox" name="ckFnlttFile" <c:if test="${empty bassAgremView.fnlttFile[0]}">disabled</c:if>>
									<label for="ckFnlttFile">1차 협약과동일</label>
									<input type="hidden" name="hdFnlttFile" value="${bassAgremView.fnlttFile[0].fileId}">
									
									<!-- file upload -->
									<input type="text" id="fnlttfileInput${i}" style="width: 520px;" readonly="readonly" title="파일명">
									<div>
										<img onclick="jsInputFileReset('ckFnlttFile','hdFnlttFile','fnlttFile${i}','fnlttfileInput${i}');" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
										<span class="btns st3" id="fnlttFile${i}Btn"> 파일선택 
											<input type="file" name="fnlttFile${i}" id="fnlttFile${i}" title="파일찾기" accept=".pdf"
												   <c:if test="${not empty dataVo.fnlttFile[i-1]}">disabled</c:if>
												   onchange="jsFileChk('ckFnlttFile','fnlttFile${i}', 'fnlttfileInput${i}', 10240, '1','${dataVo.fnlttFile}', 1); " 
											/>
										</span>
									</div>
									<!-- //file upload -->
								</div>
								<input type="hidden" name="fnlttFileVal${i}" value="${bassAgrem.fnlttFile[i-1].fileId}">
								
							</c:forEach>		            
						</td>
					</tr>
					<tr>
						<th>벤처기업인증서</th>
						<td>
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<div class="uploadFile" <c:if test="${not empty bassAgrem.vnentrCrtfFile[i-1]}">style="display:none;"</c:if>>
									
									<input id="ckVnentrCrtfFile" type="checkbox" name="authTypeR" <c:if test="${empty bassAgremView.vnentrCrtfFile[0]}">disabled</c:if>>
									<label for="ckVnentrCrtfFile">1차 협약과동일</label>
									<input type="hidden" name="hdVnentrCrtfFile" value="${bassAgremView.vnentrCrtfFile[0].fileId}">
									
									<!-- file upload -->
									<input type="text" id="vnentrCrtffileInput${i}" style="width: 520px;" readonly="readonly" title="파일명">
									<div>
										<img onclick="jsInputFileReset('ckVnentrCrtfFile','hdVnentrCrtfFile','vnentrCrtfFile${i}','vnentrCrtffileInput${i}');" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
										<span class="btns st3" id="vnentrCrtfFile${i}Btn"> 파일선택 
											<input type="file" name="vnentrCrtfFile${i}" id="vnentrCrtfFile${i}" title="파일찾기" accept=".pdf"
												   <c:if test="${not empty dataVo.vnentrCrtfFile[i-1]}">disabled</c:if>
												   onchange="jsFileChk('ckVnentrCrtfFile','vnentrCrtfFile${i}', 'vnentrCrtffileInput${i}', 10240, '1','${dataVo.vnentrCrtfFile}', 1); " 
											/>
										</span>
									</div>
									<!-- //file upload -->
								</div>
								<input type="hidden" name="vnentrCrtfFileVal${i}" value="${bassAgrem.vnentrCrtfFile[i-1].fileId}">
							
							</c:forEach>		            
						</td>
					</tr>
					<tr>
						<th>직접생산증명서</th>
						<td>
							
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<div class="uploadFile" <c:if test="${not empty bassAgrem.directPrdctnCrtfFile[i-1]}">style="display:none;"</c:if>>
									
									<input id="ckDirectPrdctnCrtfFile" type="checkbox" name="ckDirectPrdctnCrtfFile" <c:if test="${empty bassAgremView.directPrdctnCrtfFile[0]}">disabled</c:if>>
									<label for="ckDirectPrdctnCrtfFile">1차 협약과동일</label>
									<input type="hidden" name="hdDirectPrdctnCrtfFile" value="${bassAgremView.directPrdctnCrtfFile[0].fileId}">
									
									<!-- file upload -->
									<input type="text" id="directPrdctnCrtffileInput${i}" style="width: 520px;" readonly="readonly" title="파일명">
									<div>
										<img onclick="jsInputFileReset('ckDirectPrdctnCrtfFile','hdDirectPrdctnCrtfFile','directPrdctnCrtfFile${i}','directPrdctnCrtffileInput${i}');" src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제">
										<span class="btns st3" id="directPrdctnCrtfFile${i}Btn"> 파일선택 
											<input type="file" name="directPrdctnCrtfFile${i}" id="directPrdctnCrtfFile${i}" title="파일찾기" accept=".pdf"
												   <c:if test="${not empty dataVo.vnentrCrtfFile[i-1]}">disabled</c:if>
												   onchange="jsFileChk('ckDirectPrdctnCrtfFile','directPrdctnCrtfFile${i}', 'directPrdctnCrtffileInput${i}', 10240, '1','${dataVo.directPrdctnCrtfFile}', 1); " 
											/>
										</span>
									</div>
									<!-- //file upload -->
								</div>
								<input type="hidden" name="directPrdctnCrtfFileVal${i}" value="${bassAgrem.directPrdctnCrtfFile[i-1].fileId}">
								
							</c:forEach>		            
						</td>
					</tr> 
				</table>
				
				<div class="btnArea rig">
					<a href="javascript:jsSaveAction();" class="btns st1 icn icnCheck2">2차 협약신청</a>
					<a href="javascript:jsLsitAction();" class="btns st1 icn icnList">목록보기</a>
<%--					
[${bassAgremView.cmpnyNm}]
[${bassAgremView.lastAgrmntFileSeq}]
[${bassAgremView.bassAgrmntFileSeq}]
[${bassAgremView.rgsbukTrnscrFileSeq}]
[${bassAgremView.vnentrCrtfFileSeq}]
[${bassAgremView.directPrdctnCrtfFileSeq}]
[${bassAgremView.cdltDocFileSeq}]
[${bassAgremView.fnlttFileSeq}]
[${bassAgremView.agremNo}]
[${bassAgremView.fnlttFile[0]}]
        
<c:if test="${not empty bassAgremView.lastAgrmntFile[0]}">          ${bassAgremView.lastAgrmntFile[0].localNm}          </c:if>
<c:if test="${not empty bassAgremView.bassAgrmntFile[0]}">          ${bassAgremView.bassAgrmntFile[0].localNm}          </c:if>
<c:if test="${not empty bassAgremView.rgsbukTrnscrFile[0]}">        ${bassAgremView.rgsbukTrnscrFile[0].localNm}        </c:if>
<c:if test="${not empty bassAgremView.vnentrCrtfFile[0]}">          ${bassAgremView.vnentrCrtfFile[0].localNm}          </c:if>
<c:if test="${not empty bassAgremView.directPrdctnCrtfFile[0]}">    ${bassAgremView.directPrdctnCrtfFile[0].localNm}    </c:if>
<c:if test="${not empty bassAgremView.cdltDocFile[0]}">             ${bassAgremView.cdltDocFile[0].localNm}             </c:if>
<c:if test="${not empty bassAgremView.fnlttFile[0]}">               ${bassAgremView.fnlttFile[0].localNm}               </c:if>				
--%>

				</div>
			</div>
		</div>
	</section>
	<!--// content -->

	</form>
	
	<!-- <div id="loading-container" class="loading-container">
        <div class="loading"></div>
        <div id="loading-text">loading</div>
    </div> -->
 </body>
</html>