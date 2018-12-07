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
    <title>사전견적서 Iaas</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
        
    <script type="text/javascript">
        
        var date = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        var nowDate = "" + year + month + day;
    
        // Server 영역 행추가
        var jsServerAddRow = function()
        {       
            $("#serverTable01").append($("#serverAddRow01").val());
        };

        // Server 영역 행삭제
        var jsServerDeleteRow = function(obj)
        {
            var trNum = $(obj).parent().closest('tbody').prevAll().length - 1;
            $("#serverTable02 > tbody").children("tr:eq("+trNum+")").remove();
            $(obj).parent().parent().parent().remove();
        };        
        
        // DB 영역 행추가
        var jsDbAddRow = function()
        {       
            $("#dbTable01").append($("#dbAddRow01").val());
        };

        // DB 영역 행삭제
        var jsDbDeleteRow = function(obj)
        {
            var trNum = $(obj).parent().closest('tbody').prevAll().length - 1;
            $(obj).parent().parent().parent().remove();
        };

        // 납품 요구조건의 납품기한 합의후 결정 체크박스 체크 이벤트
        var jsTalkGbnChk = function()
        {
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                $("#delyDt").attr("readonly",false);
                $("#delyTime").prop("disabled", false);
            }else{
                $("#delyDt").val('');
                $("#delyDt").attr("readonly",true);
                $("#delyTime").val("");
                $("#delyTime").parents('span').find("span").html($("#delyTime option:selected").text());
                $("#delyTime").prop("disabled", true);
            }
        };
        
        function nr_num(this_s,type)
        {
            /*
            type
            -> 'int' : 양의 정수
            -> 'float' : 양의 실수
            -> '-int' : 음의 정수 포함
            -> '-float' : 음의 실수 포함
            */
            temp_value = this_s.value.toString();
            regexp = /[^-\.0-9]/g;
            repexp = '';
            temp_value = temp_value.replace(regexp,repexp);
            regexp = '';
            repexp = '';
            
            switch(type)
            {
                case 'int':    regexp = /[^0-9]/g; break;
                case 'float':  regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/; break;                
                case '-int':   regexp = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;break;
                case '-float': regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/; break;
                default : regexp = /[^0-9]/g; break;
            }
            
            switch(type)
            {
                case 'int':    repexp = '';break;
                case 'float':  repexp = '$2$3$5';break;
                case '-int':   repexp = '$1$2$4';break;
                case '-float': repexp = '$1$2$3$5'; break;
                default : regexp = /[^0-9]/g; break;
            }
            
            temp_value = temp_value.replace(regexp,repexp);
            this_s.value = temp_value;
        }

        // 숫자만 입력하도록 체크
        function jsOnlyNumber(event)
         {
             var keyID = (event.which) ? event.which : event.keyCode;
              if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
            else return false;
        }
         
        // 숫자만 입력하도록 체크2
        function removeChar(event) 
        {
            event = event || window.event;
             var keyID = (event.which) ? event.which : event.keyCode;
              if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) return;
            else event.target.value = event.target.value.replace(/[^0-9]/g, "");
        }
        // 첨부파일 반영
        var jsFileChk = function(inputId, inputIdFake){
            document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
            
            var inputFile = document.getElementById(inputId);
            var filePath = inputFile.value;
            
            if(filePath == ""){
                return false;
            }
            document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
        };

        // 첨부파일 삭제
        var jsFileDelete = function(inputId, inputIdFake){
            document.getElementById(inputIdFake).value="";
            $("input[name="+inputId+"]").val("");
        }

        // 견적요청서 취소
        var jsCommentCancel = function()
        {
            history.back();    
        }
     
        // 견적요청서 발송
        var jsRequestSend = function()
        {           
            // 입력 필수값 체크
            if(checkEditor())
            {
                //if (confirm("견적요청서를 발송 하시겠습니까?")) 
                //{
                    // VAT여부
                    if($('input:radio[name=vatGbnRadio]:checked').attr("id") == "vatGbnY"){
                        $("#vatGbn").val("Y");
                    }else{
                        $("#vatGbn").val("N");
                    }
                    
                    // 합의후 결정 여부
                    if($('#talkGbnChkbox').is(":checked") == true){
                        $("#talkGbn").val("Y");
                    }else{
                        $("#talkGbn").val("N");
                    }
                    
                    // 첨부파일
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });

                    $("#dataForm").attr("action", "ND_beforeRequestIaas2Action.do");
                    $("#dataForm").submit();
                //}
            }
        };

        // 견적요청서 필수 입력값 체크
        var checkEditor = function()
        {
           // 답변 만료일
           if($("#rplyDt").val() == null || $("#rplyDt").val() == ""){
               alert("답변 만료일을 입력해주세요.");
               $("#rplyDt").focus();
               return false;
           }else{
               // 응답 만료일이 현재일 이전일 경우 return
               var rplyDt = $("#rplyDt").val().replace(/-/gi,"");
               if(nowDate > rplyDt){
                   alert("답변 만료일은 현재일 이전일수 없습니다.");
                   $("#rplyDt").focus();
                   return false;
               }
           }
           
           var useFromDt = $("#useFromDt").val().replace(/-/gi,"");
           var useToDt   = $("#useToDt").val().replace(/-/gi,"");
           
           if  ((useToDt == "" && useFromDt != "") || (useToDt != "" && useFromDt == ""))
           {
               alert("사용기간은 둘다 없거나, 둘다 있어야 합니다.");
               return false;
           }
           
           if  ((useToDt != "" && useFromDt != "") && (useToDt < useFromDt))
           {
               alert("사용기간은 '부터'가 '까지'보다 먼저 나와야 합니다.");
               return false;
           }

           // 기관명
           if($("#realDmndOrgn").val() == null || $("#realDmndOrgn").val() == ""){
               alert("기업/기관명을 입력해주세요.");
               $("#realDmndOrgn").focus();
               return false;
           }


            return true;
        };
        
         
        // 체크 _ DB
        var clkDB = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#dbTable01').find('input[name=dbUse]').val("");
                $('#dbTable01').find('input[name=dbOs]').val("");
                $('#dbTable01').find('input[name=dbCpu]').val("");
                $('#dbTable01').find('input[name=dbMemory]').val("");
                $('#dbTable01').find('input[name=dbDisk]').val("");
                $('#dbTable01').find('input[name=dbQnty]').val("");
                
                var size = $('#dbTable01').find('tbody').size();
                for (i = 1; i < size; i++)
                {
                    $('#dbTable01').find('tbody').eq(1).remove();    
                }
                
                $('#dbIp').val("");
                $('#dbNetwork').val("");
                $('#dbAddDisk').val("");
                $('#dbBackStorg').val("");
                
                $('#divDB').hide();
            }
            else
            {
                $('#divDB').show(); 
            }            
        } ;

        // 체크 _ 스토리지
        var clkStorage = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#dbStorgSpace').val("");
                $('#dbTransVlmn').val("");                               
                
                $('#divStorage').hide();
            }
            else
            {
                $('#divStorage').show(); 
            }           
        } ;

        // 체크 _ CDN
        var clkCDN = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#cdnTransVlmn').val("");
                $('#cdnRequCnt').val("");
                
                $('#divCDN').hide();
            }
            else
            {
                $('#divCDN').show(); 
            }            
        } ;

        var a = 1 ;
        
        // 체크 _ 웹방화벽
        var clkWebFirewall = function(obj)
        {   
            if  (!$(obj).is(':checked')) 
            {
                $('#webGoodsKind').val("");
                $('#webAccess').val("");
                
                $("#webGoodsKind option[value='']").attr("selected", true);                
                $('#spanWebGoodsKind').find('span').text( $("#webGoodsKind option[value='']").text() );
                
                $('#divWebFirewall').hide();
            }
            else
            {                
                // 디폴트가 single....
                $("#webGoodsKind option[value='1001']").attr("selected", true);                
                $('#spanWebGoodsKind').find('span').text( $("#webGoodsKind option[value='1001']").text() );
                
                $('#divWebFirewall').show(); 
            }            
        } ;

        // 체크 _ 모니터링
        var clkMonitoring = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#mntingVm').val("");
                $('#mntingIdCnt').val("");
                
                $('#divMonitoring').hide();
            }
            else
            {
                $('#divMonitoring').show(); 
            }            
        } ;

        // 체크 _ 백업
        var clkBackup = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#bakupCnt').val("");
                $('#bakupStorg').val("");
                
                $('#divBackup').hide();
            }
            else
            {
                $('#divBackup').show(); 
            }            
        } ;

        // 체크 _ 관리기능
        /* 
        var clkManageFunc = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#divManageFunc').hide();
            }
            else
            {
                $('#divManageFunc').show(); 
            }            
        } ; 
        */

        // 체크 - 부가서비스
        var clkAddedService = function(obj)
        {
            if  (!$(obj).is(':checked')) 
            {
                $('#sectyVpn').val("");
                $('#sectySslvpn').val("");
                $('#divAddedService').hide();
            }
            else
            {
                $('#divAddedService').show(); 
            }            
        } ;
        
        
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
    </script>
    
    <style type="text/css">
     
        input[type=text].width50p { width : 50%; }
        
    </style>

</head>
<body>
	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
  	<input type="hidden" name="bidGbnCd"  id="bidGbnCd"  value="1004" /> <!-- 입찰종류 (1004 : 사전견적) -->
    <input type="hidden" name="userId"    id="userId"    value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="grpSeq"    id="grpSeq"    value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd" id="goodsTyCd" value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="goodsCd"   id="goodsCd"   value="<c:out value="${p_chkGoodsCode}" />" /> <!-- goodsCd -->
    <input type="hidden" name="goodArray" id="goodArray" value="" />
    <input type="hidden" name="vatGbn"    id="vatGbn"    value="" />
    <input type="hidden" name="talkGbn"   id="talkGbn"   value="" />
    <input type="hidden" name="userNm"    id="userNm"    value="${sessionScope['__usk'].userNm}" />

    <!-- content -->
    <section class="pageTit">
        <!-- 타이틀 영역 -->
        <div class="conWrap">
            <h2>견적요청</h2>
        </div>
        <!--// 타이틀 영역 -->
    </section>
    
    <div class="conWrap detailRequ iaas">
    	<%-- 
        <h3>문의대상 서비스</h3>
        <table class="tbl_st1 qSer">
            <thead>
                <tr>
                    <th>공급사</th>
                    <th>서비스</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${pager.list}" var="myWishList" varStatus="status">
                <tr>
                    <td>${myWishList.langStoreNm}</td>
                    <td>${myWishList.goodsNm}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table> 
      --%>
        
      <table class="tbl_st1 qSer" summary="시스템 요구사항(필요한 구성 항목을 선택하세요.)">
	      <caption>시스템 요구사항</caption>
	      <colgroup>
	      	<col width="*"/>
	      </colgroup>
	      <thead>
	      	<tr>                    
	        	<th scope="row">시스템 요구사항(필요한 구성 항목을 선택하세요.)</th>
	        </tr>
	      </thead>
	      <tbody>
        	<tr>
          	<td>
            	<label><input type="checkbox" name="chkServer"        id="chkServer"        value="Y" checked="checked" disabled="disabled"/> 서버</label>
              <label><input type="checkbox" name="chkDb"            id="chkDb"            value="Y" onclick="clkDB(this);"/> DB</label>
              <label><input type="checkbox" name="chkStorage"       id="chkStorage"       value="Y" onclick="clkStorage(this);"/> 스토리지</label>
              <label><input type="checkbox" name="chkCdn"           id="chkCdn"           value="Y" onclick="clkCDN(this);"/> CDN</label>
              <label><input type="checkbox" name="chkWebFirewall"   id="chkWebFirewall"   value="Y" onclick="clkWebFirewall(this);"/> 웹방화벽</label>
              <label><input type="checkbox" name="chkMonitoring"    id="chkMonitoring"    value="Y" onclick="clkMonitoring(this);"/> 모니터링</label>
              <label><input type="checkbox" name="chkBackup"        id="chkBackup"        value="Y" onclick="clkBackup(this);"/> 백업</label>
              <!-- <label><input type="checkbox" name="chkManageFunc"    id="chkManageFunc"    value="Y" onclick="clkManageFunc(this);"/> 관리기능</label> -->
              <label><input type="checkbox" name="chkAddedService"  id="chkAddedService"  value="Y" onclick="clkAddedService(this);"/> 부가서비스</label>                  
            </td>
          </tr>
        </tbody>
      </table>
      
      <!--1. 서버-->
      <h3>▶서버 요구사항</h3>
      <table id="serverTable01" class="tbl_st4" summary="서버 요구사항">
      	<caption>서버 요구사항</caption>
      	<colgroup>
	        <col width="20%" />
	        <col width="20%" />
	        <col width="20%" />
	        <col width="10%" />
	        <col width="10%" />
	        <col width="10%" />
	        <col width="10%" />
        </colgroup>
        <thead>
	        <tr>
	        	<th scope="row" colspan="7">서버정보</th>
	        </tr>
	        <tr>
<!-- style="padding: 14px 20px 14px 20px; border-bottom: 1px solid #ebebeb; background-color: #f9f9f9; white-space: nowrap; text-align: left; font-size: 14px; color: #1b1b1b;" -->
	          <th scope="col"><label for="serverUse" class="lb">용도</label></th>
	          <th scope="col"><label for="serverOs"  class="lb">OS</label></th>
	          <th scope="col"><label for="serverCpu" class="lb">CPU(Vcore)</label></th>
	          <th scope="col"><label for="serverMemory" class="lb">메모리(GB)</label></th>
	          <th scope="col"><label for="serverDisk" class="lb">Disk(GB)</label></th>
	          <th scope="col" colspan="2"><label for="serverQnty" class="lb">수량(CM)</label></th>
	        </tr>
        </thead>
        <tbody>
	        <tr>
	          <td><input type="text" id="serverUse" name="serverUse" title="용도"/></td>
	          <td><input type="text" id="serverOs"  name="serverOs"  title="OS"/></td>
	          <td><input type="text" id="serverCpu" name="serverCpu" title="CPU(Vcore)"/></td>
	          <td class="num">
	          	<div class="unit">
	            	<input type="text" id="serverMemory" name="serverMemory" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" title="메모리(GB)"/>
	            </div>
	          </td>
	          <td class="num">
	          	<div class="unit">
	            	<input type="text" id="serverDisk" name="serverDisk" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" title="Disk(GB)"/>
	            </div>
	          </td>
	          <td class="num">
	            <div class="unit">
	            	<input type="text" id="serverQnty" name="serverQnty" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" title="수량(CM)"/>
	            </div>
	          </td>
	          <td><!-- a href="#" onclick="jsServerAddRow(); return false;" class="btns st3">행추가</a --></td>
	        </tr>
        </tbody>
        </table>
 <!--         
        <textarea id="serverAddRow01" >
        <tbody>
            <tr>
                <td><input type="text" name="serverUse" /></td>
                <td><input type="text" name="serverOs" /></td>
                <td><input type="text" name="serverCpu" /></td>
                <td><input type="text" name="serverMemory" /></td>
                <td><input type="text" name="serverDisk" /></td>
                <td><input type="text" name="serverQnty" /></td>
                <td><a href="#" onclick="jsServerDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
            </tr>    
        </tbody>
        </textarea>
 -->
        <table id="serverTable02" class="tbl_st4" summary="부가정보(서버)">
	        <caption>부가정보(서버)</caption>
	        <colgroup>
	        	<col width="10%"/>
	        	<col width="*"/>
	        	<col width="10%"/>
	        	<col width="*"/>
	        	<col width="10%"/>
	        	<col width="*"/>
	        </colgroup>
	        <tbody>
	        	<tr><th scope="col" colspan="6">부가정보(서버)</th></tr>
	          <tr>
		          <th scope="col">공인 IP 수량</th>    
		          <td class="num">
		          	<div class="unit">
		            	<input type="text" class="width50p"  name="serverIp" id="serverIp" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> <label for="serverIp">개/월</label>
		            </div>    
		          </td>
		          <th scope="col">네트워크 트래픽</th> 
		          <td class="num">
		            <div class="unit">
		            	<input type="text" class="width50p"  name="serverNetwork" id="serverNetwork" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> <label for="serverNetwork">GB/월</label>
		            </div>    
		          </td>    
		          <th scope="col">GSLB</th>
		          <td class="num">
		            <div class="unit">
		            	<input type="text" class="width50p"  name="serverGslb" id="serverGslb" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> <label for="serverGslb">개/월</label>
		            </div>    
		          </td>
	          </tr>
	          <tr>    
		          <th scope="col">로드밸런서</th>      
		          <td class="num">
		            <div class="unit">
		            	<input type="text" class="width50p"  name="serverLdbl" id="serverLdbl" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> <label for="serverLdbl">GB/월</label>
		            </div>
		          </td>    
		          <th scope="col">스냅샷</th>          
		          <td class="num">
		            <div class="unit">
		            	<input type="text" class="width50p"  name="serverSnap" id="serverSnap" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> <label for="serverSnap">GB/월</label>
		            </div>
		          </td>
		          <th scope="col">이미지</th>          
		          <td class="num">
		            <div class="unit">
		            	<input type="text" class="width50p"  name="serverImg" id="serverImg" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> <label for="serverImg">GB/월</label>
		            </div>
		          </td>
	          </tr>
	        </tbody>
      	</table>
        
        <!-- 2. DB-->

		<div id="divDB" style="margin-top: 20px;">
    <h3>▶DB 요구사항</h3>
    	<table id="dbTable01" class="tbl_st4" summary="DB 요구사항">
    		<caption>DB 요구사항</caption>
	      <colgroup>
	        <col width="20%" />
	        <col width="20%" />
	        <col width="20%" />
	        <col width="10%" />
	        <col width="10%" />
	        <col width="10%" />
	        <col width="10%" />
	      </colgroup>
	      <thead>
	        <tr>
	        	<th scope="row" colspan="7">DB정보</th>
	        </tr>
	        <tr>
	          <th scope="row"><label for="dbUse" class="lb">용도</label></th>
	          <th scope="row"><label for="dbOs"  class="lb">OS</label></th>
	          <th scope="row"><label for="dbCpu" class="lb">CPU(Vcore)</label></th>
	          <th scope="row"><label for="dbMemory" class="lb">메모리(GB)</label></th>
	          <th scope="row"><label for="dbDisk"  class="lb">Disk(GB)</label></th>
	          <th scope="row" colspan="2"><label for="dbQnty"  class="lb">수량(CM)</label></th>
	        </tr>
        </thead>
        <tbody>
	        <tr>
	          <td><input type="text" id="dbUse" name="dbUse" title="용도" /></td>
	          <td><input type="text" id="dbOs"  name="dbOs"  title="OS" /></td>
	          <td><input type="text" id="dbCpu" name="dbCpu" title="CPU(Vcore)" /></td>
	          <td class="num">
	            <div class="unit">
	            	<input type="text" id="dbMemory" name="dbMemory" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" title="메모리(GB)" />
	            </div>
	          </td>
	          <td class="num">
	          	<div class="unit">
	            	<input type="text" id="dbDisk" name="dbDisk" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" title="Disk(GB)" />
	            </div>    
	          </td>
	          <td class="num">
	            <div class="unit">
	            	<input type="text" id="dbQnty" name="dbQnty" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" title="수량(CM)" />
	            </div>
	          </td>
	          <td><!-- a href="#" onclick="jsDbAddRow(); return false;" class="btns st3">행추가</a --></td>
	        </tr>
        </tbody>
      </table>
<!-- 
            <textarea id="dbAddRow01" style="display:none">
            <tbody>
                <tr>
                    <td><input type="text" name="dbUse" /></td>
                    <td><input type="text" name="dbOs" /></td>
                    <td><input type="text" name="dbCpu" /></td>
                    <td class="num">
                        <div class="unit">
                            <input type="text" name="dbMemory" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />    
                        </div>
                    </td>
                    <td class="num">
                        <div class="unit">
                            <input type="text" name="dbDisk" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />    
                        </div>
                    </td>
                    <td class="num">
                        <div class="unit">
                            <input type="text" name="dbQnty" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />    
                        </div>
                    </td>
                    <td><a href="#" onclick="jsDbDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
                </tr>    
            </tbody>
            </textarea>
 -->    
      <table  class="tbl_st4" summary="부가정보(DB)">
	      <caption>부가정보(DB)</caption>
	      <colgroup>
	      	<col width="10%"/>
	      	<col width="10%"/>
	      	<col width="10%"/>
	      	<col width="10%"/>
	      </colgroup>
      	<thead>
        	<tr>
          	<th scope="row" colspan="4">부가정보(DB)</th>
          </tr>
          <tr>
	          <th scope="row"><label for="dbIp" class="lb">공인 IP 수량</label></th>
	          <th scope="row"><label for="dbNetwork" class="lb">네트워크 트래픽</label></th>
	          <th scope="row"><label for="dbAddDisk" class="lb">추가 디스크</label></th>
	          <th scope="row"><label for="dbBackStorg" class="lb">백업 스토리지</label></th>
          </tr>
        </thead>
        <tbody>
	        <tr>
	          <td class="num">
	            <div class="unit">
	            	<input type="text" class="width50p" id="dbIp" name="dbIp" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> 
	            	<label for="dbIp">개/월</label>
	            </div>
	          </td>
	          <td class="num">
	            <div class="unit">
	            	<input type="text" class="width50p" id="dbNetwork" name="dbNetwork" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
	            	<label for="dbNetwork">GB/월</label>
	            </div>
	          </td>
	          <td class="num">
	            <div class="unit">
	              <input type="text" class="width50p" id="dbAddDisk" name="dbAddDisk" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
	              <label for="dbAddDisk">GB/월</label>
	            </div>
	          </td>
	          <td class="num">
	            <div class="unit">
	              <input type="text" class="width50p" id="dbBackStorg" name="dbBackStorg" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
	              <label for="dbBackStorg">GB/월</label>
	            </div>
	          </td>                
	        </tr>
        </tbody>
      </table>
    </div>
    
    <!--3. 스토리지-->
    <div id="divStorage" style="margin-top: 20px;">
    <h3>▶스토리지</h3>
    	<table class="tbl_st4" summary="스토리지">
    		<caption>스토리지</caption>
    		<colgroup>
    			<col width="10%"/>
    			<col width="*"/>
    			<col width="10%"/>
    			<col width="*"/>
    		</colgroup>
      	<tbody>
	        <tr>
	          <th scope="col">저장공간</th>    
	          <td class="num">
	            <div class="unit">
	            	<input type="text" class="width50p" name="dbStorgSpace" id="dbStorgSpace" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
	            	<label for="dbStorgSpace">GB/월</label>
	            </div>
	          </td>
	          <th scope="col">전송량</th>                    
	          <td class="num">
	            <div class="unit">
	              <input type="text" class="width50p" name="dbTransVlmn" id="dbTransVlmn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
	              <label for="dbTransVlmn">GB/월</label>
	            </div>    
	          </td>
	        </tr>
        </tbody>
      </table>
    </div>
    
    <!--4. CDN-->
    <div id="divCDN" style="margin-top: 20px;">
    <h3>▶CDN</h3>
    	<table class="tbl_st4" summary="CDN">
    		<caption>CDN</caption>
    		<colgroup>
    			<col width="10%"/>
    			<col width="*"/>
    			<col width="10%"/>
    			<col width="*"/>
    		</colgroup>
    		<tbody>
	        <tr>
	          <th scope="col">전송량</th>            
	          <td class="num">
	            <div class="unit">
	                <input type="text" class="width50p" name="cdnTransVlmn" id="cdnTransVlmn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	                <label for="cdnTransVlmn">GB/월</label>
	            </div>
	          </td>
	          <th scope="col">예상 요청 수</th>    
	          <td class="num">
	          	<div class="unit">
	            	<input type="text" class="width50p" name="cdnRequCnt" id="cdnRequCnt" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> 
	            	<label for="cdnRequCnt">건/월</label>
	          	</div>
	        	</td>
	      	</tr>
	    	</tbody>
	   </table>
   </div>

        <!-- 
        
        5. 웹방화벽  
        
        -->
        
		<div id="divWebFirewall" style="margin-top: 20px;">
		<h3>▶웹방화벽</h3>
	    <table class="tbl_st4" summary="웹방화벽">
	    	<caption>웹방화벽</caption>
	    	<colgroup>
	    		<col width="10%"/>
	    		<col width="*"/>
	    		<col width="10%"/>
	    		<col width="*"/>
	    	</colgroup>
		    <tbody>
	        <tr>
	           <th scope="col">서비스유형</th>    
	           <td>
	               <!-- 2074 -->
	               <span id="spanWebGoodsKind" class="sel_box">
	                   <select id="webGoodsKind" name="webGoodsKind">
	                       <option value="">선택</option>
	                       <!-- 2074 -->
	                       <c:forEach items="${webGoodsKindList}" var="webGoodsKind" varStatus="status">
	                           <option value="${webGoodsKind.PRVCD}">${webGoodsKind.PRVNM}</option>    
	                       </c:forEach>
	                   </select><label for="webGoodsKind"></label>
	               </span>
	           </td>                        
	           <th scope="col">처리속도</th>                    
	           <td class="num">
	               <div class="unit">
	                   <input type="text" class="width50p" name="webAccess" id="webAccess" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	                   <label for="webAccess">Mbps</label> 
	               </div>
	           </td>
	        </tr>
		    </tbody>
	    </table>
		</div>

        <!-- 
        
        6. 모니터링  
        
        -->
        
        <div id="divMonitoring" style="margin-top: 20px;">
        
            <h3>▶모니터링</h3>
            <table class="tbl_st4" summary="모니터링">
            <caption>모니터링</caption>
            <colgroup>
            <col width="10%"/>
            <col width="*"/>
            <col width="10%"/>
            <col width="*"/>
            </colgroup>
            <tbody>
                <tr>
                    <th scope="col">VM</th>
                    <td class="num">
                        <div class="unit"> 
                            Vcore <input type="text" class="width50p" name="mntingVm" id="mntingVm" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
                            <label for="mntingVm">GB/월</label>
                        </div>
                    </td>
                    <th scope="col">계정 수량</th>
                    <td class="num">
                        <div class="unit">
                            <input type="text" class="width50p" name="mntingIdCnt" id="mntingIdCnt" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> 
                            <label for="mntingIdCnt">개/월</label>
                        </div>
                    </td>
                </tr>
            </tbody>
            </table>
        </div>

        <!-- 
        
        7. 백업  
        
        -->
        
        <div id="divBackup" style="margin-top: 20px;">
        
            <h3>▶백업</h3>
            <table class="tbl_st4" summary="백업">
            <caption>백업</caption>
            <colgroup>
            <col width="10%"/>
            <col width="*"/>
            <col width="10%"/>
            <col width="*"/>
            </colgroup>
            <tbody>
                <tr>
                    <th scope="col">백업서버 수량 </th>
                    <td class="num">
                        <div class="unit">
                            <input type="text" class="width50p" name="bakupCnt" id="bakupCnt" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> 
                            	<label for="bakupCnt">개/월</label>
                        </div>
                    </td>
                    <th scope="col">저장용량</th>                    
                    <td class="num">
                        <div class="unit">
                            <input type="text" class="width50p" name="bakupStorg" id="bakupStorg" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
                            <label for="bakupStorg">GB/월</label>
                        </div>
                    </td>
                </tr>
            </tbody>
            </table>
        </div>
        
        <!-- 
        
        8. 관리기능 ??? 
        
        -->
        
        <!-- 
        
        9. 부가서비스 
        
        -->
        
        <div id="divAddedService" style="margin-top: 20px;">
            <h3>▶부가서비스</h3>
            <table class="tbl_st4" summary="부가서비스">
            <caption>부가서비스</caption>
            <colgroup>
            <col width="10%"/>
            <col width="*"/>
            <col width="10%"/>
            <col width="*"/>
            </colgroup>
            <thead>
	            <tr>
	            	<th scope="row" colspan="4">부가서비스_보안관리</th>
	            </tr>
            </thead>
            <tbody>
	            <tr>
	              <th scope="col">VPN</th>
	              <td class="num">
	                <div class="unit">
	                    IPSec <input type="text" class="width50p" name="sectyVpn" id="sectyVpn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" /> 
	                    <label for="sectyVpn">Mbps/월</label><br />(예시 : IPSec 100 Mbps/월)
	                </div>
	              </td>
	              <th scope="col">SSL VPN</th>                    
	              <td class="num">
	                <div class="unit">
	                    <input type="text" class="width50p" name="sectySslvpn" id="sectySslvpn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" /> 
	                    <label for="sectySslvpn">Users/월</label>
	                </div>
	              </td>
	            </tr>
            </tbody>
            </table>
            
            <table class="tbl_st4" summary="부가서비스_기타">
            <caption>부가서비스_기타</caption>
            <colgroup>
            	<col width="*"/>
            </colgroup>
            <thead>
	            <tr>
	                <th scope="row">부가서비스_기타</th>
	            </tr>
            </thead>    
            <tbody>
	            <tr>
	               <td>
	               	<input type="text" name="addedEtc" id="addedEtc" title="부가서비스_기타"/><label for="addedEtc"></label>
	               </td>
	            </tr>
            </tbody>
            </table>
        </div>

        <h3>납품 요구조건</h3>
        <table class="tbl_st4" summary="납품 요구조건">
					<caption>납품 요구조건</caption>
					<colgroup>
					<col width="10%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">사용기간</th>
							<td class="term" colspan="3">
								<input type="text" id="useFromDt" name="useFromDt" readonly="readonly"/><label for="useFromDt"></label>
                ~ 
                <input type="text" id="useToDt" name="useToDt" readonly="readonly"/><label for="useToDt"></label>
                <span id="useTerm"> <%-- (12개월 00일) --%></span>
                <input type="hidden" id="puchBudgetAmt" name="puchBudgetAmt" />
              </td>
              <!-- th>구매예산(원)</th>
              <td class="vat">
                    <div class="unit">
                        <i>원</i>                
                        <div><input type="text" id="puchBudgetAmt" name="puchBudgetAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></div>
                    </div>
                </td -->
            </tr>
            <tr>
                <th scope="col">희망 구매가</th>
                <td class="vat">
                    <div class="unit">
                        <i>원</i>
                        <div>
                        <!-- input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  -->
                        <input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onchange="getNumber(this);" onkeyup="getNumber(this);">
                        <label for="hopePuchAmt"></label>
                        </div>
                    </div>
                    <input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked"/> <label for="vatGbnY">VAT포함</label>
                    <input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"/> <label for="vatGbnN">VAT미포함</label>
                </td>
                <th  scope="col" class="requ">답변 만료일</th>
                <td class="term">
                	<input type="text" id="rplyDt" name="rplyDt" /><label for="rplyDt"></label>
                </td>
            </tr>
            <!-- <tr>
                <th>납품 장소</th>
                <td colspan="3"><input type="text" id="delyPlac" name="delyPlac"/></td>
            </tr> -->
            <tr>
                <th  scope="col">첨부파일</th>
                <td colspan="3">
                    <div class="uploadFile">
                        <input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/><label for="delyFileInput"></label>
                        <div>
                            <img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('delyFile', 'delyFileInput');" alt="삭제" />                            
                            <span class="btns st3"> 파일선택
                                <input type="file" name="delyFile" id="delyFile" class="delyFile" title="파일찾기" onchange="jsFileChk('delyFile', 'delyFileInput');"/>
                            </span>
                            <label for="delyFile"></label>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="col">추가문의</th>
                <td colspan="3"><textarea id="notifyCont" name="notifyCont" title="추가문의"></textarea><label for="notifyCont"></label></td>
            </tr>
        	</tbody>
        </table>
                
        <h3>요청자 정보</h3>
        <table class="tbl_st4" summary="요청자 정보">
					<caption>요청자 정보</caption>
					<colgroup>
					<col width="10%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="*"/>
					</colgroup>
					<tbody>
            <tr>
                <th scope="col" class="requ">작성자</th>
                <td>
                	${sessionScope['__usk'].userNm}
                	<input type="hidden" name="goodsChargerNm" value="${sessionScope['__usk'].userNm}" />
                </td>
                <th scope="col" class="requ">휴대전화</th>
                <td>${sessionScope['__usk'].mbtlnum}</td>
            </tr>
            <tr>
                <th scope="col" class="requ">기업/기관명</th>
                <td>
					        <c:if test="${sessionScope['__usk'].userTyCd eq '3001' or sessionScope['__usk'].userTyCd eq '3002'}">
					        	<c:set var="realDmndOrgn" value="${sessionScope['__usk'].pblinsttUpdtAt}"/>
					        	<c:set var="realDmndBuseoCd" value="${sessionScope['__usk'].buseoCode}"/>
					        </c:if>
					        <c:if test="${sessionScope['__usk'].userTyCd eq '2001' or sessionScope['__usk'].userTyCd eq '1001'}">
					        	<c:set var="realDmndOrgn" value="${sessionScope['__usk'].cmpnyNm}"/>
					        	<c:set var="realDmndBuseoCd" value=""/>
					        </c:if>
					        	<input type="text" 		id="realDmndOrgn"			name="realDmndOrgn" value="${realDmndOrgn}" style="width:450px" readonly="readonly"/><label for="realDmndOrgn"></label>
					          <input type="hidden"	id="realDmndOrgnCd"		name="realDmndOrgnCd" value=""/>
					          <input type="hidden"	id="realDmndBuseoCd"	name="realDmndBuseoCd" value="${realDmndBuseoCd }"/>
					          <!-- <input type="button"	id="dmndOrgnSearch"		name="dmndOrgnSearch" alt="기관명 조회" value="기관명 조회" class="btns st3" onclick="fnDmandSearch(this)"/> -->
                </td>
                <th scope="col" class="requ">이메일</th>
                <td><a href="mailto:${sessionScope['__usk'].email}">${sessionScope['__usk'].email}</a></td>
            </tr>
            <tr>
                <th scope="col">직책</th>
                <td><input type="text" id="userPosition" name="userPosition"/><label for="userPosition"></label></td>
                <th scope="col">대표전화</th>
                <td class="tel">
	                <input type="text" id="goodsChargerCttpc1" name="goodsChargerCttpc1"/><label for="goodsChargerCttpc1"></label>
	                 - 
	                <input type="text" id="goodsChargerCttpc2" name="goodsChargerCttpc2"/><label for="goodsChargerCttpc2"></label>
	                 -
	                <input type="text" id="goodsChargerCttpc3" name="goodsChargerCttpc3"/><label for="goodsChargerCttpc3"></label>
                </td>
            </tr>    
        	</tbody>                
        </table>

        <div class="btnArea rig">
        	<a href='#' onclick="jsCommentCancel();" class="btns st1 icn icnDel"> 취 소 </a>
          <a href="#" onclick="jsRequestSend();"   class="btns st1 icn icnSend"> 발 송 </a>
        </div>
    </div>
    <!--// content -->
	</form>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
  <script type="text/javascript" src="/resources/cmmnty/common/js/fakeselect.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/notice/jquery.notice.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/printPreview/jquery.print-preview.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/cookie/jquery.cookie.js"></script>
  <script type="text/javascript" src="/resources/web/analyze/tracking/js/detector.js"></script>
 <!-- datepicker -->
  <link rel="stylesheet" href="/resources/openworks/spi/jquery/datepicker/jquery.datepicker.css" />
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.ui.core.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script.min.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script-addon.js"></script>
  <script src="/resources/openworks/spi/openworks/openworks.ui.js"></script>
  <script>
  
    function explode()
    {
        $('#divDB').hide();
        $('#divStorage').hide();
        $('#divCDN').hide();
        $('#divWebFirewall').hide();
        $('#divMonitoring').hide();
        $('#divBackup').hide();
        $('#divAddedService').hide();
    }
    
    $(document).ready(function() 
    {
        $( "#useFromDt, #useToDt, #rplyDt" ).datepicker({
              showOn: "both", 
              buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
              buttonImageOnly: false,
              buttonText: "달력"
        });
        
        setTimeout(explode, 1000);        
    });
  </script>
  <!--// datepicker -->
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
</body>
</html>