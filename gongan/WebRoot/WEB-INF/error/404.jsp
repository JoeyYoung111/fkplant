<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>出错了！</title>
</head>
<body background="<%=request.getContextPath()%>/images/errorback.gif">
<table border="0" width="95%" height="95%" align="center">
    <tr>
        <td align="right" width="30%"><img src="<%=request.getContextPath()%>/images/404.jpg" alt="出错啦">
        </td>
        <td align="left"><h2><font color="red">对不起，您访问的页面不存在！</font></h2></td>
    </tr>
</table>
<br>
<jsp:forward page="/login.jsp"></jsp:forward>
</body>
</html>
