<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> JSP 게시판 웹사이트 </title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) { // 로그인 성공 
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); // 로그인 성공시 main 웹페이지로 이동 
			script.println("</script>");
		}
		else if (result == 0) { // 비밀번호 틀린 경우  
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");  
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1) { // 아이디가 존재하지 않는 경우   
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");  
			script.println("history.back()"); 
			script.println("</script>");
		}
		else if (result == -2) { // 데이터베이스 오류인 경우
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");  
			script.println("histroy.back()");
			script.println("</script>");
		}
	%>
</body>
</html>