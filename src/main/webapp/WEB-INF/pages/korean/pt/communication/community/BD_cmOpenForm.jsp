<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	request.setAttribute("SubDomain","korean");
	String nowURL = request.getRequestURI().toString();

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 개설 신청 | 커뮤니티 | 커뮤니케이션 | 씨앗 마켓</title>	

	<script type="text/javascript" src="/resources/cmmnty/common/ui/jquery-ui-1.11.2.custom.min.js"></script>
	<script type="text/javascript" src="/resources/openworks/spi/jquery/ui/jquery.ui.datepicker-ko.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/cmmnty/common/ui/jquery-ui-1.11.2.custom.min.css" />
    <op:jsTag type="spi" items="form, validate, multifile, colorpicker" />
    <style type="text/css">
		#containerLogo {position:relative; width:990px; height:170px; margin:0 auto; overflow:hidden}
		#containerLogoTitle img {position:absolute; top:0; left:0} 
		#containerLogo .result > * {position:absolute;}
		#containerLogo .result .inertxt {line-height:normal; }
		
		
		.file{position:relative;}
		.fake_input{position:absolute; top:0; right:0; width:60px; height:24px; z-index:1; cursor:pointer;}
		.fake_input input[type="file"]{width:60px; height:24px; filter:alpha(opacity:0); opacity:0;}
		.fake_input .file_photo {filter:alpha(opacity=0); opacity:0; width:60px; height:24px; cursor:pointer}
		span.btn{display:block; position:absolute; top:0; right:0;}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){	
		    // 이벤트 설정 함수 호출
		    jsInitEvent();
	
		    // 폰트
		    $("#logoTitleFont").val("batang");
		    // 폰트 사이즈
		    $("#logoTitleFontSize").val("40");
	
		 // text 로고의 초기 위치 설정
	    	var left = 0;
	    	var top  = 0;
	    	
	    	$("#textLogo").css({ "top": parseInt(top, 10), "left": parseInt(left, 10) });
	    	$("#textLogoMenu").css({ "top": parseInt(top, 10), "left": parseInt(left, 10) });
	
	    	// 컬러픽커 기본 설정 항목 처리
			$("#logoTitleColor").css('border-color','#' + $( "#logoTitleColor" ).val());
			//$( "#logoTitleColor" ).css('background-color','#' + $( "#logoTitleColor" ).val());
			
			// 화면로딩시 로고타이틀 미리보기 클릭 이벤트 발생처리
			$("#logoPreview" ).trigger("click");
			
			//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			$("#cmmntySubUrl").val("<%=GlobalConfig.DOMAIN_SUBNM %>/community/");
			//}}
			//jsTrShowHide("");  //  로고 등록 선택  N: 기존 로고 Y: 직접등록
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
			    var logoTitleFontSize = $("#logoTitleFontSize").val();
			    var logoTitleFont     = $("#logoTitleFont").val();
			    var logoTitleColor    = $("#logoTitleColor").val();
	
			    var html = '<P id="preLogo" style="font-family:\'' + logoTitleFont + '\'; font-size:' + logoTitleFontSize + 'px; font-style:italic; color:#' + logoTitleColor + '">' + logoTitle + '</p>';
			    $( "#textLogo" ).html(html);
			    // alert(html);
			   // $( "#textLogoMenu" ).html(html);
			});
			
		};
	   	//글자수체크
	    var displayBytes  = function ( nm, id ){
	        var obj  = document.getElementById( id );
	            if (obj.value.bytes() > nm){
	                if (event.keyCode != '8'){
	                   // alert(nm+'바이트까지 입력이 가능합니다.'); 
	                    alert(nm+Message.msg.chkFormByteUntill );
	                }
	                obj.value = obj.value.substring(0, obj.value.length-10);
	            }
	            eval('document.all.'+id+'_bytes').childNodes[0].innerHTML = eval('dataForm.'+id).value.bytes();
	    };
	    
		//글자수체크
	    var displayBytes2  = function ( rm, nm, id ){
	        var obj  = document.getElementById( id );
	            if (obj.value.bytes() > nm){
	                if (event.keyCode != '8'){
	                    //alert(nm+'바이트까지 입력이 가능합니다.');
	                    alert(nm+Message.msg.chkFormByteUntill );
	                }
	                obj.value = obj.value.substring(0, obj.value.length-10);
	            }else if(obj.value.bytes() < 4 && obj.value.bytes() > 0){
	                
	                //alert(rm+'바이트이상 입력하세요.');
	                alert(nm+Message.msg.chkFormByteOver );
	            } 
	            //eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
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
	    
	 // 중복확인 버튼 클릭 이벤트
        var jsDulCheckAction = function (check) {
            var cmmntyNm = $("#cmmntyNm").val();
            var cmmntyUrl = blankTrim($("#cmmntyUrl").val());
	     	
            var langCode = $("#langCode").val();
            if( check == "1"){
                
                if(cmmntyNm == ""){
                   alert(Message.msg.chkCmOpenFormNm);
      	     	   //alert("커뮤니티 이름을 입력하세요.");
      	     	   $("#cmmntyNm").focus();
      	     	   return;
      	     	}else if(cmmntyNm != ""){
      		     	 if(!checkFilter(cmmntyNm)){  
      		               $("#cmmntyNm").focus(); 
      		               $("#cmmntyNm").val(""); 
      		               return;
      		           }
      	     	}

                $.ajax({
    	            url      : "INC_cmNmUrlCheck.do",
    	            type     : "POST", 
    	            data     : { cmmntyNm : cmmntyNm  
        	            , cmmntyUrl : cmmntyUrl
        	            , cmNmUrlCheck : check
        	            , userId :  '<c:out value='${userId}'/>'
        	            , cmmntyId : cmmntyUrl
        	            , langCode : langCode},
    	            async    : false,  //false 일 경우 동기로 요청한다는 뜻임. async 비동기
    	            success  : function (response) {
    	                //alert(response);
    	                if (response == "0") {
    	                    $("#cmmntyNmCheck").val("Y");
    	                    $("#logoTitle").val(cmmntyNm);
    	                    $("#logoPreview" ).trigger("click");
    	                    alert(Message.msg.chkCmNmOk+ "\n"+Message.msg.cmOpenCmNm+cmmntyNm);
    	                } else {
    	                    alert(Message.msg.chkCmNmFail+ "\n"+Message.msg.cmOpenCmNm+cmmntyNm);
    	                    $("#cmmntyNmCheck").val("");
    	                    $("#cmmntyNm").focus();
    	                }
    	            }
    	        });
            }else if( check == "2"){
                if(cmmntyUrl == ""){
       	     	   //alert("커뮤니티 주소를 입력하세요."); 
       	     	   alert(Message.msg.chkCmOpenFormAddr );
       	     	   $("#cmmntyUrl").focus();
       	     	   return;
       		    }else if(cmmntyUrl != ""){
      		     	 if(!checkFilter(cmmntyUrl)){  
      		               $("#cmmntyUrl").focus(); 
      		               $("#cmmntyUrl").val(""); 
      		               return;
      		           }
      		     	 
      		     	 $("#cmmntyUrl").val(cmmntyUrl);
      	     	}
                //alert(cmmntyUrl);
    	    	$.ajax({
    	            url      : "INC_cmNmUrlCheck.do",
    	            type     : "POST", 
    	            data     : { cmmntyNm : cmmntyNm  
        	            , cmmntyUrl : cmmntyUrl
        	            , cmNmUrlCheck : check
        	            , userId :  '<c:out value='${userId}'/>'
        	            , cmmntyId : cmmntyUrl
        	            , langCode :  langCode },
    	            async    : false,  //false 일 경우 동기로 요청한다는 뜻임. async 비동기
    	            success  : function (response) {
    	               // alert(response);
    	                if (response == "0") {
    	                    $("#cmmntyUrlCheck").val("Y");
    	                    $("#cmmntyId").val(cmmntyUrl);
							alert(Message.msg.chkCmUrlOk+"\n"+Message.msg.cmOpenCmUrl+"http://"+$("#cmmntySubUrl").val()+cmmntyUrl);
    	                } else {
    	                    alert(Message.msg.chkCmUrlFail+"\n"+Message.msg.cmOpenCmUrl+"http://"+$("#cmmntySubUrl").val()+cmmntyUrl);
    	                    $("#cmmntyUrlCheck").val("");
    	                    $("#cmmntyId").val("");
    	                    $("#cmmntyUrl").focus();

    	                }
    	            }
    	        });
				

            }
        };
        
      //파일선택
	    var fileSel = function(el, inputNm){
	        //alert(inputNm);
		    $("input[name='"+inputNm+"']").val(el.value);
		    //alert(inputNm);
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
		        $("#file_route").val("");
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
			                        $("#file_route").val("");
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
        var validation = {     
                /** ajax submit validation **/
        		   dataForm : function() {
        		       /** 지역변수 **/
        		       
					   if($("#cmmntyUrl").val() == ""){
      		           		//alert("입력되지 않은 항목이 있습니다. \n 모든 항목을 입력 후 다시 시도해주십시오. ");      
       		            	alert(Message.msg.chkCmOpenInsertNotForm+"\n"+Message.msg.chkCmOpenInsertAllNotForm);
                    		$("#cmmntyUrl").focus();
		   		           	return false
       		       	   }
        		       if($("#cmmntyUrlCheck").val() == ""){
        		           	//alert("커뮤니티 주소 사용 가능 체크를 하시지 않았습니다.");
        		           	alert(Message.msg.chkCmOpenFormNmUrl);
                           	$("#cmmntyNmCheck").focus();
        		            return false;
        		       }
        		       if($("#cmmntyUrl").val() != ""){
        		           var cmmntyUrl = $("#cmmntyUrl").val();
        		           if(!checkFilter(cmmntyUrl)){  
        		               $("#cmmntyUrl").focus(); 
        		               $("#cmmntyUrl").val(""); 
        		               return false;
        		           }
					   }
					   if($("#cmmntyNm").val() == ""){
      		           		//alert("입력되지 않은 항목이 있습니다. \n 모든 항목을 입력 후 다시 시도해주십시오. ");      
       		            	alert(Message.msg.chkCmOpenInsertNotForm+"\n"+Message.msg.chkCmOpenInsertAllNotForm);
                    		$("#cmmntyNm").focus();
		   		           	return false;
       		       	   }
        		       if($("#cmmntyNmCheck").val() == ""){
   		           			//alert("커뮤니티 이름 사용 가능 체크를 하시지 않았습니다.");
   		           			alert(Message.msg.chkCmOpenFormNmCheck);
                      		$("#cmmntyNmCheck").focus();
		   		           	return false;
		   		       }	
        		       if($("#cmmntyNm").val() != ""){
						    var cmmntyNm = $("#cmmntyNm").val();
	        		           if(!checkFilter(cmmntyNm)){  
	        		               $("#cmmntyNm").focus(); 
	        		               $("#cmmntyNm").val(""); 
	        		               return false;
	        		           }
					   }
					   
        		       if($("#estblReqstResn").val() == ""){
       		           		//alert("입력되지 않은 항목이 있습니다. \n 모든 항목을 입력 후 다시 시도해주십시오. ");     		           
        		            //alert(Message.msg.chkCmOpenFormDc);
        		            alert(Message.msg.chkCmOpenInsertNotForm+"\n"+Message.msg.chkCmOpenInsertAllNotForm);
                     		$("#estblReqstResn").focus();
		   		           	return false
        		       }
        		       if($("#cmmntyCtgryCd option:selected").val() == ""){
       		           		//alert("입력되지 않은 항목이 있습니다. \n 모든 항목을 입력 후 다시 시도해주십시오. ");     		           
        		            //alert(Message.msg.chkCmOpenFormDc);
        		            alert(Message.msg.chkCmOpenInsertNotForm+"\n"+Message.msg.chkCmOpenInsertAllNotForm);
                     		$("#cmmntyCtgryCd").focus();
		   		           	return false;
        		       }
        		       
        		       if($("input[name=logoDirectRegistAt]:checked").val() == "Y"){
        		           if($("#file_route").val() == ""){
        		               alert(Message.msg.chkImage);
			   		           	return false;
        		           }
        		       }
        		   }
        	};

		// 개설 신청
        var jsCmOpenInsert = function(){
		    if(validation.dataForm() === false){
	        	return;
	   		}
		    
		    if ( confirm(Message.msg.chkCmOpenInsert) ) {
		        var cmmntyCtgryNm = $("#cmmntyCtgryCd option:selected").text();
				$("#cmmntyCtgryNm").val(cmmntyCtgryNm);
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_openCmUserInsert.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	                if (response == "true") {
	   	                 	alert(Message.msg.cmOpenInsertOk+"\n"+Message.msg.cmOpenInsertOk2);
		                    jrMove("BD_index.do");
		               } else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
	   	            }
	   	        });
	      	 }
   		};
   		
   	 var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	 };
	 // 특수 문자 입력 체크  
	 var checkFilter =    function (cmid){
		 var chkId = blankTrim(cmid);
		 var chktext = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
		 if(chktext.test(chkId)){
		     
		     alert(chkId+Message.msg.chkCmOpenFormSpecial);
		     //alert(chkId+" 특수문자는 입력하실 수 없습니다.");
		     return false;
		 }
		 return true;
	};
	// 공백 체크
	var blankTrim = function (name){
		return name.replace(/(\s*)/g, "");
	};
	
	var jsLangCode = function(){
	    
	    var langCode = $("#langCode").val(); 
	    if(langCode == "00"){
	        $("#urlCode").html("korean");
			$("#cmmntySubUrl").html("<%=GlobalConfig.DOMAIN_SUBNM %>/community/");
	    }
	 	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
	    /* if(langCode == "01"){
	        $("#urlCode").html("english");
	        $("#cmmntySubUrl").html("english.ceart.kr/community/");
	    }
	    if(langCode == "06"){
	        $("#urlCode").html("spanish");
	        $("#cmmntySubUrl").html("spanish.ceart.kr/community/");
	    } */
	   //}}
	};
	
	var checkReset = function(chk){
	    if(chk == '1') {
	        $("#cmmntyNmCheck").val("");
	    } else if(chk == '2') {
	        $("#cmmntyUrlCheck").val("");
	    }
	};
	</script>
</head>
<body>
	<section class="listTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>커뮤니티</h2>
			<div>신규개설</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<form name="dataForm" id="dataForm" method="post"  enctype="multipart/form-data" >
	<input type="hidden" id="cmmntyId"  name="cmmntyId" value="" />
	<input type="hidden" id="cmmntySubUrl"  name="cmmntySubUrl" value="" />
	<input type="hidden" id="cmmntyUrlCheck"  name="cmmntyUrlCheck" value="" />
	<input type="hidden" id="cmmntyNmCheck"  name="cmmntyNmCheck" value="" />
	<input type="hidden" id="logoTitleWidthLc"  name="logoTitleWidthLc" value="0" />
	<input type="hidden" id="logoTitleVrticlLc"  name="logoTitleVrticlLc" value="0" />   
	<input type="hidden" id="cmmntyCtgryNm"  name="cmmntyCtgryNm" value="" />

	<input type="hidden" name="inputName" id="inputName" value=""/>  
	<input type="hidden" name="maxFileSize" id="maxFileSize" value=""/>
	<input type="hidden" name="maxWidthSize" id="maxWidthSize" value=""/>
	<input type="hidden" name="maxHeightSize" id="maxHeightSize" value=""/>
	<input type="hidden" name="fileExt" id="fileExt" value=""/>
	<input type="hidden" name="langCode" id="langCode" value="<c:out value="${langCode}"/>"/>
	<!-- section -->
	<section class="lay_lnb">
		<div class="conWrap">
			<nav>
				<!-- 좌측 카테고리 -->
				<ul>					
					<li>
						<a href="/korean/pt/communication/community/BD_index.do">전체 커뮤니티</a>
					</li>
					<li  class="on">
					  <a href="#none" onclick="jsCmOpen('<c:out value="${sessionScope['__usk'].userTyCd}"/>');">커뮤니티 개설</a>
					</li>
				</ul>
				<!--// 좌측 카테고리 -->
			</nav>
			
			<div class="communMake">
				<table class="tbl_st4">
				<tr>
					<th>					
						<span class="requ">커뮤니티 주소</span>
						<!-- tooltip -->
						<!-- <span class="tooltip">
							<a href="#" class="s-btn w20 ml-5 tooltip type1"><strong><span>?</span></strong></a>
							<div class="tooltip-box">								
								<strong>사용가능 주소 조건</strong>
								<p>									
									중복되지 않는 주소<br/>
									알파벳과 숫자만 입력 가능<br/>
									4 byte 이상 20 byte 이하 입력 가능
								</p>									
							</div>
						</span> -->
						<!-- //tooltip -->	
					</th>					
					<td>															
						http://<%=GlobalConfig.DOMAIN_SUBNM %>/community/<input type="text" class="w304 ml10" id="cmmntyUrl" name="cmmntyUrl" title="커뮤니티 주소 입력" value="" onblur="javascript:displayBytes2(4, 20,'cmmntyUrl');" style="width:240px;ime-mode:disabled;" onkeyup="this.value=this.value.replace(/[^a-zA-z0-9]/g,'')" onchange="checkReset('2');"/>
						<a href="javascript:;" class="btns st3" id="cmmntyUrlCheckBut" name="ccmmntyUrlCheckBut" onclick="jsDulCheckAction('2');">사용가능 체크</a>
					</td>					
				</tr>
				<tr>
					<th>	
						<span class="requ">커뮤니티 이름</span>
						<!-- tooltip -->
						<!-- <span class="tooltip">
							<a href="#" class="s-btn w20 ml-5 tooltip type1"><strong><span>?</span></strong></a>
							<div class="tooltip-box">
								<strong>사용가능 이름 조건</strong>																		
									<p>
										중복되지 않는 이름<br/>
										4 byte 이상 20 byte 이하 입력 가능<br/>
									</p>									
							</div>
						</span> -->
						<!-- //tooltip -->
					</th>	
					<td>
						<input type="text" class="w445" id="cmmntyNm" name="cmmntyNm" onblur="javascript:displayBytes2(4, 40,'cmmntyNm');" onchange="checkReset('1');"/>
						<a href="javascript:;" class="btns st3" id="cmmntyNmBut" name="cmmntyNmBut" onclick="jsDulCheckAction('1'); return false;">사용가능 체크</a>
					</td>
				</tr>
				<tr>
					<th>커뮤니티 설명</th>
					<td class="text">
						<textarea  id="cmmntyDc" name="cmmntyDc" onkeyup="javascript:displayBytes(1900,'cmmntyDc');" onblur="javascript:displayBytes(1900,'cmmntyDc');"></textarea>						
						<p class="caption ar mt10" id="cmmntyDc_bytes"><em>0</em>byte/2000bytes</p>
					</td>
				</tr>
				<tr>
					<th class="requ">커뮤니티 카테고리</th>			
					<td>
						<span class="sel_box">
							<op:code id='cmmntyCtgryCd'  grpCd='2011' type='select' defaultValues='1001'/>
						</span>							
					</td>
				</tr>
				<tr>
						<th class="requ">가입방식</th>
					<td>						
						<label><input type="radio" id="cmmntySbscrbMthd_1" name="cmmntySbscrbMthd" value="1" checked="checked"/>가입 신청 시 바로 가입할 수 있습니다.</label>
						<label><input type="radio" id="cmmntySbscrbMthd_2" name="cmmntySbscrbMthd" value="2"/>가입 신청 시  운영자의 승인을 거쳐 가입할 수 있습니다.</label>										
					</td>
				</tr>
				<tr>
						<th class="requ">가입방식</th>
					<td>
						<label><input type="radio" id="logoDirectRegistAt_N" onClick="jsTrShowHide('N');" name="logoDirectRegistAt" value="N" checked="checked"/>기존 로고 타이틀 등록</label>
						<label><input type="radio" id="logoDirectRegistAt_Y" onClick="jsTrShowHide('Y');" name="logoDirectRegistAt" value="Y" />기존 이미지 직접 등록</label>					
					</td>
				</tr>
				<tr id="logoT_1">
					<th>로고 타이틀</th>
						<td>
							<ul class="val_mid">
								<li>폰트 :
								    <span class="sel_box">
										<select name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 78px; position: absolute; left: -100000px; height: auto;">							
											<option value="dotum" style="font-family:Dotum">돋움</option>
											<option value="gulim" style="font-family:Gulim">굴림</option>
											<option value="batang" style="font-family:Batang" selected="selected">바탕</option>
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
									</span>
										색상 :
											<input type="text" id="logoTitleColor" name="logoTitleColor" value="000000" class="w74" />
										크기 :
								    		<span class="sel_box">
												<select id="logoTitleFontSize" name="logoTitleFontSize" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 60px; position: absolute; left: -100000px; height: auto;">
													<c:forEach var="size" begin="14" end="72" step="2">
														<option value="${size}">${size}px</option>
													</c:forEach>															
												</select>
											</span>	
									</li>				
									<li>
											내용 :  <input type="text" class="w124" id="logoTitle"  name="logoTitle" value="<c:out value="${cmUserView.logoTitle}" default="Open Market Place" />"/>
											<a href="#" class="btns st3 refresh type1" id="logoPreview"><strong><span>새로고침</span></strong></a>
											<div id="textLogo"></div>
										</li>
									<!-- <li>
										//static select
										<textarea class="h167 mt20"></textarea>
									</li> -->
										</ul>
									</td>
								</tr>	
								 <tr id="logoT_2" style="display:none;">
									<th>로고 타이틀 직접 등록</th>
									<td class="last">
											<div class="skin" style="overflow-x:scroll; overflow-y:hidden;" ><img id="img1" src="/resources/cmmnty/default/images/img_skin.jpg" alt="대표이미지" style="width:600px; height:170px;" ></div>
											<div class="uploadFile">
											<input type="text" id="file_route" name="file_route" class="file_route" style="width:494px" readonly="readonly" title="첨부된 파일경로"  />
											<div>
												<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('markCrtfcFile${statusSeq.index}','markCrtfcInput${statusSeq.index}');"/>							
								            	<span class="btns st3">
								            		파일선택
								            		<input  type="file" id="pfile1" name="pfile1" title="찾아보기" class="file_photo" onchange="fileSel(this, 'file_route');""/>
								            	</span>
							            	</div></div>
							            	<!-- 
											<div class="file">
												<input type="text" id="file_route" name="file_route" class="file_route" style="width:494px" readonly="readonly" title="첨부된 파일경로"  />
												<div class="fake_input">
													<span id="spanFile1"><input type="file" id="pfile1" name="pfile1" title="찾아보기" class="file_photo" onchange="fileSel(this, 'file_route');" /></span>
												</div>
												<span class="btn">
													<img src="/resources/cmmnty/default/images/btn/btn_file.gif" alt="파일선택" style="cursor: pointer;" />
												</span>
											</div> -->
											<div class="guide_txt">※ JPG , GIF 형식의 10MB 미만 파일만 업로드 가능합니다.</div>
											<div class="guide_txt">※ 업로드된 파일은 1000 x 160 사이즈로 확대 또는 축소되어 표시됩니다.</div>
										</td>
									</tr> 
								<tr>
									<th class="requ">커뮤니티 개설 신청사유</th>
									<td class="text">
										<textarea id="estblReqstResn" name="estblReqstResn" onkeyup="javascript:displayBytes(1900,'estblReqstResn');" ></textarea>
										<p class="caption ar mt10" id="estblReqstResn_bytes"><em>0</em>/2000bytes</p>										
									</td>
								</tr>		
						</table>		
						
						
						<!-- btn-area -->
						<div class="btn-area mt30 rig">
							<a href="#" class="b-btn ml10 community type3" onclick="jsCmOpenInsert();"><strong><span>커뮤니티 개설</span></strong></a>
						</div>
						<!-- //btn-area -->
						</div>
					</div>	
				</section>
				<!--// content -->
			
			</form>
		</div>
		<!--// contents -->			
</body>
</html>
