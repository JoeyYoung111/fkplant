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
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/font-awesome-4.7.0/css/font-awesome.min.css"/>" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/tagTree.css"/>" />
     <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
	 <link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
      <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/tagtree/tagTree.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
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
			<div class="layui-col-md6" style="border-right: 10px solid #eee">
				<!-- 基本信息 -->
				<div class="showinfo">
				<table width="100%" border="1" cellspacing="0" cellpadding="0">
					<tr height="40" bgcolor="#3598DC">
					  	<td colspan="4"><span class="showinfo_title">单位基本详情</span></td>
					</tr>
					
						<tr>
							<td width="25%"><strong>单位名称：</strong></td>
							<td width="25%">${company.companyname }</td>
							<td width="25%"><strong>社会统一代码：</strong></td>
							<td width="25%">${company.companycode }</td>
						</tr>
						<tr>
							<td width="25%"><strong>单位大类：</strong></td>
							<td width="25%">${companytypename}</td>
							<td width="25%"><strong>单位类型：</strong></td>
							<td width="25%">${company.affecttype}</td>
						</tr>
						<tr>
							<td width="25%"><strong>是否入网：</strong></td>
							<td width="25%">${company.innet==1?"是":"否" }</td>
							<td width="25%"><strong>涉及品种：</strong></td>
							<td width="25%">${managetypeName }</td>
						</tr>
						<tr>
							<td width="25%"><strong>企业状态：</strong></td>
							<td width="25%">${company.companystatus}</td>
							<td width="25%"><strong>停用原因：</strong></td>
							<td width="25%">${company.unusedreason }</td>
						</tr>
						<tr>
							<td width="25%"><strong>经营范围：</strong></td>
							<td width="75%" colspan="3">${company.managerange }</td>
						</tr>
						<tr>
							<td width="25%"><strong>备注：</strong></td>
							<td width="75%" colspan="3">
								<textarea name="memo" id="memo" class="layui-textarea" readonly="true">${company.memo }</textarea>
							</td>
						</tr>
						<tr>
							<td width="25%"><strong>注册地详址：</strong></td>
							<td width="25%">${company.registerplace }</td>
							<td width="25%"><strong>所属辖区派出所：</strong></td>
							<td width="25%">${company.registerownerString }</td>
						</tr>
						<tr>
							<td width="25%"><strong>实际办公地详址：</strong></td>
							<td width="25%">${company.realworkplace }</td>
							<td width="25%"><strong>所属辖区派出所：</strong></td>
							<td width="25%">${company.realworkownerString }</td>
						</tr>
						<tr>
							<td width="25%"><strong>经度：</strong></td>
							<td width="25%">${company.longitude }</td>
							<td width="25%"><strong>纬度：</strong></td>
							<td width="25%">${company.latitude }</td>
						</tr>
						<tr>
							<td width="25%"><strong>经营执照照片：</strong></td>
							<td colspan="3" width="75%">
								<div class="layui-upload" style="margin-top:10px;">
						    		<blockquote>
						    			<div class="layui-upload-list" id="showlist" style="overflow:hodden;height:120px;"></div>
						    		</blockquote>
						    	</div>
							</td>
						</tr>
				</table>
				</div>
				<div style="height:100px;"></div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab"  lay-filter="dev_tab">
					<div style="position: relative;">
						<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
							style="margin: 0 30px;width: auto !important;">
							<div class="swiper-wrapper" style="width:85px;height: 80px;">
								<li class="btn btn_2 layui-this swiper-slide" >法人信息</li>
								<li class="btn btn_3 swiper-slide" onclick="xkz();">许可证信息</li>
								<li class="btn btn_7 swiper-slide" onclick="dwhc();">单位核查记录</li>
								<div class="swiper-slide"></div>
							</div>
						</div>
						<div class="my-swiper-button-next swiper-button-next1"></div>
						<div class="my-swiper-button-prev swiper-button-prev1"></div>
					</div>
				<div class="layui-tab-content">
					<div class="right-child-content layui-tab-item layui-show showinfo">
						<table width="100%" border="1" cellspacing="0" cellpadding="0">
							<tr>
								<td width="25%">姓名：</td>
								<td width="25%">${company.legalname }</td>
								<td width="25%">性别：</td>
								<td width="25%">${company.sexes }</td>
							</tr>
							<tr>
								<td width="25%">身份证号码：</td>
								<td width="25%">${company.cardnumber }</td>
								<td width="25%">民族：</td>
								<td width="25%">${company.nation }</td>
							</tr>
							<tr>
								<td width="25%">文化程度：</td>
								<td width="25%">${company.education }</td>
								<td width="25%">政治面貌：</td>
								<td width="25%">${company.politicalposition }</td>
							</tr>
							<tr>
								<td width="25%">户籍地详址：</td>
								<td width="25%">${company.homeplace }</td>
								<td width="25%">现住地详址：</td>
								<td width="25%">${company.homeplace }</td>
							</tr>
							<tr>
								<td width="25%">联系电话：</td>
								<td width="75%" colspan="3">${company.legalphone }</td>
							</tr>
						</table>
					</div>
					<div class="right-child-content layui-tab-item showinfo">
							<blockquote class="layui-elem-quote news_search">
					<div class="demoTable">
						<form class="layui-form" method="post" style="display:inline;" id="Licenceform" >
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="licenceallowdate" id="licenceallowdate" placeholder="发证日期"/>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="licencevalidityend" id="licencevalidityend" placeholder="结束日期"/>
							</div>
						</form>
						<button class="layui-btn" id="searchlicence" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
					</div>
					</blockquote>
					<table class="layui-hide" id="XKZTable" lay-filter="XKZTable"></table>
					<script type="text/html" id="XKZ">
						<a class="layui-btn layui-btn-xs" lay-event="XKZinfo">详情</a>
					</script>
						</div>
                    <div class="right-child-content layui-tab-item showinfo">
						<blockquote class="layui-elem-quote news_search">
					<div class="demoTable">
						<form class="layui-form" method="post" style="display:inline;" id="checkform" >
						<div class="layui-inline">
							<input type="text" class="layui-input" style="width:187px;" name="checkdate" id="checkdate" placeholder="核查日期"/>
						</div>
						</form>
						<button class="layui-btn" id="searchcheck" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
					</div>
					</blockquote>
					<table class="layui-hide" id="CheckTable" lay-filter="CheckTable"></table>
					<script type="text/html" id="CHECK">
						<a class="layui-btn layui-btn-xs" lay-event="Checkinfo">详情</a>
					</script>
					</div>	
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">
	
var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

var tempid = "${menuid }";
tempid = tempid.substring(tempid.indexOf("=")+1);

function Today(){
	var now = new Date();
	return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
}

function showPic(){
	var fileMap = "${fileName }".split(",");
	var pictureurl = "${pictureurl}"+"/";
	pictureurl = pictureurl.substring(pictureurl.indexOf("upload")-1);
	if("${company.codephoto }" != ""){
		for(var i in fileMap){
			$('#showlist').append('<image class="layui-upload-img" style="height:100px;width:100px;" src="'+pictureurl+fileMap[i]+'" /><span>&nbsp;&nbsp;</span>');
		}
	}else{
		$("#showlist").text("无图片");
	}
}

$(document).ready(function(){
	showPic();
	var viewer = new Viewer(document.getElementById("showlist"),{
		url:	'data-original',
		navbar:	false
	});
});


function xkz(){
	layui.use(['element','table','laydate'],function(){
		var element = layui.element;
		var table = layui.table;
		var laydate = layui.laydate;
		
		laydate.render({
			elem:	'#licenceallowdate',
			trigger:'click'
		});
		
		laydate.render({
			elem:	'#licencevalidityend',
			trigger:'click'
		});
		
		table.render({
			elem:'#XKZTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchLicence.do"/>?companyid=${id}',
			method:'post',
			cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'zizeng',type:'numbers',fixed:'left'},
		        {field:'basicName',title:'证件类型',width:200,align:"center"},
		        {field:'licenceno',title:'证书编号',width:200,align:"center",
		        	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoXKZ("+item.id+");'><font color='blue'>"+item.licenceno+"</font></span>";}},
		        {field:'chargeperson',title:'负责人',width:120,align:"center"},
		        {field:'allowrange',title:'许可范围',align:"center"},
		        {field:'validitystart',title:'有效期开始',width:130,align:"center"},
		        {field:'validityend',title:'有效期结束',width:130,align:"center"},
		        {field:'allowunit',title:'发证机关',width:130,align:"center"},
		        {field:'addoperator',title:'添加人',width:130,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//		        ,{field:'right',title:'操作',toolbar:'#XKZ',width:80,align:"center"}
		      ]],
		      page:true,
		      limit:10
		});
		/*
		table.on('tool(XKZTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'XKZinfo'){
				var index = layui.layer.open({
					title:	'详情信息',
					type:	2,
					content:locat+'/getLicenceById.do?id='+id+"&page=showinfo&menuid="+tempid,
					area:	['800','700px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		$("#searchlicence").click(function (){
			table.reload('XKZTable',{
				where:{
					allowdate: $("#licenceallowdate").val(),
					validityend: $("#licencevalidityend").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
	});
}

function hxp(){
	layui.use(['table','element'],function(){
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#ChemicalTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchChemical.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarChemical',
			cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'id',type:'radio',fixed:'left'},
		        {field:'realName',title:'化学品名称',width:250,align:"center",
		        	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoChemical("+item.id+");'><font color='blue'>"+item.realName+"</font></span>";}},
		        {field:'purpose',title:'用途',width:200,align:"center"},
		        {field:'belongtypemsg',title:'所属种类',width:200,align:"center"},
		        {field:'chemicaltype',title:'化学品类别',width:220,align:"center"},
		        {field:'packingtype',title:'包装',width:250,align:"center"},
		        {field:'addoperator',title:'添加人',width:180,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//		        ,{field:'right',title:'操作',toolbar:'#CHEMIC',width:150,align:"center"}
		      ]],
		      page:true,
		      limit:10
		});
		/*
		table.on('tool(ChemicalTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Chemicalinfo'){
				var index = layui.layer.open({
					title:	'详情信息',
					type:	2,
					content:locat+'/getChemicalById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:	['800','700px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		$("#searchChemical").click(function (){
			table.reload('ChemicalTable',{
				where:{
					belongtype: $("#chemicalbelongtype option:selected").val(),
					chemicalname: $("#chemicalname").val(),
					purpose: $("#chemicalpurpose option:selected").val(),
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
	});
}

function bzry(){
	layui.use(['table','element'],function(){
		var table = layui.table;
		var element = layui.element;
		
		table.render({
			elem:'#MessengerTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchMessenger.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarMessenger',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'personname',title:'姓名',width:100,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoMessenger("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";}},
			    {field:'cardnumber',title:'身份证号码',width:200,align:"center",
					templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoMessenger("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";}},
			    {field:'sexes',title:'性别',width:65,align:"center"},
			    {field:'telephone',title:'联系电话',width:200,align:"center"},
			    {field:'nation',title:'民族',width:120,align:"center"},
			    {field:'education',title:'文化程度',width:120,align:"center"},
			    {field:'lifeplace',title:'现居住地',align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:'#MES',width:80,align:"center"}
			]],
			page:true,
			limit:10
		});
		/*
		table.on('tool(MessengerTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Messengerinfo'){
				var index = layui.layer.open({
					title:	'详情信息',
					type:	2,
					content:locat+'/getMessengerById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:	['800','700px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
								tips: 3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		$("#searchMessenger").click(function (){
			table.reload('MessengerTable',{
				where:{
					personname: $("#Mepersonname").val(),
					sexes: $("#Mesexes option:selected").val(),
					cardnumber: $("#Mecardnumber").val(),
					telephone: $("#Metelephone").val(),
					education: $("#Meducation option:selected").val(),
					nation: $("#Mnation option:selected").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
	});
}

function cyry(){
	layui.use(['table','element'],function(){
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#ChemistryTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchChemistry.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarChemistry',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'personname',title:'姓名',width:100,align:"center"},
			    {field:'cardnumber',title:'身份证号码',width:200,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoChemistry("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";}},
			    {field:'sexes',title:'性别',width:65,align:"center",
				    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoChemistry("+item.id+");'><font color='blue'>"+item.sexes+"</font></span>";}},
			    {field:'telephone',title:'联系电话',width:160,align:"center"},
			    {field:'nation',title:'民族',width:120,align:"center"},
			    {field:'education',title:'文化程度',width:120,align:"center"},
			    {field:'politicalposition',title:'政治面貌',width:120,align:"center"},
			    {field:'station',title:'岗位',width:100,align:"center"},
			    {field:'lifeplace',title:'现住地详址',align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:"#CHEMIS",width:80,align:"center"}
			]],
			page:true,
			limit:10
		});
		/*
		table.on('tool(ChemistryTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Chemistryinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getChemistryById.do?id='+id+"&page=showinfo&menuid="+tempid,
					area:		['800','700px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		$("#searchChemistry").click(function (){
			table.reload('ChemistryTable',{
				where:{
					personname: $("#Chpersonname").val(),
					sexes: $("#Chsexes option:selected").val(),
					cardnumber: $("#Chcardnumber").val(),
					telephone: $("#Chtelephone").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
	});
}

function sb(){
	layui.use(['table','element'],function(){
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#EquipmentTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchEquipment.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarEquipment',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'emsg',title:'设备名称',width:200,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoEquipment("+item.id+");'><font color='blue'>"+item.emsg+"</font></span>";}},
			    {field:'equipmentbrand',title:'品牌',width:150,align:"center"},
			    {field:'equipmenttype',title:'型号',width:120,align:"center"},
			    {field:'equipmentpower',title:'功率',width:120,align:"center"},
			    {field:'buydate',title:'购买日期',width:130,align:"center"},
			    {field:'useyear',title:'使用年限',width:120,align:"center"},
			    {field:'usestatus',title:'使用情况',align:"center"},
			    {field:'usestate',title:'使用状态',width:120,align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:"#EQUIP",width:70,align:"center"}
			]],
			page:true,
			limit:10
		});
		/*
		table.on('tool(EquipmentTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Equipmentinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getEquipmentById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:		['800','700px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		$("#searchEquipment").click(function (){
			table.reload('EquipmentTable',{
				where:{
					usestatus: $("#usestatus option:selected").val(),
					usestate: $("#usestate option:selected").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
	});
}

function cl(){
	layui.use(['table','element'],function(){
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#VehicleTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchVehicle.do"/>?companyid=${id}',
			method:'post',
			toolbar: '#toolbarVehicle',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'vehiclecategoryMsg',title:'车辆大类',width:120,align:"center"},
			    {field:'vehicleno',title:'车辆牌照',width:120,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoVehicle("+item.id+");'><font color='blue'>"+item.vehicleno+"</font></span>";}},
			    {field:'vehiclebrand',title:'品牌型号',width:120,align:"center"},
			    {field:'vehiclecolor',title:'车辆颜色',width:120,align:"center"},
			    {field:'vehicletype',title:'车辆类型',width:100,align:"center"},
			    {field:'transportNo',title:'道路运输编号',width:150,align:"center"},
			    {field:'engineno',title:'车辆识别代码',width:150,align:"center"},
			    {field:'relatedtypeMsg',title:'涉及品种',align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:"#Veh",width:80,align:"center"}
			]],
			page:true,
			limit:10
		});
		/*
		table.on('tool(VehicleTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Vehicleinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getVehicleById.do?id='+id+"&page=showinfo&menuid="+tempid,
					area:		['800','700px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		$("#searchVehicle").click(function (){
			table.reload('VehicleTable',{
				where:{
					vehicleno: $("#vehicleno").val(),
					vehiclecolor: $("#vehiclecolor").val(),
					transportNo: $("#transportNo").val(),
					vehicletype: $("#vehicletype").val(),
					engineno: $("#engineno").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
	});
}

function dwhc(){
	layui.use(['table','laydate','element'],function(){
		var table = layui.table;
		var laydate = layui.laydate;
		var element = layui.element;
	
		table.render({
			elem:'#CheckTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchCheck.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarCheck',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'checkdate',title:'核查日期',width:200,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoCheck("+item.id+");'><font color='blue'>"+item.checkdate+"</font></span>";}},
			    {field:'filenames',title:'附件',width:800,align:"center",
			    	templet: function(d){
			    		var content="";
			    		if(d.filenames!=null){
			    			var filenames = d.filenames.split(",");
				    		var fileids = d.fileids.split(",");
				    		if(filenames.length>0){
				    			content+='<div class="layui-input-inline"><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>&nbsp;&nbsp;&nbsp;';
				    		}
				    		for(var i=1;i<filenames.length;i++){
				    			content+='<div class="layui-input-inline"><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>&nbsp;&nbsp;&nbsp;'
				    		}
			    		}
			    		return content;
			    	}
			    },
			    {field:'addoperator',title:'添加人',width:180,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:"#CHECK",width:150,align:"center"}
			]],
			page:true,
			limit:10
		});
		/*	
		table.on('tool(CheckTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Checkinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getCheckById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:		['800','700px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});
		*/
		laydate.render({
			elem:	'#checkdate',
			trigger:'click'
		});
		
		$("#searchCheck").click(function (){
			table.reload('CheckTable',{
				where:{
					checkdate: $("#checkdate").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
	});
}


layui.use(['element','table','laydate'],function(){
	var element = layui.element;
	var table = layui.table;
	var laydate = layui.laydate;
	
});

function showInfoXKZ(id){
	var index = layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getLicenceById.do?id='+id+"&page=showinfo&affecttype=${company.affecttype }&menuid="+${menuid},
		area	:['800', '650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoChemical(id){
	var index =layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getChemicalById.do?id='+id+"&page=showinfo&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoMessenger(id){
	var index =layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getMessengerById.do?id='+id+"&page=showinfo&companyname=${company.companyname }&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoChemistry(id){
	var index =layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getChemistryById.do?id='+id+"&page=showinfo&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoEquipment(id){
	var index = layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getEquipmentById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoVehicle(id){
	var index = layui.layer.open({
		title	:'详情信息',
		type	:2,
		content	:locat+'/getVehicleById.do?id='+id+"&page=showinfo&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:	3
				});
			},500);
		}
	});
	layui.layer.full(index);
}

function showInfoCheck(id){
	var index = layui.layer.open({
		title	:'详情信息',
		type	:2,
		content	:locat+'/getCheckById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:	3
				});
			},500);
		}
	});
	layui.layer.full(index);
}

</script>		
		
	</body>
</html>
