<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1> Logout Page</h1>
	
	<form action="/customLogout" method="post">
		<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
		<button>로그아웃</button>
	</form>
</body>
</html>