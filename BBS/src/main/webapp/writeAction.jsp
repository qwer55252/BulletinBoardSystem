<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="src.bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="src.bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> JSP 게시판 웹사이트 </title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) { // 로그인이 안 되어 있으면
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'"); // 로그인이 안 된 사람은 로그인 페이지로 이동 
			script.println("</script>");
		} 
		else {// 로그인이 되어있다면
			if( bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { // 사용자가 게시판의 제목 혹은 글을 쓰지 않은 경우 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");  
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				
				if (result == -1) { 
					PrintWriter script = response.getWriter(); 
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");  
					script.println("history.back()");
					script.println("</script>");
				}
				else { // 성공적으로 글을 작성한 경우 
					PrintWriter script = response.getWriter(); 
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");  
					script.println("</script>");
				}
			}
		}
		
	%>
</body>
</html>