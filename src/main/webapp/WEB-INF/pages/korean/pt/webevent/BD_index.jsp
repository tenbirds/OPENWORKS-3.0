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
    
	<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">			
		</div>
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section">
			<!-- tab -->
			<div class="tab-area tab_event">
				<ul >				
                    <li><a href="javascript:jsTabMovePate('N')" <c:if test="${empty searchMap.q_flag || searchMap.q_flag eq 'N'}">class="on"</c:if> >진행중인 이벤트</a></li>
                    <li><a href="javascript:jsTabMovePate('Y')" <c:if test="${searchMap.q_flag eq 'Y'}">class="on"</c:if> >종료된 이벤트</a></li>
				</ul>						
			</div>
			<!-- //tab -->
		</div>
		<!-- //section -->

		<!-- section -->
		<div class="section">
		    <!-- 리스트 조회수 -->
		    <op:pagerParam page="param/webListPagerParam.jsp" />
            <!-- //리스트 조회수 -->
            
			<!-- list -->
			<div class="type-thumb type-list event">
				<ul>
				<c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <li class="cont">
                        <!-- 섬네일 이미지 -->
                        <p class="thumb fl mr20"><a href="#" onclick="jsView('${baseVo.eventSn}');"><img src="${baseVo.eventFilePath}" alt="${baseVo.imageAlt}" /></a></p>
                        <!-- //섬네일 이미지 -->
                        <dl>
                            <!-- 이벤트 제목 -->
                            <dt><a href="#" onclick="jsView('${baseVo.eventSn}');">${baseVo.eventTitle}</a></dt>
                            <!-- //이벤트 제목 -->
						    <dd>
							    <ul>
							        <!-- 이벤트 기간 -->
							        <li>기간 : ${baseVo.beginDate} ~ ${baseVo.endDate}</li>
                                    <!-- //이벤트 기간 -->
                                    <c:set var="evTyCdPt" value="<%=webEventVO.EV_TY_CD_PT %>" />
                                    <c:set var="evTyCdPm" value="<%=webEventVO.EV_TY_CD_PM %>" />
                                    <!-- 이벤트 발표일자/이벤트 당첨자 확인 -->
                                    <c:if test="${baseVo.eventTyCd == evTyCdPt || baseVo.eventTyCd == evTyCdPm}">
                                        <li>발표 : ${baseVo.presnatnDate} ${baseVo.presnatnHm} </li>
                                        <c:if test="${searchMap.q_flag eq 'Y' and baseVo.przwnerCnfirmUrl ne ''}">
	                                        <li><a href="${baseVo.przwnerCnfirmUrl}" target="_blank">당첨자 확인</a></li>
                                        </c:if>
                                    </c:if>
                                    <!-- //이벤트 발표일자/이벤트 당첨자 확인 -->
							    </ul>
						    </dd>
                        </dl>
                    </li>
                </c:forEach>
                <!-- 데이터가 없을 때 알림 문구 -->
                <c:if test="${empty pager.list}">
                    <op:no-data obj="${pager}" colspan="${thCnt}" />
                </c:if>
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


	</div>
	<!-- //contents -->
</form>



    