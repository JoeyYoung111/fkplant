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
    
    <title>添加角色页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="css/system.css" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body style="background-color:#FFFFFF;">
	  <div class="js_add">
	  <form class="layui-form" method="post" id="form1" style="display:inline;">
		  	<div class="layui-inline" style="width:170px;">
			 	<select id="typeid">
			 		<option value='0'>全部类别</option>
			 		<option value='1'>融资企业</option>
			 		<option value='2'>政府</option>
			 		<option value='3'>乡镇</option>
			 		<option value='4'>金融机构</option>
			 		<option value='5'>已上市企业</option>
			 		<option value='6'>新三版企业</option>
			 		<option value='7'>股权交易挂牌企业</option>
			 		<option value='8'>上市企业培训库</option>
			 		<option value='9'>券商</option>
			 	</select>
			</div>
			<div class="layui-inline">
			   <input class="layui-input" name="condition2" id="condition2"  placeholder="人员姓名/账号"  >
			</div>
		  </form>
		  <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		  <table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
	  </div>
	  <div class="fgl"></div>
	  <div class="js_add2">
	  	<ul>
	  		<li id="listNum">已选0人</li>
	  		<li><button onclick="resetList();" style="background-color:#C9C9C9;border-radius:8px; width:40px; text-align:center;line-height:20px;cursor:pointer;">清空</button></li>
	  	</ul>
	  	<div id="ruList">
	  	</div>
	  </div>
  	  <div class="clear"></div>
	  <div class="layui-form-item">
	    <div class="layui-input-block" style="margin:3% auto;width:11%;">
	      <button onclick="ruSub()" class="layui-btn layui-btn-normal">确 认</button>
	    </div>
	  </div>
<script type="text/html" id="barButton">
   <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="select">选 择</a>
</script> 
<script type="text/javascript">


function getRUList(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getRUList.do?roleid=${param.roleid}"/>',
		dataType:	'json',
		async:      false,
		success:	function(data){
			for(i=0;i<data.length;i++){
				data[i].staffName=data[i].userName;
				ruArray[data[i].userid]=data[i];
				var ruStr="";
	      		ruStr+='<div id="ru'+data[i].userid+'">'+
	      				'<div class="js_addname">'+data[i].userName+'</div>'+
					  	'<div class="js_adddel2"></div>'+
					  	'<div class="clear"></div></div>';
	      		$('#ruList').append(ruStr);
	      		$('#listNum').text('已选'+getJsonLength(ruArray)+'人');
			}
		}
	});
}

$(document).ready(function(){
	getRUList();
});
</script>
<script>
	var ruArray={};
	var locat = (window.location+'').split('/'); 
	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
	layui.use(['table','laydate','form'], function(){
	  var table = layui.table;
	  var laydate = layui.laydate;
	  var layer = layui.layer;
	  var form=layui.form;
	  form.render();
	  //方法级渲染
	  table.render({
	    elem: '#followTable',
	    toolbar: false,
	    defaultToolbar: [],
	    url: '<c:url value="/getUser.do"/>',
	    method:'post',
	    cols: [[
	    	{field:'staffName', title: '人员姓名', width:130},
	    	{field:'usercode', title: '账号', width:143,align:'center'},
	        {field: 'typeid', title: '类别', width: 170, sort: true,templet: function (item) {
			         switch(item.typeid){
					case 1:return "<span>融资企业</span>";
					case 2:return "<span>政府</span>";
					case 3:return "<span>乡镇</span>";
					case 4:return "<span>金融机构</span>";
					case 5:return "<span>已上市企业</span>";
					case 6:return "<span>新三版企业</span>";
					case 7:return "<span>股权交易挂牌企业</span>";
					case 8:return "<span>上市企业培训库</span>";
					case 9:return "<span>券商</span>";
					default:return "<span></span>";
				}
			}},
			{field:'dpName', title: '部门名称', width:200},
			{field: 'right', title: '操作', toolbar: '#barButton',width:70} 
	    ]],
	    page: true,
	    limit: 10,
	    });
	    //搜索查询
	  $("#search").click(function () {
				table.reload('followTable', {
					where: { // 设定异步数据接口的额外参数，任意设
						typeid:$("#typeid").val(),
						staffName:$("#condition2").val(),
						usercode:$("#condition2").val(),			
					},
					page: {
						curr: 1
						// 重新从第 1 页开始
					}
				});
			});
			
	   //监听行工具事件
	  table.on('tool(followTable)', function(obj){
	    var id = obj.data.id;
	    if(obj.event === 'select'){
	      	if(ruArray[id]){
	      		setTimeout(function(){         
                  	top.layer.msg("已选择该用户！！");
             	},200);
	      	}else{
	      		ruArray[id]=obj.data;
	      		var ruStr="";
	      		ruStr+= '<div id="ru'+id+'">'+
	      				'<div class="js_addname">'+obj.data.staffName+'</div>'+
					  	'<div class="js_adddel"><a onclick="deleteRuId('+id+')"><img src="images/btn_delete.png" width="24" height="24" /></a></div>'+
					  	'<div class="clear"></div></div>';
	      		$('#ruList').append(ruStr);
	      		$('#listNum').text('已选'+getJsonLength(ruArray)+'人');
	      	}
	    }
	  }); 
	 });
	 function getJsonLength(jsonData){
	    var jsonLength = 0;
	    for(var item in jsonData){
	       jsonLength++;
	    }
	    return jsonLength;
	 }
	 function deleteRuId(id){
	 	$('#ru'+id).remove();
	 	delete ruArray[id];
	 	$('#listNum').text('已选'+getJsonLength(ruArray)+'人');
	 }
	 function resetList(){
	 	ruArray={};
	 	$('#ruList').empty();
	 	getRUList();
	 	$('#listNum').text('已选'+getJsonLength(ruArray)+'人');
	 }
	 function ruSub(){
	 	var idArr=[];
	 	$.each(ruArray,function(i){
	 		idArr.push(i);
	 	});
	 	$.ajax({
			type:		'POST',
			url:		'<c:url value="/addRoleUser.do"/>',
			data:       {
							'roleid':${param.roleid},
							'menuid':${param.menuid},
							'useridStr':idArr.join(',')
						},
			dataType:	'json',
			success:	function(data){
				var obj = eval('(' + data + ')');
               	if(obj.flag>0){
               	    //弹出loading
            		var index = top.layer.msg('用户角色配置中，请稍候',{icon: 16,time:false,shade:0.8});
                  	setTimeout(function(){         
                  		top.layer.msg(obj.msg);
                   		top.layer.close(index);
		        		layer.closeAll("iframe");
 		        		//刷新父页面
 		        		parent.location.reload();
 		         		parent.showSearchList();
 		         		parent.layer.closeAll("iframe");
               		},2000);
               	}else{
               	 	layer.msg(obj.msg);
               	}
			},
          	error:function() {
              	layer.alert("请求失败！");
          	}
		});
	 }
</script>
</body>
</html>
