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
    <title>治安从业人员</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
 <form class="layui-form" method="post" style="display:inline;">
 	<div class="layui-inline">
    	<input class="layui-input" name="personname" id="personname" autocomplete="off" placeholder="姓名："  style="width:170px;">
 	</div>
     <div class="layui-inline" >
		<input class="layui-input" name="cardnumber" id="cardnumber" style="width:170px;" autocomplete="off" placeholder="身份证号：">
	</div>
	 <div class="layui-inline" >
		<select id="sexes"  name="sexes">
			 		<option value=''>性别：全部</option>
			 		<option value='女'>女</option>
			 		<option value='男'>男</option>
		</select>
	</div>
	<div class="layui-inline" >
 	 <input class="layui-input" name="homepolice" id="homepolice"  autocomplete="off" placeholder="现居住派出所："  style="width:210px;">
	</div>
	<div class="layui-inline" >
 	  <input class="layui-input" name="cytype" id="cytype"   autocomplete="off" placeholder="人员类别：" style="width:210px;">
	</div>
	<br>
	<div class="layui-inline">
    	<input class="layui-input" name="homeplace" id="homeplace" autocomplete="off" placeholder="现居住地：" style="width:170px;">
 	</div>
 	<div class="layui-inline">
    	<input class="layui-input" name="workplace" id="workplace" autocomplete="off" placeholder="工作地："   style="width:170px;">
 	</div>
 	<div class="layui-inline" >
		<select id="nation"  name="nation"></select>
	</div>
 	<div class="layui-inline" >
 	  <input class="layui-input" name="workpolice" id="workpolice"   autocomplete="off" placeholder="工作地派出所：" style="width:210px;">
	</div>
	</form>
<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
  <script type="text/html" id="toolbarButton">
   	  <c:if test='${fn:contains(param.buttons,"新增")}'>
	  	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	  </c:if>
	  <c:if test='${fn:contains(param.buttons,"修改")}'> 
	  	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
      </c:if>
	  <c:if test='${fn:contains(param.buttons,"删除")}'>
   	    <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
      </c:if>
	  <c:if test='${fn:contains(param.buttons,"审核")}'>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="examine"><i class="layui-icon layui-icon-username"></i>调整风险</button>
	  </c:if>
<%--	  <c:if test='${fn:contains(param.buttons,"导入")}'>   --%>
<%--      	<button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>--%>
<%--      </c:if>--%>
<%--	  <c:if test='${fn:contains(param.buttons,"导出")}'>   --%>
<%--	  	<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button>     --%>
<%--      </c:if>--%>
  </script> 
</div>
 </blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
<script type="text/html" id="barButton">
 <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
</script>
<script>
$(document).ready(function(){
	    $.ajax({
			 type:		'POST',
			 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+15, //民族
			 dataType:	'json',
			 async :      false,
			 success:	function(data){					  
			      var options = '<option value="">民族：全部</option>' + fillOption(data);
			      $("select[name^=nation]").html(options);
			   }
		});
});
var locat = (window.location+'').split('/'); 
var now=new Date();
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
       layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treetable: 'treetable-lay/treetable',
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['table','laydate','form','treeSelect'], function(){
			  var table = layui.table;
			  var laydate = layui.laydate;
			  var layer = layui.layer;
			  var form=layui.form;
			  var treeSelect = layui.treeSelect;
			  form.render();
 
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchCyPerson.do"/>',
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'radio',fixed:'true',align:"center"},
        {field:'personname', title: '姓名', width:100,align:"center",templet: function (item) {
        	if(item.ajcount>0||item.jqcount>0){
        		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='red'>"+item.personname+"</font></span>";
        	}else{
        		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font>"+item.personname+"</font></span>";
        	}
        }},
    	{field:'cardnumber', title: '身份证号码', width:200,align:"center"} ,
         {field:'sexes', title: '性别', width:65,align:"center"} , 
        {field:'officeName', title: '年龄', width:60,templet: function (item) {
          		var age=now.getFullYear();
				var cardnumber=item.cardnumber.toString();
				var length=cardnumber.length;
				if(length==15){
					age-=parseInt(cardnumber.substring(6,8))+1900;
					age++;
				}else if(length==18){
					age-=parseInt(cardnumber.substring(6,10));
					age++;
				}else{
				   age=''; 
				}
				return "<span>"+age+"</span>";
           }},
        {field:'cytype', title: '人员类别',width:200,align:"center"} ,
        {field:'homeplace', title: '现居住地详址',align:"center"} ,
		{field:'jurisdictunit', title: '管控单位', width:180,align:"center"},		
		{field:'jurisdictpolice', title: '管控民警', width:120,align:"center"},
		{field:'pphone1', title: '管控民警电话', width:150,align:"center"},
		{field:'addtime', title: '建档时间', width:200,align:"center"} 
    ]],
    page: true,
    limit: 10
    });
    
    	//搜索查询
  		$("#search").click(function () {
			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname").val(),					
					cardnumber:$("#cardnumber").val(),
					sexes:$("#sexes").val(),
					nation:$("#nation").val(),
					homeplace:$("#homeplace").val(),
					workplace:$("#workplace").val(),
					homepolice:$("#homepolice").val(),
					workpolice:$("#workpolice").val(),
					cytype:$("#cytype").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset").click(function () {
		   $('form')[0].reset();
		});
		
		//监听行工具事件
		table.on('toolbar(followTable)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增非风险人员",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/cy/add.jsp?menuid='+${param.menuid}+'"/>',
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
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改从业人员",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getCyPerson.do?id='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid},
							area: ['800', '750px'],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							},
							cancel:function(){
								layui.table.reload('followTable', { }); 
							}
						})			
						layui.layer.full(index);
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var personnelid=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelCyPerson.do?id="+personnelid+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('followTable', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
					case 'import':
				      var index = layui.layer.open({
						 title : "导入涉黑恶人员信息",
						 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						 content : "<c:url value="/jsp/personel/hei/import.jsp?menuid=${param.menuid }"/>",
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
				   	var index = layui.layer.open({
						title : "涉黑恶人员信息导出",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/hei/export.jsp?menuid='+${param.menuid}+'"/>',
						area: ['1000px', '700px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});
				  break;
				  case 'examine':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var personnelid=datas[0].id;
						layer.confirm('确定将此人升级为风险人员？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/updateCyPersonRisk.do?id="+personnelid+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("升级成功！"); 	
							     table.reload('followTable', {});                 
					       	 }else{
								 top.layer.msg("升级失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择调整哪个人员！");
					}
				  break;
	         }
		});
});
 
 function showinfoPersonel(id){
         var index = layui.layer.open({
					title : "从业人员详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getCyPersonelInfo.do?personnelid='+id+'&menuid='+${param.menuid},
					area: ['800', '750px'],
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
 
</script> 
</body>

</html>