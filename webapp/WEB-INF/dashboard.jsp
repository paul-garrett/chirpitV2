<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>dashboard</title>
</head>
<body style="background-image:url('https://wallpaperaccess.com/full/6897524.jpg'); background-size: cover; background-attachment: fixed; background-repeat: no-repeat">
<div>
	<div class="container">
		<div class="d-flex justify-content-around">
			<h1>hi <c:out value="${user.userName}" />! welcome to chirpit<span style="color: red">.</span></h1>
				<a href="/myChirps">your profile</a>
				<a href="/logout">logout</a>
			</div>
			<div class="form-group justify-content-around  col-md-8">
				<form:form action="/createChirp" method="post" modelAttribute="chirp">
					<form:input type="hidden" path="user" value="${user.id}"  />
						<p>
						<form:label path="newChirp">post new chirp: </form:label>
						<form:errors path="newChirp" class="text-danger" />
						<form:input path="newChirp" class="form-control" />
						</p>
						<input type="submit">
				</form:form>
			</div>
			<div>
				<h3>latest chirps:</h3>
			</div>
				<div>
				<c:if test="${!chirps.isEmpty()}"> 
					<c:forEach items="${allChirps}" var="chirp">				
					<div>
						<p>
						<a href="${chirp.getUser().id}/memberPage"><c:out value="${chirp.user.getUserName()}" /></a>:
						<c:out value="${chirp.newChirp}" />
						</p>
						<c:if test="${chirp.user.id == user.id}">
							<div>
								<h6>likes: <c:out value="${chirp.likes.size()}"/></h6>
							</div>
						</c:if>
					</div>
						<c:if test="${chirp.user.id != user.id}">
							<c:forEach items="${chirp.likes}" var="like">
								<c:choose>
									<c:when test="${user.likedChirps.contains(like)}">
										<div>
											<form action="/dislike" method="post">
											<input type="hidden" name="chirp" value="${chirp.id}"/>
											<input type="hidden" name="source" value="dashboard.jsp"/>	
											<button>dislike</button>
											</form>
											<h6>likes: <c:out value="${chirp.likes.size()}"/></h6>
										</div>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:forEach items="${chirp.likes}" var="like">
								<c:set var="isLiked" value="true"></c:set>
									<c:choose>
										<c:when test="${user.likedChirps.contains(like)}">
											<c:set var="isLiked" value="false"></c:set>
										</c:when>
									</c:choose>
							</c:forEach>
							<c:if test="${isLiked||chirp.likes.isEmpty()}">
								<div>
									 <form:form action="/like" method="post">
										<input type="hidden" name="chirp" value="${chirp.id}"/>
										<input type="hidden" name="source" value="dashboard.jsp"/>
										<button>like</button>
									</form:form>
									<h6>likes: <c:out value="${chirp.likes.size()}"/></h6>
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				</c:if>
				</div> 
			<%-- <div>
				<c:forEach items="${allChirps}" var="chirp">
					<p>
					<a href="${chirp.getUser().id}/memberPage"><c:out value="${chirp.user.getUserName()}" /></a>:
					<c:out value="${chirp.newChirp}" />
					</p>
				</c:forEach>
			</div>  --%>
	</div>
</div>
</body>
</html>