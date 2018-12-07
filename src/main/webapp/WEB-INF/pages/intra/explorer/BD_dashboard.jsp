<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>종합현황 관리</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />

    <script type="text/javascript" src="/resources/openworks/spi/jquery/jquery-1.7.1.min.js"></script>
    <script src="/cloud_ver2/new_cloud/js/Chart.bundle.js"></script>
    <script src="/cloud_ver2/new_cloud/js/utils.js"></script>
    <script src="/cloud_ver2/new_cloud/js/v3_cmm.js"></script>
	<script src="/resources/openworks/spi/jquery/colobox/jquery.colorbox.js"></script>
    
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/jnotify/jquery.jnotify.min.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/notice/jquery.notice.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/extjs/resources/css/ext-all.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/openworks_all.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/openworks_all_print.css" media="print"/>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_cmm.css' />
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
    
    <script type="text/javascript">
    	$(document).ready(function () {
    	    $.ajax({//씨앗현황, 회원 현황, 협약서비스 현황
    	        type: "POST",
    	        url: "/intra/explorer/BD_dashboardCeartJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	            //console.log(data);
    	            var goodsTotalCnt = addCommas(data.aGoodsCnt + data.bGoodsCnt);
    	            
    	            $('#basicDate').text(data.basicDate);
    	            $('#goodsTotalCnt').text(goodsTotalCnt);
    	            
    	            $('#aGoodsRegistSttus').text(data.aGoods_regist_sttus);
    	            $('#bGoodsRegistSttus').text(data.bGoods_regist_sttus);
    	            
    	            $('#aGoodsCnt').text(addCommas(data.aGoodsCnt));
    	            $('#aDifGoodsCnt').text(addCommas(data.aDifGoodsCnt));
    	            if (data.aDifGoodsCnt < 0 ) {
    	                $('#aDifGoodsCnt').text(addCommas(data.aDifGoodsCnt));
    	                $('#aDifGoodsCnt').className ="decrease";
    	            }else if (data.aDifGoodsCnt > 0 ) {
    	                $('#aDifGoodsCnt').text(addCommas(data.aDifGoodsCnt));
    	                $('#aDifGoodsCnt').className ="increase";
    	            }else if (data.aDifGoodsCnt == 0 ) {
    	                $('#aDifGoodsCnt').className ="increase";
    	                $('#aDifGoodsCnt').text("-");
    	            }
    	            
    	            
    	            $('#bGoodsCnt').text(addCommas(data.bGoodsCnt));
    	            $('#bDifGoodsCnt').text(addCommas(data.bDifGoodsCnt));
    	            if (data.bDifGoodsCnt < 0 ) {
    	                $('#bDifGoodsCnt').text(addCommas(data.bDifGoodsCnt));
    	                $('#bDifGoodsCnt').className ="decrease";
    	            }else if (data.aDifGoodsCnt > 0 ) {
    	                $('#bDifGoodsCnt').text(addCommas(data.bDifGoodsCnt));
    	                $('#bDifGoodsCnt').className ="increase";
    	            }else if (data.bDifGoodsCnt == 0 ) {
    	                $('#bDifGoodsCnt').className ="increase";
    	                $('#bDifGoodsCnt').text("-");
    	            }
    	            
    	            
    	            $('#aSaasCnt').text(addCommas(data.aSaasCnt));
    	            $('#aDifSaasCnt').text(addCommas(data.aDifSaasCnt));
    	            if (data.aDifSaasCnt < 0 ) {
    	                $('#aDifSaasCnt').text(addCommas(data.aDifSaasCnt));
    	                $('#aDifSaasCnt').className ="decrease";
    	            }else if (data.aDifSaasCnt > 0 ) {
    	                $('#aDifSaasCnt').text(addCommas(data.aDifSaasCnt));
    	                $('#aDifSaasCnt').className ="increase";
    	            }else if (data.aDifSaasCnt == 0 ) {
    	                $('#aDifSaasCnt').className ="increase";
    	                $('#aDifSaasCnt').text("-");
    	            }

    	            $('#aPaasCnt').text(addCommas(data.aPaasCnt));
    	            $('#aDifPaasCnt').text(addCommas(data.aDifPaasCnt));
    	            if (data.aDifPaasCnt < 0 ) {
    	                $('#aDifPaasCnt').text(addCommas(data.aDifPaasCnt));
    	                $('#aDifPaasCnt').className ="decrease";
    	            }else if (data.aDifPaasCnt > 0 ) {
    	                $('#aDifPaasCnt').text(addCommas(data.aDifPaasCnt));
    	                $('#aDifPaasCnt').className ="increase";
    	            }else if (data.aDifPaasCnt == 0 ) {
    	                $('#aDifPaasCnt').className ="increase";
    	                $('#aDifPaasCnt').text("-");
    	            }
    	            
    	            $('#aIaasCnt').text(addCommas(data.aIaasCnt));
    	            $('#aDifIaasCnt').text(addCommas(data.aDifIaasCnt));
    	            if (data.aDifIaasCnt < 0 ) {
    	                $('#aDifIaasCnt').text(addCommas(data.aDifIaasCnt));
    	                $('#aDifIaasCnt').className ="decrease";
    	            }else if (data.aDifIaasCnt > 0 ) {
    	                $('#aDifIaasCnt').text(addCommas(data.aDifIaasCnt));
    	                $('#aDifIaasCnt').className ="increase";
    	            }else if (data.aDifIaasCnt == 0 ) {
    	                $('#aDifIaasCnt').className ="increase";
    	                $('#aDifIaasCnt').text("-");
    	            }
    	            
    	            $('#aScsCnt').text(addCommas(data.aScsCnt));
    	            $('#aDifScsCnt').text(addCommas(data.aDifScsCnt));
    	            if (data.aDifScsCnt < 0 ) {
    	                $('#aDifScsCnt').text(addCommas(data.aDifScsCnt));
    	                $('#aDifScsCnt').className ="decrease";
    	            }else if (data.aDifScsCnt > 0 ) {
    	                $('#aDifScsCnt').text(addCommas(data.aDifScsCnt));
    	                $('#aDifScsCnt').className ="increase";
    	            }else if (data.aDifScsCnt == 0 ) {
    	                $('#aDifScsCnt').className ="increase";
    	                $('#aDifScsCnt').text("-");
    	            }
    	            
    	            $('#bSaasCnt').text(addCommas(data.bSaasCnt));
    	            $('#bDifSaasCnt').text(addCommas(data.bDifSaasCnt));
       	            if (data.bDifSaasCnt < 0 ) {
    	                $('#bDifSaasCnt').text(addCommas(data.bDifSaasCnt));
    	                $('#bDifSaasCnt').className ="decrease";
    	            }else if (data.bDifSaasCnt > 0 ) {
    	                $('#bDifSaasCnt').text(addCommas(data.bDifSaasCnt));
    	                $('#bDifSaasCnt').className ="increase";
    	            }else if (data.bDifSaasCnt == 0 ) {
    	                $('#bDifSaasCnt').className ="increase";
    	                $('#bDifSaasCnt').text("-");
    	            }
       	            
    	            $('#bPaasCnt').text(addCommas(data.bPaasCnt));
    	            $('#bDifPaasCnt').text(addCommas(data.bDifPaasCnt));
      	            if (data.bDifPaasCnt < 0 ) {
    	                $('#bDifPaasCnt').text(addCommas(data.bDifPaasCnt));
    	                $('#bDifPaasCnt').className ="decrease";
    	            }else if (data.bDifPaasCnt > 0 ) {
    	                $('#bDifPaasCnt').text(addCommas(data.bDifPaasCnt));
    	                $('#bDifPaasCnt').className ="increase";
    	            }else if (data.bDifPaasCnt == 0 ) {
    	                $('#bDifPaasCnt').className ="increase";
    	                $('#bDifPaasCnt').text("-");
    	            }
    	            
    	            $('#bIaasCnt').text(addCommas(data.bIaasCnt));
    	            $('#bDifIaasCnt').text(addCommas(data.bDifIaasCnt));
      	            if (data.bDifIaasCnt < 0 ) {
    	                $('#bDifIaasCnt').text(addCommas(data.bDifIaasCnt));
    	                $('#bDifIaasCnt').className ="decrease";
    	            }else if (data.bDifIaasCnt > 0 ) {
    	                $('#bDifIaasCnt').text(addCommas(data.bDifIaasCnt));
    	                $('#bDifIaasCnt').className ="increase";
    	            }else if (data.bDifIaasCnt == 0 ) {
    	                $('#bDifIaasCnt').className ="increase";
    	                $('#bDifIaasCnt').text("-");
    	            }
      	            
    	            $('#bScsCnt').text(addCommas(data.bScsCnt));
    	            $('#bDifScsCnt').text(addCommas(data.bDifScsCnt));
      	            if (data.bDifScsCnt < 0 ) {
    	                $('#bDifScsCnt').text(addCommas(data.bDifScsCnt));
    	                $('#bDifScsCnt').className ="decrease";
    	            }else if (data.bDifScsCnt > 0 ) {
    	                $('#bDifScsCnt').text(addCommas(data.bDifScsCnt));
    	                $('#bDifScsCnt').className ="increase";
    	            }else if (data.bDifIaasCnt == 0 ) {
    	                $('#bDifScsCnt').className ="increase";
    	                $('#bDifScsCnt').text("-");
    	            }
    	            
    	            $('#mGoodsRegistSttus').text(data.mGoods_regist_sttus);
    	            $('#mGoodsCnt').text(addCommas(data.mGoodsCnt));
    	            $('#mDifGoodsCnt').text(addCommas(data.mDifGoodsCnt));
      	            if (data.mDifGoodsCnt < 0 ) {
    	                $('#mDifGoodsCnt').text(addCommas(data.mDifGoodsCnt));
    	                $('#mDifGoodsCnt').className ="decrease";
    	            }else if (data.mDifGoodsCnt > 0 ) {
    	                $('#mDifGoodsCnt').text(addCommas(data.mDifGoodsCnt));
    	                $('#mDifGoodsCnt').className ="increase";
    	            }else if (data.mDifGoodsCnt == 0 ) {
    	                $('#mDifGoodsCnt').className ="increase";
    	                $('#mDifGoodsCnt').text("-");
    	            }
    	            
    	            $('#mIaasCnt').text(addCommas(data.mIaasCnt));
    	            $('#mDifIaasCnt').text(addCommas(data.mDifIaasCnt));
      	            if (data.mDifIaasCnt < 0 ) {
    	                $('#mDifIaasCnt').text(addCommas(data.mDifIaasCnt));
    	                $('#mDifIaasCnt').className ="decrease";
    	            }else if (data.mDifIaasCnt > 0 ) {
    	                $('#mDifIaasCnt').text(addCommas(data.mDifIaasCnt));
    	                $('#mDifIaasCnt').className ="increase";
    	            }else if (data.mDifIaasCnt == 0 ) {
    	                $('#mDifIaasCnt').className ="increase";
    	                $('#mDifIaasCnt').text("-");
    	            }
    	            
    	            $('#mPaasCnt').text(addCommas(data.mPaasCnt));
    	            $('#mDifPaasCnt').text(addCommas(data.mDifPaasCnt));
      	            if (data.mDifPaasCnt < 0 ) {
    	                $('#mDifPaasCnt').text(addCommas(data.mDifPaasCnt));
    	                $('#mDifPaasCnt').className ="decrease";
    	            }else if (data.mDifIaasCnt > 0 ) {
    	                $('#mDifPaasCnt').text(addCommas(data.mDifPaasCnt));
    	                $('#mDifPaasCnt').className ="increase";
    	            }else if (data.mDifPaasCnt == 0 ) {
    	                $('#mDifPaasCnt').className ="increase";
    	                $('#mDifPaasCnt').text("-");
    	            }
    	            
    	            $('#mSaasCnt').text(addCommas(data.mSaasCnt));
    	            $('#mDifSaasCnt').text(addCommas(data.mDifSaasCnt));
      	            if (data.mDifSaasCnt < 0 ) {
    	                $('#mDifSaasCnt').text(addCommas(data.mDifSaasCnt));
    	                $('#mDifSaasCnt').className ="decrease";
    	            }else if (data.mDifSaasCnt > 0 ) {
    	                $('#mDifSaasCnt').text(addCommas(data.mDifSaasCnt));
    	                $('#mDifSaasCnt').className ="increase";
    	            }else if (data.mDifSaasCnt == 0 ) {
    	                $('#mDifSaasCnt').className ="increase";
    	                $('#mDifSaasCnt').text("-");
    	            }
    	            
    	            $('#mScsCnt').text(addCommas(data.mScsCnt));
    	            $('#mDifScsCnt').text(addCommas(data.mDifScsCnt));
      	            if (data.mDifScsCnt < 0 ) {
    	                $('#mDifScsCnt').text(addCommas(data.mDifScsCnt));
    	                $('#mDifScsCnt').className ="decrease";
    	            }else if (data.mDifScsCnt > 0 ) {
    	                $('#mDifScsCnt').text(addCommas(data.mDifScsCnt));
    	                $('#mDifScsCnt').className ="increase";
    	            }else if (data.mDifScsCnt == 0 ) {
    	                $('#mDifScsCnt').className ="increase";
    	                $('#mDifScsCnt').text("-");
    	            }
      	            
    	            $('#bsGoodsCnt').text(addCommas(data.bsGoodsCnt));
    	            $('#bsDifGoodsCnt').text(addCommas(data.bsDifGoodsCnt));
      	            if (data.bsDifGoodsCnt < 0 ) {
    	                $('#bsDifGoodsCnt').text(addCommas(data.bsDifGoodsCnt));
    	                $('#bsDifGoodsCnt').className ="decrease";
    	            }else if (data.bsDifGoodsCnt > 0 ) {
    	                $('#bsDifGoodsCnt').text(addCommas(data.bsDifGoodsCnt));
    	                $('#bsDifGoodsCnt').className ="increase";
    	            }else if (data.bsDifGoodsCnt == 0 ) {
    	                $('#bsDifGoodsCnt').className ="increase";
    	                $('#bsDifGoodsCnt').text("-");
    	            }
    	            
    	        }
    	    });
    	    
    	    $.ajax({//서비스 현황
    	        type: "POST",
    	        url: "/intra/explorer/BD_goodsServiceStateJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	            var innerHtml = "";
                   	if (data.goodsServiceState == "false") {
                   	    $('#goodsServiceState').html("<span class=\"falutURL\" id=\"falutURL\">이상</span>");
                   	}else{
                   	    $('#goodsServiceState').html("<span class=\"normalURL\" id=\"normalURL\">정상</span>");
                   	}
    	        }
    	    });

    	    $.ajax({//업무현황  현황
    	        type: "POST",
    	        url: "/intra/explorer/dashboardWorkJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	            
    	            $('#workContract').text(addCommas(data.workContractCnt));
    	            $('#workExamCnt').text(addCommas(data.workExamCnt));
    	            $('#workApprovalCnt').text(addCommas(data.workApprovalCnt));
    	            $('#workReqCnt').text(addCommas(data.workReqCnt));
    	            $('#qnaStateCnt').text(addCommas(data.qnaStateCnt));
    	            $('#goodsQnaStateCnt').text(addCommas(data.goodsQnaStateCnt));
    	            $('#bizStateCnt').text(addCommas(data.bizStateCnt));
    	        }
    	    });

    	    $.ajax({//총 계약금액
    	        type: "POST",
    	        url: "/intra/explorer/totalCntrAmountJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	            $('#cntrctAmount').text(addCommas(data.cntrctAmount));
    	            $('#difCntrctAmount').text(addCommas(data.difCntrctAmount));
      	            if (data.difCntrctAmount < 0 ) {
    	                $('#difCntrctAmount').text(addCommas(data.difCntrctAmount));
    	                $('#difCntrctAmount').className ="decrease";
    	            }else if (data.difCntrctAmount > 0 ) {
    	                $('#difCntrctAmount').text(addCommas(data.difCntrctAmount));
    	                $('#difCntrctAmount').className ="increase";
    	            }else if (data.difCntrctAmount == 0 ) {
    	                $('#difCntrctAmount').className ="increase";
    	                $('#difCntrctAmount').text("-");
    	            }
    	            
    	            $('#cntrctSnCnt').text(addCommas(data.cntrctSnCnt));
    	            $('#difCntrctSnCnt').text(addCommas(data.difCntrctSnCnt));
      	            if (data.difCntrctSnCnt < 0 ) {
    	                $('#difCntrctSnCnt').text(addCommas(data.difCntrctSnCnt));
    	                $('#difCntrctSnCnt').className ="decrease";
    	            }else if (data.difCntrctSnCnt > 0 ) {
    	                $('#difCntrctSnCnt').text(addCommas(data.difCntrctSnCnt));
    	                $('#difCntrctSnCnt').className ="increase";
    	            }else if (data.difCntrctSnCnt == 0 ) {
    	                $('#difCntrctSnCnt').className ="increase";
    	                $('#difCntrctSnCnt').text("-");
    	            }
    	        }
    	    });
    	    
    	    $.ajax({//계약금액 TOP 10
    	        type: "POST",
    	        url: "/intra/explorer/totalCntrTopListJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	            var innerHtml = "";
    	            
    	            for (var i=0; i<data.dataList.length; i++) {
    	                innerHtml += "<tr><td>"+data.dataList[i].rNum+"</td><td>"+data.dataList[i].purchsInsttNm+"</td><td style=\"text-align:right;\">"+addCommas(data.dataList[i].cntrctAmount)+"</td></tr>";
    	                $('#totalCntrTopList').html(innerHtml);
    	            }
    	        }
    	    });
    	    
    	    $.ajax({//계약건수 TOP 10
    	        type: "POST",
    	        url: "/intra/explorer/totalCntrCountTopListJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	            var innerHtml = "";
    	            
    	            for (var i=0; i<data.dataList.length; i++) {
    	                innerHtml += "<tr><td>"+data.dataList[i].rNum+"</td><td>"+data.dataList[i].purchsInsttNm+"</td><td>"+addCommas(data.dataList[i].cntrctAmount)+"</td></tr>";
    	                $('#totalCntrCountTopList').html(innerHtml);
    	            }
    	        }
    	    });
    	    
    	    $.ajax({//계약금액 누적통계
    	        type: "POST",
    	        url: "/intra/explorer/cntrctAmountViewJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
                    var ctx = document.getElementById("barChart01").getContext('2d');
                    var testJson = [];
                    var newJson = [];
                    var startDate = data.startDate;
                    var endDate = data.endDate;
                    
                    
                    $('#chartDate1').text("계약금액 누적통계("+startDate+" ~ "+endDate+")");
                    	
                    for (var i=0; i<data.dataList.length; i++) {
                        //console.log(data.dataList[i]);
                        var cntrDtYyyy	= data.dataList[i].cntrDtYyyy;
                        //var cntrColor 	= data.dataList[i].cntrColor;
                        var cntrJan  	= data.dataList[i].Jan/1000000;
                        var cntrFeb  	= data.dataList[i].Feb/1000000;
                        var cntrMar  	= data.dataList[i].Mar/1000000;
                        var cntrApr  	= data.dataList[i].Apr/1000000;
                        var cntrMay  	= data.dataList[i].May/1000000;
                        var cntrJun  	= data.dataList[i].Jun/1000000;
                        var cntrJul  	= data.dataList[i].Jul/1000000;
                        var cntrAug  	= data.dataList[i].Aug/1000000;
                        var cntrSept 	= data.dataList[i].Sept/1000000;
                        var cntrOct  	= data.dataList[i].Oct/1000000;
                        var cntrNov  	= data.dataList[i].Nov/1000000;
                        var cntrDece 	= data.dataList[i].Dece/1000000;

                        var backgroundColor;
                    	if (cntrDtYyyy == "2016") {
                    	    backgroundColor = window.chartColors.red;
                    	}else if (cntrDtYyyy == "2017") {
                    	    backgroundColor = window.chartColors.blue;
                    	}else{
                    	    backgroundColor = window.chartColors.orange;
                    	}
                        
                    	testJson = {
                                	label : cntrDtYyyy, 
                                	backgroundColor: backgroundColor,
                                    data: [cntrJan, cntrFeb, cntrMar, cntrApr, cntrMay, cntrJun, cntrJul, cntrAug, cntrSept, cntrOct, cntrNov, cntrDece]
                                   };
                        newJson.push(testJson);
                    }
                    
                    var barChart01 = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            	labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                                datasets:  
                                    newJson           
                        	},
                        options: {
                            tooltips: {
                                mode: 'index',
                                intersect: false
                            },
                            legend: {
                                display: false
                            }
                        }
                    });
    	        }
    	    });
    	    
       	    $.ajax({//계약건수 누적통계
    	        type: "POST",
    	        url: "/intra/explorer/cntrctCountViewJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
                    var ctx = document.getElementById("barChart02").getContext('2d');
                    var testJson = [];
                    var newJson = [];
                    var startDate = data.startDate;
                    var endDate = data.endDate;
                    
                    
                    $('#chartDate2').text("계약건수 누적통계("+startDate+" ~ "+endDate+")");
                    	
                    for (var i=0; i<data.dataList.length; i++) {
                        //console.log(data.dataList[i]);
                        var cntrDtYyyy	= data.dataList[i].cntrDtYyyy;
                        //var cntrColor 	= data.dataList[i].cntrColor;
                        var cntrJan  	= data.dataList[i].Jan;
                        var cntrFeb  	= data.dataList[i].Feb;
                        var cntrMar  	= data.dataList[i].Mar;
                        var cntrApr  	= data.dataList[i].Apr;
                        var cntrMay  	= data.dataList[i].May;
                        var cntrJun  	= data.dataList[i].Jun;
                        var cntrJul  	= data.dataList[i].Jul;
                        var cntrAug  	= data.dataList[i].Aug;
                        var cntrSept 	= data.dataList[i].Sept;
                        var cntrOct  	= data.dataList[i].Oct;
                        var cntrNov  	= data.dataList[i].Nov;
                        var cntrDece 	= data.dataList[i].Dece;

                        var backgroundColor;
                    	if (cntrDtYyyy == "2016") {
                    	    backgroundColor = window.chartColors.red;
                    	}else if (cntrDtYyyy == "2017") {
                    	    backgroundColor = window.chartColors.blue;
                    	}else{
                    	    backgroundColor = window.chartColors.orange;
                    	}
                        
                    	testJson = {
                                	label : cntrDtYyyy, 
                                	backgroundColor: backgroundColor,
                                    data: [cntrJan, cntrFeb, cntrMar, cntrApr, cntrMay, cntrJun, cntrJul, cntrAug, cntrSept, cntrOct, cntrNov, cntrDece]
                                   };
                        newJson.push(testJson);
                    }
                    
                    var barChart02 = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            	labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                                datasets:  
                                    newJson           
                        	},
                        options: {
                            tooltips: {
                                mode: 'index',
                                intersect: false
                            },
                            legend: {
                                display: false
                            }
                        }
                    });
    	        }
    	    });
    	    
    	    $.ajax({//비율
    	        type: "POST",
    	        url: "/intra/explorer/cntrctRatioJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){

                    var ctx = document.getElementById("doughnut01").getContext('2d');
                    var doughnut01 = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            datasets: [{
                                data: [data.saasRatio, data.paasRatio, data.iaasRatio, data.scsRatio, ],
                                backgroundColor: [
                                    window.chartColors.red,
                                    window.chartColors.orange,
                                    window.chartColors.blue,
                                    window.chartColors.green,
                                ],
                                label: 'Dataset 1'
                            }],
                            labels: [
                                "SaaS",
                                "PaaS",
                                "IaaS",
                                "SCS"
                            ]
                        },
                        options: {
                            responsive: true,
                            legend: {
                                display: false,
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            }
                        }
                    });
    	            
    	            
    	        }
    	    });
    	    
    	    $.ajax({//비율
    	        type: "POST",
    	        url: "/intra/explorer/cntrctCountRatioJson.do",
    	        data: {"sessionId" : "${sessionScope.tempId}"},
    	        dataType: "json",
    	        success:function(data){
    	        	//console.log(data.scsRatio);
                    var ctx = document.getElementById("doughnut02").getContext('2d');
                    var doughnut02 = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            datasets: [{
                                data: [data.saasRatio, data.paasRatio, data.iaasRatio, data.scsRatio, ],
                                backgroundColor: [
                                    window.chartColors.red,
                                    window.chartColors.orange,
                                    window.chartColors.blue,
                                    window.chartColors.green,
                                ],
                                label: 'Dataset 1'
                            }],
                            labels: [
                                "SaaS",
                                "PaaS",
                                "IaaS",
                                "SCS"
                            ]
                        },
                        options: {
                            responsive: true,
                            legend: {
                                display: false,
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            }
                        }
                    });
    	            
    	            
    	        }
    	    });
    	    
    	    HashMap = function() {
    	      this.map = new Array();  
    	    };
    	    
    	    HashMap.prototype = {
  	            put : function (key, value) {
  	                this.map[key] = value;
  	            },
  	            get: function (key) {
  	                return this.map[key];
  	            },
  	            getAll: function () {
  	                return this.map;
  	            },
  	            clear: function () {
  	                this.map = new Array();
  	            },
  	            getKeys: function () {
  	                var keys = new Array();
  	                for(i in this.map) {
  	                    keys.push(i);
  	                }
  	                return keys;
  	            }
    	    };
    	    
    	});
    	
    	function addCommas(nStr) {
    	    nStr += ''; 
    	    x = nStr.split('.'); 
    	    x1 = x[0]; 
    	    x2 = x.length > 1 ? '.' + x[1] : ''; 
    	    
    	    var rgx = /(\d+)(\d{3})/; 
    	    
    	    while (rgx.test(x1)) { 
    	        x1 = x1.replace(rgx, '$1' + ',' + '$2'); 
    	    } 
    	    
    	    return x1 + x2; 
    	}

        function makeTab(title, href, nid, flag) {
            parent.contentPanel.loadClass(title, href, nid, flag);
        }
        
        // '[+]' 클릭!!
        var jsUpdateFrontInfo = function (el)
        {
            $(el).colorbox({
    			title  : "사용자화면 정보갱신",
    			href   : "/intra/popup/PD_popFrontInfo.do",
    			width  : "550",
    			height : "270",
                overlayClose : true,
                escKey : true,
                iframe : true
    		});
        }
        
	</script>
</head>
<body class="ext-webkit ext-chrome x-border-layout-ct" id="ext-gen5">
<!-- <div name="docs-1" frameborder="0" id="ext-gen36" class=" ux-mif" style="overflow: auto; width: 1295px;background:#fff"> -->
<!-- dashboard -->
	<div class="dasharea">
	<p class="rig" style="font-size: 14px;width: 1172px;">(기준일 : <span id="basicDate">${basicDate}</span>) <button onclick="jsUpdateFrontInfo(this);">[+]</button> </p>
		<div class="bg_01 clearfix_dash">
		<h4 class="dash_title01 f_l">씨앗현황</h4>
			<div class="dash_cont01 f_l">
				<table>
					<caption>서비스등록 현황</caption>
					<thead>
						<tr>
							<th colspan="3">서비스등록현황</th>
							<th>총 <span id="goodsTotalCnt">0</span>개</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="cen bg_first" id="aGoodsRegistSttus">전시</td>
							<td class="bg_first" style="text-align:right;"><span id="aGoodsCnt">0</span>개 (<strong class="increase" id="aDifGoodsCnt">0</strong>)</td>
							<td class="cen bg_first" id="bGoodsRegistSttus">비전시</td>
							<td class="bg_first" style="text-align:right;"><span id="bGoodsCnt">0</span>개 (<strong class="decrease" id="bDifGoodsCnt">0</strong>)</td>
						</tr>
						<tr>
							<td class="cen">SaaS</td>
							<td style="text-align:right;"><span id="aSaasCnt">0</span>개 (<strong class="increase" id="aDifSaasCnt">0</strong>)</td>
							<td class="cen">SaaS</td>
							<td style="text-align:right;"><span id="bSaasCnt">0</span>개 (<strong class="decrease" id="bDifSaasCnt">0</strong>)</td>
						</tr>
						<tr>
							<td class="cen">PaaS</td>
							<td style="text-align:right;"><span id="aPaasCnt">0</span>개 (<strong class="increase" id="aDifPaasCnt">0</strong>)</td>
							<td class="cen">PaaS</td>
							<td style="text-align:right;"><span id="bPaasCnt">0</span>개 (<strong class="decrease" id="bDifPaasCnt">0</strong>)</td>
						</tr>
						<tr>
							<td class="cen">IaaS</td>
							<td style="text-align:right;"><span id="aIaasCnt">0</span>개 (<strong class="increase" id="aDifIaasCnt">0</strong>)</td>
							<td class="cen">IaaS</td>
							<td style="text-align:right;"><span id="bIaasCnt">0</span>개 (<strong class="decrease" id="bDifIaasCnt">0</strong>)</td>
						</tr>
						<tr>
							<td class="cen">SCS</td>
							<td style="text-align:right;"><span id="aScsCnt">0</span>개 (<strong class="increase" id="aDifScsCnt">0</strong>)</td>
							<td class="cen">SCS</td>
							<td style="text-align:right;"><span id="bScsCnt">0</span>개 (<strong class="decrease" id="bDifScsCnt">0</strong>)</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dash_cont01_2 f_l">
				<table>
			    	<caption>회원 현황</caption>
			    	<thead>
			    		<tr>
			    			<th colspan="2">회원 현황</th>
			    		</tr>
			       	</thead>
			       	<tbody>
			       		<tr>
			       			<td class="bg_first" id="mGoodsRegistSttus">0</td>
			       			<td class="bg_first" style="text-align:right;"><span id="mGoodsCnt">0</span>명 (<strong id="mDifGoodsCnt">0</strong>)</td>
			       		</tr>
			       		<tr>
			       			<td>공공기관</td>
			       			<td style="text-align:right;"><span id="mIaasCnt">0</span>명 (<strong id="mDifIaasCnt">0</strong>)</td>
			       		</tr>
			       		<tr>
			       			<td>기업회원</td>
			       			<td style="text-align:right;"><span id="mPaasCnt">0</span>명 (<strong id="mDifPaasCnt">0</strong>)</td>
			       		</tr>
			       		<tr>
			       			<td>개인회원</td>
			       			<td style="text-align:right;"><span id="mSaasCnt">0</span>명 (<strong class="decrease" id="mDifSaasCnt">0</strong>)</td>
			       		</tr>
			       	</tbody>
			   </table>
			</div>
			<div class="dash_cont01_2 f_l">
		        <table>
		        	<caption>협약서비스 현황</caption>
		        	<thead>
		        		<tr>
		                	<th colspan="2">협약서비스 현황</th>
		                </tr>
		            </thead>
		            <tbody>
		            	<tr>
		                	<td class="bg_first">협약기업</td>
		                    <td class="bg_first" style="text-align:right;"><span id="bsGoodsCnt">0</span>개 (<strong class="increase" id="bsDifGoodsCnt">0</strong>)</td>
		                </tr>
		            </tbody>
		        </table>
				<table class="mt20">
		            <caption>서비스 현황</caption>
		            <thead>
		                <tr>
		                	<th colspan="3">서비스 현황</th>
		            	</tr>
		            </thead>
		            <tbody>
		                <tr>
		                    <td colspan="2">서비스URL상태</td>
		                    <td><span id="goodsServiceState"  style="cursor: pointer;" onclick="makeTab('서비스현황', '/intra/store/goods/BD_goodsMonitorList.do?menuCd=231', '241', 'UPDATE');"></span></td>
		                	<!-- <td><a href="#" class="normalURL">정상</a></td> -->
		            	</tr>
		        	</tbody>
		    	</table>
       		</div>
   		</div>
		<div class="bg_02 clearfix_dash">
			<h4 class="dash_title02 f_l">업무현황</h4>
			<div class="dash_cont02 f_l">
			    <table>
			        <caption>협약관리</caption>
			        <thead>
			            <tr>
			                <th colspan="3">협약관리</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td colspan="2">체결승인요청</td>
			                <td class="rig"><span class="increase" id="workContract" style="cursor: pointer;" onclick="makeTab('기본협약관리', '/intra/bassAgremManage/BD_index.do?menuCd=241&q_agremstat=1001,1002,1007&q_init=&q_searchVal=&q_searchStatVal=&q_rowPerPage=10&q_currPage=1&q_sortName=&q_sortOrder=', '241', 'UPDATE');">0</span></td>
			            </tr>
			        </tbody>
			    </table>
			</div>
			<div class="dash_cont02 f_l">
			    <table>
			        <caption>서비스관리</caption>
			        <thead>
			            <tr>
			                <th colspan="3">서비스관리</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			            	<td colspan="2">검토(운영팀)</td>
			                <td class="rig"><span class="increase" id="workExamCnt" style="cursor: pointer;" onclick="makeTab('서비스 검토(운영팀)', '/intra/store/goods/BD_goodsExmntList.do?menuCd=197', '241', 'UPDATE');">0</span></td>
			            </tr>
			            <tr>
			                <td colspan="2">승인(NIA)</td>
			            	<td class="rig"><span id="workApprovalCnt" style="cursor: pointer;" onclick="makeTab('신규서비스 승인(NIA)', '/intra/store/goods/BD_goodsConfnList.do?menuCd=198', '241', 'UPDATE');">0</span></td>
			        	</tr>
			            <tr>
			                <td colspan="2">상품문의 답변대기</td>
			            	<td class="rig"><span id="goodsQnaStateCnt" style="cursor: pointer;" onclick="makeTab('상품문의 관리', '/intra/goods/qna/BD_index.do?menuCd=206', '241', 'UPDATE');">0</span></td>
			        	</tr>
			    	</tbody>
				</table>
			</div>
			<div class="dash_cont02 f_l cont02_sub01">
				<table>
					<caption>증명서관리</caption>
					<thead>
						<tr>
							<th colspan="3">증명서관리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2">발급요청</td>
							<td class="rig"><span class="increase" id="workReqCnt" style="cursor: pointer;" onclick="makeTab('이용실적증명서 신청승인', '/intra/proofIssueapply/BD_suppList.do?issuSttus=1001', '241', 'UPDATE');">0</span></td>
						</tr>
					</tbody>
				</table>
			</div>
	    	<div class="dash_cont02 f_l cont02_sub02">
	    		<table>
	        		<caption>게시물관리</caption>
	            	<thead>
	                	<tr>
	                    	<th colspan="3">게시물관리</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<tr>
	                		<td colspan="2">Q&amp;A 답변대기</td>
	                		<td class="rig"><span class="increase" id="qnaStateCnt">0</span></td>
	                	</tr>
		                <tr>
		                    <td colspan="2">비즈매칭 답변대기</td>
		                	<td class="rig"><span id="bizStateCnt">0</span></td>
		            	</tr>
		        	</tbody>
		    	</table>
			</div>
		</div>
   		<div class="bg_03 clearfix_dash">
       		<h4 class="dash_title03 f_l">계약현황</h4>
       		<div class="chartArea f_l">
           		<div class="clearfix_dash">
               		<div class="dash_cont03 f_l">
                   		<table>
                       		<caption>총 계약금액</caption>
                       		<tbody>
                           		<tr>
                               		<th>총 계약금액</th>
                               		<td class="rig"><span id="cntrctAmount">0</span>원  (<span class="increase" id="difCntrctAmount">0</span>)</td>
                           		</tr>
                       		</tbody>
                   		</table>
               		</div>
					<div class="dash_cont03 f_l">
						<table>
							<caption>총 계약건수</caption>
							<tbody>
								<tr>
									<th>총 계약건수</th>
									<td class="rig"><span id="cntrctSnCnt">0</span>건  (<span class="increase" id="difCntrctSnCnt">0</span>)</td>
	                        	</tr>
	                    	</tbody>
	                	</table>
					</div>
           		</div>
           		<div class="dash_cont03_2">
		            <ul class="tabs clearfix_dash">
		            	<li rel="tab1" class="f_l active"><span>계약금액</span></li>
		            	<li rel="tab2" class="f_l"><span>계약건수</span></li>
		            </ul>
               		<div class="contentArea">
                   		<div id="tab1" class="tab_content p_relative clearfix_dash">
                       		<div class="barCharArea f_l">
                           		<p class="chart_title" ><label id="chartDate1">계약금액 누적통계(2016.02 ~ 2017.12)</label> <span>(단위: 천만 원)</span></p>
                           		<canvas id="barChart01"></canvas>
                       		</div>
                       		<div class="doughnutArea f_l p_relative">
                           		<p class="chart_title">서비스 유형별 비율</p>
                       			<canvas id="doughnut01"></canvas>
                   			</div>
	                       	<div class="lankArea f_l">
	                        	<p class="chart_title">계약금액 TOP 10</p>
	                           	<div class="overArea">
	                            	<table>
	                                	<caption>계약금액 TOP 10</caption>
	                                   	<tbody id="totalCntrTopList"></tbody>
	                               </table>
	                           </div>
	                       </div>
	                    </div>
	                    <div id="tab2" class="tab_content p_relative clearfix_dash">
	                    	<div class="barCharArea f_l">
	                    		<p class="chart_title"><label id="chartDate2">계약건수 누적통계(2016.02 ~ 2017.12)</label></p>
	                    		<canvas id="barChart02"></canvas>
	                    	</div>
		                    <div class="doughnutArea f_l p_relative">
		                    	<p class="chart_title">서비스 유형별 비율</p>
		                    	<canvas id="doughnut02"></canvas>
		                    </div>
		                    <div class="lankArea f_l">
		                    	<p class="chart_title">계약건수 TOP 10</p>
		                    	<div class="overArea">
		                    		<table>
		                    			<caption>계약건수 TOP 10</caption>
		                    			<tbody id="totalCntrCountTopList"></tbody>
		                    		</table>
		                    	</div>
		                	</div>
		            	</div>
		        	</div>
		    	</div>
			</div>
		</div>
	</div>
<!-- dashboard -->  								
<!-- </div> -->
</body>
</html>