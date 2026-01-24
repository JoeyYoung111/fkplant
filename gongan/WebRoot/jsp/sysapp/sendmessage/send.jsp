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
    
    <title>发送短信页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">发送短信</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1" lay-filter="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<div class="layui-row">
		  	<div class="layui-form-item">
		  		<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
		  					<label class="layui-form-label"><font color="red" size=2>*</font>短信发送类型</label>
		  				</div>
		  			</div>
		  			<div class="layui-col-md11">
					    <div class="layui-input-block">
					      	<select id="smstype" name="smstype" style="width:170px;" lay-verify="required" lay-verType="tips">
						 		<option value="">--请选择短信发送类型--</option>
						        <option value="1">模板发送</option>
						        <option value="2">自定义发送</option>
						 	</select>
					    </div>
				    </div>
		  		</div>
		  	</div>
		  	<div class="layui-form-item">
		  		<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
		  					<label class="layui-form-label">短信内容</label>
		  				</div>
		  			</div>
		  			<div class="layui-col-md11">
					    <div class="layui-input-block">
					      	<textarea placeholder="请输入内容" class="layui-textarea" name="smstext"></textarea>
					    </div>
				    </div>
		  		</div>
		  	</div>
		  	<div class="layui-form-item">
				<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
		  					<label class="layui-form-label"><font color="red" size=2>*</font>接收目标类型</label>
		  				</div>
		  			</div>
		  			<div class="layui-col-md11">
					    <div class="layui-input-block">
					      	<select id="sendFlag" name="sendFlag" lay-filter="sendFlag" style="width:170px;" lay-verify="required" lay-verType="tips">
						 		<option value="">--请选择接收目标类型--</option>
						        <option value="1">单位</option>
						        <option value="2">个人</option>
						 	</select>
					    </div>
				    </div>
		  		</div>
			</div>
			<div class="layui-form-item" id="receiverTarget" style="display: none;">
				<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
		  					<label class="layui-form-label"><font color="red" size=2>*</font>接收目标</label>
		  				</div>
		  			</div>
		  			<div class="layui-col-md11">
					    <div class="layui-input-block">
					      	<div id="deptreceiver" style="display: none;"></div>
					      	<div id="personreceiver" style="display: none;">
					      		<input type="hidden" id="personreceiveids" name="personreceiveids" autocomplete="off" class="layui-input">
					      		<input type="text" class="layui-input" readonly="readonly"><span id="receiverspan" style="position: absolute;top: 3px;left: 10px;"></span>
					      		<button type="button" class="layui-btn layui-btn-sm" style="position: absolute;top: 3px;right: 10px;" onclick="choose();">选 择</button>
					      	</div>
					    </div>
				    </div>
		  		</div>
			</div>
		</div>
		<div class="layui-form-item layui-col-md3 layui-col-lg-offset5">
			<div class="layui-input-block">
				<button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      	<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
    
	<script type="text/javascript">
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
		});
		
		layui.use(['form','zTreeSelectM'], function(){
			var form = layui.form;
			var layer = layui.layer;
			var zTreeSelectM = layui.zTreeSelectM;
			
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#deptreceiver',//元素容器【必填】          
			    data: '<c:url value="/getDepartmentTree.do"/>',
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'deptreceiveids',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名
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
			
			form.on('select(sendFlag)', function(data){
				var receiverTarget = document.getElementById("receiverTarget");
         		receiverTarget.style.display='block';
         		if(data.value==1){
         			document.getElementById("deptreceiver").style.display='block';
         			document.getElementById("personreceiver").style.display='none';
         		}else if(data.value==2){
         			document.getElementById("deptreceiver").style.display='none';
         			document.getElementById("personreceiver").style.display='block';
         		}
     		});
     		
     		form.on('submit(msgSub)', function(data){
     			var receiveids;
     			if($("#sendFlag").val()==1){
     				receiveids=$("input[name='deptreceiveids']").val();
     			}else{
     				receiveids=$("#personreceiveids").val();
     			}
     			$("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addSendMessage.do"/>',
	              	data:		{receiveids:receiveids},
	              	dataType:	'json',
	              	async:  	false,
	              	success:	function(data) {
	              		var obj = eval('(' + data + ')');
                  		if(obj.flag>0){
                  			top.layer.msg(obj.msg);
                  			layer.closeAll("iframe");
                  			parent.layer.closeAll("iframe");
                  			parent.formSubmit();
                  		}else{
                  	 		layer.msg(obj.msg);
                		}
	                }
	          	});
	          	return false;
     		});
		});
		
		function choose(){
			var index = layui.layer.open({
				title : "接收人",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/sysapp/sendmessage/choosereceiver.jsp"/>?personreceiveids='+$("#personreceiveids").val(),
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
		}
		
		//点击叉按钮
		function cancelExpress(id){
			layer.confirm('确定删除此接收目标？', function(index){
				layer.close(index);
				$("#"+id).remove();
				document.getElementById('personreceiveids').value = $("#personreceiveids").val().replace(id+',','');
			});
		}
	</script>
  </body>
</html>
