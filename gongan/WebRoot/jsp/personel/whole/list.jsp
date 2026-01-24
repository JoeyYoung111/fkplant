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
    <title></title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/query.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
<form class="layui-form" onsubmit="return false;" style="display:inline;" onsubmit="return false;">
	
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="cardnumber" placeholder=" 身份证号：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="personname" placeholder=" 姓名：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<div id="attributelabels" style="width:297px;"></div>
		</div>
		<br>
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="telnumber" placeholder=" 名下手机号：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:212px;">
			<select id="persontype">
				<option value=""> 户籍类别: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:297px;">
			<input class="layui-input" type="text" id="homeplace" placeholder=" 现居住地详址：" autocomplete="off" >
		</div>
		<br>
		<div class="layui-inline" style="width:212px;" >
			<input class="layui-input" type="text" id="jdpolice1" placeholder=" 管辖责任民警：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<div id="jdunit1" style="width:320px;"></div>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
		<script type="text/html" id="toolbarDemo">
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
            <c:if test='${fn:contains(param.buttons,"删除")}'>
   			     <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
            </c:if>
   		</script>
</form>
</div>
</blockquote>
<%--<table class="layui-hide" id="followTable" lay-filter="followTable"></table> --%>
	<div class="result" style="height:70%;border-top: 0px solid #E4D9D6;">
		<table class="layui-table my-table" lay-skin="nob">
			<colgroup>
				<col width="75">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
				<col width="105">
			</colgroup>
<%--			<c:if test='${fn:contains(param.buttons,"新增")}'>--%>
<%--				<thead style="padding-top:1px;">--%>
<%--					<tr>--%>
<%--						<td colspan="12">--%>
<%--									<button type="button" class="layui-btn layui-btn-sm" onclick="addPersonnelExtend();"><i class="layui-icon">&#xe624;</i>新 增</button>--%>
<%--							<button type="button" class="layui-btn layui-btn-sm" onclick=""><i class="layui-icon">&#xe601;</i>导 入</button>   --%>
<%--	            			<button type="button" class="layui-btn layui-btn-sm" onclick=""><i class="layui-icon layui-icon-export"></i>导 出</button>--%>
<%--						</td>--%>
<%--					</tr>--%>
<%--				</thead>--%>
<%--            </c:if>--%>
			<tbody id="tbody_result">
				
			</tbody>
		</table>
	</div>
	<div class="layui-table-page" style="bottom:5px;position: fixed">
		<input type="hidden" id="limit" value="10"/>
		<input type="hidden" id="pageNumber" value="1"/>
		<input type="hidden" id="maxCount" value=""/>
		<div id="layui-table-page1">
			<div class="layui-box layui-laypage layui-laypage-default my-laypage" id="layui-laypage-2">
				<a href="javascript:;" class="layui-laypage-prev"><i class="layui-icon">&#xe603;</i></a>
				<span class="layui-laypage-count" id="pNumshow"></span>
				<a href="javascript:;" class="layui-laypage-next"><i class="layui-icon">&#xe602;</i></a>
				<span class="layui-laypage-count" id="sumNum"></span>
				<span class="layui-laypage-skip">到第<input type="text" id="toPnum" min="1" value="1" class="layui-input">页
				<button type="button" class="layui-laypage-btn" onclick="choosePage()">确定</button></span>
				<span class="layui-laypage-count" id="allcount"></span>
				<span class="layui-laypage-limits">
					<select id="pagenum1" name="pagenum1">
						<option value="10" selected>10 条/页</option>
						<option value="15">15 条/页</option>
						<option value="20">20 条/页</option>
						<option value="25">25 条/页</option>
						<option value="50">50 条/页</option>
						<option value="100">100 条/页</option>
					</select>
				</span>
			</div>
		</div>
	</div>
<script>
var locat = (window.location+'').split('/'); 
var now=new Date();
Date.prototype.Format = function (fmt) { 
  var o = {
    "M+": this.getMonth() + 1, // 月份
    "d+": this.getDate(), // 日
    "h+": this.getHours(), // 小时
    "m+": this.getMinutes(), // 分
    "s+": this.getSeconds(), // 秒
    "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
    "S": this.getMilliseconds() // 毫秒
  };
  if (/(y+)/.test(fmt))
    fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
  for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
      return fmt;
}
var thistitle=parent.$("li.layui-this").find("cite").text();
var index_info,viewflag=true,viewer;
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
function fillOption(data) {
	var options = '';
	$.each(data.list, function(i, item) {
		$.each(item, function(i) {
			options += '<option value="' + this.text + '">' + this.text + '</option>';
		});
	});
	return options;
}
function getpersontype(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+20,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#persontype").append(options);
		}
	});
}

$(document).ready(function(){
	getpersontype();
});

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});
var _zTreeSelectM1;
layui.use(['table','form','zTreeSelectM'], function(){
  var table = layui.table,
  zTreeSelectM = layui.zTreeSelectM,
  form = layui.form;
  
  	index_info = layer.msg('正在查询数据，请稍候',{icon: 16,time:false,shade:0.8});
	//初始化
	_zTreeSelectM1 = zTreeSelectM({
	    elem: '#attributelabels',//元素容器【必填】          
	    data: '<c:url value="/getAttributeLabelzTreeSelectM.do"/>',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'attributelabels',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符  
	    tips:' 人员属性标签：',         
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
	        },
	        view: {
	        	showIcon: false
			}
	    }
	});
  var _zTreeSelectM2 = zTreeSelectM({
	    elem: '#jdunit1',//元素容器【必填】          
	    //data: '<c:url value="/getDepartmentTree.do"/>',
	    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'jdunit1',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符  
	    tips:' 管辖责任单位：',         
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
	        },
	        view: {
	        	showIcon: false
			}
	    }
	});
    	//搜索查询
  		$("#search").click(function () {
				index_info = layer.msg('正在查询数据，请稍候',{icon: 16,time:false,shade:0.8});
				getAllPersonnel();
		});
		
		getAllPersonnel();
		form.render();
		ztreechange1("");
 });
 
 function ztreechange1(value){
 	$('#attributelabels').find("dl.layui-anim-upbit").find("dd.layui-select-tips").html('<div class="layui-input-inline"><input class="layui-input" style="width:200px;height:30px;" type="text" id="searchztree" autocomplete="off" value="'+value+'"></div><div class="layui-input-inline"><button id="searchztreebtn" type="button" class="layui-btn layui-btn-sm layui-btn-primary"><i class="layui-icon">&#xe615</button></div>');
		$("#searchztreebtn").click(function(){
				var searchtext=$("#searchztree").val();
				var content="";
				$("#attributelabels").empty();
				if(searchtext!="")content='<c:url value="/getAttributeLabelzTreeSelectMBySearch.do"/>?searchtext='+searchtext;
				else content='<c:url value="/getAttributeLabelzTreeSelectM.do"/>';
				_zTreeSelectM1 = layui.zTreeSelectM({
				    elem: '#attributelabels',//元素容器【必填】          
				    data: content,
				    type: 'get',  //设置了长度    
				    selected: [],//默认值            
				    max: 100,//最多选中个数，默认5            
				    name: 'attributelabels',//input的name 不设置与选择器相同(去#.)
				    delimiter: ',',//值的分隔符  
				    tips:' 人员属性标签：',         
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
				        },
				        view: {
				        	showIcon: false
						}
				    }
				});
			_zTreeSelectM1.render();
			$('#attributelabels').find(".layui-input").click();
			ztreechange1(searchtext);
		});
	}
 
 function getAllPersonnel(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/searchWholePersonnel.do"/>',
			dataType:	'json',
			//async:		false,
			data:		{
							cardnumber: $("#cardnumber").val(),
							personname: $("#personname").val(),
							homeplace: $("#homeplace").val(),
							attributelabels: $("input[name='attributelabels']").val(),
							persontype: $("#persontype").val(),
							telnumber:	$("#telnumber").val(),
							jdunit1: $("input[name='jdunit1']").val(),
							jdpolice1: $("#jdpolice1").val(),
							//table 页数
							limit:			$("#limit").val(),
							pageNumber:		$("#pageNumber").val()
						},
			success:	function(result){
				var total = result.total;
				$("#allcount").html("共 "+total+" 条");
				var yema = $("#pageNumber").val();
				$("#pNumshow").html("&nbsp;&nbsp;&nbsp;第 "+yema+" 页");
				var sumyema = result.allpagenum;
				$("#sumNum").html("&nbsp;&nbsp;&nbsp;共 "+sumyema+" 页");
				$("#maxCount").val(sumyema);
				var str = "";
				var data = result.data;
				for( var j=0;j<data.length;j++){
					var item=data[j];
					str += '<tr class="my-border-b">' +
							'<td align="center" style="padding-left:2px;padding-right:2px;">'+
							getDefaultPhoto(item.id)+
							'</td>' +
							'<td colspan="11">' +
							'<div class="layui-row my-font-bold my-font16 query-table-item">'+
							'<div class="layui-col-md1"><a onclick="showinfoPersonnelExtend('+item.id+')" class="my-font-blue" style="cursor:pointer;">'+item.personname+'</a></div>'+
							'<div class="layui-col-md2 my-font-black"><a onclick="showinfoPersonnelExtend('+item.id+')" class="my-font-blue" style="cursor:pointer;">'+item.cardnumber+'</a></div>'+
							'<div class="layui-col-md4 my-font14 my-font-black">现住地:'+(item.homeplace==null||item.homeplace==""?"":item.homeplace)+'</div>'+
							'<div class="layui-col-md3 my-font14 my-font-black">责任单位:'+(item.jurisdictunit==null||item.jurisdictunit==""?"":item.jurisdictunit)+'</div>'+
							'<div class="layui-col-md2 my-font14 my-font-black">责任民警:'+(item.jurisdictpolice==null||item.jurisdictpolice==""?"":item.jurisdictpolice)+'</div>'+
							'</div>'+
							'<div class="layui-row query-table-item">'+
							'<div class="layui-col-md10">';
					if(item.sexes==null||item.sexes==""){
						var validator = new IDValidator();
						var cardinfo=validator.getInfo(item.cardnumber);
						if(cardinfo)str += '<span class="my-tag-item3 red">'+(cardinfo.sex==0?'女':'男')+'</span>';
						else str += '';
					}else str += '<span class="my-tag-item3 red">'+item.sexes+'</span>';
					if(item.persontype!=null&&item.persontype!="")str +='<span class="my-tag-item3 green">'+item.persontype+'</span>';
					if(item.marrystatus!=null&&item.marrystatus!="")str +='<span class="my-tag-item3 green">'+item.marrystatus+'</span>';
					
					var now=new Date();
					var age=now.getFullYear();
					var cardnumber=item.cardnumber.toString();
					var length=cardnumber.length;
					if(length==15){
						age-=parseInt(cardnumber.substring(6,8))+1900;
						if(parseInt(cardnumber.substring(8,12))>parseInt(new Date().Format("MMdd")))age--
					}else if(length==18){
						age-=parseInt(cardnumber.substring(6,10));
						if(parseInt(cardnumber.substring(10,14))>parseInt(new Date().Format("MMdd")))age--;
					}else age=0;
					str +='<span class="my-tag-item3 green">'+age+'岁</span>';
					
	               if(item.zslabel1!=null&&item.zslabel1!=""){
	               		var zslabel1s=item.zslabel1.split(",");
	               		for(var i=0;i<zslabel1s.length;i++){
		               		if(zslabel1s[i]!=null&zslabel1s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
									data:		{
													id: zslabel1s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										if(data&&data!=null&&data!=""){
											if(zslabel1s[i]==3){
												$.ajax({
													type:		'POST',
													url:		'<c:url value="/getHeiEditorByPersonnelid.do"/>',
													data:		{
																	personnelid: item.id
																},
													dataType:	'json',
													async:      false,
													success:	function(heidata){
														if(heidata&&heidata!=null&&heidata!=""){
															if(heidata.filterflag)str+='<span class="my-tag-item3" style="cursor:pointer;background-color:#1E9FFF;color:white;" onclick="updatePersonnelExtend('+item.id+','+data.memo+');">'+data.attributelabel+'</span>';
														}
													}
												});
											}else if(zslabel1s[i]==9){
												var userid="<%=userSession.getLoginUserID()%>";
												if(userid==item.jdpolice1||userid==item.jdpolice2)str+='<span class="my-tag-item3" style="cursor:pointer;background-color:#1E9FFF;color:white;" onclick="updatePersonnelExtend('+item.id+',9);">'+data.attributelabel+'</span>';
											}else str+='<span class="my-tag-item3" style="cursor:pointer;background-color:#1E9FFF;color:white;" onclick="updatePersonnelExtend('+item.id+','+data.id+');">'+data.attributelabel+'</span>';
										}
									}
								});
		               		}
	               		}
	               }
	               if(item.lslabel1!=null&&item.lslabel1!=""){
	               		var lslabel1s=item.lslabel1.split(",");
	               		for(var i=0;i<lslabel1s.length;i++){
		               		if(lslabel1s[i]!=null&lslabel1s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
									data:		{
													id: lslabel1s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										if(data&&data!=null&&data!=""){
											str+='<span class="my-tag-item3" ';
											var flagdepartmentid=","+data.departmentid+",";
											
											if(flagdepartmentid.indexOf(",<%=userSession.getLoginUserDepartmentid()%>,")!=-1){
												$.ajax({
													type:		'POST',
													url:		'<c:url value="/getApplylabelByPersonnel.do"/>',
													data:		{
																	personnelid: item.id,
																	applylabel1: lslabel1s[i]
																},
													dataType:	'json',
													async:      false,
													success:	function(data){
														if(data.examineflag==0){
															var content ='<c:url value="/jsp/personel/labelcheck/check.jsp"/>?id='+data.id+'&menuid=${param.menuid }&personnelid='+
																item.id+"&applylabel2="+data.applylabel2+"&applylabel1="+data.applylabel1+"&applyreason="+data.applyreason+
																"&cardnumber="+item.cardnumber+"&personname="+item.personname+"&applylabel1name="+data.applylabel1name+
																"&applylabel2name="+data.applylabel2name+"&addoperator="+data.addoperator+"&addtime="+data.addtime;
															str+='onclick="openlabelcheck(\''+content+'\')" style="cursor:pointer;';
														}else str+='style="';
													},
													error: function(){
														str+='style="';
													}
												});
											}else str+='style="';
											str+='color:red;border: 1px dashed #F70909;background-color:#E9E8E2;">'+data.attributelabel+'</span>';
										}
									}
								});
		               		}
	               		}
	               }
					if(item.zslabel2!=null&&item.zslabel2!=""){
	               		var zslabel2s=item.zslabel2.split(",");
	               		for(var i=0;i<zslabel2s.length;i++){
		               		if(zslabel2s[i]!=null&zslabel2s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
									data:		{
													id: zslabel2s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										if(data&&data!=null&&data!=""){
											if(data.rootid!=9)str+='<span class="my-tag-item3" style="background-color:#5FB878;color:white;border: 1px border #5FB878;">'+data.attributelabel+'</span>';
<%--											else{--%>
<%--												var attributelabelstr=data.attributelabel.split("-");--%>
<%--												str+='<span class="my-tag-item3" style="background-color:#5FB878;color:white;border: 1px border #5FB878;">'+attributelabelstr[0]+'</span>';--%>
<%--											}--%>
										}
									}
								});
		               		}
	               		}
	               }
					if(item.lslabel2!=null&&item.lslabel2!=""){
	               		var lslabel2s=item.lslabel2.split(",");
	               		for(var i=0;i<lslabel2s.length;i++){
		               		if(lslabel2s[i]!=null&lslabel2s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
									data:		{
													id: lslabel2s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										if(data&&data!=null&&data!=""){
											if(data.rootid!=9)str+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;">'+data.attributelabel+'</span>';
<%--											else{--%>
<%--												var attributelabelstr=data.attributelabel.split("-");--%>
<%--												str+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;">'+attributelabelstr[0]+'</span>';--%>
<%--											}--%>
										}
									}
								});
		               		}
	               		}
	               }
	               
	               var tabslabel=","+item.zslabel1+",";
	               if(tabslabel.indexOf(",2012,")!=-1){
	               		$.ajax({
							type:		'POST',
							url:		'<c:url value="/getCustomLabelTreeTable.do?personlabel="/>'+item.id,
							dataType:	'json',
							async:      false,
							success:	function(customs){
								if(customs!=null&&customs!=""){
									var tabcustoms=customs.data;
									for(var i=0;i<tabcustoms.length;i++){
										str+='<span class="my-tag-item3" style="background-color:orange;color:white;border: 1px border #5FB878;">'+tabcustoms[i].customlabel+'</span>';
									}
								}
							}
						});
	               }
	               
					str +=	'</div>'+
							'<div class="layui-col-md2 my-font-black"><button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="followTableUpdate('+item.id+')">修改</button>'+
							'<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="relationchart('+item.id+')">关系拓扑图</button>'+
							'</div>'+
							'</div>'+
							'</td>' +
							'</tr>';
				}
				$("#tbody_result").html(str);
				if(viewflag){
					viewer = new Viewer(document.getElementById("tbody_result"),{
						url:	'data-original',
						navbar:	false
					});
					viewflag=false;
				}else viewer.update();
				layer.close(index_info);
			},
            error:function() {
                layer.close(index_info);
                layer.alert("长时间未响应！请重新登录！",function(){
	                window.top.location.href="login.jsp";
                });
            }
		});
	}
function openlabelcheck(content){
	var index = layui.layer.open({
		title : "人员标签审核",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : content,
		area: ['1000', '700px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回风险人员列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		},
		cancel:function(){
			$("#search").click();
		}
	})			
	layui.layer.full(index);
}
 function followTableUpdate(personnelid){
   var index = layui.layer.open({
		title : "修改风险人员信息",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getPersonnelExtendUpdate.do?personnelid='+personnelid+'&page=updateWhole&menuid='+${param.menuid },
		area: ['800', '700px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		},
		cancel:function(){
			$("#search").click();
		}
	})			
	layui.layer.full(index);
 }
 function relationchart(personnelid){
 	var index = layui.layer.open({
		title : "关系拓扑图",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : '<c:url value="getRelationchart.do"/>?personnelid='+personnelid,
		area: [document.body.scrollWidth-50, '700px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		}
	});
	layui.layer.full(index);
 }
 function addPersonnelExtend(){
 	var index = layui.layer.open({
		title : "添加风险人员",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : '<c:url value="/jsp/personel/whole/add.jsp"/>?menuid='+${param.menuid },
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
 }
 function getDefaultPhoto(personnelid){
		var str='<img style="cursor:pointer;"';
		$.ajax({
			type:		'POST',
			url :       '<c:url value="/getPersonnelPhotoFlowList.do"/>?personnelid='+personnelid,
			dataType:	'json',
			async:      false,
			success:	function(data){
				var defaultid=0;
				if(data.count>0){
					$.each(data.photos, function(i) {
						if(this.defaultflag==1){
							defaultid=this.id;
							//$('#'+photoid).attr('src','../uploadFiles/pictures/'+this.fileallName);
							//str+=' src="../uploadFiles/pictures/'+this.fileallName+'"';
							if(this.validflag>1)str+=' src="../uploadFiles/'+this.fileallName+'"';
							else str+=' src="../uploadFiles/pictures/'+this.fileallName+'"';
							return false;
						}
						
					});
				}
				if(defaultid==0){
					//$('#'+photoid).attr('src','<c:url value="/images/nophoto.png"/>');
					str+=' src="<c:url value="/images/nophoto.png"/>"';
				}
				//$('#'+photoid).attr('onload',"javascript:DrawImage(this,80,100)");
				str+=' onload="javascript:DrawImage(this,80,100)">';
			}
		});
		return str;
	}
	
	/**
	 * 图片按宽高比例进行自动缩放
	 * @param ImgObj
	 * 缩放图片源对象
	 * @param maxWidth
	 * 允许缩放的最大宽度
	 * @param maxHeight
	 * 允许缩放的最大高度
	 * @usage 
	 * 调用：<img src="图片" onload="javascript:DrawImage(this,100,100)">
	 */
	function DrawImage(ImgObj, maxWidth, maxHeight){
		var image = new Image();
		//原图片原始地址（用于获取原图片的真实宽高，当<img>标签指定了宽、高时不受影响）
		image.src = ImgObj.src;
		// 用于设定图片的宽度和高度
		var tempWidth;
		var tempHeight;
	
		if(image.width > 0 && image.height > 0){
			//原图片宽高比例 大于 指定的宽高比例，这就说明了原图片的宽度必然 > 高度
			if (image.width/image.height >= maxWidth/maxHeight) {
				if (image.width > maxWidth) {
					tempWidth = maxWidth;
					// 按原图片的比例进行缩放
					tempHeight = (image.height * maxWidth) / image.width;
				} else {
					// 按原图片的大小进行缩放
					tempWidth = image.width;
					tempHeight = image.height;
				}
			} else {// 原图片的高度必然 > 宽度
				if (image.height > maxHeight) { 
					tempHeight = maxHeight;
					// 按原图片的比例进行缩放
					tempWidth = (image.width * maxHeight) / image.height; 
				} else {
					// 按原图片的大小进行缩放
					tempWidth = image.width;
					tempHeight = image.height;
				}
			}
			// 设置页面图片的宽和高
			ImgObj.height = tempHeight;
			ImgObj.width = tempWidth;
			// 提示图片的原来大小
			ImgObj.alt = image.width + "×" + image.height;
		}
	}
	
	function choosePage(){
		var toPnum = $("#toPnum").val();
		$("#pageNumber").val(toPnum);
		$("#search").click();
	}

	$("select[name='pagenum1']").change(function(){
		$("#limit").val($(this).val());
		$("#pageNumber").val("1");
		$("#toPnum").val("");
		$("#search").click();
	});
	
	$("a.layui-laypage-prev").click(function(){
		var nowpage = $("#pageNumber").val();
		var maxy = $("#maxCount").val();
		if(nowpage > 1 && nowpage <=maxy){
			$("#pageNumber").val(nowpage-1);
			$("#search").click();
		}
	});
	
	$("a.layui-laypage-next").click(function(){
		var nowpage = parseInt($("#pageNumber").val());
		var maxy = parseInt($("#maxCount").val());
		if(nowpage >= 1 && nowpage < maxy){
			$("#pageNumber").val(nowpage+1);
			$("#search").click();
		}
	});
 
 function showinfoPersonnelExtend(personnelid){
 	var index = layui.layer.open({
		title : thistitle+"详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getPersonnelExtendUpdate.do?personnelid='+personnelid+'&memo='+thistitle+'&menuid='+${param.menuid}+'&page=showinfoWhole',
		area: ['800', '650px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		}
	})			
	layui.layer.full(index);
 }
 function updatePersonnelExtend(personnelid,personlabel){
 	var labeltitle="",content="";
 	switch(personlabel){
 		case 1:
 			labeltitle="修改涉稳人员";
 			content=locat+'/getWenGradeUpdate.do?personnelid='+personnelid+'&page=update1&menuid='+${param.menuid };
 			break;
 		case 2:
 			labeltitle="修改涉恐人员";
 			content=locat+'/getKongPersonelUpdate.do?personnelid='+personnelid+'&menuid='+${param.menuid}+'&page=update';
 			break;
 		case 3:
 			labeltitle="修改涉黑人员";
 			content=locat+'/getHeiPersonelUpdate.do?personnelid='+personnelid+'&menuid='+${param.menuid}+'&page=update';
 			break;
 		case 4:
 			labeltitle="修改涉毒人员";
 			content=locat+'/getDuPersonelUpdate.do?personnelid='+personnelid+'&menuid='+${param.menuid}+'&page=all_update';
 			break;
 		case 9:
 			labeltitle="修改政保人员";
 			content=locat+'/getPersonnelExtendUpdate.do?personnelid='+personnelid+'&personlabelid='+personlabel+'&page=update_zhengbao&menuid='+${param.menuid };
 			break;
 		case 2046:
 			labeltitle="修改治安人员";
 			content=locat+'/getZaPersonById.do?id='+personnelid+'&menuid='+${param.menuid };
 			break;
 		default:
 			labeltitle="修改风险人员";
 			content=locat+'/getPersonnelExtendUpdate.do?personnelid='+personnelid+'&personlabelid='+personlabel+'&page=update&menuid='+${param.menuid };
 			break;
 	}
 	var index = layui.layer.open({
		title : labeltitle,
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : content,
		area: ['800', '650px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		},
		cancel:function(){
			$("#search").click();
		}
	})			
	layui.layer.full(index);
 }
 function showinfoPersonnelInfo(personlabelid,id){
    var url="";
    var title="";
    if(personlabelid==1){//涉稳
    		url=	locat+'/getWenGradeUpdate.do?personnelid='+id+'&page=update1&menuid='+${param.menuid };
    		title="修改涉稳人员信息";
    }else if(personlabelid==2){//涉恐
          url=	 locat+'/getKongPersonelUpdate.do?personnelid='+id+'&menuid='+${param.menuid}+'&page=update';
          title="修改涉恐人员信息";
    }else if(personlabelid==3){//涉黑
          url=	locat+'/getHeiPersonelUpdate.do?personnelid='+id+'&menuid='+${param.menuid}+'&page=update';
          title="修改涉黑人员信息";
    }else if(personlabelid==4){//涉毒   判断是社会吸毒人员还是制毒人员
          url=locat+'/getDuPersonelUpdate.do?personnelid='+id+'&menuid='+${param.menuid}+'&page=all_update';
          title="修改涉毒人员信息";
    }
    
    	var index = layui.layer.open({
					title : title,
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : url,
					area: ['800', '700px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					},
					cancel:function(){
						layui.table.reload('followTable', { }); 
					}
				})			
				layui.layer.full(index);
				
 }
 
</script>
<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
</body>

</html>