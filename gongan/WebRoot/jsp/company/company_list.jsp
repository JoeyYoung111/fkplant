<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
		
	<title>易制毒化学品单位列表</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
</head>

<body>
<blockquote class="layui-elem-quote news_search">
	<div class="demoTable">
		<form class="layui-form" method="post" style="display:inline;" id="form1" action="<c:url value='/exportYzdCompany.do'/>">
			<input type="hidden" name="currentpage" id="currentpage"/>
			<input type="hidden" name="pagesize" id="pagesize"/>
			<input type="hidden" name="companytype" id="companytype" value='974'/>
			<div class="layui-inline">
				<input type="text" class="layui-input" style="width:187px;" name="companyname" id="companyname" placeholder="单位名称"/>
			</div>
			<div class="layui-inline">
				<input type="text" class="layui-input" style="width:187px;" name="companycode" id="companycode" placeholder="社会统一征信代码"/>
			</div>
			<div class="layui-inline">
				<input type="text" class="layui-input" style="width:187px;" name="managetype" id="managetype" placeholder="涉及品种"/>
			</div>
			<div class="layui-inline">
				<input type="text" class="layui-input" style="width:187px;" name="telephone" id="telephone" placeholder="联系电话"/>
			</div>
			<br/>
			<div class="layui-inline" style="width:187px;">
				<select name="companystatus" id="companystatus">
					<option value="">企业状态:全部</option>
					<option value="正常">正常</option>
					<option value="停用">停用</option>
				</select>
			</div>
			<div class="layui-inline" style="width:187px;">
				<select name="affecttype" id="affecttype"></select>
			</div>
			<div class="layui-inline" style="width:187px;">
				<select name="innet" id="innet">
					<option value="0">是否入网</option>
					<option value="1">是</option>
					<option value="2">否</option>
				</select>
			</div>
			<div class="layui-inline" style="width:187px;">
				<input type="text" class="layui-input" name="realworkowner" id="realworkowner" lay-filter="realworkowner" lay-reqtext="选择辖区">
			</div>
		</form>		
			
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
		<script type="text/html" id="toolbarDemo">
	 		<c:if test='${fn:contains(param.buttons,"新增")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"修改")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"删除")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"导入")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
			</c:if>
			<c:if test='${fn:contains(param.buttons,"导出")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button>
			</c:if>
		</script>
	
	</div>
</blockquote>

<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-xs" lay-event="showinfo">详情</a>
</script>


<script type="text/javascript">

	var locat = (window.location+'').split("/");
	$(function(){if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};});
	layui.config({
	    base: "<c:url value="/layui/lay/modules/"/>"
	}).extend({
	    treeSelect: "treeSelect"
	});

	function getAffectType(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+52,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				options = '<option value="">单位类型:全部</option>'+options;
				$("select[name^=affecttype]").html(options);
			}
		});
	}
	
	$(document).ready(function(){
		getAffectType();
	});
	
	layui.use(['table','form','treeSelect'],function(){
		var table = layui.table;
		var form = layui.form;
		var tempid = "${param.menuid }";
		tempid = tempid.substring(tempid.indexOf("=")+1);
		treeSelect = layui.treeSelect;
		form.render();
		var rw = treeSelect.render({
			elem:	'#realworkowner',	//选择器
			data:	'<c:url value="/getDepartmentTree.do"/>',
			type:	'get',	//异步加载
			placeholder:	'所属辖区:全部',
			search:	false,
			style:	{
				folder:	{enable: false},
				line:	{enable: true}
			},
			click: function(d){
			},
			success: function(d){
				var treeobj = treeSelect.zTree('realworkowner');
				var newNode = {name:"所属辖区:全部",id:""};
				treeobj.addNodes(null,0,newNode);
				treeSelect.refresh('realworkowner');
				rw.hideIcon();
				form.render();
			}
		});
		
		//方法级渲染
		table.render({
			elem:'#followTable',
			toolbar: true,
			defaultToolbar: ['filter', 'exports', 'print'],
			url:'<c:url value="/searchCompany.do"/>',
			method:'post',
			toolbar: '#toolbarDemo',
			cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'id',type:'radio',fixed:'left'},
		        {field:'companyname', title:'单位名称', width:200, sort:true,align:"center",
		        	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoCompany("+item.id+");'><font color='blue'>"+item.companyname+"</font></span>";}},
		        {field:'companycode', title:'社会统一征信代码', width:150, align:"center",	
		        	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoCompany("+item.id+");'><font color='blue'>"+item.companycode+"</font></span>";}},
		        {field:'affecttype', title:'单位类型', width: 160, align:"center"},
		        {field:'innet', title:'是否入网', width: 100, align:"center",
		        	templet: function(d){
		        		if(d.innet == 1){
		        			return '<span>是</span>';
		        		}
		        		if(d.innet == 2){
		        			return '<span>否</span>';
		        		}
		        		if(d.innet == 0){
		        			return '<span>未登记</span>';
		        		}
		        	}
		        },
		        {field:'telephone', title:'联系电话', width: 120, align:"center"},
		        {field:'companystatus', title:'企业状态', width: 100 , align:"center",
		        	templet: function(d){
		        		if(d.companystatus == '停用'){
		        			return '<span style="color:red">停用</span>';
		        		}else{
		        			return '<span>正常</span>';
		        		}
		        	}
		        },
		        {field:'unusedreason', title:'停用原因', width: 100, align:"center"},
		        {field:'realworkplace',title:'实际办公地详址', align:"center"},
		        {field:'realworkownerString',title:'所属辖区',width:200, align:"center"},
		        {field:'addoperator', title: '建档人', width:90} ,
                {field:'addtime', title: '建档时间', width:170}
			]],
	        page:true,
			limit:10
		});
		
		//搜索查询
		$("#search").click(function (){
			table.reload('followTable',{
				where:{
					companyname: $("#companyname").val(),
					companycode: $("#companycode").val(),
					companytype: $("#companytype").val(),
					managetype:	$("#managetype").val(),
					telephone:	$("#telephone").val(),
					companystatus: $("#companystatus").val(),
					affecttype:	$("#affecttype option:selected").val(),
					innet: $("#innet option:selected").val(),
					realworkowner: $("#realworkowner").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		//toolbar 监听头部工具条事件 followTable是lay-filter属性值
		table.on('toolbar(followTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);//选中行
			
			switch(obj.event){
				case 'add':
					var index = layui.layer.open({
						title : "添加易制毒化学品单位",
						type : 2, //0(信息框默认)1(页面层)2(iframe层)3(加载层)4(tips层)
						content : locat+"/jsp/company/custom/add.jsp?menuid="+tempid+"&companytype="+$("#companytype").val()+"&companytypename=易制毒化学品单位",
						area : ['800', '700px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500)
						}
					})
					layui.layer.full(index); //最小化
				break;
					
				case 'update':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);//深拷贝
					if(datas!=""){
						var id = datas[0].id;
						var comName = datas[0].companyname;
						var index = layui.layer.open({
							title:	"修改单位信息----"+comName,
							type:	2,
							content:locat+'/getCompanyById.do?id='+id+"&page=update&menuid="+tempid,
							area:	['800', '700px'],
							maxmin:	true,
							success:function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500)
							}
						})
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancel':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelCompany.do?id="+id+"&companytype="+$("#companytype").val()+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									$("#search").click();
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'import':
				   var index = layui.layer.open({
						 title : "导入易制毒化学品单位信息",
						 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						 content : "<c:url value="/jsp/company/company_import.jsp?menuid=${param.menuid }"/>"+"&companytype="+$("#companytype").val(),
						  area: ['600', '650'],
						 maxmin: true,
						 offset:['30'], 
						 btn:['导入','关闭'],
						 yes:function(index,layero){   //通过回调得到iframe的值
						  var body = layer.getChildFrame('body',index);//建立父子联系
					                 var iframeWin = window[layero.find('iframe')[0]['name']];              
					                 body.find("#btns").click();
						 },
						end: function () {
							$("#search").click(); 
						}
					 });	
				    break;
				case 'export':
					document.getElementById("form1").submit();
					break;
			};
			
		});
		
		//tool 是固定的工具条件名
		/*table.on('tool(followTable)',function(obj){
			var id = obj.data.id;
			var companyname = obj.data.companyname;
			if(obj.event == 'showinfo'){
				var index = layui.layer.open({
					title : "详情信息----"+companyname,
					type : 2,
					content : locat+'/getCompanyById.do?id='+id+"&page=showinfo&menuid="+tempid,
					area : ['800','800px'],
					maxmin : true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})
				layui.layer.full(index);
			}
		});*/
		
	});
	
	function showInfoCompany(id){
		var index = layui.layer.open({
			title	:"易制毒化学品单位-详情",
			type	:2,
			content	:locat+'/getCompanyById.do?id='+id+"&page=showinfo&menuid="+${param.menuid},
			area	:['800', '700px'],
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
	
	

</script>
	
</body>
</html>
