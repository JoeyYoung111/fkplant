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
	    		<td colspan="10"><span class="showinfo_title">政保组织详情</span></td>
	  		</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>组织级别</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.orgType}
				</td>
				<td width="20%" colspan="2">
					<strong>组织类别</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.orgClass}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>名称</strong>
				</td>
				<td width="80%" colspan="8">
					${organization.orgName}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>外文名称</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.orgForeignName}
				</td>
				<td width="20%" colspan="2">
					<strong>是否与境外存在勾连</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.isForeignConnections}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>是否省内组织</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.inProvince}
				</td>
				<td width="20%" colspan="2">
					<strong>是否登记注册</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.isRegister}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>成立时间</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.createTime}
				</td>
				<td width="20%" colspan="2">
					<strong>成立地点</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.createAddress}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>详细地址</strong>
				</td>
				<td width="80%" colspan="8">
					${organization.address}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>活跃程度</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.activeLevel}
				</td>
				<td width="20%" colspan="2">
					<strong>活动范围</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.activeRange}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>活动方式</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.activeWay}
				</td>
				<td width="20%" colspan="2">
					<strong>活动方式简要描述</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.activeWayDetails}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>财务状况</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.finance}
				</td>
				<td width="20%" colspan="2">
					<strong>接受资助请情况</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.subsidize}
				</td>
			</tr>
			
			<c:if test="${personnum>0}">
				<tr>
					<td width="10%" rowspan="${personnum+1}">
						<strong>人员情况</strong>
					</td>
					<td width="10%" colspan="1">
						<strong>身份</strong>
					</td>
					<td width="10%" colspan="1">
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
				<c:forEach items="${plist}" var="row" varStatus="num">
					<tr>
						<td width="10%">
							${row.identity}
						</td>
						<td width="10%">
							<a onclick="showinfoPersonnelExtend(${row.personnelid})" class="my-font-blue" style="cursor:pointer;">${row.personName}</a>
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
			
			<tr>
				<td width="20%" colspan="2">
					<strong>组织概况</strong>
				</td>
				<td width="80%" colspan="8">
					${organization.orgGeneral}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>政治主张及利益诉求</strong>
				</td>
				<td width="80%" colspan="8">
					${organization.proposition}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>管控单位</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.unitname}
				</td>
				<td width="20%" colspan="2">
					<strong>管控民警</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.policename}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>管控时间</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.controlTime}
				</td>
				<td width="20%" colspan="2">
					<strong>联系电话(长号)</strong>
				</td>
				<td width="30%" colspan="3">
					${organization.controlPhone}
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
