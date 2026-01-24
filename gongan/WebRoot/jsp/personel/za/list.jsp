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
    <title>治安人员查询</title>
   <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
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
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="homeplace" placeholder=" 现居住地详址：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<div id="attributelabels" style="width:360px;"></div>
		</div>
		<!-- 新增查询条件 -->
<%--		<div class="layui-inline" style="width:150px;">--%>
<%--			<select id="hasSheduRecord">--%>
<%--				<option value="">涉赌前科: 全部</option>--%>
<%--				<option value="1">有涉赌前科</option>--%>
<%--				<option value="0">无涉赌前科</option>--%>
<%--			</select>--%>
<%--		</div>--%>
<%--		<div class="layui-inline" style="width:150px;">--%>
<%--			<select id="hasSechangRecord">--%>
<%--				<option value="">涉娼前科: 全部</option>--%>
<%--				<option value="1">有涉娼前科</option>--%>
<%--				<option value="0">无涉娼前科</option>--%>
<%--			</select>--%>
<%--		</div>--%>
		<div class="layui-inline" style="width:150px;">
			<select id="isMinor">
				<option value="">是否未成年: 全部</option>
				<option value="1">是</option>
				<option value="0">否</option>
			</select>
		</div>
    <div class="layui-inline" style="width:150px;">
        <input class="layui-input" type="text" id="punishDateStart" placeholder="处罚日期起" autocomplete="off" readonly>
    </div>
    <div class="layui-inline" style="width:150px;">
        <input class="layui-input" type="text" id="punishDateEnd" placeholder="处罚日期止" autocomplete="off" readonly>
    </div>
         <br>
    <div class="layui-inline" style="line-height:38px;font-weight:600;">
        涉赌人员搜索：
    </div>
		<div class="layui-inline" style="width:150px;">
			<select id="duPersonAttribute">
				<option value="">涉赌人员属性</option>
			</select>
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="duMethod">
				<option value="">涉赌方式</option>
			</select>
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="duPart">
				<option value="">涉赌部位</option>
			</select>
		</div>
		<br>
    <div class="layui-inline" style="line-height:38px;font-weight:600;">
        涉娼人员搜索：
    </div>
		<div class="layui-inline" style="width:150px;">
			<select id="changPersonAttribute">
				<option value="">涉娼人员属性</option>
			</select>
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="changMethod">
				<option value="">涉娼方式</option>
			</select>
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="changType">
				<option value="">涉娼类型</option>
			</select>
		</div>
    <div class="layui-inline" style="width:150px;">
        <select id="isMinorCase">
            <option value="">未成年案件</option>
        </select>
    </div>

		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="button" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
		<script type="text/html" id="toolbarDemo">
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
            <c:if test='${fn:contains(param.buttons,"删除")}'>
   			      <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
             </c:if>
            <c:if test='${fn:contains(param.buttons,"导入")}'>
				  <button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>
             </c:if>
            <c:if test='${fn:contains(param.buttons,"导出")}'>
				  <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon">&#xe601;</i>导 出</button>
             </c:if>
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

// 加载涉赌人员属性
function loadDuPersonAttribute(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+301,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#duPersonAttribute").append(options);
		}
	});
}

// 加载涉赌方式
function loadDuMethod(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+302,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#duMethod").append(options);
		}
	});
}

// 加载涉赌部位
function loadDuPart(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+303,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#duPart").append(options);
		}
	});
}

// 加载涉娼人员属性
function loadChangPersonAttribute(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+304,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#changPersonAttribute").append(options);
		}
	});
}

// 加载涉娼方式
function loadChangMethod(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+305,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#changMethod").append(options);
		}
	});
}

// 加载涉娼类型
function loadChangType(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+306,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#changType").append(options);
		}
	});
}

$(document).ready(function(){
	getpersontype();
	loadDuPersonAttribute();
	loadDuMethod();
	loadDuPart();
	loadChangPersonAttribute();
	loadChangMethod();
	loadChangType();
});

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});
layui.use(['table','form','zTreeSelectM','laydate'], function(){
  var table = layui.table,
  zTreeSelectM = layui.zTreeSelectM,
  form = layui.form,
  laydate = layui.laydate;

  // 处罚日期选择器
  laydate.render({
    elem: '#punishDateStart',
    type: 'date'
  });
  laydate.render({
    elem: '#punishDateEnd',
    type: 'date'
  });
	//初始化
	<%--var _zTreeSelectM1 = zTreeSelectM({--%>
	<%--    elem: '#jurisdictunit1',//元素容器【必填】          --%>
    <%--    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',--%>
	<%--    type: 'get',  //设置了长度    --%>
	<%--    selected: [],//默认值            --%>
	<%--    max: 100,//最多选中个数，默认5            --%>
	<%--    name: 'jurisdictunit1',//input的name 不设置与选择器相同(去#.)--%>
	<%--    delimiter: ',',//值的分隔符  --%>
	<%--    tips:' 责任管辖单位：',         --%>
	<%--    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 --%>
	<%--    zTreeSetting: { //zTree设置--%>
	<%--        check: {--%>
	<%--            enable: true,--%>
	<%--            chkboxType: { "Y": "", "N": "" }--%>
	<%--        },--%>
	<%--        data: {--%>
	<%--            simpleData: {--%>
	<%--                enable: false--%>
	<%--            },--%>
	<%--            key: {--%>
	<%--                name: 'name',--%>
	<%--                children: 'children'--%>
	<%--            }--%>
	<%--        },--%>
	<%--        view: {--%>
	<%--        	showIcon: false--%>
	<%--		}--%>
	<%--    }--%>
	<%--});--%>
   var _zTreeSelectM2 = zTreeSelectM({
	    elem: '#attributelabels',//元素容器【必填】          
		data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid='+${param.personlabelid},
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'attributelabels',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符  
	    tips:' 人员子标签：',         
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
    url: '<c:url value="/searchZaPersonnel.do"/>',
    method:'post',
    where: {zslabel1: ${param.personlabelid}},
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'true',align:"center"},
        {field:'personname', title: '姓名', width:100,align:"center",templet: function (item) {
        	return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";
        }},
    	{field:'cardnumber', title: '身份证号码', width:180,align:"center"} ,
        {field:'sexes', title: '性别', width:100} ,
        {field:'officeName', title: '年龄', width:100,templet: function (item) {
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
        {field:'houseplace', title: '户籍地址', width:200,align:"center"} ,
        {field:'homeplace', title: '现住地址', width:200,align:"center"} ,
        {field:'homePoliceStation', title: '现住地派出所', width:150,align:"center"},
        {field:'isMinorDisplay', title: '是否未成年', width:100,align:"center",templet: function (item) {
                if(item.isMinor==1){
                    return "<span style='color:red;'>是</span>";
                }else{
                    return "<span>否</span>";
                }
            }},
        {field:'hasSheduRecord', title: '涉赌前科', width:100,align:"center",templet: function (item) {
        		if(item.hasSheduRecord==1){
					return "<span style='color:red;'>有</span>";
				}else{
					return "<span>无</span>";
				}
           }},
        {field:'hasSechangRecord', title: '涉娼前科', width:100,align:"center",templet: function (item) {
        		if(item.hasSechangRecord==1){
					return "<span style='color:red;'>有</span>";
				}else{
					return "<span>无</span>";
				}
           }},
        {field:'policename2', title: '人员类型', width:200,templet: function (item) {
               var str="";
               if(item.zslabel2&&item.zslabel2!=""){
	             	var zslabel1s=item.zslabel2.split(",");
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
							str+="<span><font color='red'>"+data.attributelabel+"&nbsp;&nbsp;</font></span>";
						}
					});
	             		}
               }
                return str;
           }},
        {field:'handleUnit', title: '打处单位', width:150,align:"center"}
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
				content : '<c:url value="/jsp/personel/za/add.jsp"/>?menuid=${param.menuid}&zslabel1=${param.personlabelid}&typename='+thistitle,
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
			layui.layer.full(index);
	    break;
   case 'update':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	   if(datas!=""){
	   var id=datas[0].id;
	    var index = layui.layer.open({
					title : "修改"+thistitle+"信息",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getZaPersonById.do?id='+id+'&buttons=${param.buttons }&menuid=${param.menuid }',
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
	        $.getJSON(locat+"/cancelZaPerson.do?id="+id+'&personnelid='+${param.personlabelid}+"&menuid="+${param.menuid },{},function(data) {
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
			content : '<c:url value="/jsp/personel/za/export.jsp?menuid='+${param.menuid}+'&personlabelid='+${param.personlabelid}+'&personlabelname='+thistitle+'"/>',
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
					zslabel1: ${param.personlabelid},
					cardnumber: $("#cardnumber").val(),
					personname: $("#personname").val(),
					homeplace: $("#homeplace").val(),
					jdunit1: $("input[name='jurisdictunit1']").val(),
					jdpolice1: $("#jurisdictpolice1").val(),
					persontype: $("#persontype").val(),
					attributelabels:$("input[name='attributelabels']").val(),
					hasSheduRecord: $("#hasSheduRecord").val(),
					hasSechangRecord: $("#hasSechangRecord").val(),
					isMinor: $("#isMinor").val(),
					duPersonAttribute: $("#duPersonAttribute").val(),
					duMethod: $("#duMethod").val(),
					duPart: $("#duPart").val(),
					changPersonAttribute: $("#changPersonAttribute").val(),
					changMethod: $("#changMethod").val(),
					changType: $("#changType").val(),
					punishDateStart: $("#punishDateStart").val(),
					punishDateEnd: $("#punishDateEnd").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset").click(function () {
		   // 重置表单
		   $('form')[0].reset();
		   // 清空输入框
		   $("#cardnumber").val('');
		   $("#personname").val('');
		   $("#homeplace").val('');
		   $("#jurisdictpolice1").val('');
		   $("#punishDateStart").val('');
		   $("#punishDateEnd").val('');
		   // 重置select下拉框为第一个选项
		   $("#persontype").prop('selectedIndex', 0);
		   $("#hasSheduRecord").prop('selectedIndex', 0);
		   $("#hasSechangRecord").prop('selectedIndex', 0);
		   $("#isMinor").prop('selectedIndex', 0);
		   $("#duPersonAttribute").prop('selectedIndex', 0);
		   $("#duMethod").prop('selectedIndex', 0);
		   $("#duPart").prop('selectedIndex', 0);
		   $("#changPersonAttribute").prop('selectedIndex', 0);
		   $("#changMethod").prop('selectedIndex', 0);
		   $("#changType").prop('selectedIndex', 0);
		   // 清空zTreeSelectM组件
		   $("input[name='jurisdictunit1']").val('');
		   $("input[name='attributelabels']").val('');
		   // 清空zTreeSelectM显示框
		   // $("#jurisdictunit1 .zTreeSelectM-input").html('<span class="zTreeSelectM-placeholder"> 责任管辖单位：</span>');
		   $("#attributelabels .zTreeSelectM-input").html('<span class="zTreeSelectM-placeholder"> 人员子标签：</span>');
		   // 重新渲染表单
		   form.render('select');
		   // 重新加载表格，只传必要参数
		   table.reload('followTable', {
				where: {
					zslabel1: ${param.personlabelid}
				},
				page: {
					curr: 1
				}
		   });
		});
 });
 
 function showinfoPersonnelExtend(id){
 	var index = layui.layer.open({
		title : thistitle+"详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getPersonnelExtendUpdate.do?id='+id+'&personlabelid='+${param.personlabelid}+'&memo='+thistitle+'&menuid='+${param.menuid}+'&page=showinfo',
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
 function showinfoPersonel(id){
         var index = layui.layer.open({
					title : "治安人员详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getZaPersonelInfo.do?personnelid='+id+'&menuid='+${param.menuid},
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
 
 
 
</script>
</body>

</html>