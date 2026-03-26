<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>江阴市公安局社会安全要素管控平台</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Access-Control-Allow-Origin" content="*">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="icon" href="favicon.ico">
	<link rel="stylesheet" href="css/font.css">
	<link rel="stylesheet" href="layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="css/font_tnyc012u2rlwstt9.css" media="all" />
	<link rel="stylesheet" href="css/main.css" media="all" />
	<link rel="stylesheet" href="<c:url value="/jquery/ad_dialog/css/ad.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value='/layui/layui.all.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/layui/layui.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/js/index.js'/> "></script>
	<!-- 右下角弹窗 -->
	<script type="text/javascript" src="<c:url value="/jquery/ad_dialog/js/ad.js"/>"></script>
	<!-- 预警接口 -->
	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/axios.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/mqtt.js"/>"></script>

	<script type="text/javascript">
		//setInterval("test()",2000);
		/*function test() {
		    $.ajax({
				type:		'POST',
				url:		'<c:url value="/getStaffListDY.do" />',
				dataType:	'json',
				async:		false,
				success:	function(data){
							
				}
			});
		}*/
	</script>
</head>
<%
	UserSession userSession = (UserSession) session.getAttribute("userSession");

%>
<body class="main_body">
<div id="secret_text" hidden style="height:600px;width:700px;padding-top:50px;"></div>
<div class="layui-layout layui-layout-admin">
	<!-- 顶部 -->
	<div class="layui-header header">
		<div class="layui-main">
			<!-- 显示/隐藏菜单 -->
			<a href="javascript:;" class="hideMenu icon-menu1"><img src="images/nav_bar.png" width="16" height="14"></a>
			<a href="#" class="logo" style="text-align:left;"><img src="images/top_title.png" width="47" height="36"></a>
			<!-- 顶部右侧菜单 -->
			<ul class="layui-nav top_menu">

				<%--<c:if test="${flag==1}">
                <li class="layui-nav-item" pc>
                    <a href="bigdata.jsp" target ="_blank"><img src="images/anlysis.png" width="24" height="24" ><cite>大数据分析</cite></a>
                </li>--%>
				<c:if test="${flag eq 1}">
					<li class="layui-nav-item" pc>
						<a href="allperson.jsp" target ="_blank"><img src="images/user.png" width="24" height="24" ><cite>人员综合查询</cite></a>
					</li>
				</c:if>
				<%--					<li class="layui-nav-item" pc>--%>
				<%--						<a href="home.jsp?flag=${flag}"><img src="images/uppassword.png" width="24" height="24"><cite>返回导航</cite></a>--%>
				<%--					</li>--%>
				<li class="layui-nav-item" pc>
					<a href="javascript:;" onclick="yujing()"><img src="images/back.png" width="24" height="24"><cite>预警信息</cite></a>
				</li>
				<li class="layui-nav-item" pc>
					<a href="javascript:;" onclick="changePWD()"><img src="images/uppassword.png" width="24" height="24"><cite>修改密码</cite></a>
				</li>
				<li class="layui-nav-item" pc>
					<a href="login.jsp" class="signOut"><img src="images/exit.png" width="24" height="24"><cite>退出登录</cite></a>
				</li>
				<li class="layui-nav-item" pc>
					<a href="javascript:;"><img src="images/user.png" width="24" height="24"><cite><%=userSession.getLoginUserDepartname()%>：<%=userSession.getLoginUserName()%></cite></a>
				</li>
			</ul>
		</div>
	</div>
	<!-- 左侧导航 -->
	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree" lay-filter="left-menu" lay-shrink="all">
				<li class="nav-tree">菜单导航</li>
				<c:forEach items="${menuList}" var="row" varStatus="num">

					<li class="layui-nav-item">
						<c:choose>
							<c:when test="${not empty row.url}">
								<%--		                    <a class="" href="javascript:;"><a data-id="zhu${row.id}" data-title="${row.menuname}" data-url="${row.url}?menuid=${row.id}&buttons=${row.buttons}"><img src="images/${row.icon }" width="24" height="24"><span>${row.menuname }</span></a></a>--%>
								<a class="" href="javascript:;" data-id="zhu${row.id}" data-title="${row.menuname}" data-url="${row.url}?menuid=${row.id}&buttons=${row.buttons}"><img src="images/${row.icon }" width="24" height="24"><span>${row.menuname }</span></a>
							</c:when>
							<c:otherwise>
								<a class="" href="javascript:;"><img src="images/${row.icon }" width="24" height="24"><span>${row.menuname }</span></a>
							</c:otherwise>
						</c:choose>
						<dl class="layui-nav-child">
							<c:forEach items="${row.sublist }" var="row1" varStatus="num1">
								<dd>
									<c:choose>
										<c:when test="${fn:indexOf(row1.url, '.jsp')>=0}">
											<a href="javascript:;" data-title="${row1.menuname}" data-id="${row.id}-${num1.index+1}"   data-url="${row1.url}<c:if test="${fn:indexOf(row1.url, '?')>=0}">&</c:if><c:if test="${fn:indexOf(row1.url, '?')<0}">?</c:if>menuid=${row1.id }&buttons=${row1.buttons }" class="site-demo-active" data-type="tabAdd">${row1.menuname}</a>
										</c:when>
										<c:when test="${fn:indexOf(row1.url, '.do')>=0}">
											<a href="javascript:;" data-title="${row1.menuname}" data-id="${row.id}-${num1.index+1}"   data-url="${row1.url}<c:if test="${fn:indexOf(row1.url, '?')>=0}">&</c:if><c:if test="${fn:indexOf(row1.url, '?')<0}">?</c:if>menuid=${row1.id }&buttons=${row1.buttons }" class="site-demo-active" data-type="tabAdd">${row1.menuname}</a>
										</c:when>
										<c:otherwise>
											<a href="${row1.url}" data-title="${row1.menuname}" class="site-demo-active" target ="_blank">${row1.menuname}</a>
										</c:otherwise>
									</c:choose>
								</dd>
							</c:forEach>

						</dl>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!--tab标签-->
	<div class="layui-tab" lay-filter="demo" lay-allowclose="true" style="margin-left: 200px;">
		<ul class="layui-tab-title"></ul>
		<div class="layui-tab-content"></div>
	</div>
	<!-- 右侧内容 -->
	<div class="layui-body layui-form">
		<div class="layui-tab marg0" lay-filter="bodyTab" id="top_tabs_box">
			<ul class="layui-tab-title top_tab" id="top_tabs">
				<li class="layui-this" lay-id=""><i class="iconfont icon-computer"></i> <cite>系统首页</cite></li>
			</ul>
			<ul class="layui-nav closeBox">
				<li class="layui-nav-item">
					<a href="javascript:;"><i class="iconfont icon-caozuo"></i> 页面操作</a>
					<dl class="layui-nav-child">
						<dd><a href="javascript:;" class="refresh refreshThis"><i class="iconfont icon-shuaxin1"></i> 刷新当前</a></dd>
						<dd><a href="javascript:;" class="closePageOther"><i class="iconfont icon-prohibit"></i> 关闭其他</a></dd>
						<dd><a href="javascript:;" class="closePageAll"><i class="iconfont icon-guanbi"></i> 关闭全部</a></dd>
					</dl>
				</li>
			</ul>
			<div class="layui-tab-content clildFrame">
				<div class="layui-tab-item layui-show">
					<c:set var="dpid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
					<c:set var="dpidstr" value=",${dpid},"/>
					<c:set var="wenstr" value=",12,13,14,15,16,17,18,19,20,21,22,23,24,"/>
					<c:set var="kongstr" value=",82,"/>
					<c:set var="dustr" value=",138,139,140,141,142,"/>
					<c:set var="eventstr" value=",165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,"/>
					<c:choose>
						<c:when test="${fn:indexOf(wenstr,dpidstr)>=0}">
							<iframe src="<c:url value='jsp/chart/wen/index.jsp?menuid=195'/> "></iframe>
						</c:when>
						<c:when test="${fn:indexOf(kongstr,dpidstr)>=0}">
							<iframe src="<c:url value='jsp/chart/kong/index.jsp?menuid=196'/> "></iframe>
						</c:when>
						<c:when test="${fn:indexOf(dustr,dpidstr)>=0}">
							<iframe src="<c:url value='jsp/chart/du/index.jsp?menuid=197'/> "></iframe>
						</c:when>
						<c:when test="${fn:indexOf(eventstr,dpidstr)>=0}">
							<iframe src="<c:url value='security-dist/maodunindex.jsp?menuid=250'/> "></iframe>
						</c:when>
						<c:otherwise>
							<iframe src="<c:url value='welcome.jsp'/> "></iframe>
						</c:otherwise>
					</c:choose>					</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<div class="layui-footer footer">
		<p>copyright @2021 江苏远望神州软件有限公司</p>
	</div>

	<!-- 右下角弹窗 -->
	<div class="float_layer" id="miaov_float_layer" style="z-index:10001;">
		<h2>
			<b>消息提醒</b>
			<a id="btn_min" href="javascript:;" class="min"></a>
		</h2>
		<div class="content2">
			<div class="wrap2" style="background-color: white;">
				<table id="ad_context" width="100%" cellspacing="0" cellpadding="0" style="text-align:center">
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 移动导航 -->
<div class="site-tree-mobile layui-hide"><i class="layui-icon">&#xe602;</i></div>
<div class="site-mobile-shade"></div>
<script>
	$(document).ready(function(){
		$("#shouye").attr("src","welcome.jsp");
		var cardnumber="<%=userSession.getLoginUserCardnumber()%>";
		//消息框
		var fk_closeflag=window.localStorage.getItem('fk_closeflag');
		if(!fk_closeflag)getSecret();
		waterprint();
		//connectYujing(cardnumber);
		/*
		if(cardnumber=="320219197209136054"){
			connectDianWei(cardnumber);
			connectJuji("320219198209246012");
			connectRenlian("320281199406301511");
		}else{
			getNewjointcontrollevel();
			var jointcontrolleveltimer = setInterval(function () {
				getNewjointcontrollevel();
			}, 6000000);
		}
		*/
		getNewjointcontrollevel();
		var jointcontrolleveltimer = setInterval(function () {
			getNewjointcontrollevel();
		}, 600000);
	});

	function waterprint(){
		var wm='<%=userSession.getLoginUserName()%>'+'\n';
		var contactNum = '<%=userSession.getLoginContactnumber() != null ? userSession.getLoginContactnumber() : ""%>';
		var number = contactNum != null && contactNum != '' && contactNum != 'null' ? contactNum : '';
		if(number.length==11)wm+=number.substring(0,3)+"****"+number.substring(7);
		else wm+=number;
		watermark({ watermark_txt: wm })//传入动态水印内容  可以从Session中拿出你需要的用户信息
		function watermark(settings) {
			//默认设置
			var defaultSettings={
				watermark_txt:"text",
				watermark_x:250,//水印起始位置x轴坐标
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
	}
	/**  首页弹出最新消息
	 1、级别调整：只提示给有审核权限按钮的人显示
	 2、通知公告：根据接受单位过滤
	 3、人员二级标签新增：根据责任警种部门过滤
	 4、增加人员一级标签：根据责任警种部门过滤
	 5、完成审核二级标签：根据申请人过滤

	 **/
	// 存储已读消息ID的localStorage key
	var READ_MESSAGES_KEY = 'jy_read_message_ids';

	// 获取已读消息ID列表
	function getReadMessageIds() {
		var stored = window.localStorage.getItem(READ_MESSAGES_KEY);
		if (stored) {
			try {
				return JSON.parse(stored);
			} catch (e) {
				return [];
			}
		}
		return [];
	}

	// 保存已读消息ID
	function saveReadMessageId(messageId) {
		var readIds = getReadMessageIds();
		if (readIds.indexOf(messageId) === -1) {
			readIds.push(messageId);
			// 只保留最近500条已读记录，防止localStorage过大
			if (readIds.length > 500) {
				readIds = readIds.slice(-500);
			}
			window.localStorage.setItem(READ_MESSAGES_KEY, JSON.stringify(readIds));
		}
	}

	// 标记消息为已读并从列表中移除
	function markMessageAsRead(messageId, messageType, element) {
		// 先保存到本地存储
		saveReadMessageId(messageId);

		// 如果消息类型是案件或警情，调用后端接口更新数据库
		if (messageType === 'aj' || messageType === 'jj') {
			// 从messageId中提取实际的数字ID（格式可能是 "123" 或 "content_timestamp"）
			var actualId = messageId;
			// 如果messageId包含下划线，说明是自动生成的，尝试从数据属性获取真实ID
			if (messageId.indexOf('_') !== -1) {
				// 从元素的data属性获取真实ID
				actualId = $(element).closest('tr').data('message-id');
			}

			// 调用后端接口标记为已读
			$.ajax({
				type: 'POST',
				url: '<c:url value="/deleteCasePoliceMessage.do"/>',
				data: { messageId: actualId },
				dataType: 'json',
				success: function(response) {
					if (response.success) {
						console.log('[调试] 消息已在数据库中标记为已读: ' + actualId);
					} else {
						console.error('[错误] 标记消息已读失败: ' + (response.error || '未知错误'));
					}
				},
				error: function(xhr, status, error) {
					console.error('[错误] 调用deleteCasePoliceMessage接口失败: ' + error);
				}
			});
		}

		// 移除该行
		$(element).closest('tr').fadeOut(300, function() {
			$(this).remove();
			// 检查是否还有消息，如果没有则最小化弹窗
			var remainingCount = $('#ad_context tbody tr').length;
			if (remainingCount === 0) {
				var oBtnMin = document.getElementById('btn_min');
				oBtnMin.click();
			}
		});
	}

	function getNewjointcontrollevel(){
		console.log("[调试] 开始执行 getNewjointcontrollevel 轮询...");
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getNewMessageRemind.do"/>',
			dataType:	'json',
			success:	function(data){
				console.log("[调试] 轮询成功，返回消息数量: " + (data.messageRemindList ? data.messageRemindList.length : 0));
				var str="";
				var readIds = getReadMessageIds();
				$.each(data.messageRemindList, function(num, item) {
					// 生成唯一消息ID（使用消息内容的hash或时间戳）
					var messageId = item.id || (item.messagecontent + '_' + (item.createtime || num));
					var messageType = item.messageType || ''; // 获取消息类型
					var actualId = item.id || ''; // 保存真实的数据库ID

					// 检查是否已读
					if (readIds.indexOf(messageId) !== -1) {
						console.log("[调试] 消息已读，跳过: " + item.messagecontent);
						return true; // continue
					}
					console.log("[调试] 消息内容: " + item.messagecontent + ", 类型: " + messageType + ", ID: " + actualId);
					str+= "<tr data-message-id='" + actualId + "' style='text-align:left;border-bottom:1px #333 dotted;height:30px;'>" +
						"<td style='position:relative;padding-right:25px;'>" +
						" •" + item.messagecontent +
						"<span onclick=\"markMessageAsRead('" + messageId + "', '" + messageType + "', this)\" " +
						"style='position:absolute;right:5px;top:50%;transform:translateY(-50%);cursor:pointer;color:#999;font-size:16px;font-weight:bold;' " +
						"title='标记为已读'>×</span>" +
						"</td></tr>";
				});
				if(str!=""){
					add_context(str);
				}else{
					var oBtnMin = document.getElementById('btn_min');
					oBtnMin.click();
				}
			},
			error: function(xhr, status, error) {
				console.log("[调试] 轮询失败: " + status + " - " + error);
			}
		});
	}

	function toMain(){
		layui.element.tabChange("bodyTab","main1");
	}
	function changePWD(){
		var index = layui.layer.open({
			title : "密码修改",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="/changePWD.jsp"/>',
			area: ['600px', '500px'],
			maxmin: false,
			success : function(layero, index){

			}
		})
	}
	function yujing(){
		var index = layui.layer.open({
			title : "预警信息",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="/jsp/yujing/list.jsp"/>',
			area: ['950px', '700px'],
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

	function getSecret(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getSecret.do"/>',
			dataType:	'json',
			async:      false,
			success:	function(data){
				$("#secret_text").html(data.secret_text);
				var index1 = top.layer.confirm($("#secret_text").html(),{
					title:false,
					closeBtn:0,
					area: ['700px', '600px'],
					offset:['50px'],
					btn:['关闭 5'],
					success : function(layero, index){
						$("#layui-layer"+index).css("background","url(images/index/bg-secret.png) no-repeat");
						//$("#layui-layer"+index).css("background-color","#CCEBFF");
						$("#layui-layer"+index).find(".layui-layer-btn").find("a").css("background-color","grey");
						$("#layui-layer"+index).find(".layui-layer-btn").css("position","absolute");
						$("#layui-layer"+index).find(".layui-layer-btn").css("top","2px");
						$("#layui-layer"+index).find(".layui-layer-btn").css("right","-10px");
						var btns=$("#layui-layer"+index).find(".layui-layer-btn").find("a").text();
						var ms=parseInt(btns.substring(3));
						var ttl=setInterval(function(){
							if(ms>0){
								ms--;
								$("#layui-layer"+index).find(".layui-layer-btn").find("a").text(btns.substring(0,3)+ms);
							}else{
								$("#layui-layer"+index).find(".layui-layer-btn").find("a").text("关闭");
								$("#layui-layer"+index).find(".layui-layer-btn").find("a").css("background-color","");
								clearInterval(ttl);
							}
						},1000);
					},
					yes:function(index,layero){   //通过回调得到iframe的值
						var btns=$("#layui-layer"+index).find(".layui-layer-btn").find("a").text();
						if(btns=="关闭"){
							window.localStorage.setItem('fk_closeflag',true);
							top.layer.close(index1);
						}

					}
				});
			}
		});
	}

	function connectYujing(cardnumber){
		var validator = new IDValidator();
		if(validator.isValid(cardnumber)){
			const server = new mqttServer({
				topic: 'msgc-ad88819016ba',//主题 msgc-ad88819016ba
				userId: cardnumber,//用户身份证号
				appId: '35248cb74d65c2263099ed68ab19ff0e',//应用id   35248cb74d65c2263099ed68ab19ff0e
				mapKey:cardnumber+'msgc-ad88819016ba',
				host: '50.64.128.50',//IP地址
				port: 6040 //端口号
			});
			server._createMqttClient().then(function (res) {
				console.log('链接成功', res);
			});
			//消息接收
			server._onMessage(function (result) {
				console.log("接收消息"+JSON.stringify(result.data));
				var model_result=result.data;
				var contentjson=JSON.parse(model_result.body.content);
				if(contentjson.modelId=="6abc5356082d86c78af87c480007efa1"){
					$.ajax({
						type:		'POST',
						url:		'<c:url value="/connectYujingByModelId.do"/>',
						data:		{
							cardnumber :  	cardnumber,
							model_title:	model_result.body.title,
							modelId:		contentjson.modelId,
							dataid:			result.data.id
						},
						dataType:	'json',
						success:	function(data){
							if(data.flag)console.log('模型结果接收成功！');
							else console.log('无结果或者模型结果接收失败！！');

							//设置消息已消费，便于统计
							server._setMessageRead(data.dataid).then( function (result) {
								console.log("消息已读:"+JSON.stringify(result));
							});
						}
					});
				}else{
					//if(cardnumber!="320219197209136054"){
					//设置消息已消费，便于统计
					server._setMessageRead(result.data.id).then( function (result) {
						console.log("消息已读:"+JSON.stringify(result));
					});
					//}
				}
			});
			//连接丢失
			server._onConnectionLost(function (err) {
				console.log('连接丢失', err)
			});
			//客户端重连监听
			server._onReconnectionSuccess(function (state) {
				console.log('是否重新连接成功', state)
			});

			//用户不在线时，登陆后接收消息
			server._unreadMessageCount().then(function (result)  {
				console.log(result.data);
				if(result.data > 0){
					var size=100;
					var page=1;
					server._unreadMessagePageList(page, size).then(function (r) {
						console.log("统计："+r.data.list);
						if(r.data.list.length>0){
							for(var i=0;i<r.data.list.length;i++){
								var model_result=r.data.list[i];
								var contentjson=JSON.parse(model_result.body.content);
								console.log("接收消息"+JSON.stringify(model_result));
								if(contentjson.modelId=="6abc5356082d86c78af87c480007efa1"){
									$.ajax({
										type:		'POST',
										url:		'<c:url value="/connectYujingByModelId.do"/>',
										data:		{
											cardnumber :  	cardnumber,
											model_title:	model_result.body.title,
											modelId:		contentjson.modelId,
											dataid:			r.data.list[i].id
										},
										dataType:	'json',
										success:	function(data){
											if(data.flag)console.log('模型结果接收成功！');
											else console.log('无结果或者模型结果接收失败！！');

											server._setMessageRead(data.dataid).then( function (result) {
												console.log("消息已读:");
												console.log(JSON.stringify(result));
											});
										}
									});
								}else{
									//if(cardnumber!="320219197209136054"){
									//设置消息已消费，便于统计
									server._setMessageRead(r.data.list[i].id).then( function (result) {
										console.log("消息已读:"+JSON.stringify(result));
									});
									//}
								}

							}
						}
					});
				}
			});
		}
	}
	//苏网通值班
	var zhibanmj=[{"unit":"城中派出所","mj":"gyn"}//高伊娜	15961535159
		,{"unit":"君山派出所","mj":"zhouxn"}//周欣妮	15251587239
		,{"unit":"西郊派出所","mj":"lxq"}//徐渭	13861622524-->姚玉琪，6827531，13961608985  张文武，13961612895,13961612895-->袁钦  750702,13861607813-->林晓强	lxq,15061771501
		,{"unit":"要塞派出所","mj":"chenlj,lujw"}//陈丽娟	15961631550	陆佳雯	13812158706
		,{"unit":"城东派出所","mj":"hlj,15190365076"}//黄李君	13585051008	陈伟宾	18306167805-->黄李君	hlj,13585051008  蔡明浩  15190365076,15190365076 （新增）
		,{"unit":"滨江派出所","mj":"777,227197"}//陆翊军	13861601007   薛新阳	227197,13861661728	（新增）
		,{"unit":"云亭派出所","mj":"gongx,226140"}//贡雪	13912451578++陈晓君 226140,15716165287
		,{"unit":"南闸派出所","mj":"cfr,liubing658"}//仇福仁	15950131222  刘一峰	liubing658,13585068799	（新增）
		,{"unit":"夏港派出所","mj":"guyt"}//张红霞	15061778205 -->顾瑶婷 guyt,13771293342
		,{"unit":"利港派出所","mj":"13915236167"}//吴仪	15961624939 -->梅治国 13915236167
		,{"unit":"申港派出所","mj":"cj,15161606471"}//陈杰	13812100384	张彬	15161606471
		,{"unit":"璜土派出所","mj":"65176,227381"}//朱建荣	13506163089	许文新	13961685568
		,{"unit":"青阳派出所","mj":"hyj"}//怀英娟 	13961624894
		,{"unit":"徐霞客派出所","mj":"227627,13585069873"}//吴东智	13861616626  沈荣伟	13585069873,13585069873	（新增）
		,{"unit":"峭岐派出所","mj":"lingcheshanren"}//张国峰	13915213110
		,{"unit":"月城派出所","mj":"cp"}//陈萍	15161659709
		,{"unit":"长泾派出所","mj":"226934"}//缪醒海	13801529527
		,{"unit":"祝塘派出所","mj":"wdl"}//汪东兰	15961659699
		,{"unit":"顾山派出所","mj":"jinj,wp"}//金菊	15861653880	王鹏	18036866320
		,{"unit":"周庄派出所","mj":"lijing"}//李敬	13812102677
		,{"unit":"三房巷派出所","mj":"228367"}//陈忠伟	13921260155 -->王煜杰 228367,15251587502
		,{"unit":"华西派出所","mj":"227826"}//卞丹军	13585068792
		,{"unit":"华士派出所","mj":"fhy"}//顾凯新	13812584296-->符红艳 fhy
		,{"unit":"新桥派出所","mj":"13815143379"}//赵崇高	13815143379
		,{"unit":"江阴政法委联动中心","mj":"226814"}//潘丰杰	13961600608
	];
	function connectDianWei(cardnumber){
		var points=",江阴信访局(微),江阴客运站安检(微),霞客高速收费站,江阴高速口,江阴北高速口,顾山高速口,青阳高速口,新桥南高速收费站上海方向(微),华西高速收费站,江阴南高速口,璜塘高速口,京沪高速无锡枢纽北,京沪高速偃桥服务区北,沪武高速海港大道,沪武高速新桥东西向,锡澄高速江阴大桥南桥头,靖江京沪高速上海方向1051.7公里处,长山卡口(虹旭),小湖路常州交界(微),芙蓉大道与S232路口,扬子大道与兴隆路路口,扬子大道与港城大道路口,利港汽渡,红旗路西黄桥南,江阴汽渡,西利线南常州交界处(微),澄鹿路与新杨路路口西50米,徐霞客大道卡口,芙蓉大道与红星路路口,扬子大道与芙蓉大道路口,镇澄路西利路路口(虹旭),芙蓉大道与亚包大道路口,海港大道与暨南大道路口,南湫路与黄河路路口(微),长安大道暨南大道路口(虹旭),光辉路顾家桥(微),南焦路常州交界处,小湖卡口(虹旭),石庄卡口滨江西道与扬子大道路口,锡张路黄旗桥南,文林卡口,锡张路与云顾线路口,长安大道卡口,桐安路与河滨西路路口(微),暨南大道与老红豆路路口,月城卡口,锡澄路与暨南大道路口,璜土卡口镇澄路格林豪泰,扬子大道与赣江路路口,旌阳路与圣杨路路口(微),东舜路习礼桥卡口(微),马朋路与马镇村路路口,马文路与锡澄路路口,桐蓉路与常州交界,芙蓉大道西常州交界,月城环山路与常州交界,月城河岸路与常州交界,月城徐家村与常州交界,江阴河东村卡口,江阴暨南大道云顾路,江阴青阳呈彩桥(微）,江阴青阳太平桥(微),江阴青阳界溪桥(微）,江阴南公安检查站,璜土科技大道与常州交界（微）,江阴小湖卡口(微),暨南大道-锡张路-西G,江阴高铁站(江阴ZD), G4221新桥高速口(北侧)张家港交界(江阴ZD), 江阴汽车客运站出口(江阴ZD微), 新杨路上品璟苑南张家港交界(江阴ZD), 香山村路奇美纺织(江阴ZD微), 延陵东路科技大道路口东南角张家港交界(江阴ZD), 澄张路科技大道路口西南角张家港交界(江阴ZD), 河马线南降路口西北角无锡交界(江阴ZD), 祥龙路常州交界(江阴ZD微), 月城三塘路常州交界(江阴ZD微), G2无锡枢纽北无锡交界(江阴ZD), 青阳兴隆桥东侧无锡交界(江阴ZD微), 龙城福第东门(江阴ZD微), 星光苑南门(江阴ZD微), 秀江南名苑西南门(江阴ZD微),";
		const server2 = new mqttServer({
			topic: 'msgc-44f9480ac6c5',//主题 msgc-ad88819016ba
			userId: cardnumber,//用户身份证号
			appId: 'b8b629aa10a20d87c481efffebb8778c',//应用id   35248cb74d65c2263099ed68ab19ff0e
			mapKey:cardnumber+'msgc-44f9480ac6c5',
			host: '50.64.128.50',//IP地址
			port: 6040 //端口号
		});
		server2._createMqttClient().then(function (res) {
			console.log('链接成功', res);
		});
		//消息接收
		server2._onMessage(function (result) {
			console.log("全息布控:接收消息"+JSON.stringify(result.data));
			var model_result=result.data;
			var contentjson=JSON.parse(model_result.body.content);
			//if(contentjson["deployType"]=="全息布控"&&points.indexOf(","+contentjson["siteName"]+",")!=-1){
			if(contentjson["deployType"]=="全息布控"&&model_result.body.title=="全市一二三级重点人员出城预警"){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/connectDianweiByModelId.post"/>',
					data:		{
						cardnumber :  	cardnumber,
						model_title:	model_result.body.title,
						modelId:		'dw',
						result:			JSON.stringify(contentjson),
						zhibanmj:		JSON.stringify(zhibanmj),
						dataid:			result.data.id
					},
					dataType:	'json',
					success:	function(data){
						if(data.flag)console.log('电围短信分发成功！');
						else console.log('无匹配结果！！');

						//设置消息已消费，便于统计
						server2._setMessageRead(data.dataid).then( function (resultn2) {
							console.log("消息已读:"+JSON.stringify(resultn2));
						});
					}
				});
			}else{
				server2._setMessageRead(result.data.id).then( function (resultn1) {
					console.log('非全息布控，或不属于重点关注点位！！');
					console.log("消息已读:"+JSON.stringify(resultn1));
				});
			}
		});
		//连接丢失
		server2._onConnectionLost(function (err) {
			console.log('连接丢失', err)
		});
		//客户端重连监听
		server2._onReconnectionSuccess(function (state) {
			console.log('是否重新连接成功', state)
		});

		//用户不在线时，登陆后接收消息
		server2._unreadMessageCount().then(function (result)  {
			console.log(result.data);
			if(result.data > 0){
				var size=100;
				var page=1;
				server2._unreadMessagePageList(page, size).then(function (r) {
					console.log("统计："+r.data.list);
					if(r.data.list.length>0){
						for(var i=0;i<r.data.list.length;i++){
							var model_result=r.data.list[i];
							var contentjson=JSON.parse(model_result.body.content);
							console.log("全息布控:接收消息"+JSON.stringify(model_result));
							//if(contentjson["deployType"]=="全息布控"&&points.indexOf(","+contentjson["siteName"]+",")!=-1){
							if(contentjson["deployType"]=="全息布控"&&model_result.body.title=="全市一二三级重点人员出城预警"){
								$.ajax({
									type:		'POST',
									url:		'<c:url value="/connectDianweiByModelId.post"/>',
									data:		{
										cardnumber :  	cardnumber,
										model_title:	model_result.body.title,
										modelId:		'dw',
										result:			JSON.stringify(contentjson),
										zhibanmj:		JSON.stringify(zhibanmj),
										dataid:			r.data.list[i].id
									},
									dataType:	'json',
									success:	function(data){
										if(data.flag)console.log('电围短信分发成功！');
										else console.log('无匹配结果！！');

										//设置消息已消费，便于统计
										server2._setMessageRead(data.dataid).then( function (resultn2) {
											console.log("消息已读:"+JSON.stringify(resultn2));
										});
									}
								});
							}else{
								server2._setMessageRead(r.data.list[i].id).then( function (resultn1) {
									console.log('非全息布控，或不属于重点关注点位！！');
									console.log("消息已读:"+JSON.stringify(resultn1));
								});
							}
						}
					}
				});
			}
		});
	}
	function connectJuji(cardnumber){
		const server3 = new mqttServer({
			topic: 'msgc-44f9480ac6c5',//主题 msgc-ad88819016ba
			userId: cardnumber,//用户身份证号
			appId: '35248cb74d65c2263099ed68ab19ff0e',//应用id   35248cb74d65c2263099ed68ab19ff0e
			mapKey:cardnumber+'msgc-44f9480ac6c5',
			host: '50.64.128.50',//IP地址
			port: 6040 //端口号
		});
		server3._createMqttClient().then(function (res) {
			console.log('链接成功', res);
		});
		//消息接收
		server3._onMessage(function (result) {
			console.log("电围聚集:接收消息"+JSON.stringify(result.data));
			var model_result=result.data;
			var contentjson=JSON.parse(model_result.body.content);
			if(contentjson.modelId=="7b2fdd4b47af43a1b3999862a4c2c1af"){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/connectJujiByModelId.post"/>',
					data:		{
						cardnumber :  	cardnumber,
						model_title:	model_result.body.title,
						modelId:		contentjson.modelId,
						zhibanmj:		JSON.stringify(zhibanmj),
						dataid:			result.data.id
					},
					dataType:	'json',
					success:	function(data){
						if(data.flag)console.log('模型结果接收成功！');
						else console.log('无结果或者模型结果接收失败！！');

						//设置消息已消费，便于统计
						server3._setMessageRead(data.dataid).then( function (result) {
							console.log("消息已读:"+JSON.stringify(result));
						});
					}
				});
			}else{
				//设置消息已消费，便于统计
				server3._setMessageRead(result.data.id).then( function (result) {
					console.log("消息已读:"+JSON.stringify(result));
				});
			}
		});
		//连接丢失
		server3._onConnectionLost(function (err) {
			console.log('连接丢失', err)
		});
		//客户端重连监听
		server3._onReconnectionSuccess(function (state) {
			console.log('是否重新连接成功', state)
		});

		//用户不在线时，登陆后接收消息
		server3._unreadMessageCount().then(function (result)  {
			console.log(result.data);
			if(result.data > 0){
				var size=100;
				var page=1;
				server3._unreadMessagePageList(page, size).then(function (r) {
					console.log("统计："+r.data.list);
					if(r.data.list.length>0){
						for(var i=0;i<r.data.list.length;i++){
							var model_result=r.data.list[i];
							var contentjson=JSON.parse(model_result.body.content);
							console.log("电围聚集:接收消息"+JSON.stringify(model_result));
							if(contentjson.modelId=="7b2fdd4b47af43a1b3999862a4c2c1af"){
								$.ajax({
									type:		'POST',
									url:		'<c:url value="/connectJujiByModelId.post"/>',
									data:		{
										cardnumber :  	cardnumber,
										model_title:	model_result.body.title,
										modelId:		contentjson.modelId,
										zhibanmj:		JSON.stringify(zhibanmj),
										dataid:			r.data.list[i].id
									},
									dataType:	'json',
									success:	function(data){
										if(data.flag)console.log('模型结果接收成功！');
										else console.log('无结果或者模型结果接收失败！！');

										server3._setMessageRead(data.dataid).then( function (result) {
											console.log("消息已读:");
											console.log(JSON.stringify(result));
										});
									}
								});
							}else{
								//设置消息已消费，便于统计
								server3._setMessageRead(r.data.list[i].id).then( function (result) {
									console.log("消息已读:"+JSON.stringify(result));
								});
							}
						}
					}
				});
			}
		});
	}
	function connectRenlian(cardnumber){
		const server4 = new mqttServer({
			topic: 'msgc-ab646dc63373',//主题 msgc-ad88819016ba
			userId: cardnumber,//用户身份证号
			appId: '39bdbbe955bb964570b4ab317fd2ed07',//应用id   35248cb74d65c2263099ed68ab19ff0e
			mapKey:cardnumber+'msgc-ab646dc63373',
			host: '50.64.128.50',//IP地址
			port: 6040 //端口号
		});
		server4._createMqttClient().then(function (res) {
			console.log('链接成功', res);
		});
		//消息接收
		server4._onMessage(function (result) {
			console.log("依图人脸:接收消息"+JSON.stringify(result.data));
			var model_result=result.data;
			var contentjson=JSON.parse(model_result.body.content);
			//if(contentjson["deployType"]=="全息布控"&&points.indexOf(","+contentjson["siteName"]+",")!=-1){
			if(model_result.body.title=="涉访人员进入信访场所"||model_result.body.title=="涉访人员离澄"||model_result.body.title=="涉访进入车站"){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/connectRenlianByModelId.post"/>',
					data:		{
						cardnumber :  	cardnumber,
						model_title:	model_result.body.title,
						modelId:		'rl',
						result:			JSON.stringify(contentjson),
						zhibanmj:		JSON.stringify(zhibanmj),
						dataid:			result.data.id
					},
					dataType:	'json',
					success:	function(data){
						if(data.flag)console.log('依图人脸短信分发成功！');
						else console.log('无匹配结果！！');

						//设置消息已消费，便于统计
						server4._setMessageRead(data.dataid).then( function (resultn2) {
							console.log("消息已读:"+JSON.stringify(resultn2));
						});
					}
				});
			}else{
				server4._setMessageRead(result.data.id).then( function (resultn1) {
					console.log('非涉访人员进入信访场所！！');
					console.log("消息已读:"+JSON.stringify(resultn1));
				});
			}
		});
		//连接丢失
		server4._onConnectionLost(function (err) {
			console.log('连接丢失', err)
		});
		//客户端重连监听
		server4._onReconnectionSuccess(function (state) {
			console.log('是否重新连接成功', state)
		});

		//用户不在线时，登陆后接收消息
		server4._unreadMessageCount().then(function (result)  {
			console.log(result.data);
			if(result.data > 0){
				var size=100;
				var page=1;
				server4._unreadMessagePageList(page, size).then(function (r) {
					console.log("统计："+r.data.list);
					if(r.data.list.length>0){
						for(var i=0;i<r.data.list.length;i++){
							var model_result=r.data.list[i];
							var contentjson=JSON.parse(model_result.body.content);
							console.log("依图人脸:接收消息"+JSON.stringify(model_result));
							if(model_result.body.title=="涉访人员进入信访场所"||model_result.body.title=="涉访人员离澄"||model_result.body.title=="涉访进入车站"){
								$.ajax({
									type:		'POST',
									url:		'<c:url value="/connectRenlianByModelId.post"/>',
									data:		{
										cardnumber :  	cardnumber,
										model_title:	model_result.body.title,
										modelId:		'rl',
										result:			JSON.stringify(contentjson),
										zhibanmj:		JSON.stringify(zhibanmj),
										dataid:			r.data.list[i].id
									},
									dataType:	'json',
									success:	function(data){
										if(data.flag)console.log('依图人脸短信分发成功！');
										else console.log('无匹配结果！！');

										//设置消息已消费，便于统计
										server4._setMessageRead(data.dataid).then( function (resultn2) {
											console.log("消息已读:"+JSON.stringify(resultn2));
										});
									}
								});
							}else{
								server4._setMessageRead(r.data.list[i].id).then( function (resultn1) {
									console.log('非涉访人员进入信访场所！！');
									console.log("消息已读:"+JSON.stringify(resultn1));
								});
							}
						}
					}
				});
			}
		});
	}
</script>
</body>
</html>