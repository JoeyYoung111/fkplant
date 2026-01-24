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
    
    <title>添加涉恐人员</title>
    
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
  		<legend>新增涉恐人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="policephone1" id="policephone1">
		<input type="hidden"  name="policephone2"  id="policephone2">
		<input type="hidden"  name="jurisdictunit1_name" id="jurisdictunit1_name">
		<input type="hidden"  name="jurisdictunit2_name"  id="jurisdictunit2_name">
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
	    		<label class="layui-form-label"><font color="red" size=2>*</font>籍贯</label>
	    		<div class="layui-input-inline">
	      			<select id="nativeplace"  name="nativeplace" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>是否国家、省平台标签人员</label>
	    		<div class="layui-input-inline">
	      			 <input type="radio" name="contractperson" value="是" title="是" checked=""  />
                     <input type="radio" name="contractperson" value="否" title="否"  />
	      		</div>
	       	</div>	
	     </div>
	     
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>联控级别</label>
	    		<div class="layui-input-inline">
	      			<select   name="jointtype" style="width:170px;" lay-verify="required" lay-verType="tips">
			 		<option value=''>联控级别：全部</option>
			 		<option value='1'>红色</option>
			 		<option value='2'>橙色</option>
			 		<option value='3'>黄色</option>
			 		<option value='4'>蓝色</option>
		</select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>在控级别</label>
	    		<div class="layui-input-inline">
	    			<input type="text" name="incontrollevel" autocomplete="off" class="layui-input"   value="在控" readonly="readonly">
	      		</div>
	       	</div>
	    </div> 
	    <div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label my-text-nowarp">分类：</label>
				<div class="layui-input-inline">
					<select name="classify" lay-filter="classify" style="width:170px;" lay-verType="tips">
					 		<option value='' >--未选择--</option>
					 		<option value='落户人员' >落户人员</option>
					 		<option value='学生' >学生</option>
					 		<option value='务工经商' >务工经商</option>
					 		<option value='党政机关事业单位人员' >党政机关事业单位人员</option>
					 		<option value='零散人员' >零散人员</option>
					 		<option value='其他' >其他</option>
                           </select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label my-text-nowarp">分类明细：</label>
				<div class="layui-input-inline">
					<select name="classifydetail" id="classifydetail" style="width:170px;" lay-verType="tips">
					 		<option value='' >--未选择--</option>
                           </select>
				</div>
			</div>
		</div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">主要涉恐嫌疑情况</label>
	    		<div class="layui-input-inline">
                      <textarea placeholder="请输入内容" class="layui-textarea" name="suspectaffair"  style="width:700px;"></textarea>
                </div>
	         </div> 
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">户籍地详址</label>
	    		<div class="layui-input-inline">
                   	<input type="text" id="houseplace" name="houseplace"  autocomplete="off" placeholder="请输入户籍地详址" class="layui-input"  style="width:700px;">
                </div>
	         </div> 
	     </div>  
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">现住地详址</label>
	    		<div class="layui-input-inline">
                    	<input type="text" id="homeplace" name="homeplace"  autocomplete="off" placeholder="请输入现住地详址" class="layui-input"   style="width:700px;">
                </div>
	         </div> 
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">信息来源</label>
	    		<div class="layui-input-inline" style="width:800px;">
                    	  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="常驻" title="常驻" >					
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="暂住" title="暂住">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="旅馆" title="旅馆">	
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="网吧" title="网吧">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="盘查" title="盘查">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="出警" title="出警">
						   <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="案件" title="案件">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="关注人员系统" title="关注人员系统">		
						  <input type="checkbox" class="parent" name="checkmethod" lay-skin="primary" value="手工录入" title="手工录入" checked>		
                </div>
	         </div> 
	     </div> 
	      <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">管辖单位</label>
	    		<div class="layui-input-inline">
	      			<input type="text" id="jurisdictunit1" name="jurisdictunit1" value="0"  lay-verify="jurisdictunit1" lay-filter="jurisdictunit1" class="layui-input">
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
	     <div class="layui-form-item" id="ybssDiv"></div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	  	<div style="height:150px;"></div>
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
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+51, //籍贯
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">籍贯：全部</option>' + fillOption(data);
				      $("select[name^=nativeplace]").html(options);
				   }
			});
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
											if(flaglabel.indexOf(",2,")!=-1){
												msg = "该身份证已存在涉恐人员--"+data.personnel.personname+"!!";
											}
										}
									}
								});
								if(msg!="")return msg;
					  		}
					  	}
		  });  
		
			$('#cardnumber').blur(function(){
					$("#labels").empty();
					$("#ybssDiv").empty();
					$("#personname").val("");
					$("#houseplace").val("");
					$("#homeplace").val("");
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
									if(flaglabel.indexOf(",2,")!=-1){
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
			        					form.render();								
										layer.alert("该身份证已存在涉恐人员--"+data.personnel.personname+"!!");
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
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">工作地详址</td><td colspan="3">'+ybss.workplace+'</td></tr>';
															str2+='<tr><td width="120" class="text-align-r my-text-nowarp">现住地经度</td><td>'+ybss.homex+'</td>';
															str2+='<td width="120" class="text-align-r my-text-nowarp">现住地纬度</td><td>'+ybss.homey+'</td></tr>';
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
															$("#houseplace").val(ybss.houseplace);
															$("#homeplace").val(ybss.homeplace);
															form.render();
														}
													}
										});
								}
							}
						});
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
			           	var newNode = {name:"空",id:0};
			        	treeSelect.zTree('jurisdictunit2').addNodes(null,0,newNode);
			        	treeSelect.refresh('jurisdictunit2');
			        	if($('#jurisdictunit2').val()!="")getUsers($('#jurisdictunit2').val(),2,0);
			        	else getUsers(0,2,0)
			        }
			    });
			form.on('select(classify)', function(data){
					  if(data.value==""){
					  		$("#classifydetail").html('<option value="" selected>--未选择--</option>');
		    				form.render();	
					  }
					  if(data.value=="落户人员"){
					  		$("#classifydetail").html('<option value="落户人员" selected>落户人员</option>');
		    				form.render();	
					  }
					  if(data.value=="学生"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="高校" <c:if test="${kongextend.classifydetail == '高校' }">selected</c:if>>高校</option><option value="内高班" <c:if test="${kongextend.classifydetail == '内高班' }">selected</c:if>>内高班</option><option value="职高技校" <c:if test="${kongextend.classifydetail == '职高技校' }">selected</c:if>>职高技校</option><option value="初中及以下" <c:if test="${kongextend.classifydetail == '初中及以下' }">selected</c:if>>初中及以下</option><option value="短期实习培训" <c:if test="${kongextend.classifydetail == '短期实习培训' }">selected</c:if>>短期实习培训</option>');
		    				form.render();	
					  }
					  if(data.value=="务工经商"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="经营店铺" <c:if test="${kongextend.classifydetail == '经营店铺' }">selected</c:if>>经营店铺</option><option value="流动摆摊" <c:if test="${kongextend.classifydetail == '流动摆摊' }">selected</c:if>>流动摆摊</option><option value="企业集体务工" <c:if test="${kongextend.classifydetail == '企业集体务工' }">selected</c:if>>企业集体务工</option><option value="社会面零散务工" <c:if test="${kongextend.classifydetail == '社会面零散务工' }">selected</c:if>>社会面零散务工</option>');
		    				form.render();	
					  }
					  if(data.value=="党政机关事业单位人员"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="驻苏公务（警务）人员" <c:if test="${kongextend.classifydetail == '驻苏公务（警务）人员' }">selected</c:if>>驻苏公务（警务）人员</option><option value="学校管理人员" <c:if test="${kongextend.classifydetail == '学校管理人员' }">selected</c:if>>学校管理人员</option><option value="集体务工管理人员" <c:if test="${kongextend.classifydetail == '集体务工管理人员' }">selected</c:if>>集体务工管理人员</option>');
		    				form.render();	
					  }
					  if(data.value=="零散人员"){
					  		$("#classifydetail").html('<option value=""   <c:if test="${kongextend.classifydetail == '' }">selected</c:if>>--未选择--</option><option value="无业人员" <c:if test="${kongextend.classifydetail == '无业人员' }">selected</c:if>>无业人员</option><option value="学龄前儿童" <c:if test="${kongextend.classifydetail == '学龄前儿童' }">selected</c:if>>学龄前儿童</option>');
		    				form.render();	
					  }
					  if(data.value=="其他"){
					  		$("#classifydetail").html('<option value="其他" selected>其他</option>');
		    				form.render();	
					  }
				  });
		  form.on('submit(roleSub)', function(data){
		     if($('#jurisdictunit1').val()!='0'&& $('#jurisdictunit1').val()!=''){
		         var jurisdictpolice1=$("#jurisdictpolice1 option:selected").text();
		           $("#policephone1").val( $("#jurisdictunit1_name").val()+"("+jurisdictpolice1+")");
		      }
		   if($('#jurisdictunit2').val()!='0'&& $('#jurisdictunit2').val()!=''){
		         var jurisdictpolice2=$("#jurisdictpolice2 option:selected").text();
		           $("#policephone2").val( $("#jurisdictunit2_name").val()+"("+jurisdictpolice2+")");
		      }
		  $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addKongPersonel.do"/>',
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
