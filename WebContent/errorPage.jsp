<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=utf-8" %>	<!--设置中文输出-->
<%@ page isErrorPage="true" %>
<html><head><title>错误页面</title></head>
<body>
	<p>
		服务器端发生错误:<%= exception.getMessage() %>
	</p>
	<p>
		错误原因为：<% exception.printStackTrace(new PrintWriter(out));%>
	</p>
</body>
</html>
