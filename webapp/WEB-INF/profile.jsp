<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>your profile</title>
</head>
<body style="background-image: url('https://wallpaperaccess.com/full/6897524.jpg'); background-size: cover; background-attachment: fixed; background-repeat: no-repeat">
	<div>
		<div class="container">
			<div class="d-flex justify-content-around">
				<div>
					<h1>
						chirpit<span style="color: red">.</span>
					</h1>
				</div>
				<a href="/home">dashboard</a> <a href="/logout">logout</a>
			</div>
			<div>
				<h3>your profile:</h3>
			</div>
				<div class="row">
					<div class="col">
						<h4>
							user name:
							<c:out value="${user.getUserName()}" />
						</h4>
						<h4>
							first name:
							<c:out value="${user.getFirstName()}" />
						</h4>
						<h4>
							last name:
							<c:out value="${user.getLastName()}" />
						</h4>
						<h4>
							email:
							<c:out value="${user.getEmail()}" />
						</h4>
						<h5>total number of posts: <c:out value="${user.chirps.size()}"/></h5>
						<h5>total number of likes: <c:out value="${user.likedChirps.size()}"/></h5>
					</div>
					<div class="col">
						<h3>
							<c:out value="${user.getUserName()}" />
							's chirps:
						</h3>
						<c:forEach items="${chirps}" var="chirp">
							<c:if test="${chirp.getUser().id == user.id}">
								<div>
									<c:out value="${chirp.newChirp}" />
								</div>
								<div>
									<a href="/${chirp.id}/editChirp">edit</a>
									<form:form action="/${chirp.id}/deleteChirp" method="post"
										modelAttribute="chirp">
										<input type="hidden" name="_method" value="delete" />
										<input type="submit" value="delete">
									</form:form>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
		</div>
	</div> 
</body>
</html>