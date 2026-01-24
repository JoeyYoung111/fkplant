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
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
   <body style="background-color:#FFFFFF;">
  	<div class="showinfo" id="print">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
		  <tr height="40" bgcolor="#3598DC">
		    <td colspan="4"><span class="showinfo_title">联控记录</span></td>
		  </tr>
				<tr>
					<td width="25%">
						<strong>情报内容来源：</strong>
					</td>
					<td width="25%">
						${jointcontrolrecord.jointorigin}
					</td>
					<td>
						<strong>情报发生时间：</strong>
					</td>
					<td>
						${jointcontrolrecord.infodate}
					</td>
				</tr>
				<tr>
					<td>
						<strong>情报内容类别：</strong>
					</td>
					<td colspan="3">
						${jointcontrolrecord.infotype}(备注说明:${jointcontrolrecord.infomemo})
					</td>
					
				</tr>
				<tr>
					<td>
						<strong>情报内容：</strong>
					</td>
					<td colspan="3">
						${jointcontrolrecord.information}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>同行人身份证号：</strong>
					</td>
					<td>
						${jointcontrolrecord.cardnumber1}
					</td>
					<td width="25%">
						<strong>同行人姓名：</strong>
					</td>
					<td>
						${jointcontrolrecord.togethername1}
					</td>
				</tr>
				 <c:if test="${jointcontrolrecord.cardnumber2!=''}">
				 <tr>
					<td width="25%">
						<strong>同行人身份证号：</strong>
					</td>
					<td>
						${jointcontrolrecord.cardnumber2}
					</td>
					<td width="25%">
						<strong>同行人姓名：</strong>
					</td>
					<td>
						${jointcontrolrecord.togethername2}
					</td>
				</tr>
				 </c:if>
				<c:if test="${jointcontrolrecord.cardnumber3!=''}">
				 <tr>
					<td width="25%">
						<strong>同行人身份证号：</strong>
					</td>
					<td>
						${jointcontrolrecord.cardnumber3}
					</td>
					<td width="25%">
						<strong>同行人姓名：</strong>
					</td>
					<td>
						${jointcontrolrecord.togethername3}
					</td>
				</tr>
				 </c:if>
				 <c:if test="${jointcontrolrecord.cardnumber4!=''}">
				 <tr>
					<td width="25%">
						<strong>同行人身份证号：</strong>
					</td>
					<td>
						${jointcontrolrecord.cardnumber4}
					</td>
					<td width="25%">
						<strong>同行人姓名：</strong>
					</td>
					<td>
						${jointcontrolrecord.togethername4}
					</td>
				</tr>
				 </c:if>
				 <c:if test="${jointcontrolrecord.cardnumber5!=''}">
				 <tr>
					<td width="25%">
						<strong>同行人身份证号：</strong>
					</td>
					<td>
						${jointcontrolrecord.cardnumber5}
					</td>
					<td width="25%">
						<strong>同行人姓名：</strong>
					</td>
					<td>
						${jointcontrolrecord.togethername5}
					</td>
				</tr>
				 </c:if>
				
				<tr>
					<td width="25%">
						<strong>群类型：</strong>
					</td>
					<td>
						${jointcontrolrecord.grouptype}
					</td>
					<td width="25%">
						<strong>群名称：</strong>
					</td>
					<td>
						${jointcontrolrecord.groupname}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>群ID：</strong>
					</td>
					<td>
						${jointcontrolrecord.groupid}
					</td>
					<td width="25%">
						<strong>交通工具类型：</strong>
					</td>
					<td>
						${jointcontrolrecord.vehicletype}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>交通工具信息：</strong>
					</td>
					<td colspan="3">
						${jointcontrolrecord.vehicleinfo}
					</td>
					
				</tr>
				<tr>
					<td width="25%">
						<strong>附件:</strong>
					</td>
					<td colspan=3 id="attachments">
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>建档人:</strong>
					</td>
					<td>
						${jointcontrolrecord.addoperator}
					</td>
					<td width="25%">
						<strong>建档时间:</strong>
					</td>
					<td>
						${jointcontrolrecord.addtime}
					</td>
				</tr>
				<tr>
					<td width="25%">
						<strong>修改人:</strong>
					</td>
					<td>
						${jointcontrolrecord.updateoperator}
					</td>
					<td width="25%">
						<strong>修改时间:</strong>
					</td>
					<td>
						${jointcontrolrecord.updatetime}
					</td>
				</tr>
			</table>  
    </div>   
    <script type="text/javascript">
    	$(document).ready(function(){
    		attachmentsList();
		});
    	function attachmentsList(){
			var filesView=$("#attachments"),
				attachmentsItem="${jointcontrolrecord.attachments}",
				attachmentsname="${jointcontrolrecord.attachmentsname}";
			if(attachmentsItem!=""){
		  		attachmentsView=attachmentsItem.split(",");
				if(attachmentsView.length>0){
					var viewname=attachmentsname.split(",");
					$.each(attachmentsView,function(index,item){
						var tr ="";
						if(index>0)tr+="&nbsp;&nbsp;&nbsp;";
						tr +='<a href="<c:url value='/downUpfile.do'/>?fileid='
								+item+'"  style="text-decoration:underline;color:blue;">'+viewname[index]+'</a>';
						filesView.append(tr);
					});
				}
		  }
		}
     </script>
  </body>
</html>
