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
    
    <title>新增制贩毒风险人员信息</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>新增制贩毒风险人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="policephone1" id="policephone1">
		<input type="hidden"  name="policephone2"  id="policephone2">
		<input type="hidden"  name="jurisdictunit1_name" id="jurisdictunit1_name">
		<input type="hidden"  name="jurisdictunit2_name"  id="jurisdictunit2_name">
		<input type="hidden"  name="narcoticstype" id="narcoticstype">
		<input type="hidden"  name="personneltype" id="personneltype"  value="2"><!--  制贩毒风险人员-->
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>身份证号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" id="cardnumber" name="cardnumber" lay-verify="required|cardnumber" autocomplete="off" placeholder="请输入身份证号" class="layui-input"  lay-reqtext="请输入身份证号" lay-verType="tips">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" id="personname" name="personname" lay-verify="required" autocomplete="off" placeholder="请输入人员姓名" class="layui-input"  lay-reqtext="请输入人员姓名">
	      		</div>
	       	</div>
	  </div>
	  <div class="layui-form-item">
	    	<div id="labels">
	    	</div>
	  	</div>
	 <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>人员属性</label>
	    		<div class="layui-input-inline">
	      			<select id="persontype"  name="persontype" style="width:170px;" lay-verify="required" lay-verType="tips">
	      			</select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>人员类别</label>
	    		<div class="layui-input-inline">
	      			<select id="ptype"  name="ptype" style="width:170px;" lay-verify="required" lay-verType="tips">
	      			     <option  value="">--请选择--</option>
	      			     <option  value="本地在册">本地在册</option>
	      			     <option  value="外来前科">外来前科</option>
	      			</select>
	      		</div>
	       	</div>
	     </div>
	    <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>涉毒种类</label>
	    		<div class="layui-input-inline"  style="width:250px;">
                   	<select name="narcoticstype1" id="narcoticstype1"  xm-select="narcoticstype1" xm-select-skin="normal"
                   	 xm-select-search=""  lay-verify="required" lay-verType="tips" ></select>
                </div>
	         </div> 
	         <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>末次处罚时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="lasttime" id="lasttime"  lay-verify="required" autocomplete="off" placeholder="请输入末次处罚时间" class="layui-input"  lay-reqtext="请输入末次处罚时间" lay-verType="tips">
	      		</div>
	       	</div>
	     </div>   
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>管控类别</label>
	    		<div class="layui-input-inline">
	      			<select   name="jointcontrollevel" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>在控状态</label>
	    		<div class="layui-input-inline">
	      			<select   name="incontrollevel" id="incontrollevel" style="width:170px;" lay-verify="required"  lay-verType="tips"></select>
	      		</div>
	       	</div>
	    </div> 
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">前科劣迹</label>
	    		<div class="layui-input-inline">
                      <textarea placeholder="请输入内容" class="layui-textarea" name="records"  style="width:680px;"></textarea>
                </div>
	         </div> 
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">户籍地详址</label>
	    		<div class="layui-input-inline">
                   	<input type="text" id="houseplace" name="houseplace"  autocomplete="off" placeholder="请输入户籍地详址" class="layui-input"  style="width:680px;">
                </div>
	         </div> 
	     </div>  
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">现住地详址</label>
	    		<div class="layui-input-inline">
                    	<input type="text" id="homeplace" name="homeplace"  autocomplete="off" placeholder="请输入现住地详址" class="layui-input"   style="width:680px;">
                </div>
	         </div> 
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">信息检查方式</label>
	    		<div class="layui-input-inline" style="width:680px;">
                    	  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="见面谈话" title="见面谈话" >					
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="调查走访" title="调查走访">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="系统查询" title="系统查询">	
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="侧面了解" title="侧面了解">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="其他" title="其他">		
				 </div>
	         </div> 
	     </div> 
	      <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">管辖单位</label>
	    		<div class="layui-input-inline"  lay-verify="jurisdictunit1">
	      			<input type="text" id="jurisdictunit1" name="jurisdictunit1"  lay-filter="jurisdictunit1"    lay-reqtext="请选择管辖单位">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">管辖民警</label>
	    		<div class="layui-input-inline"  lay-verify="jurisdictpolice1">
	      			<select id="jurisdictpolice1" name="jurisdictpolice1"   lay-filter="jurisdictpolice1"   lay-reqtext="请选择管辖民警"></select>
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
	      			<select id="jurisdictpolice2" name="jurisdictpolice2" id="jurisdictpolice2"  value="0" lay-filter="jurisdictpolice2"></select>
	      		</div>
	       	</div>	
	     </div>    
	     <div class="layui-form-item" id="ybssDiv"></div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	  	<div style="height:120px;"></div>
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
	    	$.ajax({
				 type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+82, //
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">管控类别：请选择</option>' + fillOption(data);
				      $("select[name^=jointcontrollevel]").html(options);
				   }
			});
			$.ajax({
				 type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+22, //在控级别
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				        var options = '<option value="">在控级别：请选择</option>' + fillOption(data);
				        $("select[name^=incontrollevel]").html(options);
				   }
			});
			$.ajax({
				 type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+20, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">人员属性：全部</option>' + fillOption(data);
				      $("select[name^=persontype]").html(options);
	             }
	        });
       });
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treeSelect: "treeSelect",
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['form', 'laydate','layedit','formSelects','treeSelect'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         formSelects = layui.formSelects,
		         treeSelect = layui.treeSelect,
		         laydate = layui.laydate,
		         layedit = layui.layedit;
		         laydate.render({
					elem: '#lasttime',
					type: 'date'
				});
			   $('#cardnumber').blur(function(){
					$("#labels").empty();
					$("#ybssDiv").empty();
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
									if(flaglabel.indexOf(",4,")!=-1){
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
			        					form.render();								
										layer.alert("该身份证已存在涉毒人员--"+data.personnel.personname+"!!");
									}else {
			        					form.render();								
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
										if(data.personnel.jdunit1!=null&&data.personnel.jdunit1!=""){
											treeSelect.checkNode('jurisdictunit1', data.personnel.jdunit1);
				        					treeSelect.refresh('jurisdictunit1');
											var name=treeSelect.zTree('jurisdictunit1').getSelectedNodes()[0].name;
			             					$("#jurisdictunit1_name").val(name)
				        					getUsers($('#jurisdictunit1').val(),1,data.personnel.jdpolice1);
										}
										if(data.personnel.jdunit2!=null&&data.personnel.jdunit2!=""){
											treeSelect.checkNode('jurisdictunit2', data.personnel.jdunit2);
				        					treeSelect.refresh('jurisdictunit2');
				        					var name=treeSelect.zTree('jurisdictunit2').getSelectedNodes()[0].name;
			             					$("#jurisdictunit2_name").val(name)
				        					getUsers($('#jurisdictunit2').val(),2,data.personnel.jdpolice2);
										}
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
														$("#homeplace").val(ybss.homeplace);
														$("#houseplace").val(ybss.houseplace);
														$("#persontype").val(ybss.persontype);
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
					  //身份证验证
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
					  jurisdictunit1:function(vaule,item){
					  if($("#jurisdictunit1").val()==""){
					      	$("#jurisdictunit1").next().find("input").focus();
					       return '请选择管辖单位！';
					      }
					    },
					  jurisdictpolice1:function(vaule,item){
					  if($("#jurisdictpolice1").val()==""){
					      	$("#jurisdictpolice1").next().find("input").focus();
					       return '请选择管辖单位民警！';
					      }
					    },
					 cardnumber:function(value,item){
					  		var validator = new IDValidator();
					  		if(!validator.isValid(value)){
					  			return "身份证号存在错误";
					  		}else{
					  			var msg="";
					  			$.ajax({
									type:	'post',
									url:	'<c:url value="/checkPersonnelCardnumber.do"/>',
									data:	{cardnumber :  value},
									dataType:	'json',
									async:		false,
									success:	function(data){
										if(data.flag){
											var flaglabel=","+data.personnel.zslabel1+",";
											if(flaglabel.indexOf(",4,")!=-1){
												msg = "该身份证已存在涉毒人员--"+data.personnel.personname+"!!";
											}
										}
									}
								});
								if(msg!="")return msg;
					  		}
					  	}
				 });  
		
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
			          // treeSelect.zTree('jurisdictunit1').setting=setting;
			        	//var newNode = {name:"空",id:0};
			        	//treeSelect.zTree('jurisdictunit1').addNodes(null,0,newNode);
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
			           	var newNode = {name:"空",id:0};
			        	treeSelect.zTree('jurisdictunit2').addNodes(null,0,newNode);
			        	treeSelect.refresh('jurisdictunit2');
			        	if($('#jurisdictunit2').val()!="")getUsers($('#jurisdictunit2').val(),2,0);
			        	else getUsers(0,2,0)
			        }
			    });
			    
			       //滥用毒品种类
                   formSelects.config('narcoticstype1', {
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
				     },
				    error: function(id, url, searchVal, err){           //使用远程方式的error回调
				         console.log(err);   //err对象
				    },
				      clearInput: false,          //当有搜索内容时, 点击选项是否清空搜索内容, 默认不清空
                 }, true);
                  formSelects.config('narcoticstype1', {
				    type: 'get',                //请求方式: post, get, put, delete...
				    keyName: 'name',            //自定义返回数据中name的key, 默认 name
				    keyVal: 'id',            //自定义返回数据中value的key, 默认 value
				    direction: 'auto',          //多选下拉方向, auto|up|down
				   success: function(id, url, searchVal, result){      //使用远程方式的success回调
				 
				    },
				 }, true);
				        //server模式
				        formSelects.config('narcoticstype1', {
				            keyName: 'name',
				            keyVal: 'id'
				        }).data('narcoticstype1', 'server', {
				             url: '<c:url value="/getBasicMsgTreeSelect.do"/>'+'?basicType=36'
				  });
		      
			    
			    
			    
		  form.on('submit(roleSub)', function(data){
		     var narcoticstype=formSelects.value('narcoticstype1','name');
		     $("#narcoticstype").val(narcoticstype);    
		  $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addDuPersonel.do"/>',
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
		 		        		 parent.layui.layer.closeAll("iframe");
		 		        		 parent.layui.table.reload('followTable2', {});   
	                   		},2000);
	                 	}else{
	                  	 	top.layer.msg(obj.msg);
	                	}
	             	},
	              	error:function() {
	                  	top.layer.alert("请求失败！");
	              	}
	          	});
	           	return false;
			 });
		});
	</script>
  </body>
</html>
