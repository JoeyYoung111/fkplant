+<%@ page contentType='text/html;charset=UTF-8' language='java'%>
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
    
    <title>添加涉黑人员</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>新增涉黑人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="editablename" id="editablename" >
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>身份证号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="cardnumber" id="cardnumber" lay-verify="required|Iscardnumber" autocomplete="off" placeholder="请输入身份证号" class="layui-input"  lay-reqtext="请输入身份证号" lay-verType="tips">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="personname" id="personname" lay-verify="required" autocomplete="off" placeholder="请输入人员姓名" class="layui-input"  lay-reqtext="请输入人员姓名">
	      		</div>
	       	</div>
	  </div>
	  <div class="layui-form-item">
	    	<div id="labels">
	    	</div>
	  	</div>
	 	<div class="layui-form-item">
	       	<div class="layui-inline">
		       	<label class="layui-form-label">列管单位</label>
		    	<div class="layui-input-inline">
		      		<input type="text" id="departmentid" value="<%=userSession.getLoginUserDepartname()%>" readonly style="background:#efefef" autocomplete="off" class="layui-input">
		    	</div>
		 	</div>
	       	<div class="layui-inline">
		       	<label class="layui-form-label">列管民警</label>
		    	<div class="layui-input-inline">
		      		<input type="text" id="addoperatorid" value="<%=userSession.getLoginUserName()%>" readonly style="background:#efefef" autocomplete="off" class="layui-input">
		    	</div>
		 	</div>
	 	</div>
	     
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>增加可编辑部门</label>
	    		<div class="layui-input-inline" style="width:680px;">
	      			<input type="text" id="sponsor" name="sponsor" lay-filter="sponsor" class="layui-input">
	      		</div>
	       	</div>
	     </div> 
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>选择可编辑人员</label>
	    		<div class="layui-input-inline" style="width:680px;">
	      			<select name="editableid" id="editableid"  xm-select="editableid" xm-select-skin="normal" xm-select-search=""  >
                    </select>
	       	</div>
	     </div> 
	     <div class="layui-form-item" id="ybssDiv">
	  	</div>  
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
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
		    	treeSelect.render({
				        elem: '#sponsor',
				        data: 'getDepartmentTree.do',
				        type: 'get',
				        placeholder: '请选择可编辑部门：',				//修改默认提示信息
				        search: true,								// 是否开启搜索功能：true/false，默认false
				        style: {
				            folder: {enable: false},
				            line: {enable: true}
				        },
				         click: function(d){
				              console.log(d); 
				       		       //server模式
								   formSelects.data('editableid', 'server', {
								    url: '<c:url value="/getUsersByDepartidJSON.do"/>'+'?departmentid='+$("#sponsor").val(),
								    keyword: ''
								   });   
				        },
				        success: function (d) {
				        	// 加载完成后的回调函数
				        }
		    });
              formSelects.config('editableid', {
				    type: 'get',                //请求方式: post, get, put, delete...
				    header: {},                 //自定义请求头
				    data: {},                   //自定义除搜索内容外的其他数据
				    searchUrl: '',              //搜索地址, 默认使用xm-select-search的值, 此参数优先级高
				    searchName: 'keyword',      //自定义搜索内容的key值
				    searchVal: '',              //自定义搜索内容, 搜素一次后失效, 优先级高于搜索框中的值
				    keyName: 'name',            //自定义返回数据中name的key, 默认 name
				    keyVal: 'id',            //自定义返回数据中value的key, 默认 value
				    keySel: 'selected',         //自定义返回数据中selected的key, 默认 selected
				    keyDis: 'disabled',         //自定义返回数据中disabled的key, 默认 disabled
				    keyChildren: 'children',    //联动多选自定义children
				    delay: 500,                 //搜索延迟时间, 默认停止输入500ms后开始搜索
				    direction: 'auto',          //多选下拉方向, auto|up|down
				   success: function(id, url, searchVal, result){      //使用远程方式的success回调
				        // formSelects.value(id,[1,2]);
				        /** 设置默认值实例
				        var str='986,987';
				        var arr=str.split(",");//
				        formSelects.value(id,arr); **/
				    },
				    error: function(id, url, searchVal, err){           //使用远程方式的error回调
				         console.log(err);   //err对象
				    },
				      clearInput: false,          //当有搜索内容时, 点击选项是否清空搜索内容, 默认不清空
                 }, true);
            
            $('#cardnumber').blur(function(){
					$("#labels").empty();
					$("#personname").val("");
					$("#personname").removeAttr("readonly");
					$("#personname").css("background","");
			  		var validator = new IDValidator();
			  		if(validator.isValid(this.value)){
			  			$.ajax({
							type:		'POST',
							url:		'<c:url value="/checkPersonnelCardnumber.do"/>',
							data:		{cardnumber :  this.value},
							dataType:	'json',
							async:      false,
							success:	function(data){
								if(data.flag){
									var flaglabel=","+data.personnel.zslabel1+",";
									if(flaglabel.indexOf(",3,")!=-1){
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
			        					form.render();								
										layer.alert("该身份证已存在涉黑恶人员--"+data.personnel.personname+"!!");
									}else {
			        					form.render();								
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
										if(data.personnel.zslabel1!=null&&data.personnel.zslabel1!=""){
						               		var zslabel1s=data.personnel.zslabel1.split(",");
						               		var str1='<label class="layui-form-label">已存在标签</label><div class="layui-input-inline" style="padding-left:5px;padding-top:6px;">';
						               		for(var i=0;i<zslabel1s.length;i++){
							               		$.ajax({
													type:		'POST',
													url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
													data:		{
																	id: zslabel1s[i]
																},
													dataType:	'json',
													async:      false,
													success:	function(data){
														str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;">'+data.attributelabel+'</span>';
													}
												});
						               		}
						               		str1+="</div>";
						               		$("#labels").html(str1);
						               }
			        					form.render();								
									}
								}else{
									$.ajax({
										type:		'POST',
										url:		'<c:url value="/findYbssRkByCardnumber.do"/>',
										data:		{cardnumber :  $('#cardnumber').val()},
										dataType:	'json',
										async:      false,
										success:	function(tbssflag){
														if(tbssflag.flag){
						               						var ybss=tbssflag.ybssPersonnel;
						               						var str1='<label class="layui-form-label">对接数据</label><div class="layui-input-inline" style="padding-left:5px;padding-top:6px;">';
															str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;">一标三识</span><input type="checkbox" name="ybssid" lay-skin="primary" value="'+tbssflag.ID+'" title="引用" />';
															str1+="</div>";
															$("#labels").html(str1);
															var str2='<div class="layui-input-block" style="width:700px;"><table class="layui-table" lay-even>';
															str2+='<colgroup><col width="120"><col width="200"><col width="120"><col width="200"></colgroup>';
															str2+='<tbody><tr><td width="120" class="text-align-r my-text-nowarp">姓名</td><td>'+ybss.personname+'</td>';
															str2+='<td width="120" class="text-align-r my-text-nowarp">性别</td><td>'+ybss.sexes+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">人员类别</td><td>'+ybss.persontype+'</td>';
															str2+='<td width="120" class="text-align-r my-text-nowarp">民族</td><td>'+ybss.nation+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">婚姻状态</td><td>'+ybss.marrystatus+'</td>';
															str2+='<td width="120" class="text-align-r my-text-nowarp">文化程度</td><td>'+ybss.education+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">户籍地详址</td><td colspan="3">'+ybss.houseplace+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">现住地详址</td><td colspan="3">'+ybss.homeplace+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">现住地经度</td><td>'+ybss.homex+'</td>';
															str2+='<td width="120" class="text-align-r my-text-nowarp">现住地纬度</td><td>'+ybss.homey+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">工作地详址</td><td colspan="3">'+ybss.workplace+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">手机号码</td><td colspan="3">';
															if(ybss.telnumber!=""){
																var telnumbers=ybss.telnumber.split(";");
																var telnumberstr="";
																for(var i=0;i<telnumbers.length;i++){
																	if(telnumberstr!="")telnumberstr+="</br>";
																	if(telnumbers[i].length>10)telnumberstr+=telnumbers[i];
																}
																str2+=telnumberstr;
															}
															str2+='</td></tr>';
															str2+="</tbody></table></div>";
															$("#ybssDiv").html(str2);
															$("#personname").val(ybss.personname);
															form.render();
														}
													}
										});
								}
							}
						});
			  		}
			  		
			  });
              
		   form.verify({
		       //证件号码不同类型都要验证
			  Iscardnumber:function(vaule,item){
			  if(vaule!=""){
			      var Validator = new IDValidator();
			      var identity=Validator.isValid(vaule);
			      if(!identity){ 
			          return '身份证号格式不正确！';
			      }
			     }else if(vaule==""){
			       return '请填写身份证号信息！';
			  }
			 },
		  });  
		  form.on('submit(roleSub)', function(data){
		    var ss=formSelects.value('editableid','name');
		    $("#editablename").val(ss);
            $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addHeiPersonel.do"/>',
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
		 		         		parent.location.reload();
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
