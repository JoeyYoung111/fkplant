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
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   	<body style="background-color:#FFFFFF;">
  	<div class="showinfo">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
	  		<tr height="40" bgcolor="#3598DC">
	    		<td colspan="10"><span class="showinfo_title">政保阵地详情</span></td>
	  		</tr>
			<tr>
				<td width="10%">
					<strong>阵地类别</strong>
				</td>
				<td width="20%" colspan="2">
					${position.positiontype}
				</td>
				<td width="10%">
					<strong>名称</strong>
				</td>
				<td width="60%" colspan="6">
					${position.positionname}
				</td>
			</tr>
			<tr>
				<td width="10%">
					<strong>外文名称</strong>
				</td>
				<td width="20%" colspan="2">
					${position.foreignname}
				</td>
				<td width="10%">
					<strong>成立时间</strong>
				</td>
				<td width="20%" colspan="2">
					${position.setuptime}
				</td>
				<td width="10%">
					<strong>成立地点</strong>
				</td>
				<td width="30%" colspan="3">
					${position.setupplace}
				</td>
			</tr>
			<tr>
				<td width="10%">
					<strong>详细地址</strong>
				</td>
				<td width="90%" colspan="9">
					${position.address}
				</td>
			</tr>
			<tr>
				<td width="10%">
					<strong>占地面积</strong>
				</td>
				<td width="20%" colspan="2">
					${position.placearea}
				</td>
				<td width="10%">
					<strong>涉及人数</strong>
				</td>
				<td width="20%" colspan="2">
					${position.personnum}
				</td>
				<td width="10%">
					<strong>主管政府部门或单位</strong>
				</td>
				<td width="30%" colspan="3">
					${position.chargeunit}
				</td>
			</tr>
			<c:if test="${cardnum>0}">
				<tr>
					<td width="20%" colspan="2">
						<strong>登记证书名称</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>编号</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>有效期</strong>
					</td>
					<td width="40%" colspan="4">
						<strong>发证单位</strong>
					</td>
				</tr>
				<c:forEach items="${cardlist}" var="row" varStatus="num">
					<tr>
						<td width="20%" colspan="2">
							${row.cardname}
						</td>
						<td width="20%" colspan="2">
							${row.cardno}
						</td>
						<td width="20%" colspan="2">
							${row.validdate}
						</td>
						<td width="40%" colspan="4">
							${row.cardunit}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${personnelnum>0}">
				<tr>
					<td width="10%" rowspan="${personnelnum+1}">
						<strong>人员情况</strong>
					</td>
					<td width="10%">
						<strong>身份</strong>
					</td>
					<td width="10%">
						<strong>姓名</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>证件号码</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>现住地</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>手机号码</strong>
					</td>
				</tr>
				<c:forEach items="${personnellist}" var="row" varStatus="num">
					<tr>
						<td width="10%">
							${row.identity}
						</td>
						<td width="10%">
							<a onclick="showinfoPersonnelExtend(${row.personnelid})" class="my-font-blue" style="cursor:pointer;">${row.personname}</a>
						</td>
						<td width="20%" colspan="2">
							<a onclick="showinfoPersonnelExtend(${row.personnelid})" class="my-font-blue" style="cursor:pointer;">${row.cardnumber}</a>
						</td>
						<td width="30%" colspan="3">
							${row.homeplace}
						</td>
						<td width="20%" colspan="2">
							${row.telnumber}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${eventnum>0}">
				<tr>
					<td width="10%" rowspan="${eventnum+1}">
						<strong>主要活动情况</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>活动时间</strong>
					</td>
					<td width="60%" colspan="6">
						<strong>活动简况</strong>
					</td>
				</tr>
				<c:forEach items="${eventlist}" var="row" varStatus="num">
					<tr>
						<td width="30%" colspan="3">
							${row.eventTime}
						</td>
						<td width="60%" colspan="6">
							${row.eventInfo}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${worknum>0}">
				<tr>
					<td width="10%" rowspan="${worknum+1}">
						<strong>工作记录</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>时间</strong>
					</td>
					<td width="60%" colspan="6">
						<strong>工作情况</strong>
					</td>
				</tr>
				<c:forEach items="${worklist}" var="row" varStatus="num">
					<tr>
						<td width="30%" colspan="3">
							${row.workTime}
						</td>
						<td width="60%" colspan="6">
							${row.workInfo}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<tr>
				<td width="10%" rowspan="4">
					<strong>阵地概况</strong>
				</td>
				<td width="90%" colspan="9">
					<strong>简要描述阵地(场所)的历史、自然情况及主要活动情况</strong>
				</td>
			</tr>
			<tr>
				<td width="90%" rowspan="3" colspan="9">
					${position.positionsurvey}
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
			</tr>
			<tr>
				<td width="10%">
					<strong>管控单位</strong>
				</td>
				<td width="90%" colspan="9">
					${position.unitname}
				</td>
			</tr>
			<tr>
				<td width="10%">
					<strong>管控民警</strong>
				</td>
				<td width="40%" colspan="4">
					${position.policename}
				</td>
				<td width="10%">
					<strong>联系电话(长号)</strong>
				</td>
				<td width="40%" colspan="4">
					${position.jdphone}
				</td>
			</tr>
		</table>  
		<div style="height:150px;"></div>
    </div>
    <script type="text/javascript">
    	var locat = (window.location+'').split('/'); 
    	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
    	layui.use(['table','form'], function(){});
    	function showinfoPersonnelExtend(personnelid){
	    	console.log(locat)
		 	var index = layui.layer.open({
				title : "政保阵地人员详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getPersonnelExtendUpdate.do?personnelid='+personnelid+'&menuid=${menuid}&page=showinfoWhole',
				area: ['800', '650px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})			
			layui.layer.full(index);
		 }
    </script>   
  </body>
</html>
