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
     <title>风险人员详情-涉黑</title>
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
  </head>
  
 <body class="childrenBody layui-fluid">
		<form class="layui-form layui-row"   onsubmit="return false;">
		<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
		<input type="hidden"  name="menuid"    id="menuid"  value=0>
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
							<col width="300">
							<col width="100">
							<col width="300">
						</colgroup>
						<thead>
							<tr>
								<th colspan="4" class="layui-bg-blue layui-font-16 my-text-nowarp">可编辑人员信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-align-r my-text-nowarp">在控状态：</td>
								<td colspan="3"><c:if test="${heieditor.incontrolleve eq '1'}"> 关注中</c:if>
								<c:if test="${heieditor.incontrolleve eq '2'}"> 已打击</c:if></td>
								
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">可查看人员：</td>
								<td  colspan="3">${heieditor.editablename}</td>
								
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">创建人：</td>
								<td>${heieditor.addoperator}</td>
								<td class="text-align-r my-text-nowarp">创建时间：</td>
								<td>${heieditor.addtime}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">最新修改人：</td>
								<td>${heieditor.updateoperator}</td>
								<td class="text-align-r my-text-nowarp">最新修改时间：</td>
								<td>${heieditor.updatetime}</td>
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
						<li class="btn btn_5"  onclick="openJointControlRecord(${personnel.id});">联控记录</li>
						<li class="btn btn_4"  onclick="openTrajectoryKK('${personnel.cardnumber}',2);">轨迹信息</li>
						<li class="btn btn_6"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
						<li class="btn btn_7"  onclick="openRealityShow(${personnel.id})">现实表现</li>
						
					</ul>
					--%><div style="position: relative;">
						<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
							style="margin: 0 30px;width: auto !important;">
							<div class="swiper-wrapper" style="width:85px;height: 80px;">
								<li class="btn btn_11 layui-this swiper-slide" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')">属性标签</li>
								<li class="btn btn_1 swiper-slide">关联信息</li>
								<li class="btn btn_5 swiper-slide"  onclick="openJointControlRecord(${personnel.id});">联控记录</li>
								<li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
								<li class="btn btn_6 swiper-slide"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
								<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
								<li class="btn btn_7 swiper-slide"  onclick="openRealityShow(${personnel.id})">现实表现</li>
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
							<table class="layui-hide" id="jointcontrolrecordTable" lay-filter="jointcontrolrecordTable"></table> <!-- 联控信息 -->
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
						<table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table><!-- 社会关系 -->
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
						<div class="right-child-content layui-tab-item"><!--现实表现 -->
							
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">日常生活规律
										<button class="layui-btn layui-btn-sm" id="showHistory" style="display:none;" ><i class="layui-icon">&#xe68d;</i>维护记录</button></label>
										<div class="my-input-block">
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
						<div class="right-child-content layui-tab-item">
						</div>
						<div class="right-child-content layui-tab-item">
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
					//现实表现 历史修改记录
		    	$("#showHistory").click(function () {
					var index1 = layui.layer.open({
						title : "现实表现维护记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/wen/showhistory.jsp?datalabel=2&personnelid="+${personnel.id},
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
					layui.layer.full(index1);
				});
		});
		layui.use(['table','element', 'form', 'jquery'], function() {
		   var table = layui.table;
		   
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
						
				    }
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
					        {field:'infodate', title: '情报发生时间', width:150,align:"center"},
					        {field:'infotype', title: '情报内容类别', width:150,align:"center"},
					        {field:'addoperator', title: '采集人', width:100,align:"center"} ,
					        {field:'information', title: '情报内容',align:"center"} ,
					        {field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:65,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
					    });
                 }
               //现实表现
		     function openRealityShow(personnelid){
		     	$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRealityShowByPersonnelid.do?datalabel=2&personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
					  //alert(data.firstShow);
						if(data.firstShow>0){
							var show=data.realityShow;
							$('#showHistory').show();
						 	//var lifepattern=show.lifepattern.replace(/\n/g,"<br/>");
							//var healthstate=show.healthstate.replace(/\n/g,"<br/>");
							//var characteristic=show.characteristic.replace(/\n/g,"<br/>");
							//var lifehabit=show.lifehabit.replace(/\n/g,"<br/>");
							$('#lifepattern').html(show.lifepattern);
							$('#healthstate').html(show.healthstate);
							$('#characteristic').html(show.characteristic);
							$('#lifehabit').html(show.lifehabit);
						}else{
						    $('#showHistory').hide();
						}
					}
				});
          }
	</script>
	</body>
</html>
