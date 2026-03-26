<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.net.URLDecoder"%>
<%
    Cookie[] cookies = request.getCookies();
    if(cookies == null)
        cookies = new Cookie[0];
    String name = "";
    String value = "";
    for(int i = 0; i < cookies.length; i ++)
    {
        Cookie cookie = cookies[i];
        if("KOAL_CERT_CN".equals(cookie.getName()))
        {
            name = "用户标识：";
            value = new String(URLDecoder.decode(cookie.getValue()).getBytes("ISO-8859-1"), "GBK");
            int strlen=value.length();
            value=value.substring(strlen-18,strlen);
        }else{
            continue;
        }
%>
<%= name %><%= value %>&nbsp;<BR>
<%     
    }
%>

<html>
  <head>
    <title>获取证件号码</title>
      <script type="text/javascript">
			var zjhm = "<%=value%>";
  	   </script>
  </head>
  <body onload="sfxxForm.submit();">
  <form action="<c:url value='/shuzhi.jsp'/>" id="sfxxForm" name="sfxxForm" method="post" style="display: none">
      <input type="hidden" id="cardnumber" name="cardnumber" value="<%= value %>"/>
  </form>
  </body>
  </html>
  

