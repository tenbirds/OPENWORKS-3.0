<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>협약기업 정보수정</title>
    <op:jsTag type="openworks" items="form, validate, ckeditor" />
    <op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
    
    <script type="text/javascript">
    $().ready(function() {
	    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

/*         $('#presentnPrearngeDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        }); */
        $('#presentnDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
/*         $('#cnclsComptDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        }); */
        $('#sndngDe').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
	    
        $("#dataForm").validate({
            rules: {
                cmpnyNm              : { required : true, maxlength : 50}
                ,chargerNm           : { required : true, maxlength: 10}
                ,telno           	 : { required : true}
                ,mbtlnum             : { required : true}
                ,email           	 : { required : true, email : true}
                ,presentnPrearngeDe  : { required : true, date: true}
                ,presentnDe          : { date: true}
                ,cnclsComptDe        : { date: true}
                ,sndngDe             : { date: true}
                ,cnstntCo            : { required : true, number: true}
                ,comouDe             : { required : true, formatDate: true}
            }
            ,messages: {

        	}
		});        
    });
    
 // 서비스등록
    var jsUpdateAction = function() {
        if(checkEditor()) {
            $("input[type=file]").each(function() {
                if (this.value == '') {
                    $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                    $("#"+this.id).attr("disabled","disabled");
                }
            });
            if(confirm("수정 하시겠습니까?")) {
	            $("#dataForm").attr("action", "ND_updateAction.do");
	            $("#dataForm").submit();
            }
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
      	}
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

    /**
     * 목록
     */
    var jsList = function(action) {
		self.location.href = action;
    };

    
    // 등록 vaildate
    var checkEditor = function() {
        var ret = true;
        
     	// 담당자
        if ($("#userId").val()==null || $("#userId").val().trim()=="") {
            alert("담당자를 선택해서 입력하여 주세요.");
            document.getElementById("userIdBtn").focus();
            return false;
        }
     
     	// 담당자
        if ($("#chargerNm").val()==null || $("#chargerNm").val().trim()=="") {
            alert("담당자를 입력하여 주세요.");
            document.getElementById("chargerNm").focus();
            return false;
        }
     
        // 회사명
        if ($("#cmpnyNm").val()==null || $("#cmpnyNm").val().trim()=="") {
            alert("회사명을 입력하여 주세요.");
            document.getElementById("cmpnyNm").focus();
            return false;
        }
        
     	// 전화번호
        if ($("#telno").val()==null || $("#telno").val().trim()=="") {
            alert("전화번호를 입력하여 주세요.");
            document.getElementById("telno").focus();
            return false;
        }
     
     	// 핸드폰
        if ($("#mbtlnum").val()==null || $("#mbtlnum").val().trim()=="") {
            alert("핸드폰을 입력하여 주세요.");
            document.getElementById("mbtlnum").focus();
            return false;
        }
     
     	// 이메일
        if ($("#email").val()==null || $("#email").val().trim()=="") {
            alert("이메일을 입력하여 주세요.");
            document.getElementById("email").focus();
            return false;
        }
     
     	// 제출예정일
/*         if ($("#presentnPrearngeDe").val()==null || $("#presentnPrearngeDe").val().trim()=="") {
            alert("제출예정일을 입력하여 주세요.");
            document.getElementById("presentnPrearngeDe").focus();
            return false;
        } */
        
        // vaildate 체크 실패시 false 반환
        if (!ret) {
            return false;
        }

        // vaildate 체크 성공시 true 반환
        return true;
    };

    var jsInputFileReset = function(fileId) {
        var control = $("#" + fileId);
        control.replaceWith( control = control.clone( true ) );
    };
    
    var jsSellerList = function(el) {
        $(el).colorbox({
            title : "담당자 목록",
            href : "PD_sellerListPop.do",
            width : "1000",
            height : "800",
            overlayClose : false,
            escKey : true,
            iframe : true
        });
    };
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var jsCheck = function(el,type) {
        	var _date = new Date();
        	var _year = _date.getFullYear();
        	var _month = ""+(_date.getMonth()+1);
        	var _day = ""+ _date.getDate();
        	if( _month.length == 1 ) _month = "0"+ _month;
        	if( _day.length == 1 ) _day = "0"+ _day;
        	var Today = ""+ _year +"-" + _month+"-"+ _day
        	var userTyCd = $("#dataForm #userTyCd").val();	
        	$("#dataForm #cnclsComptDe").val(Today);
        	$("#dataForm #presentnPrearngeDe").val(Today);
        	
        	if(userTyCd == 1001){
        	    userTyCd = 1002;
        	}else if(userTyCd == 2001){
        	    userTyCd = 2002;
        	}else if(userTyCd == 3001){
        	    userTyCd = 3002;
        	}
        	$("#dataForm #agremStat").val(type);
        	
            switch(type) {
	            case 1003:
	                if(confirm("검토반려 하시겠습니까?")){
	                    $("#dataForm").attr("action", "ND_updateAction.do");
	                    $("#dataForm").submit();
	                }
	                break;
	            case 1004:
	               
                     if ($("#lastAgrmntFile1").val()==null || $("#lastAgrmntFile1").val().trim()=="") {
                        alert("확정협약서를 첨부하세요");
                        document.getElementById("lastAgrmntFile1").focus();
                        return false;
                     }                    
                     if ($("#agremNo").val()==null || $("#agremNo").val().trim()=="") {
                        alert("협약번호를 입력하여 주세요");
                        document.getElementById("agremNo").focus();
                        return false;
                     } 
	                 if(confirm("승인 하시겠습니까?")) {
	                    $("#dataForm #userTyCd").val(userTyCd);
	                    $("#dataForm").attr("action", "ND_updateAction.do");
	                    $("#dataForm").submit();
	                 }
	                break;
	            }
			};
    
    
    var jsGoodsUpdateAction = function(sttus, action) {
        if(checkEditor2()){
            if (sttus != '') {
                $("#goodsRegistSttus").val(sttus);
            }
            $("input[type=file]").each(function() {
               if (this.value == '') {
                   $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                   $("#"+this.id).attr("disabled","disabled");
               }
            });
            
            $("#dataForm").attr("action", action);
            $("#dataForm").submit();
        }
    };
    
    
    
    function getTextLength(str) 
    {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            if (escape(str.charAt(i)).length == 6) {
                len++;
            }
            len++;
        }
        return len;
    }

    
    
    var modify_userinfo = function()
    {
        var errormsg = '' ;
        
        var bassAgremManageSeq = $('#bassAgremManageSeq').val();
        
		var chargerNm = $('#chargerNm').val();
		var telno     = $('#telno').val();
	    var email     = $('#email').val();
		var mbtlnum   = $('#mbtlnum').val();
	    
        
        
	    if (getTextLength(chargerNm) == 0) errormsg += '\n담당자 이름이 없습니다.';
	    if (getTextLength(telno) == 0)     errormsg += '\n전화번호가 없습니다.';
	    if (getTextLength(mbtlnum) == 0)   errormsg += '\n핸드폰번호가 없습니다.';
	    if (getTextLength(email) == 0)     errormsg += '\n이메일이 없습니다.';
	    
	    if (getTextLength(errormsg) > 0)
        {
        	alert(errormsg);        
        }
	    else
        {
	        var url = "ND_updateUser.do";
	        
	        $.post(url
	              ,{ bassAgremManageSeq : bassAgremManageSeq
	                ,chargerNm : chargerNm
	                ,telno     : telno
	                ,mbtlnum   : mbtlnum
	                ,email     : email
	               }
	              ,function(result)
	               {
	              		if (result==1)
            	    	{
            	    		alert("담당자 정보가 수정되었습니다.") ;
            	    	}
	               }
	              ,'json'
	              );
        }
    }
    
    
    
    
    
    
    </script>
</head>
<body>

    <form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">

    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
    <op:pagerParam view="view" />
	<input type="hidden" name="agremStat" id="agremStat">
	<input type="hidden" name="userId" id="userId" value="${baseVo.userId}">
    <input type="hidden" name="bassAgremManageSeq" id="bassAgremManageSeq" value="${baseVo.bassAgremManageSeq}"/>
    <input type="hidden" name="presentnPrearngeDe" id="presentnPrearngeDe"/>
    <input type="hidden" name="cnclsComptDe" id="cnclsComptDe"/>
    <input type="hidden" name="userTyCd" id="userTyCd" value="${baseVo.userTyCd}"/>
    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="200" />
            <col width="150" />
            <col width="200" />
            <col width="150" />
            <col width="*" />
        </colgroup>
        <tbody>
        	<tr><td colspan="6"><h4>협약기업 정보</h4></td></tr>
		    <tr>
				<th><span class="tx_red_s">*</span>담당자</th>
				<td colspan="5">
					<input id="chargerNm" class="w_92px" type="text" value="${baseVo.chargerNm}" style="ime-mode:active" maxlength="20"></input>
					<%-- <input name="userId" id="userId" type="hidden" value="${baseVo.userId}" maxlength="20"></input>
					<input type="button" id="userIdBtn" value="담당자 선택" onclick="jsSellerList(this);"></input> --%>
				</td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>회사명</th>
				<td colspan="5">
					<input class="w_92px" type="text" value="${baseVo.cmpnyNm}" style="ime-mode:active" maxlength="13" readonly></input>
				</td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>전화번호</th>
				<td>
					<input id="telno" class="w_92px" type="text" value="${baseVo.telno}" style="ime-mode:active" maxlength="13"></input>
				</td>
				<th><span class="tx_red_s">*</span>핸드폰</th>
				<td>
					<input id="mbtlnum" class="w_92px" type="text" value="${baseVo.mbtlnum}" style="ime-mode:active" maxlength="13"></input>
				</td>
				<th><span class="tx_red_s">*</span>이메일</th>
				<td>
					<%-- <input name="email" id="email" class="w_92px" type="text" value="${baseVo.email}" style="ime-mode:active" maxlength="50" readonly></input>--%>				 
				 	<input id="email" class="w_92px" type="text" value="${baseVo.email}" style="ime-mode:active" maxlength="50"></input>
				 	
				 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="수정" class="blue" onclick="modify_userinfo();" />
				</td>
			</tr>
		<%-- 	<tr>
				<th><span class="tx_red_s">*</span>제출예정일</th>
				<td>
					<input name="presentnPrearngeDe" id="presentnPrearngeDe" class="w120" type="text" value="${baseVo.presentnPrearngeDe}" style="ime-mode:active" maxlength="10" readonly></input>
				</td>
				<th>제출일</th>
				<td colspan="3">
					<input name="presentnDe" id="presentnDe" class="w120" type="text" value="${baseVo.presentnDe}" style="ime-mode:active" maxlength="10" readonly></input>
				</td>
			</tr>
			<tr>
				<th>체결완료일</th>
				<td>
					<input name="cnclsComptDe" id="cnclsComptDe" class="w120" type="text" value="${baseVo.cnclsComptDe}" style="ime-mode:active" maxlength="10" readonly></input>
				</td>
				<th>발송일</th>
				<td colspan="3">
					<input name="sndngDe" id="sndngDe" class="w120" type="text" value="${baseVo.sndngDe}" style="ime-mode:active" maxlength="10"  readonly></input>
				</td>
			</tr> --%>
			<tr>
				<th><span class="tx_red_s">*</span>차수</th>
				<td>
					<input class="w_92px" type="text" value="${baseVo.agremOrder}" style="ime-mode:active" maxlength="1" readonly="readonly"></input>
				</td>
				<th><span class="tx_red_s">*</span>협약종료일</th>
				<td>
					<input class="w_92px" name="agremEndDe" id="agremEndDe" type="text" value="${baseVo.agremEndDe}" style="ime-mode:active" maxlength="10" readonly="readonly"></input>
				</td>
				<th><span class="tx_red_s">*</span>협약번호</th>
				<td>
					<input class="w_92px" type="text" id="agremNo" name="agremNo" value="${baseVo.agremNo}" style="ime-mode:active" maxlength="8"></input>
				</td>
			</tr>
			<tr>
			<th>제공자신청상태</th>
				<td colspan="5">
				<c:forEach items="${codeList_stat}" var="codeList" varStatus="status">
					<c:if test="${codeList.prvCd == baseVo.agremStatCd}">
						<input class="w_92px" type="text" value="<c:out value="${codeList.prvNm}"/>" style="ime-mode:active" maxlength="13" readonly></input>
					</c:if>
				</c:forEach>
				</td>
			</tr>
        </tbody>
    </table>

    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="*" />
        </colgroup>
        <tbody>
            <tr><td colspan="2"><h4>제출서류</h4></td></tr>
			<tr>
			    <th>기본협약서</th>
                <td>
                    <input type="hidden" name="bassAgrmntFileSeq" value="${baseVo.bassAgrmntFileSeq}"/>
                    
                    <%-- <c:if test="${empty baseVo.bassAgrmntFile[0]}">
				        <input type="file" name="bassAgrmntFile1" id="bassAgrmntFile1" class="mnlFile w_92p" onchange="jsFileChk('bassAgrmntFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="bassAgrmntFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('bassAgrmntFile1');"/>
                    </c:if> --%>
						
					<c:if test="${not empty baseVo.bassAgrmntFile[0]}">
					    <c:set var="bassAgrmntFileVO" value="${baseVo.bassAgrmntFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <%-- <a href="javascript:;" onclick="jsFileDelete(this, ${bassAgrmntFileVO.fileSeq}, '${bassAgrmntFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a> --%>
                            <a href="/component/file/ND_fileDownload.do?id=${bassAgrmntFileVO.fileId }" title="${bassAgrmntFileVO.localNm}">${bassAgrmntFileVO.localNm} <span class="tx_gray">(download ${bassAgrmntFileVO.downCnt}, ${bassAgrmntFileVO.fileSize}, ${bassAgrmntFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="bassAgrmntFile1" id="bassAgrmntFile1" value="${bassAgrmntFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="bassAgrmntFile1Desc" value="${bassAgrmntFileVO.localNm}"/>
			        </c:if>
			  <%-- <c:if test="${not empty baseVo.bassAgrmntFile[0]}">
					<c:set var="bassAgrmntFileVo" value="${baseVo.bassAgrmntFile[0]}" />
						<a href="/component/file/ND_fileDownload.do?id=${bassAgrmntFileVO.fileId }" title="${bassAgrmntFileVO.localNm}">${bassAgrmntFileVO.localNm} <span class="tx_gray">(download ${bassAgrmntFileVO.downCnt}, ${bassAgrmntFileVO.fileSize}, ${bassAgrmntFileVO.fileType})</span></a>
				</c:if> --%>    
				</td>
			</tr>
			<tr>
			    <th>등기부등본</th>
                <td>
                    <input type="hidden" name="rgsbukTrnscrFileSeq" value="${baseVo.rgsbukTrnscrFileSeq}"/>
                    
                    <%-- <c:if test="${empty baseVo.rgsbukTrnscrFile[0]}">
				        <input type="file" name="rgsbukTrnscrFile1" id="rgsbukTrnscrFile1" class="mnlFile w_92p" onchange="jsFileChk('rgsbukTrnscrFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="rgsbukTrnscrFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('rgsbukTrnscrFile1');"/>
                    </c:if> --%>
						
					<c:if test="${not empty baseVo.rgsbukTrnscrFile[0]}">
					    <c:set var="rgsbukTrnscrFileVO" value="${baseVo.rgsbukTrnscrFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <%-- <a href="javascript:;" onclick="jsFileDelete(this, ${rgsbukTrnscrFileVO.fileSeq}, '${rgsbukTrnscrFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a> --%>
                            <a href="/component/file/ND_fileDownload.do?id=${rgsbukTrnscrFileVO.fileId }" title="${rgsbukTrnscrFileVO.localNm}">${rgsbukTrnscrFileVO.localNm} <span class="tx_gray">(download ${rgsbukTrnscrFileVO.downCnt}, ${rgsbukTrnscrFileVO.fileSize}, ${rgsbukTrnscrFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="rgsbukTrnscrFile1" id="rgsbukTrnscrFile1" value="${rgsbukTrnscrFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="rgsbukTrnscrFile1Desc" value="${rgsbukTrnscrFileVO.localNm}"/>
			        </c:if>
			  <%-- <c:if test="${not empty baseVo.rgsbukTrnscrFile[0]}">
	       	<c:set var="rgsbukTrnscrFileVo" value="${baseVo.rgsbukTrnscrFile[0]}" />
		        <a href="/component/file/ND_fileDownload.do?id=${rgsbukTrnscrFileVO.fileId }" title="${rgsbukTrnscrFileVO.localNm}">${rgsbukTrnscrFileVO.localNm} <span class="tx_gray">(download ${rgsbukTrnscrFileVO.downCnt}, ${rgsbukTrnscrFileVO.fileSize}, ${rgsbukTrnscrFileVO.fileType})</span></a>
		    </c:if> --%>
				</td>
			</tr>
			<tr>
			    <th>벤처기업증명서</th>
                <td>
                    <input type="hidden" name="vnentrCrtfFileSeq" value="${baseVo.vnentrCrtfFileSeq}"/>
                    
                    <%-- <c:if test="${empty baseVo.vnentrCrtfFile[0]}">
				        <input type="file" name="vnentrCrtfFile1" id="vnentrCrtfFile1" class="mnlFile w_92p" onchange="jsFileChk('vnentrCrtfFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="vnentrCrtfFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('vnentrCrtfFile1');"/>
                    </c:if> --%>
						
					<c:if test="${not empty baseVo.vnentrCrtfFile[0]}">
					    <c:set var="vnentrCrtfFileVO" value="${baseVo.vnentrCrtfFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <%-- <a href="javascript:;" onclick="jsFileDelete(this, ${vnentrCrtfFileVO.fileSeq}, '${vnentrCrtfFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a> --%>
                            <a href="/component/file/ND_fileDownload.do?id=${vnentrCrtfFileVO.fileId }" title="${vnentrCrtfFileVO.localNm}">${vnentrCrtfFileVO.localNm} <span class="tx_gray">(download ${vnentrCrtfFileVO.downCnt}, ${vnentrCrtfFileVO.fileSize}, ${vnentrCrtfFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="vnentrCrtfFile1" id="vnentrCrtfFile1" value="${vnentrCrtfFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="vnentrCrtfFile1Desc" value="${vnentrCrtfFileVO.localNm}"/>
			        </c:if>
			  <%-- <c:if test="${not empty baseVo.vnentrCrtfFile[0]}">
	       	<c:set var="vnentrCrtfFileVo" value="${baseVo.vnentrCrtfFile[0]}" />
		        <a href="/component/file/ND_fileDownload.do?id=${vnentrCrtfFileVO.fileId }" title="${vnentrCrtfFileVO.localNm}">${vnentrCrtfFileVO.localNm} <span class="tx_gray">(download ${vnentrCrtfFileVO.downCnt}, ${vnentrCrtfFileVO.fileSize}, ${vnentrCrtfFileVO.fileType})</span></a>
	      </c:if> --%>
				</td>
			</tr>
			<tr>
			    <th>직접생산증명서</th>
                <td>
                    <input type="hidden" name="directPrdctnCrtfFileSeq" value="${baseVo.directPrdctnCrtfFileSeq}"/>
                    
                    <%-- <c:if test="${empty baseVo.directPrdctnCrtfFile[0]}">
				        <input type="file" name="directPrdctnCrtfFile1" id="directPrdctnCrtfFile1" class="mnlFile w_92p" onchange="jsFileChk('directPrdctnCrtfFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="directPrdctnCrtfFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('directPrdctnCrtfFile1');"/>
                    </c:if> --%>
						
					<c:if test="${not empty baseVo.directPrdctnCrtfFile[0]}">
					    <c:set var="directPrdctnCrtfFileVO" value="${baseVo.directPrdctnCrtfFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <%-- <a href="javascript:;" onclick="jsFileDelete(this, ${directPrdctnCrtfFileVO.fileSeq}, '${directPrdctnCrtfFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a> --%>
                            <a href="/component/file/ND_fileDownload.do?id=${directPrdctnCrtfFileVO.fileId }" title="${directPrdctnCrtfFileVO.localNm}">${directPrdctnCrtfFileVO.localNm} <span class="tx_gray">(download ${directPrdctnCrtfFileVO.downCnt}, ${directPrdctnCrtfFileVO.fileSize}, ${directPrdctnCrtfFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="directPrdctnCrtfFile1" id="directPrdctnCrtfFile1" value="${directPrdctnCrtfFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="directPrdctnCrtfFile1Desc" value="${directPrdctnCrtfFileVO.localNm}"/>
			        </c:if>
			    <%-- <c:if test="${not empty baseVo.directPrdctnCrtfFile[0]}">
	         	<c:set var="directPrdctnCrtfFileVo" value="${baseVo.directPrdctnCrtfFile[0]}" />
		          <a href="/component/file/ND_fileDownload.do?id=${directPrdctnCrtfFileVO.fileId }" title="${directPrdctnCrtfFileVO.localNm}">${directPrdctnCrtfFileVO.localNm} <span class="tx_gray">(download ${directPrdctnCrtfFileVO.downCnt}, ${directPrdctnCrtfFileVO.fileSize}, ${directPrdctnCrtfFileVO.fileType})</span></a>
	        </c:if> --%>    
				</td>
			</tr>
			<tr>
			    <th>신용평가서</th>
                <td>
                    <input type="hidden" name="cdltDocFileSeq" value="${baseVo.cdltDocFileSeq}"/>
                    
                    <%-- <c:if test="${empty baseVo.cdltDocFile[0]}">
				        <input type="file" name="cdltDocFile1" id="cdltDocFile1" class="mnlFile w_92p" onchange="jsFileChk('cdltDocFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="cdltDocFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('cdltDocFile1');"/>
                    </c:if> --%>
						
					<c:if test="${not empty baseVo.cdltDocFile[0]}">
					    <c:set var="cdltDocFileVO" value="${baseVo.cdltDocFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <%-- <a href="javascript:;" onclick="jsFileDelete(this, ${cdltDocFileVO.fileSeq}, '${cdltDocFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a> --%>
                            <a href="/component/file/ND_fileDownload.do?id=${cdltDocFileVO.fileId }" title="${cdltDocFileVO.localNm}">${cdltDocFileVO.localNm} <span class="tx_gray">(download ${cdltDocFileVO.downCnt}, ${cdltDocFileVO.fileSize}, ${cdltDocFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="cdltDocFile1" id="cdltDocFile1" value="${cdltDocFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="cdltDocFile1Desc" value="${cdltDocFileVO.localNm}"/>
			        </c:if>
			  <%-- <c:if test="${not empty baseVo.cdltDocFile[0]}">
	      	<c:set var="cdltDocFileVo" value="${baseVo.cdltDocFile[0]}" />
		      	<a href="/component/file/ND_fileDownload.do?id=${cdltDocFileVO.fileId }" title="${cdltDocFileVO.localNm}">${cdltDocFileVO.localNm} <span class="tx_gray">(download ${cdltDocFileVO.downCnt}, ${cdltDocFileVO.fileSize}, ${cdltDocFileVO.fileType})</span></a>
	      </c:if> --%>
				</td>
			</tr>
			<tr>
			    <th>재무제표</th>
                <td>
                    <input type="hidden" name="fnlttFileSeq" value="${baseVo.fnlttFileSeq}"/>
                    
                    <%-- <c:if test="${empty baseVo.fnlttFile[0]}">
				        <input type="file" name="fnlttFile1" id="fnlttFile1" class="mnlFile w_92p" onchange="jsFileChk('fnlttFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="fnlttFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('fnlttFile1');"/>
                    </c:if> --%>
						
					<c:if test="${not empty baseVo.fnlttFile[0]}">
					    <c:set var="fnlttFileVO" value="${baseVo.fnlttFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <%-- <a href="javascript:;" onclick="jsFileDelete(this, ${fnlttFileVO.fileSeq}, '${fnlttFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a> --%>
                            <a href="/component/file/ND_fileDownload.do?id=${fnlttFileVO.fileId }" title="${fnlttFileVO.localNm}">${fnlttFileVO.localNm} <span class="tx_gray">(download ${fnlttFileVO.downCnt}, ${fnlttFileVO.fileSize}, ${fnlttFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="fnlttFile1" id="fnlttFile1" value="${fnlttFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="fnlttFile1Desc" value="${fnlttFileVO.localNm}"/>
			        </c:if>
			  <%-- <c:if test="${not empty baseVo.fnlttFile[0]}">
	        <c:set var="fnlttFileVo" value="${baseVo.fnlttFile[0]}" />
		      	<a href="/component/file/ND_fileDownload.do?id=${fnlttFileVO.fileId }" title="${fnlttFileVO.localNm}">${fnlttFileVO.localNm} <span class="tx_gray">(download ${fnlttFileVO.downCnt}, ${fnlttFileVO.fileSize}, ${fnlttFileVO.fileType})</span></a>
	      </c:if> --%>
				</td>
			</tr>			
        </tbody>
    </table>
   <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="*" />
        </colgroup>
        <tbody>
            <tr><td colspan="2"><h4>확정협약서</h4></td></tr>
			<tr>
				<th><span class="tx_red tx_b">*</span>확정협약서</th>
				<td>
				<input type="hidden" name="lastAgrmntFileSeq" value="${baseVo.lastAgrmntFileSeq}"/>
				<c:if test="${not empty baseVo.lastAgrmntFile[0]}">
               		<c:set var="lastAgrmntFileVO" value="${baseVo.lastAgrmntFile[0]}" />
			    	<c:set var="image" value="" />
               	 	<div class="mar_b5">
                	    <a href="/component/file/ND_fileDownload.do?id=${lastAgrmntFileVO.fileId }" title="${lastAgrmntFileVO.localNm}">${lastAgrmntFileVO.localNm} <span class="tx_gray">(download ${lastAgrmntFileVO.downCnt}, ${lastAgrmntFileVO.fileSize}, ${lastAgrmntFileVO.fileType})</span></a>
                	</div>
                	<input type="hidden" name="lastAgrmntFile1" id="lastAgrmntFile1" value="${lastAgrmntFileVO.fileUrl}"/>
                	<input type="hidden" name="fileDesc" id="lastAgrmntFile1Desc" value="${lastAgrmntFileVO.localNm}"/>
  			    </c:if>
		        <c:if test="${!not empty baseVo.lastAgrmntFile[0] }">
                	<p class="mar_t5 mar_b5">
                		<input type="file" id="lastAgrmntFile1" size="100px" class="w470 multi" name="lastAgrmntFile1"/>
					</p>
					<ul id="oh"></ul>
		        </c:if>
		        </td>
	        </tr>
   	</table>
   	
     <table class="boardWrite mar_t20">
        <tbody>
            <tr><td><h4>관리자 의견</h4></td></tr>
            </tbody>
            <tr>
            <td>
            <textarea name="mangComt" id="mangComt" style="border:5px;resize:none;width:100%; height:100px;"><c:if test="${ null eq baseVo.mangComt}">관리자 의견이 없습니다.</c:if><c:if test="${ null ne baseVo.mangComt}">${baseVo.mangComt}</c:if></textarea>
            
            </td>
            </tr>
   	</table>
    <!-- 버튼 -->
    <div class="mar_t20 mar_b50">
        <div class="float_l">
            <input type="button" value="목록" class="blue" onclick="jsList('BD_index.do');" />
            <!-- <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm();' /> -->
        </div>
         <div class="float_r">

     		<c:if test="${baseVo.agremStatCd == 1001 || baseVo.agremStatCd == 1002 || baseVo.agremStatCd == 1003 || baseVo.agremStatCd == 1007}">
            	<input type="button" value="검토반려" class="blue" onclick="jsCheck(this,1003);" />
            	<input type="button" value="즉시승인" class="blue" onclick="jsCheck(this,1004);" />
            </c:if> 
            <c:if test="${baseVo.agremStatCd == 1004}">
            <input type="button" value="수정" class="blue" onclick="jsCheck(this,1004);" />
            </c:if>
        </div>
    </div>
    <!-- //버튼 -->
    </form>
</body>
</html>