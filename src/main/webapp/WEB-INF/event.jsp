<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Index</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<!-- <link rel="stylesheet" type="text/css" href="/css/style.css"> -->
		<!-- Compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
		
		<!-- Compiled and minified JavaScript -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
	</head>

	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-6">
					<h1>${event.name}</h1>
					<p>Host: ${event.user.firstName} ${event.user.lastName}</p>
					<p>Date: <fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}" /></p>
					<p>Location: ${event.location}</p>
					<p>People who are attending this event: ${size}</p>
					<table class="table">
						<thead>
							<tr>
								<th>Name</th>
								<th>Location</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${event.users}" var="user">
							<tr>
								<td>${user.firstName} ${user.firstName}</td>
								<td>${user.location}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="col-xs-6">
					<h1>Message Wall  |  <a href="/dashboard">Dashboard</a></h1>
					<div name="message" class="col-xs-12" style="height:300px; border: 1px solid black;">
						<c:forEach items="${messages}" var="message">
							<c:if test="${message.event.id == event.id}">
							<p>${message.user.firstName} ${message.user.lastName} - ${message.message}</p>
							</c:if>
						</c:forEach>
					</div>
					<form class="form-inline" method="POST" action="/user/${user.id}/event/${event.id}/post/${user.id}">
						<div class="form-group">
							<label class="sr-only" for="message">Message:</label>
							<input type="message" class="form-control" id="message" placeholder="Enter message" name="message">
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button type="submit" class="btn btn-primary">Post</button>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>