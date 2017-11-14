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
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-6">
				<h1>Login</h1>
				<p>
					${errorMessage} ${loginMessage} ${logoutMessage} ${registered}
				</p>
				<form method="POST" action="/login">
					<p>
						<label for="username">Email</label>
						<input type="text" id="username" name="username" />
					</p>
					<p>
						<label for="password">Password</label>
						<input type="password" id="password" name="password" />
					</p>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="submit" value="Login!" />
				</form>
			</div>
			<div class="col-xs-6">
				<h1>Register!</h1>

				<p>
					<form:errors path="user.*" />
				</p>

				<form:form method="POST" action="/registration" modelAttribute="user">
					<p>
						<form:label path="firstName">First Name:</form:label>
						<form:input path="firstName" />
					</p>
					<p>
						<form:label path="lastName">Last Name:</form:label>
						<form:input path="lastName" />
					</p>
					<p>
						<form:label path="username">Email:</form:label>
						<form:input path="username" />
					</p>
					<p>
						<form:label path="location">Location:</form:label>
						<form:input path="location" />
					</p>
					<p>
						<form:label path="state">State:</form:label>

						<form:select path="state">
							<c:forEach items="${states}" var="state">

								<form:option value="${state}">${state}</form:option>
							</c:forEach>
						</form:select>
					</p>
					<p>
						<form:label path="password">Password:</form:label>
						<form:password path="password" />
					</p>
					<p>
						<form:label path="passwordConfirmation">Password Confirmation:</form:label>
						<form:password path="passwordConfirmation" />
					</p>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="submit" value="Register!" />
				</form:form>
			</div>
		</div>
	</div>
</body>

</html>