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
     <title></title>
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/font-awesome-4.7.0/css/font-awesome.min.css"/>" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/tagTree.css"/>" />
     <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/tagtree/tagTree.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
  </head>
  
 <body class="childrenBody layui-fluid">
		<form class="layui-form layui-row"  onsubmit="return false;">
		<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
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
									<img  id="defaultPhoto"  onclick="openPhotosInfo(${personnel.id})"><br>
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
								<td class="text-align-r my-text-nowarp">身高：</td>
								<td colspan="2">${personnel.personheight}</td>
								<td class="text-align-r my-text-nowarp">婚姻状况：</td>
								<td colspan="2">${personnel.marrystatus}</td>
							</tr>
							<tr>
							    <td class="text-align-r my-text-nowarp">民族：</td>
								<td colspan="2">${personnel.nation}</td>
								<td class="text-align-r my-text-nowarp">人员类别：</td>
								<td colspan="2">${personnel.persontype}</td>
							</tr>
							<tr>
								<td  colspan="2" class="text-align-r my-text-nowarp">兵役状况：</td>
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
							    <td  class="text-align-r my-text-nowarp">网络社交技能习惯：</td>
								<td colspan="2">${personnel.netskillhabit}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地详址：</td>
								<td colspan="3">${personnel.houseplace}</td>
								<td class="text-align-r my-text-nowarp">户籍地派出所：</td>
								<td colspan="2">${personnel.housepolice}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地经度：</td>
								<td colspan="3">${personnel.housex}</td>
								<td class="text-align-r my-text-nowarp">户籍地纬度：</td>
								<td colspan="2">${personnel.housey}</td>
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
								<td class="text-align-r my-text-nowarp">现住地经度：</td>
								<td colspan="3">${personnel.homex}</td>
								<td class="text-align-r my-text-nowarp">现住地纬度：</td>
								<td colspan="2">${personnel.homey}</td>
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
								<td class="text-align-r my-text-nowarp">工作地经度：</td>
								<td colspan="3">${personnel.workx}</td>
								<td class="text-align-r my-text-nowarp">工作地纬度：</td>
								<td colspan="2">${personnel.worky}</td>
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
				<!-- 分级分类信息 -->
				<div class="layui-row" style="padding: 1px;">
					<table class="layui-table" lay-even>
						<colgroup>
							<col width="100">
							<col width="150">
							<col width="100">
							<col width="150">
							<col width="100">
							<col width="150">
						</colgroup>
						<thead>
							<tr>
								<th colspan="6" class="layui-bg-blue layui-font-16 text-align-c">分级分类信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-align-r my-text-nowarp">联控级别：</td>
								<td colspan="2">${personnelExtend.jointcontrollevel}</td>
								<td class="text-align-r my-text-nowarp">在控状态：</td>
								<td colspan="2">${personnelExtend.incontrollevel}</td>
							</tr>
							<tr>
									<td class="text-align-r my-text-nowarp">人员属性标签：</td>
									<td colspan="5">${personnelExtend.personlabelname}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
								<td>${personnelExtend.unitname1}</td>
								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
								<td>${personnelExtend.policename1}</td>
								<td class="text-align-r my-text-nowarp">民警手机：</td>
								<td>${personnelExtend.policephone1}</td>
							</tr>
						
							<tr>
									<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
								<td>${personnelExtend.unitname2}</td>
								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
								<td>${personnelExtend.policename2}</td>
								<td class="text-align-r my-text-nowarp">民警手机：</td>
								<td>${personnelExtend.policephone1}</td>
							</tr>
						
						</tbody>
					</table>
				</div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab">
				  <%--<ul class="layui-tab-title btn-list" style="margin:0px; padding:0px;">
				       <li class="btn btn_11 layui-this" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')">属性标签</li>
						<li class="btn btn_1">关联信息</li>
						<li class="btn btn_2"  onclick="openTrajectoryRecord(${personnel.id});">轨迹信息</li>
						<li class="btn btn_3" onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
					</ul>
					--%><div style="position: relative;">
						<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
							style="margin: 0 30px;width: auto !important;">
							<div class="swiper-wrapper" style="width:85px;height: 80px;">
								<li class="btn btn_11 layui-this swiper-slide" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')">属性标签</li>
								<li class="btn btn_4 swiper-slide" id="tabCustomlabel" onclick="openCustomlabel(${personnel.id})">自主标签</li>
								<li class="btn btn_1 swiper-slide">关联信息</li>
								<li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
								<li class="btn btn_3 swiper-slide" onclick="openSocialRelations(${personnel.id});">社会关系</li>
								<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
								<li class="btn btn_5 swiper-slide">自定义档案</li>
								<div class="swiper-slide"></div>
							</div>
						</div>
						<div class="my-swiper-button-next swiper-button-next1"></div>
						<div class="my-swiper-button-prev swiper-button-prev1"></div>
					</div>
					<div class="layui-tab-content" style="padding-left: 1px;">
					<div class="right-child-content layui-tab-item layui-show"><!--人员属性标签 -->
						<form class="layui-form" method="post" id="formAttributeLabel" onsubmit="return false;">
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">人员属性标签</li>
									<li  onclick="applyTable(${personnel.id});">标签维护记录</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <table class="layui-table">
												<tr>
													<td>
														<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
													  		<legend style="font-size:16px">一级标签</legend>
														</fieldset>
														<div id="zslabels1" style="left:50px;"></div>
													</td>
												</tr>
												<tr>
													<td>
														<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
													  		<legend style="font-size:16px">二级标签</legend>
														</fieldset>
														<div id="zslabels2" style="left:50px;"></div>
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
							<table class="layui-table">
								<tr>
									<td valign="top" width="28%">		
										<div style="width:300px;overflow: auto;height: 450px;">
											<ul id="tagTree" class="tagtree" style="width:350px;overflow: auto;height: 360px;-right:80px;">
												
											</ul>
										</div>
									</td>
									<td valign="top" width="72%"> 
										<div id="label" style="height: 680px;display:none;">
											<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
										  		<legend id="labeltitle" style="font-size:16px;"></legend>
											</fieldset>
											<input type="hidden" id="firstLabel" value=0>
											<input type="hidden" id="customlabel" value="">
											<input type="hidden" id="customlabelname" value="">
											<input type="hidden" id="customlabelid" name="customlabelid" value=0>
											<div class="layui-form-item my-form-item">
												<label class="my-form-label-br">标签描述
												<button class="layui-btn layui-btn-sm" id="labelHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
												<div class="my-input-block">
												<textarea  class="layui-textarea"	id="labelinfo" name="labelinfo"  readonly></textarea>
													
												</div>
											</div>
											<div class="layui-form-item my-form-item">
												<label class="my-form-label-br">标签详情
												<div class="my-input-block">
												<textarea  class="layui-textarea"	id="labelmemo" name="labelmemo" readonly></textarea>
												
												</div>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<div class="right-child-content layui-tab-item  ">
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
									<tbody>
									<tr>
										<td class="text-align-r my-text-nowarp">手机号码：</td>
										<td ><a href="#" style="text-decoration: underline;" onclick="openRelation('telnumber',${personnel.id},0);">${relation.telnumber}</a></td>
										<td class="text-align-r my-text-nowarp">使用手机：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('telephone',${personnel.id},0);">${relation.telephone}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">关联wifi：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedwifi',${personnel.id},0);">${relation.relatedwifi}</a></td>
										<td class="text-align-r my-text-nowarp">交通工具：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedvehicle',${personnel.id},0);">${relation.relatedvehicle}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">银行账号：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('bankaccount',${personnel.id},0);">${relation.bankaccount}</a></td>
										<td class="text-align-r my-text-nowarp">虚拟身份：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('netidentity',${personnel.id},0);">${relation.netidentity}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">网络支付：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('netpayment',${personnel.id},0);">${relation.netpayment}</a></td>
										<td class="text-align-r my-text-nowarp">涉及房产：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedhouse',${personnel.id},0);">${relation.relatedhouse}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">法人组织：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedlegal',${personnel.id},0);">${relation.relatedlegal}</a></td>
										<td class="text-align-r my-text-nowarp">驾驶证件：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relateddriver',${personnel.id},0);">${relation.relateddriver}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">护照情况：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedpassport',${personnel.id},0);">${relation.relatedpassport}</a></td>
										<td class="text-align-r my-text-nowarp"></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="right-child-content layui-tab-item">
						 <form class="layui-form" method="post" id="formTrajectoryTable" onsubmit="return false;">
	                            <div class="layui-inline" style="width:212px;left:20px;">
	                            	<select id="trajectoryTableTypes" lay-filter="trajectoryTableTypes"></select>
	                            </div>       
								<table class="layui-hide" id="trajectoryTable" lay-filter="trajectoryTable"></table>
							</form>
						</div>
						<div class="right-child-content layui-tab-item">
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
														value="${customText.title1}" placeholder="请输入补充标题" class="layui-input" readonly>
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text1" lay-verify="" autocomplete="off"
														value="${customText.text1}" placeholder="请输入补充内容" class="layui-input" readonly>
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
														value="${customText.title2}" placeholder="请输入补充标题" class="layui-input" readonly>
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text2" lay-verify="" autocomplete="off"
														value="${customText.text2}" placeholder="请输入补充内容" class="layui-input" readonly>
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
														value="${customText.title3}" placeholder="请输入补充标题" class="layui-input" readonly>
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text3" lay-verify="" autocomplete="off"
														value="${customText.text3}" placeholder="请输入补充内容" class="layui-input" readonly>
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
														value="${customText.title4}" placeholder="请输入补充标题" class="layui-input" readonly>
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text4" lay-verify="" autocomplete="off"
														value="${customText.text4}" placeholder="请输入补充内容" class="layui-input" readonly>
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
														value="${customText.title5}" placeholder="请输入补充标题" class="layui-input" readonly>
												</div>
											</div>
										</div>
										<div class="layui-col-md8">
											<div class="layui-form-item my-form-item">
												<div class="layui-input-block" style="margin-left: 10px;">
													<input type="text" name="text5" lay-verify="" autocomplete="off"
														value="${customText.text5}" placeholder="请输入补充内容" class="layui-input" readonly>
												</div>
											</div>
										</div>
									</div>
								  	<div class="layui-col-md12">
								  		<div class="layui-form-item my-form-item" style="padding: 15px;">
											附件：
											<button type="button" class="layui-btn layui-hide"
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
							  	</div>
							</form>
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
				addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}');//加载已有人员标签
		});
		layui.use(['table','element', 'form', 'jquery', 'upload'], function() {
		   var upload = layui.upload,table = layui.table;
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
									'</td>', '</tr>'
								].join(''));

								//单个重传
								tr.find('.label-upload-file-reload').on('click', function() {
									obj.upload(index, file);
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
		 });
		
		function openCustomlabel(personlabel){
		  		$("#customlabelid").val(0);
		  		$("#customlabelname").val("");
				$("#tagTree").html("");
				$("#label").hide();
				if(personlabel>0)appendTagTree(personlabel,true);
				else{
					var personlabels="${personnelExtend.labelsql}".split(",");
					var titles="${personnelExtend.memo}".split(",");
					for(var i=0;i<personlabels.length;i++){
						$("#tagTree").append('<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-bottom: 1px;"><legend style="font-size:16px;">'+titles[i]+'</legend></fieldset>');
						if(i==0)appendTagTree(parseInt(personlabels[i]),true);
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
						var label=result.customLabel,info=result.labelinfo;
						$("#labeltitle").html(label.customlabel+(label.labledescription.trim()!=""?":":"")+label.labledescription)
						$('#customlabel').val(label.customlabel);
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
	</body>
</html>
