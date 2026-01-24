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
    
    <title>详情页面</title>
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
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
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue">基本信息：</label>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">风险名称</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.cdtname }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">风险等级</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.cdtlevel }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">风险类别</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.typename }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">处置结果</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.cdtresult }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">事发地址</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sfdz }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">事发地址经度</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sfdzx }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">事发地址纬度</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sfdzy }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉事人数</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.ssrs }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md5">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉及金额</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sjje }' class="layui-input"  readonly="readonly">
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
							<label class="layui-form-label">风险矛盾概况</label>
							<div class="layui-input-block">
								<textarea class="layui-textarea" readonly="readonly">${contradictionInfo.cdtcontent }</textarea>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">具体诉求</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.jtsq }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">主办部门</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sponsorname }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">协办部门</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.assistdeptname }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉事单位信息</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.ssdwxx }' class="layui-input" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">属地派出所领导信息</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sdpcsldxx }' class="layui-input" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">属地派出所社区民警信息</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.sdpcsmjxx }' class="layui-input" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">政府牵头处置部门</label>
							<div class="layui-input-block">
								<input type="text" value='${contradictionInfo.zfqtmbxx }' class="layui-input" readonly="readonly"/>
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
								<input type="text" value='<c:if test="${contradictionInfo.isjq eq 1}">是</c:if><c:if test="${contradictionInfo.isjq eq 0}">否</c:if>' class="layui-input"  readonly="readonly">
					    	</div>
							<div class="layui-input-inline" style="width:55%;">
								<input type="text" value='${contradictionInfo.qxx }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">是否物建信息员</label>
							<div class="layui-input-inline" style="width:25%;">
								<input type="text" value='<c:if test="${contradictionInfo.iswjxxy eq 1}">是</c:if><c:if test="${contradictionInfo.iswjxxy eq 0}">否</c:if>' class="layui-input"  readonly="readonly">
					    	</div>
							<div class="layui-input-inline" style="width:55%;">
								<input type="text" value='${contradictionInfo.xxyxx }' class="layui-input"  readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">备注信息</label>
							<div class="layui-input-block">
								<textarea class="layui-textarea" readonly="readonly">${contradictionInfo.memo }</textarea>
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
							<table class="layui-hide" id="swsj" lay-filter="swsj"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="qbxs" lay-filter="qbxs"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="zzry" lay-filter="zzry"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="wkhj" lay-filter="wkhj"></table>
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
		<script type="text/html" id="barButton">
           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
		</script>
		<script>
			layui.use(['table','form','element'], function() {
				table = layui.table;
				var form = layui.form,
				layer = layui.layer,
				element = layui.element;
				
				//初始化会引发的后果
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=94',
					dataType:	'json',
					success:	function(data){
						var yfhg = "${contradictionInfo.yfhg}";
	           			$.each(data, function(num, item) {
	           				if(yfhg.indexOf(item.name)>-1){
           						$('#yfhgcheck').append('<input type="checkbox" lay-skin="primary" value="'+item.name+'"title="'+item.name+'" disabled="disabled" checked/>');
	           				}else{
	           					$('#yfhgcheck').append('<input type="checkbox" lay-skin="primary" value="'+item.name+'" title="'+item.name+'" disabled="disabled"/>');
	           				}
	          			});
	      				form.render();
					}
				});
				
				//初始化引发涉稳事件
				table.render({
					elem: '#swsj',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchEventsInfo.do"/>',
				    where:{cdtid:${contradictionInfo.id}},
				    method:'post',
				    cols: [[
				    	{field:'fssj', title: '发生时间', width:200,align:"center"},
				    	{field:'etitle', title: '事件标题', width:200,align:"center",templet: function(d){
				    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoEventsInfo.do&quot;,&quot;引发涉稳事件&quot;,"+d.id+");return false;'>"+d.etitle+"</a>";
				    	}},
				    	{field:'sfbwd', title: '事发部位',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化情报线索信息
				table.render({
					elem: '#qbxs',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    cols: [[
				    	{field:'ldate', title: '预计发生时间', width:200,align:"center"},
				    	{field:'ltitle', title: '线索标题', width:200,align:"center",templet: function(d){
				    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;showInfoLeadsInfo.do&quot;,&quot;情报线索信息&quot;,"+d.id+");return false;'>"+d.ltitle+"</a>";
				    	}},
				    	{field:'lpointto', title: '线索指向', width:200,align:"center"},
				    	{field:'xscz', title: '线索处置',align:"center"}
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
				
				//初始化稳控化解情况
				table.render({
					elem: '#wkhj',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    cols: [[
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
				
				//初始化工作提示单
				table.render({
					elem: '#tsd',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchWorkInfo.do"/>',
				    where:{cdtid:${contradictionInfo.id},wtype:1},
				    method:'post',
				    cols: [[
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return d.wtitle;
				    		}else{
				    			return d.wtitle+'-'+d.code;
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
				    	{field:'fkcontent', title: '反馈内容',align:"center"},
    					{field:'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	if(res.workInfoList[0]!=null){
	          					obj[0].innerHTML="工作提示单（"+res.workInfoList[0].nums+"）";
	          				}
	          				if(res.workInfoList[1]!=null){
	          					obj[1].innerHTML="工作交办单（"+res.workInfoList[1].nums+"）";
	          				}
	          				if(res.workInfoList[2]!=null){
	          					obj[2].innerHTML="工作督办单（"+res.workInfoList[2].nums+"）";
	          				}
	          				if(res.workInfoList[3]!=null){
	          					obj[3].innerHTML="责任追究建议函（"+res.workInfoList[3].nums+"）";
	          				}
					    }
					}
				});
				
				//初始化工作交办单
				table.render({
					elem: '#jbd',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    cols: [[
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return d.wtitle;
				    		}else{
				    			return d.wtitle+'-'+d.code;
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
				    	{field:'fkcontent', title: '反馈内容',align:"center"},
    					{field:'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	if(res.workInfoList[0]!=null){
	          					obj[0].innerHTML="工作提示单（"+res.workInfoList[0].nums+"）";
	          				}
	          				if(res.workInfoList[1]!=null){
	          					obj[1].innerHTML="工作交办单（"+res.workInfoList[1].nums+"）";
	          				}
	          				if(res.workInfoList[2]!=null){
	          					obj[2].innerHTML="工作督办单（"+res.workInfoList[2].nums+"）";
	          				}
	          				if(res.workInfoList[3]!=null){
	          					obj[3].innerHTML="责任追究建议函（"+res.workInfoList[3].nums+"）";
	          				}
					    }
					}
				});
				
				//初始化工作督办单
				table.render({
					elem: '#dbd',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return d.wtitle;
				    		}else{
				    			return d.wtitle+'-'+d.code;
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
				    	{field:'fkcontent', title: '反馈内容',align:"center"},
    					{field:'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	if(res.workInfoList[0]!=null){
	          					obj[0].innerHTML="工作提示单（"+res.workInfoList[0].nums+"）";
	          				}
	          				if(res.workInfoList[1]!=null){
	          					obj[1].innerHTML="工作交办单（"+res.workInfoList[1].nums+"）";
	          				}
	          				if(res.workInfoList[2]!=null){
	          					obj[2].innerHTML="工作督办单（"+res.workInfoList[2].nums+"）";
	          				}
	          				if(res.workInfoList[3]!=null){
	          					obj[3].innerHTML="责任追究建议函（"+res.workInfoList[3].nums+"）";
	          				}
					    }
					}
				});
				
				//初始化责任追究建议函
				table.render({
					elem: '#jyh',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
				    	{field:'wtitle', title: '标题-编号', width:100,align:"center",templet: function(d){
				    		if(d.code==null){
				    			return d.wtitle;
				    		}else{
				    			return d.wtitle+'-'+d.code;
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
				    	{field:'fkcontent', title: '反馈内容',align:"center"},
    					{field:'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
				    ]],
				    page: true,
				    limit: 10,
				    done: function(res, curr, count){
					    if(res.code==0){
					    	var obj = document.getElementById("gzjbTab").getElementsByTagName("li");
					    	if(res.workInfoList[0]!=null){
	          					obj[0].innerHTML="工作提示单（"+res.workInfoList[0].nums+"）";
	          				}
	          				if(res.workInfoList[1]!=null){
	          					obj[1].innerHTML="工作交办单（"+res.workInfoList[1].nums+"）";
	          				}
	          				if(res.workInfoList[2]!=null){
	          					obj[2].innerHTML="工作督办单（"+res.workInfoList[2].nums+"）";
	          				}
	          				if(res.workInfoList[3]!=null){
	          					obj[3].innerHTML="责任追究建议函（"+res.workInfoList[3].nums+"）";
	          				}
					    }
					}
				});
				
				//领导批示
				table.render({
					elem: '#ldps',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchHandleInfo.do"/>',
				    where:{cdtid:${contradictionInfo.id},htype:1},
				    method:'post',
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
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
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
<%--				    toolbar: false,--%>
<%--				    defaultToolbar: ['filter', 'exports', 'print'],--%>
<%--				    method:'post',--%>
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
<%--				    	{field:'addtime', title: '录入时间', width:180,align:"center"} --%>
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
<%--				--%>
<%--				//涉稳风险交办处置建议--%>
<%--				table.render({--%>
<%--					elem: '#jbcz',--%>
<%--				    toolbar: false,--%>
<%--				    defaultToolbar: ['filter', 'exports', 'print'],--%>
<%--				    method:'post',--%>
<%--				    cols: [[--%>
<%--				    	{field:'id',type:'radio',fixed:'left'},--%>
<%--				    	{field:'hdate', title: '提交时间', width:130,align:"center"},--%>
<%--				    	{field:'htitle', title: '建议标题', width:200,align:"center"},--%>
<%--				    	{field:'hcontent', title: '建议内容',align:"center"},--%>
<%--				    	{field:'receiver', title: '接收人', width:100,align:"center"},--%>
<%--				    	{field:'hsituation', title: '办理情况', width:100,align:"center"},--%>
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
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
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
				
				element.on('tab(detailTabs)', function(data){
					switch(data.index){
						case 0:
							formSubmit('swsj','<c:url value="searchEventsInfo.do"/>');
						break;
						case 1:
							formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
						break;
						case 2:
							formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
						break;
						case 3:
							formSubmit('wkhj','<c:url value="searchDefuseInfo.do"/>');
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
				
				//工作提示单监听行工具事件
				workInfoListenTool("tsd","工作提示单","showWorkInfo.do");
				//工作交办单监听行工具事件
				workInfoListenTool("jbd","工作交办单","showWorkInfo.do");
				//工作督办单监听行工具事件
				workInfoListenTool("dbd","工作督办单","showWorkInfo.do");
				//责任追究建议函监听行工具事件
				workInfoListenTool("jyh","责任追究建议函","showWorkInfo.do");
				
				//工作提示单监听行工具事件
				function workInfoListenTool(toolname,title,url){
					table.on('tool('+toolname+')', function(obj){
						switch(obj.event){
							case 'showinfo':
								var id = obj.data.id;
								var index = layui.layer.open({
									title : title+"详情",
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content : '<c:url value="'+url+'"/>?id='+id+'&menuid='+${param.menuid },
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
						}
					});
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
		</script>
	</body>
</html>
