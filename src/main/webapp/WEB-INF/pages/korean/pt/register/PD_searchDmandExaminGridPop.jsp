<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<% 
response.setHeader("cache-control","no-cache"); 
response.setHeader("expires","0"); 
response.setHeader("pragma","no-cache"); 
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>수요예보조사</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript"/>
	<meta http-equiv="Content-Style-Type" content="text/css"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>	
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/> 

	<c:set var="rootPath" value="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }" />
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<c:set var="basePath" value="${rootPath }${path }" />
	<c:set var="libPath" value="${basePath }/resources/openworks/spi/AUIGrid/lib" />
	<c:set var="gridPath" value="${basePath}/resources/openworks/spi/AUIGrid" />
	
	<script src="${libPath }/jquery-1.8.0.min.js"></script>
	<script src="${libPath }/core.js"></script>
	<op:jsTag type="spi" items="colorbox" />
	
	<script type="text/javascript" src="${gridPath}/AUIGrid/AUIGrid.js"></script>
	<script type="text/javascript" src="${gridPath}/AUIGrid/AUIGridLicense.js"	></script>
	
	<link href="${gridPath}/AUIGrid/AUIGrid_style.css" rel="stylesheet"></link>
	<c:set var="imagesPath" value="${basePath }/resources/openworks/spi/dmandExamin" />
	<link href="${basePath}/resources/openworks/spi/dmandExamin/css/layout.css" rel="stylesheet" type="text/css" />
	<!-- ================================================================ -->
	<style type="text/css">
	.text-center {text-align:center;}
 	.view-Basic {		  background:#EDD3ED;}
	.view-Basic-left {	  background:#EDD3ED; text-align:left;}
	.view-Basic-right {	  background:#EDD3ED; text-align:right;}
	.view-Question { 	  background:#CFECF3;}
	.view-Question-left { background:#CFECF3; text-align:left;}
	.view-Question-right {background:#CFECF3; text-align:right;}
	.mycustom-disable-color {background-color: #C9C9C9; color:#C9C9C9}
	.mycustom-disable-color2 {color : #C9C9C9; background-color: black;} 
	</style>
	<style>
		html {overflow-y:scroll; height:100%;}
		body {
		margin:0 auto;
		font-family:"나눔고딕", "맑은 고딕", "돋움", Dotum, Verdana, Tahoma;
		font-weight:1000;
		font-size: 12px;
		line-height:170%;
		color:#333;
		}
		ul li,ol li{list-style:none;}
		a{text-decoration:none;}
		img{border:0 none;}
		ul,ol,dl,li {list-style:none;}
		a { text-decoration:none; color:#000;}
		dt , .hidden {position:absolute; left:-9999px; width:0; height:0; font-size:0; line-height:0;}
		@import url(http://www.openhiun.com/hangul/nanumgothic.css);

		/*파이어폭스*/
		@-moz-document url-prefix(){
		body,html {margin:0; padding:0; height:100%; }
		}

		/*크롬*/
		@media screen and (-webkit-min-device-pixel-ratio:0) {
		body,html {margin:0; padding:0;   height:100%; }
		}
		.clr:after{content:'';display:block;clear:both}
		.f_l{float:left}
		.f_r{float:right}
		.btn_bs{display:block;width:90px;height:20px;padding:5px 20px;margin:0 5px;background-color:#000;color:#fff;border-radius:5px;text-align:center;background-color:#ddd;}
		.ico_margin{margin-right:5px;}
		.ds_inline{display:inline-block;}
		.input_area{width:70%;margin-left:20px;padding:5px 20px;border-radius:5px;background-color:#ddd;}
		#fileNm{width:70%;margin-left:15px;padding:0 10px;font-size:12px;}
	</style>	
	<!-- ================================================================ -->
	
	<script type="text/javascript">
	// 그리드 생성 후 해당 ID 보관 변수
    var myGridID;
	
  	//=============================================
	// 목록 리스트 관리
	// ============================================
	    
 	// 6. 시스템 구분 (D-기존 / 신규)
    var comboOLDNEW = ["기존","신규"];
 	// 15. 클라우드 이용여부
    var comboYN = [ "Y", "N"];
 	
    var comboYear = [ "2018","2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003"];
 	
 	// 15-1. 클라우드 구분
 	var comboGuBun = [
		"민간",
		"자체",
		"국가정보자원관리원"
 	];
 	// 16. 클라우드 전환 또는 도입 예정
 	var comboPlan = [
		"2019년",
		"2020년부터",
		"예정없음"
	];
 	// 16-1. 클라우드 전환 또는 도입 예정 - 클라우드 구분
 	var comboPlanCGuBun = [
		"민간",
		"자체",
		"국가정보자원관리원"
	];
 	// 16-1. 클라우드 전환 또는 도입 예정 - 서비스 구분
 	var comboPlanSGuBun = [
		"SaaS",
		"PaaS",
		"IaaS",
		"IaaS+SaaS",
		"IaaS+PaaS",
		"PaaS+SaaS",
		"IaaS+PaaS+SaaS"
	];
	
 // 칼럼 레이아웃 작성
    var columnLayout = [ 
	{
	    dataField : "Delete",
	    headerText : "행삭제",
	    editable : false,
	    width : 60,
		renderer : {
			type : "IconRenderer",
			iconWidth 		: 12, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
			iconHeight 		: 12,
			iconTableRef 	:  { // icon 값 참조할 테이블 레퍼런스
				"default" 	: "${imagesPath}/images/delete.png" // default
			}
		}
	}, {
        dataField : "dmandSurveyNo",
        editable : false,
        skipReadonlyColumns:false,
        headerText : "①순번",
        style : "view-Basic",
        width : 80
    }, {
        dataField : "dmandSurveyOrgname",
        headerText : "②기관명",
        style : "view-Basic",
        width : 200,
        editRenderer : {
			type : "InputEditRenderer",
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
				var isValid = 0;
				if(newValue.length < 200) {
					isValid = true;
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "기관명은 200글자를 초과할 수 없습니다." };
			}
		}
    }, {
        dataField : "dmandSurveySysname",
        headerText : "<b>③시스템명</b>",
        style : "view-Basic-left",
        width : 200,
        editRenderer : {
			type : "InputEditRenderer",
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
				var isValid = 0;
				if(newValue.length < 200) {
					isValid = true;
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "시스템명은 200글자를 초과할 수 없습니다." };
			}
		}
    }, {
        dataField : "dmandSurveySysobj",
        headerText : "<b>④시스템목적</b>",
        style : "view-Basic-left",
        width : 400,
        editRenderer : {
			type : "InputEditRenderer",
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
				var isValid = 0;
				if(newValue.length < 2000) {
					isValid = true;
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "시스템 목적은 2000글자 이내로 작성가능합니다." };
			}
		}
    }, {
        dataField : "dmandSurveyDivision",
        headerText : "<b>⑤시스템구분</b>",
        style : "view-Basic",
        //styleFunction : cellStyleFunction,
        width : 100,
        editRenderer : {
			type : "DropDownListRenderer",
			descendants : [ 
			                "dmandSurveyBuildy" 	// 10. 구축년도
			               ,"dmandSurveyUpy" 		// 11. 최근 업그레이드 년도
			              ],
			//descendantDefaultValues : ["","","0","0","0"], // 변경 시 자손들에게 기본값 지정
			list : comboOLDNEW
		}		
    }, {
        dataField : "dmandSurveyManager",
        headerText : "<b>⑥담당자</b>",
        style : "view-Basic",
        width : 100,
        editRenderer : {
			type : "InputEditRenderer",
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
				var isValid = 0;
				if(newValue.length < 50) {
					isValid = true;
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "담당자는 50글자 이내로 작성가능합니다." };
			}
		}
    }, {
        dataField : "dmandSurveyMail",
        headerText : "⑦이메일",
        style : "view-Basic-left",
        width : 200,
        editRenderer : {
			type : "InputEditRenderer",
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
				var isValid = false;
				var email_matcher = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/; // 이메일 체크 정규식
				if(fn_isNull(newValue) || (email_matcher.test(newValue)) ) {
					isValid = true;
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "정확한 이메일 주소가 아닙니다. 다시 확인해 주세요." };
			}
		}
    }, {
        dataField : "dmandSurveyPhone",
        headerText : "⑧유선번호",
        style : "view-Basic",
        width : 120,
        editRenderer : {
			type : "InputEditRenderer",
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
					var isValid = false;
					var alertMsg = "";
					var telNum_reg = /^[0-9]+([-]?[0-9])*$/g;;  
					if(fn_isNull(newValue)) {
					    isValid = true;
					}
					else if(telNum_reg.test(newValue)) {
					    if(newValue.length < 50){
					        isValid = true;
					    } else {
					        alertMsg = "길이는 50을 초과할 수 없습니다.";
					    }
					} else {
					    alertMsg = "정확한 유선번호 형식이 아닙니다.";
					}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message" : alertMsg };
			}
		}
    }, {
        dataField : "dmandSurveyBuildy",
        headerText : "⑨구축년도<br />(YYYY)",
        style : "view-Basic",
        width : 100,
/* 		renderer : {
			type : "DropDownListRenderer",
			list : comboYN
		}, */
		editRenderer : {
			type : "DropDownListRenderer",
			descendants : [ 
			                "dmandSurveySeparation" // ⑪-1)클라우드구분
			               //,"dmandSurveyIntroy" // 15-2
			               ,"dmandSurveyCnvrsPlan" // 16-1
			               ,"dmandSurveyPlanCloudSeparation" // ⑫-1 클라우드 구분
			               ,"dmandSurveyPlanServSeparation" // 16-1-2
			               ,"dmandSurveyBudget" // 16-2
			               //,"dmandSurveyVldtySecretAt" // 17
			               //,"dmandSurveyVldtyFirstecon"
			              ], // 자손 필드들(15-1, 15-2, // 16, 16-1-1, 16-1-2, 17, 18)
			descendantDefaultValues : [""], // 변경 시 자손들에게 기본값 지정
			list : comboYear
		},
        width : 150
    	/* 
    	
    	
    	
        dataField : "dmandSurveyBuildy",
        headerText : "⑨구축년도<br />(YYYY)",
        style : "view-Basic",
        //styleFunction : cellStyleFunction,
        width : 80,
        editRenderer : {
			type : "InputEditRenderer",
			onlyNumeric : true, // Input 에서 숫자만 가능케 설정

			list : comboOLDNEW
		} */
        ,
    }, {
    	

        dataField : "dmandSurveyUpy",
        headerText : "⑩최근 업그레이드<br />년도(YYYY)",
        style : "view-Basic",
        width : 100,
/* 		renderer : {
			type : "DropDownListRenderer",
			list : comboYN
		}, */
		editRenderer : {
			type : "DropDownListRenderer",
			descendants : [ 
			                "dmandSurveySeparation" // ⑪-1)클라우드구분
			               //,"dmandSurveyIntroy" // 15-2
			               ,"dmandSurveyCnvrsPlan" // 16-1
			               ,"dmandSurveyPlanCloudSeparation" // ⑫-1 클라우드 구분
			               ,"dmandSurveyPlanServSeparation" // 16-1-2
			               ,"dmandSurveyBudget" // 16-2
			               //,"dmandSurveyVldtySecretAt" // 17
			               //,"dmandSurveyVldtyFirstecon"
			              ], // 자손 필드들(15-1, 15-2, // 16, 16-1-1, 16-1-2, 17, 18)
			descendantDefaultValues : [""], // 변경 시 자손들에게 기본값 지정
			list : comboYear
		},
        width : 150    	
/*     	
    	
    	
        dataField : "dmandSurveyUpy",
        headerText : "⑩최근 업그레이드<br />년도(YYYY)",
        style : "view-Basic",
        //styleFunction : cellStyleFunction,
        width : 150,
		editRenderer : {
			type : "InputEditRenderer",
			onlyNumeric : true, // Input 에서 숫자만 가능케 설정
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
				var isValid = 0;
				var numVal = Number(newValue);
				if(!isNaN(numVal) && numVal < 2019) {
					isValid = true;
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "최근 업그레이드년도는 2018년도를 초과할 수 없습니다." };
			}
		} */
    }, {
        dataField : "dmandSurveyClouduse",
        headerText : "<b>⑪현 클라우드 이용여부</b>",
        style : "view-Question",
        styleFunction : cellStyleFunction,
/* 		renderer : {
			type : "DropDownListRenderer",
			list : comboYN
		}, */
		editRenderer : {
			type : "DropDownListRenderer",
			descendants : [ 
			                "dmandSurveySeparation" // ⑪-1)클라우드구분
/* 			               ,"dmandSurveyCnvrsPlan" // 16-1
			               ,"dmandSurveyPlanCloudSeparation" // 16-1-6
			               ,"dmandSurveyPlanServSeparation" // 16-1-2
			               ,"dmandSurveyBudget" // 16-2 */
			              ], // 자손 필드들(15-1, 15-2, // 16, 16-1-1, 16-1-2, 17, 18)
			descendantDefaultValues : [""], // 변경 시 자손들에게 기본값 지정
			list : comboYN
		},
        width : 150
    }, {
        dataField : "dmandSurveySeparation",
        headerText : "⑪-1)클라우드구분",
        style : "view-Question",
        styleFunction : cellStyleFunction,
/* 		renderer : {
			type : "DropDownListRenderer",
			list : comboGuBun
		}, */
		editRenderer : {
			type : "DropDownListRenderer",
			listFunction : function(rowIndex, columnIndex, item, dataField) {
				if(item.dmandSurveyClouduse == "Y") { // 그룹 필드에서 선택된 값 비교
					item.dmandSurveySeparation.value ="";
				    return comboGuBun;
				} else if(item.dmandSurveyClouduse == "N") {
					return false;
				} else {
					return true;
				}
			}
		},
        width : 150
    }, {
        dataField : "dmandSurveyCnvrsPlan",
        headerText : "<b>⑫클라우드전환<br />또는 도입예정</b>",
        style : "view-Question-left",
        styleFunction : cellStyleFunction,
/* 		renderer : {
			type : "DropDownListRenderer",
			list : comboPlan
		}, */
		editRenderer : {
		    type : "DropDownListRenderer",
			descendants : [ // 자손 필드들(16-1-1, 16-1-2, 17, 18)
			               "dmandSurveyPlanCloudSeparation" // 16-1-1
			               ,"dmandSurveyPlanServSeparation" // 16-1-2
			               ,"dmandSurveyBudget" 			// 16-2
			               //,"dmandSurveyVldtySecretAt" 		// 17
			               //,"dmandSurveyVldtyFirstecon" 	// 18
			              ], 
			descendantDefaultValues : ["","","0"], // 변경 시 자손들에게 기본값 지정
			list : comboPlan
		},
        width : 100
    }, {
		dataField : "dmandSurveyPlanChangep", // 그룹 헤더의 dataField 는 무의미 하지만, 칼럼 순서에 사용하기 위해 임의 지정함.(중복되지 않게 임의 지정하세요.)
		headerText : "⑫-1) 클라우드 도입 예정시",
		style : "view-Question",
		children : [{
						dataField : "dmandSurveyPlanCloudSeparation",
						headerText : "클라우드 구분",
						style : "view-Question",
						styleFunction : cellStyleFunction,
						width:150,
/* 						renderer : {
							type : "DropDownListRenderer",
							list : comboPlanCGuBun
						} */
						editRenderer : {
							type : "DropDownListRenderer",
							listFunction : function(rowIndex, columnIndex, item, dataField) {
							    
								if(item.dmandSurveyCnvrsPlan == "2019년") {
									return comboPlanCGuBun;
								} else if(item.dmandSurveyCnvrsPlan == "2020년부터") {
									return comboPlanCGuBun;
								} else if(item.dmandSurveyCnvrsPlan == "예정없음") {
									return false;
								} else {
									return true;
								}
							}
						}
					}, {
						dataField : "dmandSurveyPlanServSeparation",
						headerText : "서비스구분",
						style : "view-Question",
						styleFunction : cellStyleFunction,
						width:150,
/* 						renderer : {
							type : "DropDownListRenderer",
							list : comboPlanSGuBun
						}, */
						editRenderer : {
							type : "DropDownListRenderer",
							listFunction : function(rowIndex, columnIndex, item, dataField) {
								if(item.dmandSurveyCnvrsPlan == "2019년") {
									return comboPlanSGuBun;
								} else if(item.dmandSurveyCnvrsPlan == "2020년부터") {
									return comboPlanSGuBun;
								} else if(item.dmandSurveyCnvrsPlan == "예정없음") {
									return false;
								} else {
									return true;
								}
							}
						}
					}]
    }, {
        dataField : "dmandSurveyBudget",
        headerText : "⑫-2)클라우드 예산<br />(단위:천원)",
        dataType : "numeric",
        style : "view-Question-right",
        styleFunction : cellStyleFunction,
        width : 120,
        editRenderer : {
			type : "InputEditRenderer",
			onlyNumeric : true, // Input 에서 숫자만 가능케 설정
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, item) {
			    var isValid = 0;
				var strMsg = "";
				var numVal = Number(newValue);
				if(isNaN(numVal)) {
				    strMsg = "숫자만 입력 가능합니다.";
				} else if(numVal > 10000000000000000000) {
				    isValid = false;
				    strMsg = "자릿수 20 미만";
				} else {
				    isValid = true;
				}
				
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : strMsg };
			}
		}
    }, {
        dataField : "dmandSurveyVldtySecretAt",
        headerText : "<b>⑬2020년 이후 국가정보자원관리원 <br />대구센터 입주의향 여부</b>",
        style : "view-Question",
        styleFunction : cellStyleFunction,
/* 		renderer : {
			type : "DropDownListRenderer",
			list : comboYN
		}, */
		editRenderer : {
			type : "DropDownListRenderer",
			descendantDefaultValues : [""], // 변경 시 자손들에게 기본값 지정
			list : comboYN
		},
        width : 150
    }
    ];
	
    // 윈도우 onload 이벤트 핸들링
    // 만약 jQuery 사용한다면, $(document).ready(function() {}); 사용하세요.
    
    $(document).ready(function() {
     	// 실제로 #grid_wrap 에 그리드 생성
     	createAUIGrid(columnLayout);
        requestAjax();
        $('#grid_wrap').css('width', window.innerWidth-10);
	    $('#grid_wrap').css('height', window.innerHeight-200);
        if (myGridID){ 
            AUIGrid.resize(myGridID); 
        }
     	// Ajax 요청 실행
    });
    
    $(window).resize(function(){
        $('#grid_wrap').css('width', window.innerWidth-10);
	    $('#grid_wrap').css('height', window.innerHeight-200);
        if (myGridID){ 
            AUIGrid.resize(myGridID); 
        } 
	});
    
    // 그리드 생성
    function createAUIGrid(columnLayout) {
    	
        var presentnDate = $("#presentnDate").val();
        // 제출 이후 그리드 에디팅 컨트롤 변수
        var isPresentnDate = true;
        if(presentnDate)
            isPresentnDate = false;
        var result ="";
        if(presentnDate.length > 0){
            result = "데이터가 없는 상태로 제출 되었습니다.";
        } else {
            result = "출력할 데이터가 없습니다. 조사표를 다운로드 받고 작성한 후 업로드 하세요.";
        }
        // 그리드 속성 설정
    	var gridPros = {
    			// 편집 가능 여부 (기본값 : false)
    			editable : isPresentnDate,
    			
    			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
    			enterKeyColumnBase : true,
    			
    			// 셀 선택모드 (기본값: singleCell)
    			selectionMode : "multipleCells",
    			
    			// 컨텍스트 메뉴 사용 여부 (기본값 : false)
    			useContextMenu : false,
    			
    			// 필터 사용 여부 (기본값 : false)
    			enableFilter : false,
    			
    			// 그리드에서 삭제하기(즉시삭제 : false, 삭제대기 : true)
    			softRemoveRowMode : false,
    		
    			/* // 그룹핑 패널 사용
    			useGroupingPanel : true,
    			
    			// 상태 칼럼 사용
    			showStateColumn : false,
    			
    			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
    			displayTreeOpen : false, */
    			
    			// 줄번호 칼럼 렌더러 출력 안함
    			ashowRowNumColumn : false,
    			
    			// Ctrl+C, V 제한
    			enableClipboard : false,
    			
    			// 고정로우 카운트 지정
            	fixedColumnCount : 1,

                noDataMessage : result,
                
    	};
		
    	// 실제로 #grid_wrap 에 그리드 생성
    	myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
    	// 행 추가 이벤트 바인딩 
    	AUIGrid.bind(myGridID, "addRow");
    	// 행 삭제 이벤트 바인딩 
    	AUIGrid.bind(myGridID, "removeRow");
    	// 셀 클릭 이벤트 바인딩
    	AUIGrid.bind(myGridID, "cellClick", function(event) {
    		if(event.columnIndex == "0" && (presentnDate.length < 1) ) {
    		    if (confirm("[주의] 삭제 하시겠습니까?")) {
    		        AUIGrid.removeRow(myGridID, event.rowIndex);
    		    }
    		}
    	});
    	// 헤더 클릭 이벤트 바인딩
    	AUIGrid.bind(myGridID, "headerClick", function(event) {
    		return false; // 기본 행위 소팅하지 않음, return true 시 소팅 시킴
    	});
    	
    	// 컬럼 히든 속성 부여
        AUIGrid.hideColumnByDataField(myGridID, ["dmandSurveyNo"]); //①순번
        
        if( ${statsTyCode} != '1001'){
        	AUIGrid.hideColumnByDataField(myGridID, ["dmandSurveyVldtySecretAt"]); //⑬2020년 이후 국가정보자원관리원 대구센터 입주의향 여부
        } else {
        	        	
        }
               
    	
    	// 에디팅 시작 이벤트 바인딩
/*     	AUIGrid.bind(myGridID, "cellEditBegin", function(event) {
    		// 셀이 Anna 인 경우
    		if(event.value == "Anna" || event.item.color == "Yellow") {
    			return false
    		}
    	}); */

    	//==================================================================================================
    	// 벨리데이션 체크, 수정유무 설정
    	//==================================================================================================
    	// 에디팅 시작 이벤트 바인딩
    	AUIGrid.bind(myGridID, ["cellEditBegin"], function(event) {
    	    
    	 	// 6. 시스템 구분이 기존/신규 에 따라서 입력가능 컬럼 제한 // 신규일때 수정제한(10, 11, 12, 13, 14) 
    		if(event.dataField == "dmandSurveyBuildy" 				// 10
    		        || event.dataField == "dmandSurveyUpy" 			// 11
    		        //|| event.dataField == "dmandSurveyBuildcost" 	// 12
    		        //|| event.dataField == "dmandSurveyMaint" 		// 13
    		        //|| event.dataField == "dmandSurveyExpenses" 	// 14
    		) {
    			if(event.item.dmandSurveyDivision == "기존") { // 그룹 필드에서 선택된 값 비교
					return true;
				} else {
					return false;
				}
    		}
    	    
    	    // 11. 클라우드 이용여부가 Y/N 에 따라서 입력가능 컬럼 제한 Y(15-1, 15-2) // N(16,16-1-1, 16-1-2, 17, 18)
    	    // Y(15-1, 15-2)
/*     		if(event.dataField == "dmandSurveySeparation" 
    		        || event.dataField == "dmandSurveyIntroy") {
    			if(event.item.dmandSurveyClouduse == "Y") {
    				return true; // 15번이 y 이면 작성가능
    			} else {
    			    return false; // 15번이 n 이거나 다른 값인경우 (잘못된 값이 입력된 경우)
    			}
    		} */
    		if(event.dataField == "dmandSurveySeparation") {
			if(event.item.dmandSurveyClouduse == "Y") {
				return true; // 15번이 y 이면 작성가능
			} else {
			    return false; // 15번이 n 이거나 다른 값인경우 (잘못된 값이 입력된 경우)
			}
		}
    	    
    		// 15. 클라우드 이용여부가 Y/N 에 따라서 입력가능 컬럼 제한 Y(15-1, 15-2) // N(16,16-1-1, 16-1-2, 17, 18)
    		// 15-N인경우
    		//if(event.dataField == "dmandSurveyCnvrsPlan") {
    			//if(event.item.dmandSurveyClouduse == "N") {
    				//return true; // 15번이 N 이면 작성가능
    			//} else {
    			  //  return false; // 15번이 y 이거나 (잘못된 값이 입력된 경우) 작성불가
    			//}
    		//}
    		
    		// 15. 클라우드 이용여부가 Y/N 에 따라서 입력가능 컬럼 제한 Y(15-1, 15-2) // N(16,16-1-1, 16-1-2, 17, 18)
    		// 15-N이고, 16-2018년이거나 2019년이후 인경우
    		if(event.dataField == "dmandSurveyPlanCloudSeparation" 	// 16-1-1
    		        || event.dataField == "dmandSurveyPlanServSeparation" 	// 16-1-2
    		        || event.dataField == "dmandSurveyBudget" 				// 16-2        
    		) {
    			if(event.item.dmandSurveyCnvrsPlan == "2019년" 
    			        || event.item.dmandSurveyCnvrsPlan == "2020년부터") { // 그룹 필드에서 선택된 값 비교
					return true;
				} else {
				    return false;
				}
    		}
    		
    		// 15. 클라우드 이용여부가 Y/N 에 따라서 입력가능 컬럼 제한 Y(15-1, 15-2) // N(16,16-1-1, 16-1-2, 17, 18)
    		// 15-N이고, 16-2018년이거나 2019년이후 인경우
/*     		if(event.dataField == "dmandSurveyVldtySecretAt"
    		) {
    			if(event.item.dmandSurveyCnvrsPlan == "예정없음") { // 그룹 필드에서 선택된 값 비교
					return true;
				} else {
					return false;
				}
    		} */
    	});
    };
 	// 행 삭제
    function removeRow() {
    	AUIGrid.removeRow(myGridID, "selectedIndex");
    };
    
 	// 데이터 가져오기
    requestAjax = function() {
     	// ajax 요청 전 그리드에 로더 표시
        AUIGrid.showAjaxLoader(myGridID);
     	
 		$.ajax({
 		    async : false,
 			type: "POST",
 			url: "getDmandExaminGridData.do",
 			dataType: "json",
 			success: function(response){
 			    var gridData = JSON.parse(response);
 		        // 로더 제거
 		        AUIGrid.removeAjaxLoader(myGridID);
 		        // 그리드에 데이터 세팅
 		        AUIGrid.setGridData(myGridID, gridData);
 			}
 		});
    };
    
 	// 셀스타일 함수 정의(에디팅 안되는 것처럼 보이는 색깔 부여, 
 	// 실제 에디팅이 안되도록 하려면 AUIGrid.bind(myGridID, ["cellEditBegin"], function(event) 이벤트에 등록해야 함 )//
    function cellStyleFunction( rowIndex, columnIndex, value, headerText, item, dataField) {
 	    // 에디팅이 안되는 효과를 부여할 컬럼과 조건 표기
 	    
        if(
          (columnIndex == "12" && item.dmandSurveyClouduse != "Y")
          //||(columnIndex == "12" && item.dmandSurveyDivision != "기존")
          //||(columnIndex == "13" && item.dmandSurveyDivision != "기존")
          ||(columnIndex == "14" && item.dmandSurveyCnvrsPlan != "2019년" && item.dmandSurveyCnvrsPlan != "2020년부터")
          ||(columnIndex == "15" && item.dmandSurveyCnvrsPlan != "2019년" && item.dmandSurveyCnvrsPlan != "2020년부터")
          ||(columnIndex == "16" && item.dmandSurveyCnvrsPlan != "2019년" && item.dmandSurveyCnvrsPlan != "2020년부터")
          
          //||(columnIndex == "18" && item.dmandSurveyClouduse != "N")
          //||(columnIndex == "19" && (item.dmandSurveyCnvrsPlan != "2018년" && item.dmandSurveyCnvrsPlan != "2019년부터"))
          //||(columnIndex == "20" && (item.dmandSurveyCnvrsPlan != "2018년" && item.dmandSurveyCnvrsPlan != "2019년부터"))
          //||(columnIndex == "21" && (item.dmandSurveyCnvrsPlan != "2018년" && item.dmandSurveyCnvrsPlan != "2019년부터"))
          //||(columnIndex == "22" && item.dmandSurveyCnvrsPlan != "예정없음")
          //||(columnIndex == "23" && item.dmandSurveyCnvrsPlan != "예정없음")
          ){
            return "mycustom-disable-color";
        }
    };
    
    //===================================================================================================================
    document.write(
            "<div id=alt_div style=\"" +
            "padding:2;" +
            "border:1px solid #99aed3;" +                 // 말풍선 테두리 컬러
            "background-color:#fefefe;color:#330000;" + // 말풍선 테이블 백그라운드컬러 / 폰트컬러
        	"text-align:center;" +
        	"padding:5px 10px;" +
            "font-size:13px;" +
            "position:absolute;" +
        	"top:15px;" +
        	"left:375px;" +
            "visibility:hidden;" +
            "overflow:hidden;" +
            "z-index:auto;" +
            "width:auto;" +
            "height:auto;" +
            "filter:alpha(opacity=1);" +                // 투명도
            "\"></div>"
    );
    document.onmousemove = get_xy;
    // css
    function get_xy() {
        var _style = alt_div.style;
        var x = event.x + document.body.scrollLeft; 
        var y = event.y + document.body.scrollTop;
        _style.left = x + 10;
        _style.top = y + 10;
    }
  	//===================================================================================================================
    
    //팝업 닫기
    var jsCancel = function() {
        var item = $("#presentnDate").val();
        if(item.length < 1){
            if(confirm("수요예보조사표를 저장한 후 종료하시겠습니까?\n\n확인 버튼을 누르시면 자동으로 저장 후 창이 닫힙니다.")){
                var arrAllGridData = AUIGrid.getGridData(myGridID);
    	       	$.ajax({
    	          url: "setDmandExaminGridData.do",
    	          type: "post",
    	          dataType: "json",
    	          data: JSON.stringify(arrAllGridData),
    	          contentType: "application/json",
    	          success: function(data){
    	          },
				});
    		}
        }
        parent.$.colorbox.close();
    }
    
    </script>
</head>

<body>
<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post" >
<input type="hidden" id="presentnDate" name="presentnDate" value="${userInfo.presentnDate }" />
<input type="hidden" id="tmprSaveDate" name="tmprSaveDate" value="${userInfo.tmprSaveDate }" />
<input type="hidden" id="statsTyCode" name="statsTyCode" value="${statsTyCode}" />



<div class="btndown_Wrap">
    <table style="width:100%">
		<tbody>
			<tr style="height:70px; background-color:#4567a3;">
				<td style="font-size:24px; font-weight:600; color:#fff; padding-left:15px; line-height:27px;">
					&nbsp;&nbsp;2019년 클라우드 수요예보조사
                	<!-- 
                	<span style="font-size: 12px; color: #fff; line-height: 50%;">조사표 직접입력 및 조사표 다운로드/업로드 사용가능</span>
                	<p style="font-size: 12px; color: #fff; ">(※ EA정보시스템이 없거나 해당없음 일 경우 모든 행 삭제 후 제출버튼 선택)</p>
                     -->
                    <a href="javascript:void(0);" onclick="jsCancel()" class="btn_popclose">
                    	<img src="${imagesPath}/images/btn_popclose.png" width="11" height="11">
                    </a>
                </td>
			</tr>
		</tbody>
	</table> 
	
	<!-- 그리드 영역 -->
	<div id="grid_wrap"></div>
	
	<c:choose>
		<c:when test="${userInfo.presentnDate eq null }">
		  <!--행추가 start-->
			<!-- table style="width:100%">
				<tbody>
				  <tr style="height:30px; background-color:#f3ca02">
						<td onclick="fn_addRow()" style="cursor:Pointer; font-size:14px; color:#656565; text-align:center; padding-left:15px; border:1px solid #d0cfcf;">
		                	<img src="${imagesPath}/images/icon_addline.png" width="12" height="12" style="margin-right:5px;"><strong>행추가</strong>
		                </td>
					</tr>
				</tbody>
			</table -->
	
			<div class="clr" style="margin: 10px;">
				<a href="#none" onclick="fn_addRow()" class="btn_bs f_l" style="width:150px;background-color:#ddd;color:#000">
					<img src="${imagesPath}/images/icon_addline.png" width="12" height="12" class="ico_margin">
					<strong>행추가</strong>
				</a>
			</div>
			<div class="clr" style="margin: 10px;">
				<c:if test="${statsTyCode eq '1001' }">
					<a href="javascript:void(0);" onclick="fn_surveyDownChk(this);" class="btn_bs ds_inline f_l" style="width:150px;background-color:#7d9cac;">
						<img src="/images/ico_down_excel.png" width="15" height="15" class="ico_margin" valign="middle">
						<span>조사표 다운로드(.xls)</span>
					</a>
				</c:if>
				<c:if test="${statsTyCode ne '1001' }">	
					<a href="javascript:void(0);" onclick="fn_surveyDownChk2(this);" class="btn_bs ds_inline f_l" style="width:150px;background-color:#7d9cac;">
						<img src="/images/ico_down_excel.png" width="15" height="15" class="ico_margin" valign="middle">
						<span>조사표 다운로드(.xls)</span>
					</a>
				</c:if>		
				
				
				<div class="ds_inline input_area">
					<label for="#fileNm">수요예보조사표 업로드</label>
					<input name="fileNm" id="fileNm" type="text" readonly="readonly" placeholder="2019년 수요예보조사표 엑셀 파일만 업로드 가능합니다.">
				</div>
				<a href="javascript:void(0);" onclick="fileCheck()" class="btn_bs ds_inline f_r" style="background-color:#7d9cac">적용</a>
				<input type="file" id="dmandExaminFile" name="dmandExaminFile"  onchange="fn_fileChk();" style="display: none;" accept=".xls, .xlsx"/>
				<a href="javascript:void(0);" onclick="fn_excelFind()" class="btn_bs ds_inline f_r" style="color:#000">찾아보기</a>
			</div>
			<div class="clr" style="margin: 10px;">
				<a href="javascript:void(0);" onclick="fn_surveySubmit()" class="btn_bs ds_inline f_r" style="background-color:#03a2f6">제출</a>
				<a href="javascript:void(0);" onclick="fn_surveySave()" class="btn_bs ds_inline f_r" style="background-color:#053863">임시저장</a>
			</div>	
	
		</c:when>
    <c:otherwise>
	    <!--제출파일 다운로드 버튼 영역-->
	    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="mt15 btn_area" >
	      <colgroup>
	      	<col width="33%">
			<col width="33%">
	        <col width="33%">
	      </colgroup>
				<tr>
					<!-- <td>&nbsp;</td> -->
					<c:if test="${userInfo.presentnDate ne null }">
						<td colspan="3" style="text-align: center;">
							<h2>정상적으로 수요예보조사표 등록이 완료되었습니다. 제출 완료 후에는 제출한 파일의 수정은 불가능하며, 다운로드만 가능합니다.</h2>
						</td>
					</c:if>
					<!-- <td>&nbsp;</td> -->
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<a href="javascript:void(0);" onclick="fn_submitFile(this);" style="width: 200px;">
							<span><img src="${imagesPath}/images/icon_txtdownload.png"></span>제출파일 	다운로드
						</a>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
    </c:otherwise>
   </c:choose>
</div>

    <script>
    //====================================================
    // 버튼 함수 정리
    //====================================================
    
    // 행 추가
    fn_addRow = function() {
        var item = new Object();
    	// 순번 자동증가
    	var arrAllGridData = AUIGrid.getGridData(myGridID);
    	item.dmandSurveyNo = arrAllGridData.length+1;
    	//item.dmandSurveyHighorgname = ""; // ②상위기관명
    	//item.dmandSurveyBuildcost 	= 0; // ⑫구축비
    	//item.dmandSurveyMaint 		= 0; // ⑬당해년도 유지보수비
    	//item.dmandSurveyExpenses 	= 0; // ⑭당해년도 운영비
    	//item.dmandSurveyClouduse 	= "N"; // ⑪현 클라우드 이용여부<br />(Y/N)
        // rowPos : rowIndex 인 경우 해당 index 에 삽입, first : 최상단, last : 최하단, selectionUp : 선택된 곳 위, selectionDown : 선택된 곳 아래
    	AUIGrid.addRow(myGridID, item, "last");
    };
    // 찾아보기
    fn_excelFind = function() {
        $("#dmandExaminFile").click();
    };
    
    fn_fileChk = function(){
        var fileNm = fn_clearFilePath($("#dmandExaminFile").val()); 
    }
    
    function fn_clearFilePath(val){
        var tmpStr = val;
        
        var cnt = 0;
        while(true){
            cnt = tmpStr.indexOf("/");
            if(cnt == -1) break;
            tmpStr = tmpStr.substring(cnt+1);
        }
        while(true){
            cnt = tmpStr.indexOf("\\");
            if(cnt == -1) break;
            tmpStr = tmpStr.substring(cnt+1);
        }
        
       return document.getElementById("fileNm").value=tmpStr;
    }
    
	//엑셀 파일 업로드 타입 체크
	function fileCheck(){
	    var fname = document.getElementById("fileNm").value; //파일의 풀 경로를 fname에 변수에 저장
	    var fext = fname.substr(fname.length-4).toLowerCase(); //파일의 풀 경로에서 끝에서 3번째까지의 글자를 잘라 소문자로 변경
	    if(fext == '.xls' || fext == 'xlsx'){
	        jsDmandExaminSaveAction();
	    }else if(($("input[name=dmandExaminFile]").val() == null || $("input[name=dmandExaminFile]").val() == "")  && $("input[name=dmandExaminFile]").val() == ""){
	        alert("먼저 수요예보조사표를 등록하셔야 적용이 가능합니다.");
			document.getElementById("dmandExaminFile").focus();
			return false;
	    }else{
	       alert("2018년 수요예보조사표 엑셀 파일만 업로드 가능합니다.");
	       return true;
	    }
	 }

 	// 적용버튼 클릭
	var jsDmandExaminSaveAction = function(vl) {
 		
 		var statsTyCode = $("#statsTyCode").val();
//alert(statsTyCode); 		
	    var item = $("#tmprSaveDate").val();

	    if(statsTyCode == 1001){
	    	//alert("1");
		    if(item.length > 0){
		        if(confirm("파일을 새로 등록하시면 현재 저장되어있는 내용은 삭제됩니다.\n\n등록하시겠습니까?")){
		            $("#dataForm").attr("action", "BD_dmandExaminSaveAction.do");
					$("#dataForm").submit();
     			}
		    } else {
				if(confirm("적용 하시겠습니까?")){
			    	$("#dataForm").attr("action", "BD_dmandExaminSaveAction.do");
					$("#dataForm").submit();
				} 
	    	}
	    } else {
		    //alert("2");
		    if(item.length > 0){
		        if(confirm("파일을 새로 등록하시면 현재 저장되어있는 내용은 삭제됩니다.\n\n등록하시겠습니까?")){
		            $("#dataForm").attr("action", "BD_dmandExaminSaveAction1.do");
					$("#dataForm").submit();
     			}
		    } else {
				if(confirm("적용 하시겠습니까?")){
			    	$("#dataForm").attr("action", "BD_dmandExaminSaveAction1.do");
					$("#dataForm").submit();
				} 
	    	}		    
	    }
	};
	
 	// 조사표 다운로드
    fn_surveyDownChk = function(el) {
        $('.cboxElement').removeClass('cboxElement');
	    $(el).colorbox({
            title : "조사표 다운로드",
            href : "PD_searchDmandExaminSurveyPop.do",
            width : 700,
            height : 300,
            overlayClose : false,
            escKey : false,
            iframe : true,
            fixed : true
        });
    };
 	// 조사표 다운로드
    fn_surveyDownChk2 = function(el) {
        $('.cboxElement').removeClass('cboxElement');
	    $(el).colorbox({
            title : "조사표 다운로드",
            href : "PD_searchDmandExaminSurveyPop2.do",
            width : 700,
            height : 300,
            overlayClose : false,
            escKey : false,
            iframe : true,
            fixed : true
        });
    };
    
 	// 임시저장버튼
    fn_surveySave = function(){
 		
 		var statsTyCode = $("#statsTyCode").val();
 		//alert(statsTyCode); 		
 		
        // 그리드 데이터 가져오기
        if(confirm("수요에보조사표를 임시 저장하시겠습니까?")){
	        var arrAllGridData = AUIGrid.getGridData(myGridID);
	       	if(statsTyCode == 1001){
	       		//alert("1 : " + statsTyCode);	       		
		        $.ajax({
		          url: "setDmandExaminGridData.do",
		          type: "post",
		          dataType: "json",
		          data: JSON.stringify(arrAllGridData),
		          contentType: "application/json",
		          success: function(data){
		              alert("저장 되었습니다.");
		              /* requestAjax(); */
		              self.location.reload();
		          },
		          error:function(){
		              alert("\n현재 조회가 원활하지 않습니다.\n다시 시도하여 주십시오.");
		          }
				});
	       	} else {
	       		//alert("2 : " + statsTyCode);
		        $.ajax({
			          url: "setDmandExaminGridData1.do",
			          type: "post",
			          dataType: "json",
			          data: JSON.stringify(arrAllGridData),
			          contentType: "application/json",
			          success: function(data){
			              alert("저장 되었습니다.");
			              /* requestAjax(); */
			              self.location.reload();
			          },
			          error:function(){
			              alert("\n현재 조회가 원활하지 않습니다.\n다시 시도하여 주십시오.");
			          }
					});
	       		
	       	}
	        
		}
    }
    
 	// 제출
    fn_surveySubmit = function() {
 		var statsTyCode = $("#statsTyCode").val();
 		//alert(statsTyCode); 		
 		 		
//		if(confirm("'제출'은 수요예보조사를 완료하고 완성된 문서를 발송하는 것입니다.\n수요예보조사표를 제출한 뒤에는 수정이 불가능합니다.\n제출 후 수정이 반드시 필요한 경우 관리팀에 문의하세요.\n\n제출하시겠습니까?")){
		if(confirm("수요예보조사표를 제출한 뒤에는 수정이 불가능합니다.\n제출한 후 수정이 필요한 경우 고객센터로 문의하세요 \n\n제출하시겠습니까?")){			
		 	// 제출전 벨리데이션 추가(1. 필수값 체크, 2. 유효성검사)
	 	   	if(!fn_isVerification("submit"))
	 	   	    return;
		 
	        var arrAllGridData = AUIGrid.getGridData(myGridID);
	     
	       	if(statsTyCode == 1001){
		        $.ajax({
		           url: "submitInfo.do",
		           type: "post",
		           dataType: "json",
		           data: JSON.stringify(arrAllGridData),
		           contentType: "application/json",
		           success: function(data){
		               alert("제출 되었습니다.");
		               self.location.reload();
		           },
		           error:function(){
		               alert("현재 조회가 원활하지 않습니다.\n다시 시도하여 주십시오.");
		           }
		        });
	       	} else {
		        $.ajax({
			           url: "submitInfo1.do",
			           type: "post",
			           dataType: "json",
			           data: JSON.stringify(arrAllGridData),
			           contentType: "application/json",
			           success: function(data){
			               alert("제출 되었습니다.");
			               self.location.reload();
			           },
			           error:function(){
			               alert("현재 조회가 원활하지 않습니다.\n다시 시도하여 주십시오.");
			           }
			        });
	       		
	       	} 
	  
	        
	    } 
    };
    
    // 제출 파일 다운로드
    fn_submitFile = function(){
        $("#dataForm").attr("action","ND_dmandExaminDownloadAction.do");
        $("#dataForm").submit();
        
    };
    
  	//====================================================================
    // 벨리데이션 체크 
    //====================================================================
  	// 필수값 체크

  	if( ${statsTyCode} == '1001'){
  	
	  	var arrDblNotNullColumn = [
	            ["dmandSurveySysname"			,"③시스템명"]
	            ,["dmandSurveySysobj"			,"④시스템목적"]
	            ,["dmandSurveyDivision"			,"⑤시스템구분"]
	            ,["dmandSurveyManager"			,"⑥담당자"]
	            ,["dmandSurveyClouduse"			,"⑪현 클라우드 이용여부"]
	            ,["dmandSurveyCnvrsPlan"		,"⑫클라우드 전환 또는 도입예정"]
	            ,["dmandSurveyVldtySecretAt"	,"⑬2020년 이후 국가정보자원관리원 대구센터 입주의향 여부"]
	  	];
	  	// 유효성 체크
	  	var arrThiValidationColumn = [
	  		["dmandSurveyOrgname"				,"②기관명"             	    							,"200"		]
	  		,["dmandSurveySysname"				,"③시스템명"            	    							,"200"		]
	  		,["dmandSurveySysobj"				,"④시스템목적"           									,"2000"		]
	  		,["dmandSurveyDivision"				,"⑤시스템구분"           									,"200"		]
	  		,["dmandSurveyManager"				,"⑥담당자"             	    							,"50"		]
	  		,["dmandSurveyMail"					,"⑦이메일"             	    							,"100"		]
	  		,["dmandSurveyPhone"					,"⑧유선번호"            	    			 			,"50"		]
	  		,["dmandSurveyBuildy"				,"⑨구축년도"            	    							,"4"		]
	  		,["dmandSurveyUpy"					,"⑩최근업그레이드년도"      								,"4"		]
	  		,["dmandSurveyClouduse"				,"⑪현 클라우드 이용여부"      								,"1"		]
	  		,["dmandSurveySeparation"			,"⑪-1)클라우드구분"          								,"50"		]
	  		,["dmandSurveyCnvrsPlan"				,"⑫클라우드 전환 또는 도입예정"						,"50"		]
	  		,["dmandSurveyPlanCloudSeparation"	,"⑫-1)클라우드 도입 예정시 클라우드 구분"					,"50"		]
	  		,["dmandSurveyPlanServSeparation"	,"⑫-1)클라우드 도입 예정시 서비스 구분" 					,"20"		]
	  		,["dmandSurveyBudget"				,"⑫-2)클라우드 예산"		        						,"20"		]
	  		,["dmandSurveyVldtySecretAt"			,"⑬2020년 이후 국가정보자원관리원 대구센터 입주의향 여부"	,"1"		]
	  	];
  	} else {
	  	var arrDblNotNullColumn = [
            ["dmandSurveySysname"			,"③시스템명"]
            ,["dmandSurveySysobj"			,"④시스템목적"]
            ,["dmandSurveyDivision"			,"⑤시스템구분"]
            ,["dmandSurveyManager"			,"⑥담당자"]
            ,["dmandSurveyClouduse"			,"⑪현 클라우드 이용여부"]
            ,["dmandSurveyCnvrsPlan"		,"⑫클라우드 전환 또는 도입예정"]
  	];
  	// 유효성 체크
  	var arrThiValidationColumn = [
  		["dmandSurveyOrgname"				,"②기관명"             	    							,"200"		]
  		,["dmandSurveySysname"				,"③시스템명"            	    							,"200"		]
  		,["dmandSurveySysobj"				,"④시스템목적"           									,"2000"		]
  		,["dmandSurveyDivision"				,"⑤시스템구분"           									,"200"		]
  		,["dmandSurveyManager"				,"⑥담당자"             	    							,"50"		]
  		,["dmandSurveyMail"					,"⑦이메일"             	    							,"100"		]
  		,["dmandSurveyPhone"					,"⑧유선번호"            	    			 			,"50"		]
  		,["dmandSurveyBuildy"				,"⑨구축년도"            	    							,"4"		]
  		,["dmandSurveyUpy"					,"⑩최근업그레이드년도"      								,"4"		]
  		,["dmandSurveyClouduse"				,"⑪현 클라우드 이용여부"      								,"1"		]
  		,["dmandSurveySeparation"			,"⑪-1)클라우드구분"          								,"50"		]
  		,["dmandSurveyCnvrsPlan"				,"⑫클라우드 전환 또는 도입예정"						,"50"		]
  		,["dmandSurveyPlanCloudSeparation"	,"⑫-1)클라우드 도입 예정시 클라우드 구분"					,"50"		]
  		,["dmandSurveyPlanServSeparation"	,"⑫-1)클라우드 도입 예정시 서비스 구분" 					,"20"		]
  		,["dmandSurveyBudget"				,"⑫-2)클라우드 예산"		        						,"20"		]
  	];  		
  	}
  	// 값이 올바르게 작성되었는지 확인하는 함수
  	// 모든 값이 올바르게 입력된 경우 true, 1개이상 올바르지 않은 값이 있으면 false
    fn_isVerification = function(strSaveType) {
        // 각 부분을 나누어서 정리
        var resultValue = true;
        
        var arrAllGridData = AUIGrid.getGridData(myGridID);
        
     	// 사용자가 그리드에 시스템 정보가 없음을 등록하는 경우 벨리데이션 체크가 필요하지 않음 
        if(arrAllGridData == null || arrAllGridData.length == 0){
            // 저장하는 경우 일단 저장가능
            
            if(strSaveType =="save"){
                return true;
            } else if(strSaveType == "submit") {
                if(confirm("수요예보조사표에 적용할 내용이 없습니다. \n\n도입예정없음으로 제출하시겠습니까?")){
                    return true;
                } else {
                    return false;
                }
            } else {
                return false; // 어떤유형인지 알 수 없을 경우 항상 
            } 
        }
     	
     	// 필수값 체크 2~9, 15 값이 있는지 유무 확인
        var strErrorNull 		= ""; // 필수값 체크
        var strErrorValidation 	= ""; // 유효성 체크
        
        // 그리드에 기록된 행 수 가져오기
        var maxLength = arrAllGridData.length;
        
        // 벨리데이션 체크(1. 필수값 체크)

        for(var i=0; i < arrDblNotNullColumn.length; i++){
        	        	
            strErrorNull = strErrorNull + fn_notNull(maxLength, arrDblNotNullColumn[i][0], arrDblNotNullColumn[i][1]);
        }
        
        if(strErrorNull) {
            //var errMsg = "1) ② ~ ⑨, ⑮번 항목은 필수입력항목입니다.\n   아래 항목을 확인해 주세요.";
            //strErrorNull = errMsg+"\n"+strErrorNull;
            
            strErrorNull = strErrorNull + "항목은 필수입력항목입니다.";
            
        } 
        
     	// 벨리데이션 체크(2. 유효성 체크 - 콤보박스 또는 다른 컬럼에 영향을 받는 값 등) 
        //strErrorValidation = fn_checkValidation();
     	strErrorValidation = fn_checkValidation2();
     	
        if(strErrorValidation) {
            var errMsg = "2) 정보를 잘못 입력한 항목입니다. \n   다시 한번 확인해 주세요.";
            strErrorValidation = errMsg+"\n"+strErrorValidation;
        }
        
        if((strErrorNull) || (strErrorValidation)) {
            if(strErrorNull && strErrorValidation) {
                strErrorNull = strErrorNull + "\n\n";
            }
            alert(strErrorNull+strErrorValidation);
            resultValue = false;
        }
        
        return resultValue;
    }
    
    // 벨리데이션 체크(1. 필수값 체크) 존재유무 체크 및 에러 메세지 작성(에러가있으면 텍스트가 입력되어 리턴, 정상적이면 공백리턴)
    fn_notNull = function(maxLength, strColumn, strColumnTxt) {
        var resultValue = false;
        var arrAllGridData = AUIGrid.getGridData(myGridID);
        var strErrorNull ="";
        
        for(var i=0; i < maxLength; i++) {
            var value = arrAllGridData[i][strColumn];
            // 혹시있을 예외상황 대처 trim 
            if(value){
                value = value.trim();
            }
            
            var isNull = fn_isNull(value);
            if(isNull) {
                var resultValue = true;
                if(strErrorNull == "") {
                    var ipluse = i+1;
                    strErrorNull = ipluse+"행";   
                } else {
                    var ipluse = i+1;
                    strErrorNull = strErrorNull + ", " + ipluse + "행";
                }
            }
        }
        
        if(resultValue){
            var errMsg = strColumnTxt+" : " + strErrorNull + "\n";
            return errMsg;
        } else {
            return "";
        }
        
    };
    
    // 벨리데이션 체크(1. 필수값 체크) 값이 있는지 없는지 체크하는 함수(널이면:true, 널이 아니면:false)
    fn_isNull = function(strValue) {
        if( strValue == "" 
                || strValue == null 
                || strValue == undefined 
                || ( strValue != null 
                        && typeof strValue 
                        == "object" 
                        && !Object.keys(strValue).length )) { 
            return true; 
		} else { 
		    return false; 
		}
    };
    
    fn_checkValidation2 = function() {
        // 그리드위에 그려진 모든 데이터 가져오기
        var arrAllGridData = AUIGrid.getGridData(myGridID);
        
    	//======================================================================
        // 항목별 검사 함수
        //======================================================================
        var errMsg03_0_0 = fn_getVerifiOrgname             	("dmandSurveyOrgname"				, arrAllGridData);
        var errMsg04_0_0 = fn_getVerifiSysname             	("dmandSurveySysname"				, arrAllGridData);
        var errMsg05_0_0 = fn_getVerifiSysobj              	("dmandSurveySysobj"				, arrAllGridData);
        var errMsg06_0_0 = fn_getVerifiDivision            	("dmandSurveyDivision"				, arrAllGridData);
        var errMsg07_0_0 = fn_getVerifiManager             	("dmandSurveyManager"				, arrAllGridData);
        var errMsg08_0_0 = fn_getVerifiMail                	("dmandSurveyMail"					, arrAllGridData);
        var errMsg09_0_0 = fn_getVerifiPhone               	("dmandSurveyPhone"					, arrAllGridData);
//        var errMsg10_0_0 = fn_getVerifiBuildy              	("dmandSurveyBuildy"				, arrAllGridData);
        var errMsg11_0_0 = fn_getVerifiUpy                 	("dmandSurveyUpy"					, arrAllGridData);
        var errMsg15_0_0 = fn_getVerifiClouduse            	("dmandSurveyClouduse"				, arrAllGridData);
        var errMsg15_1_0 = fn_getVerifiSeparation          	("dmandSurveySeparation"			, arrAllGridData);
        var errMsg16_0_0 = fn_getVerifiCnvrsPlan           	("dmandSurveyCnvrsPlan"				, arrAllGridData);
        var errMsg16_1_1 = fn_getVerifiPlanCloudSeparation 	("dmandSurveyPlanCloudSeparation"	, arrAllGridData);
        var errMsg16_1_2 = fn_getVerifiPlanServSeparation  	("dmandSurveyPlanServSeparation"	, arrAllGridData);
        var errMsg16_2_0 = fn_getVerifiBudget              	("dmandSurveyBudget"				, arrAllGridData);
        //var errMsg17_0_0 = fn_getVerifiVldtySecret_at      	("dmandSurveyVldtySecretAt"		, arrAllGridData);
        
        var errMsg = errMsg03_0_0+ errMsg04_0_0+ errMsg05_0_0+ errMsg06_0_0+        
					 errMsg07_0_0+ errMsg08_0_0+ errMsg09_0_0 
					 errMsg11_0_0+ errMsg15_0_0+ errMsg15_1_0+ errMsg16_0_0+ 
					 errMsg16_1_1+ errMsg16_1_2+ errMsg16_2_0
        return errMsg;
    }

    // ②기관명
    fn_getVerifiOrgname             = function(columnName, arrAllGridData){
        var strErrorValidation ="";
 	    return strErrorValidation;
    };
    // ③시스템명
    fn_getVerifiSysname             = function(columnName, arrAllGridData){
        var strErrorValidation ="";
 	    return strErrorValidation;
    };
    // ④시스템목적
    fn_getVerifiSysobj              = function(columnName, arrAllGridData){
        var strErrorValidation ="";
 	    return strErrorValidation;
    };
    // ⑤시스템구분
    fn_getVerifiDivision            = function(columnName, arrAllGridData){
     	// 6번 컬럼 체크
     	var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
            var value = arrAllGridData[j][columnName]; // 15번 항목 값 가져오기
            if(value == "기존" || value == "신규"){
                //정상
            } else {
                //비정상
                resultValue = true;
                if(strErrorValidation == "") {
                    var ipluse = j+1;
                    strErrorValidation = ipluse+"행";   
                } else {
                    var ipluse = j+1;
                    strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                }
            }
        }
        if(strErrorValidation){
        	strErrorValidation = "⑤시스템구분 : " + strErrorValidation + "\n";
        }
        return strErrorValidation;
    };
    // ⑥담당자
    fn_getVerifiManager             = function(columnName, arrAllGridData){
        var strErrorValidation ="";
 	    return strErrorValidation;
    };
    // ⑦이메일
    fn_getVerifiMail                = function(columnName, arrAllGridData){
        var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
	        var value = arrAllGridData[j][columnName]; // 9번 항목 값 가져오기
	        //alert(value);
	        if(fn_isNull(value)){
	         	// 값이 없으면 에러
	            //strErrorValidation = errMakeText(strErrorValidation,j);
	        } else if (isEmailValidation(value)){
	            // 유선번호 표기식 숫자면 true
	            // 성공
	        } else {
	            // 정규식에 맞지 않으면 false
	            //strErrorValidation = errMakeText(strErrorValidation,j);
	        }
        }
        if(strErrorValidation) {
            strErrorValidation = "⑦이메일 : " + strErrorValidation + "\n";
        }
 	    return strErrorValidation;
    };
    // ⑧유선번호
    fn_getVerifiPhone               = function(columnName, arrAllGridData){
        var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
	        var value = arrAllGridData[j][columnName]; // 9번 항목 값 가져오기
	        if(fn_isNull(value)){
	         	// 숫자가 아니면 false
	            //strErrorValidation = errMakeText(strErrorValidation,j);
	        } else if (isNumValidation(value, "dash")){
	            // 유선번호 표기식 숫자면 true
	            // 성공
	        } else {
	            // 숫자가 아니면 false
	            //strErrorValidation = errMakeText(strErrorValidation,j);
	        }
        }
        if(strErrorValidation) {
            strErrorValidation = "⑧유선번호 : " + strErrorValidation + "\n";
        }
 	    return strErrorValidation;
    };
    // ⑨구축년도
    fn_getVerifiBuildy              = function(columnName, arrAllGridData){
        var strErrorValidation ="";
        
        for(var j=0; j < arrAllGridData.length; j++) {
	        var value = arrAllGridData[j][columnName]; // 9번 항목 값 가져오기
	        
	        // 선행 제약조건 컬럼의 값 유무에 따라 벨리데이션 체크
	        if(fn_isNull(arrAllGridData[j]["dmandSurveyDivision"])) {
	            strErrorValidation = errMakeText(strErrorValidation,j);
	            continue;
	        } else if(arrAllGridData[j]["dmandSurveyDivision"] == "신규") {
	            // 벨리데이션 검사 하지 않고 패스
	            continue;
	        }
	        
	        // 벨리데이션 체크
	        if(fn_isNull(value)){
	         	// 숫자가 아니면 false
	            strErrorValidation = errMakeText(strErrorValidation,j);
	        } else if (isNumValidation(value, "onlyNum")){
	            // 유선번호 표기식 숫자면 true
	            // 성공
	            if(value > 2018){
	             	// 숫자가 아니면 false
		            strErrorValidation = errMakeText(strErrorValidation,j);
	            }
	        } else {
	         	// 숫자가 아니면 false
	            strErrorValidation = errMakeText(strErrorValidation,j);
	        }
        }
        
        if(strErrorValidation) {
            strErrorValidation = "⑨구축년도 : " + strErrorValidation + "\n";
        }
        return strErrorValidation;
    };
    // ⑩최근업그레이드년도
    fn_getVerifiUpy                 = function(columnName, arrAllGridData){
        var strErrorValidation ="";
        return strErrorValidation;
    };
   
    // ⑪현 클라우드 이용여부
    fn_getVerifiClouduse            = function(columnName, arrAllGridData){
     	// 11번 클라우드 이용여부 벨리데이션 체크
     	var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
            var value = arrAllGridData[j][columnName]; // 11번 항목 값 가져오기
            if(value == "Y" || value == "N"){

                //정상
            } else {
                //비정상
                resultValue = true;
                if(strErrorValidation == "") {
                    var ipluse = j+1;
                    strErrorValidation = ipluse+"행";   
                } else {
                    var ipluse = j+1;
                    strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                }
            }
        }
        if(strErrorValidation){
        	strErrorValidation = "⑪현 클라우드 이용여부 : " + strErrorValidation + "\n";
        }
        return strErrorValidation;
    };
    // ⑪-1)클라우드구분
    fn_getVerifiSeparation          = function(columnName, arrAllGridData){

    	var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
            var value 		= arrAllGridData[j]["dmandSurveyClouduse"]; // 11번 항목 값 가져오기
            var realValue 	= arrAllGridData[j][columnName]; // 15-1번 항목 값 가져오기
            if(value == "Y"){
                // 15번이 Y일때,,,
                if(realValue == "민간" || realValue == "자체" || realValue == "국가정보자원관리원") {
                    // 정상
                } else {
                    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    }
                }
                
            } else if(value == "N") {
                // 원래는 0이어야 하나, 
            } else {
                // 값이 없어야함
                if(fn_isNull(realValue)){
                    // 정상값
                } else {
                    // 값이 없어야 하는데 값이 있는 경우임
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    }
                }
                // 셀에 값을 강제로 널로 변경
            }
        }
     	
        if(strErrorValidation){
        	strErrorValidation = "⑪-1)클라우드 구분 : " + strErrorValidation + "\n";
        }
        return strErrorValidation;
	};

    // ⑫클라우드 전환 또는 도입예정
    fn_getVerifiCnvrsPlan           = function(columnName, arrAllGridData){
        var strErrorValidation ="";

        for(var j=0; j < arrAllGridData.length; j++) {
            var value 		= arrAllGridData[j]["dmandSurveyClouduse"]; // 15번 항목 값 가져오기
            var realValue 	= arrAllGridData[j][columnName]; // 16번 항목 값 가져오기
            if(value == "Y"){
                // 15번이 Y일때,,,
                if(fn_isNull(realValue)){
                    // 정상
                } else if(realValue.length < 2) {
                    // 정상 *널값일때 1이 찍히는 경우가 발생되어 2로 체크
                } else {
                    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    }
                }
                
            } else if(value == "N") {

                if(realValue == "2019년" || realValue == "2020년부터" || realValue == "예정없음") {
                    // 정상
                } else {

                	resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    } 
                }
            } else {
                // 값이 없어야함
                if(fn_isNull(realValue)){
                    // 정상값
                } else {
                    // 값이 없어야 하는데 값이 있는 경우임
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    }
                }
                // 셀에 값을 강제로 널로 변경
            }
        }
     	
        if(strErrorValidation){
        	strErrorValidation = "⑫클라우드 전환 또는 도입예정 : " + strErrorValidation + "\n";
        }
        
        return strErrorValidation;        
    };
    // ⑫-1) 클라우드 도입 예정시 클라우드 구분
    fn_getVerifiPlanCloudSeparation = function(columnName, arrAllGridData){
     	var strErrorValidation ="";

        for(var j=0; j < arrAllGridData.length; j++) {
            var seqValue 	= arrAllGridData[j]["dmandSurveyCnvrsPlan"];
            var realValue 	= arrAllGridData[j]["dmandSurveyPlanCloudSeparation"];

            if(seqValue == "2019년" || seqValue == "2020년부터") {

                // 값이 있어야 정상
                if(realValue == "민간" || realValue == "자체" || realValue == "국가정보자원관리원") {
                	// 정상
            	} else {
            	    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    } 
            	}
            } else if(seqValue == "예정없음") {
                // NULL이어야 정상
                if(fn_isNull(realValue)) {
                    // 정상
                } else if (realValue.length < 2) {
                    // 정상
                } else {
                    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    } 
                }
                
            } else {
             	// 비정상
                resultValue = true;
                if(strErrorValidation == "") {
                    var ipluse = j+1;
                    strErrorValidation = ipluse+"행";   
                } else {
                    var ipluse = j+1;
                    strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                } 
            }            
        }
     	
        if(strErrorValidation){
        	strErrorValidation = "⑫-1) 클라우드 도입 예정시 클라우드 구분 : " + strErrorValidation + "\n";
        }
        
        return strErrorValidation;
    };
    // ⑫-1)클라우드 도입 예정시 서비스 구분
    fn_getVerifiPlanServSeparation  = function(columnName, arrAllGridData){

    	var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
            var value 		= arrAllGridData[j]["dmandSurveyClouduse"];
            var seqValue 	= arrAllGridData[j]["dmandSurveyCnvrsPlan"];
            var realValue 	= arrAllGridData[j][columnName];
            if(value == "Y"){
                // 15번이 Y일때,,,
                if(fn_isNull(realValue)){
                    // 정상
                } else if(realValue.length < 2) {
                    // 정상 *널값일때 1이 찍히는 경우가 발생되어 2로 체크
                } else {
                    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    }
                }
                
            } else if(value == "N") {

                if(seqValue == "2019년" || seqValue == "2020년부터") {
                    // 값이 있어야 정상
                    if(realValue == "SaaS" 
                            || realValue == "PaaS" 
                            || realValue == "IaaS" 
                            || realValue == "IaaS+SaaS" 
                            || realValue == "IaaS+PaaS" 
                            || realValue == "PaaS+SaaS" 
                            || realValue == "IaaS+PaaS+SaaS") {
                    	// 정상
                	} else {
                	    // 비정상
                        resultValue = true;
                        if(strErrorValidation == "") {
                            var ipluse = j+1;
                            strErrorValidation = ipluse+"행";   
                        } else {
                            var ipluse = j+1;
                            strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                        } 
                	}
                } else if(seqValue == "예정없음") {
                    // NULL이어야 정상
                    if(fn_isNull(realValue)) {
                        // 정상
                    } else if (realValue.length < 2) {
                        // 정상
                    } else {
                        // 비정상
                        resultValue = true;
                        if(strErrorValidation == "") {
                            var ipluse = j+1;
                            strErrorValidation = ipluse+"행";   
                        } else {
                            var ipluse = j+1;
                            strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                        } 
                    }
                    
                } else {

                	resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    } 
                }
            } else {
                // 값이 없어야함
                if(fn_isNull(realValue)){
                    // 정상값
                } else if(realValue.length < 2) {
                    // 정상 *널값일때 1이 찍히는 경우가 발생되어 2로 체크
                } else {
                    // 값이 없어야 하는데 값이 있는 경우임
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    }
                }
                // 셀에 값을 강제로 널로 변경
            }
        }
     	
        if(strErrorValidation){
        	strErrorValidation = "⑫-1) 클라우드 도입 예정시 서비스 구분 : " + strErrorValidation + "\n";
        }
        return strErrorValidation;
        
    };
    // ⑫-2)클라우드 예산
    fn_getVerifiBudget              = function(columnName, arrAllGridData){
        var strErrorValidation ="";
        for(var j=0; j < arrAllGridData.length; j++) {
	        var value = arrAllGridData[j][columnName]; // 10번 항목 값 가져오기
	     	// 필수값유무, 필수가 아닌경우 추가, 필수면 해당 조건문 제거
	        if(fn_isNull(value)){
	            continue;
	        }
	        if(isNumValidation(value, "onlyNum")){
	            // 숫자면 true
	        } else {
	            // 숫자가 아니면 false
                if(strErrorValidation == "") {
                    var ipluse = j+1;
                    strErrorValidation = ipluse+"행";   
                } else {
                    var ipluse = j+1;
                    strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                }
	        }
        }
        if(strErrorValidation) {
            strErrorValidation = "⑫-2)클라우드 예산 : " + strErrorValidation + "\n";
        }
        return strErrorValidation;
    };
    // ⑬2020년 이후 국가정보자원관리원 대구센터 입주의향 여부
    fn_getVerifiVldtySecret_at      = function(columnName, arrAllGridData){
        var strErrorValidation ="";

        for(var j=0; j < arrAllGridData.length; j++) {
            var value 		= arrAllGridData[j]["dmandSurveyClouduse"];
            var seqValue 	= arrAllGridData[j]["dmandSurveyCnvrsPlan"];
            //var realValue 	= arrAllGridData[j]["dmandSurveyVldtySecretAt"]; // 17번 항목 값 가져오기
            if(seqValue == "2019년" || seqValue == "2020년부터") {
                // NULL이어야 정상
                if(fn_isNull(realValue)) {
                    // 정상
                } else if (realValue.length < 2) {
                    // 정상
                } else {
                    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    } 
                }
            } else if(seqValue == "예정없음") {
             	// 값이 있어야 정상
                if(realValue == "비밀" || realValue == "비공개" || realValue == "기타") {
                	// 정상
            	} else {
            	    // 비정상
                    resultValue = true;
                    if(strErrorValidation == "") {
                        var ipluse = j+1;
                        strErrorValidation = ipluse+"행";   
                    } else {
                        var ipluse = j+1;
                        strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                    } 
            	}
            } else {

                resultValue = true;
                if(strErrorValidation == "") {
                    var ipluse = j+1;
                    strErrorValidation = ipluse+"행";   
                } else {
                    var ipluse = j+1;
                    strErrorValidation = strErrorValidation + ", " + ipluse + "행";
                } 
            }
        }
     	
        if(strErrorValidation){
        	strErrorValidation = "⑰비밀여부 : " + strErrorValidation + "\n";
        }
 	    return strErrorValidation;
    };
    
    // 숫자 10진수 체크 함수
    function isNumeric(num, opt){
		// 좌우 trim(공백제거)을 해준다.
		num = String(num).replace(/^\s+|\s+$/g, "");
		
		if(opt == "yyyy") {
		    // 년도표기 4자리 숫자만
		    var regex = /^[1-9][0-9]{3}$/g;
		} else if(opt == "tel") {
		    // 유선번호 체크 로직
		    var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
		} else {
		 	// 금액표기, (+-)부호 미사용, 자릿수 선택, 소수점 미사용
		    var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}$/g;
		}
		
		if( regex.test(num) ){
			num = num.replace(/,/g, "");
			return isNaN(num) ? false : true;
		} else { return false;  }
    }
    
    // 숫자관련 벨리데이션
    function isNumValidation(num, opt){
     	var returnValue = false;
        // 숫자만 입력받음
        if(opt == "onlyNum"){
            returnValue = isOnlyNumber(num);
        } else if(opt == "comma"){
            returnValue = isNumComma(num);
        } else if(opt == "dash"){
            returnValue = isNumDash(num);
        } else if(opt == "tel"){
            returnValue = isValidPhone(num);
        } else if(opt == "yyyy") {
            if(isOnlyNumber(num)) {
                if(num<2018){
                    returnValue = true;
                }
            }
        }
        // 올바른 형식이면 true, 아니면 false
        return returnValue;
    }
    
    // 이메일 벨리데이션
    function isEmailValidation(input){
        var returnValue = false;
        returnValue = isEmailcheck(input);
        return returnValue;
    }
    
    /**    * 입력값에 숫자만 있는지 체크    */
    function isOnlyNumber(input) {
        var chars = "0123456789";
        return containsCharsOnly(input,chars);
    }
    
    /**    * 입력값이 숫자,대시(-)로 되어있는지 체크    */
    function isNumDash(input) {
        var chars = "-0123456789";
        return containsCharsOnly(input,chars);
    }
    
    /**    * 입력값이 숫자,콤마(,)로 되어있는지 체크    */
    function isNumComma(input) {
        var chars = ",0123456789";
        return containsCharsOnly(input,chars);
    }
    
    /**    * 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크    */
    function isValidPhone(input) {
        var format = /^(\d+)-(\d+)-(\d+)$/;
        return isValidFormat(input,format);
    }
    
    /** 	* 이메일 형식 체크 문자 @ 문자 . 문자) 				*/
    function isEmailcheck(input) {
        var format = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
        if(format.test(input)) {
            return true;
        }
        return false;
    }
    
    /**    * 입력값이 사용자가 정의한 포맷 형식인지 체크
    * 자세한 format 형식은 자바스크립트의 `regular expression`을 참조    */
    function isValidFormat(input,format) {
        if (input.value.search(format) != -1) {
            return true; //올바른 포맷 형식
        }
        return false;
    }
    
    /**
    * 입력값이 특정 문자(chars)만으로 되어있는지 체크
    * 특정 문자만 허용하려 할 때 사용
    * ex) if (!containsCharsOnly(form.blood,"ABO")) {
    *         alert("혈액형 필드에는 A,B,O 문자만 사용할 수 있습니다.");
    *     }
    */
    function containsCharsOnly(input,chars) {
        for (var inx = 0; inx < input.length; inx++) {
           if (chars.indexOf(input.charAt(inx)) == -1)
               return false;
        }
        return true;
    }
    
    
    // 에러메세지 만들기 함수(행누적용)
    function errMakeText(strErrorValidation, j){
     	// 숫자가 아니면 false
        if(strErrorValidation == "") {
            var ipluse = j+1;
            strErrorValidation = ipluse+"행";   
        } else {
            var ipluse = j+1;
            strErrorValidation = strErrorValidation + ", " + ipluse + "행";
        }
        return strErrorValidation;
    }
    
    String.prototype.trim = function() {
        return this.replace(/(^\s*)|(\s*$)/gi, "");
    }
    
    </script>
    </form>
</body>
</html>
