<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	//변경소스
	request.setAttribute("SubDomain", "korean");
	//}}
	
	String nowURL = request.getRequestURI().toString();
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>

<c:if test="${empty sessionScope['__usk'].userId}">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		//}}
	</script> 
</c:if>
<c:if test="${cmInfo.userId != sessionScope['__usk'].userId}">
<c:if test="${userBoardView.othbcSetupCd == '1002' }">
	<c:if test="${cmMberInfo.cmmntyMberId != sessionScope['__usk'].userId }">
 	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//}}
	</script> 
	</c:if>
	<c:if test="${empty cmMberInfo.cmmntyMberId }">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";		
		//}}
		
	</script>
	</c:if>
	
</c:if>
</c:if>

	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title><c:out value="${cmUserMenuView.cmmntyMenuNm}"/> | 씨앗 마켓</title>
	<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
	<op:jsTag type="spi" items="form, validate, adgallery" />
	<script type="text/javascript">
		$(document).ready(function() {
		    
		    if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		    OpenWorks.fileCnt	= <c:out value="${userBoardView.fileCnt}" default="0"/>;
		
		    
		    $.ajax({
		        url : "INC_cmPhotoBoardCMT.do",
		        dataType : "html",
		        type : "post",  // post 또는 get
		        data : { cmmntyId:"<c:out value="${cmUserMenuView.cmmntyId}"/>", langCode:"<c:out value="${cmUserMenuView.langCode}"/>", 
		            cmmntyMenuCode:"<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>", cmmntyBbsSeq:"<c:out value="${userBoardView.cmmntyBbsSeq}"/>"},   // 호출할 url 에 있는 페이지로 넘길 파라메터
		        //(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId){
		        success : function(result){
		            $("#replyDiv").html(result);
		        }
		    });
		    
		    if(OpenWorks.fileCnt > 0){
				var galleries = $('#imgView').adGallery({
					loader_image: '<c:url value="/resources/openworks/spi/jquery/ad-gallery/loader.gif" />',
					width: 600,						//Width of the image, set to false and it will read the CSS width
					height: 400,					//Height of the image, set to false and it will read the CSS height
					thumb_opacity: 0.5,				//Opacity that the thumbs fades to/from, (1 removes fade effect)
					//Note that this effect combined with other effects might be resource intensive
					//and make animations lag
					start_at_index: 0,		//Which image should be displayed at first? 0 is the first image
					animate_first_image: false,		//Should first image just be displayed, or animated in?
					animation_speed: 400,			//Which ever effect is used to switch images, how long should it take?
					display_next_and_prev: true,	//Can you navigate by clicking on the left/right on the image?
					display_back_and_forward: true,	//Are you allowed to scroll the thumb list?
					scroll_jump: 0,					//If 0, it jumps the width of the container
					slideshow: {
						enable: false,
						autostart: false,
						speed: 3000,
						start_label: '<img alt="play" src="'+ CTX_PATH + '/resources/openworks/spi/jquery/ad-gallery/control_play.png"/>',
						stop_label: '<img alt="stop" src="'+ CTX_PATH + '/resources/openworks/spi/jquery/ad-gallery/control_stop.png"/>',
						stop_on_scroll: true,		//Should the slideshow stop if the user scrolls the thumb list?
						countdown_prefix: '(',		//Wrap around the countdown
						countdown_sufix: ')',
						onStart: function(){
							//Do something wild when the slideshow starts
						},
						onStop: function(){
							//Do something wild when the slideshow stops
						}
					},
					effect: 'fade',					//'slide-hori' or 'slide-vert', 'resize', 'fade', 'none' or false
					enable_keyboard_move: true,		//Move to next/previous image with keyboard arrows?
					cycle: false,					//If set to false, you can't go from the last image to the first, and vice versa
					//All callbacks has the AdGallery objects as 'this' reference
					callbacks: {
						//Executes right after the internal init, can be used to choose which images
						//you want to preload
						init: function(){
							//preloadAll uses recursion to preload each image right after one another
							this.preloadAll();
							//Or, just preload the first three
							//this.preloadImage(0);
							//this.preloadImage(1);
							//this.preloadImage(2);
						},
						//This gets fired right after the new_image is fully visible
						afterImageVisible: function(){
							//For example, preload the next image
							var context = this;
							//this.loading(true);
							this.preloadImage(this.current_index + 1,
								function(){
									//This function gets executed after the image has been loaded
									//context.loading(false);
								}
							);
						},
						//This gets fired right before old_image is about to go away, and new_image
						//is about to come in
						beforeImageVisible: function(new_image, old_image){
							//Do something wild!
						}
					}
				});
			}else{
				$('#imgView').html("");
			};
		});
		
		//이미지 미리보기 /resources/openworks/spi/jquery/ad-gallery/jquery.ad-gallery.js 내에서 콜
		var viewImage = function(src, width, height){
			$.fn.colorbox({
				width : 800,
				height : 600,
				href  : src,
				iframe: true
			});
		};
		
		// 페이지 이동
	   	var jrMove = function(movepage){
		    
		   	// $("#cmmntyMenuCode").val();		
		   	// alert( $("#cmmntyMenuCode").val());
		   	//$("#cmmntyMenuCode").val("<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>");
		   	 $("#dataForm").attr("action",movepage).submit();
	  	}; 

	  	var jsUserBoardUptForm = function(cmmntyBbsSeq){
	  	    
	  	  	var movepage = "BD_cmPhotoBoardForm.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	alert
	        $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
	  	
		var jsUserBoardMoveView = function(cmmntyBbsSeq){
	  	    
	  	  	var movepage = "BD_cmPhotoBoardView.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	
	        $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
	  	var jsUserBoardDelete = function(cmmntyBbsSeq, atchFileSeq){
	  	  if ( confirm(Message.msg.deleteConfirm) ) {
	  	  	$("#cmmntyBbsSeq").val(cmmntyBbsSeq);
		    $("#atchFileSeq").val(atchFileSeq);
		    $("#dataForm").ajaxSubmit({
		            url      : "INC_cmPhotoBoardDelete.do",
		            type     : "POST",
		            dataType : "text",
		            async    : false,
		            success  : function(response){
		                if(response == "true"){
		                    alert(Message.msg.chkCmBoardDeleteOk);  
		                    jrMove("BD_cmPhotoBoardList.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
		                }else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
		            }
		        });
	  	  }
		};
	  	
	  	
	</script>
</head>
<body>

<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/> 
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>

	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq}"/>"/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value=""/>
	<input type="hidden" id="formSeq" name="formSeq" value=""/>
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
	</form>

			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<!-- view -->
				<table class="tbl_detail_view">
					<colgroup>
						<col style="width:*">
						<col style="width:35%">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit"><c:out value="${userBoardView.bbscttSj }"/></td>
							<td>
								<div class="cont_r">
									<span class="date"><c:out value="${userBoardView.registDt }"/></span>
									<ul class="function">
										<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   userBoardView.registId == sessionScope['__usk'].userId }">
										<li><a href="#none" onclick="jsUserBoardUptForm('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');">수정</a></li>
										<li><a href="#none" onclick="jsUserBoardDelete('<c:out value="${userBoardView.cmmntyBbsSeq }"/>', '<c:out value="${userBoardView.atchFileSeq }"/>');">삭제</a></li>
										</c:if>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<span class="name"><c:if test="${ cmInfo.userId != userBoardView.registId}"><c:out value='${userBoardView.wrterNcnm}'/></c:if>
								<c:if test="${cmInfo.userId == userBoardView.registId }"><strong>운영자</strong></c:if></span><span class="inquiry">조회수 <c:out value="${userBoardView.rdcnt }"/></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="txt_view">
									<!-- 내용과 이미지 파일 보기 -->
												<div id="imgView" class="ad-gallery" style="margin:0 auto;">
													<div class="ad-image-wrapper"></div>
													<div class="ad-controls"></div>
													<div class="ad-nav">
														<div class="ad-thumbs">
															<ul class="ad-thumb-list">
																<c:forEach items="${userBoardView.cmUserBoardFileCollection}" var="fileData" varStatus="status">
																	<li>
																		<a href="<c:url value="${fileData.fileUrl}" />">
																			<img src="<c:url value="${fileData.fileUrl}" />" class="galleryImg" alt="${fileData.localNm}" width='152px' height='100px' />
																		</a>
																	</li>
																</c:forEach>
															</ul>
														</div>
													</div>
												</div>
										<!-- //내용과 이미지 파일 보기 -->	
										<p><op:nrToBr content="${userBoardView.bbscttCn}" /></p>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //view -->

				<!-- 댓글 -->
				<div id="replyDiv"></div>
				<!-- //댓글 -->

				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmPhotoBoardList.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
					</div>
					<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   userBoardView.registId == sessionScope['__usk'].userId }">
					<div class="btn_r">
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardUptForm('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');"><span class="modify">수정</span></a></div>
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardDelete('<c:out value="${userBoardView.cmmntyBbsSeq }"/>', '<c:out value="${userBoardView.atchFileSeq }"/>');"><span class="trash">삭제</span></a></div>
					</div>
					</c:if>
				</div>
				<!-- //버튼 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</div>

</body>
</html>
