<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<op:jsTag type="spi" items="datepicker" />
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">

    $().ready(function () {
        
        
        $('#q_beginDate').datepicker({
            dateFormat: 'yy-mm-dd',
            showOn : 'button'
        });

        $('#q_endDate').datepicker({
            dateFormat: 'yy-mm-dd',
            showOn : 'button'
        });

        // 기간,발표일 달력 생성
        $("span#eventPeriod  span a").click(function(){

            
            var sType = $(this).attr('id');
            var date = $('#q_endDate').val().replace(/\/|\-/g, "");
            var yy = parseInt(date.substr(0, 4), 10);
            var mm = parseInt(date.substr(4, 2), 10);
            var dd = parseInt(date.substr(6, 2), 10);
            var endDt = new Date(yy, mm - 1, dd);
            var nowDt = new Date();
            
            switch(sType){
                case 'd_0' :
                    $('#q_beginDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
                    $('#q_endDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
                    break;
                case 'd_7D':
                    endDt.setDate(endDt.getDate() - 7);
                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
                    break;
                case 'd_1M':
                    endDt.setMonth(endDt.getMonth() - 1);                    
                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
                    break;
                case 'd_3M':
                    endDt.setMonth(endDt.getMonth() - 3);
                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
                    break;
                default:
                    break;
            }
        });
        
        
        
    });

    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
        while(num.toString().length < len) {
            num = "0" + num;
        }
        return num;
    }; //prependZero
    
    var jsSearch = function(){
        document.dataForm.action = "BD_eventList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
    
    var jsAllSearch = function(){
        $("#q_searchVal").val("");
        $("#q_eventStatus1").attr("checked", true);
        $("#q_eventStatus2").attr("checked", true);
        $("#q_eventStatus3").attr("checked", true);
        $("#q_dateTy").val("1001");
        $("#q_beginDate").val("2000-01-01");
        $("#q_endDate").val("2100-12-31");
        
        jsSearch();
    };
    
    
    var jsView = function(eventSn,flag){
        //조회수
        $.post("ND_rcntUpdateAction.do",{eventSn:eventSn},
        function(response){
            try {
                if(eval(response)){
                    post_to_url("BD_eventView.do",{"eventSn":eventSn,"flag":flag});
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
    
    
    
    //페이지 이동
    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#inquiryForm input[name=q_currPage]").val(p);
        $("#inquiryForm").submit();
    };
    
</script>

    <form name="dataForm" id="dataForm" method="get" action="BD_eventList.do">
        <input type="hidden" id="q_currPage" name="q_currPage"/>

		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
			<div class="title-area">
				<h2>응모이벤트 내역</h2>
			</div>
			<!-- //title-area -->

			<!-- section -->
			<div class="section">
				<div class="tab-search">
					<table>
						<caption>검색</caption>
						<colgroup>
						<col style="width:80px;"/>
						<col style="width:;"/>
						</colgroup>
						<tbody>

							<tr>
								<th>이름</th>
								<td><input type="text" class="w304" id="q_searchVal" name="q_searchVal" value="${searchMap.q_searchVal}"/>
								    <span class="agree ml20">
								        <input type="checkbox" name="q_eventStatus" id="q_eventStatus1" value="1001" <c:if test="${empty searchMap.q_eventStatus || fn:contains(searchMap.q_eventStatus,'1001')}">checked="checked"</c:if> /><label for="">진행중</label>
								        <input type="checkbox" name="q_eventStatus" id="q_eventStatus2" value="1002" <c:if test="${fn:contains(searchMap.q_eventStatus,'1002')}">checked="checked"</c:if> /><label for="">응모종료</label>
								        <input type="checkbox" name="q_eventStatus" id="q_eventStatus3" value="1003" <c:if test="${fn:contains(searchMap.q_eventStatus,'1003')}">checked="checked"</c:if> /><label for="">결과발표</label>
								    </span>
								</td>
							</tr>

							<tr>
								<th>기간</th>
								<td>
									<!-- static select -->
									<div class="select-area fl">
										<!-- select box -->
										<div class="sech_form">
											<div class="cont_wrap">
												<div class="selected">
													<select name="q_dateTy" id="q_dateTy" title="기간 선택" style="width: 80px; position: absolute; left: -100000px; height: auto;">
                                                           <option value="1001" <c:if test="${empty searchMap.q_dateTy ||  searchMap.q_dateTy eq '1001'}">selected="selected"</c:if>>응모기간</option>
                                                           <option value="1002" <c:if test="${searchMap.q_dateTy eq '1002'}">selected="selected"</c:if>>결과발표일</option>
													</select>
												</div>
											</div>
										</div>
										<!-- //select box -->
									</div>
									<!-- //static select -->

									<div class="calendar_input">
									  <input type="text" class="input" name="q_beginDate" id="q_beginDate" readonly="readonly" title="시작날짜선택" style="width:75px" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
									</div>
									<span class="divide"> ~ </span>										
									<div class="calendar_input end">
									  <input type="text" class="input" name="q_endDate" id="q_endDate" readonly="readonly" title="종료날짜선택" style="width:75px" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
									</div>

                                       <span id="eventPeriod">
									    <span><a href="#" id="d_0"  class="b-btn mr05 type1"><strong><span>오늘</span></strong></a></span>
									    <span><a href="#" id="d_7D" class="b-btn mr05 type1"><strong><span>1주일</span></strong></a></span>
									    <span><a href="#" id="d_1M" class="b-btn mr05 type1"><strong><span>1개월</span></strong></a></span>
									    <span><a href="#" id="d_3M" class="b-btn mr05 type1"><strong><span>3개월</span></strong></a></span>
									</span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- //section -->
			
			<!-- btn-area -->
			<div class="btn-area mt10 ar">
				<a href="#" class="b-btn search type2" onclick="jsSearch();"><strong><span>검 색</span></strong></a>
				<a href="#" class="b-btn ml10 type1" onclick="jsAllSearch();"><strong><span>전체보기</span></strong></a>
			</div>
			<!-- //btn-area -->

			<!-- section -->
			<div class="section">
				<h3 class="stitle"></h3>
                
                <span class="totalcount">
                    <op:pagerParam page="param/webListPagerParam.jsp" />
                </span>
				
				<!-- list -->
				<div class="type-list">
					<table>
						<caption>
                               <strong>응모 이벤트 검색 결과</strong>
                               <details>
                                   <summary>번호, 이름, 닉네임, 상태, 최종방문일, 개설일, 가입일(탈퇴일),방문수, 회원수, 게시글 탈퇴 정보를 제공합니다.</summary>
                               </details>
						</caption>
						<colgroup>
						    <col style="width:80px;"/>
						    <col style="width:*;"/>
						    <col style="width:100px;"/>
						    <col style="width:180px;"/>
						    <col style="width:100px;"/>
						    <col style="width:80px;"/>
						    <col style="width:80px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<th>진행상태</th>
								<th>응모기간</th>
								<th>결과 발표일</th>
								<th>조회수</th>
								<th>참여자수</th>
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
						    <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
						        <tr>
						            <td>${index-status.index}</td><!-- 번호 -->
						            <td class="title"><a href="#" onclick="jsView(${baseVo.eventSn},'${baseVo.flag}')">${baseVo.eventTitle}</a></td><!-- 이름 -->
						            <td>${baseVo.eventStatus}</td><!-- 진행상태 -->
                                       <td>${baseVo.beginDate} ~ ${baseVo.endDate}</td>
                                       <td>${baseVo.presnatnDate}</td>
                                       <td>${baseVo.eventRdcnt}</td>
                                       <td>${baseVo.commentRcnt}</td>
						        </tr>
						    </c:forEach>
						    <op:no-data obj="${pager}" colspan="7" />
						</tbody>
					</table>
				</div>
				<!-- //list -->

				<!-- paging -->
				<div class="paging">
					<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
				</div>
				<!-- //paging -->

			</div>
			<!-- //section -->

		</div>
		<!-- //contents -->
    </form>