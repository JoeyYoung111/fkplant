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
    
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	<link rel="stylesheet" href="<c:url value='/layui/css/layui1.css'/>"/>
  	<link rel="stylesheet" href="<c:url value='/css/public.css'/>" media="all" />
  	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  	
  </head>
<body class="childrenBody">
 	<div class="layui-row layui-col-md12">
		<div class="layui-tab">
			<ul class="layui-tab-title btn-list2">
				<li class="btn btn_1 layui-this">基本信息</li>
				<li class="btn btn_2" >法人信息</li>
				<li class="btn btn_3" onclick="xkz();">许可证信息</li>
				<li class="btn btn_4" onclick="hxp();">化学品品种</li>
				<li class="btn btn_5" onclick="bzry();">办证人员信息</li>
				<li class="btn btn_6" onclick="cyry();">从业人员信息</li>
				<li class="btn btn_7" onclick="sb();">设备基本信息</li>
				<c:if test="${yunshu == 1039}"><li class="btn btn_6" onclick="cl();">运输车辆信息</li></c:if>
				<li class="btn btn_7" onclick="dwhc();">单位核查记录</li>
			</ul>
			<div class="layui-tab-content" style="padding: 0;">
			
				<div class="layui-tab-item layui-show ">
					<form class="layui-form" method="post" id="form1" onsubmit="return false;">
						<table class="layui-table" lay-even>
							<colgroup>
								<col width="120">
								<col width="280">
								<col width="120">
								<col width="280">
							</colgroup>
							<thead>
								<tr>
									<th colspan="9" class="layui-bg-blue layui-font-16 text-align-c">单位基本信息</th>
								</tr>
							</thead>
							<tbody>
								<input type="hidden" name="menuid" value=${menuid } />	
								<input type="hidden" name="companytype" id="companytype" value="${company.companytype }" />
								<input type="hidden" name="id" id="id" value=${id } />
								<tr>
									<td class="text-align-r">单位名称：</td>
									<td>
										<input type="text" class="layui-input" name="companyname" id="companyname" value="${company.companyname }" lay-verify="required" autocomplete="off" lay-reqtext="请输入单位名称"/>
									</td>
									<td class="text-align-r">社会统一代码：</td>
									<td>
										<input type="text" class="layui-input" name="companycode" id="companycode" value="${company.companycode }" lay-verify="required|checkcoce" autocomplete="off" lay-reqtext="请输入征信代码"/>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">单位大类：</td>
									<td>
										<input type="text" class="layui-input" value="${companytypename }" readonly="true" />
									</td>
									<td class="text-align-r">单位类型：</td>
									<td>
										<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="生产" title="生产" />
							      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="经营" title="经营" />
							      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="使用" title="使用" />
							      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="运输" title="运输" />
							      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="仓储" title="仓储" />
									</td>
								</tr>
								<tr>
									<td class="text-align-r">是否入网：</td>
									<td>
										<select id="innet" name="innet"lay-verify="required">
									 		<option value="1"<c:if test="${company.innet eq '1' }"> selected</c:if>>是</option>
									 		<option value="2"<c:if test="${company.innet eq '2' }"> selected</c:if>>否</option>
									 	</select>
									</td>
									<td class="text-align-r">联系电话：</td>
									<td>
										<input type="text" class="layui-input" name="telephone" id="telephone" value="${company.telephone}" autocomplete="off" />
									</td>
								</tr>
								<tr>
									<td class="text-align-r">企业状态：</td>
									<td>
										<select id="companystatus" name="companystatus">
							    			<option value="正常"<c:if test="${company.companystatus eq '正常' }"> selected</c:if>>正常</option>
							    			<option value="停用"<c:if test="${company.companystatus eq '停用' }"> selected</c:if>>停用</option>
							    		</select>
									</td>
									<td class="text-align-r">停用原因：</td>
									<td>
										<select id="unusedreason" name="unusedreason">
							      			<option value=""<c:if test='${company.unusedreason eq "" }'>selected</c:if>>未停用可不选</option>
							      			<option value="工艺改进"<c:if test='${company.unusedreason eq "工艺改进" }'> selected</c:if>>工艺改进</option>
							      			<option value="政策关停"<c:if test='${company.unusedreason eq "政策关停" }'> selected</c:if>>政策关停</option>
							      			<option value="其他"<c:if test='${company.unusedreason eq "其他" }'> selected</c:if>>其他</option>
							      		</select>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">涉及品种：</td>
									<td colspan="3">
										<div id="managetype"></div>
									</td>
								</tr>
								<tr>
									<td class="text-align-r" style="height:75px;">经营范围：</td>
									<td colspan="3">
										<input type="text" class="layui-input" style="height:65px;" name="managerange" id="managerange" value="${company.managerange }" autocomplete="off"/>
									</td>
								</tr>
								<tr>
									<td class="text-align-r" style="height:75px;">备注：</td>
									<td colspan="3">
										<textarea name="memo" id="memo" class="layui-textarea">${company.memo }</textarea>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">注册地详址：</td>
									<td>
										<input type="text" class="layui-input" name="registerplace" id="registerplace" value="${company.registerplace }" autocomplete="off"/>
									</td>
									<td class="text-align-r">所属辖区派出所：</td>
									<td>
										<div class="layui-input-inline" id="ZCDXQ">
											<input type="text" class="layui-input" name="registerowner" id="registerowner" lay-filter="registerowner"  autocomplete="off" lay-reqdiv="ZCDXQ"/>
										</div>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">实际办公地详址：</td>
									<td>
										<input type="text" class="layui-input" name="realworkplace" id="realworkplace" value="${company.realworkplace }" onclick="openPGis();" readonly style="background:#efefef;cursor:pointer;" autocomplete="off"/>
									</td>
									<td class="text-align-r">所属辖区派出所：</td>
									<td>
										<div class="layui-input-inline" id="ZCDXQ">
											<input type="text" class="layui-input" name="realworkowner" id="realworkowner" lay-filter="realworkowner" autocomplete="off" lay-reqdiv="BGDXQ"/>
										</div>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">经度：</td>
									<td>
										<input type="text" class="layui-input" name="longitude" id="longitude" value="${company.longitude }" onclick="openPGis();" readonly style="background:#efefef;cursor:pointer;" autocomplete="off"/>
									</td>
									<td class="text-align-r">纬度：</td>
									<td>
										<input type="text" class="layui-input" name="latitude" id="latitude" value="${company.latitude }" onclick="openPGis();" readonly style="background:#efefef;cursor:pointer;" autocomplete="off"/>
									</td>
								</tr>
								<tr>
									<input type="hidden" name="codephoto" id="codephoto" value=""/>
									<input type="hidden" name="ramainStateid" id="remainStateid" />
								    <input type="hidden" name="delidstr" id="delidstr" value="" />
									<td class="text-align-r" >经营执照照片：</td>
									<td colspan="2">
										<div style="margin-top:10px;">
								    		<blockquote >
								    			<div id="showlist" style="overflow:hodden;height:120px;">
									    			<c:forEach items="${files}" var="row" varStatus="num">
														<button class="layui-anim layui-anim-scale"><image class="layui-upload-img" style="height:100px;width:100px;" src='${pictureurl}${row.fileallName}' /><div class="my-tag-close demo-delete" onclick="cancelImg(${row.id},this);"></div></button>&nbsp;&nbsp;
													</c:forEach>
								    			</div>
								    		</blockquote>
								    	</div>
									</td>
									<td>
										<button type="button" style="display:none" id="upload_pic">图片提交按钮(不显示 js中设置触发)</button>
										<button type="button" class="layui-btn" id="picture"><i class="layui-icon">&#xe67c;</i>上传图片</button>
										<button type="button" class="layui-btn" onclick="repic();"><i class="layui-icon">&#xe67c;</i>清空图片</button>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="layui-input-block">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="companySub">立即提交</button>
							<button type="reset" class="layui-btn layui-btn-primary" id="companyReset2">重置</button>
						</div>
					</form>
				</div>
				
				<div class="layui-tab-item">
					<form class="layui-form" method="post" id="form2">
						<table class="layui-table" lay-even>
							<colgroup>
								<col width="100">
								<col width="300">
								<col width="100">
								<col width="300">
							</colgroup>
							<thead>
								<tr>
									<th colspan="9" class="layui-bg-blue layui-font-16 text-align-c">法人信息</th>
								</tr>
							</thead>
							<tbody>
								<input type="hidden" name="menuid" value=${menuid } />	
								<input type="hidden" name="id" id="id" value=${id } />
								<tr>
									<td class="text-align-r">姓名：</td>
									<td>
										<input type="text" class="layui-input" name="legalname" id="legalname" value="${company.legalname }" autocomplete="off" lay-reqtext="请输入姓名"/>
									</td>
									<td class="text-align-r">性别：</td>
									<td>
										<input type="radio" name="sexes" value="男" title="男" <c:if test="${company.sexes eq '男' }"> checked</c:if> />
										<input type="radio" name="sexes" value="女" title="女" <c:if test="${company.sexes eq '女' }"> checked</c:if> />
									</td>
								</tr>
								<tr>
									<td class="text-align-r">证件类型:</td>
									<td>
										<select id="zjlx" name="zjlx" lay-filter="zjlx" lay-verify="required" lay-reqtext="请选择证件类型"></select>
									</td>
									<td class="text-align-r">证件号码：</td>
									<td>
										<input type="text" class="layui-input" name="cardnumber" id="cardnumber" lay-verify="required" value="${company.cardnumber }" autocomplete="off"  lay-reqtext="证件号码不能为空"/>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">文化程度：</td>
									<td>
										<select name="education" id="education" lay-filter="education" lay-verify="required" lay-reqtext="请选择文化程度"></select>
									</td>
									<td class="text-align-r">民族：</td>
									<td>
										<select name="nation" id="nation" lay-filter="nation" lay-verify="required" lay-reqtext="请选择民族"></select>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">联系电话：</td>
									<td>
										<input type="text" class="layui-input" name="legalphone" id="legalphone" value="${company.legalphone }" autocomplete="off"/>
									</td>
									<td class="text-align-r">政治面貌：</td>
									<td>
										<select name="politicalposition" id="politicalposition" lay-filter="politicalposition" lay-verify="required" lay-reqtext="请选择政治面貌"></select>
									</td>
								</tr>
								<tr>
									<td class="text-align-r">户籍地详址：</td>
									<td>
										<input type="text" class="layui-input" name="homeplace" id="homeplace" value="${company.homeplace }" autocomplete="off"/>
									</td>
									<td class="text-align-r">现住地详址：</td>
									<td>
										<input type="text" class="layui-input" name="lifeplace" id="lifeplace" value="${company.lifeplace }" autocomplete="off"/>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="layui-input-block">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="companyFRSub">立即提交</button>
							<button type="reset" class="layui-btn layui-btn-primary" id="companyReset">重置</button>
						</div>
					</form>
				</div>
				
				<div class="layui-tab-item">
					<blockquote class="layui-elem-quote news_search">
						<div class="demoTable">
							<form class="layui-form" method="post" style="display:inline;" id="Licenceform">
							<input type="hidden" name="menuid" value=${menuid } />	
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="licenceallowdate" id="licenceallowdate" placeholder="发证日期" autocomplete="off"/>
								</div>
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="licencevalidityend" id="licencevalidityend" placeholder="有效日期" autocomplete="off"/>
								</div>
							</form>
							<button class="layui-btn" id="searchlicence" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
							<script type="text/html" id="toolbarLicence">
								<button type="button" class="layui-btn layui-btn-sm" lay-event="addLicence"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="updateLicence"><i class="layui-icon layui-icon-edit"></i>修 改</button>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelLicence"><i class="layui-icon layui-icon-delete"></i>删 除</button>
							</script>
						</div>
					</blockquote>
					<table class="layui-hide" id="XKZTable" lay-filter="XKZTable"></table>
					<script type="text/html" id="XKZ">
						<a class="layui-btn layui-btn-xs" lay-event="XKZinfo">详情</a>
					</script>
				</div>
				
				<div class="layui-tab-item">
					<blockquote class="layui-elem-quote news_search">
						<div class="demoTable">
							<form class="layui-form" method="post" style="display:inline;" id="Chemicalform">
								<input type="hidden" name="menuid" value=${menuid } />	
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="chemicalname" id="chemicalname" placeholder="化学品名称" autocomplete="off"/>
								</div>
								<div class="layui-inline" style="width:187px;">
									<select id="chemicalpurpose" name="chemicalpurpose">
										<option value="" selected>用途:全部</option>
										<option value="经营">经营</option>
										<option value="运输">运输</option>
										<option value="使用">使用</option>
									</select>
								</div>
							</form>
							<button class="layui-btn" id="searchChemical" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
							<script type="text/html" id="toolbarChemical">
								<button type="button" class="layui-btn layui-btn-sm" lay-event="addChemical"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="updateChemical"><i class="layui-icon layui-icon-edit"></i>修 改</button>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelChemical"><i class="layui-icon layui-icon-delete"></i>删 除</button>
							</script>
						</div>
					</blockquote>
					<table class="layui-hide" id="ChemicalTable" lay-filter="ChemicalTable"></table>
					<script type="text/html" id="CHEMIC">
						<a class="layui-btn layui-btn-xs" lay-event="Chemicalinfo">详情</a>
					</script>
				</div>
				
				<div class="layui-tab-item">
					<blockquote class="layui-elem-quote news_search">
					<div class="demoTable">
						<form class="layui-form" method="post" style="display:inline;" id="Messengerform" >
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Mepersonname" id="Mepersonname" placeholder="姓名" autocomplete="off"/>
							</div>
							<div class="layui-inline" style="width:187px;">
								<select id="Mesexes" name="Mesexes">
									<option value="" selected>性别:全部</option>
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Mecardnumber" id="Mecardnumber" placeholder="身份证号码" autocomplete="off"/>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Metelephone" id="Metelephone" placeholder="联系电话" autocomplete="off"/>
							</div>
							<div class="layui-inline" style="187px;">
								<select name="Meducation" id="Meducation"></select>
							</div>
							<div class="layui-inline" style="187px;">
								<select name="Mnation" id="Mnation"></select>
							</div>
						</form>
						<button class="layui-btn" id="searchMessenger" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
						<script type="text/html" id="toolbarMessenger">
							<button type="button" class="layui-btn layui-btn-sm" lay-event="addMessenger"><i class="layui-icon layui-icon-add-1"></i>添加</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="updateMessenger"><i class="layui-icon layui-icon-edit"></i>修 改</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelMessenger"><i class="layui-icon layui-icon-delete"></i>删 除</button>
						</script>
					</div>
					</blockquote>
					<table class="layui-hide" id="MessengerTable" lay-filter="MessengerTable"></table>
					<script type="text/html" id="MES">
						<a class="layui-btn layui-btn-xs" lay-event="Messengerinfo">详情</a>
					</script>
				</div>
				
				<div class="layui-tab-item">
					<blockquote class="layui-elem-quote news_search">
					<div class="demoTable">
						<form class="layui-form" method="post" style="display:inline;" id="Chemistryform" >
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Chpersonname" id="Chpersonname" placeholder="姓名" autocomplete="off"/>
							</div>
							<div class="layui-inline" style="width:187px;">
								<select id="Chsexes" name="Chsexes">
									<option value="" selected>性别:全部</option>
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Chcardnumber" id="Chcardnumber" placeholder="身份证号码" autocomplete="off"/>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Chtelephone" id="Chtelephone" placeholder="联系电话" autocomplete="off"/>
							</div>
						</form>
						<button class="layui-btn" id="searchChemistry" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
						<script type="text/html" id="toolbarChemistry">
							<button type="button" class="layui-btn layui-btn-sm" lay-event="addChemistry"><i class="layui-icon layui-icon-add-1"></i>添加</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="updateChemistry"><i class="layui-icon layui-icon-edit"></i>修 改</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelChemistry"><i class="layui-icon layui-icon-delete"></i>删 除</button>
						</script>
					</div>
					</blockquote>
					<table class="layui-hide" id="ChemistryTable" lay-filter="ChemistryTable"></table>
					<script type="text/html" id="CHEMIS">
						<a class="layui-btn layui-btn-xs" lay-event="Chemistryinfo">详情</a>
					</script>
				</div>
				
				<div class="layui-tab-item">
					<blockquote class="layui-elem-quote news_search">
					<div class="demoTable">
						<form class="layui-form" method="post" style="display:inline;" id="Equipform" >
						<div class="layui-inline" style="width:187px;">
							<select id="usestatus" name="usestatus">
								<option value="" selected>使用情况:全部</option>
								<option value="自用">自用</option>
								<option value="租借">租借</option>
								<option value="购销">购销</option>
							</select>
						</div>
						<div class="layui-inline" style="width:187px;">
							<select id="usestate" name="usestate">
								<option value="" selected>使用状态:全部</option>
								<option value="正常">正常</option>
								<option value="停用">停用</option>
								<option value="报废">报废</option>
							</select>
						</div>
						</form>
						<button class="layui-btn" id="searchEquipment" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
						<script type="text/html" id="toolbarEquipment">
							<button type="button" class="layui-btn layui-btn-sm" lay-event="addEquipment"><i class="layui-icon layui-icon-add-1"></i>添加</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="updateEquipment"><i class="layui-icon layui-icon-edit"></i>修 改</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelEquipment"><i class="layui-icon layui-icon-delete"></i>删 除</button>
						</script>
					</div>
					</blockquote>
					<table class="layui-hide" id="EquipmentTable" lay-filter="EquipmentTable"></table>
					<script type="text/html" id="EQUIP">
						<a class="layui-btn layui-btn-xs" lay-event="Equipmentinfo">详情</a>
					</script>
				</div>
				
				<c:if test="${yunshu == 1039}">
					<div class="layui-tab-item">
						<blockquote class="layui-elem-quote news_search">
						<div class="demoTable">
							<form class="layui-form" method="post" style="display:inline;" id="vehicleform" >
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="vehicleno" id="vehicleno" placeholder="车辆牌照" autocomplete="off"/>
								</div>
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="vehiclecolor" id="vehiclecolor" placeholder="车辆颜色" autocomplete="off"/>
								</div>
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="transportNo" id="transportNo" placeholder="道路运输编号" autocomplete="off"/>
								</div>
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="engineno" id="engineno" placeholder="发动机号" autocomplete="off"/>
								</div>
								<div class="layui-inline">
									<input type="text" class="layui-input" style="width:187px;" name="identificationCode" id="identificationCode" placeholder="车辆识别代码" autocomplete="off" />
								</div>
							</form>
							<button class="layui-btn" id="searchVehicle" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
							<script type="text/html" id="toolbarVehicle">
								<button type="button" class="layui-btn layui-btn-sm" lay-event="addVehicle"><i class="layui-icon layui-icon-add-1"></i>添加</button>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="updateVehicle"><i class="layui-icon layui-icon-edit"></i>修 改</button>
								<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelVehicle"><i class="layui-icon layui-icon-delete"></i>删 除</button>
							</script>
						</div>
						</blockquote>
						<table class="layui-hide" id="VehicleTable" lay-filter="VehicleTable"></table>
						<script type="text/html" id="Veh">
							<a class="layui-btn layui-btn-xs" lay-event="Vehicleinfo">详情</a>
						</script>
					</div>
				</c:if>
				
				<div class="layui-tab-item">
					<blockquote class="layui-elem-quote news_search">
					<div class="demoTable">
						<form class="layui-form" method="post" style="display:inline;" id="checkform" >
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="checkdate" id="checkdate" placeholder="核查日期" autocomplete="off"/>
							</div>
						</form>
						<button class="layui-btn" id="searchCheck" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
						<script type="text/html" id="toolbarCheck">
							<button type="button" class="layui-btn layui-btn-sm" lay-event="addCheck"><i class="layui-icon layui-icon-add-1"></i>添加</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="updateCheck"><i class="layui-icon layui-icon-edit"></i>修 改</button>
							<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelCheck"><i class="layui-icon layui-icon-delete"></i>删 除</button>
						</script>
					</div>
					</blockquote>
					<table class="layui-hide" id="CheckTable" lay-filter="CheckTable"></table>
					<script type="text/html" id="CHECK">
						<a class="layui-btn layui-btn-xs" lay-event="Checkinfo">详情</a>
					</script>
				</div>
				
			</div>
		</div>
	</div>

		
<script type="text/javascript">

var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
});

var managetype = '${company.managetype }'.split(',');
managetype = turnNums(managetype);

var tempid = "${menuid }";
tempid = tempid.substring(tempid.indexOf("=")+1);

//字符串转int
function turnNums(nums){
	for(let i=0;i<nums.length;i++){
		nums[i] = parseInt(nums[i]);
	}
	return nums;
}

var VehicleStr = '';

var new_pic = 0;
//设置清空图片按钮点击事件
function repic(){
	$(".demo-delete").click();
	new_pic = 0;
	var recordingFileid = "";
	$("#codephoto").val(recordingFileid);
	$("#remainStateid").val(recordingFileid);
}

function cancelImg(id,obj){
	var tempstr = $("#delidstr").val()+id+",";
	$("#delidstr").val(tempstr);
	var re = $("#remainStateid").val().split(",");
	var newre = "";
	for(var i=0;i<re.length;i++){
		if(re[i]!=id){
			newre += re[i]+",";
		}
	}
	$("#remainStateid").val(newre.substring(0,newre.length-1));
	var dom = obj.parentNode;
	dom.remove();
}

//获取民族数据字典
function getNation(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+15,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			$("select[name^=nation]").html(options);
			options = '<option value="">---请选择---</option>'+options;
			$("select[name^=Mnation]").html('<option value="">民族</option>'+options);
		}
	});
}
//获取政治面貌数据字典
function getPoliticalPosition(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+17,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="">---请选择---</option>'+options;
			$("select[name^=politicalposition]").html(options);
		}
	});
}
//获取文化程度数据字典
function getEducation(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+19,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="">文化程度</option>'+options;
			$("select[name^=education]").html(options);
			$("select[name^=Meducation]").html(options);
		}
	});
}
//获取单位类型
function getAffectType(){
	var affecttype = "${company.affecttype}";//单位类型
	if(affecttype!=""){
		var at = affecttype.split(",");
		$('input:checkbox[name=affecttype]').each(function (i){
			for(i=0;i<at.length;i++){
				if(at[i]==$(this).val()){
					$(this).prop('checked','checked');
				}
			}
		});
	}
}
//获取证件类型字典
function getZjlx(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+61,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="身份证">身份证</option>'+options;
			$("select[name^=zjlx]").html(options);
		}
	});
}

$(document).ready(function(){
	getNation();
	getPoliticalPosition();
	getEducation();
	getAffectType();
	getZjlx();
	$("#nation").val("${company.nation}");
	$("#politicalposition").val("${company.politicalposition}");
	$("#education").val("${company.education}");
	$("#zjlx").val("${company.zjlx}");
	var t = "${company.codephoto}";
	$("#remainStateid").val(t);
	
	var viewer = new Viewer(document.getElementById("showlist"),{
		url:	'data-original',
		navbar:	false
	});
	
});

function xkz(){
	layui.use(['form','table','laydate','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var laydate = layui.laydate;
		var element = layui.element;
		
		laydate.render({
			elem:	'#licenceallowdate',
			trigger:'click'
		});
		
		laydate.render({
			elem:	'#licencevalidityend',
			trigger:'click'
		});
		
		table.render({
			elem:'#XKZTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchLicence.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarLicence',
			cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'id',type:'radio',fixed:'left'},
		        {field:'basicName',title:'证件类型',width:200,align:"center"},
		        {field:'licenceno',title:'证书编号',width:200,align:"center",
		        	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoXKZ("+item.id+");'><font color='blue'>"+item.licenceno+"</font></span>";}},
		        {field:'chargeperson',title:'负责人',width:120,align:"center"},
		        {field:'allowrange',title:'许可范围',align:"center"},
		        {field:'validitystart',title:'有效期开始',width:130,align:"center"},
		        {field:'validityend',title:'有效期结束',width:130,align:"center"},
		        {field:'allowunit',title:'发证机关',width:130,align:"center"},
		        {field:'addoperator',title:'添加人',width:130,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//		        ,{field:'right',title:'操作',toolbar:'#XKZ',width:80,align:"center"}
		      ]],
		      page:true,
		      limit:10
		});
		
		table.on('toolbar(XKZTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
			
			switch(obj.event){
				case 'addLicence':
					var index = layui.layer.open({
						title:	"添加许可证信息",
						type:	2,
						content:locat+"/jsp/company/licence_add.jsp?affecttype=${company.affecttype }&companyname=${company.companyname}&companyid=${id }&xkpz=${company.managetype}&xkpzMsg=${company.sjpzMsg}&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
					
				case 'updateLicence':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);//深拷贝
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改许可证信息",
							type:	2,
							content:locat+"/getLicenceById.do?id="+id+"&page=update&affecttype=${company.affecttype }&menuid="+tempid,
							area:	['800', '650px'],
							maxmin:	true,
							success:function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelLicence':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelLicence.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('XKZTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
					
			};
		});
		
		/*table.on('tool(XKZTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'XKZinfo'){
				var index = layui.layer.open({
					title:	'详情信息',
					type:	2,
					content:locat+'/getLicenceById.do?id='+id+"&page=showinfo&affecttype=${company.affecttype }&menuid="+tempid,
					area:	['800','650px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		$("#searchlicence").click(function (){
			table.reload('XKZTable',{
				where:{
					allowdate: $("#licenceallowdate").val(),
					validityend: $("#licencevalidityend").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

function hxp(){
	layui.use(['form','table','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#ChemicalTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchChemical.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarChemical',
			cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'id',type:'radio',fixed:'left'},
		        {field:'realName',title:'化学品名称',width:250,align:"center",
		        	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoChemical("+item.id+");'><font color='blue'>"+item.realName+"</font></span>";}},
		        {field:'purpose',title:'用途',width:200,align:"center"},
		        {field:'belongtypemsg',title:'所属种类',width:200,align:"center"},
		        {field:'chemicaltype',title:'化学品类别',width:220,align:"center"},
		        {field:'packingtype',title:'包装',width:250,align:"center"},
		        {field:'addoperator',title:'添加人',width:180,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//		        ,{field:'right',title:'操作',toolbar:'#CHEMIC',width:150,align:"center"}
		      ]],
		      page:true,
		      limit:10
		});
		
		table.on('toolbar(ChemicalTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
			
			switch(obj.event){
				case 'addChemical':
					var index = layui.layer.open({
						title:	"添加化学品种类信息",
						type:	2,
						content:locat+"/jsp/company/chemical_add.jsp?companyid=${id }&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
					
				case 'updateChemical':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);//深拷贝
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改化学品种类信息",
							type:	2,
							content:locat+"/getChemicalById.do?id="+id+"&page=update&menuid="+tempid,
							area:	['800', '650px'],
							maxmin:	true,
							success:function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelChemical':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelChemical.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('ChemicalTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
					
			};
		});
		
		/*table.on('tool(ChemicalTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Chemicalinfo'){
				var index = layui.layer.open({
					title:	'详情信息',
					type:	2,
					content:locat+'/getChemicalById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:	['800','650px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		$("#searchChemical").click(function (){
			table.reload('ChemicalTable',{
				where:{
					belongtype: $("#chemicalbelongtype option:selected").val(),
					chemicalname: $("#chemicalname").val(),
					purpose: $("#chemicalpurpose option:selected").val(),
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

function bzry(){
	layui.use(['form','table','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#MessengerTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchMessenger.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarMessenger',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'personname',title:'姓名',width:100,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoMessenger("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";}},
			    {field:'cardnumber',title:'身份证号码',width:200,align:"center",
				    templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoMessenger("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";}},
			    {field:'sexes',title:'性别',width:65,align:"center"},
			    {field:'telephone',title:'联系电话',width:200,align:"center"},
			    {field:'nation',title:'民族',width:120,align:"center"},
			    {field:'education',title:'文化程度',width:120,align:"center"},
			    {field:'lifeplace',title:'现居住地',align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    {field:'right',title:'操作',toolbar:'#MES',width:80,align:"center"}
			]],
			page:true,
			limit:10
		});
		
		table.on('toolbar(MessengerTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
			
			switch(obj.event){
				case 'addMessenger':
					var index = layui.layer.open({
						title:	"添加办证人员信息",
						type:	2,
						content:locat+"/jsp/company/messenger_add.jsp?companyid=${id}&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
				
				case 'updateMessenger':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改办证人员信息",
							type:	2,
							content:locat+"/getMessengerById.do?id="+id+"&page=update&menuid="+tempid,
							area:	['800','650px'],
							maxmin:	true,
							success:function(layero,index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelMessenger':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelMessenger.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('MessengerTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
			}
			
		});
		
		/*table.on('tool(MessengerTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Messengerinfo'){
				var index = layui.layer.open({
					title:	'详情信息',
					type:	2,
					content:locat+'/getMessengerById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:	['800','650px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
								tips: 3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		$("#searchMessenger").click(function (){
			table.reload('MessengerTable',{
				where:{
					personname: $("#Mepersonname").val(),
					sexes: $("#Mesexes option:selected").val(),
					cardnumber: $("#Mecardnumber").val(),
					telephone: $("#Metelephone").val(),
					education: $("#Meducation option:selected").val(),
					nation: $("#Mnation option:selected").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

function cyry(){
	layui.use(['form','table','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#ChemistryTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchChemistry.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarChemistry',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'personname',title:'姓名',width:100,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoChemistry("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";}},
			    {field:'cardnumber',title:'身份证号码',width:200,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoChemistry("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";}},
			    {field:'sexes',title:'性别',width:65,align:"center"},
			    {field:'telephone',title:'联系电话',width:160,align:"center"},
			    {field:'nation',title:'民族',width:120,align:"center"},
			    {field:'education',title:'文化程度',width:120,align:"center"},
			    {field:'politicalposition',title:'政治面貌',width:120,align:"center"},
			    {field:'station',title:'岗位',width:100,align:"center"},
			    {field:'lifeplace',title:'现住地详址',align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:"#CHEMIS",width:80,align:"center"}
			]],
			page:true,
			limit:10
		});
		
		table.on('toolbar(ChemistryTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
			
			switch(obj.event){
				case 'addChemistry':
					var index = layui.layer.open({
						title:	"添加从业人员信息",
						type:	2,
						content:locat+"/jsp/company/chemistry_add.jsp?companyid=${id}&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
				
				case 'updateChemistry':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改从业人员信息",
							type:	2,
							content:locat+"/getChemistryById.do?id="+id+"&page=update&menuid="+tempid,
							area:	['800','650px'],
							maxmin:	true,
							success:function(layero,index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelChemistry':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelChemistry.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('ChemistryTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
			}
		});
		
		/*table.on('tool(ChemistryTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Chemistryinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getChemistryById.do?id='+id+"&page=showinfo&menuid="+tempid,
					area:		['800','650px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		$("#searchChemistry").click(function (){
			table.reload('ChemistryTable',{
				where:{
					personname: $("#Chpersonname").val(),
					sexes: $("#Chsexes option:selected").val(),
					cardnumber: $("#Chcardnumber").val(),
					telephone: $("#Chtelephone").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

function sb(){
	layui.use(['form','table','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#EquipmentTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchEquipment.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarEquipment',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'emsg',title:'设备名称',width:200,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoEquipment("+item.id+");'><font color='blue'>"+item.emsg+"</font></span>";}},
			    {field:'equipmentbrand',title:'品牌',width:150,align:"center"},
			    {field:'equipmenttype',title:'型号',width:120,align:"center"},
			    {field:'equipmentpower',title:'功率',width:120,align:"center"},
			    {field:'buydate',title:'购买日期',width:130,align:"center"},
			    {field:'useyear',title:'使用年限',width:120,align:"center"},
			    {field:'usestatus',title:'使用情况',align:"center"},
			    {field:'usestate',title:'使用状态',width:120,align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    ,{field:'right',title:'操作',toolbar:"#EQUIP",width:70,align:"center"}
			]],
			page:true,
			limit:10
		});
		
		table.on('toolbar(EquipmentTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
				
			switch(obj.event){
				case 'addEquipment':
					var index = layui.layer.open({
						title:	"添加设备信息",
						type:	2,
						content:locat+"/jsp/company/equipment_add.jsp?companyid=${id}&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
				
				case 'updateEquipment':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改设备信息",
							type:	2,
							content:locat+"/getEquipmentById.do?id="+id+"&page=update&menuid="+tempid,
							area:	['800','650px'],
							maxmin:	true,
							success:function(layero,index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelEquipment':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelEquipment.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('EquipmentTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
			}
		});
		
		/*table.on('tool(EquipmentTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Equipmentinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getEquipmentById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:		['800','650px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		$("#searchEquipment").click(function (){
			table.reload('EquipmentTable',{
				where:{
					usestatus: $("#usestatus option:selected").val(),
					usestate: $("#usestate option:selected").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

function cl(){
	layui.use(['form','table','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var element = layui.element;
	
		table.render({
			elem:'#VehicleTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchVehicle.do"/>?companyid=${id}',
			method:'post',
			toolbar: '#toolbarVehicle',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'vehiclecategoryMsg',title:'车辆大类',width:120,align:"center"},
			    {field:'vehicleno',title:'车辆牌照',width:180,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoVehicle("+item.id+");'><font color='blue'>"+item.vehicleno+"</font></span>";}},
			    {field:'vehiclebrand',title:'品牌型号',width:180,align:"center"},
			    {field:'vehiclecolor',title:'车辆颜色',width:180,align:"center"},
			    {field:'vehicletype',title:'车辆类型',width:180,align:"center"},
			    {field:'transportNo',title:'道路运输编号',width:150,align:"center"},
			    {field:'engineno',title:'发动机号',width:180,align:"center"},
		        {field:'identificationCode',title:'车辆识别代码',width:180,align:"center"},
			    {field:'relatedtypeMsg',title:'涉及品种',width:220,align:"center"},
			    {field:'addoperator',title:'添加人',width:120,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    {field:'right',title:'操作',toolbar:"#Veh",width:80,align:"center"}
			]],
			page:true,
			limit:10
		});
		
		table.on('toolbar(VehicleTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
			
			switch(obj.event){
				case 'addVehicle':
					var index = layui.layer.open({
						title:	"添加车辆信息",
						type:	2,
						content:locat+"/jsp/company/vehicle_add.jsp?companyid=${id}&companyname=${company.companyname }&xkpz=${company.managetype}&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
				
				case 'updateVehicle':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改车辆信息",
							type:	2,
							content:locat+"/getVehicleById.do?id="+id+"&page=update&menuid="+tempid,
							area:	['800','650px'],
							maxmin:	true,
							success:function(layero,index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelVehicle':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelVehicle.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('VehicleTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
			}
		});
		
		/*table.on('tool(VehicleTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Vehicleinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getVehicleById.do?id='+id+"&page=showinfo&menuid="+tempid,
					area:		['800','650px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		$("#searchVehicle").click(function (){
			table.reload('VehicleTable',{
				where:{
					vehicleno: $("#vehicleno").val(),
					vehiclecolor: $("#vehiclecolor").val(),
					transportNo: $("#transportNo").val(),
					engineno: $("#engineno").val(),
					identificationCode:$("#identificationCode").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

function dwhc(){
	layui.use(['form','table','laydate','element'],function(){
		var form = layui.form;
		var layer = layui.layer;
		var table = layui.table;
		var laydate = layui.laydate;
		var element = layui.element;
	
		table.render({
			elem:'#CheckTable',
			toolbar:true,
			defaultToolbar:['filter','exports','print'],
			url:'<c:url value="searchCheck.do"/>?companyid=${id}',
			method:'post',
			toolbar:'#toolbarCheck',
			cols:	[[
			    {field:'id',hide:true,title:'id'},
			    {field:'id',type:'radio',fixed:'left'},
			    {field:'checkdate',title:'核查日期',width:200,align:"center",
			    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoCheck("+item.id+");'><font color='blue'>"+item.checkdate+"</font></span>";}},
			    {field:'filenames',title:'附件',width:800,align:"center",
			    	templet: function(d){
			    		var content="";
			    		if(d.filenames!=null){
			    			var filenames = d.filenames.split(",");
				    		var fileids = d.fileids.split(",");
				    		if(filenames.length>0){
				    			content+='<div class="layui-input-inline"><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>&nbsp;&nbsp;&nbsp;';
				    		}
				    		for(var i=1;i<filenames.length;i++){
				    			content+='<div class="layui-input-inline"><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>&nbsp;&nbsp;&nbsp;'
				    		}
			    		}
			    		return content;
			    	}
			    },
			    {field:'addoperator',title:'添加人',width:180,align:"center"},
		        {field:'addtime',title:'添加时间',width:180,align:"center"}
//			    {field:'right',title:'操作',toolbar:"#CHECK",width:150,align:"center"}
			]],
			page:true,
			limit:10
		});
			
		table.on('toolbar(CheckTable)',function(obj){
			var checkStatus = table.checkStatus(obj.config.id);
				
			switch(obj.event){
				case 'addCheck':
					var index = layui.layer.open({
						title:	"添加单位核查信息",
						type:	2,
						content:locat+"/jsp/company/check_add.jsp?companyid=${id}&companyname=${company.companyname }&menuid="+tempid,
						area:	['800','650px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				break;
				
				case 'updateCheck':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						var index = layui.layer.open({
							title:	"修改单位核查信息",
							type:	2,
							content:locat+"/getCheckById.do?id="+id+"&page=update&companyname=${company.companyname }&menuid="+tempid,
							area:	['800','650px'],
							maxmin:	true,
							success:function(layero,index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
										tips: 3
									});
								},500);
							}
						});
						layui.layer.full(index);
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
				
				case 'cancelCheck':
					var data = JSON.stringify(checkStatus.data);
					var datas = JSON.parse(data);
					if(datas!=""){
						var id = datas[0].id;
						layer.confirm("确定删除此信息吗?",function(index){
							layer.close(index);
							$.getJSON(locat+"/cancelCheck.do?id="+id+'&menuid='+tempid,{},function(data){
								var str = eval('('+data+')');
								if(str.flag ==1){
									top.layer.msg("数据删除成功");
									table.reload('CheckTable',{});
								}else{
									top.layer.msg("数据删除失败");
								}
							});
						});
					}else{
						top.layer.alert("请先选择数据");
					}
				break;
			}
		});
		
		/*table.on('tool(CheckTable)',function(obj){
			var id = obj.data.id;
			if(obj.event == 'Checkinfo'){
				var index = layui.layer.open({
					title:		'详情信息',
					type:		2,
					content:locat+'/getCheckById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+tempid,
					area:		['800','650px'],
					maxmin:		true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
								tips:	3
							});
						},500);
					}
				});
				layui.layer.full(index);
			}
		});*/
		
		laydate.render({
			elem:	'#checkdate',
			trigger:'click'
		});
		
		$("#searchCheck").click(function (){
			table.reload('CheckTable',{
				where:{
					checkdate: $("#checkdate").val()
				},
				page:{
					//重新从第一页开始
					curr:1
				}
			});
		});
		
		form.render();
		
	});
}

layui.use(['form','table','upload','treeSelect','zTreeSelectM','element'], function(){
	var form = layui.form;
	var upload = layui.upload;
	var layer = layui.layer;
	var zTreeSelectM = layui.zTreeSelectM;
	var treeSelect = layui.treeSelect;
	var table = layui.table;
	var element = layui.element;
	var tempid = "${menuid }";
	tempid = tempid.substring(tempid.indexOf("=")+1);
	
	var _zTreeSelectM = zTreeSelectM({
	    elem: '#managetype',//元素容器【必填】          
	    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType='+50,
	    type: 'get',   
	    selected: managetype,//默认值            
	    max: 20,//最多选中个数，默认5            
	    name: 'managetype',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符           
	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
	    tips: '涉及品种：',
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
	        }
	    }
	});

	treeSelect.render({
		elem:	'#registerowner',	//选择器
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',	
		placeholder:	'所属辖区',
		search:	true,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
		},
		success: function(d){
			treeSelect.checkNode('registerowner', ${company.registerowner});
			var treeObj = treeSelect.zTree('registerowner');
			treeSelect.refresh('registerowner');
		}
	});
	
	treeSelect.render({
		elem:	'#realworkowner',
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',
		placeholder:	'所属辖区',
		search:	true,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
		},
		success: function(d){
			treeSelect.checkNode('realworkowner',${company.realworkowner});
			var treeObj = treeSelect.zTree('realworkowner');
			treeSelect.refresh('realworkowner');
		}
	});

	//监听提交 创建一个上传组件
	var listview = $("#showlist");
	var fileidstr = "";
	var uploadInst = upload.render({
		elem:		'#picture', //绑定元素(按钮)
		url:		'<c:url value="/newuploadfile.do"/>', //上传接口
		accept:		'images', //file video audio images 允许的文件类型
		acceptMine:	'image/*',//规定打开文件选择框时，筛选出的文件类型 acceptMime:'image/*'（只显示图片文件）
		multiple:	true,	//多文件上传
		auto:		false,	//自动上传,默认是打开的
		bindAction:	'#upload_pic',	//auto为false时，点击触发上传
		choose:	function(obj){
			new_pic++;
			//选择文件后的回调函数,返回一个object参数
			//预读本地文件，如果是多文件，则会遍历 index文件索引 file文件对象 result文件编码
			obj.preview(function(index,file,result){
				var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
				var tr = $(['<button class="layui-anim layui-anim-scale">'
				            ,'<image class="layui-upload-img" style="height:100px;width:100px;" src="'+result+'" />'
				            ,'<div class="my-tag-close demo-delete">'
				            ,'</div>'
				            ,'</button>'].join(''));
		
				tr.find('.demo-delete').on('click',function(){
					delete files[index];
					new_pic--;
					tr.remove();
					uploadInst.config.elem.next()[0].value = '';//清空input file值，以免后序同名文件不可选
				});
				listview.append(tr);
				listview.append("&nbsp;&nbsp;");
			});
		}
		,done: function(res){
			var recordingFileid = res.success.toString();
			fileidstr += recordingFileid + ",";
		}
		,allDone: function(obj){
			var remainStateidstr = $("#remainStateid").val();
			if(remainStateidstr != ""){
				$("#codephoto").val(remainStateidstr+","+fileidstr.substring(0,fileidstr.length-1));
			}else{
				$("#codephoto").val(fileidstr.substring(0,fileidstr.length-1));
			}
			updateCompany();
		}
		,error: function(){
			//执行上传请求出现异常的回调
			console.log("图片上传失败");
		}
	});
	
	form.render();

	form.on('submit(companySub)',function(data){
		var remainStateidstr = $("#remainStateid").val();
		if(new_pic > 0){
			$("#upload_pic").click();
		}else{
			$("#codephoto").val(remainStateidstr);
			updateCompany();
		}
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
	form.on('submit(companyFRSub)',function(data){
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
			$("#form2").ajaxSubmit({
				url:		'<c:url value="/updateCompanyFR.do"/>',
				dataType:	'json',
				async:		false,
				success:	function(data) {
					var obj = eval('(' + data + ')');
	              	if(obj.flag>0){
	              	   //弹出loading
			            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                setTimeout(function(){         
			                top.layer.msg(obj.msg);
			                top.layer.close(index);
					        layer.closeAll("iframe");
			                //刷新父页面 parent.location.reload();
//					        window.location.reload();
		               },500);
	              	}else{
	              		top.layer.msg(obj.msg);
	              	}
				},error:function(){
					top.layer.alert("请求失败");
				}
			});
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
	function updateCompany(){
		var temp = $("#delidstr").val();
		if($("#delidstr").val()!=""){
			$.ajax({
				type: 'POST',
				url: '<c:url value="/deletefilesbyidstr.do" />',
				data: { deleteidstr: temp ,type: 'files'},
				dataType: 'json',
				async:  false,
				success: function(data){
				}
			});
		}
		
		$("#form1").ajaxSubmit({
			url:		'<c:url value="/updateCompany.do"/>?oldName=${company.companyname }',
			dataType:	'json',
			async:		false,
			success:	function(data) {
				var obj = eval('(' + data + ')');
              	if(obj.flag>0){
              	   //弹出loading
		            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                setTimeout(function(){         
		                top.layer.msg(obj.msg);
		                top.layer.close(index);
				        layer.closeAll("iframe");
		 		        //刷新父页面 parent.location.reload();
		 		       	window.location.reload();
	               },500);
              	}else{
              		top.layer.msg(obj.msg);
              	}
			},error:function(){
				top.layer.alert("请求失败");
			}
		});
	}
	
	form.verify({
		codecheck:function(value,item){
			var msg;
			$.ajax({
				type:	'post',
				url:	'<c:url value="/checkComCode.do"/>',
				data:	{companycode :  $("#companycode").val()},
				dataType:	'json',
				async:		false,
				success:	function(data){
					if(data.flag){
						msg = "代码重复";
					}
				}
			});
			return msg;
		}
	});
	
});

function showInfoXKZ(id){
	var index = layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getLicenceById.do?id='+id+"&page=showinfo&affecttype=${company.affecttype }&menuid="+${menuid},
		area	:['800', '650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoChemical(id){
	var index =layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getChemicalById.do?id='+id+"&page=showinfo&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoMessenger(id){
	var index =layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getMessengerById.do?id='+id+"&page=showinfo&companyname=${company.companyname }&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoChemistry(id){
	var index =layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getChemistryById.do?id='+id+"&page=showinfo&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoEquipment(id){
	var index = layui.layer.open({
		title	:"详情信息",
		type	:2,
		content	:locat+'/getEquipmentById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(layero,index){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function showInfoVehicle(id){
	var index = layui.layer.open({
		title	:'详情信息',
		type	:2,
		content	:locat+'/getVehicleById.do?id='+id+"&page=showinfo&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:	3
				});
			},500);
		}
	});
	layui.layer.full(index);
}

function showInfoCheck(id){
	var index = layui.layer.open({
		title	:'详情信息',
		type	:2,
		content	:locat+'/getCheckById.do?id='+id+"&page=showinfo&companyname=${company.companyname}&menuid="+${menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:	3
				});
			},500);
		}
	});
	layui.layer.full(index);
}

</script>		
<script type="text/javascript">
	function openPGis(){
		var place=$("#realworkplace").val().trim();
		var x=$("#longitude").val().trim();
		var y=$("#latitude").val().trim();
		var f1=function(event){
			place=event.data.mc;
			x=event.data.lx;
			y=event.data.ly;
			$("#realworkplace").val(place);
			$("#longitude").val(x);
			$("#latitude").val(y);
			layer.close(index);
			window.removeEventListener('message',f1,false);
		};
		var index = layui.layer.open({
			title : "标准地址",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc='+place+'&lx='+x+'&ly='+y,
		    area: ['800', '600px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			},
			cancel:function(){
				window.removeEventListener('message',f1,false);
			}
		})
		layui.layer.full(index);
		window.addEventListener('message',f1);
	}
</script>	
</body>
</html>
