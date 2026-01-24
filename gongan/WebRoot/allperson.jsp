<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>风险人员综合查询</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/query.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
<%
	UserSession userSession = (UserSession) session.getAttribute("userSession");
%>
<body class="layui-layout-body query-main">
<div class="query-title">
	<img src="<c:url value="/images/query/logo.png"/>">
</div>
<div class="query-content layui-fluid layui-anim layui-anim-scale">
	<!-- 上面条件部分 -->
	<div class="condition layui-row" style="padding-left: 10px;">
		<form class="layui-form" action="" lay-filter="example" onsubmit="return false;">
			<table class="layui-table my-table query-table" lay-skin="nob">
				<colgroup>
					<col width="120">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
				</colgroup>
				<tbody>
					<tr class="my-nobg">
						<td colspan="2" class="text-align-c my-font20 my-font-blue"><font size="5">风险人员综合查询</font></td>
						<td colspan="8">
							<div class="my-query-box">
								<div class="layui-col-md10">
									<div class="layui-form-item my-form-item">
										<input type="text" value="" class="layui-input" id="searchtext">
									</div>
								</div>
								<div class="layui-col-md2">
									<div class="layui-form-item my-form-item">
										<select id="searchField">
											<option value="cardnumber" selected>身份证</option>
											<option value="personname">姓名</option>
										</select>
									</div>
								</div>
							</div>
						</td>
						<td>
							<button type="button" id="search" class="layui-btn layui-btn-normal layui-btn-sm" style="width: 80px;">查询</button>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td class="text-align-r">当前选择标签：</td>
						<td colspan="9" style="padding-left: 30px;height: 50px;" id="radios_box"></td>
						<td>
							<button type="button" id="clearRadios" class="layui-btn layui-btn-normal layui-btn-sm"
								style="width: 80px;">清空</button>
						</td>
						<td>
							<button type="button" style="display:none;" id="show_label" class="layui-btn layui-btn-primary layui-btn-sm">
							<i class="layui-icon">&#xe61a;</i>	
							</button>
						</td>
					</tr>
					<tr id="show_label1">
						<td class="text-align-r">年龄：</td>
						<td class="text-align-c my-radio-tag">
							<input type="radio" name="ages" value="" title="全部" checked lay-filter="my_radio">
						</td>
						<td colspan="10" class="my-radio-tag">
							<input type="radio" name="ages" value="1" title="18岁以下" lay-filter="my_radio">
							<input type="radio" name="ages" value="2" title="18-30岁" lay-filter="my_radio" >
							<input type="radio" name="ages" value="3" title="31-40岁" lay-filter="my_radio" >
							<input type="radio" name="ages" value="4" title="41-50岁"  lay-filter="my_radio">
							<input type="radio" name="ages" value="5" title="50岁以上"  lay-filter="my_radio">
						</td>
					</tr>
					<tr id="show_label2">
						<td class="text-align-r">婚姻状况：</td>
						<td class="text-align-c my-radio-tag">
							<input type="radio" name="marrystatus" value="" title="全部" checked lay-filter="my_radio">
						</td>
						<td colspan="10" class="my-radio-tag" id="marrystatus">
						</td>
					</tr>
					<tr id="show_label3">
						<td class="text-align-r">文化程度：</td>
						<td class="text-align-c my-radio-tag">
							<input type="radio" name="education" value="" title="全部" checked lay-filter="my_radio">
						</td>
						<td colspan="10" class="my-radio-tag" id="education">
						</td>
					</tr>
					<tr id="show_label4">
						<td class="text-align-r">人员类别：</td>
						<td class="text-align-c my-radio-tag">
							<input type="radio" name="persontype" value="" title="全部" checked lay-filter="my_radio">
						</td>
						<td colspan="10" class="my-radio-tag" id="persontype">
						</td>
					</tr>
					<tr id="show_label5">
						<td class="text-align-r">人员标签：</td>
						<td class="text-align-c my-radio-tag">
							<input type="radio" name="personlabel" value="" title="全部" checked lay-filter="my_radio">
						</td>
						<td colspan="9" class="my-radio-tag" id="personlabels">
<%--							<input type="radio" name="personlabel" value="1" title="涉稳人员" lay-filter="my_radio">--%>
<%--							<input type="radio" name="personlabel" value="2" title="涉恐人员" lay-filter="my_radio">--%>
<%--							<input type="radio" name="personlabel" value="3" title="涉黑人员" lay-filter="my_radio">--%>
<%--							<input type="radio" name="personlabel" value="4" title="涉毒人员" lay-filter="my_radio">--%>
						</td>
						<td>
							<button type="button" id="hide_label" class="layui-btn layui-btn-primary layui-btn-sm">
							<i class="layui-icon">&#xe619;</i>	
							</button>
						</td>
					</tr>
					<!-- 标签带hover事件 -->
					<tr style="border-top: 1px solid #CCCCCC;">
						<td class="text-align-r">更多查询条件：</td>
						<td colspan="11">
							<div class="layui-form-item my-form-item">
								<div class="layui-input-inline"  style="width: 150px;">
									<select id="nation"  >
										<option value="">--请选择民族--</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 150px;">
									<select id="soldierstatus">
										<option value="">--请选择兵役情况--</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 150px;">
									<select id="heathstatus">
										<option value="">--请选择健康状态--</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 150px;">
									<select id="politicalposition">
										<option value="">--请选择政治面貌--</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 150px;">
									<select id="faith">
										<option value="">--请选择宗教信仰--</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
<%--					<tr>--%>
<%--						<td></td>--%>
<%--						<td colspan="11">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<div class="layui-input-inline" style="width: 470px;">--%>
<%--									<div id="attributelabels"></div>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</td>--%>
<%--					</tr>--%>
<%--					<tr>--%>
<%--						<td></td>--%>
<%--						<td colspan="11">--%>
<%--							<div class="layui-form-item my-form-item">--%>
<%--								<div class="layui-input-inline" id="personlabelshow1" style="display:none;width: 310px;">--%>
<%--									<div id="personneltype1"></div>--%>
<%--								</div>--%>
<%--								<div class="layui-input-inline" id="personlabelshow4" style="display:none;width: 310px;">--%>
<%--									<div id="personneltype4"></div>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</td>--%>
<%--					</tr>--%>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 搜索结果 -->
	<div class="result">
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
			<tbody id="tbody_result">
				
			</tbody>
		</table>
	</div>
	<div class="layui-table-page">
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
</div>
<script type="text/javascript">
	$(document).ready(function(){
			var wm='<%=userSession.getLoginUserName()%>'+'\n';
			var number=<%=userSession.getLoginContactnumber()%>!=null?'<%=userSession.getLoginContactnumber()%>':'';
			if(number.length==11)wm+=number.substring(0,3)+"****"+number.substring(7);
			else wm+=number;
			watermark({ watermark_txt: wm })//传入动态水印内容  可以从Session中拿出你需要的用户信息
			function watermark(settings) {
			//默认设置
			var defaultSettings={
			    watermark_txt:"text",
			    watermark_x:50,//水印起始位置x轴坐标
			    watermark_y:120,//水印起始位置Y轴坐标
			    watermark_rows:20,//水印行数
			    watermark_cols:20,//水印列数
			    watermark_x_space:100,//水印x轴间隔
			    watermark_y_space:50,//水印y轴间隔
			    watermark_color:'#000000',//水印字体颜色
			    watermark_alpha:0.1,//水印透明度
			    watermark_fontsize:'18px',//水印字体大小
			    watermark_font:'微软雅黑',//水印字体
			    watermark_width:120,//水印宽度
			    watermark_height:80,//水印长度
			    watermark_angle:15//水印倾斜度数
			};
			//采用配置项替换默认值，作用类似jquery.extend
			if(arguments.length===1&&typeof arguments[0] ==="object" )
			{
			    var src=arguments[0]||{};
			    for(key in src)
			    {
			        if(src[key]&&defaultSettings[key]&&src[key]===defaultSettings[key])
			            continue;
			        else if(src[key])
			            defaultSettings[key]=src[key];
			    }
			}

			var oTemp = document.createDocumentFragment();

			//获取页面最大宽度
			var page_width = Math.max(document.body.scrollWidth,document.body.clientWidth);
			//获取页面最大长度
			var page_height = Math.max(document.body.scrollHeight,document.body.clientHeight);

			//如果将水印列数设置为0，或水印列数设置过大，超过页面最大宽度，则重新计算水印列数和水印x轴间隔
			if (defaultSettings.watermark_cols == 0 || (parseInt(defaultSettings.watermark_x + defaultSettings.watermark_width *defaultSettings.watermark_cols + defaultSettings.watermark_x_space * (defaultSettings.watermark_cols - 1)) > page_width)) {
			    var cols=parseInt((page_width - defaultSettings.watermark_x + defaultSettings.watermark_x_space) / (defaultSettings.watermark_width + defaultSettings.watermark_x_space));
			    defaultSettings.watermark_cols = cols<8?cols:8;
			    //defaultSettings.watermark_x_space = parseInt((page_width - defaultSettings.watermark_x - defaultSettings.watermark_width * defaultSettings.watermark_cols) / (defaultSettings.watermark_cols - 1));
			}
			//如果将水印行数设置为0，或水印行数设置过大，超过页面最大长度，则重新计算水印行数和水印y轴间隔
			if (defaultSettings.watermark_rows == 0 ||(parseInt(defaultSettings.watermark_y + defaultSettings.watermark_height * defaultSettings.watermark_rows + defaultSettings.watermark_y_space * (defaultSettings.watermark_rows - 1)) > page_height)) {
			    var rows=parseInt((defaultSettings.watermark_y_space + page_height - defaultSettings.watermark_y) / (defaultSettings.watermark_height + defaultSettings.watermark_y_space));
			    defaultSettings.watermark_rows = rows<6?6:rows;
			    //defaultSettings.watermark_y_space = parseInt((page_height - defaultSettings.watermark_y - defaultSettings.watermark_height * defaultSettings.watermark_rows) / (defaultSettings.watermark_rows - 1));
			}
			var x;
			var y;
			for (var i = 0; i < defaultSettings.watermark_rows; i++) {
			    y = defaultSettings.watermark_y + (defaultSettings.watermark_y_space + defaultSettings.watermark_height) * i;
			    for (var j = 0; j < defaultSettings.watermark_cols; j++) {
			        x = defaultSettings.watermark_x + (defaultSettings.watermark_width + defaultSettings.watermark_x_space) * j;

			        var mask_div = document.createElement('div');
			        mask_div.id = 'mask_div' + i + j;
			        mask_div.appendChild(document.createTextNode(defaultSettings.watermark_txt));
			        //设置水印div倾斜显示
			        mask_div.style.webkitTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
			        mask_div.style.MozTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
			        mask_div.style.msTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
			        mask_div.style.OTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
			        mask_div.style.transform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
			        mask_div.style.visibility = "";
			        mask_div.style.position = "absolute";
			        mask_div.style.left = x + 'px';
			        mask_div.style.top = y + 'px';
			        mask_div.style.overflow = "hidden";
			        mask_div.style.zIndex = "9999";
			        //mask_div.style.border="solid #eee 1px";
			        mask_div.style.opacity = defaultSettings.watermark_alpha;
			        mask_div.style.fontSize = defaultSettings.watermark_fontsize;
			        mask_div.style.fontFamily = defaultSettings.watermark_font;
			        mask_div.style.color = defaultSettings.watermark_color;
			        mask_div.style.textAlign = "center";
			        mask_div.style.width = defaultSettings.watermark_width + 'px';
			        mask_div.style.height = defaultSettings.watermark_height + 'px';
			        mask_div.style.display = "block";
			        mask_div.style.pointerEvents="none";
			        oTemp.appendChild(mask_div);
			    };
			};
			document.body.appendChild(oTemp);
			}
		
	});

	function setRadio(basicType,name){
	    $.ajax({
			 type:		'POST',
			 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+basicType,
			 dataType:	'json',
			 success:	function(data){					  
			      	var options = '';
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<input type="radio" name="'+name+'" value="'+this.value+'" title="'+this.value+'" lay-filter="my_radio">';
						});
					});
					$('#'+name).html(options);
					layui.form.render();
			   }
		});
	}
	function getFields(basicType,name){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+basicType,
			dataType:	'json',
			success:	function(data){
				var options = '';
				$.each(data.list, function(i, item) {
					$.each(item, function(i) {
						options += '<option value="' + this.text + '">' + this.text + '</option>';
					});
				});
				$("#"+name).append(options);
				layui.form.render();
			}
		});
	}
	function searchPersonLabel(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getRootAttributeLabel.do" />',
			dataType:	'json',
			async:   	false,
			success:	function(data){					  
				var str="";
				$.each(data,function(num,item){
					str+='<input type="radio" name="personlabel" value="'+item.id+'" title="'+item.attributelabel+'" lay-filter="my_radio">';
				});
				$("#personlabels").append(str);
				layui.form.render();
			}
		});
	}
	var index_info;
	layui.use(['form', 'table','layer','jquery'], function() {
		var $ = layui.jquery,
			form = layui.form,
			layer = layui.layer,
			table = layui.table;
		var btnArr = [];
			// 年龄
		index_info = layer.msg('正在查询数据，请稍候',{icon: 16,time:false,shade:0.8});
		form.on('radio(my_radio)', function (data) {
			if($.inArray(data.elem.title,btnArr)==-1&&data.value!=''){
				if(btnArr.length>9){
					layer.msg('最多选择10个标签＞︿＜');
				}else{
					var str='';
					btnArr.push(data.elem.title);
					str += '<button type="button" name="'+data.elem.name+'"';
					if(data.elem.name=="personlabel"||data.elem.name=="ages")str +=' label="'+data.value+'"';
					str +=' class="my-tag-item2 layui-anim layui-anim-scale">';
					str +=data.elem.title+'<div class="my-tag-close"></div></button>';
					$('#radios_box').append(str);
				}
			}
			//全部时删除已选子标签
			if(data.value==''){
				$.each($("button[name="+data.elem.name+"]"),function(i,item){
					var text=$(item).text();
					$(item).remove();
					btnArr.splice($.inArray(text,btnArr), 1); 
				});
			}
		});
		//删除已选标签
		$(document).on('click', '.my-tag-close', function() {
			var text = $(this).parent().text();
			$(this).parent().remove();
			btnArr.splice($.inArray(text,btnArr), 1); 
		});
		
		setRadio(16,'marrystatus');
		setRadio(19,'education');
		setRadio(20,'persontype');
		getFields(15,'nation');
		getFields(21,'soldierstatus');
		getFields(54,'heathstatus');
		getFields(17,'politicalposition');
		getFields(18,'faith');
		searchPersonLabel();
		$("#search").click(function () {
			index_info = layer.msg('正在查询数据，请稍候',{icon: 16,time:false,shade:0.8});
			getAllPersonnel();
		});
		$("#clearRadios").click(function () {
  			$(":radio[value='']").next('.layui-form-radio').click();
		});
		$("#show_label").click(function () {
			for(var i=1;i<6;i++){
				$("#show_label"+i).show();
			}
			$("#show_label").hide();
			$("#hide_label").show();
			$(".result").css("height","50%");
		});
		$("#hide_label").click(function () {
			for(var i=1;i<6;i++){
				$("#show_label"+i).hide();
			}
			$("#show_label").show();
			$("#hide_label").hide();
			$(".result").css("height","70%");
		});
		getAllPersonnel();
		form.render();
	});
	
	function getAllPersonnel(){
		var url='<c:url value="/getAllPersonnel.do"/>?';
		url+=$('#searchField').val()+"="+$('#searchtext').val();
 		var ages=[],marrystatus=[],education=[],persontype=[],personlabel=[];
 		if($("button.my-tag-item2").size()>0){
  			$.each($("button.my-tag-item2"),function(i,item){
  				switch($(item).attr("name")){
  					case "ages":
  						ages.push($(item).attr("label"));
  						break;
  					case "marrystatus":
  						marrystatus.push($(item).text());
  						break;
  					case "education":
  						education.push($(item).text());
  						break;
  					case "persontype":
  						persontype.push($(item).text());
  						break;
  					case "personlabel":
  						personlabel.push($(item).attr("label"));
  						break;
  				}
			});
 		}
		$.ajax({
			type:		'POST',
			url:		url,
			dataType:	'json',
			//async:		false,
			data:		{
							marrystatus:		marrystatus.join(","),
							education:			education.join(","),
							persontype:			persontype.join(","),
							nation: 			$("#nation").val(),
							soldierstatus: 		$("#soldierstatus").val(),
							heathstatus: 		$("#heathstatus").val(),
							politicalposition:	$("#politicalposition").val(),
							faith: 				$("#faith").val(),
							//需要解析
							ages:			ages.join(","),
							personlabel:	personlabel.join(","),
<%--							attributelabels: $("input[name='attributelabels']").val(),--%>
							//子类
<%--							personneltype1: $("input[name='personneltype1']").val(),--%>
<%--							personneltype4: $("input[name='personneltype4']").val(),--%>
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
				for( var i=0;i<data.length;i++){
					var item=data[i];
					var kkcount=0;
					$.ajax({
						type:		'POST',
						url:		'<c:url value="/getTrajectoryKKCount.do"/>',
						data:		{
										personcard_number: item.cardnumber
									},
						dataType:	'json',
						async:      false,
						success:	function(data){
							kkcount=(data.count>0?1:0);
						}
					});
					str += '<tr class="my-border-b">' +
							'<td align="center" style="padding-left:2px;padding-right:2px;">'+
							getDefaultPhoto(item.id)+
							'</td>' +
							'<td colspan="11">' +
							'<div class="layui-row my-font-bold my-font16 query-table-item">'+
							'<div class="layui-col-md2"><a onclick="show_info('+item.id+')" class="my-font-'+(kkcount>0?'red':'blue')+'" style="cursor:pointer;">'+item.personname+'</a></div>'+
							'<div class="layui-col-md4 my-font-black"><a onclick="show_info('+item.id+')" class="my-font-'+(kkcount>0?'red':'blue')+'" style="cursor:pointer;">'+item.cardnumber+'</a></div>'+
							'<div class="layui-col-md3  my-font-black">户籍地详址:'+(item.houseplace==null||item.houseplace==""?"":item.houseplace)+'</div>'+
							'<div class="layui-col-md3 my-font-black">现住地详址:'+(item.homeplace==null||item.homeplace==""?"":item.homeplace)+'</div>'+
							'</div>'+
							'<div class="layui-row query-table-item">'+
							'<div class="layui-col-md6">';
					if(item.sexes==null||item.sexes==""){
						var validator = new IDValidator();
						var cardinfo=validator.getInfo(item.cardnumber);
						if(cardinfo)str += '<span class="my-tag-item3 red">'+(cardinfo.sex==0?'女':'男')+'</span>';
						else str += '<span class="my-tag-item3 red">错误数据</span>';
					}else str += '<span class="my-tag-item3 red">'+item.sexes+'</span>';
					if(item.persontype!=null&&item.persontype!="")str +='<span class="my-tag-item3 green">'+item.persontype+'</span>';
					if(item.marrystatus!=null&&item.marrystatus!="")str +='<span class="my-tag-item3 green">'+item.marrystatus+'</span>';
					
					var now=new Date();
					var age=now.getFullYear();
					var cardnumber=item.cardnumber.toString();
					var length=cardnumber.length;
					if(length==15){
						age-=parseInt(cardnumber.substring(6,8))+1900;
						age++;
					}else if(length==18){
						age-=parseInt(cardnumber.substring(6,10));
						age++;
					}else age=0;
					str +='<span class="my-tag-item3 green">'+age+'岁</span>';
					
<%--					if(item.personlabel!=null&&item.personlabel!=""){--%>
<%--						var labels=item.personlabel.split(",");--%>
<%--						var labelsname=item.personlabelname.split(",");--%>
<%--						for(var j=0;j<labels.length;j++){--%>
<%--							if(labelsname[j]!=null&&labelsname[j]!=""){--%>
<%--								str +='<span class="my-tag-item3">';--%>
<%--								//str += labelsname[j].replaceAll("人员","");--%>
<%--								str += labelsname[j].replace(/人员/g,"");--%>
<%--								str +='</span>';--%>
<%--							}--%>
<%--						}--%>
<%--					}--%>
<%--					if(item.attributelabelname!=null&&item.attributelabelname!=""){--%>
<%--						var attributelabelnames=item.attributelabelname.split(",");--%>
<%--						var labelsname=Array.from(new Set(attributelabelnames));--%>
<%--						for(var j=0;j<labelsname.length;j++){--%>
<%--							str +='<span class="my-tag-item3">';--%>
<%--							//str+=labelsname[j].replaceAll("人员","");--%>
<%--							str+=labelsname[j].replace(/人员/g,"");--%>
<%--							str +='</span>';--%>
<%--						}--%>
<%--					}--%>
					
					if(item.zslabel1!=null&&item.zslabel1!=""){
	               		var zslabel1s=item.zslabel1.split(",");
	               		for(var j=0;j<zslabel1s.length;j++){
		               		$.ajax({
								type:		'POST',
								url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
								data:		{
												id: zslabel1s[j]
											},
								dataType:	'json',
								async:      false,
								success:	function(data){
									str+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;">'+data.attributelabel+'</span>';
								}
							});
	               		}
	               }
					if(item.lslabel1!=null&&item.lslabel1!=""){
	               		var lslabel1s=item.lslabel1.split(",");
	               		for(var j=0;j<lslabel1s.length;j++){
		               		$.ajax({
								type:		'POST',
								url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
								data:		{
												id: lslabel1s[j]
											},
								dataType:	'json',
								async:      false,
								success:	function(data){
									str+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;">'+data.attributelabel+'</span>';
								}
							});
	               		}
	               }
					str +=	'</div>'+
							'<div class="layui-col-md3 my-font-black my-font16">户籍地派出所:'+(item.housepolice==null||item.housepolice==""?"":item.housepolice)+'</div>'+
							'<div class="layui-col-md3 my-font-black my-font16">现住地派出所:'+(item.homepolice==null||item.homepolice==""?"":item.homepolice)+'</div>'+
							'</div>'+
							'</td>' +
							'</tr>';
				}
				$("#tbody_result").html(str);
				layer.close(index_info);
			},
            error:function() {
                layer.close(index_info);
                layer.alert("长时间未响应！请重新登录！",function(){
	                window.location.href="login.jsp";
                });
            }
		});
	}
	function unique(arr) {
	  var result = [], isRepeated;
	  for (var i = 0, len = arr.length; i < len; i++) {
	    isRepeated = false;
	    for (var j = 0, len = result.length; j < len; j++) {
	      if (arr[i] == result[j]) {  
	        isRepeated = true;
	        break;
	      }
	    }
	    if (!isRepeated) {
	      result.push(arr[i]);
	    }
	  }
	  return result;
	}
	function submitForm(url, data)
	{
	　　var eleForm = document.body.appendChild(document.createElement('form'));
	　　eleForm.action = url;
	　　for (var property in data)
	　　{
	　　　　var hiddenInput = document.createElement('input');
	　　　　hiddenInput.type = 'hidden';
	　　　　hiddenInput.name = property;
	　　　　hiddenInput.value = data[property];
	　　　　eleForm.appendChild(hiddenInput);
	　　}
	　　this.eleForm = eleForm;
	　　if (!submitForm._initialized)
	　　{
	　　　　submitForm.prototype.post = function ()
	　　　  {
	　　　　　　this.eleForm.method = 'post';
			  $(this.eleForm).attr('target',"_blank");
	　　　　　　this.eleForm.submit();
	　　　　};
	　　submitForm._initialized = true;
	　　}
	}
	function show_info(personnelid){
		new submitForm("<c:url value="/allpersonshowinfo.do"/>",{personnelid:personnelid}).post();
	}
	
	function getDefaultPhoto(personnelid){
		var str='<img';
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
	layui.config({
	    base: "<c:url value="/layui/lay/modules/"/>"
	}).extend({
	    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
	});
<%--	var _zTreeSelectM0,_zTreeSelectM1,_zTreeSelectM4;--%>
<%--	layui.use(['zTreeSelectM'], function(){--%>
<%--	  var zTreeSelectM = layui.zTreeSelectM;--%>
<%--	  _zTreeSelectM0 = zTreeSelectM({--%>
<%--	    elem: '#attributelabels',//元素容器【必填】          --%>
<%--		data: '<c:url value="/getAttributeLabelzTreeSelectM.do"/>',--%>
<%--	    type: 'get',  //设置了长度    --%>
<%--	    selected: [],//默认值            --%>
<%--	    max: 100,//最多选中个数，默认5            --%>
<%--	    name: 'attributelabels',//input的name 不设置与选择器相同(去#.)--%>
<%--	    delimiter: ',',//值的分隔符  --%>
<%--	    tips:'--请选择人员属性标签--',         --%>
<%--	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 --%>
<%--	    zTreeSetting: { //zTree设置--%>
<%--	        check: {--%>
<%--	            enable: true,--%>
<%--	            chkboxType: { "Y": "", "N": "" }--%>
<%--	        },--%>
<%--	        data: {--%>
<%--	            simpleData: {--%>
<%--	                enable: false--%>
<%--	            },--%>
<%--	            key: {--%>
<%--	                name: 'name',--%>
<%--	                children: 'children'--%>
<%--	            }--%>
<%--	        },--%>
<%--	        view: {--%>
<%--	        	showIcon: false--%>
<%--			}--%>
<%--	    }--%>
<%--	  });--%>
<%--	});--%>
<%--	layui.use(['zTreeSelectM'], function(){--%>
<%--	  var zTreeSelectM = layui.zTreeSelectM;--%>
<%--	  _zTreeSelectM1 = zTreeSelectM({--%>
<%--	    elem: '#personneltype1',//元素容器【必填】          --%>
<%--		data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=46',--%>
<%--	    type: 'get',  //设置了长度    --%>
<%--	    selected: [],//默认值            --%>
<%--	    max: 100,//最多选中个数，默认5            --%>
<%--	    name: 'personneltype1',//input的name 不设置与选择器相同(去#.)--%>
<%--	    delimiter: ',',//值的分隔符  --%>
<%--	    tips:'--涉稳风险目标类别--',         --%>
<%--	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 --%>
<%--	    zTreeSetting: { //zTree设置--%>
<%--	        check: {--%>
<%--	            enable: true,--%>
<%--	            chkboxType: { "Y": "", "N": "" }--%>
<%--	        },--%>
<%--	        data: {--%>
<%--	            simpleData: {--%>
<%--	                enable: false--%>
<%--	            },--%>
<%--	            key: {--%>
<%--	                name: 'name',--%>
<%--	                children: 'children'--%>
<%--	            }--%>
<%--	        },--%>
<%--	        view: {--%>
<%--	        	showIcon: false--%>
<%--			}--%>
<%--	    }--%>
<%--	  });--%>
<%--	});--%>
<%--	layui.use(['zTreeSelectM'], function(){--%>
<%--	  var zTreeSelectM = layui.zTreeSelectM;--%>
<%--	  _zTreeSelectM4 = zTreeSelectM({--%>
<%--	    elem: '#personneltype4',//元素容器【必填】          --%>
<%--		data: [--%>
<%--				{id:1,name:'社会吸毒人员'},--%>
<%--				{id:2,name:'制贩毒风险人员'}--%>
<%--			  ],--%>
<%--	    type: 'get',  //设置了长度    --%>
<%--	    selected: [],//默认值            --%>
<%--	    max: 100,//最多选中个数，默认5            --%>
<%--	    name: 'personneltype4',//input的name 不设置与选择器相同(去#.)--%>
<%--	    delimiter: ',',//值的分隔符  --%>
<%--	    tips:'--涉毒风险目标类别--',         --%>
<%--	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 --%>
<%--	    zTreeSetting: { //zTree设置--%>
<%--	        check: {--%>
<%--	            enable: true,--%>
<%--	            chkboxType: { "Y": "", "N": "" }--%>
<%--	        },--%>
<%--	        data: {--%>
<%--	            simpleData: {--%>
<%--	                enable: false--%>
<%--	            },--%>
<%--	            key: {--%>
<%--	                name: 'name',--%>
<%--	                children: 'children'--%>
<%--	            }--%>
<%--	        },--%>
<%--	        view: {--%>
<%--	        	showIcon: false--%>
<%--			}--%>
<%--	    }--%>
<%--	});--%>
<%--	});--%>
</script>
<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
</body>

</html>