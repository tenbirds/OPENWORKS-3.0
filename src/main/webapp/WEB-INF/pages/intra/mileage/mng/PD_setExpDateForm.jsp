<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>유효기간 설정 관리</title>
    <op:jsTag type="spi" items="ui,validate,form"/>
    
    <script type="text/javascript">
    <!--
    
    $().ready(function () {
        url = "ND_insertExpDateAction.do";
        if('${actionUrl}' == 'updateExpDate') {
            url = "ND_updateExpDateAction.do";
            if('${baseVo.modDtm}' != ''){
                parent.$.colorbox.resize({width : 770, height : 700});
            }else{
                parent.$.colorbox.resize({width : 770, height : 500});
            }
        }
        
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
        
        $('#appStDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '/resources/openworks/theme/default/images/icon/icon_cal.gif',
            buttonImageOnly : true,
        });
        
        $("#dataForm").validate({
            rules: {
               expDt : { required:true }
            },
            submitHandler : function(form) {
                if(jsValidate()){
                    return false;
                }else{
                    $(form).ajaxSubmit({
                        url : url,
                        type : "POST",
                        success : function(response) {
                            try {
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.insertOk);
                                    jsList();
                                } else {
                                    jsErrorBox("중복되는 적용시작일이 있습니다. 적용시작일을 다시 지정하여 주십시오.");
                                    $('#appStDate').val();
                                }
                            } catch (e) {
                                jsSysErrorBox(response, e);
                                return;
                            }
                        }
                    });
                }
            }
        });
    });
    
    var jsValidate = function() {
        var regExp = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
        var strDate = $("#appStDate").val();
        if(!regExp.test(strDate)) {
            jsWarningBox('시작일은 꼭 2012-02-28 형식으로만 작성하십시오');
            $("#appStDate").focus;
            return false;
        }
        if($("#compareExpDt").val() == $("#expDt").val() && $("#compareAppStDate").val() == $("#appStDate").val().replace(/-/gi,"")) {
            jsWarningBox("수정하신 내용이 없습니다.");
            $("#appStDate").focus;
            return false;
        }
        $("#appStDate").val($("#appStDate").val().replace(/-/gi,""));
    };
    
    var jsList = function(){
        $("#listForm").submit();
    };
    
    //-->
    </script>
</head>

<body>
<h2>유효기간 설정</h2>
<div id="popup">
    <p class="mar_b10">
        - 마일리지 <span class="tx_red">유효기간은 전체 마일리지에 일괄 적용</span>됩니다.
        <br/> - 마일리지 유효기간은 마일리지의 소멸과 연관되어 있어 초기 설정시 마일리지 정책을 충분히 검토 후 설정하시기 바랍니다.
    </p>
    <fmt:parseDate pattern="yyyyMMdd" value="${baseVo.beforeAppStDate}" var="beforeAppStDate" />
    <c:set var="beforeAppStDate"><fmt:formatDate value="${beforeAppStDate}" pattern="yyyy-MM-dd" /></c:set>
    
    <fmt:parseDate pattern="yyyyMMdd" value="${baseVo.appStDate}" var="appStDate" />
    <c:set var="appStDate"><fmt:formatDate value="${appStDate}" pattern="yyyy-MM-dd" /></c:set>
    
    <fmt:parseDate pattern="yyyyMMddHHmmss" value="${nowDtm}" var="pNowDtm" />
    <c:set var="fNowDtm"><fmt:formatDate value="${pNowDtm}" pattern="yyyy-MM-dd" /></c:set>
    
    <p class="tx_r mar_b10"><span class="tx_red tx_b">*</span>표시는 필수입력사항입니다.</p>
    <form id="listForm" method="post" action="PD_setExpDatePop.do"></form>
    <form id="dataForm">
        <input type="hidden" name="seqNo" value="${baseVo.seqNo}" />
        <input type="hidden" id="compareExpDt" value="${baseVo.expDt}" />
        <input type="hidden" id="compareAppStDate" value="${baseVo.appStDate}" />
    <fieldset>
    <legend>유효기간설정</legend>
    <table class="boardWrite" cellspacing="0" border="0">
        <caption class="hidden"> 유효기간설정 </caption>
        <colgroup>
            <col width="20%" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th><span class="tx_red tx_b">*</span> <label for="type">유효기간 설정</label></th>
                <td>
                    <select name="expDt" id="expDt" title="유효기간을 선택해주세요">
                    <option value="">기간을 선택하세요.</option>
                    <option value="1"<c:if test="${baseVo.expDt eq 1}"> selected="selected"</c:if>>1년</option>
                    <option value="2"<c:if test="${baseVo.expDt eq 2}"> selected="selected"</c:if>>2년</option>
                    <option value="3"<c:if test="${baseVo.expDt eq 3}"> selected="selected"</c:if>>3년</option>
                    <option value="4"<c:if test="${baseVo.expDt eq 4}"> selected="selected"</c:if>>4년</option>
                    <option value="5"<c:if test="${baseVo.expDt eq 5}"> selected="selected"</c:if>>5년</option>
                    <option value="100"<c:if test="${baseVo.expDt eq 100}"> selected="selected"</c:if>>제한없음</option>
                </select>
                </td>
            </tr>
            <tr>
                <th><span class="tx_red tx_b">*</span> <label for="mil1">적용시작일</label></th>
                <td>
                    <c:choose>
                        <c:when test="${actionUrl eq 'updateExpDate'}">
                            <input type="text" name="appStDate" id="appStDate" class="w150" title="날짜선택" value="${appStDate}" />
                        </c:when>
                        <c:otherwise>
                            <input type="text" name="appStDate" id="appStDate" class="w150" title="날짜선택" value="${fNowDtm}" />
                        </c:otherwise>
                    </c:choose>
                    <p class="tx_11 mar_t10">* 직접입력은 <span class="tx_red">2012-02-28</span> 형식으로 입력하세요.</p>
                </td>
            </tr>
            <c:if test="${actionUrl eq 'updateExpDate'}">
                <tr>
                    <th>등록자</th>
                    <td>${baseVo.regId}</td>
                </tr>
                <tr>
                    <th>등록일시</th>
                    <td>
                        <fmt:formatDate value="${baseVo.regDtm}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </td>
                </tr>
                <c:if test="${not empty baseVo.modDtm}">
                    <tr>
                        <th>수정자</th>
                        <td>${baseVo.modId}</td>
                    </tr>
                    <tr>
                        <th>최종 수정일시</th>
                        <td>
                            <fmt:formatDate value="${baseVo.modDtm}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <th>최종수정 내용</th>
                    <td>
                        <c:choose>
                            <c:when test="${empty baseVo.beforeExpDt or empty baseVo.beforeAppStDate}">
                                유효기간 ${baseVo.expDt}년 / 적용시작일 ${appStDate}
                            </c:when>
                            <c:when test="${baseVo.beforeExpDt eq baseVo.expDt or baseVo.beforeAppStDate eq baseVo.appStDate}">
                                유효기간 ${baseVo.expDt}년 / 적용시작일 ${appStDate}
                            </c:when>
                            <c:otherwise>
                                유효기간 ${baseVo.beforeExpDt}년 -> <span class="tx_red_b">${baseVo.expDt}년</span> /
                                적용시작일 ${beforeAppStDate} -> <span class="tx_red_b">${appStDate}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
    </fieldset>

    <p class="tx_c mar_t20">
        <c:set var="actionType" value="등록" />
        <c:if test="${actionUrl eq 'updateExpDate'}"><c:set var="actionType" value="수정" /></c:if>
        <button class="blue">${actionType}</button>
        <button class="blue" type="button" onclick="jsList();">취소</button>
<!--         <button class="blue" type="button" onclick="history.back();">취소</button> -->
    </p>
    </form>    
</div>
</body>
</html>
                    