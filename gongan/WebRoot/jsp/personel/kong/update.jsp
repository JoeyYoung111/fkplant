<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserSession userSession = (UserSession) session.getAttribute("userSession");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     <title>风险人员修改-涉恐</title>
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	 <link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
	 <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
	<style>
	    .layui-table-fixed .layui-table-body{
	    	display:none;
	    }
	    .layui-table-fixed .layui-table-header{
	    	display:none;
	    }
	    .my-tab-title li {
			  width:15%
		}
	    .layui-form-checkbox {
		    position: relative;
		    height: 30px;
		    line-height: 30px;
		    margin-right: 10px;
		    padding-right: 30px;
		    cursor: pointer;
		    font-size: 0;
		    -webkit-transition: .1s linear;
		    transition: .1s linear;
		    box-sizing: border-box;
		    margin-top:20px;
		}
   		.layui-form-checkbox span {
		    padding: 0 10px;
		    /* height: 100%; */
		    font-size: 14px;
		    border-radius: 2px 0 0 2px;
		    background-color: #4898ed;
		    color: #fff;
		    overflow: hidden;
		    white-space: nowrap;
		    text-overflow: ellipsis;
<%--		    width: 100px;--%>
		    text-align: center;
		}
		.layui-form-checked span, .layui-form-checked:hover span {
		    background-color: #5FB878;
		}
	</style>
  </head>
 <body class="childrenBody layui-fluid">
		
		<div class="layui-form  layui-row">
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<form class="layui-form" method="post" id="formheipersonel">
					<input type="hidden"  name="menuid"   id="menuid" value=${menuid }>
					<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
					<input type="hidden"  name="zslabel1"    id="zslabel1"  value=${personnel.zslabel1 }>
					<input type="hidden"  name="kongextendid"id="kongextendid" value=${kongextend.id }>
					<input type="hidden"  name="checkmethods"id="checkmethods" value="${personnel.checkmethod }">
					<input type="hidden"  name="personlabel"id="personlabel" value="${personnel.personlabel }">
					<input type="hidden"  name="jdunit1" value="${personnel.jdunit1 }">
					<input type="hidden"  name="jdpolice1" value="${personnel.jdpolice1 }">
					<input type="hidden"  name="pphone1" value="${personnel.pphone1 }">
					<input type="hidden"  name="jdunit2" value="${personnel.jdunit2 }">
					<input type="hidden"  name="jdpolice2" value="${personnel.jdpolice2 }">
					<input type="hidden"  name="pphone2" value="${personnel.pphone2 }">
					<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 5px;">
						<div class="layui-inline layui-col-md12">
							<label class="layui-form-label layui-font-blue">基本信息</label>
						</div>
						<div class=" my-onload-img layui-col-md2" style="height: 260px;">
							<img id="defaultPhoto">
							<a class="my-font-blue" style="text-decoration: underline;cursor:pointer;" onclick="openPhotos()"><font color="red" size=2>*</font> 编 辑</a>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">身份证号：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" style="background:#efefef"
										value="${personnel.cardnumber}" readonly class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">姓名：</label>
								<div class="layui-input-block">
									<input type="text" name="personname" autocomplete="off" value="${personnel.personname}" class="layui-input" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">style="background:#efefef" readonly</c:if>>
								</div>
							</div>
						</div>
	
		              <div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">性别：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" style="background:#efefef"
										value="${personnel.sexes}" readonly class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">年龄：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" style="background:#efefef"
										value="${age}" readonly class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">曾用名：</label>
								<div class="layui-input-block">
									<input type="text" name="usedname" lay-verify="" autocomplete="off"
										value="${personnel.usedname}" placeholder="请输入曾用名" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">绰号：</label>
								<div class="layui-input-block">
									<input type="text" name="nickname" lay-verify="" autocomplete="off"
										value="${personnel.nickname}" placeholder="请输入绰号" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">身高：</label>
								<div class="layui-input-block">
									<input type="text" name="personheight" lay-verify="" autocomplete="off"
										value="${personnel.personheight}" placeholder="请输入身高" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">婚姻状况：</label>
								<div class="layui-input-block">
									<select name="marrystatus">
										<option value="">==请选择==</option>
										<c:forEach items="${marrystatus}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.marrystatus }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">民族：</label>
								<div class="layui-input-block">
									<select name="nation" lay-search>
										<option value="">==请选择==</option>
										<c:forEach items="${nation}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.nation }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">人员类别：</label>
								<div class="layui-input-block">
									<select name="persontype">
										<option value="">==请选择==</option>
										<c:forEach items="${persontype}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.persontype }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">兵役状况：</label>
								<div class="layui-input-block">
									<select name="soldierstatus">
										<option value="">==请选择==</option>
										<c:forEach items="${soldierstatus}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.soldierstatus }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">健康状态：</label>
								<div class="layui-input-block">
									<select name="heathstatus">
										<option value="">==请选择==</option>
										<c:forEach items="${heathstatus}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.heathstatus }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">政治面貌：</label>
								<div class="layui-input-block">
									<select name="politicalposition">
										<option value="">==请选择==</option>
										<c:forEach items="${politicalposition}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.politicalposition }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">宗教信仰：</label>
								<div class="layui-input-block">
									<select name="faith">
										<option value="">==请选择==</option>
										<c:forEach items="${faith}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.faith }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
	
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">文化程度：</label>
								<div class="layui-input-block">
									<select name="education">
										<option value="">==请选择==</option>
										<c:forEach items="${education}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnel.education }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">网络社交技能习惯：</label>
								<div class="layui-input-block">
									<select name="netskillhabit">
										<option value=""    <c:if test="${personnel.netskillhabit eq ''}">selected</c:if>>==请选择==</option>
										<option value="有" <c:if test="${personnel.netskillhabit eq '有'}">selected</c:if>>有</option>
										<option value="无" <c:if test="${personnel.netskillhabit eq '无'}">selected</c:if>>无</option>
									</select>
								</div>
							</div>
						</div>
	
	                   <div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">户籍地详址：</label>
								<div class="layui-input-block">
									<input type="text" name="houseplace" lay-verify="" autocomplete="off"
									value="${personnel.houseplace}" placeholder="请输入户籍地详址" class="layui-input" id="houseplace" onclick="openPGis('house','户籍地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">户籍地派出所：</label>
								<div class="layui-input-block">
									<div id="housepolice"></div>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">户籍地经度：</label>
								<div class="layui-input-block">
									<input type="text" name="housex" lay-verify="" autocomplete="off"
									value="${personnel.housex}" class="layui-input" id="housex" onclick="openPGis('house','户籍地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">户籍地纬度：</label>
								<div class="layui-input-block">
									<input type="text" name="housey" lay-verify="" autocomplete="off"
									value="${personnel.housey}" class="layui-input" id="housey" onclick="openPGis('house','户籍地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">现住地详址：</label>
								<div class="layui-input-block">
									<input type="text" name="homeplace" lay-verify="" autocomplete="off"
									value="${personnel.homeplace}" placeholder="请输入现住地详址" class="layui-input" id="homeplace" onclick="openPGis('home','现住地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">现住地派出所：</label>
								<div class="layui-input-block">
									<div id="homepolice"></div>
								</div>
							</div>
						</div>
						<div class="layui-col-md2">
							<div class="layui-form-item my-form-item">
								<div class="layui-input-inline">
									<input type="checkbox" name="homewifi"  
										value="1"
										<c:if test="${personnel.homewifi eq 1}">checked</c:if>
										title="wifi" lay-skin="primary"/>
									<input type="checkbox" name="homewide"  
										value="1"
										<c:if test="${personnel.homewide eq 1}">checked</c:if>
										title="宽带" lay-skin="primary"/>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">现住地经度：</label>
								<div class="layui-input-block">
									<input type="text" name="homex" lay-verify="" autocomplete="off"
									value="${personnel.homex}" class="layui-input" id="homex" onclick="openPGis('home','户籍地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">现住地纬度：</label>
								<div class="layui-input-block">
									<input type="text" name="homey" lay-verify="" autocomplete="off"
									value="${personnel.homey}" class="layui-input" id="homey" onclick="openPGis('home','户籍地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">工作地详址：</label>
								<div class="layui-input-block">
									<input type="text" name="workplace" lay-verify="" autocomplete="off"
									value="${personnel.workplace}" placeholder="请输入工作地详址" class="layui-input" id="workplace" onclick="openPGis('work','工作地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">工作地派出所：</label>
								<div class="layui-input-block">
									<div id="workpolice"></div>
								</div>
							</div>
						</div>
						<div class="layui-col-md2">
							<div class="layui-form-item my-form-item">
								<div class="layui-input-inline">
									<input type="checkbox" name="workwifi"  
										value="1"
										<c:if test="${personnel.workwifi eq 1}">checked</c:if>
										title="wifi" lay-skin="primary"/>
									<input type="checkbox" name="workwide"  
										value="1"
										<c:if test="${personnel.workwide eq 1}">checked</c:if>
										title="宽带" lay-skin="primary"/>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">工作地经度：</label>
								<div class="layui-input-block">
									<input type="text" name="workx" lay-verify="" autocomplete="off"
									value="${personnel.workx}" class="layui-input" id="workx" onclick="openPGis('work','工作地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">工作地纬度：</label>
								<div class="layui-input-block">
									<input type="text" name="worky" lay-verify="" autocomplete="off"
									value="${personnel.worky}" class="layui-input" id="worky" onclick="openPGis('work','工作地');" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">特殊特征：</label>
								<div class="layui-input-block">
									<input type="text" name="feature" lay-verify="" autocomplete="off"
										value="${personnel.feature}" placeholder="请输入特殊特征" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">技能专长：</label>
								<div class="layui-input-block">
									<input type="text" name="speciality" lay-verify="" autocomplete="off"
										value="${personnel.speciality}" placeholder="请输入技能专长" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">前科劣迹：</label>
								<div class="layui-input-block">
									<input type="text" name="records" lay-verify="" autocomplete="off"
										value="${personnel.records}" placeholder="请输入前科劣迹" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp">信息来源：</label>
								<c:if test="<%=userSession.getLoginRoleMsgFilter()==0 %>">
									<div class="layui-input-block">
										  	  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="常驻" title="常驻" >
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="暂住" title="暂住">		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="旅馆" title="旅馆">	
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="网吧" title="网吧">		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="盘查" title="盘查">		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="出警" title="出警">
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="案件" title="案件">		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="关注人员系统" title="关注人员系统">		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="手工录入" title="手工录入">
									</div>	
								</c:if>
								<c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">
									<div class="layui-input-block">
										  	  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="常驻" title="常驻" disabled>
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="暂住" title="暂住" disabled>		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="旅馆" title="旅馆" disabled>	
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="网吧" title="网吧" disabled>		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="盘查" title="盘查" disabled>		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="出警" title="出警" disabled>
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="案件" title="案件" disabled>		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="关注人员系统" title="关注人员系统" disabled>		
											  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="手工录入" title="手工录入" disabled>
									</div>	
								</c:if>
							</div>
						</div>
	         </div>
				<!-- 分色管控信息 -->
					<div class="layui-row" style="padding: 5px;">
						<div class="layui-inline layui-col-md12">
							<label class="layui-form-label layui-font-blue my-text-nowarp">分色管控信息</label>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item  my-form-item-lg">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>来本地时间：</label>
								<div class="layui-input-block">
									<input type="text" id="cometime" name="cometime" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">lay-verify="required"</c:if> class="layui-input"  value="${kongextend.cometime}">
								</div>
							</div>
						</div>
	                   <div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>拟离开时间：</label>
								<div class="layui-input-block">
									<input type="text" id="leavetime" name="leavetime" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">lay-verify="required"</c:if>  class="layui-input"  value="${kongextend.leavetime}">
								</div>
							</div>
						</div>
						 <div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp">籍贯：</label>
								<div class="layui-input-block" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">style="pointer-events:none;"</c:if>>
									<select   name="nativeplace" id="nativeplace" style="width:170px;" lay-verType="tips"></select>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp">国家、省平台标签人员：</label>
								<div class="layui-input-block" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">style="pointer-events:none;"</c:if>>
									<select   name="contractperson" style="width:170px;" lay-verType="tips">
									 		<option value='是'   <c:if test="${kongextend.contractperson == '是' }">selected</c:if>>是</option>
									 		<option value='否' <c:if test="${kongextend.contractperson == '否' }">selected</c:if>>否</option>
									 </select>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item  my-form-item-lg">
								<label class="layui-form-label my-text-nowarp">联控级别：</label>
								<div class="layui-input-block" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">style="pointer-events:none;"</c:if>>
									<select   name="jointtype" style="width:170px;" lay-verType="tips">
									 		<option value='1'   <c:if test="${kongextend.jointtype == '1' }">selected</c:if>>红色</option>
									 		<option value='2' <c:if test="${kongextend.jointtype == '2' }">selected</c:if>>橙色</option>
									 		<option value='3' <c:if test="${kongextend.jointtype == '3' }">selected</c:if>>黄色</option>
									 		<option value='4' <c:if test="${kongextend.jointtype == '4' }">selected</c:if>>蓝色</option>
		                             </select>
								</div>
							</div>
						</div>
	                   <div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp">在控级别：</label>
								<div class="layui-input-block" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">style="pointer-events:none;"</c:if>>
									<select   name="incontrollevel" id="incontrollevel" style="width:170px;" lay-verify="required"  lay-verType="tips"></select>
								</div>
							</div>
						</div>
						
	                  <div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>来本地事由：</label>
								<div class="layui-input-block">
								   <input type="text" id="comereason" name="comereason"  class="layui-input" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">lay-verify="required"</c:if> value="${kongextend.comereason}">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>从事行业：</label>
								<div class="layui-input-block">
								   <input type="text" id="engagedwork" name="engagedwork" class="layui-input" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">lay-verify="required"</c:if>  value="${kongextend.engagedwork}">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>身份：</label>
								<div class="layui-input-block">
									 <input type="text" id="identity" name="identity"  class="layui-input" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">lay-verify="required"</c:if> value="${kongextend.identity}">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item my-form-item-lg">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>服务处所：</label>
								<div class="layui-input-block">
									<input type="text" id="serviceplace" name="serviceplace"  class="layui-input" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">lay-verify="required"</c:if> value="${kongextend.serviceplace}">
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item  my-form-item-lg">
								<label class="layui-form-label my-text-nowarp">分类：</label>
								<div class="layui-input-block">
									<select name="classify" lay-filter="classify" style="width:170px;" lay-verType="tips">
									 		<option value=''   <c:if test="${kongextend.classify == '' }">selected</c:if>>--未选择--</option>
									 		<option value='落户人员' <c:if test="${kongextend.classify == '落户人员' }">selected</c:if>>落户人员</option>
									 		<option value='学生' <c:if test="${kongextend.classify == '学生' }">selected</c:if>>学生</option>
									 		<option value='务工经商' <c:if test="${kongextend.classify == '务工经商' }">selected</c:if>>务工经商</option>
									 		<option value='党政机关事业单位人员' <c:if test="${kongextend.classify == '党政机关事业单位人员' }">selected</c:if>>党政机关事业单位人员</option>
									 		<option value='零散人员' <c:if test="${kongextend.classify == '零散人员' }">selected</c:if>>零散人员</option>
									 		<option value='其他' <c:if test="${kongextend.classify == '其他' }">selected</c:if>>其他</option>
		                             </select>
								</div>
							</div>
						</div>
						<div class="layui-col-md6">
							<div class="layui-form-item my-form-item  my-form-item-lg">
								<label class="layui-form-label my-text-nowarp">分类明细：</label>
								<div class="layui-input-block">
									<select name="classifydetail" id="classifydetail" style="width:170px;" lay-verType="tips">
									 		<option value=''   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option>
									 		<c:if test="${kongextend.classify == '落户人员' }"><option value="落户人员" selected>落户人员</option></c:if>
									 		<c:if test="${kongextend.classify == '学生' }"><option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="高校" <c:if test="${kongextend.classifydetail == '高校' }">selected</c:if>>高校</option><option value="内高班" <c:if test="${kongextend.classifydetail == '内高班' }">selected</c:if>>内高班</option><option value="职高技校" <c:if test="${kongextend.classifydetail == '职高技校' }">selected</c:if>>职高技校</option><option value="初中及以下" <c:if test="${kongextend.classifydetail == '初中及以下' }">selected</c:if>>初中及以下</option><option value="短期实习培训" <c:if test="${kongextend.classifydetail == '短期实习培训' }">selected</c:if>>短期实习培训</option></c:if>
									 		<c:if test="${kongextend.classify == '务工经商' }"><option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="经营店铺" <c:if test="${kongextend.classifydetail == '经营店铺' }">selected</c:if>>经营店铺</option><option value="流动摆摊" <c:if test="${kongextend.classifydetail == '流动摆摊' }">selected</c:if>>流动摆摊</option><option value="企业集体务工" <c:if test="${kongextend.classifydetail == '企业集体务工' }">selected</c:if>>企业集体务工</option><option value="社会面零散务工" <c:if test="${kongextend.classifydetail == '社会面零散务工' }">selected</c:if>>社会面零散务工</option></c:if>
									 		<c:if test="${kongextend.classify == '党政机关事业单位人员' }"><option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="驻苏公务（警务）人员" <c:if test="${kongextend.classifydetail == '驻苏公务（警务）人员' }">selected</c:if>>驻苏公务（警务）人员</option><option value="学校管理人员" <c:if test="${kongextend.classifydetail == '学校管理人员' }">selected</c:if>>学校管理人员</option><option value="集体务工管理人员" <c:if test="${kongextend.classifydetail == '集体务工管理人员' }">selected</c:if>>集体务工管理人员</option></c:if>
									 		<c:if test="${kongextend.classify == '零散人员' }"><option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="无业人员" <c:if test="${kongextend.classifydetail == '无业人员' }">selected</c:if>>无业人员</option><option value="学龄前儿童" <c:if test="${kongextend.classifydetail == '学龄前儿童' }">selected</c:if>>学龄前儿童</option></c:if>
									 		<c:if test="${kongextend.classify == '其他' }"><option value="其他" selected>其他</option></c:if>
		                             </select>
								</div>
							</div>
						</div>
						<div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 30px;margin-top: 20px;">
							<div class="layui-form-item my-form-item">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="updateheipersonel">立即提交</button>
							<button type="button" class="layui-btn" lay-submit="" lay-filter="exportheipersonel">导  出</button>
	                   </div>
						</div>
					</div>
				</form>
				<div style="height:100px;"></div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab"  lay-filter="dev_tab">
					<%--<ul class="layui-tab-title btn-list"  style="margin:0px; padding:0px;">
						<li class="btn btn_11 layui-this" onclick="openAttributelabel()" >人员属性标签</li>
						<li class="btn btn_1">关联信息</li>
						<li class="btn btn_5"  onclick="openKongExtend(${personnel.id});">可疑特征</li><!--  可疑特征 -->
					    <li class="btn btn_4"  onclick="openTrajectoryKK('${personnel.cardnumber}',2);">轨迹信息</li>
						<li class="btn btn_6"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_2" onclick="openKongControlPowerGG(${personnel.id});">管控力量</li><!--公共管控力量-->
						<li class="btn btn_7" onclick="openWorkandlive(${personnel.id});">工作地,居住地</li><!--秘密管理力量 -->
						<li class="btn btn_3" onclick="openKongBackground(${personnel.id});">背景审查</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
					</ul>
				--%><div style="position: relative;">
					<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
						style="margin: 0 30px;width: auto !important;">
						<div class="swiper-wrapper" style="width:85px;height: 80px;">
							<li class="btn btn_11 layui-this swiper-slide" onclick="openAttributelabel()" >人员属性标签</li>
							<li class="btn btn_1 swiper-slide">关联信息</li>
							<li class="btn btn_5 swiper-slide"  onclick="openKongExtend(${personnel.id});">可疑特征</li><!--  可疑特征 -->
						    <li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
							<li class="btn btn_6 swiper-slide"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
							<li class="btn btn_2 swiper-slide" onclick="openKongControlPowerGG(${personnel.id});">管控力量</li><!--公共管控力量-->
							<li class="btn btn_7 swiper-slide" onclick="openWorkandlive(${personnel.id});">工作地,居住地</li><!--秘密管理力量 -->
							<li class="btn btn_3 swiper-slide" onclick="openKongBackground(${personnel.id});">背景审查</li>
							<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
							<div class="swiper-slide"></div>
						</div>
					</div>
					<div class="my-swiper-button-next swiper-button-next1"></div>
					<div class="my-swiper-button-prev swiper-button-prev1"></div>
				</div>	
				<div class="layui-tab-content">
			     <div class="right-child-content layui-tab-item layui-show"><!--人员属性标签 -->
						<form class="layui-form" method="post" id="formAttributeLabel" onsubmit="return false;">
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">人员属性标签</li>
									<li>标签维护记录</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <table class="layui-table">
												<tr>
													<td valign="top" width="20%">		
														<div id="zTree" align="center" style="width:98%;overflow: auto;height: 480px;"></div>
													</td>
													<td valign="top" width="80%"> 
														<div id="attributelabel"  style="height: 480px;">
														</div>
													</td>
												</tr>
												<tr>
													<td width="100%" colspan="2">
														<div class="layui-form-item" align="center">
														      <button type="submit" class="layui-btn" lay-submit="" lay-filter="attributeLabelSub">立即提交</button>
													  	</div>
												  	</td>
												</tr>
											</table>
								     </div>
								     <div class="layui-tab-item">
								            <table class="layui-hide" id="applyTable" lay-filter="applyTable"></table> 
								     </div>
								</div>
							</div>
						</form>
					</div>
			     <div class="right-child-content layui-tab-item">
                    <form class="layui-form" method="post" id="formRelation"  onsubmit="return false;">
					   <div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">手机号码：</label>
									<div class="layui-input-block">
										<input type="text" name=telnumber  id="telnumber"  lay-verify="title" autocomplete="off" readonly
											value="${relation.telnumber}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('telnumber',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
								<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">使用手机：</label>
									<div class="layui-input-block">
										<input type="text" name="telephone"  id="telephone"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.telephone}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button  onclick="openRelation('telephone',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">关联wifi：</label>
									<div class="layui-input-block">
										<input type="text" name="relatedwifi" id="relatedwifi"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.relatedwifi}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button  onclick="openRelation('relatedwifi',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">交通工具：</label>
									<div class="layui-input-block">
										<input type="text" name="relatedvehicle"  id="relatedvehicle"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.relatedvehicle}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('relatedvehicle',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">银行账号：</label>
									<div class="layui-input-block">
										<input type="text" name="bankaccount" id="bankaccount"  lay-verify="title" autocomplete="off"  readonly
											value="${relation.bankaccount}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('bankaccount',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">虚拟身份：</label>
									<div class="layui-input-block">
										<input type="text" name="netidentity"  id="netidentity"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.netidentity}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('netidentity',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">网络支付：</label>
									<div class="layui-input-block">
										<input type="text" name="netpayment"  id="netpayment"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.netpayment}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('netpayment',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">涉及房产：</label>
									<div class="layui-input-block">
										<input type="text" name="relatedhouse"  id="relatedhouse"  lay-verify="title" autocomplete="off"  readonly
											value="${relation.relatedhouse}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('relatedhouse',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label ">法人组织：</label>
									<div class="layui-input-block">
										<input type="text" name="relatedlegal"  id="relatedlegal"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.relatedlegal}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('relatedlegal',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label ">驾驶证件：</label>
									<div class="layui-input-block">
										<input type="text" name="relateddriver"  id="relateddriver"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.relateddriver}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('relateddriver',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label ">护照情况：</label>
									<div class="layui-input-block">
										<input type="text" name="relatedpassport"  id="relatedpassport"   lay-verify="title" autocomplete="off"  readonly
											value="${relation.relatedpassport}" placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button onclick="openRelation('relatedpassport',${personnel.id},1);"
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
						<br>
						
				</form>	
			</div>	
			
						<div class="right-child-content layui-tab-item"> <!--背景审查、可疑特征 -->
						 		<form class="layui-form" method="post" id="formkongextend">
								<input type="hidden"  name="kongextendid"id="kongextendid">
								<input type="hidden"  name="religions"id="religions"   value="${kongextend.religion}">
								<input type="hidden"  name="suspiciousthings"id="suspiciousthings" value="${kongextend.suspiciousthing}">
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">宗教特征情况</label>
										<div class="my-input-block">
											  <c:forEach items="${religion}" var="row" varStatus="num">
											      <input type="checkbox" class="parent" name="religion" lay-skin="primary" value="${row.basicName}" title="${row.basicName}" >	
											  </c:forEach>
										</div>
									</div>
								</div>
								
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">可疑物品情况</label>
										<div class="my-input-block">
											<c:forEach items="${suspiciousthing}" var="row" varStatus="num">
											      <input type="checkbox" class="parent" name="suspiciousthing" lay-skin="primary" value="${row.basicName}" title="${row.basicName}" >	
											 </c:forEach>
										</div>
									</div>
								</div>
								<!-- 多文件上传 -->
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item" style="padding: 15px;">
										体貌特征照片：
										<button type="button" class="layui-btn layui-btn-sm"
											id="risk-upload-fileList"><i class="layui-icon"></i>上传多文件</button>
										<button type="button" class="layui-btn layui-hide"
											id="risk-upload-fileListAction">开始上传</button>
										<div class="layui-upload">
											<div class="layui-upload-list">
												<table class="layui-table" style="border: 1px solid #eee;">
													<thead>
														<tr>
															<th width="40%">文件名</th>
															<th width="20%">状态</th>
															<th width="40%">操作</th>
														</tr>
													</thead>
													<tbody id="risk-view-fileList"></tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								
								<div class="layui-col-md3 layui-col-md-offset5">
									<div class="layui-form-item my-form-item" style="padding: 15px;">
										<button type="submit" class="layui-btn"  lay-submit="" lay-filter="kongextendSub">立即提交</button>
	
									</div>
								</div>
							</form>
						</div>
						<div class="right-child-content layui-tab-item"><!-- 轨迹信息 -->
							<form class="layui-form" method="post" id="formTrajectoryTable" onsubmit="return false;">
	                            <div class="layui-inline" style="width:212px;left:20px;">
	                            	<select id="trajectoryTableTypes" lay-filter="trajectoryTableTypes"></select>
	                            </div>       
								<table class="layui-hide" id="trajectoryTable" lay-filter="trajectoryTable"></table>
							</form>
							<%--<div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
								<ul class="layui-tab-title my-tab-title">
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',2);" class="layui-this">电围</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',1);">卡口</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',3);">人脸识别</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',4);">车辆</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',5);">旅馆</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',6);">网吧</li>
								</ul>
								<div class="layui-tab-content">
									<div class="layui-tab-item layui-show">
										<table class="layui-hide" id="trajectoryTable2" lay-filter="trajectoryTable2"></table> 
									</div>
									<div class="layui-tab-item">
										<table class="layui-hide" id="trajectoryTable1" lay-filter="trajectoryTable1"></table> 
									</div>
									<div class="layui-tab-item">
									    <table class="layui-hide" id="trajectoryTable3" lay-filter="trajectoryTable3"></table> 
									</div>
									<div class="layui-tab-item">
									   <table class="layui-hide" id="trajectoryTable4" lay-filter="trajectoryTable4"></table> 
									</div>
									<div class="layui-tab-item">
									   <table class="layui-hide" id="trajectoryTable5" lay-filter="trajectoryTable5"></table> 
									</div>
									<div class="layui-tab-item">
									   <table class="layui-hide" id="trajectoryTable6" lay-filter="trajectoryTable6"></table> 
									</div>
								</div>
						    </div>
						--%></div>
					    <div class="right-child-content layui-tab-item">
					           <table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table><!-- 社会关系 -->
					    </div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公共管控力量</li>
									<li>秘密管控力量</li>
								</ul>
							<div class="layui-tab-content" >
							     <div class="layui-tab-item layui-show">
							           <table class="layui-hide" id="kongcontrolpowerTable1" lay-filter="kongcontrolpowerTable1"></table><!--秘密管控力量信息 -->
							     </div>
							     <div class="layui-tab-item">
							            <table class="layui-hide" id="kongcontrolpowerTable2" lay-filter="kongcontrolpowerTable2"></table><!--公共管控力量信息 -->
							     </div>
							</div>
						  </div>   
						</div>
						 <div class="right-child-content layui-tab-item">
						       <table class="layui-hide" id="workandliveTable" lay-filter="workandliveTable"></table><!--工作地、居住地 -->
						 </div>
						 <div class="right-child-content layui-tab-item">
						     <table class="layui-hide" id="kongbackgroundTable" lay-filter="kongbackgroundTable"></table><!-- 背景审查 -->
						 </div>
						 
						 <div class="right-child-content layui-tab-item"><!-- 涉警涉案信息 -->
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
								<ul class="layui-tab-title my-tab-title">
									<li onclick="openjqxx('${personnel.cardnumber}');" class="layui-this">涉警信息</li>
									<li onclick="openajxx('${personnel.cardnumber}');">涉案信息</li>
									
								</ul>
								<div class="layui-tab-content">
									<div class="layui-tab-item layui-show">
										<table class="layui-hide" id="jqxxTable" lay-filter="jqxxTable"></table> 
									</div>
									<div class="layui-tab-item">
										<table class="layui-hide" id="ajxxTable" lay-filter="ajxxTable"></table> 
									</div>
									
								</div>
						    </div>
						</div>
						 
						 
						 
					</div>
				</div>
			</div>
		</div>
						<script type="text/html" id="publicsocialrelationstoolbar">
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
                                 <c:if test='${fn:contains(buttons,"删除")}'>
   	                                   <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
                                 </c:if>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导 出</button>
	                     </script> 
                       <script type="text/html" id="socialrelationstoolbar">
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
                                 <c:if test='${fn:contains(buttons,"删除")}'>
   	                                     <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
                                 </c:if>
	                     </script> 
	                     <script type="text/html" id="bjsctoolbar">
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
								<c:if test="<%=userSession.getLoginRoleMsgFilter()==0 %>">
   	                            	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
								</c:if>
								<c:if test="<%=userSession.getLoginRoleMsgFilter()==0 %>">
   	                            	<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
								</c:if>
	                     </script> 
			            <script type="text/html" id="socialrelationsbar">
                           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
	                    </script>
	                      <script type="text/html" id="kongcontrolpowerbar1">
                           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>
                           <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="brjl">本人简历</a>     
                           <a class="layui-btn  layui-btn-xs" lay-event="jtcy">家庭成员</a> 
                           <a class="layui-btn  layui-btn-xs" lay-event="shgx">社会关系</a> 
                        </script>
		<script>
		 $(document).ready(function(){
				getDefaultPhoto();//加载默认图片
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+22, //在控级别
					 dataType:	'json',
					 async :      false,
					 success:	function(data){					  
					        var options = '<option value="">在控级别：全部</option>' + fillOption(data);
					        $("select[name^=incontrollevel]").html(options);
					          $("#incontrollevel").val("${kongextend.incontrollevel}");
					   }
			  });
				  $.ajax({
					type:		'POST',
					 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+51, //籍贯
					 dataType:	'json',
					 async :      false,
					 success:	function(data){					  
					      var options = '<option value="">籍贯：全部</option>' + fillOption(data);
					         $("select[name^=nativeplace]").html(options);
					        $("#nativeplace").val("${kongextend.nativeplace}");
					   }
				});
				 var religions =$("#religions").val();//加载可疑物品情况          
			          if(religions!=""){   
			          var religion=religions.split(",");   
			           $('input:checkbox[name=religion]').each(function (i) {         
			             for(i=0;i<religion.length;i++){                                             
			             if(religion[i]==$(this).val()){            
			               $(this).prop('checked', 'checked');
			                     }               
			                  }   
			               });            
			          }
			       var suspiciousthings =$("#suspiciousthings").val();  //体貌特征照片         
			          if(suspiciousthings!=""){   
			          var suspiciousthing=suspiciousthings.split(",");   
			           $('input:checkbox[name=suspiciousthing]').each(function (i) {         
			             for(i=0;i<suspiciousthing.length;i++){                                             
			             if(suspiciousthing[i]==$(this).val()){            
			               $(this).prop('checked', 'checked');
			                     }               
			                  }   
			               });            
			          }
			         var checkmethods =$("#checkmethods").val();  //核查方式    
			          if(checkmethods!=""){   
			          var checkmethod=checkmethods.split(",");   
			           $('input:checkbox[name=checkmethod]').each(function (i) {         
			             for(i=0;i<checkmethod.length;i++){                                             
			             if(checkmethod[i]==$(this).val()){            
			               $(this).prop('checked', 'checked');
			                     }               
			                  }   
			               });            
			          }
			});
			
			layui.config({
			    base: "<c:url value="/layui/lay/modules/"/>"
			}).extend({
			    treeSelect: "treeSelect",
			    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
			    selectInput:"selectInput/selectInput",
			    formSelects: 'formSelects/formSelects-v4'
			});
			layui.use(['table','element', 'laydate', 'form', 'formSelects','upload','jquery','selectInput','treeSelect','zTreeSelectM'], function() {
				var element = layui.element,
					upload = layui.upload,
					$ = layui.jquery,
					selectInput= layui.selectInput,
					table = layui.table,
					laydate = layui.laydate,
					formSelects = layui.formSelects,
					treeSelect = layui.treeSelect,
		  			zTreeSelectM = layui.zTreeSelectM,
					form = layui.form;
					 laydate.render({
					      elem: '#cometime'//指定元素
				     });  
					 laydate.render({
					      elem: '#leavetime'//指定元素
				     });  
				//户籍地派出所
				selectInput.render({
		            // 容器id，必传参数
		            elem: '#housepolice',
		            name: 'housepolice', // 渲染的input的name值
		            initValue:'${personnel.housepolice}', // 渲染初始化默认值
		            placeholder: '请输入户籍地派出所', // 渲染的inputplaceholder值
		            // 联想select的初始化本地值，数组格式，里面的对象属性必须为value，name，value是实际选中值，name是展示值，两者可以一样
		            data: [
		                <c:forEach items="${policeList}" var="row" varStatus="num">
							{value: "${row.departname}", name: "${row.departname}"},
						</c:forEach>
		            ],
		            remoteSearch: false// 是否启用远程搜索 默认是false，和远程搜索回调保存同步
		        });
		        //现住地派出所
				selectInput.render({
		            // 容器id，必传参数
		            elem: '#homepolice',
		            name: 'homepolice', // 渲染的input的name值
		            initValue:'${personnel.homepolice}', // 渲染初始化默认值
		            placeholder: '请输入现住地派出所', // 渲染的inputplaceholder值
		            // 联想select的初始化本地值，数组格式，里面的对象属性必须为value，name，value是实际选中值，name是展示值，两者可以一样
		            data: [
		                <c:forEach items="${policeList}" var="row" varStatus="num">
							{value: "${row.departname}", name: "${row.departname}"},
						</c:forEach>
		            ],
		            remoteSearch: false// 是否启用远程搜索 默认是false，和远程搜索回调保存同步
		        });
		        //工作地派出所
				selectInput.render({
		            // 容器id，必传参数
		            elem: '#workpolice',
		            name: 'workpolice', // 渲染的input的name值
		            initValue:'${personnel.workpolice}', // 渲染初始化默认值
		            placeholder: '请输入工作地派出所', // 渲染的inputplaceholder值
		            // 联想select的初始化本地值，数组格式，里面的对象属性必须为value，name，value是实际选中值，name是展示值，两者可以一样
		            data: [
		                <c:forEach items="${policeList}" var="row" varStatus="num">
							{value: "${row.departname}", name: "${row.departname}"},
						</c:forEach>
		            ],
		            remoteSearch: false// 是否启用远程搜索 默认是false，和远程搜索回调保存同步
		        });
		   
	            form.render();
	            var swiper = new Swiper(".mySwiperS", {
						slidesPerView: 6,
						centeredSlides: false,
						spaceBetween: 5,
						allowTouchMove: false,
						navigation: {
							nextEl: ".swiper-button-next1",
							prevEl: ".swiper-button-prev1",
						}
					}); 
				//修改风险人员基本信息
				form.on('select(classify)', function(data){
					  if(data.value==""){
					  		$("#classifydetail").html('<option value="" selected>--未选择--</option>');
		    				form.render();	
					  }
					  if(data.value=="落户人员"){
					  		$("#classifydetail").html('<option value="落户人员" selected>落户人员</option>');
		    				form.render();	
					  }
					  if(data.value=="学生"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="高校" <c:if test="${kongextend.classifydetail == '高校' }">selected</c:if>>高校</option><option value="内高班" <c:if test="${kongextend.classifydetail == '内高班' }">selected</c:if>>内高班</option><option value="职高技校" <c:if test="${kongextend.classifydetail == '职高技校' }">selected</c:if>>职高技校</option><option value="初中及以下" <c:if test="${kongextend.classifydetail == '初中及以下' }">selected</c:if>>初中及以下</option><option value="短期实习培训" <c:if test="${kongextend.classifydetail == '短期实习培训' }">selected</c:if>>短期实习培训</option>');
		    				form.render();	
					  }
					  if(data.value=="务工经商"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="经营店铺" <c:if test="${kongextend.classifydetail == '经营店铺' }">selected</c:if>>经营店铺</option><option value="流动摆摊" <c:if test="${kongextend.classifydetail == '流动摆摊' }">selected</c:if>>流动摆摊</option><option value="企业集体务工" <c:if test="${kongextend.classifydetail == '企业集体务工' }">selected</c:if>>企业集体务工</option><option value="社会面零散务工" <c:if test="${kongextend.classifydetail == '社会面零散务工' }">selected</c:if>>社会面零散务工</option>');
		    				form.render();	
					  }
					  if(data.value=="党政机关事业单位人员"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="驻苏公务（警务）人员" <c:if test="${kongextend.classifydetail == '驻苏公务（警务）人员' }">selected</c:if>>驻苏公务（警务）人员</option><option value="学校管理人员" <c:if test="${kongextend.classifydetail == '学校管理人员' }">selected</c:if>>学校管理人员</option><option value="集体务工管理人员" <c:if test="${kongextend.classifydetail == '集体务工管理人员' }">selected</c:if>>集体务工管理人员</option>');
		    				form.render();	
					  }
					  if(data.value=="零散人员"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="无业人员" <c:if test="${kongextend.classifydetail == '无业人员' }">selected</c:if>>无业人员</option><option value="学龄前儿童" <c:if test="${kongextend.classifydetail == '学龄前儿童' }">selected</c:if>>学龄前儿童</option>');
		    				form.render();	
					  }
					  if(data.value=="其他"){
					  		$("#classifydetail").html('<option value="其他" selected>其他</option>');
		    				form.render();	
					  }
				  });
				form.on('submit(updateheipersonel)', function(data) {
					if(<%=userSession.getLoginRoleMsgFilter() %>==1&&$("#defaultPhoto").attr("src").indexOf("/images/nophoto.png")>-1){
						top.layer.alert("涉恐人员头像为必填项，请上传头像！");
					}else{
						$("#formheipersonel").ajaxSubmit({
			              	url:		'<c:url value="/updateKongPersonel.do"/>',
			              	dataType:	'json',
			              	async:  	false,
			              	success:	function(data) {
			                  	var obj = eval('(' + data + ')');
			                  	if(obj.flag>0){
			                  	    //弹出loading
			 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			                     	setTimeout(function(){         
			                     		top.layer.msg(obj.msg);
			                     		top.layer.close(index);
						        		//parent.layer.closeAll("iframe");
				 		        		//parent.location.reload();
			                   		},2000);
			                 	}else{
			                  	 	layer.msg(obj.msg);
			                	}
			             	},
			              	error:function() {
			                  	layer.alert("请求失败！");
			              	}
			          	});	
					}
					return false;
				});
				
				form.on('submit(exportheipersonel)', function(data) {
					window.location.href='<c:url value="/exportKongPersonel.do"/>?id='+$("#id").val();
					return false;
				});
				
			   //多文件列表示例
				var riskFilesListView = $("#risk-view-fileList"),
					riskFiles='',
					riskFilesChoose=0,
					riskFilesBool=false,
					riskFilesUploadListIns = upload.render({
						elem: '#risk-upload-fileList',
		        		url: '<c:url value="/newuploadfile.do"/>',
						accept: 'file',
						multiple: true,
						auto: false,
						bindAction: '#risk-upload-fileListAction',
						choose: function(obj) {
							var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
							//读取本地文件
							obj.preview(function(index, file, result) {
								var tr = $(['<tr id="risk-file-upload-' + index + '">', '<td>' + file.name +
									'</td>',
									'<td>等待上传</td>', '<td>',
									'<button class="layui-btn layui-btn-sm risk-upload-file-reload layui-hide">重传</button>',
									'<button class="layui-btn layui-btn-sm layui-btn-danger risk-upload-file-delete">删除</button>',
									'</td>', '</tr>'
								].join(''));

								//单个重传
								tr.find('.risk-upload-file-reload').on('click', function() {
									obj.upload(index, file);
								});

								//删除
								tr.find('.risk-upload-file-delete').on('click', function() {
									delete files[index]; //删除对应的文件
									tr.remove();
									riskFilesChoose--;
									riskFilesUploadListIns.config.elem.next()[0].value =
									''; //清空 input file 值，以免删除后出现同名文件不可选
								});
								
								riskFilesChoose++;
								riskFilesListView.append(tr);
							});
						},
						done: function(res, index, upload) {
							if (res.success>0) { //上传成功
								var tr = riskFilesListView.find('tr#risk-file-upload-' + index),
									tds = tr.children();
								tds.eq(1).html('<span style="color: #5FB878;">上传成功</span>');
								tds.eq(2).html(''); //清空操作
								if(riskFiles!="")riskFiles+=",";
								riskFiles+=res.success;
								riskFilesChoose--;
								return delete this.files[index]; //删除文件队列已经上传成功的文件
							}
							this.error(index, upload);
						},
						allDone: function(obj){ //当文件全部被提交后，才触发
						    riskFilesBool=true;
						    //console.log(obj.total); //得到总文件数
						    //console.log(obj.successful); //请求成功的文件数
						    //console.log(obj.aborted); //请求失败的文件数
						},
						error: function(index, upload) {
							var tr = riskFilesListView.find('tr#risk-file-upload-' + index),
								tds = tr.children();
							tds.eq(1).html('<span style="color: #FF5722;">上传失败</span>');
							tds.eq(2).find('.risk-upload-file-reload').removeClass('layui-hide'); //显示重传
						}
					});
						
	        form.on('submit(kongextendSub)', function(data) {
	              	if(riskFilesChoose>0)$('#risk-upload-fileListAction').click();
					else riskFilesBool=true;
					var clearRisk=setInterval(function(){
						if(riskFilesBool){
							var fileattachments=(riskFilesView.length>0?(bouncer(riskFilesView).join(',')+(riskFiles!=""?",":"")):"")+riskFiles;
						    $("#formkongextend").ajaxSubmit({
				              	url:		'<c:url value="/updateKYTZ.do"/>',
				              	data:		{
				              					featuresphoto:fileattachments,
				              					id:$('#kongextendid').val(),
				              					menuid:${menuid}
				              				},
				              	dataType:	'json',
				              	async:  	false,
				              	success:	function(data) {
									riskFiles='';
									riskFilesChoose=0;
									riskFilesBool=false;
								
									clearInterval(clearRisk);
				                  	var obj = eval('(' + data + ')');
				                  	if(obj.flag>0){
				                  	    //弹出loading
				 		            	var index = top.layer.msg('可疑特征提交中，请稍候',{icon: 16,time:false,shade:0.8});
				                     	setTimeout(function(){         
				                     		top.layer.msg(obj.msg);
				                     		top.layer.close(index);
					 		        		openKongExtend(obj.flag);
				                   		},2000);
				                 	}else{
				                  	 	layer.msg(obj.msg);
				                	}
				             	},
				              	error:function() {
				                  	layer.alert("请求失败！");
				              	}
				          	});	
						}
					},200);
					return false;
				});
				
		   //监听公共管控力量   头部按钮  添加、修改、删除
		  table.on('toolbar(kongcontrolpowerTable1)', function(obj){
		  var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增公共管控力量",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/kongcontrolpower_gg/add.jsp?forcetype=1&menuid="+${menuid }+"&personnelid="+${personnel.id },
						area: ['800', '600px'],
						maxmin: true,
						success : function(layero, index){
						}
					})		
				  layui.layer.full(index);
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改公共管控力量",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/getkongcontrolpowerbyid.do?id="+id+"&menuid="+${menuid }+'&page=update',
							area: ['800', '600px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
						layui.layer.full(index);
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelkongcontrolpower.do?id="+id+'&menuid='+${menuid },{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('kongcontrolpowerTable1', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
				case 'export':
					var data=JSON.stringify(checkStatus.data);
					var datas=JSON.parse(data);
					if(datas!=""){
						var ids="";
						for(var i=0;i<datas.length;i++){
		               		if(ids!="")ids+=",";
		               		ids+=datas[i].id;
						}
						window.location.href='<c:url value="/exportKongcontrolpower.do"/>?ids='+ids;
					}else{
						window.location.href='<c:url value="/exportKongcontrolpower.do"/>?personnelid='+$("#id").val();
					}
					return false;
				break;
	         }
		});		
				
		//监听公共管控力量   详情按钮
	  table.on('tool(kongcontrolpowerTable1)', function(obj){
		  var id = obj.data.id;
		  if(obj.event == 'showinfo'){
		   		var index = layui.layer.open({
					title : "公共管控力量详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getkongcontrolpowerbyid.do?id='+id+'&menuid='+${menuid }+'&page=showinfo',
					area: ['800', '600px'],
					maxmin: true,
					success : function(layero, index){
					}
				})			
			layui.layer.full(index);	
		    }else if(obj.event == 'brjl'){
		        var index = layui.layer.open({
						title : "公共管控力量-个人简历",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/kongpublicresume/list.jsp?menuid="+${menuid }+"&controlpowerid="+id,
						area: ['1000', '600px'],
						maxmin: true,
						success : function(layero, index){
						}
					})	
				layui.layer.full(index);	
		     }else if(obj.event == 'jtcy'){
		        var index = layui.layer.open({
						title : "公共管控力量-家庭关系",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/kongpublicrelation/list.jsp?relationtype=1&menuid="+${menuid }+"&controlpowerid="+id,
						area: ['1000', '600px'],
						maxmin: true,
						success : function(layero, index){
						}
					})	
				layui.layer.full(index);	
		     }else if(obj.event == 'shgx'){
		        var index = layui.layer.open({
						title : "公共管控力量-社会关系",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/kongpublicrelation/list.jsp?relationtype=2&menuid="+${menuid }+"&controlpowerid="+id,
						area: ['1000', '600px'],
						maxmin: true,
						success : function(layero, index){
						}
					})	
				layui.layer.full(index);	
		     }
    	});	
				
				
	     //监听秘密管控力量   头部按钮  添加、修改、删除
		  table.on('toolbar(kongcontrolpowerTable2)', function(obj){
		  var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增秘密管控力量",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/kongcontrolpower_mm/add.jsp?forcetype=2&menuid="+${menuid }+"&personnelid="+${personnel.id },
						area: ['600px', '500px'],
						maxmin: true,
						success : function(layero, index){
						}
					})		
				   
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改秘密管控力量",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/getkongcontrolpowerbyid.do?id="+id+"&menuid="+${menuid }+'&page=update_mm',
							area: ['600px', '500px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
					
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelkongcontrolpower.do?id="+id+'&menuid='+${menuid },{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('kongcontrolpowerTable2', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
	         }
		});			
		 //监听工作地、居住地   头部按钮  添加、修改、删除
		  table.on('toolbar(workandliveTable)', function(obj){
		  var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增工作地、居住地",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/workandlive/add.jsp?datatype=2&menuid="+${menuid }+"&personnelid="+${personnel.id },
						area: ['800px', '600px'],
						maxmin: true,
						success : function(layero, index){
						}
					})		
				   layui.layer.full(index);  
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改工作地、居住地",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/getkongbackgroundbyid.do?id="+id+"&menuid="+${menuid }+'&page=update2',
							area: ['800px', '600px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
					
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
				layui.layer.full(index);
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelKongBackground.do?id="+id+'&menuid='+${menuid },{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('workandliveTable', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
	         }
		});					
		 //监听背景审查   头部按钮  添加、修改、删除
		  table.on('toolbar(kongbackgroundTable)', function(obj){
		  var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增背景审查",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/kong/kongbackground/add.jsp?datatype=1&menuid="+${menuid }+"&personnelid="+${personnel.id },
						area: ['800px', '600px'],
						maxmin: true,
						success : function(layero, index){
						}
					})		
				   layui.layer.full(index);  
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改背景审查",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/getkongbackgroundbyid.do?id="+id+"&menuid="+${menuid }+'&page=update1',
							area: ['800px', '600px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
					
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
				layui.layer.full(index);
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelKongBackground.do?id="+id+'&menuid='+${menuid },{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('kongbackgroundTable', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
	         }
		});			
					
			
			 });
		 
		 var riskFilesView=[];
		 //可疑特征  信息显示
          function openKongExtend(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getKongExtendByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var filesview=$("#risk-view-fileList");
						filesview.html('');
					     layui.upload.render();
					      var kongextend=data.kongextend;
					    
							if(kongextend.featuresphoto!=""){
								riskFilesView=kongextend.featuresphoto.split(",");
								if(riskFilesView.length>0){
									var viewname=kongextend.filesname.split(",");
									$.each(riskFilesView,function(index,item){
										var tr = $(['<tr>', '<td>' + viewname[index] +
											'</td>',
											'<td>上传完成</td>', '<td>',
											'<button class="layui-btn layui-btn-sm risk-upload-file-download" onclick="return false;">下载</button>',
											'<button class="layui-btn layui-btn-sm layui-btn-danger risk-upload-file-delete" onclick="return false;">删除</button>',
											'</td>', '</tr>'
										].join(''));
										//删除
										tr.find('.risk-upload-file-delete').on('click', function() {
										    top.layer.confirm('确定删除此文件附件？', function(firm){
												top.layer.close(firm);
												delete riskFilesView[index]; //删除对应的文件
												tr.remove();
											});
										});
										tr.find('.risk-upload-file-download').on('click', function() {
							          		window.location.href='<c:url value="/downUpfile.do"/>?type=image&fileid='+item;
										});
										
										filesview.append(tr);
									});
								}
							}
					
					}
				});
          }
          function bouncer(array){
          		return array.filter(function(val){
          			return !(!val||val=="");
          		})
          } 
                 //管控力量 列表显示
                 function  openKongControlPowerGG(personnelid){
                  //公共管控力量 列表显示
                   layui.table.render({
					    elem: '#kongcontrolpowerTable1',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchKongControlPower.do?forcetype=1&personnelid="+personnelid,
					    method:'post',
					     toolbar: '#publicsocialrelationstoolbar',
					   cols: [[
					        {field:'id',type:'checkbox',fixed:'true',align:"center"},
					        {field:'personname', title: '姓名', width:100,align:"center"},
					        {field:'records', title: '前科情况', width:150,align:"center"},
					        {field:'actualstate', title: '现实表现',align:"center"} ,
					        {field: 'right', title: '操作', toolbar: '#kongcontrolpowerbar1',width:290,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
					    });
					     //秘密管控力量 列表显示
					    layui.table.render({
					    elem: '#kongcontrolpowerTable2',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchKongControlPower.do?forcetype=2&personnelid="+personnelid,
					    method:'post',
					     toolbar: '#socialrelationstoolbar',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'birthdate', title: '编号', width:100,align:"center"},
					        {field:'personname', title: '管勤民警警号', width:150,align:"center"},
					        {field:'interesting', title: '管勤民警电话',align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }       
                //工作地、居住地 列表显示
                 function  openWorkandlive(personnelid){
                   layui.table.render({
					    elem: '#workandliveTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					      url :   locat+"/searchKongBackground.do?datatype=2&personnelid="+personnelid,
					    method:'post',
					     toolbar: '#socialrelationstoolbar',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'checktype', title: '地点类型', width:100,align:"center"},
					        {field:'checkresume', title: '地点名称', align:"center"},
					        {field:'memo', title: '地点描述',width:130,align:"center"},
					        {field:'updateoperator', title: '修改人', width:100,align:"center"},
					        {field:'updatetime', title: '修改时间', width:180,align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }      
                    //背景审查 列表显示
                 function  openKongBackground(personnelid){
                   layui.table.render({
					    elem: '#kongbackgroundTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchKongBackground.do?datatype=1&personnelid="+personnelid,
					    method:'post',
					     toolbar: '#bjsctoolbar',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'checktime', title: '审查时间', width:150,align:"center"},
					        {field:'checktype', title: '审查方式', width:150,align:"center"},
					        {field:'checkresume', title: '审查简述',align:"center"},
					        {field:'updateoperator', title: '修改人', width:100,align:"center"},
					        {field:'updatetime', title: '修改时间', width:150,align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }
		</script>
		<script type="text/javascript">
		layui.use(['element', 'form','jquery','table','zTreeSelectM'], function() {
				var element = layui.element,
					$ = layui.jquery,
					table = layui.table,
					form = layui.form;
				
				  //方法级渲染
				  table.render({
				    elem: '#applyTable',
				    toolbar: false,
				   	defaultToolbar: ['filter', 'print'],
				    url: '<c:url value="/searchApplylabel.do"/>',
				    where:{personnelid:${personnel.id },examineflag:-1},
				    limit:5,
				    method:'post',
				    cols: [[
				    	{field:'applylabel1name', title: '申请标签1级', width:200,align:"center"} ,
				    	{field:'applylabel2name', title: '申请标签子级',align:"center"} ,
				    	{field:'addtime', title: '申请时间', width:200,align:"center"} ,
				    	{field:'examineflag', title: '审核标记', width:150,align:"center",templet: function (item) {
				    		if(item.examineflag==0){
				    			return "未审核";
				    		}else if(item.examineflag==1){
				    			return "审核通过";
				    		}else if(item.examineflag==2){
				    			return "审核不通过";
				    		}
				    	}}
				    ]],
				    page: true
				  });
				
				
				var _zTreeSelectMsz={};
				form.on('checkbox(attributeLable)',function(data){
					if(data.elem.checked==true){
						if(document.getElementById("attribute"+data.value)==null){
							$('#attributelabel').append("<div id='div"+data.value+"'><div class='layui-col-md11' style='left:-30px;'><div class='layui-form-item my-form-item'><label class='layui-form-label'>"+data.elem.title+
								"</label><div class='layui-input-block'><div id='attribute"+data.value+"'></div></div></div></div>"+
								"<div class='layui-col-md1' style='left:-30px;'><div class='layui-form-item my-form-item'><button onclick='addLabel("+data.value+",&quot;"+data.elem.title+"&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div>"+
								"<div class='layui-col-md12' style='left:-30px;'><div class='layui-form-item my-form-item'><label class='layui-form-label'>申请理由</label><div class='layui-input-block' width='100%';><textarea placeholder='请输入内容' class='layui-textarea' id='reason"+data.value+"'></textarea></div></div></div>");
				          		if(data.value==9){
					          		_zTreeSelectMsz[data.value] = layui.zTreeSelectM({
									    elem: '#attribute'+data.value,//元素容器【必填】          
									    data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid='+data.value,
									    type: 'get',  //设置了长度
									    max: 20,//最多选中个数，默认5            
									    name: 'attributelabel2',//input的name 不设置与选择器相同(去#.)
									    delimiter: ',',//值的分隔符           
									    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
									    tips: '风险二级及以下标签：',
									    zTreeSetting: { //zTree设置
									        check: {
									            enable: true,
									            chkboxType: { "Y": "p", "N": "p" }
									        },
									        data: {
									            simpleData: {
									                enable: false
									            },
									            key: {
									                name: 'name',
									                children: 'children'
									            }
									        }
									    }
									});
				          		}else{
					          		_zTreeSelectMsz[data.value] = layui.zTreeSelectM({
									    elem: '#attribute'+data.value,//元素容器【必填】          
									    data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid='+data.value,
									    type: 'get',  //设置了长度
									    max: 5,//最多选中个数，默认5            
									    name: 'attributelabel2',//input的name 不设置与选择器相同(去#.)
									    delimiter: ',',//值的分隔符           
									    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
									    tips: '风险二级及以下标签：',
									    zTreeSetting: { //zTree设置
									        check: {
									            enable: true,
									            chkboxType: { "Y": "", "N": "" }
									        },
									        data: {
									            simpleData: {
									                enable: false
									            },
									            key: {
									                name: 'name',
									                children: 'children'
									            }
									        }
									    }
									});
				          		}
						}
					}else{
						$("#div"+data.value).remove();
					}
	          	});
	          	
	          	form.on('submit(attributeLabelSub)', function(data) {
	          		//以前的正式标签
	          		var exzslabel1 = ",${personnel.zslabel1},";
	          		//需要审核的
	          		var addattributeLables=[];
	          		var addattributeLablenames=[];
	          		var addresult=[];
	          		//已有一级标签不需要审核的
	          		var uncheckattributeLables=[];
	          		$("input[name=attributeLable]:checked").each(function(){
	          			var p=$(this);
	          			if(exzslabel1.indexOf(","+p.val()+",")==-1){
	          				addattributeLables.push(p.val());
	          				addattributeLablenames.push(p.context.title);
	          			}else{
	          				uncheckattributeLables.push(p.val());
	          			}
	          		});
	          		//新增审核
	          		$.each(addattributeLables,function(num,item){
	          			addresult[num] = '{"attribute1":'+item+',"attribute2":"'+$("#attribute"+item).find("input").val()+'","applylabel1name":"'+addattributeLablenames[num]+'","applylabel2name":"'+_zTreeSelectMsz[item].names.join()+'","reason":"'+$("#reason"+item).val()+'"}';
	          		});
	          		var addjson="["+addresult.join(",")+"]";
	          		//直接更新二级标签
	          		var attribute2 = [];
	          		$.each(uncheckattributeLables,function(num,item){
	          			attribute2.push($("#attribute"+item).find("input").val());
	          		});
	          		attribute2str = attribute2.join(",");
	          		$.ajax({
						type:		'POST',
						url:		'<c:url value="/applyAttribbuteLabel.do" />',
						data:		{addjson:addjson,zslabel2:attribute2str,id:${personnel.id }},
						dataType:	'json',
						success:	function(data){					  
							var str = eval('(' + data + ')');
							if (str.flag ==1) {
								top.layer.msg(str.msg);
							}else{
								top.layer.msg(str.msg);
							}
						}
					});
	          		return false;
	          	});
	          	
	          	openAttributelabel();
		  });
          function openAttributelabel(){
          		//清空页面
          		$("#zTree").html("");
          		$('#attributelabel').html("");
          		var zslabel1=",${personnel.zslabel1},";
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRootAttributeLabel.do" />',
					dataType:	'json',
					async:   false,
					success:	function(data){					  
						$.each(data,function(num,item){
							if(zslabel1.indexOf(","+item.id+",")>-1){
								$("#zTree").append("<input type='checkbox' name='attributeLable' value='"+item.id+"' lay-filter='attributeLable' title='"+item.attributelabel+"' checked disabled>");
								$('#attributelabel').append("<div class='layui-col-md11' style='left:-30px;'><div class='layui-form-item my-form-item'><label class='layui-form-label'>"+item.attributelabel+
								"</label><div class='layui-input-block'><div id='attribute"+item.id+"'></div></div></div></div>"+
								"<div class='layui-col-md1' style='left:-30px;'><div class='layui-form-item my-form-item'><button onclick='addLabel("+item.id+",&quot;"+item.attributelabel+"&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div>");
					          		if(item.id==9){
						          		var _zTreeSelectM = layui.zTreeSelectM({
										    elem: '#attribute'+item.id,//元素容器【必填】          
										    data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid='+item.id,
										    type: 'get',  //设置了长度
										    max: 20,//最多选中个数，默认5
										    selected: [${personnel.zslabel2}],//默认值   
										    name: 'attributelabel2',//input的name 不设置与选择器相同(去#.)
										    delimiter: ',',//值的分隔符           
										    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
										    tips: '风险二级及以下标签：',
										    zTreeSetting: { //zTree设置
										        check: {
										            enable: true,
										            chkboxType: { "Y": "p", "N": "p" }
										        },
										        data: {
										            simpleData: {
										                enable: false
										            },
										            key: {
										                name: 'name',
										                children: 'children'
										            }
										        }
										    }
										});
					          		}else{
						          		var _zTreeSelectM = layui.zTreeSelectM({
										    elem: '#attribute'+item.id,//元素容器【必填】          
										    data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid='+item.id,
										    type: 'get',  //设置了长度
										    max: 5,//最多选中个数，默认5
										    selected: [${personnel.zslabel2}],//默认值   
										    name: 'attributelabel2',//input的name 不设置与选择器相同(去#.)
										    delimiter: ',',//值的分隔符           
										    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
										    tips: '风险二级及以下标签：',
										    zTreeSetting: { //zTree设置
										        check: {
										            enable: true,
										            chkboxType: { "Y": "", "N": "" }
										        },
										        data: {
										            simpleData: {
										                enable: false
										            },
										            key: {
										                name: 'name',
										                children: 'children'
										            }
										        }
										    }
										});
					          		}
							}else{
								$("#zTree").append("<input type='checkbox' name='attributeLable' value='"+item.id+"' lay-filter='attributeLable' title='"+item.attributelabel+"'>");
							}
						});
						layui.form.render();
						
					}
				});
          }
          
          function addLabel(parentid,parentlabel){
          		var index = layui.layer.open({
					title : "添加人员二级标签",
					offset: ["50"],
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/personel/attributelabel/add1.jsp?examineflag=0&menuid='+${menuid }+'&parentlabel='+parentlabel+'&parentid='+parentid+'"/>',
				    area: ['900', '500px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})
          }
		</script>
		<script type="text/javascript">
			function openPGis(type,name){
				var place=$("#"+type+"place").val().trim();
				var x=$("#"+type+"x").val();
				var y=$("#"+type+"y").val();
				var f1=function(event){
					place=event.data.mc;
					x=event.data.lx;
					y=event.data.ly;
					$("#"+type+"place").val(place);
					$("#"+type+"x").val(x);
					$("#"+type+"y").val(y);
					layer.close(index);
					window.removeEventListener('message',f1,false);
				};
				var index = layui.layer.open({
					title : name+"标准地址修改",
					offset: ["50"],
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc='+place+'&lx='+x+'&ly='+y,
				    area: ['800', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					},
					cancel:function(){
						window.removeEventListener('message',f1,false);
					}
				})
				layui.layer.full(index);
				window.addEventListener('message',f1);
			}
		</script>
	</body>
</html>
