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
    
    <title>审查页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>审查政法委风险信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value="${menuid}">
		<input type="hidden"  name="id" value="${contradictionInfo.id}" />
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>风险名称</label>
	    	<div class="layui-input-inline" style="width:20%;" lay-verify="cdtnameverify">
	      		<div id="cdtname"></div>
	    	</div>
	    	<label class="layui-form-label" style="width:10%;"><font color="red" size=2>*</font>风险等级</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<select id="cdtlevel"  name="cdtlevel" style="width:170px;" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择风险等级--</option>
			 	</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>风险类别</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<div id="cdttype"></div>
			</div>
	    
	  	</div>
		<div  class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>事发地址</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" id="sfdzplace" name="sfdz" value='${contradictionInfo.sfdz }' onclick="openPGis('sfdz','事发地址');"  autocomplete="off" class="layui-input" lay-verify="required" lay-verType="tips" readonly style="background:#efefef;cursor:pointer;"/>
			</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">事发地址经度</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" name="sfdzx" lay-verify="" autocomplete="off"
				value="${contradictionInfo.sfdzx}" class="layui-input" id="sfdzx" onclick="openPGis('sfdz','事发地址');" readonly style="background:#efefef;cursor:pointer;">
			</div>
	    	<label class="layui-form-label" style="width:10%;">事发地址纬度</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" name="sfdzy" lay-verify="" autocomplete="off"
				value="${contradictionInfo.sfdzy}" class="layui-input" id="sfdzy" onclick="openPGis('sfdz','事发地址');" readonly style="background:#efefef;cursor:pointer;">
      		</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>涉事人数</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="ssrs"  name="ssrs" style="width:170px;" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择涉事人数--</option>
			 	</select>
			</div>
	    	<label class="layui-form-label" style="width:10%;">涉及金额</label>
	    	<div class="layui-input-inline" style="width:15%;">
        		<input type="text" name="sjje" value='${contradictionInfo.sjje }' lay-verify="number" autocomplete="off" class="layui-input" placeholder="请输入涉及金额"/>
      		</div>
      		<label class="layui-form-label" style="text-align:left;">万元</label>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label"><font color="red" size=2>*</font>风险矛盾概况</label>
		    <div class="layui-input-inline"  style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="cdtcontent"  lay-verify="required" lay-verType="tips">${contradictionInfo.cdtcontent }</textarea>
		    </div>
		</div>
	    <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">具体诉求</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		    	<input type="text" name="jtsq" value='${contradictionInfo.jtsq }'  autocomplete="off" class="layui-input" placeholder="请输入具体诉求"/>
		    </div>
		</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label"  ><font color="red" size=2>*</font>处置结果</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<select id="cdtresult"  name="cdtresult" style="width:170px;"  lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择处置结果--</option>
			        <option value="已钝化" <c:if test="${contradictionInfo.cdtresult eq '已钝化'}"> selected</c:if>>已钝化</option>
			        <option value="已化解" <c:if test="${contradictionInfo.cdtresult eq '已化解'}"> selected</c:if>>已化解</option>
			        <option value="处置中" <c:if test="${contradictionInfo.cdtresult eq '处置中'}"> selected</c:if>>处置中</option>
			 	</select>
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">主办部门</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" id="sponsor" name="sponsor" lay-filter="sponsor" class="layui-input">
			</div>
		</div>
	  	<div class="layui-form-item layui-form-text">
	  	   <label class="layui-form-label">协办部门</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<div id="assistdept"></div>
			</div>
	  	</div>
	  	<div  class="layui-form-item">
			<label class="layui-form-label">涉事单位信息</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" name="ssdwxx" value='${contradictionInfo.ssdwxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入涉事单位名称+单位负责人+联系电话"/>
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">属地派出所领导信息</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" name="sdpcsldxx" value='${contradictionInfo.sdpcsldxx }'  autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入属地派出所分管领导+联系电话"/>
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">属地派出所社区民警信息</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" name="sdpcsmjxx" value='${contradictionInfo.sdpcsmjxx }'  autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入属地派出所民警+联系电话"/>
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">政府牵头处置部门</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" name="zfqtmbxx" value='${contradictionInfo.zfqtmbxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入部门+领导+联系电话"/>
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">会引发的后果</label>
			<div class=layui-input-inline style="width:52.5%;">
				<div id="yfhgcheck"></div>
			</div>
		</div>
		<div class="layui-form-item">
	  		<label class="layui-form-label">是否建群</label>
	    	<div class="layui-input-inline" style="width:15%;">
	      		<select id="isjq"  name="isjq" style="width:170px;" lay-verify="required" lay-verType="tips">
			        <option value="0" <c:if test="${contradictionInfo.isjq eq '0'}"> selected</c:if>>否</option>
			        <option value="1" <c:if test="${contradictionInfo.isjq eq '1'}"> selected</c:if>>是</option>
			 	</select>
	    	</div>
	    	<div class="layui-input-inline" style="width:37%;">
	    		<input type="text" name="qxx" value='${contradictionInfo.qxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入群信息"/>
			</div>
	    </div>
	    <div class="layui-form-item">
	  		<label class="layui-form-label">是否物建信息员</label>
	    	<div class="layui-input-inline" style="width:15%;">
	      		<select id="iswjxxy"  name="iswjxxy" style="width:170px;" lay-verify="required" lay-verType="tips">
			        <option value="0" <c:if test="${contradictionInfo.iswjxxy eq '0'}"> selected</c:if>>否</option>
			        <option value="1" <c:if test="${contradictionInfo.iswjxxy eq '1'}"> selected</c:if>>是</option>
			 	</select>
	    	</div>
	    	<div class="layui-input-inline" style="width:37%;">
	    		<input type="text" name="xxyxx" value='${contradictionInfo.xxyxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入信息员信息"/>
			</div>
	    </div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">备注信息</label>
		    <div class="layui-input-inline"  style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="memo">${contradictionInfo.memo }</textarea>
		    </div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">审核结果</label>
	    	<div class="layui-input-block">
		    	<input type="radio" name="nowstate" value="2" title="通过" checked>
		    	<input type="radio" name="nowstate" value="3" title="不通过">
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">反馈意见</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="examineopinion"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
		    treeSelect: "treeSelect",
			selectInput:"selectInput/selectInput"
		});
		
		layui.use(['form','zTreeSelectM','treeSelect','selectInput'], function(){
			var form = layui.form,
				layer = layui.layer,
				selectInput= layui.selectInput,
				treeSelect = layui.treeSelect,
				zTreeSelectM = layui.zTreeSelectM;
				
		  	form.on('submit(userSub)', function(data){
		     	$("#form1").ajaxSubmit({
	              	url:		'<c:url value="/checkZfwContradictionInfo.do"/>',
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
			 
			form.verify({
		    	cdtnameverify: function(value,item){
		    		if(!$('input[name=cdtname]').val()){
		    			$('input[name=cdtname]').focus();
			  			return "请选择风险名称";
		    		}
		    	},
			});
			
			//风险名称
			selectInput.render({
	            // 容器id，必传参数
	            elem: '#cdtname',
	            name: 'cdtname', // 渲染的input的name值
	            initValue:'${contradictionInfo.cdtname}', // 渲染初始化默认值
	            placeholder: '请输入风险名称', // 渲染的inputplaceholder值
	            // 联想select的初始化本地值，数组格式，里面的对象属性必须为value，name，value是实际选中值，name是展示值，两者可以一样
	            data: [
	                <c:forEach items="${cdtnameList}" var="row" varStatus="num">
						{value: "${row}", name: "${row}"},
					</c:forEach>
	            ],
	            remoteSearch: false// 是否启用远程搜索 默认是false，和远程搜索回调保存同步
	        });
	        
	        var cdttype = '${contradictionInfo.cdttype }'.split(',');
			cdttype = turnNums(cdttype);
	        //初始化风险类别
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#cdttype',//元素容器【必填】          
			    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=39',
			    type: 'get',  //设置了长度    
			    selected: cdttype,//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'cdttype',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
			    tips: '风险类别：',
			    verify: 'required', 
			    reqtext:"请选择风险类别", 
			    reqdiv:"cdttype",  
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
           				if(item.name=="${contradictionInfo.cdtlevel}"){
							$('#cdtlevel').append('<option value="' + item.name + '" selected>' + item.name + '</option>');
						}else{
							$('#cdtlevel').append('<option value="' + item.name + '">' + item.name + '</option>');
						}
          			});
      				form.render("select");
				}
			});
			
			//初始化涉事人数
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=43',
				dataType:	'json',
				success:	function(data){
           			$.each(data, function(num, item) {
           				if(item.name=="${contradictionInfo.ssrs}"){
							$('#ssrs').append('<option value="' + item.name + '" selected>' + item.name + '</option>');
						}else{
							$('#ssrs').append('<option value="' + item.name + '">' + item.name + '</option>');
						}
          			});
      				form.render("select");
				}
			});
			
			//初始化会引发的后果
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=94',
				dataType:	'json',
				success:	function(data){
					var yfhg = "${contradictionInfo.yfhg}";
           			$.each(data, function(num, item) {
           				if(yfhg.indexOf(item.name)>-1){
           					$('#yfhgcheck').append('<input type="checkbox" name="yfhg" lay-skin="primary" value="'+item.name+'"title="'+item.name+'" checked/>');
           				}else{
           					$('#yfhgcheck').append('<input type="checkbox" name="yfhg" lay-skin="primary" value="'+item.name+'" title="'+item.name+'"/>');
           				}
          			});
      				form.render();
				}
			});
			
			var assistdept = '${contradictionInfo.assistdept }'.split(',');
			assistdept = turnNums(assistdept);
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getDepartmentTree.do"/>',
				dataType:	'json',
				success:	function(data){
					//初始化协助部门
					var _zTreeSelectM = zTreeSelectM({
					    elem: '#assistdept',//元素容器【必填】          
					    data: data,
					    type: 'get',  //设置了长度    
					    selected: assistdept,//默认值            
					    max: 5,//最多选中个数，默认5            
					    name: 'assistdept',//input的name 不设置与选择器相同(去#.)
					    delimiter: ',',//值的分隔符           
					    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
					    tips: '请选择协办部门：',
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
			
			treeSelect.render({
		        elem: '#sponsor', // 选择器
		        data: '<c:url value="/getDepartmentTree.do"/>',// 数据
		        type: 'get', // 异步加载方式：get/post，默认get
		        placeholder: '请选择主办部门：', // 占位符
		        search: true, // 是否开启搜索功能：true/false，默认false
		        // 一些可定制的样式
		        style: {
		            folder: { enable: false },
		            line: {  enable: true}
		        },
		        click: function(d){   // 点击回调
		           
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		        	if(${contradictionInfo.sponsor}>0){
		        		treeSelect.checkNode('sponsor', ${contradictionInfo.sponsor});
						//获取zTree对象，可以调用zTree方法
	               		var treeObj = treeSelect.zTree('sponsor');
						//刷新树结构
	                	treeSelect.refresh('sponsor');
		        	}
		        }
		    });
		    
		    function turnNums(nums){
				for(let i=0;i<nums.length;i++){
					nums[i] = parseInt(nums[i]);
				}
				return nums;
			}
		});
	</script>
	<script type="text/javascript">
		function openPGis(type,name){
			var place=$("#"+type+"place").val().trim();
			var x=$("#"+type+"x").val();
			var y=$("#"+type+"y").val();
			var f1=function(event){
				place=event.data.mc;
				x=event.data.lx;
				y=event.data.ly;
				$("#"+type+"place").val(place);
				$("#"+type+"x").val(x);
				$("#"+type+"y").val(y);
				layer.close(index);
				window.removeEventListener('message',f1,false);
			};
			var index = layui.layer.open({
				title : name+"标准地址修改",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc='+place+'&lx='+x+'&ly='+y,
			    area: ['800', '600px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				},
				cancel:function(){
					window.removeEventListener('message',f1,false);
				}
			})
			layui.layer.full(index);
			window.addEventListener('message',f1);
		}
	</script>
  </body>
</html>
