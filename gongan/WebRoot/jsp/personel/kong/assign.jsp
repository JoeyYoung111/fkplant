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
    
    <title>修改涉恐人员-指派信息</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>涉恐人员-指派信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=0>
		<input type="hidden"  name="id" id="id" value="${kongextend.id}">
		<input type="hidden"  name="personnelid" id="personnelid" value=${personnel.id }>
		<input type="hidden"  name="policephone1" id="policephone1">
		<input type="hidden"  name="policephone2"  id="policephone2">
		<input type="hidden"  name="jurisdictunit1_name" id="jurisdictunit1_name">
		<input type="hidden"  name="jurisdictunit2_name"  id="jurisdictunit2_name">
		<div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">管辖单位</label>
	    		<div class="layui-input-inline">
	      			<input type="text" id="jurisdictunit1" name="jurisdictunit1" value="0" lay-filter="jurisdictunit1" lay-verify="jurisdictunit1" class="layui-input">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">管辖民警</label>
	    		<div class="layui-input-inline">
	      			<select id="jurisdictpolice1" name="jurisdictpolice1" id="jurisdictpolice1"  lay-filter="jurisdictpolice1"></select>
	      		</div>
	       	</div>	
	     </div>
	      <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">双管辖单位</label>
	    		<div class="layui-input-inline">
	      			<input type="text" id="jurisdictunit2" name="jurisdictunit2" value="0" lay-filter="jurisdictunit2" lay-verify="jurisdictunit2" class="layui-input">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">双管辖民警</label>
	    		<div class="layui-input-inline">
	      			<select id="jurisdictpolice2" name="jurisdictpolice2" id="jurisdictpolice2"  lay-filter="jurisdictpolice2"></select>
	      		</div>
	       	</div>	
	     </div>    
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		var users1={},users2={};
			function getUsers(departmentid,index,value){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>'+departmentid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var options = fillOption(data);
						var firstid=0;
						if(index==1)users1={};
						else if(index==2)users2={};
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								if(i==0)firstid=this.value;
								if(index==1)users1[this.value]=this.memo;
								else if(index==2)users2[this.value]=this.memo;
							});
						});
						var id="#jurisdictpolice"+index;
						$(id).html(options);
						layui.form.render();
						if(value!=""&&value!=0)$(id+" option[value="+value+"]").select();
					
					}
				});
			}
			
	$(document).ready(function(){
	  
       });
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treeSelect: "treeSelect",
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['form', 'layedit','formSelects','treeSelect'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         formSelects = layui.formSelects,
		         treeSelect = layui.treeSelect,
		         layedit = layui.layedit;
		   
		    //管辖单位  只查询派出所
		  	var treeseeting1=treeSelect.render({
			        elem: '#jurisdictunit1',
			       data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
			        type: 'get',
			        placeholder: '管辖责任单位',
			        search: false,
			        style: {
			            folder: {
			                enable: false
			            },
			            line: {
			                enable: true
			            }
			        },
			        // 点击回调
			        click: function(d){
			           var id=treeSelect.zTree('jurisdictunit1').getSelectedNodes()[0].id;
			           if(id!=0){
			              var name=treeSelect.zTree('jurisdictunit1').getSelectedNodes()[0].name;
			              $("#jurisdictunit1_name").val(name);
			           }else{
			              $("#jurisdictunit1_name").val("");
			           }
			        	if($('#jurisdictunit1').val()!="")getUsers($('#jurisdictunit1').val(),1,0);
			        	else getUsers(0,1,0)
			        	form.render();
			        },
			        // 加载完成后的回调函数
			        success: function (d) {
			             if("${personnel.jdunit1}"!=""&&"${personnel.jdunit1}"!="0"){
				        	treeSelect.checkNode('jurisdictunit1', "${personnel.jdunit1}");
				        	getUsers("${personnel.jdunit1}",1,"${personnel.jdpolice1}");
				        	 var name=treeSelect.zTree('jurisdictunit1').getSelectedNodes()[0].name;
				        	 console.log("name="+name);
			                 $("#jurisdictunit1_name").val(name);
			        	}
			        	
			        	var newNode = {name:"空",id:0};
			        	treeSelect.zTree('jurisdictunit1').addNodes(null,0,newNode);
			        	if($('#jurisdictunit1').val()!="")getUsers($('#jurisdictunit1').val(),1,0);
			        	else getUsers(0,1,0)
			        	treeSelect.refresh('jurisdictunit1');
			        	treeseeting1.hideIcon();//隐藏图标使用
			       }
			    });
		  //双管辖单位  只查询派出所
	      treeSelect.render({
			        elem: '#jurisdictunit2',
			        data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
			        type: 'get',
			        placeholder: '管辖责任单位',
			        search: false,
			        style: {
			            folder: {
			                enable: false
			            },
			            line: {
			                enable: true
			            }
			        },
			        // 点击回调
			        click: function(d){
			           var id=treeSelect.zTree('jurisdictunit2').getSelectedNodes()[0].id;
			           if(id!=0){
			              var name=treeSelect.zTree('jurisdictunit2').getSelectedNodes()[0].name;
			              $("#jurisdictunit2_name").val(name);
			           }else{
			              $("#jurisdictunit2_name").val("");
			           }
			        	if($('#jurisdictunit2').val()!="")getUsers($('#jurisdictunit2').val(),2,0);
			        	else getUsers(0,2,0)
			        	form.render();
			        
			        },
			        // 加载完成后的回调函数
			        success: function (d) {
			            // treeSelect.checkNode('jurisdictunit2', "${personnel.jdunit2}");
			            if("${personnel.jdunit2}"!=""&&"${personnel.jdunit2}"!="0"){
				        	treeSelect.checkNode('jurisdictunit2', "${personnel.jdunit2}");
				        	getUsers("${personnel.jdunit2}",2,"${personnel.jdpolice2}");
				        	var name=treeSelect.zTree('jurisdictunit2').getSelectedNodes()[0].name;
			                 $("#jurisdictunit2_name").val(name);
			        	} 
			            var newNode = {name:"空",id:0};
			        	treeSelect.zTree('jurisdictunit2').addNodes(null,0,newNode);
			        	treeSelect.refresh('jurisdictunit2');
			        	if($('#jurisdictunit2').val()!="")getUsers($('#jurisdictunit2').val(),2,0);
			        	else getUsers(0,2,0)
			        }
			    });
		  form.on('submit(roleSub)', function(data){
		     if($('#jurisdictunit1').val()!='0'){
		         var jurisdictpolice1=$("#jurisdictpolice1 option:selected").text();//民警
		           $("#policephone1").val( $("#jurisdictunit1_name").val()+"("+jurisdictpolice1+")");
		      }
		   if($('#jurisdictunit2').val()!='0'){
		         var jurisdictpolice2=$("#jurisdictpolice2 option:selected").text();
		           $("#policephone2").val( $("#jurisdictunit2_name").val()+"("+jurisdictpolice2+")");
		      }
		  $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateKongPersonelZP.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(obj.msg);
	                     		top.layer.close(index);
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		//parent.location.reload();
		 		         		parent.$("#search1").click();
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
	           	return false;
			 });
		});
	</script>
  </body>
</html>
