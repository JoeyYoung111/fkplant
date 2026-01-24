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
    <base href="<%=basePath%>">
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/font-awesome-4.7.0/css/font-awesome.min.css"/>" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/tagTree.css"/>" />
	 <link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
	 <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
	 <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/tagtree/tagTree.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js?v=20250422-2"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
	<script type="text/javascript" src="<c:url value="/jsp/personel/xd_radio_event.js"/>"></script><!-- 涉警涉案详情 -->
  	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<!-- ztree -->
	<script type="text/javascript" src="<c:url value="/jquery/ztree/jquery.ztree.all-3.5.js"/>"></script>
	<link rel="stylesheet" href="<c:url value="/jquery/ztree/zTreeStyle.css"/>"/>
	<style type="text/css">
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

		.my-tab-title li {  width:25%  }
   	</style>
  </head>
 <body class="childrenBody layui-fluid">
		
		<div class="layui-form layui-row">
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<form class="layui-form" method="post" id="formPersonnelExtend" onsubmit="return false;">
					<input type="hidden"  name="menuid"   id="menuid" value=${menuid }>
					<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
					<input type="hidden"  name="zslabel1"    id="zslabel1"  value=${personnel.zslabel1 }>
					<input type="hidden"  name="personnelid"id="personnelid" value=${personnelExtend.personnelid }>
					<input type="hidden"  name="personlabelname"id="personlabelname" value=${personnelExtend.personlabelname }>
					<input type="hidden"  name="personlabel"id="personlabel" value="${personnel.personlabel }">
					<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
						<div class="layui-inline layui-col-md12">
							<label class="layui-form-label layui-font-blue">基本信息：</label>
						</div>
						<div class=" my-onload-img layui-col-md2" style="height: 260px;">
							<img id="defaultPhoto">
							<a class="my-font-blue" style="text-decoration: underline;cursor:pointer;" onclick="openPhotos()">编 辑</a>
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
<%--									<input type="text" autocomplete="off" style="background:#efefef"--%>
<%--										value="${personnel.personname}" readonly class="layui-input">--%>
									<input type="text" name="personname" autocomplete="off" value="${personnel.personname}" class="layui-input" <c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">style="background:#efefef" readonly</c:if>>
								</div>
							</div>
						</div>
	
		              <div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">性别：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" name="sexes" placeholder="请输入性别"
										value="${personnel.sexes}" <c:if test="${fn:length(personnel.cardnumber)>14}">style="background:#efefef;" readonly</c:if> class="layui-input">
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
										<option value=""  <c:if test="${personnel.netskillhabit eq ''}">selected</c:if>>==请选择==</option>
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
                </div>
				<!-- 分级分类信息 -->
					<div class="layui-row" style="padding: 15px;">
						<div class="layui-inline layui-col-md12">
							<label class="layui-form-label layui-font-blue my-text-nowarp">分级分类信息</label>
						</div>
						<div class="layui-col-md7">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">涉政级别：</label>
								<div class="layui-input-block">
								<select name="jointcontrollevel"  id="jointcontrollevel">
										<option value="">==请选择==</option>
										<c:forEach items="${jointcontrollevel}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == personnelExtend.jointcontrollevel }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
                      <%-- <input type="text" autocomplete="off" style="background:#efefef"  value="${personnelExtend.jointcontrollevel}" name="jointcontrollevel" readonly class="layui-input">--%>
								</div>
							</div>
						</div>
<%--						<div class="layui-col-md7">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<label class="layui-form-label">在控状态：</label>--%>
<%--								<div class="layui-input-block">--%>
<%--									<select name="incontrollevel">--%>
<%--										<option value="">==请选择==</option>--%>
<%--										<c:forEach items="${incontrollevel}" var="row" varStatus="num">--%>
<%--											<option value="${row.basicName}" <c:if test="${row.basicName == personnelExtend.incontrollevel }">selected</c:if>>${row.basicName}</option>--%>
<%--										</c:forEach>--%>
<%--									</select>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--						<div class="layui-col-md12">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<label class="layui-form-label">人员属性标签：</label>--%>
<%--								<div class="layui-input-block">--%>
<%--									<div id="attributelabels"></div>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
                 		<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">列控依据：</label>
								<div class="layui-input-block">
									<textarea placeholder="何时、何地参与何种涉政活动，被教育处理情况及近期思想状况等。" class="layui-textarea"
										id="memo" name="memo"  >${personnelExtend.memo}</textarea>
								</div>
							</div>
						</div>


						<div class="layui-col-md8">
							<div class="layui-col-md7">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任单位：</label>
									<div class="layui-input-block">
										<input type="text" id="jdunit1" name="jdunit1" value="0" lay-filter="jdunit1" lay-verify="jdunit1" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任民警：</label>
									<div class="layui-input-block">
										<select id="jdpolice1" name="jdpolice1" lay-filter="jdpolice1">
			    						</select>
									</div>
								</div>
							</div>
						</div>
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">民警手机：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" name="pphone1" id="pphone1" lay-verify=""
										value="${personnel.pphone1}" placeholder="请输入民警手机" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-md8">
							<div class="layui-col-md7">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label my-text-nowarp">双列管单位：</label>
									<div class="layui-input-block">
										<input type="text" id="jdunit2" name="jdunit2" value="0" lay-filter="jdunit2" lay-verify="jdunit2" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label my-text-nowarp">双列管民警：</label>
									<div class="layui-input-block">
										<select id="jdpolice2" name="jdpolice2"  lay-filter="jdpolice2">
			    						</select>
									</div>
								</div>
							</div>
						</div>
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">民警手机：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" name="pphone2" id="pphone2" lay-verify=""
										value="${personnel.pphone2}" placeholder="请输入民警手机" class="layui-input">
								</div>
							</div>
						</div>

					</div>

					<div class="layui-row" style="padding: 15px;">
						<div class="layui-inline layui-col-md12">
							<label class="layui-form-label layui-font-blue my-text-nowarp">其他信息</label>
						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">管控力量：</label>
								<div class="layui-input-block">
									<input type="text" lay-verify="" autocomplete="off"
										   value="${personnel.control_power}" class="layui-input" onclick="openRelation('controlpower',${personnel.id},1);" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>

						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">管控方案：</label>
								<div class="layui-input-block">
									<input type="text" lay-verify="" autocomplete="off"
																	  value="${personnel.control_plan}" class="layui-input" onclick="openRelation('controlplan',${personnel.id},1);" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">应急预案：</label>
								<div class="layui-input-block">
									<input type="text" lay-verify="" autocomplete="off"
										   value="${personnel.control_emergency}" class="layui-input" onclick="openRelation('controlemergency',${personnel.id},1);" readonly style="background:#efefef;cursor:pointer;">
								</div>
							</div>
						</div>

					</div>

					<div class="layui-col-md4 layui-col-md-offset6" style="margin-bottom: 30px;margin-top: 30px;">
						<div class="layui-form-item my-form-item">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="updatePersonnelExtend">立即提交</button>
							<%--						<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重置&nbsp;</button>--%>
						</div>
					</div>

				</form>
				<div style="height:100px;"></div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab"  lay-filter="dev_tab">
					<%--<ul class="layui-tab-title btn-list">
						<li class="btn btn_11 layui-this" onclick="openAttributelabel()" >人员属性标签</li>
						<li class="btn btn_1">关联信息</li>
						<li class="btn btn_4"  onclick="openTrajectoryKK('${personnel.cardnumber}',2);">轨迹信息</li>
						<li class="btn btn_3" onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
						<li class="btn btn_5"  onclick="opengrjl('${personnel.id}');">特殊信息</li>
						<li class="btn btn_13"  onclick="openposition('${personnel.id}')">阵地信息</li>
						<li class="btn btn_14"  onclick="opensjxx('${personnel.id}');">事件信息</li>
					</ul>
				--%><div style="position: relative;">
					<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
						style="margin: 0 30px;width: auto !important;">
						<div class="swiper-wrapper" style="width:85px;height: 80px;">
							<li class="btn btn_15 swiper-slide layui-this" id="tabWorkRecord" onclick="openWorkRecord(${personnel.id});">民警工作记载</li>
							<li class="btn btn_5 swiper-slide">关联信息</li>
							<li class="btn btn_13 swiper-slide"  onclick="openposition('${personnel.id}')">政保阵地</li>
							<li class="btn btn_14 swiper-slide"  onclick="opensjxx('${personnel.id}');">政保事件</li>
							<li class="btn btn_2 swiper-slide"  onclick="openorganization('${personnel.id}');">政保组织</li>
							<li class="btn btn_11 swiper-slide" onclick="openAttributelabel()" >人员属性标签</li>
<%--							<li class="btn btn_1 swiper-slide">关联信息</li>--%>
							<li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
							<li class="btn btn_3 swiper-slide" onclick="openSocialRelations(${personnel.id});">社会关系</li>
							<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}');radio_jqxx();">涉警涉案</li>
							<div class="swiper-slide"></div>
						</div>
					</div>
					<div class="my-swiper-button-next swiper-button-next1"></div>
					<div class="my-swiper-button-prev swiper-button-prev1"></div>
				</div>	
				<div class="layui-tab-content">
					<div class="right-child-content layui-tab-item layui-show"><!--民警工作记载 -->
			           <table class="layui-hide" id="workRecordTable" lay-filter="workRecordTable"></table>
				    </div>
					<div class="right-child-content layui-tab-item"><!-- 特殊信息信息 -->
						<div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
							<ul class="layui-tab-title my-tab-title">
								
								<li class="layui-this">个人情况</li>
								<li onclick="opengrjl('${personnel.id}');">个人简历</li>
								<li onclick="openhdjl('${personnel.id}');">主要活动记录</li>
								<li >关联信息</li>
							</ul>
							<div class="layui-tab-content">
								<div class="layui-tab-item layui-show">
									<form class="layui-form" method="post" id="formWorkExtend" onsubmit="return false;">
										<div class="layui-form-item">
									    	<label class="layui-form-label">国籍</label>
									    	<div class="layui-input-block">
									      		<input type="text" name="country" value="${personnelExtend.country}" autocomplete="off" placeholder="请输入国籍" class="layui-input">
									    	</div>
									  	</div>
										<div class="layui-form-item">
									    	<label class="layui-form-label">出生日期</label>
									    	<div class="layui-input-block">
									      		<input type="text" name="birthday" id="birthday" readonly value="${personnelExtend.birthday}" autocomplete="off" placeholder="请选择出生日期" class="layui-input">
									    	</div>
									  	</div>
										<div class="layui-form-item">
									    	<label class="layui-form-label">身份/职业</label>
									    	<div class="layui-input-block">
									      		<input type="text" name="vocation" value="${personnelExtend.vocation}" autocomplete="off" placeholder="请输入身份/职业" class="layui-input">
									    	</div>
									  	</div>
										<div class="layui-form-item">
									    	<label class="layui-form-label">工作单位</label>
									    	<div class="layui-input-block">
									      		<input type="text" name="workunit" value="${personnelExtend.workunit}" autocomplete="off" placeholder="请输入工作单位" class="layui-input">
									    	</div>
									  	</div>
										<div class="layui-form-item">
									    	<label class="layui-form-label">职务</label>
									    	<div class="layui-input-block">
									      		<input type="text" name="workjob" value="${personnelExtend.workjob}" autocomplete="off" placeholder="请输入职务" class="layui-input">
									    	</div>
									  	</div>
									  	<div class="layui-form-item">
										    <div class="layui-input-block">
										      <button type="submit" class="layui-btn" lay-submit="" lay-filter="workExtendSub">立即提交</button>
										    </div>
									  	</div>
									</form>
								</div>
								<div class="layui-tab-item">
									<table class="layui-hide" id="kongpublicresume" lay-filter="kongpublicresume"></table> 
								</div>
								<div class="layui-tab-item">
									<table class="layui-hide" id="hdjlTable" lay-filter="hdjlTable"></table> 
								</div>
								<div class="layui-tab-item">
									<form class="layui-form" method="post" id="formRelation"  onsubmit="return false;">
										<div class="layui-col-md11">
											<div class="layui-form-item my-form-item">
												<label class="layui-form-label">手机号码：</label>
												<div class="layui-input-block">
													<input type="text" name=telnumber  id="telnumber"  lay-verify="title" autocomplete="off"
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
													<input type="text" name="telephone"  id="telephone"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="relatedwifi" id="relatedwifi"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="relatedvehicle"  id="relatedvehicle"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="bankaccount" id="bankaccount"  lay-verify="title" autocomplete="off"
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
													<input type="text" name="netidentity"  id="netidentity"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="netpayment"  id="netpayment"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="relatedhouse"  id="relatedhouse"  lay-verify="title" autocomplete="off"
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
													<input type="text" name="relatedlegal"  id="relatedlegal"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="relateddriver"  id="relateddriver"   lay-verify="title" autocomplete="off"
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
													<input type="text" name="relatedpassport"  id="relatedpassport"   lay-verify="title" autocomplete="off"
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
										<div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 30px;margin-top: 30px;">
											<%--						<div class="layui-form-item my-form-item">--%>
											<%--						    <button type="submit" class="layui-btn"  lay-submit="" lay-filter="relationSub">立即提交</button>--%>
											<%--							<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重置&nbsp;</button>--%>
											<%--						</div>--%>
										</div>
									</form>
								</div>
							</div>
					    </div>
					</div>
					<div class="right-child-content layui-tab-item"><!--政保阵地 -->
						<table class="layui-hide" id="positionTable" lay-filter="positionTable"></table> 
					</div>
					<div class="right-child-content layui-tab-item"><!--政保事件 -->
						<table class="layui-hide" id="sjxxTable" lay-filter="sjxxTable"></table> 
					</div>
					<div class="right-child-content layui-tab-item"><!--政保组织 -->
						<table class="layui-hide" id="organizationTable" lay-filter="organizationTable"></table> 
					</div>
					<div class="right-child-content layui-tab-item"><!--人员属性标签 -->
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
<%--                    <div class="right-child-content layui-tab-item">--%>
<%--                    --%>
<%--			</div>	--%>

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
						
						<script type="text/html" id="socialrelationstoolbar">
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
								<c:if test='${fn:contains(buttons,"删除")}'>
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
								</c:if>
                                <c:if test='${fn:contains(buttons,"删除")}'>
   	                                  <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
                               </c:if>
	                     </script> 
			            <script type="text/html" id="socialrelationsbar">
                           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
	                    </script>
						<div class="right-child-content layui-tab-item"><!--社会关系 -->
				           <table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table>
					    </div>
					     <div class="right-child-content layui-tab-item"><!-- 涉警涉案信息 -->
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
								<ul class="layui-tab-title my-tab-title">
									<li onclick="openjqxx('${personnel.cardnumber}');radio_jqxx();" class="layui-this">涉警信息</li>
									<li onclick="openajxx('${personnel.cardnumber}');radio_ajxx();">涉案信息</li>
									
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
	 <script type="text/html" id="resumetoolbarButton">
   	    <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
    </script>
	<script type="text/html" id="resumebar">
         <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="update">修改</a>     
         <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="cancel">删除</a> 
     </script> 	
		
		
		
		<script>
		
			var users1={},users2={};
			function getUsers(departmentid,index,value){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>'+departmentid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var options = fillOption(data);
						var firstid=0;
						if(index==1)users1={};
						else if(index==2)users2={};
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								if(i==0)firstid=this.value;
								if(index==1)users1[this.value]=this.memo;
								else if(index==2)users2[this.value]=this.memo;
							});
						});
						var id="#jdpolice"+index;
						$(id).html(options);
						layui.form.render();
						if(value!=""&&value!=0)
						    $(id+" option[value="+value+"]").select();
						else{
							if(index==1)$("#pphone1").val(users1[firstid]);
							else if(index==2)$("#pphone2").val(users2[firstid]);
						}
					}
				});
			}
			
		
			$(document).ready(function(){
				getDefaultPhoto();//加载默认图片
			});
			
			layui.config({
			    base: "<c:url value="/layui/lay/modules/"/>"
			}).extend({
			    treeSelect: "treeSelect",
			    selectInput:"selectInput/selectInput",
     			zTreeSelectM: 'zTreeSelectM/zTreeSelectM'
			});
			layui.use(['element', 'form','laydate', 'upload','jquery','selectInput','treeSelect','table'], function() {
				var element = layui.element,
					upload = layui.upload,
					$ = layui.jquery,
					laydate = layui.laydate,
					selectInput= layui.selectInput,
					treeSelect = layui.treeSelect,
					table = layui.table,
					form = layui.form;
				  
				  laydate.render({
				   	elem:'#birthday'
				   	,format:  'yyyy年MM月dd日'
				  });
				  
				  //方法级渲染
				  table.render({
				    elem: '#applyTable',
				    toolbar: false,
				   	defaultToolbar: ['filter', 'print'],
				    url: '<c:url value="/searchApplylabel.do"/>',
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
				
				treeSelect.render({
			        // 选择器
			        elem: '#jdunit1',
			        // 数据
			        data: '<c:url value="/getDepartmentTree.do"/>',
			        // 异步加载方式：get/post，默认get
			        type: 'get',
			        // 占位符
			        placeholder: '管辖责任单位',
			        // 是否开启搜索功能：true/false，默认false
			        search: false,
			        // 一些可定制的样式
			        style: {
			            folder: {
			                enable: false
			            },
			            line: {
			                enable: true
			            }
			        },
			        // 点击回调
			        click: function(d){
			        	getUsers($('#jdunit1').val(),1,0);
			        	form.render();
			        },
			        // 加载完成后的回调函数
			        success: function (d) {
			        	treeSelect.checkNode('jdunit1', "${personnel.jdunit1}");
			        	treeSelect.refresh('jdunit1');
			        	getUsers("${personnel.jdunit1}",1,"${personnel.jdpolice1}");
			        	form.render();
			        }
			    });
				var ztreestylechange2=treeSelect.render({
			        // 选择器
			        elem: '#jdunit2',
			        // 数据
			        data: '<c:url value="/getDepartmentTree.do"/>',
			        // 异步加载方式：get/post，默认get
			        type: 'get',
			        // 占位符
			        placeholder: '管辖责任单位',
			        // 是否开启搜索功能：true/false，默认false
			        search: false,
			        // 一些可定制的样式
			        style: {
			            folder: {
			                enable: false
			            },
			            line: {
			                enable: true
			            }
			        },
			        // 点击回调
			        click: function(d){
			        	if($('#jdunit2').val()!="")getUsers($('#jdunit2').val(),2,0);
			        	else getUsers(0,2,0)
			        	form.render();
			        },
			        // 加载完成后的回调函数
			        success: function (d) {
			        	var treeObj = treeSelect.zTree('jdunit2');
			        	if("${personnel.jdunit2}"!=""&&"${personnel.jdunit2}"!="0"){
				        	treeSelect.checkNode('jdunit2', "${personnel.jdunit2}");
				        	getUsers("${personnel.jdunit2}",2,"${personnel.jdpolice2}");
			        	}
			        	var newNode = {name:"取消选择"};
			        	treeObj.addNodes(null,0,newNode);
			        	treeSelect.refresh('jdunit2');
			        	ztreestylechange2.hideIcon();
			        	form.render();
			        }
			    });
				form.on('select(jdpolice1)', function(data){
				  	$('#pphone1').val(users1[data.value]);
				  	form.render();
				});
				form.on('select(jdpolice2)', function(data){
				  	$('#pphone2').val(users2[data.value]);
				  	form.render();
				});
				
				var labelFilesListView = $("#label-view-fileList"),
					labelFiles='',
					labelFilesChoose=0,
					labelFilesBool=false,
					labelFilesUploadListIns = upload.render({
						elem: '#label-upload-fileList',
		        		url: '<c:url value="/newuploadfile1.do"/>',
						accept: 'file',
						multiple: true,
						auto: false,
						bindAction: '#label-upload-fileListAction',
						choose: function(obj) {
							var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
							//读取本地文件
							obj.preview(function(index, file, result) {
								var tr = $(['<tr id="label-file-upload-' + index + '">', '<td>' + file.name +
									'</td>',
									'<td>等待上传</td>', '<td>',
									'<button class="layui-btn layui-btn-sm label-upload-file-reload layui-hide">重传</button>',
									'<button class="layui-btn layui-btn-sm layui-btn-danger label-upload-file-delete">删除</button>',
									'</td>', '</tr>'
								].join(''));

								//单个重传
								tr.find('.label-upload-file-reload').on('click', function() {
									obj.upload(index, file);
								});

								//删除
								tr.find('.label-upload-file-delete').on('click', function() {
									delete files[index]; //删除对应的文件
									tr.remove();
									labelFilesChoose--;
									labelFilesUploadListIns.config.elem.next()[0].value =
									''; //清空 input file 值，以免删除后出现同名文件不可选
								});
								
								labelFilesChoose++;
								labelFilesListView.append(tr);
							});
						},
						done: function(res, index, upload) {
							if (res.success>0) { //上传成功
								var tr = labelFilesListView.find('tr#label-file-upload-' + index),
									tds = tr.children();
								tds.eq(1).html('<span style="color: #5FB878;">上传成功</span>');
								tds.eq(2).html(''); //清空操作
								if(labelFiles!="")labelFiles+=",";
								labelFiles+=res.success;
								labelFilesChoose--;
								return delete this.files[index]; //删除文件队列已经上传成功的文件
							}
							this.error(index, upload);
						},
						allDone: function(obj){ //当文件全部被提交后，才触发
						    labelFilesBool=true;
						    //console.log(obj.total); //得到总文件数
						    //console.log(obj.successful); //请求成功的文件数
						    //console.log(obj.aborted); //请求失败的文件数
						},
						error: function(index, upload) {
							var tr = labelFilesListView.find('tr#label-file-upload-' + index),
								tds = tr.children();
							tds.eq(1).html('<span style="color: #FF5722;">上传失败</span>');
							tds.eq(2).find('.label-upload-file-reload').removeClass('layui-hide'); //显示重传
						}
					});
				openWorkRecord(${personnel.id});
				form.render();
				//滚动图片按钮显示         
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
				//基本信息+分类分级  监听提交
				form.on('submit(updatePersonnelExtend)', function(data) {
					var url='<c:url value="/updatePersonnelExtend.do"/>?personFilter='+${personnelExtend.id};//临时存放id
					if(!$("input[name=homewifi]").prop("checked"))url+="&homewifi=";
					if(!$("input[name=homewide]").prop("checked"))url+="&homewide=";
					if(!$("input[name=workwifi]").prop("checked"))url+="&workwifi=";
					if(!$("input[name=workwide]").prop("checked"))url+="&workwide=";
				
					$("#formPersonnelExtend").ajaxSubmit({
		              	url:		url,
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
					        		layer.closeAll("iframe");
			 		        		//刷新父页面
			 		         		parent.$("#search").click();
		 		         			parent.layer.closeAll("iframe");
		                   		},2000);
		                 	}else{
		                  	 	layer.msg(obj.msg);
		                	}
		             	},
		              	error:function() {
		                  	layer.alert("请求失败！");
		              	}
		          	});	
					return false;
				});
				form.on('submit(workExtendSub)', function(data) {
					var url='<c:url value="/updatePersonnelWorkExtend.do"/>?personFilter=${personnelExtend.id}&menuid=${menuid}&personlabelname=${personnelExtend.personlabelname}';//临时存放id
				
					$("#formWorkExtend").ajaxSubmit({
		              	url:		url,
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
		                   		},2000);
		                 	}else{
		                  	 	layer.msg(obj.msg);
		                	}
		             	},
		              	error:function() {
		                  	layer.alert("请求失败！");
		              	}
		          	});	
					return false;
				});
				
				form.on('submit(labelSub)', function(data) {
					if(labelFilesChoose>0)$('#label-upload-fileListAction').click();
					else labelFilesBool=true;
	            	var index = top.layer.msg("自定义标签("+$('#customlabel').val()+')提交中，请稍候',{icon: 16,time:false,shade:0.8});
					var clearLabel=setInterval(function(){
						if(labelFilesBool){
							var fileattachments=(labelFilesView.length>0?(bouncer(labelFilesView).join(',')+(labelFiles!=""?",":"")):"")+labelFiles;
							$("#formCustomlabel").ajaxSubmit({
				              	url:		'<c:url value="/updateLabelinfo.do"/>',
				              	data:		{
				              					personnelid:	${personnel.id},
				              					attachments:	fileattachments,
				              					id:				$('#firstLabel').val(),
				              					menuid:			${menuid},
				              					infotitle:		'自定义标签('+$('#customlabel').val()+')'
				              				},
				              	dataType:	'json',
				              	async:  	false,
				              	success:	function(data) {
									labelFiles='';
									labelFilesChoose=0;
									labelFilesBool=false;
									
									clearInterval(clearLabel);
				                  	var obj = eval('(' + data + ')');
				                  	if(obj.flag>0){
				                  	    //弹出loading
				                     	setTimeout(function(){         
				                     		top.layer.msg(obj.msg);
				                     		top.layer.close(index);
					 		        		//刷新自定义模块
					 		        		openLabelinfo(obj.flag);
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
				
				var _zTreeSelectMsz={};
				form.on('checkbox(attributeLable)',function(data){
					if(data.elem.checked==true){
						if(document.getElementById("attribute"+data.value)==null){
							$('#attributelabel').append("<div id='div"+data.value+"'><div class='layui-col-md11'><div class='layui-form-item my-form-item'><label class='layui-form-label'>"+data.elem.title+
								"</label><div class='layui-input-block'><div id='attribute"+data.value+"'></div></div></div></div>"+
								"<div class='layui-col-md1'><div class='layui-form-item my-form-item'><button onclick='addLabel("+data.value+",&quot;"+data.elem.title+"&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div></div>");
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
	          			addresult[num] = '{"attribute1":'+item+',"attribute2":"'+$("#attribute"+item).find("input").val()+'","applylabel1name":"'+addattributeLablenames[num]+'","applylabel2name":"'+_zTreeSelectMsz[item].names.join()+'"}';
	          		});
	          		var addjson="["+addresult.join(",")+"]";
	          		console.log(addjson);
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
				
				$("#labelHistory").click(function () {
					var index = layui.layer.open({
						title : '自定义标签('+$('#customlabel').val()+')'+"维护记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/custom/labelhistory.jsp?personnelid="+${personnel.id}+"&customlabelid="+$("#customlabelid").val(),
						area: ['800', '600px'],
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
				});
		  });
		  
		  layui.use(['form','zTreeSelectM'], function(){
			  var form = layui.form,
			  zTreeSelectM = layui.zTreeSelectM,
			  layer = layui.layer;
<%--			  var _zTreeSelectM1 = zTreeSelectM({--%>
<%--			    elem: '#attributelabels',//元素容器【必填】          --%>
<%--			    data: '<c:url value="/getAttributeLabelzTreeSelectM.do"/>',--%>
<%--			    type: 'get',  //设置了长度    --%>
<%--			    selected: [${personnelExtend.attributelabels}],//默认值            --%>
<%--			    max: 100,//最多选中个数，默认5            --%>
<%--			    name: 'attributelabels',//input的name 不设置与选择器相同(去#.)--%>
<%--			    delimiter: ',',//值的分隔符  --%>
<%--			    tips:' 人员属性标签：',--%>
<%--			    verify: 'required',   --%>
<%--			    reqtext:"请选择人员属性标签", --%>
<%--			    reqdiv:"attributelabels",          --%>
<%--			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 --%>
<%--			    zTreeSetting: { //zTree设置--%>
<%--			        check: {--%>
<%--			            enable: true,--%>
<%--			            chkboxType: { "Y": "", "N": "" }--%>
<%--			        },--%>
<%--			        data: {--%>
<%--			            simpleData: {--%>
<%--			                enable: false--%>
<%--			            },--%>
<%--			            key: {--%>
<%--			                name: 'name',--%>
<%--			                children: 'children'--%>
<%--			            }--%>
<%--			        },--%>
<%--			        view: {--%>
<%--			        	showIcon: false--%>
<%--					}--%>
<%--			    }--%>
<%--			});--%>
			  form.render();
		  });
		  
<%--		  function openCustomlabel(personlabel){--%>
<%--		  		$("#customlabelid").val(0);--%>
<%--				$("#tagTree").html("");--%>
<%--				if(personlabel>0)appendTagTree(personlabel,true);--%>
<%--				else{--%>
<%--					var personlabels="${personnelExtend.labelsql}".split(",");--%>
<%--					var titles="${personnelExtend.memo}".split(",");--%>
<%--					for(var i=0;i<personlabels.length;i++){--%>
<%--						$("#tagTree").append('<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-bottom: 1px;"><legend style="font-size:16px;">'+titles[i]+'</legend></fieldset>');--%>
<%--						if(i==0)appendTagTree(parseInt(personlabels[i]),true);--%>
<%--						else appendTagTree(parseInt(personlabels[i]),false);--%>
<%--					}--%>
<%--				}--%>
<%--		  }--%>
		  
		  function appendTagTree(personlabel,clickflag){
	  		$.ajax({
				type:		'POST',
				url:		'<c:url value="/getCustomLabelTagtree.do?personlabel="/>'+personlabel,
				dataType:	'json',
				async:      false,
				success:	function(data){
					$("#tagTree li.li-top > span").unbind();
					$("#tagTree li span").unbind();
					$("#tagTree li span i").unbind();
					$("#tagTree").tagTree({
				    	id:"",
				    	data:data,
				    	fold:false,
				    	multiple:false,
				    	check:function(val){
				    		$("#label").show();
				    		$("#customlabelid").val(val);
				    		openLabelinfo(val);
				    	},
				    	done:function(){
				    		if(clickflag){
					    		$("#label").hide();
					    		$("#tagTree .fa-check").each(function(index, el) {
									if($(el).attr('data-val')==data[0].value)$(el).click();
									return false;
								});
				    		}
				    	}
				    });
				}
			});
		  }
		  var labelFilesView=[];
		  function openLabelinfo(customlabelid){
		  		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getLabelinfo.do"/>',
					data:		{
									customlabelid:	customlabelid,
									personnelid:	${personnel.id}
								},
					dataType:	'json',
					async:      false,
					success:	function(result){
						var filesview=$("#label-view-fileList")
						filesview.html('');
						layui.upload.render();
						var label=result.customLabel,info=result.labelinfo;
						$("#labeltitle").html(label.customlabel+"("+label.personlabelname+")"+(label.labledescription.trim()!=""?":":"")+label.labledescription)
						$('#customlabel').val(label.customlabel+"("+label.personlabelname+")");
						$('#labelinfo').val(info.labelinfo);
						$('#labelmemo').val(info.memo);
						if(result.firstLabel>0){
							$('#firstLabel').val(info.id);
							$('#labelHistory').show();
							if(info.attachments!=""){
								labelFilesView=info.attachments.split(",");
								if(labelFilesView.length>0){
									var viewname=info.filesname.split(",");
									$.each(labelFilesView,function(index,item){
										var tr = $(['<tr>', '<td>' + viewname[index] +
											'</td>',
											'<td>上传完成</td>', '<td>',
											'<button class="layui-btn layui-btn-sm label-upload-file-download" onclick="return false;">下载</button>',
											'<button class="layui-btn layui-btn-sm layui-btn-danger label-upload-file-delete" onclick="return false;">删除</button>',
											'</td>', '</tr>'
										].join(''));
										//删除
										tr.find('.label-upload-file-delete').on('click', function() {
										    top.layer.confirm('确定删除此文件附件？', function(firm){
												top.layer.close(firm);
												delete labelFilesView[index]; //删除对应的文件
												tr.remove();
											});
										});
										tr.find('.label-upload-file-download').on('click', function() {
							          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
										});
										
										filesview.append(tr);
									});
								}
							}
						}else{
							$('#firstLabel').val(0);
							$('#labelHistory').hide();
						}
					}
				});
		  }
		  
		  function bouncer(array){
          		return array.filter(function(val){
          			return !(!val||val=="");
          		})
          }
          
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
								$('#attributelabel').append("<div class='layui-col-md11'><div class='layui-form-item my-form-item'><label class='layui-form-label'>"+item.attributelabel+
								"</label><div class='layui-input-block'><div id='attribute"+item.id+"'></div></div></div></div>"+
								"<div class='layui-col-md1'><div class='layui-form-item my-form-item'><button onclick='addLabel("+item.id+",&quot;"+item.attributelabel+"&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div>");
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
				    	}},
				    	{field:'failreason', title: '审核理由', width:200,align:"center"}
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
	          	
	          	
	       //监听个人简历   工具事件
		  table.on('toolbar(kongpublicresume)', function(obj){
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增个人简历",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/zhengbao/resume/add.jsp?controlpowerid="/>'+${personnel.id},
						area: ['600px', '500px'],
						offset:['70px'],
						maxmin: true,
						success : function(layero, index){
						}
					})		
				 break;
			 }
		 }); 	
	    //监听个人简历   列表按钮
	    table.on('tool(kongpublicresume)', function(obj){
		  var id = obj.data.id;
		  if(obj.event == 'update'){
		   		var index = layui.layer.open({
					title : "修改个人简历",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getkongpublicresumebyid.do?id='+id+'&menuid=0&page=update_zhengbao',
					area: ['600px', '500px'],
					offset:['70px'],
					maxmin: true,
					success : function(layero, index){
					}
			})			
				
		    }else if(obj.event == 'cancel'){
		          top.layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelKongPublicResume.do?id="+id+'&menuid=0',{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('kongpublicresume', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
					});
		     }
    	});	     	
	          	
	    
	    
	      //监听主要活动情况   工具事件
		  table.on('toolbar(hdjlTable)', function(obj){
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增主要活动情况",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/zhengbao/assessment/add.jsp?controltype=3&personnelid="/>'+${personnel.id},
						area: ['800px', '600px'],
						offset:['70px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					})	
				 break;
			 }
		 }); 	
	    
	     //监听主要活动情况   列表按钮
	    table.on('tool(hdjlTable)', function(obj){
		  var id = obj.data.id;
		  if(obj.event == 'update'){
		   			var index = layui.layer.open({
							title : "修改主要活动情况",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/searchdailycontrolbyid.do?page=zhengbao_assessment&id='+id,
							area: ['800px', '600px'],
							offset:['70px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
			}else if(obj.event == 'cancel'){
		          top.layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelkongdailycontrol.do?id="+id+'&menuid=0',{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('hdjlTable', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
					});
		     }
    	});	     	
	    
	   });          	
          
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
          function examine(personnelid){
           var jointcontrollevel="${wenGrade.jointcontrollevel}";
	       if(jointcontrollevel==null){
	            jointcontrollevel="";
	        }
             $.getJSON(locat+"/getjointcontrollevelCount.do?personnelid="+personnelid,{},function(data) {
				var str = eval('(' + data + ')');
	        	 if (str.flag>0) {		                          
			               top.layer.msg("该人员存在未审核联控级别调整申请，不可重复申请......");
			      }else{
				    var index = layui.layer.open({
					title : "联控级别调整申请",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/personel/wen/jointcontrollevel/add.jsp?menuid='+${param.menuid}+'&personnelid='+personnelid+'&jointcontrollevel_old='+jointcontrollevel+'"/>',
					area: ['800', '500px'],
					offset:['50'],
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
	       });      
          }
          //政保特殊信息-个人简历
          function opengrjl(controlpowerid){
             //方法级渲染
			  layui.table.render({
			    elem: '#kongpublicresume',
			    toolbar: true,
			    defaultToolbar: ['filter', 'exports', 'print'],
			    url: '<c:url value="/searchZbPublicResume.do?controlpowerid="/>'+controlpowerid,
			    method:'post',
			    toolbar: '#resumetoolbarButton',
			    cols: [[
			        {field:'starttime', title: '开始时间', width:120,align:"center"},
			        {field:'endtime', title: '结束时间', width:120,align:"center"},
			        {field:'workdetails', title: '学习工作经历',align:"center"},
			        {field: 'right', title: '操作', toolbar: '#resumebar',width:120,align:"center"} 
			    ]],
			    page: true,
			    limit: 10
			    });
          }
          
          
          //政保特殊信息-主要活动情况
          function openhdjl(controlpowerid){
             //方法级渲染
		   layui.table.render({
		    elem: '#hdjlTable',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    url: '<c:url value="/searchKongDailyControl.do?controltype=3&personnelid="/>'+controlpowerid,
		    method:'post',
		    toolbar: '#resumetoolbarButton',
		    cols: [[
		        {field:'controltime', title: '活动时间', width:120,align:"center"},
		        {field:'controlcontent', title: '活动简况', align:"center",templet: function (item) {
						var controlcontent="";
						if(item.controlcontent!=null&&item.controlcontent!=""){
						  controlcontent= item.controlcontent.replace(/\n/g,"<br/>");
					}
					return "<div>"+controlcontent+"</div>";
		         }},
		        {field:'addtime', title: '填写时间',width:150,align:"center"},
		        {field: 'right', title: '操作', toolbar: '#resumebar',width:120,align:"center"} 
		      
		    ]],
		    page: true,
		    limit: 10
		    });
          }
          
          function opensjxx(personnelid){
          	layui.table.render({
		    elem: '#sjxxTable',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    url: '<c:url value="/searchByKeyperson.do"/>',
		    where: {type:2,personnelid:personnelid},
		    method:'post',
		    cols: [[
		        {field:'cdtname', title: '事件名称', width:200,align:"center",templet: function(d){
		    		return "<a href='#' style='text-decoration: underline;' onclick='showZbInfo(&quot;"+d.id+"&quot;);return false;'><font color='blue'>"+d.cdtname+"</font></a>";
		    	}},
		        {field:'cdtlevel', title: '事件级别', width:120,align:"center"},
    			{field:'cdttype', title: '事件类别', width:120,align:"center"},
		    	{field:'sfdz', title: '发生地点', width:200,align:"center"},
		    	{field:'memo', title: '发生时间',align:"center"}
		      
		    ]],
		    page: true,
		    limit: 10
		    });
          }
          
          function showZbInfo(id){
			var index = layui.layer.open({
				title : "政保事件详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="showZbEvent.do"/>?id='+id+'&menuid=${param.menuid }',
				area: ['800', '750px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});
			layui.layer.full(index);
		}
		
		function openposition(personnelid){
          	layui.table.render({
			    elem: '#positionTable',
			    toolbar: true,
			    defaultToolbar: ['filter', 'exports', 'print'],
			    url: '<c:url value="/searchPosition.do"/>',
			    where: {personnelid:personnelid},
			    method:'post',
			    cols: [[
			    	{field:'positionname', title: '名称', width:150,align:"center",templet: function (item) {
					   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPosition("+item.id+");'><font color='blue'>"+item.positionname+"</font></span>";
			           }},
			    	{field:'positiontype', title: '阵地级别', width:100} ,
    				{field:'positioncharacter', title: '阵地类别',width:120} ,
			        {field:'setuptime', title: '成立时间', width:120} , 
			        {field:'setupplace', title: '成立地点', width:120} , 
			        {field:'addoperator', title: '建档人', width:90} ,
			        {field:'addtime', title: '建档时间', width:170} 
			    ]],
			    page: true,
			    limit: 10
		    });
          }
          
          function showinfoPosition(id){
		 	var index = layui.layer.open({
				title : "政保阵地详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getPositionUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
				area: ['800', '700px'],
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
		 
		 function openorganization(personnelid){
          	layui.table.render({
			    elem: '#organizationTable',
			    toolbar: true,
			    defaultToolbar: ['filter', 'exports', 'print'],
			    url: '<c:url value="/searchOrganization.do"/>',
			    where: {personnelid:personnelid},
			    method:'post',
			    cols: [[
			    	{field:'orgName', title: '名称',align:"center",templet: function (item) {
					   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoOrganization("+item.id+");'><font color='blue'>"+item.orgName+"</font></span>";
			           }},
			    	{field:'orgType', title: '组织级别',align:"center"} ,
			    	{field:'inProvince', title: '是否省内组织',align:"center"} ,
			    	{field:'isRegister', title: '是否登记注册',align:"center"} ,
			        {field:'createTime', title: '成立时间',align:"center"} ,
			        {field:'activeLevel', title: '活跃程度',align:"center"} ,
			        {field:'isForeignConnections', title: '是否与境外存在勾连',align:"center"} ,
			        {field:'addoperator', title: '建档人',align:"center"} ,
			        {field:'addtime', title: '建档时间',align:"center"}
			    ]],
			    page: true,
			    limit: 10
		    });
          }
          function showinfoOrganization(id){
		 	var index = layui.layer.open({
				title : "政保组织详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getOrganizationUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
				area: ['800', '700px'],
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
		 
		 function openWorkRecord(personnelid){
		 	layui.table.render({
			    elem: '#workRecordTable',
			    toolbar: true,
			    defaultToolbar: ['filter', 'exports', 'print'],
			    url :   locat+"/searchWorkRecord.do?recordtype=personel&recordid="+personnelid,
			    method:'post',
			    toolbar: '#socialrelationstoolbar',
			    cols: [[
			        {field:'id',type:'radio',fixed:'true',align:"center"},
			        {field:'worktime', title: '时间', width:150,align:"center",templet: function (item) {
					   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWorkRecord("+item.id+");'><font color='blue'>"+item.worktime+"</font></span>";
			           }},
			        {field:'worktype', title: '工作方式', width:120,align:"center"},
			        {field:'workplace', title: '地点',width:120,align:"center"}, 
                    {field:'workrecord', title: '工作记录',align:"center"},
                    {field:'addoperator', title: '记录民警',align:"center"}
			    ]],
			    page: true,
			    limit: 10
			    });
			    
			 layui.table.on('toolbar(workRecordTable)', function(obj){
			  	var checkStatus =layui.table.checkStatus(obj.config.id);
				var menuid=$("#menuid").val();
				switch(obj.event){
					case 'add':
				  		var index = layui.layer.open({
							title : "新增民警工作记载",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/jsp/position/record/add.jsp?menuid="+menuid+"&recordtype=personel&recordid="+personnelid,
							area: ['800', '600px'],
							maxmin: true,
							success : function(layero, index){
							},
							cancel: function (index, layero) {//取消事件
							       //  alert(1);
							    //  element.tabChange('dev_tab', "six");
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
								title : "修改工作记载",
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content :locat+"/getWorkRecordUpdate.do?id="+id+"&menuid="+menuid+'&page=update',
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
							top.layer.confirm('确定删除此信息？', function(index){
						      layer.close(index);
						      $.getJSON(locat+"/cancelWorkRecord.do?id="+id+'&menuid='+menuid,{},function(data) {
								 var str = eval('(' + data + ')');
						      	 if (str.flag ==1) {		                          
								     top.layer.msg("数据删除成功！"); 	
								     openWorkRecord(personnelid);                
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
		 }
		 function showinfoWorkRecord(id){
		 	var index = layui.layer.open({
				title : "民警工作记载详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getWorkRecordUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
				area: ['800', '700px'],
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
