<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>

<spring:url value="/resources/css/screen.css" var="resourceCmxUrl"/>

<link  rel="stylesheet" type="text/css" href="${resourceCmxUrl}"/>

</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<img src="${contextPath}/image?type=0&imagevalue=${article.id}" height="200" width="200">
<br><br>
<table id="newspaper-b" name="details">
<tr>
<td><spring:message code="label.article.title"/></td>
<td><c:out value="${article.title}"></c:out></td>
</tr>
<tr>
<td><spring:message code="label.article.description"/></td>
<td><c:out value="${article.desciption}"></c:out></td>
</tr>
<tr>
<td><spring:message code="label.article.contents"/></td>
<td><c:out value="${article.content}"></c:out></td>
</tr>
</table>
</body>
</html>