<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>post likes</title>
</head>
<body style="background-image: url('https://wallpaperaccess.com/full/6897524.jpg'); background-size: cover; background-attachment: fixed; background-repeat: no-repeat">
	<div>
	<div class="container">
		<div class="d-flex justify-content-around">
			<h1>chirpit<span style="color: red">.</span></h1>
			<a href="/myChirps">your profile</a>
			<a href="/home">dashboard</a>
			<a href="/logout">logout</a>
		</div>
		<div>
			<h3><c:out value="${chirp.user.getName()}" /> chirped:  </h3>
		</div>
	</div>
	</div>
</body>
</html>