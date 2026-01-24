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
    <title>矛盾风险信息</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<form class="layui-form" onsubmit="return false;">
		<div class="layui-inline" >
			<input class="layui-input" type="text" name="cdtname" id="cdtname" autocomplete="off" placeholder=" 标题关键词：">
		</div>
		<div class="layui-inline" style="display:none;">
			<div id="rkdept" name="rkdept"  style="width:400px;"></div>
		</div>
		<div class="layui-inline" >
			<div id="cdttype" name="cdttype"  style="width:400px;"></div>
		</div>
		<div class="layui-inline">
			<div id="zbdept" name="zbdept" style="width:420px;"></div>
		</div>
		<div class="layui-inline">
			<select name="isshield" id="isshield"  style="width:200px;">
				<option value="-1">是否显示全部：</option>
		        <option value="-1">是</option>
		        <option value="0" selected>否</option>
		    </select>
		</div>
		<br>
		<div class="layui-inline">
			<input class="layui-input" type="text" name="cdtcontent" id="cdtcontent" autocomplete="off" placeholder=" 内容关键词：">
		</div>
		<div class="layui-inline">
			<select name="cdtresult" id="cdtresult"  style="width:200px;">
		        <option value="">处置结果：</option>
		        <option value="已钝化">已钝化</option>
		        <option value="已化解">已化解</option>
		        <option value="处置中">处置中</option>
		    </select>
		</div>
		<div class="layui-inline" >
			<select name="cdtlevel" id="cdtlevel" lay-verify="required" style="width:200px;">
		        <option value="">风险等级：</option>
		    </select>
		</div>
		<div class="layui-inline" style="width:200px;">     
			<input class="layui-input" id="startTime" placeholder="入库时间(开始)："  autocomplete="off" readonly="readonly">     
		</div>
		至
		<div class="layui-inline" style="width:200px;">
			<input class="layui-input" id="endTime" placeholder="入库时间(结束)：" autocomplete="off"  readonly="readonly">
		</div>
		<div class="layui-inline" style="width:200px;">     
			<input class="layui-input" id="updatestartTime" placeholder="更新时间(开始)："  autocomplete="off" readonly="readonly">     
		</div>
		至
		<div class="layui-inline" style="width:200px;">
			<input class="layui-input" id="updateendTime" placeholder="更新时间(结束)：" autocomplete="off"  readonly="readonly">
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<script type="text/html" id="toolbarDemo">
			<c:if test='${fn:contains(param.buttons,"新增")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"修改")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
			</c:if>
		    <c:if test='${fn:contains(param.buttons,"删除")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="canel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
			</c:if>
<%--			<button type="button" class="layui-btn layui-btn-sm" lay-event="timeaxis"><i class="layui-icon layui-icon-time"></i>时 间 轴</button>--%>
            <c:if test='${fn:contains(param.buttons,"屏蔽")}'>
			   <button type="button" class="layui-btn layui-btn-sm" lay-event="block"><i class="layui-icon layui-icon-rate-half"></i>屏 蔽</button>
	       </c:if>
			<c:if test='${fn:contains(param.buttons,"打印")}'>
		   		<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="dy">&#xe66d; 打印</button>
			</c:if>
   		</script>
   		<script type="text/html" id="barButton">
           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
		</script>
</form>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
var sortfield="",sortdiv="",sortsql="";
	layui.config({
	    base: "<c:url value="/layui/lay/modules/"/>"
	}).extend({
	    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
	});
layui.use(['table','form','zTreeSelectM','laydate'], function(){
	var table = layui.table,
	laydate = layui.laydate,
	zTreeSelectM = layui.zTreeSelectM,
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
	 
	 var updatestartTime=laydate.render({
		elem:'#updatestartTime',
		done: function(value, date){
			updateendTime.config.min={           
				year:date.year,
				month:date.month-1,//关键
                date:date.date
         	};
    	}  
	});
	 var updateendTime=laydate.render({
	   elem:'#updateendTime',
	  done: function(value, date){
	       updatestartTime.config.max={           
	          year:date.year,
	          month:date.month-1,//关键
	                date:date.date
	         };
	    }
	 });
  
	//初始化风险类别
	var _zTreeSelectM = zTreeSelectM({
	    elem: '#cdttype',//元素容器【必填】          
	    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=39',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 5,//最多选中个数，默认5            
	    name: 'cdttype',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符           
	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
	    tips: '风险类别：',
	    zTreeSetting: { //zTree设置
	        check: {
	            enable: true,
	            chkboxType: { "Y": "", "N": "" }
	        },
	        data: {
	            simpleData: {
	                enable: false
	            },
	            key: {
	                name: 'name',
	                children: 'children'
	            }
	        }
	    }
	});
	
	//初始化风险等级
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=93',
		dataType:	'json',
		success:	function(data){
         			$.each(data, function(num, item) {
         				$('#cdtlevel').append('<option value="' + item.name + '">' + item.name + '</option>');
        			});
    				form.render("select");
		}
	});
	
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getDepartmentTree.do"/>',
		dataType:	'json',
		success:	function(data){
			//初始化入库单位
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#rkdept',//元素容器【必填】          
			    data: data,
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'rkdept',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
			    tips: '入库单位：',
			    zTreeSetting: { //zTree设置
			        check: {
			            enable: true,
			            chkboxType: { "Y": "", "N": "" }
			        },
			        data: {
			            simpleData: {
			                enable: false
			            },
			            key: {
			                name: 'name',
			                children: 'children'
			            }
			        }
			    }
			});
			
			//初始化主办部门
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#zbdept',//元素容器【必填】          
			    data: data,
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'zbdept',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
			    tips: '主管部门：',
			    zTreeSetting: { //zTree设置
			        check: {
			            enable: true,
			            chkboxType: { "Y": "", "N": "" }
			        },
			        data: {
			            simpleData: {
			                enable: false
			            },
			            key: {
			                name: 'name',
			                children: 'children'
			            }
			        }
			    }
			});
		}
	});
  var buttons = "${param.buttons }";
  var type = "${param.type }";
  if(buttons.indexOf("屏蔽")>-1){
	  //方法级渲染
	  table.render({
	    elem: '#followTable',
	    toolbar: true,
	    defaultToolbar: ['filter', 'exports', 'print'],
	    url: '<c:url value="/searchContradictionInfo.do"/>',
	    where: {type:type},
	    method:'post',
	    toolbar: '#toolbarDemo',
	    autoSort: false,
	    cols: [[
	    	{field:'id',type:'radio',fixed:'left'},
	    	{field:'cdtname', title: '风险名称',width:330,align:"center",templet: function(d){
	    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;);return false;'>"+d.cdtname+"</a>";
	    	}},
	    	{field:'cdtlevel', title: '风险等级', width:90,align:"center"},
	    	{field:'typename', title: '风险类别', width:200,align:"center"},
	    	{field:'cdtresult', title: '处置结果', width:90,align:"center",templet: function(item){
	    		if(item.cdtresult=="已化解"){
	    			return "<span style='color: green;'>已化解</span>";
	    		}else{
	    			return item.cdtresult;
	    		}
	    	}},
	    	{field:'ssrs', title: '涉事人数', width:100,align:"center"},
	    	{field:'nowstate', title: '审核状态', width:150,align:"center",templet:
	    		function(item){
	    			if(item.nowstate==1){
	    				return "<span style='color: red;'>新申请（未审核）</span>";
	    			}else if(item.nowstate==2){
	    				return "<span style='color: green;cursor:pointer' onclick='showFeedback(&quot;"+item.id+"&quot;);'>已审核（通过）</span>";
	    			}else if(item.nowstate==3){
	    				return "<span style='color: blue;cursor:pointer' onclick='showFeedback(&quot;"+item.id+"&quot;);'>已审核（不通过）</span>";
	    			}
	    		}},
	    	{field:'sponsorname', title: '主管部门', width:150,align:"center"},
	    	{field:'addtime', title: '入库时间', width:170,align:"center"},
	    	{field:'updatetime', title: '更新时间', width:170,align:"center"},
	    	{field:'cdtcode', title: '事件编码', width:180,align:"center"},
	    	{field:'isshield', title: '是否屏蔽',align:"center",templet:
	    		function(item){
	    			if(item.isshield==0){
	    				return "否";
	    			}else if(item.isshield==1){
	    				return "是";
	    			}
	    		}}
	    ]],
	    page: true,
	    limit: 10,
	    done: function(){
	    	if(sortfield!=""&&sortdiv!=""){
	    		$("#followTable").next().find("table>thead>tr>th[data-field="+sortfield+"]").find("div").append(sortdiv);
	    	}
	    	$("#followTable").next().find("table>thead>tr>th").css("cursor","pointer");
	    	$("#followTable").next().find("table>thead>tr>th").click(function () {
		 			var field=$(this).attr("data-field");
		 			if(field!=0&&field!=sortfield&&field!="right"){
			  			sortfield=field;
			  			if(sortdiv!="")sortdiv.remove();
			  			sortdiv=$('<span class="layui-table-sort layui-inline" lay-sort="asc"><i class="layui-edge layui-table-sort-asc" title="升序"></i><i class="layui-edge layui-table-sort-desc" title="降序"></i></span>');
			  			$(this).find("div").append(sortdiv);
			  			$(this).click();
		 			}
			});
	    }
	  });
  }else{
  	  //方法级渲染
	  table.render({
	    elem: '#followTable',
	    toolbar: true,
	    defaultToolbar: ['filter', 'exports', 'print'],
	    url: '<c:url value="/searchContradictionInfo.do"/>',
	    where: {type:type},
	    method:'post',
	    toolbar: '#toolbarDemo',
	    autoSort: false,
	    cols: [[
	    	{field:'id',type:'radio',fixed:'left'},
	    	{field:'cdtname', title: '风险名称',align:"center",templet: function(d){
	    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;);return false;'>"+d.cdtname+"</a>";
	    	}},
	    	{field:'cdtlevel', title: '风险等级', width:90,align:"center"},
	    	{field:'typename', title: '风险类别', width:200,align:"center"},
	    	{field:'cdtresult', title: '处置结果', width:90,align:"center"},
	    	{field:'ssrs', title: '涉事人数', width:100,align:"center"},
	    	{field:'sjje', title: '涉事金额', width:90,align:"center"},
	    	
	    	{field:'nowstate', title: '审核状态', width:150,align:"center",templet:
	    		function(item){
	    			if(item.nowstate==1){
	    				return "<span style='color: red;'>新申请（未审核）</span>";
	    			}else if(item.nowstate==2){
	    				return "<span style='color: green;cursor:pointer' onclick='showFeedback(&quot;"+item.id+"&quot;);'>已审核（通过）</span>";
	    			}else if(item.nowstate==3){
	    				return "<span style='color: blue;cursor:pointer' onclick='showFeedback(&quot;"+item.id+"&quot;);'>已审核（不通过）</span>";
	    			}
	    		}},
	    	{field:'rkdept', title: '入库单位', width:150,align:"center"},
	    	{field:'addtime', title: '入库时间', width:200,align:"center"}
	    ]],
	    page: true,
	    limit: 10,
	    done: function(){
	    	if(sortfield!=""&&sortdiv!=""){
	    		$("#followTable").next().find("table>thead>tr>th[data-field="+sortfield+"]").find("div").append(sortdiv);
	    	}
	    	$("#followTable").next().find("table>thead>tr>th").css("cursor","pointer");
	    	$("#followTable").next().find("table>thead>tr>th").click(function () {
		 			var field=$(this).attr("data-field");
		 			if(field!=0&&field!=sortfield&&field!="right"){
			  			sortfield=field;
			  			if(sortdiv!="")sortdiv.remove();
			  			sortdiv=$('<span class="layui-table-sort layui-inline" lay-sort="asc"><i class="layui-edge layui-table-sort-asc" title="升序"></i><i class="layui-edge layui-table-sort-desc" title="降序"></i></span>');
			  			$(this).find("div").append(sortdiv);
			  			$(this).click();
		 			}
			});
	    }
	  });
  }
  
  	//触发排序事件 
	table.on('sort(followTable)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
	  //console.log(obj.field); //当前排序的字段名
	  //console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
	  //console.log(this); //当前排序的 th 对象
	 	  if(obj.type!=null){
	 	  	if(obj.field!='cdtlevel'){
	 	  		sortsql="ORDER BY "+obj.field+" "+obj.type;
	 	  	}else{
	 	  		sortsql="ORDER BY FIELD(A.cdtlevel,'存档','自控','低风险','中风险','高风险') "+obj.type;
	 	  	}
	 	  }else{
	 	  	if(obj.field!='cdtlevel'){
	 	  		sortsql="ORDER BY "+obj.field+" asc";
	 	  	}else{
	 	  		sortsql="ORDER BY FIELD(A.cdtlevel,'存档','自控','低风险','中风险','高风险') asc";
	 	  	}
	 	  }
	  sortdiv.attr("lay-sort",obj.type!=null?obj.type:"asc");
	  table.reload('followTable', {
	  		initSort: obj,
			where: { // 设定异步数据接口的额外参数，任意设
				cdtlevel: $("#cdtlevel").val(),
				cdttype: $("input[name='cdttype']").val(),			
				zbdept: $("input[name='zbdept']").val(),
				cdtresult: $("#cdtresult").val(),
				isshield: $("#isshield").val(),
				cdtname: $("#cdtname").val(),
				cdtcontent: $("#cdtcontent").val(),
				rkdept: $("input[name='rkdept']").val(),
				startTime: $("#startTime").val(),
				endTime: $("#endTime").val(),
				updatestartTime: $("#updatestartTime").val(),
				updateendTime: $("#updateendTime").val(),
				sortsql:	sortsql
			},
			page: {
				curr: 1
				// 重新从第 1 页开始
			}
		});
	});
    
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'add':
   var index = layui.layer.open({
				title : "添加矛盾风险信息",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/event/contradictionInfo/add.jsp"/>?menuid=${param.menuid }',
				area: ['800', '800px'],
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
    break;
   case 'update':
   var data=JSON.stringify(checkStatus.data);
   var datas=JSON.parse(data);
   var id=datas[0].id;
   //alert( '<c:url value="getContradictionInfo.do"/>?id='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid }+'&page=update');
   var assistdept = ""+datas[0].assistdept;
   var loginUserDepartmentid = "<%=userSession.getLoginUserDepartmentid()%>";
   if("<%=userSession.getLoginRoleEventFilter()%>"==0||(datas[0].sponsor==loginUserDepartmentid||assistdept.indexOf(loginUserDepartmentid)>-1)){
	   if(datas[0].nowstate==1||datas[0].nowstate==3){
	   		if(datas!=""){
		   			var index = layui.layer.open({
						title : "修改矛盾风险信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="getContradictionInfo.do"/>?id='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid }+'&page=update',
						area: ['800', '800px'],
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
			}else{
				layer.alert("请先选择修改哪条数据！");
			}
	   }else if(datas[0].nowstate==2){
	   		var index = layui.layer.open({
				title : "修改矛盾风险信息",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="getContradictionInfo.do"/>?id='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid }+'&page=updateCheck',
				area: ['800', '800px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				},
				cancel : function(index,layero){
					$("#search").click();
				}
			});
			layui.layer.full(index);
	   }
   }else{
   		layer.alert("非入库单位或协助部门，无该事件修改权限！");
   }
    break;
case 'canel':
   var data=JSON.stringify(checkStatus.data);
   var datas=JSON.parse(data);
    if(datas!=""){
   var id=datas[0].id;
    layer.confirm('确定删除此信息？', function(index){
        layer.close(index);
        $.getJSON('<c:url value="cancelContradictionInfo.do"/>?id='+id+'&menuid='+${param.menuid }+'&cdtname='+datas[0].cdtname,{
			},function(data) {
			var str = eval('(' + data + ')');
        	 if (str.flag ==1) {		                          
		     	top.layer.msg("数据删除成功！"); 	
		     	table.reload('followTable', {    
		        });                 
		     }else{
				top.layer.msg("删除失败!");
		      }			      	    		
        	});      
		});
		}else{
			layer.alert("请先选择删除哪条数据！");
		}
    break;
case 'timeaxis':
	var data=JSON.stringify(checkStatus.data);
	var datas=JSON.parse(data);
	if(datas!=""){
		var id=datas[0].id;
		var index = layui.layer.open({
			title : "时间轴",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="searchTimeaxis.do"/>?id='+id,
			area: ['800', '800px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		});
		layui.layer.full(index);
	}else{
		layer.alert("请先选择数据！");
	}
break;
case 'block':
	var data=JSON.stringify(checkStatus.data);
	var datas=JSON.parse(data);
	if(datas!=""){
		var id=datas[0].id;
		if(datas[0].isshield==0){
			layer.confirm('确定屏蔽此信息？', function(index){
				layer.close(index);
				$.getJSON('<c:url value="blockContradictionInfo.do"/>?id='+id+'&menuid=${param.menuid }&isshield=1'+'&cdtname='+datas[0].cdtname,{
					},function(data) {
					var str = eval('(' + data + ')');
		        	 if (str.flag ==1) {		                          
				     	top.layer.msg("数据屏蔽成功！"); 	
				     	table.reload('followTable', {});                 
				     }else{
						top.layer.msg("屏蔽失败!");
				      }
		        	});
			});
		}else{
			layer.confirm('确定解除屏蔽？', function(index){
				layer.close(index);
				$.getJSON('<c:url value="blockContradictionInfo.do"/>?id='+id+'&menuid=${param.menuid }&isshield=0'+'&cdtname='+datas[0].cdtname,{
					},function(data) {
					var str = eval('(' + data + ')');
		        	 if (str.flag ==1) {		                          
				     	top.layer.msg("数据解除屏蔽成功！"); 	
				     	table.reload('followTable', {});                 
				     }else{
						top.layer.msg("解除屏蔽失败!");
				      }
		        	});
			});
		}
	}else{
		layer.alert("请先选择数据！");
	}
break;
case 'dy':
	var data=JSON.stringify(checkStatus.data);
	var datas=JSON.parse(data);
	if(datas!=""){
		var id=datas[0].id;
		window.location.href='<c:url value="/exportContradictionInfo.do"/>?id='+id+'&menuid=${param.menuid }'+'&cdtname='+datas[0].cdtname;
		return false;
	}else{
		layer.alert("请先选择数据！");
	}
break;
   }
   
 });
    
    	//搜索查询
  		$("#search").click(function () {
  			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					cdtlevel: $("#cdtlevel").val(),
					cdttype: $("input[name='cdttype']").val(),			
					zbdept: $("input[name='zbdept']").val(),
					cdtresult: $("#cdtresult").val(),
					isshield: $("#isshield").val(),
					cdtname: $("#cdtname").val(),
					cdtcontent: $("#cdtcontent").val(),
					rkdept: $("input[name='rkdept']").val(),
					startTime: $("#startTime").val(),
					endTime: $("#endTime").val(),
					updatestartTime: $("#updatestartTime").val(),
					updateendTime: $("#updateendTime").val(),
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
 });
		
		function showFeedback(id){
			var index = layui.layer.open({
				title : "审核记录",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/event/contradictionInfo/checkFeedback.jsp"/>?cdtid='+id,
				area: ['800', '750px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});
			layui.layer.full(index);
		}
		
		function showInfo(id){
			var index = layui.layer.open({
				title : "矛盾风险详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="showContradictionInfo.do"/>?id='+id+'&menuid=${param.menuid }',
				area: ['800', '750px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});
			layui.layer.full(index);
		}
</script>
</body>

</html>