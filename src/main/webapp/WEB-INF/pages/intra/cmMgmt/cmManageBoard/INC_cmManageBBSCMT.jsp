<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<style type="text/css">	
.reply_box{/*margin-top:60px;*/ width:100%;}
.comment_area{padding:0 20px 20px; background:#f7f7f7;}
.comment_area .textarea{position:relative; width:714px; height:62px; margin-top:20px; border:1px solid #e4e4e4; background:#fff;}
.comment_area .textarea textarea{width:634px; height:62px; border:none; line-height:16px;}
.comment_area .textarea input{position:absolute; top:0; right:0;}
.comment_area .textarea img{position:absolute; top:0; right:0;}
.comment_area .comment_list{overflow:hidden; width:100%;}
.comment_area .comment_list ul li{overflow:hidden; padding:18px 0 0 0;}
.comment_area .comment_list ul li.comment:last-child{padding-bottom:0; border-bottom:none;}
.comment_area .comment_list ul li.comment{padding:15px 0 17px 0; border-bottom:1px dotted #bbb; color:#737373; line-height:18px;}
.comment_area .comment_list ul li.comment .reply{padding:0 35px;}

.comment_area .comment_list ul li .cont_l ul li{overflow:hidden; padding-bottom:17px; border-bottom:1px dotted #bbb;}
.comment_area .comment_list ul li .cont_l{float:left;}
.comment_area .comment_list ul li .cont_l strong{float:left; color:#333; font-weight:normal; font-family:'NanumGothicBold';}
.comment_area .comment_list ul li .cont_l .date{float:left; margin-left:12px; color:#acacac; font-size:11px;}
.comment_area .comment_list ul li .cont_l .btn_reply{float:left; margin:2px 0 0 30px; padding-left:12px; background:url('/resources/cmmnty/default/images/common/ico/ico_reply.gif') no-repeat left 2px; color:#737373; font-size:11px;}
.comment_area .comment_list ul li .cont_l .btn_reply a{color:#737373; text-decoration:none;}
.comment_area .comment_list ul li .cont_r{float:right;}
.comment_area .comment_list ul li .cont_r ul li{float:left; margin:0 0 0 6px; padding:0 0 0 6px; background:url('/resources/cmmnty/default/images/common/bul/bul_d.gif') no-repeat left 2px; font-size:11px;}
.comment_area .comment_list ul li .cont_r ul >*:first-child{margin-left:0; padding-left:0; background:none;}
.comment_area .comment_list ul li .cont_r ul li a{color:#737373; text-decoration:none;}

.comment_area .comment_list ul li.reply{padding:0 20px;}
.comment_area .comment_list ul li.reply .textarea{width:674px;}
.comment_area .comment_list ul li.reply .textarea textarea{width:594px;}
.comment_area .comment_list ul li.reply_list{padding:18px 20px 0;}
.comment_area .comment_list ul li.reply_list .cont_l strong{padding-left:14px; background:url('/resources/cmmnty/default/images/common/ico/ico_reply_arrow.gif') no-repeat left 4px;}
</style>
<!-- 사용자 스크립트 시작 -->
<script type="text/javascript">
    $().ready(function(){
    });
    
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
    
 // 페이지 이동
   	var jrMoveForm = function(form, movepage){
     
   	 //$("#"+form).attr("method","get");
   	 //$("#"+form+" #cmmntyMenuCode").val("");
   	 $("#"+form).attr("action",movepage).submit();
  	}; 
  	var jrMoveCmtList = function(cmmntyId,cmmntyMenuCode,cmmntyBbsSeq){
	    $.ajax({
	        url : "INC_cmManageBBSCMT.do",
	        dataType : "html",
	        type : "post",  // post 또는 get
	        data : { cmmntyId:cmmntyId, cmmntyMenuCode:cmmntyMenuCode, cmmntyBbsSeq:cmmntyBbsSeq},   
	        // 호출할 url 에 있는 페이지로 넘길 파라메터
	        //(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId){
	        success : function(result){
	            $("#replyDiv").html(result);
	        }
	    });
	 };
	 
  	// 답글폼 추가
  	var jsReplyFormAdd = function(form, cmmntyId, langCode, cmtseq, cmmntyMenuCode, bbsseq, cmtdp ) {
  	  	
      	var userid = "<c:out value="${sessionScope['__usk'].userId}"/>";

  	    $("#replyHtml"+cmtseq).css("display","block");
  	    
  		var formName = "<form id='"+form+"' name='"+form+"' method='post' onSubmit='return false' >";
  		
  	    $("#replyHtml"+cmtseq).html(formName+$("#replyCommentDiv").html()+"</form>");
  	    $("#replyHtml"+cmtseq).find('textarea[name=cmtCn]').focus();
  	  	$("#replyHtml"+cmtseq).find('input[name=cmmntyId]').val(cmmntyId);
  	  	$("#replyHtml"+cmtseq).find('input[name=langCode]').val(langCode);
  	    $("#replyHtml"+cmtseq).find('input[name=cmmntyMenuCode]').val(cmmntyMenuCode);
  	  	$("#replyHtml"+cmtseq).find('input[name=cmmntyBbsSeq]').val(bbsseq);
  	  	$("#replyHtml"+cmtseq).find('input[name=cmmntyCmtSeq]').val(cmtseq);
  		$("#replyHtml"+cmtseq).find('input[name=cmtDp]').val(cmtdp);
  		$("#replyHtml"+cmtseq).find('input[name=currentPage]').val($("#commentForm input[name=currentPage]").val());
  		//alert($("#commentForm input[name=currentPage]").val());
  	    $("#dataForm #formSeq").val(cmtseq);
  	    $("html, body").animate({scrollTop:$("#replyHtml"+cmtseq).position().top}, 10);
  	};
  	
  	 //댓글 페이지 번호이벤트 함수
    var jsCmtPageMove = function(curpage ) {
  	     
  	 //alert(curpage);
        var target = $("#replyDiv");
       
        //alert($("#commentForm input[name=currentPage]").val());
        if($.trim(target.text()) == "" || curpage != $("#commentForm input[name=currentPage]")) {
            $.get("INC_cmManageBBSCMT.do", {
                cmmntyId : "<c:out value='${param.cmmntyId}'/>",
                cmmntyMenuCode : "<c:out value='${param.cmmntyMenuCode}'/>",
                cmmntyBbsSeq   : "<c:out value='${param.cmmntyBbsSeq}'/>",
                langCode   : "<c:out value='${param.langCode}'/>",
                q_currPage : curpage
            },
            function(result){
                target.empty();
                target.append(result);
                $("#commentForm input[name=currentPage]").val(curpage);
            });
        }
    };
    
    // 댓글 폼에 데이터 세팅
    var jsCommentModify= function(form, cmmntyBbsSeq, cmmntyCmtSeq, refrnCmtSeq, cmtDp){
        
        var cmmntyId = $("#commentForm #cmmntyId").val();
        var currentPage = $("#commentForm #currentPage").val();
        var cmmntyMenuCode = $("#commentForm #cmmntyMenuCode").val();
        var langCode = $("#commentForm #langCode").val();
        var userid = "<c:out value="${sessionScope['__usk'].userId}"/>";
        
        $.post("INC_cmManageBBSCMTForm.do", {
            cmmntyId : cmmntyId,
            cmmntyCmtSeq : cmmntyCmtSeq,
            cmmntyBbsSeq : cmmntyBbsSeq,
            refrnCmtSeq : refrnCmtSeq,
            cmtDp : cmtDp,
            cmmntyMenuCode: cmmntyMenuCode,
            langCode: langCode
        },
        function(result) {
            if(result.result == true) {
                if(cmtDp == "0"){
                
                   $("#"+form+" #currentPage").val(currentPage);
                   $("#"+form+" #cmmntyId").val(result.value.cmmntyId);
                   $("#"+form+" #langCode").val(result.value.langCode);
                   $("#"+form+" #cmmntyBbsSeq").val(result.value.cmmntyBbsSeq);
                   $("#"+form+" #cmmntyCmtSeq").val(result.value.cmmntyCmtSeq);  
                   $("#"+form+" #refrnCmtSeq").val(result.value.refrnCmtSeq);  
                   $("#"+form+" #cmmntyMenuCode").val(cmmntyMenuCode);
                   $("#"+form+" #cmtCn").val(result.value.cmtCn);
                   $("#"+form+" #cmtCn").focus();
                   $("#"+form+" #comment").attr("onclick","jsCommentUptInsert('commentForm','update');");
                   $("html, body").animate({scrollTop:$("#"+form).position().top}, 10);
                   
                }else  if(cmtDp == "1"){
                   // alert($("#dataForm #formSeq").val());
                	//기존 답글 폼 삭제
                	jsModifyFormRemove($("#dataForm #formSeq").val());
              	    $("#replyHtml"+cmmntyCmtSeq).css("display","block");
              	    
              		var formName = "<form id='"+form+"' name='"+form+"' method='post' onSubmit='return false' >";
              		
              	    $("#replyHtml"+cmmntyCmtSeq).html(formName+$("#replyCommentUpdateDiv").html()+"</form>");
              	    
              	  	$("#replyHtml"+cmmntyCmtSeq).find('input[name=cmmntyId]').val(result.value.cmmntyId);
              	  	$("#replyHtml"+cmmntyCmtSeq).find('input[name=langCode]').val(result.value.langCode);
              	  	$("#replyHtml"+cmmntyCmtSeq).find('input[name=cmmntyMenuCode]').val(cmmntyMenuCode);
              	  	$("#replyHtml"+cmmntyCmtSeq).find('input[name=cmmntyBbsSeq]').val(result.value.cmmntyBbsSeq);
              	  	$("#replyHtml"+cmmntyCmtSeq).find('input[name=cmmntyCmtSeq]').val(result.value.cmmntyCmtSeq);
              	  	$("#replyHtml"+cmmntyCmtSeq).find('input[name=refrnCmtSeq]').val(result.value.refrnCmtSeq);
              		$("#replyHtml"+cmmntyCmtSeq).find('input[name=cmtDp]').val(result.value.cmtDp);
               	    $("#replyHtml"+cmmntyCmtSeq).find('textarea[name=cmtCn]').val(result.value.cmtCn);
               	    
               	 	$("#replyHtml"+cmmntyCmtSeq).find('textarea[name=cmtCn]').focus();
               	 	
              		$("#replyHtml"+cmmntyCmtSeq).find('input[name=currentPage]').val(currentPage);
              		//alert($("#replyHtml"+cmmntyCmtSeq).html());
              	    $("#dataForm #formSeq").val(cmmntyCmtSeq);
              	  //alert($("#dataForm #formSeq").val());
              	    $("html, body").animate({scrollTop:$("#replyHtml"+cmmntyCmtSeq).position().top}, 10);
                }
                
            } else {
                alert(Message.msg.requiredLogin);
            }
        }, 'json');
  	};
  	
  //댓글수정폼 삭제
  	var jsModifyFormRemove = function(seq) {
  	   
  	    $("#replyHtml"+seq).css("display","none");
  	  	$("#replyHtml"+seq).html("");
  	    $("html, body").animate({scrollTop:$("#commentForm").position().top}, 10);
  	};
  	
 // 답글 입력/수정
    var jsReplyUptInsert = function(form) {
        var cmtUrl = "";
        var cmtseq = $("#dataForm #formSeq").val();
        
        if(form == "commentReplyForm") {
           cmtUrl = "INC_cmManageBBSCMTInsert.do?bbsCmt=reply";
           $("#commentForm *").attr('disabled', true);
        } else if(form == "commentModifyForm"){
            cmtUrl = "INC_cmManageBBSCMTUpdate.do?bbsCmt=reply";
            $("#commentForm *").attr('disabled', true);
        }
        
        var cmmntyId = $("#replyHtml"+cmtseq).find('input[name=cmmntyId]').val();
        var langCode = $("#replyHtml"+cmtseq).find('input[name=langCode]').val();
        var cmmntyMenuCode = $("#replyHtml"+cmtseq).find('input[name=cmmntyMenuCode]').val();
        var cmmntyBbsSeq =$("#replyHtml"+cmtseq).find('input[id=cmmntyBbsSeq]').val();
        var cmmntyCmtSeq = $("#replyHtml"+cmtseq).find('input[name=cmmntyCmtSeq]').val();
        var cmtCn = $("#replyHtml"+cmtseq).find('textarea[name=cmtCn]').val();
        var cmtDp = $("#replyHtml"+cmtseq).find('input[name=cmtDp]').val();
        
        var refrnCmtSeq = $("#replyHtml"+cmtseq).find('input[name=refrnCmtSeq]').val();
        
        //alert(refrnCmtSeq);
        
        var currentPage = $("#replyHtml"+cmtseq).find('input[name=currentPage]').val();
          $.ajax({
            url      : cmtUrl,
            type     : "POST",
            data     : {cmmntyId:cmmntyId, langCode:langCode, cmmntyMenuCode:cmmntyMenuCode, cmmntyBbsSeq: cmmntyBbsSeq, cmmntyCmtSeq:cmmntyCmtSeq, cmtCn:cmtCn, cmtDp:cmtDp, refrnCmtSeq:refrnCmtSeq},
            dataType : "JSON",
            async : false,
            success  : function(response) {
                //alert(response);
	                if(response.result){   
		                if(form == "commentModifyForm"){
		                    alert(Message.msg.commentUpdateOk);  
		                }else{
				           //alert(Message.msg.insertOk);  
		                }
						jsCmtPageMove(currentPage);
	                }else { 
	                   alert(Message.msg.processFail);
	                   return false;
	               }
            }
        });
        
        return false;
    };
    
    //댓글입력/수정
    var jsCommentUptInsert = function(form , type) {

        var cmtUrl =  "";
        var cmmntyBbsSeq = $("#commentForm #cmmntyBbsSeq").val();
	        if(type == "update"){
	            cmtUrl =  "INC_cmManageBBSCMTUpdate.do?bbsCmt=comment"; 
	        }else{
	            cmtUrl =  "INC_cmManageBBSCMTInsert.do?bbsCmt=comment";
	        }
	        
         dataString = $("#"+form).serialize();
          $.ajax({
            url      : cmtUrl,
            type     : "POST",
            data     : dataString,
            dataType : "JSON",
            async : false,
            success  : function(response) {
                if(response.result){
                    if(type == "update"){
	                    alert(Message.msg.commentUpdateOk);  
	                }else{
			           //alert(Message.msg.insertOk);  
	                }
					jsCmtPageMove($("#commentForm input[name=currentPage]").val());
                }else { 
                   alert(Message.msg.processFail);
                   return;
               }
            }
        });
        
          return false;
    };
    
 	//댓글, 답글 삭제 
 	var jsDeleteComment= function(form, cmmntyBbsSeq, cmmntyCmtSeq, refrnCmtSeq, cmtDp ){
 	
	     var cmmntyId = $("#"+form+" #cmmntyId").val();
	     var currentPage = $("#"+form+" #currentPage").val();
	     var cmmntyMenuCode = $("#"+form+" #cmmntyMenuCode").val();
	     var langCode = $("#"+form+" #langCode").val();
	     if(confirm(Message.msg.chkCmBoardCmt)){
		       $.ajax({
		         url      : "INC_cmManageBBSCMTDelete.do",
		         type     : "POST",
		         data     : {cmmntyId:cmmntyId, langCode:langCode, cmmntyMenuCode:cmmntyMenuCode, cmmntyBbsSeq: cmmntyBbsSeq, cmmntyCmtSeq:cmmntyCmtSeq, refrnCmtSeq:refrnCmtSeq, cmtDp:cmtDp},
		         dataType : "JSON",
		         async : false,
		         success  : function(response) {
			                if(response.result){
			                    alert(Message.msg.commentDeleteOk);  
		//	                    jrMoveCmtList(cmmntyId,cmmntyMenuCode,cmmntyBbsSeq);
								jsCmtPageMove(currentPage);
			                    //return false;
			                }else { 
			                   alert(Message.msg.processFail);
			                   return false;
			               }
		         }
		     });
	     }
     	return false;
    };
    

</script>
						<h4 class="tx_13 mar_t10">댓글 : <span id="cmtCnt" class="tx_orange_u">${pager.totalNum}</span>개</h4>
					<!-- 답글 수정  -->
						<div id="replyCommentUpdateDiv" style="display: none;">
					        <input type="hidden" name="cmmntyId" id="cmmntyId" value="<c:out value='${param.cmmntyId}'/>" />
					        <input type="hidden" name="cmmntyMenuCode" id="cmmntyMenuCode" value="" />
					        <input type="hidden" name="cmmntyBbsSeq" id="cmmntyBbsSeq" value="" />
					        <input type="hidden" name="cmmntyCmtSeq" id="cmmntyCmtSeq" value="" />
					        <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
					        <input type="hidden" name="cmtDp" id="cmtDp" value="" />
					        <input type="hidden" name="currentPage" id="currentPage" value="" />
					        <input type="hidden" name="langCode" id="langCode" value=""/>
							<div class="textarea">
									<textarea id="cmtCn" name="cmtCn" onkeyup="javascript:displayBytes(500,'cmtCn');"  ></textarea>
									<img id="butReply" src="/resources/cmmnty/default/images/btn/btn_reply.gif" alt="답글수정" onclick="jsReplyUptInsert('commentModifyForm');" style="cursor: pointer;">
								</div>
						</div>
					<!--  //수정/삭제 입력-->		
			
					<!-- 답글 입력 -->
						<div id="replyCommentDiv" style="display: none;">
					        <input type="hidden" name="cmmntyId" id="cmmntyId" value="" />
					        <input type="hidden" name="langCode" id="langCode" value=""/>
					        <input type="hidden" name="cmmntyMenuCode" id="cmmntyMenuCode" value="" />
					        <input type="hidden" name="cmmntyBbsSeq" id="cmmntyBbsSeq" value="" />
					        <input type="hidden" name="cmmntyCmtSeq" id="cmmntyCmtSeq" value="" />
					        <input type="hidden" name="cmtDp" id="cmtDp" value="" />
					        <input type="hidden" name="currentPage" id="currentPage" value="" />
							<div class="textarea">
									<textarea id="cmtCn" name="cmtCn" onkeyup="javascript:displayBytes(500,'cmtCn');"  ></textarea>
									<img id="butReply" src="/resources/cmmnty/default/images/btn/btn_reply.gif" alt="답글입력" onclick="jsReplyUptInsert('commentReplyForm');" style="cursor: pointer;">
								</div>
						</div>
					<!--  //답글 입력-->		
    		<div class="reply_box">
					<span class="totalcount">

						
					</span>
					<div class="comment_area">
						<!-- 댓글 리스트 -->
						<div class="comment_list" style="display: block;">
							<ul>
								<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
								<c:forEach items="${pager.list}" var="data" varStatus="status">
								<!-- 댓글 내용 -->
								<c:if test="${ data.cmtDp == '0' }">
								<li>
									<div class="cont_l">
										<c:if test="${ cmInfo.userId != data.registId}">
											<strong><c:out value='${data.wrterNcnm}'/></strong>
										</c:if>
										<c:if test="${cmInfo.userId == data.registId }">
											<strong>운영자</strong>
										</c:if>
										<span class="date"><c:out value='${data.registDt}'/></span>
										<span class="btn_reply"><a href="#none" onclick="jsReplyFormAdd('commentReplyForm','<c:out value='${ data.cmmntyId}'/>','<c:out value='${ data.langCode}'/>','<c:out value='${ data.cmmntyCmtSeq}'/>', '<c:out value='${ param.cmmntyMenuCode}'/>','<c:out value='${ data.cmmntyBbsSeq}'/>',<c:out value='${ data.cmtDp}'/>);" >답글</a></span>
									</div>
									<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   data.registId == sessionScope['__usk'].userId }">
									<div class="cont_r">
										<ul>
											<li><a href="#none" onclick="jsCommentModify('commentForm','<c:out value='${ data.cmmntyBbsSeq}'/>','<c:out value='${ data.cmmntyCmtSeq}'/>', '<c:out value='${ data.refrnCmtSeq}'/>', '<c:out value='${ data.cmtDp}'/>')">수정</a></li>
											<li><a href="#none" onclick="jsDeleteComment('commentForm','<c:out value='${ data.cmmntyBbsSeq}'/>','<c:out value='${ data.cmmntyCmtSeq}'/>', '<c:out value='${ data.refrnCmtSeq}'/>', '<c:out value='${ data.cmtDp}'/>' )">삭제</a></li>
										</ul>
									</div>
									</c:if>
								</li>
								<li class="comment">
									<op:nrToBr content="${data.cmtCn}" />
								</li>
								</c:if>
								<!-- //댓글 내용 -->
								<!-- 답글 내용 -->
								<c:if test="${ data.cmtDp == '1' }">
								<li class="reply_list">
									<div class="cont_l">
											<c:if test="${ cmInfo.userId != data.registId}">
											<strong><c:out value='${data.wrterNcnm}'/></strong>
										</c:if>
										<c:if test="${cmInfo.userId == data.registId }">
											<strong>운영자</strong>
										</c:if>
										<span class="date"><c:out value='${data.registDt}'/></span>
									</div>
									<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   data.registId == sessionScope['__usk'].userId }">
									<div class="cont_r">
										<ul>
											<li><a href="#none" onclick="jsCommentModify('commentModifyForm','<c:out value='${ data.cmmntyBbsSeq}'/>','<c:out value='${ data.cmmntyCmtSeq}'/>', '<c:out value='${ data.refrnCmtSeq}'/>', '<c:out value='${ data.cmtDp}'/>')">수정</a></li>
											<li><a href="#none" onclick="jsDeleteComment('commentForm','<c:out value='${ data.cmmntyBbsSeq}'/>','<c:out value='${ data.cmmntyCmtSeq}'/>', '<c:out value='${ data.refrnCmtSeq}'/>', '<c:out value='${ data.cmtDp}'/>' )">삭제</a></li>
										</ul>
									</div>
									</c:if>
								</li>								
								<li class="comment">
									<div class="reply"><op:nrToBr content="${data.cmtCn}" /></div>
								</li>
								</c:if>
								<!-- 답글 입력 -->
								<li id="replyHtml<c:out value='${ data.cmmntyCmtSeq}'/>" class="reply" style="display:none;"></li>
								<!-- //답글 입력 -->
								</c:forEach>
							</ul>
						</div>
						<!-- //댓글 리스트 -->
					 <!-- 댓글 입력-->
<%-- 					  data : { cmmntyId:"<c:out value="${cmUserMenuView.cmmntyId}"/>", langCode:"<c:out value="${cmUserMenuView.langCode}"/>",  --%>
<%-- 		            cmmntyMenuCode:"<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>", cmmntyBbsSeq:"<c:out value="${userBoardView.cmmntyBbsSeq}"/>"},  --%>
						    <form id="commentForm" action="INC_cmManageBBSCMTInsert.do" name="commentForm" method="post"  onSubmit="return false">
						        <input type="hidden" name="cmmntyId" id="cmmntyId" value="<c:out value='${param.cmmntyId}'/>" />
						        <input type="hidden" name="cmmntyMenuCode" id="cmmntyMenuCode" value="<c:out value='${param.cmmntyMenuCode}'/>" />
						        <input type="hidden" name="cmmntyBbsSeq" id="cmmntyBbsSeq" value="<c:out value='${param.cmmntyBbsSeq}'/>" />
						        <input type="hidden" name="langCode" id="langCode" value="<c:out value='${param.langCode}'/>"/>
						        <input type="hidden" name="cmmntyCmtSeq" id="cmmntyCmtSeq" value="" />
						        <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
						        <input type="hidden" name="currentPage" id="currentPage" value="<c:out value='${param.currentPage}'/>" />
								<div class="textarea">
									<textarea id="cmtCn" name="cmtCn" onkeyup="javascript:displayBytes(500,'cmtCn');"></textarea>
				                            <input id="comment" type="image" src="/resources/cmmnty/default/images/btn/btn_comment.gif" alt="댓글입력" onclick="jsCommentUptInsert('commentForm','insert');">
								</div>
						    <!-- //댓글 입력-->
					</div>
					
				</div>
				<!-- paging -->
				<c:if test="${!empty pager.list}"><op:pager pager="${pager}" page="pager/webCmtPager.jsp" script="jsCmtPageMove" /></c:if>
				<!-- //paging -->