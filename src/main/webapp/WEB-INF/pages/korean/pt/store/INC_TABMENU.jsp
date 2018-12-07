<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="tabgubun" value='<%=request.getParameter("tab")%>' /><c:set var="gcode" value='<%=request.getParameter("goodsCode")%>' />
<script type="text/javascript">
  $( window).load(function() {
     $("#poptitiel").html(parent.$("#goodsNm").val()+'<a href="#"  onclick="jsClose();">닫기</a>');
     $(".tit").html(parent.$("#goodsNm").val());
  	//if (parent.$("#vodurl").val() == "")  $(".moving").remove();  // 사용안함.
  	if (parent.$("#scrImg").val() == ""){  $(".screen").hide(); $("#tampmenu").addClass('ele2');}
  	// $('.pop-tab > ul > li').width(($('.pop-tab > ul').width() / $('.pop-tab > ul > li').size()) -1 );  	
  });
  
  function screenLink(){
      var imgSeq = parent.$("#seqImg").val();
      location.href = "/korean/pt/store/inc/INC_screen.do?tab=screen&goodsCode=${gcode}&goodsCode=${gcode}&goodsImageFileSeq="+imgSeq;
  }
  
	//닫기
  var jsClose = function(){
      parent.$.fn.colorbox.close();
  };
</script>
	<!-- button  class="btn-close">닫기</button -->
 	<h2 id="poptitiel"> </h2>
 	<div>	
		<h3 class="tit"></h3>	
		<aside id="tampmenu">
			<a href="/korean/pt/store/inc/INC_inquiry.do?tab=inquiry&goodsCode=${gcode}"  class="<c:if test="${tabgubun == 'inquiry'}" >on</c:if>">Q&A</a>
			<%-- <a href="/korean/pt/store/inc/INC_comment.do?tab=comment&goodsCode=${gcode}" class="<c:if test="${tabgubun == 'comment'}" >on</c:if>">리뷰</a> --%>
			<a href="#" class="screen <c:if test="${tabgubun == 'screen'}" >on</c:if>" onClick="screenLink();">사용화면</a>
			<%-- <a href="/korean/pt/store/inc/INC_vodplay.do?tab=vodplay&goodsCode=${gcode}" class="<c:if test="${tabgubun == 'vodplay'}" >on</c:if>">소개영상</a> --%>
			<a href="/korean/pt/store/inc/INC_relation.do?tab=relation&goodsCode=${gcode}" class="<c:if test="${tabgubun == 'relation'}" >on</c:if>">연관서비스</a>
			</ul>
		</aside>
		<!-- //pop-tab -->