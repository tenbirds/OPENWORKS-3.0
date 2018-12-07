<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
//<![CDATA[
    var validate = function() {
        var $validateTarget;
<c:forEach items="${validate.results}" var="validateResult"><c:forEach items="${validateResult.typeMsgs}" var="typeMsg">
        $validateTarget = $("[name='${validateResult.fieldName}']");
        <c:set var="type" value="${typeMsg.validType}Validator" />
        if(!$validateTarget.${type}(<c:forEach items="${typeMsg.validData}" var="validData" varStatus="dataStatus">${validData}<c:if test="${not dataStatus.last}">,</c:if></c:forEach>)) {
            jsWarningBox("${typeMsg.validMsg}");
            if($validateTarget.length <= 1) {
                $validateTarget.focus();
            } else {
                $validateTarget[0].focus();
            }
            return false;
        }
</c:forEach></c:forEach>
        if(typeof(customValidate) != "undefined") {
            return customValidate();
        };
        
        return true;
    };
//]]>
</script>