<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	
	<title>이용희망목록 목록생성</title>
  <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
  
  <!--[if lt IE 9]>
  	<script src="/resources/web/theme/default/js/html5shiv.js"></script> 
  <![endif]-->
	<op:jsTag type="openworks" items="form" />
  <op:jsTag type="spi" items="form,datepicker" />
    
  <script type="text/javascript">
  	function numberWithCommas(x){
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    $().ready(function() {
	    // 화면 초기 인입 및 선택 재조회시 선택한 사업이 도입사업 목록의 최 상단에 위치하도록 스크롤 이동
	    bizListSelect();
	    
	    // [이용희망목록]에서 전체를 체크했을때
	    $("#ckMultiBoxAll1").click(function() 
	    {
	        var amount = 0 ;
	        
	        if  ($(this).is(':checked')) 
	        {        
	            $("input[name=goods_check]").prop("checked", true);
	        } 
	        else 
	        {        
	            $("input[name=goods_check]").prop("checked", false);    
	        }
	        
	        $("input[name=goods_check]:checked").each(function (i) 
	        {
	            amount += Number($(this).attr('goods_amount')); 
	        });
	        
	        $("#beforSelAmount").html(numberWithCommas(amount)+"원");
	    });
	    
	    // [이용희망목록]에서 상품을 체크했을때
	    $('.goods_check').click(function() 
	    {
	        var amount = 0 ;
	        $('.goods_check:checked').each(function(){                    
	            amount += Number($(this).attr('goods_amount'));
	        });
	        
	        $("#beforSelAmount").html(numberWithCommas(amount)+"원");
	    });
	    
	     
	    // [이용대상확정]에서 전체를 체크했을때
	    $("#ckMultiBoxAll2").click(function() 
	    {
	        var amountBefore = 0 ;
	        var amountDetail = 0 ;
	        
	           if  ($(this).is(':checked')) 
	           {        
	               $("input[name=Index]").prop("checked", true);
	
	               amountDetail += Number($("input[name=Index]").attr('goods_amount'));
	            amountBefore += Number($("input[name=Index]").attr('before_amount'));
	           } else {        
	               $("input[name=Index]").prop("checked", false);    
	           }
	           
	           $("#beforSelAmount2").html(numberWithCommas(amountBefore)+"원");
	        $("#detailSelAmount2").html(numberWithCommas(amountDetail)+"원");
	       }); 
	    
	    // [이용대상확정]에서 상품을 체크했을때
	    $('.Index').click(function() 
	    {
	        var amountBefore = 0 ;
	        var amountDetail = 0 ;
	        
	        $('.Index:checked').each(function(){                    
	            amountDetail += Number($(this).attr('goods_amount'));
	            amountBefore += Number($(this).attr('before_amount'));
	        });
	        
	        $("#beforSelAmount2").html(numberWithCommas(amountBefore)+"원");
	        $("#detailSelAmount2").html(numberWithCommas(amountDetail)+"원");
	     });
    }); //ready

     // 화면 초기 인입 및 선택 재조회시 선택한 사업이 도입사업 목록의 최 상단에 위치하도록 스크롤 이동
     var bizListSelect = function(){
         
         var selectId = "bizList_" + $('#grpSeq').val();

         jQuery('#bizList li').each(function() {
             var text = jQuery(this).attr('id');

             if(selectId == text) {
                 var top = jQuery(this).position().top; // 현재 리스트의 위치
                 // 첫번째 목록 선택시 위쪽 여백 스크롤 하지 않기 위해
                 if(top == 20){
                     top = 0;
                 }

                 $('#bizList').animate( { scrollTop : top }, 200 );
                 return false;
             }
         });
     };
     
     // 도입사업 선택
     var jsSearchMyWishDetail = function(grpSeq, goodsTyCd, confrmChk)
     {
         $('#grpSeq').val(grpSeq);
         $('#goodsTyCd').val(goodsTyCd);
         $('#confrmChk').val(confrmChk);
         
         document.dataForm.method = "POST";
         document.dataForm.submit();
     };

     // 사업명생성
     var jsWishInfor = function(){
         if($("#auditlogNm").val() == null || $("#auditlogNm").val() == ""){
             alert("사업명을 입력해주세요.");
             $("#auditlogNm").focus();
             return false;
         }
         $("#dataForm").ajaxSubmit({
             url      : "/korean/store/ND_WishInfor.do",
             type     : "POST",
             dataType : "json",
             success  : function(response){
                 location.reload();
             }
         });
     };

     // 이용희망목록의 도입사업 삭제
     var jsGoodsDelete = function(seq){
         
         if($('#confrmChk').val() == 'Y'){
             alert("이미 견적요청/공고등록 된 사업입니다.");
             return false;
         }else{
             if(confirm("선택하신 사업을 삭제하시겠습니까?")) {
                    $("#dataForm").ajaxSubmit({
                      url      : "ND_myWishDeleteAction.do",
                      type     : "POST",
                      dataType : "text",
                      success  : function(response) {
                            if (response == "true")  {
                              alert("이용희망목록의 도입사업를 삭제 되었습니다.");
                              location.reload();
                            } else { 
                                alert("이용희망목록의 도입사업 삭제 중 오류가 발생했습니다.");
                                 return;
                            }
                       }
                    });
             }
         }
     };
        
     // 이용희망목록에 보관된 클라우드서비스 삭제
     var jsStoreGoodsDelete = function()
     {
         if($('input:checkbox[name=goods_check]:checked').length < 1){
             alert('이용희망목록 에서 삭제할 클라우드서비스를 선택하세요');
             return;
         }
         
         var goods_chk = $("input[name='goods_check']:checked");
         var goods_array = "";
         var confirm_Chk = "Y";
         goods_chk.each(function(){
             var chkGoodsCode = $(this).val();
             var goodsConfirmYn = $('#goodsConfirmYn_'+chkGoodsCode).val();

             if(goodsConfirmYn != ''){
                 alert("사전견적이 제공자에 요청되어 진행중이므로 삭제할 수 없습니다.");
                 confirm_Chk = "N";
                 return false;
             }else{
                 goods_array += (goods_array == "") ? chkGoodsCode : "|" + chkGoodsCode;   
             }
         });

         if(confirm_Chk == 'N'){
             return false;
         }

         if (confirm("선택하신 클라우드서비스를 삭제하시겠습니까?")) 
         {                
             if (confirm_Chk == 'Y')
             {
                 $('#goodArray').val(goods_array);
                 
                 $("#dataForm").ajaxSubmit({
                     url      : "/korean/pt/wish/ND_myWishStoreGoodsDeleteAction.do",
                     type     : "POST",
                     dataType : "text",
                     success  : function(response) {
                         if (response == "true")  {
                             alert("이용희망목록에 보관된 클라우드서비스가 삭제 되었습니다.");
                             location.reload();
                         } else { 
                             alert("이용희망목록에 보관된 클라우드서비스 처리 중 오류가 발생했습니다.");
                             return;
                         }
                     }
                 });
             }
         }
     }

     // 보관목록의 서비스 선택 후 확정목록에 담기
     var jsGoodsConfirm = function()
     {
         if($("input[type='checkbox']:checked").length < 1){
             alert('이용대상 서비스를 선택 후 확정하세요.');
             return;
         }
         
         //확정을 할때에는 사업자등록증이 있어야 확정할 수 있다.개인구매회원은 버튼사용 금지
         if($('#userTyCd').val()=='1001'){
             alert('개인회원은 사용할 수 없습니다.');
             return;
         }
         // 체크 시작
         var type = false;
         var index = new Array();
         var langStoreNm = new Array();
         var count = 0;
         var goods_index = new Array();
         var goods_index2 = new Array();
         var goods_langStoreNm = new Array();
         
         var goods_chk = $("input[name='goods_check']:checked");
         var goods_array = "";
         var confirm_Chk = "Y";
         goods_chk.each(function(){
             var chkGoodsCode = $(this).val();
             var goodsConfirmYn = $('#goodsConfirmYn_'+chkGoodsCode).val();

             if(goodsConfirmYn == 'Y'){
                 alert("이미 확정된 클라우드서비스가 존재합니다.");
                 confirm_Chk = "N";
                 type = true;
                 return false;
             }else{
                 goods_array += (goods_array == "") ? chkGoodsCode : "|" + chkGoodsCode;   
             }
         });
         
         if(type){
             return;
         }
         
         $("input[name=goods_check]:checked").each(function (i) {
             goods_index[i] = $(this).val();
             goods_index2[i] = $("#goods_index"+goods_index[i]).val(); 
             goods_langStoreNm[i] = $("#goods_langStoreNm"+goods_index2[i]).val(); 
         });
         if(goods_index.length == 0){
             alert("선택하신 클라우드서비스가 존재 하지않습니다.");
             return;
         }
         $("input[name=Index]:checked").each(function (i) {
             index[i] = $(this).val();
             langStoreNm[i] = $("#langStoreNm"+this.value).val();     
         });
         if(goods_index.length > 0){
             for(var i = 0; i < goods_index.length; i += 1){
                 for(var j = 0; j < goods_index.length; j += 1){
                     if(i != j){
                         if(goods_langStoreNm[i] == goods_langStoreNm[j]){
                             alert("선택하신 클라우드서비스 지원업체가 중복되어있습니다.");
                             return;     
                         }
                     }
                 }
                 
                 for(var j = 0; j < index.length; j += 1){    
                    if(goods_langStoreNm[i] == langStoreNm[j]){
                        alert("이미 확정된 클라우드서비스 지원업체가 존재합니다.");
                        return;     
                    }
                 }
               }
         }
         
         // 체크 끝
         if(confirm("선택하신 클라우드서비스를 확정하시겠습니까?")) 
         {
             var goods_chk = $("input[name='goods_check']:checked");
             var goods_array = "";
             var confirm_Chk = "Y";
             
             goods_chk.each(function(){
                 var chkGoodsCode = $(this).val();
                 var goodsConfirmYn = $('#goodsConfirmYn_'+chkGoodsCode).val();

                 if(goodsConfirmYn == 'Y'){
                     alert("이미 확정된 클라우드서비스가 존재합니다.");
                     confirm_Chk = "N";
                     return false;
                 }else{
                     goods_array += (goods_array == "") ? chkGoodsCode : "|" + chkGoodsCode;   
                 }
             });
             
             if (confirm_Chk == 'Y')
             {
                 $('#goodArray').val(goods_array);
                 $('#cntrMothod').val('Y');
                    $("#dataForm").ajaxSubmit({
                      url      : "/korean/pt/wish/ND_myWishConfirmAction.do",
                      type     : "POST",
                      dataType : "text",
                      success  : function(response) {
                            if (response == "true")  {
                              alert("확정목록 담기를 완료되었습니다.");
                              location.reload();
                            } else { 
                                alert("확정목록 담기 중 오류가 발생했습니다.");
                                 return;
                            }
                       }
                    });
                    /*
                    UPDATE TCM_WISHORDER_DETAIL_L 
                    SET CONFRM_CHK = 'Y'
                       ,CONFRM_DT  = SYSDATE
                  WHERE GRP_SEQ    = {grpSeq}
                    AND USER_ID    = {userId}
                    AND GOODS_CODE = {goodsCd}
                    */
             }
         }
     };
     
     // [이용희망목록] '요청' 버튼 클릭!! 
     var jsbfRequestEstimate = function(goodcode, goodsTyCd)
     {
         // 이미 사전견적요청한 건입니다.-> pass하기로함. Yang            
         //선택된 서비스만 사전견적을 보냅니다.
           /*   
           var goodcode = "";
         if($("input[name='goods_check']:checked").length < 1){
             alert('사전견적요청 할 서비스를 선택하세요');
             return false;                
         }else if($("input[name='goods_check']:checked").length > 1){
             alert('사전견적요청은 1건씩만 가능합니다.');
             return false;
         }else{   
             
             $("input[name=goods_check]:checked").each(function(i){
                 if( goodcode == ""){
                     goodcode = $("input[name=goods_check]:checked").eq(i).val();
                 }
             });
         } 
         */
         
         // VO로 추가 : 선택된 서비스들을 XXXX1|XXXX2|XXXX3 형태로 JAVA로 보냅니다.  ->선택된것들에서 1건으로만으로 변경 
         $('#goodsCd2').val(goodcode);            
         $('#goodsTyCd').val(goodsTyCd); // 타입을 지정하지 않으면 오류가 남..            
         
         if (goodsTyCd == '1001')      { document.dataForm.action = "/korean/pt/before/BD_beforeRequestPaas.do"; } // PaaS [이용희망목록] '요청'
         else if (goodsTyCd == '1002') { document.dataForm.action = "/korean/pt/before/BD_beforeRequestSaas.do"; } // SaaS [이용희망목록] '요청'
         else if (goodsTyCd == '1003') { document.dataForm.action = "/korean/pt/before/BD_beforeRequestIaas.do"; } // IaaS [이용희망목록] '요청'
         else if (goodsTyCd == '1004') { document.dataForm.action = "/korean/pt/before/BD_beforeRequestScs.do"; } // SCS [이용희망목록] '요청'

         document.dataForm.method = "POST";
         document.dataForm.submit();
     };
     
     
     
     
     //
     // [이용희망목록]  '보기' 버튼 클릭!!
     //
     var popViewEstimateReply = function(el, logSeq) 
     {
         $(el).colorbox({
             title  : "과거견적서 리스트보기",
             href   : "PD_historyBeforeEstimate.do?logSeq="+logSeq,
             width  : "300",
             height : "400",
             overlayClose : false,
             iframe : true,                
             onClosed: function() // 닫히면.. 선택된 견적서의 내용을 보여주는 팝업창을 띄운다. 
             {                            
                 var notifySeq = $("#notifySeq").val();
                 if  (notifySeq != '')
                     $("#tmpWishLogSeq").click();                 
             }
         });
     };
     
     //
     //  [이용희망목록]  '보기' 팝업(과거견적서 리스트보기)에서 견적서 하나를 선택하였을때 호출되어짐...
     //
     var jsbfRequestEstimateAgain = function( notifyNum
                                               ,notifySeq
                                               ,userId
                                               ,goodsCd
                                               ,langStoreUserId )
     {
         // 선택되 견적서 한건의 정보를 저장한다.
         
         $("#notifyNum").val( notifyNum ) ;
         $("#notifySeq").val( notifySeq ) ;
         $("#userId").val( userId ) ;
         $("#goodsCd").val( goodsCd ) ;
         $("#langStoreUserId").val( langStoreUserId ) ;
     };
     
     //
     // 과거견적서 보기  $("#tmpWishLogSeq") 클릭시 [= (과거견적서 리스트보기)에서 견적서 하나를 선택하였을때 ]
     //
     var jsWishLogSeq = function(el)
     {
         var notifyNum        = $("#notifyNum").val() ;
         var notifySeq        = $("#notifySeq").val() ;
         var userId           = $("#userId").val() ;
         var goodsCd          = $("#goodsCd").val() ;
         var langStoreUserId  = $("#langStoreUserId").val() ;            
         
         $(el).colorbox({
             title  : "견적서 요청내용보기",
             href   : "PD_wishViewEstimateReply.do?notifyNum="+notifyNum+"&notifySeq="+notifySeq+"&userId="+userId+"&goodsCd="+goodsCd+"&langStoreUserId="+langStoreUserId,
             width  : "1090",
             height : "850",
             overlayClose : false,
             iframe : true
         });
     };        
     
     
     // [이용대상 확정] '요청' 버튼 클릭!!
     var jsRequestEstimate = function(goodcode, goodsTyCd)
     {
           /*     
           if($('#confirmCnt').val() <= 0 ){
              alert("해당사업에 확정된 클라우드서비스가 없습니다.");
          }else{ 
          */                 
          $('#goodsCd2').val(goodcode);             
          $('#goodsTyCd').val(goodsTyCd); // 타입을 지정하지 않으면 오류가 남..
          
          if (goodsTyCd == '1001')       { document.dataForm.action = "/korean/pt/bid/BD_requestPaas.do"; } // PaaS [이용대상 확정] '요청'
          else if (goodsTyCd == '1002')  { document.dataForm.action = "/korean/pt/bid/BD_requestSaas.do"; } // SaaS [이용대상 확정] '요청'
          else if (goodsTyCd == '1003')  { document.dataForm.action = "/korean/pt/bid/BD_requestIaas.do"; } // IaaS [이용대상 확정] '요청'

          document.dataForm.method = "POST";
          document.dataForm.submit();
          /*    
          } 
          */
     } 
     
     // [이용대상 확정] '수의계약' 버튼 클릭!!
     var jsOptional = function()
     {
         if($('#confirmCnt').val() != 1 ){
             alert("수의계약 대상이 아닙니다.\n수의계약은 1개의 클라우드서비스와 진행 할 수 있습니다.");
             return false;
         }else{
             if(confirm("선택하신 클라우드서비스를 수의계약 하시겠습니까?")) {
                 $("#dataForm").ajaxSubmit({
                     url      : "ND_myWishOptional.do",
                     type     : "POST",
                     dataType : "text",
                     success  : function(response) {
                         if (response == "true")  {
                             alert("수의계약 완료되었습니다.");
                             location.reload();
                         } else { 
                             alert("수의계약 처리 중 오류가 발생했습니다.");
                             return;
                         }
                     }
                 });
             }
         }
     };

     // [이용대상 확정] '지명공고등록' 버튼 클릭!!
     var jsRequestRegist = function(cntrMothod)
     {
         var userTyCd = $('#userTyCd').val();
         
         if(userTyCd == 1001 || userTyCd == 1002){
             alert("개인회원은 이용하실 수 없습니다");
         //}else if($('#confirmCnt').val() <= 0 ){  // [이용대상 확정] 의 건수
         //    alert("해당사업에 확정된 클라우드서비스가 없습니다.");  
         }else{
             // 입찰 계약방법 셋팅
             $('#cntrMothod').val(cntrMothod);
             
             var type =false;
             
             if(cntrMothod == '1004')
             {
                 var index = new Array();
                 var langStoreNm = new Array();

                 $("input[name=Index]:checked").each(function (i) 
                 {
                     index[i]       = $(this).val();
                     langStoreNm[i] = $("#langStoreNm"+this.value).val();
                 });
                 
                 // 클라우드서비스 지원업체가 전부 동일여부 체크
                 /*
                 if(index.length > 0)
                 {
                     for(var i = 0; i < index.length; i += 1)
                     {
                         for(var j = 0; j < index.length; j += 1)
                         {
                             if(i != j){
                                 if(langStoreNm[i] == langStoreNm[j]){
                                        type=true;
                                        break;      
                                 }
                             }
                         }
                     }
                 }
                 */type=false;
             }
             
             if(type)
             {
                 alert("클라우드서비스 지원업체가 전부 동일하여 지명입찰을 할 수 없습니다.");
             }
             else
             {
                 document.dataForm.action = "/korean/pt/bid/BD_requestRegist.do";
                 document.dataForm.method = "POST";
                 document.dataForm.submit();
             }
         }
     };
     
     // [이용희망목록/이용대상확정]  '서비스/견적 비교' 버튼 클릭!!
     var fnGoodsCheckComp = function(el, flg)
     {
         var goodsCds   = []; // goodsCd 의 리스트  
         var goodsTyCds = [];
         var notifyNums = [];
         var notifySeqs = [];
         var checkCnt   = 0;
         var grpSeq     = '${p_grpSeq}';
         
         if (flg =='N') /*이용희망목록*/
         {                
             $('input:checkbox[name=goods_check]:checked').each(function () 
             { 
                 goodsCds.push($(this).val()); // goodsCd 의 리스트
                 goodsTyCds.push($(this).attr('goodsTyCd'));
                 notifyNums.push($(this).attr('notifyNum'));
                 notifySeqs.push($(this).attr('notifySeq'));
             });
         }
         else /*이용대상확정*/
         {                
             $('input:checkbox[name=Index]:checked').each(function () {
                 items.push($("#confirmGoodsCd"+$(this).val()).val());
             });
         }

         checkCnt = goodsCds.length; // 선택한 상품의 갯수
        
         if (checkCnt == 0 ) 
         {
             alert("비교 서비스  1개이상 선택 하세요.");
             return false;
         } 
         else if (checkCnt > 3 ) 
         {
             alert("선택상품 비교는 최대 3개까지 가능합니다.");
             return false;
         }
         else
         {
             var chk = false ; // 다른 하나라도 발견되면 true
             
             var firstCD = goodsTyCds[0];
             for (var i in goodsTyCds) 
             {
                 if  (firstCD != goodsTyCds[i]) chk = true ;
             }
             
             if (chk == true)    
             {
                 alert("선택상품의 상품구분은 전부 같아야 합니다.");
             }
             else
             {
                 /*
                 checkCnt
                 goodsCds
                 grpSeq
                 goodsTyCd
                 notifyNums
                 notifySeqs
                 */
                 
                 $(el).colorbox({
                     title        : "서비스/견적 비교",
                     href         : "/korean/pt/popup/PD_wishGoodsPop.do?checkCnt="+checkCnt+"&goodsCds="+goodsCds+"&grpSeq="+grpSeq+"&goodsTyCd="+firstCD+"&notifyNums="+notifyNums+"&notifySeqs="+notifySeqs,
                     width        : "1190",
                     height       : "700",
                     overlayClose : false,
                     escKey       : true,
                     iframe       : true
                 });
             }                
         }
     };
     
     // [이용대상확정]  '삭제' 버튼 클릭!!
     //2017-04-18 삭제버튼 취소 -양부장
     var jsConfirmGoodsDelete = function(){
         if(confirm("확정목록 전체를 삭제하시겠습니까?")) {
          $("#dataForm").ajaxSubmit({
             url      : "ND_myWishConfirmGoodsDeleteAction.do",
             type     : "POST",
             dataType : "text",
             success  : function(response) {
                 if (response == "true")  {
                     alert("확정목록 클라우드서비스가 삭제 되었습니다.");
                     location.reload();
                 } else { 
                     alert("확정목록 클라우드서비스 처리 중 오류가 발생했습니다.");
                        return;
                 }
                 }
          });
          }
     }    
     
     
     // [이용대상확정]  검색이력 '보기' 버튼 클릭!!
     var PopHistoryGoodsSearch = function(el,logSeq) {
         $(el).colorbox({
             title  : "견적서 상품 검색이력보기",
             href   : "PD_historyGoodsSearch.do?logSeq="+logSeq,
             width  : "650",
             height : "550",
             overlayClose : false,
             iframe : true
         });
     };
     
	// [이용희망목록]  '계약확정' 버튼 클릭!!
	var jsContractChk = function()
	{
			var items = []; 
      var checkCnt = 0;
      var contrctChk = [];
      var amount = 0;
      
      $('input:checkbox[name=goods_check]:checked').each(function (i)
    		  {
    	  		items.push($(this).val());
    	  		contrctChk.push($(this).attr('contrctChk'));
    		  });
      checkCnt = items.length;
      if (checkCnt <= 0 )
      {
    	  alert("선택상품이 없습니다. 상품을 선택하세요.");
             
        return false;
      }
      else
      {
    	  for (var i=0; i <= contrctChk.length; i++) {
    			if(contrctChk[i] == 'N') {
        	  if (confirm("※(주의)계약확정시 견적을 재요청 할 수 없습니다.\n 선택하신 클라우드서비스를 계약확정 하시겠습니까?"))
        	  {
        		  document.dataForm.goodsCd2.value = items.join(","); // 상품코드 세팅
              document.dataForm.action = "/korean/pt/wish/BD_index.do?cntrct_chk=Y";
              document.dataForm.method = "POST";
              document.dataForm.submit();

              return true;
            }else{
            	return false;
            }
    		  }else{
    			  alert("선택하신 서비스 중 이미 계약 확정이 된 서비스가 있습니다. \n계약 확정된 서비스는 선택에서 제외 하시기 바랍니다.");
    			  return;
    		  }
    	  }
      }
    };
     
     // [이용희망목록]  '표준계약서 다운로드' 버튼 클릭!!
     var popStandardContract = function(el) {            
         $(el).colorbox({
             title  : "표준계약서 다운로드",
             href   : "/cloud_ver3/html_web/popup_download.html",
             width  : "500",
             height : "300",
             overlayClose : false,
             iframe : true
         });
     };
	</script>

</head>
<body>
<form name="dataForm" id="dataForm">
	<input type="hidden" name="userId"     			id="userId"     value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
	<input type="hidden" name="grpSeq"     			id="grpSeq"     value="<c:out value="${p_grpSeq}" />" />    <!--  -->
	<input type="hidden" name="goodsTyCd"  			id="goodsTyCd"  value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003) -->
	<input type="hidden" name="goodArray"  			id="goodArray"  value="" />
	<input type="hidden" name="cntrMothod" 			id="cntrMothod" value="" />
	<input type="hidden" name="confirmCnt" 			id="confirmCnt" value="<c:out value="${pager2.totalNum}"/>" /> <!--  확정목록 서비스수 -->
	<input type="hidden" name="confrmChk"  			id="confrmChk"  value="<c:out value="${p_confrmChk}"/>" />     <!--  공고/견적 생성여부 -->
	<input type="hidden" name="userTyCd"  			id="userTyCd"   value="<c:out value="${userTyCd}"/>"/>
	<input type="hidden" name="goodsCd2"   			id="goodsCd2"   value="" /> <!-- 계약확정 처리를 위한 선택된 아이템 리스트(goodsCd) -->
	<input type="hidden" name="q_viewType" 			id="q_viewType" value="${param.q_viewType}">
	
	<!-- 이 공고 코드로 '재요청' 할 수있게 이전의 사전견적서를 찾아서 복사해온다. -->
	<input type="hidden" name="notifyNum"       id="notifyNum"       value="" />       
	<input type="hidden" name="notifySeq"       id="notifySeq"       value="" />
	<input type="hidden" name="langStoreUserId" id="langStoreUserId" value="" />
	<input type="hidden" name="goodsCd"         id="goodsCd"         value="" /> 
    
    
	<!-- content -->
	<section class="pageTit">
	  <!-- 타이틀 영역 -->
	  <div class="conWrap"><h2>이용희망목록</h2></div>
	  <!--// 타이틀 영역 -->
	</section>
	
	<section class="lay_lnb">
		<div class="conWrap">
		<!--left_area-->
    	<div class="left_area">
      	<h2>사업명</h2>
        <ul>
        	<c:forEach items="${baseList}" var="myWishVo"><%--  ${myWishVo.confrmChk} --%>
            <li id="bizList_${myWishVo.grpSeq}" <c:if test='${p_grpSeq eq myWishVo.grpSeq}'>class="on"</c:if>>
            	<span onclick="jsSearchMyWishDetail('${myWishVo.grpSeq}','${myWishVo.goodsTyCd}','N');" style="cursor: pointer;" title="${myWishVo.auditlogNm}">${myWishVo.auditlogNm}</span>
          		<c:if test='${p_grpSeq eq myWishVo.grpSeq}'><span onclick="jsGoodsDelete('${myWishVo.grpSeq}');" class="icon_delete" style="cursor: pointer;" title="삭제"></span></c:if>
          	</li>
          </c:forEach>
          <c:if test="${empty baseList}">
          	<li><a href="#none" class="off">등록된 사업명이 없습니다.</a></li>
        	</c:if>
        </ul>
      </div>
      <!--left_area end-->
      <div class="contents">
      	<div id="list1">
         <!-- 
         <div class="tab_link e2">
             <a href="#none" class="on" onClick="$('#list1').show();$('#list2').hide();">이용희망목록</a>
             <a href="#none" onClick="$('#list2').show();$('#list1').hide();">이용대상 확정</a>
         </div>
         -->
         <!--이용희망목록 ------------------------------------------------------------------------- 탭 1 (TCM_WISHORDER_DETAIL_L.CONFRM_CHK == Null or 'N')-->
        	<div class="box_info">
          	<ul class="list_st1">
            	<li>견적요청가 총액 : <strong id="beforeAmount"></strong></li>
              <li>견적요청서 미수신 : <strong id="beforeCnt"></strong></li>
            </ul>
          </div>
          <div class="btnArea">
          	<div class="f_l">
            	<span onClick="fnGoodsCheckComp(this,'N'); return false;" class="btns st5" style="cursor: pointer;" title="서비스/견적 비교">서비스/견적 비교</span>
            	&nbsp;<span style="color:red;">* 서비스/견적비교는 동일한 서비스유형만 가능합니다.</span>                        
            </div>
            <div class="f_r">
            	<!-- a href="#" class="btns st5" onclick="jsGoodsConfirm();" >이용대상 확정</a -->                        
              <span class="btns st1" onclick="popStandardContract(this);" title="표준계약서 다운로드" style="cursor: pointer;">표준계약서 다운로드</span>
            </div>
          </div>
          
          <table class="tbl_st3 type_c" summary="이용희망목록">
          	<caption>이용희망목록</caption>
          	<colgroup>
          	<col width="5%"/> 
            	<col width="4%"/>
              <col width="*"/>
              <col width="*"/>
              <col width="*"/>
              <col width="5%"/>
              <col width="5%"/>
              <col width="10%"/>
              <col width="10%"/>
          	</colgroup>
          	<thead>
          		<tr>
	              <th scope="row"><input type="checkbox" name="ckMultiBoxAll1" id="ckMultiBoxAll1" title="전체선택"/><label for="ckMultiBoxAll1" style="display: none;" title="전체선택">전체선택</label></th>
	              <th scope="row">서비스<br/>유형</th>                            
	              <th scope="row">서비스명</th>
	              <th scope="row">제공자명</th>
	              <th scope="row">견적가*</th>
	              <th colspan="2" scope="row">견적관리</th>
	              <th scope="row">계약현황</th>
	              <th scope="row">검색이력</th>
              </tr>
            </thead>
            <tfoot>
	            <tr>
	            	<td colspan="4" style="font-weight:bold;"  scope="row">선택 서비스 견적금액</td>
	              <td class="txt_r" id="beforSelAmount" style="text-align:right;font-weight:bold;"  scope="row">0 원</td>
	              <td colspan="4"  scope="row"></td>
	            </tr>
            </tfoot>
            <tbody>
            	<c:set var="index" value="${pager.indexNo}"/>
              <c:set var="beforeCnt" value="0"/>
              <c:set var="beforeAmount" value="0"/>
              
              <c:forEach items="${pager.list}" var="myWishList" varStatus="status">
              	<input type="hidden" name="goods_index${myWishList.goodsCd}" id="goods_index${myWishList.goodsCd}" value="${index-status.index}"/>
                <input type="hidden" name="goods_langStoreNm${index-status.index}" id ="goods_langStoreNm${index-status.index}" value="${myWishList.langStoreNm}"/>
              <!-- 제공자 아이디 : ${myWishList.langStoreUserId}  -->                        
              <tr>
	              <td scope="row">
	              	<input type="checkbox" id="goods_check" name="goods_check" class="goods_check" value='${myWishList.goodsCd}' goods_amount="${myWishList.splyAmt}" goodsTyCd='${myWishList.goodsTyCd}' notifyNum='${myWishList.notifyNum}' notifySeq='${myWishList.notifySeq}' contrctChk='${myWishList.contrctChk }' />
	              	<label for="goods_check" style="display: none;" title="선택">선택</label>
	              </td>
	              <td scope="row">${myWishList.goodsTyNm}</td>
	              <td style="text-align:left;" scope="row"><a href="/korean/pt/store/software/BD_view.do?goodsCode=${myWishList.goodsCd}&pageUrlNm=null&goodsTyCd=${myWishList.goodsTyCd}&ctgryPath=&_pathLang=korean">${myWishList.goodsNm}</a></td>
	              <td style="text-align:left;" goodsTyNm="${myWishList.goodsTyNm}" langStoreUserId="${myWishList.langStoreUserId}" scope="row">${myWishList.langStoreNm}</td>
	              <td class="txt_r" style="text-align:right;" scope="row">
		              <c:choose>
		              	<c:when test="${fn:length(myWishList.splyAmt) gt 0}">
		                	<fmt:formatNumber value="${myWishList.splyAmt}"/> 원
		                </c:when>
		                <c:when test="${fn:length(myWishList.splyAmt) eq 0}">0 원</c:when>
		              </c:choose>
	              </td>
                <td scope="row">
	                <!--   ${myWishList.confrmChk},${myWishList.confrmChkN} -->
	                <!-- TCN_BEFORE_ESTE_SPLY.CONFM_GBN(=${myWishList.confrmChk}) ( null:'요청', Y:'보기', N:'미수신' ) -->
	                <!-- null:'요청'                                       -->
	                <!--    Y:'보기'    제공자씨앗>사전견적답변관리 발송시 -->
	                <!--    N:'미수신'  없음          요청 저장 후         -->
	                
	                <c:if test="${myWishList.confrmChk ne 'N' and myWishList.confrmChk ne 'Y'}" >
	                    <span onClick="jsbfRequestEstimate('${myWishList.goodsCd}', '${myWishList.goodsTyCd}');" class="btns_s st3" title="요청" style="cursor: pointer;">요청</span> 
	                </c:if>
	                
	                <c:if test="${myWishList.confrmChk eq 'Y' and myWishList.splyLen ne 0}" >
	                    <span onClick="popViewEstimateReply(this,'${myWishList.logSeq}');" class="btns_s st1" title="보기" style="cursor: pointer;">보기</span> 
	                    <c:set var="beforeAmount" value="${beforeAmount+myWishList.splyAmt}"/>                                    
	                </c:if>
	                
	                <c:if test="${myWishList.confrmChk eq 'N' or myWishList.splyLen eq 0}" >
	                    <span class="btns_s st2">미수신</span> <c:set var="beforeCnt" value="${beforeCnt+1}"/>
	                </c:if>
                </td>
                <td scope="row">                            
                    <!-- TCN_BEFORE_ESTE_SPLY.CONFM_GBN(=${myWishList.confrmChk}) ( null:'요청', Y:'보기', N:'미수신' ) -->
                    <!-- Y:'재요청'  제공자씨앗>사전견적답변관리 발송시 -->
                    
                    <c:if test="${myWishList.confrmChk eq 'Y' and myWishList.contrctChk eq 'N'}" > <!-- 답변이있고, 계약확정이 되지않았을 경우 -->
                        <span onClick="jsbfRequestEstimate('${myWishList.goodsCd}', '${myWishList.goodsTyCd}');" class="btns_s st3" title="재요청" style="cursor: pointer;">재요청</span>
                    </c:if>                                
                </td>
                <!-- ..계약현황.. -->
                <td scope="row">
                    <c:if test="${myWishList.contrctChk eq 'Y'}" >확정</c:if>
                </td>
                <td scope="row">
                    <c:if test="myWishList.keyWord ne '' " >
                        <span onClick="Pop1(this);" class="btns st5" title="조회" style="cursor: pointer;">조회</span>
                    </c:if>
                    <span class="btns_s st2" onclick="PopHistoryGoodsSearch(this,'${myWishList.logSeq}');" title="보기" style="cursor: pointer;">보기</span>
                </td>
              </tr>
               <%-- 
               <li>
               <a href="/korean/pt/store/software/BD_view.do?goodsCode=${myWishList.goodsCd}&pageUrlNm=null&goodsTyCd=${myWishList.goodsTyCd}&ctgryPath=&_pathLang=korean'">${myWishList.goodsNm}</a>
               <a href="#" class="sim_opcl">${myWishList.langStoreNm}</a>
               <dl>
                   <dt>검색어:</dt>
                   <dd>${myWishList.keyWord}</dd>
                   <dt>필터조건:</dt>
                   <dd>${myWishList.filterCon}</dd>                            
               </dl>
               </li> 
               --%>
              <input type="hidden" name="goodsConfirmYn_${myWishList.goodsCd}" id="goodsConfirmYn_${myWishList.goodsCd}" value='${myWishList.confrmChk}'/>
              </c:forEach>
              <c:if test="${empty pager.list}">
	            	<tr><td colspan="7">보관된 내역이 없습니다.</tr>
	            </c:if>
            </tbody>
          </table>
          <script> $("#beforeAmount").html('<fmt:formatNumber value="${beforeAmount}" />원'); $("#beforeCnt").html('${beforeCnt}건');</script>
                
          <div class="btnArea" style="margin-top: 10px;">
          	<div class="f_l">
            	<span class="btns st5" onclick="jsStoreGoodsDelete();" title="삭제" style="cursor: pointer;">삭제</span>
            </div>
            <div class="f_r">
            	<span class="btns st5" onclick="jsContractChk();" title="계약확정" style="cursor: pointer;">계약확정</span>
              <!--  a href="#" onclick="jsRequestRegist('1004');"  class="btns st5">지명공고 등록</a -->
            </div>
          </div>
          <a id="tmpWishLogSeq" onclick="jsWishLogSeq(this)"></a> <!-- 지우지말것 견적서일련번호 임시저장 -->
        </div> <!-- <div id="list1"> -->
        
        <!--이용대상 확정 ------------------------------------------------------------------------- 탭 2 (TCM_WISHORDER_DETAIL_L.CONFRM_CHK == 'Y')-->
        <!---------------- 2018.04 부터 폐기처리 
        <div id="list2" style="display:none;">
        	<div class="tab_link e2">
            <a href="#none" onClick="$('#list1').show();$('#list2').hide();">이용희망목록</a>
          	<a href="#none"  class="on"  onClick="$('#list2').show();$('#list1').hide();">이용대상 확정</a>
          </div>
          <div class="box_info">
          	<ul class="list_st1">
            	<li>상세견적가 총액 : <strong id="detailAmount"></strong></li>
              <li>상세견적서 미수신 : <strong id="detailCnt"></strong></li>
            </ul>
          </div>
          <div class="btnArea">
          	<div class="f_l">
            	<a href="#" onClick="fnGoodsCheckComp(this, 'Y'); return false;" c class="btns st5">비교</a>
            </div>
            <div class="f_r">
            	<a href="#" onclick="jsRequestRegist('1004');"  class="btns st5">지명공고 등록</a>
              <- a href="/korean/pt/myCeart/BD_purchsDtlsList.do" class="btns st5">계약대상 선정</a -> 
            </div>
          </div>
           <table class="tbl_st3 type_c">
	           <caption></caption>
	           <colgroup>
	               <col width="5%">
	               <col width="7%">
	               <col width="9%">
	               <col />
	               <col width="11%">
	               <col width="11%">
	               <col width="9%">
	               <col width="9%">
	               <col width="9%">
	               <col width="9%">
	           </colgroup>
	           <thead>
	               <tr>
	                   <th><input type="checkbox" name="ckMultiBoxAll2" id="ckMultiBoxAll2" title="전체선택"/></th>
	                   <th>구분</th>
	                   <th>서비스명</th>
	                   <th>제공자명</th>
	                   <th>사전견적가</th>
	                   <th>상세견적가</th>
	                   <th>상세견적서</th>
	                   <th>검색이력</th>
	                   <th>수의계약</th>
	                   <th>구매형태</th>
	               </tr>
	           </thead>
	           <tfoot>
	               <tr>
	                   <td colspan="4">선택 서비스 견적금액</td>
	                   <td class="txt_r" id="beforSelAmount2">0</td>
	                   <td class="txt_r" id="detailSelAmount2">0</td>
	                   <td colspan="4"></td>
	               </tr>
	           </tfoot>
	           <tbody>
             	<c:set var="index" value="${pager2.indexNo}"/>
              <input type="hidden" name="goodsCd" id="goodsCd" >
              	<c:forEach items="${pager2.list}" var="myWishConfirmList" varStatus="status">
                	<c:if test="${pager2.totalNum eq 1}"> 
	                  <input type="hidden" name="langStoreUserId" id ="langStoreUserId" value="${myWishConfirmList.langStoreUserId}"/>        
	                  <input type="hidden" name="goodsNm" id="goodsNm" value="${myWishConfirmList.goodsNm}">
	                  <input type="hidden" name="userNm" id="userNm" value="${myWishConfirmList.userNm}">
	                  <input type="hidden" name="langStoreNm" id ="langStoreNm" value="${myWishConfirmList.langStoreNm}"/>
	                  <input type="hidden" name="auditlogNm" id ="auditlogNm" value="${myWishConfirmList.auditlogNm}"/>
                  </c:if>
              <tr>
	              <td><input type="checkbox" name="Index" id ="Index" class="Index" before_amount="${myWishConfirmList.splyAmt}" goods_amount="${myWishConfirmList.splyAmt_detail}" value="${index-status.index}"/>
	                  <input type="hidden" id="confirmGoodsCd${index-status.index}" value="${myWishConfirmList.goodsCd}">
	                  <input type="hidden" name="langStoreNm${index-status.index}" id ="langStoreNm${index-status.index}" value="${myWishConfirmList.langStoreNm}"/>
	              </td>
	              <td>${myWishConfirmList.goodsTyNm}</td>
	              <td><a href="/korean/pt/store/software/BD_view.do?goodsCode=${myWishConfirmList.goodsCd}&pageUrlNm=null&goodsTyCd=${myWishConfirmList.goodsTyCd}&ctgryPath=&_pathLang=korean'">${myWishConfirmList.goodsNm}</a></td>
	              <td><a  class="sim_opcl">(${myWishConfirmList.langStoreUserId})__${myWishConfirmList.langStoreNm}</a></td>
	              <td class="txt_r"><fmt:formatNumber value="${myWishConfirmList.splyAmt}"/></td>
	              <td class="txt_r"><fmt:formatNumber value="${myWishConfirmList.splyAmt_detail}"/></td>
	              <td>
                  <- TCN_BEFORE_ESTE_SPLY.CONFM_GBN(=${myWishConfirmList.confrmChk}) ( null:'요청') ->
                  <- null:'요청'  jsRequestEstimate() ->
                  <c:if test="${myWishConfirmList.confrmChk ne 'N' and myWishConfirmList.confrmChk ne 'Y'}" >
                      <a href="#" onclick="jsRequestEstimate('${myWishConfirmList.goodsCd}', '${myWishConfirmList.goodsTyCd}');"  class="btns st3">요청</a>
                  </c:if>
                  <%-- 다른 버튼이 있어야 되지 않을지..? --%>
	              </td>
	              <td><a href="#" class="btns st2" onclick="Pop3(this);">조회</a></td>
	              <td><a href="#" onclick="jsOptional();" class="btns st4">수의계약</a></td>
	              <td></td>
              </tr>
              </c:forEach>
              <c:if test="${empty pager2.list}">
                  <tr><td colspan="10">보관된 내역이 없습니다.</tr>
              </c:if>
	           </tbody>
           </table>
           <script> $("#detailAmount").html('<fmt:formatNumber value="${beforeAmount}" />원'); $("#detailCnt").html('${beforeCnt}건');</script>
                
           <div class="btnArea lef" style="margin-top: 10px;">
           	<a href="#" onClick="jsConfirmGoodsDelete();" class="btns st5">삭제</a>                
           </div>
        </div>-------->

			</div>
		</div>
	</section>
    <!--// content -->
</form>
</body>
</html>