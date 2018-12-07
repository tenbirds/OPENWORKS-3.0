<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 게시물 관리 상세</title>

	<op:jsTag type="spi" items="form, validate,colorbox, adgallery" />
	<script type="text/javascript">
	$(document).ready(function() {
		
	    <c:if test="${ userBoardView.cmmntyBbsTyCd == '1001'  || userBoardView.cmmntyBbsTyCd == '1003'  }">
		   $.ajax({
		        url : "INC_cmManageBBSCMT.do",
		        dataType : "html",
		        type : "post",  // post 또는 get
		        data : { cmmntyId:"<c:out value="${cmUserMenuView.cmmntyId}"/>", langCode:"<c:out value="${cmUserMenuView.langCode}"/>", 
		            cmmntyMenuCode:"<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>", cmmntyBbsSeq:"<c:out value="${userBoardView.cmmntyBbsSeq}"/>"},   // 호출할 url 에 있는 페이지로 넘길 파라메터
		        //(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId){
		        success : function(result){
		            $("#replyDiv").html(result);
		        }
		    });
		 </c:if>
	    if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
	    OpenWorks.fileCnt	= <c:out value="${userBoardView.fileCnt}" default="0"/>;
	    
	    <c:if test="${ userBoardView.cmmntyBbsTyCd == '1003' }">
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
					start_label: '<img src="'+ CTX_PATH + '/resources/openworks/spi/jquery/ad-gallery/control_play.png"/>',
					stop_label: '<img src="'+ CTX_PATH + '/resources/openworks/spi/jquery/ad-gallery/control_stop.png"/>',
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
		</c:if>
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
	    
    var jsBBSUptForm = function(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId, cmmntyBbsTyCd) {
//         $(el).colorbox({
//            	title : "커뮤니티 게시판 정보",         
//  			href      : "PD_cmManageBBSForm.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsSeq="+cmmntyBbsSeq+"&registId="+registId+"&cmmntyBbsTyCd="+cmmntyBbsTyCd,
//  			width : "900px",
//  	        height : "500px",
//            iframe : true
//        }); 
		$(parent.location).attr("href", "javascript:jsBBSInsertForm('"+cmmntyId+"','"+langCode+"','"+cmmntyMenuCode+"','"+cmmntyBbsSeq+"','"+registId+"','"+cmmntyBbsTyCd+"');");//부모창 함수 호출
        
 	};
    
	var jsBBSDelUpdate = function(cmmntyBbsSeq){
	   		// var parentUrl = parent.document.URL;
	   		var cmmntyId  = $("#cmmntyId").val();
			var langCode     = $("#langCode").val();
			var cmmntyMenuCode  = $("#cmmntyMenuCode").val();
			var cmmntyBbsTyCd = $("#cmmntyBbsTyCd").val();
	  	  if ( confirm(Message.msg.deleteConfirm) ) {
	  	  	$("#cmmntyBbsSeq").val(cmmntyBbsSeq);
		    $("#dataForm").ajaxSubmit({
		            url      : "ND_cmManageBBSDelUpt.do",
		            type     : "POST",
		            dataType : "text",
		            async    : false,
		            success  : function(response){
		                if(response == "true"){
		                    alert(Message.msg.chkCmBoardDeleteOk);  
		                    jsCloseWin();
			          		parent.location.reload("PD_cmManageBBSList.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsTyCd="+cmmntyBbsTyCd);
		                }else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
		            }
		        });
	  	  }
	};
	
	var jsCloseWinReload = function(){
	    
	    var cmmntyId  = $("#cmmntyId").val();
		var langCode     = $("#langCode").val();
		var cmmntyMenuCode  = $("#cmmntyMenuCode").val();
		var cmmntyBbsTyCd = $("#cmmntyBbsTyCd").val();
	    parent.location.reload("PD_cmManageBBSList.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsTyCd="+cmmntyBbsTyCd);
	    jsCloseWin();
	}
	</script>
</head>
<body>
	
	<div id="popup">
<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/> 
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	<input type="hidden" id="langCode" name="langCode" value="<c:out value="${cmUserMenuView.langCode}"/>"/>
	
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq}"/>"/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value=""/>
	<input type="hidden" id="formSeq" name="formSeq" value=""/>
	
        <h2 class="mar_t20">커뮤니티 게시물 관리 상세</h2>
		<fieldset>
		<legend>커뮤니티 게시물 관리 상세</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="커뮤니티 게시물 관리 상세">
            		<caption class="hidden">커뮤니티 게시물 관리 상세</caption>
			<colgroup>
			  <col width="20%" />
			  <col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>커뮤니티 이름 / 게시판 이름</span></th>
					<td><span><c:out value="${cmInfo.cmmntyNm}"/> / <c:out value="${cmUserMenuView.cmmntyMenuNm}"/></span></td>
				</tr>
				<tr>
					<th><span>제목</span></th>
					<td><span><c:out value="${userBoardView.bbscttSj}"/></span></td>
				</tr>
				<tr>
					<th><span>작성자 닉네임</span></th>
					<td><span><c:out value="${userBoardView.wrterNcnm}"/></span></td>
				</tr>
				<tr>
					<th><span>등록일시</span></th>
					<td><span><c:out value="${userBoardView.registDt }"/></span></td>
				</tr>
				<tr>
					<th><span>조회수</span></th>
					<td><span><c:out value="${userBoardView.rdcnt}"/></span></td>
				</tr>
				<c:if test="${ userBoardView.cmmntyBbsTyCd == '1003' }">
				<tr>
					<td colspan="2" >
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
					</td>
				</tr>
				</c:if>
				<tr>
					<th ><span>내용</span></th>
					<td  colspan="2" ><span><op:nrToBr content="${userBoardView.bbscttCn}" /></span></td>
				</tr>
				<!-- 
				1001	기본형
1002	FAQ형
1003	갤러리형
1004	답변형
				 -->
				 
				<c:if test="${ userBoardView.cmmntyBbsTyCd != '1002' }">
              	<tr>
					<th><span>첨부파일</span></th>
					<td><span><c:forEach items="${userBoardView.cmUserBoardFileCollection}" var="fileData" varStatus="status">
									<a href="/component/file/ND_fileDownload.do?id=<c:out value="${fileData.fileId}"/>" title="<c:out value='${fileData.fileDesc}'/>">
									<c:out value="${fileData.localNm }"/></a> (<c:out value="${fileData.fileSize }"/>)</span><span class="download">다운로드 
									<em><c:out value="${fileData.downCnt }"/></em><br/>
                           			 </c:forEach></span></td>
				</tr>
				</c:if>
				<c:if test="${ userBoardView.cmmntyBbsTyCd == '1001'  || userBoardView.cmmntyBbsTyCd == '1003'  }">
				<tr>
					<th><span>태그</span></th>
					<c:set  var="listLength"  value="${fn:length(userBoardView.cmUserBoardTagCollection)}"/> 
					<td><c:forEach items="${userBoardView.cmUserBoardTagCollection}" var="tagData" varStatus="status"><c:out value="${tagData.tagNm }" /><c:if test="${ status.count != listLength }">, </c:if></c:forEach></td>
				</tr>
				</c:if>
				<c:if test="${ userBoardView.cmmntyBbsTyCd == '1004' }">
				<tr>
					<th><span>답변일시</span></th>
					<td><span><c:out value="${userBoardView.answerDt }"/></span></td>
				</tr>
				<tr>
					<th><span>답변자 ID</span></th>
					<td><span><c:out value="${userBoardView.answerId }"/></span></td>
				</tr>
				<tr>
					<th ><span>질문 답변 내용</span></th>
					<td  colspan="2" ><span><op:nrToBr content="${userBoardView.answerCn}" /></span></td>
				</tr>
				</c:if>
			</tbody>
          </table>
        </fieldset>
        <!-- 댓글 -->
        
		<div id="replyDiv"></div>
		<!-- //댓글 -->
        <p class="tx_c mar_t20">
        <div>
           <div class="float_l">
           </div>
           <div class="float_r">
				<a href="#" class="btn"><button type="button" onclick="jsBBSUptForm('<c:out value="${userBoardView.cmmntyId}"/>' ,'<c:out value="${userBoardView.langCode}"/>','<c:out value="${userBoardView.cmmntyMenuCode}"/>' ,'<c:out value="${userBoardView.cmmntyBbsSeq}"/>' ,'<c:out value="${userBoardView.registId}"/>' ,'<c:out value="${userBoardView.cmmntyBbsTyCd}"/>');" class="blue">수정</button></a>
				<a href="#" class="btn"><button type="button" onclick="jsBBSDelUpdate('<c:out value="${userBoardView.cmmntyBbsSeq}"/>');" class="blue">삭제</button></a>
           		<a href="#" class="btn"><button type="button" onclick="jsCloseWinReload();" class="blue">닫기</button></a>
          </div>
		</div>
		</p>
	</form>
	</div>
</body>
</html>