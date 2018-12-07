
$().ready(function() {
	$("#dataForm").validate();
	$.extend( $.validator.messages, {
		required	: "필수 항목입니다.",
		remote		: "항목을 수정하세요.",
		email		: "유효하지 않은 E-Mail주소입니다.",
		url			: "유효하지 않은 URL입니다.",
		date		: "올바른 날짜를 입력하세요.",
		dateISO		: "올바른 날짜(ISO)를 입력하세요.",
		number		: "유효한 숫자가 아닙니다.",
		digits		: "숫자만 입력 가능합니다.",
		creditcard	: "신용카드 번호가 바르지 않습니다.",
		equalTo		: "같은 값을 다시 입력하세요.",
		extension	: "올바른 확장자가 아닙니다.",
		maxlength	: $.validator.format( "{0}자를 넘을 수 없습니다. " ),
		minlength	: $.validator.format( "{0}자 이상 입력하세요." ),
		rangelength	: $.validator.format( "문자 길이가 {0} 에서 {1} 사이의 값을 입력하세요." ),
		range		: $.validator.format( "{0} 에서 {1} 사이의 값을 입력하세요." ),
		max			: $.validator.format( "{0} 이하의 값을 입력하세요." ),
		min			: $.validator.format( "{0} 이상의 값을 입력하세요." )

	});
	
	$.validator.setDefaults({
	    onkeyup:false,
	    onclick:false,
	    onfocusout:false,
	    showErrors:function(errorMap, errorList){
	        if(this.numberOfInvalids()) {
	            alert(errorList[0].message);
	        }
	    }
	});
/*
	$.validator.addMethod(
		    "extraMethod",
		    function (value, element) {
		        if(value != "") {
		            reutrn true;
		        } else {
		            return false;
		        }
		    },
		    "값이 없습니다."
		);
	*/
/*	
	$("#dataForm").validate(
			{
				rules: {
					goodsNm             : { required : true, maxlength : 100}
			      , goodsNm             : { maxlength: 100}
			      , comouDe             : { formatDate: true}
			      , goodsChargerEmail   : { email: true}
			      , itemVodUrl          : { url : true}
			      , goodsDwldUrl        : { url : true}
			      , goodsHmpgUrl        : { url : true}
			      , goodsMonitorUrl     : { url : true}
			      , goodsSumry          : { maxlength: 3000}
			      , cnstntCo            : { number: true}}
			,messages: {
				
			}
     });
*/
    $("input[id=metaLangs1006]").click(function(){
        if ($(this).attr("checked")) {
            $("#metaLangEtc").removeAttr("readonly");
            $("#metaLangEtc").focus();
        }  else {
            $("#metaLangEtc").val("");
            $("#metaLangEtc").attr("readonly","true");
        }
    });
});

        // 서비스 수정
        var jsGoodsUpdateAction = function(sttus, action, flag, form) {
        	if (sttus != '') {
        		$("#goodsRegistSttus").val(sttus);
        	}

        	if (form == 'dataForm1' || form == 'dataForm4') {
	        	$("input[type=file]").each(function() {
	        		if (this.value == '') {
	        			$("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                    $("#"+this.id).attr("disabled","disabled");
	                }
	            });
        	}

        	if (confirm("데이터를 수정하시겠습니까?")) {
/*
        		$("#dataform1 input[name=svcFlag]").val(flag);
        		$("#dataform1").attr("action", action);
        		$("#dataform1").submit();
*/
            	eval($("#"+form+" input[name=svcFlag]").val(flag));       		
        		eval($("#"+form).attr("action", action));
        		eval($("#"+form).submit());
        	}else{
        		return;
        	}
        };

        // 서비스등록
        var jsGoodsInsertAction = function() {
            if(checkEditor()) {
                $("input[type=file]").each(function() {
                    if (this.value == '') {
                        $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                        $("#"+this.id).attr("disabled","disabled");
                    }
                });

                $("#dataForm").attr("action", "ND_goodsInsertAction.do");
                $("#dataForm").submit();
            }
        };

        var jsRegistBack = function(el, sttus) {
        	var goodsCode = $("#goodsCode").val();
        	var exmntConfmHistSn = $("#exmntConfmHistSn").val();
        	var langCode = $("#langCode").val();

        	switch (sttus) {
            	case 1003 :
                    $(el).colorbox({
                        title : "승인반려",
                        href : "/intra/store/goods/PD_returnReasonPop.do?goodsCode="+goodsCode+"&exmntConfmCd=1003&confmReturnSection=",
                        width : "700",
                        height : "600",
                        overlayClose : false,
                        escKey : false,
                        iframe : true
                    });
                    break;
                case 1005 :
                    $(el).colorbox({
                        title : "승인반려",
                        href : "/intra/store/goods/PD_returnReasonPop.do?goodsCode="+goodsCode+"&exmntConfmCd=1005&confmReturnSection=",
                        width : "700",
                        height : "600",
                        overlayClose : false,
                        escKey : false,
                        iframe : true
                    });
                    break;
                case 1010 :
                    $(el).colorbox({
                        title : "승인반려",
                        href : "/intra/store/goods/PD_returnReasonPop.do?goodsCode="+goodsCode+"&exmntConfmHistSn="+exmntConfmHistSn+"&exmntConfmCd=1010&confmReturnSection=",
                        width : "700",
                        height : "600",
                        overlayClose : false,
                        escKey : false,
                        iframe : true
                    });
                    break;
                case 1004 :
                	if (confirm("검토완료 처리하시 겠습니까?")) {
                		location.href="/intra/store/goods/ND_goodsExmntUpdate.do?goodsCode="+goodsCode+"&exmntConfmCd="+sttus+"&langCode="+langCode+"&exmntConfmHistSn="+exmntConfmHistSn+"&confmReturnSection=";
                	}else{
                		return;
                	}
                    break;

            }

//            if(confirm("해당 서비스를 검토대기 목록으로 이동시키겠습니까?")){
//                $("#dataForm").attr("action", "ND_registUpdateAction.do");
//                $("#dataForm").submit();
//            }
        };

        var jsCtgrySelPop = function(el, pid) {
            if ($("#userId").val() == "") {
                alert("판매자를 먼저 선택해 주십시오.");
                return false;
            }

            /*$(el).colorbox({
                title : "카테고리선택",
                href : "/intra/store/goods/PD_categoryPop.do?PID=" + pid,
                width : "580",
                height : "600",
                overlayClose : false,
                escKey : true,
                iframe : true
            });*/
            
            var goodsTyCd = $(':radio[name="goodsKndCd"]:checked').val().substring(2);
            $(el).colorbox({
                title        : "서비스 카테고리선택",
                href         : "/korean/pt/sale/goods/PD_categoryPop.do?PID=ST" + goodsTyCd,
                width        : "650",
                height       : "750",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
            
        };

        var jsCtgrySel = function() {
            var ctgryCodes = $("#setCtgryCodes").val();
            $('table#goodsCtgry').append('');
            if (ctgryCodes == "") {
                $('table#goodsCtgry tr').remove();
            }
            else {

                ctgryCodes = ctgryCodes.split(",");
                var ctgryCodeUrl = "";
                for (var i = 0; i < ctgryCodes.length; i++) {
                    if (i > 0) {
                        ctgryCodeUrl += "&";
                    }
                    ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
                }
               
                var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
                $.post(url,
                function(response){
                    if(response.length > 0){
                        $('table#goodsCtgry tr').remove();
                        for (var i = 0; i < response.length; i++) {
                            var htmlVal = "";
                            htmlVal = '<tr id="goodsCtgry_' + response[i].ctgryCode + '"><td>[' + response[i].ctgryClNm + ']</td>';
                            htmlVal += '<td>' + response[i].ctgryPath + '</td>';
                            htmlVal += '<td><input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);"></input>';
                            htmlVal += '<input type="hidden" name="ctgryCds" class="getCtgryCodes" value="' + response[i].ctgryCode + '"></input></td></tr>';
                            $('table#goodsCtgry').append(htmlVal);
                        }
                    }
                });
            }
        };

        var jsCategoryDelete = function(el) {
            if ($('input[id^=goodsCtgry_]').length > 1)
            {
                $('tr#' + el.id).remove();
            }
            else
            {
                alert("카테고리는 최소 한개 이상 존재해야합니다.");
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
//             imgCnt += $(".imgFileDiv").length;
//             if (imgCnt > maxCnt) {
//                 alert("최대 파일첨부 개수는 " + maxCnt + "개 입니다.");
//                 var htmlVal = $("div#"+inputId+"Div").html();
//                 $("input[name="+inputId+"]").remove();
//                 $("div#"+inputId+"Div").append(htmlVal);
//                 retrun false;
//             }

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

//                    $("#dataForm").ajaxSubmit({
//                        url      : "ND_uploadFileChk.do",
//                        data     : { inputName : inputId,
//                                     maxFileSize : s, fileExt : fileExt },
//                        type     : "POST",
//                        dataType : "text",
//                        async    : false,
//                        success  : function(response){
//
//                                    if(response == "100") {
//    //                                  alert(Message.msg.processOk);
//                                        //preview(inputId, imageId, parentId, w, h, s, true);
//    //                                     alert(response);
//                                    }else{
//                                        //preview(inputId, imageId, parentId, w, h, s, false);
//                                        //jsErrorBox(response);
//
//                                        alert(response);
//                                        var htmlVal = "";
//                                        htmlVal = $("span#"+inputId+"Div").html();
//                                        $("input[name="+inputId+"]").remove();
//                                        $("span#"+inputId+"Div").append(htmlVal);
//                                  }
//                        }
//                    });
          }
      };

      //서비스이미지 용량,크기,비율 확인(이미지아이디, 최대넓이, 최대높이, 최소넓이, 최소높이, 용량, 확장자, seq, imgType, fileSeq, 파일첨부갯수)
        var jsPreview = function(inputId, w, h, sw, sh, s, fileExt ,seq, imgType, fileSeq, maxCnt) {
//             var source = $("input[name="+inputId+"]").eq(seq).val();

            var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt);

            if (fileCountResult) {
                var source = $("input[name="+inputId+"]").val();

                //확장자 잘라내기
                var lastDot = source.lastIndexOf('.');
                var ext = source.substring(lastDot + 1);

                if(fileExt.indexOf(ext.toLowerCase()) == -1){
                    alert( "지원하지 않는 이미지 형식입니다.\n jpg, gif, png 형식만 가능합니다." );
                    var htmlVal = "";
                    htmlVal = $("span#"+inputId+"Div").html();
                    $("input[name="+inputId+"]").remove();
                    $("span#"+inputId+"Div").append(htmlVal);
                }else{
/*
                    $("#dataForm").ajaxSubmit({
                        url      : "ND_uploadImgChk.do",
                        data     : { inputName : inputId,
                                     maxWidthSize : w, maxHeightSize : h,
                                     minWidthSize : sw, minHeightSize : sh,
                                     maxFileSize : s, fileExt : fileExt, imgType : imgType },
                        type     : "POST",
                        dataType : "text",
                        async    : false,
                        success  : function(response){

                                    if(response == "100") {
    //                                  alert(Message.msg.processOk);
                                        //preview(inputId, imageId, parentId, w, h, s, true);
    //                                     alert(response);
                                    }else{
                                        //preview(inputId, imageId, parentId, w, h, s, false);
                                        //jsErrorBox(response);

                                        alert(response);
                                        var htmlVal = "";
                                        htmlVal = $("span#"+inputId+"Div").html();
                                        $("input[name="+inputId+"]").remove();
                                        $("span#"+inputId+"Div").append(htmlVal);
                                  }
                        }
                    }); */
                }
            }
        };

        var jsChngHistCodeInsert = function(goodsChangeCode){
            var url = "ND_chngHistCodeInsert.do";
//            var goodsCode = $("#goodsCode").val();
            $("#dataForm").ajaxSubmit({
                url      : url,
                data     : { goodsChangeCode: goodsChangeCode },
                type     : "POST",
                dataType : "text",
                async    : false,
                success  : function(response){
                }
            });
        };

      //첨부된 파일중 ajax를 이용하여 파일 삭제
        var jsFileDelete = function(element, seq, id, mkCd, code){
        	
            if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
                return false;

            var url = "ND_fileDelete.do";
            $.post(url,
                { fileId : id, fileSeq : seq, markCd: mkCd, goodsCode: code },
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

        /**
         * 목록
         */
        var jsList = function(action) {
            document.dataForm.action = action;
            document.dataForm.submit();
        };

        var jsCancel = function() {
            if(!confirm("서비스등록을 취소하시겠습니까?"))
                return false;

            self.location.reload();
        };

        var jsSellerList = function(el) {
            $(el).colorbox({
                title : "판매자 목록",
                href : "../goods/PD_sellerListPop.do",
                width : "1000",
                height : "800",
                overlayClose : false,
                escKey : true,
                iframe : true
            });
        };

        var jsDeleteConfirm = function(el) {/*
            if(!confirm("서비스를 정말 삭제하시겠습니까?"))
                return false;

            jsDelete("ND_goodsDeleteAction.do", "dataForm");
            */
            $(el).colorbox({
                title : "정보변경",
                href  : "PD_svcChangeRequstPop.do?goodsRegistSttus=9999",
                width : "500",
                height:  "250",
                iframe: true
            }); 
            
        };

        /**
         * 미리보기
         */
        var jsGoodsPreview = function(ty) {
            if ($("#userId").val() == "") {
                alert("판매자 항목을 먼저 입력하여 주세요.");
                document.getElementById("userIdBtn").focus();
                return false;
            }
            //$("#goodsLicenceNms").val($("#goodsLicenceNm").text());// ??
            $("#metaLangsNm").val($("input[name=metaLangs]:checked").map(function () { return $("#"+this.id+"Nm").text(); }).get().join(", ")); // 지원언어
            $("#metaOSnms").val($("#metaOSnm").text()); // 지원OS
            $("#metaASnms").val($("#metaASnm").text()); // A/S방침
            //$("#metaTECHnms").val($("#metaTECHnm").text()); //??
            
            // 아키텍쳐
            var archtcSe = 0;
            $('input[name="archtcSeArry"]:checked').each(function (i) {
                archtcSe = archtcSe + Number($(this).val());
            });
            $("#archtcSe").val(archtcSe);
            
            // 기타첨부파일
            $("#mnlFilesFileDesc").val($("#mnlFile1Desc").val()+","+$("#mnlFile2Desc").val()+","+$("#mnlFile3Desc").val()+","+$("#mnlFile4Desc").val()+","+$("#mnlFile5Desc").val());

            window.open("/intra/pt/popup/" + ty,"preview","width=1040, height=768, scrollbars=yes");
            var act = document.dataForm.action;
            document.dataForm.target = "preview";
            document.dataForm.action = "/intra/pt/popup/" + ty;
            document.dataForm.submit();
            document.dataForm.action = act;
            document.dataForm.target = "_self";

        };

        // 서비스등록 vaildate
        var checkEditor = function() {
            var ret = true;
            /*************************/
            /** STEP1) 마스터 정보 체크 **/
            /*************************/
            // STEP1-1) 판매자
            if ($("#userId").val() == "") {
                alert("판매자 항목을 먼저 입력하여 주세요.");
                document.getElementById("userIdBtn").focus();
                return false;
            }

            // STEP1-2) 서비스명
            if ($("#goodsNm").val()==null || $("#goodsNm").val().trim()=="") {
                alert("서비스명 항목을 입력하여 주세요.");
                document.getElementById("goodsNm").focus();
                return false;
            }
            
            // STEP1-3) 카테고리
            if($("input[name=ctgryCds]").val() == null || $("input[name=ctgryCds]").val() == ""  ){
                 alert("카테고리를 선택해주세요.");
                 document.getElementById("ctgryBtn").focus();
                 return false;
            }

            // STEP1-4) 대표이미지
            if($("input[name=imageFile1]").val() == null || $("input[name=imageFile1]").val() == ""  ){
                alert("대표이미지를 등록해주세요.");
                document.getElementById("imageFile1").focus();
                return false;
            }
            
            /*************************/
            /** STEP2) 기본 정보 체크 ****/
            /*************************/
            // STEP2-1) 제조사
            if ($("#goodsMakr").length > 0) {
                if ($("#goodsMakr").val()==null || $("#goodsMakr").val().trim()=="") {
                    alert("제조사 항목을 입력하여 주세요.");
                    document.getElementById("goodsMakr").focus();
                    return false;
                }
            }

            // STEP2-2) 출시일
            if ($("#comouDe").length > 0) {
                if ($("#comouDe").val()==null || $("#comouDe").val().trim()=="") {
                    alert("출시일 항목을 입력하여 주세요.");
                    document.getElementById("comouDe").focus();
                    return false;
                }
            }
            // STEP2-3) 단가
            if ($("#goodsPc").length > 0) {
                if ($("#goodsPc").val()==null || $("#goodsPc").val().trim()=="") {
                    alert("단가 항목을 입력하여 주세요.");
                    document.getElementById("goodsPc").focus();
                    return false;
                }
            }            
            
            // STEP2-4) 계약단위
            if ($("#metaCntrctUnits").length > 0) {
                if ($("#metaCntrctUnits").val()==null || $("#metaCntrctUnits").val()=="") {
                    alert("계약단위 항목을 입력하여 주세요.");
                    document.getElementById("metaCntrctUnitBtn").focus();
                    return false;
                }
            }
            
            // STEP2-5) 서비스제공방식
            if ($("input[name=serviceOfferMethod]").length > 0) {
                if ($("input[name=serviceOfferMethod]:checked").length <= 0) {
                    alert("서비스제공방식 항목을 입력하여 주세요.");
                    $("input[name=serviceOfferMethod]").eq(0).focus();
                    return false;
                }
            }
            
            // STEP2-6) 지원언어
            if ($("input[name=metaLangs]").length > 0) {
                if ($("input[name=metaLangs]:checked").length <= 0) {
                    alert("지원언어 항목을 입력하여 주세요.");
                    $("input[name=metaLangs]").eq(0).focus();
                    return false;
                }
            }
            // STEP2-6) 지원언어 - 기타 수기체크 
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
            
            // STEP2-7) 원산지
            if ($("#orgplce").length > 0) {
                if ($("#orgplce").val()==null || $("#orgplce").val().trim()=="") {
                    alert("원산지 항목을 입력하여 주세요.");
                    document.getElementById("orgplce").focus();
                    return false;
                }
            }
            
            // STEP2-8) A/S방침
            if ($("#metaASs").val()==null || $("#metaASs").val()=="") {
                alert("A/S 항목을 입력하여 주세요.");
                document.getElementById("metaASsBtn").focus();
                return false;
            }
            
            // STEP2-9) 지원OS
            if ($("#metaOSs").length > 0) {
                if ($("#metaOSs").val()==null || $("#metaOSs").val()=="") {
                    alert("지원OS 항목을 입력하여 주세요.");
                    document.getElementById("metaOSsBtn").focus();
                    return false;
                }
            }
            
            // STEP2-10) 아키텍처
            if ($("input[name=archtcSeArry]").length > 0) {
                if ($("input[name=archtcSeArry]:checked").length <= 0) {
                    alert("아키텍처 항목을 입력하여 주세요.");
                    $("#archtcSeArry1").focus();
                    return false;
                }
            }
            
            /*************************/
            /** STEP3) 판매자 정보 체크 ***/
            /*************************/
            // STEP3-1) 담당자
            if ($("#goodsChargerNm").val()==null || $("#goodsChargerNm").val().trim()=="") {
                alert("담당자 항목을 입력하여 주세요.");
                document.getElementById("goodsChargerNm").focus();
                return false;
            }
            // STEP3-2) 담당자 이메일
            if ($("#goodsChargerEmail").val()==null || $("#goodsChargerEmail").val().trim()=="") {
                alert("담당자 이메일 항목을 입력하여 주세요.");
                document.getElementById("goodsChargerEmail").focus();
                return false;
            }
            // STEP3-3) 담당자 전화번호
            if ($("#goodsChargerCttpc").val()==null || $("#goodsChargerCttpc").val().trim()=="") {
                alert("담당자 전화번호 항목을 입력하여 주세요.");
                document.getElementById("goodsChargerCttpc").focus();
                return false;
            }
            
            /*************************/
            /** STEP4) 상세 정보 체크 ****/
            /*************************/
            // STEP4-1) 서비스개요
            if ($("#goodsSumry").val()==null || $("#goodsSumry").val().trim()=="") {
                alert("서비스개요 항목을 입력하여 주세요.");
                document.getElementById("goodsSumry").focus();
                return false;
            }
            
            // STEP4-2) 태그
            var metaTagCnt=0;
            var goodsTagCnt=0;
            var metaTAGs = $("#metaTAGs").val().split(",");
            var goodsTagsTmp = $("#goodsTags").val().split(",");
            var metaTAGsNm = $("#metaTAGhtml").text().replace(/ X/gi, ",");
                 metaTAGsNm = metaTAGsNm.substr(0, metaTAGsNm.length -1);
                 metaTAGsNm = metaTAGsNm.split(",");
                 
            if ($("#metaTAGs").val()==null || $("#metaTAGs").val()=="") {
                metaTagCnt=0;
            } else {
                metaTagCnt=metaTAGs.length;
            }
            goodsTagCnt = goodsTagsTmp.length;

            var j=0;
            var goodsTags = Array();
            for(var i=0; i < goodsTagCnt; i++){
                if (goodsTagsTmp[i]!=null && goodsTagsTmp[i].trim()!="") {
                goodsTags[j] = goodsTagsTmp[i];
                j++;
                }
            }
            goodsTagCnt=goodsTags.length;
            
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
                
                if ((metaTagCnt + goodsTagCnt) > 10) {
                    alert("태그 항목은 최대 10개까지 입력 가능합니다.");
                    document.getElementById("metaTAGsBtn").focus();
                    return false;
                }
            }

            /*************************/
            /** STEP5) 에디터영역 체크 ****/
            /*************************/
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

            /***************************/
            /** STEP6) 가격표이미지 체크 ****/
            /***************************/
            if($("input[name=priceFile1]").val() == null || $("input[name=priceFile1]").val() == ""  ){
                alert("가격표를 등록해주세요.");
                document.getElementById("priceFile1").focus();
                return false;
            }
            
            /***************************/
            /** STEP7) 서비스규격서 이미지 체크 ****/
            /***************************/
           /* if($("input[name=mnlFile1]").val() == null || $("input[name=mnlFile1]").val() == ""  ){
                alert("서비스규격서를 등록해주세요.");
                document.getElementById("mnlFile1").focus();
                return false;
            }
*/
            // vaildate 체크 실패시 false 반환
            if (!ret) {
                return false;
            }

            // vaildate 체크 성공시 true 반환
            return true;
        };

        
        
        // 서비스수정 vaildate
        var checkEditor2 = function() {
            var ret = true;
            /*************************/
            /** STEP1) 마스터 정보 체크 **/
            /*************************/
            // STEP1-1) 판매자
            if ($("#userId").val() == "") {
                alert("판매자 항목을 먼저 입력하여 주세요.");
                document.getElementById("userIdBtn").focus();
                return false;
            }

            // STEP1-2) 서비스명
            if ($("#goodsNm").val()==null || $("#goodsNm").val().trim()=="") {
                alert("서비스명 항목을 입력하여 주세요.");
                document.getElementById("goodsNm").focus();
                return false;
            }
            
            // STEP1-3) 카테고리
            if($("input[name=ctgryCds]").val() == null || $("input[name=ctgryCds]").val() == ""  ){
                 alert("카테고리를 선택해주세요.");
                 document.getElementById("ctgryBtn").focus();
                 return false;
            }
            
            /*************************/
            /** STEP2) 기본 정보 체크 ****/
            /*************************/
            // STEP2-1) 제조사
            if ($("#goodsMakr").length > 0) {
                if ($("#goodsMakr").val()==null || $("#goodsMakr").val().trim()=="") {
                    alert("제조사 항목을 입력하여 주세요.");
                    document.getElementById("goodsMakr").focus();
                    return false;
                }
            }

            // STEP2-2) 출시일
            if ($("#comouDe").length > 0) {
                if ($("#comouDe").val()==null || $("#comouDe").val().trim()=="") {
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
            
            // STEP2-3) 단가
            if ($("#goodsPc").length > 0) {
                if ($("#goodsPc").val()==null || $("#goodsPc").val().trim()=="") {
                    alert("단가 항목을 입력하여 주세요.");
                    document.getElementById("goodsPc").focus();
                    return false;
                }
            }            
            
            // STEP2-4) 계약단위
            if ($("#metaCntrctUnits").length > 0) {
                if ($("#metaCntrctUnits").val()==null || $("#metaCntrctUnits").val()=="") {
                    alert("계약단위 항목을 입력하여 주세요.");
                    document.getElementById("metaCntrctUnitBtn").focus();
                    return false;
                }
            }
            
            // STEP2-5) 서비스제공방식
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
            
            // STEP2-6) 지원언어
            if ($("input[name=metaLangs]").length > 0) {
                if ($("input[name=metaLangs]:checked").length <= 0) {
                    alert("지원언어 항목을 입력하여 주세요.");
                    $("input[name=metaLangs]").eq(0).focus();
                    return false;
                }
            }
            // STEP2-6) 지원언어 - 기타 수기체크 
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
            
            // STEP2-7) 원산지
            if ($("#orgplce").length > 0) {
                if ($("#orgplce").val()==null || $("#orgplce").val().trim()=="") {
                    alert("원산지 항목을 입력하여 주세요.");
                    document.getElementById("orgplce").focus();
                    return false;
                }
            }
            
            // STEP2-8) A/S방침
            if ($("#metaASs").val()==null || $("#metaASs").val()=="") {
                alert("A/S 항목을 입력하여 주세요.");
                document.getElementById("metaASsBtn").focus();
                return false;
            }
            
            // STEP2-9) 지원OS
            if ($("#metaOSs").length > 0) {
                if ($("#metaOSs").val()==null || $("#metaOSs").val()=="") {
                    alert("지원OS 항목을 입력하여 주세요.");
                    document.getElementById("metaOSsBtn").focus();
                    return false;
                }
            }
            
            // STEP2-10) 아키텍처
            if ($("input[name=archtcSeArry]").length > 0) {
                if ($("input[name=archtcSeArry]:checked").length <= 0) {
                    alert("아키텍처 항목을 입력하여 주세요.");
                    $("#archtcSeArry1").focus();
                    return false;
                }
            }
            
            /*************************/
            /** STEP3) 판매자 정보 체크 ***/
            /*************************/
            // STEP3-1) 담당자
            if ($("#goodsChargerNm").val()==null || $("#goodsChargerNm").val().trim()=="") {
                alert("담당자 항목을 입력하여 주세요.");
                document.getElementById("goodsChargerNm").focus();
                return false;
            }
            // STEP3-2) 담당자 이메일
            if ($("#goodsChargerEmail").val()==null || $("#goodsChargerEmail").val().trim()=="") {
                alert("담당자 이메일 항목을 입력하여 주세요.");
                document.getElementById("goodsChargerEmail").focus();
                return false;
            }
            // STEP3-3) 담당자 전화번호
            if ($("#goodsChargerCttpc").val()==null || $("#goodsChargerCttpc").val().trim()=="") {
                alert("담당자 전화번호 항목을 입력하여 주세요.");
                document.getElementById("goodsChargerCttpc").focus();
                return false;
            }
            
            /*************************/
            /** STEP4) 상세 정보 체크 ****/
            /*************************/
            // STEP4-1) 서비스개요
            if ($("#goodsSumry").val()==null || $("#goodsSumry").val().trim()=="") {
                alert("서비스개요 항목을 입력하여 주세요.");
                document.getElementById("goodsSumry").focus();
                return false;
            }
            
            // STEP4-2) 태그
            var metaTagCnt=0;
            var goodsTagCnt=0;
            var metaTAGs = $("#metaTAGs").val().split(",");
            var goodsTagsTmp = $("#goodsTags").val().split(",");
            var metaTAGsNm = $("#metaTAGhtml").children("li").text().replace(/ X/gi, ","); // Detail 화면에서는 li 값을 가져옴
                 metaTAGsNm = metaTAGsNm.substr(0, metaTAGsNm.length -1);
                 metaTAGsNm = metaTAGsNm.split(",");
            
            if ($("#metaTAGs").val()==null || $("#metaTAGs").val()=="") {
                metaTagCnt=0;
            } else {
                metaTagCnt=metaTAGs.length;
            }
            goodsTagCnt = goodsTagsTmp.length;
            
            var j=0;
            var goodsTags = Array();
            for(var i=0; i < goodsTagCnt; i++){
                if (goodsTagsTmp[i]!=null && goodsTagsTmp[i].trim()!="") {
                goodsTags[j] = goodsTagsTmp[i];
                j++;
                }
            }
            goodsTagCnt=goodsTags.length;
            
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
                
                if ((metaTagCnt + goodsTagCnt) > 10) {
                    alert("태그 항목은 최대 10개까지 입력 가능합니다.");
                    document.getElementById("metaTAGsBtn").focus();
                    return false;
                }
            }
            
            /*************************/
            /** STEP5) 에디터영역 체크 ****/
            /*************************/
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

            /***************************/
            /** STEP6) 가격표이미지 체크 ****/
            /***************************/
            if($("input[name=priceFile1]").val() == null || $("input[name=priceFile1]").val() == ""  ){
                alert("가격표를 등록해주세요.");
                document.getElementById("priceFile1").focus();
                return false;
            }
            
            /***************************/
            /** STEP7) 서비스규격서 이미지 체크 ****/
            /***************************/
            /*if($("input[name=mnlFile1]").val() == null || $("input[name=mnlFile1]").val() == ""  ){
                alert("서비스규격서를 등록해주세요.");
                document.getElementById("mnlFile1").focus();
                return false;
            }*/

            // vaildate 체크 실패시 false 반환
            if (!ret) {
                return false;
            }

            // vaildate 체크 성공시 true 반환
            return true;
        };

        var jsMetaPop = function(el, codeGroupCd, cdStart, cdEnd) {
            if ($("#userId").val() == "") {
                alert("판매자를 먼저 선택해 주십시오.");
                return false;
            }
            var codeLangCode = $("input[name=langCode]").val();
            $(el).colorbox({
                title : "선택",
                href : "/korean/pt/popup/PD_metaPop.do?codeLangCode=" + codeLangCode + "&codeGroupCd=" + codeGroupCd + "&cdStart=" + cdStart + "&cdEnd=" + cdEnd,
                width : "780",
                height : "600",
                overlayClose : false,
                escKey : true,
                iframe : true
            });
        };

        var jsMetaTagDelete = function(el) {
            if(confirm(el.text.substr(0, el.text.length - 2) + " 태그를 삭제하시겠습니까?")){
                $(el).parent().remove();
                var tempTag = $("#metaTAGs").val();
                tempTag = tempTag.replace(el.id.substr(7) + ",","");
                tempTag = tempTag.replace(","+el.id.substr(7),"");
                tempTag = tempTag.replace(el.id.substr(7),"");
                $("#metaTAGs").val(tempTag);
            }
        };

        var jsInputFileReset = function(fileId) {

            var control = $("#" + fileId);
            control.replaceWith( control = control.clone( true ) );
        };
//        var jsMetaTagDelete = function(el) {
//            if(confirm(el.value.substr(0, el.value.length - 2) + " 태그를 삭제하시겠습니까?")){
//                el.remove();
//            }
//        };

        var jsHistoryPop = function(el, goodsCode){
            $(el).colorbox({
        //        title : "주요한 서비스정보 변경 이력",
        //        href : "PD_goodsChngHist.do?goodsCode="+goodsCode,
                title : "서비스정보 변경신청 이력",
                href : "PD_goodsChngHist.do?goodsCode="+goodsCode,
                width : "850",
                height : "550",
                iframe : true
            });
        };

        var jsRegHistoryPop = function(el, goodsCode){
            $(el).colorbox({
        //        title : "주요한 서비스정보 변경 이력",
        //        href : "PD_goodsChngHist.do?goodsCode="+goodsCode,
                title : "서비스정보 변경신청 이력",
                href : "PD_goodsChngRegHist.do?goodsCode="+goodsCode,
                width : "850",
                height : "550",
                iframe : true
            });
        };    

        var jsSpecHistoryPop = function(el, goodsCode){
            $(el).colorbox({
                title : "주요한 서비스정보 변경 이력",
                href : "PD_goodsSpecHist.do?goodsCode="+goodsCode,
                width : "850",
                height : "550",
                iframe : true
            });
        };
        
        //사용 안함
        //기술카테고리
        var jsTechCtgryChk = function() {
            var ctgryCds = new Array();
            $("input[name=ctgryCds]").each(function(i) {
                    ctgryCds[i] = $(this).val();
            });

            var langCode = $("#langCode").val();
            var techCtgry = "";
            switch (langCode) {
                case '00' :
                    techCtgry = "6202_45";
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
                              if(response=="true") {
                                  tech = true;
                              } else {
                                  alert("기술 카테고리에서 반드시 1개의 카테고리를 선택하셔야 합니다.");
                                  tech =  false;
                            }
                  }
              });
            return tech;
        };
        
