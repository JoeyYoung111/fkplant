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
    
    <title>反馈</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value='/js/check.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;overflow:auto">
  		<legend>关联近期动态</legend>
	</fieldset>
	<div style="text-align: center;">
		<button type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="toPage('wkhj');" id="wkhjbutton">稳控化解情况(${workInfo.defuseInfocount })</button>
		<button type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="toPage('swsj');" id="swsjbutton">引发涉稳事件(${workInfo.eventsInfocount })</button>
		<button type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="toPage('qbxs');" id="qbxsbutton">情报线索信息(${workInfo.leadsInfocount })</button>
		<button type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="toPage('zzry');" id="zzrybutton">主要组织人员(${workInfo.keypersonnelcount })</button>
	</div>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;overflow:auto">
  		<legend>反馈描述</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${menuid }>
		<input type="hidden"  name="id" id="id" value=${workInfo.id }>
		<div class="layui-form-item">
			<label class="layui-form-label">化解状态</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<select id="hjzt"  name="hjzt">
			 		<option value="">--请选择--</option>
			 		<option value="不稳定" <c:if test="${workInfo.hjzt eq '不稳定'}"> selected</c:if>>不稳定</option>
			 		<option value="稳定" <c:if test="${workInfo.hjzt eq '稳定'}"> selected</c:if>>稳定</option>
			 		<option value="缓解" <c:if test="${workInfo.hjzt eq '缓解'}"> selected</c:if>>缓解</option>
			 		<option value="化解" <c:if test="${workInfo.hjzt eq '化解'}"> selected</c:if>>化解</option>
			 	</select>
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">反馈内容</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="fkcontent">${workInfo.fkcontent }</textarea>
		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">附件上传</label>
		    <div class="layui-input-block" style="width:50%">
		    	<button type="button" class="layui-btn" id="files">选择多文件</button>
		    	<button type="button" style="display:none" id="upload_files">文件上传</button>
		    	<div class="layui-upload-list">
		    		<table class="layui-table">
		    			<thead><tr>
		    				<th>文件名</th>
		    				<th>状态</th>
		    				<th>操作</th>
		    			</tr></thead>
		    			<tbody id="filelist">
		    				<c:if test="${not empty workInfo.filenames}">
			    				<c:set value="${fn:split(workInfo.filenames,',') }" var="filenames"></c:set>
			    				<c:set value="${fn:split(workInfo.fileids,',') }" var="fileids"></c:set>
			    				<c:forEach items="${filenames}" var="filename" varStatus="num">
				    				<tr id="upload">
				    					<td id="showfiles"><a href="<c:url value='/downUpfile.do' />?fileid=${fileids[num.index] }" class="layui-table-link">${filename }</a></td>
				    					<td>上传完成</td>
				    					<td>
				    						<button class="layui-btn layui-btn-xs layui-btn-danger demo-deletes" type="button" onclick="cancelfiles(${fileids[num.index] },this);">删除</button>
				    					</td>
				    				</tr>
				    			</c:forEach>
			    			</c:if>
		    			</tbody>
		    		</table>
		    	</div>
		    </div>
		    <input type="hidden" name="fkattachments" id="fkattachments" class="layui-input" value="${workInfo.fkattachments }"/>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		var fileidstr = "${workInfo.fkattachments }";
		var delidstr = "";
		var layer;
		layui.use(['form','upload'], function(){
			var form = layui.form,
			upload = layui.upload,
			layer = layui.layer;
			
			var choose_files = 0;
  
			//文件上传
			var listview = $("#filelist");
			var uploadListIns = upload.render({
				elem: '#files', //绑定元素,
				url: '<c:url value="/newuploadfile1.do"/>', //上传接口
				accept:'file',
				multiple: true,
				auto: false,
				bindAction:'#upload_files',
				choose: function(obj){
			  		var files = this.files = obj.pushFile();
			  		choose_files++;
			  		obj.preview(function(index,file,result){
				  		var tr = $(['<tr id="upload-'+index+'">'
				  					,'<td>'+file.name+'</td>'
				  					,'<td>等待上传</td>'
				  					,'<td>'
				  						,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
				  					,'</td>'
				  					,'</tr>'].join(''));
				  					
				  		tr.find('.demo-delete').on('click',function(){
				  			delete files[index];
				  			choose_files--;
				  			tr.remove();
				  			uploadListIns.config.elem.next()[0].value = '';//清空input file值，以免后序同名文件不可选
				  		});
				  		listview.append(tr);
			  		});
			  }
			  ,done: function(res){
			    var recordingFileid = res.success;
			    if(fileidstr==""){
			    	fileidstr += recordingFileid;
			    }else{
			    	fileidstr += "," + recordingFileid;
			    }
			    console.log("文件上传成功");
			  }
			  ,allDone: function(obj){
			 		$("#fkattachments").val(fileidstr);
			 		add();
			  }
			  ,error: function(){
			    var tr = listview.find('tr#upload-'+index),
			    tds = tr.children();
			    tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
			    tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
			   
			  }
			});
			
			form.on('submit(msgSub)', function(data){
				var index1 = top.layer.msg('信息上传中，请稍后',{icon:16,time:false,shade:0.8});
				if(choose_files < 1){
					$("#fkattachments").val(fileidstr);
					add();
				}else{
					$("#upload_files").click();
				}
				setTimeout(function(){
					top.layer.close(index1);
				},800);	
			    $("#fkattachments").val("0");
			    return false;
			});
		});
		
		function cancelfiles(id,obj){
			var fileids = fileidstr.split(",");
			delidstr += id + ",";
			var newfileids = "";
			for(var i=0;i<fileids.length;i++){
				if(fileids[i]!=id){
					newfileids += fileids[i]+",";
				}
			}
			fileidstr = newfileids.substring(0,newfileids.length-1);
			var dom = obj.parentNode.parentNode;
			dom.remove();
		}
		
		function add(){
			if(delidstr!=""){
				$.ajax({
					type: 'POST',
					url: '<c:url value="/deletefilesbyidstr.do" />',
					data: { deleteidstr: delidstr ,type: 'files'},
					dataType: 'json',
					async:  true,
					success: function(data){
					}
				});
			}
		
			$("#form1").ajaxSubmit({
              	url:		'<c:url value="/feedbackWorkInfo.do"/>',
              	dataType:	'json',
              	async:  	false,
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
	 		        if("${page}"=="feedback"){
	 		        	if(${workInfo.wtype }==1){
		 		        	parent.formSubmit('tsd','<c:url value="searchWorkInfo.do"/>');
		 		        }else if(${workInfo.wtype }==2){
		 		        	parent.formSubmit('jbd','<c:url value="searchWorkInfo.do"/>?wtype=${workInfo.wtype }');
		 		        }else if(${workInfo.wtype }==3){
		 		        	parent.formSubmit('dbd','<c:url value="searchWorkInfo.do"/>?wtype=${workInfo.wtype }');
		 		        }else{
		 		        	parent.formSubmit('jyh','<c:url value="searchWorkInfo.do"/>?wtype=${workInfo.wtype }');
		 		        }
	 		        }else{
	 		        	parent.layui.table.reload('followTable', {});
	 		        }
	 		        parent.layer.closeAll("iframe");
                   },500);
                 }else{
                  	 layer.msg(obj.msg);
                }
             },
              	error:function() {
                  	alert("请求失败！");
              	}
          	});
  		}
  		
  		function toPage(page){
  			if(page=='wkhj'){
  				var index = layui.layer.open({
					title : "关联稳控化解情况",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/event/contradictionInfo/workInfo/link/wkhjlist.jsp"/>?menuid=${menuid }&cdtid=${workInfo.cdtid}&workinfoid=${workInfo.id}&page=${page }',
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
  			}else if(page=='swsj'){
  				var index = layui.layer.open({
					title : "关联引发涉稳事件",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/event/contradictionInfo/workInfo/link/swsjlist.jsp"/>?menuid=${menuid }&cdtid=${workInfo.cdtid}&workinfoid=${workInfo.id}&page=${page }&fxdj=${workInfo.cdtlevel}',
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
  			}else if(page=='qbxs'){
  				var index = layui.layer.open({
					title : "关联情报线索信息",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/event/contradictionInfo/workInfo/link/qbxslist.jsp"/>?menuid=${menuid }&cdtid=${workInfo.cdtid}&workinfoid=${workInfo.id}&page=${page }&fxdj=${workInfo.cdtlevel}',
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					},cancel: function(){
						$.ajax({
							type: 'POST',
							url: '<c:url value="/countEventByWorkinfoid.do" />',
							data: { workinfoid: $("#id").val()},
							dataType: 'json',
							async:  true,
							success: function(data){
								$('#swsjbutton').text("引发涉稳事件("+data.count+")");
							}
						});
					}
				});			
				layui.layer.full(index);
  			}else{
  				var index = layui.layer.open({
					title : "关联主要组织人员",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/event/contradictionInfo/workInfo/link/zzrylist.jsp"/>?menuid=${menuid }&cdtid=${workInfo.cdtid}&workinfoid=${workInfo.id}&page=${page }&cdtcontent=${workInfo.cdtcontent }',
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
  			}
  		}
	</script>
  </body>
</html>
