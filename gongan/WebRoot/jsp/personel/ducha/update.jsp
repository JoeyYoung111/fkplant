<%@ page import="com.aladdin.model.UserSession" %>
<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
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
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/tagtree/tagTree.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
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
									<input type="text" name="personname" autocomplete="off" value="${personnel.personname}" class="layui-input" style="background:#efefef" readonly>
								</div>
							</div>
						</div>
	
		              <div class="layui-col-md5">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label">性别：</label>
								<div class="layui-input-block">
									<input type="text" autocomplete="off" style="background:#efefef" name="sexes"
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
							<label class="layui-form-label layui-font-blue my-text-nowarp">管控信息</label>
						</div>
						<div class="layui-col-12">
							<div class="layui-form-item my-form-item">
								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>人员级别：</label>
								<div class="layui-input-block">
									<select name="personnelLevel" id="personnelLevel" lay-filter="personnelLevel">
										<option value="">==请选择==</option>
										<option value="0" <c:if test="${personnel.personnelLevel == 0}">selected</c:if>>已化解</option>
										<option value="1" <c:if test="${personnel.personnelLevel == 1}">selected</c:if>>一般未化解</option>
										<option value="2" <c:if test="${personnel.personnelLevel == 2}">selected</c:if>>重点未化解</option>
									</select>
								</div>
							</div>
						</div>
<%--						<div class="layui-col-md4">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<label class="layui-form-label my-text-nowarp">联控级别：</label>--%>
<%--								<div class="layui-input-block">--%>
<%--									<select name="jointcontrollevel">--%>
<%--										<option value="">==请选择==</option>--%>
<%--										<c:forEach items="${jointcontrollevel}" var="row" varStatus="num">--%>
<%--											<option value="${row.basicName}" <c:if test="${row.basicName == personnelExtend.jointcontrollevel}">selected</c:if>>${row.basicName}</option>--%>
<%--										</c:forEach>--%>
<%--									</select>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--						<div class="layui-col-md4">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<label class="layui-form-label my-text-nowarp">在控状态：</label>--%>
<%--								<div class="layui-input-block">--%>
<%--									<select name="incontrollevel">--%>
<%--										<option value="">==请选择==</option>--%>
<%--										<c:forEach items="${incontrollevel}" var="row" varStatus="num">--%>
<%--											<option value="${row.basicName}" <c:if test="${row.basicName == personnelExtend.incontrollevel}">selected</c:if>>${row.basicName}</option>--%>
<%--										</c:forEach>--%>
<%--									</select>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
                        <div class="layui-col-md8">
                            <div class="layui-col-md7">
                                <div class="layui-form-item my-form-item">
                                    <label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任单位：</label>
                                    <div class="layui-form layui-input-block" lay-filter="jdunit1_div">
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
						<div class="layui-col-md4 layui-col-md-offset6" style="margin-bottom: 30px;margin-top: 30px;">
							<div class="layui-form-item my-form-item">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="duchaUpdateLeft">立即提交</button>
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
							<div class="swiper-wrapper" style="height: 80px;">
                                <li class="btn btn_2 layui-this swiper-slide" onclick="switchTab(0)">诉求归纳</li>
                                <li class="btn btn_15 swiper-slide" id="tabZhenkong" onclick="onZhenkongTabClick()">侦控记录</li>
                                <li class="btn btn_6 swiper-slide" onclick="switchTab(2)">投诉信访</li>
								<li class="btn btn_11 swiper-slide" onclick="switchTab(3); openAttributelabel();">人员属性标签</li>
								<li class="btn btn_4 swiper-slide" id="tabCustomlabel" onclick="switchTab(4); openCustomlabel(${personnel.id});">自主标签</li>
								<li class="btn btn_1 swiper-slide" onclick="switchTab(5)">关联信息</li>
								<li class="btn btn_4 swiper-slide" onclick="switchTab(6); openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
								<li class="btn btn_3 swiper-slide" onclick="switchTab(7); openSocialRelations(${personnel.id});">社会关系</li>
								<li class="btn btn_12 swiper-slide" onclick="switchTab(8); openjqxx('${personnel.cardnumber}');">涉警涉案</li>
								<li class="btn btn_5 swiper-slide" onclick="switchTab(9)">自定义档案</li>
								<div class="swiper-slide"></div>
							</div>
						</div>
						<div class="my-swiper-button-next swiper-button-next1"></div>
						<div class="my-swiper-button-prev swiper-button-prev1"></div>
					</div>
				<div class="layui-tab-content">
					<!-- ========== 诉求归纳 Tab ========== -->
					<div class="right-child-content layui-tab-item layui-show">
						<form class="layui-form" method="post" id="formSuqiu" onsubmit="return false;">
							<input type="hidden" name="personnelid" value="${personnel.id}">
							<div class="layui-row" style="padding: 15px;">
								<div class="layui-col-md12">
									<div class="layui-form-item">
										<label class="layui-form-label">诉求综述：</label>
                                        <button type="button" class="layui-btn layui-btn-primary" onclick="openSuqiuHistory()">历史记录</button>
										<div class="layui-input-block">
											<textarea name="suqiuContent" placeholder="请输入诉求综述" class="layui-textarea" style="height:150px;">${dcSuqiu.suqiuContent}</textarea>
										</div>
									</div>
								</div>

								<div class="layui-col-md6">
									<div class="layui-form-item">
										<label class="layui-form-label">问题标签：</label>
										<div class="layui-input-block">
											<input type="checkbox" name="problemTag" value="1" lay-skin="switch" lay-text="有|无"
												<c:if test="${dcSuqiu.problemTag == 1}">checked</c:if> >
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item">
										<label class="layui-form-label">备注：</label>
										<div class="layui-input-block">
											<input type="text" name="memo" autocomplete="off" value="${dcSuqiu.memo}" placeholder="请输入备注" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item">
										<label class="layui-form-label">录入人：</label>
										<div class="layui-input-block">
											<input type="text" autocomplete="off" value="${dcSuqiu.addoperator}" readonly class="layui-input" style="background:#efefef">
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item">
										<label class="layui-form-label">录入时间：</label>
										<div class="layui-input-block">
											<input type="text" autocomplete="off" value="${dcSuqiu.addtime}" readonly class="layui-input" style="background:#efefef">
										</div>
									</div>
								</div>
								<div class="layui-col-md12" style="margin-top:15px;text-align:center;">
									<button type="submit" class="layui-btn" lay-submit="" lay-filter="saveSuqiu">提交诉求归纳</button>

								</div>
							</div>
						</form>
					</div>
					<!-- ========== 侦控记录 Tab ========== -->
					<div class="right-child-content layui-tab-item" id="zhenkongTabContent">
						<!-- 无权限提示（departmentid不在督察大队范围时显示） -->
						<div id="zhenkongNoPermission" style="display:none;padding:40px;text-align:center;">
							<i class="layui-icon" style="font-size:48px;color:#ccc;">&#xe62e;</i>
							<p style="color:#999;font-size:16px;margin-top:10px;">缺乏权限，无法查看侦控记录</p>
						</div>
						<div id="zhenkongContent" style="display:none;padding:15px;">
							<!-- 侦控信息 type=1 -->
							<fieldset class="layui-elem-field">
								<legend>侦控信息</legend>
								<div class="layui-field-box">
									<form class="layui-form" method="post" id="formZhenkong1" onsubmit="return false;">
										<input type="hidden" name="personnelid" value="${personnel.id}">
										<input type="hidden" name="recordType" value="1">
										<div class="layui-form-item">
											<label class="layui-form-label">侦控信息：</label>
											<div class="layui-input-block">
												<textarea name="zhenkongInfo" placeholder="请输入侦控信息" class="layui-textarea" style="height:80px;">${zhenkong1.zhenkongInfo}</textarea>
											</div>
										</div>
										<div class="layui-form-item">
											<div class="layui-inline">
												<label class="layui-form-label">证据充足：</label>
												<div class="layui-input-inline">
													<input type="checkbox" name="evidenceFlag" value="1" lay-skin="switch" lay-text="是|否"
														<c:if test="${zhenkong1.evidenceFlag == 1}">checked</c:if> >
												</div>
											</div>
											<div class="layui-inline">
												<label class="layui-form-label">打击条件：</label>
												<div class="layui-input-inline">
													<input type="checkbox" name="hitCondition" value="1" lay-skin="switch" lay-text="是|否"
														<c:if test="${zhenkong1.hitCondition == 1}">checked</c:if> >
												</div>
											</div>
										</div>
										<div style="text-align:center;">
											<button type="submit" class="layui-btn layui-btn-sm" lay-submit="" lay-filter="saveZhenkong1">保存</button>
											<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="openZhenkongHistory(1)">历史记录</button>
										</div>
									</form>
								</div>
							</fieldset>
							<!-- 警情研判 type=2 -->
							<fieldset class="layui-elem-field">
								<legend>警情研判</legend>
								<div class="layui-field-box">
									<form class="layui-form" method="post" id="formZhenkong2" onsubmit="return false;">
										<input type="hidden" name="personnelid" value="${personnel.id}">
										<input type="hidden" name="recordType" value="2">
										<div class="layui-form-item">
											<label class="layui-form-label">研判分析：</label>
											<div class="layui-input-block">
												<textarea name="analysisContent" placeholder="请输入深度研判分析记录" class="layui-textarea" style="height:80px;">${zhenkong2.analysisContent}</textarea>
											</div>
										</div>
										<div style="text-align:center;">
											<button type="submit" class="layui-btn layui-btn-sm" lay-submit="" lay-filter="saveZhenkong2">保存</button>
											<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="openZhenkongHistory(2)">历史记录</button>
										</div>
									</form>
								</div>
							</fieldset>
							<!-- 资金情况 type=3 -->
							<fieldset class="layui-elem-field">
								<legend>资金情况</legend>
								<div class="layui-field-box">
									<form class="layui-form" method="post" id="formZhenkong3" onsubmit="return false;">
										<input type="hidden" name="personnelid" value="${personnel.id}">
										<input type="hidden" name="recordType" value="3">
										<div class="layui-form-item">
											<label class="layui-form-label">资金情况：</label>
											<div class="layui-input-block">
												<textarea name="fundInfo" placeholder="请输入资金情况" class="layui-textarea" style="height:80px;">${zhenkong3.fundInfo}</textarea>
											</div>
										</div>
										<div style="text-align:center;">
											<button type="submit" class="layui-btn layui-btn-sm" lay-submit="" lay-filter="saveZhenkong3">保存</button>
											<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="openZhenkongHistory(3)">历史记录</button>
										</div>
									</form>
								</div>
							</fieldset>
							<!-- 通联情况 type=4 -->
							<fieldset class="layui-elem-field">
								<legend>通联情况</legend>
								<div class="layui-field-box">
									<form class="layui-form" method="post" id="formZhenkong4" onsubmit="return false;">
										<input type="hidden" name="personnelid" value="${personnel.id}">
										<input type="hidden" name="recordType" value="4">
										<div class="layui-form-item">
											<label class="layui-form-label">通联情况：</label>
											<div class="layui-input-block">
												<textarea name="contactInfo" placeholder="请输入通联情况" class="layui-textarea" style="height:80px;">${zhenkong4.contactInfo}</textarea>
											</div>
										</div>
										<div style="text-align:center;">
											<button type="submit" class="layui-btn layui-btn-sm" lay-submit="" lay-filter="saveZhenkong4">保存</button>
											<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="openZhenkongHistory(4)">历史记录</button>
										</div>
									</form>
								</div>
							</fieldset>
							<!-- 现实表现 type=5 -->
							<fieldset class="layui-elem-field">
								<legend>现实表现</legend>
								<div class="layui-field-box">
									<form class="layui-form" method="post" id="formZhenkong5" onsubmit="return false;">
										<input type="hidden" name="personnelid" value="${personnel.id}">
										<input type="hidden" name="recordType" value="5">
										<div class="layui-form-item">
											<label class="layui-form-label">现实表现：</label>
											<div class="layui-input-block">
												<textarea name="performanceInfo" placeholder="请输入现实表现" class="layui-textarea" style="height:80px;">${zhenkong5.performanceInfo}</textarea>
											</div>
										</div>
										<div style="text-align:center;">
											<button type="submit" class="layui-btn layui-btn-sm" lay-submit="" lay-filter="saveZhenkong5">保存</button>
											<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="openZhenkongHistory(5)">历史记录</button>
										</div>
									</form>
								</div>
							</fieldset>
						</div><!-- end zhenkongContent -->
					</div><!-- end zhenkongTabContent -->
					<!-- ========== 投诉信访 Tab ========== -->
					<div class="right-child-content layui-tab-item">
						<form class="layui-form" method="post" id="formXinfang" onsubmit="return false;">
							<input type="hidden" name="personnelid" value="${personnel.id}">
							<input type="hidden" name="attachmentId" id="xinfangAttachmentId" value="">
							<div style="padding:10px 15px 0 15px;display:flex;align-items:center;justify-content:space-between;">
								<span class="layui-font-blue" style="font-size:15px;font-weight:bold;">投诉信访</span>
								<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="openXinfangHistory()"><i class="layui-icon">&#xe68d;</i>历史记录</button>
							</div>
							<div class="layui-row" style="padding:10px 15px;">
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">诉求来源</label>
										<div class="my-input-block">
											<input type="text" name="suqiuSource" id="xf_suqiuSource" autocomplete="off"
												placeholder="请输入诉求来源" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">诉求日期</label>
										<div class="my-input-block">
											<input type="text" name="suqiuDate" id="xf_suqiuDate" autocomplete="off"
												placeholder="年-月-日" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">诉求分类</label>
										<div class="my-input-block">
											<input type="text" name="suqiuType" id="xf_suqiuType" autocomplete="off"
												placeholder="请输入诉求分类" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">被诉求单位</label>
										<div class="my-input-block">
											<input type="text" name="targetUnit" id="xf_targetUnit" autocomplete="off"
												placeholder="请输入被诉求单位" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">诉求内容</label>
										<div class="my-input-block">
											<textarea name="suqiuContent" id="xf_suqiuContent" placeholder="请输入诉求内容"
												class="layui-textarea" style="height:80px;"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">是否化解</label>
										<div class="my-input-block">
											<select name="resolveFlag" id="xf_resolveFlag">
												<option value="0">未化解</option>
												<option value="1">已化解</option>
											</select>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">备注</label>
										<div class="my-input-block">
											<input type="text" name="memo" id="xf_memo" autocomplete="off"
												placeholder="请输入备注" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">附件上传</label>
										<div class="my-input-block">
											<button type="button" class="layui-btn layui-btn-sm" id="xinfangUploadBtn">
												<i class="layui-icon">&#xe67c;</i>选择文件
											</button>
											<div id="xinfangFileList" style="margin-top:5px;"></div>
										</div>
									</div>
								</div>
								<div class="layui-col-md12" style="text-align:center;margin-top:10px;">
									<button type="submit" class="layui-btn" lay-submit="" lay-filter="submitXinfangInline">保存投诉信访</button>
								</div>
							</div>
						</form>
					</div>
					<!-- ========== 人员属性标签 Tab (原有) ========== -->
					<div class="right-child-content layui-tab-item">
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
					<div class="right-child-content layui-tab-item"><!--自定义标签 -->
							
							<form class="layui-form" method="post" id="formCustomlabel" onsubmit="return false;">
								<table class="layui-table">
									<tr>
										<td valign="top" width="35%">		
											<div>
												<div style="display:inline;"><a href="javascript:edittagtree(1)"><i class="layui-icon" style="color:green;">&#xe654;</i>新增</a></div>
												<div style="display:inline;margin-left:5px;"><a href="javascript:edittagtree(2)"><i class="layui-icon" style="color:blue;">&#xe642;</i>修改</a></div>
												<div style="display:inline;margin-left:5px;"><a href="javascript:edittagtree(3)"><i class="layui-icon" style="color:red;">&#xe640;</i>删除</a></div>
											</div>
											<div style="width:300px;overflow: auto;height: 450px;">
												<ul id="tagTree" class="tagtree" style="width:350px;overflow: auto;height: 360px;-right:80px;">
													
												</ul>
											</div>
										</td>
										<td valign="top" width="65%"> 
											<div id="label" style="height: 680px;display:none;">
												<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
											  		<legend id="labeltitle"  style="font-size:16px;"></legend>
												</fieldset>
												<input type="hidden" id="firstLabel" value=0>
												<input type="hidden" id="customlabel" value="">
												<input type="hidden" id="customlabelname" value="">
												<input type="hidden" id="customlabelid" name="customlabelid" value=0>
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">标签描述
													<button class="layui-btn layui-btn-sm" id="labelHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
													<div class="my-input-block">
														<textarea placeholder="请输入标签描述内容" class="layui-textarea"
															id="labelinfo" name="labelinfo"></textarea>
													</div>
												</div>
												<div class="layui-form-item my-form-item">
													<label class="my-form-label-br">标签详情
													<div class="my-input-block">
														<textarea placeholder="请输入标签详情内容" class="layui-textarea"
															id="labelmemo" name="memo"></textarea>
													</div>
												</div>
												<div class="layui-col-md3 layui-col-md-offset4">
													<div class="layui-form-item my-form-item" style="padding: 15px;">
														<button type="submit" class="layui-btn" lay-submit="" lay-filter="labelSub">立即提交</button>
													</div>
												</div>
											</div>
										</td>
									</tr>
								</table>
							</form>
						</div>
                    <div class="right-child-content layui-tab-item">
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
						<div class="layui-form-item my-form-item">
						    <button type="submit" class="layui-btn"  lay-submit="" lay-filter="relationSub">立即提交</button>
							<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重置&nbsp;</button>
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
						<div class="right-child-content layui-tab-item"><!--社会关系 -->
				           <table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table>
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
						<div class="right-child-content layui-tab-item"><!--自定义档案 -->
							<form class="layui-form" method="post" id="formCustomText" onsubmit="return false;">
								<input type="hidden"  name="id" id="customTextid"  value=${customTextid }>
								<input type="hidden"  name="personnelid" value=${personnel.id }>
								<div class="layui-row" style="padding: 15px;">
								  	<div class="layui-col-md12">
										<div class="layui-col-md4">
											<div class="layui-form-item my-form-item">
												<label class="layui-form-label my-text-nowarp">补充1</label>
												<div class="layui-input-block">
													<input type="text" name="title1" lay-verify="" autocomplete="off"
														value="${customText.title1}" placeholder="请输入补充标题" class="layui-input">
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text1" lay-verify="" autocomplete="off"
														value="${customText.text1}" placeholder="请输入补充内容" class="layui-input">
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md12">
										<div class="layui-col-md4">
											<div class="layui-form-item my-form-item">
												<label class="layui-form-label my-text-nowarp">补充2</label>
												<div class="layui-input-block">
													<input type="text" name="title2" lay-verify="" autocomplete="off"
														value="${customText.title2}" placeholder="请输入补充标题" class="layui-input">
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text2" lay-verify="" autocomplete="off"
														value="${customText.text2}" placeholder="请输入补充内容" class="layui-input">
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md12">
										<div class="layui-col-md4">
											<div class="layui-form-item my-form-item">
												<label class="layui-form-label my-text-nowarp">补充3</label>
												<div class="layui-input-block">
													<input type="text" name="title3" lay-verify="" autocomplete="off"
														value="${customText.title3}" placeholder="请输入补充标题" class="layui-input">
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text3" lay-verify="" autocomplete="off"
														value="${customText.text3}" placeholder="请输入补充内容" class="layui-input">
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md12">
										<div class="layui-col-md4">
											<div class="layui-form-item my-form-item">
												<label class="layui-form-label my-text-nowarp">补充4</label>
												<div class="layui-input-block">
													<input type="text" name="title4" lay-verify="" autocomplete="off"
														value="${customText.title4}" placeholder="请输入补充标题" class="layui-input">
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text4" lay-verify="" autocomplete="off"
														value="${customText.text4}" placeholder="请输入补充内容" class="layui-input">
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md12">
										<div class="layui-col-md4">
											<div class="layui-form-item my-form-item">
												<label class="layui-form-label my-text-nowarp">补充5</label>
												<div class="layui-input-block">
													<input type="text" name="title5" lay-verify="" autocomplete="off"
														value="${customText.title5}" placeholder="请输入补充标题" class="layui-input">
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text5" lay-verify="" autocomplete="off"
														value="${customText.text5}" placeholder="请输入补充内容" class="layui-input">
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md12">
								  		<div class="layui-form-item my-form-item" style="padding: 15px;">
											附件：
											<button type="button" class="layui-btn layui-btn-sm"
												id="label-upload-fileList"><i class="layui-icon"></i>上传多文件</button>
											<button type="button" class="layui-btn layui-hide"
												id="label-upload-fileListAction">开始上传</button>
											<div class="layui-upload">
												<div class="layui-upload-list">
													<table class="layui-table" style="border: 1px solid #eee;">
														<thead>
															<tr>
																<th width="50%">文件名</th>
																<th width="20%">状态</th>
																<th width="30%">操作</th>
															</tr>
														</thead>
														<tbody id="label-view-fileList"></tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md3 layui-col-md-offset3" style="margin-bottom: 30px;margin-top: 20px;">
									    <div class="layui-input-block">
									      <button type="submit" class="layui-btn" lay-submit="" lay-filter="customTextSub">立即提交</button>
									    </div>
								  	</div>
							  	</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
		
			// 允许查看侦控记录的部门ID（与后端 DUCHA_DADUI_IDS 保持一致）
			var DUCHA_DADUI_IDS = [1, 56, 57, 58];
            var currentUserDeptId = '<%=userSession != null ? userSession.getLoginUserDepartmentid() : ""%>';

			function switchTab(index) {
				$('.layui-tab-content > .layui-tab-item').removeClass('layui-show')
					.eq(index).addClass('layui-show');
				$('.mySwiperS .swiper-slide').removeClass('layui-this')
					.eq(index).addClass('layui-this');
			}

			/* 点击侦控记录Tab：根据 departmentid 判断权限 */
            function onZhenkongTabClick() {
                switchTab(1);
                // 确保 DUCHA_DADUI_IDS 和 currentDeptId 都能正确匹配（统一转为字符串比较）
                var hasPerm = false;
                for(var i=0; i<DUCHA_DADUI_IDS.length; i++) {
                    if(DUCHA_DADUI_IDS[i].toString() === currentUserDeptId.toString()) {
                        hasPerm = true;
                        break;
                    }
                }

                if (hasPerm) {
                    $('#zhenkongNoPermission').hide();
                    $('#zhenkongContent').show();
                    // 重要：重新渲染表单，否则隐藏状态下生成的 switch 开关可能不显示
                    layui.form.render();
                } else {
                    $('#zhenkongContent').hide();
                    $('#zhenkongNoPermission').show();
                }
            }

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
                        }
                        $('#treeSelect-input-jdunit1').blur(function(){
                            form.render(null,"jdunit1_div");
                        });
                        //加载涉警涉案
                        $('#sjsa').click();
                    }
                });

            });

			layui.use(['element', 'form', 'upload','jquery','selectInput','treeSelect','table','laydate'], function() {
				var element = layui.element,
					upload = layui.upload,
					$ = layui.jquery,
					selectInput= layui.selectInput,
					treeSelect = layui.treeSelect,
					table = layui.table,
					laydate = layui.laydate,
					form = layui.form;
				
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



                form.on('select(jdpolice1)', function(data){
                    $('#pphone1').val(users1[data.value]);
                    form.render();
                });
                form.on('select(jdpolice2)', function(data){
                    $('#pphone2').val(users2[data.value]);
                    form.render();
                });
                form.render();
				
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
				if($("#customTextid").val()>0)openCustomTextFiles($("#customTextid").val());
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
				//基本信息+分类分级+人员级别  监听提交
				form.on('submit(duchaUpdateLeft)', function(data) {
					// 1. 先更新人员级别
					$.ajax({
						type: 'POST',
						url: '<c:url value="/ducha/updatePersonnelLevel.do"/>',
						data: {
							id: ${personnel.id},
							personnelLevel: $("#personnelLevel").val(),
							menuid: ${menuid}
						},
						dataType: 'json',
						async: false,
						success: function(data) {
							var obj = eval('(' + data + ')');
							if(obj.flag <= 0) {
								layer.msg(obj.msg);
							}
						}
					});
					// 2. 再更新基本信息+管控信息
					var url='<c:url value="/updatePersonnelExtend.do"/>?personFilter='+${personnelExtend.id};
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
		 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
					        		layer.closeAll("iframe");
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

				// ===== 诉求归纳保存 =====
				form.on('submit(saveSuqiu)', function(data) {
					var problemTagVal = $("input[name='problemTag']").prop("checked") ? 1 : 0;
					$("#formSuqiu").ajaxSubmit({
						url: '<c:url value="/ducha/saveSuqiu.do"/>?menuid=${menuid}&problemTag=' + problemTagVal,
						dataType: 'json',
						async: false,
						success: function(data) {
							var obj = eval('(' + data + ')');
							if(obj.flag > 0) {
								top.layer.msg(obj.msg);
							} else {
								layer.msg(obj.msg);
							}
						},
						error: function() {
							layer.alert("请求失败！");
						}
					});
					return false;
				});

				// ===== 侦控记录保存 (5种类型) =====
				for (var zt = 1; zt <= 5; zt++) {
					(function(recordType) {
						form.on('submit(saveZhenkong' + recordType + ')', function(data) {
							$("#formZhenkong" + recordType).ajaxSubmit({
								url: '<c:url value="/ducha/saveZhenkong.do"/>?menuid=${menuid}',
								dataType: 'json',
								async: false,
								success: function(data) {
									var obj = eval('(' + data + ')');
									if(obj.flag > 0) {
										top.layer.msg(obj.msg);
									} else {
										layer.msg(obj.msg);
									}
								},
								error: function() {
									layer.alert("请求失败！");
								}
							});
							return false;
						});
					})(zt);
				}

				// ===== 人员级别变化：侦控记录Tab可见性由权限控制，无需响应级别变化 =====

				// ===== 投诉信访 — 内嵌表单初始化 =====
				laydate.render({ elem: '#xf_suqiuDate', type: 'date' });

				var xinfangUploadedIds = [];
				upload.render({
					elem: '#xinfangUploadBtn',
					url: '<c:url value="/newuploadfile1.do"/>',
					accept: 'file',
					multiple: true,
					done: function(res) {
						if (res.success > 0) {
							xinfangUploadedIds.push(res.success);
							$('#xinfangAttachmentId').val(xinfangUploadedIds.join(','));
							var fileName = res.filename || ('文件' + res.success);
							$('#xinfangFileList').append(
								'<span style="margin-right:10px;" id="xf-file-' + res.success + '">' +
								'<i class="layui-icon" style="color:green;">&#xe605;</i> ' + fileName +
								' <a href="javascript:;" onclick="removeXinfangFile(' + res.success + ')" style="color:red;">删除</a>' +
								'</span>'
							);
						} else {
							layer.msg('上传失败');
						}
					}
				});

				// 提交投诉信访（内嵌表单）
				form.on('submit(submitXinfangInline)', function(formData) {
					$('#formXinfang').ajaxSubmit({
						url: '<c:url value="/ducha/saveXinfang.do"/>?menuid=${menuid}',
						dataType: 'json',
						async: false,
						success: function(data) {
							var obj = eval('(' + data + ')');
							if (obj.flag > 0) {
								top.layer.msg(obj.msg);
								// 清空表单
								$('#xf_suqiuSource,#xf_suqiuDate,#xf_suqiuType,#xf_targetUnit,#xf_suqiuContent,#xf_memo').val('');
								$('#xf_resolveFlag').val('0');
								$('#xinfangAttachmentId').val('');
								$('#xinfangFileList').html('');
								xinfangUploadedIds = [];
								layui.form.render('select');
							} else {
								layer.msg(obj.msg);
							}
						},
						error: function() {
							layer.alert("请求失败！");
						}
					});
					return false;
				});

				form.on('submit(customTextSub)', function(data) {
					if(labelFilesChoose>0)$('#label-upload-fileListAction').click();
					else labelFilesBool=true;
		            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
					var clearLabel=setInterval(function(){
						if(labelFilesBool){
							var attachments=(labelFilesView.length>0?(bouncer(labelFilesView).join(',')+(labelFiles!=""?",":"")):"")+labelFiles;
							$("#formCustomText").ajaxSubmit({
				              	url:		'<c:url value="/updateCustomText.do"/>?attachments='+attachments+'&menuid=${menuid}',
								dataType:	'json',
								async:  	false,
				              	success:	function(data) {
				                  	var obj = eval('(' + data + ')');
				                  	
				                  	labelFiles='';
									labelFilesChoose=0;
									labelFilesBool=false;
				                  	clearInterval(clearLabel);
				                  	if(obj.flag>0){
				                  	    //弹出loading
				                     	setTimeout(function(){         
				                     		top.layer.msg(obj.msg);
				                     		top.layer.close(index);
				                     		$("#customTextid").val(obj.flag);
				                     		openCustomTextFiles(obj.flag);
				                   		},1000);
				                 	}else{
				                  	 	layer.msg(obj.msg);
				                	}
				             	},
				              	error:function() {
				                  	layer.alert("请求失败！");
				                  	clearInterval(clearLabel);
				              	}
				          	});	
						}
			        },200);
					return false;
				});
				
				form.on('submit(labelSub)', function(data) {
	            	var index = top.layer.msg("自定义标签("+$('#customlabel').val()+')提交中，请稍候',{icon: 16,time:false,shade:0.8});
					$("#formCustomlabel").ajaxSubmit({
		              	url:		'<c:url value="/updateLabelinfo.do"/>',
		              	data:		{
		              					personnelid:	${personnel.id},
		              					id:				$('#firstLabel').val(),
		              					menuid:			${menuid},
		              					infotitle:		'自定义标签('+$('#customlabel').val()+')'
		              				},
		              	dataType:	'json',
		              	async:  	false,
		              	success:	function(data) {
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
					return false;
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
                $(function() {
                    var isDucha = false;
                    for (var i = 0; i < DUCHA_DADUI_IDS.length; i++) {
                        if (DUCHA_DADUI_IDS[i] == currentUserDeptId) {
                            isDucha = true;
                            break;
                        }
                    }
                    if (isDucha) {
                        $('#zhenkongNoPermission').hide();
                        $('#zhenkongContent').show();
                    } else {
                        $('#zhenkongContent').hide();
                        $('#zhenkongNoPermission').show();
                    }
                    layui.form.render();
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
		  
          function edittagtree(index){
		 	switch(index){
		 		case 1:
		 		   var parentid = $("#customlabelid").val();  //是否是一级菜单
				   var parentlabel =$("#customlabelname").val()==""?"无":$("#customlabelname").val();//父节点自动以标签
				   var personlabel=${not empty personnel.id ? personnel.id : 0};//人员类型标签
					var index = layui.layer.open({
						title : "添加自定义标签",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/customlabel/add.jsp?menuid='+${param.menuid }+'&parentlabel='+parentlabel+'&personlabel='+personlabel+'&parentid='+parentid+'"/>',
					    offset: ["50"],
					    area: ['1000px', '600px'],
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
		 		case 2:
				 	var id=$("#customlabelid").val();
		 			if(id!=0){
				     	 var index = layui.layer.open({
							title : "修改自定义标签",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getCustomLabelByid.do?id='+id+"&menuid="+${param.menuid },
							offset: ["50"],
							area: ['1000px', '600px'],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							}
						})
					}else{
						top.layer.alert("请先选择自定义标签！");
					}
		 			break;
		 		case 3:
		 			 var id=$("#customlabelid").val();
					 if(id!=0){
					     top.layer.confirm('确定删除此信息？', function(index){
						        layer.close(index);
						     $.getJSON(locat+"/cancelcustomlabel.do?id="+id+"&menuid="+${param.menuid },{
									},function(data) {
									var str = eval('(' + data + ')');
						        	 if (str.flag ==1) {		                          
								         top.layer.msg("数据删除成功！"); 	
								         $("#tabCustomlabel").click()            
								       }else{
									       top.layer.msg("删除失败!");
									       $("#tabCustomlabel").click()                     
								      }			      	    		
						        });      
				         });
					}else{
						top.layer.alert("请先选择自定义标签！");
					}
		 			break;
		 	}
		 }
          
		  function openCustomlabel(personlabel){
		  		$("#customlabelid").val(0);
		  		$("#customlabelname").val("");
				$("#tagTree").html("");
				$("#label").hide();
				if(personlabel>0)appendTagTree(personlabel,false);
				else{
					var personlabels="${personnelExtend.labelsql}".split(",");
					var titles="${personnelExtend.memo}".split(",");
					for(var i=0;i<personlabels.length;i++){
						$("#tagTree").append('<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-bottom: 1px;"><legend style="font-size:16px;">'+titles[i]+'</legend></fieldset>');
						if(i==0)appendTagTree(parseInt(personlabels[i]),false);
						else appendTagTree(parseInt(personlabels[i]),false);
					}
				}
		  }
		  
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
<%--						var filesview=$("#label-view-fileList")--%>
<%--						filesview.html('');--%>
<%--						layui.upload.render();--%>
						var label=result.customLabel,info=result.labelinfo;
						$("#labeltitle").html(label.customlabel+(label.labledescription.trim()!=""?":":"")+label.labledescription)
						$('#customlabel').val(label.customlabel);
						$('#customlabelname').val(label.customlabel);
						$('#labelinfo').val(info.labelinfo);
						$('#labelmemo').val(info.memo);
						if(result.firstLabel>0){
							$('#firstLabel').val(info.id);
							$('#labelHistory').show();
<%--							if(info.attachments!=""){--%>
<%--								labelFilesView=info.attachments.split(",");--%>
<%--								if(labelFilesView.length>0){--%>
<%--									var viewname=info.filesname.split(",");--%>
<%--									$.each(labelFilesView,function(index,item){--%>
<%--										var tr = $(['<tr>', '<td>' + viewname[index] +--%>
<%--											'</td>',--%>
<%--											'<td>上传完成</td>', '<td>',--%>
<%--											'<button class="layui-btn layui-btn-sm label-upload-file-download" onclick="return false;">下载</button>',--%>
<%--											'<button class="layui-btn layui-btn-sm layui-btn-danger label-upload-file-delete" onclick="return false;">删除</button>',--%>
<%--											'</td>', '</tr>'--%>
<%--										].join(''));--%>
<%--										//删除--%>
<%--										tr.find('.label-upload-file-delete').on('click', function() {--%>
<%--										    top.layer.confirm('确定删除此文件附件？', function(firm){--%>
<%--												top.layer.close(firm);--%>
<%--												delete labelFilesView[index]; //删除对应的文件--%>
<%--												tr.remove();--%>
<%--											});--%>
<%--										});--%>
<%--										tr.find('.label-upload-file-download').on('click', function() {--%>
<%--							          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;--%>
<%--										});--%>
<%--										--%>
<%--										filesview.append(tr);--%>
<%--									});--%>
<%--								}--%>
<%--							}--%>
						}else{
							$('#firstLabel').val(0);
							$('#labelHistory').hide();
						}
					}
				});
		  }
		  
		  function openCustomTextFiles(id){
		  		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getCustomTextById.do"/>',
					data:		{
									id:	id,
								},
					dataType:	'json',
					async:      false,
					success:	function(result){
						var filesview=$("#label-view-fileList")
						filesview.html('');
						layui.upload.render();
						if(result.id>0){
							if(result.attachments!=""){
								labelFilesView=result.attachments.split(",");
								if(labelFilesView.length>0){
									var viewname=result.filesname.split(",");
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
						}
					}
				});
		  }
		  
		  function bouncer(array){
          		return array.filter(function(val){
          			return !(!val||val=="");
          		})
          }
		</script>
		<script type="text/javascript">
          layui.config({
              base: "<c:url value="/layui/lay/modules/"/>"
          }).extend({
              zTreeSelectM: 'zTreeSelectM/zTreeSelectM'
          });
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
		<!-- ===== 督察模块专用函数 ===== -->
		<script type="text/javascript">
		var locat = (window.location+'').split('/');
		$(function(){
			if('main' == locat[3]){
				locat = locat[0]+'//'+locat[2];
			} else {
				locat = locat[0]+'//'+locat[2]+'/'+locat[3];
			}
		});

		/* 诉求归纳历史记录 */
		function openSuqiuHistory() {
			layui.layer.open({
				title: '诉求归纳历史记录',
				type: 1,
				area: ['800px', '500px'],
				content: '<div style="padding:10px;"><table id="suqiuHistoryTable" lay-filter="suqiuHistoryTable"></table></div>',
				success: function(layero, index) {
					layui.table.render({
						elem: '#suqiuHistoryTable',
						url: '<c:url value="/ducha/history.do"/>',
						method: 'get',
						where: { type: 'suqiu', personnelid: ${personnel.id} },
						cols: [[
							{field:'suqiuContent', title:'诉求综述', minWidth:200},
							{field:'problemTag', title:'问题标签', width:90, templet: function(item) {
								return item.problemTag == 1 ? '有' : '无';
							}},
							{field:'addoperator', title:'录入人', width:100},
							{field:'addtime', title:'录入时间', width:170},
							{field:'memo', title:'备注', width:150}
						]],
						page: true,
						limit: 10
					});
				}
			});
		}

		/* 侦控记录历史记录 */
		function openZhenkongHistory(recordType) {
			var typeNames = {1:'侦控信息', 2:'警情研判', 3:'资金情况', 4:'通联情况', 5:'现实表现'};
			layui.layer.open({
				title: typeNames[recordType] + '历史记录',
				type: 1,
				area: ['800px', '500px'],
				content: '<div style="padding:10px;"><table id="zhenkongHistoryTable" lay-filter="zhenkongHistoryTable"></table></div>',
				success: function(layero, index) {
					var colsDef;
					if (recordType == 1) {
						colsDef = [
							{field:'zhenkongInfo', title:'侦控信息', minWidth:200},
							{field:'evidenceFlag', title:'证据充足', width:90, templet: function(item) { return item.evidenceFlag == 1 ? '是' : '否'; }},
							{field:'hitCondition', title:'打击条件', width:90, templet: function(item) { return item.hitCondition == 1 ? '是' : '否'; }},
							{field:'addoperator', title:'录入人', width:100},
							{field:'addtime', title:'录入时间', width:170}
						];
					} else if (recordType == 2) {
						colsDef = [
							{field:'analysisContent', title:'研判分析', minWidth:300},
							{field:'addoperator', title:'录入人', width:100},
							{field:'addtime', title:'录入时间', width:170}
						];
					} else if (recordType == 3) {
						colsDef = [
							{field:'fundInfo', title:'资金情况', minWidth:300},
							{field:'addoperator', title:'录入人', width:100},
							{field:'addtime', title:'录入时间', width:170}
						];
					} else if (recordType == 4) {
						colsDef = [
							{field:'contactInfo', title:'通联情况', minWidth:300},
							{field:'addoperator', title:'录入人', width:100},
							{field:'addtime', title:'录入时间', width:170}
						];
					} else {
						colsDef = [
							{field:'performanceInfo', title:'现实表现', minWidth:300},
							{field:'addoperator', title:'录入人', width:100},
							{field:'addtime', title:'录入时间', width:170}
						];
					}
					layui.table.render({
						elem: '#zhenkongHistoryTable',
						url: '<c:url value="/ducha/history.do"/>',
						method: 'get',
						where: { type: 'zhenkong', personnelid: ${personnel.id}, recordType: recordType },
						cols: [colsDef],
						page: true,
						limit: 10
					});
				}
			});
		}

		/* 新增投诉信访弹窗 */
		function openAddXinfang() {
			var xinfangFormHtml =
				'<form class="layui-form" method="post" id="formAddXinfang" onsubmit="return false;" style="padding:15px;">' +
				'<input type="hidden" name="personnelid" value="${personnel.id}">' +
				'<input type="hidden" name="attachmentId" id="xinfangAttachmentId" value="">' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">诉求来源：</label>' +
				'  <div class="layui-input-block"><input type="text" name="suqiuSource" placeholder="请输入诉求来源" class="layui-input"></div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">诉求分类：</label>' +
				'  <div class="layui-input-block"><input type="text" name="suqiuType" placeholder="请输入诉求分类" class="layui-input"></div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">诉求日期：</label>' +
				'  <div class="layui-input-block"><input type="text" name="suqiuDate" id="xinfangSuqiuDate" placeholder="请选择日期" class="layui-input" autocomplete="off"></div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">被诉求单位：</label>' +
				'  <div class="layui-input-block"><input type="text" name="targetUnit" placeholder="请输入被诉求单位" class="layui-input"></div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">诉求内容：</label>' +
				'  <div class="layui-input-block"><textarea name="suqiuContent" placeholder="请输入诉求内容" class="layui-textarea" style="height:80px;"></textarea></div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">是否化解：</label>' +
				'  <div class="layui-input-block"><select name="resolveFlag"><option value="0">未化解</option><option value="1">已化解</option></select></div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">附件上传：</label>' +
				'  <div class="layui-input-block">' +
				'    <button type="button" class="layui-btn layui-btn-sm" id="xinfangUploadBtn"><i class="layui-icon">&#xe67c;</i>选择文件</button>' +
				'    <div id="xinfangFileList" style="margin-top:5px;"></div>' +
				'  </div>' +
				'</div>' +
				'<div class="layui-form-item">' +
				'  <label class="layui-form-label">备注：</label>' +
				'  <div class="layui-input-block"><input type="text" name="memo" placeholder="请输入备注" class="layui-input"></div>' +
				'</div>' +
				'<div style="text-align:center;margin-top:10px;">' +
				'  <button type="submit" class="layui-btn" lay-submit="" lay-filter="submitXinfang">提交</button>' +
				'</div>' +
				'</form>';

			var xfIndex = layui.layer.open({
				title: '新增投诉信访记录',
				type: 1,
				area: ['700px', '620px'],
				content: xinfangFormHtml,
				success: function(layero, index) {
					layui.form.render();
					// 日期选择器
					layui.laydate.render({
						elem: '#xinfangSuqiuDate',
						type: 'date'
					});
					// 附件上传
					var xinfangUploadedIds = [];
					layui.upload.render({
						elem: '#xinfangUploadBtn',
						url: '<c:url value="/newuploadfile1.do"/>',
						accept: 'file',
						multiple: true,
						done: function(res) {
							if (res.success > 0) {
								xinfangUploadedIds.push(res.success);
								$('#xinfangAttachmentId').val(xinfangUploadedIds.join(','));
								var fileName = res.filename || ('文件' + res.success);
								$('#xinfangFileList').append(
									'<span style="margin-right:10px;" id="xf-file-' + res.success + '">' +
									'<i class="layui-icon" style="color:green;">&#xe605;</i> ' + fileName +
									' <a href="javascript:;" onclick="removeXinfangFile(' + res.success + ')" style="color:red;">删除</a>' +
									'</span>'
								);
							} else {
								layer.msg('上传失败');
							}
						}
					});
					// 提交信访记录
					layui.form.on('submit(submitXinfang)', function(formData) {
						$('#formAddXinfang').ajaxSubmit({
							url: '<c:url value="/ducha/saveXinfang.do"/>?menuid=${menuid}',
							dataType: 'json',
							async: false,
							success: function(data) {
								var obj = eval('(' + data + ')');
								if(obj.flag > 0) {
									top.layer.msg(obj.msg);
									layui.layer.close(xfIndex);
									reloadXinfangTable();
								} else {
									layer.msg(obj.msg);
								}
							},
							error: function() {
								layer.alert("请求失败！");
							}
						});
						return false;
					});
				}
			});
		}

		/* 删除信访附件（弹窗内） */
		function removeXinfangFile(fileid) {
			$('#xf-file-' + fileid).remove();
			var ids = $('#xinfangAttachmentId').val().split(',');
			ids = ids.filter(function(v) { return v != fileid && v != ''; });
			$('#xinfangAttachmentId').val(ids.join(','));
		}

		/* 查看信访附件 */
		function viewXinfangFiles(attachmentIds) {
			var ids = attachmentIds.split(',');
			var html = '<div style="padding:15px;">';
			for (var i = 0; i < ids.length; i++) {
				if (ids[i] && ids[i] != '') {
					html += '<div style="margin-bottom:8px;"><a href="<c:url value="/downUpfile.do"/>?fileid=' + ids[i] + '&type=1" target="_blank" class="layui-btn layui-btn-xs layui-btn-normal">下载附件' + (i+1) + '</a></div>';
				}
			}
			html += '</div>';
			layui.layer.open({
				title: '附件列表',
				type: 1,
				area: ['400px', '300px'],
				content: html
			});
		}

		/* 刷新信访列表 */
		function reloadXinfangTable() {
			layui.table.reload('xinfangTable', {
				where: { type: 'xinfang', personnelid: ${personnel.id} },
				page: { curr: 1 }
			});
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
