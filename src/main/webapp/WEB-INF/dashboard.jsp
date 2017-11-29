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
		<!-- Compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
		
		<!-- Compiled and minified JavaScript -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
		<script>
			$('.datepicker').pickadate({
					selectMonths: true, // Creates a dropdown to control month
					selectYears: 15, // Creates a dropdown of 15 years to control year,
					today: 'Today',
					clear: 'Clear',
					close: 'Ok',
					closeOnSelect: false // Close upon selecting a date,
				});
			
		</script>
	</head>

	<body>
		<div style="float:right">
			<form id="logoutForm" method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="Logout!" class="btn  light-blue darken-2" />
			</form>
		</div>
		<div>
			<div class="brand-logo center">
				<h1>Welcome ${currentUser.firstName} ${currentUser.lastName}</h1>
			</div>
			<hr>
			<div class="row">
				<div class="grid-example col s12 m6">
					<form method="POST" action="/dashboard/newEvent/${currentUser.id}" >
						<div class="row">
							<div class="input-field col s12">
								<input type="text" id="name"  name="name" class="validate">
								<label for="name">Event Title:</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s12">
								<input type="date" id="date1" name="date" class="datepicker">
								<label for="date1"></label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s8">
								<input type="text" id="location" name="location" class="validate">
								<label for="location">Enter Location</label>
							</div>
							<div class="input-field col s4">
								<div>
									<select name="state" class="form-control">
										<c:forEach items="${states}" var="state">
											<option value="${state}">${state}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button type="submit" class="btn  light-blue darken-2">Submit</button>
					</form>
				</div>
				<div class="grid-example col s12 m6">


					<div class="card small  blue-grey lighten-3">
						<div class="card-content black-text">
							<p>Here are some events in your state:</p>
							<table class="bordered">
								<thead>
									<tr>
										<th>Name</th>
										<th>Date</th>
										<th>Location</th>
										<th>Host</th>
										<th>Action | Status</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${events}" var="event">
										<c:if test="${currentUser.state == event.state}">
											<tr>
												<td>
													<a href="/user/${currentUser.id}/event/${event.id}">${event.name}</a>
												</td>
												<td>
													<fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}" />
												</td>
												<td>${event.location} ${event.state} </td>
												<td>${event.user.firstName}</td>
												<c:if test="${currentUser.id == event.user.id}">
													<td >
														<a type="button" data-toggle="modal" data-target="#myModal${event.id}">Update</a> | 
														<a href="/event/delete/${event.id}">Delete</a>
													</td>
												</c:if>
												<c:if test="${currentUser.id != event.user.id}">
													<td>
														<p>
															<a href="/event/${event.id}/join/${currentUser.id}">Join</a> |
															<a href="/event/${event.id}/cancel/${currentUser.id}">Cancel</a>
														</p>
													</td>
												</c:if>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>


					<div class="card small  blue-grey lighten-3">
						<div class="card-content black-text">
							<p>Here are some events in other states:</p>
							<table class="bordered">
								<thead>
									<tr>
										<th>Name</th>
										<th>Date</th>
										<th>Location</th>
										<th>Host</th>
										<th>Action | Status</th>
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
													<td>
														<fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}" />
													</td>
													<td>${event.location} ${event.state} </td>
													<td>${event.user.firstName}</td>
													<c:if test="${currentUser.id == event.user.id}">
														<td> 
															<p>
																<a type="button" data-toggle="modal" data-target="#myModal${event.id}">Update</a> | 
																<a href="/event/delete/${event.id}">Delete</a>
															</p>
														</td>
													</c:if>
													<c:if test="${currentUser.id != event.user.id}">
														<td>
															<c:if test="${event.users.isEmpty()}">
																<td>
																	<p>
																		<a href="/event/${event.id}/join/${currentUser.id}">Join</a> | <a href="/event/${event.id}/cancel/${currentUser.id}">Cancel</a>
																	</p>
																</td>
															</c:if>
															<c:forEach items="${event.users}" var="user">
																<c:if test="${currentUser.id == user.id}">
																	<p>Joining </p> |
																</c:if>
																<c:if test="${currentUser.id != user.id}">
																	<a href="/event/${event.id}/join/${currentUser.id}">Join </a> | 
																</c:if>
															</c:forEach>
															<a href="/event/${event.id}/cancel/${currentUser.id}">Cancel </a>
														</td>
													</c:if>
												</tr>
											</c:if>
										</c:forEach>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<hr>

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