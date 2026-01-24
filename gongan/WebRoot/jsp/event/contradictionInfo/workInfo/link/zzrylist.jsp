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
    <title>主要组织人员</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
 <body>
<div class="layui-inline">
	<input type="text" name="cardnumber" id="cardnumber" autocomplete="off" placeholder=" 请输入身份证号：" class="layui-input">
</div>
<button class="layui-btn" id="addConnect"><i class="layui-icon">&#xe64c;</i>新增关联</button>
<button class="layui-btn" id="cancelConnect"><i class="layui-icon">&#xe64d;</i>删除关联</button>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
layui.use(['table'], function(){
	var layer = layui.layer,
	table = layui.table;
	
	//初始化主要组织人员
	table.render({
		elem: '#followTable',
		url:'<c:url value="searchKeypersonnel.do"/>',
		where:{cdtid:${param.cdtid },workinfoid:${param.workinfoid }},
	    toolbar: false,
	    defaultToolbar: [],
	    method:'post',
	    cols: [[
	    	{field:'id',type:'radio',fixed:'left'},
	    	{field:'cardnumber', title: '身份证号', width:200,align:"center"},
	    	{field:'personname', title: '姓名', width:200,align:"center"},
	    	{field:'houseplace', title: '户籍地', width:200,align:"center"},
	    	{field:'homeplace', title: '现住地',align:"center"}
	    ]],
	    page: true,
	    limit: 10
	});
	
	$("#addConnect").click(function () {
		var Validator = new IDValidator();
		if(!Validator.isValid($('#cardnumber').val())){
			layer.alert("身份证号不合法，请重新输入！");
		}else{
			//新增关联
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/addKeypersonnel.do"/>',
				data:		{cardnumber:$('#cardnumber').val(),cdtid:${param.cdtid},menuid:${param.menuid},workinfoid:${param.workinfoid }},
				dataType:	'json',
				success:	function(data){
           			var obj = eval('(' + data + ')');
                  	if(obj.flag>0){
                  	    //弹出loading
 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                     	setTimeout(function(){         
                     		top.layer.msg(obj.msg);
                     		top.layer.close(index);
	 		        		//刷新
	 		        		formSubmit();
	 		        		if("${param.page}"=="feedback"){
	 		        			parent.parent.formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
	 		        		}
                   		},2000);
                 	}else if(obj.flag==0){
                  	 	//新增涉稳人员
                  	 	var index = layui.layer.open({
							title : "添加涉稳人员",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : '<c:url value="/getWenGradeUpdate.do"/>?page=addinContradiction&menuid=${param.menuid }&workinfoid=${param.workinfoid }&cdtid=${param.cdtid}&conflictdetails=${param.cdtcontent }&cardnumber='+$('#cardnumber').val(),
							area: ['800', '600px'],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							}
						})			
						layui.layer.full(index);
                	}else{
                		layer.msg(obj.msg);
                	}
				}
			});
		}
	});
	
	$("#cancelConnect").click(function () {
		var  checkStatus =table.checkStatus('followTable');
		var data=JSON.stringify(checkStatus.data);
 		var datas=JSON.parse(data);
 		if(datas!=""){
			var id=datas[0].id;
		    layer.confirm('确定删除此信息？', function(index){
		        layer.close(index);
		        $.getJSON('<c:url value="cancelKeypersonnel.do"/>?id='+id+'&menuid='+${param.menuid },{
					},function(data) {
						var obj = eval('(' + data + ')');
                  		if(obj.flag>0){
                  			top.layer.msg("数据删除成功！");
                  			formSubmit();
                  			if("${param.page}"=="feedback"){
	 		        			parent.parent.formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
	 		        		}
                  		}else{
                  			layer.msg("删除失败!");
                  		}
		        	});      
				});
		}else{
			layer.alert("请先选择删除哪条数据！");
		}
	});
 });
	
	function formSubmit(){
		layui.table.reload('followTable', {
			page: {
				curr: 1
				// 重新从第 1 页开始
			},done: function(res, curr, count){
				parent.$('#zzrybutton').text("主要组织人员("+count+")");
				parent.layui.form.render();
			}
		});
	}
</script>
</body>

</html>