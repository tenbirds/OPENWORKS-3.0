<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<jsp:useBean id="webEventVO" class="zes.openworks.web.webevent.WebEventVO" />


<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
    //페이지 이동
    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };

    //탭 페이지 이동
    var jsTabMovePate = function(flag){
        $("#dataForm input[name=q_flag]").val(flag);
        $("#dataForm").submit();
    };

    
    var jsView = function(eventSn){
        
        //조회수
        $.post("ND_rcntUpdateAction.do",{eventSn:eventSn},
        function(response){
            try {
                if(eval(response)){
                    post_to_url("BD_eventView.do",{"eventSn":eventSn,"flag":"${searchMap.q_flag}"});
                }else{
                    alert(Message.msg.processFail);
                }
            } catch (e) {
                alert(e);
                return;
            }
        });
    };

    //Submit 전속 전송  (주소,파라메터,메소드)
    function post_to_url(path, params, method) {
        method = method || "post"; // Post:Get 전송 기본설정은 Post
        
        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);


        // 예  {"userId":"abcd","mgrId":"abcd"}
        for(var key in params) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);
     
            form.appendChild(hiddenField);
        }
     
        document.body.appendChild(form);
        form.submit();
    }
    

</script>

<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
    <input type="hidden" name="q_flag" />
    <input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="<c:out value='${searchMap.q_rowPerPage}'/>"/>
    <input type="hidden" name="q_currPage" 	 id="q_currPage"   value="<c:out value='${searchMap.q_currPage}'/>"/>
	<input type="hidden" name="q_sortName" 	 id="q_sortName"   value="<c:out value='${searchMap.q_sortName}'/>" />
	<input type="hidden" name="q_sortOrder"  id="q_sortOrder"  value="<c:out value='${searchMap.q_sortOrder}'/>"/>
    
    <!-- title-area -->
	<div class="title-area">
		<h2>이벤트</h2>
	</div>
	<!-- //title-area -->

	<!-- section -->
	<div class="section side">
		<p class="total-count">총 <strong>${pager.totalNum}</strong>개</p>
		<!-- list -->
		<div class="type-list">
			<ul>
				<c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                	<li>
						<strong><a href="javascript:;" onclick="jsView('${baseVo.eventSn}');">${baseVo.eventTitle}</a></strong>
						<span>
							<span>기간 : ${baseVo.beginDate} ~ ${baseVo.endDate}</span>
							<c:set var="evTyCdPt" value="<%=webEventVO.EV_TY_CD_PT %>" />
                            <c:set var="evTyCdPm" value="<%=webEventVO.EV_TY_CD_PM %>" />
                            <!-- 이벤트 발표일자/이벤트 당첨자 확인 -->
                            <c:if test="${baseVo.eventTyCd == evTyCdPt || baseVo.eventTyCd == evTyCdPm}">
                            	<span>발표 : ${baseVo.presnatnDate} ${baseVo.presnatnHm}</span>
                                <c:if test="${searchMap.q_flag eq 'Y' and baseVo.przwnerCnfirmUrl ne ''}">
                                <span><a href="${baseVo.przwnerCnfirmUrl}" target="_blank">당첨자 확인</a></span>
                                </c:if>
                            </c:if>
                            <!-- //이벤트 발표일자/이벤트 당첨자 확인 -->
						</span>
					</li>
                </c:forEach>
			</ul>
		</div>
		<!-- //list -->

		<!-- paging -->
		<div class="paging">
        	<c:if test="${searchMap.q_flag eq 'N'}">
            	<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
            </c:if>
		</div>
		<!-- //paging -->
	</div>
	<!-- //section -->
</form>



    