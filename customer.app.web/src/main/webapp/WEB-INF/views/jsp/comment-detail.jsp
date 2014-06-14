<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<spring:url value="/resources/css/screen.css" var="resourceCmxUrl" />

<link rel="stylesheet" type="text/css" href="${resourceCmxUrl}" />

</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<img src="${contextPath}/image?type=0&imagevalue=${comments.article.id}" height="200" width="200">
	<br>
	<br>
	<table id="newspaper-b" name="details"
		style="table-layout: fixed; width: 100%">
		<tr>
			<td>Article Title</td>
			<td><c:out value="${comments.article.title}"></c:out></td>
		</tr>
		<tr>
			<td>Article Description</td>
			<td style="word-wrap: break-word"><c:out value="${comments.article.desciption}"></c:out></td>
		</tr>
		<tr>
			<td>Article Comments</td>
			<td style="word-wrap: break-word"><c:out value="${comments.article.content}"></c:out></td>
		</tr>
		<tr>
			<td>Article Created On</td>
			<td><c:out value="${comments.article.createdAt}"></c:out></td>
		</tr>
		<tr>
			<td>Rejected Comments</td>
			<td><c:out value="${rejectedComments}"></c:out></td>
		</tr>
		<tr>
			<td>Approved Comments</td>
			<td><c:out value="${approvedComments}"></c:out></td>
		</tr>
		<tr>
			<td>Total Comments</td>
			<td><c:out value="${totalComments}"></c:out></td>
		</tr>
		<tr>
			<td>Comment</td>
			<td style="word-wrap: break-word"><c:out
					value="${comments.comment}"></c:out></td>
		</tr>
		<tr>
			<td>First Name</td>
			<td><c:out value="${comments.user.firstName}"></c:out></td>
		</tr>
		<tr>
			<td>Last Name</td>
			<td><c:out value="${comments.user.lastName}"></c:out></td>
		</tr>
	</table>
</body>
</html>