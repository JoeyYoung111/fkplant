<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html>
<head>
    <title>出错了！</title>
    <script type="text/javascript">
        function showErr() {
            if (document.all.showbtn.value == "显示详细信息") {
                document.all.errdiv.style.display = 'block';
                document.all.showbtn.value = "隐藏详细信息";
            } else {
                document.all.errdiv.style.display = 'none';
                document.all.showbtn.value = "显示详细信息";
            }
        }
    </script>
</head>
<body background="<%=request.getContextPath()%>/images/errorback.gif">
<table border="0" width="95%" height="95%" align="center">
    <tr>
        <td align="right" width="30%"><img src="<%=request.getContextPath()%>/images/404.jpg" alt="出错啦">
        </td>
        <td align="left"><h2><font color="red">很遗憾，好像出了点儿问题！</font></h2></td>
    </tr>
</table>
<%
    Exception ex = (Exception) request.getAttribute("exception");
    if (ex != null) {
%>
<%=ex.getMessage()%><br>
<input type="button" id="showbtn" value="显示详细信息" onclick="showErr();"/><br>
<table id="errdiv" align="center" bgcolor="darkseagreen" style="display:none;">
    <tr>
        <td><%ex.printStackTrace(new java.io.PrintWriter(out));%>&nbsp;</td>
    </tr>
</table>
<%}%>
</body>
</html>