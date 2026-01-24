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
    
    <title>新增涉及人员</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">新增涉及人员信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<div  class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>人员身份证号</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" id="cardnumber" name="cardnumber"  autocomplete="off" class="layui-input" placeholder="请输入人员身份证号"/>
			</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="personname" readonly style="background:#efefef" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">手机号码</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="telnumber" autocomplete="off" class="layui-input" readonly style="background:#efefef">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div id="labels">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">现住地</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="homeplace" autocomplete="off" class="layui-input" style="width:660px;background:#efefef" readonly>
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">处理措施</label>
		    <div class="layui-input-inline" style="width:52.5%;">
<%--		      <textarea placeholder="请输入处理措施" class="layui-textarea" id="deal" name="deal"></textarea>--%>
		      <select name="deal" autocomplete="off">
					<option value="" selected> --- 请选择处理措施 --- </option>
					<option value="行政处罚">行政处罚</option>
					<option value="敲打训诫">敲打训诫</option>
					<option value="遣送出境">遣送出境</option>
					<option value="教育转化">教育转化</option>
					<option value="报列不准入境">报列不准入境</option>
					<option value="劝阻出境">劝阻出境</option>
					<option value="其他处理">其他处理</option>
				</select>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.use(['form'], function(){
			var form = layui.form,
			layer = layui.layer;
			
			$('#cardnumber').blur(function(){
					$("#labels").empty();
		  			$.ajax({
						type:		'POST',
						url:		'<c:url value="/checkPersonnelCardnumber.do"/>',
						data:		{cardnumber :  this.value},
						dataType:	'json',
						async:      false,
						success:	function(data){
							if(data.flag){
								$("#personname").val(data.personnel.personname);
								$("#homeplace").val(data.personnel.homeplace);
								$("#telnumber").val(data.personnel.telnumber);
								$("#personnelid").val(data.personnel.id);
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
						}
					});
			  		
			  });
			
			form.on('submit(msgSub)', function(data){
					//新增
					$.ajax({
						type:		'POST',
						url:		'<c:url value="/addKeypersonnel.do"/>',
						data:		{cardnumber:$('#cardnumber').val(),deal:$('#deal').val(),cdtid:${param.cdtid},menuid:${param.menuid}},
						dataType:	'json',
						success:	function(data){
		           			var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                  	    //弹出loading
		 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
			 		        		//刷新
			 		        		parent.$("#sjrybutton").click();
			 		        		layer.closeAll("iframe");
			 		        		parent.layer.closeAll("iframe");
		                   		},2000);
		                 	}else if(obj.flag==0){
		                  	 	//新增风险人员
		                  	 	var index = layui.layer.open({
									title : "添加风险人员",
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content : '<c:url value="/jsp/event/zbEvent/addwholePerson.jsp"/>?menuid=${param.menuid }&cdtid=${param.cdtid}&cardnumber='+$('#cardnumber').val()+'&deal='+$('#deal').val(),
									area: ['800', '600px'],
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
		                	}else{
		                		layer.msg(obj.msg);
		                	}
						}
					});
				return false;
			});
		});
	</script>
  </body>
</html>
