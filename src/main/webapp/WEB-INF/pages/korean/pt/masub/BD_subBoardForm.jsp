<%@page import="zes.core.lang.Validate"%>
<%@page import="zes.base.support.OpHelper"%>
<%@page import="zes.openworks.web.login.UserLoginVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>서브등록</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript">
	$().ready(function(){
	    $("#status").val("");
	    $("#dataForm").validate({
	        rules: {
	            masubTitle              : { required : true , maxlength : 200},
	            masubContent            : { required : true}
	        },
	        submitHandler : function(form){
	            $(form).ajaxSubmit({
	                    url    : "BD_subBoardAction.do",
	                    type : "POST",
	                    dataType : "text",
	                    success : function(response){
	                        if (response == "true")  {
	                            if($("#status").val()=="d"){
	                                alert("삭제되었습니다.");
	                                self.location.href="BD_subBoardList.do";
	                            }if($("#status").val()=="r_i" || $("#status").val()=="r_u" || $("#status").val()=="r_d"){
	                                alert("저장되었습니다.");
	                                self.location.reload();
	                            }else{
	                                alert("저장되었습니다.");
	                                self.location.href="BD_subBoardList.do";
	                            }
	                  		} else { 
		                  		alert(response);
		                  		//alert(Message.msg.processFail);
		        		        return;
	                  		}
	                   }
	            });
	        }
	    });
	});//ready end				
	
	var insertBoardForm = function(){
	    $("#status").val("i");
	    $("#dataForm").submit();
	}
	var updateBoardForm = function(){
	    $("#status").val("u");
	    $("#dataForm").submit();
	}
	var deleteBoardForm = function(){
	    $("#status").val("d");
	    $("#dataForm").submit();
	}
	
	var insertReplyForm = function(){
	    if(!$("#status").val()){
	        $("#status").val("r_i");
	    }
	    $("#dataForm").submit();
	}
	var updateReplyForm = function(data){
	    $("#status").val("r_u");
	    var dataArray = data.split(',');
        $("#replyNum").val(dataArray[0]);
        $("#replyUserId").val(dataArray[1]);
	    $("#dataForm").submit();
	}
	var deleteReplyForm = function(data){
	    $("#status").val("r_d");
	    var dataArray = data.split(',');
        $("#replyNum").val(dataArray[0]);
        $("#replyUserId").val(dataArray[1]);
	    $("#dataForm").submit();
	}
	function commentEdit(reNum,userId,comment){
	    $("#status").val("r_u");
	    $("#replyNum").val(reNum);
	    $("#replyUserId").val(userId);
	    $("#replyContent").text(comment);
	    $("#replyContent").focus();	    
	}


</script>
</head>
<body>
	<div class="supAdm mstSub">
	<form name="dataForm" id="dataForm" method="post" action="BD_subBoardAction.do">
		<input type="hidden" id="status" name="status"/>
		<input type="hidden" id="writeUserId" name="writeUserId" value="<c:out value='${cotent.userId}'/>"/>
		<input type="hidden" id="masubNum" name="masubNum" value="<c:out value='${cotent.masubNum}'/>"/>
		<input type="hidden" id="replyCnt" name="replyCnt" value="<c:out value='${fn:length(reply)}'/>"/>
		<input type="hidden" id="replyNum" name="replyNum" value=""/>
		<input type="hidden" id="replyUserId" name="replyUserId" value=""/>
		<!-- contents -->
		<table class="tbl_st4">
           <c:choose>
               <c:when test="${not empty cotent}">
               		<tr>
						<th class="requ">제목</th>
						<td><input type="text" id="masubTitle" name="masubTitle" value="<c:out value='${cotent.masubTitle}'/>" title="제목을 입력하세요"/></td>
					</tr>
					<tr>
						<th class="requ">내용</th>
						<td><textarea id="masubContent" name="masubContent" title="내용을 입력하세요" ><c:out value='${cotent.masubContent}'/></textarea></td>
					</tr>
               </c:when>
               <c:otherwise>
                   <tr>
						<th class="requ">제목</th>
						<td><input type="text" id="masubTitle" name="masubTitle"/></td>
					</tr>
					<tr>
						<th class="requ">내용</th>
						<td><textarea id="masubContent" name="masubContent"></textarea></td>
					</tr>
               </c:otherwise>
           </c:choose>
		</table><!-- contents -->
		<div class="btnArea rig">
		<c:choose>
              <c:when test="${not empty cotent}">               		
              	<c:if test="${empty reply and sessionScope['__usk'].userId eq cotent.userId}">
	              	<a href="#"  onclick="deleteBoardForm(this);" class="btns st1 icn icnDel">삭 제</a>
					<a href="#"  onclick="updateBoardForm(this);" class="btns st1 icn icnSave">저 장</a>
				</c:if>
			</c:when>
			<c:otherwise>
				<a href="#"  onclick="insertBoardForm(this);" class="btns st1 icn icnSave">저 장</a>
			</c:otherwise>
		</c:choose>
		<a href="BD_subBoardList.do" class="btns st1 icn icnList">목록보기</a>
		</div>
		
		<!-- re -->
		<div id="re" class="cmntArea">
			<c:if test="${not empty reply}">
			<c:set var="data" value="${reply}"/>
			<dl>
				<dt>댓글(<i>${fn:length(data)}</i>)</dt>
				<c:forEach items="${reply}" var="data" varStatus="subStatus">
				<dd>
					<ul>
						<li><c:if test="${sessionScope['__usk'].userId eq data.userId}" >
							<c:out value='${data.userId}'/>
							</c:if>
							<c:if test="${sessionScope['__usk'].userId ne data.userId}" >
							<c:out value='${data.maskRegistId}'/>
							</c:if>
						</li>
						<li><c:out value='${data.masubEntrDate}'/></li>
						<li class="cont_view">
							<op:nrToBr content="${data.masubContent }"/>
						</li>
					</ul>
					<span>  
						<c:if test="${sessionScope['__usk'].userId eq data.userId}" >
						<a href="javascript:;" onclick='commentEdit("${data.replyNum}","${data.userId}","${data.masubContent}");' class="btns st3">수정</a>
						<a href="javascript:;" onclick='deleteReplyForm("<c:out value='${data.replyNum}'/>,<c:out value='${data.userId}'/>");' class="btns st3">삭제</a>
						</c:if>
					</span>
					
				</dd>
				</c:forEach>					
			</dl>
			
			</c:if>
			
		
			<c:if test="${not empty cotent}">
			<dl class="cmentWrite">
				<dt>댓글쓰기</dt>
				<dd>
					<textarea id="replyContent" name="replyContent"></textarea>
					<a href="#"  onclick="insertReplyForm();" class="btns st3">댓글쓰기</a>
				</dd>
			</dl>
			</c:if>
		</div><!-- re -->
				
		
	</form>	
	</div>
</body>
</html>