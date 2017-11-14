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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!-- <link rel="stylesheet" type="text/css" href="/css/style.css"> -->
	</head>

	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-6">
					<h1>Welcome ${currentUser.firstName} ${currentUser.lastName}</h1>
				</div>
				<div class="col-xs-6" style="margin-top: 30px;">
					<form id="logoutForm" method="POST" action="/logout" style="float:right;">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="submit" value="Logout!" class="btn btn-primary"/>
					</form>
				</div>
			</div>
			<hr>
			<p>Here are some events in your state:</p>
			<table class="table">
				<thead>
					<tr>
						<th>Name</th>
						<th>Date</th>
						<th>Location</th>
						<th>Host</th>
						<th>Action / Status</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${events}" var="event">
					<c:if test="${currentUser.state == event.state}">
					<tr>
						<td><a href="/user/${currentUser.id}/event/${event.id}">${event.name}</a></td>
						<td><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}" /></td>
						<td>${event.location} ${event.state} </td>
						<td>${event.user.firstName}</td>
						<c:if test="${currentUser.id == event.user.id}">
							<td>
								<button type="button" class="btn btn-info btn-link" data-toggle="modal" data-target="#myModal${event.id}">Update</button>
								<a href="/event/delete/${event.id}">Delete</a>
							</td>
						</c:if>
						<c:if test="${currentUser.id != event.user.id}">
							<td>
								<a href="/event/${event.id}/join/${currentUser.id}">Join</a>
								<a href="/event/${event.id}/cancel/${currentUser.id}">Cancel</a>
							</td>
						</c:if>
					</tr>
					</c:if>
					</c:forEach>
				</tbody>
			</table>

			<p>Here are some events in other states:</p>
			<table class="table">
				<thead>
					<tr>
						<th>Name</th>
						<th>Date</th>
						<th>Location</th>
						<th>Host</th>
						<th>Status / Action</th> 
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach items="${events}" var="event">
							<c:if test="${currentUser.state != event.state}">
							<tr>
								<td>
									<a href="/user/${currentUser.id}/event/${event.id}">${event.name}</a>
								</td>
								<td><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}" /></td>
								<td>${event.location} ${event.state} </td>
								<td>${event.user.firstName}</td>
								<c:if test="${currentUser.id == event.user.id}">
									<td>
										<button type="button" class="btn btn-info btn-link" data-toggle="modal" data-target="#myModal${event.id}">Update</button>
										<a href="/event/delete/${event.id}">Delete</a>
									</td>
								</c:if>
								<c:if test="${currentUser.id != event.user.id}">
									<td>
										<c:if test="${event.users.isEmpty()}">
											<td>
												<a href="/event/${event.id}/join/${currentUser.id}">Join</a>
												<a href="/event/${event.id}/cancel/${currentUser.id}">Cancel</a>
											</td>
										</c:if>
										<c:forEach items="${event.users}" var="user">
											<c:if test="${currentUser.id == user.id}">
												<p>Joining </p>
											</c:if>
											<c:if test="${currentUser.id != user.id}">
												<a href="/event/${event.id}/join/${currentUser.id}">Join </a>
											</c:if>
										</c:forEach>
										<a href="/event/${event.id}/cancel/${currentUser.id}">Cancel  </a>
									</td>
								</c:if>
							</tr>
							</c:if>
						</c:forEach>
					</tr>
				</tbody>
			</table>
			<form class="form-inline" method="POST" action="/dashboard/newEvent/${currentUser.id}">
				<div class="form-group">
					<label class="sr-only" for="name">name:</label>
					<input type="name" class="form-control" id="name" placeholder="Enter event name" name="name">
				</div>
				<div class="form-group">
					<label class="sr-only" for="date">Date</label>
					<input type="date" class="form-control" id="date" placeholder="Enter Date" name="date">
				</div>
				<div class="form-group">
					<label class="sr-only" for="location">Location</label>
					<input type="location" class="form-control" id="loction" placeholder="Enter Location" name="location">
					<select name="state" class="form-control">
						<c:forEach items="${states}" var="state">
							<option value="${state}">${state}</option>
						</c:forEach>
					</select>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>

			<c:forEach items="${events}" var="event">
				<div class="modal fade" id="myModal${event.id}" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Update ${event.name}</h4>
							</div>
							<div class="modal-body">
								<form class="form-inline" method="POST" action="/event/update/${event.id}">
									<div class="form-group">
										<label class="sr-only" for="name">name:</label>
										<input type="name" class="form-control" id="name" placeholder="Enter event name" name="name">
									</div>
									<div class="form-group">
										<label class="sr-only" for="date">Date</label>
										<input type="date" class="form-control" id="date" placeholder="Enter Date" name="date">
									</div>
									<div class="form-group">
										<label class="sr-only" for="location">Location</label>
										<input type="location" class="form-control" id="loction" placeholder="Enter Location" name="location">
										<select name="state" class="form-control">
											<c:forEach items="${states}" var="state">
												<option value="${state}">${state}</option>
											</c:forEach>
										</select>
									</div>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<button type="submit" class="btn btn-primary">Submit</button>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</body>
</html>