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
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
   <body style="background-color:#FFFFFF;">
  	<div class="showinfo" id="print">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
		  <tr height="40" bgcolor="#3598DC">
		    <td colspan="4"><span class="showinfo_title">社会关系</span></td>
		  </tr>
				<tr>
					<td width="25%">
						<strong>获取来源：</strong>
					</td>
					<td width="25%">
						${socialrelations.gainorigin}
					</td>
					<td>
						<strong>关系类别：</strong>
					</td>
					<td>
						${socialrelations.relationtype}
					</td>
				</tr>
				<tr>
					<td>
						<strong>关系称谓：</strong>
					</td>
					<td>
						${socialrelations.appellation}<c:if test="${not empty socialrelations.memo}">(${socialrelations.memo})</c:if>
					</td>
					<td>
						<strong>身份证号：</strong>
					</td>
					<td>
						${socialrelations.cardnumber}
					</td>
				</tr>
				<tr>
					<td>
						<strong>姓名：</strong>
					</td>
					<td>
						${socialrelations.personname}
					</td>
					<td>
						<strong>现居地：</strong>
					</td>
					<td>
						${socialrelations.homeplace}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>工作单位：</strong>
					</td>
					<td>
						${socialrelations.workplace}
					</td>
					<td width="25%">
						<strong>联系电话1：</strong>
					</td>
					<td>
						${socialrelations.telnumber1}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>联系电话2：</strong>
					</td>
					<td>
						${socialrelations.telnumber2}
					</td>
					<td width="25%">
						<strong>联系电话3：</strong>
					</td>
					<td>
						${socialrelations.telnumber3}
					</td>
				</tr>
			</table>  
    </div>   
    <script type="text/javascript">
     </script>
  </body>
</html>
