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
     <title>风险人员详情-涉稳</title>
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
	<style>
	   .my-tab-title li {  width:25%  }
	</style>
	  <style>
     	/*layui-table 表格内容允许换行*/
<%--	    .layui-table-main .layui-table td div:not(.laytable-cell-radio){--%>
<%--	        height: auto;--%>
<%--	        overflow:visible;--%>
<%--	        text-overflow:inherit;--%>
<%--	        white-space:normal;--%>
<%--	    }--%>
<%--      	.layui-table-cell {--%>
<%--		    font-size:14px;--%>
<%--		    padding:0 5px;--%>
<%--		    height:auto;--%>
<%--		    overflow:visible;--%>
<%--		    text-overflow:inherit;--%>
<%--		    white-space:normal;--%>
<%--		    word-break: break-all;--%>
<%--		}--%>
		.layui-table-fixed .layui-table-body{
	    	display:none;
	    }
	    .layui-table-fixed .layui-table-header{
	    	display:none;
	    }
  </style>
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
									<img  id="defaultPhoto"  onclick="openPhotosInfo(${wenGrade.personnelid})"><br>
									
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
								<th colspan="6" class="layui-bg-blue layui-font-16 my-text-nowarp">分级分类信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-align-r my-text-nowarp">联控级别：</td>
								<td colspan="">${wenGrade.jointcontrollevel}</td>
								<td class="text-align-r my-text-nowarp">上行意愿：</td>
								<td colspan="">${wenGrade.awaywill}</td>
								<td class="text-align-r my-text-nowarp">在控状态：</td>
								<td colspan="">${wenGrade.incontrollevel}</td>
							</tr>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">风险人员类别：</td>--%>
<%--								<td  colspan="5">${wenGrade.typename}</td>--%>
<%--							</tr>--%>
							<tr>
								<td class="text-align-r my-text-nowarp">责任警种：</td>
								<td  colspan="5">${wenGrade.policename}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
								<td>${personnel.jurisdictunit}</td>
								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
								<td>${personnel.jurisdictpolice}</td>
								<td class="text-align-r my-text-nowarp">民警手机：</td>
								<td>${personnel.pphone1}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
								<td>${personnel.policephone}</td>
								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
								<td>${personnel.incontrolleve}</td>
								<td class="text-align-r my-text-nowarp">民警手机：</td>
								<td>${personnel.pphone2}</td>
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
						<li class="btn btn_2" onclick="openWenRisk(${wenGrade.personnelid})">风险背景</li>
						<li class="btn btn_3" onclick="searchWenVisit(${wenGrade.personnelid})">涉诉涉访经历</li>
						<li class="btn btn_4"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
						<li class="btn btn_5" onclick="openJointControlRecord(${wenGrade.personnelid});">联控记录</li>
						<li class="btn btn_6"   onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
						<li class="btn btn_7" onclick="openRealityShow(${wenGrade.personnelid})">现实表现</li>
						
					</ul>
					--%><div style="position: relative;">
						<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
								style="margin: 0 30px;width: auto !important;">
								<div class="swiper-wrapper" style="width:85px;height: 80px;">
									<li class="btn btn_11 layui-this swiper-slide" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')" >人员属性标签</li>
									<li class="btn btn_1 swiper-slide">关联信息</li>
									<li class="btn btn_2 swiper-slide"  onclick="openWenRisk(${wenGrade.personnelid})">风险背景</li>
									<li class="btn btn_3 swiper-slide"  onclick="searchWenVisit(${wenGrade.personnelid})">涉诉涉访经历</li>
								    <li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
									<li class="btn btn_5 swiper-slide"  onclick="openJointControlRecord(${wenGrade.personnelid});">联控记录</li>
									<li class="btn btn_6 swiper-slide"   onclick="openSocialRelations(${personnel.id});">社会关系</li>
									<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
									<li class="btn btn_7 swiper-slide"  onclick="openRealityShow(${wenGrade.personnelid})">现实表现</li>
									<div class="swiper-slide"></div>
								</div>
							</div>
							<div class="my-swiper-button-next swiper-button-next1"></div>
							<div class="my-swiper-button-prev swiper-button-prev1"></div>
						</div>	
					<div class="layui-tab-content swiper-container" style="padding-left: 1px;">
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
										<td ><a href="#" style="text-decoration: underline;" onclick="openRelation('telnumber',${wenGrade.personnelid},0);">${relation.telnumber}</a></td>
										<td class="text-align-r my-text-nowarp">使用手机：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('telephone',${wenGrade.personnelid},0);">${relation.telephone}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">关联wifi：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedwifi',${wenGrade.personnelid},0);">${relation.relatedwifi}</a></td>
										<td class="text-align-r my-text-nowarp">交通工具：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedvehicle',${wenGrade.personnelid},0);">${relation.relatedvehicle}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">银行账号：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('bankaccount',${wenGrade.personnelid},0);">${relation.bankaccount}</a></td>
										<td class="text-align-r my-text-nowarp">虚拟身份：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('netidentity',${wenGrade.personnelid},0);">${relation.netidentity}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">网络支付：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('netpayment',${wenGrade.personnelid},0);">${relation.netpayment}</a></td>
										<td class="text-align-r my-text-nowarp">涉及房产：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedhouse',${wenGrade.personnelid},0);">${relation.relatedhouse}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">法人组织：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedlegal',${wenGrade.personnelid},0);">${relation.relatedlegal}</a></td>
										<td class="text-align-r my-text-nowarp">驾驶证件：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relateddriver',${wenGrade.personnelid},0);">${relation.relateddriver}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">护照情况：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedpassport',${wenGrade.personnelid},0);">${relation.relatedpassport}</a></td>
										<td class="text-align-r my-text-nowarp"></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="right-child-content layui-tab-item"><!--风险背景 -->
						<form class="layui-form" method="post" id="formWenRisk" onsubmit="return false;">
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">矛盾风险产生经过、详情
											<button class="layui-btn layui-btn-sm" id="riskHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
										<div class="my-input-block">
										<textarea  class="layui-textarea"  readonly	id="conflictdetails" name="conflictdetails">${wenRisk.conflictdetails}</textarea></div>
									</div>
								</div>
								
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">目前风险状态及人员诉求</label>
										<div class="my-input-block">
										<textarea  class="layui-textarea"  readonly	id="riskappeal" name="riskappeal">${wenRisk.riskappeal}</textarea>
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
							</form>
						</div>
						<div class="right-child-content layui-tab-item">
						 	<table class="layui-hide" id="wenVisitTable" lay-filter="wenVisitTable"></table>
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
								</div>
						    </div>
						--%></div>
						<div class="right-child-content layui-tab-item">
						  <table class="layui-hide" id="jointcontrolrecordTable" lay-filter="jointcontrolrecordTable"></table> <!-- 联控信息 -->
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
						<div class="right-child-content layui-tab-item">
							
						      <div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">日常生活规律
										<button class="layui-btn layui-btn-sm" id="showHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
										<div class="my-input-block" >
										<textarea  class="layui-textarea"  readonly	id="lifepattern" name="lifepattern"></textarea>
										</div>
									</div>
								</div>
								
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">健康状况</label>
										<div class="my-input-block">
										    <textarea  class="layui-textarea"  readonly	id="healthstate" name="healthstate"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">性格特点</label>
										<div class="my-input-block">
										    <textarea  class="layui-textarea"  readonly	id="characteristic" name="characteristic"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">生活习惯</label>
										<div class="my-input-block">
										   <textarea  class="layui-textarea"  readonly	id="lifehabit" name="lifehabit"></textarea>
										</div>
									</div>
								</div>
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
				addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}');
		});
		layui.use(['table','element', 'form', 'jquery'], function() {
		   var table = layui.table;
			
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
		 //现实表现 历史修改记录   	
		 $("#showHistory").click(function () {
		 //alert(${personnel.id});
					var index = layui.layer.open({
						title : "现实表现维护记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/showhistory.jsp?datalabel=1&&personnelid="+${personnel.id},
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
			 //风险背景 历史修改记录   	    	
		  $("#riskHistory").click(function () {
					var index = layui.layer.open({
						title : "风险背景维护记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/riskhistory.jsp?personnelid="+${personnel.id},
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
		       //联动记录 列表显示
                 function  openJointControlRecord(personnelid){
                   layui.table.render({
					    elem: '#jointcontrolrecordTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchJointControlRecord.do?personnelid="+personnelid,
					    method:'post',
					    cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'infodate', title: '情报发生时间', width:150,align:"center",templet: function (item) {
								   return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoJointcontrolrecord("+item.id+");'><font color='blue'>"+item.infodate+"</font></span>";
		                    }},
					        {field:'infotype', title: '情报内容类别', width:150,align:"center"},
					        {field:'addoperator', title: '采集人', width:100,align:"center"} ,
					        {field:'information', title: '情报内容',align:"center"} 
					        //{field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:65,align:"center"} 
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
					   if(data.firstRisk>0){
							var risk=data.wenRisk;
							$('#riskHistory').show();
						//	$('#firstRisk').val(risk.id);//存放wenRisk id
						if(risk.fileattachments!=""){
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
											'</td>', '</tr>'
										].join(''));
									  tr.find('.risk-upload-file-download').on('click', function() {
							          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
										});
										
										filesview.append(tr);
									});
								}
							}
							if(risk.videoattachments!=""){
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
											'</td>', '</tr>'
										].join(''));
									  tr.find('.risk-upload-video-show').on('click', function() {
											openVideo("../uploadFiles/audio/"+viewallname[index])
										});
										
										videosview.append(tr);
									});
								}
							}
						}else{
							$('#riskHistory').hide();
							
						}
					}
				});
          }
          
          function openVideo(url){
          		var html='<div><video id="video" controls preload="auto" width="100%" height="100%"><source src="'
          		+url
          		+'" type="video/mp4"></video></div>';
          		var index=layui.layer.open({
          			type:1,
          			skin:'layui-layer-rim',
          			title:"视频预览",
          			content:html,
          			area: ['600', '600px'],
          		});
          		layui.layer.full(index);
          }
                  //涉诉涉访经历 列表显示
                 function  searchWenVisit(personnelid){
                   layui.table.render({
					    elem: '#wenVisitTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchWenVisit.do?personnelid="+personnelid,
					    method:'post',
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
						        //{field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:70}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }
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
                 //现实表现
               function openRealityShow(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRealityShowByPersonnelid.do?datalabel=1&personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						if(data.firstShow>0){
							var show=data.realityShow;
							$('#showHistory').show();
							//var lifepattern=show.lifepattern.replace(/\n/g,"<br/>");
							//var healthstate=show.healthstate.replace(/\n/g,"<br/>");
							//var characteristic=show.characteristic.replace(/\n/g,"<br/>");
							//var lifehabit=show.lifehabit.replace(/\n/g,"<br/>");
							$('#lifepattern').val(show.lifepattern);
							$('#healthstate').val(show.healthstate);
							$('#characteristic').val(show.characteristic);
							$('#lifehabit').val(show.lifehabit);
						}else{
							$('#showHistory').hide();
						}
					}
				});
          }
	</script>
	</body>
</html>
