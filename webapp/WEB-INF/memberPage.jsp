<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>member page</title>
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
		<div>
			<h3><c:out value="${member.getUserName()}" />'s chirps:</h3>
				<c:forEach items="${member.chirps}" var="chirp">
					<p>
					<c:out value="${chirp.newChirp}" />
					</p>
					<div>
						<c:if test="${!user.isChirpLiked(chirp)}">
									 <form:form action="/like" method="post">
										<input type="hidden" name="chirp" value="${chirp.id}"/>
										<input type="hidden" name="id" value="${member.id}"/>
										<input type="hidden" name="source" value="memberPage.jsp"/>	
										<button>like</button>
									</form:form>
						</c:if>
						<c:if test="${user.isChirpLiked(chirp)}">
									 <form:form action="/dislike" method="post">
										<input type="hidden" name="chirp" value="${chirp.id}"/>
										<input type="hidden" name="id" value="${member.id}"/>
										<input type="hidden" name="source" value="memberPage.jsp"/>	
										<button>dislike</button>
									</form:form>
						</c:if>
									<h6>likes: <c:out value="${chirp.likes.size()}"/></h6>
								</div>
				</c:forEach>
			
			<br />
			<h5>total number of posts: <c:out value="${member.chirps.size()}"/></h5>
			<h5>total number of likes: <c:out value="${member.getCountOfLikedChirps()}"/></h5>
		</div>
	</div>
</div>	
</body>
</html>