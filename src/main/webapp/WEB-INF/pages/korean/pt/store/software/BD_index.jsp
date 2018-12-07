<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
String sessionID = (String)session.getId();
session.setAttribute("tempId", sessionID);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>솔루션 서비스</title>
    <script type="text/javascript">
	var type = true;
	var funUnitSysChange = function(){
	    if(type){
	        $('#searchs').show();
	        type = false;
	    }else if(!type){
	        $('#searchs').hide();
	        type = true;
	    }
	};
    $().ready(function () {
      
        $("#all_check").click(function(){
           if ($("#all_check").is(":checked")){
            	$(".goods_check").attr("checked", true);
        	}else{
        	    $(".goods_check").attr("checked", false);
        	} 
        });
        

        // 2017.11.29 eulro.yoon 추가
		// '서비스 비교 담기' 
		$('#svcCompare').click(function() {
        	var items = []; 
            var checkCnt = 0;
            var sessionid = '${sessionScope.tempId}';
            $('input:checkbox[name=goods_check]:checked').each(function () { 
                	items.push($(this).val());
            });
            checkCnt = items.length;
           	if (checkCnt == 0 ) {
                alert('비교하실 서비스는 적어도 1개 이상 선택 하셔야 합니다.');
                return false;
            }
            _loadComare(items, '${sessionScope.tempId}', true);
            $('input:checkbox[name=goods_check]:checked').attr("checked", false);
        }) ;
        
        var items = []; 
        items.push('');
        _loadComare(items, '${sessionScope.tempId}', false);
    });
    
	var _loadComare= function(items, sessionid, showflg){
	    $.ajax({
	        type     : "POST",
	        url      : "/myCeart/BD_goodsTmp.do",
	        data     : { "item"      : items
	                    ,"sessionId" : sessionid
	                   },
	        dataType : "json",
	        success  :function(data){
				var goodsHtml = "";//new StringBuffer();
	         
	         	$('#itemWrap').html('');	//append 초기화
	         	if(showflg){ // 아래 서비스 비교창을 보이도록한다.
	         	   	$('.location_wrap').animate({ bottom:'0' }, 300).addClass('active');
	    			$('.btn_compare').css('background-image','url(/cloud_ver3/html_web/images/icon_compareClose.png)')
	         	}
	         	$('#compCnt').text(data.length);
	                 
                for (i=0; i<data.length; i++) {
                	goodsHtml = '<li>';
                    goodsHtml = goodsHtml + '<span><label><input type="checkbox"  title='+data[i].GOODS_NM+' id="goods_code" name="goods_code" goods_type="'+data[i].GOODSTYNM+'"  value='+data[i].GOODS_CODE+' class="goods_code" /></label></span>'
                    goodsHtml = goodsHtml + '<span>['+data[i].GOODSTYNM+']</span> <span>'+data[i].GOODS_NM+'</span> ';
                    goodsHtml = goodsHtml + '<span class="btn_delete"><a href="#" onClick="fnGoodsDelete(\''+data[i].GOODS_CODE+'\'); return false;">삭제</a></span>';
                    goodsHtml = goodsHtml + '</li>';
                    
                    $('#itemWrap').append(goodsHtml);
                }
                
                return false;
	        }
	    }); 
	}
	
    var _serCompare = function(goodId){
        $('.serCompare').removeClass('hidden').addClass('on');  
        var goodsName =  $("#goodsNm_"+goodId).val();
        var storeNm	  =  $("#storeNm_"+goodId).val();
        var goodImage =  $("#goodImage_"+goodId).val();
        var productInfro="<span id='compareItem_"+goodId+"'><span style='cursor: pointer;'><img src='"+goodImage+"' alt='"+goodsName+"' /><i>"+goodsName+"</i></span>";
        productInfro +="<span><span style='cursor: pointer;'>"+storeNm+"</a><input type='checkbox' /> <button onClick='_serCompareDelte(\""+goodId+"\"); return false;'>삭제</button></span></span>";
        $('#itemWrap').append(productInfro);
    } 
    
    var _serCompareClear = function(){
        var items = [];
        var checkCnt = 0;
        var sessionid = '${sessionScope.tempId}';
        $('input:checkbox[name=goods_code]:checked').each(function () { 
            items.push($(this).val());
        });
        
        checkCnt = items.length;
 		
        if ($('#compCnt').text() != '0') {
	        if (confirm("정말 삭제하시겠습니까??") == true){
		        $.ajax({
		            type: "POST",
		            url: "/myCeart/BD_goodsTmpDelete.do",
		            data: {"item" : items, "sessionId" : sessionid},
		            dataType: "json",
		            success:function(data){
		                console.log("data: " + data);
		                $('#itemWrap').html('');
		                $('#compCnt').text("0");
		                $('#btnDel').unbind('click');
		                return false;
		            }
		        });
	        }else {
	            return false;
	        }
        }else{
            alert('삭제할 비교서비스가 없습니다.');
            return false;
        }
    }
    
    var _serCompareDelte = function(goodId){
        $('#compareItem_'+goodId).html('');
    }
    
    var jsMovePage = function(page) {
        createItem();
        $("#dataForm input[name=q_currPage]").val(page);
        document.dataForm.action = "BD_index.do";
        document.dataForm.method = "post";
        document.dataForm.submit();
    };

    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "../inc/BD_storeView.do";
        document.dataForm.submit();

    };

    var jsSearch = function(){
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
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
    };

    function selectSort(num, goodsTyCd) {
        createItem();
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.elements["q_sortName"].value = num; 
        document.dataForm.submit();
    };
    
    function filterSearch() {
       /*  if($("input[type='checkbox']:checked").length < 1){
        	alert('1개이상 선택하세요');
        	return;
        } */
        createItem();
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
    	document.dataForm.submit();
    };
    
    function initFilter() {
        var checkObjs = $("input[type='checkbox']:checked");
        checkObjs.prop("checked", false);
    }

    function createItem(){
        var items = [];
        var itemsName = [];
        var selectItem12Len = $('input:checkbox[name="selectItem12"]:checked').length;
        if(selectItem12Len > 0) {
            $('input:checkbox[name=selectItem12]:checked').each(function () {
               	items.push($(this).val());
               	
               	if ($(this).val() == '1001') {
               	    itemsName.push('IaaS');               	    
               	}
               	if ($(this).val() == '1002') {
               	    itemsName.push('SaaS');
               	}
               	if ($(this).val() == '1003') {
               	    itemsName.push('PaaS');
               	}
               	if ($(this).val() == '1004') {
               	    itemsName.push('SCS');
               	}
            });
            $("#selectItem3").val(items);
            //$("#selectNames").text(itemsName);
        }else{
            $("#selectItem3").remove();
        }
        /* <c:set var="selecItemNames" value="" /> */
		
        
        if($('input:checkbox[name="selectItem5"]:checked').length > 0)
            $("#creteItem").html("<input type='hidden' name='selectItem5' value='3'>");
        else 
            $("#creteItem").html("");
    }
    
    //탭 클릭시 동작 처리
    var jsSeller = function(userId) {
        $("#userId").val(userId);
        document.dataForm.action = "../BD_goodsOfSeller.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
 
	<c:set var="flgChk" value="Y" />
	
	// '이용희망목록 담기' 클릭
    var jsWishPurch = function(el,mode) {
        <c:if test="${empty sessionScope['__usk']}"> 
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin + "?returnUrl=/korean/pt/store/software/BD_index.do&amp;returnParam=goodsTyCd=${goodsTyCd}";
        }
        </c:if>
        <c:if test="${not empty sessionScope['__usk']}">
        
        $(".btn_select a").removeClass("cboxElement");
        $(".btnArea a").removeClass("cboxElement");
        
        $good_jop = "";
        
        var errmsg = '' ;
        
        if(mode == "list") 
        {            
	        $(".goods_check").each(function()
            {
	            if ($(this).is(":checked"))
	            {
		            if  ( $(this).parent().attr("value") == '<c:out value="${sessionScope['__usk'].userId}"/>')
		            {
		                if  (errmsg == '') errmsg = "자신의 서비스(같은ID)를 목록에 담을 수 없습니다." ; 
		            }
		            else
		            {
		                $good_jop += ","+$(this).val();			                
		            }
	            }
	        });
        }
        
        if(mode == "compare") {
            $(".goods_code").each(function(){
	            if($(this).is(":checked")){
	                $good_jop += ","+$(this).val();
	            }
	        });
        }
        
        if  (errmsg != '') 
        {
            $good_jop = "";
            alert( errmsg );
            return false;
        }
        else
        {
	        if($good_jop =="") {alert('이용희망목록에 담을 서비스 1개 이상을 선택하세요.');  return false;}
	        $(el).colorbox({
	            title : "이용희망목록에 담기",
	            href : "/korean/pt/popup/PD_wishOrderPop.do?goodsTyCd=${goodsTyCd}&mode="+mode,
	            width : "910",
	            height : "230",
	            overlayClose : false,
	            escKey : false,
	            iframe : true
	        });
        }
        </c:if>
    };

    //서비스비교 전체선택/해제
	var fnGoodsCheckAll = function(obj){
	    var i;
	    var chk = document.getElementsByName("goods_code");
	    var tot = chk.length;
	    var checkedVal = $('.goods_code').prop("checked");
	        
	    if (checkedVal) {
	        $("input[name=goods_code]:checkbox").attr("checked", false);
	    }else{
	        $("input[name=goods_code]:checkbox").attr("checked", true);
	    }
    };

	var fnGoodsCheckComp = function(el){
	    
        var items = []; 
        var checkCnt = 0;
        var sessionid = '${sessionScope.tempId}';
        var type=""; 
        var checkType= true;
        $('input:checkbox[name=goods_code]:checked').each(function () { 
           	items.push($(this).val());
           	if(type == "") type=$(this).attr('goods_type');
           	if(type != $(this).attr('goods_type'))  checkType = false;
        });
        
        if(checkType == false){
	        alert("서비스 구분을 복합하여 선택하면 비교가 적용되지 않습니다.\n- 예 : IaaS, PaaS = 비교 불가\n        IaaS, IaaS = 비교 가능");
	        return false;
        }
        
        checkCnt = items.length;
        $(".btn_select a").removeClass("cboxElement");
	    if(checkCnt < 2) {
            alert("비교을 위해 최소 2개, 최대 3개를  선택해 주세요");
            return false;
        }	    
	    else
        {
	        if(checkCnt > 3) {
	            alert("선택상품 비교는 최대 3개까지 가능합니다.");
	            return false;
	        }else{
	            $(el).colorbox({
	                title        : "서비스비교",
	                href         : "/korean/pt/popup/PD_dbGoodsPop.do?checkCnt="+checkCnt+"&items="+items+"&si="+sessionid,
	                width        : "1190",
	                height       : "700",
	                overlayClose : false,
	                escKey       : true,
	                iframe       : true
	            });
	        }
        }        
    };
	
    var fnGoodsDelete = function (goodsCode) {
        var item = goodsCode;
        var sessionid = '${sessionScope.tempId}';
        
        if (confirm("정말 삭제하시겠습니까??") == true){
	        $.ajax({
	            type: "POST",
	            url: "/myCeart/BD_goodsTmpDelete.do",
	            data: {"item" : item, "sessionId" : sessionid},
	            dataType: "json",
	            success:function(data){
                 	$('#itemWrap').html('');	//append 초기화
                 	$('.serCompare').removeClass('hidden').addClass('on');
                 	$('#compCnt').text(data.length);
                    var goodsHtml="";
                    
                    for (var i=0; i<data.length; i++) {
                        goodsHtml = goodsHtml + "<li>"
                        goodsHtml = goodsHtml + '<span><label><input  type="checkbox" title="'+data[i].GOODS_NM+'" id="goods_code" name="goods_code" value='+data[i].GOODS_CODE+' class="goods_code"></label></span>'
                        goodsHtml = goodsHtml + '<span>['+data[i].GOODSTYNM+']</span> <span>'+data[i].GOODS_NM+'</span> ';
                        goodsHtml = goodsHtml + '<span class="btn_delete"><a href="#none" onClick="fnGoodsDelete(\''+data[i].GOODS_CODE+'\'); return false;">삭제</a></span>';
                        goodsHtml = goodsHtml + '</li>';
                     $('#itemWrap').html(goodsHtml);
                    }
	                return false;
	            }
	        });
        }
        
    };

    var jsCancel = function(){
        location.reload();
        return false;
    };
    </script>

</head>
<body>
    <!-- content -->
	<section class="listTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>클라우드서비스</h2>
<%-- 			<c:if test="${goodsTyCd == '1002'}"><h2>SaaS</h2></c:if>
			<c:if test="${goodsTyCd == '1001'}"><h2>PaaS</h2></c:if>
			<c:if test="${goodsTyCd == '1003'}"><h2>IaaS</h2></c:if> --%>
			
			<div>
			<c:if test="${empty ctgry.langCtgryNm}">전체</c:if>
			<c:if test="${not empty ctgry.langCtgryNm}">${ctgry.langCtgryNm}</c:if>
				<i><b>${pager.totalNum} </b>개 
				<%-- <c:if test="${goodsTyCd == '1002'}">SaaS</c:if>
                <c:if test="${goodsTyCd == '1001'}">PaaS</c:if>
                <c:if test="${goodsTyCd == '1003'}">IaaS</c:if> --%></i> 
			</div>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	<section class="lay_lnb">
    <form name="dataForm" id="dataForm" method="post" action="BD_index.do">
		<input type="hidden" id="q_currPage"  	   name="q_currPage"      value="${searchMap.q_currPage}" />
		<input type="hidden" id="q_sortName"  	   name="q_sortName"      value="${searchMap.q_sortName}" />
		<input type="hidden" id="q_sortOrder" 	   name="q_sortOrder"     value="${searchMap.q_sortOrder}" />
		<input type="hidden" id="ctgryCode"   	   name="ctgryCode"       value="${ctgry.ctgryCode}" />
		<input type="hidden" id="goodsCode"   	   name="goodsCode"       value="" />
		<input type="hidden" id="section"     	   name="section"         value="" />
		<input type="hidden" id="ctgryParentCode"  name="ctgryParentCode" value="${ctgryParentInit}">
		<input type="hidden" id="goodsTyCd"   	   name="goodsTyCd"       value="${goodsTyCd}">
		<input type="hidden" id="userId"           name="userId"          value="">	
		<input type="hidden" id="goodsCheck"  	   name="goodsCheck"      value="" />
		<input type="hidden" id="selectItem3"  	   name="selectItem3"     value="" />
		
		
		<div class="conWrap listsearch_area">
			<nav>
				<!-- 좌측 카테고리 -->
				<ul>
					<li <c:if test="${ctgryParentInit == null or ctgryParentInit == ''}"> class="on"</c:if>><a href="BD_index.do?goodsTyCd=${goodsTyCd}">전체 (${ctgryTotalCount})</a></li>
					<%-- <c:if test="${goodsTyCd ne '1001'}"> --%>
					<c:forEach items="${ctgryParentList}" var="_ctgryParentList" varStatus="status">
						<%-- <c:if test="${_ctgryParentList.ctgryDp eq '1'}" > --%>
						<li <c:if test="${_ctgryParentList.ctgryCode == ctgryParentInit}">class="on"</c:if>>
							
							<%-- <c:if test="${_ctgryParentList.ctgryClCd ne '1001'}" > --%>
							<a href="BD_index.do?goodsTyCd=${_ctgryParentList.ctgryClCd}&ctgryCode=${_ctgryParentList.ctgryCode}&ctgryParentCode=${_ctgryParentList.ctgryCode}">${_ctgryParentList.langCtgryNm} (${_ctgryParentList.ctgryCnt})</a>
							<%-- </c:if> --%>
							
							<%-- <c:if test="${_ctgryParentList.ctgryClCd eq '1001'}" > --%>
							<%-- <a href="BD_index.do?goodsTyCd=${_ctgryParentList.ctgryClCd}">${_ctgryParentList.langCtgryNm}</a> --%>
							<%-- </c:if> --%>
						</li>
						<%-- </c:if> --%>
						<c:if test="${_ctgryParentList.subCnt > 0}" >
						<ul>
						<c:forEach items="${ctgryParentList}" var="_ctgrySubList" varStatus="status">
						<c:if test="${_ctgrySubList.ctgryDp > 1 and _ctgryParentList.ctgryCode eq _ctgrySubList.parntsCtgryCode}" >
							<li><a href="BD_index.do?goodsTyCd=${goodsTyCd}&ctgryCode=${_ctgrySubList.ctgryCode}&ctgryParentCode=${_ctgryParentList.ctgryCode}"  <c:if test="${_ctgrySubList.ctgryCode == ctgryInit}">class="on"</c:if>>${_ctgrySubList.langCtgryNm}</a></li>
						</c:if>
						</c:forEach></ul>
						<li>
						</c:if>
					</c:forEach>
					<%-- </c:if>  --%>
				</ul>
			</nav>
			
			<!--필터검색-->
			<c:set var="selecItemNames" value="" /> 
			<div class="filter_area">
				<p>필터검색</p>
				<ul class="btn_top">
					<li><span onClick="initFilter();" class="btns st3" style="cursor: pointer;">초기화</span></li>
					<li><span onClick="filterSearch();" class="btns st5" style="cursor: pointer;">적용</span></li>
				</ul>
				<div class="filter_St01 clearfix">
					<h3>공공기관 이용 필터</h3>
					<ul class="clearfix">
					<c:forEach items="${organUserList}" var="_organUserList" varStatus="status">
						<li>
							<label>
							<c:if test="${_organUserList.prvCd eq '1001'}">
								<c:set var="codeval" value="1004" />
								<input type="checkbox" title="${_organUserList.prvNm}" id="selectItem13" name="selectItem13" value="${codeval}" <c:if test="${fn:contains(selectItem13,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
							</c:if>
							<c:if test="${_organUserList.prvCd ne '1001'}">
								<c:set var="codeval" value="2060${_organUserList.prvCd}" />
								<input type="checkbox" title="${_organUserList.prvNm}" id="selectItem2" name="selectItem2" value="${codeval}" <c:if test="${fn:contains(selectItem2,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_organUserList.prvNm} " /></c:if>/>
							</c:if>
							${_organUserList.prvNm}
							</label>
						</li>
					</c:forEach>
					</ul>
				</div>
				<div class="filter_St01 clearfix">
					<h3>서비스 구분</h3>
					<ul class="clearfix">
						<li>
							<label>
								<input type="checkbox" title="IaaS" id="selectItem12" name="selectItem12" value="1003" <c:if test="${fn:contains(param.selectItem3,'1003')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / IaaS" /></c:if> />
						 		IaaS
						 	</label>
						</li>
						<li>
							<label>
								<input type="checkbox" title="SaaS" id="selectItem12" name="selectItem12" value="1002" <c:if test="${fn:contains(param.selectItem3,'1002')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SaaS" /></c:if> /> 
						 		SaaS
						 	</label>
						</li>
						<li>
							<label>
								<input type="checkbox" title="PaaS" id="selectItem12" name="selectItem12" value="1001" <c:if test="${fn:contains(param.selectItem3,'1001')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / PaaS" /></c:if> /> 
						 		PaaS
						 	</label>
						</li>
						<li>
							<label>
								<input type="checkbox" title="SCS" id="selectItem12" name="selectItem12" value="1004" <c:if test="${fn:contains(param.selectItem3,'1004')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / SCS" /></c:if> /> 
						 		SCS
						 	</label>
						</li>
					</ul>
				</div>
				<div class="filter_St01 clearfix">
					<h3>클라우드 구축방식</h3>
					<ul class="clearfix">
						<c:forEach items="${buildMethodList}" var="_buildMethodList" varStatus="status">
						<li>
							<c:set var="codeval" value="2032${_buildMethodList.prvCd}" />
							<label>
								<input type="checkbox" title="${_buildMethodList.prvNm}" id="selectItem7" name="selectItem7" value="${codeval}"  <c:if test="${fn:contains(selectItem7,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_buildMethodList.prvNm} " /> </c:if>/> 
								${_buildMethodList.prvNm}
							</label>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="filter_St01 clearfix">
					<h3>인증정보</h3>
					<ul class="clearfix">
					<c:forEach items="${certificationList}" var="_certificationList" varStatus="status">
						<li>
							<c:set var="codeval" value="${_certificationList.prvCd}" />
							<label>
								<input type="checkbox" title="${_certificationList.prvNm}" id=selectItem4 name="selectItem4" value="${codeval}" <c:if test="${fn:contains(selectItem4,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_certificationList.prvNm} " /> </c:if>/> 
								${_certificationList.prvNm}
							</label>
						</li>
					</c:forEach>
					</ul>
				</div>
				<span class="btn_open" style="cursor: pointer;">확장</span>
				<div class="filter_close">
					<span class="btn_close" style="cursor: pointer;">숨김</span>
					<div class="filter_St01 clearfix">
						<h3>서비스기술지원</h3>
						<ul class="clearfix">
							<c:forEach items="${serviceManageList}" var="_serviceManageList" varStatus="status">
							<c:set var="codeval" value="2030${_serviceManageList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" title="${_serviceManageList.prvNm}" id="selectItem5" name="selectItem5" value="${codeval}" <c:if test="${fn:contains(selectItem5,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_serviceManageList.prvNm} " /></c:if>/> 
									${_serviceManageList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<c:if test="${goodsTyCd == '1002'}">
					<div class="filter_St01 clearfix">
						<h3>호환성 지원</h3>
						<ul class="clearfix">
						<c:forEach items="${compatibilityList}" var="_compatibilityList" varStatus="status">
							<c:set var="codeval" value="2031${_compatibilityList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" title="${_compatibilityList.prvNm}" id="selectItem6" name="selectItem6" value="${codeval}" <c:if test="${fn:contains(selectItem6,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_compatibilityList.prvNm} " /> </c:if>/> 
									${_compatibilityList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>개발지원</h3>
						<ul class="clearfix">
						<c:forEach items="${deploySupportList}" var="_deploySupportList" varStatus="status">
							<c:set var="codeval" value="2056${_deploySupportList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" title="${_deploySupportList.prvNm}" id="selectItem8" name="selectItem8" value="${codeval}" <c:if test="${fn:contains(selectItem8,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_deploySupportList.prvNm} " /></c:if>/> 
									${_deploySupportList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					</c:if>
					<div class="filter_St01 clearfix">
						<h3>교육, 기술지원</h3>
						<ul class="clearfix">
						<c:forEach items="${eduTechSupportList}" var="_eduTechSupportList" varStatus="status">
						<c:set var="codeval" value="2057${_eduTechSupportList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" title="${_eduTechSupportList.prvNm}" id="selectItem9" name="selectItem9" value="${codeval}" <c:if test="${fn:contains(selectItem9,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_eduTechSupportList.prvNm} " /></c:if>/> 
									${_eduTechSupportList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>관리정보제공</h3>
						<ul class="clearfix">
						<c:forEach items="${mangerInfotList}" var="_mangerInfotList" varStatus="status">
						<c:set var="codeval" value="2058${_mangerInfotList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" title="${_mangerInfotList.prvNm}" id="selectItem10" name="selectItem10" value="${codeval}" <c:if test="${fn:contains(selectItem10,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_mangerInfotList.prvNm} " /></c:if>/> 
									${_mangerInfotList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3> 기업구분</h3>
						<ul class="clearfix">
						<li>
<!-- 
중소기업	1003	
중견기업	1002	
대기업	1001 
-->
							<label><input type="checkbox" title="중소기업" id="selectItem1" name="selectItem1" value="1003" <c:if test="${fn:contains(selectItem1,'1003')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중소기업 " /> </c:if> /> 중소기업</label>
						</li>
					  <li>
					  	<label><input type="checkbox" title="중견기업" id="selectItem1" name="selectItem1" value="1002" <c:if test="${fn:contains(selectItem1,'1002')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 중견기업 " /> </c:if> /> 중견기업</label>
					  </li>
					  <li>
					  	<label><input type="checkbox" title="대기업" id="selectItem1" name="selectItem1" value="1001" <c:if test="${fn:contains(selectItem1,'1001')}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / 대기업 " /> </c:if> /> 대기업</label></li>
					  </ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>고객지원 </h3>
						<ul class="clearfix">
						<c:forEach items="${customSupportList}" var="_customSupportList" varStatus="status">
						<c:set var="codeval" value="2059${_customSupportList.prvCd}" />
							<li>
								<label>
									<input type="checkbox" title="${_customSupportList.prvNm}" id="selectItem11" name="selectItem11"  value="${codeval}" <c:if test="${fn:contains(selectItem11,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_customSupportList.prvNm} " /> </c:if> /> ${_customSupportList.prvNm}
								</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<%-- <div class="filter_St01 clearfix">
						<h3>최소 계약단위</h3>
						<ul class="clearfix">
						<c:forEach items="${contractUnitList}" var="_contractUnitList" varStatus="status">
							<li><c:set var="codeval" value="2028${_contractUnitList.prvCd}" />
								<label><input type="checkbox" id="selectItem3" name="selectItem3" value="${codeval}"  <c:if test="${fn:contains(selectItem3,codeval)}">checked="checked" <c:set var="selecItemNames" value="${selecItemNames} / ${_contractUnitList.prvNm} " /> </c:if>/> ${_contractUnitList.prvNm}</label>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>서비스관리</h3>
						<ul class="clearfix">
						<c:forEach items="${serviceManageList}" var="_serviceManageList" varStatus="status">
							<li><label><c:set var="codeval" value="2030${_serviceManageList.prvCd}" />
								<input type="checkbox" id="selectItem5" name="selectItem5" value="${codeval}" 
								<c:if test="${fn:contains(selectItem5,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_serviceManageList.prvNm} " />
								</c:if>/> ${_serviceManageList.prvNm}</label></li>
						</c:forEach>
						</ul>
					</div>
					<div class="filter_St01 clearfix">
						<h3>호환성 지원</h3>
						<ul class="clearfix">
						<c:forEach items="${compatibilityList}" var="_compatibilityList" varStatus="status">
							<li><label><c:set var="codeval" value="2031${_compatibilityList.prvCd}" />
								<input type="checkbox" id="selectItem6" name="selectItem6" value="${codeval}" 
								<c:if test="${fn:contains(selectItem6,codeval)}">checked="checked"
							 	<c:set var="selecItemNames" value="${selecItemNames} / ${_compatibilityList.prvNm} " />
								</c:if>/> ${_compatibilityList.prvNm}</label></li>
						</c:forEach>
						</ul>
					</div>
					
					<div class="filter_St01 clearfix">
						<h3>지원언어</h3>
						<ul class="clearfix">
						<c:forEach items="${languageList}" var="_languageList" varStatus="status">
							<li><label><c:set var="codeval" value="1019${_languageList.prvCd}" />
								<input type="checkbox" id="selectItem8" name="selectItem8"  value="${codeval}" 
								<c:if test="${fn:contains(selectItem8,codeval)}">checked="checked"
						 		<c:set var="selecItemNames" value="${selecItemNames} / ${_languageList.prvNm} " />
						 		</c:if> /> ${_languageList.prvNm}</label></li>
						</c:forEach>
						</ul>
					</div> --%>
				</div>
			</div>
			
	        <!--필터검색 end-->
			<div class="list_product">
				<c:if test="${not empty selecItemNames}">
				<!-- 필터 적용 결과 -->
				<p class="filter_result"><strong style="font-size:14px;">
					<i id="selectNames">
						${fn:replace(fn:substring(selecItemNames,3,fn:length(selecItemNames)),'/',',')}
					</i> 필터 적용 결과 입니다.</strong>
				</p>
				<!-- 필터 적용 결과 -->
				</c:if>
				<div style="display:inline-block;margin-bottom:15px;width:100%;">
<!-- 
					<div class="f_l">
						<span id="svcCompare" style="cursor:pointer;" class="btns st5" >비교</span>
					</div>
 -->					
					<div class="f_r">
						<span onclick="jsWishPurch(this,'list');" class="btns st1" style="cursor: pointer;">이용희망목록 담기</span>
						<span class="sel_box">
							<select name="q_searchKeyType" id="q_searchKeyType"  onChange="selectSort(this.value,'${goodsTyCd}');">
								<option value="1" <c:if test="${ empty searchMap.q_sortName or searchMap.q_sortName == '1' }">selected="selected"</c:if>>최신 등록순</option>
								<option value="3" <c:if test="${ !empty searchMap.q_sortName and searchMap.q_sortName == '3' }">selected="selected"</c:if>>조회순</option>
								<option value="5" <c:if test="${ !empty searchMap.q_sortName and searchMap.q_sortName == '5' }">selected="selected"</c:if>>계약건수 순</option>
							</select><label for="q_searchKeyType" style="display: none;">정렬</label>
						</span>
					</div>
				</div>
				<input type="hidden" name="ctgryPath" 	id="ctgryPath"	value="${path}" >
<!-- 서비스 목록 -->
				<ul class="view_list">
					<c:forEach items="${pager.list}" var="_goodsList" varStatus="status">
					  <c:set var="goosCodes" value="${goosCodes},${_goodsList.goodsCode}" />
					  <c:set var="goodImage" value="${_goodsList.itemImgUrl}" />
					<li>
						<p class="name_product" value="${_goodsList.userId}">
							<label><input type="checkbox" id="goods_check" name="goods_check" class="goods_check" value="${_goodsList.goodsCode}" title="${_goodsList.goodsNm}"/>
							<span onclick="jsView('${_goodsList.goodsCode}');">${_goodsList.goodsNm}</span></label>
							<!-- 마크 이미지 있을경우 -->
							<c:if test="${not empty _goodsList.cngdMarkFile}">
								<img src="${_goodsList.cngdMarkFile[0].fileUrl}" alt="${_goodsList.cngdMarkList[0].CNTC_GOODS_NM}" />
								<%-- <c:out value="${_goodsList.cngdMarkList[0].CNTC_GOODS_NM}"/> --%>
							</c:if>
							<c:forEach items="${_goodsList.markFile}" var="fileVo" varStatus="status1">
								<c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
								<img title="${fn:replace(fileVo2.localNm,'.png','' )}" src="${fileVo2.fileUrl}" width="33" height="33" alt="${fn:replace(fileVo2.localNm,'.png','' )}"/>
								<%-- <c:out value="${fn:replace(fileVo2.localNm,'.png','' )}"/> --%>
								</c:forEach>
							</c:forEach>
							<!-- //마크 이미지 있을경우 -->
						</p>
						<p class="name_company">
							<span style="cursor: pointer; color: #7d7d7d;" onClick="jsSeller('${_goodsList.userId}')">${_goodsList.langStoreNm}</span>
							<span>|</span>${_goodsList.registDt}
						</p>
						<p class="txt_product">
							<span style="line-height:26px; font-size: 15px; cursor: pointer;" onclick="jsView('${_goodsList.goodsCode}');"><c:if test="${fn:length(_goodsList.goodsSumry) >= 220}"><c:out value="${fn:substring(_goodsList.goodsSumry,0,220)}"/>...</c:if>
							<c:if test="${fn:length(_goodsList.goodsSumry) < 220}">${_goodsList.goodsSumry}</c:if>
							</span>
						</p>
						<input type="hidden" id="goodsNm_${_goodsList.goodsCode}" value="${_goodsList.goodsNm}">
						<input type="hidden" id="storeNm_${_goodsList.goodsCode}" value="${_goodsList.langStoreNm}">
						 <input type="hidden" id="goodImage_${_goodsList.goodsCode}" value="${goodImage}">
					</li>
					</c:forEach>
					<c:if test="${empty pager.list}">
					<li>
						<p class="no_content">
							찾고 계신 클라우드 서비스가 없나요?<br/><br/>
							비즈매칭을 통해 원하는 클라우드서비스에 대한 조언을 받아보세요.<br /><br/><br/>
							- <a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1010" target="_self"><strong style="font-size:14px">비즈매칭 이동하기</strong></a>-  
						</p>
					</li>
					</c:if>
				</ul>
				<!-- paging -->
					<op:pager pager="${pager}" page="pager/webPager.jsp"/>
				<!-- //paging -->
			</div>
		</div>
		</form>
		<!--서비스 비교-->
		<div class="location_wrap">
			<div class="compare_wrap">
				<p class="tit">서비스 비교(<label id="compCnt"></label>)
					<span id="svcCompare" style="height:30px; margin:0 0 0 10px; cursor:pointer;" class="btns st5" >서비스 비교 담기</span>
					<span class="btn_compare" style="cursor: pointer;"></span>
				</p>
				<div class="img_select">
					<div class="scrollarea">
						<ul id="itemWrap"></ul>
					</div>
				</div>
				<!--img_select end-->
				<ul class="btn_select">
					<li><a href="#none" onClick="fnGoodsCheckAll();" class="btn_bordergray">전체선택/해제</a></li>
					<li><a href="#none" onClick="fnGoodsCheckComp(this); return false;"  class="btn_darkblue">서비스비교</a></li>
					<li><a href="#none" onClick="_serCompareClear(); return false;" class="btn_darkblue">전체비우기</a></li>
					<li><a href="#none" onClick="jsWishPurch(this,'compare'); return false;"  class="btn_darkblue">이용희망목록 담기</a></li>
				</ul>
			</div>
		</div>
	</section>

