<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserSession userSession = (UserSession) session.getAttribute("userSession");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>工作交办信息管理</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  <style>
     /*layui-table 表格内容允许换行*/
     .layui-table-main .layui-table td[data-field="filenames"] div:not(.laytable-cell-radio){
         height: auto;
         overflow:visible;
         text-overflow:inherit;
         white-space:normal;
     }
     .layui-table-fixed .layui-table-body{
      display:none;
     }
   </style>
 <body>
<blockquote class="layui-elem-quote news_search">	
<form class="layui-form" onsubmit="return false;">
             <div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="cdtname" autocomplete="off" placeholder=" 风险名称：">
				</div>
			<div class="layui-inline" style="width:200px;">
			<select name="wtype" id="wtype" lay-verify="required">
		        <option value="0">工作单类别：</option>
		        <option value="1">工作提示单</option>
		        <option value="2">工作交办单</option>
		        <option value="3">工作督办单</option>
		        <option value="4">责任追究建议函</option>
		    </select>
		</div>
		<div class="layui-inline" style="width:200px;">
			<select name="nowstates" id="nowstates">
		        <option value="0">状态：</option>
		        <option value="1">已下发</option>
		        <option value="2">已签收</option>
		        <option value="3">已反馈</option>
		    </select>
		</div>
		<div class="layui-inline" style="width:200px;">     
			<input class="layui-input" id="startTime" placeholder="下发时间(开始)："  autocomplete="off" readonly="readonly">     
		</div>
		至
		<div class="layui-inline" style="width:200px;">
			<input class="layui-input" id="endTime" placeholder="下发时间(结束)：" autocomplete="off"  readonly="readonly">
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<script type="text/html" id="toolbarDemo">
			<c:if test='${fn:contains(param.buttons,"签收")}'>
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="qs">&#xe705; 签收</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"反馈")}'>
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="fk">&#xe681; 反馈</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"打印")}'>
		   		<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="dy">&#xe66d; 打印</button>
			</c:if>
   		</script>
</form>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
layui.use(['table','form','laydate'], function(){
	var table = layui.table,
	laydate = layui.laydate,
	form = layui.form;
	
	var startTime=laydate.render({
		elem:'#startTime',
		done: function(value, date){
			endTime.config.min={           
				year:date.year,
				month:date.month-1,//关键
                date:date.date
         	};
    	}  
	});
	 var endTime=laydate.render({
	   elem:'#endTime',
	  done: function(value, date){
	       startTime.config.max={           
	          year:date.year,
	          month:date.month-1,//关键
	                date:date.date
	         };
	    }
	 });

	//方法级渲染
	table.render({
	    elem: '#followTable',
	    toolbar: true,
	    defaultToolbar: ['filter', 'exports', 'print'],
	    url: '<c:url value="/searchWorkInfo.do"/>',
	    method:'post',
	    toolbar: '#toolbarDemo',
	    cols: [[
	    	{field:'id',type:'radio',fixed:'left'},
	        {field:'cdtname', title: '风险名称', width:200,align:"center",templet:
	        	function(d){
	        		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.cdtname+"</a>";
	        	}
	        },
	    	{field:'wtype', title: '工作单类型', width:150,align:"center",templet:
	    		function(item){
	    			if(item.wtype==1){
	    				return "<span>工作提示单</span>";
	    			}else if(item.wtype==2){
	    				return "<span>工作交办单</span>";
	    			}else if(item.wtype==3){
	    				return "<span>工作督办单</span>";
	    			}else if(item.wtype==4){
	    				return "<span>责任追究建议函</span>";
	    			}
	    		}
	    	},
	    	{field:'wtitle', title: '标题', width:200,align:"center"},
	    	{field:'wcontent', title: '内容', width:200,align:"center"},
	    	{field:'filenames', title: '附件',width:200,align:"center",templet: function(d){
	    		var content="";
	    		if(d.filenames!=null){
	    			var filenames = d.filenames.split(",");
		    		var fileids = d.fileids.split(",");
		    		if(filenames.length>0){
		    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
		    		}
		    		for(var i=1;i<filenames.length;i++){
		    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
		    		}
	    		}
	    		return content;
	    	}},
	    	//{field:'receivedept', title: '接受单位',align:"center"},
	    	{field:'receivername', title: '接收人',align:"center"},
	    	{field:'xfpername', title: '下发人',align:"center"},
	    	//{field:'xfperdep', title: '下发人单位',align:"center"},
	    	//{field:'xftime', title: '下发时间',align:"center"},
	    	{field:'qspername', title: '签收人',align:"center"},
	    	//{field:'qstime', title: '签收时间',align:"center"},
	    	{field:'fkname', title: '反馈人',align:"center"},
	    	//{field:'fktime', title: '反馈时间',align:"center"},
	    	//{field:'fkcontent', title: '反馈内容',align:"center"},
	    	{field:'nowstates', title: '状态', width:90,align:"center",templet:
	    		function(item){
	    			if(item.nowstates==1){
	    				return "<span style='color: red;'>已下发</span>";
	    			}else if(item.nowstates==2){
	    				return "<span style='color: blue;'>已签收</span>";
	    			}else if(item.nowstates==3){
	    				return "<span style='color: green;'>已反馈</span>";
	    			}
	    		}}
	    ]],
	    page: true,
	    limit: 10
	});
    
	//监听行工具事件
	table.on('toolbar(followTable)', function(obj){
		var  checkStatus =table.checkStatus(obj.config.id);
		switch(obj.event){
			case 'qs':
				var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
				if(datas!=""){
					if(<%=userSession.getLoginUserID() %>==datas[0].receiverid){
						if(datas[0].nowstates==1){
							var id=datas[0].id;
							top.layer.confirm('确定签收？', function(index){
					        	layer.close(index);
					        	$.getJSON('<c:url value="signWorkInfo.do"/>?id='+id+'&menuid='+${param.menuid },{},function(data) {
									var str = eval('(' + data + ')');
					        		if (str.flag ==1) {		                          
							    		top.layer.msg("数据签收成功！"); 	
							     		table.reload('followTable', {});
							     	}else{
										top.layer.msg("签收失败!");
							    	}		      	    		
					        	});
							});
						}else{
							top.layer.msg("数据已签收!");
						}
					}else{
						top.layer.alert("只有接收人才可以签收！");
					}
				}else{
					top.layer.alert("请先选择签收哪条数据！");
				}
		    break;
			case 'fk':
		   		var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
				if(datas!=""){
					if(<%=userSession.getLoginUserID() %>==datas[0].receiverid){
						if(datas[0].nowstates!=1){
							var id=datas[0].id;
							var index = layui.layer.open({
								title : "反馈工作交办管理",
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content : '<c:url value="getFeedback.do"/>?menuid=${param.menuid }&page=gzjbsearch&id='+id,
								area: ['800', '800px'],
								maxmin: true,
								success : function(layero, index){
									setTimeout(function(){
										layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
											tips: 3
										});
									},500)
								}
							});
							layui.layer.full(index);
						}else{
							top.layer.alert("请先签收数据！");
						}
					}else{
						top.layer.alert("只有接收人才可以反馈！");
					}
				}else{
					top.layer.alert("请先选择反馈哪条数据！");
				}
		    break;
		    case 'dy':
		    	var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
				if(datas!=""){
					var id=datas[0].id;
					var index = layui.layer.open({
						title : "打印工作交办管理",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="printWorkInfo.do"/>?id='+id,
						area: ['800', '800px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});
					layui.layer.full(index);
				}else{
					top.layer.alert("请先选择打印哪条数据！");
				}
		    break;
		}
	});
    
    	//搜索查询
  		$("#search").click(function () {
  			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					wtype: $("#wtype").val(),
					nowstates: $("#nowstates").val(),
					startTime: $("#startTime").val(),
					endTime: $("#endTime").val(),
					cdtname: $("#cdtname").val()
					
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
 });
 		function showInfo(id,wtypename){
 			var index = layui.layer.open({
				title : wtypename+"详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="showWorkInfo.do"/>?id='+id+'&menuid=${param.menuid }',
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