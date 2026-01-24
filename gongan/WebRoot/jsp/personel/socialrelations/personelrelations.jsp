<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  
   <body style="background-color:#FFFFFF;">
  	<div class="showinfo" id="print">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
		  <tr height="40" bgcolor="#3598DC">
		    <td colspan="4"><span class="showinfo_title">与风险人员社会关系</span></td>
		  </tr>
		  <c:forEach items="${socialrelations_list}" var="row" varStatus="num">
				<tr>
					<td width="10%">${num.index+1}</td>
					<td width="90%">
						${row.personname}【${row.cardnumber}】的${row.appellation}<c:if test="${not empty row.memo}">(${row.memo})</c:if>
					</td>
				</tr>
			</c:forEach>	
			</table>  
    </div>   
  </body>
</html>
