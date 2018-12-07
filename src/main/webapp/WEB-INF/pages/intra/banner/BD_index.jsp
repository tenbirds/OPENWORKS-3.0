<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>배너 관리</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="highlight" />

<!-- 기능별 스크립트 정의 -->

<script type="text/javascript">
//<CDATA[[

    $().ready(function(){
         $("input[name=chk-all]").click(function() {
             var isChecked = this.checked;
             $("input[name=bannerSns]").each(function() {
                 this.checked = isChecked;
             });
         });
    }); //ready
       
          
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

    var jsInsertForm = function(){
        document.dataForm2.action = "BD_insertForm.do";
        document.dataForm2.submit();
    };

    var jsUpdate = function(el,vl){
        document.dataForm2.action = "BD_updateForm.do?bannerSn=" + vl;
        document.dataForm2.submit();
    };

    var jsViewImg = function(el, vl, zl){
        $(el).colorbox({
            title : zl,
            href  : vl,
            width : "300",
            height: "300"
        });
    };

    var jsSearch = function(){
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    
    var jsUseYn = function(bannerSn){
        var elementz = $('#UseYn_' + bannerSn);
        var useYnVal = elementz.html() == '사용' ? 'N' : 'Y';
        $.post("ND_bannerUseYnUpdateAction.do", {
            bannerSn : bannerSn,
            useYn : useYnVal
        },
        function(response){

            try {
                if(eval(response)) {
                    jsSuccessBox(Message.msg.processOk);
                    elementz.removeClass();

                    if(useYnVal == 'Y' ){
                        elementz.addClass("ico-chk");
                        elementz.attr("title", "클릭 시 미사용으로 변경");
                        elementz.text("사용");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_chk_blue.png");
                    }else{
                        elementz.addClass("tx_red");
                        elementz.attr("title", "클릭 시 사용으로 변경");
                        elementz.text("미사용");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_cancel_red.png");
                    }
                } else {
                    jsErrorBox(Message.msg.processFail);
                }
            } catch (e) {
                jsSysErrorBox(response, e);
                return;
            }
        });
    };
		
    var jsFbUseYn = function(frontboardSn){
        var elementz = $('#FbUseYn_' + frontboardSn);
        var useYnVal = elementz.html() == '사용' ? 'N' : 'Y';
        $.post("ND_UseYnFrontBoardUpdateAction.do", {
            frontboardSn : frontboardSn,
            useYn : useYnVal
        },
        function(response){

            try {
                if(eval(response)) {
                    jsSuccessBox(Message.msg.processOk);
                    elementz.removeClass();

                    if(useYnVal == 'Y' ){
                        elementz.addClass("ico-chk");
                        elementz.attr("title", "클릭 시 미사용으로 변경");
                        elementz.text("사용");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_chk_blue.png");
                    }else{
                        elementz.addClass("tx_red");
                        elementz.attr("title", "클릭 시 사용으로 변경");
                        elementz.text("미사용");
                        elementz.next("img").attr("src","/resources/intra/mgr/icon_cancel_red.png");
                    }
                } else {
                    jsErrorBox(Message.msg.processFail);
                }
            } catch (e) {
                jsSysErrorBox(response, e);
                return;
            }
        });
    };
    
    
    var jsOrder = function(el){
        $(el).colorbox({
            title : "배너 정렬 관리",
            href  : "PD_order.do",
            width : "700",
            height: "700",
            iframe: true
        });
    };


    /**
     * 목록 삭제
     */
    var jsDeleteList = function(){
        var url = "ND_deleteAction.do?";
        var bannerSns = new Array();
        $("input[name=bannerSns]:checked").each(function (i) {
            bannerSns[i] = $(this).val();
            url += "bannerSns=" + $(this).val() + "&";
        });

        if(bannerSns.length == 0){
            jsWarningBox("삭제 대상 배너를 1개 이상 선택하세요.");
            return false;
        }else{
            if(confirm("선택한 " + bannerSns.length + "개의 배너을 정말 삭제하시겠습니까?")){
                $.post(url,
                function(response){
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            self.location.reload();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                });
            }
        }
    };
    
//]]>
</script>
</head>
<body>
	<div id="contents">
		<form name="dataForm2" id="dataForm2" method="post">
		</form>

		<!-- 검색 -->
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
            <input type="hidden" name="q_seq" id="q_seq" value="" />
          
			<div class="search">
	            <fieldset>
	                <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
	                <label class="skip" for="boardsearch">게시물 검색항목</label>
	                
	                <select id="q_domainCd" title="전체" name="q_domainCd">
                      <option value="">전체</option>
                      <c:forEach items="${dataVo}" var="_bean">
                      <option value="${_bean.domainCd }" <c:if test="${param.q_domainCd eq  _bean.domainCd}">selected="selected"</c:if>>${_bean.domainDc}</option>
                      </c:forEach>
                  </select>
                    <label class="skip" for="boardsearch2">게시물 검색항목2</label>
                    <op:code id="bannerTyCd" grpCd="40" defaultValues="${param.bannerTyCd}" type="select" defaultLabel="전체"/>
	                <label class="skip" for="searchText">검색단어 입력</label>
	                <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
	                <button class="gray mar_l5 mar_b5" onclick="jsSearch();">검색</button>
	            </fieldset>
	        </div>
            <op:pagerParam title="배너 목록" />
        </form>
		<!-- //검색 -->
		<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>

		<!-- 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
			<caption class="hidden"> 목록 </caption>
			<colgroup>
                <col width="5%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="15%"/>
                <col width="10%"/>
				<col width=""/>
				<col width="8%"/>
				<col width="8%"/>
			</colgroup>
			<thead>
				<tr>
          <th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
					<th>번호</th>
					<th>사이트</th>
					<th>이미지</th>
          <th>광고주</th>
					<th>특성</th>
					<th>상태</th>
					<th class="lr_none">사용여부</th>
				</tr>
			</thead>
			<tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
				<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
					<tr>
                        <td><input type="checkbox" name="bannerSns" value="${baseVo.bannerSn}"/></td>
                        <td>${index-status.index}</td><!-- <td>${baseVo.bannerSn}</td> -->						
						<td>
							<p class="mar_t5">
                                <c:forEach items="${baseVo.domainCdList }" var="_bean" varStatus="status">
                                    <c:if test="${not status.first }">, </c:if>
                                    ${_bean.domainDc}
                                </c:forEach>
                                
                            </p>
						</td>
						<td>
							<c:if test="${not empty baseVo.bannerFilePath}">
								<a href="#" onclick="jsViewImg(this,'${baseVo.bannerFilePath }','${baseVo.bannerTitle }');">
								<img src="${baseVo.bannerFilePath }" alt="${baseVo.imageAlt }" style="border: 1px solid #333333;height:60px;width: 100px;"/></a>
							</c:if>
						</td>
                        <td class="tx_l">
                            ${baseVo.advrtsClientNm}
                        </td>
						<td>
							<div class="tx_l">
						    	<a href="#" onclick="jsUpdate(this,'${baseVo.bannerSn}');">
									<span style="font-weight: bold;">종류 </span><span style="font-weight: bold; margin-left: 31px;">: &nbsp;&nbsp;</span><span>${baseVo.bannerTyNm}</span>
									<br />
									<span style="font-weight: bold;">제목 </span><span style="font-weight: bold; margin-left: 31px;">: &nbsp;&nbsp;</span><span>${fn:substring(baseVo.bannerTitle,0,30)}<c:if test="${fn:length(baseVo.bannerTitle) > 30}">...</c:if></span>
									<br />
									<span style="font-weight: bold;">표시 기간 </span><span style="font-weight: bold;">: &nbsp;&nbsp;</span><span>${fn:substring(baseVo.beginDate,0,4)}-${fn:substring(baseVo.beginDate,4,6)}-${fn:substring(baseVo.beginDate,6,8)}
									~ ${fn:substring(baseVo.endDate,0,4)}-${fn:substring(baseVo.endDate,4,6)}-${fn:substring(baseVo.endDate,6,8)}</span>
								</a>
							</div>
						</td>
						<td <c:if test="${baseVo.gubun eq 1}">class="tx_red"</c:if><c:if test="${baseVo.gubun eq 2}">class="tx_blue"</c:if>>
								<c:if test="${baseVo.gubun eq 1}">진행중</c:if>
								<c:if test="${baseVo.gubun eq 0}">종료</c:if>
								<c:if test="${baseVo.gubun eq 2}">대기중</c:if>
						</td>
						<td class="lr_none">
							<c:if test="${baseVo.useYn eq 'N'}">
								<a href="javaScript:jsUseYn('${baseVo.bannerSn}');">
									<span id="UseYn_${baseVo.bannerSn}" class="tx_red" title="클릭 시 사용으로 변경">미사용</span> <img src="/resources/intra/mgr/icon_cancel_red.png" style="vertical-align:middle;" />
								</a>
							</c:if>
							<c:if test="${baseVo.useYn eq 'Y'}">
								<a href="javaScript:jsUseYn('${baseVo.bannerSn}');">
									<span id="UseYn_${baseVo.bannerSn}" class="ico-chk" title="클릭 시 미사용으로 변경">사용</span> <img src="/resources/intra/mgr/icon_chk_blue.png" style="vertical-align:middle;" />
								</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<op:no-data obj="${pager}" colspan="8" />
			</tbody>
		</table>
		<!-- //리스트 -->

		<!-- 페이징 -->
		<op:pager pager="${pager}" />
		<!-- //페이징 -->
		<div class="tx_r">			
			<a href="#" onclick="jsOrder(this);"><button class="blue" type="button">광고/배너정렬</button></a>
			<c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'  or MenuAssignType eq 'R'}">
				<button class="blue" type="button" onclick="jsInsertForm();">광고/배너 등록</button>
                <button class="blue" type="button" onclick="jsDeleteList();">선택항목삭제</button>
			</c:if>
		</div>

	</div>
	<!-- //컨텐츠영역 -->
</body>
</html>