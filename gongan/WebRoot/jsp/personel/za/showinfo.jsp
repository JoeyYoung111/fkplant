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

	   /* 修复小屏幕下左右tab重叠问题 */
	   .layui-form.layui-row {
	       display: flex;
	       flex-wrap: nowrap;
	       overflow-x: auto;
	       align-items: flex-start;
	   }

	   .layui-form.layui-row > .layui-col-md6 {
	       flex: 0 0 50%;
	       min-width: 500px;
	       max-width: 50%;
	       overflow-y: auto;
	       /*max-height: 100vh;*/
           height: auto;
           min-height: 100%;
	   }

	   /* 在小屏幕下确保两栏并排显示，允许横向滚动 */
	   @media screen and (max-width: 1200px) {
	       .layui-form.layui-row > .layui-col-md6 {
	           flex: 0 0 600px;
	           min-width: 500px;
	           max-width: 600px;
	           overflow-y: auto;
	           max-height: 100vh;
	       }
	   }

	   @media screen and (max-width: 768px) {
	       .layui-form.layui-row > .layui-col-md6 {
	           flex: 0 0 500px;
	           min-width: 450px;
	           max-width: 500px;
	           overflow-y: auto;
	           max-height: 100vh;
	       }
	   }
	</style>
  </head>
  
 <body class="childrenBody layui-fluid">
		<form class="layui-form layui-row" onsubmit="return false;">
		<input type="hidden"  name="id"    id="id"  value=${personnel.id }>
			<!-- 左边表单 -->
			<div class="layui-col-md6" style="border-right: 1px solid #eee">
				<!-- 基本信息 -->
				<div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px 15px 100px 15px;">
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
								<td class="text-align-r my-text-nowarp">户籍地省：</td>
								<td colspan="2">${personnel.houseProvince}</td>
								<td class="text-align-r my-text-nowarp">户籍地市：</td>
								<td colspan="2">${personnel.houseCity}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">户籍地县：</td>
								<td colspan="2">${personnel.houseCounty}</td>
								<td class="text-align-r my-text-nowarp">户籍地镇街：</td>
								<td colspan="2">${personnel.houseTown}</td>
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
								<td class="text-align-r my-text-nowarp">现住地省：</td>
								<td colspan="2">${personnel.homeProvince}</td>
								<td class="text-align-r my-text-nowarp">现住地市：</td>
								<td colspan="2">${personnel.homeCity}</td>
							</tr>
							<tr>
								<td class="text-align-r my-text-nowarp">现住地县：</td>
								<td colspan="2">${personnel.homeCounty}</td>
								<td class="text-align-r my-text-nowarp">现住地镇街：</td>
								<td colspan="2">${personnel.homeTown}</td>
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
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">涉赌前科：</td>--%>
<%--								<td colspan="2">--%>
<%--									<c:if test="${personnel.hasSheduRecord eq 1}">有</c:if>--%>
<%--									<c:if test="${personnel.hasSheduRecord eq 0 or empty personnel.hasSheduRecord}">无</c:if>--%>
<%--								</td>--%>
<%--								<td class="text-align-r my-text-nowarp">涉黄前科：</td>--%>
<%--								<td colspan="2">--%>
<%--									<c:if test="${personnel.hasSechangRecord eq 1}">有</c:if>--%>
<%--									<c:if test="${personnel.hasSechangRecord eq 0 or empty personnel.hasSechangRecord}">无</c:if>--%>
<%--								</td>--%>
<%--							</tr>--%>
							<tr>
								<td class="text-align-r my-text-nowarp">是否未成年：</td>
								<td colspan="2">
									<c:if test="${personnel.isMinor eq 1}">是</c:if>
									<c:if test="${personnel.isMinor eq 0 or empty personnel.isMinor}">否</c:if>
								</td>
								<td class="text-align-r my-text-nowarp">打处单位：</td>
								<td colspan="2" id="handleUnitDisplay">
									<c:choose>
										<c:when test="${not empty personnel.handleUnitCode}">
											<!-- 使用JavaScript根据handleUnitCode查找部门名称 -->
											<span id="handleUnitNames"></span>
										</c:when>
										<c:when test="${not empty personnel.handleUnit}">
											${personnel.handleUnit}
										</c:when>
										<c:otherwise>
											暂无
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
<%--						    <tr>--%>
<%--								<td class="text-align-r my-text-nowarp">工作地详址：</td>--%>
<%--								<td colspan="6">${personnel.workplace}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">工作地派出所：</td>--%>
<%--								<td colspan="2">${personnel.workpolice}&nbsp;&nbsp;--%>
<%--								<c:if test="${personnel.workwifi eq 1}">【wifi】</c:if>--%>
<%--								<c:if test="${personnel.workwide eq 1}">【宽带】</c:if></td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">工作地经度：</td>--%>
<%--								<td colspan="3">${personnel.workx}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">工作地纬度：</td>--%>
<%--								<td colspan="2">${personnel.worky}</td>--%>
<%--							</tr>--%>
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
<%--			    <div class="layui-row" style="padding: 1px;">--%>
<%--					<table class="layui-table" lay-even>--%>
<%--						<colgroup>--%>
<%--							<col width="100">--%>
<%--							<col width="150">--%>
<%--							<col width="100">--%>
<%--							<col width="150">--%>
<%--							<col width="100">--%>
<%--							<col width="150">--%>
<%--						</colgroup>--%>
<%--						<thead>--%>
<%--							<tr>--%>
<%--								<th colspan="6" class="layui-bg-blue layui-font-16 text-align-c">分级分类信息</th>--%>
<%--							</tr>--%>
<%--						</thead>--%>
<%--						<tbody>--%>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>--%>
<%--								<td>${personnel.jurisdictunit}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>--%>
<%--								<td>${personnel.jurisdictpolice}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">民警手机：</td>--%>
<%--								<td>${personnel.pphone1}</td>--%>
<%--							</tr>--%>
<%--							<tr>--%>
<%--								<td class="text-align-r my-text-nowarp">管辖责任单位：</td>--%>
<%--								<td>${personnel.policephone}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">管辖责任民警：</td>--%>
<%--								<td>${personnel.incontrolleve}</td>--%>
<%--								<td class="text-align-r my-text-nowarp">民警手机：</td>--%>
<%--								<td>${personnel.pphone2}</td>--%>
<%--							</tr>--%>
<%--						</tbody>--%>
<%--					</table>--%>
<%--				</div>--%>
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
								<li class="btn btn_6 swiper-slide" onclick="openZaChang(${personnel.id})" >涉黄背景</li>
								<li class="btn btn_13 swiper-slide" onclick="openZaPei(${personnel.id})" >陪侍记录</li>
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
                                <button class="layui-btn layui-btn-sm" id="duHistory"><i class="layui-icon">&#xe68d;</i>历史记录</button>
                                <div class="layui-col-md12">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">关联案件</label>
                                        <div class="my-input-block">
                                            <input type="hidden" name="relatedCaseId"
                                                   id="du_relatedCaseId" value="">
                                            <input type="text" id="du_caseName"
                                                   autocomplete="off"
                                                   class="layui-input" readonly
                                                   style="background:#efefef;">
                                        </div>
                                    </div>
                                </div>
								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉赌情况综述
										<button class="layui-btn layui-btn-sm" id="duHistory"><i class="layui-icon">&#xe68d;</i>历史记录</button>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="lssdqk" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">采集来源</label>
										<div class="my-input-block">
											<input type="text" id="collectSource-du" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
                                <div class="layui-col-md6">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">采集日期</label>
                                        <div class="my-input-block">
                                            <input type="text" id="du_collectDate" autocomplete="off" class="layui-input" readonly>
                                        </div>
                                    </div>
                                </div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">人员属性</label>
										<div class="my-input-block">
											<input type="text" id="du_rysx" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">赌博方式</label>
										<div class="my-input-block" >
                                            <input type="text" id="dbfs-div" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">赌博部位</label>
										<div class="my-input-block" >
                                            <input type="text" id="dbbw-div" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">手机号码</label>
										<div class="my-input-block">
											<input type="text" id="du_phone" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉赌前科</label>
										<div class="my-input-block">
											<input type="text" id="du_hasSheduRecord" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">打处单位</label>
										<div class="my-input-block">
											<input type="text" id="du_handleUnit" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
                                <div class="layui-col-md6">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">处罚情况</label>
                                        <div class="my-input-block" id="cfjg-div">
                                            <input type="text" id="cfjg" autocomplete="off" class="layui-input" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">处罚日期</label>
                                        <div class="my-input-block">
                                            <input type="text" id="chsj" autocomplete="off" class="layui-input" readonly>
                                        </div>
                                    </div>
                                </div>

                                <div class="layui-col-md12">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">涉案地址</label>
                                        <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="du_caseAddress" readonly></textarea>
                                        </div>
                                    </div>
                                </div>

								<div class="layui-col-md12">
									<label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">省：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homeProvince" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">地级市：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homeCity" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">县级市：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homeCounty" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">镇街：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homeTown" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">详细地址：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homeplace" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">现住地派出所：</label>
										<div class="layui-input-block">
											<input type="text" id="du_policeStation" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">现住地经度：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homex" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">现住地纬度：</label>
										<div class="layui-input-block">
											<input type="text" id="du_homey" class="layui-input" readonly>
										</div>
									</div>
								</div>

								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">查获经过</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chjg" readonly></textarea>
										</div>
									</div>
								</div>

								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">处理详情</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="clxq" readonly></textarea>
										</div>
									</div>
								</div>
                                <div class="layui-col-md12" style="height: 400px;"></div>
							</form>
						</div>
					<div class="right-child-content layui-tab-item" >
					     	<form class="layui-form" method="post" id="formZaChang" onsubmit="return false;">
                                <button class="layui-btn layui-btn-sm" id="changHistory"><i class="layui-icon">&#xe68d;</i>历史记录</button>
                                <div class="layui-col-md12">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">关联案件</label>
                                        <div class="my-input-block">
                                            <input type="hidden" name="relatedCaseId"
                                                   id="chang_relatedCaseId" value="">
                                            <input type="text" id="chang_caseName"
                                                   autocomplete="off"
                                                   class="layui-input" readonly
                                                   style="background:#efefef;">
                                        </div>
                                    </div>
                                </div>
								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉嫖情况综述
										<button class="layui-btn layui-btn-sm" id="changHistory"><i class="layui-icon">&#xe68d;</i>历史记录</button></label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_lsscqk" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">采集来源</label>
										<div class="my-input-block">
											<input type="text" id="collectSource-chang" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
                                <div class="layui-col-md6">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">采集日期</label>
                                        <div class="my-input-block">
                                            <input type="text" id="chang_collectDate" autocomplete="off" class="layui-input" readonly>
                                        </div>
                                    </div>
                                </div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">人员属性</label>
										<div class="my-input-block" >
                                            <input type="text" id="chang_scjs" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉黄方式</label>
										<div class="my-input-block" id="chang_myfs-div">
                                            <input type="text" id="chang_myfs" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉黄类型</label>
										<div class="my-input-block">
											<input type="text" id="chang_changType" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">手机号码</label>
										<div class="my-input-block">
											<input type="text" id="chang_phone" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉黄前科</label>
										<div class="my-input-block">
											<input type="text" id="chang_hasShechangRecord" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">打处单位</label>
										<div class="my-input-block">
											<input type="text" id="chang_handleUnit" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
                                <div class="layui-col-md6">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">处罚情况</label>
                                        <div class="my-input-block" id="chang_cfjg-div">
                                            <input type="text" id="chang_cfjg" autocomplete="off" class="layui-input" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">处罚日期</label>
                                        <div class="my-input-block">
                                            <input type="text" id="chang_chsj" autocomplete="off" class="layui-input" readonly>
                                        </div>
                                    </div>
                                </div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">是否未成年案件</label>
										<div class="my-input-block">
											<input type="text" id="chang_isMinorCase" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>

                                <div class="layui-col-md12">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">涉案地址</label>
                                        <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_caseAddress" readonly></textarea>
                                        </div>
                                    </div>
                                </div>

								<div class="layui-col-md12">
									<label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">省：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homeProvince" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">地级市：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homeCity" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">县级市：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homeCounty" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md3">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label">镇街：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homeTown" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">详细地址：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homeplace" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">现住地派出所：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_policeStation" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">现住地经度：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homex" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="layui-form-label my-text-nowarp">现住地纬度：</label>
										<div class="layui-input-block">
											<input type="text" id="chang_homey" class="layui-input" readonly>
										</div>
									</div>
								</div>



								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">查获经过</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_chjg" readonly></textarea>
										</div>
									</div>
								</div>

								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">处理详情</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="chang_clxq" readonly></textarea>
										</div>
									</div>
								</div>
                                <div class="layui-col-md12" style="height: 400px;"></div>
							</form>
						</div>

					<div class="right-child-content layui-tab-item" style="padding-bottom: 800px;">
					     	<form class="layui-form" method="post" id="formZaPei" onsubmit="return false;">
                                <button class="layui-btn layui-btn-sm" id="peiHistory"><i class="layui-icon">&#xe68d;</i>历史记录</button>
                                <div class="layui-col-md12">
                                    <div class="layui-form-item my-form-item">
                                        <label class="my-form-label-br">关联案件</label>
                                        <div class="my-input-block">
                                            <input type="hidden" name="relatedCaseId"
                                                   id="pei_relatedCaseId" value="">
                                            <input type="text" id="pei_caseName"
                                                   autocomplete="off"
                                                   class="layui-input" readonly
                                                   style="background:#efefef;">
                                        </div>
                                    </div>
                                </div>
								<div class="layui-col-md12" style="display:none;">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">陪侍情况综述
										<button class="layui-btn layui-btn-sm" id="peiHistory"><i class="layui-icon">&#xe68d;</i>历史记录</button></label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="pei_otherMemo" readonly></textarea>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">角色标签</label>
										<div class="my-input-block">
											<input type="text" id="pei_memo" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">采集来源</label>
										<div class="my-input-block">
											<input type="text" id="collectSource-pei" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md6">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">涉黄前科</label>
										<div class="my-input-block">
											<input type="text" id="pei_hasShechangRecord" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">采集日期</label>
										<div class="my-input-block">
											<input type="text" id="pei_collectDate" autocomplete="off" class="layui-input" readonly>
										</div>
									</div>
								</div>
								<div class="layui-col-md12">
									<div class="layui-form-item my-form-item">
										<label class="my-form-label-br">活动场所</label>
										<div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
												id="pei_activityPlace" readonly></textarea>
										</div>
									</div>
								</div>
                                <div class="layui-col-md12" style="height: 400px;"></div>
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
								           <div id="attributelabel" style="padding: 10px;"></div>
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
										<td colspan="3">
											<a href="#" style="text-decoration: underline;" onclick="openRelation('telnumber',${personnel.id},0);">${relation.telnumber}</a>
											<span style="color:#999;font-size:12px;margin-left:10px;">(显示最新记录，点击查看更多)</span>
										</td>
									</tr>
									<tr>
										<td class="text-align-r my-text-nowarp">使用手机：</td>
										<td colspan="3"><a href="#" style="text-decoration: underline;" onclick="openRelation('telephone',${personnel.id},0);">${relation.telephone}</a></td>
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
		// ✅ 定义locat变量，用于构建请求URL
		var locat = (window.location + '').split('/');
		if ('main' == locat[3]) {
			locat = locat[0] + '//' + locat[2];
		} else {
			locat = locat[0] + '//' + locat[2] + '/' + locat[3];
		}

		// ✅ 全局policeData，供所有函数共享
		var policeData = [];

		// ✅ 提前加载派出所数据（同步加载，确保后续函数可用）
		$.ajax({
		    type: 'GET',
		    url: '<c:url value="/getJiangyinPoliceStations.do"/>',
		    dataType: 'json',
		    async: false,
		    success: function(data) {
		        if (data && data.length > 0) {
		            for (var i = 0; i < data.length; i++) {
		                policeData.push({
		                    name: data[i].departname,
		                    departmentid: data[i].departmentid
		                });
		            }
		        }
		        window.policeData = policeData; // 同步到window
		    }
		});

		// ✅ 根据handleUnitCode查找单位名称的通用函数（支持多值逗号分隔）
		function getHandleUnitName(handleUnitCode) {
		    if (!handleUnitCode) return '-';
		    var codeStr = handleUnitCode.toString().trim();
		    var codeArray = codeStr.split(',');
		    var names = [];
		    var otherAdded = false;
		    for (var k = 0; k < codeArray.length; k++) {
		        var code = codeArray[k].trim();
		        if (!code) continue;
		        var codeNum = parseInt(code);
		        if (!isNaN(codeNum) && codeNum >= 240 && codeNum <= 263) {
		            var found = false;
		            for (var i = 0; i < policeData.length; i++) {
		                if (policeData[i].departmentid == code) {
		                    names.push(policeData[i].name);
		                    found = true;
		                    break;
		                }
		            }
		            if (!found && !otherAdded) {
		                names.push('治安大队');
		                otherAdded = true;
		            }
		        } else {
		            // 不在240-263范围内，只添加一次"治安大队"
		            if (!otherAdded) {
		                names.push('治安大队');
		                otherAdded = true;
		            }
		        }
		    }
		    return names.length > 0 ? names.join(', ') : '-';
		}

		 $(document).ready(function(){
				getDefaultPhoto();//加载默认图片
				openZaDu('${personnel.id}');
				loadAttributeLabels(); // 加载人员属性标签

				// ✅ 初始化涉警涉案信息
				setTimeout(function() {
					if (typeof openjqxx === 'function') {
						openjqxx('${personnel.cardnumber}');
						console.log('✓ 涉警信息初始化完成');
					}
				}, 100);

		});
		layui.use(['table','flow','element', 'form', 'jquery'], function() {
		    var flow = layui.flow;
		    var table = layui.table;
		    var element = layui.element;
		   flow.lazyimg();//图片加载——重要
		
		// 加载打处单位名称显示
		loadHandleUnitNames();

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

		// ========== 涉案信息函数定义（showinfo.jsp 专用版本）==========
		/**
		 * 打开涉案信息表格（只读展示）
		 * 注意：此函数在 showinfo.jsp 中本地定义，覆盖 personel221018.js 中的同名函数
		 * 包含 cfqk（处罚情况）和 cfrq（处罚日期）字段
		 */
		function openajxx(sfzh) {
			console.log('🔍 [showinfo.jsp] openajxx 函数被调用，sfzh=' + sfzh);
			layui.table.render({
				elem: '#ajxxTable',
				toolbar: true,
				defaultToolbar: ['filter', 'exports', 'print'],
				url: locat + "/searchXdAjxx.do?sfzh=" + sfzh,
				method: 'post',
				cols: [[
					{field: 'id', type: 'radio', fixed: 'true', align: "center"},
					{field: 'jjbh', title: '案件编号', width: 180, align: "center"},
					{field: 'slsj', title: '受理时间', width: 180, align: "center"},
					{field: 'ajlb', title: '案件类别', width: 150, align: "center"},
					{field: 'ajmc', title: '案件名称', width: 150, align: "center"},
					{field: 'sldwmc', title: '受理单位', width: 150, align: "center"},
					{field: 'jyaq', title: '简要案情', width: 150, align: "center"},
					{field: 'cfqk', title: '处罚情况', width: 180, align: "center"},
					{
						field: 'cfrq',
						title: '处罚日期',
						width: 150,
						align: "center",
						templet: function(d) {
							if (d.cfrq && d.cfrq.length === 14) {
								// 格式：20260318134727 -> 2026-03-18
								return d.cfrq.substring(0, 4) + '-' + d.cfrq.substring(4, 6) + '-' + d.cfrq.substring(6, 8);
							}
							return d.cfrq || '';
						}
					}
				]],
				page: true,
				limit: 10,
				done: function(res, curr, count) {
					console.log('✅ [showinfo.jsp] 涉案信息表格渲染完成');
					console.log('📊 返回数据:', res);
					console.log('📊 数据行数:', res.data ? res.data.length : 0);
					if (res.data && res.data.length > 0) {
						console.log('📝 第一条数据示例:', res.data[0]);
						console.log('  ✓ cfqk (处罚情况):', res.data[0].cfqk);
						console.log('  ✓ cfrq (处罚日期):', res.data[0].cfrq);
					}
				}
			});
		}

		// ✅ 监听涉警涉案 tab 切换
		element.on('tab(GuiJi)', function(data){
			console.log('🔄 涉警涉案tab切换，index=' + data.index);
			var cardnumber = '${personnel.cardnumber}';

			if (data.index === 0) {
				// 涉警信息 tab
				console.log('📋 切换到涉警信息tab');
				if (typeof openjqxx === 'function') {
					openjqxx(cardnumber);
				}
			} else if (data.index === 1) {
				// 涉案信息 tab
				console.log('📋 切换到涉案信息tab，调用 openajxx');
				openajxx(cardnumber);
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

		 // 加载打处单位名称显示（参考update.jsp的实现）
		 function loadHandleUnitNames() {
		     var handleUnitCode = '${personnel.handleUnitCode}';
		     if (!handleUnitCode || handleUnitCode.trim() === '') {
		         return;
		     }

		     // 使用与update.jsp相同的接口加载江阴派出所数据
		     $.ajax({
		         type: 'GET',
		         url: '<c:url value="/getJiangyinPoliceStations.do"/>',
		         dataType: 'json',
		         async: false,
		         success: function(data) {
		             if (data && data.length > 0) {
		                 var codes = handleUnitCode.split(',');
		                 var names = [];

		                 // 构建部门数据映射（与update.jsp保持一致）
		                 var policeData = [];
		                 for (var i = 0; i < data.length; i++) {
		                     policeData.push({
		                         name: data[i].departname,
		                         departmentid: data[i].departmentid
		                     });
		                 }

		                 // 查找每个部门ID对应的名称
		                 var otherAdded = false; // 标记"治安大队"是否已添加
		                 for (var i = 0; i < codes.length; i++) {
		                     var code = codes[i].trim();
		                     if (code !== '') {
		                         var codeNum = parseInt(code);
		                         // 不在240-263范围内，显示"治安大队"（只显示一次）
		                         if (isNaN(codeNum) || codeNum < 240 || codeNum > 263) {
		                             if (!otherAdded) {
		                                 names.push('治安大队');
		                                 otherAdded = true;
		                             }
		                             continue;
		                         }
		                         var foundName = '';
		                         // 从policeData中查找匹配的名称
		                         for (var j = 0; j < policeData.length; j++) {
		                             if (policeData[j].departmentid && policeData[j].departmentid.toString() === code) {
		                                 foundName = policeData[j].name;
		                                 break;
		                             }
		                         }
		                         // 如果找到了名称，使用名称；否则显示部门ID
		                         names.push(foundName || ('部门' + code));
		                     }
		                 }

		                 // 显示部门名称
		                 if (names.length > 0) {
		                     $('#handleUnitNames').text(names.join(', '));
		                 }
		             }
		         },
		         error: function() {
		             console.error('加载部门数据失败');
		         }
		     });
		 }

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
		
		/**
		 * 加载人员属性标签（table结构展示）
		 */
		function loadAttributeLabels() {
		    $("#attributelabel").html("");

		    // 获取人员已拥有的标签，确保过滤掉空字符串
		    var zslabel1Str = "${personnel.zslabel1}" || "";
		    var zslabel2Str = "${personnel.zslabel2}" || "";

		    var zslabel1Array = zslabel1Str.split(",").filter(function(id) {
		        return id && id.trim() !== "";
		    });
		    var zslabel2Array = zslabel2Str.split(",").filter(function(id) {
		        return id && id.trim() !== "";
		    });

		    console.log("一级标签:", zslabel1Array);
		    console.log("子标签:", zslabel2Array);

		    // 如果没有一级标签，显示提示信息
		    if (zslabel1Array.length === 0) {
		        $("#attributelabel").append(
		            "<table class='layui-table' lay-skin='line'>" +
		            "  <thead>" +
		            "    <tr>" +
		            "      <th width='30%'>一级标签</th>" +
		            "      <th width='70%'>子标签</th>" +
		            "    </tr>" +
		            "  </thead>" +
		            "  <tbody>" +
		            "    <tr>" +
		            "      <td colspan='2' style='text-align:center;color:#999;'>暂无标签</td>" +
		            "    </tr>" +
		            "  </tbody>" +
		            "</table>"
		        );
		        return;
		    }

		    // 创建table结构
		    var tableHtml =
		        "<table class='layui-table' lay-skin='line'>" +
		        "  <thead>" +
		        "    <tr>" +
		        "      <th width='30%'>一级标签</th>" +
		        "      <th width='70%'>子标签</th>" +
		        "    </tr>" +
		        "  </thead>" +
		        "  <tbody id='labelTableBody'>" +
		        "  </tbody>" +
		        "</table>";

		    $("#attributelabel").append(tableHtml);

		    // 获取所有一级标签
		    $.ajax({
		        type: 'POST',
		        url: '<c:url value="/getRootAttributeLabel.do" />',
		        dataType: 'json',
		        async: false,
		        success: function (rootLabels) {

		            // 遍历人员已拥有的每个一级标签
		            $.each(rootLabels, function (num, rootLabel) {

		                // 只展示人员已拥有的一级标签
		                if (zslabel1Array.indexOf(String(rootLabel.id)) === -1) {
		                    return true; // continue
		                }

		                // 获取该一级标签对应的所有子标签
		                $.ajax({
		                    type: 'GET',
		                    url: '<c:url value="/getChildrenLabelByParentid.do"/>',
		                    data: { parentid: rootLabel.id },
		                    dataType: 'json',
		                    async: false,
		                    success: function (childLabels) {

		                        // 筛选出人员已拥有的子标签名称
		                        var ownedChildLabels = [];
		                        if (childLabels && childLabels.length > 0) {
		                            console.log("子标签数据:", childLabels);
		                            $.each(childLabels, function (i, childLabel) {
		                                // TreeSelect返回的JSON中，字段名是name而不是attributelabel
		                                if (childLabel && childLabel.id) {
		                                    if (zslabel2Array.indexOf(String(childLabel.id)) !== -1) {
		                                        // 优先使用name字段，如果没有则使用title字段
		                                        var labelName = childLabel.name || childLabel.title || "";
		                                        if (labelName && labelName.trim() !== "") {
		                                            ownedChildLabels.push(labelName);
		                                        }
		                                    }
		                                }
		                            });
		                        }

		                        console.log("筛选出的子标签名称:", ownedChildLabels);

		                        // 构建子标签显示内容
		                        var childLabelsHtml = "";
		                        if (ownedChildLabels.length > 0) {
		                            // 有子标签，用顿号分隔显示
		                            childLabelsHtml = ownedChildLabels.join("、");
		                        } else {
		                            // 无子标签
		                            childLabelsHtml = "<span style='color:#999;'>无子标签</span>";
		                        }

		                        // 添加一行到table
		                        var rowHtml =
		                            "<tr>" +
		                            "  <td style='font-weight:600;'>" + rootLabel.attributelabel + "</td>" +
		                            "  <td>" + childLabelsHtml + "</td>" +
		                            "</tr>";

		                        $("#labelTableBody").append(rowHtml);
		                    }
		                });
		            });
		        }
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
							// ✅ 回显基本信息
							$('#du_caseName').val(zaDu.caseName || '');
							$('#lssdqk').val(zaDu.lssdqk || '');
							$('#collectSource-du').val(zaDu.collectSource || '');
							$('#du_rysx').val(zaDu.personAttribute || zaDu.rysx || '');
							$('#dbfs-div').val(zaDu.dbfs || '');
							$('#dbbw-div').val(zaDu.dbbw || '');
							$('#du_phone').val(zaDu.phone || '');
							$('#du_isMinorCase').val(zaDu.isMinorCase == 1 ? '是' : '否');
							// ✅ 回显地址信息
							$('#du_homeProvince').val(zaDu.homeProvince || '');
							$('#du_homeCity').val(zaDu.homeCity || '');
							$('#du_homeCounty').val(zaDu.homeCounty || '');
							$('#du_homeTown').val(zaDu.homeTown || '');
							$('#du_homeplace').val(zaDu.homeDetail || zaDu.homeplace || '');
							$('#du_policeStation').val(zaDu.homePoliceStationName || zaDu.policeStationName || '');
							$('#du_homex').val(zaDu.homeLng || zaDu.homex || '');
							$('#du_homey').val(zaDu.homeLat || zaDu.homey || '');
							// ✅ 回显其他信息
							$('#du_collectDate').val(zaDu.collectDate || '');
							$('#du_caseAddress').val(zaDu.caseAddressList || zaDu.caseAddress || '');
							$('#chsj').val(zaDu.chsj || '');
							$('#chjg').val(zaDu.chjg || '');
							$('#cfjg').val(zaDu.cfjg || '');
							$('#clxq').val(zaDu.clxq || '');

							// ✅ 回显涉赌前科
							$('#du_hasSheduRecord').val(zaDu.hasSheduRecord == 1 ? '有' : '无');

							// ✅ 回显打处单位
							$('#du_handleUnit').val(getHandleUnitName(zaDu.handleUnitCode));

							// ✅ 加载关联案件
							if(zaDu.id){
								loadExistingDuRel(zaDu.id);
							}
						}
					}
				});
          }
          
          function openZaChang(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZaChangByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						if(data.firstChang>0){
							var zaChang=data.zaChang;
							// ✅ 回显基本信息
							$('#chang_caseName').val(zaChang.caseName || '');
							$('#chang_lsscqk').val(zaChang.chang_lsscqk || zaChang.lsscqk || '');
							$('#collectSource-chang').val(zaChang.collectSource || '');
							$('#chang_scjs').val(zaChang.chang_scjs || zaChang.personAttribute || zaChang.scjs || '');
							$('#chang_myfs').val(zaChang.chang_myfs || zaChang.myfs || '');
							$('#chang_changType').val(zaChang.changType || '');
							$('#chang_phone').val(zaChang.phone || '');
							$('#chang_isMinorCase').val(zaChang.isMinorCase == 1 ? '是' : '否');
							// ✅ 回显地址信息
							$('#chang_homeProvince').val(zaChang.homeProvince || '');
							$('#chang_homeCity').val(zaChang.homeCity || '');
							$('#chang_homeCounty').val(zaChang.homeCounty || '');
							$('#chang_homeTown').val(zaChang.homeTown || '');
							$('#chang_homeplace').val(zaChang.homeDetail || zaChang.homeplace || '');
							$('#chang_policeStation').val(zaChang.homePoliceStationName || zaChang.policeStationName || '');
							$('#chang_homex').val(zaChang.homeLng || zaChang.homex || '');
							$('#chang_homey').val(zaChang.homeLat || zaChang.homey || '');
							// ✅ 回显其他信息
							$('#chang_collectDate').val(zaChang.collectDate || '');
							$('#chang_caseAddress').val(zaChang.caseAddressList || zaChang.caseAddress || '');
							$('#chang_chsj').val(zaChang.chang_chsj || zaChang.chsj || '');
							$('#chang_chjg').val(zaChang.chang_chjg || zaChang.chjg || '');
							$('#chang_cfjg').val(zaChang.chang_cfjg || zaChang.cfjg || '');
							$('#chang_clxq').val(zaChang.chang_clxq || zaChang.clxq || '');

							// ✅ 回显涉黄前科
							$('#chang_hasShechangRecord').val(zaChang.hasShechangRecord == 1 ? '有' : '无');

							// ✅ 回显打处单位
							$('#chang_handleUnit').val(getHandleUnitName(zaChang.handleUnitCode));

							// ✅ 加载关联案件
							if(zaChang.id){
								loadExistingChangRel(zaChang.id);
							}
						}
					}
				});
          }

          function openZaPei(personnelid){
          		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZaPeiByPersonnelid.do?personnelid="/>'+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						if(data.firstPei>0){
							var zaPei=data.zaPei;
							// ✅ 回显基本信息
							$('#pei_caseName').val(zaPei.caseName || '');
							$('#pei_otherMemo').val(zaPei.otherMemo || '');
							$('#pei_memo').val(zaPei.memo || '');
							$('#collectSource-pei').val(zaPei.collectSource || '');
							$('#pei_collectDate').val(zaPei.collectDate || '');
							$('#pei_activityPlace').val(zaPei.activityVenue || zaPei.activityPlace || '');

							// ✅ 回显涉黄前科
							$('#pei_hasShechangRecord').val(zaPei.hasShechangRecord == 1 ? '有' : '无');

							// ✅ 加载关联案件
							if(zaPei.id){
								loadExistingPeiRel(zaPei.id);
							}
						}
					}
				});
          }

    	   // ✅ 涉赌背景数据回显方法（详情页版本 - showinfo.jsp）
    	   function echoZaDuData(data) {
    	       console.log('📥 从历史记录接收涉赌数据（详情页）:', data);

    	       // ✅ 回显关联案件
    	       $('#du_relatedCaseId').val(data.caseName || '');

    	       // ✅ 回显基本信息
    	       $('#lssdqk').val(data.lssdqk || '');
    	       $('#collectSource-du').val(data.collectSource || '');
    	       $('#du_rysx').val(data.personAttribute || data.rysx || '');
    	       $('#dbfs-div').val(data.dbfs || '');
    	       $('#dbbw-div').val(data.dbbw || '');
    	       $('#du_dbType').val(data.dbTypeName || '');
    	       $('#du_phone').val(data.phone || '');
    	       $('#du_isMinorCase').val(data.isMinorCase == 1 ? '是' : '否');

    	       // ✅ 回显地址信息
    	       $('#du_homeProvince').val(data.homeProvince || '');
    	       $('#du_homeCity').val(data.homeCity || '');
    	       $('#du_homeCounty').val(data.homeCounty || '');
    	       $('#du_homeTown').val(data.homeTown || '');
    	       $('#du_homeplace').val(data.homeDetail || data.homeplace || '');
    	       $('#du_policeStation').val(data.homePoliceStationName || '');
    	       $('#du_homex').val(data.homeLng || data.homex || '');
    	       $('#du_homey').val(data.homeLat || data.homey || '');

    	       // ✅ 回显其他信息
    	       $('#du_collectDate').val(data.collectDate || '');
    	       $('#du_caseAddress').val(data.caseAddressList || data.caseAddress || '');
    	       $('#chsj').val(data.chsj || '');
    	       $('#chjg').val(data.chjg || '');
    	       $('#cfjg').val(data.cfjg || '');
    	       $('#clxq').val(data.clxq || '');

    	       // ✅ 回显涉赌前科
    	       $('#du_hasSheduRecord').val(data.hasSheduRecord == 1 ? '有' : '无');

    	       // ✅ 回显打处单位
    	       $('#du_handleUnit').val(getHandleUnitName(data.handleUnitCode));
    	       // ✅ 加载关联案件
    	       if(data.id){
    	           loadExistingDuRel(data.id);
    	       }

    	       console.log('✓ 涉赌数据回显完成（详情页）');
    	   }

    	   // ✅ 涉黄背景数据回显方法（详情页版本 - showinfo.jsp）
    	   function echoZaChangData(data) {
    	       console.log('📥 从历史记录接收涉黄数据（详情页）:', data);

    	       // ✅ 回显关联案件
    	       $('#chang_relatedCaseId').val(data.caseName || '');

    	       // ✅ 回显基本信息
    	       $('#chang_lsscqk').val(data.chang_lsscqk || data.lsscqk || '');
    	       $('#collectSource-chang').val(data.collectSource || '');
    	       $('#chang_scjs').val(data.chang_scjs || data.personAttribute || data.scjs || '');
    	       $('#chang_myfs').val(data.chang_myfs || data.myfs || '');
    	       $('#chang_changType').val(data.changType || '');
    	       $('#chang_phone').val(data.phone || '');
    	       $('#chang_isMinorCase').val(data.isMinorCase == 1 ? '是' : '否');

    	       // ✅ 回显地址信息
    	       $('#chang_homeProvince').val(data.homeProvince || '');
    	       $('#chang_homeCity').val(data.homeCity || '');
    	       $('#chang_homeCounty').val(data.homeCounty || '');
    	       $('#chang_homeTown').val(data.homeTown || '');
    	       $('#chang_homeplace').val(data.homeDetail || data.homeplace || '');
    	       $('#chang_policeStation').val(data.homePoliceStationName || '');
    	       $('#chang_homex').val(data.homeLng || data.homex || '');
    	       $('#chang_homey').val(data.homeLat || data.homey || '');

    	       // ✅ 回显其他信息
    	       $('#chang_collectDate').val(data.collectDate || '');
    	       $('#chang_caseAddress').val(data.caseAddressList || data.caseAddress || '');
    	       $('#chang_chsj').val(data.chang_chsj || data.chsj || '');
    	       $('#chang_chjg').val(data.chang_chjg || data.chjg || '');
    	       $('#chang_cfjg').val(data.chang_cfjg || data.cfjg || '');
    	       $('#chang_clxq').val(data.chang_clxq || data.clxq || '');

    	       // ✅ 回显涉黄前科
    	       $('#chang_hasShechangRecord').val(data.hasShechangRecord == 1 ? '有' : '无');

    	       // ✅ 回显打处单位
    	       $('#chang_handleUnit').val(getHandleUnitName(data.handleUnitCode));

    	       // ✅ 加载关联案件
    	       if(data.id){
    	           loadExistingChangRel(data.id);
    	       }

    	       console.log('✓ 涉黄数据回显完成（详情页）');
    	   }

    	   // ✅ 陪侍记录数据回显方法（详情页版本 - showinfo.jsp）
    	   function echoZaPeiData(data) {
    	       console.log('📥 从历史记录接收陪侍数据（详情页）:', data);

    	       // ✅ 回显关联案件
    	       $('#pei_relatedCaseId').val(data.caseName || '');

    	       // ✅ 回显基本信息
    	       $('#pei_otherMemo').val(data.otherMemo || '');
    	       $('#collectSource-pei').val(data.collectSource || '');
    	       $('#pei_collectDate').val(data.collectDate || '');
    	       $('#pei_activityPlace').val(data.activityVenue || data.activityPlace || '');

    	       // ✅ 回显涉黄前科
    	       $('#pei_hasShechangRecord').val(data.hasShechangRecord == 1 ? '有' : '无');

    	       // ✅ 加载关联案件
    	       if(data.id){
    	           loadExistingPeiRel(data.id);
    	       }

    	       console.log('✓ 陪侍数据回显完成（详情页）');
    	   }

    	   // ✅ echoDataToParent 统一回显入口函数（供历史记录页面调用）
    	   function echoDataToParent(data, type) {
    	       console.log('📥 echoDataToParent 接收数据，类型：' + type, data);

    	       if (type === 'du') {
    	           echoZaDuData(data);
    	       } else if (type === 'chang') {
    	           echoZaChangData(data);
    	       } else if (type === 'pei') {
    	           echoZaPeiData(data);
    	       } else {
    	           console.error('未知的数据类型：' + type);
    	       }

    	       // 关闭历史记录弹窗
    	       try {
    	           var index = parent.layer.getFrameIndex(window.name);
    	           parent.layer.close(index);
    	       } catch (e) {
    	           console.log('关闭弹窗失败（可能已关闭）:', e);
    	       }
    	   }

    	   // ============================================================
    	   // 涉赌关联案件功能（详情页只读版本）
    	   // ============================================================

    	   /**
    	    * 加载涉赌记录的已有关联关系（警情和案件）- 详情页只读显示
    	    */
    	   function loadExistingDuRel(duId) {
    	       if (!duId || duId <= 0) {
    	           console.log('无效的duId，跳过加载关联关系');
    	           return;
    	       }

    	       console.log('🔍 开始加载涉赌关联关系，duId:', duId);

    	       $.ajax({
    	           url: locat + '/queryDuRelations.do',
    	           data: {duId: duId},
    	           type: 'POST',
    	           dataType: 'json',
    	           async: false,
    	           success: function(result) {
    	               if (result && result.code === 0) {
    	                   console.log('✓ 查询到涉赌关联详情:', result);

    	                   window.selectedDuRelations = [];

    	                   if (result.jqList && result.jqList.length > 0) {
    	                       result.jqList.forEach(function(jq) {
    	                           window.selectedDuRelations.push({
    	                               type: 'jq',
    	                               id: jq.id,
    	                               name: (jq.jjsj || '') + '-' + (jq.bjnr || '')
    	                           });
    	                       });
    	                       console.log('✓ 加载 ' + result.jqList.length + ' 条警情');
    	                   }

    	                   if (result.ajList && result.ajList.length > 0) {
    	                       result.ajList.forEach(function(aj) {
    	                           window.selectedDuRelations.push({
    	                               type: 'aj',
    	                               id: aj.id,
    	                               name: (aj.ajbh || '') + '-' + (aj.ajmc || '')
    	                           });
    	                       });
    	                       console.log('✓ 加载 ' + result.ajList.length + ' 条案件');
    	                   }

    	                   updateDuRelationDisplay();
    	                   console.log('✅ 涉赌关联关系加载完成，共 ' + window.selectedDuRelations.length + ' 条');
    	               }
    	           }
    	       });
    	   }

    	   /**
    	    * 更新涉赌关联案件显示（详情页只读版本）
    	    */
    	   function updateDuRelationDisplay() {
    	       var formItem = $('#du_caseName').closest('.layui-form-item');
    	       formItem.find('.du-relation-list').remove();

    	       if (window.selectedDuRelations && window.selectedDuRelations.length > 0) {
    	           $('#du_caseName').val('已关联 ' + window.selectedDuRelations.length + ' 条记录');

    	           var html = '<div class="du-relation-list" style="margin-top:10px;border:1px solid #e6e6e6;padding:10px;border-radius:4px;background:#f8f8f8;width:100%;">';
    	           html += '<div style="margin-bottom:8px;font-weight:bold;color:#333;">关联列表：</div>';

    	           window.selectedDuRelations.forEach(function(rel) {
    	               var typeText = rel.type === 'jq'
    	                   ? '<span style="display:inline-block;padding:2px 8px;background:#1E9FFF;color:#fff;border-radius:3px;font-size:12px;">警情</span>'
    	                   : '<span style="display:inline-block;padding:2px 8px;background:#FF5722;color:#fff;border-radius:3px;font-size:12px;">案件</span>';

    	               html += '<div style="padding:8px;margin:5px 0;background:#fff;border:1px solid #e6e6e6;border-radius:3px;">';
    	               html += typeText + ' <span style="margin-left:8px;color:#666;">' + rel.name + '</span>';
    	               html += '</div>';
    	           });

    	           html += '</div>';
    	           formItem.append(html);
    	       } else {
    	           $('#du_caseName').val('');
    	       }
    	   }

    	   // ============================================================
    	   // 涉黄关联案件功能（详情页只读版本）
    	   // ============================================================

    	   /**
    	    * 加载涉黄记录的已有关联关系（警情和案件）- 详情页只读显示
    	    */
    	   function loadExistingChangRel(changId) {
    	       if (!changId || changId <= 0) {
    	           console.log('无效的changId，跳过加载关联关系');
    	           return;
    	       }

    	       console.log('🔍 开始加载涉黄关联关系，changId:', changId);

    	       $.ajax({
    	           url: locat + '/queryChangRelations.do',
    	           data: {changId: changId},
    	           type: 'POST',
    	           dataType: 'json',
    	           async: false,
    	           success: function(result) {
    	               if (result && result.code === 0) {
    	                   console.log('✓ 查询到涉黄关联详情:', result);

    	                   window.selectedChangRelations = [];

    	                   if (result.jqList && result.jqList.length > 0) {
    	                       result.jqList.forEach(function(jq) {
    	                           window.selectedChangRelations.push({
    	                               type: 'jq',
    	                               id: jq.id,
    	                               name: (jq.jjsj || '') + '-' + (jq.bjnr || '')
    	                           });
    	                       });
    	                       console.log('✓ 加载 ' + result.jqList.length + ' 条警情');
    	                   }

    	                   if (result.ajList && result.ajList.length > 0) {
    	                       result.ajList.forEach(function(aj) {
    	                           window.selectedChangRelations.push({
    	                               type: 'aj',
    	                               id: aj.id,
    	                               name: (aj.ajbh || '') + '-' + (aj.ajmc || '')
    	                           });
    	                       });
    	                       console.log('✓ 加载 ' + result.ajList.length + ' 条案件');
    	                   }

    	                   updateChangRelationDisplay();
    	                   console.log('✅ 涉黄关联关系加载完成，共 ' + window.selectedChangRelations.length + ' 条');
    	               }
    	           }
    	       });
    	   }

    	   /**
    	    * 更新涉黄关联案件显示（详情页只读版本）
    	    */
    	   function updateChangRelationDisplay() {
    	       var formItem = $('#chang_caseName').closest('.layui-form-item');
    	       formItem.find('.chang-relation-list').remove();

    	       if (window.selectedChangRelations && window.selectedChangRelations.length > 0) {
    	           $('#chang_caseName').val('已关联 ' + window.selectedChangRelations.length + ' 条记录');

    	           var html = '<div class="chang-relation-list" style="margin-top:10px;border:1px solid #e6e6e6;padding:10px;border-radius:4px;background:#f8f8f8;width:100%;">';
    	           html += '<div style="margin-bottom:8px;font-weight:bold;color:#333;">关联列表：</div>';

    	           window.selectedChangRelations.forEach(function(rel) {
    	               var typeText = rel.type === 'jq'
    	                   ? '<span style="display:inline-block;padding:2px 8px;background:#1E9FFF;color:#fff;border-radius:3px;font-size:12px;">警情</span>'
    	                   : '<span style="display:inline-block;padding:2px 8px;background:#FF5722;color:#fff;border-radius:3px;font-size:12px;">案件</span>';

    	               html += '<div style="padding:8px;margin:5px 0;background:#fff;border:1px solid #e6e6e6;border-radius:3px;">';
    	               html += typeText + ' <span style="margin-left:8px;color:#666;">' + rel.name + '</span>';
    	               html += '</div>';
    	           });

    	           html += '</div>';
    	           formItem.append(html);
    	       } else {
    	           $('#chang_caseName').val('');
    	       }
    	   }

    	   // ============================================================
    	   // 陪侍关联案件功能（详情页只读版本）
    	   // ============================================================

    	   /**
    	    * 加载陪侍记录的已有关联关系（警情和案件）- 详情页只读显示
    	    */
    	   function loadExistingPeiRel(peiId) {
    	       if (!peiId || peiId <= 0) {
    	           console.log('无效的peiId，跳过加载关联关系');
    	           return;
    	       }

    	       console.log('🔍 开始加载陪侍关联关系，peiId:', peiId);

    	       $.ajax({
    	           url: locat + '/queryPeiRelations.do',
    	           data: {peiId: peiId},
    	           type: 'POST',
    	           dataType: 'json',
    	           async: false,
    	           success: function(result) {
    	               if (result && result.code === 0) {
    	                   console.log('✓ 查询到陪侍关联详情:', result);

    	                   window.selectedPeiRelations = [];

    	                   if (result.jqList && result.jqList.length > 0) {
    	                       result.jqList.forEach(function(jq) {
    	                           window.selectedPeiRelations.push({
    	                               type: 'jq',
    	                               id: jq.id,
    	                               name: (jq.jjsj || '') + '-' + (jq.bjnr || '')
    	                           });
    	                       });
    	                       console.log('✓ 加载 ' + result.jqList.length + ' 条警情');
    	                   }

    	                   if (result.ajList && result.ajList.length > 0) {
    	                       result.ajList.forEach(function(aj) {
    	                           window.selectedPeiRelations.push({
    	                               type: 'aj',
    	                               id: aj.id,
    	                               name: (aj.ajbh || '') + '-' + (aj.ajmc || '')
    	                           });
    	                       });
    	                       console.log('✓ 加载 ' + result.ajList.length + ' 条案件');
    	                   }

    	                   updatePeiRelationDisplay();
    	                   console.log('✅ 陪侍关联关系加载完成，共 ' + window.selectedPeiRelations.length + ' 条');
    	               }
    	           }
    	       });
    	   }

    	   /**
    	    * 更新陪侍关联案件显示（详情页只读版本）
    	    */
    	   function updatePeiRelationDisplay() {
    	       var formItem = $('#pei_caseName').closest('.layui-form-item');
    	       formItem.find('.pei-relation-list').remove();

    	       if (window.selectedPeiRelations && window.selectedPeiRelations.length > 0) {
    	           $('#pei_caseName').val('已关联 ' + window.selectedPeiRelations.length + ' 条记录');

    	           var html = '<div class="pei-relation-list" style="margin-top:10px;border:1px solid #e6e6e6;padding:10px;border-radius:4px;background:#f8f8f8;width:100%;">';
    	           html += '<div style="margin-bottom:8px;font-weight:bold;color:#333;">关联列表：</div>';

    	           window.selectedPeiRelations.forEach(function(rel) {
    	               var typeText = rel.type === 'jq'
    	                   ? '<span style="display:inline-block;padding:2px 8px;background:#1E9FFF;color:#fff;border-radius:3px;font-size:12px;">警情</span>'
    	                   : '<span style="display:inline-block;padding:2px 8px;background:#FF5722;color:#fff;border-radius:3px;font-size:12px;">案件</span>';

    	               html += '<div style="padding:8px;margin:5px 0;background:#fff;border:1px solid #e6e6e6;border-radius:3px;">';
    	               html += typeText + ' <span style="margin-left:8px;color:#666;">' + rel.name + '</span>';
    	               html += '</div>';
    	           });

    	           html += '</div>';
    	           formItem.append(html);
    	       } else {
    	           $('#pei_caseName').val('');
    	       }
    	   }

    	   $("#duHistory").click(function () {
				var index = layui.layer.open({
					title : "涉赌背景历史记录",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/jsp/personel/za/duhistory.jsp?personnelid=${personnel.id}&showflag=1",
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
					title : "涉黄背景历史记录",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/jsp/personel/za/changhistory.jsp?personnelid=${personnel.id}&showflag=1",
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
    	   $("#peiHistory").click(function () {
				var index = layui.layer.open({
					title : "陪侍背景历史记录",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/jsp/personel/za/peihistory.jsp?personnelid=${personnel.id}&showflag=1",
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
