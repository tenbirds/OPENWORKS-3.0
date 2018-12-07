<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>신청하기</title>
    <op:jsTag type="openworks" items="web-core"/>
    <op:jsTag type="spi" items="validate, form"/>
    <link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
    <script type="text/javascript">

        <c:if test="${empty dataVo.purchsNo && param.sleMthdCd==1002}">
            $().ready(function(){
                $("#dataForm").validate({
                    rules: {
                        // 개인판매회원
                        <c:if test="${fn:startsWith(sessionScope['__usk'].userTyCd, '10')}">
                            cmpnyNm :{required: true, maxlength: 20},
                            email   :{required: true, email: true, maxlength: 50},
                        </c:if>
                        // 기업판매회원
                        <c:if test="${fn:startsWith(sessionScope['__usk'].userTyCd, '20')}">
                            cmpnyReprsntTelno : {required: true, maxlength: 20},
                            chargerNm         : {required: true, maxlength:100},
                            chargerCttpc      : {required: true, maxlength: 20},
                            chargerEmail      : {required: true, email: true, maxlength: 50},
                        </c:if>
                        
                        dlivMssage       :{required: true, maxlength: 2000}
                    },
                    message: {
                        // 개인판매회원
                        <c:if test="${fn:startsWith(sessionScope['__usk'].userTyCd, '10')}">
                            email : {email: Message.msg.email}
                        </c:if>
                    },
                    submitHandler : function(form){
                        if(!$("#t01_y").is(':checked')){
                            alert(Message.msg.agreeOrderTerms);
                            $("#t01_y").focus();
                            return false;
                        }
                        
                        $(form).ajaxSubmit({
                            url      : "/korean/pt/store/premium/ND_purch.do",
                            type     : "POST",
                            dataType : "json",
                            success  : function(response){
                                           if(response.result){
                                               alert(Message.msg.orderOk);
                                               parent.$.fn.colorbox.close();
                                           } else {
                                               if(response.message == "requiredLogin"){
                                                   if(confirm(Message.msg.requiredLogin)){
                                                       returnUrl = "/korean/pt/store/software/BD_view.do&returnParam=goodsCode=${param.goodsCode}";
                                                       top.location.href = "/korean/pt/login/user/BD_index.do?returnUrl="+returnUrl;
                                                   }
                                               } else{
                                                   alert(Message.msg.processError);
                                               }
                                           }
                                       }
                        });
                    }
                });
            });

            // 문의하기
            var jsOrder = function(){
                $("#dataForm").attr("action", "/korean/store/premium/ND_purch.do");
                $("#dataForm").submit();
            };
        </c:if>
        
        // 다운로드
        var jsDownload = function(){
            if(!$("#t01_y").is(':checked')){
                alert(Message.msg.agreeTerms);
                $("#t01_y").focus();
                return false;
            }
	        $("#dataForm").attr("action","/korean/store/premium/ND_purchDownload.do");
	        $("#dataForm").submit();
	        jsClose();
        }

        //
        $( window ).load(function() {
            var height = $("#layer-pop").height() + 100;
        });

        // 닫기
        var jsClose = function(){
            parent.$.fn.colorbox.close();
        };
    </script>
</head>

<body>
    <!-- layer popup -->
    <div class="layer-pop" id="layer">
    
	    <!-- <span>test </span> -->
	    <div class="bg"></div>
	        
        <!-- pop-cont -->
        <div class="pop-cont orange question">
	        <button onclick="jsClose();"  class="btn-close">닫기</button>
	        <h3>
	            <c:if test="${param.sleMthdCd == 1001}">다운로드 </c:if>
                   <c:if test="${param.sleMthdCd == 1002}">
                    <c:if test="${not empty dataVo.purchsNo}">
			            <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">개인</c:if>
			            <c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">기업</c:if>
	           구매문의내용
		            </c:if>
		            <c:if test="${empty dataVo.purchsNo}">구매문의하기  </c:if>
	            </c:if>
	        </h3>
	
	        <!-- section -->
	        <div class="section">
	        
	            <!-- purchsNo 가 없을 경우  -->
	            <c:if test="${empty dataVo.purchsNo}">
	                
	                <!-- sleMthdCd = '1002'  -->
                    <c:if test="${param.sleMthdCd == 1002}">

                        <form id="dataForm">
                            <input type="hidden" name="langCode" value="${param.langCode}" />
                            <input type="hidden" name="goodsCode" value="${param.goodsCode}" />
                            <input type="hidden" name="sleMthdCd" value="${param.sleMthdCd}" />

              		        <table>
				                <colgroup>
					                <col style="width:12%;" />
					                <col style="width:16%;" />
					                <col style="width:12%;" />
					                <col style="width:*;" />
				                </colgroup>
					            <thead>
						            <tr>
							            <th colspan="2">나의 정보
							                <c:if test="${dataVo.userTyCd eq '1001' || dataVo.userTyCd eq '1002'}">(개인)</c:if>
		             						<c:if test="${dataVo.userTyCd eq '2001' || dataVo.userTyCd eq '2002'}">(기업)</c:if></th>
							            <th colspan="2">서비스 정보</th>
						            </tr>
					            </thead>
				            
					            <tbody>				
					                <%-- 개인판매회원 --%>
			  		                <c:if test="${fn:startsWith(sessionScope['__usk'].userTyCd, '10')}">
						            <tr>
							            <th>이름</th>
							            <td>${dataVo.userNm}</td>
							            <th>서비스명</th>
							            <td><script type="text/javascript">document.write(parent.$("[id=goodsNm]").text());</script></td>
						            </tr>
						            <tr>
							            <th>회사명</th>
							            <td><input type="text" id="cmpnyNm" name="cmpnyNm" style="width:160px;" value="${dataVo.entrprsCmpnyNm}" /></td>
							            <th>단가</th>
							            <td><script type="text/javascript">document.write(parent.$("#goodsPrice").text());</script></td>
						            </tr>
						            <tr>
							            <th>이메일</th>
							            <td><input type="text" id="email" name="email" style="width:160px;" value="${dataVo.email}" /></td>
							            <th><!-- 라이센스 --></th>
							            <td><!-- <script type="text/javascript">document.write(parent.$("#goodsLicence").text());</script> --></td>
						            </tr>
						            </c:if>
						            <%-- //개인판매회원 --%>
						            
						            <%-- 기업판매회원 --%>            
					                <c:if test="${fn:startsWith(sessionScope['__usk'].userTyCd, '20')}">
					 	            <tr>
							            <th>법인 정보</th>
							            <td>${dataVo.userNm}</td>
							            <th>서비스명</th>
							            <td><script type="text/javascript">document.write(parent.$("[id=goodsNm]").text());</script></td>
						            </tr>
						            <tr>
							            <th>회사명</th>
							            <td><input type="hidden" id="cmpnyNm" name="cmpnyNm" value="${dataVo.entrprsCmpnyNm}"/></td>
							            <th>가격</th>
							            <td><script type="text/javascript">document.write(parent.$("#goodsPrice").text());</script></td>
						            </tr>
						            <tr>
							            <th>이메일</th>
							            <td><input type="text" id="chargerEmail" name="chargerEmail" value="${dataVo.email}"/></td>
							            <th><!-- 라이센스 --></th>
							            <td><!-- <script type="text/javascript">document.write(parent.$("#goodsLicence").text());</script> --></td>
						            </tr>
					                </c:if>
					                <%-- //기업판매회원 --%>
					                
					                <%-- 개인/기업공통 --%>
						            <tr>
							            <td colspan="4">
								            <div class="message">
								                <strong>판매자에게 전달할 메시지</strong>
									            <textarea  class="cont_box" id="dlivMssage" name="dlivMssage" placeholder="문의내용을 작성해주세요 (최대 2,000자)"></textarea>								
								            </div>
								            <div class="message">
								                <p class="caption mt10 mb10">※ 구매문의 신청 시 판매자에게 “나의 정보”가 전달됩니다.</p>
									            <span class="agree"><input type="checkbox" name="t01" id="t01_y"  /><label>정보 전달 동의</label></span>
								            </div>
								        </td>
						            </tr>
						            <%-- //개인/기업공통 --%>

					            </tbody>
			                </table>
                        </form>
	                </c:if>
	                <!-- //sleMthdCd = '1002'  -->
	                
                </c:if> 
                <!-- //purchsNo 가 없을 경우  -->          	
	        </div>
	        <!-- //section -->
	        
	        <!-- btn area -->
	        <div class="btn-area ac mb20">
		        <a href="#reg" onclick="jsClose();" class="b-btn type1"><strong><span>취소</span></strong></a>
                <c:if test="${param.sleMthdCd == 1002}">
                    <c:if test="${empty dataVo.purchsNo}">
				        <a href="#reg" onclick="jsOrder();" class="b-btn ml10 type2"><strong><span>문의하기</span></strong></a>
				    </c:if>
                </c:if>
	        </div>
	        <!-- //btn area -->

        </div>
        <!-- //pop-cont -->
	        
    </div>
    <!-- //layer popup -->
</body>
</html>

