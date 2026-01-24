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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   	<body style="background-color:#FFFFFF;">
  	<form class="layui-form" method="post" id="form1" onsubmit="return false;">
  		<table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 2.5%;margin-top: 2.5%;margin-bottom: 30px;">
			<tr>
				<td width="60%" colspan=2>
					<strong>请选择要导出的"${param.personlabelname}"的字段：</strong>
				</td>
				<td width="30%">
					（姓名和身份证、年龄为导出的必选属性）
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:15px;">
					<input type="checkbox" title="姓名" lay-skin="primary" checked disabled>
				</td>
				<td width="30%" style="padding:15px;">
					<input type="checkbox" title="身份证" lay-skin="primary" checked disabled>
				</td>
				<td width="30%" style="padding:15px;">
					<input type="checkbox" title="年龄" lay-skin="primary" checked disabled>
					
				</td>
			</tr>
			<tr>
				<td width="60%" colspan=2>
					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
				  		<legend>基本信息</legend>
					</fieldset>
				</td>
				<td width="20%" style="padding-left:25px;">
					<input type="checkbox" lay-filter="personnelall" title="全选" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="sexes" name="personnel" title="性别" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="usedname" name="personnel" title="曾用名" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="nickname" name="personnel" title="绰号" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="marrystatus" name="personnel" title="婚姻状况" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="nation" name="personnel" title="民族" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="soldierstatus" name="personnel" title="兵役状况" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="heathstatus" name="personnel" title="健康状态" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="politicalposition" name="personnel" title="政治面貌" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="faith" name="personnel" title="宗教信仰" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="feature" name="personnel" title="特殊特征" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="speciality" name="personnel" title="技能专长" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="records" name="personnel" title="前科劣迹" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="education" name="personnel" title="文化程度" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="persontype" name="personnel" title="人员类别" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="personheight" name="personnel" title="身高" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="netskillhabit" name="personnel" title="网络社交技能习惯" lay-skin="primary">
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="houseplace" name="personnel" title="户籍地详址" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="housepolice" name="personnel" title="户籍地派出所" lay-skin="primary">
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="homeplace" name="personnel" title="现住地详址" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="homepolice" name="personnel" title="现住地派出所" lay-skin="primary">
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="workplace" name="personnel" title="工作地详址" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="workpolice" name="personnel" title="工作地派出所" lay-skin="primary">
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="60%" colspan=2>
					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
				  		<legend>${param.personlabelname}信息</legend>
					</fieldset>
				</td>
				<td width="20%" style="padding-left:25px;">
					<input type="checkbox" lay-filter="extendall" title="全选" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="addtime" name="extend" title="建档时间" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="addoperator" name="extend" title="建档人" lay-skin="primary">
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="jointcontrollevel" name="extend" title="联控级别" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="incontrollevel" name="extend" title="在控状态" lay-skin="primary">
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="unitname1" name="extend" title="管辖责任单位" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="policename1" name="extend" title="管辖责任民警" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="policephone1" name="extend" title="管辖责任民警手机" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="unitname2" name="extend" title="双管辖责任单位" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="policename2" name="extend" title="双管辖责任民警" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="policephone2" name="extend" title="双管辖责任民警手机" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="60%" colspan=2>
					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
				  		<legend>关联信息</legend>
					</fieldset>
				</td>
				<td width="20%" style="padding-left:25px;">
					<input type="checkbox" lay-filter="relationall" title="全选" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="telnumber" name="relation" title="手机号码" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="telephone" name="relation" title="使用手机" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="relatedwifi" name="relation" title="关联wifi" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="relatedvehicle" name="relation" title="交通工具" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="bankaccount" name="relation" title="银行账号" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="netidentity" name="relation" title="虚拟身份" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="netpayment" name="relation" title="网络支付" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="relatedhouse" name="relation" title="涉及房产" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="relatedlegal" name="relation" title="法人组织" lay-skin="primary">
				</td>
			</tr>
			<tr>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="relateddriver" name="relation" title="驾驶证件" lay-skin="primary">
				</td>
				<td width="30%" style="padding:5px;padding-left:20px;">
					<input type="checkbox" value="relatedpassport" name="relation" title="护照情况" lay-skin="primary">
				</td>
				<td>
				</td>
			</tr>
		</table>  
		<div class="layui-form-item">
		    <div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 20px;">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="exportSub"><i class="layui-icon">&#xe67d;</i>导 出</button>
		    </div>
	  	</div>
    </form>   
    <script type="text/javascript">
    	$(document).ready(function(){
		});
		layui.use(['form'],function(){
			var form=layui.form;
			
			form.on('checkbox(personnelall)',function(data){
				if(data.elem.checked){
					$("input[name=personnel]").prop("checked",true);				
				}else{
					$("input[name=personnel]").prop("checked",false);	
				}
				form.render();
			})
			form.on('checkbox(extendall)',function(data){
				if(data.elem.checked){
					$("input[name=extend]").prop("checked",true);				
				}else{
					$("input[name=extend]").prop("checked",false);	
				}
				form.render();
			})
			form.on('checkbox(relationall)',function(data){
				if(data.elem.checked){
					$("input[name=relation]").prop("checked",true);				
				}else{
					$("input[name=relation]").prop("checked",false);	
				}
				form.render();
			})
			
			form.on('submit(exportSub)', function(data){
	         var personnelfield=["personname","cardnumber","age"],personneltext=["姓名","身份证","年龄"];
	         $("input[name=personnel]:checked").each(function(){
	         	var p=$(this);
	         	personnelfield.push(p.val());
	         	personneltext.push(p.attr("title"));
	         });
	         
	         var extendfield=[],extendtext=[];
	         $("input[name=extend]:checked").each(function(){
	         	var p=$(this);
	         	extendfield.push(p.val());
	         	extendtext.push(p.attr("title"));
	         });
	         
	         var relationfield=[],relationtext=[];
	         $("input[name=relation]:checked").each(function(){
	         	var p=$(this);
	         	relationfield.push(p.val());
	         	relationtext.push(p.attr("title"));
	         });
	         
	         var index = top.layer.msg('数据导出中，请稍候',{icon: 16,time:false,shade:0.8});
	         var url='<c:url value="/exportPersonnelExtend.do"/>?'+
	         						'personnelfield='+personnelfield.join(",")+
	         						'&personneltext='+personneltext.join(",")+
	         						'&extendfield='+extendfield.join(",")+
	         						'&extendtext='+extendtext.join(",")+
	         						'&relationfield='+relationfield.join(",")+
	         						'&relationtext='+relationtext.join(",")+
	         						'&cardnumber='+parent.$("#cardnumber").val()+
	         						'&personname='+parent.$("#personname").val()+
	         						'&homeplace='+parent.$("#homeplace").val()+
	         						'&unitname1='+parent.$("input[name='jurisdictunit1']").val()+
	         						'&policename1='+parent.$("#jurisdictpolice1").val()+
	         						'&jointcontrollevel='+parent.$("#jointcontrollevel").val()+
	         						'&incontrollevel='+parent.$("#incontrollevel").val()+
	         						'&persontype='+parent.$("#persontype").val()+
	         						'&telnumber='+parent.$("#telnumber").val()+
	         						'&personlabelid='+${param.personlabelid}+
	         						'&menuid='+${param.menuid};
	         	if("${param.personlabelid}"==9)url+='&attributelabels='+parent.$("input[name='attributelabels']").val();
	            var xhr=new XMLHttpRequest();
	         	xhr.open('POST',url,true);
	         	xhr.responseType="blob";
	         	xhr.onload=function(){
	         		if(this.status===200){
	         			var blob=this.response;
	         			if(navigator.msSaveBlob==null){
	         				var a=document.createElement('a');
	         				var headerName=xhr.getResponseHeader("Content-disposition");
	         				a.download=decodeURIComponent(headerName).substring(20);
	         				if(a.download!=null&&a.download!=""){
		         				a.href=URL.createObjectURL(blob);
		         				$("body").append(a);
		         				a.click();
		         				URL.revokeObjectURL(a.href);
		         				$(a).remove();
	         				}else{
								top.layer.msg("无导出数据!未生成文件。。");	         				
	         				}
	         			}else{
	         				navigator.msSaveBlob(blob,decodeURIComponent(headerName).substring(20));
	         			}
	         		}
	         		top.layer.close(index);
	         		parent.layer.closeAll("iframe");
	         	};
	         	xhr.send();
	         
	           	return false;
			 });
		})
    </script>
  </body>
</html>
