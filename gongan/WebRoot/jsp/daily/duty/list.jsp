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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   	<style>
   		.showinfo{
   			width:100%;
   			height:90%;
   			overflow:hidden;
   		}
   		.showinfo table{
   			height:100%;
   			width:100%;
   			overflow-y:auto;
   			display:block;
   			table-layout:fixed;
   		}
   		.showinfo table::-webkit-scrollbar{
   			width:0;
   		}
		.showinfo thead{
		    position:sticky;
		    position:-webkit-sticky;
			top:0;
			left:0;
			right:0;
			display:table;
			width:100%;
			table-layout:fixed;
			z-index:3;
			background-color:white;
		}
		.showinfo tbody{
			display:table;
			table-layout:fixed;
			z-index:1;
		}
		.showinfo tbody td{
		    height: auto;
	        overflow:visible;
	        text-overflow:inherit;
	        white-space:normal;
		}
	</style>
   	<body style="background-color:#FFFFFF;">
  	<div class="showinfo">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
	  		<thead>
		  		<tr height="40" bgcolor="#3598DC">
		    		<td colspan="9" width="95%"><span class="showinfo_title">值班管理</span></td>
		  		</tr>
				<tr>
					<td width="15%" rowspan="2">
						<strong>单位</strong>
					</td>
					<td width="10%" rowspan="2">
						<strong>扎口组织督导所领导</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>反恐专题</strong>
					</td>
					<td width="30%" colspan="3">
						<strong>涉稳人员、事件专题</strong>
					</td>
					<td width="20%" colspan="2">
						<strong>禁毒专题</strong>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<strong>分管领导</strong>
					</td>
					<td width="10%">
						<strong>社区民警</strong>
					</td>
					<td width="10%">
						<strong>分管领导</strong>
					</td>
					<td width="10%">
						<strong>社区民警</strong>
					</td>
					<td width="10%">
						<strong>岗位辅警</strong>
					</td>
					<td width="10%">
						<strong>分管领导</strong>
					</td>
					<td width="10%">
						<strong>岗位辅警</strong>
					</td>
				</tr>
			</thead>
			<tbody id="tabletext">
			</tbody>
		</table>  
		<button class="hidden" id="refresh" onclick="getgetAllDuty()" ></button>
		<div style="height:150px;"></div>
    </div>
    <script type="text/javascript">
    	var locat = (window.location+'').split('/'); 
    	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
    	layui.use(['table','form'], function(){
    		getgetAllDuty();
    	});
    	var departnamelist=["要塞派出所","君山派出所","城中派出所","西郊派出所","滨江派出所","城东派出所","云亭派出所","南闸派出所","周庄派出所","华士派出所","华西派出所","三房巷派出所","新桥派出所","璜土派出所","利港派出所","申港派出所","夏港派出所","青阳派出所","徐霞客派出所","峭岐派出所","月城派出所","长泾派出所","祝塘派出所","顾山派出所"];
    	function getgetAllDuty(){
    		$.ajax({
				type:		'POST',
				url:		'<c:url value="/getgetAllDutyList.do"/>',
				dataType:	'json',
				success:	function(result){
					var tabletext = '';
					for(var k=0;k<departnamelist.length;k++){
						$.each(result, function(i, item) {
							if(departnamelist[k]==item.departname){
								var mflag=false;
								if(<%=userSession.getLoginUserRoleid()%>==1||<%=userSession.getLoginUserRoleid()%>==41||<%=userSession.getLoginUserDepartmentid()%>==item.departid)mflag=true;
								
								var width=$(".showinfo").find("thead").find("tr").next().find("td:first").css("width");
								tabletext += '<tr>';
								tabletext += '<td width="'+width+'">'+item.departname.replace("派出","")+'</td>';
								if(mflag){
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'dp_leader\',\'扎口组织督导所领导\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.dp_leader!=null?item.dp_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'kong_leader\',\'反恐工作-分管领导\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.kong_leader!=null?item.kong_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'kong_police\',\'反恐工作-社区民警\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.kong_police!=null?item.kong_police:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'wen_leader\',\'涉稳风险人员、事件管控工作-分管领导\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.wen_leader!=null?item.wen_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'wen_police\',\'涉稳风险人员、事件管控工作-社区民警\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.wen_police!=null?item.wen_police:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'wen_fu_police\',\'涉稳风险人员、事件管控工作-岗位辅警\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.wen_fu_police!=null?item.wen_fu_police:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'du_leader\',\'禁毒工作-分管领导\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.du_leader!=null?item.du_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'" style="cursor:pointer;" onclick="changeText('+item.id+',\'du_fu_police\',\'禁毒工作-岗位辅警\')"><textarea readonly style="cursor:pointer;" class="layui-textarea">'+(item.du_fu_police!=null?item.du_fu_police:'')+'</textarea></td>';
								}else{
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.dp_leader!=null?item.dp_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.kong_leader!=null?item.kong_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.kong_police!=null?item.kong_police:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.wen_leader!=null?item.wen_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.wen_police!=null?item.wen_police:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.wen_fu_police!=null?item.wen_fu_police:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.du_leader!=null?item.du_leader:'')+'</textarea></td>';
									tabletext += '<td width="'+width+'"><textarea readonly class="layui-textarea">'+(item.du_fu_police!=null?item.du_fu_police:'')+'</textarea></td>';
								}
								tabletext += '</tr>';
							}
						});
					}
					$("#tabletext").html(tabletext);
					layui.form.render();
				}
			});
    	}
    	
    	function changeText(id,field,fieldname){
    		var index = layui.layer.open({
				title : fieldname,
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getDutyUpdate.do?id='+id+'&field='+field+'&menuid=${param.menuid}',
				area: ['1000', '650px'],
				offset:['50px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});	
    	}
    </script>   
  </body>
</html>
