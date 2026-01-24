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
    
    <title>详情页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body style="background-color:#FFFFFF;">
  <div class="showinfo">
	<table width="100%" border="1" cellspacing="0" cellpadding="0">
		<tr height="40" bgcolor="#3598DC">
    		<td colspan="4"><span class="showinfo_title">矛盾风险信息详情</span></td>
  		</tr>
		<tr>
	    	<td width="15%">风险名称</td>
	    	<td width="35%">${contradictionInfo.cdtname }</td>
	    	<td width="15%">风险等级</td>
	    	<td width="35%">${contradictionInfo.cdtlevel }</td>
	    </tr>
	    <tr>
	    	<td width="15%">风险类别</td>
	    	<td width="35%">${contradictionInfo.typename }</td>
	    	<td width="15%">处置结果</td>
	    	<td width="35%">${contradictionInfo.cdtresult }</td>
	    </tr>
	    <tr>
			<td width="15%">事发地址</td>
			<td width="80%" colspan="3">${contradictionInfo.sfdz }</td>
		</tr>
	    <tr>
			<td width="15%">事发地址经度</td>
			<td width="35%">${contradictionInfo.sfdzx }</td>
			<td width="15%">事发地址纬度</td>
			<td width="35%">${contradictionInfo.sfdzy }</td>
	    </tr>
	    <tr>
			<td width="15%">涉事人数</td>
			<td width="35%">${contradictionInfo.ssrs }</td>
			<td width="15%">涉及金额</td>
			<td width="35%">${contradictionInfo.sjje }</td>
	    </tr>
	    <tr>
			<td width="15%">风险矛盾概况</td>
			<td width="80%" colspan="3">${contradictionInfo.cdtcontent }</td>
	    </tr>
	    <tr>
			<td width="15%">具体诉求</td>
			<td width="80%" colspan="3">${contradictionInfo.jtsq }</td>
	    </tr>
	    <tr>
			<td width="15%">主办部门</td>
			<td width="35%">${contradictionInfo.sponsorname }</td>
			<td width="15%">协办部门</td>
			<td width="35%">${contradictionInfo.assistdeptname }</td>
	    </tr>
	    <tr>
			<td width="15%">涉事单位信息</td>
			<td width="80%" colspan="3">${contradictionInfo.ssdwxx }</td>
	    </tr>
	    <tr>
			<td width="15%">属地派出所领导信息</td>
			<td width="80%" colspan="3">${contradictionInfo.sdpcsldxx }</td>
	    </tr>
	    <tr>
			<td width="15%">属地派出所社区民警信息</td>
			<td width="80%" colspan="3">${contradictionInfo.sdpcsmjxx }</td>
	    </tr>
	    <tr>
			<td width="15%">政府牵头处置部门</td>
			<td width="80%" colspan="3">${contradictionInfo.zfqtmbxx }</td>
	    </tr>
	    <tr>
			<td width="15%">会引发的后果</td>
			<td width="80%" colspan="3"><div id="yfhgcheck"></div></td>
	    </tr>
	    <tr>
			<td width="15%">是否建群</td>
			<td width="35%"><c:if test="${contradictionInfo.isjq eq '0'}">否</c:if><c:if test="${contradictionInfo.isjq eq '1'}">是</c:if></td>
			<td colspan="2">${contradictionInfo.qxx }</td>
	    </tr>
	    <tr>
			<td width="15%">是否物建信息员</td>
			<td width="35%"><c:if test="${contradictionInfo.iswjxxy eq '0'}">否</c:if><c:if test="${contradictionInfo.iswjxxy eq '1'}">是</c:if></td>
			<td colspan="2">${contradictionInfo.xxyxx }</td>
	    </tr>
	    <tr>
			<td width="15%">备注信息</td>
			<td width="80%" colspan="3">${contradictionInfo.memo }</td>
	    </tr>
	</table>
  </div>
	<script type="text/javascript">
		//初始化会引发的后果
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=94',
				dataType:	'json',
				success:	function(data){
					var yfhg = "${contradictionInfo.yfhg}";
           			$.each(data, function(num, item) {
           				if(yfhg.indexOf(item.name)>-1){
           					$('#yfhgcheck').append('<input type="checkbox" value="'+item.name+'" onclick="return false;" checked/>'+item.name);
           				}else{
           					$('#yfhgcheck').append('<input type="checkbox" value="'+item.name+'" onclick="return false;"/>'+item.name);
           				}
          			});
				}
			});
	</script>
  </body>
</html>
