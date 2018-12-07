<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>커뮤니티 <c:if test="${  openCmManageView.cmmntySttusCd == '1002'  }">승인</c:if><c:if test="${ openCmManageView.cmmntySttusCd != '1002'  } ">개설신청</c:if>정보</title>
	<style type="text/css">
#containerLogo {position:relative; width:999px; height:170px; margin:0 auto; overflow:hidden}
#containerLogoTitle img {position:absolute; top:0; left:0} 
#containerLogo .result > * {position:absolute;}
 #containerLogo .result .inertxt {line-height:normal; }
	</style>
   <op:jsTag type="spi" items="jquery, form, notice, validate, ui, multifile, colorbox, colorpicker" />
	<op:jsTag type="openworks" items="ui" />
	<script type="text/javascript">
		//<![CDATA[
           
           	$(document).ready(function(){	
           	    
           	    var logoDirect = '<c:out value="${openCmManageView.logoDirectRegistAt}"/>'; //로고 타이틀 직접 등록 여부 
           	    // 취소 버튼 클릭 시 데이터베이스에 저장된 상태로 보이도록 하기 위해 사용
        	    cmOpenInfo = {
        		    logoTitleWidthLc  : <c:out value="${openCmManageView.logoTitleWidthLc}" default="0" />,	        
        		    logoTitleVrticlLc  : <c:out value="${openCmManageView.logoTitleVrticlLc}" default="0" />,	        
        		    logoTitleFont  : "<c:out value="${openCmManageView.logoTitleFont}" />",	        
        		    logoTitleFontSize : "<c:out value="${openCmManageView.logoTitleFontSize}" default="34" />",	        
        		    logoTitleColor : "<c:out value="${openCmManageView.logoTitleColor}" />"	        
        		};

           	  
        	    // 이벤트 설정 함수 호출
        	    jsInitEvent();

        	    // 폰트
        	    $("select[name=logoTitleFont]").val("<c:out value="${openCmManageView.logoTitleFont}" />");
        	    // 폰트 사이즈
        	    $("select[name=logoTitleFontSize]").val("<c:out value="${openCmManageView.logoTitleFontSize}" default="34" />");

        	 // text 로고의 초기 위치 설정
            	var left = $("input[name=logoTitleWidthLc]").val();
            	var top  = $("input[name=logoTitleVrticlLc]").val();
            	
            	$( "#textLogo" ).css({ "top": parseInt(top, 10), "left": parseInt(left, 10) });

            	// 컬러픽커 기본 설정 항목 처리
        		$( "#picker" ).css('border-color','#' + $( "#picker" ).val());

        		// 화면로딩시 로고타이틀 미리보기 클릭 이벤트 발생처리
        		$( "#logoPreview" ).trigger("click");
        		
        	    
        		var msg = "<c:out value='${param.msg}' default='no' />";
        		if (msg != "no") {
        		    alert("요청정보가 정상적으로 수행되었습니다.");
        		}


    			jsTrShowHide(logoDirect);  //  로고 등록 선택  N: 기존 로고 Y: 직접등록
        		
			});

         // 화면로딩시 필요한 이벤트 처리
        	var jsInitEvent = function() {

        	    // text 드레그 가능하게
        		$( "#textLogo" ).draggable({ 
        		    containment: "#containerLogo", 
        		    scroll: false,
        		    stop: function( event, ui ) {
        		    	$("input[name=logoTitleWidthLc]").val(parseInt(ui.position.left, 10));
        		    	$("input[name=logoTitleVrticlLc]").val(parseInt(ui.position.top, 10));
        		    }
        		});
        		
        	    // 컬러 색상 처리 이벤트 및 객체 연결
        		$( "#picker" ).colpick({
        			layout:'hex',
        			//submit:0,
        			colorScheme:'dark', //'light'
//         			onChange : function(hsb, hex, rgb, el, bySetColor) {
//         				$(el).css('border-color','#'+hex);
//         				if(!bySetColor) $(el).val(hex);
//         			}
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
        		$( "#logoPreview" ).click(function() {
        		    var logoTitle         = $( "#logoTitle" ).val();
        		    var logoTitleFontSize = $( "select[name=logoTitleFontSize]" ).val();
        		    var logoTitleFont     = $( "select[name=logoTitleFont]"     ).val();
        		    var logoTitleColor    = $( "input[name=logoTitleColor]"     ).val();

        		    var html = '<P id="preLogo" style="font-family:\'' + logoTitleFont + '\'; font-size:' + logoTitleFontSize + 'px; font-style:italic; color:#' + logoTitleColor + '">' + 
        					   logoTitle +
        					   '</p>';
        		    $( "#textLogo" ).html(html);
        		});
        		
        	};
        	 	
		var jsInsertSave = function(){
     	      if ( confirm("커뮤니티 개설을 승인하시겠습니까?") ) {

     		 	        $("#dataForm").ajaxSubmit({
     		   	            url      : "INC_openCmManageUpdate.do?confirm=Y",
     		   	            type     : "POST",
     		   	            dataType : "text",
     		   	            success  : function(response) {
     		   	            if (response == "true")  {
     		   	                    jsSuccessBox("승인 되었습니다.");
     		   	               		jsCloseWin();
     		   	               		parent.location.reload(); 
     		   	                } else { 
     		   	                	jsSuccessBox("승인 중 오류가 발생했습니다.");
     		   	                   	return;
     		   	                }
     		   	            }
     		   	        });
     	       	 }
     	};
     	   
		var jsUpdateApply = function(){
   	       	 if ( confirm("커뮤니티 정보를 수정 하시겠습니까?") ) {

   		 	        $("#dataForm").ajaxSubmit({
   		   	            url      : "INC_applyCmManageUpdate.do?applyClose=Y",
   		   	            type     : "POST",
   		   	            dataType : "text",
   		   	            success  : function(response) {
   		   	            if (response == "true")  {
   		   	                    jsSuccessBox("적용 되었습니다.");
   		   	               		jsCloseWin();
   		   	               		parent.location.reload(); 
   		   	                } else { 
   		   	                	jsSuccessBox("적용 중 오류가 발생했습니다.");
   		   	                   	return;
   		   	                }
   		   	            }
   		   	        });
   	       	 }
   	   	};
   	   	
  		// 부모창 커뮤니티 폐쇄 호출
           var jsClosePopupApply = function(el,cmmntyId, langCode, userId ) {
               //alert("커뮤니티 거절 창으로 이동합니다.");
               $(parent.location).attr("href", "javascript:jsPopupClose('"+cmmntyId+"','"+langCode+"','"+userId+"');");//부모창 함수 호출
//                $(window.parent.document).attr("href", "javascript:jsPopupClose('"+cmmntyId+"','"+langCode+"','"+userId+"');");//부모창 함수 호출
//                window.parent.jsPopupClose(el,cmmntyId,langCode,userId);
               //window.opener.jsPopupClose(cmmntyId,langCode,userId);
//                parent.location.href="javascript:jsPopupClose('"+cmmntyId+"','"+langCode+"','"+userId+"');";
           };
           // 사유입력 승인보류 view 
           var jsOpenPopupReject = function(el, cmmntyId, langCode, userId ) {
               $(parent.location).attr("href", "javascript:jsPopupReject('"+cmmntyId+"','"+langCode+"','"+userId+"');");//부모창 함수 호출
             // window.parent.jsPopupReject(el,cmmntyId,langCode,userId);
              //$(window.parent.document).attr("href", "javascript:jsPopupClose('"+cmmntyId+"','"+langCode+"','"+userId+"');");//부모창 함수 호출
             // window.opener.jsPopupReject(cmmntyId,langCode,userId);
//                parent.location.href="javascript:jsPopupReject('"+cmmntyId+"','"+langCode+"','"+userId+"');";
            };

            // 중복확인 버튼 클릭 이벤트
            var jsDulCheckAction = function (check) {
                var cmmntyNm = $("#cmmntyNm").val();
                var cmmntyUrl = $("#cmmntyUrl").val();
                if( check == "1"){
        	    	$.ajax({
        	            url      : "INC_cmNmUrlCheck.do",
        	            type     : "POST", 
        	            data     : { cmmntyNm : cmmntyNm  
            	            , cmmntyUrl : cmmntyUrl
            	            , cmNmUrlCheck : check
            	            , userId :  '<c:out value='${openCmManageView.userId}'/>'
            	            , cmmntyId :  '<c:out value='${openCmManageView.cmmntyId}'/>'
            	            , langCode :  '<c:out value='${openCmManageView.langCode}'/>' },
        	            async    : false,  //false 일 경우 동기로 요청한다는 뜻임. async 비동기
        	            success  : function (response) {
        	                if (response != "0") {
        	                    alert("커뮤니티 이름은 이미 존재합니다.");
        	                    $("#cmmntyNmCheck").val("");
        	                    $("#cmmntyNm").focus();
        	                    
        	                } else {
        	                    $("#cmmntyNmCheck").val("Y");
        	                	alert("입력하신 커뮤니티 이름은 사용할 수 있습니다.");
        	                }
        	            }
        	        });
                }else if( check == "2"){
        	    	$.ajax({
        	            url      : "INC_cmNmUrlCheck.do",
        	            type     : "POST", 
        	            data     : { cmmntyNm : cmmntyNm  
            	            , cmmntyUrl : cmmntyUrl
            	            , cmNmUrlCheck : check
            	            , userId :  '<c:out value='${openCmManageView.userId}'/>'
            	            , cmmntyId :  '<c:out value='${openCmManageView.cmmntyId}'/>'
            	            , langCode :  '<c:out value='${openCmManageView.langCode}'/>' },
        	            async    : false,  //false 일 경우 동기로 요청한다는 뜻임. async 비동기
        	            success  : function (response) {
        	                if (response != "0") {
        	                    alert("커뮤니티 주소가 이미 존재합니다.");
        	                    $("#cmmntyUrlCheck").val("");
        	                    $("#cmmntyUrl").focus();
        	                    
        	                } else {
        	                    $("#cmmntyUrlCheck").val("Y");
        	                	alert("입력하신 커뮤니티 주소는 사용할 수 있습니다.");
        	                }
        	            }
        	        });
					

                }
            };
           	//글자수체크
            var displayBytes  = function ( nm, id ){
                var obj  = document.getElementById( id );
                    if (obj.value.bytes() > nm){
                        if (event.keyCode != '8'){
                            alert(nm+'바이트까지 입력이 가능합니다.');
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


       	 //파일선택
    		var fileSel = function(el, inputNm){
    		   // $("input[name='"+inputNm+"']").val(el.value);
    		    jsPreview('file_add',inputNm, 'img1', 'spanFile1' ,990, 310, 1000, 'jpg,jpeg,png');
    		};
    		
    		//이미지 용량확인
    	 	var jsPreview = function(inputId, inputNm, imageId, parentId, width, height, filsize, fileExt) {
    	     	var source = $("input[name="+inputId+"]").val();
    	     	//확장자 잘라내기
    	      	var lastDot = source.lastIndexOf('.');
    	       var ext = source.substring(lastDot + 1);
    	  	    if(fileExt.indexOf(ext.toLowerCase()) == -1){
    	  	      	alert( "지원하지 않는 이미지 형식입니다.\n jpg, png 형식만 가능합니다!" );
    	  	        $("input[id='file_route']").val(""); 
    	  	    }else{
    	 		    $("#maxFileSize").val(filsize);
    	 		    $("#inputName").val(inputId);
    	 		   	$("#maxWidthSize").val(width);
    	 		   	$("#maxHeightSize").val(height);
    	 		    $("#fileExt").val("jpg,jpeg,png");
    	 		    
    	 	        $("#dataForm").ajaxSubmit({
    	 	            url      : "ND_uploadImgChk.do",
    	 	            type     : "POST",
    	 	            dataType : "text",
    	 	            async    : false,
    	 	            success  : function(response){
    	 	                        if(response == "100") {
    	 	                           //alert(Message.msg.processOk); 
    	 	                           preview(inputId, imageId, '', width, height, filsize, true);   
    	 	                        }else{
    	 	    	                    alert(response);    
    	 	    	                  // preview(inputId, imageId, parentId, width, height, filsize, false);    
    									$("input[id='file_route']").val("");
    	 	                        }
    	 	            }
    	 	        });
    	  	    } 
    	 	};

    		var jsTrShowHide = function (fn){

    		    if(fn == "N"){
    	 	   		$("#logoT_1").show();
    		 	   	$("#logoT_2").hide();
    		    }else if(fn == "Y"){
    	 	   		$("#logoT_1").hide();
    		 	   	$("#logoT_2").show();
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
    	                      preViewer.src = "/resources/ms/common/images/admin/transparent.png"; 
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
    	                   targetImage.src = "/resources/ms/images/@thumb-intro.jpg"; //기본 이미지

    	                   
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
         	//]]>
	</script>       	
</head>
<body>
<!-- 컨텐츠영역 -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="userId" name="userId" value="<c:out value="${openCmManageView.userId}"/>" />
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${openCmManageView.cmmntyId}"/>" />
		<input type="hidden" id="langCode" name="langCode" value="<c:out value="${openCmManageView.langCode}"/>" />
		<input type="hidden" id="cmmntySttusCd" name="cmmntySttusCd" value="<c:out value="${openCmManageView.cmmntySttusCd}"/>" /> 
		<input type="hidden" name="logoTitleWidthLc" value="<c:out value="${openCmManageView.logoTitleWidthLc}" default="0" />" />
		<input type="hidden" name="logoTitleVrticlLc" value="<c:out value="${openCmManageView.logoTitleVrticlLc}" default="0" />" />   
		
		<input type="hidden" id="cmmntyNmCheck"  name="cmmntyNmCheck" value="Y" />
		<input type="hidden" id="cmmntyUrlCheck"  name="cmmntyUrlCheck" value="Y" />
		
		<input type="hidden" name="inputName" id="inputName" value=""/>
		<input type="hidden" name="maxFileSize" id="maxFileSize" value=""/>
		<input type="hidden" name="maxWidthSize" id="maxWidthSize" value=""/>
		<input type="hidden" name="maxHeightSize" id="maxHeightSize" value=""/>
		<input type="hidden" name="fileExt" id="fileExt" value=""/>
		
		<input type="hidden" id="logoFileSeq" name="logoFileSeq" value="<c:out value="${openCmManageView.logoFileSeq}"/>" />
		
	<div id="popup">
	 
		<h2 class="mar_t20">커뮤니티 <c:if test="${  openCmManageView.cmmntySttusCd == '1002'  }">승인</c:if><c:if test="${  openCmManageView.cmmntySttusCd != '1002' } ">개설신청 </c:if>상세</h2>
		<fieldset>
		<legend>신청자 기본 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="신청자 기본 정보">
            		<caption class="hidden"> 신청자 기본 정보 </caption>
			<colgroup>
			  <col width="11%" />
			  <col width="39%" />
			  <col width="11%" />
			  <col width="39%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>이름</span></th>
					<td><c:out value="${openCmManageView.userNm}"/></td>
					<th>회원등급</th>
					<td><c:out value="${openCmManageView.userGradCode}"/></td>
				</tr>
              	<tr>
					<th><span>전화번호</span></th>
					<td><span><c:out value="${openCmManageView.telno}"/></span></td>
					<th>회원구분</th>
					<td><span><c:out value="${openCmManageView.userTyNm}"/></span></td>
				</tr>
				<tr>
					<th><span>휴대전화</span></th>
					<td><span><c:out value="${openCmManageView.mbtlnum}"/></span></td>
					<th>회사명</th>
					<td><span>
					<c:if test="${openCmManageView.userTyCd == '1001' ||  openCmManageView.userTyCd == '1002'}"><c:out value="${userOption.cmpnyNm}"/></c:if>
					<c:if test="${openCmManageView.userTyCd == '2001' ||  openCmManageView.userTyCd == '2002'}"><c:out value="${userEntrprsOption.cmpnyNm}"/></c:if>
					</span></td>
				</tr>
				<tr>
					<th><span>이메일 주소</span></th>
					<td><span><c:out value="${openCmManageView.email}"/></span></td>
					<th>스토어명</th>
					<td><span><c:out value="${openCmManageView.langStoreNm}"/></span></td>
				</tr>
				</tbody>
          </table>
        </fieldset>
        <h2 class="mar_t20">커뮤니티 정보</h2>
        <fieldset>
		<legend>커뮤니티 정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="커뮤니티 정보">
            		<caption class="hidden"> 커뮤니티 정보 </caption>
			<colgroup>
			  <col width="11%" />
			  <col width="39%" />
			  <col width="11%" />
			  <col width="39%" />
			</colgroup>
			<tbody>
          	<tr>
					<th><span>커뮤니티 이름</span></th>
					<td><span><input type="text" id="cmmntyNm"  name="cmmntyNm" size="45" value="<c:out value="${openCmManageView.cmmntyNm}"/>"  />
					<input type="button" id="cmmntyNmCheck" name="cmmntyNmCheck" class="bt_grad g_L" value="사용가능체크"  onclick="jsDulCheckAction('1');"  /></span></td>
					<th>지원 언어</th>
					<td><span><select id="langCodeSelect" name="langCodeSelect" title="분류를 선택해주세요" class="over" disabled="disabled">
											<option value="">언어선택</option>
											<c:forEach items="${langCodeList}" var="langCode" varStatus="status">
											<option value="${langCode.langCode}"<c:if test="${langCode.langCode == openCmManageView.langCode}" > selected="selected"</c:if>>${langCode.langNm}</option>
											</c:forEach>
										</select></span></td>
				</tr>
				<tr>
					<th><span>커뮤니티 주소</span></th>
					<td><span>http://<input type="text" id="cmmntyUrl"  name="cmmntyUrl" style="width: 300px" value="<c:out value="${openCmManageView.cmmntyUrl}"/>" disabled="disabled"/> 
<!-- 					<input type="button" id="cmmntyUrlCheck" name="ccmmntyUrlCheck" class="bt_grad g_L" value="사용가능체크"   onclick="jsDulCheckAction('2');" /> -->
<!-- 					</span></td> -->
					
					<th>커뮤니티 카테고리</th>
					<td><span><op:code id="cmmntyCtgryCd"  grpCd="2011" type="select" defaultValues="${openCmManageView.cmmntyCtgryCd}" /></span></td> 
				</tr>
				<tr>
					<th><span>커뮤니티 설명</span><br/><span id="cmmntyDc_bytes">0</span>/2000 byte </th>
					<td colspan="3">
					<textarea id="cmmntyDc" name="cmmntyDc"  rows="8" class="w99_p" onkeyup="javascript:displayBytes(950,'cmmntyDc');"  onblur="javascript:displayBytes(950,'cmmntyDc');" ><c:out value="${openCmManageView.cmmntyDc}"/></textarea></td>
				</tr>
				<tr>
					<th><span>가입 방식</span></th>
					<td colspan="3"> 
					<span><input type="radio" id="cmmntySbscrbMthd_1" name="cmmntySbscrbMthd" value="1" <c:if test="${openCmManageView.cmmntySbscrbMthd eq '1'}">checked="checked"</c:if> />
		                <label for="cmmntySbscrbMthd_1">가입 신청 시 바로 가입할 수 있습니다.</label><br/>
		                <input type="radio" id="cmmntySbscrbMthd_2" name="cmmntySbscrbMthd" value="2" <c:if test="${openCmManageView.cmmntySbscrbMthd eq '2'}">checked="checked"</c:if> />
		                <label for="cmmntySbscrbMthd_2">가입 신청 시 운영자의 승인을 거쳐 가입할 수 있습니다.</label></span></td>
				</tr>
				<tr>
					<th><span>로고 등록 방식</span></th>
					<td colspan="3"> 
					<span><input type="radio" id="logoDirectRegistAt_N" name="logoDirectRegistAt" value="N" <c:if test="${openCmManageView.logoDirectRegistAt eq 'N'}">checked="checked"</c:if>  onclick="jsTrShowHide('N')"/>
		                <label for="logoDirectRegistAt_N">기존 로고 타이틀 등록</label><br/>
		                <input type="radio" id="logoDirectRegistAt_Y" name="logoDirectRegistAt" value="Y" <c:if test="${openCmManageView.logoDirectRegistAt eq 'Y'}">checked="checked"</c:if> onclick="jsTrShowHide('Y')" />
		                <label for="logoDirectRegistAt_Y">로고 이미지 직접 등록</label></span></td>
				</tr>
				<tr id="logoT_1" >
					<th><span>로고 타이틀</span></th>
					<td colspan="3">
					<div>
							<ul>
								<span>▶ 폰트:</span>
								<select name="logoTitleFont" title="폰트 선택" style="width:145px">
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
								<span><label for="txtColor">▶ 색상:</label></span>
								<span class="color_txt">
									<input type="text" id="picker" name="logoTitleColor" value="<c:out value="${openCmManageView.logoTitleColor}" default="000000"/>" style="width:120px" />
								</span>
								&nbsp;
								<span>▶ 크기:</span>
								<select  name="logoTitleFontSize" title="폰트 크기 선택" style="width:80px">
									<c:forEach var="size" begin="14" end="72" step="2">
									<option value="${size}">${size}px</option>
									</c:forEach>
								</select>		
								&nbsp;	
								<span>▶ 내용:</span>
								<input type="text" id="logoTitle"  name="logoTitle" size="45" value="<c:out value="${openCmManageView.logoTitle}" default="Open Market Place" />" style="width:180px"/>
								<input type="button" id="logoPreview" class="bt_grad g_L" value="적용하기" />
							</ul>	<!-- //logobox _style -->
						</div>
						<br/>
						<div id="containerLogo" style="overflow-x:scroll;">
							<div class="result" >
								<img id="mainLogo" src="/resources/cmmnty/default/images/img_skin.jpg" alt="" style="width: 999px; height: 170px"/>
								<div id="textLogo" class="inertxt" ></div>
							</div>
						</div></td>
				</tr>
				<tr id="logoT_2" style="display:none;">
					<th><span>로고 타이틀</span></th>
					<td colspan="3"> 
					<div>
							<ul>
								<span>▶ 로고 이미지 직접 등록  <p>로고 타이틀 이미지의 최적 사이즈는 가로 956pixel, 세로 50pixel ~ 170pixel 입니다.</p> </span>
								<div >
									<span id="spanFile1"><input type="file" id="file_add" name="file_add"  title="찾아보기" onchange="fileSel(this, '');"  style="width:494px"/></span>
								</div>
							</ul>
					</div>
					<br/>
					<div id="containerLogo" style="overflow-x:scroll; overflow-y:hidden;"">
						<div class="result" >
						<c:if test="${openCmManageView.logoFileSeq == 1 || openCmManageView.logoFileSeq == -1}">
						<img id="img1" src="/resources/cmmnty/default/images/img_skin.jpg" alt="대표이미지" style="width:999px; height:170px;" >
						</c:if>
						<c:if test="${openCmManageView.logoFileSeq != 1 && openCmManageView.logoFileSeq != -1}">
						<img id="img1" src="<c:out value="${openCmManageView.logoFileUrl}"/>" alt="대표이미지" style="width:999px; height:170px;" >
						</c:if>
						</div>
					</div>
				</td>
				</tr>
				
				<tr>
					<th><span>커뮤니티 개설<br/>신청 사유</span> <br/><span id="estblReqstResn_bytes">0</span>/2000 byte</th>
					<td colspan="3"><span>
					<textarea id="estblReqstResn" name="estblReqstResn"  rows="8" class="w99_p" onkeyup="javascript:displayBytes(950,'estblReqstResn');"  onblur="javascript:displayBytes(950,'estblReqstResn');" ><c:out value="${openCmManageView.estblReqstResn}"/></textarea>
					</span></td>
				</tr>
        		</tbody>
         	</table>
        </fieldset>
        
        <p class="tx_c mar_t20">
        <div>
           <div class="float_l">
           <c:if test="${ openCmManageView.cmmntySttusCd == '1002' }">
				<a href="#none" class="btn"><button id="buttonApply" type="button" onclick="jsClosePopupApply(this,'<c:out value="${openCmManageView.cmmntyId}"/>','<c:out value='${openCmManageView.langCode}'/>','<c:out value='${openCmManageView.userId}'/>');" class="blue">커뮤니티폐쇄</button></a>
			</c:if>
           </div>
           <div class="float_r">
           		<c:if test="${ openCmManageView.cmmntySttusCd == '1001' }">
				<a href="#" class="btn"><button id="buttonSave" type="button" onclick="jsInsertSave();" class="blue">승인</button></a>
				<a href="#" class="btn"><button id="buttonReject" type="button" onclick="jsOpenPopupReject(this,'<c:out value="${openCmManageView.cmmntyId}"/>','<c:out value='${openCmManageView.langCode}'/>','<c:out value='${openCmManageView.userId}'/>');" class="blue">거절</button></a>
				</c:if>
				<c:if test="${ openCmManageView.cmmntySttusCd == '1002' }">
				<a href="#" class="btn"><button id="buttonApply()" type="button" onclick="jsUpdateApply();" class="blue">적용</button></a>
				<a href="#" class="btn"><button id="buttonClose()"  type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
				</c:if>
          </div>
		</div>
		</p>
	</div>
	</form>
</body>
</html>