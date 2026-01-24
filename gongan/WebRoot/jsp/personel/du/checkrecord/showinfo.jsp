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
		    <td colspan="4"><span class="showinfo_title">联控记录</span></td>
		  </tr>
				<tr>
					<td width="25%">
						<strong>检查类型：</strong>
					</td>
					<td width="25%">
						${ducheckrecord.checktype}
					</td>
					<td>
						<strong>检查时间：</strong>
					</td>
					<td>
						${ducheckrecord.checktime}
					</td>
				</tr>
				<tr>
					<td>
						<strong>检查单位：</strong>
					</td>
					<td>
						${ducheckrecord.checkunit}
					</td>
					<td>
						<strong>采集人：</strong>
					</td>
					<td>
						${ducheckrecord.checkman}
					</td>
				</tr>
				<tr>
					<td>
						<strong>内容：</strong>
					</td>
					<td colspan="3">
						${ducheckrecord.checkcontent}
					</td>
				</tr>
				<tr>
					<td>
						<strong>创建人：</strong>
					</td>
					<td>
						${ducheckrecord.addoperator}
					</td>
					<td width="25%">
						<strong>创建时间：</strong>
					</td>
					<td>
						${ducheckrecord.addtime}
					</td>
				</tr>
				<tr>
					<td>
						<strong>修改人：</strong>
					</td>
					<td>
						${ducheckrecord.updateoperator}
					</td>
					<td >
						<strong>修改时间：</strong>
					</td>
					<td>
						${ducheckrecord.updatetime}
					</td>
				</tr>
			</table>  
    </div>   
    <script type="text/javascript">
     </script>
  </body>
</html>
