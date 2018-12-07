<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />
    <title>${dataVo.title}</title>

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <style type="text/css">

        body {
            font-size: 12px;
            color: #595959;
            font-family: Gulim,Dotum,Arial,AppleGothic,Sans-serif;
        }

        p {
            text-align: justify;
            word-wrap:break-workd;
            font-size: 1em;
        }

        .mes_body .wid_center {
            margin: 0 auto;
        }

        .mes_body .letter {
            float: left;
            width: 681px;
            line-height: 140%;
        }

        .mes_body .letter .m_tit {
            padding-top: 10px;
            color: #6e4824;
            font-size: 14px;
            font-weight: bold;
        }

        .mes_body .letter .l_top {
            background: url('/resources/monitor/images/message/top_bg.gif') no-repeat left top;
            height: 95px;
            padding: 40px 50px 0 130px;
        }

        .mes_body .letter .l_center {
            background: url('/resources/monitor/images/message/body_bg.gif') repeat-y left top;
            padding: 20px 50px 20px 130px;
        }

        .mes_body .letter .l_footer {
            background: url('/resources/monitor/images/message/bottom_bg.gif') no-repeat left bottom;
            height: 112px;
            padding: 80px 50px 0 130px;
        }

        .mes_body .letter .m_footer {
            padding-top: 10px;
        }

    </style>

</head>
<body>
    <div id="message">
        <div class="mes_body">
            <div class="wid_center">
                <div class="letter">
                    <div class="l_top">
                        <c:if test="${not empty dataVo.logoFileNm}">
                            <img src="${dataVo.logoFileNm}" alt="로고"/><br/>
                        </c:if>
                        <p class="m_tit">${dataVo.mailTitle}</p>
                    </div>
                    <div class="l_center"><op:nrToBr content="${dataVo.mailContent}" /></div>
                    <div class="l_footer">
                        <c:if test="${not empty dataVo.attechFileNm}">
                            <img src="${dataVo.attechFileNm}" alt="로고"/><br/>
                        </c:if>
                        <p class="m_footer">${dataVo.mailAddr}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
