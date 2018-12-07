<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>IT전문가서비스 수정페이지</title>
	<op:jsTag type="spi" items=" form, validate, colorbox" />
	<op:jsTag type="openworks" items="form, validate, ckeditor" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
  <script type="text/javascript">
    $(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");});});
  </script>
<script type="text/javascript">
$().ready(function() {

    jsNationChange("${dataVo.langCode}");

    $("#dataForm").validate({
        rules: {
            goodsNm             : { required : true, maxlength: 100}
           ,spcltyRealm         : { required : function () {return $("#insertSection").val() == 1002;}}
           ,cnstntCo            : { required : function () {return $("#insertSection").val() == 1002;}, number: true}
           ,goodsChargerNm      : { required : function () {return $("#insertSection").val() == 1002;}}
           ,goodsChargerEmail   : { required : function () {return $("#insertSection").val() == 1002;}}
           ,goodsChargerCttpc   : { required : function () {return $("#insertSection").val() == 1002;}}
           ,goodsChargerMbtlnum : { required : function () {return $("#insertSection").val() == 1002;}}
           ,goodsSumry          : { required : true, maxlength: 3000}
           ,goodsPc             : { number : true}
           ,goodsHmpgUrl        : { url : true}
       }
        ,messages: {
	        goodsPc : { number: "숫자만 입력해주세요(ex:2000)"}
	    }
        ,invalidHandler: function(event, validator) {
            $("#loading-container").hide();
        }
//         ,submitHandler : function(form) {
//            alert(CKEDITOR.instances.goodsMainFnct.getData());
//             if(CKEDITOR.instances.goodsMainFnct.getData() == '')
//              {
//                  alert("서비스내용을 입력해주세요.");
//                  $("#goodsMainFnct").focus();
//                  return false;

//              }
//              else
//              {
//                  $("#goodsMainFnct").val(CKEDITOR.instances.packageCont.getData());
//              }
//              form.submit();
//              $("#dataForm").submit();

//             $("#dataForm").attr("action", "ND_goodsUpdateAction.do");
//             $("#dataForm").submit();

//              $(form).ajaxSubmit({
//                 url      : "ND_goodsUpdateAction.do",
//                 type     : "POST",
//                 dataType : "text",
//                 success  : function(response) {
//                      if (response) {
//                          jsSuccessBox(response);
////                                  self.location.href = "";
//                      }else{
//                          jsErrorBox(response);
//                      }
//                 }
//              });
//           }
     });

    displayBytes(3000,'goodsSumry');
});

var jsNationChange = function(langCode){
    if(langCode == '00'){//한국어
        $("#nation").hide();
    }else if(langCode == '01' || langCode == '06'){//영어,스페인
        $("#nation").show();
    }
};


var jsLoading = function(){
  $("#loading-container").show();
  return true;
};

var jsGoodsUpdateAction = function(sttus) {

    $("#tempSave").removeAttr('onclick');
    $("#regReq").removeAttr('onclick');
    //임시저장(1001),등록신청(1002)
      $("#insertSection").val(sttus);
      $("#goodsRegistSttus").val(sttus);

      if(sttus == 1001){  //임시저장(1001)
          if(checkEditor2()){
//               $("input[type=file][value!='']").trigger("onchange");
              if (confirm("임시저장 하시겠습니까? 임시 저장한 서비스는 서비스등록 대기 목록에서 확인할 수 있습니다.")) {
	              $("input[type=file]").each(function() {
	                  if (this.value == '') {
	                      $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                      $("#"+this.id).attr("disabled","disabled");
	                  }
	              });
	              $("#dataForm").attr("action", "ND_goodsUpdateAction.do");
	              $("#dataForm").submit();
              }else{
                  $("#loading-container").hide();
              }
          }else{
              $("#loading-container").hide();
          }
      }else{  //등록신청(1002)
          if(checkEditor()){
//               $("input[type=file][value!='']").trigger("onchange");
              if (confirm("등록 신청시 관리자가 검토, 승인이 완료되기 전까지 해당 서비스를 수정할 수 없습니다.\n등록 신청을 하시겠습니까?")) {
	              $("input[type=file]").each(function() {
	                  if (this.value == '') {
	                      $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                      $("#"+this.id).attr("disabled","disabled");
	                  }
	              });
	              $("#dataForm").attr("action", "ND_goodsUpdateAction.do");
	              $("#dataForm").submit();
              }else{
                  $("#loading-container").hide();
              }
          }else{
              $("#loading-container").hide();
          }
      }
      $("#tempSave").attr("onclick", "if (jsLoading()==true){jsGoodsUpdateAction('1001');};");
      $("#regReq").attr("onclick", "if (jsLoading()==true){jsGoodsUpdateAction('1002');};");
  };

var jsCtgrySelPop = function(el) {

    $(el).colorbox({
        title : "카테고리선택",
        href : "/korean/pt/sale/goods/PD_categoryPop.do?PID=ST02",
        width : "450",
        height : "700",
        overlayClose : false,
        escKey : true,
        iframe : true
    });
};

var jsCtgrySel = function() {

    var ctgryCodes = $("#setCtgryCodes").val();
    if (ctgryCodes == "") {
        $('li#goodsCtgry').remove();
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

        /* var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
        $.post(url,
        function(response){
            if(response.length > 0){
                var htmlVal = "";
                $('li#goodsCtgry').remove();
                    htmlVal = '<li id="goodsCtgry">';

                for (var i = 0; i < response.length; i++) {
                    htmlVal += '<ul  id="goodsCtgry_' + response[i].ctgryCode + '">';
                    htmlVal += '<li class="cate01"><span class="tit">'+response[i].ctgryClNm+'</span></li>';
                    htmlVal += '<li class="cate02"><span>'+response[i].ctgryPath+'</span></li>';
                    htmlVal += '<li>';
                    htmlVal += '<button onclick="jsCategoryDelete(this); return false;" id="goodsCtgry_' + response[i].ctgryCode + '" title="'+response[i].ctgryPath+'삭제">';
                    htmlVal += '<input type="hidden" name="ctgryCds" class="getCtgryCodes" value="' + response[i].ctgryCode + '"/>';
                    htmlVal += '<span><img src="/resources/web/theme/default/images/btn/btn_reg_close.gif" alt="삭제"></span>';
                    htmlVal += '</li>';
                    htmlVal += '</ul>';

                }
                    htmlVal += '</li>';
                    $('#goods').append(htmlVal);

            }
        }); */
        
        /* {{ BH, 2015.12.16 서비스등록 디자인 변경으로 인한 소스수정 */
        var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
        $.post(url, function(response){
            if(response.length > 0){
                var htmlVal = "";
                $('li#goodsCtgry').remove();
                htmlVal = '<li id="goodsCtgry">';

                for(var i = 0; i < response.length; i++) {
                    htmlVal += '<ul id="goodsCtgry_' + response[i].ctgryCode + '">';
                    htmlVal += '<li class="cate02"><p class="caption mt10"><strong>·    '+ response[i].ctgryClNm + '</strong>';
                    htmlVal += '<strong>' + response[i].ctgryPath + '</strong>';
                    htmlVal += '<button onclick="jsCategoryDelete(this); return false;" id="goodsCtgry_' + response[i].ctgryCode + '" title="' + response[i].ctgryPath + '삭제">';
                    htmlVal += '<input type="hidden" name="ctgryCds" class="getCtgryCodes" value="' + response[i].ctgryCode + '"/>';
                    htmlVal += '<span><img src="/resources/web/theme/default/images/btn/btn_reg_close.gif" alt="삭제"></span></p>';
                    htmlVal += '</li>';
                    htmlVal += '</ul>';
                }

                htmlVal += '</li>';
                $('#goods').append(htmlVal);
            }
        });
        /* }} */
    }
};

//카테고리삭제
var jsCategoryDelete = function(el) {
    if ($('button[id^=goodsCtgry_]').length > 1)
    {
        $('ul#' + el.id).remove();
        $("input[name=ctgryCds]").each(function(i) {
            if($("input[name=ctgryCds]").eq(i).val() == el.id.substr(11)){
                $("input[name=ctgryCds]").eq(i).remove();
            }
        });
    }
    else
    {
        alert("카테고리는 최소 한개 이상 존재해야합니다.");
    }
};

var jsFileRemove = function(seq) {
    imgAppend(seq);
};

/* var imgAppend = function(seq) {
    //파일 엑스버튼누르명(이미지)
    $("li#imgPrev"+seq).remove();

    var htmlVal = "";
    htmlVal += '<li id="imgPrev'+seq+'" >';
    htmlVal += '<button onclick="jsFileRemove('+seq+'); return false;" class="img_del" style="z-index : 10000;">';
    htmlVal += '<span><em>제거</em></span>';
    htmlVal += '</button>';
    htmlVal += '<span class="button btn_light_gray02"  style="margin-left: 47px;"><span class="btn_file">등록</span></span>';
    htmlVal += '<p class="fake_input req" id="fileSet'+seq+'" > ';
    htmlVal += "<input type=\"file\" name=\"imageFile"+seq+"\" id=\"imageFile"+seq+"\" onchange=\"jsPreview('imageFile"+seq+"', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',"+seq+",'Img',-1,5,this);\"/>";
    htmlVal += '<input type="hidden" name="fileDesc" id="imageFile'+seq+'Desc" value=""/>';
    htmlVal += '</p>';
    htmlVal += '</li>';

    var seq = seq-1;
    if(seq == 0 ){seq = 2;  $("li#imgPrev"+seq).before(htmlVal);
    }else{ $("li#imgPrev"+seq).after(htmlVal); }
}; */

var imgAppend = function(seq){
    //파일 X 버튼 클릭(이미지)
    var htmlVal = "";
    htmlVal += '<li id="imgPrev' + seq + '" >';
    htmlVal += '<div><p class="thumb"></p>';
    htmlVal += '<p class="ac"><a href="#" class="s-btn type5"><strong><span>등록</span></strong></a></p>';
    htmlVal += '<a href="#" onclick="jsFileRemove(\''+seq +'\'); return false;"><img src="/new_cloud/images/icon-btn/btn-close.png" alt="" /></a>';
    htmlVal += '<p class="fake_input req" id="fileSet' + seq + '"  style="overflow: hidden; position: absolute; top: 110px; right: 40px;">';
    htmlVal += "<input type=\"file\" name=\"imageFile" + seq + "\" id=\"imageFile" + seq + "\" onchange=\"jsPreview('imageFile" + seq + "', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png'," + seq + ",'Img',-1,5,this);\"/>";
    htmlVal += '<input type="hidden" name="fileDesc" id="imageFile' + seq + 'Desc" value=""/>';
    htmlVal += '</p>';
    htmlVal += '</div>';
    htmlVal += '</li>';
    
    $("li#imgPrev"+seq).remove();
    
    var seq = seq - 1;
    //alert(seq);
    if(seq == 0){
        seq = 2; $("li#imgPrev"+seq).before(htmlVal);
    }else if(seq == 5){
        seq = 7; $("li#imgPrev"+seq).before(htmlVal);
    }else{
        $("li#imgPrev"+seq).after(htmlVal);
    }
};


var checkEditor2 = function() {

    //카테고리
    var count = 0;
    $("input[name = ctgryCds]").each(function(i) {
        count++;
    });
    if(count < 1){
        alert(Message.msg.chkGoods04);
         $("#jsCtgrySelPop").focus();
         return false;
    }
     var eachSection = 'N';
    if(eachSection == 'N'){

         //담당자 이메일 셋팅
         if($.trim($("#goodsChargerEmail1").val()) != "" ){
            if($.trim($("#goodsChargerEmail1").val()) == null || $.trim($("#goodsChargerEmail1").val()) == "") {
                 alert('이메일을 입력해주세요.');
                 $("#goodsChargerEmail1").focus();
                 return false;
             }

            var email = $.trim($('#goodsChargerEmail1').val())+"@"+$.trim($('#goodsChargerEmail2').val());
            if( !fnb_isEmailOK(email) ){
                alert("정확한 이메일을 입력해주세요.");
                $("#goodsChargerEmail2").focus();
                return false;
            }
            $("#goodsChargerEmail").val(email);
        }

          //담당자 연락처 셋팅
        if($.trim($("#goodsChargerCttpc1").val()) != "" || $.trim($("#goodsChargerCttpc2").val()) != "" || $.trim($("#goodsChargerCttpc3").val()) != "" ){

             var langCode = $(':radio[name="langCode"]:checked').val();

             if("${dataVo.langCode}" != '00' && $("#goodsChargerCttpc0 option:selected").val() == "") {
                 alert('국가를 선택해주세요.');
                 $("#goodsChargerCttpc0").focus();
                 return false;
             }else if("${dataVo.langCode}" != '00') {
                 $("#goodsChargerCttpc0 option:selected").val($("#goodsChargerCttpc0 option:selected").val() + "-");
             }else if("${dataVo.langCode}" == '00'){
                 $("#goodsChargerCttpc0 option:selected").val("");
             }

            if(!fnb_isNumeric($.trim($("#goodsChargerCttpc1").val()))) {
                 alert('정확한 연락처를 입력해주세요.');
                 $("#goodsChargerCttpc1").focus();
                 return false;
             }
            if(!fnb_isNumeric($.trim($("#goodsChargerCttpc2").val()))) {
                 alert('정확한 연락처를 입력해주세요.');
                 $("#goodsChargerCttpc2").focus();
                 return false;
             }

            if(!fnb_isNumeric($.trim($("#goodsChargerCttpc3").val()))) {
                 alert('정확한 연락처를 입력해주세요.');
                 $("#goodsChargerCttpc3").focus();
                 return false;
             }

            var Cttpc = $("#goodsChargerCttpc0 option:selected").val()+$.trim($('#goodsChargerCttpc1').val())+"-"+$.trim($('#goodsChargerCttpc2').val())+"-"+$.trim($('#goodsChargerCttpc3').val());
            $("#goodsChargerCttpc").val(Cttpc);
        }

        //담당자 휴대전화번호 셋팅
        if($.trim($("#goodsChargerMbtlnum1").val()) != "" || $.trim($("#goodsChargerMbtlnum2").val()) != "" || $.trim($("#goodsChargerMbtlnum3").val()) != "" ){
            if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum1").val()))) {
                 alert('정확한 휴대전화번호를 입력해주세요.');
                 $("#goodsChargerMbtlnum1").focus();
                 return false;
             }
             if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum2").val()))) {
                 alert('정확한 휴대전화번호를 입력해주세요.');
                 $("#goodsChargerMbtlnum2").focus();
                 return false;
             }
            if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum3").val()))) {
                alert('정확한 휴대전화번호를 입력해주세요.');
                 $("#goodsChargerMbtlnum3").focus();
                 return false;
             }
             var Mbtlnum = $.trim($('#goodsChargerMbtlnum1').val())+"-"+$.trim($('#goodsChargerMbtlnum2').val())+"-"+$.trim($('#goodsChargerMbtlnum3').val());
             $("#goodsChargerMbtlnum").val(Mbtlnum);
        }

      //파일설명이있으나 파일이없는경우
        if(eachSection == 'N'){
            $("input[name=fileDesc][id ^= mnlfile]").each(function(i) {
                var seq = i+1;

                if($("#mnlfile"+seq+"Desc").val() != null && $("#mnlfile"+seq+"Desc").val() != ""){ // 파일설명서가있는경우
                    if ($('input[id="mnfileInput'+seq+'"]').val() == null ||  $('input[id="mnfileInput'+seq+'"]').val() == "" ){
                        if($("#pre_file"+seq).html() == null || $("#pre_file"+seq).html() == ""){
                            alert(Message.msg.chkGoods18);
                            eachSection ='Y';
                            return false;
                        }
                    }
                }else{//파일설명서가 없는경우
                    if ($("#mnfileInput"+seq).val() != null &&  $("#mnfileInput"+seq).val() != "" ){
                        alert(Message.msg.chkGoods19);
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

var checkEditor = function() {

    //카테고리
    var count = 0;
    $("input[name = ctgryCds]").each(function(i) {
        count++;
    });
    if(count < 1){
         alert("카테고리를 선택해주세요.");
         $("#jsCtgrySelPop").focus();
         return false;
    }

 //이미지파일 최소1개 체크
 var count = 0;
     for(var seq = 1; seq < 6; seq++) {
         if($("img#img"+seq).attr('src') != null && $("img#img"+seq).attr('src') != ""){
             count++;
         }
     }
     if(count == 0){
         alert("최소1개의 이미지가 필요합니다.");
         $("#imageFile1").focus();
         return false;
     }

     var eachSection = 'N';

    if(eachSection == 'N'){
        //A/S방침
        if ($("#metaASs").val()==null || $("#metaASs").val()=="") {
            alert("A/S 항목을 입력하여 주세요.");
            document.getElementById("metaASsBtn").focus();
            return false;
        }
        //보유자격증
        if ($("#metaTECHs").length > 0) {
            if ($("#metaTECHs").val()==null || $("#metaTECHs").val()=="") {
                alert("보유자격증 항목을 입력하여 주세요.");
                document.getElementById("metaTECHsBtn").focus();
                return false;
            }
        }
         //담당자 이메일 셋팅
         if($.trim($("#goodsChargerEmail1").val()) == null || $.trim($("#goodsChargerEmail1").val()) == "") {
             alert('이메일을 입력해주세요.');
             $("#goodsChargerEmail1").focus();
             return false;
         }

        var email = $.trim($('#goodsChargerEmail1').val())+"@"+$.trim($('#goodsChargerEmail2').val());
            if( !fnb_isEmailOK(email) ){
                alert("정확한 이메일을 입력해주세요.");
                $("#goodsChargerEmail2").focus();
                return false;
            }

            //담당자 연락처 셋팅
          //담당자 연락처 셋팅
            if("${dataVo.langCode}" != '00' && $("#goodsChargerCttpc0 option:selected").val() == "") {
                 alert('국가를 선택해주세요.');
                 $("#goodsChargerCttpc0").focus();
                 return false;
            }else if("${dataVo.langCode}" != '00') {
                $("#goodsChargerCttpc0 option:selected").val($("#goodsChargerCttpc0 option:selected").val() + "-");
             }else if("${dataVo.langCode}" == '00'){
                 $("#goodsChargerCttpc0 option:selected").val("");
             }
            if(!fnb_isNumeric($.trim($("#goodsChargerCttpc1").val()))) {
                 alert('정확한 연락처를 입력해주세요.');
                 $("#goodsChargerCttpc1").focus();
                 return false;
             }
            if(!fnb_isNumeric($.trim($("#goodsChargerCttpc2").val()))) {
                 alert('정확한 연락처를 입력해주세요.');
                 $("#goodsChargerCttpc2").focus();
                 return false;
             }

            if(!fnb_isNumeric($.trim($("#goodsChargerCttpc3").val()))) {
                 alert('정확한 연락처를 입력해주세요.');
                 $("#goodsChargerCttpc3").focus();
                 return false;
             }

            var Cttpc = $("#goodsChargerCttpc0 option:selected").val()+$.trim($('#goodsChargerCttpc1').val())+"-"+$.trim($('#goodsChargerCttpc2').val())+"-"+$.trim($('#goodsChargerCttpc3').val());

        //담당자 휴대전화번호 셋팅
            if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum1").val()))) {
                 alert('정확한 휴대전화번호를 입력해주세요.');
                 $("#goodsChargerMbtlnum1").focus();
                 return false;
             }
            if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum2").val()))) {
                 alert('정확한 휴대전화번호를 입력해주세요.');
                 $("#goodsChargerMbtlnum2").focus();
                 return false;
             }

            if(!fnb_isNumeric($.trim($("#goodsChargerMbtlnum3").val()))) {
                alert('정확한 휴대전화번호를 입력해주세요.');
                 $("#goodsChargerMbtlnum3").focus();
                 return false;
             }

        var Mbtlnum = $.trim($('#goodsChargerMbtlnum1').val())+"-"+$.trim($('#goodsChargerMbtlnum2').val())+"-"+$.trim($('#goodsChargerMbtlnum3').val());

        //값 담아주기
         $("#goodsChargerEmail").val(email);
         $("#goodsChargerCttpc").val(Cttpc);
         $("#goodsChargerMbtlnum").val(Mbtlnum);

       //태그
         var metaTagCnt=0;
         var goodsTagCnt=0;

         if($("#goodsTags").val() == "태그 직접 입력. 콤마로 구분해 주세요") {
             $("#goodsTags").val("");
         }
         var metaTAGs = $("#metaTAGs").val().split(",");
         var goodsTagsTmp = $("#goodsTags").val().split(",");

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
//          if ($("#goodsTags").val()==null || $("#goodsTags").val()=="") {
//              goodsTagCnt=0;
//          } else {
//              goodsTagCnt=goodsTags.length;
//          }

         if ((metaTagCnt + goodsTagCnt) == 0) {
             alert("태그 항목을 입력하여 주세요.");
             document.getElementById("metaTAGsBtn").focus();
             return false;
         }
         //태그중복체크
         for(var i =0; i < goodsTagCnt; i++){
             for(var j=0; j< goodsTagCnt; j++){
                 if(goodsTags[i] == goodsTags[j] && i !=j){
                     ret = false;
                     alert("중복된 태그 내용이 포함되어 있습니다.");
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
      //태그중복체크
//         var goodsTags = $("#goodsTags").val().split(",");

//         for(var i =0; i < goodsTags.length; i++){
//             for(var j=0; j< goodsTags.length; j++){
//                 if(goodsTags[i] == goodsTags[j] && i !=j){
//                     alert("중복된 태그 내용이 포함되어 있습니다.");
//                     $("#goodsTags").focus();
//                     eachSection ='Y';
//                     return false;
//                 }
//             }
//         }

        if(eachSection == 'N'){

            if(CKEDITOR.instances.goodsMainFnct.getData().trim() == ''){
                alert("주요기능을 입력해주세요.");
                CKEDITOR.instances.goodsMainFnct.focus();
                return false;
            } else if(CKEDITOR.instances.cnslExpcEffect.getData().trim() == '') {
                alert("기대효과 내용을 입력해주세요.");
                CKEDITOR.instances.cnslExpcEffect.focus();
                return false;
            } else if(CKEDITOR.instances.goodsRefer.getData().trim() == '') {
                alert("레퍼런스 내용을 입력해주세요.");
                CKEDITOR.instances.goodsRefer.focus();
                return false;
            }

        }

      //파일설명이있으나 파일이없는경우
        if(eachSection == 'N'){
            $("input[name=fileDesc][id ^= mnlfile]").each(function(i) {
                var seq = i+1;

                if($("#mnlfile"+seq+"Desc").val() != null && $("#mnlfile"+seq+"Desc").val() != ""){ // 파일설명서가있는경우
                    if ($('input[id="mnfileInput'+seq+'"]').val() == null ||  $('input[id="mnfileInput'+seq+'"]').val() == "" ){
                        if($("#pre_file"+seq).html() == null || $("#pre_file"+seq).html() == ""){
                            alert("설명서 파일을 등록해주세요.");
                            eachSection ='Y';
                            return false;
                        }
                    }
                }else{//파일설명서가 없는경우
                    if ($("#mnfileInput"+seq).val() != null &&  $("#mnfileInput"+seq).val() != "" ){
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

/* //업로드 파일 미리보기
var readURL = function (input,index) {
    if ($(input).val()!="") {
        if ( window.FileReader ) {
            /*IE 10 이상에서는 FileReader 이용
           var reader = new FileReader();
                   reader.onload = function (e) {
                       if(e.target.result.indexOf("image/gif") > 0 || e.target.result.indexOf("image/jpg") > 0 || e.target.result.indexOf("image/jpeg") > 0 || e.target.result.indexOf("image/png") > 0){
                           $("img#img"+index).remove();
                           var html ='';
           	               html += "<img src=\""+e.target.result+"\" alt=\"업로드 이미지 미리보기\" id=\"img"+index+"\" />";
           	               $("#imgPrev"+index).append(html);
                       }
                   };
                   reader.readAsDataURL(input.files[0]);
           } else {
                    $("img#img"+index).remove();
                    var html ='';
                    html += "<img src=\"" + "\" alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" id=\"img"+index+"\" />";
                    $("#imgPrev"+index).append(html);
           }
    }
};*/

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
                    $("#imgPrev"+index+" .thumb").append(html);
                }
            };
            reader.readAsDataURL(input.files[0]);
        }else{
            $("img#img"+index).remove();
            var html ='';
            html += "<img src=\"" + "\"   alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" id=\"img"+index+"\"/>";
            $("#imgPrev"+index+" .thumb").append(html);
        }
    }
};

//파일선택
var jsFileCount = function(inputId, fileSeq, maxCnt, seq){
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
      data : { fileSeq : fileSeq, maxCnt : maxCnt },
      type : "POST",
      dataType : "text",
      async    : false,
      success : function(response) {

          if (response != "") {
              alert(response);
              imgAppend(seq);
              ret = false;
          }
          else {
              ret = true;
          }
      }

  });
  return ret;
};

//파일갯수
var jsFileChkCount = function(inputId, fileSeq, maxCnt){
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
                $("input[name="+inputId+"]").val("");
                htmlVal = $("#"+inputId+"Span").html();
                $("input[name="+inputId+"]").remove();
                $("#"+inputId+"Span").append(htmlVal);
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
var jsFileChk = function(inputId, inputIdFake, s, fileExt, fileSeq, maxCnt) {
      document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
      return;

      var inputFile = document.getElementById(inputId);
      var filePath = inputFile.value;
      if (filePath == "") {
          return false;
      }

      var fileCountResult = jsFileChkCount(inputId, fileSeq, maxCnt);

      if (fileCountResult) {
              var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
              var fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai";
              var htmlVal = "";
              if (fileExtPermit.indexOf(fileExt) <= 0) {
                  alert(fileExt + Message.msg.fileCannotUplaod);
                  htmlVal = "";
                  $("input[name="+inputId+"]").val("");
                  htmlVal = $("#"+inputId+"Span").html();
                  $("input[name="+inputId+"]").remove();
                  $("#"+inputId+"Span").append(htmlVal);
                  return false;
              }

              if (inputFile.files[0].size > (s * 1024) && s != 0) {
                 alert(Message.msg.fileSizeOver);
                 htmlVal = "";
                 $("input[name="+inputId+"]").val("");
                 htmlVal = $("#"+inputId+"Span").html();
                 $("input[name="+inputId+"]").remove();
                 $("#"+inputId+"Span").append(htmlVal);
                 return false;
              }

              document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();

//               $("#dataForm").ajaxSubmit({
//                   url      : "ND_uploadFileChk.do",
//                   data     : { inputName : inputId,
//                                maxFileSize : s, fileExt : fileExt },
//                   type     : "POST",
//                   dataType : "text",
//                   async    : false,
//                   success  : function(response){

//                               if(response == "100") {
// //                                  alert(Message.msg.processOk);
//                                   //preview(inputId, imageId, parentId, w, h, s, true);
// //                                     alert(response);
//                               }else{
//                                   //preview(inputId, imageId, parentId, w, h, s, false);
//                                   //jsErrorBox(response);

//                                   alert(response);
//                                   var htmlVal = "";
//                                   $("input[name="+inputId+"]").val("");
//                                   htmlVal = $("#"+inputId+"Span").html();
//                                   $("input[name="+inputId+"]").remove();
//                                   $("#"+inputId+"Span").append(htmlVal);
//                             }
//                   }
//               });

      }
  };

//서비스이미지 용량,크기,비율 확인(이미지아이디, 최대넓이, 최대높이, 최소넓이, 최소높이, 용량, 확장자, seq, imgType, fileSeq, 파일첨부갯수)
var jsPreview = function(inputId, w, h, sw, sh, s, fileExt ,seq, imgType, fileSeq, maxCnt, fileThis) {
//   var source = $("input[name="+inputId+"]").eq(seq).val();

  var fileCountResult = jsFileCount(inputId, fileSeq, maxCnt,seq);

  if (fileCountResult) {
      var source = $("input[name="+inputId+"]").val();

      //확장자 잘라내기
      var lastDot = source.lastIndexOf('.');
      var ext = source.substring(lastDot + 1);

      if(fileExt.indexOf(ext.toLowerCase()) == -1){
          alert( "지원하지 않는 이미지 형식입니다.\n jpg, gif, png 형식만 가능합니다." );
          imgAppend(seq);

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

                          if(response == "100") { */
                              readURL(fileThis,seq);
/*                          }else{
                              alert(response );
                              imgAppend(seq);
                        }
              }
          });
*/
      }
  }
};


function fnb_isNumeric( sz_arg )
{
    var OK = false;
    var i_loop;

    if( sz_arg.length > 0 )
    {
        for( i_loop = 0; i_loop < sz_arg.length; i_loop++ )
        {
            if( sz_arg.charAt(i_loop) < '0' || sz_arg.charAt(i_loop) > '9' )
                break;
        }
        if( i_loop == sz_arg.length )
            OK = true;
    }
    return OK;
}

function fnb_isAlphaNumeric( sz_arg )
{
    var OK = false;
    var pattern = /(^[a-zA-Z0-9]+$)/;

    if( sz_arg && pattern.test( sz_arg ) )
        OK = true;
    return OK;
}

function fnb_isEmailOK( sz_email )
{
    var OK = false;
    //var pattern = /(\S+)@(\S+)\.(\S+)/; 이메일주소에 한글 사용시
    var pattern = /([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)\.([0-9a-zA-Z_-]+)/;

    if( sz_email && pattern.test( sz_email ) )
        OK = true;
    return OK;
}

var jsList = function(goodsRegistSttus) {
    var url;
    if(goodsRegistSttus == 1006 || goodsRegistSttus == 1007 ){
        //서비스관리로 이동
        url="BD_cnslList.do";
    }else{
        //서비스등록대기로 이동
        url="BD_waitingList.do";
    }
    document.dataForm.action = url;
    document.dataForm.submit();
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

var jsDeleteConfirm = function() {
    if(!confirm("서비스를 정말 삭제하시겠습니까?"))
        return false;

    jsDelete("ND_goodsDeleteAction.do", "dataForm");
};

/**
 * 미리보기
 */
 var jsCnsltPreview = function() {
     $("#metaASnms").val($("#metaASnm").text());
     $("#metaTECHnms").val($("#metaTECHnm").text());

     $("#mnlFilesFileDesc").val($.trim($(".mnlFilesFileDesc1").val())+"," + $.trim($(".mnlFilesFileDesc2").val()) +","+ $.trim($(".mnlFilesFileDesc3").val()) +","+ $.trim($(".mnlFilesFileDesc4").val()) +","+ $.trim($(".mnlFilesFileDesc5").val()));
     window.open("/korean/pt/popup/PD_cnsltPreview.do","preview","width=1040, height=768, scrollbars=yes");
     document.dataForm.action = "/korean/pt/popup/PD_cnsltPreview.do";
     document.dataForm.target = "preview";
     document.dataForm.submit();
     document.dataForm.target = "_self";
 };

//글자수체크
 var displayBytes  = function ( nm, id ){
     var obj  = document.getElementById( id );
         if (obj.value.bytes() > nm){
             if (event.keyCode != '8'){
//               alert(nm+'바이트까지 입력이 가능합니다.');
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

 var jsMetaPop = function(el, codeGroupCd, cdStart, cdEnd) {
     var codeLangCode = "<c:out value='${dataVo.langCode}'/>";
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

 var jsInputFileReset = function(fileId, textId) {
     $("#" + textId).val("");
     var control = $("#" + fileId);
     control.replaceWith( control = control.clone( true ) );
 };

</script>
</head>
<body>

<div class="contents">
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
<input type="hidden" name="goodsStatus" value="${dataVo.goodsRegistSttus}" id="goodsStatus"/>
<input type="hidden" name="goodsRegistSttus" value="" id="goodsRegistSttus"/>
<input type="hidden" name="goodsChargerEmail" value="" id="goodsChargerEmail"/>
<input type="hidden" name="goodsChargerCttpc" value="" id="goodsChargerCttpc"/>
<input type="hidden" name="goodsChargerMbtlnum" value="" id="goodsChargerMbtlnum"/>
<input type="hidden" name="q_goodsTyCd" value="1003" id="q_goodsTyCd"/>
<input type="hidden" name="langCode" value="<c:out value='${dataVo.langCode}'/>"  id="langCode"/>
<input type="hidden" name="goodsCode" value="<c:out value='${dataVo.goodsCode}'/>" id="goodsCode"/>
<input type="hidden" name="registDt" value="<c:out value='${dataVo.registDt}'/>" id="registDt"/>
<input type="hidden"  value="" id="insertSection"/>
<input type="hidden" name="goodsKndCd" value="1003">
				<!-- title-area -->
				<div class="title-area">
					<h2>IT 전문가서비스 상세</h2>
				</div>
				<!-- //title-area -->

				<!-- section -->
				<div class="section">
					<!-- <div class="border-box mt10">
						<ul>
						<li>※ 서비스명 입력과 카테고리만 선택하시면 임시저장이 가능합니다. 임시저장은 입력작업 진행중에 계속 하실 수 있습니다.</li>
						<li>※ 서비스 등록신청을 위해서는 필수항목(*)을 모두 입력하셔야합니다.</li>
						<li>※ 서비스는 같지만 라이선스, 버전, A/S방침에 따라 서비스 가격이 다르다면 각각 다른 서비스으로 등록을 권합니다.</li>
						</ul>
					</div> -->
					<div class="tab-search bor-t mt10">
						<table>
							<caption>서비스등록</caption>
							<colgroup>
							<col style="width:140px;"/>
							<col style="width:;"/>
							</colgroup>
							<tbody>
								<tr style="display:none;"><!--언어선택-->  	
				                    <th><span><strong class="txt-point">언어선택</strong></span></th>
				                    <th>
				                    <ul>
				                    <li>
				                        <c:forEach items="${storeLangList}" var="lang" varStatus="sts">
				                           <span><label for="langCode${sts.index}"><input type="radio" id="langCode${sts.index}" name="langCode" value="<c:out value='${lang.langCode}'/>"
				                            ${(sts.first) or (empty storeLang and lang.langCode eq siteLang) or (lang.langCode eq storeLang)? 'checked':'' }
				                            ${lang.langCode eq storeLang ? 'checked':'' }
				                            onchange="jsNationChange('${lang.langCode}');" />${lang.langNm}</label></span>
				                        </c:forEach>
				                    </li>
				                	</ul>
				                	</th>
								</tr>
								<tr>
									<th><span><strong class="txt-point">서비스명 입력</strong></th>
									<td><input name="goodsNm" id="goodsNm" type="text" value="<c:out value='${dataVo.goodsNm}'/>" class="w445" /></td>
								</tr>
								<tr>
									<th><strong class="txt-point">카테고리 선택</strong></th>
									<td><a href="#" title="새창 열림" onclick="jsCtgrySelPop(this);" id="jsCtgrySelPop" class="s-btn radius type1"><strong><span>카테고리선택</span></strong></a>
                       				 <input type="hidden" id="setCtgryCodes" name="setCtgryCodes" value=""/></td>	 
								</tr>
								<tr>
									<th colspan="2">연결된 카테고리</th>
								</tr>
								<tr>
									<th colspan="3" class="goodsCtgry cate3">
										
										<ul id="goods">
				                            <li id ="goodsCtgry">
				                                <c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
				                                    <ul class="multi-list langCategory${category.CATEGORY_LANGCD} goodsCtgry_${category.CTGRYCODE}">
				                                        <li class="cate01"><span class="caption"><strong>· 
				                                      <c:out value='${_goodsCtgry.CTGRYCLNM }'/><c:out value='${_goodsCtgry.CTGRYPATH}'/></strong></span>
				                                            <button onclick="" title="3depth category Name 삭제">
				                                                <span><img src="/resources/web/theme/default/images/btn/btn_reg_close.gif" alt="삭제"></span>
				                                            </button>
				                                        </li>
				                                    </ul>
				                                    <input type="hidden" name="ctgryCds" class="getCtgryCodes" value="<c:out value='${_goodsCtgry.CTGRYCODE}'/>" />
				                                </c:forEach>
				                            </li>
				                        </ul>
									</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section">
					<div class="tab-search type-write">
						<table>
							<caption>서비스등록</caption>
							<colgroup>
							<col style="width:140px;"/>
							<col style="width:;"/>
							</colgroup>
							<tbody>
								<tr>
									<th colspan="2">
										<strong class="txt-point mr20">서비스 대표 이미지 및 사용화면 이미지 등록</strong><span class="caption">(*JPG, GIF 형식의 10MB 미만 파일만 업로드 가능합니다. 이미지 사이즈는 300 X 250px을 권장합니다.)</span>
											<div class="section">
	                   						 <div class="reg_img">
	                   						 <input type="hidden" name="goodsImageFileSeq" value="<c:out value='${dataVo.goodsImageFileSeq}'/>"  />
												<ul class="multi-section file-upload mt20">
					                                <c:set var="image" value="" />
							                        <c:forEach items="${dataVo.imageFile}" var="fileVo" varStatus="status">
							                           <c:set var="i" value="${status.index+1}"/>
							                           
							                            <li  id="imgPrev${i}" <c:if test="${i == 1}">style="margin-left: 0;"</c:if>>
							                                <div>
							                                <p class="thumb"><img src="${fileVo.fileUrl}" alt="${fileVo.localNm} 이미지" id="img${i}"></p>
							                                <p class="fake_input req">
							                                    <input type="file" name="imageFile${i}" id="imageFile${i}" class="imageFile" onchange='jsPreview("imageFile${i}", 0, 0, 400, 300, 1024, "jpg,jpeg,gif,png",${i},"Img", ${dataVo.goodsImageFileSeq}, 5,this);' title="파일 찾기"/>
							                                </p>
							                                <a href="#" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}'); return false;"><img src="/new_cloud/images/icon-btn/btn-close.png" alt="" /></a>
							                                <!-- 사용자 등록 이미지 -->
							                                
							                                 <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value="imageFile${i}Desc"/>
							                                 <c:set var="count" value="${count+1}"/>
							                            </div>
							                            </li>
					                                	<c:set var="image"><c:if test="${!status.first}">${image},</c:if>${fileVo.fileUrl}</c:set>
								                        
								                       </c:forEach>
								                       <input type="hidden" name="image" value="${image}" />
								
								                       <!-- 추가이미지 -->
								                       <c:forEach var="i" begin="${count+1}" end="10" step="1" varStatus="status">
								                            <li id="imgPrev${status.index}" <c:if test="${i == 1}">style="margin-left: 0;"</c:if>>
								                                <div>
								                                <p class="thumb"></p>
			                                    				<p class="ac">	
								                                <a href="#" class="s-btn type5"><strong><span>등록</span></strong></a>
								                                </p>
								                                <a href="#" onclick="jsFileRemove('${i}'); return false;"><img src="/new_cloud/images/icon-btn/btn-close.png" alt="" /></a>
								                                <p class="fake_input req" id="fileSet${status.index}"  style="overflow:hidden; position:absolute; top:110px; right:40px;">
					                                            <input type="file" name="imageFile${i}" id="imageFile${i}" class="imageFile" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 1024, 'jpg,gif,png',${i},'Img', -1, 5,this);"/>
					                                            <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""/>
					                                       		</p>
						                                        </div>
								                            </li>
								                        </c:forEach>
													</ul>
												</div>
											</div>
										<p class="mt10 fl"><span class="caption">※ 최소 1개 이상의 이미지를 등록해주시기 바랍니다. (단, 첫번째 이미지는 서비스 대표이미지로 사용됩니다.)</span></p>
									</th>
								</tr>
								<tr>
									<th><span class="txt-point">체험판</span></th>
									<td>
										<div class="fr">
											<p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
											<input type="text" name="itemVodUrl" id="itemVodUrl" value="${dataVo.itemVodUrl}" class="w550 mt5" />
										</div>
									</td>
								</tr>
								<tr>
									<th><span class="txt-point">서비스상세</span></th>
									<td><span class="fl mt20">서비스상세 URL</span>
										<div class="fr ml20">
											<p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
											<input type="text" name="goodsDwldUrl" id="goodsDwldUrl" value="<c:out value='${dataVo.goodsDwldUrl}'/>" class="w550" />
										</div>
									</td>
								</tr>
<%-- 2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함								
								<tr>
									<th><span class="txt-point">소개영상</span></th>
									<td><span class="fl mt20">소개영상 URL</span>
										<div class="fr ml20">
											<p class="caption">※ 서비스에 대한 소개 영상이 있는 경우 영상을 플레이 할 URL 주소를 입력해 주세요.</p>
											<input name="demoExprnUrl" id="demoExprnUrl" type="text" value="<c:out value='${dataVo.demoExprnUrl}'/>" class="w550" />
										</div>
									</td>
								</tr> --%>
								<tr>
									<th colspan="2"><span><strong class="txt-point">기본정보 입력</strong></span></th>
								</tr>
								<tr>
									<th><span class="point">기업구분</span></th>
									<td><span class="agree"><input type="checkbox" id="smlpzChk" name="smlpzChk" value="Y" <c:if test="${dataVo.smlpzChk  == 'Y'}" >checked="checked" </c:if> /><label>중소기업</label></span></td>
								</tr>
								<tr>
									<th><span>가격(￦)</span></th>
									<td>
									 <span class="agree">
									 <c:forEach items="${dataVo.goodsMetaPrice}" var="_goodsMetaPrice" varStatus="status">
			                              <input name="metaPrices" id="metaPrice${_goodsMetaPrice.PRICECD}" type="checkbox" value="${_goodsMetaPrice.PRICECD}"
			                                    <c:if test="${_goodsMetaPrice.PRICECD == _goodsMetaPrice.METAPRICECD}"> checked="checked"</c:if>/>
			                               		<span class="caption mr10">${_goodsMetaPrice.PRICENM}</span>
			                          </c:forEach>
		                            <input name="goodsPc" id="goodsPc" type="text" title="가격입력" value="<c:out value='${dataVo.goodsPc}'/>"/></span>
								</tr>
								<tr>
									<th><span class="point">지역</span></th>
									<td><a id="metaAREAsBtn" onclick="jsMetaPop(this, 2022, '', '');" href="javascript:;"  class="b-btn type1"><strong><span>선택</span></strong></a>
										<span id="metaAreanm"><c:forEach items="${dataVo.goodsMetaArea}" var="_goodsMetaArea" varStatus="status">${_goodsMetaArea.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
		                            	<input name="metaAreas" id="metaAreas" type="hidden" value="<c:forEach items="${dataVo.goodsMetaArea}" var="_goodsMetaArea" varStatus="status">${_goodsMetaArea.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
									</td>
								</tr>
								<tr>
									<th><span class="point">A/S방침</span></th>
									<td>
				                       <a id="metaASsBtn" onclick="jsMetaPop(this, 1021, '2000', '2999');" href="javascript:;" class="b-btn type1"><strong><span>선택</span></strong></a> 
				                        <span id="metaASnm"><c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
				                    <input name="metaASs" id="metaASs" type="hidden"
				                     value="<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaAS.INDVDLZ_CD == 2005}"><c:set var="metaASetc" value="${_goodsMetaAS.META_ETC_CN}"/></c:if></c:forEach>"/>
				                    <input name="metaASetc" id="metaASetc" type="hidden" value="${metaASetc}"/>
				                    <input name="metaASnms" id="metaASnms" type="hidden" value=""/>
				                </td>
								</tr>
								<tr>
									<th><span class="point">전문분야</span></th>
									<td><input type="text" id="spcltyRealm" name="spcltyRealm" value="<c:out value='${dataVo.spcltyRealm}'/>" class="w650" /></td>
								</tr>
								<tr>
									<th><span class="point">전문<br/>컨설턴트 수</span></th>
									<td><input type="text" id="cnstntCo" name="cnstntCo" value="<c:out value='${dataVo.cnstntCo}'/>" class="w650" /></td>
								</tr>
								<tr>
									<th><span class="point">보유기술 및<br/>자격증</span></th>
									<td><a id="metaTECHsBtn" onclick="jsMetaPop(this, 1022, '', '');" href="javascript:;" class="b-btn type1"><strong><span>선택</span></strong></a>
									<span id="metaTECHnm"><c:forEach items="${dataVo.goodsMetaTECH}" var="_goodsMetaTECH" varStatus="status">${_goodsMetaTECH.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
									<input name="metaTECHs" id="metaTECHs" type="hidden"
				                     value="<c:forEach items="${dataVo.goodsMetaTECH}" var="_goodsMetaTECH" varStatus="status">${_goodsMetaTECH.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaTECH.INDVDLZ_CD == 1002}"><c:set var="metaTECHetc" value="${_goodsMetaTECH.META_ETC_CN}"/></c:if></c:forEach>"/>
				                    <input name="metaTECHetc" id="metaTECHetc" type="hidden" value="${metaTECHetc}"/>
				                    <input name="metaTECHnms" id="metaTECHnms" type="hidden" value=""/>
									</td>
								</tr>
								<tr>
									<th colspan="2"><span><strong class="txt-point">판매자 정보 입력</strong></span></th>
								</tr>
								<tr>
									<th><span class="point">회사명</span></th>
									<td><input type="text" id="langStoreNm" name="langStoreNm" value="<c:out value='${dataVo.goodsStore[0].LANGSTORENM }'/>" readonly="readonly"class="w650" /></td>
								</tr>
								<tr>
									<th><span class="point">담당자</span></th>
									<td><input type="text" id="goodsChargerNm" name="goodsChargerNm" value="<c:out value='${dataVo.goodsChargerNm}'/>"  class="w650" /></td>
								</tr>
								<tr>
									<th><span class="point">담당자 이메일</span></th>
									<td><input type="text" id="goodsChargerEmail1" name="goodsChargerEmail1" value="${fn:split(dataVo.goodsChargerEmail,'@')[0]}" class="w194" /><span class="space">@</span><input type="text" name="goodsChargerEmail2" id="goodsChargerEmail2" value="${fn:split(dataVo.goodsChargerEmail,'@')[1]}" class="w194" /></td>
								</tr>
								<tr>
			                        <th><span class="point">담당자 연락처</span></th>
			                        <td>
			                           <!-- static select -->
										<div class="select-area">
											<!-- select box -->
											<div class="sech_form">
												<div class="cont_wrap">
													<div class="selected">
				                                        <select id="goodsChargerCttpc0" name="goodsChargerCttpc0"  title="국가 선택" style="width:210px;"  >
				                                            <option value="">국가 선택</option>
				                                            <c:forEach items="${nation}" var="list">
				                                                <option <c:if test="${fn:replace(dataVo.langCode,'00','82') == list.INTRLTELNL}">selected</c:if> value="<c:out value='${list.INTRLTELNL}'/>" ${fn:split(dataVo.goodsChargerCttpc,'-')[0] == list.INTRLTELNL ? 'selected="selected"' : ''}><c:out value="${list.LANGNATIONNM}" />(<c:out value="${list.INTRLTELNL}" />)</option>
				                                            </c:forEach>
				                                        </select>
													</div>														
												</div>
											</div>
											<!-- //select box -->
										</div>
										<!-- //static select -->
				                        <c:if test="${dataVo.langCode == '00'}">
				                            <c:set var="idx" value="0"/>
				                        </c:if>
				                        <c:if test="${dataVo.langCode != '00'}">
				                            <c:set var="idx" value="1"/>
				                        </c:if>
			                            <input type="text" name="goodsChargerCttpc1" id="goodsChargerCttpc1" title="연락처 입력" value="${fn:split(dataVo.goodsChargerCttpc,'-')[idx]}" class="w124" maxlength="4"/> -
			                            <input type="text" name="goodsChargerCttpc2" id="goodsChargerCttpc2" title="연락처 입력" value="${fn:split(dataVo.goodsChargerCttpc,'-')[idx+1]}" class="w124" maxlength="4"/> -
			                            <input type="text" name="goodsChargerCttpc3" id="goodsChargerCttpc3" title="연락처 입력" maxlength="4" value="${fn:split(dataVo.goodsChargerCttpc,'-')[idx+2]}" class="w124" maxlength="4"/>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th><span class="point">담당자 휴대폰</span></th>
			                        <td>
			                            <input type="text" name="goodsChargerMbtlnum1" id="goodsChargerMbtlnum1" title="휴대전화번호 입력" value="${fn:split(dataVo.goodsChargerMbtlnum,'-')[0]}" class="w124" maxlength="3"/> -
			                            <input type="text" name="goodsChargerMbtlnum2" id="goodsChargerMbtlnum2" title="휴대전화번호 입력" value="${fn:split(dataVo.goodsChargerMbtlnum,'-')[1]}" class="w124" maxlength="4"/> -
			                            <input type="text" name="goodsChargerMbtlnum3" id="goodsChargerMbtlnum3" title="휴대전화번호 입력" value="${fn:split(dataVo.goodsChargerMbtlnum,'-')[2]}" class="w124" maxlength="4"/>
			                        </td>
			                    </tr>
<%-- 	2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함		                    
								<tr>
									<th><span>홈페이지 URL</span></th>
									<td><input type="text" id="goodsHmpgUrl" name="goodsHmpgUrl" value="<c:out value='${dataVo.goodsHmpgUrl}'/>" class="w650" id="" /></td>
								</tr> --%>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //section -->

				<!-- btn-area -->
				<!-- <div class="btn-area mt10 ar">
					<a href="#" class="b-btn save2 type1"><strong><span>임시저장</span></strong></a>
				</div> -->
				<!-- //btn-area -->

				<!-- section -->
				<div class="section">
					<div class="tab-search type-write">
						<table>
							<caption>서비스등록</caption>
							<colgroup>
							<col style="width:;"/>
							</colgroup>
							<tbody>
								<tr>
									<th>
										<p class="mb10"><strong class="txt-point">상세정보 입력</strong></p>
										<span class="point">서비스개요</span>
										<div class="mt5">
											<textarea name="goodsSumry" id="goodsSumry" onkeyup="javascript:displayBytes(3000,'goodsSumry');" class="h167"><c:out value='${dataVo.goodsSumry}'/></textarea>
											<p class="ar mt5">
												<span class="byte"><span id="goodsSumry_bytes" class="txt-point">0</span><span class="caption">/ 3,000 Byte</span></span>
											</p>
										</div>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">태그</span>
										<span class="caption">(※ 태그선택 또는 직접 입력으로 총 10개의 태그를 입력할 수 있습니다.)</span>
										<div class="mt5 border-box">
											<a id="metaTAGsBtn" onclick="jsMetaPop(this, 1023, '', '');" href="javascript:;" class="b-btn type1"><strong><span>태그선택</span></strong></a>
											<input type="text" id="goodsTags" name="goodsTags"value="<c:forEach items="${dataVo.goodsTag}" var="_goodsTag" varStatus="status"><c:out value='${_goodsTag.GOODSTAGNM}'/>${!status.last?', ':''}</c:forEach>" onclick="if (this.value == '태그 직접 입력. 콤마로 구분해 주세요') value='';" class="w650"/>
											<div>
						                        <input name="metaTAGs" id="metaTAGs" type="hidden" value="<c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">${_goodsMetaTAG.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
						                        <ul id="metaTAGhtml">
							                        <c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">
							                        <li><a id="metaTAG${_goodsMetaTAG.INDVDLZ_CD}" onclick="jsMetaTagDelete(this);" href="javascript:;">${_goodsMetaTAG.INDVDLZ_CD_NM} X</a></li>
							                        </c:forEach>
						                        </ul>
						                    </div>
				                        
										</div>
										<p class="mt5 caption">※ 등록하신 태그는 통합검색에 적용되기까지 최대 24시간이 소요됩니다.</p>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">특장점</span>
										<div class="mt5">
											<textarea name="itemSfe" id="itemSfe" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.itemSfe}' escapeXml="false"/></textarea>
					                        <script type="text/javascript">
					                        //<![CDATA[
					                            CKEDITOR.replace('itemSfe', {
					                                height               : 200,
					                                htmlEncodeOutput     : true,
					                                enterMode            : "2",
					                                skin                 : "moono",
					                                toolbar              : [[ 'BulletedList' ]],
					                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
					                            });
					                        //]]>
					                        </script>
										</div>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">대상고객</span>
										<div class="mt5">
											<textarea name="goodsRefer" id="goodsRefer" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.goodsRefer}' escapeXml="false"/></textarea>
					                        <script type="text/javascript">
					                        //<![CDATA[
					                            CKEDITOR.replace('goodsRefer', {
					                                height               : 200,
					                                htmlEncodeOutput     : true,
					                                enterMode            : "2",
					                                skin                 : "moono",
					                                toolbar              : [[ 'BulletedList' ]],
					                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
					                            });
					                        //]]>
					                        </script>
										</div>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">주요기능</span>
										<div class="mt5">
											 <textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.goodsMainFnct}' escapeXml="false"/></textarea>
					                        <script type="text/javascript">
					                        //<![CDATA[
					                            CKEDITOR.replace('goodsMainFnct', {
					                                height               : 200,
					                                htmlEncodeOutput     : true,
					                                enterMode            : "2",
					                                skin                 : "moono",
					                                toolbar              : [[ 'BulletedList' ]],
					                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
					                            });
					                        //]]>
					                        </script>
										</div>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">기대효과</span>
										<div class="mt5">
											 <textarea name="cnslExpcEffect" id="cnslExpcEffect" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.cnslExpcEffect}' escapeXml="false"/></textarea>
					                        <script type="text/javascript">
					                        //<![CDATA[
					                            CKEDITOR.replace('cnslExpcEffect', {
					                                height               : 200,
					                                htmlEncodeOutput     : true,
					                                enterMode            : "2",
					                                skin                 : "moono",
					                                toolbar              : [[ 'BulletedList' ]],
					                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
					                            });
					                        //]]>
					                        </script>
										</div>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">회사소개서</span>
									</th>
								</tr>
								<tr>
									<th>
										<ul>
										<li class="mt10">
											<span class="fl ml10">파일업로드</span>
											<input type="hidden" name="goodsMnlFileSeq" value="${dataVo.goodsMnlFileSeq}"/>
												
												<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
												 <div class="fr" <c:if test="${not empty dataVo.mnlFile[i-1]}">style="diplay:none;"</c:if>>
													<div class="file-area fr"  <c:if test="${not empty dataVo.mnlFile[i-1]}">style="display:none;" </c:if>>
														<!-- file upload -->
														<input type="text" id="mnfileInput${i}" readonly="readonly" title="파일명" class="fileup">
														<span class="file_del"><img onclick="jsInputFileReset('mnlFile${i}','mnfileInput${i}');" src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제"></span>
														<div class="fake_input">
															<a href="#" class="b-btn type1"><strong><span>파일선택</span></strong></a>
															<span id="mnlFile${i}Span">
																 <input type="file" name="mnlFile${i}" id="mnlFile${i}" class="mnlFile" title="파일찾기" <c:if test="${not empty dataVo.mnlFile[i-1]}">disabled</c:if> onchange="jsFileChk('mnlFile${i}', 'mnfileInput${i}', 10240, '1','${dataVo.goodsMnlFileSeq}', 1); "/>
																 <input type="hidden" name="fileDesc" id="mnlFile${i}Desc" value=""/>
															</span>
														</div>
														<!-- //file upload -->
														</div>	
													</div>
													 <c:if test="${not empty dataVo.mnlFile[i-1]}">
													 <div class="fr">
					                                        <p class="pre_file" id="pre_file${i}">
					                                           <a href="#none" onclick="jsFileDelete(this, ${dataVo.mnlFile[i-1].fileSeq}, '${dataVo.mnlFile[i-1].fileId}'); return false;" class="aDeisable"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" alt="삭제" class="vm"/></a>
					                                           <a href="/component/file/ND_fileDownload.do?id=${dataVo.mnlFile[i-1].fileId }" title="${dataVo.mnlFile[i-1].localNm}" class="aDeisable">${dataVo.mnlFile[i-1].localNm} <span class="tx_gray">(${dataVo.mnlFile[i-1].fileSize}, ${dataVo.mnlFile[i-1].fileType})</span></a>
					                                        </p>
					                                   </div>     
					                                 </c:if>
												</c:forEach>
												<input type="hidden" id="mnlFilesFileDesc" name="mnlFilesFileDesc" value="" />
													<!-- //file upload -->
												
										</li>
										</ul>
									</th>
								</tr>
								<tr>
									<th>
										<span class="point">서비스설명서</span>
									</th>
								</tr>
								<tr>
									<th>
										<ul>
										<li class="mt10">
											<span class="fl ml10">파일업로드</span>
											 <input type="hidden" name="mnlDnFileSeq" value="${dataVo.mnlDnFileSeq}"/>												
												 <c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
												 <div class="fr" <c:if test="${not empty dataVo.dnlFile[i-1]}">style="diplay:none;"</c:if>>
													<div class="file-area fr" <c:if test="${not empty dataVo.dnlFile[i-1]}">style="display:none;" </c:if>>
														<!-- file upload -->
														<input type="text" id="dnfileInput${i}" readonly="readonly" title="파일명" class="fileup">
														<span class="file_del"><img onclick="jsInputFileReset('dnlFile${i}','dnfileInput${i}');" src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제"></span>
														<div class="fake_input">
															<a href="#" class="b-btn type1"><strong><span>파일선택</span></strong></a>
															<span id="dnlFile${i}Span">
																 <input type="file" name="dnlFile${i}" id="dnlFile${i}" class="mnlFile" title="파일찾기" <c:if test="${not empty dataVo.dnlFile[i-1]}">disabled</c:if> onchange="jsFileChk('dnlFile${i}', 'dnfileInput${i}', 10240, '1','${dataVo.mnlDnFileSeq}', 1); "/>
																 <input type="hidden" name="fileDesc" id="dnlFile${i}Desc" value=""/>
															</span>
														</div>
													</div>	
														<!-- //file upload -->
													</div>
													 <c:if test="${not empty dataVo.dnlFile[i-1]}">
													  <div class="fr">
					                                        <p class="pre_file" id="pre_file${i}">
					                                           <a href="#none" onclick="jsFileDelete(this, ${dataVo.dnlFile[i-1].fileSeq}, '${dataVo.dnlFile[i-1].fileId}'); return false;" class="aDeisable"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" alt="삭제" class="vm"/></a>
					                                           <a href="/component/file/ND_fileDownload.do?id=${dataVo.dnlFile[i-1].fileId }" title="${dataVo.dnlFile[i-1].localNm}" class="aDeisable">${dataVo.dnlFile[i-1].localNm} <span class="tx_gray">(${dataVo.dnlFile[i-1].fileSize}, ${dataVo.dnlFile[i-1].fileType})</span></a>
					                                        </p>
					                                   </div>     
					                                 </c:if>
												  </c:forEach>
											<!-- //file upload -->
										</li>
										</ul>
									</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //section -->
				<c:if test="${dataVo.goodsRegistSttus eq 1001 || dataVo.goodsRegistSttus eq 1003 || dataVo.goodsRegistSttus eq 1007}">
				<div class="btn-area mt20">
					<p class="fl">
						<a href="#" onclick="jsCancel();" class="b-btn cancel mr10 ac type1"><strong><span>취 소</span></strong></a>
						<!-- <a href="#" onclick="jsGoodsPreview();" class="b-btn search2 type1"><strong><span>미리보기</span></strong></a> -->
						<a href="#none" onclick="jsDeleteConfirm();" class="b-btn cancel mr10 ac type3"><strong><span>삭 제</span></strong></a>
					</p>
					<p class="fr">
						<a href="javascript:" id="tempSave" onclick="if (jsLoading()==true){jsGoodsUpdateAction('1001');};" class="b-btn save2 mr10 type1"><strong><span>임시저장</span></strong></a>
						<a href="javascript:" id="regReq" onclick="if (jsLoading()==true){jsGoodsUpdateAction('1002');};" class="b-btn registry type2"><strong><span>등록신청</span></strong></a>
					</p>
				</div>
				</c:if>
				</form>
			</div>
</body>
</html>