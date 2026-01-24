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
	 <link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
	 <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
	 <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
<%--	<script type="text/javascript" src="<c:url value="/jsp/personel/personel.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->在最后面--%>
	<style>
<%--			.layui-table-cell {--%>
<%--		    font-size:14px;--%>
<%--		    padding:0 5px;--%>
<%--		    overflow:visible;--%>
<%--		    text-overflow:inherit;--%>
<%--		    white-space:normal;--%>
<%--		    word-break: break-all;--%>
<%--		}--%>
<%--		.layui-table-main .layui-table td div:not(.laytable-cell-radio){--%>
<%--	        height: auto;--%>
<%--	        overflow:visible;--%>
<%--	        text-overflow:inherit;--%>
<%--	        white-space:normal;--%>
<%--	    }--%>
	    .layui-table-fixed .layui-table-body{
	    	display:none;
	    }
	    .my-tab-title li {
			  width:25%
		}
	    .layui-table-fixed .layui-table-header{
	    	display:none;
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
		
		<div class="layui-form layui-row">
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<form class="layui-form" method="post" id="formWenGrade">
					<input type="hidden"  name="menuid"   id="menuid" value=${menuid }>
					<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
					<input type="hidden"  name="zslabel1"    id="zslabel1"  value=${personnel.zslabel1 }>
					<input type="hidden"  name="policephone1" value="${personnel.pphone1}">
					<input type="hidden"  name="policephone2" value="${personnel.pphone2}">
					<input type="hidden"  name="personnelid"id="personnelid" value=${wenGrade.personnelid }>
					<input type="hidden"  name="personlabel"id="personlabel" value="${personnel.personlabel }">
					<input type="hidden"  name="isFilter"id="isFilter" value="<%=userSession.getLoginRoleFieldFilter()%>">
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
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">联控级别：</label>
								<div class="layui-input-block">
								<select name="jointcontrollevel"  id="jointcontrollevel">
										<option value="">==请选择==</option>
										<c:forEach items="${jointcontrollevel}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == wenGrade.jointcontrollevel }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
                      <%-- <input type="text" autocomplete="off" style="background:#efefef"  value="${wenGrade.jointcontrollevel}" name="jointcontrollevel" readonly class="layui-input">--%>
								</div>
							</div>
						</div>
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">上行意愿：</label>
								<div class="layui-input-block">
									<select name="awaywill">
										<option value="">==请选择==</option>
										<c:forEach items="${awaywill}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == wenGrade.awaywill }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="layui-col-md4">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">在控状态：</label>
								<div class="layui-input-block">
									<select name="incontrollevel">
										<option value="">==请选择==</option>
										<c:forEach items="${incontrollevel}" var="row" varStatus="num">
											<option value="${row.basicName}" <c:if test="${row.basicName == wenGrade.incontrollevel }">selected</c:if>>${row.basicName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
	
<%--						<div class="layui-col-md12">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>风险人员类别：</label>--%>
<%--								<div class="layui-input-block">--%>
<%--									<div id="personneltype"></div>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
						<div class="layui-col-md12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label"><font color="red" size=2>*</font>责任警种：</label>
								<div class="layui-input-block">
									<div id="responsiblepolice"></div>
								</div>
							</div>
						</div>
						<div id="jd1_div">
							<div class="layui-col-md8" id="jd1_col8">
								<div class="layui-col-md7">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任单位：</label>
										<div class="layui-form layui-input-block" id="jdunit1_div" lay-filter="jdunit1_div">
											<input type="text" id="jdunit1" name="jdunit1" value="0" lay-filter="jdunit1" lay-verify="jdunit1" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md5" id="jd1_col5">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任民警：</label>
										<div class="layui-input-block">
											<select id="jdpolice1" name="jdpolice1" lay-filter="jdpolice1">
				    						</select>
										</div>
									</div>
								</div>
							</div>
							<div class="layui-col-md4" id="jd1_col4">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">民警手机：</label>
									<div class="layui-input-block">
										<input type="text" autocomplete="off" name="pphone1" id="pphone1" lay-verify=""
											value="${personnel.pphone1}" placeholder="请输入民警手机" class="layui-input">
									</div>
								</div>
							</div>
						</div>
						<div id="jd2_div">
							<div class="layui-col-md8" id="jd2_col8">
								<div class="layui-col-md7">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">双列管单位：</label>
										<div class="layui-form layui-input-block" id="jdunit2_div" lay-filter="jdunit2_div">
											<input type="text" id="jdunit2" name="jdunit2" value="0" lay-filter="jdunit2" lay-verify="jdunit2" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md5" id="jd2_col5">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">双列管民警：</label>
										<div class="layui-input-block">
											<select id="jdpolice2" name="jdpolice2"  lay-filter="jdpolice2">
				    						</select>
										</div>
									</div>
								</div>
							</div>
							<div class="layui-col-md4" id="jd2_col4">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">民警手机：</label>
									<div class="layui-input-block">
										<input type="text" autocomplete="off" name="pphone2" id="pphone2" lay-verify=""
											value="${personnel.pphone2}" placeholder="请输入民警手机" class="layui-input">
									</div>
								</div>
							</div>
						</div>
						<div class="layui-col-md8 layui-col-md-offset4" style="margin-bottom: 30px;margin-top: 30px;">
							<div class="layui-form-item my-form-item">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="updateWenGrade">立即提交</button>
							<button type="button" class="layui-btn" lay-submit="" lay-filter="examine"  onclick="examine(${personnel.id})">级别调整申请</button>
	<%--						<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重置&nbsp;</button>--%>
							</div>
						</div>
					</div>
				</form>
				<div style="height:100px;"></div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab">
				<div style="position: relative;">
					<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
						style="margin: 0 30px;width: auto !important;">
						<div class="swiper-wrapper" style="width:85px;height: 80px;">
							<li class="btn btn_11 layui-this swiper-slide" onclick="openAttributelabel()" >人员属性标签</li>
							<li class="btn btn_1 swiper-slide">关联信息</li>
							<li class="btn btn_2 swiper-slide"  onclick="openWenRisk(${wenGrade.personnelid})">风险背景</li>
							<li class="btn btn_3 swiper-slide"  onclick="searchWenVisit()">涉诉涉访经历</li>
						    <li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
							<li class="btn btn_5 swiper-slide"  onclick="openJointControlRecord(${wenGrade.personnelid});">联控记录</li>
							<li class="btn btn_6 swiper-slide"   onclick="openSocialRelations(${personnel.id});">社会关系</li>
							<li class="btn btn_7 swiper-slide"  onclick="openRealityShow(${wenGrade.personnelid})">现实表现</li>
							<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
							<div class="swiper-slide"></div>
						</div>
					</div>
					<div class="my-swiper-button-next swiper-button-next1"></div>
					<div class="my-swiper-button-prev swiper-button-prev1"></div>
				</div>	
				
				<div class="layui-tab-content swiper-container">
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
                    <div class="right-child-content layui-tab-item ">
                    	<div class="layui-tab my-tab layui-tab-brief">
							<ul class="layui-tab-title my-tab-title">
								<li class="layui-this">公安数据</li>
								<li>政法委数据</li>
							</ul>
							<div class="layui-tab-content" >
							     <div class="layui-tab-item layui-show">
							           <form class="layui-form" method="post" id="formRelation"  onsubmit="return false;">
										   <div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">手机号码：</label>
														<div class="layui-input-block">
															<input type="text" name=telnumber  id="telnumber"  lay-verify="title" autocomplete="off"  readonly
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
															<input type="text" name="telephone"  id="telephone"   lay-verify="title" autocomplete="off" readonly
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
															<input type="text" name="relatedwifi" id="relatedwifi"   lay-verify="title" autocomplete="off" readonly
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
							     <div class="layui-tab-item">
							     		<form class="layui-form" method="post" id="formRelation"  onsubmit="return false;">
							     				<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">手机号码：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_telnumber"  id="zfw_telnumber"  lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.telnumber}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('telnumber',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
													<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">使用手机：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_telephone"  id="zfw_telephone"   lay-verify="title" autocomplete="off" readonly
																value="${zfw_relation.telephone}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button  onclick="openRelation_zfw('telephone',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">关联wifi：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_relatedwifi" id="zfw_relatedwifi"   lay-verify="title" autocomplete="off" readonly
																value="${zfw_relation.relatedwifi}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button  onclick="openRelation_zfw('relatedwifi',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">交通工具：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_relatedvehicle"  id="zfw_relatedvehicle"   lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.relatedvehicle}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('relatedvehicle',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">银行账号：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_bankaccount" id="zfw_bankaccount"  lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.bankaccount}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('bankaccount',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
					
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">虚拟身份：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_netidentity"  id="zfw_netidentity"   lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.netidentity}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('netidentity',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
					
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">网络支付：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_netpayment"  id="zfw_netpayment"   lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.netpayment}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('netpayment',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
					
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label">涉及房产：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_relatedhouse"  id="zfw_relatedhouse"  lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.relatedhouse}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('relatedhouse',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
					
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label ">法人组织：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_relatedlegal"  id="zfw_relatedlegal"   lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.relatedlegal}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('relatedlegal',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label ">驾驶证件：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_relateddriver"  id="zfw_relateddriver"   lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.relateddriver}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('relateddriver',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
												<div class="layui-col-md11">
													<div class="layui-form-item my-form-item">
														<label class="layui-form-label ">护照情况：</label>
														<div class="layui-input-block">
															<input type="text" name="zfw_relatedpassport"  id="zfw_relatedpassport"   lay-verify="title" autocomplete="off"  readonly
																value="${zfw_relation.relatedpassport}" placeholder="" class="layui-input">
														</div>
													</div>
												</div>
												<div class="layui-col-md1">
													<div class="layui-form-item my-form-item">
														<button onclick="openRelation_zfw('relatedpassport',${personnel.id},'${buttons}');"
															class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
															更多</button>
													</div>
												</div>
											<br>
									</form>
							     </div>
							</div>
						</div>
					</div>	
			

						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								     	<form class="layui-form" method="post" id="formWenRisk"   onsubmit="return false;">
											<input type="hidden" id="firstRisk" value=0>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">矛盾风险产生经过、详情
													<button class="layui-btn layui-btn-sm" id="riskHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
													<div class="my-input-block">
														<textarea placeholder="请输入内容" class="layui-textarea"
															id="conflictdetails" name="conflictdetails"></textarea>
													</div>
												</div>
											</div>
											
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">目前风险状态及人员诉求</label>
													<div class="my-input-block">
														<textarea placeholder="请输入内容" class="layui-textarea"
															id="riskappeal" name="riskappeal"></textarea>
													</div>
												</div>
											</div>
											<!-- 多文件上传 -->
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item" style="padding: 15px;">
													文件附件：
													<button type="button" class="layui-btn layui-btn-sm"
														id="risk-upload-fileList"><i class="layui-icon"></i>上传多文件</button>
													<button type="button" class="layui-btn layui-hide"
														id="risk-upload-fileListAction">开始上传</button>
													<div class="layui-upload">
														<div class="layui-upload-list">
															<table class="layui-table" style="border: 1px solid #eee;">
																<thead>
																	<tr>
																		<th width="30%">文件名</th>
																		<th width="20%">状态</th>
																		<th width="25%">上传时间</th>
																		<th width="25%">操作</th>
																	</tr>
																</thead>
																<tbody id="risk-view-fileList"></tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
											<!-- 上传视频 -->
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item" style="padding: 15px;">
													视频附件：
													<button type="button" class="layui-btn layui-btn-sm" id="risk-upload-videoList"><i
															class="layui-icon"></i>上传视频</button>
													<button type="button" class="layui-btn layui-hide"
														id="risk-upload-videoListAction">开始上传</button>
													<div class="layui-upload-list">
														<table class="layui-table" style="border: 1px solid #eee;">
															<thead>
																<tr>
																	<th width="30%">文件名</th>
																	<th width="20%">状态</th>
																	<th width="25%">上传时间</th>
																	<th width="25%">操作</th>
																</tr>
															</thead>
															<tbody id="risk-view-videoList"></tbody>
														</table>
													</div>
												</div>
											</div>
											<div class="layui-col-md3 layui-col-md-offset5">
												<div class="layui-form-item my-form-item" style="padding: 15px;">
													<button type="submit" class="layui-btn"  lay-submit="" lay-filter="riskSub">立即提交</button>
				<%--									<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重--%>
				<%--										置&nbsp;</button>--%>
												</div>
											</div>
										</form>
								     </div>
								     <div class="layui-tab-item">
								           <form class="layui-form" method="post" id="formWenRisk_zfw"   onsubmit="return false;">
											<input type="hidden" id="firstRisk_zfw" value=0>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">矛盾风险产生经过、详情
													<button class="layui-btn layui-btn-sm" id="riskHistory_zfw" style="display:none;"><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
													<div class="my-input-block">
														<textarea placeholder="请输入内容" class="layui-textarea"
															id="conflictdetails_zfw" name="conflictdetails_zfw" readonly></textarea>
													</div>
												</div>
											</div>
											
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">目前风险状态及人员诉求</label>
													<div class="my-input-block">
														<textarea placeholder="请输入内容" class="layui-textarea" id="riskappeal_zfw" name="riskappeal_zfw" readonly></textarea>
													</div>
												</div>
											</div>
											<!-- 多文件上传 -->
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item" style="padding: 15px;">
													文件附件：
													<div class="layui-upload">
														<div class="layui-upload-list">
															<table class="layui-table" style="border: 1px solid #eee;">
																<thead>
																	<tr>
																		<th width="30%">文件名</th>
																		<th width="20%">状态</th>
																		<th width="25%">上传时间</th>
																		<th width="25%">操作</th>
																	</tr>
																</thead>
																<tbody id="risk-view-fileList_zfw"></tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
											<!-- 上传视频 -->
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item" style="padding: 15px;">
													<div class="layui-upload-list">
														<table class="layui-table" style="border: 1px solid #eee;">
															<thead>
																<tr>
																	<th width="30%">文件名</th>
																	<th width="20%">状态</th>
																	<th width="25%">上传时间</th>
																	<th width="25%">操作</th>
																</tr>
															</thead>
															<tbody id="risk-view-videoList_zfw"></tbody>
														</table>
													</div>
												</div>
											</div>
										</form>
								     </div>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <script type="text/html" id="wenVisitToolbar">
   	                            				<button type="button" class="layui-btn layui-btn-sm" lay-event="search"><i class="layui-icon">&#xe615;</i>刷 新</button>
   	                            				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	                            				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
                                				<c:if test='${fn:contains(buttons,"删除")}'>
   	                           	    				<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
                                				</c:if>
	                     					</script> 
							         		<table class="layui-hide" id="wenVisitTable" lay-filter="wenVisitTable"></table>
								     </div>
								     <div class="layui-tab-item">
								     		<table class="layui-hide" id="wenVisitTable_zfw" lay-filter="wenVisitTable_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item"><!-- 轨迹信息 -->
                            <form class="layui-form" method="post" id="formTrajectoryTable" onsubmit="return false;">
	                            <div class="layui-inline" style="width:212px;left:20px;">
	                            	<select id="trajectoryTableTypes" lay-filter="trajectoryTableTypes"></select>
	                            </div>       
								<table class="layui-hide" id="trajectoryTable" lay-filter="trajectoryTable"></table>
							</form>
						</div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
										<table class="layui-hide" id="jointcontrolrecordTable" lay-filter="jointcontrolrecordTable"></table> <!-- 联控信息 -->
								     </div>
								     <div class="layui-tab-item">
								     	<table class="layui-hide" id="jointcontrolrecordTable_zfw" lay-filter="jointcontrolrecordTable_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
						<script type="text/html" id="socialrelationstoolbar">
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	                            <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
                                <c:if test='${fn:contains(buttons,"删除")}'>
   	                                   <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
                                 </c:if>
	                     </script> 
			            <script type="text/html" id="socialrelationsbar">
                           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
	                    </script>
	                     <script type="text/html" id="trajectoryrecordbar">
                            <a class="layui-btn layui-btn-xs" lay-event="qbbs">情报上报</a>       
	                    </script>
						<div class="right-child-content layui-tab-item"><!--社会关系 -->
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li onclick="openSocialRelations_zfw(${wenGrade.personnelid});">政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
										<table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table>
								     </div>
								     <div class="layui-tab-item">
								     	<table class="layui-hide" id="socialrelationsTable_zfw" lay-filter="socialrelationsTable_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item"><!--现实表现 -->
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								     	<form class="layui-form" method="post" id="formRealityShow" onsubmit="return false;">
											<input type="hidden" id="firstShow" value=0>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">日常生活规律
													<button class="layui-btn layui-btn-sm" id="showHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>历史修改记录</button></label>
													<div class="my-input-block">
														<textarea placeholder="请输入日常生活规律内容" class="layui-textarea"
															id="lifepattern" name="lifepattern"></textarea>
													</div>
												</div>
											</div>
											
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">健康状况</label>
													<div class="my-input-block">
														<textarea placeholder="请输入健康状况内容" class="layui-textarea"
															id="healthstate" name="healthstate"></textarea>
													</div>
												</div>
											</div>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">性格特点</label>
													<div class="my-input-block">
														<textarea placeholder="请输入性格特点内容" class="layui-textarea"
															id="characteristic" name="characteristic"></textarea>
													</div>
												</div>
											</div>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">生活习惯</label>
													<div class="my-input-block">
														<textarea placeholder="请输入生活习惯内容" class="layui-textarea"
															id="lifehabit" name="lifehabit"></textarea>
													</div>
												</div>
											</div>
											<div class="layui-col-md3 layui-col-md-offset5">
												<div class="layui-form-item my-form-item" style="padding: 15px;">
													<button type="submit" class="layui-btn"  lay-submit="" lay-filter="showSub">立即提交</button>
				                                 </div>
											</div>
										</form>
								     </div>
								     <div class="layui-tab-item">
								     	<form class="layui-form" method="post" onsubmit="return false;">
											<input type="hidden" id="firstShow_zfw" value=0>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">日常生活规律
													<button class="layui-btn layui-btn-sm" id="showHistory_zfw" style="display:none;"><i class="layui-icon">&#xe68d;</i>历史修改记录</button></label>
													<div class="my-input-block">
														<textarea placeholder="请输入日常生活规律内容" class="layui-textarea"
															id="lifepattern_zfw" name="lifepattern_zfw"></textarea>
													</div>
												</div>
											</div>
											
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">健康状况</label>
													<div class="my-input-block">
														<textarea placeholder="请输入健康状况内容" class="layui-textarea"
															id="healthstate_zfw" name="healthstate_zfw"></textarea>
													</div>
												</div>
											</div>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">性格特点</label>
													<div class="my-input-block">
														<textarea placeholder="请输入性格特点内容" class="layui-textarea"
															id="characteristic_zfw" name="characteristic_zfw"></textarea>
													</div>
												</div>
											</div>
											<div class="layui-col-md12">
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">生活习惯</label>
													<div class="my-input-block">
														<textarea placeholder="请输入生活习惯内容" class="layui-textarea"
															id="lifehabit_zfw" name="lifehabit_zfw"></textarea>
													</div>
												</div>
											</div>
										</form>
								     </div>
								</div>
							</div>
							
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
		<script type="text/html" id="checkToolbar">
			<c:if test='${fn:contains(param.buttons,"审核")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="check"><i class="layui-icon layui-icon-survey"></i>审核</button>
			</c:if>
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
				var  isFilter= $('#isFilter').val(); //获取数据过滤标志
				//当前用户如数据过滤（用户过滤or部门过滤），不可编辑修改联控状态
				if(isFilter==1){
				    $("#jointcontrollevel").attr("disabled","disabled");
				}else if(isFilter==2){
				    $("#jointcontrollevel").attr("disabled","disabled");
				}
			});
			
			layui.config({
			    base: "<c:url value="/layui/lay/modules/"/>"
			}).extend({
			    treeSelect: "treeSelect",
			    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
			    selectInput:"selectInput/selectInput"
			});
			
			layui.use(['form','treeSelect'], function(){
				var form = layui.form,
		  		treeSelect = layui.treeSelect;
		  		var ztreestylechange1=treeSelect.render({
			        // 选择器
			        elem: '#jdunit1',
			        // 数据
			        //data: '<c:url value="/getDepartmentTree.do"/>',
			        data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
			        // 异步加载方式：get/post，默认get
			        type: 'get',
			        // 占位符
			        placeholder: '管辖责任单位',
			        // 是否开启搜索功能：true/false，默认false
			        search: true,
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
			        	if("${personnel.jdunit1}"!=""){
				        	treeSelect.checkNode('jdunit1', "${personnel.jdunit1}");
				        	treeSelect.refresh('jdunit1');
				        	getUsers("${personnel.jdunit1}",1,"${personnel.jdpolice1}");
				        	form.render();
			        	if("<%=userSession.getLoginUserRoleid()%>"==32||"<%=userSession.getLoginUserRoleid()%>"==31){
					        	$("#jdunit1_div").css("pointerEvents","none");
					        	if("<%=userSession.getLoginUserDepartmentid()%>"=="${personnel.jdunit1}"){
					        		$("#jd2_div").css("pointerEvents","none");
					        		$("#jd2_col4").css("backgroundColor","#efefef");
					        		$("#jd2_col8").css("backgroundColor","#efefef");
					        	}
				        	}
			        	}
			        	$('#treeSelect-input-jdunit1').blur(function(){
			        		form.render(null,"jdunit1_div");
					    });
			        }
			    });
			    
			});
			layui.use(['form','treeSelect'], function(){
				var form = layui.form,
		  		treeSelect = layui.treeSelect;
		  		var ztreestylechange2=treeSelect.render({
			        // 选择器
			        elem: '#jdunit2',
			        // 数据
			        //data: '<c:url value="/getDepartmentTree.do"/>',
			        data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
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
			        	if("<%=userSession.getLoginUserRoleid()%>"==32||"<%=userSession.getLoginUserRoleid()%>"==31){
				        	$("#jdunit2_div").css("pointerEvents","none");
				        	if("<%=userSession.getLoginUserDepartmentid()%>"=="${personnel.jdunit2}"){
				        		$("#jd1_div").css("pointerEvents","none");
				        		$("#jd1_col4").css("backgroundColor","#efefef");
				        		$("#jd1_col8").css("backgroundColor","#efefef");
				        	}
			        	}
			        	$('#treeSelect-input-jdunit2').blur(function(){
			        		form.render(null,"jdunit2_div");
					    });
			        }
			    });
			});
			
			layui.use(['element', 'form', 'upload','jquery','selectInput','zTreeSelectM'], function() {
				var element = layui.element,
					upload = layui.upload,
					$ = layui.jquery,
					selectInput= layui.selectInput,
		  			zTreeSelectM = layui.zTreeSelectM,
					form = layui.form;
				
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
<%--				var _zTreeSelectM1 = zTreeSelectM({--%>
<%--				    elem: '#personneltype',//元素容器【必填】          --%>
<%--				    json: ${personneltype},//json数组直接获取 默认''--%>
<%--				    //data:url--%>
<%--				    width: "90%",  //设置了长度    --%>
<%--				    selected: [${wenGrade.personneltype}],//默认值            --%>
<%--				    max: 100,//最多选中个数，默认5            --%>
<%--				    name: 'personneltype',//input的name 不设置与选择器相同(去#.)--%>
<%--				    delimiter: ',',//值的分隔符 --%>
<%--				    tips:'请选择风险人员类别',--%>
<%--				    verify: 'required',   --%>
<%--				    reqtext:"请选择风险人员类别", --%>
<%--				    reqdiv:"personneltype",  --%>
<%--				    field: { idName: 'id', titleName: 'name'},//候选项数据的键名 --%>
<%--				    zTreeSetting: { //zTree设置--%>
<%--				        check: {--%>
<%--				            enable: true,--%>
<%--				            chkboxType: { "Y": "", "N": "" }--%>
<%--				        },--%>
<%--				        data: {--%>
<%--				            simpleData: {--%>
<%--				                enable: false--%>
<%--				            },--%>
<%--				            key: {--%>
<%--				                name: 'name',--%>
<%--				                children: 'children'--%>
<%--				            }--%>
<%--				        },--%>
<%--				        view: {--%>
<%--				        	showIcon: false--%>
<%--						}--%>
<%--				    }--%>
<%--				});  --%>
			  var _zTreeSelectM2 = zTreeSelectM({
				    elem: '#responsiblepolice',//元素容器【必填】          
				    json: ${responsiblepolice},//json数组直接获取 默认''
				    //data:url
				    width: "90%",  //设置了长度    
				    selected: [${wenGrade.responsiblepolice}],//默认值            
				    max: 100,//最多选中个数，默认5            
				    name: 'responsiblepolice',//input的name 不设置与选择器相同(去#.)
				    delimiter: ',',//值的分隔符 
				    tips:'请选择责任警种',      
				    verify: 'required', 
				    reqtext:"请选择责任警种", 
				    reqdiv:"responsiblepolice",      
				    field: { idName: 'id', titleName: 'basicName'},//候选项数据的键名 
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
				                name: 'basicName'
				            }
				        },
				        view: {
				        	showIcon: false,
							showLine: false
						}
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
				form.on('submit(updateWenGrade)', function(data) {
					var url='<c:url value="/updateWenGrade.do"/>?personFilter='+${wenGrade.id};//临时存放id
					if(!$("input[name=homewifi]").prop("checked"))url+="&homewifi=";
					if(!$("input[name=homewide]").prop("checked"))url+="&homewide=";
					if(!$("input[name=workwifi]").prop("checked"))url+="&workwifi=";
					if(!$("input[name=workwide]").prop("checked"))url+="&workwide=";
				$("#jointcontrollevel").removeAttr("disabled");//提交前移除只读 否则获取不到值
				
					$("#formWenGrade").ajaxSubmit({
		              	url:		url,
						dataType:	'json',
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
					        		//layer.closeAll("iframe");
			 		        		//刷新父页面
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
					return false;
				});

				//多文件列表示例
				var riskFilesListView = $("#risk-view-fileList"),
					riskFiles='',
					riskFilesChoose=0,
					riskFilesBool=false,
					riskFilesUploadListIns = upload.render({
						elem: '#risk-upload-fileList',
		        		url: '<c:url value="/newuploadfile1.do"/>',
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
					
				//视频列表示例
				var riskVideosListView = $("#risk-view-videoList"),
					riskVideos='',
					riskVideosChoose=0,
					riskVideosBool=false,
					riskVideosUploadListIns = upload.render({
						elem: '#risk-upload-videoList',
		        		url: '<c:url value="/newuploadrecodefile.do"/>',
						accept: 'video',
						acceptMime:'video/*',
						multiple: true,
						auto: false,
						bindAction: '#risk-upload-videoListAction',
						choose: function(obj) {
							var videos = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
							//读取本地文件
							obj.preview(function(index, video, result) {
								var tr = $(['<tr id="risk-video-upload-' + index + '">', '<td>' + video.name +
									'</td>',
									'<td>等待上传</td>', '<td>',
									'<button class="layui-btn layui-btn-sm risk-upload-video-reload layui-hide">重传</button>',
									'<button class="layui-btn layui-btn-sm layui-btn-danger risk-upload-video-delete">删除</button>',
									'</td>', '</tr>'
								].join(''));

								//单个重传
								tr.find('.risk-upload-video-reload').on('click', function() {
									obj.upload(index, video);
								});

								//删除
								tr.find('.risk-upload-video-delete').on('click', function() {
									delete videos[index]; //删除对应的文件
									tr.remove();
									riskVideosChoose--;
									riskVideosUploadListIns.config.elem.next()[0].value =
									''; //清空 input video 值，以免删除后出现同名文件不可选
								});
								
								riskVideosChoose++;
								riskVideosListView.append(tr);
							});
						},
						done: function(res, index, upload) {
							if (res.success>0) { //上传成功
								var tr = riskVideosListView.find('tr#risk-video-upload-' + index),
									tds = tr.children();
								tds.eq(1).html('<span style="color: #5FB878;">上传成功</span>');
								tds.eq(2).html(''); //清空操作
								if(riskVideos!="")riskVideos+=",";
								riskVideos+=res.success;
								riskVideosChoose--;
								return delete this.files[index]; //删除文件队列已经上传成功的文件
							}
							this.error(index, upload);
						},
						allDone: function(obj){ //当文件全部被提交后，才触发
						    riskVideosBool=true;
						    //console.log(obj.total); //得到总文件数
						    //console.log(obj.successful); //请求成功的文件数
						    //console.log(obj.aborted); //请求失败的文件数
						},
						error: function(index, upload) {
							var tr = riskVideosListView.find('tr#risk-video-upload-' + index),
								tds = tr.children();
							tds.eq(1).html('<span style="color: #FF5722;">上传失败</span>');
							tds.eq(2).find('.risk-upload-video-reload').removeClass('layui-hide'); //显示重传
						}
					});
					
				form.on('submit(riskSub)', function(data) {
					if(riskFilesChoose>0)$('#risk-upload-fileListAction').click();
					else riskFilesBool=true;
					
					if(riskVideosChoose>0)$('#risk-upload-videoListAction').click();
					else riskVideosBool=true;
					
					var clearRisk=setInterval(function(){
						if(riskFilesBool&&riskVideosBool){
							var fileattachments=(riskFilesView.length>0?(bouncer(riskFilesView).join(',')+(riskFiles!=""?",":"")):"")+riskFiles;
							var videoattachments=(riskVideosView.length>0?(bouncer(riskVideosView).join(',')+(riskVideos!=""?",":"")):"")+riskVideos;
							$("#formWenRisk").ajaxSubmit({
				              	url:		'<c:url value="/updateWenRisk.do"/>',
				              	data:		{
				              					personnelid:${wenGrade.personnelid},
				              					fileattachments:fileattachments,
				              					videoattachments:videoattachments,
				              					id:$('#firstRisk').val(),
				              					menuid:${menuid}
				              				},
				              	dataType:	'json',
				              	async:  	false,
				              	success:	function(data) {
									riskFiles='';
									riskFilesChoose=0;
									riskFilesBool=false;
									
									riskVideos='';
									riskVideosChoose=0;
									riskVideosBool=false;
									clearInterval(clearRisk);
				                  	var obj = eval('(' + data + ')');
				                  	if(obj.flag>0){
				                  	    //弹出loading
				 		            	var index = top.layer.msg('风险背景提交中，请稍候',{icon: 16,time:false,shade:0.8});
				                     	setTimeout(function(){         
				                     		top.layer.msg(obj.msg);
				                     		top.layer.close(index);
					 		        		//刷新风险背景模块
					 		        		openWenRisk(obj.flag);
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
				
				$("#riskHistory").click(function () {
					var index = layui.layer.open({
						title : "风险背景维护记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/riskhistory.jsp?personnelid="+${wenGrade.personnelid},
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
				
				$("#riskHistory_zfw").click(function () {
					var index = layui.layer.open({
						title : "政法委风险背景维护记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/riskhistory_zfw.jsp?personnelid="+${wenGrade.personnelid},
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
				
				form.on('submit(showSub)', function(data) {
					$("#formRealityShow").ajaxSubmit({
		              	url:		'<c:url value="/updateRealityShow.do"/>',
		              	data:		{
		              					personnelid:${wenGrade.personnelid},
		              					id:$('#firstShow').val(),
		              					datalabel:1,
		              					menuid:${menuid}
		              				},
		              	dataType:	'json',
		              	async:  	false,
		              	success:	function(data) {
		                  	var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                  	    //弹出loading
		 		            	var index = top.layer.msg('现实表现提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
			 		        		//刷新风险背景模块
			 		        		openRealityShow(obj.flag);
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
				
				$("#showHistory").click(function () {
					var index = layui.layer.open({
						title : "现实表现历史修改记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/showhistory.jsp?datalabel=1&personnelid="+${wenGrade.personnelid},
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
				
				$("#showHistory_zfw").click(function () {
					var index = layui.layer.open({
						title : "政法委现实表现历史修改记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/showhistory_zfw.jsp?datalabel=1&personnelid="+${wenGrade.personnelid},
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
          var riskFilesView=[],riskVideosView=[];
          function openWenRisk(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getWenRiskByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var filesview=$("#risk-view-fileList"),
							videosview=$("#risk-view-videoList");
						filesview.html('');
						videosview.html('');
						layui.upload.render();
						if(data.firstRisk>0){
							var risk=data.wenRisk;
							$('#firstRisk').val(risk.id);//存放wenRisk id
							$('#riskHistory').show();
							$('#conflictdetails').val(risk.conflictdetails);
							$('#riskappeal').val(risk.riskappeal);
							
							if(risk.fileattachments!=null&&risk.fileattachments!=""){
								riskFilesView=risk.fileattachments.split(",");
								if(riskFilesView.length>0){
									var viewname=risk.filesname.split(",");
									var viewaddtime=risk.filesaddtime.split(",");
									$.each(riskFilesView,function(index,item){
										var tr = $(['<tr>', '<td>' + viewname[index] +
											'</td>',
											'<td>上传完成</td>', 
											'<td>'+viewaddtime[index]+'</td>', 
											'<td>',
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
							          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
										});
										
										filesview.append(tr);
									});
								}
							}
							if(risk.videoattachments!=null&&risk.videoattachments!=""){
								riskVideosView=risk.videoattachments.split(",");
								if(riskVideosView.length>0){
									var viewname=risk.videosname.split(",");
									var viewallname=risk.videosallname.split(",");
									var viewaddtime=risk.videosaddtime.split(",");
									$.each(riskVideosView,function(index,item){
										var tr = $(['<tr>', '<td>' + viewname[index] +
											'</td>',
											'<td>上传完成</td>', 
											'<td>'+viewaddtime[index]+'</td>', 
											'<td>',
											'<button class="layui-btn layui-btn-sm risk-upload-video-show" onclick="return false;">预览</button>',
											'<button class="layui-btn layui-btn-sm layui-btn-danger risk-upload-video-delete" onclick="return false;">删除</button>',
											'</td>', '</tr>'
										].join(''));
										//删除
										tr.find('.risk-upload-video-delete').on('click', function() {
										    top.layer.confirm('确定删除此视频附件？', function(firm){
												top.layer.close(firm);
												delete riskVideosView[index]; //删除对应的文件
												tr.remove();
											});
										});
										tr.find('.risk-upload-video-show').on('click', function() {
											openVideo("../uploadFiles/audio/"+viewallname[index])
										});
										
										videosview.append(tr);
									});
								}
							}
						}else{
							$('#firstRisk').val(0);
							$('#riskHistory').hide();
						}
					}
				});
				
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getWenRiskByPersonnelid_zfw.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var filesview=$("#risk-view-fileList_zfw"),
							videosview=$("#risk-view-videoList_zfw");
						filesview.html('');
						videosview.html('');
						var risk=data.wenRisk;
						$('#riskHistory_zfw').show();
						$('#conflictdetails_zfw').val(risk.conflictdetails);
						$('#riskappeal_zfw').val(risk.riskappeal);
						if(risk.fileattachments!=null&&risk.fileattachments!=""){
							riskFilesView=risk.fileattachments.split(",");
							if(riskFilesView.length>0){
								var viewname=risk.filesname.split(",");
								var viewaddtime=risk.filesaddtime.split(",");
								$.each(riskFilesView,function(index,item){
									var tr = $(['<tr>', '<td>' + viewname[index] +
										'</td>',
										'<td>上传完成</td>', 
										'<td>'+viewaddtime[index]+'</td>','<td>',
											'<button class="layui-btn layui-btn-sm risk-upload-file-download" onclick="return false;">下载</button>',
											'</td>','</tr>'
									].join(''));
									tr.find('.risk-upload-file-download').on('click', function() {
						          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
									});
									filesview.append(tr);
								});
							}
						}
						if(risk.videoattachments!=null&&risk.videoattachments!=""){
							riskVideosView=risk.videoattachments.split(",");
							if(riskVideosView.length>0){
								var viewname=risk.videosname.split(",");
								var viewallname=risk.videosallname.split(",");
								var viewaddtime=risk.videosaddtime.split(",");
								$.each(riskVideosView,function(index,item){
									var tr = $(['<tr>', '<td>' + viewname[index] +
										'</td>',
										'<td>上传完成</td>', 
										'<td>'+viewaddtime[index]+'</td>','<td>',
											'<button class="layui-btn layui-btn-sm risk-upload-file-download" onclick="return false;">下载</button>',
											'</td>','</tr>'
									].join(''));
									tr.find('.risk-upload-file-download').on('click', function() {
						          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
									});
									videosview.append(tr);
								});
							}
						}
					}
				});
          }
          
			//社会关系 列表显示
			function  openSocialRelations_zfw(personnelid){
				layui.table.render({
					    elem: '#socialrelationsTable_zfw',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchsocialrelations_zfw.do?personnelid="+personnelid,
					    method:'post',
					    toolbar: '#checkToolbar',
					    cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'relationtype', title: '关系类别', width:120,align:"center",templet: function (item) {
								   return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoSocialrelations("+item.id+");'><font color='blue'>"+item.relationtype+"</font></span>";
		                    }},
					        {field:'appellation', title: '关系称谓', width:120,align:"center",templet: function (item) {
							       return "<span>"+item.appellation+(item.appellation=="其他"?("("+item.memo+")"):"")+"</span>";
		                    }},
					        {field:'personname', title: '姓名',width:120,align:"center",templet: function (item) {							        
					        	   if (item.riskpersonnel=="1") {
							             return "<span><a href='javascript:showinfo(&apos;"+item.cardnumber+"&apos;,"+item.riskpersonnel+");' style='text-decoration:underline;color:blue;' ><font color='red'>"+item.personname+"</font></a></span>";
							       }else{
							           return "<span><a href='javascript:showinfo(&apos;"+item.cardnumber+"&apos;,"+item.riskpersonnel+");' style='text-decoration:underline;color:blue;' ><font color='blue'>"+item.personname+"</font></a></span>";
							       }
		                    }}, 
		                    {field:'homeplace', title: '现居住地',align:"center"} ,
					        {field:'telnumber1', title: '联系电话',width:120,align:"center"}
					    ]],
					    page: true,
					    limit: 10
				});
			}
          
          function openVideo(url){
          		var html='<div><video id="video" controls="controls" autoplay="autoplay" preload="auto" width="100%" height="100%"><source src="'
          		+url
          		+'" type="video/mp4"></video></div>';
<%--          		var html='<div><embed id="video" type="video/webm" quality="high" align="middle" width="100%" allowScriptAccess="always" height="100%" src="'--%>
<%--          		+url--%>
<%--          		+'"></embed></div>';--%>
          		var index=layui.layer.open({
          			type:1,
          			skin:'layui-layer-rim',
          			title:"视频预览",
          			content:html,
          			area: ['600', '600px'],
          		});
          		layui.layer.full(index);
          }
          
          function bouncer(array){
          		return array.filter(function(val){
          			return !(!val||val=="");
          		})
          }
//涉访涉诉经历
layui.use(['table','form'], function(){
  var table = layui.table,
  form = layui.form;
  //方法级渲染
  table.render({
    elem: '#wenVisitTable',
    toolbar: true,
    defaultToolbar: ['filter'],
    method:'post',
    toolbar: '#wenVisitToolbar',
    cols: [[
    	{field:'id',type:'radio',fixed:'left', width:'6%'},//sort: true 排序
        {field:'startdate', title: '当次行为活动起止日期', width:'20%',templet: function (item) {
				//return "<span>"+item.startdate+"-"+item.enddate+"</span>";
				return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWenVisit("+item.id+");'><font color='blue'>"+item.startdate+"-"+item.enddate+"</font></span>";
           }},
        {field:'sensitivenode', title: '是否敏感节点', width:100,templet: function (item) {
				if(item.sensitivenode==1)return "<span>是</span>";
				else return "<span>否</span>";
           }},
        {field:'activitytype', title: '当次行为活动类别', width:180} ,
        {field:'activitydirection', title: '行为活动方向', width:120} ,
        {field:'handleresult', title: '现场处置结果情况', width:140} ,
        {field:'returnpunish', title: '人员回澄处罚结果', width:140} 
        //{field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:65}
    ]],
    page: true,
    limit: 10
  });
  
  table.render({
    elem: '#wenVisitTable_zfw',
    toolbar: true,
    defaultToolbar: ['filter'],
    method:'post',
    toolbar: '#checkToolbar',
    cols: [[
    	{field:'id',type:'radio',fixed:'left', width:'6%'},//sort: true 排序
        {field:'startdate', title: '当次行为活动起止日期', width:'20%',templet: function (item) {
				return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWenVisit_zfw("+item.id+");'><font color='blue'>"+item.startdate+"-"+item.enddate+"</font></span>";
           }},
        {field:'sensitivenode', title: '是否敏感节点', width:100,templet: function (item) {
				if(item.sensitivenode==1)return "<span>是</span>";
				else return "<span>否</span>";
           }},
        {field:'activitytype', title: '当次行为活动类别', width:180} ,
        {field:'activitydirection', title: '行为活动方向', width:120} ,
        {field:'handleresult', title: '现场处置结果情况', width:140} ,
        {field:'returnpunish', title: '人员回澄处罚结果', width:140}
    ]],
    page: true,
    limit: 10
  });
  
  //监听行工具事件
  table.on('toolbar(wenVisitTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'search':
   		searchWenVisit();
   		break;
   case 'add':
   		var index = layui.layer.open({
				title : "添加涉诉涉访经历",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getWenVisitUpdate.do?personnelid='+${wenGrade.personnelid}+'&page=add&menuid='+${menuid },
				area: ['800', '600px'],
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
					title : "修改涉诉涉访经历",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getWenVisitUpdate.do?id='+id+'&page=update&menuid='+${menuid },
					area: ['800', '600px'],
					success : function(layero, index){
					}
				})			
				layui.layer.full(index);
				}else{
					top.layer.alert("请先选择修改哪条数据！");
				}
	    break;
	case 'cancel':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	    if(datas!=""){
	   		var id=datas[0].id;
	    	top.layer.confirm('确定删除此涉诉涉访经历？', function(index){
		        layer.close(index);
		        $.getJSON(locat+"/cancelWenVisit.do?id="+id+"&menuid="+${param.menuid },{
					},function(data) {
						var str = eval('(' + data + ')');
		        	 	if (str.flag ==1) {		                          
				     		top.layer.msg("数据删除成功！"); 	
				     		searchWenVisit();                 
				       	}else{
							top.layer.msg("删除失败!");
				      	}			      	    		
		        	});      
			});
		}else{
			top.layer.alert("请先选择删除哪条涉诉涉访经历！");
		}
	    break;
   };
   
 });
 
	//监听行工具事件
	table.on('toolbar(wenVisitTable_zfw)', function(obj){
		var  checkStatus =table.checkStatus(obj.config.id);
		switch(obj.event){
			case 'check':
				var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
	    		if(datas!=""){
	    			if(datas[0].validflag==1){
						top.layer.confirm('确定将此信息加入公安库？', function(index){
				        	layer.close(index);
					        $.getJSON('<c:url value="zfwWenVisit_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
								var str = eval('(' + data + ')');
								if (str.flag ==1) {		                          
							     	top.layer.msg("数据审查成功！");
							     	searchWenVisit();
								}else{
									top.layer.msg("审查失败!");
								}			      	    		
					        });
						});
					}else{
						top.layer.msg("该数据已经在公安库中!");
					}
	    		}
			break;
		}
	});
 
 table.on('tool(wenVisitTable)', function(obj){
	  var id = obj.data.id;
	  if(obj.event == 'showinfo'){
	   		var index = layui.layer.open({
				title : "涉诉涉访经历详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getWenVisitUpdate.do?id='+id+'&menuid='+${menuid }+'&page=showinfo',
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
	    }
	  	});
 
         //监听联控记录   头部按钮  添加、修改、删除
		  table.on('toolbar(jointcontrolrecordTable)', function(obj){
		  var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增联控记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/jointcontrolrecord/add.jsp?menuid="+${menuid }+"&personnelid="+${personnel.id},
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
							title : "修改联控记录",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/getjointcontrolrecordbyid.do?id="+id+"&menuid="+${menuid }+'&page=update',
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
					      $.getJSON(locat+"/canceljointcontrolrecord.do?id="+id+'&menuid='+${menuid },{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('jointcontrolrecordTable', {});                 
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
		
		//监听联控记录   头部按钮  添加、修改、删除
		table.on('toolbar(jointcontrolrecordTable_zfw)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'check':
				var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
	    		if(datas!=""){
	    			if(datas[0].validflag==1){
						top.layer.confirm('确定将此信息加入公安库？', function(index){
				        	layer.close(index);
					        $.getJSON('<c:url value="zfwJointControlRecord_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
								var str = eval('(' + data + ')');
								if (str.flag ==1) {		                          
							     	top.layer.msg("数据审查成功！");
							     	openJointControlRecord(datas[0].personnelid);
								}else{
									top.layer.msg("审查失败!");
								}			      	    		
					        });
						});
					}else{
						top.layer.msg("该数据已经在公安库中!");
					}
	    		}
				break;
			}
		});
		
		table.on('toolbar(socialrelationsTable_zfw)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'check':
				var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
	    		if(datas!=""){
	    			//查验身份证
	    			if(datas[0].validflag==1){
						top.layer.confirm('确定将此信息加入公安库？', function(index){
				        	layer.close(index);
					        $.getJSON('<c:url value="zfwsocialrelations_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
								var str = eval('(' + data + ')');
								if (str.flag ==1) {		                          
							     	top.layer.msg("数据审查成功！");
							     	table.reload('socialrelationsTable', {});
							     	table.reload('socialrelationsTable_zfw', {});
								}else{
									top.layer.msg("审查失败!");
								}			      	    		
					        });
						});
					}else{
						top.layer.msg("该数据已经在公安库中!");
					}
	    		}
				break;
			}
		});		
		
				//监听联控记录   详情按钮
			  table.on('tool(jointcontrolrecordTable)', function(obj){
				  var id = obj.data.id;
				  if(obj.event == 'showinfo'){
				   		var index = layui.layer.open({
							title : "联控记录详情",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getjointcontrolrecordbyid.do?id='+id+'&menuid='+${menuid }+'&page=showinfo',
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
				 }else if(obj.event == 'qbbs'){
				   		var index = layui.layer.open({
							title : "新增上报信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getjointcontrolrecordbyid.do?id='+id+'&menuid='+${menuid }+'&page=qbbs',
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
				 }
		    });
 	
        });
 
				function showinfoWenVisit(id){
			   		var index = layui.layer.open({
						title : "涉诉涉访经历详情",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getWenVisitUpdate.do?id='+id+'&menuid='+${menuid }+'&page=showinfo',
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
				
				function showinfoWenVisit_zfw(id){
			   		var index = layui.layer.open({
						title : "涉诉涉访经历详情",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getWenVisitUpdate_zfw.do?id='+id+'&menuid='+${menuid },
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
 
				 function searchWenVisit(){
				 	layui.table.reload('wenVisitTable', {
				 		url: '<c:url value="/searchWenVisit.do"/>?personnelid='+${wenGrade.personnelid},
						page: {curr: 1}
					});
					
					layui.table.reload('wenVisitTable_zfw', {
				 		url: '<c:url value="/searchWenVisit_zfw.do"/>?personnelid='+${wenGrade.personnelid},
						page: {curr: 1}
					});
				 }
 
                 //联动记录 列表显示
                 function  openJointControlRecord(personnelid){
                 	layui.table.render({
					    elem: '#jointcontrolrecordTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchJointControlRecord.do?personnelid="+personnelid,
					    method:'post',
					    toolbar: '#socialrelationstoolbar',
					    cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'infodate', title: '情报发生时间', width:150,align:"center",templet: function (item) {
								   return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoJointcontrolrecord("+item.id+");'><font color='blue'>"+item.infodate+"</font></span>";
		                    }},
					        {field:'infotype', title: '情报内容类别', width:100,align:"center"},
					        {field:'addoperator', title: '采集人', width:70,align:"center"} ,
					        {field:'information', title: '情报内容',align:"center"} ,
					        {field: 'right', title: '操作', toolbar: '#trajectoryrecordbar',width:100,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
				 	});
				 	
				 	layui.table.render({
					    elem: '#jointcontrolrecordTable_zfw',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchJointControlRecord_zfw.do?personnelid="+personnelid,
					    method:'post',
					    toolbar: '#checkToolbar',
					    cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'infodate', title: '情报发生时间', width:150,align:"center",templet: function (item) {
								   return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoJointcontrolrecord_zfw("+item.id+");'><font color='blue'>"+item.infodate+"</font></span>";
		                    }},
					        {field:'infotype', title: '情报内容类别', width:100,align:"center"},
					        {field:'addoperator', title: '采集人', width:70,align:"center"} ,
					        {field:'information', title: '情报内容',align:"center"}
					    ]],
					    page: true,
					    limit: 10
				 	});
                 }
              function showinfoJointcontrolrecord(id){
			   		var index = layui.layer.open({
						title : "联控记录详情",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getjointcontrolrecordbyid.do?id='+id+'&menuid='+${menuid }+'&page=showinfo',
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
			 }
			 function showinfoJointcontrolrecord_zfw(id){
			   		var index = layui.layer.open({
						title : "政法委联控记录详情",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getjointcontrolrecordbyid_zfw.do?id='+id+'&menuid='+${menuid },
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
			 }
			 
             function openRealityShow(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRealityShowByPersonnelid.do?datalabel=1&personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						if(data.firstShow>0){
							var show=data.realityShow;
							$('#firstShow').val(show.id);//存放realityShow id
							$('#showHistory').show();
							$('#lifepattern').val(show.lifepattern);
							$('#healthstate').val(show.healthstate);
							$('#characteristic').val(show.characteristic);
							$('#lifehabit').val(show.lifehabit);
						}else{
							$('#firstShow').val(0);
							$('#showHistory').hide();
						}
					}
				});
				
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRealityShowByPersonnelid_zfw.do?datalabel=1&personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						if(data.firstShow>0){
							var show=data.realityShow;
							$('#firstShow_zfw').val(show.id);//存放realityShow id
							$('#showHistory_zfw').show();
							$('#lifepattern_zfw').val(show.lifepattern);
							$('#healthstate_zfw').val(show.healthstate);
							$('#characteristic_zfw').val(show.characteristic);
							$('#lifehabit_zfw').val(show.lifehabit);
						}else{
							$('#firstShow_zfw').val(0);
							$('#showHistory_zfw').hide();
						}
					}
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
								"<div class='layui-col-md1' style='left:-30px;'><div class='layui-form-item my-form-item'><button onclick='addLabel("+item.id+",&quot;"+item.attributelabel+"&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div></div>");
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
		</script>
		<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
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
