<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<script type="text/javascript">
		$().ready(function(){
			
		    $.ajax({
	 	       	url: "/web/inc/INC_hot.list.do",
	 	        cache: false,
		        type: "POST",
		        dataType: "JSON",
		        async: false,
		        success: function(data){				            
		            if(data.hot.length > 0){
		                for(var k = 1; k <= data.hot.length; k++){
		                    var l = k - 1;
		                    $('<li id="hotLi_'+k+'"></li>').appendTo("#hotDiv");
		                    $('<img src="/resources/web/theme/default/images/main/num_'+k+'.gif"'+' alt="'+k+'" class="vm" /><a href="/web/board/BD_board.list.do?bbsCd='+data.hot[l].bbsCd+'"> '+data.hot[l].hotMenuName+'</a>').appendTo("#hotLi_"+k);
		                }
		            }
		            hotPoll();
		    	}
	 		});
		    
		});
		
		//성공시 재귀호출
		var hotPoll = function() {
		    setTimeout(function(){
				$.ajax({
		 	       	url: "/web/inc/INC_hot.list.do",
		 	        cache: false,
			        type: "POST",
			        dataType: "JSON",
			        success: function(data){				            
			            if(data.hot.length > 0){
			                for(var k = 1; k <= data.hot.length; k++){
			                    var l = k - 1;
			                    $("#hotLi_"+k).empty();
			                    $('<img src="/resources/web/theme/default/images/main/num_'+k+'.gif"'+' alt="'+k+'" class="vm" /><a href="/web/board/BD_board.list.do?bbsCd='+data.hot[l].bbsCd+'"> '+data.hot[l].hotMenuName+'</a>').appendTo("#hotLi_"+k);
			                }
			            }
			            hotPoll();
			    	}
		 		});
			}, 10000);	//호출기간지정
		};
	</script>
	
	<!-- 핫이슈영역 사용시 아래와 인크루드하여 사용 -->
<!-- 	<div class="issue_hot"> -->
<%-- 		<jsp:include page="web/inc/INC_hot.list.jsp" flush="true"></jsp:include> --%>
<!-- 	</div> -->
    <div class="issue">
		<h3><img src="/resources/web/theme/default/images/main/c_tit02.gif" alt="핫메뉴"/></h3>
		<ul id="hotDiv"></ul>
	</div>