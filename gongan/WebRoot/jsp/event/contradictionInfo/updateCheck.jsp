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
    
    <title>修改页面</title>
    
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	<link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
  </head>
  <style>
     /*layui-table 表格内容允许换行*/
     .layui-table-main .layui-table td[data-field="filenames"] div:not(.laytable-cell-radio){
         height: auto;
         overflow:visible;
         text-overflow:inherit;
         white-space:normal;
     }
     .layui-table-fixed .layui-table-body{
      display:none;
     }
     .btn-list .btn {
	    margin: 0 3px;
	    box-sizing: border-box;
	    width: 155px;
	    height: 80px;
	    border-radius: 5px;
	    background-size: 100% 100%;
	    background-repeat: no-repeat;
	    background-position: center center;
	    padding: 0px 5px;
	    display: flex;
	    justify-content: center;
	    align-items: flex-end;
	    font-size: 13px;
	    white-space: nowrap;
	    transition: all ease .3s;
	}
   </style>
  
   <body class="childrenBody layui-fluid">
	
		<div class="layui-form layui-row" style="border-bottom: 1px solid #eee;">
			<div class="layui-col-md6" style="border-right: 1px solid #eee;padding-right: 15px;padding-bottom: 15px;">
				<form method="post" id="form1">
					<input type="hidden"  name="menuid" value="${menuid}">
					<input type="hidden"  name="id" value="${contradictionInfo.id}" />
					<input type="hidden"  name="nowstate" value="${contradictionInfo.nowstate}" />
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue">基本信息：</label>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>风险名称</label>
							<div class="layui-input-block" lay-verify="cdtnameverify">
								<div id="cdtname"></div>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>风险等级</label>
							<div class="layui-input-block">
								<select id="cdtlevel"  name="cdtlevel" style="width:170px;" lay-verify="required" lay-verType="tips">
							 		<option value="">--请选择风险等级--</option>
							 	</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">风险类别</label>
							<div class="layui-input-block">
								<div id="cdttype"></div>
							</div>
						</div>
					</div>
					
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>事发地址</label>
							<div class="layui-input-block">
								<input type="text" id="sfdzplace" name="sfdz" value='${contradictionInfo.sfdz }' onclick="openPGis('sfdz','事发地址');"  autocomplete="off" class="layui-input" lay-verify="required" lay-verType="tips" readonly style="background:#efefef;cursor:pointer;"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">事发地址经度：</label>
							<div class="layui-input-block">
								<input type="text" name="sfdzx" lay-verify="" autocomplete="off"
								value="${contradictionInfo.sfdzx}" class="layui-input" id="sfdzx" onclick="openPGis('sfdz','事发地址');" readonly style="background:#efefef;cursor:pointer;">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label my-text-nowarp">事发地址纬度：</label>
							<div class="layui-input-block">
								<input type="text" name="sfdzy" lay-verify="" autocomplete="off"
								value="${contradictionInfo.sfdzy}" class="layui-input" id="sfdzy" onclick="openPGis('sfdz','事发地址');" readonly style="background:#efefef;cursor:pointer;">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>涉事人数</label>
							<div class="layui-input-block">
								<select id="ssrs"  name="ssrs" lay-verify="required" lay-verType="tips">
							 		<option value="">--请选择涉事人数--</option>
							 	</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉及金额</label>
							<div class="layui-input-block">
								<input type="text" name="sjje" value='${contradictionInfo.sjje }' lay-verify="number" autocomplete="off" class="layui-input" placeholder="请输入涉及金额"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md1">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label" style="text-align:left;">万元</label>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>风险矛盾概况</label>
							<div class="layui-input-block">
								<textarea placeholder="请输入内容" class="layui-textarea" name="cdtcontent" id="cdtcontent" lay-verify="required" lay-verType="tips">${contradictionInfo.cdtcontent }</textarea>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">具体诉求</label>
							<div class="layui-input-block">
								<input type="text" name="jtsq" value='${contradictionInfo.jtsq }'  autocomplete="off" class="layui-input" placeholder="请输入具体诉求"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">处置结果</label>
							<div class="layui-input-block">
								<select id="cdtresult"  name="cdtresult">
							 		<option value="">--请选择处置结果--</option>
							        <option value="已钝化" <c:if test="${contradictionInfo.cdtresult eq '已钝化'}"> selected</c:if>>已钝化</option>
							        <option value="已化解" <c:if test="${contradictionInfo.cdtresult eq '已化解'}"> selected</c:if>>已化解</option>
							        <option value="处置中" <c:if test="${contradictionInfo.cdtresult eq '处置中'}"> selected</c:if>>处置中</option>
							 	</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">主办部门</label>
							<div class="layui-input-block">
								<input type="text" id="sponsor" name="sponsor" lay-filter="sponsor" class="layui-input">
							</div>
						</div>
					</div>
					
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">协办部门</label>
							<div class="layui-input-block">
								<div id="assistdept"></div>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉事单位信息</label>
							<div class="layui-input-block">
								<input type="text" name="ssdwxx" value='${contradictionInfo.ssdwxx }' autocomplete="off" class="layui-input" placeholder="请输入涉事单位名称+单位负责人+联系电话"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">属地派出所领导信息</label>
							<div class="layui-input-block">
								<input type="text" name="sdpcsldxx" value='${contradictionInfo.sdpcsldxx }'  autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入属地派出所分管领导+联系电话"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">属地派出所社区民警信息</label>
							<div class="layui-input-block">
								<input type="text" name="sdpcsmjxx" value='${contradictionInfo.sdpcsmjxx }'  autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入属地派出所民警+联系电话"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">政府牵头处置部门</label>
							<div class="layui-input-block">
								<input type="text" name="zfqtmbxx" value='${contradictionInfo.zfqtmbxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入部门+领导+联系电话"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">会引发的后果</label>
							<div class="layui-input-block">
								<div id="yfhgcheck"></div>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">是否建群</label>
							<div class="layui-input-inline" style="width:25%;">
					      		<select id="isjq"  name="isjq" style="width:170px;" lay-verify="required" lay-verType="tips">
							        <option value="0" <c:if test="${contradictionInfo.isjq eq '0'}"> selected</c:if>>否</option>
							        <option value="1" <c:if test="${contradictionInfo.isjq eq '1'}"> selected</c:if>>是</option>
							 	</select>
					    	</div>
							<div class="layui-input-inline" style="width:55%;">
					    		<input type="text" name="qxx" value='${contradictionInfo.qxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入群信息"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">是否物建信息员</label>
					    	<div class="layui-input-inline" style="width:25%;">
					      		<select id="iswjxxy"  name="iswjxxy" style="width:170px;" lay-verify="required" lay-verType="tips">
							        <option value="0" <c:if test="${contradictionInfo.iswjxxy eq '0'}"> selected</c:if>>否</option>
							        <option value="1" <c:if test="${contradictionInfo.iswjxxy eq '1'}"> selected</c:if>>是</option>
							 	</select>
					    	</div>
					    	<div class="layui-input-inline" style="width:55%;">
					    		<input type="text" name="xxyxx" value='${contradictionInfo.xxyxx }' autocomplete="off" class="layui-input" maxlength="100" placeholder="请输入信息员信息"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">备注信息</label>
							<div class="layui-input-block">
								<textarea placeholder="请输入内容" class="layui-textarea" name="memo">${contradictionInfo.memo }</textarea>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
						    <div class="layui-input-block">
						      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
						      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
						    </div>
					    </div>
				  	</div>
				</form>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6" style="border-left: 1px solid #EEEEEE;">
				<div class="layui-tab"  lay-filter="detailTabs">
					<ul class="layui-tab-title btn-list">
						<li class="btn btn_11 layui-this">引发涉稳事件</li>
						<li class="btn btn_12">情报线索信息</li>
						<li class="btn btn_13">主要组织人员</li>
						<li class="btn btn_14">稳控化解情况</li>
						<li class="btn btn_15" onclick="openTimeaxis('${contradictionInfo.id}');">时间轴</li>
					</ul>
					<div class="layui-tab-content " style="padding: 15px;">
						<div class="right-child-content layui-tab-item layui-show">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <table class="layui-hide" id="swsj" lay-filter="swsj"></table>
								     </div>
								     <div class="layui-tab-item">
								           <table class="layui-hide" id="swsj_zfw" lay-filter="swsj_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <table class="layui-hide" id="qbxs" lay-filter="qbxs"></table>
								     </div>
								     <div class="layui-tab-item">
								           <table class="layui-hide" id="qbxs_zfw" lay-filter="qbxs_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								     	<div class="layui-inline">
											<input type="text" name="cardnumber" id="cardnumber" autocomplete="off" placeholder=" 请输入身份证号：" class="layui-input">
										</div>
										<button class="layui-btn" id="addConnect"><i class="layui-icon">&#xe64c;</i>新增关联</button>
										<button class="layui-btn" id="cancelConnect"><i class="layui-icon">&#xe64d;</i>删除关联</button>
										<button class="layui-btn" id="changeImportance"><i class="layui-icon">&#xe66e;</i>调整重要程度</button>
										<table class="layui-hide" id="zzry" lay-filter="zzry"></table>
								     </div>
								     <div class="layui-tab-item">
								           <table class="layui-hide" id="zzry_zfw" lay-filter="zzry_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
						<div class="right-child-content layui-tab-item">
							<div class="layui-tab my-tab layui-tab-brief">
								<ul class="layui-tab-title my-tab-title">
									<li class="layui-this">公安数据</li>
									<li>政法委数据</li>
								</ul>
								<div class="layui-tab-content" >
								     <div class="layui-tab-item layui-show">
								           <table class="layui-hide" id="wkhj" lay-filter="wkhj"></table>
								     </div>
								     <div class="layui-tab-item">
								           <table class="layui-hide" id="wkhj_zfw" lay-filter="wkhj_zfw"></table>
								     </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-row my-font-blue">
				工作交办管理
			</div>
			<div class="layui-tab my-tab layui-tab-brief" lay-filter="gzjbTab">
				<ul class="layui-tab-title my-tab-title4" id="gzjbTab">
					<li class="layui-this">工作提示单（0）</li>
					<li>工作交办单（0）</li>
					<li>工作督办单（0）</li>
					<li>责任追究建议函（0）</li>
				</ul>
				<div class="layui-tab-content" style="min-height: 100px;">
					<div class="layui-tab-item layui-show">
						<table class="layui-hide" id="tsd" lay-filter="tsd"></table>
					</div>
					<div class="layui-tab-item">
						<table class="layui-hide" id="jbd" lay-filter="jbd"></table>
					</div>
					<div class="layui-tab-item">
						<table class="layui-hide" id="dbd" lay-filter="dbd"></table>
					</div>
					<div class="layui-tab-item">
						<table class="layui-hide" id="jyh" lay-filter="jyh"></table>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-row my-font-blue">
				推动化解处置情况
			</div>
			<div class="layui-tab my-tab layui-tab-brief" lay-filter="tdhjTab">
				<ul class="layui-tab-title my-tab-title" id="tdhjTab">
					<li class="layui-this">领导批示（0）</li>
					<li>涉稳专报（0）</li>
<%--					<li>维稳专报（0）</li>--%>
<%--					<li>涉稳风险交办处置建议（0）</li>--%>
					<li>专题会议纪要（0）</li>
				</ul>
				<div class="layui-tab-content" style="min-height: 100px;">
					<div class="layui-tab-item layui-show">
						<table class="layui-hide" id="ldps" lay-filter="ldps"></table>
					</div>
					<div class="layui-tab-item">
						<table class="layui-hide" id="yqkb" lay-filter="yqkb"></table>
					</div>
<%--					<div class="layui-tab-item">--%>
<%--						<table class="layui-hide" id="wwzb" lay-filter="wwzb"></table>--%>
<%--					</div>--%>
<%--					<div class="layui-tab-item">--%>
<%--						<table class="layui-hide" id="jbcz" lay-filter="jbcz"></table>--%>
<%--					</div>--%>
					<div class="layui-tab-item">
						<table class="layui-hide" id="hyjy" lay-filter="hyjy"></table>
					</div>
				</div>
			</div>
		</div>
		<script type="text/html" id="toolbarDemo">
			<div class="layui-btn-container">
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="add">&#xe624; 新增</button>
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="update">&#xe642;修改</button>
                <c:if test='${fn:contains(buttons,"删除")}'>
				      <button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="canel">&#xe640;删除</button>
                </c:if>
			</div>
		</script>
		<script type="text/html" id="gzjbToolbar">
			<div class="layui-btn-container">
                 <button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="xf">&#xe609; 下发</button>
                 <c:if test='${fn:contains(buttons,"签收")}'>
				        <button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="qs">&#xe705; 签收</button>
                  </c:if>
                  <c:if test='${fn:contains(buttons,"反馈")}'>
				          <button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="fk">&#xe681; 反馈</button>
                  </c:if>
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="dy">&#xe66d; 打印</button>
			</div>
		</script>
		<script type="text/html" id="qbbar">
			<a class="layui-btn layui-btn-xs" lay-event="qbbs">情报上报</a>       
		</script>
		<script type="text/html" id="checkToolbar">
			<c:if test='${fn:contains(param.buttons,"审核")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="check"><i class="layui-icon layui-icon-survey"></i>审核</button>
			</c:if>
   		</script>
		<script>
			//定义表格
			var table;
			
			layui.config({
			    base: "<c:url value="/layui/lay/modules/"/>"
			}).extend({
			    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
			    treeSelect: "treeSelect",
				selectInput:"selectInput/selectInput"
			});
			var cdttype = '${contradictionInfo.cdttype }'.split(',');
			cdttype = turnNums(cdttype);
			layui.use(['table','form','zTreeSelectM','treeSelect','element','selectInput'], function() {
				table = layui.table;
				var form = layui.form,
				layer = layui.layer,
				treeSelect = layui.treeSelect,
				zTreeSelectM = layui.zTreeSelectM,
				element = layui.element,
				selectInput= layui.selectInput;
				
				form.verify({
			    	cdtnameverify: function(value,item){
			    		if(!$('input[name=cdtname]').val()){
			    			$('input[name=cdtname]').focus();
				  			return "请选择风险名称";
			    		}
			    	},
				});
				
				//风险名称
				selectInput.render({
		            // 容器id，必传参数
		            elem: '#cdtname',
		            name: 'cdtname', // 渲染的input的name值
		            initValue:'${contradictionInfo.cdtname}', // 渲染初始化默认值
		            placeholder: '请输入风险名称', // 渲染的inputplaceholder值
		            // 联想select的初始化本地值，数组格式，里面的对象属性必须为value，name，value是实际选中值，name是展示值，两者可以一样
		            data: [
		                <c:forEach items="${cdtnameList}" var="row" varStatus="num">
							{value: "${row}", name: "${row}"},
						</c:forEach>
		            ],
		            remoteSearch: false// 是否启用远程搜索 默认是false，和远程搜索回调保存同步
		        });
		        
		        //初始化风险等级
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=93',
					dataType:	'json',
					success:	function(data){
	           			$.each(data, function(num, item) {
	           				if(item.name=="${contradictionInfo.cdtlevel}"){
								$('#cdtlevel').append('<option value="' + item.name + '" selected>' + item.name + '</option>');
							}else{
								$('#cdtlevel').append('<option value="' + item.name + '">' + item.name + '</option>');
							}
	          			});
	      				form.render("select");
					}
				});
		        
				//初始化涉事人数
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=43',
					dataType:	'json',
					success:	function(data){
	           			$.each(data, function(num, item) {
	           				if(item.name=="${contradictionInfo.ssrs}"){
								$('#ssrs').append('<option value="' + item.name + '" selected>' + item.name + '</option>');
							}else{
								$('#ssrs').append('<option value="' + item.name + '">' + item.name + '</option>');
							}
	          			});
	      				form.render("select");
					}
				});
				
				//初始化会引发的后果
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=94',
					dataType:	'json',
					success:	function(data){
						var yfhg = "${contradictionInfo.yfhg}";
	           			$.each(data, function(num, item) {
	           				if(yfhg.indexOf(item.name)>-1){
           						$('#yfhgcheck').append('<input type="checkbox" name="yfhg" lay-skin="primary" value="'+item.name+'"title="'+item.name+'" checked/>');
	           				}else{
	           					$('#yfhgcheck').append('<input type="checkbox" name="yfhg" lay-skin="primary" value="'+item.name+'" title="'+item.name+'"/>');
	           				}
	          			});
	      				form.render();
					}
				});
				
				var assistdept = '${contradictionInfo.assistdept }'.split(',');
				assistdept = turnNums(assistdept);
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getDepartmentTree.do"/>',
					dataType:	'json',
					success:	function(data){
						//初始化协助部门
						var _zTreeSelectM = zTreeSelectM({
						    elem: '#assistdept',//元素容器【必填】          
						    data: data,
						    type: 'get',  //设置了长度    
						    selected: assistdept,//默认值            
						    max: 5,//最多选中个数，默认5            
						    name: 'assistdept',//input的name 不设置与选择器相同(去#.)
						    delimiter: ',',//值的分隔符           
						    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
						    tips: '请选择协办部门：',
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
					}
				});
				
				treeSelect.render({
			        elem: '#sponsor', // 选择器
			        data: '<c:url value="/getDepartmentTree.do"/>',// 数据
			        type: 'get', // 异步加载方式：get/post，默认get
			        placeholder: '请选择主办部门：', // 占位符
			        search: true, // 是否开启搜索功能：true/false，默认false
			        // 一些可定制的样式
			        style: {
			            folder: { enable: false },
			            line: {  enable: true}
			        },
			        click: function(d){   // 点击回调
			           
			        },
			        // 加载完成后的回调函数
			        success: function (d) {
			        	if(${contradictionInfo.sponsor}>0){
			        		treeSelect.checkNode('sponsor', ${contradictionInfo.sponsor});
							//获取zTree对象，可以调用zTree方法
		               		var treeObj = treeSelect.zTree('sponsor');
							//刷新树结构
		                	treeSelect.refresh('sponsor');
			        	}
			        }
			    });
				
				//初始化风险类别
				var _zTreeSelectM = zTreeSelectM({
				    elem: '#cdttype',//元素容器【必填】          
				    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=39',
				    type: 'get',  //设置了长度    
				    selected: cdttype,//默认值            
				    max: 5,//最多选中个数，默认5            
				    name: 'cdttype',//input的name 不设置与选择器相同(去#.)
				    delimiter: ',',//值的分隔符           
				    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
				    tips: '风险类别：',
				    verify: 'required', 
				    reqtext:"请选择风险类别", 
				    reqdiv:"cdttype",  
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
				
				form.on('submit(msgSub)', function(data){
		         $("#form1").ajaxSubmit({
		              	url:		'<c:url value="/updateContradictionInfo.do"/>',
		              	dataType:	'json',
		              	async:  false,
		              	success:	function(data) {
		                  	var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                  	    //弹出loading
		 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
					        		layer.closeAll("iframe");
			 		        		//刷新父页面
			 		         		parent.location.reload();
		                   		},2000);
		                 	}else{
		                  	 	layer.msg(obj.msg);
		                	}
		             	},
		              	error:function() {
		                  	layer.alert("请求失败！");
		              	}
		          	});
		           	return false;
				 });
				
				//初始化引发涉稳事件
				table.render({
					elem: '#swsj',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchEventsInfo.do"/>',
				    where:{cdtid:${contradictionInfo.id}},
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'fssj', title: '发生时间', width:200,align:"center"},
				    	{field:'etitle', title: '事件标题', width:200,align:"center",templet: function(d){
				    		if(d.etitle==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoEventsInfo.do&quot;,&quot;引发涉稳事件&quot;,"+d.id+");return false;'>-</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoEventsInfo.do&quot;,&quot;引发涉稳事件&quot;,"+d.id+");return false;'>"+d.etitle+"</a>";
				    		}
				    	}},
				    	{field:'sfbwd', title: '事发部位',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化情报线索信息
				table.render({
					elem: '#qbxs',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'ldate', title: '预计发生时间', width:150,align:"center"},
				    	{field:'ltitle', title: '线索标题', width:200,align:"center",templet: function(d){
				    		if(d.ltitle==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoLeadsInfo.do&quot;,&quot;情报线索信息&quot;,"+d.id+");return false;'>-</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoLeadsInfo.do&quot;,&quot;情报线索信息&quot;,"+d.id+");return false;'>"+d.ltitle+"</a>";
				    		}
				    	}},
				    	{field:'lpointto', title: '线索指向', width:200,align:"center"},
				    	{field:'xscz', title: '线索处置',align:"center"},
				    	{field: 'right', title: '操作', toolbar: '#qbbar',width:100,align:"center"} 
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化主要组织人员
				table.render({
					elem: '#zzry',
				    toolbar: false,
				    defaultToolbar: [],
				    method:'post',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
							return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWenGrade("+item.wenid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
						}} ,
				    	{field:'personname', title: '姓名', width:100,align:"center"},
				    	{field:'houseplace', title: '户籍地', width:200,align:"center"},
				    	{field:'homeplace', title: '现住地',align:"center"},
				    	{field:'importance', title: '重要程度', width:100,align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化稳控化解情况
				table.render({
					elem: '#wkhj',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'lsdate', title: '预计落实时间', width:200,align:"center"},
				    	{field:'csgs', title: '措施概述', width:200,align:"center",templet: function(d){
				    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoDefuseInfo.do&quot;,&quot;稳控化解情况&quot;,"+d.id+");return false;'>"+d.csgs+"</a>";
				    	}},
				    	{field:'sflsqk', title: '是否落实情况', width:200,align:"center"},
				    	{field:'lsqkks', title: '落实情况概述',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//政法委初始化
				table.render({
					elem: '#swsj_zfw',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchEventsInfo_zfw.do"/>',
				    where:{cdtid:${contradictionInfo.id}},
				    method:'post',
				    toolbar: '#checkToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'fssj', title: '发生时间', width:200,align:"center"},
				    	{field:'etitle', title: '事件标题', width:200,align:"center",templet: function(d){
				    		if(d.etitle==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoEventsInfo_zfw.do&quot;,&quot;政法委引发涉稳事件&quot;,"+d.id+");return false;'>-</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoEventsInfo_zfw.do&quot;,&quot;政法委引发涉稳事件&quot;,"+d.id+");return false;'>"+d.etitle+"</a>";
				    		}
				    	}},
				    	{field:'sfbwd', title: '事发部位',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				table.render({
					elem: '#qbxs_zfw',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#checkToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'ldate', title: '预计发生时间', width:150,align:"center"},
				    	{field:'ltitle', title: '线索标题', width:200,align:"center",templet: function(d){
				    		if(d.ltitle==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoLeadsInfo_zfw.do&quot;,&quot;情报线索信息&quot;,"+d.id+");return false;'>-</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoLeadsInfo_zfw.do&quot;,&quot;情报线索信息&quot;,"+d.id+");return false;'>"+d.ltitle+"</a>";
				    		}
				    	}},
				    	{field:'lpointto', title: '线索指向', width:200,align:"center"},
				    	{field:'xscz', title: '线索处置',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				table.render({
					elem: '#zzry_zfw',
				    toolbar: false,
				    defaultToolbar: [],
				    method:'post',
				    toolbar: '#checkToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
							return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWenGrade("+item.wenid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
						}} ,
				    	{field:'personname', title: '姓名', width:200,align:"center"},
				    	{field:'houseplace', title: '户籍地', width:200,align:"center"},
				    	{field:'homeplace', title: '现住地',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				table.render({
					elem: '#wkhj_zfw',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#checkToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'lsdate', title: '预计落实时间', width:200,align:"center"},
				    	{field:'csgs', title: '措施概述', width:200,align:"center",templet: function(d){
				    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoDefuseInfo_zfw.do&quot;,&quot;稳控化解情况&quot;,"+d.id+");return false;'>"+d.csgs+"</a>";
				    	}},
				    	{field:'sflsqk', title: '是否落实情况', width:200,align:"center"},
				    	{field:'lsqkks', title: '落实情况概述',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化工作提示单
				table.render({
					elem: '#tsd',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchWorkInfo.do"/>',
				    where:{cdtid:${contradictionInfo.id},wtype:1},
				    method:'post',
				    toolbar: '#gzjbToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+"</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+'-'+d.code+"</a>";
				    		}
				    	}},
				    	{field:'wcontent', title: '内容', width:200,align:"center"},
				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'receivedept', title: '接收单位',align:"center"},
				    	{field:'receivername', title: '接收人',align:"center"},
				    	{field:'xfpername', title: '下发人',align:"center"},
				    	{field:'xfperdep', title: '下发人单位',align:"center",templet: function(d){
				    		return "联动中心";
				    	}},
				    	{field:'xftime', title: '下发时间',align:"center"},
				    	{field:'qspername', title: '签收人',align:"center"},
				    	{field:'qstime', title: '签收时间',align:"center"},
				    	{field:'fkname', title: '反馈人',align:"center"},
				    	{field:'fktime', title: '反馈时间',align:"center"},
				    	{field:'fkcontent', title: '反馈内容',align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	for(var i=0;i<res.workInfoList.length;i++){
					    		if(res.workInfoList[i].wtype==1){
					    			obj[0].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==2){
					    			obj[1].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==3){
					    			obj[2].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==4){
					    			obj[3].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
				//初始化工作交办单
				table.render({
					elem: '#jbd',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#gzjbToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+"</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+'-'+d.code+"</a>";
				    		}
				    	}},
				    	{field:'wcontent', title: '内容', width:200,align:"center"},
				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'receivedept', title: '接收单位',align:"center"},
				    	{field:'receivername', title: '接收人',align:"center"},
				    	{field:'xfpername', title: '下发人',align:"center"},
				    	{field:'xfperdep', title: '下发人单位',align:"center",templet: function(d){
				    		return "联动中心";
				    	}},
				    	{field:'xftime', title: '下发时间',align:"center"},
				    	{field:'qspername', title: '签收人',align:"center"},
				    	{field:'qstime', title: '签收时间',align:"center"},
				    	{field:'fkname', title: '反馈人',align:"center"},
				    	{field:'fktime', title: '反馈时间',align:"center"},
				    	{field:'fkcontent', title: '反馈内容',align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	for(var i=0;i<res.workInfoList.length;i++){
					    		if(res.workInfoList[i].wtype==1){
					    			obj[0].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==2){
					    			obj[1].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==3){
					    			obj[2].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==4){
					    			obj[3].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
				//初始化工作督办单
				table.render({
					elem: '#dbd',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#gzjbToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+"</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+'-'+d.code+"</a>";
				    		}
				    	}},
				    	{field:'wcontent', title: '内容', width:200,align:"center"},
				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'receivedept', title: '接收单位',align:"center"},
				    	{field:'receivername', title: '接收人',align:"center"},
				    	{field:'xfpername', title: '下发人',align:"center"},
				    	{field:'xfperdep', title: '下发人单位',align:"center",templet: function(d){
				    		return "联动中心";
				    	}},
				    	{field:'xftime', title: '下发时间',align:"center"},
				    	{field:'qspername', title: '签收人',align:"center"},
				    	{field:'qstime', title: '签收时间',align:"center"},
				    	{field:'fkname', title: '反馈人',align:"center"},
				    	{field:'fktime', title: '反馈时间',align:"center"},
				    	{field:'fkcontent', title: '反馈内容',align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	for(var i=0;i<res.workInfoList.length;i++){
					    		if(res.workInfoList[i].wtype==1){
					    			obj[0].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==2){
					    			obj[1].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==3){
					    			obj[2].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==4){
					    			obj[3].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
				//初始化责任追究建议函
				table.render({
					elem: '#jyh',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#gzjbToolbar',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+"</a>";
				    		}else{
				    			return "<a href='#' style='text-decoration: underline;' onclick='showWorkInfo(&quot;"+d.id+"&quot;,&quot;"+d.wtypename+"&quot;);return false;'>"+d.wtitle+'-'+d.code+"</a>";
				    		}
				    	}},
				    	{field:'wcontent', title: '内容', width:200,align:"center"},
				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'receivedept', title: '接收单位',align:"center"},
				    	{field:'receivername', title: '接收人',align:"center"},
				    	{field:'xfpername', title: '下发人',align:"center"},
				    	{field:'xfperdep', title: '下发人单位',align:"center",templet: function(d){
				    		return "联动中心";
				    	}},
				    	{field:'xftime', title: '下发时间',align:"center"},
				    	{field:'qspername', title: '签收人',align:"center"},
				    	{field:'qstime', title: '签收时间',align:"center"},
				    	{field:'fkname', title: '反馈人',align:"center"},
				    	{field:'fktime', title: '反馈时间',align:"center"},
				    	{field:'fkcontent', title: '反馈内容',align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	for(var i=0;i<res.workInfoList.length;i++){
					    		if(res.workInfoList[i].wtype==1){
					    			obj[0].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==2){
					    			obj[1].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==3){
					    			obj[2].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}else if(res.workInfoList[i].wtype==4){
					    			obj[3].innerHTML="工作提示单（"+res.workInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
				//领导批示
				table.render({
					elem: '#ldps',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchHandleInfo.do"/>',
				    where:{cdtid:${contradictionInfo.id},htype:1},
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'hdate', title: '录入时间', width:130,align:"center"},
				    	{field:'leaderlevel', title: '领导级别', width:130,align:"center"},
				    	{field:'approveperson', title: '批示人', width:100,align:"center"},
				    	{field:'htitle', title: '标题', width:200,align:"center"},
				    	{field:'hcontent', title: '内容',align:"center"},
				    	{field:'filenames', title: '附件', width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'addoperator', title: '录入人', width:100,align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("tdhjTab").getElementsByTagName("li");
					    	for(var i=0;i<res.handleInfoList.length;i++){
					    		if(res.handleInfoList[i].htype==1){
					    			obj[0].innerHTML="领导批示（"+res.handleInfoList[i].nums+"）";
					    		}
					    		if(res.handleInfoList[i].htype==2){
					    			obj[1].innerHTML="涉稳专报（"+res.handleInfoList[i].nums+"）";
					    		}
		          				if(res.handleInfoList[i].htype==5){
					    			obj[2].innerHTML="专题会议纪要（"+res.handleInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
				//涉稳专报
				table.render({
					elem: '#yqkb',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'hdate', title: '编刊时间', width:130,align:"center"},
				    	{field:'htitle', title: '标题', width:200,align:"center"},
				    	{field:'hcontent', title: '内容',align:"center"},
				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'addoperator', title: '录入人', width:100,align:"center"},
				    	{field:'addtime', title: '录入时间', width:180,align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("tdhjTab").getElementsByTagName("li");
					    	for(var i=0;i<res.handleInfoList.length;i++){
					    		if(res.handleInfoList[i].htype==1){
					    			obj[0].innerHTML="领导批示（"+res.handleInfoList[i].nums+"）";
					    		}
					    		if(res.handleInfoList[i].htype==2){
					    			obj[1].innerHTML="涉稳专报（"+res.handleInfoList[i].nums+"）";
					    		}
		          				if(res.handleInfoList[i].htype==5){
					    			obj[2].innerHTML="专题会议纪要（"+res.handleInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
<%--				//维稳专报--%>
<%--				table.render({--%>
<%--					elem: '#wwzb',--%>
<%--				    toolbar: true,--%>
<%--				    defaultToolbar: ['filter', 'exports', 'print'],--%>
<%--				    method:'post',--%>
<%--				    toolbar: '#toolbarDemo',--%>
<%--				    cols: [[--%>
<%--				    	{field:'id',type:'radio',fixed:'left'},--%>
<%--				    	{field:'hdate', title: '编刊时间', width:130,align:"center"},--%>
<%--				    	{field:'htitle', title: '专报标题', width:200,align:"center"},--%>
<%--				    	{field:'hcontent', title: '专报内容',align:"center"},--%>
<%--				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){--%>
<%--				    		var content="";--%>
<%--				    		if(d.filenames!=null){--%>
<%--				    			var filenames = d.filenames.split(",");--%>
<%--					    		var fileids = d.fileids.split(",");--%>
<%--					    		if(filenames.length>0){--%>
<%--					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';--%>
<%--					    		}--%>
<%--					    		for(var i=1;i<filenames.length;i++){--%>
<%--					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'--%>
<%--					    		}--%>
<%--				    		}--%>
<%--				    		return content;--%>
<%--				    	}},--%>
<%--				    	{field:'addoperator', title: '录入人', width:100,align:"center"},--%>
<%--				    	{field:'addtime', title: '录入时间', width:180,align:"center"}--%>
<%--				    ]],--%>
<%--				    page: true,--%>
<%--				    limit: 10,--%>
<%--				    done: function(res, curr, count){--%>
<%--					    if(res.code==0){--%>
<%--					    	var obj = document.getElementById("tdhjTab").getElementsByTagName("li");--%>
<%--					    	for(var i=0;i<res.handleInfoList.length;i++){--%>
<%--					    		if(i==0){--%>
<%--					    			obj[0].innerHTML="领导批示（"+res.handleInfoList[0].nums+"）";--%>
<%--					    		}--%>
<%--					    		if(i==1){--%>
<%--					    			obj[1].innerHTML="涉稳专报（"+res.handleInfoList[1].nums+"）";--%>
<%--					    		}--%>
<%--		          				if(i==2){--%>
<%--					    			obj[2].innerHTML="维稳专报（"+res.handleInfoList[2].nums+"）";--%>
<%--					    		}--%>
<%--		          				if(i==3){--%>
<%--					    			obj[3].innerHTML="涉稳风险交办处置建议（"+res.handleInfoList[3].nums+"）";--%>
<%--					    		}--%>
<%--		          				if(i==4){--%>
<%--					    			obj[4].innerHTML="专题会议纪要（"+res.handleInfoList[4].nums+"）";--%>
<%--					    		}--%>
<%--					    	}--%>
<%--					    }--%>
<%--					}--%>
<%--				});--%>
				
<%--				//涉稳风险交办处置建议--%>
<%--				table.render({--%>
<%--					elem: '#jbcz',--%>
<%--				    toolbar: true,--%>
<%--				    defaultToolbar: ['filter', 'exports', 'print'],--%>
<%--				    method:'post',--%>
<%--				    toolbar: '#toolbarDemo',--%>
<%--				    cols: [[--%>
<%--				    	{field:'id',type:'radio',fixed:'left'},--%>
<%--				    	{field:'hdate', title: '提交时间', width:130,align:"center"},--%>
<%--				    	{field:'htitle', title: '建议标题', width:200,align:"center"},--%>
<%--				    	{field:'hcontent', title: '建议内容',align:"center"},--%>
<%--				    	{field:'receiver', title: '接收人', width:100,align:"center"},--%>
<%--				    	{field:'hsituation', title: '办理情况', width:200,align:"center"},--%>
<%--				    	{field:'hresult', title: '处置结果', width:200,align:"center"},--%>
<%--				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){--%>
<%--				    		var content="";--%>
<%--				    		if(d.filenames!=null){--%>
<%--				    			var filenames = d.filenames.split(",");--%>
<%--					    		var fileids = d.fileids.split(",");--%>
<%--					    		if(filenames.length>0){--%>
<%--					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';--%>
<%--					    		}--%>
<%--					    		for(var i=1;i<filenames.length;i++){--%>
<%--					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'--%>
<%--					    		}--%>
<%--				    		}--%>
<%--				    		return content;--%>
<%--				    	}},--%>
<%--				    	{field:'addoperator', title: '录入人', width:100,align:"center"}--%>
<%--				    ]],--%>
<%--				    page: true,--%>
<%--				    limit: 10,--%>
<%--				    done: function(res, curr, count){--%>
<%--					    if(res.code==0){--%>
<%--					    	var obj = document.getElementById("tdhjTab").getElementsByTagName("li");--%>
<%--					    	for(var i=0;i<res.handleInfoList.length;i++){--%>
<%--					    		if(i==0){--%>
<%--					    			obj[0].innerHTML="领导批示（"+res.handleInfoList[0].nums+"）";--%>
<%--					    		}--%>
<%--					    		if(i==1){--%>
<%--					    			obj[1].innerHTML="涉稳专报（"+res.handleInfoList[1].nums+"）";--%>
<%--					    		}--%>
<%--		          				if(i==2){--%>
<%--					    			obj[2].innerHTML="维稳专报（"+res.handleInfoList[2].nums+"）";--%>
<%--					    		}--%>
<%--		          				if(i==3){--%>
<%--					    			obj[3].innerHTML="涉稳风险交办处置建议（"+res.handleInfoList[3].nums+"）";--%>
<%--					    		}--%>
<%--		          				if(i==4){--%>
<%--					    			obj[4].innerHTML="专题会议纪要（"+res.handleInfoList[4].nums+"）";--%>
<%--					    		}--%>
<%--					    	}--%>
<%--					    }--%>
<%--					}--%>
<%--				});--%>
				
				//专题会议纪要
				table.render({
					elem: '#hyjy',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'hdate', title: '会议时间', width:130,align:"center"},
				    	{field:'htitle', title: '会议标题', width:200,align:"center"},
				    	{field:'hcontent', title: '会议内容',align:"center"},
				    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
				    		var content="";
				    		if(d.filenames!=null){
				    			var filenames = d.filenames.split(",");
					    		var fileids = d.fileids.split(",");
					    		if(filenames.length>0){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
					    		}
					    		for(var i=1;i<filenames.length;i++){
					    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
					    		}
				    		}
				    		return content;
				    	}},
				    	{field:'addoperator', title: '录入人', width:100,align:"center"}
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("tdhjTab").getElementsByTagName("li");
					    	for(var i=0;i<res.handleInfoList.length;i++){
					    		if(res.handleInfoList[i].htype==1){
					    			obj[0].innerHTML="领导批示（"+res.handleInfoList[i].nums+"）";
					    		}
					    		if(res.handleInfoList[i].htype==2){
					    			obj[1].innerHTML="涉稳专报（"+res.handleInfoList[i].nums+"）";
					    		}
		          				if(res.handleInfoList[i].htype==5){
					    			obj[2].innerHTML="专题会议纪要（"+res.handleInfoList[i].nums+"）";
					    		}
					    	}
					    }
					}
				});
				
				//引发涉稳事件监听行工具事件
				ListenTool("引发涉稳事件","swsj","eventsInfo","&fxdj=${contradictionInfo.cdtlevel}&page=updateCheck","getEventsInfo.do","cancelEventsInfo.do","<c:url value='searchEventsInfo.do'/>");
				//情报线索信息监听行工具事件
				ListenTool("情报线索信息","qbxs","leadsInfo","&fxdj=${contradictionInfo.cdtlevel}&page=updateCheck","getLeadsInfo.do","cancelLeadsInfo.do","<c:url value='searchLeadsInfo.do'/>");
				//情报线索信息监听行工具事件
				ListenTool("稳控化解情况","wkhj","defuseInfo","&page=updateCheck","getDefuseInfo.do","cancelDefuseInfo.do","<c:url value='searchDefuseInfo.do'/>");
				//工作提示单监听行工具事件
				workInfoListenTool("工作提示单","tsd","workInfo/tsd","&wtype=1&page=feedback");
				//工作交办单监听行工具事件
				workInfoListenTool("工作交办单","jbd","workInfo/tsd","&wtype=2&page=feedback");
				//工作督办单监听行工具事件
				workInfoListenTool("工作督办单","dbd","workInfo/tsd","&wtype=3&page=feedback");
				//责任追究建议函监听行工具事件
				workInfoListenTool("责任追究建议函","jyh","workInfo/tsd","&wtype=4&page=feedback");
				//领导批示监听行工具事件
				ListenTool("领导批示","ldps","handleInfo","&htype=1","getHandleInfo.do","cancelHandleInfo.do","<c:url value='searchHandleInfo.do'/>");
				//涉稳专报监听行工具事件
				ListenTool("涉稳专报","yqkb","handleInfo","&htype=2","getHandleInfo.do","cancelHandleInfo.do","<c:url value='searchHandleInfo.do'/>?htype=2");
				//维稳专报监听行工具事件
<%--				ListenTool("维稳专报","wwzb","handleInfo","&htype=3","getHandleInfo.do","cancelHandleInfo.do","<c:url value='searchHandleInfo.do'/>?htype=3");--%>
				//涉稳风险交办处置建议监听行工具事件
<%--				ListenTool("涉稳风险交办处置建议","jbcz","handleInfo","&htype=4","getHandleInfo.do","cancelHandleInfo.do","<c:url value='searchHandleInfo.do'/>?htype=4");--%>
				//专题会议纪要监听行工具事件
				ListenTool("专题会议纪要","hyjy","handleInfo","&htype=5","getHandleInfo.do","cancelHandleInfo.do","<c:url value='searchHandleInfo.do'/>?htype=5");
				
				//情报线索工具按钮监听
				table.on('tool(qbxs)', function(obj){
					switch(obj.event){
						case 'qbbs':
							var exparam = "&infostate="+obj.data.xscz+"&infotitle="+obj.data.ltitle+"&lcontent="+obj.data.lcontent+"&czqkgs="+obj.data.czqkgs;
							var index = layui.layer.open({
								title:	"新增上报信息",
								type:	2,
								content:'<c:url value="/jsp/event/contradictionInfo/leadsInfo/information_add.jsp"/>?menuid=${param.menuid}'+exparam,
								area:	['800','800px'],
								maxmin:	true,
								success:	function(layero, index){
									setTimeout(function(){
										layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
											tips: 3
										});
									},500)
								}
							});
							layui.layer.full(index);
						break;
					}
				});
				
				element.on('tab(detailTabs)', function(data){
					switch(data.index){
						case 0:
							formSubmit('swsj','<c:url value="searchEventsInfo.do"/>');
							formSubmit('swsj_zfw','<c:url value="searchEventsInfo_zfw.do"/>');
						break;
						case 1:
							formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
							formSubmit('qbxs_zfw','<c:url value="searchLeadsInfo_zfw.do"/>');
						break;
						case 2:
							formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
							formSubmit('zzry_zfw','<c:url value="searchKeypersonnel_zfw.do"/>');
						break;
						case 3:
							formSubmit('wkhj','<c:url value="searchDefuseInfo.do"/>');
							formSubmit('wkhj_zfw','<c:url value="searchDefuseInfo_zfw.do"/>');
						break;
					}
				});
				
				element.on('tab(gzjbTab)', function(data){
					switch(data.index){
						case 0:
							formSubmit('tsd','<c:url value="searchWorkInfo.do"/>');
						break;
						case 1:
							formSubmit('jbd','<c:url value="searchWorkInfo.do"/>?wtype=2');
						break;
						case 2:
							formSubmit('dbd','<c:url value="searchWorkInfo.do"/>?wtype=3');
						break;
						case 3:
							formSubmit('jyh','<c:url value="searchWorkInfo.do"/>?wtype=4');
						break;
					}
				});
				
				element.on('tab(tdhjTab)', function(data){
					switch(data.index){
						case 0:
							formSubmit('ldps','<c:url value="searchHandleInfo.do"/>');
						break;
						case 1:
							formSubmit('yqkb','<c:url value="searchHandleInfo.do"/>?htype=2');
						break;
<%--						case 2:--%>
<%--							formSubmit('wwzb','<c:url value="searchHandleInfo.do"/>?htype=3');--%>
<%--						break;--%>
<%--						case 3:--%>
<%--							formSubmit('jbcz','<c:url value="searchHandleInfo.do"/>?htype=4');--%>
<%--						break;--%>
						case 2:
							formSubmit('hyjy','<c:url value="searchHandleInfo.do"/>?htype=5');
						break;
					}
				});
				
				//政法委监听
				table.on('toolbar(swsj_zfw)', function(obj){
					var  checkStatus =table.checkStatus(obj.config.id);
					switch(obj.event){
						case 'check':
							var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								if(datas[0].validflag==1){
									top.layer.confirm('确定将此信息加入公安库？', function(index){
							        	layer.close(index);
								        $.getJSON('<c:url value="zfwEventsInfo_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
											var str = eval('(' + data + ')');
											if (str.flag ==1) {		                          
										     	top.layer.msg("数据审查成功！"); 	
												formSubmit('swsj','<c:url value="searchEventsInfo.do"/>');
												formSubmit('swsj_zfw','<c:url value="searchEventsInfo_zfw.do"/>');
											}else{
												top.layer.msg("审查失败!");
											}			      	    		
								        });
									});
								}else{
									top.layer.msg("该数据已经在公安库中!");
								}
							}
						break;
					}
				});
				
				table.on('toolbar(qbxs_zfw)', function(obj){
					var checkStatus =table.checkStatus(obj.config.id);
					switch(obj.event){
						case 'check':
							var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								console.log(datas[0].validflag);
								if(datas[0].validflag==1){
									top.layer.confirm('确定将此信息加入公安库？', function(index){
							        	layer.close(index);
								        $.getJSON('<c:url value="zfwLeadsInfo_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
											var str = eval('(' + data + ')');
											if (str.flag ==1) {		                          
										     	top.layer.msg("数据审查成功！"); 	
												formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
												formSubmit('qbxs_zfw','<c:url value="searchLeadsInfo_zfw.do"/>');
											}else{
												top.layer.msg("审查失败!");
											}			      	    		
								        });
									});
								}else{
									top.layer.msg("该数据已经在公安库中!");
								}
							}
						break;
					}
				});
				
				table.on('toolbar(zzry_zfw)', function(obj){
					var checkStatus =table.checkStatus(obj.config.id);
					switch(obj.event){
						case 'check':
							var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								console.log(datas[0].validflag);
								if(datas[0].validflag==1){
									top.layer.confirm('确定将此信息加入公安库？', function(index){
							        	layer.close(index);
								        $.getJSON('<c:url value="zfwKeypersonnel_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
											var str = eval('(' + data + ')');
											if (str.flag ==1) {		                          
										     	top.layer.msg("数据审查成功！"); 	
												formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
												formSubmit('zzry_zfw','<c:url value="searchKeypersonnel_zfw.do"/>');
											}else{
												top.layer.msg("审查失败!");
											}			      	    		
								        });
									});
								}else{
									top.layer.msg("该数据已经在公安库中!");
								}
							}
						break;
					}
				});
				
				table.on('toolbar(wkhj_zfw)', function(obj){
					var checkStatus =table.checkStatus(obj.config.id);
					switch(obj.event){
						case 'check':
							var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								console.log(datas[0].validflag);
								if(datas[0].validflag==1){
									top.layer.confirm('确定将此信息加入公安库？', function(index){
							        	layer.close(index);
								        $.getJSON('<c:url value="zfwDefuseInfo_check.do"/>?id='+datas[0].id+'&menuid='+${param.menuid },{},function(data) {
											var str = eval('(' + data + ')');
											if (str.flag ==1) {		                          
										     	top.layer.msg("数据审查成功！");
												formSubmit('wkhj','<c:url value="searchDefuseInfo.do"/>');
												formSubmit('wkhj_zfw','<c:url value="searchDefuseInfo_zfw.do"/>');
											}else{
												top.layer.msg("审查失败!");
											}			      	    		
								        });
									});
								}else{
									top.layer.msg("该数据已经在公安库中!");
								}
							}
						break;
					}
				});
			});
			
			
			
			function turnNums(nums){
				for(let i=0;i<nums.length;i++){
					nums[i] = parseInt(nums[i]);
				}
				return nums;
			}
			
			function formSubmit(page,url){
				table.reload(page, {
					url: url,
				    where:{cdtid:${contradictionInfo.id}},
					page: {
						curr: 1
						// 重新从第 1 页开始
					}
				});
			}
			
			//监听行工具事件
			function ListenTool(title,toolname,addfolder,exparam,updateurl,cancelurl,searchurl){
				var content = '<c:url value="/jsp/event/contradictionInfo/'+addfolder+'/add.jsp"/>?menuid=${param.menuid }&cdtid=${contradictionInfo.id}'+exparam;
				table.on('toolbar('+toolname+')', function(obj){
				   var  checkStatus =table.checkStatus(obj.config.id);
				   switch(obj.event){
				   case 'add':
				   var index = layui.layer.open({
								title : "添加"+title,
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content : [content,'yes'],
								area: ['800', '800px'],
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
				   		if(<%=userSession.getLoginRoleEventFilter() %>!=0&&<%=userSession.getLoginRoleFieldFilter() %>==2&&<%=userSession.getLoginUserID() %>!=datas[0].addoperatorid){
				   			top.layer.alert("只有添加人才可以修改数据！");
				   		}else{
				   			var id=datas[0].id;
						    var index = layui.layer.open({
										title : "修改"+title,
										type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
										content : '<c:url value="'+updateurl+'"/>?id='+id+'&menuid='+${param.menuid }+exparam,
										area: ['800', '800px'],
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
					}else{
						top.layer.alert("请先选择修改哪条数据！");
					}
				    break;
				    
				case 'canel':
				   var data=JSON.stringify(checkStatus.data);
				   var datas=JSON.parse(data);
				    if(datas!=""){
				    	if(<%=userSession.getLoginRoleEventFilter() %>==0||<%=userSession.getLoginUserID() %>==datas[0].addoperatorid){
				    		var id=datas[0].id;
						    top.layer.confirm('确定删除此信息？', function(index){
						        layer.close(index);
						        $.getJSON('<c:url value="'+cancelurl+'"/>?id='+id+'&menuid='+${param.menuid },{
									},function(data) {
									var str = eval('(' + data + ')');
						        	 if (str.flag ==1) {		                          
								     	top.layer.msg("数据删除成功！"); 	
								     	formSubmit(toolname,searchurl);                
								     }else{
										top.layer.msg("删除失败!");
								      }			      	    		
						        	});      
								});
				    	}else{
				   			top.layer.alert("只有添加人才可以删除数据！");
				   		}
					}else{
						top.layer.alert("请先选择删除哪条数据！");
					}
				    break;
				   };
				   
				 });
			}
			
			//工作提示单监听行工具事件
			function workInfoListenTool(title,toolname,addfolder,exparam){
				table.on('toolbar('+toolname+')', function(obj){
					var  checkStatus =table.checkStatus(obj.config.id);
					switch(obj.event){
						case 'xf':
							var index = layui.layer.open({
								title : "下发"+title,
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content : '<c:url value="/jsp/event/contradictionInfo/'+addfolder+'/add.jsp"/>?menuid=${menuid }&cdtid=${contradictionInfo.id}'+exparam,
								area: ['800', '750px'],
								maxmin: true,
								success : function(layero, index){
									setTimeout(function(){
										layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
											tips: 3
										});
									},500)
								}
							});			
							layui.layer.full(index);
					    break;
						case 'qs':
							var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								if(<%=userSession.getLoginUserID() %>==datas[0].receiverid){
									if(datas[0].nowstates==1){
										var id=datas[0].id;
										top.layer.confirm('确定签收？', function(index){
								        	layer.close(index);
								        	$.getJSON('<c:url value="signWorkInfo.do"/>?id='+id+'&menuid='+${param.menuid },{},function(data) {
												var str = eval('(' + data + ')');
								        		if (str.flag ==1) {		                          
										    		top.layer.msg("数据签收成功！"); 	
										     		table.reload(toolname, {    
										        	});                 
										     	}else{
													top.layer.msg("签收失败!");
										    	}		      	    		
								        	});
										});
									}else{
										top.layer.msg("数据已签收!");
									}
								}else{
									top.layer.alert("只有接收人才可以签收！");
								}
							}else{
								top.layer.alert("请先选择签收哪条数据！");
							}
					    break;
						case 'fk':
					   		var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								if(<%=userSession.getLoginUserID() %>==datas[0].receiverid){
									if(datas[0].nowstates!=1){
										var id=datas[0].id;
										var index = layui.layer.open({
											title : "反馈工作交办管理",
											type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
											content : '<c:url value="getFeedback.do"/>?menuid=${menuid }&id='+id+exparam,
											area: ['800', '800px'],
											maxmin: true,
											success : function(layero, index){
												setTimeout(function(){
													layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
														tips: 3
													});
												},500)
											}
										});
										layui.layer.full(index);
									}else{
										top.layer.alert("请先签收数据！");
									}
								}else{
									top.layer.alert("只有接收人才可以反馈！");
								}
							}else{
								top.layer.alert("请先选择反馈哪条数据！");
							}
					    break;
					    case 'dy':
					    	var data=JSON.stringify(checkStatus.data);
							var datas=JSON.parse(data);
							if(datas!=""){
								var id=datas[0].id;
								var index = layui.layer.open({
									title : "打印工作交办管理",
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content : '<c:url value="printWorkInfo.do"/>?id='+id+exparam,
									area: ['800', '800px'],
									maxmin: true,
									success : function(layero, index){
										setTimeout(function(){
											layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
												tips: 3
											});
										},500)
									}
								});
								layui.layer.full(index);
							}else{
								top.layer.alert("请先选择打印哪条数据！");
							}
					    break;
					}
				 });
			}
			
			$("#addConnect").click(function () {
				var Validator = new IDValidator();
				if(!Validator.isValid($('#cardnumber').val())){
					top.layer.alert("身份证号不合法，请重新输入！");
				}else{
					//新增关联
					$.ajax({
						type:		'POST',
						url:		'<c:url value="/addKeypersonnel.do"/>',
						data:		{cardnumber:$('#cardnumber').val(),cdtid:${contradictionInfo.id},menuid:${menuid}},
						dataType:	'json',
						success:	function(data){
		           			var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                  	    //弹出loading
		 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
			 		        		//刷新
			 		        		formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
		                   		},2000);
		                 	}else if(obj.flag==0){
		                  	 	//新增涉稳人员
		                  	 	var index = layui.layer.open({
									title : "添加涉稳人员",
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content : '<c:url value="/getWenGradeUpdate.do"/>?page=addinContradiction&menuid=${menuid }&cdtid=${contradictionInfo.id}'+'&cardnumber='+$('#cardnumber').val(),
									area: ['800', '600px'],
									maxmin: true,
									success : function(layero, index){
										setTimeout(function(){
											layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
												tips: 3
											});
										},500)
									}
								});
								layui.layer.full(index);
		                	}else{
		                		layer.msg(obj.msg);
		                	}
						}
					});
				}
			});
			
			$("#cancelConnect").click(function () {
				var  checkStatus =table.checkStatus('zzry');
				var data=JSON.stringify(checkStatus.data);
   				var datas=JSON.parse(data);
   				if(datas!=""){
				   var id=datas[0].id;
				    top.layer.confirm('确定删除此信息？', function(index){
				        layer.close(index);
				        $.getJSON('<c:url value="cancelKeypersonnel.do"/>?id='+id+'&menuid='+${param.menuid }+'&cardnumber='+datas[0].cardnumber,{
							},function(data) {
								var obj = eval('(' + data + ')');
		                  		if(obj.flag>0){
		                  			top.layer.msg("数据删除成功！");
		                  			//刷新
			 		        		formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
		                  		}else{
		                  			layer.msg("删除失败!");
		                  		}
				        	});      
						});
				}else{
					layer.alert("请先选择删除哪条数据！");
				}
			});
			
			$("#changeImportance").click(function () {
				var  checkStatus =table.checkStatus('zzry');
				var data=JSON.stringify(checkStatus.data);
   				var datas=JSON.parse(data);
   				if(datas!=""){
					var id=datas[0].id;
				    top.layer.prompt({
						formType: 2,//这里依然指定类型是多行文本框，但是在下面content中也可绑定多行文本框
						title: '重要程度',
						area: ['300px', '100px'],
						btnAlign: 'c',
						content: `<div><input type="number" name="importance" id="importance" autocomplete="off" placeholder="请输入重要程度" class="layui-input"></div>`,
						yes: function (index, layero) {
						     var importance = top.$('#importance').val();//获取多行文本框的值
						     if(importance!=""){
                                $.getJSON('<c:url value="updateKpImportance.do"/>?id='+id+'&importance='+importance,{},function(data) {
			      	          	if (data.flag ==1) {		                          
							    	top.layer.msg("重要程度设置成功！"); 
							    	top.layer.close(index);	
							     	table.reload('zzry', {});       		          
						       	 	}else{
										top.layer.msg("重要程度设置失败!");
						      	 	}			      	    		
						      	});
						     }else{
						     	top.layer.msg("请输入要设置的重要程度！", { icon: 5, anim: 6 });
						     }
					       }
                        });
				}else{
					top.layer.alert("请先选择调整哪条数据！");
				}
			});
			
			function showInfo(url,title,id){
				var content = "<c:url value='"+url+"'/>?id="+id;
				var index = layui.layer.open({
					title : title+"详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : content,
					area: ['800', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
				layui.layer.full(index);
			}
			
			function showinfoWenGrade(id){
			 	var index = layui.layer.open({
					title : "风险人员-涉稳详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : "<c:url value='/getWenGradeUpdate.do'/>?id="+id+'&menuid='+${param.menuid}+'&page=showinfo',
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
			 
			 function openTimeaxis(id){
				var index = layui.layer.open({
					title : "时间轴",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="searchTimeaxis.do"/>?id='+id,
					area: ['800', '800px'],
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
		</script>
		<script type="text/javascript">
			function openPGis(type,name){
				var place=$("#"+type+"place").val().trim();
				var x=$("#"+type+"x").val();
				var y=$("#"+type+"y").val();
				var f1=function(event){
					place=event.data.mc;
					x=event.data.lx;
					y=event.data.ly;
					$("#"+type+"place").val(place);
					$("#"+type+"x").val(x);
					$("#"+type+"y").val(y);
					layer.close(index);
					window.removeEventListener('message',f1,false);
				};
				var index = layui.layer.open({
					title : name+"标准地址修改",
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
			
			function showWorkInfo(id,wtypename){
	 			var index = layui.layer.open({
					title : wtypename+"详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="showWorkInfo.do"/>?id='+id+'&menuid=${param.menuid }',
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
