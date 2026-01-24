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
     <title>风险人员详情-通用</title>
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
  </head>
  
 <body class="childrenBody layui-fluid">
		<form class="layui-form layui-row"   onsubmit="return false;">
		<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
		<input type="hidden"  name="menuid"    id="menuid"  value=0>
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 1px;">
					<table class="layui-table" lay-even>
						<colgroup>
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<th colspan="7" class="layui-bg-blue layui-font-16 text-align-c">基本信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="5" class="text-align-c img">
									<img  id="defaultPhoto">
								</td>
								<td class="text-align-r my-text-nowarp">身份证号：</td>
								<td colspan="2">${personnel.cardnumber}</td>
								<td class="text-align-r my-text-nowarp">姓名：</td>
								<td colspan="2">${personnel.personname}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">性别：</td>
								<td colspan="2">${personnel.sexes}</td>
								<td class="text-align-r my-text-nowarp">年龄：</td>
								<td colspan="2">${age}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">曾用名：</td>
								<td colspan="2">${personnel.usedname}</td>
								<td class="text-align-r my-text-nowarp">绰号：</td>
								<td colspan="2">${personnel.nickname}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">婚姻状况：</td>
								<td colspan="2">${personnel.marrystatus}</td>
								<td class="text-align-r my-text-nowarp">民族：</td>
								<td colspan="2">${personnel.nation}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">兵役状况：</td>
								<td colspan="2">${personnel.soldierstatus}</td>
								<td class="text-align-r my-text-nowarp">健康状态：</td>
								<td colspan="2">${personnel.heathstatus}</td>
							</tr>
							<tr>
								<td colspan="2" class="text-align-r my-text-nowarp">政治面貌：</td>
								<td colspan="2">${personnel.politicalposition}</td>
								<td class="text-align-r my-text-nowarp">宗教信仰：</td>
								<td colspan="2">${personnel.faith}</td>
							</tr>
							<tr>
								<td colspan="2" class="text-align-r my-text-nowarp">文化程度：</td>
								<td colspan="2">${personnel.education}</td>
								<td class="text-align-r my-text-nowarp">人员类别：</td>
								<td colspan="2">${personnel.persontype}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地详址：</td>
								<td colspan="3">${personnel.houseplace}</td>
								<td class="text-align-r my-text-nowarp">户籍地派出所：</td>
								<td colspan="2">${personnel.housepolice}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">现住地详址：</td>
								<td colspan="3">${personnel.homeplace}</td>
								<td class="text-align-r my-text-nowarp">现住地派出所：</td>
								<td colspan="2">${personnel.homepolice}&nbsp;&nbsp;
								<c:if test="${personnel.homewifi eq 1}">【wifi】</c:if>
								<c:if test="${personnel.homewide eq 1}">【宽带】</c:if></td>
							</tr>
							
						<tr>
								<td class="text-align-r my-text-nowarp">工作地详址：</td>
								<td colspan="3">${personnel.workplace}</td>
								<td class="text-align-r my-text-nowarp">工作地派出所：</td>
								<td colspan="2">${personnel.workpolice}&nbsp;&nbsp;
								<c:if test="${personnel.workwifi eq 1}">【wifi】</c:if>
								<c:if test="${personnel.workwide eq 1}">【宽带】</c:if></td>
							</tr>
							
							<tr>
								<td class="text-align-r my-text-nowarp">特殊特征：</td>
								<td colspan="6">${personnel.feature}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">技能专长：</td>
								<td colspan="6">${personnel.speciality}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">前科劣迹：</td>
								<td colspan="6">${personnel.records}</td>
							</tr>
							
						</tbody>
					</table>
				</div>
				
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab">
				<ul class="layui-tab-title btn-list">
						<li class="btn btn_1 layui-this">关联信息</li>
						<li class="btn btn_6"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
					</ul>
					<div class="layui-tab-content" style="padding-left: 1px;">
						<div class="right-child-content layui-tab-item layui-show ">
							<table class="layui-table" lay-even>
								<colgroup>
									<col width="120">
									<col width="300">
									<col width="120">
									<col width="300">
								</colgroup>
								<thead>
								</thead>
								<tbody>
									<tr>
										<td class="text-align-r my-text-nowarp">手机号码：</td>
										<td >${relation.telnumber}</td>
										<td class="text-align-r my-text-nowarp">使用手机：</td>
										<td>${relation.telephone}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">关联wifi：</td>
										<td>${relation.relatedwifi}</td>
										<td class="text-align-r my-text-nowarp">交通工具：</td>
										<td>${relation.relatedvehicle}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">银行账号：</td>
										<td>${relation.bankaccount}</td>
										<td class="text-align-r my-text-nowarp">虚拟身份：</td>
										<td>${relation.netidentity}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">网络支付：</td>
										<td>${relation.netpayment}</td>
										<td class="text-align-r my-text-nowarp">涉及房产：</td>
										<td>${relation.relatedhouse}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">法人组织：</td>
										<td>${relation.relatedlegal}</td>
										<td class="text-align-r my-text-nowarp">驾驶证件：</td>
										<td>${relation.relateddriver}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">护照情况：</td>
										<td>${relation.relatedpassport}</td>
										<td class="text-align-r my-text-nowarp"></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="right-child-content layui-tab-item  layui-tab-item layui-show">
						<table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table><!-- 社会关系 -->
						</div>
						<script type="text/html" id="socialrelationsbar">
                           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
	                    </script>
					</div>
				</div>
			</div>
		</form>
	<script>
	 $(document).ready(function(){
				getDefaultPhoto();//加载默认图片
				
		});
		layui.use(['table','element', 'form', 'jquery'], function() {
		   var table = layui.table;
		
		    	
		 });
		
	</script>
	</body>
</html>
