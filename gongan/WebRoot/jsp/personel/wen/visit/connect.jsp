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
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<input type="hidden" id="jointcontrolid" value=${param.jointcontrolid }>
<script type="text/html" id="barButton">
<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="showinfo">详情</a>
{{#  if($("#jointcontrolid").val()<0){ }}    
	{{#  if(d.wenvisitid !=${param.wenvisitid}){ }}
		<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="link">关联</a>
	{{#  } }}
	{{#  if(d.wenvisitid==${param.wenvisitid}){ }}
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="cancel">解除关联</a> 
	{{#  } }}
{{#  } }} 
{{#  if($("#jointcontrolid").val()>=0){ }}
	{{#  if(d.id !=$("#jointcontrolid").val()){ }}
		<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="link">关联</a>
	{{#  } }}
	{{#  if(d.id ==$("#jointcontrolid").val()){ }}
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="cancel">解除关联</a> 
	{{#  } }} 
{{#  } }}

</script>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
var locat = (window.location+'').split('/'); 
var now=new Date();
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

$(document).ready(function(){
});

layui.use(['table','form'], function(){
  var table = layui.table,
  form = layui.form,
  visitflag=0;
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter'],
    url :   locat+"/searchJointControlRecord.do?personnelid="+${param.personnelid}+'&wenvisitid='+${param.wenvisitid},
    method:'post',
    cols: [[
        {field:'infodate', title: '情报发生时间', width:150,align:"center"},
        {field:'infotype', title: '情报内容类别', width:150,align:"center"},
        {field:'addoperator', title: '采集人', width:100,align:"center"} ,
        {field:'information', title: '情报内容',align:"center",templet: function (item) {
        		if(item.wenvisitid==${param.wenvisitid})visitflag++;
				return "<span>"+item.information+"</span>";
           }} ,
        {field: 'right', title: '操作', toolbar: '#barButton',width:150,align:"center"} 
    ]],
    page: true,
    limit: 10
  });
  
  //监听联控记录   详情按钮
  table.on('tool(followTable)', function(obj){
	  var id = obj.data.id;
	  if(obj.event === 'showinfo'){
	   		var index = layui.layer.open({
				title : "联控记录详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getjointcontrolrecordbyid.do?id='+id+'&menuid=0&page=showinfo',
				area: ['800', '550px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})			
	    }else if(obj.event === 'cancel'){
	    	parent.$("#jointcontrolid").val(0);
	    	parent.$("#traffictype").val("");
	    	parent.$("#togetherperson").val("");
	    	parent.layer.closeAll("iframe");
	    }else if(obj.event === 'link'){
	    	if(visitflag>0){
	    		if($("#jointcontrolid").val()<0){
		    		layer.alert("此活动经历已关联！");
		    	}else{
		    		if($("#jointcontrolid").val()>0&&id!=$("#jointcontrolid").val()){
		    			layer.alert("此活动经历已关联！");
		    		}else{
		    			parent.$("#jointcontrolid").val(id);
				    	var vehicletype=obj.data.vehicletype;
				    	var vehicleinfo=obj.data.vehicleinfo;
				    	var traffictype=(vehicletype!=""?(vehicletype+"("+(vehicleinfo!=""?vehicleinfo:"无工具信息")+")"):"");
				    	parent.$("#traffictype").val(traffictype);
				    	var togetherperson="";
				    	if(obj.data.togethername1!=""){
				    		togetherperson+=obj.data.togethername1;
				    		if(obj.data.togethername2!=""){
				    			togetherperson+=","+obj.data.togethername2;
				    			if(obj.data.togethername3!=""){
				    				togetherperson+=","+obj.data.togethername3;
				    				if(obj.data.togethername4!=""){
					    				togetherperson+=","+obj.data.togethername4;
					    				if(obj.data.togethername5!=""){
						    				togetherperson+=","+obj.data.togethername5;
						    			}
					    			}
				    			}
				    		}
				    	}
				    	parent.$("#togetherperson").val(togetherperson);
				    	parent.layer.closeAll("iframe");
		    		}
		    	}
	    	}else{
		    	if($("#jointcontrolid").val()<=0){
			    	parent.$("#jointcontrolid").val(id);
			    	var vehicletype=obj.data.vehicletype;
			    	var vehicleinfo=obj.data.vehicleinfo;
			    	var traffictype=(vehicletype!=""?(vehicletype+"("+(vehicleinfo!=""?vehicleinfo:"无工具信息")+")"):"");
			    	parent.$("#traffictype").val(traffictype);
			    	var togetherperson="";
			    	if(obj.data.togethername1!=""){
			    		togetherperson+=obj.data.togethername1;
			    		if(obj.data.togethername2!=""){
			    			togetherperson+=","+obj.data.togethername2;
			    			if(obj.data.togethername3!=""){
			    				togetherperson+=","+obj.data.togethername3;
			    				if(obj.data.togethername4!=""){
				    				togetherperson+=","+obj.data.togethername4;
				    				if(obj.data.togethername5!=""){
					    				togetherperson+=","+obj.data.togethername5;
					    			}
				    			}
			    			}
			    		}
			    	}
			    	parent.$("#togetherperson").val(togetherperson);
			    	parent.layer.closeAll("iframe");
		    	}else if(id!=$("#jointcontrolid").val()){
		    		layer.alert("此活动经历已关联！");
		    	}
	    	}
	    }
	    
   	});
   
 });
</script>
</body>

</html>