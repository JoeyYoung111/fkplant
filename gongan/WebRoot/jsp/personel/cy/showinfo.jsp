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
     <title></title>
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/font-awesome-4.7.0/css/font-awesome.min.css"/>" />
     <link rel="stylesheet" href="<c:url value="/js/tagtree/tagTree.css"/>" />
     <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/tagtree/tagTree.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
  </head>
  
 <body class="childrenBody layui-fluid">
		<form class="layui-form layui-row"  onsubmit="return false;">
		<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
					<table class="layui-table" lay-even>
						<colgroup>
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<th colspan="7" class="layui-bg-blue layui-font-16 text-align-c">基本信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="5" class="text-align-c img">
									<img  id="defaultPhoto"  onclick="openPhotosInfo(${personnel.id})"><br>
								</td>
								<td class="text-align-r my-text-nowarp">身份证号：</td>
								<td colspan="2">${personnel.cardnumber}</td>
								<td class="text-align-r my-text-nowarp">姓名：</td>
								<td colspan="2">${personnel.personname}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">性别：</td>
								<td colspan="2">${personnel.sexes}</td>
								<td class="text-align-r my-text-nowarp">年龄：</td>
								<td colspan="2">${age}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">曾用名：</td>
								<td colspan="2">${personnel.usedname}</td>
								<td class="text-align-r my-text-nowarp">绰号：</td>
								<td colspan="2">${personnel.nickname}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">身高：</td>
								<td colspan="2">${personnel.personheight}</td>
								<td class="text-align-r my-text-nowarp">婚姻状况：</td>
								<td colspan="2">${personnel.marrystatus}</td>
							</tr>
							<tr>
							    <td class="text-align-r my-text-nowarp">民族：</td>
								<td colspan="2">${personnel.nation}</td>
								<td class="text-align-r my-text-nowarp">人员类别：</td>
								<td colspan="2">${personnel.persontype}</td>
							</tr>
							<tr>
								<td  colspan="2" class="text-align-r my-text-nowarp">兵役状况：</td>
								<td colspan="2">${personnel.soldierstatus}</td>
								<td class="text-align-r my-text-nowarp">健康状态：</td>
								<td colspan="2">${personnel.heathstatus}</td>
							</tr>
							<tr>
								<td colspan="2" class="text-align-r my-text-nowarp">政治面貌：</td>
								<td colspan="2">${personnel.politicalposition}</td>
								<td class="text-align-r my-text-nowarp">宗教信仰：</td>
								<td colspan="2">${personnel.faith}</td>
							</tr>
							<tr>
								<td colspan="2" class="text-align-r my-text-nowarp">文化程度：</td>
								<td colspan="2">${personnel.education}</td>
							    <td  class="text-align-r my-text-nowarp">网络社交技能习惯：</td>
								<td colspan="2">${personnel.netskillhabit}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地详址：</td>
								<td colspan="3">${personnel.houseplace}</td>
								<td class="text-align-r my-text-nowarp">户籍地派出所：</td>
								<td colspan="2">${personnel.housepolice}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地经度：</td>
								<td colspan="3">${personnel.housex}</td>
								<td class="text-align-r my-text-nowarp">户籍地纬度：</td>
								<td colspan="2">${personnel.housey}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">现住地详址：</td>
								<td colspan="3">${personnel.homeplace}</td>
								<td class="text-align-r my-text-nowarp">现住地派出所：</td>
								<td colspan="2">${personnel.homepolice}&nbsp;&nbsp;
								<c:if test="${personnel.homewifi eq 1}">【wifi】</c:if>
								<c:if test="${personnel.homewide eq 1}">【宽带】</c:if></td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">现住地经度：</td>
								<td colspan="3">${personnel.homex}</td>
								<td class="text-align-r my-text-nowarp">现住地纬度：</td>
								<td colspan="2">${personnel.homey}</td>
							</tr>
						<tr>
								<td class="text-align-r my-text-nowarp">工作地详址：</td>
								<td colspan="3">${personnel.workplace}</td>
								<td class="text-align-r my-text-nowarp">工作地派出所：</td>
								<td colspan="2">${personnel.workpolice}&nbsp;&nbsp;
								<c:if test="${personnel.workwifi eq 1}">【wifi】</c:if>
								<c:if test="${personnel.workwide eq 1}">【宽带】</c:if></td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">工作地经度：</td>
								<td colspan="3">${personnel.workx}</td>
								<td class="text-align-r my-text-nowarp">工作地纬度：</td>
								<td colspan="2">${personnel.worky}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">特殊特征：</td>
								<td colspan="6">${personnel.feature}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">技能专长：</td>
								<td colspan="6">${personnel.speciality}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">前科劣迹：</td>
								<td colspan="6">${personnel.records}</td>
							</tr>
							
						</tbody>
					</table>
				</div>
				<!-- 分级分类信息 -->
				<div class="layui-row" style="padding: 1px;">
					<table class="layui-table" lay-even>
						<colgroup>
							<col width="100">
							<col width="150">
							<col width="100">
							<col width="150">
							<col width="100">
							<col width="150">
						</colgroup>
						<thead>
							<tr>
								<th colspan="6" class="layui-bg-blue layui-font-16 text-align-c">分级分类信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
								<td>${personnel.jurisdictunit}</td>
								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
								<td>${personnel.jurisdictpolice}</td>
								<td class="text-align-r my-text-nowarp">民警手机：</td>
								<td>${personnel.pphone1}</td>
							</tr>
						
						</tbody>
					</table>
				</div>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6">
				<div class="layui-tab">
				  <%--<ul class="layui-tab-title btn-list" style="margin:0px; padding:0px;">
				       <li class="btn btn_11 layui-this" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')">属性标签</li>
						<li class="btn btn_1">关联信息</li>
						<li class="btn btn_2"  onclick="openTrajectoryRecord(${personnel.id});">轨迹信息</li>
						<li class="btn btn_3" onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
					</ul>
					--%><div style="position: relative;">
						<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
							style="margin: 0 30px;width: auto !important;">
							<div class="swiper-wrapper" style="width:85px;height: 80px;">
								<li class="btn btn_12 swiper-slide" id="sjsa"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
								<li class="btn btn_5 swiper-slide" id="zaextendButton">更多信息</li>
								<div class="swiper-slide"></div>
							</div>
						</div>
						<div class="my-swiper-button-next swiper-button-next1"></div>
						<div class="my-swiper-button-prev swiper-button-prev1"></div>
					</div>
					<div class="layui-tab-content swiper-container">
						<div class="right-child-content layui-tab-item layui-show"><!-- 涉警涉案信息 -->
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
								<ul class="layui-tab-title my-tab-title">
									<li onclick="openjqxx('${personnel.cardnumber}');" class="layui-this">涉警信息</li>
									<li onclick="openajxx('${personnel.cardnumber}');">涉案信息</li>
									
								</ul>
								<div class="layui-tab-content">
									<div class="layui-tab-item layui-show">
										<table class="layui-hide" id="jqxxTable" lay-filter="jqxxTable"></table> 
									</div>
									<div class="layui-tab-item">
										<table class="layui-hide" id="ajxxTable" lay-filter="ajxxTable"></table> 
									</div>
									
								</div>
						    </div>
						</div>
						<div class="right-child-content layui-tab-item">
							<form class="layui-form" method="post" id="formzaextend">
								<input type="hidden"  name="kongextendid"id="kongextendid">
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">职业</label>
										<div class="my-input-block">
											  <input type="text" name="zy" id="zy" autocomplete="off" value="${zaExtend.zy}" class="layui-input" readonly="readonly">
										</div>
									</div>
								</div>
								
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">工作单位</label>
										<div class="my-input-block">
											<input type="text" name="workunit" id="workunit" autocomplete="off" value="${zaExtend.workunit}" class="layui-input" readonly="readonly">
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</form>
	<script>
	 $(document).ready(function(){
				getDefaultPhoto();//加载默认图片
				addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}');//加载已有人员标签
		});
		layui.use(['table','element', 'form', 'jquery', 'upload'], function() {
		   var upload = layui.upload,table = layui.table;
		   //加载涉警涉案
		   $('#sjsa').click();
		    	//滚动图片按钮显示         
		         var swiper = new Swiper(".mySwiperS", {
						slidesPerView: 6,
						centeredSlides: false,
						spaceBetween: 5,
						allowTouchMove: false,
						navigation: {
							nextEl: ".swiper-button-next1",
							prevEl: ".swiper-button-prev1",
						}
					}); 
		 });
	</script>
	</body>
</html>
