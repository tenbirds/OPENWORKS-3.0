<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page language="java" import="java.net.InetAddress" %>

<html>
<head>
<title>비밀번호 확인</title>
<op:jsTag type="spi" items="validate,form,colorbox" />
<script type="text/javascript">

$().ready(function() {

    $("#Form").validate({
        rules: {
            accessResn: { required: true, minlength : 10, maxlength: 1000 }
        },
        submitHandler : function(form) {
            var menuType = $("#logMenuTy").val();

             $(form).ajaxSubmit({
                url      : "ND_userLogInsertAction.do",
                type     : "POST",
                dataType : "json",
                success  : function(response) {
                    if(!response.result){
                        jsWarningBox(response.message);
                        return;
                    } else {
                        if(menuType == 'R'){
                            self.location.href = "${param.returnUrl}?userId="+$("#userId").val()+"&userTyCd="+$("#userTyCd").val()+"${paramVal}";
                            //parent.$.colorbox.resize({width : "${param.widthV}", height : "${param.heightV}"});
                        }else if(menuType == 'U'){
                            parent.$("#submitYN").val("Y");
                            parent.$("#Form").submit();
                            parent.$.fn.colorbox.close();
                        }else if(menuType == 'O'){
                            parent.parent.location.href = "${param.returnUrl}?menuType="+$("#logMenuTy").val()+"${paramVal}";
                            if('${param.title1}' == '회원 정보 엑셀 출력'){
                                parent.parent.$.fn.colorbox.close();
                            }else{
                                parent.$.fn.colorbox.close();
                            }
                        }
                    }
                }
             });
         }
    });
});


</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
    <form id="Form">

        <input type="hidden" id="userId" name="userId" value="${param.userId }"/>
        <input type="hidden" id="userTyCd" name="userTyCd" value="${param.userTyCd }"/>
        <input type="hidden" id="logMenuTy" name="logMenuTy" value="${param.logMenuTy }"/>            <!-- 조회 : R, 변경: U, 출력 : O -->
        <input type="hidden" id="logMenuNm" name="logMenuNm" value="${param.logMenuNm }"/>                <!-- 메뉴명 -->
        <input type="hidden" id="outptCn" name="outptCn" value="${param.outptCn }"/>    <!-- 출력내용 : 리스트 or [홍길동]접속이력 -->
        <input type="hidden" id="changeCn" name="changeCn" value="${param.changeCn }"/>            <!-- 변경내용 : [이메일항목], [주소항목], [전화번호항목] -->

            <ul class="blet">
                    <li>회원의 개인정보 보호를 위하여 정보 조회 및 출력에 대한 접근을 제한 합니다.</li>
                    <li>권한 있는 관리자 외에는 접근을 불허하며, 조회 및 출력 이력이 남습니다.</li>
                    <c:if test="${param.logMenuTy eq 'O' }">
                        <li class="tx_red">회원정보가 출력된 엑셀문서에 대해 보안 및 관리를 철저히 하시기 바랍니다.</li>
                    </c:if>
            </ul>
            
            <%
			InetAddress inet = InetAddress.getLocalHost();
			String svrIP     = inet.getHostAddress();
			String autoPw    = "192.168.85.26".equals(svrIP) || "192.168.85.31".equals(svrIP) ? "kwon!!" : "" ; // 로컬ip일때 자동으로 만능암호를 자동입력한다.	                   
			%>

            <!-- 사유 -->
            <h2 class="mar_t20">
                <c:if test="${param.logMenuTy eq 'R'}">조회 </c:if>
                <c:if test="${param.logMenuTy eq 'U'}">변경 </c:if>
                <c:if test="${param.logMenuTy eq 'O'}">출력 </c:if>
                사유
                <span class="tx_red">(10자이상 상세기재)</span>
            </h2>
            <fieldset>
            <legend>추가정보 등록하기</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 추가정보 등록하기 </caption>
                <colgroup>
                    <col width="" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>
                            <label for="reason">
                                <c:if test="${param.accessResn eq 'R'}">조회 </c:if>
                                <c:if test="${param.accessResn eq 'U'}">변경 </c:if>
                                <c:if test="${param.accessResn eq 'O'}">출력 </c:if>
                                사유
                            </label>
                        </th>
                        <td><textarea id="accessResn" name="accessResn"  rows="8" class="w99_p"></textarea></td>
                    </tr>
                </tbody>
            </table>
            </fieldset>
            <!-- //사유 -->

            <!-- 비밀번호 재입력 -->
            <h2 class="mar_t20">비밀번호 재입력</h2>
            <div class="w_100p clear">
            <fieldset>
            <legend>비밀번호변경</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 비밀번호변경 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th><label for="userPwd">비밀번호 재입력</label></th>
                        <td>
                            <input type="password" id="userPwd1" class="w180" name="userPwd1" title="비밀번호를 재입력해주세요" value="<%=autoPw%>" /><br />
                            <p class="mar_t10">* <span class="tx_blue_n">로그인시 사용한 비밀번호</span>를 입력하세요.</p>
                            <p class="mar_t5">* <span class="tx_blue_n">3회 이상 입력 오류</span> 시 일정시간 동안의 <span class="tx_blue_n">접근이 차단</span>됩니다.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
            </fieldset>
            </div>

            <p class="tx_c mar_t20">
                <a href="#">
                    <button type="submit" class="blue">확인</button>
                </a>
                <a href="#">
                    <button type="button" onclick="parent.$.fn.colorbox.close();" class="blue">취소</button>
                </a>
            </p>

    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>