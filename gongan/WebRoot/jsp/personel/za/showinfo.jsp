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
     <title>风险人员详情-治安</title>
    <meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	 <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script><!-- 头像编辑、关联信息 、社会关系 数据处理js -->
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
	<style>
	   .my-tab-title li {  width:25%  }
	</style>
  </head>
  
 <body class="childrenBody layui-fluid">
		<form class="layui-form layui-row" onsubmit="return false;">
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
<%--								<td class="text-align-r my-text-nowarp">曾用名：</td>--%>
<%--								<td colspan="2">${personnel.usedname}</td>--%>
								<td class="text-align-r my-text-nowarp">绰号：</td>
								<td colspan="2">${personnel.nickname}</td>
								<td class="text-align-r my-text-nowarp">婚姻状况：</td>
								<td colspan="2">${personnel.marrystatus}</td>
							</tr>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">身高：</td>--%>
<%--								<td colspan="2">${personnel.personheight}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">婚姻状况：</td>--%>
<%--								<td colspan="2">${personnel.marrystatus}</td>--%>
<%--							</tr>--%>
							<tr>
							    <td class="text-align-r my-text-nowarp">民族：</td>
								<td colspan="2">${personnel.nation}</td>
								<td class="text-align-r my-text-nowarp">人员类别：</td>
								<td colspan="2">${personnel.persontype}</td>
							</tr>
<%--							<tr>--%>
<%--								<td  colspan="2" class="text-align-r my-text-nowarp">兵役状况：</td>--%>
<%--								<td colspan="2">${personnel.soldierstatus}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">健康状态：</td>--%>
<%--								<td colspan="2">${personnel.heathstatus}</td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td colspan="2" class="text-align-r my-text-nowarp">政治面貌：</td>--%>
<%--								<td colspan="2">${personnel.politicalposition}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">宗教信仰：</td>--%>
<%--								<td colspan="2">${personnel.faith}</td>--%>
<%--							</tr>--%>
							<tr>
								<td class="text-align-r my-text-nowarp">文化程度：</td>
								<td colspan="5">${personnel.education}</td>
<%--							    <td class="text-align-r my-text-nowarp">网络社交技能习惯：</td>--%>
<%--								<td colspan="2">${personnel.netskillhabit}</td>--%>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地详址：</td>
								<td colspan="6">${personnel.houseplace}</td>
<%--								<td class="text-align-r my-text-nowarp">户籍地派出所：</td>--%>
<%--								<td colspan="2">${personnel.housepolice}</td>--%>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地经度：</td>
								<td colspan="3">${personnel.housex}</td>
								<td class="text-align-r my-text-nowarp">户籍地纬度：</td>
								<td colspan="2">${personnel.housey}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">现住地详址：</td>
								<td colspan="6">${personnel.homeplace}</td>
<%--								<td class="text-align-r my-text-nowarp">现住地派出所：</td>--%>
<%--								<td colspan="2">${personnel.homepolice}&nbsp;&nbsp;--%>
<%--								<c:if test="${personnel.homewifi eq 1}">【wifi】</c:if>--%>
<%--								<c:if test="${personnel.homewide eq 1}">【宽带】</c:if></td>--%>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">现住地经度：</td>
								<td colspan="3">${personnel.homex}</td>
								<td class="text-align-r my-text-nowarp">现住地纬度：</td>
								<td colspan="2">${personnel.homey}</td>
							</tr>
						<tr>
								<td class="text-align-r my-text-nowarp">工作地详址：</td>
								<td colspan="6">${personnel.workplace}</td>
<%--								<td class="text-align-r my-text-nowarp">工作地派出所：</td>--%>
<%--								<td colspan="2">${personnel.workpolice}&nbsp;&nbsp;--%>
<%--								<c:if test="${personnel.workwifi eq 1}">【wifi】</c:if>--%>
<%--								<c:if test="${personnel.workwide eq 1}">【宽带】</c:if></td>--%>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">工作地经度：</td>
								<td colspan="3">${personnel.workx}</td>
								<td class="text-align-r my-text-nowarp">工作地纬度：</td>
								<td colspan="2">${personnel.worky}</td>
							</tr>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">特殊特征：</td>--%>
<%--								<td colspan="6">${personnel.feature}</td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">技能专长：</td>--%>
<%--								<td colspan="6">${personnel.speciality}</td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">前科劣迹：</td>--%>
<%--								<td colspan="6">${personnel.records}</td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">信息来源：</td>--%>
<%--								<td colspan="6">${personnel.checkmethod}</td>--%>
<%--							</tr>--%>
						</tbody>
					</table>
				</div>
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
							<tr>
								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>
								<td>${personnel.policephone}</td>
								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>
								<td>${personnel.incontrolleve}</td>
								<td class="text-align-r my-text-nowarp">民警手机：</td>
								<td>${personnel.pphone2}</td>
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
						<li class="btn btn_5"  onclick="openKongExtend(${personnel.id});">可疑特征</li><!--  背景审查、可疑特征 -->
						<li class="btn btn_4"  onclick="openTrajectoryKK('${personnel.cardnumber}',2);">轨迹信息</li>
						<li class="btn btn_6"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
						<li class="btn btn_12"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
						<li class="btn btn_2" onclick="openKongControlPower(${personnel.id});">管控力量</li><!--管控力量-->
						<li class="btn btn_7" onclick="openWorkandlive(${personnel.id});">工作地,居住地</li><!--工作地,居住地 -->
						<li class="btn btn_3" onclick="openKongBackground(${personnel.id});">背景审查</li>
						
					</ul>
					--%>
					<div style="position: relative;">
						<div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
							style="margin: 0 30px;width: auto !important;">
							<div class="swiper-wrapper" style="width:85px;height: 80px;">
								<li class="btn btn_2 layui-this swiper-slide" onclick="openZaDu(${personnel.id})" >涉赌背景</li>
								<li class="btn btn_6 swiper-slide" onclick="openZaChang(${personnel.id})" >涉娼背景</li>
								<li class="btn btn_11 swiper-slide" onclick="addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}')">属性标签</li>
								<li class="btn btn_1 swiper-slide">关联信息</li>
								<li class="btn btn_4 swiper-slide"  onclick="openTrajectoryKK('${personnel.cardnumber}','');">轨迹信息</li>
								<li class="btn btn_6 swiper-slide"  onclick="openSocialRelations(${personnel.id});">社会关系</li>
								<li class="btn btn_12 swiper-slide"  onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
								<li class="btn btn_7 swiper-slide"  onclick="openGoodsShow(${personnel.id})">关联物品</li>
								<li class="btn btn_5 swiper-slide" id="zaextendButton">更多信息</li>
								<div class="swiper-slide"></div>
							</div>
						</div>
						<div class="my-swiper-button-next swiper-button-next1"></div>
						<div class="my-swiper-button-prev swiper-button-prev1"></div>
					</div>
					<div class="layui-tab-content" style="padding-left: 1px;">
					<div class="right-child-content layui-tab-item layui-show">
					     	<form class="layui-form" method="post" id="formZaDu" onsubmit="return false;">
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">历史涉赌情况综述
										<button class="layui-btn layui-btn-sm" id="duHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>历史记录</button></label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="lssdqk" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">赌博方式</label>
										<div class="my-input-block" id="dbfs-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="dbfs" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">赌博部位</label>
										<div class="my-input-block" id="dbbw-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="dbbw" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">查获时间
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chsj" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">查获经过</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chjg" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">处罚结果</label>
										<div class="my-input-block" id="cfjg-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="cfjg" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">处理详情</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="clxq" readonly></textarea>
										</div>
									</div>
								</div>
							</form>
						</div>
					<div class="right-child-content layui-tab-item">
					     	<form class="layui-form" method="post" id="formZaChang" onsubmit="return false;">
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">历史涉嫖情况综述
										<button class="layui-btn layui-btn-sm" id="changHistory" style="display:none;"><i class="layui-icon">&#xe68d;</i>历史记录</button></label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_lsscqk" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉娼角色</label>
										<div class="my-input-block" id="chang_scjs-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_scjs" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉娼部位</label>
										<div class="my-input-block" id="chang_scbw-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_scbw" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">卖淫方式</label>
										<div class="my-input-block" id="chang_myfs-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_myfs" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">查获时间
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_chsj" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">查获经过</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_chjg" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">处罚结果</label>
										<div class="my-input-block" id="chang_cfjg-div">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_cfjg" readonly rows="1"></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">处理详情</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_clxq" readonly></textarea>
										</div>
									</div>
								</div>
							</form>
						</div>
				
					<div class="right-child-content layui-tab-item"><!--人员属性标签 -->
						<form class="layui-form" method="post" id="formAttributeLabel" onsubmit="return false;">
							<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">人员属性标签</li>
									<li  onclick="applyTable(${personnel.id});">标签维护记录</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <table class="layui-table">
												<tr>
													<td>
														<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
													  		<legend style="font-size:16px">一级标签</legend>
														</fieldset>
														<div id="zslabels1" style="left:50px;"></div>
													</td>
												</tr>
												<tr>
													<td>
														<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
													  		<legend style="font-size:16px">二级标签</legend>
														</fieldset>
														<div id="zslabels2" style="left:50px;"></div>
													</td>
												</tr>
											</table>
								     </div>
								     <div class="layui-tab-item">
								            <table class="layui-hide" id="applyTable" lay-filter="applyTable"></table> 
								     </div>
								</div>
							</div>
						</form>
					</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-table" lay-even>
								<colgroup>
									<col width="120">
									<col width="300">
									<col width="120">
									<col width="300">
								</colgroup>
								<thead>
								</thead>
								<tbody>
									<tr>
										<td class="text-align-r my-text-nowarp">手机号码：</td>
										<td ><a href="#" style="text-decoration: underline;" onclick="openRelation('telnumber',${personnel.id},0);">${relation.telnumber}</a></td>
										<td class="text-align-r my-text-nowarp">使用手机：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('telephone',${personnel.id},0);">${relation.telephone}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">关联wifi：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedwifi',${personnel.id},0);">${relation.relatedwifi}</a></td>
										<td class="text-align-r my-text-nowarp">交通工具：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedvehicle',${personnel.id},0);">${relation.relatedvehicle}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">银行账号：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('bankaccount',${personnel.id},0);">${relation.bankaccount}</a></td>
										<td class="text-align-r my-text-nowarp">虚拟身份：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('netidentity',${personnel.id},0);">${relation.netidentity}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">网络支付：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('netpayment',${personnel.id},0);">${relation.netpayment}</a></td>
										<td class="text-align-r my-text-nowarp">涉及房产：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedhouse',${personnel.id},0);">${relation.relatedhouse}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">法人组织：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedlegal',${personnel.id},0);">${relation.relatedlegal}</a></td>
										<td class="text-align-r my-text-nowarp">驾驶证件：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relateddriver',${personnel.id},0);">${relation.relateddriver}</a></td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">护照情况：</td>
										<td><a href="#" style="text-decoration: underline;" onclick="openRelation('relatedpassport',${personnel.id},0);">${relation.relatedpassport}</a></td>
										<td class="text-align-r my-text-nowarp"></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="right-child-content layui-tab-item"><!-- 轨迹信息 -->
							<form class="layui-form" method="post" id="formTrajectoryTable" onsubmit="return false;">
	                            <div class="layui-inline" style="width:212px;left:20px;">
	                            	<select id="trajectoryTableTypes" lay-filter="trajectoryTableTypes"></select>
	                            </div>       
								<table class="layui-hide" id="trajectoryTable" lay-filter="trajectoryTable"></table>
							</form>
						</div>
					    <div class="right-child-content layui-tab-item">
					           <table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table><!-- 社会关系 -->
					    </div>
					    <div class="right-child-content layui-tab-item"><!-- 涉警涉案信息 -->
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
						<div class="right-child-content layui-tab-item"><!-- 关联物品 -->
							<form class="layui-form" method="post" id="goodsForm" onsubmit="return false;">
								<table class="layui-hide" id="goodsTable" lay-filter="goodsTable"></table>
							</form>
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
						 
					  <script type="text/html" id="socialrelationsbar">
                           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
	                    </script>
					</div>
				</div>
			</div>
		</form>
	<script>
		 $(document).ready(function(){
				getDefaultPhoto();//加载默认图片
				openZaDu('${personnel.id}');
				//addLabels('${personnel.zslabel1}','${personnel.zslabel2}','${personnel.lslabel1}','${personnel.lslabel2}','${personnel.id}');//加载已有人员标签
	  	
		});
		layui.use(['table','flow','element', 'form', 'jquery'], function() {
		    var flow = layui.flow;
		    var table = layui.table;
		   flow.lazyimg();//图片加载——重要
		
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
	    //监听公共管控力量   详情按钮
	  table.on('tool(kongcontrolpowerTable1)', function(obj){
		  var id = obj.data.id;
		   if(obj.event == 'showinfo'){
		   		var index = layui.layer.open({
					title : "公共管控力量详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getkongcontrolpowerbyid.do?id='+id+'&menuid=0&page=showinfo',
				    area: ['800', '600px'],
					maxmin: true,
					success : function(layero, index){
					}
				})	
			  layui.layer.full(index); 			
			  }
    	   });	
	 });
		 var riskFilesView=[];
		 //可疑特征  信息显示
          function openKongExtend(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getKongExtendByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var filesview=$("#risk-view-fileList");
						  var kongextend=data.kongextend;
					       if(kongextend.featuresphoto!=""){
								riskFilesView=kongextend.featuresphoto.split(",");
								if(riskFilesView.length>0){
									var viewname=kongextend.filesname.split(",");
									var viewname1=kongextend.filesallname.split(",");
								    var options="";
									$.each(riskFilesView,function(index,item){
									  options +="<div class='layui-col-md3 my-imgbox'>";
									    options +='<img lay-src="../uploadFiles/pictures/'+viewname1[index]+'">';
										options +="</div>";
						                //console.log("options="+options);
									});
								}
							$('#risk-view-fileList').html(options);
					  }
					var viewer = new Viewer(document.getElementById("risk-view-fileList"),{
				              url:	'data-original',
				              navbar:	false
	                    });
					}
				});
          }
       
                 //公共管控力量 列表显示
                 function  openKongControlPower(personnelid){
                   layui.table.render({
					    elem: '#kongcontrolpowerTable1',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchKongControlPower.do?forcetype=1&personnelid="+personnelid,
					    method:'post',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'personname', title: '姓名', width:100,align:"center"},
					        {field:'records', title: '前科情况', width:150,align:"center"},
					        {field:'actualstate', title: '现实表现',align:"center"} ,
					        {field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:80,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
					    });
					    //秘密管控力量 列表显示
					    layui.table.render({
					    elem: '#kongcontrolpowerTable2',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchKongControlPower.do?forcetype=2&personnelid="+personnelid,
					    method:'post',
					     toolbar: '#socialrelationstoolbar',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'birthdate', title: '编号', width:100,align:"center"},
					        {field:'personname', title: '管勤民警警号', width:150,align:"center"},
					        {field:'interesting', title: '管勤民警电话',align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }       
                //工作地、居住地 列表显示
                 function  openWorkandlive(personnelid){
                   layui.table.render({
					    elem: '#workandliveTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					      url :   locat+"/searchKongBackground.do?datatype=2&personnelid="+personnelid,
					    method:'post',
					     toolbar: '#socialrelationstoolbar',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'checktype', title: '地点类型', width:100,align:"center"},
					        {field:'checktime', title: '地点名称', width:150,align:"center"},
					        {field:'checkresume', title: '地点描述',align:"center"},
					        {field:'updateoperator', title: '修改人', width:100,align:"center"},
					        {field:'updatetime', title: '修改时间', width:150,align:"center"},
					    ]],
					    page: true,
					    limit: 10
					    });
                 }      
                    //背景审查 列表显示
                 function  openKongBackground(personnelid){
                   layui.table.render({
					    elem: '#kongbackgroundTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchKongBackground.do?datatype=1&personnelid="+personnelid,
					    method:'post',
					   cols: [[
					          {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'checktime', title: '审查时间', width:150,align:"center"},
					        {field:'checktype', title: '审查方式', width:150,align:"center"},
					        {field:'checkresume', title: '审查简述',align:"center"},
					        {field:'updateoperator', title: '修改人', width:100,align:"center"},
					        {field:'updatetime', title: '修改时间', width:150,align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }  
                 
		function openGoodsShow(){
         	//方法级渲染
			layui.table.render({
			    elem: '#goodsTable',
			    toolbar: false,
			   	defaultToolbar: ['filter', 'print'],
			    url: '<c:url value="/searchItemByPerson.do"/>',
			    where:{personid:${personnel.id }},
			    limit:5,
			    method:'post',
			    cols: [[
			    	{field:'itemtype', title: '物品品种', width:200,align:"center"} ,
			    	{field:'goodscodename', title: '物品型号', width:200,align:"center"} ,
			    	{field:'casename', title: '案件名称',align:"center"} ,
			    	{field:'sjdate', title: '收缴日期', width:200,align:"center"}
			    ]],
			    page: true
			  });
		}
		
		function openZaDu(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZaDuByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						if(data.firstDu>0){
							var zaDu=data.zaDu;
							$('#duHistory').show();
							$('#lssdqk').val(zaDu.lssdqk);
							$('#chsj').val(zaDu.chsj);
							$('#chjg').val(zaDu.chjg);
							$('#clxq').val(zaDu.clxq);
							$('#cfjg').val(zaDu.cfjg);
							$('#dbfs').val(zaDu.dbfs);
							$('#dbbw').val(zaDu.dbbw);
						}else{
							$('#duHistory').hide();
						}
					}
				});
          }
          
    	   $("#duHistory").click(function () {
					var index = layui.layer.open({
						title : "涉赌背景历史记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/za/duhistory.jsp?personnelid=${personnel.id}",
						area: ['800', '600px'],
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
				});  
    	   $("#changHistory").click(function () {
					var index = layui.layer.open({
						title : "涉娼背景历史记录",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/za/changhistory.jsp?personnelid=${personnel.id}",
						area: ['800', '600px'],
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
				});  
	</script>
	</body>
</html>
