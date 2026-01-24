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
				<form class="layui-form" method="post" id="formCy">
					<input type="hidden"  name="menuid"   id="menuid" value=${menuid }>
					<input type="hidden"  name="policephone1" value="${personnel.pphone1}">
					<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
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
										<input type="text" name="persontype" lay-verify="" autocomplete="off" value="${personnel.persontype}" class="layui-input">
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
									value="${personnel.workplace}" placeholder="请输入工作地详址" class="layui-input"  id="workplace" onclick="openPGis('work','工作地');" readonly style="background:#efefef;cursor:pointer;">
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
	
<%--						<div class="layui-col-md12">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>风险人员类别：</label>--%>
<%--								<div class="layui-input-block">--%>
<%--									<div id="personneltype"></div>--%>
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
						<div class="layui-col-md8 layui-col-md-offset4" style="margin-bottom: 30px;margin-top: 30px;">
							<div class="layui-form-item my-form-item">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="updateCy">立即提交</button>
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
							<li class="btn btn_12 swiper-slide" id="sjsa"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
							<li class="btn btn_5 swiper-slide" id="zaextendButton" onclick="openZaExtend(${personnel.id});">更多信息</li>
							<div class="swiper-slide"></div>
						</div>
					</div>
					<div class="my-swiper-button-next swiper-button-next1"></div>
					<div class="my-swiper-button-prev swiper-button-prev1"></div>
				</div>	
				
				<div class="layui-tab-content swiper-container">
						<div class="right-child-content layui-tab-item layui-show"><!-- 涉警涉案信息 -->
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
						<div class="right-child-content layui-tab-item">
							<form class="layui-form" method="post" id="formzaextend">
								<input type="hidden"  name="kongextendid"id="kongextendid">
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">职业</label>
										<div class="my-input-block">
											  <input type="text" name="zy" id="zy" autocomplete="off" placeholder="请输入职业" class="layui-input">
										</div>
									</div>
								</div>
								
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">工作单位</label>
										<div class="my-input-block">
											<input type="text" name="workunit" id="workunit" autocomplete="off" placeholder="请输入工作单位" class="layui-input">
										</div>
									</div>
								</div>
								<div class="layui-col-md3 layui-col-md-offset5">
									<div class="layui-form-item my-form-item" style="padding: 15px;">
										<button type="submit" class="layui-btn"  lay-submit="zaextendSub" lay-filter="zaextendSub">立即提交</button>
	
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
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
			        	}
			        	$('#treeSelect-input-jdunit1').blur(function(){
			        		form.render(null,"jdunit1_div");
					    });
					    //加载涉警涉案
					    $('#sjsa').click();
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
					
				form.on('submit(updateCy)', function(data) {
					var url='<c:url value="/updateCyPerson.do"/>?1=1';
					if(!$("input[name=homewifi]").prop("checked"))url+="&homewifi=";
					if(!$("input[name=homewide]").prop("checked"))url+="&homewide=";
					if(!$("input[name=workwifi]").prop("checked"))url+="&workwifi=";
					if(!$("input[name=workwide]").prop("checked"))url+="&workwide=";
					$("#formCy").ajaxSubmit({
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
				
				form.on('submit(zaextendSub)', function(data) {
					$("#formzaextend").ajaxSubmit({
				    	url:		'<c:url value="/updateZaExtend.do"/>?personnelid='+$("#id").val()+"&menuid=${menuid}",
				        dataType:	'json',
				        async:  	false,
				        success:	function(data) {
				        	var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                  	    //弹出loading
		                     	top.layer.msg(obj.msg);
		                     	$("#zaextendButton").click();
		                 	}else{
		                  	 	top.layer.msg(obj.msg);
		                	}
				        }
					});
					return false;
				});
		  });
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
			
			function openZaExtend(personnelid){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZaExtend.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						$("#zy").val(data.zaExtend.zy);
						$("#workunit").val(data.zaExtend.workunit);
					}
				});
			}
		</script>
		<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
	</body>
</html>
