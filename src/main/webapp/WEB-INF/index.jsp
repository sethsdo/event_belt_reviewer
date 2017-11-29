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
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<!-- Compiled and minified CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
	
	<!-- Compiled and minified JavaScript -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
	<style>
		.form-control {
			border-radius: 0px;
			width: 100%;
			height: 50px;
		}
	
		h1 {
			text-align: center;
		}
	
		.btn {
			background-color: rgb(64, 139, 201);
			font-size: large;
		}
	
		.errors {
			color: red;
		}
	</style>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-6">
				<h1 style="margin-top:250px;">Welcome</h1>
				<hr>
			</div>
	
			<div class="col-xs-5">
				<h1 class="">Login</h1>
				<p class="errors">
					${errorMessage} ${loginMessage} ${logoutMessage}
				</p>
				<p style="color:green">
					${registered}
				</p>
				<form method="POST" action="/login">
					<p>
						<input class="form-control" placeholder="Email" type="text" id="username" name="username" />
					</p>
					<p>
						<input class="form-control" placeholder="Password" type="password" id="password" name="password" />
					</p>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="submit" class="btn btn-default form-control" value="Login!" />
				</form>
				<h1 class="">Register!</h1>
				<p class="errors">
					<form:errors path="user.*" /> ${error} ${error5}
				</p>
				<form:form method="POST" action="/registration" modelAttribute="user">
					<p>
						<form:input path="username" class="form-control" placeholder="Email" />
					</p>
					<p>
						<form:input path="firstName" class="form-control" placeholder="First Name" />
					</p>
					<p>
						<form:input path="lastName" class="form-control" placeholder="Last Name" />
					</p>
					<p>
						<form:password path="password" class="form-control" placeholder="Password" />
					</p>
					<p>
						<form:password path="passwordConfirmation" class="form-control" placeholder="Password Confirmation" />
					</p>
					<input type="submit" value="Register!" class="btn btn-default form-control" />
				</form:form>
			</div>
			<div class="col-xs-1"></div>
		</div>
</body>

</html>