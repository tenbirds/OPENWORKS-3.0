<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${validateResult.typeMsgs}" var="typeMsg">
    <p class="valid_message">${typeMsg.validMsg}</p>
</c:forEach>
