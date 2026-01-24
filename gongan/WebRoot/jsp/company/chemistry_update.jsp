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
    
    <title>修改懂化学技术人员</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	
</head>
<body>
<form class="layui-form" method="post" id="update_chemistry_form">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>修改懂化学技术人员</legend>
	</fieldset>
	
	<input type="hidden" name="menuid" id="menuid" value=${menuid } />
	<input type="hidden" name="companyid" id="companyid" value=${chemistry.companyid} />
	<input type="hidden" name="id" id="id" value=${chemistry.id} />
    <div class="layui-form-item">
    	<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="personname" id="personname" value="${chemistry.personname}" autocomplete="off" lay-reqtext="请输入姓名"/>
	    	</div>
    	</div>
    	<div class="layui-inline">
	    	<label class="layui-form-label">性别</label>
	    	<div class="layui-input-inline">
	    		<input type="radio" name="sexes" value="男" title="男" <c:if test="${chemistry.sexes eq '男'}"> checked</c:if> />
	    		<input type="radio" name="sexes" value="女" title="女" <c:if test="${chemistry.sexes eq '女'}"> checked</c:if> />
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
    	<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>身份证号码</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="cardnumber" id="cardnumber" value="${chemistry.cardnumber}" lay-verify="required|checkcard" autocomplete="off" lay-reqtext="身份证不能为空"/>
	    	</div>
    	</div>
    	<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>文化程度</label>
	    	<div class="layui-input-inline">
	    		<select name="education" id="education" style="width:170px;" lay-verify="required"></select>
	    	</div>
		</div>
    </div>

    <div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>联系电话</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="telephone" id="telephone" value="${chemistry.telephone}" lay-verify="required" lay-reqtext="请输入联系电话" autocomplete="off"/>
	    	</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>岗位</label>
			<div class="layui-input-inline">
				<select name="station" id="station" style="width:170px;" lay-verify="required" lay-reqtext="请选择岗位"></select>
			</div>
		</div>
	</div>
    
    <div class="layui-form-item">
    	<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>民族</label>
	    	<div class="layui-input-inline">
	      		<select name="nation" id="nation" style="width:170px;" lay-verify="required" lay-reqtext="请选择民族" ></select>
	    	</div>
		</div>
    	<div class="layui-inline">
    		<label class="layui-form-label"><font color="red" size=2>*</font>政治面貌</label>
	    	<div class="layui-input-inline">
	      		<select name="politicalposition" id="politicalposition" style="width:170px;" lay-verify="required" lay-reqtext="请选择政治面貌" ></select>
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
    	<div class="layui-inline">
    		<label class="layui-form-label">毕业院校</label>
    		<div class="layui-input-inline">
    			<input type="text" class="layui-input" name="school" id="school" value="${chemistry.school}" autocomplete="off" />
    		</div>
    	</div>
    	<div class="layui-inline">
    		<div class="layui-inline">
    			<label class="layui-form-label">专业</label>
	    		<div class="layui-input-inline">
	    			<input type="text" class="layui-input" name="major" id="major" value="${chemistry.school}" autocomplete="off" />
	    		</div>
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
    	<div class="layui-inline">
    		<label class="layui-form-label">微信号</label>
    		<div class="layui-input-inline">
    			<input type="text" class="layui-input" name="wechat" id="wechat" value="${chemistry.wechat}" autocomplete="off" />
    		</div>
    	</div>
    	<div class="layui-inline">
    		<label class="layui-form-label">QQ</label>
    		<div class="layui-input-inline">
    			<input type="text" class="layui-input" name="qq" id="qq" value="${chemistry.qq}" autocomplete="off" />
    		</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
	    <div class="layui-inline">
			<label class="layui-form-label">户籍地详址</label>
			<div class="layui-input-inline">
		  		<input type="text" class="layui-input" name="homeplace" id="homeplace" value="${chemistry.homeplace}" style="width:670px;" autocomplete="off"/>
			</div>
		</div>
    </div>
	
    <div class="layui-form-item">
    	<div class="layui-inline">
	    	<label class="layui-form-label">现住地详址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="lifeplace" id="lifeplace" value="${chemistry.lifeplace}" style="width:670px;" autocomplete="off"/>
	    	</div>
    	</div>
    </div>
    
  	<div class="layui-form-item layui-form-text">
  		<label class="layui-form-label">备注信息</label>
     	<div class="layui-input-inline" style="width:670px;">
     		<textarea name="memo" id="memo" class="layui-textarea">${chemistry.memo}</textarea>
     	</div>
    </div>
  	
	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="UPDATEChemistrySub">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="UPDATEChemistryReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">
	//获取民族数据字典
	function getNation(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+15,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				$("select[name^=nation]").html(options);
			}
		});
	}
	//获取政治面貌数据字典
	function getPoliticalPosition(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+17,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				$("select[name^=politicalposition]").html(options);
			}
		});
	}
	//获取文化程度数据字典
	function getEducation(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+19,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				$("select[name^=education]").html(options);
			}
		});
	}
	//获取岗位列表
	function getStation(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+74,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				$("select[name^=station]").html(options);
			}
		});
	}
	
	$(document).ready(function(){
		getNation();
		getPoliticalPosition();
		getEducation();
		getStation();
		$("#nation").val("${chemistry.nation}");
		$("#politicalposition").val("${chemistry.politicalposition}");
		$("#education").val("${chemistry.education}");
		$("#station").val("${chemistry.station}");
	});
	
	layui.use('form',function(){
		var form = layui.form;
		var layer = layui.layer;
		form.render();
		
		form.on('submit(UPDATEChemistrySub)',function(data){
			var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
			setTimeout(function(){
				updateChemistry();
		   		top.layer.close(index1);
		   	},800);
		  	return false;
		});
		
		form.verify({
			checkcard:function(value,item){
				var Validator = new IDValidator();
				//验证号码是否合法，合法返回true，不合法返回false
				var code = $("#cardnumber").val();
				var i = Validator.isValid(code);
				if(i == false){
					console.log("不合法");
					return "不合法";
				}
			}
		});
		
		function updateChemistry(){
			$("#update_chemistry_form").ajaxSubmit({
				url:		'<c:url value="/updateChemistry.do"/>',
				dataType:	'json',
				async:		false,
				success:	function(data) {
					var obj = eval('(' + data + ')');
	              	if(obj.flag>0){
	              	   //弹出loading
			            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                setTimeout(function(){         
			                top.layer.msg(obj.msg);
			                top.layer.close(index);
					        layer.closeAll("iframe");
					        parent.layer.closeAll("iframe");
			 		        //刷新父页面
			 		        //parent.location.reload();
			 		        parent.$("#searchChemistry").click();
		               },500);
	              	}else{
	              		top.layer.msg(obj.msg);
	              	}
				},error:function(){
					top.layer.alert("请求失败");
				}
			});
		}
		
	});
		
</script>

</body>
</html>
