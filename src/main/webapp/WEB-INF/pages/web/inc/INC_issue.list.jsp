<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<script type="text/javascript">		
		$().ready(function(){		    
				
		    $.ajax({
	 	       	url: "/web/inc/INC_issue.list.do",
	 	        cache: false,
		        type: "POST",
		        dataType: "JSON",
		        async: false,
		        success: function(data){
		            if(data.issue.length > 0){		                
		                for(var i = 1; i <= data.issue.length; i++){
		                    var j = i - 1;
		                    $('<li id="issueLi_'+i+'"></li>').appendTo("#issueDiv");
		                    $('<img src="/resources/web/theme/default/images/main/num_'+i+'.gif"'+' alt="'+i+'" class="vm" /><a href="/web/board/BD_board.view.do?bbsCd='+data.issue[j].bbsCd+'&seq='+data.issue[j].bbsSeq+'"> '+data.issue[j].issueTitle+'</a>').appendTo("#issueLi_"+i);
		                }
		            }
		            issuePoll();
		    	}
	 		});
		});

		//성공시 재귀호출
		var issuePoll = function() {
		    setTimeout(function(){		        
				$.ajax({
		 	       	url: "/web/inc/INC_issue.list.do",
		 	        cache: false,
			        type: "POST",
			        dataType: "JSON",
			        success: function(data){
			            if(data.issue.length > 0){
			                $("#issueDiv").fadeOut(1000);//임시로 표시
			                for(var i = 1; i <= data.issue.length; i++){
			                    var j = i - 1;
			                    $("#issueLi_"+i).empty();
			                    $('<img src="/resources/web/theme/default/images/main/num_'+i+'.gif"'+' alt="'+i+'" class="vm" /><a href="/web/board/BD_board.view.do?bbsCd='+data.issue[j].bbsCd+'&seq='+data.issue[j].bbsSeq+'"> '+data.issue[j].issueTitle+'</a>').appendTo("#issueLi_"+i);
			                }
			                $("#issueDiv").fadeIn(1500);//임시로 표시
			            }				            
			            issuePoll();
			    	}
		 		});
			}, 10000);	//호출기간지정
		};

	</script>
    <!-- 핫이슈영역 사용시 아래와 인크루드하여 사용 -->
<!-- 	<div class="issue_hot"> -->
<%-- 		<jsp:include page="web/inc/INC_issue.list.jsp" flush="true"></jsp:include> --%>
<!-- 	</div> -->
    <div class="issue">
		<h3><img src="/resources/web/theme/default/images/main/c_tit01.gif" alt="이슈컨텐츠"/></h3>
		<ul id="issueDiv"></ul>
	</div>