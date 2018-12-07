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
            iframe : true
        });
        </c:if>
    };
    
    var jsItst = function(code, intrstcnt) {
        $("#dataForm").ajaxSubmit(
                    {
                        url : "ND_itst.do",
                        type : "POST",
                        dataType : "json",
                        //data: ,
                        success : function(response) {
                            console.log(response);
                            
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
					<p>
						<c:if test="${not empty dataVo.itemImgUrl}"><img src="${ dataVo.itemImgUrl}" alt="${dataVo.goodsNm}" id="pathImage1" ><!-- 나라장터연계이미지  --></c:if> 
						<c:if test="${ empty dataVo.itemImgUrl}"><img src="${dataVo.imageFile[0].fileUrl}" alt="${dataVo.goodsNm}" id="pathImage1" ></c:if>
					</p>
					<p>${dataVo.goodsNm}<span>계약건수<strong>${suplycnt}건</strong></span></p>  
					<p>서비스분류 : <c:if test="${dataVo.langCtgryNm eq 'PaaS'}">플랫폼</c:if> <c:if test="${dataVo.langCtgryNm ne 'PaaS'}">${dataVo.langCtgryNm}</c:if></p>
					<p><!-- 인증정보 -->
						<c:forEach items="${dataVo.goodsMarkList}" var="_goodsMark" varStatus="status">
            	${_goodsMark.markNm} <c:if test="${status.index < fn:length(dataVo.goodsMarkList)-1 }">, </c:if>
						</c:forEach>
					</p> 
				</div>
				<c:if test="${dataVo.svcPc ne null and dataVo.svcPc ne ''and dataVo.svcPc ne '0'}">
					<p class="pro_price"><fmt:formatNumber value="${dataVo.svcPc}" type="number" /> ${dataVo.svcPcUntCd} / ${dataVo.dueStdrMumm}</p>
				</c:if>
				<div style="margin-top:20px;">
					<c:if test="${not empty dataVo.goodsDwldUrl}"><a href="${dataVo.goodsDwldUrl}" target="_blank"  class="btns st1">서비스 안내</a></c:if>
					<c:if test="${not empty dataVo.priceFile}">
						<c:forEach items="${dataVo.priceFile}" var="_priceFilee" varStatus="status">
						<a  href="javascript:;" onclick="jsFileDown('${_priceFilee.fileId}');"  class="btns st1">서비스가격표</a>
						</c:forEach>
					</c:if>
					
					<c:if test="${not empty dataVo.itemVodUrl}">
						<a  href="${dataVo.itemVodUrl}" target="_blank"  class="btns st1">서비스 체험하기</a>
					</c:if>
					
					<%-- <c:if test="${dataVo.goodsKndCd ne 1004}"> --%>
					
						<c:if test="${dataVo.specMaxNum > 0 and dataVo.specErr > 0}">
							<a  href="javascript:;" onclick="jsSpec(this);" class="btns st1">서비스규격서</a>
						</c:if>
						<c:if test="${dataVo.goodsMnlFileSeq < 1}">
							<c:if test="${not empty dataVo.mnlFile}">
							   <c:forEach items="${dataVo.mnlFile}" var="_mnlFile" varStatus="status">
									<a  href="javascript:;" onclick="jsFileDown('${_mnlFile.fileId}');" title="${_mnlFile.localNm}"  class="btns st1">서비스규격서</a>
							   </c:forEach>
							</c:if> 
						</c:if>
					<%-- </c:if> --%>
				</div>
	    </div>
	    <div class="f_r">
	    	<table class="normal_table" summary="제공자 정보">
	    		<caption>제공자 정보</caption>
        	<colgroup>
          	<col width="110px">
            <col width="192px">
          </colgroup>
          <thead>
          	<tr>
          		<th scope="col">제공자 정보</th>
          		<th scope="col"><a  href="javascript:;" onClick="jsSeller('${dataVo.userId}')" class="goList">다른서비스 보기</a></th>
	          </tr>
	        </thead>
	        <tbody>
						<tr>
							<td scope="col">제공자명</td>
							<td>
								<c:if test="${ empty dataVo.goodsStore[0].LANGSTORENM}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsStore[0].LANGSTORENM}">${dataVo.goodsStore[0].LANGSTORENM}</c:if>									
							</td>
						</tr>
						<tr>
							<td scope="col">기업구분</td>
						  <td>
						  	<c:if test="${ empty dataVo.smlpzChk}">해당없음</c:if> 
								<c:if test="${not empty dataVo.smlpzChk}">${dataVo.smlpzChk}</c:if>
					  	</td>
						</tr>
						<tr>
							<td scope="col">담당자</td>
							<td>
								<c:if test="${ empty dataVo.goodsChargerNm}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsChargerNm}">${dataVo.goodsChargerNm}</c:if>
							</td>
						</tr>
						<tr>
							<td scope="col">연락처</td>
							<td>
								<c:if test="${ empty dataVo.goodsChargerCttpc}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsChargerCttpc}">
									<c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) == 4}">
										${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}-${dataVo.goodsChargerCttpc.split('-')[3]}
			            </c:if>
			            <c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) < 4}">
			            	${dataVo.goodsChargerCttpc.split('-')[0]}-${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}
			            </c:if>
								</c:if>		
							</td>
						</tr>
						<tr>
							<td scope="col">이메일</td>
							<td>
								<c:if test="${ empty dataVo.goodsChargerEmail}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsChargerEmail}">
									<a href="mailto:${dataVo.goodsChargerEmail}">${dataVo.goodsChargerEmail}</a> 
								</c:if>								
							</td>
						</tr>
					</tbody>
					<tfoot hidden="hidden"><tr><td colspan="2"></td></tr></tfoot>
	      </table>    
			</div>
		</div>
		<%@ include file="/WEB-INF/pages/web/inc/INC_SnsView.jsp"%>	
		<ul class="sns_area">
			<li><a href="javascript:fn_sendSns('facebook','${dataVo.goodsNm}');" title="페이스북">페이스북</a></li>
			<li><a href="javascript:fn_sendSns('twitter','${dataVo.goodsNm}');" title="트위터">트위터</a></li>
			<li><a href="javascript:fn_sendSns('naver','${dataVo.goodsNm}');" title="블로그">블로그</a></li>
			<li><a href="javascript:;" onclick="jsItst('${dataVo.goodsCode}', '${intrstcnt}');" class="favor <c:if test="${intrstcnt > 0}">on</c:if>" title="즐겨찾기">즐겨찾기</a></li>
			<li><a href="javascript:;" onClick="pgPrint();return false;" title="프린트">프린트</a></li>
		</ul>
		
		<div class="btnArea rig">
		<c:if test="${param.vw ne 'sale'}">
			<a href="#" onclick="jsWishPurch(this); return false;"  class="btns st1">이용희망목록 담기</a>
		</c:if>
			<a href="#" onClick="history.back(-1);" class="listView">이전보기</a>			
		</div>
		<section>
			<c:if test="${not empty ppsList}">
			<h3><i>나라장터 종합쇼핑몰 구매</i></h3>
			<div>
				<table class="tbl_st6 faq">
					<caption></caption>
					<colgroup>
						<col width="6%">
						<col width="*">
						<%-- <col width="6%"> --%>
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>규격명</th>
							<!-- <th>구매 수량</th> -->
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${ppsList}" var="_ppsList" varStatus="status">
					<input type="hidden" name="unitPric" value="${_ppsList.unitPric}">
							<input  name="basktGoodsQy" type="hidden" placeholder="1">
						<tr>
							<td><input type="checkbox" name="thngCheckBoxArr"  id="thngCheckBoxArr"  value="${_ppsList.cntrNum}${_ppsList.lineNum}"></td>
							<td> ${_ppsList.itemName}</td>

							<td><fmt:formatNumber value="${_ppsList.unitPric}" type="NUMBER" groupingUsed="true" /> 원</td>
						</tr>
					</c:forEach>
				</table>
				<p class="btn_cen"><a href="#" class="btns st1" onClick="basktReg();">나라장터에서 구매</a></p>
			</div>
			</c:if>	
			<h3><i>서비스 개요</i></h3>
			<div>
           		<c:if test="${ empty dataVo.goodsChargerNm}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.goodsChargerNm}">
					<op:nrToBr content="${dataVo.goodsSumry}" /> 
				</c:if>					
				
			</div>
			<h3><i>특장점</i></h3>
			<div>
           		<c:if test="${ empty dataVo.itemSfe}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.itemSfe}">
					<c:out value="${dataVo.itemSfe}" escapeXml="false" />
				</c:if>
			</div>
			<h3><i>대상고객</i></h3>
			<div>
           		<c:if test="${ empty dataVo.cstmrInfo}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.cstmrInfo}">
					<c:out value="${dataVo.cstmrInfo}" escapeXml="false" />
				</c:if>
			</div>
			<h3><i>주요레퍼런스</i></h3>
			<div>
           		<c:if test="${ empty dataVo.goodsRefer}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.goodsRefer}">
					<c:out value="${dataVo.goodsRefer}" escapeXml="false" />
				</c:if>				  
			</div>
			<h3><i>주요기능</i></h3>
			<div>
           		<c:if test="${ empty dataVo.goodsMainFnct}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.goodsMainFnct}">
					<c:out value="${dataVo.goodsMainFnct}" escapeXml="false" />
				</c:if>				
			</div>

<c:if test="${goodsTyCd ne '1004'}">
			<h3><i>서비스 사양</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" style="width: 100%" summary="서비스 사양">
					<caption>서비스 사양</caption>
					<colgroup>
						<col width="160px">
						<col width="*">
					</colgroup>
					<thead hidden="true">
						<tr>
							<th scope="col">사양</th>
							<th scope="col">내용</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td scope="col">서비스 관리기준</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaSvc}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaSvc}">
									<c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status"><c:if test="${!status.first}">, </c:if>
										${_goodsMetaSvc.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">인증정보</td>
							<td>
								<c:if test="${ empty dataVo.goodsMarkList}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMarkList}">
									<c:forEach items="${dataVo.goodsMarkList}" var="_goodsMark" varStatus="status">
										<c:forEach items="${dataVo.markFile[status.index]}" var="fileVo" varStatus="status1">
											<img src="${fileVo.fileUrl}" title="${_goodsMark.markNm}" width="33" height="33" alt="${_goodsMark.markNm}"/> ${_goodsMark.markNm}
											<c:if test="${status.index > 1} }">, </c:if>
										</c:forEach>
										<c:if test="${empty dataVo.markFile[status.index]}">
											${_goodsMark.markNm}<c:if test="${status.index > 1} }">, </c:if>
										</c:if>
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">구축방식</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaCnstcMthd}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaCnstcMthd}">
									<c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status"><c:if test="${!status.first}">, </c:if>
										${_goodsMetaCnstcMthd.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">서비스유형</td>
							<td>
								<c:if test="${ empty dataVo.serviceOfferMethodNm}">해당없음</c:if> 
								<c:if test="${not empty dataVo.serviceOfferMethodNm}">
									${dataVo.serviceOfferMethodNm}
								</c:if>								
							</td>
						</tr>
						<tr>
							<td scope="col">아키텍처</td>
							<td>
								<c:if test="${ empty dataVo.archtcSe}">해당없음</c:if> 						
								<c:if test="${not empty dataVo.archtcSe}">
									<c:choose>
										<c:when test="${dataVo.archtcSe == 1}">
											32-bit
										</c:when>
										<c:when test="${dataVo.archtcSe == 2}">
											64-bit
										</c:when>
										<c:when test="${dataVo.archtcSe == 3}">
											32-bit, 64-bit
										</c:when>
									</c:choose>
								</c:if>
							</td>
						</tr>
						<tr>
							<td scope="col">지원OS</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaOS}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaOS}">
									<c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">
										<c:if test="${!status.first}">, </c:if>${_goodsMetaOS.INDVDLZ_CD_NM}<c:if test="${_goodsMetaOS.INDVDLZ_CD eq 9001 }">(${_goodsMetaOS.META_ETC_CN})</c:if>
									</c:forEach>
								</c:if>	
							</td>
						</tr>  
						<tr>
							<td scope="col">지원언어</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaLang}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaLang}">
									<c:forEach items="${dataVo.goodsMetaLang}" var="_goodsMetaLang" varStatus="status"><c:if test="${!status.first}">, </c:if>
										${_goodsMetaLang.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
							</td>
						</tr> 
						<tr>
							<td scope="col">A/S</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaAS}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaAS}">
									<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">
										<c:if test="${!status.first}">, </c:if>${_goodsMetaAS.INDVDLZ_CD_NM}<c:if test="${_goodsMetaAS.INDVDLZ_CD eq 1005 }">(${_goodsMetaAS.META_ETC_CN})</c:if>
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">호환성</td>
							<td>
				          		<c:if test="${ empty dataVo.goodsMetaStd}">
				          	 		해당없음
				          		</c:if> 
								<c:if test="${not empty dataVo.goodsMetaStd}">
									<c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status"><c:if test="${!status.first}">, </c:if>${_goodsMetaStd.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">제조사</td>
							<td>
				          		<c:if test="${ empty dataVo.goodsMakr}">
				          	 		해당없음
				          		</c:if> 
								<c:if test="${not empty dataVo.goodsMakr}">
									${dataVo.goodsMakr}
								</c:if>								
							</td>
						</tr>
						<tr>
							<td scope="col">출시일</td>
							<td>
								<c:if test="${ empty dataVo.comouDe}">해당없음</c:if> 
								<c:if test="${not empty dataVo.comouDe}">${dataVo.comouDe}</c:if>								
							</td>
						</tr>
					</tbody>
					<tfoot hidden="true">
						<tr>
							<td colspan="2"></td>
						</tr>
					</tfoot>
				</table>
				<ul>
					<li class="btn_cen">
					<c:if test="${dataVo.goodsKndCd ne 1004}">
						<c:if test="${dataVo.specMaxNum > 0 and dataVo.specErr > 0}">
						<a  href="javascript:;" onclick="jsSpec(this);" class="btns st2">서비스규격서</a>
						</c:if>
						<c:if test="${dataVo.goodsMnlFileSeq < 1}"> 
							<c:if test="${not empty dataVo.mnlFile}">
							   <c:forEach items="${dataVo.mnlFile}" var="_mnlFile" varStatus="status">
									<a  href="javascript:;" onclick="jsFileDown('${_mnlFile.fileId}');" title="${_mnlFile.localNm}"  class="btns st2">서비스규격서</a>
							   </c:forEach>
							</c:if> 
						</c:if>
					</c:if>
					</li>
				</ul>
			</div>
</c:if>
			<c:if test="${ not empty dataVo.dnlFile or not empty dataVo.etcFile}">
			<h3><i>매뉴얼 및 첨부파일</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%" summary="매뉴얼 및 첨부파일">
					<caption>매뉴얼 및 첨부파일</caption>
					<colgroup>
						<col width="160px">
						<col width="*">
					</colgroup>
					<thead hidden="hidden"><tr><th scope="col" colspan="2"></th></tr></thead>
					<c:if test="${not empty dataVo.dnlFile}">
					<tr>
						<td scope="col">사용자 메뉴얼</td>
						<td><c:forEach items="${dataVo.dnlFile}" var="_dnlFile" varStatus="status">
							${_dnlFile.localNm}<a href="javascript:;"  onclick="jsFileDown('${_dnlFile.fileId}');" title="${_dnlFile.localNm}"  class="btn_ml"><img src="/cloud_ver2/new_cloud/images/icn_txt_downLoad.png" alt="다운로드"></a>
							</c:forEach>
						</td>
					</tr>
					</c:if>
					<c:if test="${not empty dataVo.etcFile}">
					<tr>
						<td class="font_normal font14 borB0">기타 첨부파일</td>
						<td class="borR0 borB0">
				 	   <c:forEach items="${dataVo.etcFile}" var="_etcFile" varStatus="status">
						${_etcFile.localNm}<a href="javascript:;"  onclick="jsFileDown('${_etcFile.fileId}');" title="${_etcFile.localNm}"  class="btn_ml"><img src="/cloud_ver2/new_cloud/images/icn_txt_downLoad.png" alt="다운로드"></a>
						</c:forEach> 
						</td>
					</tr>
					</c:if> 
				</table>
			</div>
			</c:if> 
			<c:if test="${goodsTyCd ne '1004'}">
			<h3><i>관련이미지</i></h3>
			<div class="ps_r firstImg_img_area">
				<div id="firstImg">
					<c:if test="${ not empty dataVo.imageFile[1].fileUrl }">
					<img src="${dataVo.imageFile[1].fileUrl}" alt="관련이미지" />
					</c:if>
				</div>
				<div class="screen_img_area">
					<ul>
						<c:if test="${ not empty dataVo.imageFile[1].fileUrl }">
							<input type="hidden" id="scrImg" value="${dataVo.imageFile[1].fileUrl}" />
							<input type="hidden" id="seqImg" value="${dataVo.goodsImageFileSeq}" />
				      <c:forEach var="j" begin="1" end="2" step="1" varStatus="imgUlStatus">
				      	<c:if test="${(j-1)*5 < (fn:length(dataVo.imageFile)-1)}">
									<c:forEach var="i" begin="${1 + ((j-1)*5)}" end="${5 + ((j-1)*5)}" step="1" varStatus="imgLiStatus">
										<c:if test="${!empty dataVo.imageFile[i]}">
				            	<li class="small_screen_img">
				            		<span id="imgFiles" style="cursor: pointer;" onclick="fnLoadImg('${dataVo.imageFile[i].fileUrl}')">
				            			<img src="${dataVo.imageFile[i].fileUrl}" alt="${dataVo.goodsNm}"  />
				            		</span><img src="${dataVo.imageFile[i].fileUrl}" alt="${dataVo.goodsNm}"  />
				            	</li>
				            </c:if>
				          </c:forEach>
				        </c:if>
				      </c:forEach>
						</c:if> 
						<c:if test="${empty dataVo.imageFile[1].fileUrl }">
							<input type="hidden" id="scrImg" value="" />
						</c:if>
					</ul>
				</div>
			</div>
			</c:if>
<c:if test="${param.vw ne 'sale'}">			
			<h3><i>Q&amp;A</i></h3>
			<div>
				<iframe title="상품문의하기" id="inquiryFrame" src="../inc/INC_inquiry.do?goodsCode=${dataVo.goodsCode}&pageUrlNm=${dataVo.pageUrlNm}" width="100%" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 ></iframe>
			</div>
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
						<li><p><span onclick="jsView('${_goodsList.goodsCode}');" style="cursor: pointer;"><img src="${goodImage}" alt="${_goodsList.goodsNm}">${_goodsList.goodsNm}</span></p></li>
					</c:forEach>
				</ul> 
	        </div>	
			</c:if>
			<op:no-data obj="${pager}" colspan="4" />
</c:if>
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
					<li><a href="#">CLOUD CAM</a></li>
				</ul> 
				<span><a href="#" class="btn_prev"></a></span>
				<span><a href="#" class="btn_next"></a></span>   
			</div> -->
		</section>
		
	</div>
	<!--// content -->
		
			<%-- <aside>			
				<c:if test="${not empty dataVo.itemImgUrl}">
					<img src="${ dataVo.itemImgUrl}" alt="${dataVo.goodsNm}" id="pathImage1" >
					<!-- 나라장터연계이미지  -->
				</c:if> 
				<c:if test="${ empty dataVo.itemImgUrl}">
					<img src="${dataVo.imageFile[0].fileUrl}" alt="${dataVo.goodsNm}" id="pathImage1" >
				</c:if>
				<div class="duct_list">
					<a href="javascript:;" onclick="jsTab(this, 'inquiry');" class="qaView moreV">Q&amp;A</a>				
					<a  href="javascript:;" onClick="jsSeller('${dataVo.userId}')" class="goList">제공자서비스목록</a>
					<span>이용건수<i>${suplycnt}</i></span>
				</div>
				<div class="share">
					<em>공유하기</em>
					<a href="javascript:fn_sendSns('facebook','${dataVo.goodsNm}');"><img src="/cloud_ver2/new_cloud/images/btn_share_fb.png" alt="facebook" /></a>
					<a href="javascript:fn_sendSns('twitter','${dataVo.goodsNm}');"><img src="/cloud_ver2/new_cloud/images/btn_share_tw.png" alt="twitter" /></a>
					<a href="javascript:fn_sendSns('naver','${dataVo.goodsNm}');"><img src="/cloud_ver2/new_cloud/images/btn_share_bl.png" alt="blog" /></a>
				</div>
				<c:if test="${not empty dataVo.goodsMetaTAG or not empty dataVo.goodsTag}">
				<div class="tags">
					<c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">
						<a href="#">#${_goodsMetaTAG.INDVDLZ_CD_NM}</a>
					</c:forEach>
					<c:forEach items="${dataVo.goodsTag}" var="_goodsTag" varStatus="status">
						<a href="#">#${_goodsTag.GOODSTAGNM}</a>
					</c:forEach>
				</div>
				</c:if>
	
				<div class="relate_link">
					<c:if test="${not empty dataVo.goodsDwldUrl}">
					<a href="${dataVo.goodsDwldUrl}" target="_blank"  class="site">서비스 안내</a>
					</c:if>
					<c:if test="${dataVo.goodsKndCd ne 1004}">
						<c:if test="${dataVo.goodsMnlFileSeq > 0}">
						<a  href="javascript:;" onclick="jsSpec(this);"  class="spec">서비스규격서</a>
						</c:if>
						<c:if test="${dataVo.goodsMnlFileSeq < 1}">
							<c:if test="${not empty dataVo.mnlFile}">
							   <c:forEach items="${dataVo.mnlFile}" var="_mnlFile" varStatus="status">
									<a  href="javascript:;" onclick="jsFileDown('${_mnlFile.fileId}');" title="${_mnlFile.localNm}"  class="spec">서비스규격서</a>
							   </c:forEach>
							</c:if> 
						</c:if>
					</c:if>	
					<c:if test="${not empty dataVo.priceFile}">
					<c:forEach items="${dataVo.priceFile}" var="_priceFilee" varStatus="status">
					<a  href="javascript:;" onclick="jsFileDown('${_priceFilee.fileId}');"  class="pric">서비스가격표</a>
					</c:forEach>
					</c:if>
					<c:if test="${not empty dataVo.dnlFile}">
					 <c:forEach items="${dataVo.dnlFile}" var="_dnlFile" varStatus="status">
					<a href="javascript:;"  onclick="jsFileDown('${_dnlFile.fileId}');" title="${_dnlFile.localNm}" class="menu">사용자메뉴얼</a>
					</c:forEach>
					</c:if>
					<c:if test="${not empty dataVo.itemVodUrl}">
					<a  href="${dataVo.itemVodUrl}" target="_blank" class="demo">체 험 판</a>
					</c:if>
					<!-- <a href="javascript:;"  onclick="jsPurch(this, '1003');" class="buyi">구매 요청</a> -->
					<!-- <a href="#" class="buyi">구매희망목록 담기</a> -->
				</div>
			</aside>
	
			<div class="summary">
			
				<span  class="noPrint">
					<a href="javascript:;" onclick="jsItst('${dataVo.goodsCode}');" class="favor <c:if test="${intrstcnt > 0}">on</c:if>">관심목록 추가</a>
					<a href="javascript:;" onClick="pgPrint();return false;"><img src="/cloud_ver2/new_cloud/images/icn_print.png" alt="프린트" /></a>
					<a href="#" onClick="history.back(-1);" class="listView">이전보기</a>
				</span>
	
				<h2>
					${dataVo.goodsNm}
				</h2>
				
				<table class="tbl_st2">
					<tr>
						<th>서비스 분류</th>
						<td colspan="3">
						<c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
							<c:if test="${!status.first}">, </c:if>${_goodsCtgry.CTGRYCLNM} > ${_goodsCtgry.CTGRYPATH.split(' > ')[1]}
						</c:forEach></td>
					</tr>
					<tr>
						<th>제공자</th>
						<td>${dataVo.goodsStore[0].LANGSTORENM}</td>
						<th>기업구분</th>
						<td><c:if test="${dataVo.smlpzChk =='Y'}" >중소기업</c:if>
							<c:if test="${dataVo.smlpzChk =='M'}" >중견기업</c:if>
							<c:if test="${dataVo.smlpzChk =='B'}" >대기업</c:if></td>
					</tr>
					<tr>
						<th>제조사</th>
						<td>${dataVo.goodsMakr}</td>
						<th>원산지</th>
						<td>${dataVo.orgplce}</td>
					</tr>
					<tr>
						<th>출시일</th>
						<td colspan="3">${dataVo.comouDe}</td>
					</tr>
					<tr>
						<th>서비스 관리기준</th>
						<td colspan="3"><c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status"><c:if test="${!status.first}">, </c:if>${_goodsMetaSvc.INDVDLZ_CD_NM}</c:forEach></td>
					</tr>
					<c:if test="${not empty dataVo.goodsMetaStd}">
					<tr>
						<th>호환성</th>
						<td colspan="3"><c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status"><c:if test="${!status.first}">, </c:if>${_goodsMetaStd.INDVDLZ_CD_NM}</c:forEach></td>
					</tr>
					</c:if>
					<tr>
						<th>지원언어</th>
						<td colspan="3"><c:forEach items="${dataVo.goodsMetaLang}" var="_goodsMetaLang" varStatus="status"><c:if test="${!status.first}">, </c:if>${_goodsMetaLang.INDVDLZ_CD_NM}</c:forEach></td>
					</tr>
					<tr>
						<th>구축방식</th>
						<td><c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status"><c:if test="${!status.first}">, </c:if>${_goodsMetaCnstcMthd.INDVDLZ_CD_NM}</c:forEach></td>
						<th>서비스 유형</th>
						<td><c:if test="${not empty dataVo.serviceOfferMethod}">${dataVo.serviceOfferMethodNm}</c:if></td>
					</tr>
					<tr class="import">
						<th>계약단위</th>
						<td><c:forEach items="${dataVo.goodsMetaCntrctUnit}" var="_goodsMetaCntrctUnit" varStatus="status">	<c:if test="${!status.first}">, </c:if>${_goodsMetaCntrctUnit.INDVDLZ_CD_NM}<c:if test="${_goodsMetaCntrctUnit.INDVDLZ_CD eq 1005}">(${_goodsMetaCntrctUnit.META_ETC_CN})</c:if></c:forEach></td>
						<th>단가</th>
						<td>${dataVo.goodsPc}</td>
					</tr>
					<tr>
						<th>담당자</th>
						<td>${dataVo.goodsChargerNm}</td>
						<th>Tel</th>
						<td><c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) == 4}">
					                    		${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}-${dataVo.goodsChargerCttpc.split('-')[3]}
		                    </c:if>
		                    <c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) < 4}">
		                    		${dataVo.goodsChargerCttpc.split('-')[0]}-${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}
		                    </c:if></td>
					</tr>
					<tr>
						<th>e-mail</th>
						<td colspan="3"><a href="mailto:#">${dataVo.goodsChargerEmail}</a></td>
					</tr>
					<tr>
						<th>아키텍처</th>
						<td colspan="3"><c:if test="${not empty dataVo.archtcSe}">
						                    	<c:choose>
													<c:when test="${dataVo.archtcSe == 1}">
														32-bit
													</c:when>
													<c:when test="${dataVo.archtcSe == 2}">
														64-bit
													</c:when>
													<c:when test="${dataVo.archtcSe == 3}">
														32-bit, 64-bit
													</c:when>
													<c:otherwise>
														
													</c:otherwise>
												</c:choose>
											</c:if></td>
					</tr>
					<tr>
						<th>A/S</th>
						<td colspan="3"><c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">
		                                    	<c:if test="${!status.first}">, </c:if>${_goodsMetaAS.INDVDLZ_CD_NM}<c:if test="${_goodsMetaAS.INDVDLZ_CD eq 1005 }">(${_goodsMetaAS.META_ETC_CN})</c:if>
		                                    </c:forEach></td>
					</tr>
					<tr>
						<th>지원 O/S</th>
						<td colspan="3" class="os"><c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">
		                 <c:if test="${!status.first}">, </c:if>${_goodsMetaOS.INDVDLZ_CD_NM}<c:if test="${_goodsMetaOS.INDVDLZ_CD eq 9001 }">(${_goodsMetaOS.META_ETC_CN})</c:if>
		                 </c:forEach></td>
					</tr>
					<c:if test="${not empty dataVo.goodsMarkList}">
					<tr>
						<th>인증정보</th>
						<td colspan="3">
										<c:forEach items="${dataVo.goodsMarkList}" var="_goodsMark" varStatus="status">
											<c:forEach items="${dataVo.markFile[status.index]}" var="fileVo" varStatus="status1">
												<img src="${fileVo.fileUrl}" title="${_goodsMark.markNm}" width="33" height="33"/>
											</c:forEach>
											<c:if test="${empty dataVo.markFile[status.index]}">
												${_goodsMark.markNm}
											</c:if>
										</c:forEach>
									</td>
					</tr></c:if>
				</table>
			
				<div class="btnArea rig">
					<a href="#" onclick="jsWishPurch(this); return false;" class="btns icnCart">이용희망목록에 담기</a>
				</div>
				
			</div>	
			
			<c:if test="${not empty ppsList}">
			<!-- 나라장터 등록서비스일 경우 -->
			<section class="naraMar">
				<h3><i><img src="/cloud_ver2/new_cloud/images/bnr_mainFoot_g2b.png" alt="나라장터 종합쇼핑몰"></i></h3>
				<ul class="option_view">
				
				<c:forEach items="${ppsList}" var="_ppsList" varStatus="status">				
					<li>
						<i><input type="checkbox" name="thngCheckBoxArr"  id="thngCheckBoxArr"  value="${_ppsList.cntrNum}${_ppsList.lineNum}"> ${_ppsList.itemName}</i>
						<div>
							<div class="in_de_btn">
								<input type="text" value="1"  name="basktGoodsQy" />
								<input type="hidden" name="unitPric" value="${_ppsList.unitPric}">
								<b><span><fmt:formatNumber value="${_ppsList.unitPric}" type="NUMBER" groupingUsed="true" /></span> 원</b>
							</div>	<!-- <a href="#" class="btn_del">삭제</a>		 -->						
						</div>
						
					</li>
				</c:forEach>
				</ul>
				<div class="btnArea rig">
					<a href="#" class="btns icnCart" onClick="basktReg();">나라장터에서 구매</a>
				</div>	
			</section>			
			<!--// 나라장터 등록서비스일 경우 -->
			</c:if>	
			<hr />
			<c:if test="${ not empty dataVo.imageFile[1].fileUrl }">
	            <input type="hidden" id="scrImg" value="${dataVo.imageFile[1].fileUrl}" />
				<input type="hidden" id="seqImg" value="${dataVo.goodsImageFileSeq}" />
				<div class="view_demo_img">
				<ul class="slider_2">
				
	            <c:forEach var="j" begin="1" end="2" step="1" varStatus="imgUlStatus">
	            <c:if test="${(j-1)*5 < (fn:length(dataVo.imageFile)-1)}">
					<c:forEach var="i" begin="${1 + ((j-1)*5)}" end="${5 + ((j-1)*5)}" step="1" varStatus="imgLiStatus">
					<c:if test="${!empty dataVo.imageFile[i]}">
	                 	<li class="moreV"><a href="javascript:;" onclick="jsTab(this, 'screen');"><img src="${dataVo.imageFile[i].fileUrl}" alt="${dataVo.goodsNm}"  /></a></li>
	              	</c:if>
	              	</c:forEach>
	            </c:if>
	            </c:forEach>
	            </ul>
				</div>
			</c:if> 
			<c:if test="${empty dataVo.imageFile[1].fileUrl }">
				<input type="hidden" id="scrImg" value="" />
			</c:if>
			 
			<section>
				<h3><i>서비스 개요</i></h3>
				<p>
					<op:nrToBr content="${dataVo.goodsSumry}" />
				</p>
				<h3><i>특장점</i></h3>
				<p>
					<c:if test="${not empty dataVo.itemSfe}"><c:out value="${dataVo.itemSfe}" escapeXml="false" /></c:if>		
				</p>
				<h3><i>대상고객</i></h3>
				<p>
					<c:if test="${not empty dataVo.goodsRefer}"><c:out value="${dataVo.goodsRefer}" escapeXml="false" /></c:if>  
				</p>
				<h3><i>주요기능</i></h3>
				<p>
					<c:if test="${not empty dataVo.goodsMainFnct}"><c:out value="${dataVo.goodsMainFnct}" escapeXml="false" /></c:if>
				</p>
			</section>
	
			<div class="btnArea rig">
				<a href="#" onClick="history.back(-1);" class="listView">이전보기</a>			
			</div>
		 --%>
<!-- 		</div> -->
<!-- 	</div> -->
		</form>
	
	<!--// content -->	

</body>
</html>		
						
