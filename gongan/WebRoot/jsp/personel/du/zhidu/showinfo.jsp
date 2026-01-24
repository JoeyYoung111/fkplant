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
     <title>详情制贩毒风险人员信息</title>
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
								<td class="text-align-r my-text-nowarp">人员属性：</td>
								<td colspan="2">${personnel.persontype}</td>
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
								<td class="text-align-r my-text-nowarp">信息检查方式：</td>
								<td colspan="6">${personnel.checkmethod}</td>
							</tr>
							 <tr>
							<td class="text-align-r my-text-nowarp">末次处罚时间：</td>
								<td colspan="6">${duextend.lasttime}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">涉毒种类：</td>
								<td colspan="6">${duextend.narcoticstype}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">前科劣迹：</td>
								<td colspan="6">${personnel.records}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">其他案件类别：</td>
								<td colspan="6">${duextend.casenameMsg}</td>
							</tr>
						</tbody>
					</table>
				</div>
		  </div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab">
				<%--<ul class="layui-tab-title btn-list">
				        <li class="btn btn_11 layui-this" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')">属性标签</li>
					    <li class="btn btn_2  layui-this">分类分级</li>
						<li class="btn btn_1 ">关联信息</li>
						<li class="btn btn_5"  onclick="openDuCheckRecord(${personnel.id});">联控记录</li>
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
							    <li class="btn btn_2 swiper-slide">分类分级</li>
								<li class="btn btn_1 swiper-slide">关联信息</li>
								<li class="btn btn_5 swiper-slide"  onclick="openDuCheckRecord(${personnel.id});">联控记录</li>
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
					 <div class="right-child-content layui-tab-item"><!--分类分级 -->
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
										<td class="text-align-r my-text-nowarp">人员类别：</td>
										<td colspan="3" id="ptype">${duextend.ptype }</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">管控类别：</td>
										<td >${duextend.jointcontrollevel}</td>
										<td class="text-align-r my-text-nowarp">在控状态：</td>
										<td>${duextend.incontrollevel}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">管控现状/表现：</td>
										<td  colspan="3">${duextend.controlstatus}</td>
									</tr>
									
									<tr>
										<td class="text-align-r my-text-nowarp">平安关爱对象：</td>
										<td>
										    <c:if test="${duextend.caredperson eq 1}">是</c:if>
										    <c:if test="${duextend.caredperson eq 2}">否</c:if>
										</td>
										<td class="text-align-r my-text-nowarp">平安关爱措施：</td>
										<td>${duextend.safetyaction}</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
										<td>${duextend.unitname1}</td>
										<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
										<td>${duextend.policename1}(手机号：${duextend.policephone1})</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">双列管单位：</td>
										<td>${duextend.unitname2}</td>
										<td class="text-align-r my-text-nowarp">双列管民警：</td>
										<td>${duextend.policename2}(手机号：${duextend.policephone2})</td>
									</tr>
									
								</tbody>
							</table>
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
										<label class="my-form-label-br">现实表现：
										<div class="my-input-block">
										  <span id="actualstate"></span>
										</div>
									</div>
								</div>
								
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">其他说明情况：</label>
										<div class="my-input-block">
										   <textarea  class="layui-textarea"  readonly	id="memo" name="memo"></textarea>
										</div>
									</div>
								</div>
							    <div class="layui-col-md12">
									<div class="layui-form-item my-form-item" style="padding: 15px;">
										附件：
										<div class="layui-upload">
											<div class="layui-upload-list">
												<table class="layui-table" style="border: 1px solid #eee;">
													<thead>
														<tr>
															<th width="40%">文件名</th>
															<th width="20%">状态</th>
															<th width="40%">操作</th>
														</tr>
													</thead>
													<tbody id="risk-view-fileList"></tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								
						</div>
					 
					</div>
				</div>
			</div>
		</form>
	<script>
	 $(document).ready(function(){
				getDefaultPhoto();//加载默认图片
				addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}');//加载已有人员标签
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
		 });
		   //联控记录 列表显示
                 function  openDuCheckRecord(personnelid){
                   layui.table.render({
					    elem: '#jointcontrolrecordTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchducheckrecord.do?personnelid="+personnelid,
					    method:'post',
					    toolbar: '#socialrelationstoolbar',
					    cols: [[
					        {field:'id',type:'radio',fixed:'true',width:50,align:"center"},
					        {field:'checktype', title: '检查类型', width:100,align:"center"},
					        {field:'checktime', title: '检查时间', width:110,align:"center"},
					        {field:'checkunit', title: '检查单位', width:150,align:"center"},
					        {field:'checkman', title: '采集人', width:100,align:"center"} ,
					        {field:'checkcontent', title: '内容',align:"center"} ,
					        {field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:70,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
					    });
                 }
	        //现实表现
	        var riskFilesView=[];
		     function openRealityShow(personnelid){
		     		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getDuExtendByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var filesview=$("#risk-view-fileList");
						filesview.html('');
					      var duextend=data.duextend;
					     var actualstate = duextend.actualstate;
                         actualstate=actualstate.replace(/,/g, ";<br />");
                         $("#actualstate").html(actualstate);
                          $("#memo").val(duextend.memo);
					      if(duextend.attachments!=""){
								riskFilesView=duextend.attachments.split(",");
								if(riskFilesView.length>0){
									var viewname=duextend.filesname.split(",");
									$.each(riskFilesView,function(index,item){
										var tr = $(['<tr>', '<td>' + viewname[index] +
											'</td>',
											'<td>上传完成</td>', '<td>',
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
				       }
				});
          }
             	 
	</script>
	</body>
</html>
