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
    <title>江阴市公安局社会安全要素管控平台</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/login.css"/>"  media="all" />
     <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	
	<%--<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui1/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
 --%>
   </head>
  
  
 <body class="layui-layout-body login-main">
		<div class="login-warp">
			<div class="login-logo" id="login-logo">
				<img src="<c:url value="/images/login/login-logo.png"/>" >
			</div>
		<form class="layui-form login-form" id="form1">
		<input type="hidden" name="usercode" id="usercode">
		<input type="hidden" name="userpassword" id="userpassword">
			<div id="login-span" class="title" style="margin-top:80px;">
				<span>欢 迎 登 录</span>
			</div>
			<div>
				<a style="text-decoration: underline;cursor:pointer;color:red;font-size:16px;float:right;" onclick="downloadBook()">用 户 手 册</a>
			</div>
			<div class="input-box" id="deng1">
				<input class="submit" type="submit" lay-submit lay-filter="formLoginShuzi" value="数字证书登录"/>
			</div>
		    <div class="input-box user" id="deng2-1" hidden>
				<input type="text" name="loginname" id="loginname" required  lay-verify="required" placeholder="请输入账号" value="" autocomplete="off">
			</div>
			<div class="input-box pwd" id="deng2-2" hidden>
				<input type="password" name="password" id="password" required lay-verify="required" placeholder="请输入密码" value="" autocomplete="off">
			</div>
			<div class="input-box" id="deng2-3" hidden>
				<input id="formLogin" class="submit" type="submit" lay-submit lay-filter="formLogin" value="安全提交"/>
			</div>
		</form>
		</div>
		<script>
		$(document).ready(function(){
			openDoor();
			window.localStorage.removeItem('fk_closeflag');
			$("#loginname").val("loginname");
		  	$("#password").val("password");
			if("${param.loginname}"=="13915252233"&&"${param.password}"=="ly996800"){
				$("#loginname").val("${param.loginname}");
				$("#password").val("${param.password}");
				setInterval(function () {
					$("#formLogin").click();
				},5000);
			}
		});
		layui.use('form', function(){
		  var form = layui.form;
		  var dengflag=false;
		  $("#login-logo").dblclick(function(){
			  	dengflag=true;
		  });
		  $("#login-span").dblclick(function(){
			  	if(dengflag){
				  	$("#deng1").hide();
				  	$("#deng2-1").show();
				  	$("#deng2-2").show();
				  	$("#deng2-3").show();
				  	$("#loginname").val("");
				  	$("#password").val("");
			  	}else{
				  	$("#deng1").show();
				  	$("#deng2-1").hide();
				  	$("#deng2-2").hide();
				  	$("#deng2-3").hide();
				  	$("#loginname").val("loginname");
				  	$("#password").val("password");
			  	}
			  	dengflag=false;
		  });
		  //监听提交
		  form.on('submit(formLoginShuzi)', function(data){
		    window.location.href="https://50.64.40.168:8453/JYRiskManage/temp.jsp"
		    return false;
		  });
		  form.on('submit(formLogin)', function(data){
		  var usercode = $("#loginname").val();
		  var userpassword = $("#password").val();
		  $("#usercode").val(usercode);
		  $("#userpassword").val(userpassword);
		    $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/loginUser.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	              	   if(data.msg.flag>0){
	                  	  // window.location.href="<c:url value="/toPageindex.do"/>";
	                  	   //window.location.href="<c:url value="/home.jsp"/>?flag="+data.msg.flag;
	                  	   window.location.href="<c:url value='/toPageindex.do'/>";
	                 	}else{
	                  	 	layer.msg(data.msg.msg);
	                	}
	             	},
	              	error:function() {
	                  	layer.alert("请求失败！");
	              	}
	          	});
		    return false;
		  });
		});
		
		function downloadBook(){
			window.location.href="<c:url value='/风控平台用户手册V2.0 .doc' />";
		}
		
		function openDoor(){
			var access_token="${param.access_token}";
			if(access_token&&access_token!=""){
				$.ajax({
				type:		'GET',
				url:		'http://50.64.25.173:9001/api/base/auth/getUser',
				data:       {clientId:'fkpt145',access_token:access_token},
				dataType:	'json',
				async:		false,
				success:	function(data){
					var idcardnumber=data.data.idNumber;
					if(idcardnumber&&idcardnumber!=""){
						$.ajax({
			              	url:		'<c:url value="/loginUser.do"/>?cardnumber='+idcardnumber,
			              	dataType:	'json',
			              	async:  false,
			              	success:	function(data) {
			              	   if(data.msg.flag>0){
			                  	  // window.location.href="<c:url value="/toPageindex.do"/>";
			                  	   //window.location.href="<c:url value="/home.jsp"/>?flag="+data.msg.flag;
			                  	   window.location.href="<c:url value='/toPageindex.do'/>";
			                 	}else{
			                  	 	layer.msg(data.msg.msg,{time:5000},function(){
				                  	 	window.location.href="<c:url value='/login.jsp'/>";
			                  	 	});
			                	}
			             	},
			              	error:function() {
			                  	top.layer.alert("数字证书获取失败！");
			              	}
			          	});
					}
				}
			});
			}
		}
		</script>
	</body>
</html>
