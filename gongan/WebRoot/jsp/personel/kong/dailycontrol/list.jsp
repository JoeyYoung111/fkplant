<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 
    <title>日常管控-三天一走访查询</title>
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
   <style>
 .layui-table td .layui-table-cell{
    height:90px;
    }
  .layui-form-radio {
	    padding-top:50px;
     }
        	/*layui-table 表格内容允许换行*/
	    .layui-table-main .layui-table td div:not(.laytable-cell-radio){
	        height: auto;
	        overflow:visible;
	        text-overflow:inherit;
	        white-space:normal;
	    }
	    .layui-table-fixed .layui-table-body{
	    	display:none;
	    }
</style>
  </head>
 <body>
<input type="hidden"  name="personnelid" id="personnelid"  value=${personnelid}></input>&nbsp;
 <script type="text/html" id="toolbarButton">
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
	</script> 
  
    <table class="layui-hide" id="followTable" lay-filter="followTable"></table>
   
<script>

$(document).ready(function(){
	
});
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
       layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treetable: 'treetable-lay/treetable',
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['table','flow','laydate','form','treeSelect'], function(){
			  var table = layui.table;
			  var laydate = layui.laydate;
			  var layer = layui.layer;
			  var form=layui.form;
			  var treeSelect = layui.treeSelect;
			  var flow = layui.flow;
			  form.render();
 
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchKongDailyControl.do?controltype=1&personnelid="/>'+${personnelid},
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'radio',fixed:'true',align:"center"},
        {field:'controltime', title: '管控时间', width:110,align:"center"},
        {field:'controlmode', title: '管控方式', width:100,align:"center"},
        {field:'controlcontent', title: '反馈内容', align:"center",templet: function (item) {
				var controlcontent="";
				if(item.controlcontent!=null&&item.controlcontent!=""){
				  controlcontent= item.controlcontent.replace(/\n/g,"<br/>");
				}
				return "<div>"+controlcontent+"</div>";
           }},
        
        {field:'addoperatordepart', title: '建档派出所',width:120,align:"center"} ,
        {field:'addoperator', title: '建档民警',width:90,align:"center"} ,
        {field:'addtime', title: '建档时间',width:110,align:"center"} ,
        {field:'filesallname', title: '图片附件',align:"center",templet: function (item) {
             var options="";
             if(item.fileattachments!=null&&item.fileattachments!=""){
               $.ajax({
					type:		'POST',
					url:		'<c:url value="/getFileNames.do"/>',
					data:		{
									fileattachments: item.fileattachments
								},
					dataType:	'json',
					async:      false,
					success:	function(data){
					   var obj = eval('(' + data + ')');
					   var num=item.LAY_TABLE_INDEX+1;  //行号
				        if(obj.msg==""){
				          options+='<div id="filelist'+num+'">';
				          options +='</div>';
					    }else{
					      var  riskFilesView=obj.msg.split(",");
				            if(riskFilesView.length>0){
									var viewname=obj.result.split(",");
									var viewname1=obj.msg.split(",");
									var mark=obj.mark.split(",");
									options+='<div id="filelist'+num+'">';
									$.each(riskFilesView,function(index,item){
									if(mark[index]==1){
									    options +='<img style="float:left;"  src="/../uploadFiles/pictures/'+viewname1[index]+'">';
									}else{
									    options +='<img style="float:left;"  src="/../uploadFiles/'+viewname1[index]+'">';
									}
									
							});
						   options +='</div>';
						}
					 }
				   }
				});
             
             }
            return options;
		  }}
		
    ]],
    page: true,
    limit: 10,
    done: function(res, curr, count){//数据渲染完的回调
      for(var i=1;i<=count;i++){
        var imgdiv=document.getElementById("filelist"+i);
        if(imgdiv!=null){
          new Viewer(imgdiv,{ 
              navbar:	false //点击查看时不显示缩略图
	      });
        }
      
       }
      }
    });
    
		
		//监听行工具事件
		table.on('toolbar(followTable)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
					var alertmsg = "";
					//未填报不能新增照片
					if("${kongextend.filesallname}"==""){
						alertmsg="照片";
					}
					if("${kongextend.cometime}"==""||"${kongextend.leavetime}"==""||"${kongextend.nativeplace}"==""||"${kongextend.contractperson}"==""||${kongextend.jointtype}==0||"${kongextend.comereason}"==""||"${kongextend.engagedwork}"==""||"${kongextend.identity}"==""||"${kongextend.serviceplace}"==""){
						if(alertmsg==""){
							alertmsg="分色管控信息";
						}else{
							alertmsg+=",分色管控信息";
						}
					}
					if("${kongextend.exportRelation.telnumber}"==""){
						if(alertmsg==""){
							alertmsg="手机号码";
						}else{
							alertmsg+=",手机号码";
						}
					}
					if(${relationcount}==0){
						if(alertmsg==""){
							alertmsg="社会关系";
						}else{
							alertmsg+=",社会关系";
						}
					}
					if(alertmsg==""){
						var index = layui.layer.open({
							title : "新增三天一走访",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : '<c:url value="/jsp/personel/kong/dailycontrol/add.jsp?controltype=1&personnelid="/>'+${personnelid},
							area: ['600px', '600px'],
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
						top.layer.msg("请先完善该人员信息!"+alertmsg+"信息缺失");
					}
				 break;
				case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改三天一走访",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/searchdailycontrolbyid.do?page=dailycontrol&id='+id,
							area: ['600px', '600px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
						
					}else{
						layer.alert("请先选择一条修改数据！");
					}
					layui.layer.full(index);	
			   		break;
			   	case 'cancel':
			  	var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelkongdailycontrol.do?id="+id+'&menuid=0',{},function(data) {
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
						layer.alert("请先选择一条要删除的数据！");
					}
					break;
			  
	         }
		});
	
	
 });
</script> 
</body>

</html>