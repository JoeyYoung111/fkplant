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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   	<body style="background-color:#FFFFFF;">
  	<div class="showinfo">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0" id="yujingTable">
	  		<tr height="40" bgcolor="#3598DC">
	    		<td colspan="10"><span class="showinfo_title">预警信息详情</span></td>
	  		</tr>
		</table>  
		<div style="height:150px;"></div>
    </div>
    <script type="text/javascript">
    	var locat = (window.location+'').split('/'); 
    	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
    	layui.use(['table','form'], function(){
    		var result=JSON.parse('${yujing.result}');
    		var header=JSON.parse('${yujing.header}');
    		console.log(result);
    		console.log(header);
    		var htmlstr="";
    		var trindex=0;
    		$.each(result, function(i, item) {
    			if(trindex==0)htmlstr+='<tr>';
    			var title=header[i];
    			htmlstr+='<td width="20%" colspan="2"><strong>'+((title!=undefined&&title!=null&&title!="")?title:i)+'</strong></td>';
    			htmlstr+='<td width="30%" colspan="3">'+item+'</td>';
    			trindex++;
    			if(trindex==2){
    				htmlstr+='</tr>';
    				trindex=0;
    			}
    		});
    		$("#yujingTable").append(htmlstr);
    	});
    </script>   
  </body>
</html>
