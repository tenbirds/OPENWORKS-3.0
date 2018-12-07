<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>코드 선택</title>
	<%-- <op:jsTag type="openworks" items="web-core"/> --%>
    
    <script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/component/javascript/MD_globalConfig.do"></script>
    
    <script type="text/javascript" src="${contextPath}/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="${contextPath}/component/javascript/MD_massageConfig.do"></script>
    <op:jsTag type="spi" items="form,validate,extjs" />
    
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" /> 
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    
    <script type="text/javascript">    
    //<![CDATA[
	// 	    $( window ).load(function() {
	// 	        var height = $("#pop_wrap").height() + 70;
	//             var width = $("#pop_wrap").width() + 70;
	// 	        parent.$.fn.colorbox.resize({height:height+"px", width:width+"px"});
	
	// // 	        parent.$.fn.colorbox.resize({width:width+"px"})
	// 	    });

        var jsSelect = function(grpCd) 
        {
            switch(grpCd) 
            {
                case '1015' : 
                      $("input[type=radio]:checked").each(function() {
                          if ($("#goodsLicenceCn"+this.value).val() == '' && this.value != '1009') {
                              alert("선택항목의 내용을 입력해 주십시오.");
                              $("#goodsLicenceCn"+this.value).focus();
                              return false;
                          }
                          parent.$("#goodsLicenceCd").val(this.value);
                          if (this.value != '1009') {
                              parent.$("#goodsLicenceCn").val($("#goodsLicenceCn"+this.value).val());
                          } else if (this.value == '1009') {
                              parent.$("#goodsLicenceCn").val('');
                          }
                          if (this.value != '1008') {
                              parent.$("#goodsLicenceNm").text(parent.$("#goodsLicenceCn").val() + $("#goodsLicenceNm"+this.value).text());
                          } else if (this.value == '1008'){
                              parent.$("#goodsLicenceNm").text($("#goodsLicenceNm"+this.value).text() + ' ' + parent.$("#goodsLicenceCn").val());
                          }
                          parent.$.fn.colorbox.close();
	                  });
                      break;
                      
                case '1020' :
                    var metaOS = "";
                    var metaOSnm = "";
                    var ret = true;
                    
	                $("input[type=checkbox]:checked").each(function(i) {
	                    if (i==0) {
	                         metaOS = metaOS + this.value;
	                         metaOSnm = metaOSnm + $("#metaOSnm"+this.value).text();
	                    } else {
	                         metaOS = metaOS + "," + this.value;
	                         metaOSnm = metaOSnm + ", " + $("#metaOSnm"+this.value).text();
	                    }
	                    if (this.value == '9001') {
                            if ($("#metaOSetc"+this.value).val().trim() == '') {
                                alert("선택항목의 내용을 입력해 주십시오.");
                                $("#metaOSetc"+this.value).focus();
                                ret = false;
                                return false;
                            }
	                        parent.$("#metaOSetc").val($("#metaOSetc"+this.value).val());
	                    } else {
	                        parent.$("#metaOSetc").val("");
	                    }
	                });
	                if (ret) {
		                parent.$("#metaOSs").val(metaOS);
		                parent.$("#metaOSnm").text(metaOSnm);
	                    parent.$.fn.colorbox.close();
	                }
	                break;
	                
                case '1021' :
                    var metaAS = "";
                    var metaASnm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {
                        if (i==0) {
                             metaAS = metaAS + this.value;
                             metaASnm = metaASnm + $("#metaASnm"+this.value).text();
                        } else {
                             metaAS = metaAS + "," + this.value;
                             metaASnm = metaASnm + ", " + $("#metaASnm"+this.value).text();
                        }
                        if (this.value == '1005' || this.value == '2005') {
                            if ($("#metaASetc"+this.value).val().trim() == '') {
                                alert("선택항목의 내용을 입력해 주십시오.");
                                $("#metaASetc"+this.value).focus();
                                ret = false;
                                return false;
                            }
                            parent.$("#metaASetc").val($("#metaASetc"+this.value).val());
                        } else {
                            parent.$("#metaASetc").val("");
                        }
                    });
                    if (ret) {
	                    parent.$("#metaASs").val(metaAS);
	                    parent.$("#metaASnm").text(metaASnm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
                case '1022' :
                    var metaTECH = "";
                    var metaTECHnm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {
                        if (i==0) {
                             metaTECH = metaTECH + this.value;
                             metaTECHnm = metaTECHnm + $("#metaTECHnm"+this.value).text();
                        } else {
                             metaTECH = metaTECH + "," + this.value;
                             metaTECHnm = metaTECHnm + ", " + $("#metaTECHnm"+this.value).text();
                        }
                        if (this.value == '1002') {
                            if ($("#metaTECHetc"+this.value).val().trim() == '') {
                                alert("선택항목의 내용을 입력해 주십시오.");
                                $("#metaTECHetc"+this.value).focus();
                                ret = false;
                                return false;
                            }
                            parent.$("#metaTECHetc").val($("#metaTECHetc"+this.value).val());
                        } else {
                            parent.$("#metaTECHetc").val("");
                        }
                    });
                    if (ret) {
	                    parent.$("#metaTECHs").val(metaTECH);
	                    parent.$("#metaTECHnm").text(metaTECHnm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
                case '1023' :
                    var metaTAG = "";
                    var metaTAGhtml = ""
                    
                    $("input[type=checkbox]:checked").each(function(i) {
                        if (i==0) {
                            metaTAG = metaTAG + this.value;
                            
                            metaTAGhtml = metaTAGhtml + "<li><a id='metaTAG"+this.value+"' onclick='jsMetaTagDelete(this);' href='javascript:;''>" + $("#metaTAGnm"+this.value).html() + " X</a></li>";
//                             "<input type='button' value='" + $("#metaTAGnm"+this.value).html() + " X' onclick='jsMetaTagDelete(this);'/>";
                        } else {
                            metaTAG = metaTAG + "," + this.value;
                            metaTAGhtml = metaTAGhtml + "<li><a id='metaTAG"+this.value+"' onclick='jsMetaTagDelete(this);' href='javascript:;''>" + $("#metaTAGnm"+this.value).html() + " X</a></li>";
//                             " <input type='button' value='" + $("#metaTAGnm"+this.value).html() + " X' onclick='jsMetaTagDelete(this);'/>";
                        }
                    });
                    parent.$("#metaTAGs").val(metaTAG);
                    parent.$("#metaTAGhtml").html(metaTAGhtml);
                    parent.$.fn.colorbox.close();
                    break;
//{{ 2015.12.18 	
    			case '2022':
    			    var metaArea = "";
                    var metaAreanm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaArea = metaArea + this.value;
                            metaAreanm = metaAreanm + $("#metaAreanm"+this.value).text();
                        } else {
                            metaArea = metaArea + "," + this.value;
                            metaAreanm = metaAreanm + ", " + $("#metaAreanm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaAreas").val(metaArea);
	                    parent.$("#metaAreanm").text(metaAreanm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
//}}                
/* KS : 클라우드 신규 공통코드 추가 {{ */
    			case '2027':
    			    var metaExprn = "";
                    var metaExprnNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaExprn = metaExprn + this.value;
                            metaExprnNm = metaExprnNm + $("#metaExprnNm"+this.value).text();
                        } else {
                            metaExprn = metaExprn + "," + this.value;
                            metaExprnNm = metaExprnNm + ", " + $("#metaExprnNm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaExprns").val(metaExprn);
	                    parent.$("#metaExprnNm").text(metaExprnNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2028':
    			    var metaCntrctUnit = "";
                    var metaCntrctUnitNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaCntrctUnit = metaCntrctUnit + this.value;
                            metaCntrctUnitNm = metaCntrctUnitNm + $("#metaCntrctUnitNm"+this.value).text();
                        } else {
                            metaCntrctUnit = metaCntrctUnit + "," + this.value;
                            metaCntrctUnitNm = metaCntrctUnitNm + ", " + $("#metaCntrctUnitNm"+this.value).text();
                        }
                        if (this.value == '1005') {
                            if ($("#metaCntrctUnitetc"+this.value).val().trim() == '') {
                                alert("선택항목의 내용을 입력해 주십시오.");
                                $("#metaCntrctUnitetc"+this.value).focus();
                                ret = false;
                                return false;
                            }
	                        parent.$("#metaCntrctUnitetc").val($("#metaCntrctUnitetc"+this.value).val());
	                    } else {
	                        parent.$("#metaCntrctUnitetc").val("");
	                    }
                    });
                    
                    if (ret) {
	                    parent.$("#metaCntrctUnits").val(metaCntrctUnit);
	                    parent.$("#metaCntrctUnitNm").text(metaCntrctUnitNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2029':
    			    var metaCrtfc = "";
                    var metaCrtfcNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaCrtfc = metaCrtfc + this.value;
                            metaCrtfcNm = metaCrtfcNm + $("#metaCrtfcNm"+this.value).text();
                        } else {
                            metaCrtfc = metaCrtfc + "," + this.value;
                            metaCrtfcNm = metaCrtfcNm + ", " + $("#metaCrtfcNm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaCrtfcs").val(metaCrtfc);
	                    parent.$("#metaCrtfcNm").text(metaCrtfcNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2030':
    			    var metaSvc = "";
                    var metaSvcNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaSvc = metaSvc + this.value;
                            metaSvcNm = metaSvcNm + $("#metaSvcNm"+this.value).text();
                        } else {
                            metaSvc = metaSvc + "," + this.value;
                            metaSvcNm = metaSvcNm + ", " + $("#metaSvcNm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaSvcs").val(metaSvc);
	                    parent.$("#metaSvcNm").text(metaSvcNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2031':
    			    var metaStd = "";
                    var metaStdNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaStd = metaStd + this.value;
                            metaStdNm = metaStdNm + $("#metaStdNm"+this.value).text();
                        } else {
                            metaStd = metaStd + "," + this.value;
                            metaStdNm = metaStdNm + ", " + $("#metaStdNm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaStds").val(metaStd);
	                    parent.$("#metaStdNm").text(metaStdNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2032':
    			    var metaCnstcMthd = "";
                    var metaCnstcMthdNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaCnstcMthd = metaCnstcMthd + this.value;
                            metaCnstcMthdNm = metaCnstcMthdNm + $("#metaCnstcMthdNm"+this.value).text();
                        } else {
                            metaCnstcMthd = metaCnstcMthd + "," + this.value;
                            metaCnstcMthdNm = metaCnstcMthdNm + ", " + $("#metaCnstcMthdNm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaCnstcMthds").val(metaCnstcMthd);
	                    parent.$("#metaCnstcMthdNm").text(metaCnstcMthdNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2033':
    			    var metaScqcLv = "";
                    var metaScqcLvNm = "";
                    var ret = true;
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            metaScqcLv = metaScqcLv + this.value;
                            metaScqcLvNm = metaScqcLvNm + $("#metaScqcLvNm"+this.value).text();
                        } else {
                            metaScqcLv = metaScqcLv + "," + this.value;
                            metaScqcLvNm = metaScqcLvNm + ", " + $("#metaScqcLvNm"+this.value).text();
                        }
                    });
                    
                    if (ret) {
	                    parent.$("#metaScqcLvs").val(metaScqcLv);
	                    parent.$("#metaScqcLvNm").text(metaScqcLvNm);
	                    parent.$.fn.colorbox.close();
                    }
                    break;
                    
    			case '2068': // 견적요청(Paas) '런타임' /pages/korean/pt/before/BD_requestPaas2.form.jsp
    				
    			    var runtimesCd = ""; // 코드값
                    var runtimesNm = ""; // 코드이름
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            runtimesCd = runtimesCd + this.value;
                            runtimesNm = runtimesNm + $("#metaScqcLvNm"+this.value).text();
                        } else {
                            runtimesCd = runtimesCd + "," + this.value;
                            runtimesNm = runtimesNm + ", " + $("#metaScqcLvNm"+this.value).text();
                        }
                    });
                    
                    parent.$("#runtimes").val(runtimesCd);
                    parent.$("#runtimesNm").text(runtimesNm);                    
                    parent.$.fn.colorbox.close();
                    
    			    break;
                    
    			case '2069': // 견적요청(Paas) '미들웨어' /pages/korean/pt/before/BD_requestPaas2.form.jsp
    				
    			    var middlewaresCd = ""; // 코드값
                    var middlewaresNm = ""; // 코드이름
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            middlewaresCd = middlewaresCd + this.value;
                            middlewaresNm = middlewaresNm + $("#metaScqcLvNm"+this.value).text();
                        } else {
                            middlewaresCd = middlewaresCd + "," + this.value;
                            middlewaresNm = middlewaresNm + ", " + $("#metaScqcLvNm"+this.value).text();
                        }
                    });
                    
	                parent.$("#middlewares").val(middlewaresCd);
	                parent.$("#middlewaresNm").text(middlewaresNm);
	                parent.$.fn.colorbox.close();
                    
    			    break;
                    
    			case '2070': // 견적요청(Paas) '프레임워크' /pages/korean/pt/before/BD_requestPaas2.form.jsp
    				
    			    var frameworksCd = ""; // 코드값
                    var frameworksNm = ""; // 코드이름
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            frameworksCd = frameworksCd + this.value;
                            frameworksNm = frameworksNm + $("#metaScqcLvNm"+this.value).text();
                        } else {
                            frameworksCd = frameworksCd + "," + this.value;
                            frameworksNm = frameworksNm + ", " + $("#metaScqcLvNm"+this.value).text();
                        }
                    });

	                parent.$("#frameworks").val(frameworksCd);
	                parent.$("#frameworksNm").text(frameworksNm);
                    parent.$.fn.colorbox.close();
                    
    			    break;
                    
    			case '2071': // 견적요청(Paas) '서비스' /pages/korean/pt/before/BD_requestPaas2.form.jsp
    				
    			    var servicesCd = ""; // 코드값
                    var servicesNm = ""; // 코드이름
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            servicesCd = servicesCd + this.value;
                            servicesNm = servicesNm + $("#metaScqcLvNm"+this.value).text();
                        } else {
                            servicesCd = servicesCd + "," + this.value;
                            servicesNm = servicesNm + ", " + $("#metaScqcLvNm"+this.value).text();
                        }
                    });

	                parent.$("#services").val(servicesCd);
	                parent.$("#servicesNm").text(servicesNm);
                    parent.$.fn.colorbox.close();
                    
    			    break;
                    
    			case '2072': // 견적요청(Paas) '애드온' /pages/korean/pt/before/BD_requestPaas2.form.jsp
    				
    			    var addonsCd = ""; // 코드값
                    var addonsNm = ""; // 코드이름
                    
                    $("input[type=checkbox]:checked").each(function(i) {                        
                        if (i==0) {
                            addonsCd = addonsCd + this.value;
                            addonsNm = addonsNm + $("#metaScqcLvNm"+this.value).text();
                        } else {
                            addonsCd = addonsCd + "," + this.value;
                            addonsNm = addonsNm + ", " + $("#metaScqcLvNm"+this.value).text();
                        }
                    });

	                parent.$("#addons").val(addonsCd);
	                parent.$("#addonsNm").text(addonsNm);
                    parent.$.fn.colorbox.close();
                    
    			    break;
            }
        };
        
        var jsCancel = function() {
            parent.$.fn.colorbox.close();
        }
        
        $(document).ready(function() {
            var height = $("#pop_wrap").height() + 70;
            var width = $("#pop_wrap").width() + 70;
            parent.$.fn.colorbox.resize({height:height+"px", width:width+"px"});
            
            <c:choose>
            
            <c:when test="${codeList.codeGroupCd == 1015 }">
                $("#goodsLicenceCd" +parent.$("#goodsLicenceCd").val()).attr("checked","true");
                $("#goodsLicenceCn" +parent.$("#goodsLicenceCd").val()).val(parent.$("#goodsLicenceCn").val());
                $("input[name=goodsLicenceCd]").click( function() {
                    $("input[name=goodsLicenceCn]").val('');
                });
            </c:when>
            <c:when test="${codeList.codeGroupCd == 1020 }">
	            var metaOScds;
	            metaOScds = parent.$("#metaOSs").val();
	            metaOScds = metaOScds.split(",");
	            
	            for (var i = 0; i < metaOScds.length; i++) {
	                $("#metaOS"+metaOScds[i]).attr("checked", "true");
	                if (metaOScds[i]=='9001') {
	                    $("#metaOSetc"+metaOScds[i]).val(parent.$("#metaOSetc").val());
	                }
	            }
	            
	            $("input[id^=metaOS]").not("#metaOS9999").click( function() {
	                if (this.id != "metaOSetc9001") {
	                    $("#metaOS9999").removeAttr("checked");
	                }
	            });
	            
                $("#metaOS9999").click( function() {
                    $("input[id^=metaOS]").not(this).removeAttr("checked");
                    $("input[id^=metaOSetc]").val("");
                });
            </c:when>
            <c:when test="${codeList.codeGroupCd == 1021 }">
	            var metaAScds = Array();
	            metaAScds = parent.$("#metaASs").val().split(",");
	            
	            for (var i = 0; i < metaAScds.length; i++) {
	                $("#metaAS"+metaAScds[i]).attr("checked", "true");
	                if (metaAScds[i]=='1005' || metaAScds[i]=='2005') {
	                    $("#metaASetc"+metaAScds[i]).val(parent.$("#metaASetc").val());
	                }
	            }
	            
	            $("input[id^=metaAS]").not("#metaAS1006").click( function() {
	                if (this.id != "metaASetc1005") {
	                    $("#metaAS1006").removeAttr("checked");
	                }
	            });

               $("input[id^=metaAS]").not("#metaAS2006").click( function() {
                    if (this.id != "metaASetc2005") {
                        $("#metaAS2006").removeAttr("checked");
                    }
                });

               $("#metaAS1006").click( function() {
	                $("input[id^=metaAS]").not(this).removeAttr("checked");
	                $("input[id^=metaASetc]").val("");
	            });
	            
                $("#metaAS2006").click( function() {
                    $("input[id^=metaAS]").not(this).removeAttr("checked");
                    $("input[id^=metaASetc]").val("");
                });
            </c:when>
            <c:when test="${codeList.codeGroupCd == 1022 }">
	            var metaTECHcds = Array();
	            metaTECHcds = parent.$("#metaTECHs").val().split(",");
	            
	            for (var i = 0; i < metaTECHcds.length; i++) {
	                $("#metaTECH"+metaTECHcds[i]).attr("checked", "true");
	                if (metaTECHcds[i]=='1002') {
	                    $("#metaTECHetc"+metaTECHcds[i]).val(parent.$("#metaTECHetc").val());
	                }
	            }
	            
	            $("input[id^=metaTECH]").not("#metaTECH1003").click( function() {
	                if (this.id != "metaTECHetc1002") {
	                    $("#metaTECH1003").removeAttr("checked");
	                }
	            });
	            
	            $("#metaTECH1003").click( function() {
	                $("input[id^=metaTECH]").not(this).removeAttr("checked");
	                $("input[id^=metaTECHetc]").val("");
	            });                
            </c:when>
            <c:when test="${codeList.codeGroupCd == 1023 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaTAGs").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaTag"+metaTAGcds[i]).attr("checked", "true");
	            }
            </c:when>
            <c:when test="${codeList.codeGroupCd == 2022 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaAreas").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaArea"+metaTAGcds[i]).attr("checked", "true");
	            }
        	</c:when>
        	<%-- KS : 클라우드 신규등록 공통코드 {{ --%>
        	<c:when test="${codeList.codeGroupCd == 2027 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaExprns").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaExprn"+metaTAGcds[i]).attr("checked", "true");
	            }
	    		</c:when>
	    		<c:when test="${codeList.codeGroupCd == 2028 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaCntrctUnits").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaCntrctUnit"+metaTAGcds[i]).attr("checked", "true");
	                if (metaTAGcds[i]=='1005') {
	                    $("#metaCntrctUnitetc"+metaTAGcds[i]).val(parent.$("#metaCntrctUnitetc").val());
	                }
	            }
            </c:when>
    		<c:when test="${codeList.codeGroupCd == 2029 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaCrtfcs").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaCrtfc"+metaTAGcds[i]).attr("checked", "true");
	            }
	    		</c:when>
	    		<c:when test="${codeList.codeGroupCd == 2030 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaSvcs").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaSvc"+metaTAGcds[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2031 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaStds").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaStd"+metaTAGcds[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2032 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaCnstcMthds").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaCnstcMthd"+metaTAGcds[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2033 }">                 
	            var metaTAGcds = Array();
	            metaTAGcds = parent.$("#metaScqcLvs").val().split(",");
	            for (var i = 0; i < metaTAGcds.length; i++) {
	                $("#metaScqcLv"+metaTAGcds[i]).attr("checked", "true");
	            }
    		</c:when>
    		
    		
    		<c:when test="${codeList.codeGroupCd == 2068 }">  /* 견적요청(Paas) '런타임' /pages/korean/pt/before/BD_requestPaas2.form.jsp */
	    		var tmpArry = Array();
	    		tmpArry = parent.$("#runtimes").val().split(",");
	            for (var i = 0; i < tmpArry.length; i++) 
	            {
	                $("#metaScqcLv"+tmpArry[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2069 }">  /* 견적요청(Paas) '미들웨어' /pages/korean/pt/before/BD_requestPaas2.form.jsp */                 
	    		var tmpArry = Array();
	    		tmpArry = parent.$("#middlewares").val().split(",");
	            for (var i = 0; i < tmpArry.length; i++) 
	            {
	                $("#metaScqcLv"+tmpArry[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2070 }">  /* 견적요청(Paas) '프레임워크' /pages/korean/pt/before/BD_requestPaas2.form.jsp */                 
	    		var tmpArry = Array();
	    		tmpArry = parent.$("#frameworks").val().split(",");
	            for (var i = 0; i < tmpArry.length; i++) 
	            {
	                $("#metaScqcLv"+tmpArry[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2071 }">  /* 견적요청(Paas) '서비스' /pages/korean/pt/before/BD_requestPaas2.form.jsp */                 
	    		var tmpArry = Array();
	    		tmpArry = parent.$("#services").val().split(",");
	            for (var i = 0; i < tmpArry.length; i++) 
	            {
	                $("#metaScqcLv"+tmpArry[i]).attr("checked", "true");
	            }
    		</c:when>
    		<c:when test="${codeList.codeGroupCd == 2072 }">  /* 견적요청(Paas) '애드온' /pages/korean/pt/before/BD_requestPaas2.form.jsp */                 
	    		var tmpArry = Array();
	    		tmpArry = parent.$("#addons").val().split(",");
	            for (var i = 0; i < tmpArry.length; i++) 
	            {
	                $("#metaScqcLv"+tmpArry[i]).attr("checked", "true");
	            }
    		</c:when>
            
            </c:choose>
        });
      //]]>
</script>
</head>
<body class="winPopup qna">

	<h2>
    <c:choose>
        <c:when test="${codeList.codeGroupCd == 1015 }">라이선스</c:when>
        <c:when test="${codeList.codeGroupCd == 1020 }">지원 OS</c:when>
        <c:when test="${codeList.codeGroupCd == 1021 }">A/S 방침</c:when>
        <c:when test="${codeList.codeGroupCd == 1022 }">보유기술 및 자격증</c:when>
        <c:when test="${codeList.codeGroupCd == 1023 }">태그선택</c:when>          
        <c:when test="${codeList.codeGroupCd == 2022 }">지역</c:when>
        <c:when test="${codeList.codeGroupCd == 2027 }">무료/체험</c:when>
        <c:when test="${codeList.codeGroupCd == 2028 }">계약단위</c:when>
        <c:when test="${codeList.codeGroupCd == 2029 }">인증</c:when>
        <c:when test="${codeList.codeGroupCd == 2030 }">서비스 관리</c:when>
        <c:when test="${codeList.codeGroupCd == 2031 }">호환성(표준)</c:when>
        <c:when test="${codeList.codeGroupCd == 2032 }">구축방식</c:when>
        <c:when test="${codeList.codeGroupCd == 2033 }">SCQC Level</c:when>          
        <c:when test="${codeList.codeGroupCd == 2068 }">런타임<!-- 견적요청(Paas) '런타임' /pages/korean/pt/before/BD_requestPaas2.form.jsp --></c:when>            
        <c:when test="${codeList.codeGroupCd == 2069 }">미들웨어<!-- 견적요청(Paas) '미들웨어' /pages/korean/pt/before/BD_requestPaas2.form.jsp --></c:when>
        <c:when test="${codeList.codeGroupCd == 2070 }">프레임워크<!-- 견적요청(Paas) '프레임워크' /pages/korean/pt/before/BD_requestPaas2.form.jsp --></c:when>
        <c:when test="${codeList.codeGroupCd == 2071 }">서비스<!-- 견적요청(Paas) '서비스' /pages/korean/pt/before/BD_requestPaas2.form.jsp --></c:when>
        <c:when test="${codeList.codeGroupCd == 2072 }">애드온<!-- 견적요청(Paas) '애드온' /pages/korean/pt/before/BD_requestPaas2.form.jsp --></c:when>
    </c:choose> 
    <a href="#"  onclick="jsCancel();">닫기</a>
    </h2>
    
	<!-- 팝업 윈도우 크기 width:778px  -->
    <div id="pop_wrap">
            <!-- popup content -->
            <div class="section" style="margin: 0 auto;display: table;">
            	<br/><br/>
                <c:choose>
                <c:when test="${codeList.codeGroupCd == 1015}">
                <p class="guide_txt" style="padding: 5px;"></p>
                <fieldset>
                <legend><span>라이선스 선택/등록</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="goodsLicenceCd" id="goodsLicenceCd${_dataVo.codeIndvdlzCd}" type="radio" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                    <c:if test="${_dataVo.codeIndvdlzCd < 1008}">
                        <input name="goodsLicenceCn" id="goodsLicenceCn${_dataVo.codeIndvdlzCd}" type="text" style="width: 30px"/>&nbsp;
                    </c:if>
                        <span id="goodsLicenceNm${_dataVo.codeIndvdlzCd}">${_dataVo.codeIndvdlzCdNm}</span>
                    <c:if test="${_dataVo.codeIndvdlzCd == 1008}">
                       &nbsp;<input name="goodsLicenceCn" id="goodsLicenceCn${_dataVo.codeIndvdlzCd}" type="text" style="width: 150px;" />
                    </c:if>
                    </td>
                    </tr>
                    </c:forEach>
                    
                </tbody>
                </table>
                </fieldset>
                </c:when>

                <c:when test="${codeList.codeGroupCd == 1020}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>지원 OS</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                      <col style="width:20px;">
                      <col>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:set var="grp" value="0"/>
                    <c:set var="i" value="0"/>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <c:set var="grp_i" value="${fn:substring(_dataVo.codeIndvdlzCd,0,1)}"/>
                    <c:if test="${grp != grp_i}">                    
                    <c:choose>
                        <c:when test="${ grp_i == '1' }">
                        <tr><td colspan="6">
                        <div style="margin-top: 10px; padding-bottom: 5px; color: #000; font-family: dotum; font-weight: bold; text-align: left;"> - 윈도</div></td></tr>
                        </c:when>
                        <c:when test="${ grp_i == '2' }">
                        <tr><td colspan="6">
                        <div style="margin-top: 15px; padding-bottom: 5px; color: #000; font-family: dotum; font-weight: bold; text-align: left;"> - 리눅스/유닉스</div></td></tr>
                        </c:when>
                        <c:when test="${ grp_i == '3' }">
                        <tr><td colspan="6">
                        <div style="margin-top: 15px; padding-bottom: 5px; color: #000; font-family: dotum; font-weight: bold; text-align: left;"> - 맥OS X</div></td></tr>
                        </c:when>
                        <c:when test="${ grp_i == '4' }">
                        <tr><td colspan="6">
                        <div style="margin-top: 15px; padding-bottom: 5px; color: #000; font-family: dotum; font-weight: bold; text-align: left;"> - iOS</div></td></tr>
                        </c:when>
                        <c:when test="${ grp_i == '5' }">
                        <tr><td colspan="6">
                        <div style="margin-top: 15px; padding-bottom: 5px; color: #000; font-family: dotum; font-weight: bold; text-align: left;"> - 안드로이드</div></td></tr>
                        </c:when>
                        
                        <c:when test="${ grp_i == '9' }">
                        <tr><td colspan="6">
                        <div style="margin-top: 15px; padding-bottom: 5px; color: #000; font-family: dotum; font-weight: bold; text-align: left;"></div></td></tr>
                        </c:when>
                    </c:choose>
                    <c:set var="grp" value="${fn:substring(_dataVo.codeIndvdlzCd,0,1)}"/>
                    <c:set var="i" value="0"/>
                    </c:if>
                    <c:if test="${(i % 3) == 0}">
                    <tr>
                    </c:if>
                    <td style="padding:5px;"><input id="metaOS${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaOSnm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    <c:if test="${_dataVo.codeIndvdlzCd == 9001}">
                       &nbsp;<input id="metaOSetc${_dataVo.codeIndvdlzCd }" type="text" style="width: 100px;"/>
                    </c:if>
                    </td>
                    <c:if test="${(i % 3) == 2}">
                    </tr>
                    </c:if>
                    <c:set var="i" value="${i + 1 }"/>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>

                <c:when test="${codeList.codeGroupCd == 1021}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>A/S 방침</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaAS${_dataVo.codeIndvdlzCd }" id="metaAS${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaASnm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    <c:if test="${_dataVo.codeIndvdlzCd == 1005 || _dataVo.codeIndvdlzCd == 2005}">
                       &nbsp;<input name="metaASetc${_dataVo.codeIndvdlzCd }" id="metaASetc${_dataVo.codeIndvdlzCd }" type="text" style="width: 150px;"/>
                    </c:if>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                
                <c:when test="${codeList.codeGroupCd == 1022}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>보유기술 및 자격증</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaTECH${_dataVo.codeIndvdlzCd }" id="metaTECH${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaTECHnm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    <c:if test="${_dataVo.codeIndvdlzCd == 1002}">
                       &nbsp;<input name="metaTECHetc${_dataVo.codeIndvdlzCd }" id="metaTECHetc${_dataVo.codeIndvdlzCd }" type="text" style="width: 150px;"/>
                    </c:if>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                
                <c:when test="${codeList.codeGroupCd == 1023}">
                <p class="guide_txt" style="padding: 5px;">태그선택 또는 직접 입력으로 총 10개의 태그를 입력할 수 있습니다.</p>
                <fieldset>
                <legend><span>태그선택</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaTag${_dataVo.codeIndvdlzCd }" id="metaTag${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td class="tit"  style="padding:5px;"><span id="metaTAGnm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2022}">
                <fieldset>
                <legend><span>태그선택</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                	<tr>	
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <td style="padding:5px;"><input name="metaArea${_dataVo.codeIndvdlzCd }" id="metaArea${_dataVo.codeIndvdlzCd}" type="checkbox" value="${_dataVo.codeIndvdlzCd}"/></td>
                    <td class="tit"  style="padding:5px;"><span id="metaAreanm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    <c:if test="${status.index == 8}"></tr><tr></c:if>
                    </td>                    
                    </c:forEach>
                    </tr>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <%-- ----------------------- --%>
                <%-- KS : 클라우드공통코드신규 추가 {{ --%>
                <%-- ----------------------- --%>
                <c:when test="${codeList.codeGroupCd == 2027}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>무료/체험</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaExprn${_dataVo.codeIndvdlzCd }" id="metaExprn${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaExprnNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2028}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>계약단위</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaCntrctUnit${_dataVo.codeIndvdlzCd }" id="metaCntrctUnit${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaCntrctUnitNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                        <c:if test="${_dataVo.codeIndvdlzCd == 1005}">
	                       &nbsp;<input id="metaCntrctUnitetc${_dataVo.codeIndvdlzCd }" type="text" style="width: 100px;"/>
	                    </c:if>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2029}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>인증</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaCrtfc${_dataVo.codeIndvdlzCd }" id="metaCrtfc${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaCrtfcNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2030}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>서비스 관리</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaSvc${_dataVo.codeIndvdlzCd }" id="metaSvc${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaSvcNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2031}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>호환성(표준)</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaStd${_dataVo.codeIndvdlzCd }" id="metaStd${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaStdNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2032}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>구축방식</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaCnstcMthd${_dataVo.codeIndvdlzCd }" id="metaCnstcMthd${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaCnstcMthdNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2033}">
                <p class="guide_txt"></p>
                <fieldset>
                <legend><span>SCQC Level</span></legend>
                <table style="width: auto;">
                    <colgroup>
                      <col style="width:20px;">
                      <col>
                    </colgroup>
                <tbody>
                    <c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
                    <tr>
                    <td style="padding:5px;"><input name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"/></td>
                    <td style="padding:5px;">
                        <span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
                    </td>
                    </tr>
                    </c:forEach>
                </tbody>
                </table>
                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2068}">   <!-- 견적요청(Paas) '런타임' /pages/korean/pt/before/BD_requestPaas2.form.jsp -->
	                <p class="guide_txt"></p>
	                <fieldset>
	                <legend><span>런타임</span></legend>
	                <table style="width: auto;">
	                <tbody>	                	
	                	<c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
				        	<c:choose>
			                  	<c:when test="${status.last and status.index % 4 lt 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>				                    
				                    </td>
			                  		<c:forEach var="i" begin="0" end="${status.index % 8}" step="1">
			                  			<td>&nbsp;</td>			                  			
			                  		</c:forEach>
			                  		</tr>
			                  	</c:when>
			                  	<c:when test="${status.index % 4 eq 0}">
			                      	<tr>
			                      	<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                  	</c:when>                  
			                  	<c:when test="${status.index % 4 gt 0 and status.index % 4 lt 3 }">
			        				<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>        				
			    				</c:when>
			                  	<c:when test="${status.index % 4 eq 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span  id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                      	</tr>
			                  	</c:when>                                  
			              	</c:choose>        					
			 			</c:forEach>
	                </tbody>
	                </table>
	                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2069}">   <!-- 견적요청(Paas) '미들웨어' /pages/korean/pt/before/BD_requestPaas2.form.jsp -->
	                <p class="guide_txt"></p>
	                <fieldset>
	                <legend><span>미들웨어</span></legend>
	                <table style="width: auto;">
	                <tbody>	                	
	                	<c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
				        	<c:choose>
			                  	<c:when test="${status.last and status.index % 4 lt 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>				                    
				                    </td>
			                  		<c:forEach var="i" begin="0" end="${status.index % 8}" step="1">
			                  			<td>&nbsp;</td>			                  			
			                  		</c:forEach>
			                  		</tr>
			                  	</c:when>
			                  	<c:when test="${status.index % 4 eq 0}">
			                      	<tr>
			                      	<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                  	</c:when>                  
			                  	<c:when test="${status.index % 4 gt 0 and status.index % 4 lt 3 }">
			        				<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>        				
			    				</c:when>
			                  	<c:when test="${status.index % 4 eq 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span  id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                      	</tr>
			                  	</c:when>                                  
			              	</c:choose>        					
			 			</c:forEach>
	                </tbody>
	                </table>
	                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2070}">   <!-- 견적요청(Paas) '프레임워크' /pages/korean/pt/before/BD_requestPaas2.form.jsp -->
	                <p class="guide_txt"></p>
	                <fieldset>
	                <legend><span>프레임워크</span></legend>
	                <table style="width: auto;">
	                <tbody>	                	
	                	<c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
				        	<c:choose>
			                  	<c:when test="${status.last and status.index % 4 lt 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>				                    
				                    </td>
			                  		<c:forEach var="i" begin="0" end="${status.index % 8}" step="1">
			                  			<td>&nbsp;</td>			                  			
			                  		</c:forEach>
			                  		</tr>
			                  	</c:when>
			                  	<c:when test="${status.index % 4 eq 0}">
			                      	<tr>
			                      	<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                  	</c:when>                  
			                  	<c:when test="${status.index % 4 gt 0 and status.index % 4 lt 3 }">
			        				<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>        				
			    				</c:when>
			                  	<c:when test="${status.index % 4 eq 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span  id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                      	</tr>
			                  	</c:when>                                  
			              	</c:choose>        					
			 			</c:forEach>
	                </tbody>
	                </table>
	                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2071}">   <!-- 견적요청(Paas) '서비스' /pages/korean/pt/before/BD_requestPaas2.form.jsp -->
	                <p class="guide_txt"></p>
	                <fieldset>
	                <legend><span>서비스</span></legend>
	                <table style="width: auto;">
	                <tbody>	                	
	                	<c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
				        	<c:choose>
			                  	<c:when test="${status.last and status.index % 4 lt 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>				                    
				                    </td>
			                  		<c:forEach var="i" begin="0" end="${status.index % 8}" step="1">
			                  			<td>&nbsp;</td>			                  			
			                  		</c:forEach>
			                  		</tr>
			                  	</c:when>
			                  	<c:when test="${status.index % 4 eq 0}">
			                      	<tr>
			                      	<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                  	</c:when>                  
			                  	<c:when test="${status.index % 4 gt 0 and status.index % 4 lt 3 }">
			        				<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>        				
			    				</c:when>
			                  	<c:when test="${status.index % 4 eq 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span  id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                      	</tr>
			                  	</c:when>                                  
			              	</c:choose>        					
			 			</c:forEach>
	                </tbody>
	                </table>
	                </fieldset>
                </c:when>
                <c:when test="${codeList.codeGroupCd == 2072}">   <!-- 견적요청(Paas) '애드온' /pages/korean/pt/before/BD_requestPaas2.form.jsp -->
	                <p class="guide_txt"></p>
	                <fieldset>
	                <legend><span>애드온</span></legend>
	                <table style="width: auto;">
	                <tbody>	                	
	                	<c:forEach items="${dataVo}" var="_dataVo" varStatus="status">
				        	<c:choose>
			                  	<c:when test="${status.last and status.index % 4 lt 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>				                    
				                    </td>
			                  		<c:forEach var="i" begin="0" end="${status.index % 8}" step="1">
			                  			<td>&nbsp;</td>			                  			
			                  		</c:forEach>
			                  		</tr>
			                  	</c:when>
			                  	<c:when test="${status.index % 4 eq 0}">
			                      	<tr>
			                      	<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                  	</c:when>                  
			                  	<c:when test="${status.index % 4 gt 0 and status.index % 4 lt 3 }">
			        				<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>        				
			    				</c:when>
			                  	<c:when test="${status.index % 4 eq 3}">
			                  		<td style="padding:5px;">
			                  		<label class="short_txt">
			                  			<input class="mgmrgy4px" name="metaScqcLv${_dataVo.codeIndvdlzCd }" id="metaScqcLv${_dataVo.codeIndvdlzCd }" type="checkbox" value="${_dataVo.codeIndvdlzCd }"
			                  			/><span  id="metaScqcLvNm${_dataVo.codeIndvdlzCd }">${_dataVo.codeIndvdlzCdNm}</span>
				                    </label>
			                      	</tr>
			                  	</c:when>                                  
			              	</c:choose>        					
			 			</c:forEach>
	                </tbody>
	                </table>
	                </fieldset>
                </c:when>
                <%-- ----------------------- --%>
                <%-- }} KS : 클라우드공통코드신규 추가 --%>
                <%-- ----------------------- --%>
                </c:choose>
                <div class="sub_cate">
                </div>

                <div class="btn_area">
                    <div class="btn_pop_c">                     
                        <div class="btn_navi">
                            <a style="padding: 6px 20px 12px 10px;" href="#reg" onclick="jsSelect('${codeList.codeGroupCd}');"><span class="gt" style="color:white;">등록</span></a>                            
                        </div>
                        <div class="btn_navi_g">
                            <a href="#cancel" onclick="jsCancel();"><span class="cancel">취소</span></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //popup content -->
    </div>
</body>
</html>
