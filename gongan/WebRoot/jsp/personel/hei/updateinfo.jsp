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
    <base href="<%=basePath%>">
    
    <title>修改涉黑人员</title>
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/layui1/css/layui.css"/>"  media="all" />
	<script type="text/javascript" src="<c:url value="/layui1/layui.js"/>"></script>
	<%--<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui1/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
 --%><body class="childrenBody layui-fluid" style="overflow: scroll;">
		<div class="layui-row layui-col-md12 my-children-nav">
			<div class="page-title" style="float: left;">
				风险人员信息
			</div>
			<div class="page-nav-right-btn" style="float: right;">
				<i class="layui-icon layui-icon-close"></i>
			</div>
			<div class="page-nav-right-btn" style="float: right;">
				<i class="layui-icon layui-icon-template-1"></i>
			</div>
		</div>
		<form class="layui-form layui-row">
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue">基本信息：</label>
					</div>
					<div class=" my-onload-img layui-col-md2" style="height: 260px;">
						<img src="../images/home/people.png">
						<a href="#" class="my-font-blue" style="text-decoration: underline;" id="onloadimg">上传</a>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">身份证号：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">姓名：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>

					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">曾用名：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">绰号：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>

					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">性别：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">名族：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>

					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">婚姻状况：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">出生年月：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>

					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">年龄：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">健康状态：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">政治面貌：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">宗教信仰：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>

					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">文化程度：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">人员类别：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>

					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">兵役状况：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">户籍地详址：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">户籍地派出所：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">现住地详址：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">现住地派出所：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">居住地wifi：</label>
							<div class="layui-input-block">
								<input type="checkbox" name="like1[write]" lay-skin="primary" title="是" checked="">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="否">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">居住地宽带：</label>
							<div class="layui-input-block">
								<input type="checkbox" name="like1[write]" lay-skin="primary" title="是" checked="">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="否">
							</div>
						</div>
					</div>

					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">工作地详址：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">工作地派出所：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">工作地wifi：</label>
							<div class="layui-input-block">
								<input type="checkbox" name="like1[write]" lay-skin="primary" title="是" checked="">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="否">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">工作地宽带：</label>
							<div class="layui-input-block">
								<input type="checkbox" name="like1[write]" lay-skin="primary" title="是" checked="">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="否">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">特殊特征：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">技能专长：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">前科：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">信息核查方式：</label>
							<div class="layui-input-block">
								<input type="checkbox" name="like1[write]" lay-skin="primary" title="常驻" checked="">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="暂住">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="旅馆">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="网吧">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="盘查">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="出警">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="案件">
								<input type="checkbox" name="like1[read]" lay-skin="primary" title="关注人员系统">
							</div>
						</div>
					</div>
				</div>
				<!-- 分级分类信息 -->
				<div class="layui-row" style="padding: 15px;">
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue my-text-nowarp">分级分类信息</label>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">联控级别：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md7">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">在控状态：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>

					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">风险人员类别：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md7">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">责任警种：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>

					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">管辖责任单位：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md3">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">管辖责任民警：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">辖区责任民警手机号：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">双列管单位：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md3">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">双列管民警：</label>
							<div class="layui-input-block">
								<select name="interest" lay-filter="aihao">
									<option value=""></option>
									<option value="0">写作</option>
									<option value="1" selected="">阅读</option>
									<option value="2">游戏</option>
									<option value="3">音乐</option>
									<option value="4">旅行</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">双列管民警手机号码：</label>
							<div class="layui-input-block">
								<input type="text" name="title" lay-verify="title" autocomplete="off"
									placeholder="请输入标题" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 30px;">
						<div class="layui-form-item my-form-item">
							<button type="button" class="layui-btn layui-btn-sm"><i
									class="layui-icon">&#xe642;</i>编辑</button>
							<button type="button" class="layui-btn layui-btn-sm">
								<img src="../images/button/err.png">
								保存</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab">
					<ul class="layui-tab-title btn-list">
						<li class="btn btn_1 layui-this">关联信息</li>
						<li class="btn btn_2">风险背景</li>
						<li class="btn btn_3">设防设诉经历</li>
						<li class="btn btn_4">轨迹信息</li>
						<li class="btn btn_5">控诉记录</li>
						<li class="btn btn_6">社会关系</li>
						<li class="btn btn_7">现实表现</li>
					</ul>
					<div class="layui-tab-content">
						<div class="right-child-content layui-tab-item layui-show ">
							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">手机号码：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">使用手机：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md11">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">关联wifi：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">交通工具：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">银行账号：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">虚拟身份：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">网络支付：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label">涉及房产：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>

							<div class="layui-col-md5">
								<div class="layui-form-item my-form-item">
									<label class="layui-form-label ">法人组织：</label>
									<div class="layui-input-block">
										<input type="text" name="title" lay-verify="title" autocomplete="off"
											placeholder="" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-md1">
								<div class="layui-form-item my-form-item">
									<button
										class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
										更多</button>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-col-md12">
								<div class="layui-form-item my-form-item">
									<label class="my-form-label-br">矛盾风险产生经过</label>
									<div class="my-input-block">
										<textarea placeholder="请输入内容" class="layui-textarea"></textarea>
									</div>
								</div>
							</div>
							<div class="layui-col-md12">
								<div class="layui-form-item my-form-item">
									<label class="my-form-label-br">详情</label>
									<div class="my-input-block">
										<textarea placeholder="请输入内容" class="layui-textarea"></textarea>
									</div>
								</div>
							</div>
							<div class="layui-col-md12">
								<div class="layui-form-item my-form-item">
									<label class="my-form-label-br">目前风险状态及人员诉求</label>
									<div class="my-input-block">
										<textarea placeholder="请输入内容" class="layui-textarea"></textarea>
									</div>
								</div>
							</div>
							<!-- 多文件上传 -->
							<div class="layui-col-md12">
								<div class="layui-form-item my-form-item" style="padding: 15px;">
									文件附件：
									<button type="button" class="layui-btn layui-btn-sm"
										id="test-upload-testList">选择多文件</button>
									<button type="button" class="layui-btn layui-btn-sm"
										id="test-upload-testListAction">开始上传</button>
									<div class="layui-upload">
										<div class="layui-upload-list">
											<table class="layui-table">
												<thead>
													<tr>
														<th>文件名</th>
														<th>大小</th>
														<th>状态</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody id="test-upload-demoList"></tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- 上传视频 -->
							<div class="layui-col-md12">
								<div class="layui-form-item my-form-item" style="padding: 15px;">
									视频附件：
									<button type="button" class="layui-btn layui-btn-sm" id="test-upload-type3"><i
											class="layui-icon"></i>上传视频</button>
									<div class="layui-upload-list">
										<table class="layui-table" style="border: 1px solid #eee;">
											<tbody id="test-upload-vieoList"></tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="layui-col-md3 layui-col-md-offset5">
								<div class="layui-form-item my-form-item" style="padding: 15px;">
									<button type="button" class="layui-btn layui-btn-sm">立即提交</button>
									<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重
										置&nbsp;</button>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item">设防设诉经历4</div>
						<div class="right-child-content layui-tab-item">轨迹信息5</div>
						<div class="right-child-content layui-tab-item">控诉记录2</div>
						<div class="right-child-content layui-tab-item">社会关系3</div>
						<div class="right-child-content layui-tab-item">现实表现4</div>
					</div>
				</div>
			</div>
		</form>
		<script src="../layui/layui.js" type="text/javascript" charset="utf-8"></script>
		<script>
			layui.use(['element', 'form', 'upload', 'jquery'], function() {
				var element = layui.element,
					$ = layui.jquery,
					upload = layui.upload,
					form = layui.form;

				//监听提交
				form.on('submit(formLogin)', function(data) {
					layer.msg(JSON.stringify(data.field));
					return false;
				});
				upload.render({
					elem: '#onloadimg' //绑定元素
						,
					url: '/upload/' //上传接口
						,
					done: function(res) {
						//上传完毕回调
					},
					error: function() {
						//请求异常回调
					}
				});
				upload.render({
					elem: '#test1' //绑定元素
						,
					url: '/upload/' //上传接口
						,
					done: function(res) {
						//上传完毕回调
					},
					error: function() {
						//请求异常回调
					}
				});
				// 上传视频
				upload.render({
					elem: '#test-upload-type3',
					url: '/upload/',
					accept: 'video' //视频
						,
					done: function(res) {
						console.log(res)
					}
				});

				//多文件列表示例
				var demoListView = $("#test-upload-demoList"),
					uploadListIns = upload.render({
						elem: '#test-upload-testList',
						url: '/upload/',
						accept: 'file',
						multiple: true,
						auto: false,
						bindAction: '#test-upload-testListAction',
						choose: function(obj) {
							var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
							//读取本地文件
							obj.preview(function(index, file, result) {
								var tr = $(['<tr id="upload-' + index + '">', '<td>' + file.name +
									'</td>', '<td>' + (file.size / 1014).toFixed(1) + 'kb</td>',
									'<td>等待上传</td>', '<td>',
									'<button class="layui-btn layui-btn-sm test-upload-demo-reload layui-hide">重传</button>',
									'<button class="layui-btn layui-btn-sm layui-btn-danger test-upload-demo-delete">删除</button>',
									'</td>', '</tr>'
								].join(''));

								//单个重传
								tr.find('.test-upload-demo-reload').on('click', function() {
									obj.upload(index, file);
								});

								//删除
								tr.find('.test-upload-demo-delete').on('click', function() {
									delete files[index]; //删除对应的文件
									tr.remove();
									uploadListIns.config.elem.next()[0].value =
									''; //清空 input file 值，以免删除后出现同名文件不可选
								});

								demoListView.append(tr);
							});
						},
						done: function(res, index, upload) {
							if (res.code == 0) { //上传成功
								var tr = demoListView.find('tr#upload-' + index),
									tds = tr.children();
								tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
								tds.eq(3).html(''); //清空操作
								return delete this.files[index]; //删除文件队列已经上传成功的文件
							}
							this.error(index, upload);
						},
						error: function(index, upload) {
							var tr = demoListView.find('tr#upload-' + index),
								tds = tr.children();
							tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
							tds.eq(3).find('.test-upload-demo-reload').removeClass('layui-hide'); //显示重传
						}
					});


			});
		</script>
	</body>
</html>
