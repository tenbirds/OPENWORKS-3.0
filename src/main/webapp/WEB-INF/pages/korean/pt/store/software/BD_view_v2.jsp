<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title>상세페이지 | 클라우드스토어 씨앗</title>
<script type="text/javascript"
	src="/resources/web/theme/common/js/fakeselect.js"></script>
<!--[if lt IE 9]>
        <script src="/resources/web/theme/common/js/html5shiv.js"></script>
    <![endif]-->
<op:jsTag type="spi" items="form" />
<script type="text/javascript">
    //document.write('<style>');
    //document.write('div.selectbox_option a{font-size:15px;}');
    //document.write('</style>');
	function calcHeight(FrameName) 
	{ 
		var the_height= document.getElementById(FrameName).contentWindow.document.body.scrollHeight; 
		document.getElementById(FrameName).height=the_height; 
	} 


    $(function() {
        
        /********************************************
        // 서비스 상세 메뉴바
         ********************************************/
        //var tab = $('#tab_area'), offset = tab.offset(), tabOffset = [], flag = 0, loaded = false;
        
        //수량-증가,감소 버튼
        var $buttonBox = $('.in_de_btn');
       /*  $buttonBox.append('<a class="inc">위</a><a class="dcc">아래</a>'); */
        $buttonBox.find("a").on("click",function(){
            var $button = $(this);
            var oldValue = $button.parent().find("input").val();

            if($button.hasClass('inc')){
                var newVal = parseFloat(oldValue) + 1;
            } else{
                if(oldValue > 1){
                    var newVal = parseFloat(oldValue) - 1;
                } else {
                    newVal = 1;
                }
            }
            $button.parent().find("input:text[name=basktGoodsQy]").val(newVal);
            var sercicePric =   parseFloat($button.parent().find("input:hidden[name=unitPric]").val()) ;
            $button.parent().find("span").html(comma(parseFloat(sercicePric)*newVal));
        });
        
        <c:if test="${not empty sessionScope['__usk']}">
        if("${pageUrlNm}".substring(0,1) == "I"){
            var id = 'inquiry';
            var param ="tab="+id+"&goodsCode=${dataVo.goodsCode}&pageUrlNm=${pageUrlNm}";
            var url = "../inc/INC_"+id+".do?"; 
            
          /*   $.colorbox({
                title : "",
                href : url + param,
                width : "1006",
                height : "870",
                overlayClose : true,
                escKey : true,
                iframe : true
            }); */
            
        }
        </c:if>

    });
	
   //콤마찍기
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }

    /********************************************
     // 서비스상세 이미지 변경 보기
     ********************************************/
    
    var jsPurch = function(el, mthd) {
        <c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
        }
        </c:if>

        if(mthd == '1002') {
            <c:if test="${not empty sessionScope['__usk']}">
            $(el).colorbox(
                            {   title : "구매문의하기",
                                href : "/korean/pt/popup/PD_orderPop.do?goodsCode=${dataVo.goodsCode}&sleMthdCd=1002&langCode=${dataVo.langCode}&goodsTyCd=${dataVo.goodsKndCd}",
                                width : "910",
                                height : "700",
                                overlayClose : false,
                                escKey : false,
                                iframe : true
                            });
            </c:if>
        }
        if(mthd == '1001') {
            <c:if test="${not empty sessionScope['__usk']}">
            $(el).colorbox(
                            {
                                title : "다운로드",
                                href : "/korean/pt/popup/PD_orderPop.do?goodsCode=${dataVo.goodsCode}&sleMthdCd=1001&langCode=${dataVo.langCode}&goodsFileSeq=${dataVo.goodsFileSeq}&goodsTyCd=${dataVo.goodsKndCd}",
                                width : "1000",
                                height : "800",
                                overlayClose : false,
                                escKey : false,
                                iframe : true
                            });
            </c:if>
        }
        /* 구매요청서 추가분 2016.11.16 */
        if(mthd == '1003') {
            <c:if test="${not empty sessionScope['__usk']}">
            $(el).colorbox(
                            {
                                title : "구매요청서",
                                href : "",
                                width : "1000",
                                height : "1000",
                                overlayClose : false,
                                escKey : false,
                                iframe : true
                            });
            </c:if>
        }
    };

    //QA, 리뷰, 납품실적, 연관서비스 
    var jsTab = function(el, id) {
       
        <c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
        }
        </c:if>
        
        <c:if test="${not empty sessionScope['__usk']}">
        var param = "tab=" + id + "&goodsCode=${dataVo.goodsCode}&pageUrlNm=${dataVo.pageUrlNm}&goodsImageFileSeq=${dataVo.goodsImageFileSeq}&goodsTyCd=${goodsTyCd}";
        var url = "../inc/INC_" + id + ".do?";

        $(el).colorbox({
            title : "",
            href : url + param,
            width : "1006",
            height : "870",
            overlayClose : true,
            escKey : true,
            iframe : true
        });
        </c:if>
    };
    
    
    
    //서비스규격서보기 
    var jsSpec= function(el) {
        <c:if test="${empty sessionScope['__usk']}"> 
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
            + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
        }
        </c:if>
        <c:if test="${not empty sessionScope['__usk']}"> 
        $(el).colorbox({
            title : "",
            href : "/korean/pt/popup/PD_goodsSpecPop.do?goodsCode=${dataVo.goodsCode}",
            width : "910",
            height : "900",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
        </c:if>
    };
    
    var jsItst = function(code) {
        $("#dataForm")
            .ajaxSubmit(
                    {
                        url : "ND_itst.do",
                        type : "POST",
                        dataType : "json",
                        success : function(response) {
                            if(response.result) {
                                if(confirm(response.message)) {
                                    top.location.href = "/korean/pt/mygoods/BD_intrstPrdtList.do";
                                }else{
                                    if($(".favor").hasClass("on"))
                                    	$(".favor").removeClass("on");
                                    else 
                                        $(".favor").addClass("on");
                                }
                            } else {
                                if(response.message == "requiredLogin") {
                                    if(confirm(Message.msg.requiredLogin)) {
                                        returnUrl = "/korean/pt/store/software/BD_view.do&returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${dataVo.goodsKndCd}";
                                        top.location.href = "/korean/pt/login/user/BD_index.do?returnUrl="
                                                + returnUrl;
                                    }
                                } else {
                                    alert(Message.msg.watchFail);
                                }
                            }
                        }
                    });
    };

    var jsSeller = function(userId) {
        $("#userId").val(userId);
        document.dataForm.action = "../BD_goodsOfSeller.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

    var jsFileDown = function(fid) {
        <c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
        }
        </c:if>
        <c:if test="${not empty sessionScope['__usk']}">
        self.location.href = "/component/file/ND_fileDownload.do?id=" + fid;
        </c:if>
    };

    var searchItem = function(fid, value) {
		/* 폼 새로 생성함 (목록 path의 별개로 가기 위해서)*/
        var form = document.createElement("form");
        form.setAttribute("action", "BD_index.do?goodsTyCd=${dataVo.goodsKndCd}");
        form.setAttribute("method", "post");
        // form.elements["q_currPage"].value = "1";

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", fid);
        hiddenField.setAttribute("value", value);
        form.appendChild(hiddenField);

        document.body.appendChild(form);
        form.submit();
    };
    
    var jsWishPurch = function(el) {
        <c:if test="${empty sessionScope['__usk']}"> 
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
            + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
        }
        </c:if>        
        <c:if test="${not empty sessionScope['__usk']}">
        
        
        if  ( '${dataVo.userId}' == '<c:out value="${sessionScope['__usk'].userId}"/>')
        {
            alert("자신의 서비스(같은ID)를 목록에 담을 수 없습니다.") ; 
        }
        else
        {
            $(el).colorbox({
                title : "이용희망목록에 담기",
                href : "/korean/pt/popup/PD_wishOrderPop.do?goodsTyCd="+$("#goodsTyCd").val()+"&mode=form",
                width : "910",
                height : "230",
                overlayClose : false,
                escKey : false,
                iframe : true
            });			                
        }
        
        
        </c:if>
       
    };

    function pgPrint()
    {
        Popup($("#wrap_ver2").html());
    }
    
    var mywindow ;
    function Popup(data)
    {
	    	mywindow = window.open('', 'my div', 'top=0,left=0,width=1024,height=600');
		    mywindow.document.write('<!DOCTYPE html><html lang="ko"><head><title></title>');
		    mywindow.document.write('<meta charset="utf-8" />');
		    mywindow.document.write('<meta http-equiv="X-UA-Compatible" content="IE=edge" />');
		    mywindow.document.write('<link href="/new_cloud/css/sub_ver2.css" rel="stylesheet" type="text/css" />');
		    mywindow.document.write('<link href="/cloud_ver2/new_cloud/css/v3_cmm.css" rel="stylesheet" type="text/css" />');
		    mywindow.document.write('<link href="/cloud_ver2/new_cloud/css/v3_css.css" rel="stylesheet" type="text/css" />');
		    mywindow.document.write('<style type="text/css">');
		    mywindow.document.write('.noPrint{display:none;}');
		    mywindow.document.write('</style>');
		    mywindow.document.write('</head><body>');
		    mywindow.document.write('<div id="wrap_ver2">');
		    mywindow.document.write(data);
		    mywindow.document.write('</div>');
		    mywindow.document.write('</body></html>');
		    mywindow.document.close(); // IE >= 10에 필요
		    mywindow.focus(); // necessary for IE >= 10
		    id = setTimeout( printStart, 100 );
	    return true;
    }
    
    function printStart(){
        mywindow.print();
		mywindow.close();
    }
    
    <c:if test="${not empty ppsList}">
  
    
    /////////////////////////////////////////////////
    // {{ 2016-11-16 나라장터 장바구니 담기 
    function basktReg() {
        <c:if test="${empty sessionScope['__usk']}">
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${dataVo.goodsCode}&goodsTyCd=${goodsTyCd}";
        }
        </c:if>
        <c:if test="${not empty sessionScope['__usk']}">
        if(!$("input:checkbox[id='thngCheckBoxArr']").is(":checked")){ alert('체크된 목록이 없습니다.'); return;}
        
        var thngCheckBox = document.getElementsByName("thngCheckBoxArr");
        var basktGoodsQy = document.getElementsByName("basktGoodsQy");
        var checkcnt =0;
        var bakGood = '[';
        
        for(var i = 0; i < thngCheckBox.length; i++){
             
            if(thngCheckBox[i].checked){
        	  if(parseInt(basktGoodsQy[i].value) < 1) {alert('체크된 항목에 수량을 체크하지 안았습니다.'); return;}
        	  else {
        	      if( checkcnt > 0) bakGood += ',';
        	      bakGood += '{"no" : "'+thngCheckBox[i].value+'", "qy" : "' + basktGoodsQy[i].value+ '"}';
        	      checkcnt++;
        	   }
            }
        }
        bakGood += ']';
        if(checkcnt > 5) alert("5개 이하만 구매가 가능합니다. ")
        else {
	    	var openNewWin = window.open("about:blank");
	    	openNewWin.location.href="http://www.g2b.go.kr:8092/sm/mp/shopbaskt/SMMPShopbasktList.do?cloudGoodsYn=Y&list="+bakGood;+"&id="+<c:out value="${sessionScope['__usk'].userId}" />;
        }
    	</c:if>
    };
   
    //}}
    </c:if>
    
    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "/korean/pt/store/inc/BD_storeView.do";
        document.dataForm.submit();    
    };
    
    
    var fnLoadImg = function (vl) {
        $("#firstImg").html("<img src="+vl+" width=\"260\" height=\"317\">");
    }
</script>
</head>
<body>
    
	<!-- content -->
	<!-- <div class="conWrap swView" id="wrap_ver2">
		<div class="conWrap swView"> -->
		
	<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" name="q_currPage" id="q_currPage" value="${searchMap.q_currPage}" />
	<input type="hidden" name="q_sortName" id="q_sortName" value="${searchMap.q_sortName}" />
	<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="${searchMap.q_sortOrder}" />
	<input type="hidden" name="goodsCode" id="goodsCode" value="${dataVo.goodsCode}" />
	<input type="hidden" name="sleMthdCd" id="sleMthdCd" value="${dataVo.sleMthdCd}" />
	<input type="hidden" name="goodsFileSeq" id="goodsFileSeq" value="${dataVo.goodsFileSeq}" />
	<input type="hidden" name="userId" id="userId" value="">
	<input type="hidden" name="goodsTyCd" id="goodsTyCd" value="${dataVo.goodsKndCd}">
	<input type="hidden" name="goodsNm" id="goodsNm" value="${dataVo.goodsNm}">

	<!-- content -->
	<div class="conWrap new_swView" id="wrap_ver2">
		<div class="pro_title">
	        <div class="f_l">
	        	<div class="pro_txt">
					<p><!-- <img src="images/bg.jpg"> -->
					<c:if test="${not empty dataVo.itemImgUrl}">
					<img src="${ dataVo.itemImgUrl}" alt="${dataVo.goodsNm}" id="pathImage1" >
					<!-- 나라장터연계이미지  -->
					</c:if> 
					<c:if test="${ empty dataVo.itemImgUrl}">
						<img src="${dataVo.imageFile[0].fileUrl}" alt="${dataVo.goodsNm}" id="pathImage1" >
					</c:if>
					</p> 
					<p>${dataVo.goodsNm}<span>계약건수<strong>${suplycnt}건</strong></span></p>  
					<p>서비스분류 : <c:if test="${dataVo.langCtgryNm eq 'PaaS'}">플랫폼</c:if> <c:if test="${dataVo.langCtgryNm ne 'PaaS'}">${dataVo.langCtgryNm}</c:if></p>
					
					<!--  p>
					<c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
							<c:if test="${!status.first}" >, </c:if>${_goodsCtgry.CTGRYCLNM} > ${_goodsCtgry.CTGRYPATH.split(' > ')[1]}
					</c:forEach></p -->  
					<p><!-- 인증정보 -->
					<c:forEach items="${dataVo.goodsMarkList}" var="_goodsMark" varStatus="status">
                        ${_goodsMark.markNm}
                        <%-- 
                        <c:forEach items="${dataVo.markFile[status.index]}" var="fileVo" varStatus="status1">
                            <img src="${fileVo.fileUrl}" title="${_goodsMark.markNm}" width="33" height="33"/>
                        </c:forEach>
                        <c:if test="${empty dataVo.markFile[status.index]}">
                            ${_goodsMark.markNm}
                        </c:if>
                         --%>
					</c:forEach></p> 
				</div>
				<p class="pro_price">\ ${dataVo.goodsPc}</p>
	        </div>
	        <div class="f_r">
	            <table class="normal_table">
	                <caption></caption>
	                <colgroup>
	                    <col width="110px">
	                    <col width="192px">
	                </colgroup>
	                <thead>
	                    <tr>
	                      <th>제공자 정보</th>
	                      <th><a  href="javascript:;" onClick="jsSeller('${dataVo.userId}')" class="goList">다른서비스 보기</a></th>
	                    </tr>
	              	</thead>
	             	<tbody>
						<tr>
							<td>제공자명</td>
							<td>${dataVo.goodsStore[0].LANGSTORENM}</td>
						</tr>
						<tr>
						  	<td>기업구분</td>
						  	<td><c:if test="${dataVo.smlpzChk =='Y'}" >중소기업</c:if>
							<c:if test="${dataVo.smlpzChk =='M'}" >중견기업</c:if>
							<c:if test="${dataVo.smlpzChk =='B'}" >대기업</c:if></td>
						</tr>
						<tr>
							<td>담당자</td>
							<td>${dataVo.goodsChargerNm}</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td><c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) == 4}">
					                    		${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}-${dataVo.goodsChargerCttpc.split('-')[3]}
		                    </c:if>
		                    <c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) < 4}">
		                    		${dataVo.goodsChargerCttpc.split('-')[0]}-${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}
		                    </c:if></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><a href="mailto:${dataVo.goodsChargerEmail}">${dataVo.goodsChargerEmail}</a></td>
						</tr>
	              	</tbody>
	          	</table>    
			</div>
		</div>
		<%@ include file="/WEB-INF/pages/web/inc/INC_SnsView.jsp"%>
		
		<div class="btnArea rig">
			<a href="#" onclick="jsWishPurch(this); return false;"  class="btns st1">이용희망목록 담기</a>
			<a href="#" onClick="history.back(-1);" class="listView">이전보기</a>			
		</div>
		<section>
			<h3><i>제공자 정보</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%">
                    <caption></caption>
                    <colgroup>
                        <col width="260px">
                        <col width="*">
                    </colgroup>
                    <tr>
                        <th>회사 설립년도</th>
                        <td>2010년</td>
                    </tr>
                    <tr>
                        <th>회사소개</th>
                        <td>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio optio deleniti modi nobis quasi, non, fuga sapiente ipsa! Alias, placeat ex. Dolor explicabo aut consequuntur nisi laborum, rem iusto perspiciatis!</td>
                    </tr>
                </table>
			</div>
			<h3><i>서비스 개요</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%">
                    <caption></caption>
                    <colgroup>
                        <col width="260px">
                        <col width="*">
                    </colgroup>
                    <tr>
                        <th>전문분야</th>
                        <td>비즈니스, 솔루션 아키텍처, 품질보증분석가 등</td>
                    </tr>
                    <tr>
                        <th>컨설팅 주요 내용</th>
                        <td>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Asperiores in, officia ratione repellendus, dicta excepturi blanditiis atque at beatae sint ex error aut. Error blanditiis omnis laboriosam alias perferendis, quas debitis porro. Sunt excepturi, magnam repudiandae perferendis fugit, eos iure aliquid aliquam sed nihil accusantium quia veritatis tempore minus illum maxime commodi quos suscipit maiores et veniam nisi, distinctio deserunt tenetur. Soluta totam sapiente, dolorem, dolore autem ab cum mollitia atque commodi nobis eum illum sit, voluptatum harum est fugiat accusantium ea earum deserunt. Culpa odit commodi nostrum explicabo, excepturi atque in tempore accusamus officiis voluptatibus dolor, nam rerum. At!</td>
                    </tr>
                </table>
			</div>
			<h3><i>핵심기술 및 경험</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%">
                    <caption></caption>
                    <colgroup>
                        <col width="260px">
                        <col width="*">
                    </colgroup>
                    <tr>
                        <th>보유자격</th>
                        <td>MS 클라우드 전문가 자격 등</td>
                    </tr>
                    <tr>
                        <th>보유기술</th>
                        <td>클라우드 환경 기반의 자바 개발, DB 마이그레이션 등</td>
                    </tr>
                    <tr>
                        <th>컨설팅 가능 인프라</th>
                        <td>OpenStack, CloudStack</td>
                    </tr>
                    <tr>
                        <th>컨설팅 가능 플랫폼</th>
                        <td>Cloud Foundry</td>
                    </tr>
                    <tr>
                        <th>프로젝트 경험</th>
                        <td>oo은행 클라우드 이전 등</td>
                    </tr>
                    <tr>
                        <th>컨설팅 가능 상세 서비스</th>
                        <td>네트워킹, 스토리지</td>
                    </tr>
                    <tr>
                        <th>컨설팅 수행기간</th>
                        <td>도입전반 : 3개월, 품질보증/테스트 : 3개월</td>
                    </tr>
                    <tr>
                        <th>컨설팅 수행 가능 지역</th>
                        <td>서울시, 경기도, 세종시</td>
                    </tr>
                    <tr>
                        <th>사전 컨설팅 가능 여부</th>
                        <td>YES</td>
                    </tr>
                </table>
			</div>
			<h3><i>Q&amp;A</i></h3>
			<div><iframe title="상품문의하기" id="inquiryFrame" src="../inc/INC_inquiry.do?goodsCode=${dataVo.goodsCode}&pageUrlNm=${dataVo.pageUrlNm}"
              width="100%" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 ></iframe></div>
			<h3><i>연관서비스</i></h3>
			<c:if test="${not empty pager.list}">
			<div class="ps_r">
                <ul class="logoView">
					<c:forEach items="${pager.list}" var="_goodsList" varStatus="status">
						<c:set var="goodImage" value="${_goodsList.itemImgUrl}" />
						<c:if test="${not empty dataVo.itemImgUrl}">
							 <c:set var="goodImage" value="${_goodsList.itemImgUrl}"/>
						</c:if> 
						<c:if test="${ empty _goodsList.itemImgUrl}">
							 <c:set var="goodImage" value="${_goodsList.imageFile[0].fileUrl}" />
						</c:if>
						<a href="#" onclick="jsView('${_goodsList.goodsCode}');">
						<li>
							<p><img src="${goodImage}" alt="${_goodsList.goodsNm}"></p>${_goodsList.goodsNm}
	                    </li>
	                    </a>
						
					</c:forEach>
				</ul> 
	        </div>	
			</c:if>
			<op:no-data obj="${pager}" colspan="4" />
        
			<%--
			<iframe title="연관솔루션" id="relationFrame" src="../inc/INC_relation.do?goodsCode=${dataVo.goodsCode}&pageUrlNm=${dataVo.pageUrlNm}"  width="100%"  height="300px"   frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
			--%>
			
			<!-- <div class="ps_r">
				<ul class="logoView">
					<li class="mr20 mb10"><a href="#">이러닝플러스</a></li>
					<li class="mr20 mb10"><a href="#">트그리스</a></li>
					<li class="mr20 mb10"><a href="#">모바일 디바이스 보안 관리 솔루션 - MaaS360</a></li>
					<li class="mr20 mb10"><a href="#">웹 및 모바일 애플리케이션 보안 테스트 솔루션 - AppScan</a></li>
					<li class="mb10"><a href="#">IBM Watson Analytics</a></li>
					li class="mr23"><a href="#">젠미디어</a></li>
					<li class="mr23"><a href="#">IBM Watson Customer Experience Analytics</a></li>
					<li class="mr23"><a href="#">K닷Cloud</a></li>
					<li class="mr23"><a href="#">클라우드 저장소 서비스</a></li>
					<li><a href="#">CLOUD CAM</a></li
				</ul> 
				<span><a href="#" class="btn_prev"></a></span>
				<span><a href="#" class="btn_next"></a></span>   
			</div> -->
		</section>
		
	</div>
	<!--// content -->
		
		</div>
	</div>
		</form>
	
	<!--// content -->	

</body>
</html>		
						
