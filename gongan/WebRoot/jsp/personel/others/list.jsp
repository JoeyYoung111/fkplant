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
    <title></title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
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
			<div id="attributelabels" style="width:643px;"></div>
		</div>
		<br>
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="telnumber" placeholder=" 名下手机号：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="homeplace" placeholder=" 现居住地详址：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:212px;">
			<select id="jointcontrollevel">
				<option value=""> 联控级别: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:212px;">
			<select id="incontrollevel" style="width:212px;">
				<option value=""> 在控状态: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:212px;">
			<select id="persontype">
				<option value=""> 户籍类别: 全部</option>
			</select>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
		<script type="text/html" id="toolbarDemo">
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
            <c:if test='${fn:contains(param.buttons,"删除")}'>
   			     <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
            </c:if>
            <button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
            <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导 出</button>   
   		</script>
	  <script type="text/html" id="barButton">
           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
     </script>
</form>
</div>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
var locat = (window.location+'').split('/'); 
var now=new Date();
var thistitle=parent.$("li.layui-this").find("cite").text();
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
function getjointcontrollevel(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+47,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#jointcontrollevel").append(options);
		}
	});
}
function getincontrollevel(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+22,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#incontrollevel").append(options);
		}
	});
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
	getjointcontrollevel();
	getincontrollevel();
	getpersontype();
});

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});
layui.use(['table','form','zTreeSelectM'], function(){
  var table = layui.table,
  zTreeSelectM = layui.zTreeSelectM,
  form = layui.form;
	//初始化
	var _zTreeSelectM1 = zTreeSelectM({
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
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   	defaultToolbar: ['filter', 'print'],
    url: '<c:url value="/searchPersonnelExtend.do"/>?personlabelid=0',
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
    	{field:'personname', title: '姓名', width:100,templet: function (item) {
		   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonnelExtend("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";
           }},
    	{field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
		   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonnelExtend("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";
           }} ,
        {field:'sexes', title: '性别', width:65} , 
        {field:'officeName', title: '年龄', width:65,templet: function (item) {
          		var age=now.getFullYear();
				var cardnumber=item.cardnumber.toString();
				var length=cardnumber.length;
				if(length==15){
					age-=parseInt(cardnumber.substring(6,8))+1900;
					age++;
				}else if(length==18){
					age-=parseInt(cardnumber.substring(6,10));
					age++;
				}else{
				   age=''; 
				}
				return "<span>"+age+"</span>";
           }},
        
        {field:'persontype', title: '户籍类别', width:90} ,
        {field:'homeplace', title: '现居住地详址'} ,
        {field:'policename2', title: '其他人员类型', width:180,templet: function (item) {
          	   var policename2Str=item.policename2;
               var unitname2Str=item.unitname2;
               var policename2_lists=policename2Str.split(",");
               var unitname2_lists=unitname2Str.split(",");
               var str="";
               if(policename2_lists.length>0){
               		for(k=0;k<policename2_lists.length;k++){
                      str+="<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonnelInfo("+unitname2_lists[k]+","+item.personnelid+");'><font color='red'>"+policename2_lists[k]+"&nbsp;&nbsp;</font></span>";
                }
               }
                return str;
           }},
        {field:'unitname1', title: '管辖责任单位', width:120} ,
        {field:'policename1', title: '管辖责任民警', width:120} ,
        {field:'policephone1', title: '民警电话', width:120} ,
        {field:'jointcontrollevel', title: '联控级别', width:90} ,
        {field:'incontrollevel', title: '在控状态', width:90} ,
        {field:'addoperator', title: '建档人', width:90} ,
        {field:'addtime', title: '建档时间', width:170} 
        //{field: 'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
    ]],
    page: true,
    limit: 10
  });
  
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'add':
   		var index = layui.layer.open({
				title : "添加"+thistitle,
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getPersonnelExtendUpdate.do?id=0&personlabelid=0&personlabelname='+thistitle+'&page=addothers&menuid='+${param.menuid },
				area: ['1000', '600px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})			
			//layui.layer.full(index);
	    break;
   case 'update':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	   if(datas!=""){
	   var id=datas[0].id;
	    var index = layui.layer.open({
					title : "修改"+thistitle+"信息",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getPersonnelExtendUpdate.do?id='+id+'&buttons='+'${param.buttons }'+'&page=update&menuid='+${param.menuid },
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					},
					cancel:function(){
						table.reload('followTable', { }); 
					}
				})			
				layui.layer.full(index);
				}else{
					layer.alert("请先选择修改哪条数据！");
				}
	    break;
	case 'cancel':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	    if(datas!=""){
	   var id=datas[0].id;
	    layer.confirm('确定删除此'+thistitle+'信息？', function(index){
	        layer.close(index);
	        $.getJSON(locat+"/cancelPersonnelExtend.do?id="+id+"&menuid="+${param.menuid },{},function(data) {
				var str = eval('(' + data + ')');
	        	 if (str.flag ==1) {		                          
			          top.layer.msg("数据删除成功！"); 	
			          table.reload('followTable', { });                 
			       }else{
				       top.layer.msg("删除失败!");
			      }			      	    		
	        	});      
			});
			}else{
				layer.alert("请先选择删除哪条数据！");
				}
	    break;
	    case 'export':
	   	var index = layui.layer.open({
			title : thistitle+"信息导出",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="/jsp/personel/custom/export.jsp?menuid='+${param.menuid}+'&personlabelid=0&personlabelname='+thistitle+'"/>',
			area: ['1000px', '600px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		});
	   	break;
	   	case 'import':
		   var index = layui.layer.open({
				 title : "导入"+thistitle+"信息",
				 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				 content : "<c:url value="/jsp/personel/custom/import.jsp?menuid=${param.menuid }&personlabelid=${param.personlabelid }"/>",
				  area: ['600', '650'],
				 maxmin: true,
				 offset:['30'], 
				 btn:['导入','关闭'],
				 yes:function(index,layero){   //通过回调得到iframe的值
				  var body = layer.getChildFrame('body',index);//建立父子联系
			                 var iframeWin = window[layero.find('iframe')[0]['name']];              
			                 body.find("#btns").click();
				 },
				end: function () {
					$("#search").click(); 
				}
			 });	
		    break;
   };
   
 });	
    	//搜索查询
  		$("#search").click(function () {
  			table.reload('followTable', {
				where: { 
					cardnumber: $("#cardnumber").val(),
					personname: $("#personname").val(),
					homeplace: $("#homeplace").val(),
					attributelabels: $("input[name='attributelabels']").val(),
					jointcontrollevel: $("#jointcontrollevel").val(),
					incontrollevel: $("#incontrollevel").val(),
					persontype: $("#persontype").val(),
					telnumber:	$("#telnumber").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
 });
 
 function showinfoPersonnelExtend(id){
 	var index = layui.layer.open({
		title : thistitle+"详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getPersonnelExtendUpdate.do?id='+id+'&memo='+thistitle+'&menuid='+${param.menuid}+'&page=showinfo',
		area: ['800', '750px'],
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
					area: ['800', '750px'],
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
</body>

</html>