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
		    <td colspan="4"><span class="showinfo_title">公共管控力量</span></td>
		  </tr>
				<tr>
					<td width="25%">
						<strong>姓名：</strong>
					</td>
					<td width="25%">
						${kongcontrolpower.personname}
					</td>
					<td>
						<strong>性别：</strong>
					</td>
					<td>
						${kongcontrolpower.sexes}
					</td>
				</tr>
				<tr>
					<td>
						<strong>兴趣爱好：</strong>
					</td>
					<td>
						${kongcontrolpower.interesting}
					</td>
					<td>
						<strong>特殊技能：</strong>
					</td>
					<td>
						${kongcontrolpower.speciality}
					</td>
				</tr>
				<tr>
					<td>
						<strong>党派职务：</strong>
					</td>
					<td>
						${kongcontrolpower.partyduty}
					</td>
					<td>
						<strong>职务：</strong>
					</td>
					<td>
						${kongcontrolpower.duty}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>别名绰号：</strong>
					</td>
					<td>
						${kongcontrolpower.nickname}
					</td>
					<td width="25%">
						<strong>文化程度：</strong>
					</td>
					<td>
						${kongcontrolpower.education}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>出生年月：</strong>
					</td>
					<td>
						${kongcontrolpower.birthdate}
					</td>
					<td width="25%">
						<strong>电话：</strong>
					</td>
					<td>
						${kongcontrolpower.telephone}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>家庭住址：</strong>
					</td>
					<td>
						${kongcontrolpower.address}
					</td>
					<td width="25%">
						<strong>工作单位：</strong>
					</td>
					<td>
						${kongcontrolpower.workunit}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>前科情况：</strong>
					</td>
					<td  colspan="3">
						${kongcontrolpower.records}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>现实表现：</strong>
					</td>
					<td  colspan="3">
						${kongcontrolpower.actualstate}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>建立的目的和任务：</strong>
					</td>
					<td  colspan="3">
						${kongcontrolpower.purposetask}
					</td>
				</tr>
			</table>  
    </div>   
    <script type="text/javascript">
     </script>
  </body>
</html>
