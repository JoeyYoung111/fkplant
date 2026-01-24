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
	    		<td colspan="10"><span class="showinfo_title">事件详情</span></td>
	  		</tr>
			<tr>
				<td width="10%" colspan="1">
					<strong>事件类别</strong>
				</td>
				<td width="40%" colspan="4">
					${contradictionInfo.cdttype}
				</td>
				<td width="10%" colspan="1">
					<strong>主要活动方式</strong>
				</td>
				<td width="40%" colspan="4">
					  ${contradictionInfo.cdtresult }
				</td>
			</tr>
			<tr>
				<td width="10%" colspan="1">
					<strong>事件名称</strong>
				</td>
				<td width="40%" colspan="4">
					  ${contradictionInfo.cdtname }
				</td>
				<td width="10%" colspan="1">
					<strong>涉及人数</strong>
				</td>
				<td width="40%" colspan="4">
					  ${contradictionInfo.ssrs }
				</td>
			</tr>
			<tr>
				<td width="10%" colspan="1">
					<strong>发生地点</strong>
				</td>
				<td width="90%" colspan="9">
					  ${contradictionInfo.sfdz }
				</td>
			</tr>
			<tr>
				<td width="10%" colspan="1">
					<strong>发生时间</strong>
				</td>
				<td width="20%" colspan="2">
					  ${contradictionInfo.memo }
				</td>
				<td width="10%" colspan="1">
					<strong>处置时间</strong>
				</td>
				<td width="20%" colspan="2">
					  ${contradictionInfo.examinetime }
				</td>
				<td width="10%" colspan="1">
					<strong>处置状态</strong>
				</td>
				<td width="30%" colspan="3">
					  ${contradictionInfo.examineopinion }
				</td>
			</tr>
			<tr>
				<td width="10%" colspan="1">
					<strong>情况经过</strong>
				</td>
				<td width="90%" colspan="9">
					  ${contradictionInfo.cdtcontent }
				</td>
			</tr>
			
			<c:if test="${personnum>0}">
				<tr>
					<td width="10%" rowspan="${personnum+1}">
						<strong>涉及人员</strong>
					</td>
					<td width="10%" colspan="1">
						<strong>姓名</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>证件号码</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>现住地</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>手机号码</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>处理措施</strong>
					</td>
				</tr>
				<c:forEach items="${plist}" var="row" varStatus="num">
					<tr>
						<td width="10%">
							<a onclick="showinfoPersonnelExtend(${row.id})" class="my-font-blue" style="cursor:pointer;">${row.personname}</a>
						</td>
						<td width="20%" colspan="2">
							<a onclick="showinfoPersonnelExtend(${row.id})" class="my-font-blue" style="cursor:pointer;">${row.cardnumber}</a>
						</td>
						<td width="20%" colspan="2">
							${row.homeplace}
						</td>
						<td width="20%" colspan="1">
							${row.telnumber}
						</td>
						<td width="20%" colspan="2">
							${row.deal}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${organizationnum>0}">
				<tr>
					<td width="10%" rowspan="${organizationnum+1}">
						<strong>涉及组织</strong>
					</td>
					<td width="30%" colspan="2">
						<strong>组织名称</strong>
					</td>
					<td width="60%" colspan="6">
						<strong>备注</strong>
					</td>
				</tr>
				<c:forEach items="${organizationlist}" var="row" varStatus="num">
					<tr>
						<td width="30%" colspan="3">
							${row.orgName}
						</td>
						<td width="60%" colspan="6">
							${row.memo}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${num>0}">
				<tr>
					<td width="10%" rowspan="${num+1}">
						<strong>涉及网络群组</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>群组类型</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>群组名称</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>群组ID</strong>
					</td>
				</tr>
				<c:forEach items="${organizationlist}" var="row" varStatus="num">
					<tr>
						<td width="30%" colspan="3">
							
						</td>
						<td width="30%" colspan="3">
							
							
						</td>
						<td width="30%" colspan="3">
							
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${num>0}">
				<tr>
					<td width="10%" rowspan="${num+1}">
						<strong>涉及场所</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>场所名称</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>场所地址</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>处理结果</strong>
					</td>
				</tr>
				<c:forEach items="${list}" var="row" varStatus="num">
					<tr>
						<td width="30%" colspan="3">
							
						</td>
						<td width="30%" colspan="3">
							
							
						</td>
						<td width="30%" colspan="3">
							
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${num>0}">
				<tr>
					<td width="10%" rowspan="${num+1}">
						<strong>涉及物品</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>物品类型</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>物品名称</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>处理结果</strong>
					</td>
				</tr>
				<c:forEach items="${list}" var="row" varStatus="num">
					<tr>
						<td width="30%" colspan="3">
							
						</td>
						<td width="30%" colspan="3">
							
							
						</td>
						<td width="30%" colspan="3">
							
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<tr>
				<td width="20%" colspan="2">
					<strong>管控民警</strong>
				</td>
				<td width="30%" colspan="3">
				
				</td>
				<td width="20%" colspan="2">
					<strong>联系电话(长号)</strong>
				</td>
				<td width="30%" colspan="3">
				
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
