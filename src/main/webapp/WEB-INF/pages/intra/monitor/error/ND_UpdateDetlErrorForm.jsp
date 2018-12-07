<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.base.support.*,zes.openworks.monitor.error.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%
    // 장애관리 서버 주소
    String HOST_NAME = request.getServerName();
    Integer HOST_PORT = request.getServerPort();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />
    <title>상태코드 ${errorVo.errorResNm} 오류가 발생되었습니다.</title>

    <op:jsTag type="spi" items="jquery, validate" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <style>
        body{background-color:#ebe8df;margin:0;padding:0;font-family:Dotum;color:#666;line-height:1.5em;font-size:12px;}
        .error_contents{
            margin:0 auto;
            background:url("/resources/monitor/emguide/images/error_bg.jpg") no-repeat left top;
            width:1002px;
            height:794px;
        }
        .error_contents p.c_title{padding:132px 0 40px 490px;}
        ul{list-style:none;margin:0 60px 20px 490px;padding:0;}
        .error_contents ul li{background:url("/resources/monitor/emguide/images/icon_arrow.gif") no-repeat left 5px;padding:3px 0 3px 20px;}
        .error_contents ul li strong{color:#000;font-weight:bold;}
        span.tx_red{color:#fe0000;font-size:14px;font-weight:bold;}
        span.tx_blue{color:#036cbe;font-size:14px;font-weight:bold;}
        
        .boardWrite{
            margin:0 0 0 290px;
            border-top:2px solid #bbd2b5;
            border-bottom:1px solid #bbd2b5;
            width:650px;
            line-height:140%;
        }
        .boardWrite th{
            background-color:#d6e3d1;
            text-align:left;
            padding:7px 10px;
            border-bottom:1px solid #bbd2b5;
            color:#2e591c;
            font-size:11px;
        }
        .boardWrite th.bgred{
            background-color:#f5e8e5;
        }
        .boardWrite th.line_r,.boardWrite td.line_r{
            border-right:1px solid #d0d0d0;
        }
        .boardWrite th.tx_c{
            text-align:center;
        }
        .boardWrite td{
            padding:7px 10px;
            border-bottom:1px solid #bbd2b5;
        }
        .boardWrite td.tx_r{
            text-align:right;
        }

        form {
            margin: 0px;
            padding: 0px;
        }

        input {
            color: #555;
            font-size: 12px;
            line-height: 15px;
            vertical-align: middle;
        }

        select {
            line-height: 19px;
            border: 1px solid #c3c3c3;
            color: #555;
            font-size: 12px;
            letter-spacing: 0;
            padding: 3px 3px;
            vertical-align: middle;
        }
        textarea {
            padding:2px 3px;
            border:1px solid #d6d6d6;
            color:#555;
        }

        input.button, input.submit , input.image, button {
            cursor:pointer;
        }

        textarea, pre {
            overflow:auto;
        }


        fieldset {
            border: 0 none;
        }

        legend,label.skip {
            width:0;
            height:0;
            line-height:0;
            overflow:hidden;
            visibility:hidden;
            font-size:0;
            display:none;
        }
        caption {
            width:0;
            height:0;
            line-height:0;
            overflow:hidden;
            visibility:hidden;
            font-size:0;
        }
        img {border: 0 none;}
        input.w120{width:120px;}
        textarea.w99_p{width:99%;}
    </style>

    <script type="text/javascript">
    //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {

            $("#dataForm").validate({
                rules: {
                    errorInformYn: {required : true},
                    userName: {required : true, minlength : 2},
                    email:{email : true},
                    mobNo:{phone: true},
                    etc:{rangelength:[10,1000]}
                },
                submitHandler: function(form) {
                    var informYn = $("input[name='errorInformYn']:checked").val();

                    if(informYn == "Y") {
                        var email = $("#email").val();
                        var mobNo = $("#mobNo").val();
                        if($.trim(email) == "" && $.trim(mobNo) == "") {
                            alert("완료시통보를 받고자 하는 경우 이메일 또는 휴대전화번호중 하나는 입력해야 합니다.");
                            return false;
                        }
                    }
                    form.submit();
                }
            });

        });

    //]]>
    </script>

</head>
 
<body>

    <%-- 처리자 정보 --%>
    <c:set var="transactorVo" value="${errorVo.transactor}" />

    <div class="error_contents">
        <p class="c_title"><img src="/resources/monitor/emguide/images/error_tx.png" alt="오류가 발생되었습니다. 이용에 불편을 드려 죄송하오며 필수입력항목이 누락되었는지 등의 여부를 확인하여 주시기 바랍니다. 빠른시일안에 정상 서비스를 제공하도록 노력하겠습니다."/></p>
        <ul>
            <li><strong>접수번호</strong> : <span class="tx_red">${errorVo.errorNo}</span><br/>접수번호를 알고계시면 더 빠른 상담이 가능합니다.</li>
            <li><strong>진행상태조회</strong> : 
                <span class="tx_blue">
                    <a href="http://<%= HOST_NAME %>:<%= HOST_PORT %>/collector/error/ND_SearchError.do?q_errorNo=${errorVo.errorNo}" target="_blank">
                        http://<%= request.getServerName() %>:<%=request.getServerPort() %>/collector/error/ND_SearchError.do?q_errorNo=${errorVo.errorNo}
                    </a>
                </span>
                <br/>위 주소로 이동하신 후 즐겨찾기(북마크)에 등록하고 확인하세요.
            </li>
            <c:if test="${not empty transactorVo}">
                <li><strong>담당자</strong> : 
                    ${transactorVo.transactorNm}
                    ( 이메일 : ${transactorVo.email}, 전화번호 : ${transactorVo.telNo} )
                </li>
            </c:if>
            <c:if test="${not empty errorVo.guideCont}">
            <li><strong>임시조치 안내</strong> : 
                <op:nrToBr content="${errorVo.guideCont}" />
            </li>
            </c:if>
        </ul>

        <form id="dataForm" name="dataForm" method="post" action="/collector/error/ND_UpdateDetlError.do">
            <input type="hidden" id="errorNo" name="errorNo" value="${errorVo.errorNo}" />
            <input type="hidden" id="detlSeqNo" name="detlSeqNo" value="${errorVo.detlSeqNo}" />

            <!-- 내용쓰기 -->
            <fieldset>
                <legend>글입력</legend>
                <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
                    <caption class="hidden"> 글입력하기 </caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="80%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>완료시 통보여부</th>
                            <td><input type="radio" id="errorInformYnY" name="errorInformYn" value="Y" checked="checked"/>
                            <label for="errorInformYnY">통보받음</label>&nbsp;&nbsp;&nbsp;
                            <input type="radio" id="errorInformYnN" name="errorInformYn" value="N" />
                            <label for="errorInformYnN">받지않음<span>&nbsp;&nbsp;&nbsp;(오류수정 완료시 결과를 통보 받을 수 있습니다.)</span></label>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="userName">이름</label></th>
                            <td>
                            <input type="text" id="userName" name="userName" value="${errorVo.userName}" maxlength="10" class="w120" /></td>
                        </tr> 
                        <tr>
                            <th><label for="email">이메일</label></th>
                            <td>
                            <input type="text" id="email" name="email" value="${errorVo.email}" maxlength="150" class="w120" /> (이메일로 받고자 하는 경우 입력하세요.)</td>
                        </tr> 
                        <tr>
                            <th><label for="mobNo">휴대전화번호</label></th>
                            <td>
                            <input type="text" id="mobNo" name="mobNo" value="${errorVo.mobNo}" maxlength="14" class="w120" /> (문자메시지로 받고자 하는 경우 입력하세요.)</td>
                        </tr> 
                        <tr>
                            <th><label for="etc">기타의견</label></th>
                            <td><textarea id="etc" name="etc"  rows="4" class="w99_p" title="내용입력"></textarea>
                            <br/>
                            (1000자 이내로 입력하세요.)
                            </td>
                        </tr>           
                    </tbody>
                </table>
            </fieldset>

            <!-- //내용쓰기 -->
            <div style="margin:10px 60px 0 0;text-align:right;">
                <button type="submit" class="blue" style="border:0px;" ><img src="/resources/monitor/emguide/images/btn_regist.gif" alt="등록하기"/></button>
                <button type="button" class="blue" onclick="history.go(-2);" style="border:0px;" ><img src="/resources/monitor/emguide/images/btn_return.gif" alt="돌아가기"/></button>
            </div>

        </form>
    </div>
</body>
</html>


