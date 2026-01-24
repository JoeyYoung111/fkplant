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
   	<body style="background-color:#FFFFFF;">
  	<div class="showinfo">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
	  		<tr height="40" bgcolor="#3598DC">
	    		<td colspan="4"><span class="showinfo_title">涉诉涉访经历</span></td>
	  		</tr>
			<tr>
				<td width="15%">
					<strong>活动开始日期:</strong>
				</td>
				<td width="35%">
					${wenVisit.startdate}
				</td>
				<td width="15%">
					<strong>活动结束日期:</strong>
				</td>
				<td width="35%">
					${wenVisit.enddate}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>是否敏感节点:</strong>
				</td>
				<c:if test="${wenVisit.sensitivenode eq 0}"><td width="85%" colspan=3>否</td></c:if>
				<c:if test="${wenVisit.sensitivenode eq 1}">
					<td width="35%">是</td>
					<td width="15%">
						<strong>敏感节点名称:</strong>
					</td>
					<td width="35%">
						${wenVisit.nodename}
						<c:if test="${wenVisit.nodename eq '重大赛事'||wenVisit.nodename eq '重要活动'||wenVisit.nodename eq '其它'}">&nbsp;&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.nodememo}&nbsp;)</c:if>
					</td>
				</c:if>
			</tr>
			<tr>
				<td width="15%">
					<strong>当次行为活动类别:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.activitytype}
					<c:if test="${wenVisit.activitytype eq '其它'}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.activitymemo}&nbsp;)</c:if>
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动方向:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.activitydirection}
					<c:if test="${wenVisit.activitydirection eq '其它'}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.directionmemo}&nbsp;)</c:if>
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动涉及场所:</strong>
				</td>
				<td width="35%">
					${wenVisit.relatedplace}
					<c:if test="${wenVisit.relatedplace eq '其它'}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.placememo}&nbsp;)</c:if>
				</td>
				<td width="15%">
					<strong>单位场所性质:</strong>
				</td>
				<td width="35%">
					${wenVisit.placecharacter}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动具体形式:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.activityform}
					<c:if test="${wenVisit.activityform eq '其它表示方式'||wenVisit.activityform eq '其它扰乱秩序行为'}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.formmemo}&nbsp;)</c:if>
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动携带物品:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.activitything}
					<c:if test="${wenVisit.activitything eq '其它涉访物品'}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.thingmemo}&nbsp;)</c:if>
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动具体经过:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.activityprocess}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动涉及单位登记受理情况:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.acceptance}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动前往方式:</strong>
				</td>
				<td width="35%">
					${wenVisit.traffictype}
				</td>
				<td width="15%">
					<strong>前往活动同行人员:</strong>
				</td>
				<td width="35%">
					${wenVisit.togetherperson}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为活动落脚方式:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.staytype}
					<c:if test="${wenVisit.staytype ne '旅馆住宿'}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.staymemo}&nbsp;)</c:if>
				</td>
			</tr>
			<c:if test="${wenVisit.staytype eq '旅馆住宿'}">
				<tr>
					<td width="15%">
						<strong>入住时间:</strong>
					</td>
					<td width="35%">
						${wenVisit.hotelintime}
					</td>
					<td width="15%">
						<strong>退房时间:</strong>
					</td>
					<td width="35%">
						${wenVisit.hotelouttime}
					</td>
				</tr>
				<tr>
					<td width="15%">
						<strong>旅馆名称:</strong>
					</td>
					<td width="35%">
						${wenVisit.hotelname}
					</td>
					<td width="15%">
						<strong>入住房号:</strong>
					</td>
					<td width="35%">
						${wenVisit.hotelroom}
					</td>
				</tr>
				<tr>
					<td width="15%">
						<strong>旅馆编码:</strong>
					</td>
					<td width="35%">
						${wenVisit.hotelcode}
					</td>
					<td width="15%">
						<strong>旅馆地址:</strong>
					</td>
					<td width="35%">
						${wenVisit.hoteladdress}
					</td>
				</tr>
			</c:if>
			<tr>
				<td width="15%">
					<strong>行为活动现场发现单位:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.findunit}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>现场处置结果情况:</strong>
				</td>
				<td width="35%">
					${wenVisit.handleresult}
				</td>
				<td width="15%">
					<strong>训诫书、羁押或交接手续单据:</strong>
				</td>
				<td width="35%" id="admonishfile">
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>行为人员返回方式:</strong>
				</td>
				<td width="35%">
					${wenVisit.returntype}
				</td>
				<td width="15%">
					<strong>行为人员返回使用交通工具:</strong>
				</td>
				<td width="35%">
					${wenVisit.returnvehicle}
					<c:if test="${!empty wenVisit.vehiclememo}">&nbsp;&nbsp;(&nbsp;备注说明：&nbsp;${wenVisit.vehiclememo}&nbsp;)</c:if>
				</td>
			</tr>
			<c:if test="${wenVisit.returntype ne '自行返回'}">
				<tr>
					<td width="15%">
						<strong>接回力量单位:</strong>
					</td>
					<td width="35%">
						${wenVisit.powerunit}
					</td>
					<td width="15%">
						<strong>人员情况:</strong>
					</td>
					<td width="35%">
						${wenVisit.personstate}
					</td>
				</tr>
			</c:if>
			<tr>
				<td width="15%">
					<strong>人员回澄采集情况:</strong>
				</td>
				<td width="35%">
					${wenVisit.returncollect}
				</td>
				<td width="15%">
					<strong>人员回澄处罚结果:</strong>
				</td>
				<td width="35%">
					${wenVisit.returnpunish}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>具体处罚内容:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.punishcontent}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>登记受理单位答复情况:</strong>
				</td>
				<td width="85%" colspan=3>
					${wenVisit.unitreply}
				</td>
			</tr>
			<tr>
				<td width="15%">
					<strong>附件:</strong>
				</td>
				<td width="85%" colspan=3 id="attachments">
				</td>
			</tr>
		</table>  
    </div>   
    <script type="text/javascript">
    	$(document).ready(function(){
    		admonishfileList();
    		attachmentsList();
		});
		
		function admonishfileList(){
			var filesView=$("#admonishfile"),
				admonishfileItem="${wenVisit.admonishfile}",
				admonishfilename="${wenVisit.admonishfilename}";
			if(admonishfileItem!=""){
		  		admonishfileView=admonishfileItem.split(",");
				if(admonishfileView.length>0){
					var viewname=admonishfilename.split(",");
					$.each(admonishfileView,function(index,item){
						var tr ="";
						if(index>0)tr+="&nbsp;&nbsp;&nbsp;";
						tr +='<a href="<c:url value='/downUpfile.do'/>?fileid='
								+item+'"  style="text-decoration:underline;color:blue;">'+viewname[index]+'</a>';
						filesView.append(tr);
					});
				}
		  }
		}
		function attachmentsList(){
			var filesView=$("#attachments"),
				attachmentsItem="${wenVisit.attachments}",
				attachmentsname="${wenVisit.attachmentsname}";
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
