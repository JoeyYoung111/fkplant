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
		<div class="layui-form">
			<table class="layui-table" lay-even>
				<colgroup>
					<col width="100">
					<col width="100">
					<col width="200">
					<col width="100">
					<col width="200">
					<col width="100">
					<col width="200">
					<col width="100">
					<col width="200">
				</colgroup>
				<thead>
					<tr>
						<th colspan="9" class="layui-bg-blue layui-font-16 text-align-c">人员信息详情</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="5" class="text-align-c img">
							<img id="photo">
						</td>
						<td class="text-align-r">身份证号：</td>
						<td>${personnel.cardnumber}</td>
						<td class="text-align-r">姓名：</td>
						<td>${personnel.personname}</td>
						<td class="text-align-r">曾用名：</td>
						<td>${personnel.usedname}</td>
						<td class="text-align-r">绰号：</td>
						<td>${personnel.nickname}</td>
					</tr>
					<tr>
						<td class="text-align-r">性别：</td>
						<td id="sexes">${personnel.sexes}</td>
						<td class="text-align-r">民族：</td>
						<td>${personnel.nation}</td>
						<td class="text-align-r">婚姻状况：</td>
						<td>${personnel.marrystatus}</td>
						<td class="text-align-r">出生年月：</td>
						<td id="birth"></td>
					</tr>
					<tr>
						<td class="text-align-r">年龄：</td>
						<td id="age"></td>
						<td class="text-align-r">健康状态：</td>
						<td>${personnel.heathstatus}</td>
						<td class="text-align-r">政治面貌：</td>
						<td>${personnel.politicalposition}</td>
						<td class="text-align-r">宗教信仰：</td>
						<td>${personnel.faith}</td>
					</tr>
					<tr>
						<td class="text-align-r">文化程度：</td>
						<td>${personnel.education}</td>
						<td class="text-align-r">人员类别：</td>
						<td>${personnel.persontype}</td>
						<td class="text-align-r">兵役状况：</td>
						<td colspan="3">${personnel.soldierstatus}</td>
					</tr>
					<tr>
						<td class="text-align-r">户籍地详址：</td>
						<td colspan="3">${personnel.houseplace}</td>
						<td class="text-align-r">户籍地派出所：</td>
						<td colspan="3">${personnel.housepolice}</td>
					</tr>
					<tr>
						<td class="text-align-r" colspan="2">现住地详址：</td>
						<td>${personnel.homeplace}</td>
						<td class="text-align-r">现住地派出所：</td>
						<td>${personnel.homepolice}</td>
						<td class="text-align-r">居住地wifi：</td>
						<td><c:if test="${personnel.homewifi eq 1}">有</c:if><c:if test="${personnel.homewifi ne 1}">无</c:if></td>
						<td class="text-align-r">居住地宽带：</td>
						<td><c:if test="${personnel.homewide eq 1}">有</c:if><c:if test="${personnel.homewide ne 1}">无</c:if></td>
					</tr>
					<tr>
						<td class="text-align-r" colspan="2">工作地详址：</td>
						<td>${personnel.workplace}</td>
						<td class="text-align-r">工作地派出所：</td>
						<td>${personnel.workpolice}</td>
						<td class="text-align-r">工作地WiFi：</td>
						<td><c:if test="${personnel.workwifi eq 1}">有</c:if><c:if test="${personnel.workwifi ne 1}">无</c:if></td>
						<td class="text-align-r">工作地宽带：</td>
						<td><c:if test="${personnel.workwide eq 1}">有</c:if><c:if test="${personnel.workwide ne 1}">无</c:if></td>
					</tr>
					<tr>
						<td class="text-align-r" colspan="2"><br>特殊特征：<br><br></td>
						<td colspan="7">${personnel.feature}</td>
					</tr>
					<tr>
						<td class="text-align-r" colspan="2"><br>技能专长：<br><br></td>
						<td colspan="7">${personnel.speciality}</td>
					</tr>
					<tr>
						<td class="text-align-r" colspan="2"><br>前科劣迹：<br><br></td>
						<td colspan="7">${personnel.records}</td>
					</tr>
					<tr>
						<td class="text-align-r" colspan="2"><br>信息核查方式：<br><br></td>
						<td colspan="7">${personnel.checkmethod}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
<script>
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
		
		getDefaultPhoto(${personnel.id});//加载默认图片
		getInfo();
	});
	
	function getInfo(){
		var validator = new IDValidator();
		var cardinfo=validator.getInfo("${personnel.cardnumber}");
		var now=new Date();
		var age=now.getFullYear();
		var cardnumber="${personnel.cardnumber}";
		var length=cardnumber.length;
		if(length==15){
			age-=parseInt(cardnumber.substring(6,8))+1900;
			age++;
		}else if(length==18){
			age-=parseInt(cardnumber.substring(6,10));
			age++;
		}else age=0;
		$('#age').html(age);
		$('#birth').html(cardinfo.birth.substring(0,7));
		if(""=="${personnel.sexes}")$('#sexes').html(cardinfo.sex==0?'女':'男');
	}
	
	function getDefaultPhoto(personnelid){
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
							if(this.validflag>1)$('#photo').attr('src','../uploadFiles/'+this.fileallName);
							else $('#photo').attr('src','../uploadFiles/pictures/'+this.fileallName);
						}
					});
				}
				if(defaultid==0){
					$('#photo').attr('src','<c:url value="/images/nophoto.png"/>');
				}
				$('#photo').attr('onload',"javascript:DrawImage(this,120,160)");
			}
		});
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
</script>
</body>

</html>