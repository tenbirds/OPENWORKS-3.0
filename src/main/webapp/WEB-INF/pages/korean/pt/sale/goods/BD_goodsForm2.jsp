<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>서비스등록페이지</title>
<op:jsTag type="openworks" items="form, validate, ckeditor" />
<op:jsTag type="spi" items="form, validate, colorbox" />
<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
<script type="text/javascript">
    $(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");});});
</script>
<script type="text/javascript">
	$("#exttbl").hide();
    $().ready(function(){
        //jsNationChange('00');
        if($("#langCode").val() == '00'){
            $("#nation").hide();
        }else{
            $("#nation").show();
        }

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
               /* ,goodsChargerMbtlnum1 : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
               ,goodsChargerMbtlnum2 : { required : function () {return $("#insertSection").val() == 1002;}, number : true}
               ,goodsChargerMbtlnum3 : { required : function () {return $("#insertSection").val() == 1002;}, number : true} */
               ,goodsChargerNm       : { required : function () {return $("#insertSection").val() == 1002;}}
               ,goodsChargerEmail1   : { required : function () {return $("#insertSection").val() == 1002;}}
               ,goodsChargerEmail2   : { required : function () {return $("#insertSection").val() == 1002;}}
               ,goodsVerInfo         : { required : function () {return $("#insertSection").val() == 1002;}}
               ,goodsSumry           : { required : function () {return $("#insertSection").val() == 1002;}}
             //,goodsSumry           : { required : true}
                ,itemVodUrl         : { url : true}
               ,goodsDwldUrl         : { url : true}
               /* ,demoExprnUrl         : { url : true} */
               ,goodsHmpgUrl         : { url : true}
               ,goodsMonitorUrl       : { url : true}
               ,langStoreNm          : { required : function () {return $("#insertSection").val() == 1002;}} // 회사명
               ,goodsPc              : { required : function () {return $("#insertSection").val() == 1002;}} // 단가
            }
           ,invalidHandler: function(event, validator){
                $("#loading-container").hide();
            }
        });

        displayBytes(3000,'goodsSumry');

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
    });
    
 	// 서비스구분선택 변경시
 	var strCtgryCurrentVal = "1002";
    var jsCtgryList = function(vl){
 	    var ctgrysVal = $("#setCtgryCodes").val();
    	if($.trim(ctgrysVal) != "") {
	    	if(confirm("서비스구분 변경 시 연결된 카테고리가 초기화됩니다.\n변경하시겠습니까?")){
	    	    strCtgryCurrentVal = vl;
	    	    $("#setCtgryCodes").val('');
	    	    $('#goods').html('');
	    	}else{
	    	    $('input:radio[name="goodsKndCd"]:input[value='+strCtgryCurrentVal+']').attr("checked", true);
	    	}
    	} else {
    	    strCtgryCurrentVal = vl;
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
    var jsGoodsInsertAction = function(sttus, mode) {
        $("#tempSave").removeAttr('onclick');
        $("#nextMove").removeAttr('onclick');

        //임시저장(1001),등록신청(1002)        
        $("#goodsRegistSttus").val(sttus);
        $("#insertSection").val(sttus);
        $("#mode").val(mode);
     
       // if(sttus == 1001){      //임시저장(1001)
       if(mode == "tempSave")  {  
            if(checkEditor2()){
                //$("input[type=file][value!='']").trigger("onchange");
                if(confirm("임시저장 하시겠습니까? 임시 저장한 서비스는 승인대기서비스 목록에서 확인할 수 있습니다.")){
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });                    
                    $("#dataForm").attr("action", "ND_goodsInsertAction.do");
                    $("#dataForm").submit();
                    
                }else{
                    $("#loading-container").hide();
                }
            }else{
                $("#loading-container").hide();
            }
        
        }else if(mode == "nextMove") { 
            //if(checkEditor()){
                //$("input[type=file][value!='']").trigger("onchange");
                //if(confirm("등록 신청시 관리자가 검토, 승인이 완료되기 전까지 해당 서비스를 수정할 수 없습니다.\n등록 신청을 하시겠습니까?")){
                //if(confirm("서비스규격서로 이동  하시겠습니까? 임시 저장한 서비스는 승인대기서비스 목록에서 확인할 수 있습니다.")){  
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });
                    //$("#dataForm").attr("action", "ND_goodsInsertAction.do");
                    //$("#dataForm").submit();
                    
                    document.dataForm.action = "ND_goodsInsertAction.do";
                    document.dataForm.submit();
                    /*
                }else{
                    $("#loading-container").hide();
                }
            }else{
                $("#loading-container").hide();
            }*/
        }

        $("#tempSave").attr("onclick", "if (jsLoading()==true){jsGoodsInsertAction('1001','tempSave');};");
        $("#nextMove").attr("onclick", "if (jsLoading()==true){jsGoodsInsertAction('1001', 'nextMove');};");
    };

    var jsCtgrySelPop = function(el){
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
                        htmlVal += response[i].ctgryClNm ;
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

    var checkEditor = function(){
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

            /* //담당자 휴대전화번호 셋팅
            if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum1").val()))){
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
            
            /* if((metaTagCnt + goodsTagCnt) == 0){
                alert("태그 항목을 입력하여 주세요.");
                document.getElementById("metaTAGsBtn").focus();
                return false;
            } */
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
          /*   
            //서비스규격서
            if($("input[name=mnlFile1]").val() == null || $("input[name=mnlFile1]").val() == ""  ){
                alert("서비스규격서를 등록해주세요.");
                document.getElementById("mnlFileBtn").focus();
                return false;
            } */

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
                        $("#imgPrev"+index+" .thumbimg").append(html);
                    }
                };
                reader.readAsDataURL(input.files[0]);
            }else{
                $("img#img"+index).remove();
                var html ='';
                html += "<img src=\"" + "\"   alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" id=\"img"+index+"\"/>";
                $("#imgPrev"+index+" .thumbimg").append(html);
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

    //파일종류
    var jsFileChk = function(inputId, inputIdFake, s, fileExt, fileSeq, maxCnt){
        document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
        
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
            title 		: "",
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

    var jsInputFileReset = function(fileId, textId){
        $("#" + textId).val("");
        var control = $("#" + fileId);
        control.replaceWith( control = control.clone( true ) );
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
</script>
</head>
<body>
<div class="supAdm view register">
<img src="/cloud_ver2/new_cloud/images/srvRgst_step_1.png" alt="서비스 상세정보 입력" />
	<h3>서비스 상세정보 입력</h3>
	
	<ul>
		<li>본 서비스의 정상적인 사용을 위하여 IE10 버전 이상을 사용하십시오.</li>
		<li>서비스구분선택, 서비스명 입력, 카테고리 선택, 서비스 대표 이미지만 입력하시면 임시저장이 가능합니다.<br />
			임시저장은 입력 작업 진행중에 계속 하실 수 있습니다.</li>
		<li>서비스 등록신청을 위해서는 필수항목(<em>*</em>)을 모두 입력하셔야합니다.</li>
		<li>첨부하는 파일은 개인정보와 관련하여 필터링 검사가 이루어집니다.</li>
		<li>가격표 및 첨부파일은 모든 정보의 임시저장 이후 첨부하십시오.</li>
	</ul>
	<table class="tbl_st4">
		<tr>
			<th>클라우드서비스 가격표 양식</th>
			<td><a href="/component/file/ND_directDownload.do?fp=/resources/download/0606_StandardPrice.hwp&fn=클라우드서비스 가격표 양식.hwp" class="btns st3">다운로드</a></td>
		</tr>
	</table>	
	
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <input type="hidden" name="goodsRegistSttus" value="" id="goodsRegistSttus"/>
    <input type="hidden" name="goodsChargerEmail" value="" id="goodsChargerEmail"/>
    <input type="hidden" name="goodsChargerCttpc" value="" id="goodsChargerCttpc"/>
    <input type="hidden" name="goodsChargerMbtlnum" value="" id="goodsChargerMbtlnum"/>
    <input type="hidden" name="langCode" id="langCode" value="00"/>
    <input type="hidden" name="insertSection" id="insertSection" value=""/>	
    <input type="hidden" name="mode" id="mode" value=""/>				
	<dl>
		<dt>서비스 구분선택 [<em>필수</em>]</dt>
		<dd>
			<op:code id="goodsKndCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="1002" type="radio" defaultLabel="구분" onclick="jsCtgryList(this.value)" />			
		</dd>
	</dl>
	<dl>
		<dt>서비스명 입력 [<em>필수</em>]</dt>
		<dd><input name="goodsNm" id="goodsNm" type="text" value="<c:out value='${dataVo.goodsNm}'/>" class="w445" onKeyup="javascript:displayBytes(70,'goodsNm');"/>
		<p class="desc">※ 70Byte 까지 입력이 가능합니다.(<span id="goodsNm_bytes">0</span>/70 Byte)</p>
		</dd>
	</dl>

	<dl>
		<dt>카테고리 선택 [<em>필수</em>]</dt>
		<dd><a href="#" onclick="jsCtgrySelPop(this);" id="jsCtgrySelPop" class="btns st3">카테고리 선택</a>
		<input type="hidden" id="setCtgryCodes" name="setCtgryCodes" value=""/></dd>
	</dl>

	<dl>
		<dt>연결된 카테고리</dt>		
                 <dd class="relaCate" id="goods">
                     <c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
                         <span class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
                             <c:out value='${_goodsCtgry.CTGRYCLNM }'/> <c:out value='${_goodsCtgry.CTGRYPATH}'/>
                                 <!-- <button onclick="" title="3depth category Name 삭제">
                                     <span><img src="/resources/web/theme/default/images/btn/btn_reg_close.gif" alt="삭제"></span>
                                 </button> -->
                         </span>
                     </c:forEach>
                 </dd> 
	</dl>
	<dl>
			<dt>
				서비스 대표 이미지 [<em>필수</em>]
				<i>※ 이미지는 10MB미만, 318px x 278px의 JPG, GIF파일만 등록가능합니다. 사이즈가 다를 경우 승인되지 않습니다.</i>
			</dt>
			<dd class="thumb" >
				<span id="imgPrev1">
					<a href="#" class="del" onclick="jsFileRemove('1'); return false;">삭제</a>
					<!-- <img src="/cloud_ver2/new_cloud/images/temp/thumb_10.png" alt="대표이미지" id="imgPrev1"/> -->
					<p class="thumbimg"></p>
					<a href="#">등록</a>
					 <p class=" req" id="fileSet1"  style="opacity:0; overflow:hidden; position:absolute; top:110px; right:50px;width:50px;">
                                <input type="file" name="imageFile1" id="imageFile1" onchange="jsPreview('imageFile1', 0, 0, 400, 300, 1024, 'jpg,gif,png',1,'Img', -1, 5,this);"/>
                                <input type="hidden" name="fileDesc" id="imageFile1Desc" value=""/>
                           </p>
                      </span> <span id="imgPrev0" style="display:none;" ></span>
                  </dd>    
	</dl>
	<dl>
			<dt>
				사용화면 이미지 등록
				<i>※ 이미지는 10MB미만, 318px x 278px의 JPG, GIF파일만 등록가능합니다. 사이즈가 다를 경우 승인되지 않습니다.</i>
			</dt>
			<dd class="thumb" >	
				<c:if test="${empty dataVo.imageFile}">
                           <c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
                           <span id="imgPrev${status.index}">
                              	    <a href="#" class="del" onclick="jsFileRemove('${i}'); return false;">삭제</a>
                               	<p class="thumbimg"></p>
                              			<a href="#">등록</a>
                               	<p  id="fileSet${status.index}"  style="opacity:0; overflow:hidden; position:absolute; top:110px; right:50px;width:50px;">
                                         	<input type="file" name="imageFile${i}" id="imageFile${i}" class="imageFile" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 1024, 'jpg,gif,png',${i},'Img', -1, 5,this);"/>
                                         	<input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""/>
                                    		</p>
                           </span>
                    		</c:forEach>
                     		<input type="hidden" name="image" value="${image}" />
                       </c:if>
			</dd>
		</dl>	
		<dl>
			<dt>
				체험판
				<b>※ 이용자가 다운로드 또는 온라인 체험을 받을 수 있는 서비스인 경우 관련 URL 주소를 입력해 주세요.</b>
			</dt>
			<dd><input type="text" name="itemVodUrl" id="itemVodUrl" value="${dataVo.itemVodUrl}"  /></dd>
		</dl>
		<dl>
			<dt>
				서비스 안내
				<b>※ 이용자가 다운로드 또는 온라인에서 확인 할 수 있는 서비스 안내 URL 주소를 입력해 주세요.</b>
			</dt>
			<dd><input type="text" name="goodsDwldUrl" id="goodsDwldUrl" value="<c:out value='${dataVo.goodsDwldUrl}'/>" /></dd>
		</dl>	
		<dl>
			<dt>
				모니터링 URL
				<b>※ 모티터링URL 시비스 상태를 확인할 수 있는 모니터링 URL을 입력해 주세요.</b>
			</dt>
			<dd><input type="text" id="goodsMonitorUrl" name="goodsMonitorUrl" value="${dataVo.goodsMonitorUrl}" id="goodsMonitorUrl" /></dd>
		</dl>
		<h3>인증정보</h3>				
		<p>
			※ 인증서가 있는 경우 증빙자료 첨부(단, 표준프레임워크호환 서비스 등록은 "표준프레임워크 호환레벨 확인서" 첨부시에만 가능)<br />
			※ 조달청 나라장터 등록서비스의 경우 종합쇼핑몰 제품상세정보 캡처화면 첨부
		</p>
		
		<table class="tbl_st4 certi">
                    <c:forEach items="${goodsMark}" var="_goodsMark" varStatus="statusSeq">
                     <tr>
					<th><c:out value='${_goodsMark.MARKNM}'/></th>
					<c:choose>
					<c:when test="${_goodsMark.MARKCD != '1005'}">                            	
                        	<td>
                            	<label>
                                <input type="hidden" name="markCds" id="markCds" value="<c:out value='${_goodsMark.MARKCD}'/>"/>
                                <input type="checkbox" name="goodsMarkCds" value="<c:out value='${_goodsMark.MARKCD}'/>" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/> 
                           		</label>
					</td>
					<th>증빙 자료 업로드</th>
					<td>
                           <div class="uploadFile">
							<input type="text" id="markCrtfcInput${statusSeq.index}" readonly="readonly" title="파일명" />
							<div>
								<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" alt="삭제" onclick="jsInputFileReset('markCrtfcFile${statusSeq.index}','markCrtfcInput${statusSeq.index}');"/>							
				            	<span class="btns st3" id="markCrtfcFile${statusSeq.index}Span" >
				            		파일선택
				            		<input  type="file" name="markCrtfcFile${statusSeq.index}" id="markCrtfcFile${statusSeq.index}" class="markCrtfcFile${statusSeq.index}" onchange="jsFileChk('markCrtfcFile${statusSeq.index}', 'markCrtfcInput${statusSeq.index}', 10240, '1', -1, 1); "/>
				            	</span>
				            	 <input type="hidden" name="fileDesc" id="markCrtfcFile${statusSeq.index}Desc" value=""/>
                                		 <input type="hidden" name="crtfcSeFileSeqs" value=""/>
			            	</div>
			            </div>	
					</c:when>
					<c:when test="${_goodsMark.MARKCD == '1005'}">
					<td colspan="3">
						<input type="text" id="cntrctNo" name="cntrctNo"/>
						<p class="desc">※ 계약번호는 “-(하이픈)”을 제거하고 입력해주세요.</p> </td>
					</c:when>
					</c:choose>
      	    </tr>  
           		</c:forEach>
              </table>
              
             <h3>기본정보 입력</h3>				
	   <table class="tbl_st4 basicInput">	
			<tr>
				<th class="requ">제조사</th>
				<td><input name="goodsMakr" id="goodsMakr" type="text" value="<c:out value='${dataVo.goodsMakr}'/>" class="w650" id="" /></td>
			</tr>
			<tr>
				<th class="requ">출시일</span></th>
				<td>
					<input name="comouDe" id="comouDe" type="text" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="<c:out value='${dataVo.comouDe}'/>" maxlength="8" class="w650" id="" />
					<p class="desc">※ 입력 예시 :20140501</p>
				</td>
			</tr>
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
				<th class="requ">서비스 유형</th>
                   <td>
                   	 <op:code id="serviceOfferMethod" grpCd="2034" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="1001" type="radio" defaultLabel="구분"  />
				</td>
			</tr>
			<tr>
				<th class="requ">서비스 관리</th>
				<td><a id="metaSvcBtn" onclick="jsMetaPop(this, 2030, '', '');" href="javascript:;" class="btns st3">선택</a>
					<span id="metaSvcNm"></span>
                    <input name="metaSvcs" id="metaSvcs" type="hidden" value=""/>
                </td>
			</tr>
			<tr>
				<th class="requ">구축방식</th>
				<td><a id="metaCnstcMthdBtn" onclick="jsMetaPop(this, 2032, '', '');" href="javascript:;" class="btns st3">선택</a>
					<span id="metaCnstcMthdNm"></span>
                    <input name="metaCnstcMthds" id="metaCnstcMthds" type="hidden" value=""/>
                </td>
			</tr>
			<tr>
				<th>호환성(표준)</th>
				<td><a id="metaStdBtn" onclick="jsMetaPop(this, 2031, '', '');" href="javascript:;" class="btns st3">선택</a>
					<span id="metaStdNm"></span>
                	<input name="metaStds" id="metaStds" type="hidden" value=""/>
                </td>
			</tr>
			<tr>
                <th class="requ">지원언어</th>
                <td class="lang">
                    <c:forEach items="${goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
	                    <label><input name="metaLangs" id="metaLangs${_goodsMetaLang.metaLangCd}" type="checkbox" value="${_goodsMetaLang.metaLangCd}"
	                                  <c:if test="${(not status.first) and (not status.last)}"> </c:if>
	                                  <c:if test="${status.first}"> checked="checked"</c:if>/> 
	                              ${_goodsMetaLang.metaLangNm} 
	                    </lablel> 
	                    <span id="metaLangs${_goodsMetaLang.metaLangCd}Nm"></span>
	                    <c:if test="${status.last}">
	                    	<input name="metaLangEtc" id="metaLangEtc" type="text" title="지원언어 입력" style="width: 250px;" value="" readonly="readonly" />
	                    </c:if>
                    </c:forEach>
                	<input name="metaLangsNm" id="metaLangsNm" type="hidden" value=""/>                          
            	</td>
            </tr>			                  
			<tr>
				<th class="requ">원산지</th>
				<td>
					<input type="text"  id="orgplce" name="orgplce"/>
				</td>
			</tr>
			<tr>
				<th class="requ">A/S방침</th>
				<td><a id="metaASsBtn" onclick="jsMetaPop(this, 1021, '1000', '1999');" href="javascript:;"  class="btns st3">선택</a>
				<span id="metaASnm"></span>
                         <input name="metaASs" id="metaASs" type="hidden" value=""/>
                         <input name="metaASetc" id="metaASetc" type="hidden" value=""/>
                         <input name="metaASnms" id="metaASnms" type="hidden" value=""/>
                         </td>
			</tr>
			<tr>
				<th class="requ">지원OS</th>
				<td><a id="metaOSsBtn" onclick="jsMetaPop(this, 1020, '', '');" href="javascript:;"  class="btns st3">선택</a>
				<span id="metaOSnm"></span>
				<input name="metaOSs" id="metaOSs" type="hidden" value=""/>
                   <input name="metaOSetc" id="metaOSetc" type="hidden" value=""/>
                   <input name="metaOSnms" id="metaOSnms" type="hidden" value=""/>
				</td>
			</tr>
			<tr>
				<th class="requ">아키텍쳐</th>
				<td>
				<input type="hidden" id="archtcSe" name="archtcSe"/>
				<label><input  type="checkbox" id="archtcSe1" name="archtcSe1" value="1"/> 32-BIT</label><label><input type="checkbox" id="archtcSe2" name="archtcSe1" class="space_ml" value="2"/> 64-BIT</label></td>
			</tr>
		</table>
		
		<h3>판매자 정보 입력</h3>
		<table class="tbl_st4">					
			<tr>
				<th class="requ">회사명</th>
				<td><input type="text" id="langStoreNm" name="langStoreNm" value="<c:out value='${goodsStoreList.LANGSTORENM}'/>" readonly="readonly" id="" class="w650" /></td>
			</tr>
			<tr>
				<th class="requ">담당자</th>
				<td><input type="text" id="goodsChargerNm" name="goodsChargerNm" value="<c:out value='${goodsStoreList.STORECHARGERNM}'/>" class="w650" /></td>
			</tr>
			<tr>
				<th class="requ">담당자 이메일</th>
				<td class="emailSt1">
				<input type="text" id="goodsChargerEmail1" name="goodsChargerEmail1" value="${fn:split(goodsStoreList.REPRSNTEMAIL,'@')[0]}" class="w194" /><span class="space">@</span>
				<input type="text" id="goodsChargerEmail2" name="goodsChargerEmail2" value="${fn:split(goodsStoreList.REPRSNTEMAIL,'@')[1]}" class="w194" />
				</td>
			</tr>
			<tr>
                      <th class="requ">담당자 연락처</th>
                      <td class="tel">
                      	  <span class="sel_box">
                            <select id="goodsChargerCttpc0" name="goodsChargerCttpc0" title="국가 선택" style="width:210px;">
                                <option value="">국가 선택</option>
                                <c:forEach items="${nation}" var="list">
                                    <option value="<c:out value='${list.INTRLTELNL}'/>" ${sessionScope['__usk'].nationCode == list.NATIONCODE ? 'selected' : ''}><c:out value="${list.LANGNATIONNM}" />(<c:out value="${list.INTRLTELNL}" />)</option>
                                </c:forEach>
                            </select>
                            </span>
                          <input type="text" name="goodsChargerCttpc1" id="goodsChargerCttpc1" title="연락처 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(goodsStoreList.REPRSNTTELNO,'-')[0]}" class="w124" maxlength="4"/> -
                          <input type="text" name="goodsChargerCttpc2" id="goodsChargerCttpc2" title="연락처 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(goodsStoreList.REPRSNTTELNO,'-')[1]}" class="w124" maxlength="4"/> -
                          <input type="text" name="goodsChargerCttpc3" id="goodsChargerCttpc3" title="연락처 입력" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(goodsStoreList.REPRSNTTELNO,'-')[2]}" class="w124" maxlength="4"/>
                      </td>
                  </tr>
                  <tr>
                      <th class="requ">담당자 휴대폰</th>
                      <td class="tel">
                          <input type="text" name="goodsChargerMbtlnum1" id="goodsChargerMbtlnum1" title="휴대전화번호 입력" value="" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" class="w124" maxlength="3"/> -
                          <input type="text" name="goodsChargerMbtlnum2" id="goodsChargerMbtlnum2" title="휴대전화번호 입력" value="" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" class="w124" maxlength="4"/> -
                          <input type="text" name="goodsChargerMbtlnum3" id="goodsChargerMbtlnum3" title="휴대전화번호 입력" value="" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  class="w124" maxlength="4"/>
                      </td>
                  </tr>
		</tbody>
	</table>
	<h3>상세 정보 입력</h3>
	<table class="tbl_st4 detailInput">
		<tr>
			<th class="requ">서비스개요</th>
			<td><textarea name="goodsSumry" id="goodsSumry" onkeyup="javascript:displayBytes(3000,'goodsSumry');" class="h167"></textarea>
			<p class="ar mt5">
				<span class="byte"><span id="goodsSumry_bytes" class="txt-point">0</span><span class="caption">/ 3,000 Byte</span></span>
			</p>
			</td>
		</tr>
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
		<tr>
			<th class="requ">특장점</th>
			<td>
				<textarea name="itemSfe" id="itemSfe" rows="15" style="width: 743px" title="내용을 입력해주세요"></textarea>
                      <script type="text/javascript">
                      //<![CDATA[
                          CKEDITOR.replace('itemSfe', {
                              height               : 200,
                              htmlEncodeOutput     : false,
                              enterMode            : "2",
                              skin                 : "moono",
                              toolbar              : [[ 'BulletedList' ]],
                              filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                              on					 : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsNm").focus();}}
                          });
                      //]]>
                      </script>
						
			</td>
		</tr>
		<tr>
			<th class="requ">대상고객</th>
			<td>
				<textarea name="goodsRefer" id="goodsRefer" rows="15" style="width: 743px" title="내용을 입력해주세요"></textarea>
                      <script type="text/javascript">
                      //<![CDATA[
                          CKEDITOR.replace('goodsRefer', {
                              height               : 200,
                              htmlEncodeOutput     : false,
                              enterMode            : "2",
                              skin                 : "moono",
                              toolbar              : [[ 'BulletedList' ]],
                              filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                              on					 : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsNm").focus();}}
                          });
                      //]]>
                      </script>
			</td>
		</tr>	
		<tr>
			<th class="requ">주요기능</th>
			<td>
					 <textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" style="width: 743px" title="내용을 입력해주세요"></textarea>
                       <script type="text/javascript">
                       //<![CDATA[
                           CKEDITOR.replace('goodsMainFnct', {
                               height               : 200,
                               htmlEncodeOutput     : false,
                               enterMode            : "2",
                               skin                 : "moono",
                               toolbar              : [[ 'BulletedList' ]],
                               filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                               on					 : {instanceReady:function(){this.execCommand( 'bulletedlist' ); $("#goodsNm").focus();}}
                           });
                           
                       //]]>
                       </script>
			</td>
		</tr>
		<tr>
			<th class="requ">가격표(업로드)</th>
			<td>
				<div class="uploadFile">
					<input type="text" readonly="readonly" id="pricefileInput1" />
					<div>
						<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('priceFile1','pricefileInput1');"  alt="삭제" />							
		            	<span class="btns st3">
		            		파일선택
		            		<input type="file"  name="priceFile1" id="priceFile1" class="priceFile" title="파일찾기" onchange="jsFileChk('priceFile1', 'pricefileInput1', 10240, '1', -1, 5);"/>
		            		<input type="hidden" name="fileDesc" id="priceFile1Desc" value=""/>
		            	</span>
	            	</div>
	            </div>
			</td>
		</tr>
	<!-- 	<tr>
				<th class="requ">서비스규격서(업로드)</th>
				<td>
					<span class="point">서비스규격서</span>
				
						span class="fl ml10">파일명<input type="text" id="" class="ml10" /></span
						<div class="fr">
							<strong class="dis-block fl mt10 mr10">파일 업로드</strong>
							<div class="file-area fr">
								file upload
								<input type="text" id="mnfileInput1" readonly="readonly" title="파일명" class="fileup">
								<span class="file_del"><img onclick="jsInputFileReset('mnlFile1','mnfileInput1');" src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제"></span>
								<div class="fake_input">
									<a id="mnlFileBtn" href="#" class="b-btn type1"><strong><span>파일선택</span></strong></a>
									<span id="mnlFile1Span">
										<input type="file" name="mnlFile1" id="mnlFile1" class="mnlFile" title="파일찾기" onchange="jsFileChk('mnlFile1', 'mnfileInput1', 10240, '1', -1, 5);">
										<input type="hidden" name="fileDesc" id="mnlFile1Desc" value=""/>
									</span>
								</div>
								//file upload
							</div>
						</div>
					
				</td>
			</tr> -->
			<tr>
				<th>사용메뉴얼(업로드)</th>
				<td>
					<div class="uploadFile">
						<input type="text" id="dnfileInput1" readonly="readonly" title="파일명" class="fileup">
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('dnlFile1','dnfileInput1');" alt="삭제" />							
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="dnlFile1" id="dnlFile1" class="mnlFile" title="파일찾기" onchange="jsFileChk('dnlFile1', 'dnfileInput1', 10240, '1', -1, 5);">
								<input type="hidden" name="fileDesc" id="dnlFile1Desc" value=""/>
			            	</span>
		            	</div>
		            </div>	
		           
					</td>
				</tr>
				<tr>
				<th>기타 첨부파일(최대 5개)</th>
					<td>
						<c:forEach var="i" begin="1" end="5" step="1" varStatus="rtstatus">
						<!-- span class="fl ml10">파일명<input type="text" id="" class="ml10" /></span -->
						<div class="uploadFile">
							<input type="text"  id="etcfileInput<c:out value='${i}'/>" name="etcfileInput<c:out value='${i}'/>" readonly="readonly" title="파일명" class="fileup">
							<div>
								<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('etcFile<c:out value='${i}'/>','etcfileInput<c:out value='${i}'/>');" alt="삭제" />							
				            	<span class="btns st3">
				            		파일선택
				            		<input type="file" name="etcFile<c:out value='${i}'/>" id="etcFile<c:out value='${i}'/>" class="mnlFile" title="파일찾기" onchange="jsFileChk('etcFile<c:out value='${i}'/>', 'etcfileInput<c:out value='${i}'/>', 10240, '1', -1, 5);">
									<input type="hidden" name="fileDesc" id="etcFile<c:out value='${i}'/>Desc" value=""/>
				            	</span>
			            	</div>
		            	</div>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>			
							
			
</form>							
			<div class="btnArea rig">
					<a href="#"  onclick="jsCancel();" class="f_l btns st2">취소</a>
					<a href="#" id="tempSave" onclick="if (jsLoading()==true){jsGoodsInsertAction('1001','tempSave');}" class="btns st1 icn icnSave">임시저장</a>
					<a href="#" id="nexMove" onclick="if (jsLoading()==true){jsGoodsInsertAction('1001','nextMove');}" class="btns st1 icn_r next">다음</a>
				</div>				
			</div>		
	
	 <div id="loading-container" class="loading-container">
        <div class="loading"></div>
        <div id="loading-text">loading</div>
    </div>
			
		
</body>
</html>