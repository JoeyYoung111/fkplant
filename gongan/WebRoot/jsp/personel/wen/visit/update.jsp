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
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: -3px;">
  		<legend id="typeName">修改涉诉涉访经历</legend>
	</fieldset>
<form class="layui-form" method="post" id="form1" onsubmit="return false;">
	<input type="hidden"  name="id" value=${wenVisit.id }>
	<input type="hidden"  name="menuid" value=${menuid }>
	<input type="hidden" id="personnelid"  name="personnelid" value=${wenVisit.personnelid }>
	<div class="layui-row">
		<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>活动开始日期</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block">
		      			<input type="text" name="startdate" value="${wenVisit.startdate}" id="startdate" readonly lay-verify="required" lay-reqtext="请选择活动开始日期" autocomplete="off" placeholder="年-月-日" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">活动结束日期</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
		      			<input type="text" name="enddate" value="${wenVisit.enddate}" id="enddate" readonly autocomplete="off" placeholder="年-月-日" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>是否敏感节点</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block">
			    		<select name="sensitivenode" id="sensitivenode" lay-filter="sensitivenode">
							<option value="0" selected>否</option>
							<option value="1">是</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">敏感节点名称</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block" lay-verify="nodename">
						<select name="nodename" id="nodename" lay-filter="nodename" disabled>
							<option value>==请选择==</option>
							<c:forEach items="${nodename}" var="row" varStatus="num">
								<option value="${row.basicName}">${row.basicName}</option>
							</c:forEach>
							<option value="重要活动">重要活动</option>
							<option value="重大赛事">重大赛事</option>
							<option value="其它">其它</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	  	</div>
		<div class="layui-form-item" id="nodememo_show" style="display:none;">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">敏感节点备注说明</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="nodememo" value="${wenVisit.nodememo}"  id="nodememo" lay-verify="nodememo" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>当次行为活动类别</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="activitytype">
		      			<select name="activitytype" id="activitytype" lay-filter="activitytype">
			      			<option value>==请选择==</option>
							<c:forEach items="${activitytype}" var="row" varStatus="num">
								<option value="${row.basicName}">${row.basicName}</option>
							</c:forEach>
							<option value="其它">其它</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		    	<div class="layui-col-md11">	
			    	<div class="layui-input-block" style="margin-left:-50px;">
		      			<input type="text" name="activitymemo" value="${wenVisit.activitymemo}" id="activitymemo" lay-verify="activitymemo" style="background:#efefef" readonly autocomplete="off" placeholder="备注说明" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动方向</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="activitydirection">
		      			<select name="activitydirection" id="activitydirection" lay-filter="activitydirection">
			      			<option value>==请选择==</option>
							<option value="市县">市县</option>
							<option value="赴省">赴省</option>
							<option value="赴京">赴京</option>
							<option value="其它">其它</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		    	<div class="layui-col-md11">	
			    	<div class="layui-input-block" style="margin-left:-50px;">
		      			<input type="text" name="directionmemo" value="${wenVisit.directionmemo}" id="directionmemo" lay-verify="directionmemo" style="background:#efefef" readonly autocomplete="off" placeholder="备注说明" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动涉及场所</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="relatedplace">
		      			<select name="relatedplace" id="relatedplace" lay-filter="relatedplace">
			      			<option value>==请选择==</option>
			      			<c:forEach items="${relatedplace}" var="row" varStatus="num">
								<option value="${row.basicName}" place-character="${row.parentName}">${row.basicName}</option>
							</c:forEach>
							<option value="其它" place-character="其它">其它</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		    	<div class="layui-col-md11">	
			    	<div class="layui-input-block" style="margin-left:-50px;">
		      			<input type="text" name="placememo" value="${wenVisit.placememo}" id="placememo" lay-verify="placememo" style="background:#efefef" readonly autocomplete="off" placeholder="备注说明" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
    	</div>
    	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">单位场所性质</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
		      			<input type="text" name="placecharacter" value="${wenVisit.placecharacter}" id="placecharacter" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	    	<div class="layui-col-md6">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动具体形式</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="activityform">
		      			<select name="activityform" id="activityform" lay-filter="activityform">
			      			<option value>==请选择==</option>
							<c:forEach items="${activityform_show}" var="row" varStatus="num">
								<option value="${row.basicName}">${row.basicName}</option>
							</c:forEach>
							<option value="其它表示方式">其它表示方式</option>
							<c:forEach items="${activityform_disturb}" var="row" varStatus="num">
								<option value="${row.basicName}">${row.basicName}</option>
							</c:forEach>
							<option value="其它扰乱秩序行为">其它扰乱秩序行为</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		    	<div class="layui-col-md11">	
			    	<div class="layui-input-block" style="margin-left:-50px;">
		      			<input type="text" name="formmemo" value="${wenVisit.formmemo}" id="formmemo" lay-verify="formmemo" style="background:#efefef" readonly autocomplete="off" placeholder="备注说明" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动携带物品</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="activitything">
		      			<select name="activitything" id="activitything" lay-filter="activitything">
			      			<option value>==请选择==</option>
							<c:forEach items="${activitything}" var="row" varStatus="num">
								<option value="${row.basicName}">${row.basicName}</option>
							</c:forEach>
							<option value="其它涉访物品">其它涉访物品</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		    	<div class="layui-col-md11">	
			    	<div class="layui-input-block" style="margin-left:-50px;">
		      			<input type="text" name="thingmemo" value="${wenVisit.thingmemo}" id="thingmemo" lay-verify="thingmemo" style="background:#efefef" readonly autocomplete="off" placeholder="备注说明" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动具体经过</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="activityprocess" value="${wenVisit.activityprocess}" lay-verify="required" lay-reqText="请填写行为活动具体经过" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动涉及单位登记受理情况</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="acceptance" value="${wenVisit.acceptance}" lay-verify="required" lay-reqText="请填写行为活动涉及单位登记受理情况" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动前往方式</label>
			    </div>
		    	<div class="layui-col-md8">	
			    	<div class="layui-input-block">
		      			<input type="text" name="traffictype" value="${wenVisit.traffictype}" id="traffictype" lay-verify="required" lay-reqText="请填写行为活动前往方式" class="layui-input">
			    	</div>
		    	</div>
		    	<div class="layui-col-md2" style="padding-top:5px;padding-left:15px;">
		    		<input type="hidden" id="jointcontrolid" name="jointcontrolid" value=-1>
			    	<button id="connect" class="layui-btn layui-btn-sm layui-btn-primary"><i class="layui-icon">&#xe64c;</i>关 联</button>
			    </div>
	    	</div>
	    	<div class="layui-col-md6">
	    		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">前往活动同行人员</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
		      			<input type="text" name="togetherperson" value="${wenVisit.togetherperson}" id="togetherperson" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动落脚方式</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="staytype">
		      			<select name="staytype" id="staytype" lay-filter="staytype">
			      			<option value>==请选择==</option>
							<option value="旅馆住宿">旅馆住宿</option>
							<option value="租住房屋">租住房屋</option>
							<option value="关系借宿">关系借宿</option>
							<option value="其它落脚方式">其它落脚方式</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		    	<div class="layui-col-md11">	
			    	<div class="layui-input-block" style="margin-left:-50px;">
		      			<input type="text" name="staymemo" value="${wenVisit.staymemo}" id="staymemo" lay-verify="staymemo" style="background:#efefef" readonly autocomplete="off" placeholder="备注说明" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div id="stay_show" style="display:none;">
	  		<div class="layui-form-item">
		    	<div class="layui-col-md6">
			    	<div class="layui-col-md1 layui-col-md-offset1">
				    	<label class="layui-form-label">入住时间</label>
			    	</div>
			    	<div class="layui-col-md9">
				    	<div class="layui-input-block">
			      			<input type="text" name="hotelintime" value="${wenVisit.hotelintime}" id="hotelintime" readonly lay-verify="hotelintime" autocomplete="off" placeholder="年-月-日" class="layui-input">
				    	</div>
			    	</div>
		    	</div>
		   		<div class="layui-col-md6">
			   		<div class="layui-col-md1 layui-col-md-offset1">
				    	<label class="layui-form-label">退房时间</label>
				    </div>
			    	<div class="layui-col-md9">	
				    	<div class="layui-input-block">
			      			<input type="text" name="hotelouttime" value="${wenVisit.hotelouttime}" id="hotelouttime" readonly lay-verify="hotelouttime" autocomplete="off" placeholder="年-月-日" class="layui-input">
				    	</div>
			    	</div>
		    	</div>
		  	</div>
	  		<div class="layui-form-item">
		    	<div class="layui-col-md6">
			    	<div class="layui-col-md1 layui-col-md-offset1">
				    	<label class="layui-form-label">旅馆名称</label>
			    	</div>
			    	<div class="layui-col-md9">
				    	<div class="layui-input-block">
			      			<input type="text" name="hotelname" value="${wenVisit.hotelname}" lay-verify="hotelname" autocomplete="off" class="layui-input">
				    	</div>
			    	</div>
		    	</div>
		   		<div class="layui-col-md6">
			   		<div class="layui-col-md1 layui-col-md-offset1">
				    	<label class="layui-form-label">入住房号</label>
				    </div>
			    	<div class="layui-col-md9">	
				    	<div class="layui-input-block">
			      			<input type="text" name="hotelroom" value="${wenVisit.hotelroom}" lay-verify="hotelroom" autocomplete="off" class="layui-input">
				    	</div>
			    	</div>
		    	</div>
		  	</div>
	  		<div class="layui-form-item">
		    	<div class="layui-col-md6">
			    	<div class="layui-col-md1 layui-col-md-offset1">
				    	<label class="layui-form-label">旅馆编码</label>
			    	</div>
			    	<div class="layui-col-md9">
				    	<div class="layui-input-block">
			      			<input type="text" name="hotelcode" value="${wenVisit.hotelcode}" lay-verify="hotelcode" autocomplete="off" class="layui-input">
				    	</div>
			    	</div>
		    	</div>
		   		<div class="layui-col-md6">
			   		<div class="layui-col-md1 layui-col-md-offset1">
				    	<label class="layui-form-label">旅馆地址</label>
				    </div>
			    	<div class="layui-col-md9">	
				    	<div class="layui-input-block">
			      			<input type="text" name="hoteladdress" value="${wenVisit.hoteladdress}" lay-verify="hoteladdress" autocomplete="off" class="layui-input">
				    	</div>
			    	</div>
		    	</div>
		  	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为活动现场发现单位</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="findunit" value="${wenVisit.findunit}" lay-verify="required" lay-reqText="请填写行为活动现场发现单位" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>现场处置结果情况</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="handleresult">
		      			<select name="handleresult" id="handleresult" lay-filter="handleresult">
			      			<option value>==请选择==</option>
							<c:forEach items="${handleresult}" var="row" varStatus="num">
								<option value="${row.basicName}" <c:if test="${row.basicName == wenVisit.handleresult}">selected</c:if>>${row.basicName}</option>
							</c:forEach>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为人员返回方式</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="returntype">
		      			<select name="returntype" id="returntype" lay-filter="returntype">
			      			<option value>==请选择==</option>
			      			<option value="自行返回">自行返回</option>
			      			<option value="中途劝返">中途劝返</option>
			      			<option value="对接领回">对接领回</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
	   			<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>行为人员返回使用交通工具</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="returnvehicle">
		      			<select name="returnvehicle" id="returnvehicle" lay-filter="returnvehicle">
			      			<option value>==请选择==</option>
			      			<c:forEach items="${returnvehicle}" var="row" varStatus="num">
								<option value="${row.basicName}" <c:if test="${row.basicName == wenVisit.returnvehicle}">selected</c:if>>${row.basicName}</option>
							</c:forEach>
						</select>
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">返回使用交通工具备注说明</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="vehiclememo" value="${wenVisit.vehiclememo}" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div id="returntype_show" class="layui-form-item" style="display:none;">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">接回力量单位</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block">
		      			<input type="text" name="powerunit" value="${wenVisit.powerunit}" lay-verify="powerunit" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">人员情况</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
		      			<input type="text" name="personstate" value="${wenVisit.personstate}" lay-verify="personstate" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>人员回澄采集情况</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="returncollect">
		      			<select name="returncollect" id="returncollect" lay-filter="returncollect">
			      			<option value>==请选择==</option>
			      			<option value="已标采" <c:if test="${wenVisit.returncollect eq '已标采'}">selected</c:if>>已标采</option>
			      			<option value="采手机" <c:if test="${wenVisit.returncollect eq '采手机'}">selected</c:if>>采手机</option>
			      			<option value="未采集" <c:if test="${wenVisit.returncollect eq '未采集'}">selected</c:if>>未采集</option>
			      			<option value="无采集条件" <c:if test="${wenVisit.returncollect eq '无采集条件'}">selected</c:if>>无采集条件</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
	   			<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label"><font color="red" size=2>*</font>人员回澄处罚结果</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block" lay-verify="returnpunish">
		      			<select name="returnpunish" id="returnpunish" lay-filter="returnpunish">
			      			<option value>==请选择==</option>
			      			<option value="教育训诫" <c:if test="${wenVisit.returnpunish eq '教育训诫'}">selected</c:if>>教育训诫</option>
			      			<option value="行政处罚" <c:if test="${wenVisit.returnpunish eq '行政处罚'}">selected</c:if>>行政处罚</option>
			      			<option value="刑事强制" <c:if test="${wenVisit.returnpunish eq '刑事强制'}">selected</c:if>>刑事强制</option>
			      			<option value="暂不处理" <c:if test="${wenVisit.returnpunish eq '暂不处理'}">selected</c:if>>暂不处理</option>
						</select>
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">具体处罚内容</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<textarea class="layui-textarea" rows=2 name="punishcontent">${wenVisit.punishcontent}</textarea>
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">登记受理单位答复情况</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="unitreply" value="${wenVisit.unitreply}" autocomplete="off" class="layui-input">
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">训诫书、羁押或交接手续单据</label>
		    	</div>
		    	<div class="layui-col-md9">
			    	<div class="layui-input-block">
						<button type="button" class="layui-btn" id="admonishfile"><i class="layui-icon">&#xe681;</i>上 传</button>
			    		<button type="button" class="layui-btn layui-hide"
											id="admonishfileAction">开始上传</button>
			    	</div>
		    	</div>
	    	</div>
	   		<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">其它附件</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
						<button type="button" class="layui-btn" id="attachments"><i class="layui-icon">&#xe681;</i>上 传</button>
			    		<button type="button" class="layui-btn layui-hide"
											id="attachmentsAction">开始上传</button>
			    	</div>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
		   	<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">上传文件</label>
		    	</div>
	    	</div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
			    		<div class="layui-upload">
							<div class="layui-upload-list">
								<table class="layui-table" style="border: 1px solid #eee;">
									<thead>
										<tr>
											<th width="20%">文件名</th>
											<th width="40%">类别</th>
											<th width="20%">状态</th>
											<th width="20%">操作</th>
										</tr>
									</thead>
									<tbody id="upload-filesList"></tbody>
								</table>
							</div>
						</div>
			    	</div>
		    	</div>
	    	</div>
	  	</div>
		<div class="layui-form-item">
		    <div class="layui-col-md4 layui-col-md-offset5">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="visitSub">立即提交</button>
		    </div>
	  	</div>
  	</div>
</form>
	<script type="text/javascript">
		$(document).ready(function(){
		});
		var pathName=window.document.location.pathname;
		var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
		var protocol = location.protocol;
		var hostname = location.hostname;    
		var port = location.port; 
		var locat = protocol + "//" + hostname + ":" + port + projectName;
		layui.use(['form','laydate','upload'], function(){
		  var form = layui.form,
		  laydate = layui.laydate,
		  upload = layui.upload,
		  layer = layui.layer;
		  
		  laydate.render({
		   	elem:'#startdate'
		   	,format: 'yyyy-MM-dd'
		  });
		  laydate.render({
		   	elem:'#enddate'
		   	,format:  'yyyy-MM-dd'
		  });
		  laydate.render({
		   	elem:'#hotelintime'
		   	,format:  'yyyy-MM-dd'
		  });
		  laydate.render({
		   	elem:'#hotelouttime'
		   	,format:  'yyyy-MM-dd'
		  });
		  
		  form.verify({
		  	nodename:function(value,item){
		  		if($("#sensitivenode").val()==1&&$("#nodename").val()==""){
		  			$("#nodename").next().find("input").focus();
			  		return "请选择敏感节点名称";
		  		}
		  	},
		  	nodememo:function(value,item){
		  		if(($("#nodename").val()=="重要活动"||$("#nodename").val()=="重大赛事"||$("#nodename").val()=="其它")&&value=="")return "请填写敏感节点备注说明";
		  	},
		  	activitytype:function(value,item){
		  		if($("#activitytype").val()==""){
		  			$("#activitytype").next().find("input").focus();
			  		return "请选择当次行为活动类别";
		  		}
		  	},
		  	activitymemo:function(value,item){
		  		if($("#activitytype").val()=="其它"&&value=="")return "请填写当次行为活动类别备注说明";
		  	},
		  	activitydirection:function(value,item){
		  		if($("#activitydirection").val()==""){
		  			$("#activitydirection").next().find("input").focus();
			  		return "请选择行为活动方向";
		  		}
		  	},
		  	directionmemo:function(value,item){
		  		if($("#activitydirection").val()=="其它"&&value=="")return "请填写行为活动方向备注说明";
		  	},
		  	relatedplace:function(value,item){
		  		if($("#relatedplace").val()==""){
		  			$("#relatedplace").next().find("input").focus();
			  		return "请选择行为活动涉及场所";
		  		}
		  	},
		  	placememo:function(value,item){
		  		if($("#relatedplace").val()=="其它"&&value=="")return "请填写行为活动涉及场所备注说明";
		  	},
		  	activityform:function(value,item){
		  		if($("#activityform").val()==""){
		  			$("#activityform").next().find("input").focus();
			  		return "请选择行为活动具体形式";
		  		}
		  	},
		  	formmemo:function(value,item){
		  		if(($("#activityform").val()=="其它表示方式"||$("#activityform").val()=="其它扰乱秩序行为")&&value=="")return "请填写行为活动具体形式备注说明";
		  	},
		  	activitything:function(value,item){
		  		if($("#activitything").val()==""){
		  			$("#activitything").next().find("input").focus();
			  		return "请选择行为活动携带物品";
		  		}
		  	},
		  	thingmemo:function(value,item){
		  		if($("#activitything").val()=="其它涉访物品"&&value=="")return "请填写行为活动携带物品备注说明";
		  	},
		  	staytype:function(value,item){
		  		if($("#staytype").val()==""){
		  			$("#staytype").next().find("input").focus();
			  		return "请选择行为活动落脚方式";
		  		}
		  	},
		  	staymemo:function(value,item){
		  		if($("#staytype").val()!="旅馆住宿"&&value=="")return "请填写行为活动落脚方式备注说明";
		  	},
		  	hotelintime:function(value,item){
		  		if($("#staytype").val()=="旅馆住宿"&&value=="")return "请选择入住时间";
		  	},
		  	hotelouttime:function(value,item){
		  		if($("#staytype").val()=="旅馆住宿"&&value=="")return "请选择退房时间";
		  	},
		  	hotelname:function(value,item){
		  		if($("#staytype").val()=="旅馆住宿"&&value=="")return "请填写旅馆名称";
		  	},
		  	hotelroom:function(value,item){
		  		if($("#staytype").val()=="旅馆住宿"&&value=="")return "请填写入住房号";
		  	},
		  	hotelcode:function(value,item){
		  		if($("#staytype").val()=="旅馆住宿"&&value=="")return "请填写旅馆编码";
		  	},
		  	hoteladdress:function(value,item){
		  		if($("#staytype").val()=="旅馆住宿"&&value=="")return "请填写旅馆地址";
		  	},
		  	handleresult:function(value,item){
		  		if($("#handleresult").val()==""){
		  			$("#handleresult").next().find("input").focus();
			  		return "请选择现场处置结果情况";
		  		}
		  	},
		  	returntype:function(value,item){
		  		if($("#returntype").val()==""){
		  			$("#returntype").next().find("input").focus();
			  		return "请选择行为人员返回方式";
		  		}
		  	},
		  	returnvehicle:function(value,item){
		  		if($("#returnvehicle").val()==""){
		  			$("#returnvehicle").next().find("input").focus();
			  		return "请选择行为人员返回使用交通工具";
		  		}
		  	},
		  	powerunit:function(value,item){
		  		if(($("#returntype").val()=="中途劝返"||$("#returntype").val()=="对接领回")&&value=="")return "请填写接回力量单位";
		  	},
		  	personstate:function(value,item){
		  		if(($("#returntype").val()=="中途劝返"||$("#returntype").val()=="对接领回")&&value=="")return "请填写人员情况";
		  	},
		  	returncollect:function(value,item){
		  		if($("#returncollect").val()==""){
		  			$("#returncollect").next().find("input").focus();
			  		return "请选择人员回澄采集情况";
		  		}
		  	},
		  	returnpunish:function(value,item){
		  		if($("#returnpunish").val()==""){
		  			$("#returnpunish").next().find("input").focus();
			  		return "请选择人员回澄处罚结果";
		  		}
		  	},
		  });
		  
		  form.on('select(sensitivenode)', function(data){
			  if(data.value==1){
			  		$("#nodename").removeAttr("disabled");
    				form.render('select');
    				$("#nodename").next().find("input").css("background","");	
			  }else{
			  		$("#nodename").attr("disabled","disabled");
			  		$("#nodememo_show").hide();
			  		$("#nodename").val("");
			  		$("#nodememo").val("");
			  		form.render();
			  		$("#nodename").next().find("input").css("background","#efefef");
			  }
		  });
		  form.on('select(nodename)', function(data){
			  if(data.value=="重要活动"||data.value=="重大赛事"||data.value=="其它"){
			  		$("#nodememo_show").show();
    				form.render();	
			  }else{
			  		$("#nodememo_show").hide();
			  		$("#nodememo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(activitytype)', function(data){
			  if(data.value=="其它"){
			  		$("#activitymemo").removeAttr("readonly");
			  		$("#activitymemo").css("background","");
    				form.render();	
			  }else{
			  		$("#activitymemo").attr("readonly","");
			  		$("#activitymemo").css("background","#efefef");
			  		$("#activitymemo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(activitydirection)', function(data){
			  if(data.value=="其它"){
			  		$("#directionmemo").removeAttr("readonly");
			  		$("#directionmemo").css("background","");
    				form.render();	
			  }else{
			  		$("#directionmemo").attr("readonly","");
			  		$("#directionmemo").css("background","#efefef");
			  		$("#directionmemo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(relatedplace)', function(data){
			  if(data.value!="")$("#placecharacter").val($("#relatedplace").find("option[value='"+data.value+"']").attr("place-character"))
			  else $("#placecharacter").val("");
			  if(data.value=="其它"){
			  		$("#placememo").removeAttr("readonly");
			  		$("#placememo").css("background","");
    				form.render();	
			  }else{
			  		$("#placememo").attr("readonly","");
			  		$("#placememo").css("background","#efefef");
			  		$("#placememo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(activityform)', function(data){
			  if(data.value=="其它表示方式"||data.value=="其它扰乱秩序行为"){
			  		$("#formmemo").removeAttr("readonly");
			  		$("#formmemo").css("background","");
    				form.render();	
			  }else{
			  		$("#formmemo").attr("readonly","");
			  		$("#formmemo").css("background","#efefef");
			  		$("#formmemo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(activitything)', function(data){
			  if(data.value=="其它涉访物品"){
			  		$("#thingmemo").removeAttr("readonly");
			  		$("#thingmemo").css("background","");
    				form.render();	
			  }else{
			  		$("#thingmemo").attr("readonly","");
			  		$("#thingmemo").css("background","#efefef");
			  		$("#thingmemo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(staytype)', function(data){
			  if(data.value!="旅馆住宿"){
			  		if(data.value!=""){
				  		$("#staymemo").removeAttr("readonly");
				  		$("#staymemo").css("background","");
			  		}else{
			  			$("#staymemo").attr("readonly","");
			  			$("#staymemo").css("background","#efefef");
			  			$("#staymemo").val("");
			  		}
			  		$("#stay_show").hide();
    				form.render();	
			  }else{
			  		$("#staymemo").attr("readonly","");
			  		$("#staymemo").css("background","#efefef");
			  		$("#stay_show").show();
			  		$("#staymemo").val("");
			  		form.render();
			  }
		  });
		  form.on('select(returntype)', function(data){
			  if(data.value=="中途劝返"||data.value=="对接领回"){
			  		$("#returntype_show").show();
    				form.render();	
			  }else{
			  		$("#returntype_show").hide();
			  		$("#powerunit").val("");
			  		$("#personstate").val("");
			  		form.render();
			  }
		  });
		  
		  var admonishfileListView = $("#upload-filesList"),
				admonishfile='',
				admonishfileChoose=0,
				admonishfileBool=false,
				admonishfileUploadListIns = upload.render({
					elem: '#admonishfile',
		       		url: '<c:url value="/newuploadfile1.do"/>',
					accept: 'file',
					multiple: true,
					auto: false,
					bindAction: '#admonishfileAction',
					choose: function(obj) {
						var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
						//读取本地文件
						obj.preview(function(index, file, result) {
							var tr = $(['<tr id="admonishfile-upload-' + index + '">', '<td>' + file.name +
								'</td>',
								'<td>训诫书、羁押或交接手续单据</td>',
								'<td>等待上传</td>', '<td>',
								'<button class="layui-btn layui-btn-sm admonishfile-reload layui-hide">重传</button>',
								'<button class="layui-btn layui-btn-sm layui-btn-danger admonishfile-delete">删除</button>',
								'</td>', '</tr>'
							].join(''));
		
							//单个重传
							tr.find('.admonishfile-reload').on('click', function() {
								obj.upload(index, file);
							});
		
							//删除
							tr.find('.admonishfile-delete').on('click', function() {
								delete files[index]; //删除对应的文件
								tr.remove();
								admonishfileChoose--;
								admonishfileUploadListIns.config.elem.next()[0].value =
								''; //清空 input file 值，以免删除后出现同名文件不可选
							});
							
							admonishfileChoose++;
							admonishfileListView.append(tr);
						});
					},
					done: function(res, index, upload) {
						if (res.success>0) { //上传成功
							var tr = admonishfileListView.find('tr#admonishfile-upload-' + index),
								tds = tr.children();
							tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
							tds.eq(3).html(''); //清空操作
							if(admonishfile!="")admonishfile+=",";
							admonishfile+=res.success;
							admonishfileChoose--;
							return delete this.files[index]; //删除文件队列已经上传成功的文件
						}
						this.error(index, upload);
					},
					allDone: function(obj){ //当文件全部被提交后，才触发
					    admonishfileBool=true;
					},
					error: function(index, upload) {
						var tr = admonishfileListView.find('tr#admonishfile-upload-' + index),
							tds = tr.children();
						tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
						tds.eq(3).find('.admonishfile-reload').removeClass('layui-hide'); //显示重传
					}
				});
				
		  var attachmentsListView = $("#upload-filesList"),
				attachments='',
				attachmentsChoose=0,
				attachmentsBool=false,
				attachmentsUploadListIns = upload.render({
					elem: '#attachments',
		       		url: '<c:url value="/newuploadfile1.do"/>',
					accept: 'file',
					multiple: true,
					auto: false,
					bindAction: '#attachmentsAction',
					choose: function(obj) {
						var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
						//读取本地文件
						obj.preview(function(index, file, result) {
							var tr = $(['<tr id="attachments-upload-' + index + '">', '<td>' + file.name +
								'</td>',
								'<td>其它附件</td>',
								'<td>等待上传</td>', '<td>',
								'<button class="layui-btn layui-btn-sm attachments-reload layui-hide">重传</button>',
								'<button class="layui-btn layui-btn-sm layui-btn-danger attachments-delete">删除</button>',
								'</td>', '</tr>'
							].join(''));
		
							//单个重传
							tr.find('.attachments-reload').on('click', function() {
								obj.upload(index, file);
							});
		
							//删除
							tr.find('.attachments-delete').on('click', function() {
								delete files[index]; //删除对应的文件
								tr.remove();
								attachmentsChoose--;
								attachmentsUploadListIns.config.elem.next()[0].value =
								''; //清空 input file 值，以免删除后出现同名文件不可选
							});
							
							attachmentsChoose++;
							attachmentsListView.append(tr);
						});
					},
					done: function(res, index, upload) {
						if (res.success>0) { //上传成功
							var tr = attachmentsListView.find('tr#attachments-upload-' + index),
								tds = tr.children();
							tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
							tds.eq(3).html(''); //清空操作
							if(attachments!="")attachments+=",";
							attachments+=res.success;
							attachmentsChoose--;
							return delete this.files[index]; //删除文件队列已经上传成功的文件
						}
						this.error(index, upload);
					},
					allDone: function(obj){ //当文件全部被提交后，才触发
					    attachmentsBool=true;
					},
					error: function(index, upload) {
						var tr = attachmentsListView.find('tr#attachments-upload-' + index),
							tds = tr.children();
						tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
						tds.eq(3).find('.attachments-reload').removeClass('layui-hide'); //显示重传
					}
				});
		  
		  var filesView=$("#upload-filesList"),
		  	  admonishfileView=[],attachmentsView=[],
		  	  admonishfileItem="${wenVisit.admonishfile}",attachmentsItem="${wenVisit.attachments}",
		  	  admonishfilename="${wenVisit.admonishfilename}",attachmentsname="${wenVisit.attachmentsname}";
		  if(admonishfileItem!=""){
		  		admonishfileView=admonishfileItem.split(",");
				if(admonishfileView.length>0){
					var viewname=admonishfilename.split(",");
					$.each(admonishfileView,function(index,item){
						var tr = $(['<tr>', '<td>' + viewname[index] +
							'</td>',
							'<td>训诫书、羁押或交接手续单据</td>',
							'<td>上传完成</td>', '<td>',
							'<button class="layui-btn layui-btn-sm admonishfile-download" onclick="return false;">下载</button>',
							'<button class="layui-btn layui-btn-sm layui-btn-danger admonishfile-delete">删除</button>',
							'</td>', '</tr>'
						].join(''));
						//删除
						tr.find('.admonishfile-delete').on('click', function() {
						    top.layer.confirm('确定删除此训诫书、羁押或交接手续单据？', function(firm){
								top.layer.close(firm);
								delete admonishfileView[index]; //删除对应的文件
								tr.remove();
							});
						});
						tr.find('.admonishfile-download').on('click', function() {
			          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
						});
						
						filesView.append(tr);
					});
				}
		  }
		  if(attachmentsItem!=""){
		  		attachmentsView=attachmentsItem.split(",");
				if(attachmentsView.length>0){
					var viewname=attachmentsname.split(",");
					$.each(attachmentsView,function(index,item){
						var tr = $(['<tr>', '<td>' + viewname[index] +
							'</td>',
							'<td>其它附件</td>',
							'<td>上传完成</td>', '<td>',
							'<button class="layui-btn layui-btn-sm attachments-download" onclick="return false;">下载</button>',
							'<button class="layui-btn layui-btn-sm layui-btn-danger attachments-delete">删除</button>',
							'</td>', '</tr>'
						].join(''));
						//删除
						tr.find('.attachments-delete').on('click', function() {
						    top.layer.confirm('确定删除此其它附件？', function(firm){
								top.layer.close(firm);
								delete attachmentsView[index]; //删除对应的文件
								tr.remove();
							});
						});
						tr.find('.attachments-download').on('click', function() {
			          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
						});
						
						filesView.append(tr);
					});
				}
		  }
		  
		  form.render();
		  //$("#nodename").next().find("input").css("background","#efefef");
		  $("#sensitivenode").next().find("dl").find("dd[lay-value='"+"${wenVisit.sensitivenode}"+"']").click();
		  $("#nodename").next().find("dl").find("dd[lay-value='"+"${wenVisit.nodename}"+"']").click();
		  $("#activitytype").next().find("dl").find("dd[lay-value='"+"${wenVisit.activitytype}"+"']").click();
		  $("#activitydirection").next().find("dl").find("dd[lay-value='"+"${wenVisit.activitydirection}"+"']").click();
		  $("#relatedplace").next().find("dl").find("dd[lay-value='"+"${wenVisit.relatedplace}"+"']").click();
		  $("#activityform").next().find("dl").find("dd[lay-value='"+"${wenVisit.activityform}"+"']").click();
		  $("#activitything").next().find("dl").find("dd[lay-value='"+"${wenVisit.activitything}"+"']").click();
		  $("#staytype").next().find("dl").find("dd[lay-value='"+"${wenVisit.staytype}"+"']").click();
		  $("#returntype").next().find("dl").find("dd[lay-value='"+"${wenVisit.returntype}"+"']").click();
		  
		  form.on('submit(visitSub)', function(data){
	         if(admonishfileChoose>0)$('#admonishfileAction').click();
			 else admonishfileBool=true;
			
			 if(attachmentsChoose>0)$('#attachmentsAction').click();
			 else attachmentsBool=true;
	         
	         var clearVisit=setInterval(function(){
	         	if(admonishfileBool&&attachmentsBool){
					var admonishfileupdate=(admonishfileView.length>0?(bouncer(admonishfileView).join(',')+(admonishfile!=""?",":"")):"")+admonishfile;
					var attachmentsupdate=(attachmentsView.length>0?(bouncer(attachmentsView).join(',')+(attachments!=""?",":"")):"")+attachments;
			         $("#form1").ajaxSubmit({
			              	url:		'<c:url value="/updateWenVisit.do"/>',
			              	data:		{
			              					admonishfile:admonishfileupdate,
			              					attachments:attachmentsupdate
			              				},
			              	dataType:	'json',
			              	async:  	false,
			              	success:	function(data) {
			              		clearInterval(clearVisit);
			                  	var obj = eval('(' + data + ')');
			                  	if(obj.flag>0){
		                  			//弹出loading
			 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			                     	setTimeout(function(){         
			                     		top.layer.msg(obj.msg);
			                     		top.layer.close(index);
						        		layer.closeAll("iframe");
				 		        		//刷新父页面
				 		         		parent.searchWenVisit();
				 		         		parent.layer.closeAll("iframe");
			                   		},2000);
			                 	}else{
			                  	 	top.layer.msg(obj.msg);
			                	}
			             	},
			              	error:function() {
			                  	top.layer.alert("请求失败！");
			              	}
			          	});
		         	}
		         },200);
	         
	           	return false;
			 });
			 
			 $("#connect").click(function(){
			 	var personnelid=$("#personnelid").val();
			 	var jointcontrolid=$("#jointcontrolid").val();
				var index = layui.layer.open({
					title : "联控关联",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/jsp/personel/wen/visit/connect.jsp?personnelid='+personnelid+'&jointcontrolid='+jointcontrolid+'&wenvisitid='+${wenVisit.id},
					area: ['700', '650px'],
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
			 });
		});
		
		function bouncer(array){
          		return array.filter(function(val){
          			return !(!val||val=="");
          		})
          }
	</script>
  </body>
</html>
