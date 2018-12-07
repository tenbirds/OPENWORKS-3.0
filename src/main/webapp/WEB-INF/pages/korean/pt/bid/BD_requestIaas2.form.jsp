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
    <title>상세정보(견적)요청서 Iaas</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
        
    <style type="text/css">
     
        input[type=text].width50p { width : 50%; }
        
    </style>

    <script type="text/javascript">
        
        var date = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        var nowDate = "" + year + month + day;
        
        $().ready(function() {
        }); //ready
    
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

                    $("#dataForm").attr("action", "ND_requestIaas2Action.do");
                    $("#dataForm").submit();
                //}
            }
        };

        // 견적요청서 필수 입력값 체크
        var checkEditor = function()
        {
         	// 응답 만료일
            if($("#rplyDt").val() == null || $("#rplyDt").val() == ""){
                alert("응답 만료일을 입력해주세요.");
                $("#rplyDt").focus();
                return false;
            }else{
                // 응답 만료일이 현재일 이전일 경우 return
                var rplyDt = $("#rplyDt").val().replace(/-/gi,"");
                if(nowDate > rplyDt){
                    alert("응답 만료일은 현재일 이전일수 없습니다.");
                    $("#rplyDt").focus();
                    return false;
                }
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
                
                //$('#divDB').hide();
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
        
    </script>
    

</head>
<body>
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <input type="hidden" name="bidGbnCd"  id="bidGbnCd"  value="1002" /> <!-- 입찰종류 (그룹코드 :2037 중 1002:견적요청, 사전견적 : 1004) -->
    <input type="hidden" name="userId"    id="userId"    value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="grpSeq"    id="grpSeq"    value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd" id="goodsTyCd" value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="goodsCd"   id="goodsCd"   value="<c:out value="${p_goodsCd}" />" /> <!-- goodsCd -->
    <input type="hidden" name="goodArray" id="goodArray" value="" />
    <input type="hidden" name="vatGbn"    id="vatGbn"    value="" />
    <input type="hidden" name="talkGbn"   id="talkGbn"   value="" />
    <input type="hidden" name="userNm"    id="userNm"    value="${sessionScope['__usk'].userNm}" />

    <!-- content -->
    <section class="pageTit">
        <!-- 타이틀 영역 -->
        <div class="conWrap">
            <h2>상세정보(견적) 요청서</h2>
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
        
        <table class="tbl_st1 qSer">
            <thead>
                <tr>                    
                    <th>시스템 요구사항(필요한 구성 항목을 선택하세요.)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <label><input type="checkbox" name="chkServer"        id="chkServer"        value="Y" checked="checked" disabled="disabled"/> 서버</label>
                        <label><input type="checkbox" name="chkDB"            id="chkDB"            value="Y" onclick="clkDB(this);"/> DB</label>
                        <label><input type="checkbox" name="chkStorage"       id="chkStorage"       value="Y" onclick="clkStorage(this);"/> 스토리지</label>
                        <label><input type="checkbox" name="chkCDN"           id="chkCDN"           value="Y" onclick="clkCDN(this);"/> CDN</label>
                        <label><input type="checkbox" name="chkWebFirewall"   id="chkWebFirewall"   value="Y" onclick="clkWebFirewall(this);"/> 웹방화벽</label>
                        <label><input type="checkbox" name="chkMonitoring"    id="chkMonitoring"    value="Y" onclick="clkMonitoring(this);"/> 모니터링</label>
                        <label><input type="checkbox" name="chkBackup"        id="chkBackup"        value="Y" onclick="clkBackup(this);"/> 백업</label>
                        <!-- <label><input type="checkbox" name="chkManageFunc"    id="chkManageFunc"    value="Y" onclick="clkManageFunc(this);"/> 관리기능</label> -->
                        <label><input type="checkbox" name="chkAddedService"  id="chkAddedService"  value="Y" onclick="clkAddedService(this);"/> 부가서비스</label>                  
                    </td>
                </tr>
            </tbody>
        </table>
        
        <!-- 
        
        1. 서버 
        
        -->
        
        <h3>▶서버 요구사항</h3>
        
        <table id="serverTable01" class="tbl_st4">
        <thead>
        	<tr>
        		<th colspan="7">서버정보</th>
        	</tr>
            <tr>
                <th>용도</th>
                <th>OS</th>
                <th>CPU(Vcore)</th>
                <th>메모리(GB)</th>
                <th>Disk(GB)</th>
                <th colspan="2">수량(CM)</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input type="text" name="serverUse" /></td>
                <td><input type="text" name="serverOs" /></td>
                <td><input type="text" name="serverCpu" /></td>
                <td><input type="text" name="serverMemory" /></td>
                <td><input type="text" name="serverDisk" /></td>
                <td><input type="text" name="serverQnty" /></td>
                <td><a href="#" onclick="jsServerAddRow(); return false;" class="btns st3">행추가</a></td>
            </tr>
        </tbody>
        </table>
        
        <textarea id="serverAddRow01" style="display:none">
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

        <table id="serverTable02" class="tbl_st4">
        <tbody>
        	<tr><th colspan="6">부가정보(서버)</th></tr>
            <tr>
                <th>공인 IP 수량</th>     <td><input type="text" class="width50p"  name="serverIp"      id="serverIp" /> 개/월</td>
                <th>네트워크 트래픽</th> <td><input type="text" class="width50p"  name="serverNetwork" id="serverNetwork" /> GB/월</td>
                <th>GSLB</th>            <td><input type="text" class="width50p"  name="serverGslb"    id="serverGslb" /> 개/월</td>
            </tr>
            <tr>    
                <th>로드밸런서</th>      <td><input type="text" class="width50p"  name="serverLdbl"    id="serverLdbl" /> GB/월</td>
                <th>스냅샷</th>          <td><input type="text" class="width50p"  name="serverSnap"    id="serverSnap" /> GB/월</td>
                <th>이미지</th>             <td><input type="text" class="width50p"  name="serverImg"     id="serverImg" /> GB/월</td>
            </tr>
        </tbody>
        </table>
        
        <!-- 
        
        2. DB  
        
        -->

        <div id="divDB" style="margin-top: 20px;">
        
            <h3>▶DB 요구사항</h3>
            
            <table id="dbTable01" class="tbl_st4">
            <thead>
                <tr>
            		<th colspan="7">DB정보</th>
            	</tr>
                <tr>
                    <th>용도</th>
                    <th>OS</th>
                    <th>CPU(Vcore)</th>
                    <th>메모리(GB)</th>
                    <th>Disk(GB)</th>
                    <th colspan="2">수량(CM)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="text" name="dbUse" /></td>
                    <td><input type="text" name="dbOs" /></td>
                    <td><input type="text" name="dbCpu" /></td>
                    <td><input type="text" name="dbMemory" /></td>
                    <td><input type="text" name="dbAddDisk" /></td>
                    <td><input type="text" name="dbQnty" /></td>
                    <td><a href="#" onclick="jsDbAddRow(); return false;" class="btns st3">행추가</a></td>
                </tr>
            </tbody>
            </table>
    
            <textarea id="dbAddRow01" style="display:none">
            <tbody>
                <tr>
                    <td><input type="text" name="dbUse" /></td>
                    <td><input type="text" name="dbOs" /></td>
                    <td><input type="text" name="dbCpu" /></td>
                    <td><input type="text" name="dbMemory" /></td>
                    <td><input type="text" name="dbDisk" /></td>
                    <td><input type="text" name="dbQnty" /></td>
                    <td><a href="#" onclick="jsDbDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
                </tr>    
            </tbody>
            </textarea>
    
            <table class="tbl_st4">
            <thead>
            	<tr>
            		<th colspan="4">부가정보(DB)</th>
            	</tr>
                <tr>
                    <th>공인 IP 수량</th>
                    <th>네트워크 트래픽</th>
                    <th>추가 디스크</th>
                    <th>백업 스토리지</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="text" class="width50p" id="dbIp" name="dbIp" /> 개/월</td>
                    <td><input type="text" class="width50p" id="dbNetwork" name="dbNetwork" /> GB/월</td>
                    <td><input type="text" class="width50p" id="dbAddDisk" name="dbAddDisk" /> GB/월</td>
                    <td><input type="text" class="width50p" id="dbBackStorg" name="dbBackStorg" /> GB/월</td>                
                </tr>
            </tbody>
            </table>
        </div>

        <!-- 
        
        3. 스토리지  
        
        -->
        <div id="divStorage" style="margin-top: 20px;">
        
            <h3>▶스토리지</h3>
            <table class="tbl_st4">
            <tbody>
                <tr>
                    <th>저장공간</th>    
                    <td><input type="text" class="width50p" name="dbStorgSpace" id="dbStorgSpace" /> GB/월</td>
                    <th>전송량</th>                    
                    <td><input type="text" class="width50p" name="dbTransVlmn" id="dbTransVlmn" /> GB/월</td>
                </tr>
            </tbody>
            </table>
        </div>

        <!-- 
        
        4. CDN  
        
        -->
        <div id="divCDN" style="margin-top: 20px;">
    
            <h3>▶CDN</h3>
            <table class="tbl_st4">
            <tbody>
                <tr>
                    <th>전송량</th>            
                    <td><input type="text" class="width50p" name="cdnTransVlmn" id="cdnTransVlmn" /> GB/월</td>
                    <th>예상 요청 수</th>    
                    <td><input type="text" class="width50p" name="cdnRequCnt" id="cdnRequCnt" /> 건/월</td>
                </tr>
            </tbody>
            </table>
        </div>

        <!-- 
        
        5. 웹방화벽  
        
        -->
        
        <div id="divWebFirewall" style="margin-top: 20px;">
        
            <h3>▶웹방화벽</h3>
            <table class="tbl_st4">
            <tbody>
                <tr>
                    <th>서비스유형</th>    
                    <td>
                        <!-- 2074 -->
                        <span id="spanWebGoodsKind" class="sel_box">
                            <select id="webGoodsKind" name="webGoodsKind">
                                <option value="">선택</option>
                                <!-- 2074 -->
                                <c:forEach items="${webGoodsKindList}" var="webGoodsKind" varStatus="status">
                                    <option value="${webGoodsKind.PRVCD}">${webGoodsKind.PRVNM}</option>    
                                </c:forEach>
                            </select>
                        </span>
                    </td>                        
                    <th>처리속도</th>                    
                    <td><input type="text" class="width50p" name="webAccess" id="webAccess" /> Mbps</td>
                </tr>
            </tbody>
            </table>
        </div>

        <!-- 
        
        6. 모니터링  
        
        -->
        
        <div id="divMonitoring" style="margin-top: 20px;">
        
            <h3>▶모니터링</h3>
            <table class="tbl_st4">
            <tbody>
                <tr>
                    <th>VM</th>
                    <td>Vcore <input type="text" class="width50p" name="mntingVm" id="mntingVm" /> GB/월</td>
                    <th>계정 수량</th>
                    <td><input type="text" class="width50p" name="mntingIdCnt" id="mntingIdCnt" /> 개/월</td>
                </tr>
            </tbody>
            </table>
        </div>

        <!-- 
        
        7. 백업  
        
        -->
        
        <div id="divBackup" style="margin-top: 20px;">
        
            <h3>▶백업</h3>
            <table class="tbl_st4">
            <tbody>
                <tr>
                    <th>백업서버 수량 </th>
                    <td><input type="text" class="width50p" name="bakupCnt" id="bakupCnt" /> 개/월</td>
                    <th>저장용량</th>                    
                    <td><input type="text" class="width50p" name="bakupStorg" id="bakupStorg" /> GB/월</td>
                </tr>
            </tbody>
            </table>
        </div>
        
        <!-- 
        
        8. 관리기능 
        
        -->
        
        <!-- 
        
        9. 부가서비스 
        
        -->
        
        <div id="divAddedService" style="margin-top: 20px;">
            
            <h3>▶부가서비스</h3>
            
            <h4>보안관리</h4>
            <table class="tbl_st4">
            <tbody>
                <tr>
                    <th>VPN</th>
                    <td>
                        IPSec <input type="text" class="width50p" name="sectyVpn" id="sectyVpn" /> Mbps/월<br />
                        (예시 : IPSec 100 Mbps/월)
                    </td>
                    <th>SSL VPN</th>                    
                    <td><input type="text" class="width50p" name="sectySslvpn" id="sectySslvpn" /> Users/월</td>
                </tr>
            </tbody>
            </table>
            
            <h4>기타</h4>
            <table class="tbl_st4">
                <tbody>
                    <tr>
                        <td><input type="text" name="addedEtc" id="addedEtc" /></td>
                    </tr>
                </tbody>
            </table>
        </div>
        

        
        
        
        <h3>납품 요구조건</h3>
        <table class="tbl_st4">
            <tr>
                <th>사용기간</th>
                <td class="term" colspan="3">                    
                      <input type="text" id="useFromDt" name="useFromDt" readonly="readonly"/>
                    ~ <input type="text" id="useToDt" name="useToDt" readonly="readonly"/>
                    <span id="useTerm"/> <%-- (12개월 00일) --%>
                    
                    <input type="hidden" name="puchBudgetAmt">
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
                <th>희망 구매가</th>
                <td class="vat">
                    <div class="unit">
                        <i>원</i>
                        <div><input type="text" id="hopePuchAmt" name="hopePuchAmt" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></div>
                    </div>
                    <label><input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" checked="checked"/> VAT포함</label>
                    <label><input type="radio" name="vatGbnRadio" id="vatGbnN" value="N"/> VAT미포함</label>
                </td>
                <th class="requ">응답 만료일</th>
                <td class="term"><input type="text" id="rplyDt" name="rplyDt" /></td>
            </tr>
            <tr>
                <th>납품 장소</th>
                <td colspan="3"><input type="text" id="delyPlac" name="delyPlac"/></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                    <div class="uploadFile">
                        <input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/>
                        <div>
                            <img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsFileDelete('delyFile', 'delyFileInput');" alt="삭제" />                            
                            <span class="btns st3">
                                파일선택
                                <input type="file" name="delyFile" id="delyFile" class="delyFile" title="파일찾기" onchange="jsFileChk('delyFile', 'delyFileInput');"/>
                            </span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>추가문의</th>
                <td colspan="3"><textarea id="notifyCont" name="notifyCont" ></textarea></td>
            </tr>
        </table>
                
        <h3>요청자 정보</h3>
        <table class="tbl_st4">
            <tr>
                <th class="requ">작성자</th>
                <td>${sessionScope['__usk'].userNm}</td>
				<input type="hidden" name="goodsChargerNm" value="${sessionScope['__usk'].userNm}" />
                <th class="requ">휴대전화</th>
                <td>${sessionScope['__usk'].mbtlnum}</td>
            </tr>
            <tr>
                <th class="requ">기업/기관명</th>
                <td><input type="text" id="realDmndOrgn" name="realDmndOrgn" value="${sessionScope['__usk'].cmpnyNm}"/></td>
                <th class="requ">이메일</th>
                <td><a href="mailto:">${sessionScope['__usk'].email}</a></td>
            </tr>
            <tr>
                <th>직책</th>
                <td><input type="text" id="userPosition" name="userPosition"/></td>
                <th>대표전화</th>
                <td class="tel">
                    <input type="text" id="goodsChargerCttpc1" name="goodsChargerCttpc1"/> - 
                    <input type="text" id="goodsChargerCttpc2" name="goodsChargerCttpc2"/> -
                    <input type="text" id="goodsChargerCttpc3" name="goodsChargerCttpc3"/>
                </td>
            </tr>                    
        </table>
            
        <div class="btnArea rig">
            <a href="#" onclick="jsRequestSend(); return false;" class="btns st1 icn icnSend"> 발 송 </a>
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