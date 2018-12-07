<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	    
    
    <title>서비스등록페이지</title>
    
    <op:jsTag type="openworks" items="form, validate, ckeditor" />
    <op:jsTag type="spi" items="form, validate, colorbox" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
	<style>
		input::placeholder {
		  color: #E5E3E3;
		  font-style: italic;
		  font-weight: bold;
		  
		}
    </style> 


     
    <script type="text/javascript">
        $(function(){
            $(window).on('scroll'
                    ,function(){
                		$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");
                    }
            );
        });
    </script>
    
    <script type="text/javascript">
    
	 	// 숫자만 입력하도록 체크
		function jsOnlyNumber(event){
			 var keyID = (event.which) ? event.which : event.keyCode;
			  if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
			else return false;
		}
	 	
		// 숫자만 입력하도록 체크2
		function removeChar(event) {
			event = event || window.event;
			 var keyID = (event.which) ? event.which : event.keyCode;
			  if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) return;
			else event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
		
		//[] <--문자 범위 [^] <--부정 [0-9] <-- 숫자  
      	//[0-9] => \d , [^0-9] => \D
      	// 세자리 3자리 콤머 자동등록
      	var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
      	var rgx2 = /(\d+)(\d{3})/; 

      	function getNumber(obj)
      	{        
			var num01;
           	var num02;
           	num01 = obj.value;
           	num02 = num01.replace(rgx1,"");
           	num01 = setComma(num02);
           	obj.value =  num01;
		}

      	function setComma(inNum)
      	{           
        	var outNum;
           	outNum = inNum; 
           	while (rgx2.test(outNum)) 
           	{
                outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
            }
           	return outNum;
      	}
      	

      	var prev = ""; 
      	var regexp = /^\d{0,2}(\.\d{0,1})?$/;
      	
      	function svcUseful_kup(obj)  
      	{ 
      	    if(obj.value.search(regexp)==-1) { 
      	        obj.value = prev; 
      	    } 
      	    else { 
      	        prev = obj.value; 
      	    } 
      	} 

        
    	$("#exttbl").hide();
    	
        $().ready(function(){

            //jsNationChange('00');
            if($("#langCode").val() == '00'){
                $("#nation").hide();
            }else{
                $("#nation").show();
            }
    
      		/********* 임시 주석 저장 테스트를 위해..            
            $("#dataForm").validate({
                rules: {
                    goodsNm              : { required : true, maxlength : 100}
                   ,comouDe              : { required : function () {return $("#insertSection").val() == 1002;}, formatDate : true}
                   ,langCode             : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,goodsMakr            : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,archtcSe             : { required : function () {return $("#insertSection").val() == 1002;}} //아키텍쳐
                   ,goodsKndCd           : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,goodsChargerCttpc1   : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
                   ,goodsChargerCttpc2   : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
                   ,goodsChargerCttpc3   : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
                   // ,goodsChargerMbtlnum1 : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
                   //,goodsChargerMbtlnum2 : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
                   //,goodsChargerMbtlnum3 : { required : function () {return $("#insertSection").val() == 1002;}, number : true} 
                   ,goodsChargerNm       : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,goodsChargerEmail1   : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,goodsChargerEmail2   : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,goodsVerInfo         : { required : function () {return $("#insertSection").val() == 1002;}}
                   ,goodsSumry           : { required : function () {return $("#insertSection").val() == 1002;}}
                   //,goodsSumry         : { required : true}
                   ,itemVodUrl           : { url : true}
                   ,goodsDwldUrl         : { url : true}
                   //,demoExprnUrl      : { url : true} 
                   ,goodsHmpgUrl         : { url : true}
                   ,goodsMonitorUrl      : { url : true}
                   ,langStoreNm          : { required : function () {return $("#insertSection").val() == 1002;}} // 회사명
                   ,goodsPc              : { required : function () {return $("#insertSection").val() == 1002;}} // 단가
                }
               ,invalidHandler: function(event, validator){
                    $("#loading-container").hide();
                }
            });
            
            *************/
           
            if($("#curStep").val() == 2){
            	displayBytes(3000,'goodsSumry');
            } else if($("#curStep").val() == 5){
            	//displayBytes(3000,'chgItemContent');
            }

            $("input[id=metaLangs1006]").click(function(){
                if($(this).attr("checked")){
                    $("#metaLangEtc").removeAttr("readonly");
                    $("#metaLangEtc").focus();
                }else{
                    $("#metaLangEtc").val("");
                    $("#metaLangEtc").attr("readonly","true");
                }
            });
    
            $('input[name="goodsMarkCds"]').click(function() {
                if ($(this).is(':checked') && $(this).val() == "1005") {
                    return confirm("조달청 등록서비스와 동일한 내용으로 등록하여야 합니다.\n만일 허위·과장 정보를 등록하여 적발될 경우 조달청 나라장터\n종합쇼핑몰 서비스등록이 취소될 수 있으며 기타 피해에 대한\n모든 책임을 지셔야 합니다.");
                }
            });

            // 1 ~ 5 단계 각각 이동 클릭
            $(".serviceprocess").click(function()
            {
                /*************************
                <c:if test="${onoff1 eq 'on'}" >
					var valid = $("#dataForm").valid();
	                
	                var ctgrysVal = $("#setCtgryCodes").val();
	                
	                if  (ctgrysVal == "") 
	                {
	                    $("#err_setCtgryCodes").show();                    
	                }
	                else
	                {
	                    $("#err_setCtgryCodes").hide();
	                }
                </c:if>
                
                
                
                var nxt = eval( $(this).attr("value") ) ;
                var cur = eval( $("#curStep").val() ) ;
                var goodsCode = '${session_GoodsCode}';
                
                if  (nxt == cur) exit ;

                if (goodsCode == "") {
                    //1단계 저장 없이 넘어감 방지
                    alert('서비스 일반정보 등록은 필수 입니다. \n필수 정보 입력 후 다음단계로 이동하시기 바랍니다.');
                    return;
                }

                $("#nxtStep").val( $(this).attr("value") );

                $("#dataForm").attr("action", "/korean/pt/sale/goods/BD_goodsForm.do");
                $("#dataForm").submit();
                 **********/
            });
            
            jsMoving( $("#curStep").val() );
            
            //alert($("#curStep").val());
            
/* 
            $('[name="cInfrstrctr"]').click(function () {
                
                $('input:checkbox[name=cInfrstrctr]:checked').each(function () { 
                	alert($(this).val());
                	
                	if ($(this).val() == '1007') {
                	    $("#cInfrstrctrEtc").attr("readonly", false);
                	}else{
                	    $("#cInfrstrctrEtc").attr("readonly", true);
                	}
            	});
                
                
            });
 */         
 
 			if ( $("#isMark").is(":checked") ) {
 				$("#markCrtfcFile0Span").hide();
 				$("#markCrtfcFile1Span").hide();
 				$("#markCrtfcFile3Span").hide();

 				$("#markCrtfcFile0Images").hide();
 				$("#markCrtfcFile1Images").hide();
 				$("#markCrtfcFile3Images").hide();

 				$("#gsCrtfcNo").attr("readonly",true);
 			} else {
 				$("#markCrtfcFile0Span").show();
 				$("#markCrtfcFile1Span").show();
 				$("#markCrtfcFile3Span").show();

 				$("#markCrtfcFile0Images").show();
 				$("#markCrtfcFile1Images").show();
 				$("#markCrtfcFile3Images").show();

 				$("#gsCrtfcNo").attr("readonly",false);
 			}
 
        });
        
        
        var fnReadAble = function (val, nm) {
            var flag = $('input:checkbox[name="'+nm+'"]').is(":checked");;
            
            //var cInfrstrctr = $('input:checkbox[name="cInfrstrctr"]').is(":checked");
            //var cPltfom = $('input:checkbox[name="cPltfom"]').is(":checked");
            
            if (flag) {
                if ((nm == "cInfrstrctr") && (val == '1007')) {
                    $("#cInfrstrctrEtc").attr("readonly", false);
                }
                if ((nm == "cPltfom") && (val == '1004')) {
                    $("#cPltfomEtc").attr("readonly", false);
                }
                if ((nm == "cCnslRelm") && (val == '1004')) {
                    $("#cCnslRelmEtc").attr("readonly", false);
                }
                if ((nm == "cExcPd") && (val == '1008')) {
                    $("#cExcPdEtc").attr("readonly", false);
                }
                
                
            }else{
                if (nm == "cInfrstrctr") {
                	$("#cInfrstrctrEtc").attr("readonly", true);
                }
                if (nm == "cPltfom") {
                    $("#cPltfomEtc").attr("readonly", true);
                }
                if (nm == "cCnslRelm") {
                    $("#cCnslRelmEtc").attr("readonly", true);
                }
                if (nm == "cExcPd") {
                    $("#cExcPdEtc").attr("readonly", true);
                }
            }
            
        } 
        
		// '이전' 버튼 클릭
        var jsPrevMov = function(obj)
		{            
		    var curPage = $("#curStep").val();
		    
		    if (curPage == 5) $("#nxtStep").val( --curPage ); // '수정' 버튼을 누를 시 처음으로 간다.     
		    else  		      $("#nxtStep").val( --curPage ); // 이전으로 간다.
		    
		    //if (curPage == 5) $("#nxtStep").val( 1 ); // '수정' 버튼을 누를 시 처음으로 간다.     
		    //else  		      $("#nxtStep").val( --curPage ); // 이전으로 간다.
		    
            $("#dataForm").attr("action", "BD_goodsForm.do");
            $("#dataForm").submit();
        }
		
        // '다음' 버튼 클릭
		var jsNextMov = function()
		{            
		    var curPage = $("#curStep").val();
		    
		    $("#nxtStep").val( ++curPage );
            $("#dataForm").attr("action", "BD_goodsForm.do");
            $("#dataForm").submit();
        }
		
        function jsMoving(curStep){

        	// 1단계 클릭시!!
        	if  (curStep == 1) { $("#btnPrev").hide(); }
        	else               { $("#btnPrev").show(); }
        	
        	// 5단계 클릭시!!
        	if  (curStep == 5)
       	    {
        	    $("#btnPrev").text("이전");        	    
        	    //$("#btnPrev").text("수정");        	    
        	    $("#btnNext").hide();
        	    
        	    $("#tempSave").hide();
        	    $("#request_authorization").show();
       	    }
        	else
       	    {
        	    $("#btnPrev").text("이전");        	    
        	    $("#btnNext").show();
        	    
        	    $("#tempSave").show();
        	    $("#request_authorization").hide();
       	    }            
        }
        
		
        
        
        var strCtgryCurrentVal = "1002";
        
        // 서비스구분선택 변경시
        var jsGoodsKndCd = function(vl)
        {
            var ctgrysVal = $("#setCtgryCodes").val();
            
            if ($.trim(ctgrysVal) != "") 
            {
                if (confirm("서비스구분 변경 시 연결된 카테고리가 초기화됩니다.\n변경하시겠습니까?"))
                {
                    strCtgryCurrentVal = vl;
                    $("#setCtgryCodes").val('');
                    $('#goods').html('');
                    
                    $("#goods_type_1001").hide();
                    $("#goods_type_1002").hide();
                    $("#goods_type_1003").hide();
                    $("#goods_type_1004").hide();
                    $("#goods_type_"+vl).show();
                    
                    if  (vl == "1004") $("#goods_type_SPL").hide()
                    else               $("#goods_type_SPL").show();
                }
                else
                {
                    $('input:radio[name="goodsKndCd"]:input[value='+strCtgryCurrentVal+']').attr("checked", true);
                }
            } 
            else 
            {
                strCtgryCurrentVal = vl;
                
                $("#goods_type_1001").hide();
                $("#goods_type_1002").hide();
                $("#goods_type_1003").hide();
                $("#goods_type_1004").hide();
                $("#goods_type_"+vl).show();
                
                if  (vl == "1004") $("#goods_type_SPL").hide()
                else               $("#goods_type_SPL").show();                    
            }
        };
        
		        
    
        var jsNationChange = function(langCode){
            location.search = "?langCode=" + langCode;
            location.reload;
        };
    
        var jsLoading = function(){
            $("#loading-container").show();
            return true;
        };
        
        //서비스 임시저장 및 등록 신청
        var jsGoodsInsertAction = function(sttus, mode, step) {
            
            // VAT포함
            if ($('input:checkbox[name=svcPcVat]').is(':checked')==false){
                $("input[name=svcPcVat]").val('N');
        	}

            // VAT포함
            if ($('input:checkbox[name=svcPcVat]').is(':checked')==true){
                $("input[name=svcPcVat]").val('Y');
        	}

            // 해당사항없음
            if ($('input:checkbox[name=isMark]').is(':checked')==false){
                $("input[name=isMark]").val('N');
        	}

         // 해당사항없음
            if ($('input:checkbox[name=isMark]').is(':checked')==true){
                $("input[name=isMark]").val('Y');
        	}
        	
            if  ( checkEditor() == true )
            {
	            // 임시저장(1001),등록신청(1002)
	            $("#goodsRegistSttus").val(sttus);
	            $("#insertSection").val(sttus);
	            $("#mode").val(mode);
	            
				var msg = "" ;
				
				var strUpdateYn = $("#updateYn").val();

				if(strUpdateYn == 'update' && step == "5"){
		            msg = "승인요청시 비전시가 됩니다. \n승인요청 하시겠습니까?" ;
				} else {
		            if  (sttus == '1001') msg = "임시저장 하시겠습니까? 임시 저장한 서비스는 승인대기서비스 목록에서 확인할 수 있습니다." ; 
		            if  (sttus == '1002') msg = "승인요청 하시겠습니까?" ;
				}
					
				if(mode == "tempSave")  {  

					if(strUpdateYn == 'update' && step == "5"){
						var str = $.trim( $("#chgItemContent").val() );
						
	 			        if (str == null || str.length < 1){
				            
				        	alert("수정사유를 입력 하여 주십시요.");
				            $(" chgItemContent").focus();
				            return false;
				        } 

				        if ( str.length < 10){
				            
				        	alert("수정사유를 15글자 이상 입력 하여 주십시요.");
				            $("#chgItemContent").focus();
				            return false;
				        }			         
					}				

					if (confirm(msg)){            
	           	
	                	$("#tempSave").removeAttr('onclick');
	                   	$("#nextMove").removeAttr('onclick');
	                   
	                   	$("input[type=file]").each(function(){
	                    	if(this.value == ''){
	                        	$("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                           	$("#"+this.id).attr("disabled","disabled");
	                       	}
	                   	});
	                   
	                   	if (step == "1") {
	                    	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep1.do");
	                   	}
	                   	if (step == "2") {
	                    	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep2.do");
	                   	}
	                   	if (step == "3") {
	                   	    $("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep3.do");
	                   	}
	                   	if (step == "4") {
	                    	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep4.do");
	                   	}
	                   	if (step == "5") {
	                    	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep5.do");
	                   	}
	                   	$("#dataForm").submit();
	               }else{
	                   $("#loading-container").hide();
	                   return;
	               }
	            }else if(mode == "nextMove") { 
	            	$("#tempSave").removeAttr('onclick');
	               	$("#nextMove").removeAttr('onclick');
	               
	               	$("input[type=file]").each(function(){
	                	if(this.value == ''){
	                    	$("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                       	$("#"+this.id).attr("disabled","disabled");
	                   	}
	               	});
	               
	               	if (step == "1") {
	                	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep1.do");
	               	}
	               	if (step == "2") {
	                	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep2.do");
	               	}
	               	if (step == "3") {
	               	    $("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep3.do");
	               	}
	               	if (step == "4") {
	                	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep4.do");
	               	}
	               	if (step == "5") {
	                	$("#dataForm").attr("action", "/korean/pt/sale/goods/ND_goodsActionStep5.do");
	               	}
	               	$("#dataForm").submit();
	            }
	    
	            $("#tempSave").attr("onclick", "if (jsLoading()==true){jsGoodsInsertAction('1001','tempSave');};");
	            $("#nextMove").attr("onclick", "if (jsLoading()==true){jsGoodsInsertAction('1001', 'nextMove');};");
            }
            else
            {
                $("#loading-container").hide();
            }
        };
    
        // '카테고리 선택' 클릭시..!!
        var jsCtgrySelPop = function(el)
        {
            var goodsTyCd = $(':radio[name="goodsKndCd"]:checked').val().substring(2);
            
            $(el).colorbox({
                title        : "",
                href         : "/korean/pt/sale/goods/PD_categoryPop.do?PID=ST" + goodsTyCd,
                width        : "500",
                height       : "600",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
        };
    
        var jsCtgrySel = function(){
            var ctgryCodes = $("#setCtgryCodes").val();
            if($.trim(ctgryCodes) == ""){
                $('li#goodsCtgry').remove();
            }else{
                ctgryCodes = ctgryCodes.split(",");
    
                var ctgryCodeUrl = "";
                for(var i = 0; i < ctgryCodes.length; i++){
                    if(i > 0){
                        ctgryCodeUrl += "&";
                    }
                    ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
                }
                
                /* {{ BH, 2015.12.16 서비스등록 디자인 변경으로 인한 소스수정 */
                var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
                $.post(url, function(response){
                    if(response.length > 0){
                        var htmlVal = "";
                        //$('li#goodsCtgry').remove();
                        //htmlVal = '<li id="goodsCtgry">';
    
                        for(var i = 0; i < response.length; i++) {
                            htmlVal += '<span id="goodsCtgry_' + response[i].ctgryCode + '">';
                            //htmlVal += response[i].ctgryClNm ;
                            htmlVal += response[i].ctgryPath ;
                            //htmlVal += '<button onclick="jsCategoryDelete(this); return false;" id="goodsCtgry_' + response[i].ctgryCode + '" title="' + response[i].ctgryPath + '삭제">';
                            htmlVal += '<input type="hidden" name="ctgryCds" class="getCtgryCodes" value="' + response[i].ctgryCode + '"/>';
                            htmlVal += '<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsCategoryDelete(this); return false;" id="goodsCtgry_' + response[i].ctgryCode + '" title="' + response[i].ctgryPath + '삭제"/>';
                            if((i+1) < response.length)htmlVal += ',';
                            htmlVal += '  </span>';
                        }
    
                        //htmlVal += '</li>';{{}}
                        $('#goods').html(htmlVal);
                    }
                });
                /* }} */
            }
        };
    
        //카테고리삭제
        var jsCategoryDelete = function(el){
           
             if($('img[id^=goodsCtgry_]').length > 1){
                $('span#' + el.id).remove();
                $("input[name=ctgryCds]").each(function(i){
                    if($("input[name=ctgryCds]").eq(i).val() == el.id.substr(11)){
                        $("input[name=ctgryCds]").eq(i).remove();
                    }
                });
            }else{
                alert("카테고리는 최소 한개 이상 존재해야합니다.");
            } 
        };
    
        var jsFileRemove = function(seq){
            imgAppend(seq);
        };
    
        var imgAppend = function(seq){
            //파일 X 버튼 클릭(이미지)
            var htmlVal = "";
            htmlVal += '<span id="imgPrev' + seq + '" >';     
            htmlVal += '<a href="#" class="del" onclick="jsFileRemove(\''+seq +'\'); return false;">삭제</a>';
            htmlVal += '<p class="thumbimg"></p>';
            htmlVal += '<a href="#">변경</a>';
            htmlVal += '<p class=" req" id="fileSet' + seq + '" style="opacity:0; overflow:hidden; position:absolute; top:110px; right:50px;width:50px;">';
            htmlVal += "<input type=\"file\" name=\"imageFile" + seq + "\" id=\"imageFile" + seq + "\" onchange=\"jsPreview('imageFile" + seq + "', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png'," + seq + ",'Img',-1,5,this);\"/>";
            htmlVal += '<input type="hidden" name="fileDesc" id="imageFile' + seq + 'Desc" value=""/>';
            htmlVal += ' </p>';
            htmlVal += '</span>';
            $("span#imgPrev"+seq).remove();
            var seq = seq - 1;
            //alert(seq);
            if(seq == 0){
               seq = 0; $("span#imgPrev"+seq).before(htmlVal);
               // $("span#imgPrev1").html(htmlVal);
            }else if(seq ==1){
                seq = 3; $("span#imgPrev"+seq).before(htmlVal);
            }else if(seq == 5){
                seq = 7; $("span#imgPrev"+seq).before(htmlVal);
            }else{
                $("span#imgPrev"+seq).after(htmlVal);
            }
        };
    
        var checkEditor = function()
        {
            <c:if test="${onoff1 eq 'on'}" >
	            
            	// 서비스명
	            if ($("#goodsNm").val() == null || $("#goodsNm").val() == "")
	            {
	                alert("서비스명을 입력해주세요.");
	                $("#goodsNm").focus();
	                return false;
	            }
            	
            	// 서비스 구분
            	if ($('input:radio[name=goodsKndCd]').is(':checked')==false)
            	{
            	    alert("서비스구분을 선택하세요.");
	                $("input[name=goodsKndCd]").focus();
	                return false;
            	}
	    
	            // 카테고리
	            if ($("#setCtgryCodes").val() == null || $("#setCtgryCodes").val() == "")
	            {
	                alert("카테고리를 선택해주세요.");
	                $("#jsCtgrySelPop").focus();
	                return false;
	            }
	            
	            // 과금기준
	            if ($('input:radio[name=dueStdrMumm]').is(':checked')==false)
            	{
            	    alert("과금기준을 선택하세요.");
	                $("input[name=dueStdrMumm]").focus();
	                return false;
            	}	            
	            
	            // 서비스 가격단위
	            if ($("#svcPcUntCd").val() == '1001')
	            {
		            if(($("#svcPc").val()).length < 2){
		            	alert("한화 선택시 2자리 이상으로 입력하여 주십시요.");
		            	$("#svcPcUntCd").focus();
		            	return false;
		            }
		            
	            }            

	            // 서비스 가격
	            if ($("#svcPc").val() == null || $("#svcPc").val() == "")
	            {
	                alert("서비스가격을 입력해주세요.");
	                $("#svcPc").focus();
	                return false;
	            }            
	            
	            // 최소 계약기간
	            if ($("#mummCntrctpd").val() == null || $("#mummCntrctpd").val() == "")
	            {
	                alert("최소 계약기간을 입력해주세요.");
	                $("#mummCntrctpd").focus();
	                return false;
	            }
	    
	             //대표이미지
	            if (   ($("input[name=imageFile1]").val() == null || $("input[name=imageFile1]").val() == ""  ) &&  ($("#goodsImageFileSeq").val() == null || $("#goodsImageFileSeq").val() == ""))
	            {
	                alert("대표이미지를 등록해주세요.");
	                $("#imgPrev1Btn").focus();
	                return false;
	            }
	             
            </c:if>
            
            <c:if test="${onoff2 eq 'on'}" >  
	         	
	        	// 서비스개요
	            if ($("#goodsSumry").val() == null || $("#goodsSumry").val() == "")
	            {
	                alert("서비스개요를 입력해주세요.");
	                $("#goodsSumry").focus();
	                return false;
	            }
	        	
	            // 특장점
	        	var chkVar = CKEDITOR.instances.itemSfe.getData();	        	
	            if (chkVar == null || chkVar == "")
	            {
	                alert("특장점을 입력해주세요.");
	                CKEDITOR.instances.itemSfe.focus();
	                return false;
	            }
	        	
	            // 대상고객
	        	var chkVar = CKEDITOR.instances.cstmrInfo.getData();	        	
	            if (chkVar == null || chkVar == "")
	            {
	                alert("대상고객을 입력해주세요.");
	                CKEDITOR.instances.cstmrInfo.focus();
	                return false;
	            }
	        	
	            // 주요기능
	        	var chkVar = CKEDITOR.instances.goodsMainFnct.getData();	        	
	            if (chkVar == null || chkVar == "")
	            {
	                alert("주요기능을 입력해주세요.");
	                CKEDITOR.instances.goodsMainFnct.focus();
	                return false;
	            }
	            

	            // 주요 레퍼런스
	        	var chkVar = CKEDITOR.instances.goodsRefer.getData();	        	
	            if (chkVar == null || chkVar == "")
	            {
	                alert("주요 레퍼런스을 입력해주세요.");
	                CKEDITOR.instances.goodsRefer.focus();
	                return false;
	            }
	            
	            
	            // 서비스 기대효과
	        	var chkVar = CKEDITOR.instances.goodsExpcEffect.getData();	        	
	            if (chkVar == null || chkVar == "")
	            {
	                alert("서비스 기대효과을 입력해주세요.");
	                CKEDITOR.instances.goodsExpcEffect.focus();
	                return false;
	            }
	            
	            <c:if test="${goodsInfo.goodsKndCd ne '1004'}">
	            
	            // 서비스관리기준
	            if ($("#metaSvcs").val() == null || $("#metaSvcs").val() == "")
	            {
	                alert("서비스관리기준을 입력해주세요.");
	                $("#metaSvcBtn").focus();
	                return false;
	            }
	            
	            // 구축방식
	            if ($('input:checkbox[name=metaCnstcMthds]').is(':checked')==false)
            	{
            	    alert("구축방식을 선택하세요.");
	                $("input[name=metaCnstcMthds]").focus();
	                return false;
            	}
	            
	            // 서비스 유형
	            if ($('input:radio[name=serviceOfferMethod]').is(':checked')==false)
            	{
            	    alert("서비스 유형을 선택하세요.");
	                $("input[name=serviceOfferMethod]").focus();
	                return false;
            	}
	                
                // 아키텍쳐
	            if ($('input:checkbox[name=archtcSe1]').is(':checked')==false)
            	{
            	    alert("아키텍쳐을 선택하세요.");
	                $("input[name=archtcSe1]").focus();
	                return false;
            	}
                
	         	// 지원OS
	            if ($("#metaOSs").val() == null || $("#metaOSs").val() == "")
	            {
	                alert("지원OS를 입력해주세요.");
	                $("#metaOSsBtn").focus();
	                return false;
	            }
	         	
	         	// 지원언어
	            if ($('input:checkbox[name=metaLangs]').is(':checked')==false)
            	{
            	    alert("지원언어을 선택하세요.");
	                $("input[name=metaLangs]").focus();
	                return false;
            	}
	         	
	            // A/S방침
	            if ($("#metaASs").val() == null || $("#metaASs").val() == "")
	            {
	                alert("A/S방침를 입력해주세요.");
	                $("#metaASsBtn").focus();
	                return false;
	            }
	            
	            
	            // 제조사
	            if ($("#goodsMakr").val() == null || $("#goodsMakr").val() == "")
	            {
	                alert("제조사를 입력해주세요.");
	                $("#goodsMakr").focus();
	                return false;
	            }
	            
	            // 출시일
	            if ($("#comouDe").val() == null || $("#comouDe").val() == "")
	            {
	                alert("출시일을 입력해주세요.");
	                $("#comouDe").focus();
	                return false;
	            }
	            
	            </c:if>

            </c:if>

            <c:if test="${onoff3 eq 'on'}" > 
        		if( ${goodsInfo.goodsKndCd} == 1004 ){

        			
        			//if($('input:checkbox[name=cInfrstrctr]:checked').val() == "") { 
    	                //alert("컨설팅 가능 인프라를 입력해주세요.");
    	                //$("#cInfrstrctr").focus();
    	                //return false;
//        				
        			//}
        			
        			
        			
/*         			
                     $('[name="cInfrstrctr"]').click(function () {
                        
                        $('input:checkbox[name=cInfrstrctr]:checked').each(function () { 
                        	alert($(this).val());

                        });
                    });
                    return;
 $('input:checkbox[name=cInfrstrctr]:checked').val();
        			
        			
        			//$("input[id=cInfrstrctr]").val()
        			
        			alert($('input:checkbox[name=cInfrstrctr]:checked').val());
        			alert($("#cInfrstrctr").val());
        			alert($("input[id=cInfrstrctr]").val());        			
        			return;
        			
        			return true;
        			
        			if($('input:checkbox[name=cInfrstrctr]:checked').val() == 1007){

        				
        				
        				
        			} */
        			
        			
        		} else {
        			//if( ${goodsInfo.goodsKndCd} == 1001 || ${goodsInfo.goodsKndCd} == 1002 || ${goodsInfo.goodsKndCd} == 1003){
					//공통	
					//서비스 시작 절차
					if ($("#svcBeginProcss").val() == null || $("#svcBeginProcss").val() == ""){
						alert("서비스 시작 절차를 입력해주세요.");
						$("#svcBeginProcss").focus();
						return false;
					}

					//서비스 종료 절차
					if ($("#svcEndProcss").val() == null || $("#svcEndProcss").val() == ""){
						alert("서비스 종료 절차를 입력해주세요.");
						$("#svcEndProcss").focus();
						return false;
					}
					
					//서비스 평가판 제공여부 및 제공기간
					if($('input:radio[name="atSvcEvl"]:checked').val() == 'Y'){
						if ($("#svcEvlSuplyPd").val() == null || $("#svcEvlSuplyPd").val() == ""){
							alert("서비스 평가판 제공여부 및 제공기간을 입력해주세요.");
							$("#svcEvlSuplyPd").focus();
							return false;
						}
					}

					//서비스 가용성
					if ($("#svcUseful").val() == null || $("#svcUseful").val() == ""){
						alert("서비스 가용성을 입력해주세요.");
						$("#svcUseful").focus();
						return false;
					}
					
					//서비스 프로비저닝 시간
					if ($("#svcProvisioningTime").val() == null || $("#svcProvisioningTime").val() == ""){
						alert("서비스 프로비저닝 시간을 입력해주세요.");
						$("#svcProvisioningTime").focus();
						return false;
					}
					
					//서비스 프로비저닝 해제 시간
					if ($("#svcProvisioningRelisTime").val() == null || $("#svcProvisioningRelisTime").val() == ""){
						alert("서비스 프로비저닝 해제 시간을 입력해주세요.");
						$("#svcProvisioningRelisTime").focus();
						return false;
					}
					
					//장애관리 및 보고 정책
					if ($("#troblManageReprtPolicy").val() == null || $("#troblManageReprtPolicy").val() == ""){
						alert("장애관리 및 보고 정책을 입력해주세요.");
						$("#troblManageReprtPolicy").focus();
						return false;
					}
					
					//API 지원 여부 및 타입
					if($('input:radio[name="apiSportAt"]:checked').val() == 'Y'){
						if ($("#apiSportTy").val() == null || $("#apiSportTy").val() == ""){
							alert("API 지원 여부 및 타입을 입력해주세요.");
							$("#apiSportTy").focus();
							return false;
						}
					}
					
					//사용자 매뉴얼 정보 유무 및 설명
/* 					if($('input:radio[name="userMnlInfoAt"]:checked').val() == 'Y'){
						if ($("#userMnlInfoInput").val() == null || $("#userMnlInfoInput").val() == ""){
							alert("사용자 매뉴얼 정보 유무 및 설명을 입력해주세요.");
							$("#userMnlInfoInput").focus();
							return false;
						}
					}
 */
					//사용자 교육 지원 여부 및 정보
					if($('input:radio[name="userEdcSportAt"]:checked').val() == 'Y'){
						if ($("#userEdcSportInput").val() == null || $("#userEdcSportInput").val() == ""){
							alert("사용자 교육 지원 여부 및 정보를 입력해주세요.");
							$("#userEdcSportInput").focus();
							return false;
						}
					}

					//고객센터 운영 여부  및 운영 시간
					if($('input:radio[name="cstmrCnterOperAt"]:checked').val() == 'Y'){
						if ($("#cstmrCnterOperTime").val() == null || $("#cstmrCnterOperTime").val() == ""){
							alert("고객센터 운영 여부  및 운영 시간을 입력해주세요.");
							$("#cstmrCnterOperTime").focus();
							return false;
						}
					}

	        		if( ${goodsInfo.goodsKndCd} == 1002 ){ //saas시작
						//SAAS
						//사용자용 서비스 제공 방식
						if ($("#sUserSvcSuplyMthd").val() == null || $("#sUserSvcSuplyMthd").val() == ""){
							alert("사용자용 서비스 제공 방식을 입력해주세요.");
							$("#sUserSvcSuplyMthd").focus();
							return false;
						}
						
						//관리용 서비스 제공 방식
						if ($("#sManageSvcSuplyMthd").val() == null || $("#sManageSvcSuplyMthd").val() == ""){
							alert("관리용 서비스 제공 방식을 입력해주세요.");
							$("#sManageSvcSuplyMthd").focus();
							return false;
						}
						
						//서비스 보안 관리
						if ($("#sInfrstrctrSuplyMthd").val() == null || $("#sInfrstrctrSuplyMthd").val() == ""){
							alert("서비스 보안 관리를 입력해주세요.");
							$("#sInfrstrctrSuplyMthd").focus();
							return false;
						}
						
						//보안 정책
						if ($("#sScrtyPolicy").val() == null || $("#sScrtyPolicy").val() == ""){
							alert("보안 정책을 입력해주세요.");
							$("#sScrtyPolicy").focus();
							return false;
						}
						
						//데이터 암호화 여부 및 방식
						if ($("#sDataEncptAtMthd").val() == null || $("#sDataEncptAtMthd").val() == ""){
							alert("데이터 암호화 여부 및 방식을 입력해주세요.");
							$("#sDataEncptAtMthd").focus();
							return false;
						}
						
						//백업 및 복구 정책
						if ($("#sBackupRecovryPolicy").val() == null || $("#sBackupRecovryPolicy").val() == ""){
							alert("백업 및 복구 정책을 입력해주세요.");
							$("#sBackupRecovryPolicy").focus();
							return false;
						}
						
						//사용자 인증 및 보안 보호 정책
						if ($("#sUserCrtfcScrtyPrtcPolicy").val() == null || $("#sUserCrtfcScrtyPrtcPolicy").val() == ""){
							alert("사용자 인증 및 보안 보호 정책을 입력해주세요.");
							$("#sUserCrtfcScrtyPrtcPolicy").focus();
							return false;
						}
						
						//지원 운영체계 목록
						if ($("#sSportOpersysmList").val() == null || $("#sSportOpersysmList").val() == ""){
							alert("지원 운영체계 목록을 입력해주세요.");
							$("#sSportOpersysmList").focus();
							return false;
						}
						
						//지원 웹브라우저 목록
						if ($("#sSportWbsrList").val() == null || $("#sSportWbsrList").val() == ""){
							alert("지원 웹브라우저 목록을 입력해주세요.");
							$("#sSportWbsrList").focus();
							return false;
						}
						
						//지원 모바일 플랫폼 목록
						if ($("#sSportMobilePltfomList").val() == null || $("#sSportMobilePltfomList").val() == ""){
							alert("지원 모바일 플랫폼 목록을 입력해주세요.");
							$("#sSportMobilePltfomList").focus();
							return false;
						}
						
						//개발지원 조건 및 기타 사항
						if ($("#sDevlopSportEtc").val() == null || $("#sDevlopSportEtc").val() == ""){
							alert("개발지원 조건 및 기타 사항을 입력해주세요.");
							$("#sDevlopSportEtc").focus();
							return false;
						}
	        		} else if( ${goodsInfo.goodsKndCd} == 1001 ){ //paas시작
						//Secure 개발
						if ($("#pSecureDevlop").val() == null || $("#pSecureDevlop").val() == ""){
							alert("Secure 개발을 입력해주세요.");
							$("#pSecureDevlop").focus();
							return false;
						}
						//ecure design, coding, testing 및 배포
						if ($("#pSecureDctWdtb").val() == null || $("#pSecureDctWdtb").val() == ""){
							alert("ecure design, coding, testing 및 배포를 입력해주세요.");
							$("#pSecureDctWdtb").focus();
							return false;
						}
						//지원 언어
						if ($("#pSportLang").val() == null || $("#pSportLang").val() == ""){
							alert("지원 언어를 입력해주세요.");
							$("#pSportLang").focus();
							return false;
						}
						//지원 플랫폼
						if ($("#pSportPltfom").val() == null || $("#pSportPltfom").val() == ""){
							alert("지원 플랫폼을 입력해주세요.");
							$("#pSportPltfom").focus();
							return false;
						}
						//지원 Container 및 버전
						if ($("#pSportContainerVer").val() == null || $("#pSportContainerVer").val() == ""){
							alert("지원 Container 및 버전을 입력해주세요.");
							$("#pSportContainerVer").focus();
							return false;
						}
						//지원 데이터 저장소
						if ($("#pSportDataStorge").val() == null || $("#pSportDataStorge").val() == ""){
							alert("지원 데이터 저장소를 입력해주세요.");
							$("#pSportDataStorge").focus();
							return false;
						}
						//개발자 도구 정보
						if ($("#pDvlprUntInfo").val() == null || $("#pDvlprUntInfo").val() == ""){
							alert("개발자 도구 정보를 입력해주세요.");
							$("#pDvlprUntInfo").focus();
							return false;
						}
						//CI(Continuous Integration) 지원
						if ($("#pCisportSport").val() == null || $("#pCisportSport").val() == ""){
							alert("Continuous Integration 지원을 입력해주세요.");
							$("#pCisportSport").focus();
							return false;
						}
						//로깅/모니터링 지원
						if ($("#pLogingMntrngSport").val() == null || $("#pLogingMntrngSport").val() == ""){
							alert("로깅/모니터링 지원을 입력해주세요.");
							$("#pLogingMntrngSport").focus();
							return false;
						}
						//로깅/모니터링 지원
						if ($("#pLoadBalancingSport").val() == null || $("#pLoadBalancingSport").val() == ""){
							alert("Load Balancing 지원을 입력해주세요.");
							$("#pLoadBalancingSport").focus();
							return false;
						}
	        			
	        		} else if( ${goodsInfo.goodsKndCd} == 1003 ){ //iaas시작
						//공개표준 지원 및 문서
						if ($("#iOthbcStdSportDoc").val() == null || $("#iOthbcStdSportDoc").val() == ""){
							alert("공개표준 지원 및 문서를 입력해주세요.");
							$("#iOthbcStdSportDoc").focus();
							return false;
						}
						//서비스에 직접 연결하는 네트워크
						if ($("#iSvcDirectCnncNtwrk").val() == null || $("#iSvcDirectCnncNtwrk").val() == ""){
							alert("서비스에 직접 연결하는 네트워크를 입력해주세요.");
							$("#iSvcDirectCnncNtwrk").focus();
							return false;
						}
						//가상 네트워크 지원
						if ($("#iVirtlNtwrkSport").val() == null || $("#iVirtlNtwrkSport").val() == ""){
							alert("가상 네트워크 지원을 입력해주세요.");
							$("#iVirtlNtwrkSport").focus();
							return false;
						}
						//지원 장비 목록
						if ($("#iSportEqpmnList").val() == null || $("#iSportEqpmnList").val() == ""){
							alert("지원 장비 목록을 입력해주세요.");
							$("#iSportEqpmnList").focus();
							return false;
						}
						//서버/컴퓨터 서비스
						if ($("#iServerComputerSvc").val() == null || $("#iServerComputerSvc").val() == ""){
							alert("서버/컴퓨터 서비스를 입력해주세요.");
							$("#iServerComputerSvc").focus();
							return false;
						}
						//스토리지 서비스
						if ($("#iStrgeSvc").val() == null || $("#iStrgeSvc").val() == ""){
							alert("스토리지 서비스를 입력해주세요.");
							$("#iStrgeSvc").focus();
							return false;
						}
						//네트워크 서비스
						if ($("#iNtwrkSvc").val() == null || $("#iNtwrkSvc").val() == ""){
							alert("네트워크 서비스를 입력해주세요.");
							$("#iNtwrkSvc").focus();
							return false;
						}
						//보안 서비스
						if ($("#iScrtySvc").val() == null || $("#iScrtySvc").val() == ""){
							alert("보안 서비스를 입력해주세요.");
							$("#iScrtySvc").focus();
							return false;
						}
						//관리 서비스
						if ($("#iManageSvc").val() == null || $("#iManageSvc").val() == ""){
							alert("관리 서비스를 입력해주세요.");
							$("#iManageSvc").focus();
							return false;
						}
						//기타 서비스
						if ($("#iEtcSvc").val() == null || $("#iEtcSvc").val() == ""){
							alert("기타 서비스를 입력해주세요.");
							$("#iEtcSvc").focus();
							return false;
						}
	        		} else if( ${goodsInfo.goodsKndCd} == 1004 ){ //SCS시작
						
	        		}
	        	}

            </c:if>
            
            <c:if test="${onoff4 eq 'on'}" >
	         	// 회사 설립년도
	            if ($("#cmpnyFondYear").val() == null || $("#cmpnyFondYear").val() == "")
	            {
	                alert("회사 설립년도를 입력해주세요.");
	                $("#cmpnyFondYear").focus();
	                return false;
	            }
	         	
	         	// 회사 소개
	         	if ($("#cmpnyIntrcn").val() == null || $("#cmpnyIntrcn").val() == "")
	            {
	                alert("회사 소개를 입력해주세요.");
	                $("#cmpnyIntrcn").focus();
	                return false;
	            }	            
	            
	            // 사업 분야
	            if ($("#bsnsRealm").val() == null || $("#bsnsRealm").val() == "")
	            {
	                alert("사업 분야를 입력해주세요.");
	                $("#bsnsRealm").focus();
	                return false;
	            }
	            
	            // 공급 유형
	            if ($('input:radio[name=svcEntrprsSuplyTy]').is(':checked')==false)
            	{
            	    alert("공급 유형을 선택하세요.");
	                $("input[name=svcEntrprsSuplyTy]").focus();
	                return false;
            	}	            
	            
	            // 기업구분
	            if ($('input:radio[name=entrprsSe]').is(':checked')==false)
            	{
            	    alert("기업구분을 선택하세요.");
	                $("input[name=entrprsSe]").focus();
	                return false;
            	}
	            
	            // 서비스 담당자
	            if ($("#svcChargerNm").val() == null || $("#svcChargerNm").val() == "")
	            {
	                alert("서비스 담당자를 입력해주세요.");
	                $("#svcChargerNm").focus();
	                return false;
	            }
	            // 서비스 담당자 이메일
	            if (($("#svcChargerEmail1").val() == null || $("#svcChargerEmail1").val() == "")
	               || ($("#svcChargerEmail2").val() == null || $("#svcChargerEmail2").val() == ""))  
	            {
	                alert("서비스 담당자 이메일를 입력해주세요.");
	                $("#svcChargerEmail1").focus();
	                return false;
	            }
	            // 서비스 담당자 연락처 (국가)	            
	            //var chkVar = $("#svcChargerCttpc option:selected").val();	        	
	            //if (chkVar == null || chkVar == "")
	            //{
	                //alert("서비스 담당자 연락처 (국가)를 입력해주세요.");
	                //$("#svcChargerCttpc").focus();
	                //return false;
	            //}
	            // 서비스 담당자 연락처 번호
	            if (($("#svcChargerCttpc1").val() == null || $("#svcChargerCttpc1").val() == "")
	                || ($("#svcChargerCttpc2").val() == null || $("#svcChargerCttpc2").val() == "")  
	                || ($("#svcChargerCttpc3").val() == null || $("#svcChargerCttpc3").val() == ""))  
	     	    {
 	                alert("서비스 담당자 연락처 번호를 입력해주세요.");
 	                $("#svcChargerCttpc1").focus();
 	                return false;
 	            }
	            // 서비스 담당자 휴대폰 번호
	            if (($("#svcChargerMbtlNum1").val() == null || $("#svcChargerMbtlNum1").val() == "")
	                || ($("#svcChargerMbtlNum2").val() == null || $("#svcChargerMbtlNum2").val() == "")  
	                || ($("#svcChargerMbtlNum3").val() == null || $("#svcChargerMbtlNum3").val() == ""))  
	     	    {
 	                alert("서비스 담당자 휴대폰 번호를 입력해주세요.");
 	                $("#svcChargerMbtlNum1").focus();
 	                return false;
 	            }
	            
	            // 가격표(업로드)
	            if (   ($("#priceFile1").val() == null || $("#priceFile1").val() == "")
	                && ($("#priceDnFileSeq").val() == -1))  
	     	    {
 	                alert("가격표를 등록해주세요.");
 	                $("#svcChargerCttpc1").focus();
 	                return false;
 	            }

	            if ( ($("#priceFile1").val() != null || $("#priceFile1").val() != "") ) {
					//alert("11111112222222");
	            	var thumbext = $("#pricefileInput1").val(); //파일을 추가한 input 박스의 값

	            	thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

	            	if(thumbext != "pdf"){ //확장자를 확인합니다.

	            		alert('가격표(업로드)는 pdf.파일만 등록 가능합니다.');
	            		
	            		location.reload();
	            	
		            	return false;

	            	}
				}
            
            </c:if>
            <c:if test="${onoff5 eq 'on'}" > return true; </c:if>
            
            
            return true;
            
            /************
    	
            var eachSection = 'N';
    
            //인증정보
            if(eachSection == 'N'){
                //체크 되어 있는 값 추출 (체크박스만 선택하고 파일을 안넣었을경우)_인증정보
                var count = 0;
                $("input[name=goodsMarkCds]").each(function(i){
                    if ($('input[name="goodsMarkCds"]').eq(i).is(":checked")){
                        if($('input[name="goodsMarkCds"]').eq(i).val() != "1005"){//나라장터인증이 아닌경우
                            if($("#markCrtfcFile" + i).val() == null || $("#markCrtfcFile" + i).val() == ""){
                                alert("선택하신 인증정보의 파일을 선택해주세요.");
                                $("#markCrtfcFile" + i).focus();
                                eachSection ='Y';
                                return false;
                            }
                        } else {//나라장터인증이면
                            if($("#cntrctNo").val() == null || $("#cntrctNo").val()  == ""){
                                alert("나라장터 계약번호를 입력해주세요.");
                                $("#cntrctNo").focus();
                                eachSection ='Y';
                                return false;
                            }
                        }
                    }else{//체크박스 선택하지않고 파일만 넣었을경우_인증정보
                        if($('input[name="goodsMarkCds"]').eq(i).val() != "1005"){//나라장터인증이 아닌경우
                            if($("#markCrtfcFile" + i).val() != null && $("#markCrtfcFile" + i).val() != ""){
                                alert("인증정보 체크박스 선택을 해주세요.");
                                $('input[name="goodsMarkCds"]').eq(i).focus();
                                eachSection ='Y';
                                return false;
                            }
                        } else {//나라장터인증이면
                            if($("#cntrctNo").val() != null && $("#cntrctNo").val()  != ""){
                                $("#cntrctNo").val('');
                            }
                        }
                    }
                });
            }
    
            if(eachSection == 'N'){
             //제조사
                if ($("#goodsMakr").length > 0) {
                    if ($("#goodsMakr").val() == null || $.trim($("#goodsMakr").val()) == "") {
                        alert("제조사 항목을 입력하여 주세요.");
                        document.getElementById("goodsMakr").focus();
                        return false;
                    }
                }
    
                //출시일
                if ($("#comouDe").length > 0) {
                    if ($("#comouDe").val() == null || $.trim($("#comouDe").val()) == "") {
                        alert("출시일 항목을 입력하여 주세요.");
                        document.getElementById("comouDe").focus();
                        return false;
                    }
                }
                
               //기업구분
               if ($("input[name=smlpzChk]").length > 0) {
                   if ($("input[name=smlpzChk]:checked").length <= 0) {
                       alert("기업구분을 입력하여 주세요.");
                       $("input[name=smlpzChk]").eq(0).focus();
                       return false;
                   }
               }
    
               //단가
                if ($("#goodsPc").length > 0) {
                    if ($("#goodsPc").val() == null || $.trim($("#goodsPc").val()) == "") {
                        alert("단가 항목을 입력하여 주세요.");
                        document.getElementById("goodsPc").focus();
                        return false;
                    }
                }            
                
                //계약단위
                if ($("#metaCntrctUnits").length > 0) {
                    if ($("#metaCntrctUnits").val() == null || $.trim($("#metaCntrctUnits").val()) == "") {
                        alert("계약단위 항목을 입력하여 주세요.");
                        document.getElementById("metaCntrctUnitBtn").focus();
                        return false;
                    }
                }
                
                //서비스 유형
                if ($("input[name=serviceOfferMethod]").length > 0) {
                    if ($("input[name=serviceOfferMethod]:checked").length <= 0) {
                        alert("서비스 유형 항목을 입력하여 주세요.");
                        $("input[name=serviceOfferMethod]").eq(0).focus();
                        return false;
                    }
                }
                
               //서비스 관리
               if ($("#metaSvcs").length > 0) {
                   if ($("#metaSvcs").val() == null || $.trim($("#metaSvcs").val()) == "") {
                       alert("서비스 관리을 입력하여 주세요.");
                       document.getElementById("metaSvcBtn").focus();
                       return false;
                   }
               }
               
               //구축방식
               if ($("#metaCnstcMthds").length > 0) {
                   if ($("#metaCnstcMthds").val() == null || $.trim($("#metaCnstcMthds").val()) == "") {
                       alert("구축방식을 입력하여 주세요.");
                       document.getElementById("metaCnstcMthdBtn").focus();
                       return false;
                   }
               }
               
                //지원언어
                if ($("input[name=metaLangs]").length > 0) {
                    if ($("input[name=metaLangs]:checked").length <= 0) {
                        alert("지원언어 항목을 입력하여 주세요.");
                        $("input[name=metaLangs]").eq(0).focus();
                        return false;
                    }
                }
                //지원언어 - 기타 수기체크 
                var mlChk = $("input[name=metaLangs]:checked");
                for(var i=0; i<mlChk.length; i++){
                    if(mlChk[i].value == 1006){
                       if ($("#metaLangEtc").val() == null || $("#metaLangEtc").val().trim() == "") {
                             alert("기타인 경우 지원언어를 입력하여 주세요.");
                             document.getElementById("metaLangEtc").focus();
                             return false;
                          }
                    }
                }
                
                //원산지
                if ($("#orgplce").length > 0) {
                    if ($("#orgplce").val()==null || $.trim($("#orgplce").val()) == "") {
                        alert("원산지 항목을 입력하여 주세요.");
                        document.getElementById("orgplce").focus();
                        return false;
                    }
                }
                
                //A/S방침
                if ($("#metaASs").val()==null || $.trim($("#metaASs").val()) == "") {
                    alert("A/S 항목을 입력하여 주세요.");
                    document.getElementById("metaASsBtn").focus();
                    return false;
                }
                
                //지원OS
                if ($("#metaOSs").length > 0) {
                    if ($("#metaOSs").val()==null || $.trim($("#metaOSs").val()) == "") {
                        alert("지원OS 항목을 입력하여 주세요.");
                        document.getElementById("metaOSsBtn").focus();
                        return false;
                    }
                }
                
                  //아키텍쳐 값셋팅
                var selectedItem = new Array();
                $('input[name="archtcSe1"]:checkbox:checked').each(function (i){
                    selectedItem[i] = $(this).val();
                });
                if((selectedItem[0] == null || selectedItem[0] == "") && (selectedItem[1] == null || selectedItem[2] == "")){
                    alert("아키텍쳐는 필수선택 값입니다.");
                    $("#archtcSe1").focus();
                    return false;
                };
                if(selectedItem[0] == null || selectedItem[0] == ""){ selectedItem[0] = 0;};
                if(selectedItem[1] == null || selectedItem[2] == ""){ selectedItem[1] = 0;};
    
                var archtcSe = Number(selectedItem[0]) + Number(selectedItem[1]);
                
                //담당자
                if ($("#goodsChargerNm").length > 0) {
                    if ($("#goodsChargerNm").val() == null || $.trim($("#goodsChargerNm").val()) == "") {
                        alert("담당자 항목을 입력하여 주세요.");
                        document.getElementById("goodsChargerNm").focus();
                        return false;
                    }
                }
                
                //담당자 이메일 셋팅
                if($.trim($("#goodsChargerEmail1").val()) == null || $.trim($("#goodsChargerEmail1").val()) == ""){
                    alert('이메일을 입력해주세요.');
                    $("#goodsChargerEmail1").focus();
                    return false;
                }
    
                var email = $.trim($('#goodsChargerEmail1').val())+"@"+$.trim($('#goodsChargerEmail2').val());
                if(!fnb_isEmailOK(email)){
                    alert("정확한 이메일을 입력해주세요.");
                    $("#goodsChargerEmail2").focus();
                    return false;
                }
    
                var langCode = $("#langCode").val();
    
                //담당자 연락처 셋팅
                if($("#goodsChargerCttpc0 option:selected").val() == ""){
                    alert('국가를 선택해주세요.');
                    $("#goodsChargerCttpc0").focus();
                    return false;
                }
                if(!fnb_isNumeric($.trim($("#goodsChargerCttpc1").val()))){
                    alert('정확한 연락처를 입력해주세요.');
                    $("#goodsChargerCttpc1").focus();
                    return false;
                }
                if(!fnb_isNumeric($.trim($("#goodsChargerCttpc2").val()))){
                    alert('정확한 연락처를 입력해주세요.');
                    $("#goodsChargerCttpc2").focus();
                    return false;
                }
                if(!fnb_isNumeric($.trim($("#goodsChargerCttpc3").val()))){
                    alert('정확한 연락처를 입력해주세요.');
                    $("#goodsChargerCttpc3").focus();
                    return false;
                }
    
                var Cttpc = $("#goodsChargerCttpc0 option:selected").val()+"-"+$.trim($('#goodsChargerCttpc1').val())+"-"+$.trim($('#goodsChargerCttpc2').val())+"-"+$.trim($('#goodsChargerCttpc3').val());
    
                var Mbtlnum = $.trim($('#goodsChargerMbtlnum1').val())+"-"+$.trim($('#goodsChargerMbtlnum2').val())+"-"+$.trim($('#goodsChargerMbtlnum3').val());
    
                //값 담아주기
                $("#archtcSe").val(archtcSe);
                $("#goodsChargerEmail").val(email);
                $("#goodsChargerCttpc").val(Cttpc);
                $("#goodsChargerMbtlnum").val(Mbtlnum);
    
                 //서비스개요
                if ($("#goodsSumry").val()==null || $.trim($("#goodsSumry").val()) == "") {
                    alert("서비스개요 항목을 입력하여 주세요.");
                    document.getElementById("goodsSumry").focus();
                    return false;
                }
                
                //태그
                var metaTagCnt = 0;
                var goodsTagCnt = 0;
    
                if($("#goodsTags").val() == "태그 직접 입력. 콤마로 구분해 주세요"){
                    $("#goodsTags").val("");
                }
                var metaTAGs = $("#metaTAGs").val().split(",");
                var goodsTagsTmp = $("#goodsTags").val().split(",");
                var metaTAGsNm = $("#metaTAGhtml").text().replace(/ X/gi, ",");
                     metaTAGsNm = metaTAGsNm.substr(0, metaTAGsNm.length -1);
                     metaTAGsNm = metaTAGsNm.split(",");
    
                if($("#metaTAGs").val() == null || $("#metaTAGs").val() == ""){
                    metaTagCnt=0;
                }else{
                    metaTagCnt=metaTAGs.length;
                }
                goodsTagCnt = goodsTagsTmp.length;
    
                var j = 0;
                var goodsTags = Array();
                for(var i = 0; i < goodsTagCnt; i++){
                    if(goodsTagsTmp[i] != null && $.trim(goodsTagsTmp[i]) != ""){
                        goodsTags[j] = goodsTagsTmp[i];
                        j++;
                    }
                }
                goodsTagCnt = goodsTags.length;
                
                if((metaTagCnt + goodsTagCnt) > 0){
                    //태그중복체크 (수기입력시)
                    for(var i =0; i < goodsTagCnt; i++){ 
                        for(var j=0; j< goodsTagCnt; j++){
                            var tagI = goodsTags[i];
                            var tagJ = goodsTags[j]
                            if(tagI.trim() == tagJ.trim() && i != j){
                                ret = false;
                                alert("수기로 입력된 태그중 중복된 태그가 있습니다.");
                                $("#goodsTags").focus();
                                return false;
                            }
                        }
                    }
        
                    //태그중복체크 (선택 + 수기입력)
                    for(var i =0; i < metaTAGsNm.length; i++){
                        for(var j=0; j< goodsTagsTmp.length; j++){
                            var metaVal = metaTAGsNm[i];
                            var goodsVal = goodsTagsTmp[j];
                            if(metaVal.trim() == goodsVal.trim()){
                                ret = false;
                                alert("선택한 태그와 입력한 태그중 중복된 태그 내용이 포함되어 있습니다.");
                                $("#goodsTags").focus();
                                return false;
                            }
                        }
                    }
        
                    if((metaTagCnt + goodsTagCnt) > 10){
                        alert("태그 항목은 최대 10개까지 입력 가능합니다.");
                        document.getElementById("metaTAGsBtn").focus();
                        return false;
                    }
                }
    
                if(eachSection == 'N'){
                    if($.trim(CKEDITOR.instances.itemSfe.getData()).replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").replace(/\s/g,'') == ''){
                        alert("특장점을 입력해주세요.");
                        CKEDITOR.instances.itemSfe.focus();
                        return false;
                    }else if($.trim(CKEDITOR.instances.goodsRefer.getData()).replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").replace(/\s/g,'') == ''){
                        alert("대상고객을 입력해주세요.");
                        CKEDITOR.instances.goodsRefer.focus();
                        return false;
                    }else if($.trim(CKEDITOR.instances.goodsMainFnct.getData()).replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").replace(/\s/g,'') == ''){
                         alert("주요기능을 입력해주세요.");
                         CKEDITOR.instances.goodsMainFnct.focus();
                         return false;
                     }
                }
                
                //가격표
                if($("input[name=priceFile1]").val() == null || $("input[name=priceFile1]").val() == ""  ){
                    alert("가격표를 등록해주세요.");
                    document.getElementById("priceFile1").focus();
                    return false;
                }
    
                //파일설명이있으나 파일이없는경우
                if(eachSection == 'N'){
                    $("input[name=fileDesc][id ^= mnlfile]").each(function(i){
                        var seq = i + 1;
    
                        if($("#mnlfile"+seq+"Desc").val() != null && $("#mnlfile"+seq+"Desc").val() != ""){
                            // 파일설명서가있는경우
                            if($('input[id="mnfileInput'+seq+'"]').val() == null || $('input[id="mnfileInput'+seq+'"]').val() == ""){
                                alert("설명서 파일을 등록해주세요.");
                                eachSection = 'Y';
                                return false;
                            }
                        }else{
                            //파일설명서가 없는경우
                            if($("#mnfileInput"+seq).val() != null && $("#mnfileInput"+seq).val() != ""){
                                alert("설명서의 파일설명을 등록해주세요.");
                                $("#mnlfile"+seq+"Desc").focus();
                                eachSection ='Y';
                                return false;
                            }
                        }
                    });
                }
                
                if(eachSection == 'N'){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
            **********************/
            
            alert("123445");
            return;
            
        };
    
        var checkEditor2 = function(){
            //서비스명
            if($("#goodsNm").val() == null || $("#goodsNm").val() == ""){
                alert("서비스명을 입력해주세요.");
                $("#goodsNm").focus();
                return false;
            }
    
            //카테고리
            if($("#setCtgryCodes").val() == null || $("#setCtgryCodes").val() == ""){
                alert("카테고리를 선택해주세요.");
                $("#jsCtgrySelPop").focus();
                return false;
            }
    
              //대표이미지
            if($("input[name=imageFile1]").val() == null || $("input[name=imageFile1]").val() == ""  ){
                alert("대표이미지를 등록해주세요.");
                $("#imgPrev1Btn").focus();
                return false;
            }
            
            var eachSection = 'N';
    
            //인증정보
            if(eachSection == 'N'){
                // 체크 되어 있는 값 추출 (체크박스만 선택하고 파일을 안넣었을경우)_인증정보
                var count = 0;
                $("input[name=goodsMarkCds]").each(function(i){
                    if ($('input[name="goodsMarkCds"]').eq(i).is(":checked")){
                        if($('input[name="goodsMarkCds"]').eq(i).val() != "1005"){//나라장터인증이 아닌경우
                            if($("#markCrtfcFile" + i).val() == null || $("#markCrtfcFile" + i).val() == ""){
                                alert("선택하신 인증정보의 파일을 선택해주세요.");
                                $("#markCrtfcFile" + i).focus();
                                eachSection ='Y';
                                return false;
                            }
                        } else {//나라장터인증이면
                            if($("#cntrctNo").val() == null || $("#cntrctNo").val()  == ""){
                                alert("나라장터 계약번호를 입력해주세요.");
                                $("#cntrctNo").focus();
                                eachSection ='Y';
                                return false;
                            }
                        }
                    }else{//체크박스 선택하지않고 파일만 넣었을경우_인증정보
                        if($('input[name="goodsMarkCds"]').eq(i).val() != "1005"){//나라장터인증이 아닌경우
                            if($("#markCrtfcFile" + i).val() != null && $("#markCrtfcFile" + i).val() != ""){
                                alert("인증정보 체크박스 선택을 해주세요.");
                                $('input[name="goodsMarkCds"]').eq(i).focus();
                                eachSection ='Y';
                                return false;
                            }
                        } else {//나라장터인증이면
                            if($("#cntrctNo").val() != null && $("#cntrctNo").val()  != ""){
                                $("#cntrctNo").val('');
                            }
                        }
                    }
                });
            }
    
            if(eachSection == 'N'){
                //아키텍쳐 값셋팅
                var selectedItem = new Array();
                $('input[name="archtcSe1"]:checkbox:checked').each(function (i){
                    selectedItem[i] = $(this).val();
                });
    
                if((selectedItem[0] != null || selectedItem[0] != "") || (selectedItem[1] != null || selectedItem[2] != "")){
                    if(selectedItem[0] == null || selectedItem[0] == ""){ selectedItem[0] = 0; };
                    if(selectedItem[1] == null || selectedItem[2] == ""){ selectedItem[1] = 0; };
    
                    var archtcSe = Number(selectedItem[0]) + Number(selectedItem[1]);
                    $("#archtcSe").val(archtcSe);
                }
                
                //담당자
                if ($("#goodsChargerNm").length > 0) {
                    if ($("#goodsChargerNm").val() == null || $.trim($("#goodsChargerNm").val()) == "") {
                        alert("담당자 항목을 입력하여 주세요.");
                        document.getElementById("goodsChargerNm").focus();
                        return false;
                    }
                }
    
                //담당자 이메일 셋팅
                if($.trim($("#goodsChargerEmail1").val()) != ""){
                    if($.trim($("#goodsChargerEmail1").val()) == null || $.trim($("#goodsChargerEmail1").val()) == ""){
                        alert('이메일을 입력해주세요.');
                        $("#goodsChargerEmail1").focus();
                        return false;
                    }
    
                    var email = $.trim($('#goodsChargerEmail1').val())+"@"+$.trim($('#goodsChargerEmail2').val());
                    if(!fnb_isEmailOK(email)){
                        alert("정확한 이메일을 입력해주세요.");
                        $("#goodsChargerEmail2").focus();
                        return false;
                    }
                    $("#goodsChargerEmail").val(email);
                }
    
                //담당자 연락처 셋팅
                
                if($("#goodsChargerCttpc0 option:selected").val() == ""){
                    alert('국가를 선택해주세요.');
                    $("#goodsChargerCttpc0").focus();
                    return false;
                }
                if(!fnb_isNumeric($.trim($("#goodsChargerCttpc1").val()))){
                    alert('정확한 연락처를 입력해주세요.');
                    $("#goodsChargerCttpc1").focus();
                    return false;
                }
                if(!fnb_isNumeric($.trim($("#goodsChargerCttpc2").val()))){
                    alert('정확한 연락처를 입력해주세요.');
                    $("#goodsChargerCttpc2").focus();
                    return false;
                }
                if(!fnb_isNumeric($.trim($("#goodsChargerCttpc3").val()))){
                    alert('정확한 연락처를 입력해주세요.');
                    $("#goodsChargerCttpc3").focus();
                    return false;
                }
    
                var Cttpc = $("#goodsChargerCttpc0 option:selected").val()+"-"+$.trim($('#goodsChargerCttpc1').val())+"-"+$.trim($('#goodsChargerCttpc2').val())+"-"+$.trim($('#goodsChargerCttpc3').val());
                $("#goodsChargerCttpc").val(Cttpc);
                
                //담당자 휴대전화번호 셋팅
                if($.trim($("#goodsChargerMbtlnum1").val()) != "" || $.trim($("#goodsChargerMbtlnum2").val()) != "" || $.trim($("#goodsChargerMbtlnum3").val()) != ""){
                    /* if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum1").val()))){
                        alert('정확한 휴대전화번호를 입력해주세요.');
                        $("#goodsChargerMbtlnum1").focus();
                        return false;
                    }
                    if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum2").val()))){
                        alert('정확한 휴대전화번호를 입력해주세요.');
                        $("#goodsChargerMbtlnum2").focus();
                        return false;
                    }
                    if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum3").val()))){
                        alert('정확한 휴대전화번호를 입력해주세요.');
                        $("#goodsChargerMbtlnum3").focus();
                        return false;
                    } */
    
                    var Mbtlnum = $.trim($('#goodsChargerMbtlnum1').val())+"-"+$.trim($('#goodsChargerMbtlnum2').val())+"-"+$.trim($('#goodsChargerMbtlnum3').val());
                    $("#goodsChargerMbtlnum").val(Mbtlnum);
                }
    
                //파일설명이있으나 파일이없는경우
                if(eachSection == 'N'){
                    $("input[name=fileDesc][id ^= mnlfile]").each(function(i){
                        var seq = i + 1;
    
                        if($("#mnlfile"+seq+"Desc").val() != null && $("#mnlfile"+seq+"Desc").val() != ""){
                            // 파일설명서가있는경우
                            if($('input[id="mnfileInput'+seq+'"]').val() == null || $('input[id="mnfileInput'+seq+'"]').val() == ""){
                                alert("설명서 파일을 등록해주세요.");
                                eachSection = 'Y';
                                return false;
                            }
                        }else{
                            //파일설명서가 없는경우
                            if($("#mnfileInput"+seq).val() != null && $("#mnfileInput"+seq).val() != ""){
                                alert("설명서의 파일설명을 등록해주세요.");
                                $("#mnlfile"+seq+"Desc").focus();
                                eachSection = 'Y';
                                return false;
                            }
                        }
                    });
                }
    
                if(eachSection == 'N'){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        };
        /* 
         * 숫자만 입력하도록 체크
         */
        function jsOnlyNumber(event){
            var keyID = (event.which) ? event.which : event.keyCode;
            if(( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8)
            {
                return;
            }
            else
            {
               return false;
            }
                        
        }
    
        /* 크롬- 숫자만 입력하도록 체크*/
        function removeChar(event) {
            event = event || window.event;
            var keyID = (event.which) ? event.which : event.keyCode;
            if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
                return;
            else
                event.target.value = event.target.value.replace(/[^0-9]/g, "");
        }
        
        //업로드 파일 미리보기
        var readURL = function(input,index){
            if($(input).val() != ""){
                if(window.FileReader){
                    /*IE 10 이상에서는 FileReader 이용*/
                    var reader = new FileReader();
                    reader.onload = function(e){
                        if(e.target.result.indexOf("image/gif") > 0 || e.target.result.indexOf("image/jpg") > 0 || e.target.result.indexOf("image/jpeg") > 0 || e.target.result.indexOf("image/png") > 0){
                            $("img#img"+index).remove();
                            var html ='';
                            html += "<img src=\""+e.target.result+"\" alt=\"업로드 이미지 미리보기\" id=\"img"+index+"\"/>";
                            $("#imgPrev"+index+" .thumbimg").html(html)/* .append(html) */;
                        }
                    };
                    reader.readAsDataURL(input.files[0]);
                }else{
                    $("img#img"+index).remove();
                    var html ='';
                    html += "<img src=\"" + "\"   alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" id=\"img"+index+"\"/>";
                    $("#imgPrev"+index+" .thumbimg").html(html)/* append(html) */;
                }
            }
        };
    
        //파일선택
        var jsFileCount = function(inputId, fileSeq, maxCnt, seq){
            return true;
    
            if(fileSeq == ""){
                fileSeq = -1;
            }
            var ret = false;
            var fCnt = 0;
            $("input[type=file][class~="+inputId.substring(0, inputId.length - 1)+"]").each(function(){
                if(this.value != null && this.value != ""){
                    fCnt++;
                }
            });
    
            $.ajax({
                url      : "ND_fileCountChk.do",
                data     : { fileSeq : fileSeq, fCnt : fCnt, maxCnt : maxCnt },
                type     : "POST",
                dataType : "text",
                async    : false,
                success  : function(response){
                    if(response != ""){
                        alert(response);
                        imgAppend(seq);
                        ret = false;
                    }else{
                        ret = true;
                    }
                }
            });
            return ret;
        };
    
        //파일갯수
        var jsFileChkCount = function(inputId, fileSeq, maxCnt){
            return true;
    
            if(fileSeq == ""){
                fileSeq = -1;
            }
            var ret = false;
            var fCnt = 0;
    
            $("input[type=file][class~="+inputId.substring(0, inputId.length - 1)+"]").each(function(){
                if(this.value != null && this.value != ""){
                    fCnt++;
                }
            });
    
            $.ajax({
                url      : "ND_fileCountChk.do",
                data     : { fileSeq : fileSeq, fCnt : fCnt, maxCnt : maxCnt },
                type     : "POST",
                dataType : "text",
                async    : false,
                success  : function(response){
                    if(response != ""){
                        alert(response);
                        var htmlVal = "";
                        $("input[name="+inputId+"]").val("");
                        htmlVal = $("#"+inputId+"Span").html();
                        $("input[name="+inputId+"]").remove();
                        $("#"+inputId+"Span").append(htmlVal);
                        ret = false;
                    }else{
                        ret = true;
                    }
                }
            });
            return ret;
        };

        //첨부된 파일중 ajax를 이용하여 파일 삭제
        var jsFileDelete = function(element, seq, id, markcd, goodsCode, updateYn){
            
        	//alert("element : " + element);
        	//alert("goodsCode : " + goodsCode);
        	//alert("id : " + id);        	
        	
        	if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
                return false;

            var url = "ND_fileDelete.do";
            $.post(url,
                { fileId : id, fileSeq : seq, markCd : markcd, goodsCode : goodsCode, updateYn : updateYn},
                function(result){
                    if(result == 1){
                        $(element).parent().remove();

//                         if(OpenWorks.maxFileCnt <= OpenWorks.fileCnt)
//                        if (goodsChangeCode > 0) {
//                             jsChngHistCodeInsert(goodsChangeCode);
//                        }
                        self.location.reload();

//                         if(eval($("#uploadFileCnt").val()) > 0)
//                             $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
//                         else $("#uploadFileCnt").val(0);

//                         $.fn.MultiFile.reEnableEmpty();

                    }else{
                        alert('파일을 삭제하지 못했습니다.');
                    }
                }, 'json');
        };        
    
        //파일종류
        var jsFileChk = function(inputId, inputIdFake, s, fileExt, fileSeq, maxCnt){
            
            document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();

            //alert("inputId1 : " + inputId); //priceFile1            
            
            if(inputId == 'priceFile1'){

            	var thumbext = $("#pricefileInput1").val(); //파일을 추가한 input 박스의 값

            	thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.

            	if(thumbext != "pdf"){ //확장자를 확인합니다.

            		alert('가격표(업로드)는 pdf.파일만 등록 가능합니다.');
            		
            		location.reload();
            	
            		return;

            	}
            }
            
            var inputFile = document.getElementById(inputId);
            var filePath = inputFile.value;
    
            if(filePath == ""){
                return false;
            }
    
            var fileCountResult = jsFileChkCount(inputId, fileSeq, maxCnt);
            //var fileCountResult = true;
    
            if(fileCountResult){
                var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
                var fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai,zip";
                var htmlVal = "";
    
                if(fileExtPermit.indexOf(fileExt) <= 0){
                    alert(fileExt + Message.msg.fileCannotUplaod);
                    jsInputFileReset(inputId, inputIdFake);
                    /* htmlVal = "";
                    $("input[name="+inputId+"]").val("");
                    htmlVal = $("#"+inputId+"Span").html();
                    $("input[name="+inputId+"]").remove();
                    $("#"+inputId+"Span").append(htmlVal); */
                    return false;
                }
    
                if(inputFile.files[0].size > (s * 1024) && s != 0){
                    alert(Message.msg.fileSizeOver);
                    jsInputFileReset(inputId, inputIdFake);
                    /* htmlVal = "";
                    $("input[name="+inputId+"]").val("");
                    htmlVal = $("#"+inputId+"Span").html();
                    $("input[name="+inputId+"]").remove();
                    $("#"+inputId+"Span").append(htmlVal); */
                    return false;
                }
    
                document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();            
            }
        };
    
        //서비스이미지 용량,크기,비율 확인(이미지아이디, 최대넓이, 최대높이, 최소넓이, 최소높이, 용량, 확장자, seq, imgType, fileSeq, 파일첨부갯수)
        var jsPreview = function(inputId, w, h, sw, sh, s, fileExt ,seq, imgType, fileSeq, maxCnt, fileThis){
            //var source = $("input[name="+inputId+"]").eq(seq).val();
            var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt,seq);
    
            //$("input[name="+inputId+"]").val('');
            if(fileCountResult){
                var source = $("input[name="+inputId+"]").val();
                
                //확장자 잘라내기
                var lastDot = source.lastIndexOf('.');
                var ext = source.substring(lastDot + 1);
                
                if(fileExt.indexOf(ext.toLowerCase()) == -1){
                    alert( "지원하지 않는 이미지 형식입니다.\n jpg, gif, png 형식만 가능합니다." );
                    imgAppend(seq);
                }else{
                    readURL(fileThis,seq);
                }
            }
        };
    
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
    
        function fnb_isEmailOK(sz_email){
            var OK = false;
            var pattern = /([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)\.([0-9a-zA-Z_-]+)/;
    
            if(sz_email && pattern.test(sz_email))
                OK = true;
            return OK;
        }
    
        //글자수체크
        var displayBytes = function(nm, id){
            var obj = document.getElementById(id);
            if(obj.value.bytes() > nm){
                if(event.keyCode != '8'){
                    //alert(nm+'바이트까지 입력이 가능합니다.');
                    alert(nm+Message.msg.chkFormByteUntill);
                }
                obj.value = obj.value.substring(0, obj.value.length - 10);
            }
            eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
        };
    
        //글자수체크 bytes 계산 속성 추가
        String.prototype.bytes = function(){
            var str = this;
            var size = 0;
            for(var i=0; i < str.length; i++){
                size += (str.charCodeAt(i) > 128) ? 2 : 1;
            }
            return size;
        };
    
        //미리보기
        var jsGoodsPreview = function(){
            $("#goodsLicenceNms").val($("#goodsLicenceNm").text());
            $("#metaLangsNm").val($("input[name=metaLangs]:checked").map(function(){ return $("#"+this.id+"Nm").text(); }).get().join(", "));
            $("#metaOSnms").val($("#metaOSnm").text());
            $("#metaASnms").val($("#metaASnm").text());
    
            var selectedItem = new Array();
            $('input[name="archtcSe1"]:checkbox:checked').each(function(i){
                selectedItem[i] = $(this).val();
            });
            if(selectedItem[0] == null || selectedItem[0] == ""){ selectedItem[0] = 0; };
            if(selectedItem[1] == null || selectedItem[2] == ""){ selectedItem[1] = 0; };
    
            //아키텍쳐
            var archtcSe = Number(selectedItem[0]) + Number(selectedItem[1]);
            $("#archtcSe").val(archtcSe);
    
            $("#mnlFilesFileDesc").val($.trim($(".mnlFilesFileDesc1").val())+"," + $.trim($(".mnlFilesFileDesc2").val()) +","+ $.trim($(".mnlFilesFileDesc3").val()) +","+ $.trim($(".mnlFilesFileDesc4").val()) +","+ $.trim($(".mnlFilesFileDesc5").val()));
    
            window.open("/korean/pt/popup/PD_goodsPreview.do","preview","width=1040, height=768, scrollbars=yes");
            document.dataForm.action = "/korean/pt/popup/PD_goodsPreview.do";
            document.dataForm.target = "preview";
            document.dataForm.submit();
            document.dataForm.target = "_self";
        };
    
        var jsMetaPop = function(el, codeGroupCd, cdStart, cdEnd){
            var codeLangCode = $("input[name=langCode]").val();
            $(el).colorbox({
                title        : "",
                href         : "/korean/pt/popup/PD_metaPop.do?codeLangCode=" + codeLangCode + "&codeGroupCd=" + codeGroupCd + "&cdStart=" + cdStart + "&cdEnd=" + cdEnd,
                width        : "680",
                height       : "400",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
        };
    
        var jsMetaTagDelete = function(el){
            if(confirm(el.text.substr(0, el.text.length - 2) + " 태그를 삭제하시겠습니까?")){
                $(el).parent().remove();
                var tempTag = $("#metaTAGs").val();
                tempTag = tempTag.replace(el.id.substr(7) + ",","");
                tempTag = tempTag.replace(","+el.id.substr(7),"");
                tempTag = tempTag.replace(el.id.substr(7),"");
                $("#metaTAGs").val(tempTag);
            }
        };
        
        // 클라우드 서비스 하위 메뉴 /*_userguide.getCtgryList*/ 에서 다중선택할 수있도록 한다.
        // '3-4. 서비스형 소프트웨어(SCS) 관련 규격 정보'에서 '컨설팅 가능 상세 서비스' 를 '선택'
        var jsCtgryListPop = function(el) 
        {
            $(el).colorbox({
                title        : "",
                href         : "/korean/pt/popup/PD_ctgryListPop.do",
                width        : "680",
                height       : "400",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
        };
    
        var jsInputFileReset = function(fileId, textId){
            $("#" + textId).val("");
            var control = $("#" + fileId);
            control.replaceWith( control = control.clone( true ) );
            
            var priceDnFileSeq = control.parent().find("input:hidden[name=priceDnFileSeq]");
            if (typeof priceDnFileSeq.val() != "undefined" );
            	priceDnFileSeq.val(-1) ;            
        };
    
        var jsCancel = function(){
            if(confirm("서비스등록을 취소하시겠습니까?")){
                location.reload();
            }
            return false;
        };
    
        //기술카테고리
        var jsTechCtgryChk = function(){
            var ctgryCds = new Array();
            $("input[name=ctgryCds]").each(function(i){
                ctgryCds[i] = $(this).val();
            });
    
            var langCode = $("#langCode").val();
            var techCtgry = "";
            switch(langCode){
                case '00' :
                    techCtgry = "6202_44";
                    break;
                case '01' :
                    techCtgry = "6202_308";
                    break;
                case '06' :
                    techCtgry = "6202_399";
                    break;
                default:
                    break;
            }
    
            var tech = false;
            $("#dataForm").ajaxSubmit({
                url      : "ND_techCtgryChk.do",
                data     : { ctgryCds : ctgryCds, techCtgry : techCtgry },
                type     : "POST",
                dataType : "text",
                async    : false,
                success  : function(response){
                    if(response == "true"){
                        tech = true;
                    }else{
                        alert("기술 카테고리에서 반드시 1개 이상의 카테고리를 선택하셔야 합니다.");
                        tech = false;
                    }
                }
            });
            return tech;
        };
        
        var fileAdd = function (){
            $("#fileAddsection").show();
            $("#fileAddButton").html("");
            
        }
        
        /* var jsChkPrice = function(val, box) {
            if(val == '1005') {
                if(box.checked) {
                    $('#goodsPc').attr('readOnly',false);
                    $('#goodsPc').focus();
                } else {
                    $('#goodsPc').val('');
                    $('#goodsPc').attr('readOnly',true);
                }
            }
        } */
        
        // 서비스 평가판 제공여부 및 제공기간
        var jsAtSvcEvl = function(val){
            if (val == 'N'){
                $('#svcEvlSuplyPd').attr("readonly",true);
                $('#svcEvlSuplyPd').val('');
            }else{
                $('#svcEvlSuplyPd').attr("readonly",false);
                $('#svcEvlSuplyPd').val('');
                $('#svcEvlSuplyPd').focus();
            }          
        }
        
        // API 지원 여부 및 타입
        var jsApiSportAt = function(val){
            if (val == 'N'){
                $('#apiSportTy').attr("readonly",true);
                $('#apiSportTy').val('');
            }else{
                $('#apiSportTy').attr("readonly",false);
                $('#apiSportTy').val('');
                $('#apiSportTy').focus();
            }
        }
        
        // 사용자 매뉴얼 정보 유무 및 설명
/*         var jsUserMnlInfoAt = function(val){
            if (val == 'N'){
                $('#userMnlInfoInput').attr("readonly",true);
                $('#userMnlInfoInput').val('');
            }else{
                $('#userMnlInfoInput').attr("readonly",false);
                $('#userMnlInfoInput').val('');
                $('#userMnlInfoInput').focus();
            }
        } */
        
        // 사용자 교육 지원 여부  및 정보 
        var jsUserEdcSportAt = function(val){
            if (val == 'N'){
                $('#userEdcSportInput').attr("readonly",true);
                $('#userEdcSportInput').val('');
            }else{
                $('#userEdcSportInput').attr("readonly",false);
                $('#userEdcSportInput').val('');
                $('#userEdcSportInput').focus();
            }
        } 
        
        //
        var jsCstmrCnterOperAt = function(val){
            //alert(val);
            if (val == 'N'){
                $('#cstmrCnterOperTime').attr("readonly",true);
                $('#cstmrCnterOperTime').val('');
            }else{
                $('#cstmrCnterOperTime').attr("readonly",false);
                $('#cstmrCnterOperTime').val('');
                $('#cstmrCnterOperTime').focus();
            }
        }  
        
		var isMarking = function(val, val2) {

	        //첨부된 파일중 ajax를 이용하여 파일 삭제
//	        var jsFileDelete = function(element, seq, id){
//			alert(val);
			
		    if ( $("#isMark").is(":checked") ) {
	            if (confirm("서비스 인증정보 내용이 모두 삭제됩니다. 삭제하시겠습니까?")) {
	            	
	                var url = "ND_markingInfoDelete.do";
	                $.post(url,
	                    { goodsCode : val, isMark : 'Y', updateYn : val2},

	                    function(result){
	                        
	                    	//alert(result);
	                    	
	                    	if(result > 0){
	                            //$(element).parent().remove();

	                            self.location.reload();

	                        }else{
	                            alert('서비스 인증정보를 삭제하지 못했습니다.');
	                        }
	                    }, 'json');	            	
	            	
/* 	                $(".markCrtfcFile").val('');
	                $(".markCrtfcInput").val('');
	                
	                $(".markCrtfcInput").attr("disabled", true);
			    	$(".markCrtfcFile").attr("disabled", true);
			    	
			    	$(".markCrtfcCodeInput").attr("disabled", true);
			    	$(".markCrtfcCodeInput").val('');
			    	
			    	<c:forEach items="${goodsMark}" var="_goodsMark" varStatus="statusSeq">
			    	<c:choose><c:when test="${_goodsMark.MARKCD != '1005' and _goodsMark.MARKCD != '1003'}"> 
			    	jsInputFileReset('markCrtfcFile${statusSeq.index}','markCrtfcInput${statusSeq.index}');
			    	</c:when></c:choose>
			    	</c:forEach> */
	            }
		    }else{
		        
/*                 var url = "ND_markingInfoDelete.do";
                $.post(url,
                    { goodsCode : val, isMark : 'N'},

                    function(result){
                        
                    	//alert(result);
                    	
                    	if(result > 0){
                            //$(element).parent().remove();

                            self.location.reload();

                        }else{
                            alert('서비스 인증정보를 삭제하지 못했습니다.');
                        }
                    }, 'json');	  	 */	    	


         				$("#markCrtfcFile0Span").show();
         				$("#markCrtfcFile1Span").show();
         				$("#markCrtfcFile3Span").show();
         				
         				$("#markCrtfcFile0Images").show();
         				$("#markCrtfcFile1Images").show();
         				$("#markCrtfcFile3Images").show();
         				
         				$("#gsCrtfcNo").attr("readonly",false);
                    
                    
		    	$(".markCrtfcInput").attr("disabled", false);
		        $(".markCrtfcFile").attr("disabled", false);
		        
		        $(".markCrtfcCodeInput").attr("disabled", false);
		    }
		}
		
		
		var fnSetArchtcSe = function(val) {
		    var selectedItem = new Array();
            $('input[name="archtcSe1"]:checkbox:checked').each(function (i){
                selectedItem[i] = $(this).val();
            });

            if(selectedItem[0] == null || selectedItem[0] == ""){ selectedItem[0] = 0;};
            if(selectedItem[1] == null || selectedItem[2] == ""){ selectedItem[1] = 0;};

            var archtcSe = Number(selectedItem[0]) + Number(selectedItem[1]);

		    $("#archtcSe").val(archtcSe);
		}
		
	    var jsFileDown = function(fid) {
	        <c:if test="${empty sessionScope['__usk']}">
	        if(confirm(Message.msg.userLoginCheck)) {
	            top.location.href = Config.url.userLogin
	                    + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
	        }
	        </c:if>
	        <c:if test="${not empty sessionScope['__usk']}">
	        self.location.href = "/component/file/ND_fileDownload.do?id=" + fid;
	        </c:if>
	    };

	    
	    $('.DOC_TEXT').keyup(function (e){
 	    	var content = $(this).val();
//	    	debugger;
	    	$('#counter').html("("+content.length+"/최대10자)");
	    	
	    	if(content.length > 10){
	    		alert("최대 10자리");
	    		
	    		$(this).val(content.substring(0,10));

	    		$('#counter').html("(10/최대10자)");		
	    	}
	    });	    

	    var fnChangeEvent = function(vl) {
	        //$("#sortVl").val(vl)
	        
	        if(vl == '1001'){
	        	alert(vl);	
	        }
	        
	        
	        
	        //document.dataForm.submit();
	    }
	    
	    
    </script>
    
</head>
<body>

<div class="supAdm view register">
    
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">

	<input type="hidden" name="nxtStep"   id="nxtStep"   value="" />
	<input type="hidden" name="curStep"   id="curStep"   value="${curStep}" />
	<input type="hidden" name="updateYn"   id="updateYn"   value="${updateYn}" />	
	<input type="hidden" name="curPageUpdateYn"   id="curPageUpdateYn"   value="" />	

	<input type="hidden" name="goodsCode" id="goodsCode" value="${session_GoodsCode}"/> <!-- 임시저장을 한번이라도 하면 세션에서 값을 가지고온다. -->
	
    <input type="hidden" name="goodsRegistSttus"       id="goodsRegistSttus"    value="${goodsInfo.goodsRegistSttus}" />
    <input type="hidden" name="goodsStatus"            id="goodsStatus"         value="${goodsInfo.goodsRegistSttus}" />
    <input type="hidden" name="goodsChargerEmail"      id="goodsChargerEmail"   value="" />
    <input type="hidden" name="goodsChargerCttpc"      id="goodsChargerCttpc"   value="" />
    <input type="hidden" name="goodsChargerMbtlnum"    id="goodsChargerMbtlnum" value="" />
    <input type="hidden" name="langCode" id="langCode" value="00"/>
    <input type="hidden" name="insertSection" id="insertSection" value=""/>    
    <input type="hidden" name="mode" id="mode" value=""/>

    <div id="seviceprocess" class="clearfix" style="margin-bottom: 50px;">
        <ul>
            <li><span id="process_01" value="1" class="serviceprocess ${active1}" pointer;"><img src="/cloud_ver2/new_cloud/images/img_Serviceprocess_01_${onoff1}.png" alt="서비스 상세정보 입력1"/></span></li>
            <li><span id="process_02" value="2" class="serviceprocess ${active2}" pointer;"><img src="/cloud_ver2/new_cloud/images/img_Serviceprocess_02_${onoff2}.png" alt="서비스 상세정보 입력2"/></span></li>
            <li><span id="process_03" value="3" class="serviceprocess ${active3}" pointer;"><img src="/cloud_ver2/new_cloud/images/img_Serviceprocess_03_${onoff3}.png" alt="서비스 상세정보 입력3"/></span></li>
            <li><span id="process_04" value="4" class="serviceprocess ${active4}" pointer;"><img src="/cloud_ver2/new_cloud/images/img_Serviceprocess_04_${onoff4}.png" alt="서비스 상세정보 입력4"/></span></li>
            <li><span id="process_05" value="5" class="serviceprocess ${active5}" pointer;"><img src="/cloud_ver2/new_cloud/images/img_Serviceprocess_05_${onoff5}.png" alt="서비스 상세정보 입력5"/></span></li>
        </ul>
    </div>
    
<!--1 단계 시작 -->
    <div id="serviceRegist01" class="serviceRegist ${active1}">
    	<h3>1-1. 서비스 일반정보</h3>
        	<table class="tbl_st4 basicInput">    
		        <tr>
		            <th class="requ">서비스명</th>
		            <td><input name="goodsNm" id="goodsNm" type="text" placeholder="" value="<c:out value='${goodsInfo.goodsNm}'/>" style="width:70%;" onKeyup="javascript:displayBytes(70,'goodsNm');"/>&nbsp;(<span id="goodsNm_bytes">0</span>/70 Byte)</td>
		        </tr>
		        <tr>
		            <th class="requ">서비스 구분</th>
		            <td>
		            	<!-- 1005 -->
		                <c:forEach items="${goodsKndCd}" var="_goodsKndCd" varStatus="status">
		                    
		                    <input type="radio" name="goodsKndCd" id="goodsKndCd_${_goodsKndCd.PRVCD}" value="${_goodsKndCd.PRVCD}" onclick="jsGoodsKndCd(this.value)" style="margin-right: 10px;"
		                    <c:if test="${_goodsKndCd.PRVCD eq goodsInfo.goodsKndCd}"> checked="checked" </c:if>>
		                    <label for="goodsKndCd_${_goodsKndCd.PRVCD}">${_goodsKndCd.PRVNM}</label>    
		                </c:forEach>
		                <label for="goodsKndCd" class="error"  style="display:none;"></label>
		            	※ 서비스 구분별 규격항목이 다르므로 정확히 선택하시기 바랍니다.
		            </td>
		        </tr>        
		        <tr>
		            <th class="requ">카테고리</th>
		            <td>
		                <a href="#" onclick="jsCtgrySelPop(this);" id="jsCtgrySelPop" class="btns st3">카테고리 선택</a>
		                <input type="hidden" id="setCtgryCodes" name="setCtgryCodes" value="<c:forEach var="goodsCateList" items="${goodsCateList}" varStatus="statusIndex">${goodsCateList.ctgryCode}<c:if test="${statusIndex.index+1 lt fn:length(goodsCateList) }">,</c:if></c:forEach>"/>
		                <div class="relaCate" id="goods">
		                    <!-- 연결된 카테고리 -->
		                    <c:forEach items="${goodsCateList}" var="_goodsCtgry" varStatus="status">
<%-- 		                    <c:forEach var="_goodsCtgry" items="${goodsCateList}" varStatus="statusIndex"> --%>
								<span id="goodsCtgry_${_goodsCtgry.ctgryCode}">
		                    	<%-- <span class="multi-list langCategory${_goodsCtgry.ctgryCode} goodsCtgry_${_goodsCtgry.ctgryCode}"> --%>
		                    		<input type="hidden" name="ctgryCds" class="getCtgryCodes" value="${_goodsCtgry.ctgryCode}">
		                    		<c:out value='${_goodsCtgry.ctgryName }'/><c:if test="${status.index+1 lt fn:length(goodsCateList) }">, </c:if>
		                        </span>
		                    </c:forEach>
		                </div>                 
		            </td>
		        </tr>
		        <tr>
		            <th class="requ">과금기준</th>
		            <td>
		            	<!-- 2077 -->
		                <c:forEach items="${dueStdrMumm}" var="_dueStdrMumm" varStatus="status">
		                    <input type="radio" name="dueStdrMumm" id="dueStdrMumm_${_dueStdrMumm.PRVCD}" value="${_dueStdrMumm.PRVCD}" style="margin-right: 10px;"
		                    <c:if test="${_dueStdrMumm.PRVCD eq goodsInfo.dueStdrMumm}"> checked="checked" </c:if>>
		                    <label for="dueStdrMumm_${_dueStdrMumm.PRVCD}">${_dueStdrMumm.PRVNM}</label>
		                </c:forEach>
		            	<label for="dueStdrMumm" class="error"  style="display:none;"></label>
		            </td>
		        </tr>
		        <tr>
		            <th class="requ">서비스 가격</th>
		            <td class="vat">
		            	<div class="unit" style="width:100%">
		            		<span id="spanSvcPcUntCd" class="sel_box">
		                    	<select id="svcPcUntCd" name="svcPcUntCd">
		                        <!-- 2064 -->
		                        <c:forEach items="${svcPcUntCd}" var="_svcPcUntCd" varStatus="status">
		                        	<option value="${_svcPcUntCd.PRVCD}">${_svcPcUntCd.PRVNM}</option>    
		                        </c:forEach>
		                        </select>
		                    </span>
			            	<input type="text" id="svcPc" name="svcPc" placeholder="" value="<fmt:formatNumber value="${goodsInfo.svcPc}" type="NUMBER"/>" style="width:150px"  maxlength="13" style="ime-mode:disabled" onchange="getNumber(this);" onkeyup="getNumber(this);"/>
			            	<label><input type="checkbox" id="svcPcVat" name="svcPcVat" <c:if test="${goodsInfo.svcPcVat eq 'Y'}"> checked="checked" </c:if>>VAT 포함</label>
		            	</div>
		            </td>
		        </tr>
		        <tr>
		            <th class="requ">최소 계약기간</th>
		            <td><input type="text" id="mummCntrctpd" style="width:250px"  name="mummCntrctpd" placeholder="" value="${goodsInfo.mummCntrctpd}"></td>
		        </tr>
		        <tr>
		            <th class="requ">서비스 대표 이미지</th>
		            <td>
		            <div class="thumb" >
		                <span id="imgPrev1">
		                    <a href="#" class="del" onclick="jsFileRemove('1'); return false;">삭제</a>
		                    <!-- <img src="/cloud_ver2/new_cloud/images/temp/thumb_10.png" alt="대표이미지" id="imgPrev1"/> -->
		                    <p class="thumbimg">
		                    	<c:if test="${fn:length(goodsInfo.goodsImageFileUrl) gt 0}">
		                    	<img src="${goodsInfo.goodsImageFileUrl[0]}" alt="대표이미지" id="imgPrev1"/>
		                    	</c:if>
		                    </p>
		                    <a href="#">등록</a>
		                    <p class=" req" id="fileSet1"  style="opacity:0; overflow:hidden; position:absolute; top:110px; right:50px;width:50px;">
		                    	<input type="file" name="imageFile1" id="imageFile1" onchange="jsPreview('imageFile1', 0, 0, 400, 300, 1024, 'jpg,gif,png',1,'Img', -1, 5,this);" accept=".gif, .jpg, .png"/>
		                        <input type="hidden" name="fileDesc" id="imageFile1Desc" value=""/>
		                        <input type="hidden" name="goodsImageFileSeq" id="goodsImageFileSeq" value="${goodsInfo.goodsImageFileSeq}"/>
		                        
		                    </p>
		                </span> 
		                <span id="imgPrev0" style="display:none;" ></span>
		            </div>
		            <i>※ 이미지는 10MB미만, 318px x 278px의 JPG, GIF파일만 등록가능합니다. 사이즈가 다를 경우 승인되지 않습니다.</i>
		            </td>
		        </tr>
		        <tr>
		            <th>사용화면 이미지 등록</th>
		            <td>
			            <div class="thumb" >    
			                <c:if test="${empty dataVo.imageFile}">
			                    <c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
			                        <span id="imgPrev${status.index}">
			                            <a href="#" class="del" onclick="jsFileRemove('${i}'); return false;">삭제</a>
			                            <p class="thumbimg">
			                            <%-- ${fn:length(goodsInfo.goodsImageFileUrl)-1} --%>
			                            	<c:if test="${fn:length(goodsInfo.goodsImageFileUrl) gt 0}">
			                            		<c:forEach var="j" begin="1" end="${fn:length(goodsInfo.goodsImageFileUrl)-1}" step="1" varStatus="statusImg">
			                            			<c:if test="${j eq i-1 }">
			                            				<img src="${goodsInfo.goodsImageFileUrl[j]}" id="imgPrev${i}"/>
			                            			</c:if>
			                            		</c:forEach>
			                            	</c:if>
			                            </p>
			                            <a href="#">등록</a>
			                            <p  id="fileSet${status.index}" style="opacity:0; overflow:hidden; position:absolute; top:110px; right:50px;width:50px;">
			                                <input type="file" name="imageFile${i}" id="imageFile${i}" class="imageFile" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 1024, 'jpg,gif,png',${i},'Img', -1, 5,this);" accept=".gif, .jpg, .png"/>
			                                <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""/>
			                            </p>
			                        </span>
			                    </c:forEach>
			                    <input type="hidden" name="image" value="${image}" />
			                </c:if>
			            </div>
			            <i>※ 이미지는 10MB미만, 318px x 278px의 JPG, GIF파일만 등록가능합니다. 사이즈가 다를 경우 승인되지 않습니다.</i>
		            </td>
		        </tr>
		        <tr>
		            <th>체험판 URL</th>
		            <td>
		            	<input type="text" name="itemVodUrl" id="itemVodUrl" placeholder="" value="${goodsInfo.itemVodUrl}" />
		            	※ 이용자가 다운로드 또는 온라인 체험을 받을 수 있는 서비스인 경우 관련 URL 주소를 입력해 주세요.
		            </td>
		        </tr>
		        <tr>
		            <th>서비스 안내 URL</th>
		            <td>
		            	<input type="text" name="goodsDwldUrl" id="goodsDwldUrl" placeholder="" value="${goodsInfo.goodsDwldUrl}" />
		            	※ 이용자가 다운로드 또는 온라인에서 확인 할 수 있는 서비스 안내 URL 주소를 입력해 주세요.
		            </td>
		        </tr>
		        <tr>
		            <th>모니터링 URL</th>
		            <td>
		            	<input type="text" id="goodsMonitorUrl" name="goodsMonitorUrl" id="goodsMonitorUrl" placeholder="" value="${goodsInfo.goodsMonitorUrl}" />
		            	※ 모니터링URL 시비스 상태를 확인할 수 있는 모니터링 URL을 입력해 주세요
		            </td>
		        </tr>
        	</table>
    
    </div>
    
    
<!--2 단계 시작-->
    <div id="serviceRegist02" class="serviceRegist ${active2}">
    
        <h3>2-1. 서비스 상세정보</h3>
        
        <table class="tbl_st4 basicInput">
        <tr>
            <th class="requ">서비스개요</th>
            <td>
            	<textarea name="goodsSumry" id="goodsSumry" onkeyup="javascript:displayBytes(3000,'goodsSumry');">${goodsInfo.goodsSumry}</textarea>
            	<p class="ar mt5">
                	<span class="byte"><span id="goodsSumry_bytes" class="txt-point">0</span><span class="caption">/ 3000 Byte</span></span>
            	</p>
            </td>
        </tr>
        <tr>
            <th class="requ">특장점</th>
            <td>
                <textarea name="itemSfe" id="itemSfe" rows="15" style="width: 743px" title="내용을 입력해주세요">${goodsInfo.itemSfe}</textarea>
                         <script type="text/javascript">
                         //<![CDATA[
                             CKEDITOR.replace('itemSfe', {
                                 height               : 200,
                                 htmlEncodeOutput     : false,
                                 enterMode            : "2",
                                 skin                 : "moono",
                                 toolbar              : [[ 'BulletedList' ]],
                                 filebrowserUploadUrl : ""/* "/component/file/ND_fileUpload.do" */,
                                 on                   : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsSumry").focus();}}
                             });
                         //]]>
                         </script>
                        
            </td>
        </tr>
        <tr>
            <th class="requ">대상고객</th>
            <td>
                <textarea name="cstmrInfo" id="cstmrInfo" rows="15" style="width: 743px" title="내용을 입력해주세요">${goodsInfo.cstmrInfo}</textarea>
                         <script type="text/javascript">
                         //<![CDATA[
                             CKEDITOR.replace('cstmrInfo', {
                                 height               : 200,
                                 htmlEncodeOutput     : false,
                                 enterMode            : "2",
                                 skin                 : "moono",
                                 toolbar              : [[ 'BulletedList' ]],
                                 filebrowserUploadUrl : ""/* "/component/file/ND_fileUpload.do" */,
                                 on                   : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsSumry").focus();}}
                             });
                         //]]>
                         </script>
            </td>
        </tr>    
        <tr>
            <th class="requ">주요기능</th>
            <td>
                <textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" style="width: 743px" title="내용을 입력해주세요">${goodsInfo.goodsMainFnct}</textarea>
                          <script type="text/javascript">
                          //<![CDATA[
                              CKEDITOR.replace('goodsMainFnct', {
                                  height               : 200,
                                  htmlEncodeOutput     : false,
                                  enterMode            : "2",
                                  skin                 : "moono",
                                  toolbar              : [[ 'BulletedList' ]],
                                  filebrowserUploadUrl : ""/* "/component/file/ND_fileUpload.do" */,
                                  on                   : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsSumry").focus();}}
                              });
                              
                          //]]>
                          </script>
            </td>
        </tr>
        <tr>
            <th class="requ">주요 레퍼런스<br />(등록 서비스 기준)</th>
            <td>
                <textarea name="goodsRefer" id="goodsRefer" rows="15" style="width: 743px" title="내용을 입력해주세요">${goodsInfo.goodsRefer}</textarea>
                          <script type="text/javascript">
                          //<![CDATA[
                              CKEDITOR.replace('goodsRefer', {
                                  height               : 200,
                                  htmlEncodeOutput     : false,
                                  enterMode            : "2",
                                  skin                 : "moono",
                                  toolbar              : [[ 'BulletedList' ]],
                                  filebrowserUploadUrl : ""/* "/component/file/ND_fileUpload.do" */,
                                  on                   : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsSumry").focus();}}
                              });
                              
                          //]]>
                          </script>
						<%--<input type="text" id="mainRefer" name="mainRefer" value="${specInfo.mainRefer}"> --%>
            </td>
        </tr>
<%--         
        <tr>
            <th class="requ">서비스 정의 및 특징</th>
            <td><input type="text" id="svcDfnSfe" name="svcDfnSfe"  value="${specInfo.svcDfnSfe}"></td>
        </tr>
 --%>        
        <tr>
            <th class="requ">서비스 기대효과</th>
            <td>
            	<textarea name="goodsExpcEffect" id="goodsExpcEffect" rows="15" style="width: 743px" title="내용을 입력해주세요">${goodsInfo.goodsExpcEffect}</textarea>
                          <script type="text/javascript">
                          //<![CDATA[
                              CKEDITOR.replace('goodsExpcEffect', {
                                  height               : 200,
                                  htmlEncodeOutput     : false,
                                  enterMode            : "2",
                                  skin                 : "moono",
                                  toolbar              : [[ 'BulletedList' ]],
                                  filebrowserUploadUrl : ""/* "/component/file/ND_fileUpload.do" */,
                                  on                   : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsSumry").focus();}}
                              });
                              
                          //]]>
                          </script>
            </td>
        </tr>
        </table>
        
       <div id="2-2" <c:if test="${goodsInfo.goodsKndCd eq '1004'}">style="display:none"</c:if>>
        <h3>2-2. 서비스 사양정보</h3>
        
        <table class="tbl_st4 basicInput">
        <tr>
            <th class="requ">서비스 관리 기준</th>
            <td><a id="metaSvcBtn" onclick="jsMetaPop(this, 2030, '', '');" href="javascript:;" class="btns st3">선택</a>
                <span id="metaSvcNm">
					<c:set var="conut" value="0" />
                	<c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
                		<c:if test="${metaSvc.groupCd eq '2030'}">
                			<c:if test="${conut gt 0}">,</c:if>
                			${metaSvc.indvdlzNm}
                			<c:set var="conut" value="${count + 1}" />
                		</c:if>
                	</c:forEach>
                </span>
                <input name="metaSvcs" id="metaSvcs" type="hidden" value="<c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus"><c:if test="${metaSvc.groupCd eq '2030'}">${metaSvc.indvdlzCd}<c:if test="${metaSvcStatus.index lt fn:length(goodsMetaList) }">,</c:if></c:if></c:forEach>"/>
            </td>
        </tr>
        <tr>
            <th class="requ">구축방식</th>
            <td>
            	<!-- 2032 -->
            	<c:forEach items="${metaCnstcMthds}" var="_metaCnstcMthds" varStatus="status">                    
                	 
                	<c:set var="checked" value="false"/>
                	<c:forEach items="${goodsMetaList}" var="_goodsMeta" varStatus="status">
	               		<c:if test="${_goodsMeta.groupCd eq '2032' and _goodsMeta.indvdlzCd eq _metaCnstcMthds.PRVCD}">
	                		<c:set var="checked" value="true"/>
	                	</c:if>
                	</c:forEach>
                	
                	<input type="checkbox" name="metaCnstcMthds" id="metaCnstcMthds_${_metaCnstcMthds.PRVCD}" value="${_metaCnstcMthds.PRVCD}" style="margin-right: 10px;" <c:if test="${checked eq true}"> checked="checked" </c:if>>
                	<label for="metaCnstcMthds_${_metaCnstcMthds.PRVCD}">${_metaCnstcMthds.PRVNM}</label>    
                </c:forEach>
            </td>
        </tr>
        <tr>
            <th class="requ">서비스 유형</th>
            <td>
            	<!-- 2034 -->
            	<c:forEach items="${serviceOfferMethod}" var="_serviceOfferMethod" varStatus="status">                    
                	<input type="radio" name="serviceOfferMethod" id="serviceOfferMethod_${_serviceOfferMethod.PRVCD}" value="${_serviceOfferMethod.PRVCD}" style="margin-right: 10px;" <c:if test="${_serviceOfferMethod.PRVCD eq goodsInfo.serviceOfferMethod}"> checked="checked" </c:if>>
                	<label for="serviceOfferMethod_${_serviceOfferMethod.PRVCD}">${_serviceOfferMethod.PRVNM}</label>    
                </c:forEach>            
            </td>
        </tr>
        <tr>
            <th class="requ">아키텍쳐</th>
            <td>
             	<input type="hidden" id="archtcSe" name="archtcSe" value="${goodsInfo.archtcSe}"/>
            	<label><input  type="checkbox" id="archtcSe1" name="archtcSe1" value="1" onclick="fnSetArchtcSe('1')" <c:if test="${goodsInfo.archtcSe eq '1' or goodsInfo.archtcSe eq '3'}">checked="checked"</c:if> /> 32-BIT</label>
            	<label><input type="checkbox" id="archtcSe1" name="archtcSe1" class="space_ml" value="2" onclick="fnSetArchtcSe('2')" <c:if test="${goodsInfo.archtcSe eq '2' or goodsInfo.archtcSe eq '3'}">checked="checked"</c:if>/> 64-BIT</label>
            </td>
        </tr>
        <tr>
            <th class="requ">지원OS</th>
            <td><a id="metaOSsBtn" onclick="jsMetaPop(this, 1020, '', '');" href="javascript:;"  class="btns st3">선택</a>
            <span id="metaOSnm">
                	<c:forEach var="metaOSnm" items="${goodsMetaList}" varStatus="metaOSnmStatus">
                		<c:if test="${metaOSnm.groupCd eq '1020'}">
                			${metaOSnm.indvdlzNm}<c:if test="${metaOSnmStatus.index lt fn:length(goodsMetaList) }">,</c:if>
                		</c:if>
                	</c:forEach>
            </span>
            	<input name="metaOSs"   id="metaOSs"   type="hidden" value="<c:forEach var="metaOSnm" items="${goodsMetaList}" varStatus="metaOSnmStatus"><c:if test="${metaOSnm.groupCd eq '1020'}">${metaOSnm.indvdlzCd}<c:if test="${metaOSnmStatus.index lt fn:length(goodsMetaList) }">,</c:if></c:if></c:forEach>"/>
                <input name="metaOSetc" id="metaOSetc" type="hidden" value="<c:forEach var="metaOSnm" items="${goodsMetaList}" varStatus="metaOSnmStatus"><c:if test="${metaOSnm.groupCd eq '1020'}">${metaOSnm.metaEtcCn}</c:if></c:forEach>"/>
                <input name="metaOSnms" id="metaOSnms" type="hidden" value=""/>
            </td>
        </tr>
        <tr>
            <th class="requ">지원언어</th>
            <td class="lang">
                <c:forEach items="${goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
                	
                	<c:set var="checked" value="false"/>
                	<c:forEach items="${goodsMetaList}" var="_goodsMeta" varStatus="status">
	               		<c:if test="${_goodsMeta.groupCd eq '1019' and _goodsMeta.indvdlzCd eq _goodsMetaLang.metaLangCd}">
	                		<c:set var="checked" value="true"/>
	                	</c:if>
                	</c:forEach>                	
                 
                 	<input name="metaLangs" id="metaLangs${_goodsMetaLang.metaLangCd}" type="checkbox" value="${_goodsMetaLang.metaLangCd}"                    
                    	<c:if test="${checked eq true}"> checked="checked"</c:if>/> 
                    <label for="metaLangs${_goodsMetaLang.metaLangCd}">${_goodsMetaLang.metaLangNm}</lablel> 
                 	
                 	<span id="metaLangs${_goodsMetaLang.metaLangCd}Nm"></span>
	                 <c:if test="${status.last}">
	                     <input name="metaLangEtc" id="metaLangEtc" type="text" title="지원언어 입력" style="width: 250px;" value="" readonly="readonly" />
	                 </c:if>
	                 
                </c:forEach>
                <input name="metaLangsNm" id="metaLangsNm" type="hidden" value=""/>                          
            </td>
        </tr>
        <tr>
            <th class="requ">A/S방침</th>
            <td><a id="metaASsBtn" onclick="jsMetaPop(this, 1021, '1000', '1999');" href="javascript:;"  class="btns st3">선택</a>
                <span id="metaASnm">
                	<c:forEach var="metaASnm" items="${goodsMetaList}" varStatus="metaASnmStatus">
                		<c:if test="${metaASnm.groupCd eq '1021'}">
                			${metaASnm.indvdlzNm}<c:if test="${metaASnmStatus.index lt fn:length(goodsMetaList) }">,</c:if>
                		</c:if>
                	</c:forEach>
                </span>
                <input name="metaASs"   id="metaASs"   type="hidden" value="<c:forEach var="metaASnm" items="${goodsMetaList}" varStatus="metaASnmStatus"><c:if test="${metaASnm.groupCd eq '1021'}">${metaASnm.indvdlzCd}<c:if test="${metaASnmStatus.index lt fn:length(goodsMetaList) }">,</c:if></c:if></c:forEach>"/>
                <input name="metaASetc" id="metaASetc" type="hidden" value="<c:forEach var="metaASnm" items="${goodsMetaList}" varStatus="metaASnmStatus"><c:if test="${metaASnm.groupCd eq '1021'}">${metaASnm.metaEtcCn}</c:if></c:forEach>"/>
                <input name="metaASnms" id="metaASnms" type="hidden" value=""/>
            </td>
        </tr>
        <tr>
            <th>호환성(표준)</th>
            <td><a id="metaStdBtn" onclick="jsMetaPop(this, 2031, '', '');" href="javascript:;" class="btns st3">선택</a>
                <span id="metaStdNm">
                	<c:forEach var="metaStdNm" items="${goodsMetaList}" varStatus="metaStdNmStatus">
                		<c:if test="${metaStdNm.groupCd eq '2031'}">
                			${metaStdNm.indvdlzNm}<c:if test="${metaStdNmStatus.index lt fn:length(goodsMetaList) }">,</c:if>
                		</c:if>
                	</c:forEach>
                </span>
                <input name="metaStds" id="metaStds" type="hidden" value="<c:forEach var="metaStdNm" items="${goodsMetaList}" varStatus="metaStdNmStatus"><c:if test="${metaStdNm.groupCd eq '2031'}">${metaStdNm.indvdlzCd}<c:if test="${metaStdNmStatus.index lt fn:length(goodsMetaList) }">,</c:if></c:if></c:forEach>"/>
            </td>
        </tr>
        <tr>
            <th class="requ">제조사</th>
            <td><input name="goodsMakr" id="goodsMakr" type="text" placeholder="" value="<c:out value='${goodsInfo.goodsMakr}'/>" class="w650" id="" /></td>
        </tr>
        <tr>
            <th class="requ">출시일</span></th>
            <td>
                <input name="comouDe" id="comouDe" type="text" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" placeholder="" value="<c:out value='${goodsInfo.comouDe}'/>" maxlength="8" class="w650" id="" />
                <p class="desc">※ 입력 예시 :20140501</p>
            </td>
        </tr>
        </table>
        <!-- 
        
        인증항목을 db에서 불려옴...
         
            /* _webGoods.goodsMarkList*/    
            
                     SELECT B.INDVDLZ_CD    AS MARKCD
                          , B.INDVDLZ_CD_NM AS MARKNM
                          , A.MARK_CD       AS GOODSMARKCD
                          , (SELECT MARK_IMAGE_FILE_SEQ FROM TST_GOOD_MARK_M WHERE MARK_CD = A.MARK_CD) AS MARKIMAGEFILESEQ
                          , C.CRTFC_SE_FILE_SEQ AS CRTFCSEFILESEQ 
                       FROM OP_CODE_INDVDLZ B 
            LEFT OUTER JOIN TST_GOOD_MARK_I A
                         ON A.MARK_CD    = B.INDVDLZ_CD 
                        AND A.GOODS_CODE = #goodsCode
            LEFT OUTER JOIN TST_CTFC_ATCH_I C
                         ON C.CRTFC_SE_CD = B.INDVDLZ_CD   
                        AND C.GOODS_CODE  = #goodsCode
                      WHERE B.GROUP_CD  = 1011
                        AND B.USE_YN    = 'Y'
                        <if test="langCode != null  and  langCode != ''">
                        AND B.LANG_CODE = #langCode
                        </if>
                   ORDER BY B.CD_SORT_NO

        TST_GOOD_MARK_I // 인증선택정보
        TST_CTFC_ATCH_I // 인증서 첨부파일정보        
        -->
        
        <h3>2-3. 서비스 인증정보 </h3>
        
        <div style="padding-left: 200px;margin-top: -26px;position: relative;">
        	<label><input type="checkbox" id="isMark" name="isMark" value=""  <c:if test="${goodsInfo.isMark eq 'Y'}"> checked="checked" </c:if> onclick="isMarking('${session_GoodsCode}','${updateYn}');" />해당사항 없음</label>
        </div>       
        
        <p style="margin-top: 10px;">
        	※ 인증서가 있는 경우 증빙자료 첨부<br />
        	※ 조달청 나라장터 등록서비스의 경우 조달등록번호를 입력하시기 바랍니다
        </p>
        <table class="tbl_st4 certi">
        	<caption></caption>
	        <colgroup>
	        	<col width="20%">
	            <col width="10%">
	            <col width="*">
	        </colgroup>
	        <tbody>
	        <c:forEach items="${goodsMark}" var="_goodsMark" varStatus="statusSeq">
	        
	            <tr>
	                <th><c:out value='${_goodsMark.MARKNM}'/></th>
	                <c:choose>
	                <c:when test="${_goodsMark.MARKCD != '1005'}">  <!-- GS인증,나라장터종합쇼핑몰 등록 서비스 외 일반인증 -->                                
	                    <!-- td>
	                        <label>
	                            <input type="hidden" name="markCds" id="markCds" value="<c:out value='${_goodsMark.MARKCD}'/>"/>
	                            <input type="checkbox" name="goodsMarkCds" value="<c:out value='${_goodsMark.MARKCD}'/>" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/> 
	                        </label>
	                    </td>
	                    <th>증빙 자료 업로드</th -->
	                    <!-- <td style="width:60px;" style="display:none;"> -->
	                    <input type="checkbox" style="display:none;" name="goodsMarkCds" value="<c:out value='${_goodsMark.MARKCD}'/>" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/>
	                    <!-- </td> -->                    
	                    <td colspan="3">
	                        <div class="uploadFile">
	                            <input type="text" id="markCrtfcInput${statusSeq.index}" readonly="readonly" title="파일명" class="markCrtfcInput"  value="${_goodsMark.FILENM}"/>
	                            <div>

									<c:if test="${_goodsMark.FILENM eq NULL }">
										<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" id="markCrtfcFile${statusSeq.index}Images" onclick="jsInputFileReset('markCrtfcFile${statusSeq.index}','markCrtfcInput${statusSeq.index}');"/>									
	                                	<span class="btns st3" id="markCrtfcFile${statusSeq.index}Span" >파일선택 
	                                    	<input type="file" name="markCrtfcFile${statusSeq.index}" id="markCrtfcFile${statusSeq.index}" class="markCrtfcFile" onchange="jsFileChk('markCrtfcFile${statusSeq.index}', 'markCrtfcInput${statusSeq.index}', 10240, '1', -1, 1); " accept=".pdf"/>
	                                	</span>

									</c:if>
									<c:if test="${_goodsMark.FILENM ne NULL }">
										<img src="/resources/openworks/theme/default/images/btn/btn_del.gif" width="13" height="13" alt="삭제" href="javascript:;" onclick="jsFileDelete(this, ${_goodsMark.CRTFCSEFILESEQ}, '${_goodsMark.FILEID}',${_goodsMark.MARKCD}, '${session_GoodsCode}','${updateYn}');"/>									
	                                	<span class="btns st9" id="markCrtfcFile${statusSeq.index}Span" >파일선택 
	                                	</span>
	                                	
									</c:if>
										<input type="hidden" name="fileDesc" id="markCrtfcFile${statusSeq.index}Desc" value=""/>
		                                <input type="hidden" name="crtfcSeFileSeqs" value="${_goodsMark.CRTFCSEFILESEQ}"/>
		                                
		                                <input type="hidden" name="markCds" id="markCds" value="<c:out value='${_goodsMark.MARKCD}'/>"/>
	                                                            
	                                                            
	                            </div>
	                        </div>    
	                    </td>
	                </c:when>
	                <c:when test="${_goodsMark.MARKCD == '1005'}">  <!-- GS인증 -->
	                    <td colspan="3">
	                        <input type="text" class="markCrtfcCodeInput"  id="gsCrtfcNo" name="gsCrtfcNo" placeholder="" value="${goodsInfo.gsCrtfcNo}" style="witdh:50px"/>
	                        <p class="desc">※ 인증번호는 “-(하이픈)”을 제거하고 입력해주세요.</p> 
	                    </td>
	                </c:when>
	                <c:when test="${_goodsMark.MARKCD == '1003'}">  <!-- 나라장터종합쇼핑몰 등록 서비스(GROUP_CD = 2060) -->
	                    <td colspan="3">
	                    	조달등록번호 <input type="text" class="markCrtfcCodeInput" id="naraCrtfcNo" name="naraCrtfcNo" style="width:400px;" placeholder="" value="${goodsInfo.naraCrtfcNo}" maxlength="12" />  
	                    	<p class="desc">※ 조달등록번호는 “-(하이픈)”을 제거하고 입력해주세요.</p>                       
	                    </td>
	                </c:when>
	                </c:choose>
	            </tr>  
	        </c:forEach>
	        <tbody>
        </table>
		</div>
    </div>       
        
    
<!--3 단계 시작-->
    <div id="serviceRegist03" class="serviceRegist ${active3}">
		<div id="goods_type_SPL" <c:if test="${goodsInfo.goodsKndCd eq '1004'}">style="display:none"</c:if>>
		
			<h3>3-1. 서비스 기술정보</h3>
	          <!-- 규격서 3  -->
	      
	        <table class="tbl_st4 certi">
	            <tr><th class="requ">서비스 시작 절차</th>
	                <td><input type="text" id="svcBeginProcss" name="svcBeginProcss" placeholder="예) 운영계약 후 시스템 오픈" value="${specInfo.svcBeginProcss}"></td>
	            </tr>
	            <tr><th class="requ">서비스 종료 절차</th>
	                <td><input type="text" id="svcEndProcss" name="svcEndProcss" placeholder="예) 시스템 종료 1주일 전에 통보" value="${specInfo.svcEndProcss}"></td>
	            </tr>
	            <tr><th class="requ">서비스 평가판 제공여부 및 제공기간</th>
	                <td>
	                    <label><input type="radio" name="atSvcEvl" value="Y" onclick="jsAtSvcEvl(this.value)"  <c:if test="${specInfo.atSvcEvl eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="atSvcEvl" value="N" onclick="jsAtSvcEvl(this.value)"  <c:if test="${specInfo.atSvcEvl eq 'N' || specInfo.atSvcEvl eq null}"> checked="checked"</c:if>>NO</label>
	                    <input type="text" id="svcEvlSuplyPd" name="svcEvlSuplyPd" style="width: 70%;" placeholder="예) YES선택시 작성 : 1개월 or 해당사항없음" value="${specInfo.svcEvlSuplyPd}" <c:if test="${specInfo.atSvcEvl eq 'N' || specInfo.atSvcEvl eq null}">readonly="readonly"</c:if>>
	                </td>
	            </tr>
	            <tr><th class="requ">SLA 적용 여부</th>
	                <td>
	                    <label><input type="radio" name="slaApplcAt" value="Y" <c:if test="${specInfo.slaApplcAt eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="slaApplcAt" value="N" <c:if test="${specInfo.slaApplcAt eq 'N' || specInfo.slaApplcAt eq null}"> checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr>
	            	<th class="requ">서비스 가용성</th>
	            	<td>
	            		<input type="text" id="svcUseful" name="svcUseful" style="width: 100px; ime-mode:disabled; text-align:right;" placeholder="" value="${specInfo.svcUseful}" maxlength="4" onkeyup="svcUseful_kup(this)" /> % (소수점 1자리)
	            	</td>
	            </tr>
	            <tr>
	            	<th class="requ">자동 확장 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="atmcEstnSportAt" value="Y" <c:if test="${specInfo.atmcEstnSportAt eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="atmcEstnSportAt" value="N" <c:if test="${specInfo.atmcEstnSportAt eq 'N' || specInfo.atmcEstnSportAt eq null}"> checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">클러스터링 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="clusteringSportAt" value="Y" <c:if test="${specInfo.clusteringSportAt eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="clusteringSportAt" value="N" <c:if test="${specInfo.clusteringSportAt eq 'N' || specInfo.clusteringSportAt eq null}"> checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">셀프서비스 프로비저닝 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sfsrvProvisioningSportAt" value="Y" <c:if test="${specInfo.sfsrvProvisioningSportAt eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sfsrvProvisioningSportAt" value="N" <c:if test="${specInfo.sfsrvProvisioningSportAt eq 'N' || specInfo.sfsrvProvisioningSportAt eq null}"> checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">서비스 프로비저닝 시간</th><td><input type="text" id="svcProvisioningTime" name="svcProvisioningTime" style="width: 100px; ime-mode:disabled;" placeholder="" value="${specInfo.svcProvisioningTime}" onchange="getNumber(this);" onkeyup="getNumber(this);" maxlength="4"/> 분</td></tr>
	            <tr><th class="requ">서비스 프로비저닝 해제 시간</th><td><input type="text" id="svcProvisioningRelisTime" name="svcProvisioningRelisTime" style="width: 100px; ime-mode:disabled;" placeholder="" value="${specInfo.svcProvisioningRelisTime}" onchange="getNumber(this);" onkeyup="getNumber(this);" maxlength="4"/> 분</td></tr>
	        </table>
	            
			<h3>3-2. 서비스 및 데이터 관리 정보</h3>
	        <!-- 규격서 4 --> 
	                  
	        <table class="tbl_st4 certi">
	            <tr><th class="requ">데이터센터 국내, 외 위치 정보</th>
	                <td> 
	                    <op:code id="dataCnterLcInfo" grpCd="2079" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="radio" defaultLabel="데이터센터 국내, 외 위치 정보" defaultValues="${specInfo.dataCnterLcInfo}"/>
	                </td>
	            </tr>
	            <tr><th class="requ">데이터센터 위치 정보</th><td><input type="text" id="dataCnterHbrdLcInfo" name="dataCnterHbrdLcInfo" placeholder="예) 대한민국 경기도 OO센터" value="${specInfo.dataCnterHbrdLcInfo}"/></td></tr>
	            <tr><th class="requ">재해복구계획</th><td><input type="text" id="dsstrrecovryPlan" name="dsstrrecovryPlan" placeholder="예) DR제공여부 및 위치, 백업절차, 재해복구 절차 등" value="${specInfo.dsstrrecovryPlan}"/></td></tr>
	            <tr><th class="requ">데이터 추출 절차</th><td><input type="text" id="dataExtrcProcss" name="dataExtrcProcss" placeholder="예) 사용자의 요청 시 특정 데이터에 접근 및 제공 가능" value="${specInfo.dataExtrcProcss}"/></td></tr>
	            <tr><th class="requ">미사용 데이터 보호 정책</th><td><input type="text" id="unuseDataPrtcPolicy" name="unuseDataPrtcPolicy" placeholder="예) 제공기업의 데이터 보호 정책" value="${specInfo.unuseDataPrtcPolicy}"/></td></tr>
	            <tr><th class="requ">안전한 데이터 삭제 정책</th><td><input type="text" id="safeDataDeletePolicy" name="safeDataDeletePolicy" placeholder="예) 제공기업의 데이터 삭제 정책(서비스 종료 시 DB보관 기관 등 포함)" value="${specInfo.safeDataDeletePolicy}"/></td></tr>
	            <tr><th class="requ">서비스 관리 및 현황 정보 제공</th>
	                <td>
	                    <label><input type="radio" name="svcManageSttusInfoSuply" value="Y" <c:if test="${specInfo.svcManageSttusInfoSuply eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="svcManageSttusInfoSuply" value="N" <c:if test="${specInfo.svcManageSttusInfoSuply eq 'N' || specInfo.svcManageSttusInfoSuply eq null}"> checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">서비스 이용 로그 제공 여부</th>
	                <td>
	                    <label><input type="radio" name="svcUseLogSuplyAt" value="Y" <c:if test="${specInfo.svcUseLogSuplyAt eq 'Y'}"> checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="svcUseLogSuplyAt" value="N" <c:if test="${specInfo.svcUseLogSuplyAt eq 'N' || specInfo.svcUseLogSuplyAt eq null}"> checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">장애관리 및 보고 정책</th><td><input type="text" id="troblManageReprtPolicy" name="troblManageReprtPolicy" placeholder="예) 실시간 모니터링을 통해 장애 발견 시 발생시점에 고객보고 진행" value="${specInfo.troblManageReprtPolicy}"/></td></tr>
	            <tr><th class="requ">API 지원 여부 및 타입</th>
	                <td>
	                    <label><input type="radio" name="apiSportAt" value="Y" onclick="jsApiSportAt(this.value)" <c:if test="${specInfo.apiSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="apiSportAt" value="N" onclick="jsApiSportAt(this.value)" <c:if test="${specInfo.apiSportAt eq 'N' || specInfo.apiSportAt eq null}">checked="checked"</c:if>>NO</label>
	                    <input type="text" id="apiSportTy" name="apiSportTy" style="width: 70%;" placeholder="예) YES선택시 작성 : 웹 형식 등 해당 API 지원 타입" value="${specInfo.apiSportTy}" <c:if test="${specInfo.apiSportAt eq 'N' || specInfo.apiSportAt eq null}">readonly="readonly"</c:if>/>
	                </td>
	            </tr>
	        </table>
	            
	            
	        <h3>3-3. 서비스 지원 정보</h3>    
	        <!-- 규격서 5 --> 
	            
	        <table class="tbl_st4 certi">
	            <tr><th class="requ">사용자 매뉴얼 제공 여부</th>
	                <td>
	                    <label><input type="radio" name="userMnlSuplyAt" value="Y" <c:if test="${specInfo.userMnlSuplyAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="userMnlSuplyAt" value="N" <c:if test="${specInfo.userMnlSuplyAt eq 'N' || specInfo.userMnlSuplyAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <!-- tr><th class="requ">사용자 매뉴얼 정보 유무 및 설명</th>
	                <td>
	                    <label><input type="radio" name="userMnlInfoAt" value="Y" onclick="jsUserMnlInfoAt(this.value)" <c:if test="${specInfo.userMnlInfoAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="userMnlInfoAt" value="N" onclick="jsUserMnlInfoAt(this.value)" <c:if test="${specInfo.userMnlInfoAt eq 'N' || specInfo.userMnlInfoAt eq null}">checked="checked"</c:if>>NO</label>	                    
	                    <input type="text" id="userMnlInfoInput" name="userMnlInfoInput" style="width: 70%;" placeholder="예) YES선택시 작성 : 사용자매뉴얼" value="${specInfo.userMnlInfoInput}"  <c:if test="${specInfo.userMnlInfoAt eq 'N' || specInfo.userMnlInfoAt eq null}">readonly="readonly"</c:if>/>
	                </td>
	            </tr -->
	            <tr><th class="requ">사용자 교육 지원 여부 및 정보</th>
	                <td>
	                    <label><input type="radio" name="userEdcSportAt" value="Y" onclick="jsUserEdcSportAt(this.value)" <c:if test="${specInfo.userEdcSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="userEdcSportAt" value="N" onclick="jsUserEdcSportAt(this.value)" <c:if test="${specInfo.userEdcSportAt eq 'N' || specInfo.userEdcSportAt eq null}">checked="checked"</c:if>>NO</label>
	                    <input type="text" id="userEdcSportInput" name="userEdcSportInput" style="width: 70%;" placeholder="예) YES선택시 작성 : 사용자 교육 제공 초기 시스템 셋팅 시 기본 운영 교육 제공" value="${specInfo.userEdcSportInput}"  <c:if test="${specInfo.userEdcSportAt eq 'N' || specInfo.userEdcSportAt eq null}">readonly="readonly"</c:if>/>
	                </td>
	            </tr>
	            <tr><th class="requ">방문 교육 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="visitEdcSportAt" value="Y" <c:if test="${specInfo.visitEdcSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="visitEdcSportAt" value="N" <c:if test="${specInfo.visitEdcSportAt eq 'N' || specInfo.visitEdcSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">방문 기술 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="visitTchnlgySportAt" value="Y" <c:if test="${specInfo.visitTchnlgySportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="visitTchnlgySportAt" value="N" <c:if test="${specInfo.visitTchnlgySportAt eq 'N' || specInfo.visitTchnlgySportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">방문 외 기술 지원 여부 <br /> (온라인, 이메일, 전화 등)</th>
	                <td>
	                    <label><input type="radio" name="visitElseTchnlgySportAt" value="Y" <c:if test="${specInfo.visitElseTchnlgySportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="visitElseTchnlgySportAt" value="N" <c:if test="${specInfo.visitElseTchnlgySportAt eq 'N' || specInfo.visitElseTchnlgySportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">고객센터 운영 여부  및 운영 시간</th>
	                <td>
	                    <label><input type="radio" name="cstmrCnterOperAt" value="Y" onclick="jsCstmrCnterOperAt(this.value)" <c:if test="${specInfo.cstmrCnterOperAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="cstmrCnterOperAt" value="N" onclick="jsCstmrCnterOperAt(this.value)" <c:if test="${specInfo.cstmrCnterOperAt eq 'N' || specInfo.cstmrCnterOperAt eq null}">checked="checked"</c:if>>NO</label>	                    
	                    <input type="text" id="cstmrCnterOperTime" name="cstmrCnterOperTime" style="width: 70%;" placeholder="예) YES선택시 작성 : 오전 9시 ~ 오후 8시" value="${specInfo.cstmrCnterOperTime}"  <c:if test="${specInfo.cstmrCnterOperAt eq 'N' || specInfo.cstmrCnterOperAt eq null}">readonly="readonly"</c:if>/>
	                </td>
	            </tr>
	        </table>
        
        </div>
        <div id="goods_type_1002" <c:if test="${goodsInfo.goodsKndCd ne '1002'}">style="display:none"</c:if>>
	        <h3>3-4. 소프트웨어형 서비스(SaaS) 관련 규격 정보</h3>
	        <table class="tbl_st4 certi">
	        <tbody>
	            <tr>
	            	<th rowspan="2" class="rb">서비스 제공 방식</th>
	            	<th class="requ">사용자용 서비스 제공 방식</th>
	            	<td><input type="text" id="sUserSvcSuplyMthd" name="sUserSvcSuplyMthd" placeholder="예) 웹, 모바일" value="${specInfo.sUserSvcSuplyMthd}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">관리용 서비스 제공 방식</th>
	            	<td><input type="text" id="sManageSvcSuplyMthd" name="sManageSvcSuplyMthd" placeholder="예) 웹, 모바일, REST API" value="${specInfo.sManageSvcSuplyMthd}"></td>
	            </tr>
	            <tr>
	            	<th rowspan="5" class="rb">서비스 보안 관리</th>
	            	<th class="requ">인프라 제공 방식</th>
	            	<td><input type="text" id="sInfrstrctrSuplyMthd" name="sInfrstrctrSuplyMthd" placeholder="예) 자체 데이터센터 운영, 제3의 호스팅 업체 이용" value="${specInfo.sInfrstrctrSuplyMthd}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">보안 정책 </th>
	            	<td><input type="text" id="sScrtyPolicy" name="sScrtyPolicy" placeholder="예) 자체 정책 또는 호스팅 업체 정책 준수" value="${specInfo.sScrtyPolicy}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">데이터 암호화 여부 및 방식</th>
	            	<td><input type="text" id="sDataEncptAtMthd" name="sDataEncptAtMthd" placeholder="예) 128-bit 데이터 암호화 지원" value="${specInfo.sDataEncptAtMthd}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">백업 및 복구 정책</th>
	            	<td><input type="text" id="sBackupRecovryPolicy" name="sBackupRecovryPolicy" placeholder="예) DR 구성 등 관련 정책" value="${specInfo.sBackupRecovryPolicy}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">사용자 인증 및 보안 보호 정책</th>
	            	<td><input type="text" id="sUserCrtfcScrtyPrtcPolicy" name="sUserCrtfcScrtyPrtcPolicy" placeholder="예) 사용자별 보안레벨 분리 및 2-factor 인증 지원" value="${specInfo.sUserCrtfcScrtyPrtcPolicy}"></td>
	            </tr>
	            <tr>
	            	<th rowspan="4" class="rb">다중 플랫폼<br />(cross platform)</th>
	                <th class="requ">다중 플랫폼 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sMultiPltfomSportAt" value="Y" <c:if test="${specInfo.sMultiPltfomSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sMultiPltfomSportAt" value="N" <c:if test="${specInfo.sMultiPltfomSportAt eq 'N' || pecInfo.sMultiPltfomSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr>
	            	<th class="requ">지원 운영체계 목록</th>
	            	<td><input type="text" id="sSportOpersysmList" name="sSportOpersysmList" placeholder="예) Windows, Linux, Mac" value="${specInfo.sSportOpersysmList}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">지원 웹브라우저 목록</th>
	            	<td><input type="text" id="sSportWbsrList" name="sSportWbsrList" placeholder="예) IE, Firefox, Chrome, Safari" value="${specInfo.sSportWbsrList}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">지원 모바일 플랫폼 목록</th>
	            	<td><input type="text" id="sSportMobilePltfomList" name="sSportMobilePltfomList" placeholder="예) iOS, Android, 윈도우 모바일, 바다 등" value="${specInfo.sSportMobilePltfomList}"></td>
	            </tr>
	            <tr>
	            	<th rowspan="4" class="rb">호환성 정보</th>
	                <th class="requ">개방형 표준 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sOpenStdSportAt" value="Y" <c:if test="${specInfo.sOpenStdSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sOpenStdSportAt" value="N" <c:if test="${specInfo.sOpenStdSportAt eq 'N' || specInfo.sOpenStdSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">정부 프레임워크 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sGvrnFrmwrkSportAt" value="Y" <c:if test="${specInfo.sGvrnFrmwrkSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sGvrnFrmwrkSportAt" value="N" <c:if test="${specInfo.sGvrnFrmwrkSportAt eq 'N' || specInfo.sGvrnFrmwrkSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">오픈소스 SW 호환 여부</th>
	                <td>
	                    <label><input type="radio" name="sOpenSourcSwAt" value="Y" <c:if test="${specInfo.sOpenSourcSwAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sOpenSourcSwAt" value="N" <c:if test="${specInfo.sOpenSourcSwAt eq 'N' || specInfo.sOpenSourcSwAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">PaaS-Ta 호환 여부</th>
	                <td>
	                    <label><input type="radio" name="sPaastaAt" value="Y" <c:if test="${specInfo.sPaastaAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sPaastaAt" value="N" <c:if test="${specInfo.sPaastaAt eq 'N' || specInfo.sPaastaAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th rowspan="7" class="rb">개발지원 정보</th>
	                <th class="requ">소스 공개 여부</th>
	                <td>
	                    <label><input type="radio" name="sSourcOthbcAt" value="Y" <c:if test="${specInfo.sSourcOthbcAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sSourcOthbcAt" value="N" <c:if test="${specInfo.sSourcOthbcAt eq 'N' || specInfo.sSourcOthbcAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">외부 API ACCESS 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sApiAccessSportAt" value="Y" <c:if test="${specInfo.sApiAccessSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sApiAccessSportAt" value="N" <c:if test="${specInfo.sApiAccessSportAt eq 'N' || specInfo.sApiAccessSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">DB 마이그레이션 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sDbMigrationSportAt" value="Y" <c:if test="${specInfo.sDbMigrationSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sDbMigrationSportAt" value="N" <c:if test="${specInfo.sDbMigrationSportAt eq 'N' || specInfo.sDbMigrationSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">외부 응용프로그램 통합 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sExtrlApplicationSportAt" value="Y" <c:if test="${specInfo.sExtrlApplicationSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sExtrlApplicationSportAt" value="N" <c:if test="${specInfo.sExtrlApplicationSportAt eq 'N' || specInfo.sExtrlApplicationSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">Sub-tenancy 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="sSubTenancySportAt" value="Y" <c:if test="${specInfo.sSubTenancySportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sSubTenancySportAt" value="N" <c:if test="${specInfo.sSubTenancySportAt eq 'N' || specInfo.sSubTenancySportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">커스터마이징 가능 여부</th>
	                <td>
	                    <label><input type="radio" name="sCstmzngPosblAt" value="Y" <c:if test="${specInfo.sCstmzngPosblAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="sCstmzngPosblAt" value="N" <c:if test="${specInfo.sCstmzngPosblAt eq 'N' || specInfo.sCstmzngPosblAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr><th class="requ">개발지원 조건 및 기타 사항</th><td><input type="text" id="sDevlopSportEtc" name="sDevlopSportEtc" placeholder="예) SSO지원, Flow 관리 지원으로만 한정" value="${specInfo.sDevlopSportEtc}"></td></tr>
	        </tbody>
	        </table>
	        
    	</div>
        
        <div id="goods_type_1001" <c:if test="${goodsInfo.goodsKndCd ne '1001'}">style="display:none"</c:if>>
        <h3>3-4. 플랫폼형 서비스(Paas) 관련 규격 정보</h3>
        	<table class="tbl_st4 certi">
        		<tbody>
        			<tr>
        				<th rowspan="2" class="rb">서비스 제공 방식</th>
        				<th class="requ">Secure 개발</th>
        				<td><input type="text" id="pSecureDevlop" name="pSecureDevlop" placeholder="예) 공급사에서 운영 소스개발 제공" value="${specInfo.pSecureDevlop}"></td>
        			</tr>
        			<tr>
        				<th class="requ">Secure design, coding, testing 및 배포</th>
        				<td><input type="text" id="pSecureDctWdtb" name="pSecureDctWdtb" placeholder="예) 해당없음" value="${specInfo.pSecureDctWdtb}"></td>
        			</tr>
        			<tr>
        				<th rowspan="5" class="rb">아키텍처 계획 수립</th>
        				<th class="requ">지원 언어</th><td><input type="text" id="pSportLang" name="pSportLang" placeholder="예) Java, C#, Python" value="${specInfo.pSportLang}"></td>
        			</tr>
        			<tr>
        				<th class="requ">지원 플랫폼</th><td><input type="text" id="pSportPltfom" name="pSportPltfom" placeholder="예) Spring Framework, .NET, 전자정부 표준프레임워크" value="${specInfo.pSportPltfom}"></td>
        			</tr>
        			<tr>
        				<th class="requ">지원 Container 및 버전</th><td><input type="text" id="pSportContainerVer" name="pSportContainerVer" placeholder="예) J2EE 6, Docker 1.3, .NET 4.6" value="${specInfo.pSportContainerVer}"></td>
        			</tr>
        			<tr>
        				<th class="requ">지원 데이터 저장소</th><td><input type="text" id="pSportDataStorge" name="pSportDataStorge" placeholder="예) MySQL, PPAS 등" value="${specInfo.pSportDataStorge}"></td>
        			</tr>
        			<tr>
        				<th class="requ">Sub-tenancy 지원 여부</th>
        				<td>
        					<label><input type="radio" name="pSubTenancySportAt" value="Y" <c:if test="${specInfo.pSubTenancySportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
        					<label><input type="radio" name="pSubTenancySportAt" value="N" <c:if test="${specInfo.pSubTenancySportAt eq 'N' || specInfo.pSubTenancySportAt eq null}">checked="checked"</c:if>>NO</label>
	                	</td>
	            	</tr>
	            	<tr>
	            		<th rowspan="4" class="rb">다중 플랫폼<br />(cross platform)</th>
	            		<th class="requ">개발자 도구 정보</th><td><input type="text" id="pDvlprUntInfo" name="pDvlprUntInfo" placeholder="예) eclipse plugin, Visual Studio plugin 제공" value="${specInfo.pDvlprUntInfo}"></td>
	            	</tr>
	            	<tr>
	            		<th class="requ">SDK/API 제공 여부</th>
	            		<td>
	                    	<label><input type="radio" name="pSdkApiSuplyAt" value="Y" <c:if test="${specInfo.pSdkApiSuplyAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    	<label><input type="radio" name="pSdkApiSuplyAt" value="N" <c:if test="${specInfo.pSdkApiSuplyAt eq 'N' || specInfo.pSdkApiSuplyAt eq null}">checked="checked"</c:if>>NO</label>
	                    </td>
	            </tr>
	           <tr><th class="requ">테스트 및 디버깅 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="pTestDebugingSportAt" value="Y" <c:if test="${specInfo.pTestDebugingSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="pTestDebugingSportAt" value="N" <c:if test="${specInfo.pTestDebugingSportAt eq 'N' || specInfo.pTestDebugingSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	           <tr><th class="requ">Add-on 서비스 및 마켓플레이스 지원 여부</th>
	                <td>
	                    <label><input type="radio" name="pAddonSvcMarkplaceSportAt" value="Y" <c:if test="${specInfo.pAddonSvcMarkplaceSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="pAddonSvcMarkplaceSportAt" value="N" <c:if test="${specInfo.pAddonSvcMarkplaceSportAt eq 'N' || specInfo.pAddonSvcMarkplaceSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr>
	            	<th rowspan="3" class="rb">배포 및 운영환경</th>
	            	<th class="requ">CI(Continuous Integration) 지원</th>
	            	<td><input type="text" id="pCisportSport" name="pCisportSport" placeholder="예) 빌드 및 CI 환경 제공" value="${specInfo.pCisportSport}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">로깅/모니터링 지원</th><td><input type="text" id="pLogingMntrngSport" name="pLogingMntrngSport" placeholder="예) 통합 모니터링 시스템 제공" value="${specInfo.pLogingMntrngSport}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">Load Balancing 지원</th><td><input type="text" id="pLoadBalancingSport" name="pLoadBalancingSport" placeholder="예) 서비스용 LB 지원" value="${specInfo.pLoadBalancingSport}"></td>
	            </tr>
	        </tbody>
		</table>
	</div>
	<div id="goods_type_1003" <c:if test="${goodsInfo.goodsKndCd ne '1003'}">style="display:none"</c:if>>
	<h3>3-4. 인프라형 서비스(Iaas) 관련 규격 정보</h3>
		<table class="tbl_st4 certi">
			<tbody>
				<tr>
					<th>공개표준지원</th>
					<th class="requ">공개표준 지원 및 문서</th>
					<td><input type="text" id="iOthbcStdSportDoc" name="iOthbcStdSportDoc" placeholder="예) 공개표준 지원 및 문서 없음" value="${specInfo.iOthbcStdSportDoc}"></td>
				</tr>
				<tr>
					<th rowspan="2" class="rb">네트워그와 연결</th>
					<th class="requ">서비스에 직접 연결하는 네트워크</th>
					<td><input type="text" id="iSvcDirectCnncNtwrk" name="iSvcDirectCnncNtwrk" placeholder="예) 인터넷" value="${specInfo.iSvcDirectCnncNtwrk}"></td>
				</tr>
				<tr>
					<th class="requ">가상 네트워크 지원</th><td><input type="text" id="iVirtlNtwrkSport" name="iVirtlNtwrkSport" placeholder="예) VNET 및 VPN 지원" value="${specInfo.iVirtlNtwrkSport}"></td>
				</tr>
				<tr>
					<th rowspan="2" class="rb">접근지원</th>
					<th class="requ">동기화 지원 여부 </th>
	                <td>
	                    <label><input type="radio" name="iSynchrnSportAt" value="Y" <c:if test="${specInfo.iSynchrnSportAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="iSynchrnSportAt" value="N" <c:if test="${specInfo.iSynchrnSportAt eq 'N' || specInfo.iSynchrnSportAt eq null}">checked="checked"</c:if>>NO</label>
	                </td>
	            </tr>
	            <tr>
	            	<th class="requ">지원 장비 목록</th>
	            	<td><input type="text" id="iSportEqpmnList" name="iSportEqpmnList" placeholder="예) 서비스가 지원하거나 최적화된 장비(PC,태블릿,스마트폰 등)의 목록" value="${specInfo.iSportEqpmnList}"></td>
	            </tr>
	            <tr>
	            	<th rowspan="6" class="rb">제공 서비스</th>
	            	<th class="requ">서버/컴퓨터 서비스</th>
	            	<td><input type="text" id="iServerComputerSvc" name="iServerComputerSvc" placeholder="예) Linux/Windows Server, GPU Server 등" value="${specInfo.iServerComputerSvc}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">스토리지 서비스</th><td><input type="text" id="iStrgeSvc" name="iStrgeSvc" placeholder="예) NAS, SSD, CDN" value="${specInfo.iStrgeSvc}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">네트워크 서비스</th><td><input type="text" id="iNtwrkSvc" name="iNtwrkSvc" placeholder="예) Load Balancer 등" value="${specInfo.iNtwrkSvc}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">보안 서비스</th><td><input type="text" id="iScrtySvc" name="iScrtySvc" placeholder="예) Firewall, IPS 등" value="${specInfo.iScrtySvc}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">관리 서비스</th><td><input type="text" id="iManageSvc" name="iManageSvc" placeholder="예) Import/Export, DR, Backup 등" value="${specInfo.iManageSvc}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">기타 서비스</th><td><input type="text" id="iEtcSvc" name="iEtcSvc" placeholder="예) DBMS(MySQL, PPAS, MS-SQL), NoSQL 등" value="${specInfo.iEtcSvc}"></td>
	            </tr>
			</tbody>
		</table>
	</div>
        <div id="goods_type_1004" <c:if test="${goodsInfo.goodsKndCd ne '1004'}">style="display:none"</c:if>>
        
	        <h3>3-1. 컨설팅 서비스 (SCS) 관련 규격 정보</h3>
	        
	        <table class="tbl_st4 certi">
	        <tbody>
	            <tr>
	            	<th  class="requ" colspan="2">전문가 구성</th>
	            	<td><input type="text" id="cSpcltyRealm" name="cSpcltyRealm" placeholder="예) 비즈니스, 솔루션 아키텍처, 품질보증분석가 등" value="${specInfo.cSpcltyRealm}"></td>
	            </tr>
	            <tr>
	            	<th rowspan="2" class="rb">컨설팅 주요내용</th>
	            	<th class="requ">도입전반</th>
	            	<td><input type="text" id="cIndcWhole" name="cIndcWhole" placeholder="예) 조직환경에 맞는 클라우드 서비스 소개, 단계적 적용 방법 가이드 등" value="${specInfo.cIndcWhole}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">Setup &amp; Migration</th>
	            	<td><input type="text" id="cSetupMgr" name="cSetupMgr" placeholder="예) 선택한 서비스를 조직환경에 맞게 세팅" value="${specInfo.cSetupMgr}"></td>
	            </tr>
	            <tr>
	            	<th rowspan="5" class="rb">핵심기술 및 경험</th>
	            	<th class="requ">보유자격</th>
	            	<td><input type="text" id="cHoldQualf" name="cHoldQualf" placeholder="예) MS 클라우드 전무가 자격 등" value="${specInfo.cHoldQualf}"></td>
	            </tr>
	            <tr>
	            	<th class="requ">보유기술</th>
	            	<td><input type="text" id="cHoldTchnlgy" name="cHoldTchnlgy" placeholder="예) OO클라우드 환경 기반의 자바 개발, DB 마이그레이션 등" value="${specInfo.cHoldTchnlgy}"></td>
	            </tr>
	            <tr><th class="requ">컨설팅 가능 인프라</th>
	            	<td>
	            		<op:code id="cInfrstrctr" grpCd="2080" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 가능 인프라" defaultValues="${specInfo.cInfrstrctr}" onclick="fnReadAble(this.value, this.name)"/>
	            		<input type="text" id="cInfrstrctrEtc" name="cInfrstrctrEtc" placeholder="예) VDI" value="${specInfo.cInfrstrctrEtc}" readonly="readonly">
	            	</td>
	            </tr>
	            <tr><th class="requ">컨설팅 가능 플랫폼</th>
	            	<td>
	            		<op:code id="cPltfom" grpCd="2081" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 가능 플랫폼" defaultValues="${specInfo.cPltfom}" onclick="fnReadAble(this.value, this.name)"/>
	            		<input type="text" id="cPltfomEtc" name="cPltfomEtc" value="${specInfo.cPltfomEtc}" readonly="readonly">
	            	</td>
	            </tr>
	            <tr>
	            	<th class="requ">프로젝트 경험</th>
	            	<td><input type="text" id="cPrjctExprnc" name="cPrjctExprnc" placeholder="예) OO은행 클라우드 이전 등" value="${specInfo.cPrjctExprnc}"></td>
	            </tr>
	            <tr><th  class="requ" colspan="2">컨설팅 영역</th>
	            	<td>
	            		<op:code id="cCnslRelm" grpCd="2082" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="프로젝트 경험" defaultValues="${specInfo.cCnslRelm}" onclick="fnReadAble(this.value, this.name)"/>
	            		<input type="text" id="cCnslRelmEtc" name="cCnslRelmEtc" value="${specInfo.cCnslRelmEtc}" readonly="readonly">
	            	</td>
	            </tr>
	            <tr><th  class="requ" colspan="2">컨설팅 범위</th>
	            	<td>
	            		<op:code id="cCnslScope" grpCd="2083" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 범위" defaultValues="${specInfo.cCnslScope}"/>
	            	</td>
	            </tr>
	            <tr><th  class="requ" colspan="2">컨설팅 가능 상세 서비스</th>
	            	<td>
	            	    <!-- 클라우드 서비스 하위 메뉴 /*_userguide.getCtgryList*/ 에서 다중선택할 수있도록 한다. -->
	            		<a onclick="jsCtgryListPop(this);" href="javascript:;" class="btns st3">선택</a>	            		
	            		<input type="hidden" id="cDetailSvc" name="cDetailSvc"  value="${specInfo.cDetailSvc}"/>
	            		<span id="cDetailSvcNm">
	            			<c:forEach var="tstCateMgmt" items="${tstCateMgmt}" varStatus="status">
	            				${tstCateMgmt.indvdlzNm}<c:if test="${status.index lt fn:length(tstCateMgmt)}">,</c:if>
	            			</c:forEach>
	            		</span>
	            	</td>
	            </tr>
	            <tr>
	            	<th  class="requ" colspan="2">컨설팅 수행기간</th>
	            	<td>
	            		<op:code id="cExcPd" grpCd="2084" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 수행기간" defaultValues="${specInfo.cExcPd}"  onclick="fnReadAble(this.value, this.name)"/>
	            		<input type="text"   id="cExcPdEtc" name="cExcPdEtc" value="${specInfo.cExcPdEtc}" readonly="readonly">
	            	</td>
	            </tr>
	            <tr><th  class="requ" colspan="2">컨설팅 수행 가능 지역</th>
	            	<td>
	            	     <op:code id="cExcArea" grpCd="2022" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 수행 가능 지역" defaultValues="${specInfo.cExcArea}"/>
	            	</td>
	            </tr>
	            <tr><th  class="requ" colspan="2">사전 컨설팅 가능 여부</th>
	            	<td>
	            		<label><input type="radio" name="cBeffatCnslAt" value="Y" <c:if test="${specInfo.cBeffatCnslAt eq 'Y'}">checked="checked"</c:if>>YES</label>
	                    <label><input type="radio" name="cBeffatCnslAt" value="N" <c:if test="${specInfo.cBeffatCnslAt eq 'N' || specInfo.cBeffatCnslAt eq null}">checked="checked"</c:if>>NO</label>
	            	</td>
	            </tr>
	            <!-- <tr><th colspan="2">컨설팅 금액</th><td><input type="hidden" id="cCnslPc" name="cCnslPc" value="0" style="width: 100px; ime-mode:disabled; text-align:right;" onchange="getNumber(this);" onkeyup="getNumber(this);"></td></tr> -->
	        </tbody>
	        </table>
        </div>        
    </div>
        
<!--4 단계 시작-->
    <div id="serviceRegist04" class="serviceRegist ${active4}">
        <h3>4-1. 제공자 정보</h3>
        <table class="tbl_st4">
        <tbody>

            <tr>
            	<th class="requ">회사명칭</th>
            	<td><input type="text" id="cmpnyNm" name="cmpnyNm" style="width: 100px; ime-mode:disabled" maxlength="4" value="<c:out value='${specInfo.cmpnyNm}'/>" readonly/> </td>
            </tr>
            <tr>
            	<th class="requ">회사 설립년도</th>
            	<td><input type="text" id="cmpnyFondYear" name="cmpnyFondYear" style="width: 100px; ime-mode:disabled" maxlength="4" placeholder="" value="<c:out value='${specInfo.cmpnyFondYear}'/>"/> 년</td>
            </tr>
            <tr>
                <th class="requ">기업구분</th>
                <td>
                	<!-- 2075 -->
	                <c:forEach items="${entrprsSe}" var="_entrprsSe" varStatus="status">
	                    <label>
	                    	<input type="radio" name="entrprsSe" id="entrprsSe_${_entrprsSe.PRVCD}" value="${_entrprsSe.PRVCD}" style="margin-right: 10px;" <c:if test="${_entrprsSe.PRVCD eq specInfo.entrprsSe}"> checked="checked" </c:if>>
	                    	${_entrprsSe.PRVNM}
	                    </label>    
	                </c:forEach>	                
                </td>
            </tr>
            <tr>
            	<th class="requ">회사 소개</th>
            	<td><input type="text" id="cmpnyIntrcn" name="cmpnyIntrcn" placeholder="" value="<c:out value='${specInfo.cmpnyIntrcn}'/>"/></td>
            </tr>
            <tr>
            	<th class="requ">사업 분야</th>
            	<td><input type="text" id="bsnsRealm" name="bsnsRealm" placeholder="예) 컴퓨팅, 네트워크 서비스 및 Hybrid 클라우드" value="<c:out value='${specInfo.bsnsRealm }'/>"/></td>
            </tr>
            <tr>
                <th class="requ">공급 유형</th>
                <td>
                	<!-- 2055 -->
	                <c:forEach items="${svcEntrprsSuplyTy}" var="_svcEntrprsSuplyTy" varStatus="status">
	                    <label>
	                    	<input type="radio" name="svcEntrprsSuplyTy" id="svcEntrprsSuplyTy_${_svcEntrprsSuplyTy.PRVCD}" value="${_svcEntrprsSuplyTy.PRVCD}" style="margin-right: 10px;" <c:if test="${_svcEntrprsSuplyTy.PRVCD eq specInfo.svcEntrprsSuplyTy}"> checked="checked" </c:if>>
	                    	${_svcEntrprsSuplyTy.PRVNM}
	                    </label>    
	                </c:forEach>
                </td>
            </tr>
        </tbody>
        </table>
        
        <h3>4-2. 서비스 담당자 정보</h3>
        <table class="tbl_st4">
        <tbody>
            <tr>
                <th class="requ">담당자</th>
                <td><input type="text" id="svcChargerNm" name="svcChargerNm" placeholder="" value="<c:out value='${specInfo.svcChargerNm}'/>" class="w650" /></td>
            </tr>
            <tr>
                <th class="requ">담당자 이메일</th>
                <td class="emailSt1">
                <input type="text" id="svcChargerEmail1" name="svcChargerEmail1" placeholder="" value="${fn:split(specInfo.svcChargerEmail,'@')[0]}" class="w194" /><span class="space">@</span>
                <input type="text" id="svcChargerEmail2" name="svcChargerEmail2" placeholder="" value="${fn:split(specInfo.svcChargerEmail,'@')[1]}" class="w194" />
                </td>
            </tr>
            <tr>
                <th class="requ">담당자 연락처</th>
                <td class="tel">
                      <!--  span class="sel_box">
                      <select id="svcChargerCttpc" name="svcChargerCttpc" title="국가 선택" style="width:210px;">
                          <option value="">국가 선택</option>
                          <c:forEach items="${nation}" var="list">
                              <option value="<c:out value='${list.INTRLTELNL}'/>" <c:if test="${specInfo.svcChargerCttpc eq list.INTRLTELNL}">selected="selected"</c:if>}><c:out value="${list.LANGNATIONNM}" />(<c:out value="${list.INTRLTELNL}" />)</option>
                          </c:forEach>
                      </select>
                      </span -->
                      
					<input type="hidden" name="svcChargerCttpc" id="svcChargerCttpc" title="국가" value="82" />  
                      
                    <input type="text" name="svcChargerCttpc1" id="svcChargerCttpc1" title="연락처 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" placeholder="" value="${fn:split(specInfo.svcChargerTelno,'-')[0]}" class="w124" maxlength="4"/> -
                    <input type="text" name="svcChargerCttpc2" id="svcChargerCttpc2" title="연락처 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" placeholder="" value="${fn:split(specInfo.svcChargerTelno,'-')[1]}" class="w124" maxlength="4"/> -
                    <input type="text" name="svcChargerCttpc3" id="svcChargerCttpc3" title="연락처 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" placeholder="" value="${fn:split(specInfo.svcChargerTelno,'-')[2]}" class="w124" maxlength="4"/>
                </td>
            </tr>
            <tr>
                <th class="requ">담당자 휴대폰</th>
                <td class="tel">
                    <input type="text" name="svcChargerMbtlNum1" id="svcChargerMbtlNum1" title="휴대전화번호 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" class="w124" maxlength="3" placeholder="" value="${fn:split(specInfo.svcChargerMbtlNum,'-')[0]}"/> -
                    <input type="text" name="svcChargerMbtlNum2" id="svcChargerMbtlNum2" title="휴대전화번호 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" class="w124" maxlength="4" placeholder="" value="${fn:split(specInfo.svcChargerMbtlNum,'-')[1]}"/> -
                    <input type="text" name="svcChargerMbtlNum3" id="svcChargerMbtlNum3" title="휴대전화번호 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" class="w124" maxlength="4" placeholder="" value="${fn:split(specInfo.svcChargerMbtlNum,'-')[2]}"/>
                </td>
            </tr>
        </tbody>
        </table>
        
        
        
        <h3>4-3. 가격표 및 첨부파일</h3>
        <div style="padding-left: 200px;margin-top: -20px;position: relative;">
        	(※ 첨부파일은 pdf형식만 업로드 가능합니다.)
        </div>
        
        <table class="tbl_st4" style="margin-top: 20px;">
        <tbody>                    
            <tr>
                <th class="requ">가격표(업로드)</th>
                <td>
                    <div class="uploadFile">
                        <input type="text" readonly="readonly" id="pricefileInput1" style="width: 550px;" value="${goodsInfo.priceDnFileNm}"/>
                        <div>
                            <img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('priceFile1','pricefileInput1');"  alt="삭제" />                            
                            <span class="btns st3">
                            	파일선택
                                <input type="file"   name="priceFile1" id="priceFile1" class="priceFile" value="${goodsInfo.priceDnFileNm}" title="파일찾기" onchange="jsFileChk('priceFile1', 'pricefileInput1', 10240, '1', -1, 5);" accept=".pdf"/>
                                <input type="hidden" name="fileDesc"   id="priceFile1Desc" value=""/>
                                <input type="hidden" name="priceDnFileSeq" id="priceDnFileSeq" value="${goodsInfo.priceDnFileSeq}"/>
                                
                            </span>
                            <a href="/component/file/ND_directDownload.do?fp=/resources/download/0606_StandardPrice.hwp&amp;fn=클라우드서비스 가격표 양식.hwp" class="btns st3">서비스가격표</a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr <c:if test="${goodsInfo.goodsKndCd eq '1004'}">style="display:none"</c:if>>
                <th>사용메뉴얼(업로드)</th>
                <td>
                    <div class="uploadFile">
                        <input type="text" id="dnfileInput1" readonly="readonly" title="파일명" class="fileup" value="${goodsInfo.mnlDnFileNm}"/>
                        <div>
                            <img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('dnlFile1','dnfileInput1');" alt="삭제" />                            
                            <span class="btns st3">파일선택
                                <input type="file" name="dnlFile1" id="dnlFile1" class="mnlFile" title="파일찾기" value="${goodsInfo.mnlDnFileNm}" onchange="jsFileChk('dnlFile1', 'dnfileInput1', 10240, '1', -1, 5);" accept=".pdf"/>
                                <input type="hidden" name="fileDesc" id="dnlFile1Desc" value=""/>
                                <input type="hidden" name="mnlDnFileSeq" id="mnlDnFileSeq" value="${goodsInfo.mnlDnFileSeq}"/>
                            </span>
                        </div>
                    </div>    
                   
                </td>
            </tr>
                
			<tr>
                <th>기타 첨부파일(최대 5개)</th>
                <td>
                   	<input type="hidden" name="itemDnFileSeq" id="itemDnFileSeq" value="${goodsInfo.itemDnFileSeq}"/>
                   	
                    <c:forEach var="i" begin="1" end="5" step="1" varStatus="rtstatus">                        
                        <!-- span class="fl ml10">파일명<input type="text" id="" class="ml10" /></span -->
                        <div class="uploadFile">
                            <input type="text"  id="etcfileInput<c:out value='${i}'/>" name="etcfileInput<c:out value='${i}'/>" readonly="readonly" title="파일명" class="fileup" value="${goodsInfo.itemDnFileNm[i-1]}"/>
                            <input type="hidden" id="etcfileOrdrNo<c:out value='${i}'/>" name="etcfileOrdrNo<c:out value='${i}'/>" value="${goodsInfo.itemDnFileOrdrNo[i-1]}"/>
                            <div>
                                <img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('etcFile<c:out value='${i}'/>','etcfileInput<c:out value='${i}'/>');" alt="삭제" />                            
                                <span class="btns st3">
                                    파일선택
                                    <input type="file" name="etcFile<c:out value='${i}'/>" id="etcFile<c:out value='${i}'/>" class="mnlFile" title="파일찾기" onchange="jsFileChk('etcFile<c:out value='${i}'/>', 'etcfileInput<c:out value='${i}'/>', 10240, '1', -1, 5);"  accept=".pdf"/>
                                    <input type="hidden" name="fileDesc" id="etcFile<c:out value='${i}'/>Desc" value=""/>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </td>
            </tr>
        </tbody>
        </table>
        
    
    </div>
    
<!--5 단계 시작-->
    <div id="serviceRegist05" class="serviceRegist ${active5}">
		
		<div class="serviceRegist05_title">서비스 상세화면(미리보기)</div>
		
		<div class="conWrap new_swView" id="wrap_ver2">
		
			<section>
				<div class="pro_title">
								
					<div class="f_l">
                    	
                    	<div class="pro_txt">
                        	<p><img id="vwImgPrev" src="${goodsInfo.goodsImageFileUrl[0]}"></p> <!-- /cloud_ver2/new_cloud/images/bg_uploadImg.png --> 
                            <p><c:out value="${goodsInfo.goodsNm}"/></p>  
                            <p>서비스분류 :                            
	                            <c:set var="conut" value="${fn:length(goodsCateList)}" />                            
	                            <c:forEach var="goodsCateList" items="${goodsCateList}" varStatus="statusIndex">${goodsCateList.ctgryName}<c:if test="${statusIndex.index+1 lt conut }">,</c:if></c:forEach>
                            </p>
                            <p><!-- 인증정보 --> </p>
                        </div>
                        
                    	<p class="pro_price">\ <fmt:formatNumber value="${goodsInfo.svcPc}" type="NUMBER"/></p>
                    	
                    	<div>
							<c:if test="${not empty goodsInfo.itemVodUrl}">
								<a  href="${goodsInfo.itemVodUrl}" target="_blank"  class="btns st1">서비스 체험하기</a>
							</c:if>
							
							<c:if test="${not empty goodsInfo.goodsDwldUrl}">
								<a href="${goodsInfo.goodsDwldUrl}" target="_blank"  class="btns st1">서비스 안내</a>
							</c:if>
							
							<c:if test="${not empty goodsInfo.goodsMonitorUrl}">
								<a href="${goodsInfo.goodsMonitorUrl}" target="_blank"  class="btns st1">모니터링</a>
							</c:if>
							
							<c:if test="${not empty goodsInfo.priceDnFileSeq}">
								<a  href="javascript:;" onclick="jsFileDown('${goodsInfo.priceDnFileId}');"  class="btns st1">서비스가격표</a>								
							</c:if>
							
							<c:if test="${goodsInfo.goodsMnlFileSeq > 0}">
								<a  href="javascript:;" onclick="jsSpec(this);" class="btns st1">서비스규격서</a>
							</c:if>
							
							<c:if test="${goodsInfo.goodsMnlFileSeq < 1}">
								<c:if test="${not empty goodsInfo.mnlFile}">
								   <c:forEach items="${goodsInfo.mnlFile}" var="_mnlFile" varStatus="status">
										<a  href="javascript:;" onclick="jsFileDown('${_mnlFile.fileId}');" title="${_mnlFile.localNm}"  class="btns st1">서비스규격서</a>
								   </c:forEach>
								</c:if> 
							</c:if>
							
						</div>
                    	
                    </div>
                    <div class="f_r">
                    	<table class="normal_table">
                        <caption></caption>
                        <colgroup>
                        	<col width="110px">
                            <col width="192px">
                        </colgroup>
                        <thead>
                        <tr>
                        	<th>제공자 정보</th>
                            <th><a  href="javascript:;" onClick="jsSeller('')" class="goList">다른서비스 보기</a></th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr>
								<td>제공자명</td>
                              	<td><c:out value='${goodsStoreList.LANGSTORENM}'/></td>                             	
                              	
                            </tr>
                            <tr>
                                <td>기업구분</td>
                                <td><c:out value='${specInfo.entrprsSeNm}'/></td>                                
                            </tr>
                            <tr>
                                <td>담당자</td>
                                <td><c:out value='${specInfo.svcChargerNm}'/></td>
                                
                            </tr>
                            <tr>
                                <td>연락처</td>
                                <td><c:out value='${specInfo.svcChargerTelno}'/></td>
                            </tr>
                            <tr>
                                <td>이메일</td>
                                <td><c:out value='${specInfo.svcChargerEmail}'/></td>
                            </tr>
                        </tbody>
                        </table>    
                    </div>					
				</div>
											
			</section>
			
			<section>
				<h3><i>제공자 정보</i></h3>
				<div>
					<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%">
	                    <caption></caption>
	                    <colgroup>
	                        <col width="260px">
	                        <col width="*">
	                    </colgroup>
	                    <tr>
	                        <th>회사 설립년도</th>
	                        <td><c:out value='${specInfo.cmpnyFondYear}'/>년</td>
	                    </tr>
	                    <tr>
	                        <th>회사소개</th>
	                        <td><c:out value='${specInfo.cmpnyIntrcn}'/></td>
	                    </tr>
	                </table>
				</div>
				<h3><i>서비스 개요</i></h3>
				<div>
					<pre  style="line-height:1.5em">${goodsInfo.goodsSumry}</pre>
				</div>
				<h3><i>특장점</i></h3>
				<div>
					${goodsInfo.itemSfe}
				</div>
				<h3><i>대상고객</i></h3>
				<div>
					${goodsInfo.cstmrInfo}
				</div>
				<h3><i>주요기능</i></h3>
				<div>
					${goodsInfo.goodsMainFnct}
				</div>
				<h3><i>주요레퍼런스</i></h3>
				<div>
					${goodsInfo.goodsRefer}
				</div>
				<h3><i>서비스 기대효과</i></h3>
				<div>
					${goodsInfo.goodsExpcEffect}
				</div>
			</section>
			
			<section id="goods_type_1004" <c:if test="${goodsInfo.goodsKndCd ne '1004'}">style="display:none"</c:if>>	
					
				<h3><i>전문가 구성</i></h3>
				<div>${specInfo.cSpcltyRealm}</div>
				
				<h3><i>컨설팅 주요내용</i></h3>
				<div>
					<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%">
	                    <caption></caption>
	                    <colgroup>
	                        <col width="260px">
	                        <col width="*">
	                    </colgroup>
	                    <tr>
	                        <th>도입전반</th>
	                        <td>${specInfo.cIndcWhole}</td>
	                    </tr>
	                    <tr>
	                        <th>Setup &amp; Migration</th>
	                        <td>${specInfo.cSetupMgr}</td>
	                    </tr>
	                    
	                </table>
				</div>
				
				<h3><i>핵심기술 및 경험</i></h3>
				<div>
					<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%">
	                    <caption></caption>
	                    <colgroup>
	                        <col width="260px">
	                        <col width="*">
	                    </colgroup>
	                    <tr>
	                        <th>보유자격</th>
	                        <td>${specInfo.cHoldQualf}</td>
	                    </tr>
	                    <tr>
	                        <th>보유기술</th>
	                        <td>${specInfo.cHoldTchnlgy}</td>
	                    </tr>
	                    <tr>
	                        <th>컨설팅 가능 인프라</th>
	                        <td>${specInfo.cInfrstrctrNm}</td>
	                    </tr>
	                    <tr>
	                        <th>컨설팅 가능 플랫폼</th>
	                        <td>${specInfo.cPltfomNm}</td>
	                    </tr>
	                    <tr>
	                        <th>프로젝트 경험</th>
	                        <td>${specInfo.cPrjctExprnc}</td>
	                    </tr>
	                </table>
				</div>
			
				<h3><i>컨설팅 영역</i></h3>
				<div>${specInfo.cCnslRelmEtc}</div>
				
				<h3><i>컨설팅 범위</i></h3>
				<div>${specInfo.cCnslScope}</div>
				
				<h3><i>컨설팅 기능 상세 서비스</i></h3>
				<div>
					<c:forEach var="tstCateMgmt" items="${tstCateMgmt}" varStatus="status">
           				${tstCateMgmt.indvdlzNm}<c:if test="${status.index lt fn:length(tstCateMgmt)}">,</c:if>
           			</c:forEach>
				</div>
				
				<h3><i>컨설팅 수행기간</i></h3>
				<div>${specInfo.cExcPdNm}</div>
				
				<h3><i>컨설팅 수행가능 지역</i></h3>
				<div>${specInfo.cExcAreaNm}</div>				
	        
			</section>
					
			<section <c:if test="${goodsInfo.goodsKndCd eq '1004'}">style="display:none"</c:if>>
				
				<h3><i>서비스 사양</i></h3>
				<div>
				<table class="normal_table">
	                <caption></caption>
	                <colgroup>
	                	<col width="110px">
	                    <col width="192px">
	                </colgroup>
	                <tbody>
						<tr>
							<th>서비스 관리기준</th>
	                        <td>
	                        	<c:set var="conut" value="0" />
		                        <c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '2030'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:set var="conut" value="${count + 1}" />
				                	</c:if>
			                	</c:forEach>
	                        </td>
	                    </tr>
						<tr>
							<th>인증정보</th>
	                        <td style="padding-top: 10px;padding-bottom: 10px;">
	                        	<table>
	                        	<caption></caption>
						        <colgroup>
						        	<col width="50%">
						            <col width="*">
						        </colgroup>
						        <tbody>
		                        	<c:forEach items="${goodsMark}" var="_goodsMark" varStatus="statusSeq">
							            <tr>
							                <th><c:out value='${_goodsMark.MARKNM}'/></th>
							                <c:choose>
							                <c:when test="${_goodsMark.MARKCD != '1005' and _goodsMark.MARKCD != '1003'}">  <!-- GS인증,나라장터종합쇼핑몰 등록 서비스 외 일반인증 -->                                
							                    <td colspan="3">
							                    <%-- ${_goodsMark.FILENM} --%>
							                    <img alt="" src="${_goodsMark.MARKIMAGEFILEURL}">
							                    </td>
							                    
							                    
							                </c:when>
							                <c:when test="${_goodsMark.MARKCD == '1005'}">  <!-- GS인증 -->
							                    <td colspan="3">${goodsInfo.gsCrtfcNo}</td>
							                </c:when>
							                <c:when test="${_goodsMark.MARKCD == '1003'}">  <!-- 나라장터종합쇼핑몰 등록 서비스(GROUP_CD = 2060) -->
							                    <td colspan="3">${goodsInfo.naraCrtfcNo}</td>
							                </c:when>
							                </c:choose>
							            </tr>  
		                        	</c:forEach>
	                        	</tbody>
	                        	</table>
	                        </td>
	                    </tr>
						<tr>
							<th>구축방식</th>
	                        <td>
	                        	<c:set var="conut" value="0" />
		                        <c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '2032'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
	                        </td>
	                    </tr>
						<tr>
							<th>서비스 유형</th>
	                        <td>serviceOfferMethod</td>
	                    </tr>
						<tr>
							<th>아키텍쳐</th>
	                        <td>
				            	<c:if test="${goodsInfo.archtcSe eq '1'}"> 32-BIT</c:if>
				            	<c:if test="${goodsInfo.archtcSe eq '2'}"> 64-BIT</c:if>
				            	<c:if test="${goodsInfo.archtcSe eq '3'}"> 32-BIT , 64-BIT</c:if>
	                        </td>
	                    </tr>
						<tr>
							<th>지원OS</th>
	                        <td>
	                        	<c:set var="conut" value="0" />
		                        <c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '1020'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:if test="${fn:length(metaSvc.metaEtcCn) gt 0}">(${metaSvc.metaEtcCn})</c:if>
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
	                        </td>
	                    </tr>
						<tr>
							<th>지원언어</th>
	                        <td>
	                        	<c:set var="conut" value="0" />
		                        <c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '1019'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:if test="${fn:length(metaSvc.metaEtcCn) gt 0}">(${metaSvc.metaEtcCn})</c:if>
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
	                        </td>
	                    </tr>
						<tr>
							<th>A/S 방침</th>
	                        <td>
	                        	<c:set var="conut" value="0" />
		                        <c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '1021'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
	                        </td>
	                    </tr>
						<tr>
							<th>호환성</th>
	                        <td>
	                        	<c:set var="conut" value="0" />
		                        <c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '2031'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
	                        </td>
	                    </tr>
						<tr>
							<th>제조사</th>
	                        <td>
	                        	${goodsInfo.goodsMakr}
	                        </td>
	                    </tr>
						<tr>
							<th>출시일</th>
	                        <td>
	                        	${goodsInfo.comouDe}
	                        </td>
	                    </tr>
	                </tbody>
                </table>
                <br />

               
                            
                </div>
				
			</section>			
				<c:if test="${curStep eq 5 && updateYn eq 'update'}">
					<table class="normal_table">
		                <caption></caption>
		                <colgroup>
		                	<col>
		                    <col>
		                </colgroup>
		                <tbody>
							<tr>
								<th style="text-align: center">수정사유</th>
		                    </tr>
							<tr>
		                        <td>
 									<textarea name="chgItemContent" id="chgItemContent" onkeyup="javascript:displayBytes(3000,'chgItemContent');">${goodsInfo.chgItemContent}</textarea>
		                         </td>
		                    </tr>
							<tr>
								<th style="text-align: center">관리자 검토의견</th>
		                    </tr>
							<tr>
		                        <td>
 									<textarea name="cfmItemContent" id=cfmItemContent disabled>${goodsInfo.cfmItemContent}</textarea>
		                         </td>

		                    </tr>
		                </tbody>
	                </table>    
				</c:if> 
		</div>	
    
    </div>
    
    
    
        
    <%--           
    <h3>기본정보 입력</h3>        
                     
    <table class="tbl_st4 basicInput">    
            
            <!-- <tr>
                <th class="requ">무료/체험 구분</th>
                <td><a id="metaExprnBtn" onclick="jsMetaPop(this, 2027, '', '');" href="javascript:;" class="btns st3">선택</a>
                <span id="metaExprnNm"></span>
                         <input name="metaExprns" id="metaExprns" type="hidden" value=""/>
                         </td>
            </tr> -->
            <tr>
                <th class="requ">기업구분</th>
                <td><label><input type="radio" id="smlpzChk" name="smlpzChk" value="Y"  checked /> 중소기업</label>
                <label><input type="radio" id="smlpzChk" name="smlpzChk" value="M"  /> 중견기업</label>
                <label><input type="radio" id="smlpzChk" name="smlpzChk" value="B"  /> 대기업</label>
                </td>
            </tr>
            <tr>
                <th class="requ">단가(￦)</th>
                <td>
                     <input name="goodsPc" id="goodsPc" type="text" title="가격입력" maxlength="50"/></span>
                     <p class="desc">
                        ※ 서비스가격 수준을 효과적으로 알릴 수 있는 기준가격을 입력해 주세요. (예, 10년까지 39,000원/월)<br />
                        ※ 자세한 서비스 요금은 가격표 항목에 첨부파일 형식으로 등록할 수 있습니다.
                    </p>
            </tr>
            <tr>
                <th class="requ">계약단위</th>
                <td><a id="metaCntrctUnitBtn" onclick="jsMetaPop(this, 2028, '', '');" href="javascript:;" class="btns st3">선택</a>
                    <span id="metaCntrctUnitNm"></span>
                    <input name="metaCntrctUnits"   id="metaCntrctUnits"   type="hidden" value=""/>
                    <input name="metaCntrctUnitetc" id="metaCntrctUnitetc" type="hidden" value=""/>
                </td>
            </tr>
            
            
                                          
            <tr>
                <th class="requ">원산지</th>
                <td>
                    <input type="text"  id="orgplce" name="orgplce"/>
                </td>
            </tr>
            
            
            
        </table>
        
        <h3>판매자 정보 입력</h3>
        <table class="tbl_st4">                    
            <tr>
                <th class="requ">회사명</th>
                <td><input type="text" id="langStoreNm" name="langStoreNm" value="<c:out value='${goodsStoreList.LANGSTORENM}'/>" readonly="readonly" id="" class="w650" /></td>
            </tr>
        </tbody>
    </table>
    
    <h3>상세 정보 입력</h3>
    <table class="tbl_st4 detailInput">
        
        <tr>
                <th>태그</th>
                <td class="tags">
                <a id="metaTAGsBtn" onclick="jsMetaPop(this, 1023, '', '');" href="javascript:;"  class="btns st3">태그선택</a>
                <input type="text" id="goodsTags" name="goodsTags" value="태그 직접 입력. 콤마로 구분해 주세요" onclick="if (this.value == '태그 직접 입력. 콤마로 구분해 주세요') value='';" class="w650"/>
                <input name="metaTAGs" id="metaTAGs" type="hidden"/>
                <ul id="metaTAGhtml"></ul>
                <p class="desc">
                        ※ 태그 직접 입력은 콤마로 구분해 주세요.<br /> 
                        ※ 태그선택 또는 직접 입력으로 총 10개의 태그를 입력할 수 있습니다.<br />
                        ※ 등록하신 태그는 통합검색에 적용되기까지 최대 24시간이 소요됩니다.
                    </p>
                </td>
        </tr>
        
        
            </tbody>
    </table>
     --%>            
                            
            
</form>
	    
	    <div class="btnArea rig">    	
	    	
	    	<!-- a href="#"  onclick="jsCancel();" class="f_l btns st2">취소</a -->	        
	        <!-- a href="#" id="nexMove" onclick="if (jsLoading()==true){jsGoodsInsertAction('1001','nextMove');}" class="btns st1 icn_r next">다음</a -->	        
	        
	        <span id="btnPrev"  onclick="jsPrevMov(this)" class="f_l btns st1 icn icnPre" style="display: none; cursor: pointer;">이전</span>	        
	        <span id="tempSave" onclick="if (jsLoading()==true){jsGoodsInsertAction('1001','tempSave', '${curStep}');}" class="btns st1 icn icnSave" style="cursor: pointer;">임시저장</span>
	        <span id="request_authorization" onclick="if (jsLoading()==true){jsGoodsInsertAction('1002','tempSave', '${curStep}');}" class="btns st1 icn icnSave" style="display: none; cursor: pointer;">승인요청</span>
	        <span id="btnNext" onclick="if (jsLoading()==true){jsGoodsInsertAction('1001','nextMove', '${curStep}');}" class="btns st1 icn_r next" style="cursor: pointer;">다음</span>
	    </div>
	                    
    </div>        
    
    <div id="loading-container" class="loading-container">
        <div class="loading"></div>
        <div id="loading-text">loading</div>
	</div>
            
        
</body>
</html>