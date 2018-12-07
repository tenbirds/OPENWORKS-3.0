<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 정보 | 클라우드스토어 씨앗</title>	
   	<op:jsTag type="spi" items="form, validate, multifile, colorpicker" />
	
	<style type="text/css">
		#containerLogo {position:relative; width:990px; height:170px; margin:0 auto; overflow:hidden}
		#containerLogoTitle img {position:absolute; top:0; left:0} 
		#containerLogo .result > * {position:absolute;}
 		#containerLogo .result .inertxt {line-height:normal; }
	</style>
	<script type="text/javascript">
		$(document).ready(function(){	
	   	    
	   	    var logoDirect = '<c:out value="${cmUserView.logoDirectRegistAt}"/>'; //로고 타이틀 직접 등록 여부 
	   	    // 취소 버튼 클릭 시 데이터베이스에 저장된 상태로 보이도록 하기 위해 사용
		    cmOpenInfo = {
			    logoTitleWidthLc  : <c:out value="${cmUserView.logoTitleWidthLc}" default="0" />,	        
			    logoTitleVrticlLc  : <c:out value="${cmUserView.logoTitleVrticlLc}" default="0" />,	  
			    logoTitleFont  : '<c:out value="${cmUserView.logoTitleFont}" />',	   
			    logoTitleFontSize : '<c:out value="${cmUserView.logoTitleFontSize}" default="34" />',	        
			    logoTitleColor : '<c:out value="${cmUserView.logoTitleColor}" />'	        
			};
	   	  
		    // 이벤트 설정 함수 호출
		    jsInitEvent();
	
		    // 폰트
		    <c:if test="${empty cmUserView.logoTitleFont}">
		    $("select[name=logoTitleFont]").val('gulim');
			</c:if>
			<c:if test="${not empty cmUserView.logoTitleFont}">
			$("select[name=logoTitleFont]").val('<c:out value="${cmUserView.logoTitleFont}" />');	   
			</c:if>
		    
		    // 폰트 사이즈
		    $("select[name=logoTitleFontSize]").val('<c:out value="${cmUserView.logoTitleFontSize}" default="40" />');
	
		 	// text 로고의 초기 위치 설정
	    	var left = $("input[name=logoTitleWidthLc]").val();
	    	var top  = $("input[name=logoTitleVrticlLc]").val();
	    	
	    	$("#textLogo").css({ "top": parseInt(top, 10), "left": parseInt(left, 10) });
	    	$("#textLogoMenu").css({ "top": parseInt(top, 10), "left": parseInt(left, 10) });
	
	    	// 컬러픽커 기본 설정 항목 처리
			$("#logoTitleColor").css('border-color','#' + $( "#logoTitleColor" ).val());
			//$( "#logoTitleColor" ).css('background-color','#' + $( "#logoTitleColor" ).val());
			
			// 화면로딩시 로고타이틀 미리보기 클릭 이벤트 발생처리
			$("#logoPreview" ).trigger("click");
	
			jsTrShowHide(logoDirect);  //  로고 등록 선택  N: 기존 로고 Y: 직접등록
			
		    
		    var cmmntyDc  = $("#cmmntyDc").val();
		    if(cmmntyDc !=""){
		    	$("#cmmntyDc_bytes").html( cmmntyDc.bytes() );
		    }
		});
	
		// 화면로딩시 필요한 이벤트 처리
		var jsInitEvent = function() {
	
		    // text 드레그 가능하게
			$("#textLogo").draggable({ 
			    containment: "#containerLogo", 
			    scroll: false,
			    stop: function( event, ui ) {
			    	$("input[name=logoTitleWidthLc]").val(parseInt(ui.position.left, 10));
			    	$("input[name=logoTitleVrticlLc]").val(parseInt(ui.position.top, 10));
			    }
			});
			
		    // 컬러 색상 처리 이벤트 및 객체 연결
			$("#logoTitleColor").colpick({
				layout:'hex',
				//submit:0,
				colorScheme:'dark',
// 				onChange : function(hsb, hex, rgb, el, bySetColor) {
				    
// 				    $(el).css('border-color','#'+hex);
//  					$(el).css('background-color','#'+hex);
// 					$(el).css('color','#'+hex);
// 					if(hex == 'ffffff'){
// 					   $(el).css('color','#000000');
// 					}
// 					if(!bySetColor) $(el).val(hex);
// 				},
				onSubmit:function(hsb, hex, rgb, el, bySetColor) {
				    $(el).css('border-color','#'+hex);
					$(el).css('color','#'+hex);
					if(!bySetColor) $(el).val(hex);
					$(el).colpickHide();
				}
			}).keyup(function(){
				$(this).colpickSetColor(this.value);
			});
		    
			// 미리보기 버튼 클릭 이벤트 설정
			$("#logoPreview").click(function() {
			    var logoTitle         = $("#logoTitle").val();
			    var logoTitleFontSize = $("select[name=logoTitleFontSize]").val();
			    var logoTitleFont     = $("select[name=logoTitleFont]").val();
// 			    alert(logoTitleFont);
			    var logoTitleColor    = $("input[name=logoTitleColor]").val();
	
			    var html = '<P id="preLogo" style="font-family:\'' + logoTitleFont + '\'; font-size:' + logoTitleFontSize + 'px; font-style:italic; color:#' + logoTitleColor + '">' + logoTitle + '</p>';
			    $( "#textLogo" ).html(html);
			   //alert(html);
			   // $( "#textLogoMenu" ).html(html);
			});
			
		};
	   	//글자수체크
	    var displayBytes  = function ( nm, id ){
	        var obj  = document.getElementById( id );
	            if (obj.value.bytes() > nm){
	                if (event.keyCode != '8'){
// 	                    alert(nm+'바이트까지 입력이 가능합니다.');
	                    alert(nm+Message.msg.chkFormByteUntill);
	                }
	                obj.value = obj.value.substring(0, obj.value.length-10);
	            } 
	            
	            eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
	    };
	    
	    //글자수체크 bytes 계산 속성 추가
	    String.prototype.bytes = function(){
	        var str = this;
	        var size = 0;
	        for (var i=0; i<str.length; i++){
	        	size += (str.charCodeAt(i) > 128) ? 2 : 1;
	        }
	        return size;
	    };
	    
	    var fileSel = function(el, inputNm){
		    $("input[name='"+inputNm+"']").val(el.value);
		    
// 		    jsPreview('file_add',inputNm, 0, 0, 5120,"exe,jsp,zip,class,alz");
		    jsPreview('pfile1', 'img1', inputNm , 1000, 170, 1024, 'jpg,jpeg,png,gif');
		};
	    
		//서비스이미지 용량,크기,비율 확인
		var jsPreview = function(inputId, imageId, parentId, w, h, s, fileExt) {
	    	
			//alert("1111");
	    	var inputField = document.getElementById(inputId);        
	    	var source = inputField.value;
	    	//alert(inputField);
	    	//확장자 잘라내기
	    	var lastDot = source.lastIndexOf('.');
	   		var ext = source.substring(lastDot + 1);
	    
		    if(fileExt.indexOf(ext.toLowerCase()) == -1){
		        //alert( "지원하지 않는 이미지 형식입니다.\n jpg, png 형식만 가능합니다." );
		        alert(Message.msg.chkImageExt);
		        inputField.value = "";
		    }else{
		
			    $("#inputName").val(inputId);
			    $("#maxFileSize").val(s);
			    $("#maxWidthSize").val(w);
			    $("#maxHeightSize").val(h);
			    $("#fileExt").val(fileExt);
			    		    
		        $("#dataForm").ajaxSubmit({
		            url      : "ND_uploadImgChk.do",
		            type     : "POST",
		            dataType : "text",
		            async    : false,
		            success  : function(response){
		               // alert(response);  
		                        if(response == "100") {
		                            preview(inputId, imageId, '', w, h, s, true);       
		                            //alert(Message.msg.processOk); 
		                                                 
		                        }else{
		                            preview(inputId, imageId, '', w, h, s, false);    
			                        //jsErrorBox(response);                        
		    	                    alert(response);                            
		                        }     
		            }
		        });
		    } 
		};
		
		  // 업로드하는 사용자의 이미지를 미리보기합니다.
	    // inputId : form의 input 태그 아이디입니다.
	    // imageId : 입력 화면에 미리보기에 이용할 기본 이미지가 있어야합니다. (기본이미지와 사용자 업로드 이미지 대체를 통해 미리보기)
	    // parentId
	    // w : 가로크기, h : 세로크기, s :제한용량(1024 -> 1Megabyte)
	    function preview(inputId, imageId, parentId, w, h, s, result) {
	        try{
	           var rtnSuccess = result;
	           var image_max_width = w, image_max_height = h;
	           var image_max_size = 1024 * s; //1byte * 2048 = 2Megabyte
	           var inputField = document.getElementById(inputId);
	           var source = inputField.value;
	           //////////////////// 브라우저 검사하여 실제 이미지 경로 찾기
	           var ua = window.navigator.userAgent;
	           var localImagePath;
	                  
	           if (ua.indexOf("MSIE") > -1) {
	            
	               if (source.indexOf("\\fakepath\\") < 0) {
	                   localImagePath = source;
	               } else {
	                   inputField.select();     
	                  if(document.selection.createRangeCollection == null
	                    || typeof(document.selection.createRangeCollection) == "undefined") { 
	                      localImagePath = document.selection.createRange().text.toString();
	                   }else{
	                      localImagePath = document.selection.createRangeCollection()[0].text.toString();
	                   }
	                   inputField.blur();
	               }
	           } else {
	               if (ua.indexOf("Firefox/3") > -1) {
	                   localImagePath = inputField.files[0].getAsDataURL();
	               } else {
	                   localImagePath = 'file://' + source;
	               }
	           }
	           //////////////////////////////////////////////////////////////////////
	           
	           ////////////img obj 기본셋팅
	           var x = image_max_width;
	           var y = image_max_height;
	           //alert(x +"="+ y);      
	           var targetImage = document.getElementById(imageId);
	           //targetImage.style.display = ( x < 1 || y < 1 ) ? 'none' : 'block';
	         //  alert(targetImage);
	           if(rtnSuccess == true) {
	               //출력이미지 사이즈 조정은 안한므로 막는다.
	               //targetImage.width = x;  
	               //targetImage.height = y;
	               ////////////////////////////////////////////////////////////////////
	               
	               //////////////이미지 교체
	               if(window.FileReader) { //FileReader가 지원되는 브라우저
	                            
	                  var reader = new FileReader();
	                  reader.onloadend = (function(aImg) {
	                     return function(e) {
	                     aImg.src = e.target.result;             
	                     };
	                  })(targetImage);
	                  reader.readAsDataURL(inputField.files[0]);
	                  //alert("FileReader! =" + targetImage.src);          
	               }else{ //ie
	                  var uploadImage = new Image();
	                  uploadImage.src = localImagePath;
	                  targetImage.src = uploadImage.src;
	                  
	                  if(ua.indexOf("MSIE 9") > -1 || ua.indexOf("MSIE 8") > -1 || ua.indexOf("MSIE 7") > -1 || ua.indexOf("MSIE 6") > -1) { 
	                      
	                      var preViewer = document.getElementById(imageId); //document.getElementById(imageId); document.getElementById("preViewer"); 
	                      preViewer.src = "/resources/cmmnty/default/images/img_skin.jpg"; 
	                      preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + localImagePath + "', sizingMethod='scale')";
	                      
	                      var inputSeq = inputId.substring(5,6);
	                      $("#delBtn"+inputSeq).show();
	                      
	                      return false;
	                  }
	               }
	               /////////////////////////////////////////////////
	           }    
	           
	           /////////////////////////////////////////////////
	           $(this).delay(100).queue(function(){ 

	               //////////////파일 사이즈 체크       
	               if(!rtnSuccess){
	                   targetImage.src = "/resources/cmmnty/default/images/img_skin.jpg"; //기본 이미지

	                   
	                   inputField.outerHTML = inputField.outerHTML;//--------input file 내용 삭제는 이걸로  
	                  
  
	               }else{
	                   var inputSeq = inputId.substring(5,6);
	                   $("#delBtn"+inputSeq).show();
	                   
	               }
	               $(this).remove();
	               $(this).dequeue(); //얘를 안해주면 한번만 delay가 한번만 적용된다.
	           });
	          
	           //setTimeout(function(){checkSize(targetImage,w,h);},100);
	           
	        }catch(e){
	             alert("인터넷 브라우저 속성에서 미리보기를 지원하지 않습니다.\n'저장'후 이미지를 확인 하실 수 있습니다." );
	        }
	    }; 
	    //////////////////////////////////////////////////////////// 
	    // 로고등록방식 선택시 변환
     	var jsTrShowHide = function (fn){
    		    if(fn == "N"){
    	 	   		$("#logoT_1").show();
    		 	   	$("#logoT_2").hide();
    		    }else if(fn == "Y"){
    	 	   		$("#logoT_1").hide();
    		 	   	$("#logoT_2").show();
        		}	   
    	};
	    
    	var jsInfoUpdate = function(){
  	       //	 if ( confirm("커뮤니티 정보를 수정 하시겠습니까?") ) {
  	   			if ( confirm(Message.msg.chkCmInfoUpdate) ){
					var cmmntyId = $("#cmmntyId").val();
  		 	        $("#dataForm").ajaxSubmit({
  		   	            url      : "INC_cmOptInfoUpdate.do?applyClose=Y",
  		   	            type     : "POST",
  		   	            dataType : "text",
  		   	            success  : function(response) {
  		   	            if (response == "true")  {
  		   	                    //alert("적용 되었습니다.");
  		   	                    alert(Message.msg.chkCmInfoUpdateOk);
  		   	               		jrMove("BD_index.do?cmmntyId="+cmmntyId);
  		   	                } else { 
  		   	                	//alert("적용 중 오류가 발생했습니다.");
  		   	                	alert(Message.msg.chkCmInfoUpdateFail);
  		   	                   	return;
  		   	                }
  		   	            }
  		   	        });
  	       	 }
  	   	};
  	   	
  	  // 페이지 이동
 	   var jrMove = function(movepage){
 	        $("#dataForm").attr("action",movepage).submit();
 	   };
	    //]]>
    </script>
    </head>
<body>


    
	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
		<input type="hidden" id="userId" name="userId" value="<c:out value="${cmUserView.userId}"/>" />
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserView.cmmntyId}"/>" />
		<input type="hidden" id="cmmntySttusCd" name="cmmntySttusCd" value="<c:out value="${cmUserView.cmmntySttusCd}"/>" /> 
		<input type="hidden" name="logoTitleWidthLc" value="<c:out value="${cmUserView.logoTitleWidthLc}" default="0" />" />
		<input type="hidden" name="logoTitleVrticlLc" value="<c:out value="${cmUserView.logoTitleVrticlLc}" default="0" />" />   
		
		<input type="hidden" id="cmmntyNmCheck"  name="cmmntyNmCheck" value="Y" />
		<input type="hidden" id="cmmntyUrlCheck"  name="cmmntyUrlCheck" value="Y" />
		
		<input type="hidden" name="inputName" id="inputName" value=""/>
		<input type="hidden" name="maxFileSize" id="maxFileSize" value=""/>
		<input type="hidden" name="maxWidthSize" id="maxWidthSize" value=""/>
		<input type="hidden" name="maxHeightSize" id="maxHeightSize" value=""/>
		<input type="hidden" name="fileExt" id="fileExt" value=""/>
<!-- container -->
	<div id="container">
		<!-- side navigation bar -->
			<jsp:include page="/korean/cm/admin/cmOptAdminMenu/INC_cmOptAdminMenuLeft.do?menuCode=cmoptinfo&amp;cmmntyId=${cmUserView.cmmntyId}" flush="true"></jsp:include>
		<!-- //side navigation bar -->
		
		<!-- contents -->
		<div id="contents">
			<h2>커뮤니티 정보</h2>
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%">
					<col style="width:*">
					<col style="width:15%">
					<col style="width:25%">
				</colgroup>
				<tbody>
					<tr>
						<td class="tit">커뮤니티 주소</td>
						<td>http://<c:out value='${cmUserView.cmmntyUrl}'/></td>
						<td class="tit">커뮤니티 개설일</td>
<%-- 						<fmt:parseDate value='${cmUserView.confmDt}' var='confmDt' pattern="yyyy-MM-dd HH:mm" scope="page"/> --%>
						<td class="last"><c:out value='${cmUserView.confmDt}'/></td>
					</tr>
					<tr>
						<td class="tit">커뮤니티 이름</td>
						<td class="last" colspan="3"><c:out value='${cmUserView.cmmntyNm}'/></td>
					</tr>
					<tr>
						<td class="tit">커뮤니티 설명</td>
						<td colspan="3" class="last">
							<textarea id="cmmntyDc" name="cmmntyDc"  style="width:570px; height:76px;" onkeyup="javascript:displayBytes(1900,'cmmntyDc');"  ><c:out value='${cmUserView.cmmntyDc}'/></textarea>
							<span class="byte"><em><span id="cmmntyDc_bytes">0</span></em>/2000byte</span>
						</td>
					</tr>
					<tr>
						<td class="tit" >커뮤니티 카테고리</td>
						<td class="last"  colspan="3"><c:out value='${cmUserView.cmmntyCtgryNm}'/></td>
<!-- 						<td class="tit">지원 언어</td> -->
<%-- 						<td class="last"><c:out value='${cmUserView.langNm}'/></td> --%>
					</tr>
					<tr>
						<td class="tit">가입 방식</td>
						<td class="last" colspan="3">
							<ul class="join">
								<li>
									<input type="radio"  id="cmmntySbscrbMthd_1" name="cmmntySbscrbMthd" title="join" value="1" <c:if test="${cmUserView.cmmntySbscrbMthd eq '1'}">checked="checked"</c:if>/> 
									<label for="cmmntySbscrbMthd_1">가입 신청 시 바로 가입할 수 있습니다.</label>
								</li>
								<li>
									<input type="radio" id="cmmntySbscrbMthd_2" name="cmmntySbscrbMthd" title="join" value="2" <c:if test="${cmUserView.cmmntySbscrbMthd eq '2'}">checked="checked"</c:if>/> 
									<label for="cmmntySbscrbMthd_2">가입 신청 시 운영자의 승인을 거쳐 가입할 수 있습니다.</label>
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<td class="tit">로고 등록 방식</td>
						<td class="last" colspan="3">
							<ul class="join">
								<li>
									<input type="radio" id="logoDirectRegistAt_N" name="logoDirectRegistAt" title="logoDirect" value="N" <c:if test="${cmUserView.logoDirectRegistAt eq 'N'}">checked="checked"</c:if> onclick="jsTrShowHide('N')" /> 
									<label for="logoDirectRegistAt_N">기존 로고 타이틀 등록</label>
								</li>
								<li>
									<input type="radio" id="logoDirectRegistAt_Y" name="logoDirectRegistAt" title="logoDirect" value="Y" <c:if test="${cmUserView.logoDirectRegistAt eq 'Y'}">checked="checked"</c:if>  onclick="jsTrShowHide('Y')"/> 
									<label for="logoDirectRegistAt_Y">로고 이미지 직접 등록</label>
								</li>
							</ul>
						</td>
					</tr>
					<tr id="logoT_1" >
						<td class="tit">로고 타이틀</td>
						<td class="last" colspan="3">
						<div>
							<ul>
								<li>폰트:
								<select id="logoTitleFont" name="logoTitleFont" title="폰트 선택" style="width:140px">
									<option value="dotum" style="font-family:Dotum">돋움</option>
									<option value="gulim" style="font-family:Gulim">굴림</option>
									<option value="batang" style="font-family:Batang">바탕</option>
									<option value="arial" style="font-family:Arial">Arial</option>
									<option value="arial black" style="font-family:'Arial Black'">Arial Black</option>
									<option value="tahoma" style="font-family:Tahoma">Tahoma</option>
									<option value="verdana" style="font-family:Verdana">Verdana</option>
									<option value="sans-serif" style="font-family:Sans-serif">Sans-serif</option>
									<option value="serif" style="font-family:Serif">Serif</option>
									<option value="monospace" style="font-family:Monospace">Monospace</option>
									<option value="cursive" style="font-family:Cursive">Cursive</option>
									<option value="fantasy" style="font-family:Fantasy">Fantasy</option>
									<option value="Times New Roman" style="font-family:Times New Roman">Times New Roman</option>
								</select>
								&nbsp;		
								색상:<input type="text" id="logoTitleColor" name="logoTitleColor" value="<c:out value="${cmUserView.logoTitleColor}" default="000000"/>" class="input" style="width:70px;" />
								&nbsp;
								크기:<select id="logoTitleFontSize" name="logoTitleFontSize" title="폰트 크기 선택" style="width:70px">
									<c:forEach var="size" begin="14" end="72" step="2">
										<option value="${size}">${size}px</option>
									</c:forEach>
								</select>		
								&nbsp;	
								내용:<input type="text" id="logoTitle"  name="logoTitle" size="45" value="<c:out value="${cmUserView.logoTitle}" default="Open Market Place" />" class="input" style="width:150px;"/>
								&nbsp;
								<img src="/resources/cmmnty/default/images/btn/btn_refresh.png" id="logoPreview" class="bt_grad g_L" alt="적용하기" style="cursor: pointer;" /></li>
							</ul>	<!-- //logobox _style -->
							</div>
							<br/>
							<div class="skin" style="overflow-x:scroll;">
								<div id="containerLogo" >
									<div class="result" >
										<img id="mainLogo" src="/resources/cmmnty/default/images/img_skin.jpg" alt="대표이미지" style="width:999px; height:170px;" />
										<div id="textLogo" class="inertxt" ></div>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr id="logoT_2" style="display:none;">
						<td class="tit">로고 타이틀</td>
						<td class="last" colspan="3">
						<div class="skin" style="overflow-x:scroll; overflow-y:hidden;">
						<c:if test="${cmUserView.logoFileSeq == 1 || cmUserView.logoFileSeq == -1}">
						<img id="img1" src="/resources/cmmnty/default/images/img_skin.jpg" alt="대표이미지" style="width:999px; height:170px;" >
						</c:if>
						<c:if test="${cmUserView.logoFileSeq != 1 && cmUserView.logoFileSeq != -1}">
						<img id="img1" src="<c:out value="${cmUserView.logoFileUrl}"/>" alt="대표이미지" style="width:999px; height:170px;" >
						</c:if>
						</div>
						<div>
<!-- 						<div class="file community"> -->
<!-- 								<div class="fake_input"> -->
<!--  									<input type="file" title="파일명 입력" onchange="javascript:document.getElementById('file011').value=this.value"> --> 
<!-- 									<span id="spanFile1"> -->
<!-- 									<input type="file" id="pfile1" name="pfile1" class="file_photo" title="대표 이미지 교체" onchange="javascript:jsPreview('pfile1', 'img1', 'spanFile1', 1000, 180 1024, 'jpg,jpeg,png');" /> -->
<!-- 									</span> -->
<!-- 								</div> -->
<!-- 								<span class="selectBtn"> -->
<!-- 									<img src="/resources/cmmnty/default/images/btn/btn_file.gif" alt="파일선택" style="cursor: pointer;"> -->
<!-- 								</span> -->
<!-- 							</div> -->
							<br/>
							<div class="file">
<!-- 									<input type="text" id="spanFile1" name="spanFile1" title="파일명" readonly="readonly" style="width:500px;"/> -->
									<input type="text" id="file_route" name="file_route" class="file_route" style="width:494px" title="첨부된 파일경로" readonly="readonly" />
									<div class="fake_input">
										<span id="spanFile1"><input type="file" id="pfile1" name="pfile1" title="찾아보기" class="file_photo" onchange="fileSel(this, 'file_route');" /></span>
									</div>
									<span class="btn">
										<img src="/resources/cmmnty/default/images/btn/btn_file.gif" alt="파일선택" style="cursor: pointer;" />
									</span>
								</div>
					</div>
							<div class="guide_txt">※ JPG , GIF 형식의 10MB 미만 파일만 업로드 가능합니다.</div>
							<div class="guide_txt">※ 업로드된 파일은 990 x 160 사이즈로 확대 또는 축소되어 표시됩니다.</div>
						
							<input type="hidden" id="logoFileSeq" name="logoFileSeq" value="<c:out value="${cmUserView.logoFileSeq}"/>" />
							<input type="hidden" id="logoFileUrl" name="logoFileUrl" value="<c:out value="${cmUserView.logoFileUrl}"/>" />
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_area">
				<div class="btn_navi"><a href="#" onclick="jsInfoUpdate();"><span class="save">저장</span></a></div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	</form>
</body>
</html>