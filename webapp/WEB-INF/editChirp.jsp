<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>edit chirp</title>
</head>
<body style="background-image:url('https://wallpaperaccess.com/full/6897524.jpg'); background-size: cover; background-attachment: fixed; background-repeat: no-repeat">
<div>
	<div class="container">
		<div class="d-flex justify-content-around">
	 		<h1>chirpit<span style="color: red">.</span></h1>
	 		<a href="/home">dashboard</a>
	 		<a href="/myChirps">your profile</a>			
			<a href="/logout">logout</a>
		</div>
		<div class="form-group">
			<form:form action="/${chirp.id}/updateChirp" method="post" modelAttribute="chirp">
				<input type="hidden" name="_method" value="put" />
				<form:input type="hidden" path="user" value="${user.id}" />
				<p>
				<form:label path="newChirp">edit chirp:</form:label>
				<form:errors path="newChirp" class="text-danger" />
				<form:input path="newChirp" class="form-control" />
				</p>
			<input type="submit" value="submit">
			</form:form>
		</div>
	</div>
</div>
</body>
</html>