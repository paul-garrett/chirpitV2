<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>login and registration</title>
</head>
<body style="background-image:url('https://wallpaperaccess.com/full/6897524.jpg');  background-size: cover; background-attachment: fixed; background-repeat: no-repeat">
<div>
	 <div class="container">
	 	<div>
	 		<h1>chirpit<span style="color: red">.</span></h1>
	 	</div>
	 	<div>
	 		<h4>the place on the internet for all of your hockey trash talk!</h4>
	 	</div>
	 	<h1>login:</h1>
    	<form:form action="/login" method="post" modelAttribute="newLogin">
        <div class="form-group">
            <label>email:</label>
            <form:input path="email" class="form-control" />
            <form:errors path="email" class="text-danger" />
        </div>
        <div class="form-group">
            <label>password:</label>
            <form:password path="password" class="form-control" />
            <form:errors path="password" class="text-danger" />
        </div>
        <input type="submit" value="Login" class="btn btn-success" />
    </form:form>
    
    <br />
    
    <h1>register:</h1>
    <form:form action="/register" method="post" modelAttribute="newUser">
        <div class="form-group">
            <label>user name:</label>
            <form:input path="userName" class="form-control" />
            <form:errors path="userName" class="text-danger" />
        </div>
         <div class="form-group">
            <label>first name:</label>
            <form:input path="firstName" class="form-control" />
            <form:errors path="firstName" class="text-danger" />
        </div>
         <div class="form-group">
            <label>last name:</label>
            <form:input path="lastName" class="form-control" />
            <form:errors path="lastName" class="text-danger" />
        </div>
        <div class="form-group">
            <label>email:</label>
            <form:input path="email" class="form-control" />
            <form:errors path="email" class="text-danger" />
        </div>
        <div class="form-group">
            <label>password:</label>
            <form:password path="password" class="form-control" />
            <form:errors path="password" class="text-danger" />
        </div>
        <div class="form-group">
            <label>confirm password:</label>
            <form:password path="confirm" class="form-control" />
            <form:errors path="confirm" class="text-danger" />
        </div>
        <input type="submit" value="Register" class="btn btn-primary" />
    </form:form>
	 
	 </div>
</div>
</body>
</html>