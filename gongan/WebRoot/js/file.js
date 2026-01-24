var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
//新增页面 文件表单初始化样式
function initinputfile(type){
	$("#myFile").fileinput({
        language : 'zh',//设置语言
        uploadUrl : locat+"/newuploadfile.do?type="+type,
        uploadAsync:true, 
        showBrowse:true,
		showCaption: true, 
		showUpload: false,//是否显示上传按钮 
		showRemove: false,//是否显示删除按钮 
		showCaption: true,//是否显示输入框 
		showPreview:true, 
		showCancel:true, 		
		browseOnZoneClick:true,
		dropZoneEnabled: false, //是否显示拖拽区域
		//minImageWidth: 50, //图片的最小宽度
		//minImageHeight: 50,//图片的最小高度
		//maxImageWidth: 1000,//图片的最大宽度
		//maxImageHeight: 1000,//图片的最大高度
		//maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
		//minFileCount: 0,
		maxFileCount: 10, //表示允许同时上传的最大文件个数		
		initialPreviewShowDelete:true, 
		msgFilesTooMany: "选择上传的文件数量 超过允许的最大数值！", 
		overwriteInitial:false,
		previewFileIcon: '<i class="glyphicon glyphicon-file"></i>', 
		allowedFileExtensions : ['jpg','png'],	//接收文件后缀
		//allowedPreviewTypes : [ 'image'],//配置所有的被预览文件类型		
		preferIconicPreview:true,
		layoutTemplates:{
		actionUpload:'',
		
		},
    }).on("fileuploaded", function(e, data) {//文件上传成功后执行
    	var res = data.response;
        document.getElementById("fileidstr").value=document.getElementById("fileidstr").value+res.success+",";            
    });
}
//初始化时触发
$('#myFile').on('filereset', function(event) {

});

/*//上传时触发
$('#myFile').on('change', function(event,index) {
	alert(index);
	 console.log(event);
	document.getElementById("filestatus").value=Number(document.getElementById("filestatus").value)+1;
});*/
$('#myFile').on('fileloaded', function(event, file, previewId, index, reader) {
    console.log("fileloaded");
    document.getElementById("filestatus").value=document.getElementById("filestatus").value+previewId+",";
 
});

$('#myfile').on('change',function(event){
	document.getElementById('deleteidstr').value=document.getElementById('fileidstr').value;
});
//清空时执行		
$('#myFile').on('filecleared', function(event) {
		console.log("filecleared");
});
//已有图片删除前执行
$('#myFile').on('filepredelete', function(event, key, jqXHR, data) {	
	document.getElementById('deleteidstr').value=document.getElementById('deleteidstr').value+key+",";
	var fileidstr=document.getElementById('fileidstr').value;
	var aa=fileidstr.split(",");
	var bb="";
	for (var i=0;i<aa.length-1;i++){
	if(aa[i]!=key){
		bb=bb+aa[i]+',';
	}
	document.getElementById('fileidstr').value=bb;
	}



});

//未上传图片删除时执行
$('#myFile').on('filepreremove', function(event, id, index) {
	var fileidstr=document.getElementById('filestatus').value;
	
	var aa=fileidstr.split(",");
	var bb="";
	for (var i=0;i<aa.length-1;i++){
	if(aa[i]!=id){
		bb=bb+aa[i]+',';
	}
	document.getElementById('filestatus').value=bb;
	}

});
//新增  ajax提交
function addfile(addurl){
	 $('#defaultForm').ajaxSubmit({				
		url:	locat+addurl,
       	dataType:	'json',
       	success:	function(data) {
       		if (data.msg.flag > 0) {
        		toastr.success(data.msg.msg);
            } else {
            	toastr.success(data.msg.msg);  
        	}
       	},
       	error:function() {
           	alert("请求失败！");
       	}
	 });		
	 $("#myModal").modal('hide');   		
}
//删除文件，包括数据库数据和服务器文件
function deletefilemsg(deleteurl){
	 $.ajax({
         type:       "POST",
     	 url:	locat+deleteurl,
         dataType:   'json',
         success:    function(data) {
            
         },error:    function() {
            
         }
     });
}
//修改页面  file表中查询文件，文件表单初始化
function initupdateinput(url){
	$.ajax({ 
		type : "post", 
		url : locat+url, 
		dataType : "json", 
		success : function(data) { 
			console.info(data);
			showFiles(data);
		}, 
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
		} 
	});
}
function showFiles(djson){
		//后台返回json字符串转换为json对象 
			var reData = eval(djson); 
			// 预览图片json数据组 
			var preList = new Array(); 
			for ( var i = 0; i < reData.length; i++) { 
				var array_element = reData[i]; 
				// 图片类型 
				if(array_element.filename.indexOf("gif")>0||
					array_element.filename.indexOf("jpg")>0||
					array_element.filename.indexOf("jpeg")>0||
					array_element.filename.indexOf("png")>0||
					array_element.filename.indexOf("bmp")>0){ 		
					preList[i]= "<img src='upload/user/"+array_element.fileallname+"' class=\"file-preview-image\">"; 
					
			        
		    }else{ 
		    	   // 非图片类型的展示 
		    	    preList[i]=	"<div class='file-preview-other'>" +
					"<h2><i class='glyphicon glyphicon-file'></i></h2>" +"此文件支持下载预览"+
					"</div>"
					
				} 
			} 
			var previewJson = preList; 
			// 与上面 预览图片json数据组 对应的config数据 
			var preConfigList = new Array(); 
			for ( var i = 0; i < reData.length; i++) { 
				var array_element = reData[i]; 
				var tjson = {caption: array_element.filename, // 展示的文件名 						
						width: '120px', 
						url: locat+"/deleteImage.do", // 删除url 
						key: array_element.id, // 删除是Ajax向后台传递的参数 
						extra: {id: 100} 
				}; 
				preConfigList[i] = tjson; 					
			}				
		$("#myFile").fileinput({
            language : 'zh',
            uploadUrl : locat+"/newuploadfile.do?type=2",
            uploadAsync:true, 
            showBrowse:true,
			showCaption: true, 
			showUpload: false,//是否显示上传按钮 
			showRemove: false,//是否显示删除按钮 
			showCaption: true,//是否显示输入框 
			showPreview:true, 
			showCancel:true, 		
			browseOnZoneClick:true,
			dropZoneEnabled: false, 
			maxFileCount: 10, 				
			initialPreviewShowDelete:true, 
			msgFilesTooMany: "选择上传的文件数量 超过允许的最大数值！", 
			initialPreview: previewJson, 
			overwriteInitial:false,
			previewFileIcon: '<i class="glyphicon glyphicon-file"></i>', 
			//allowedFileExtensions : ['jpg','png','txt'],	
			//allowedPreviewTypes : [ 'image','txt'],//配置所有的被预览文件类型		
			otherActionButtons:'<button  type="button" id="" class="kv-cust-btn btn btn-xs btn-default" title="Download" {dataKey}><i class="glyphicon glyphicon-download"></i></button>',//自定义按钮
			preferIconicPreview:true,
			layoutTemplates:{//删除上传按钮
			actionUpload:'',			
			},
			initialPreviewConfig: preConfigList 
        }).on("fileuploaded", function(e, data) {//文件上传成功后执行
            var res = data.response;
            document.getElementById("fileidstr").value=document.getElementById("fileidstr").value+res.success+",";            
        }); 
		//点击下载触发下载方法
		$('.kv-cust-btn').on('click', function() {
		    var $btn = $(this), key = $btn.data('key');
		    var url= locat+"/downUpfile.do?fileid="+key+"&type=3";		    
		    window.location.href=url;
		    
		});
}	
function showFiles1(fileidstr){ 
   var  names=fileidstr.split(",");	
   // 预览图片json数据组 
			var preList = new Array(); 
	for(var i = 0; i < names.length-1; i++){
		var  namess=names[i];
				if(namess.indexOf("gif")>0||
					namess.indexOf("jpg")>0||
					namess.indexOf("jpeg")>0||
					namess.indexOf("png")>0||
					namess.indexOf("bmp")>0){ 
						
					 preList[i]= "<img src='../../upload/qualityproblem/"+namess+"' class=\"file-preview-image\">"; 
			     
		    }else{ 
		    	   // 非图片类型的展示 
		    	    preList[i]=	"<div class='file-preview-other'>" +
					"<h2><i class='glyphicon glyphicon-file'></i></h2>" +"此文件支持下载预览"+
					"</div>"
					
				} 
			}
		var previewJson = preList; 
		// 与上面 预览图片json数据组 对应的config数据 
			var preConfigList = new Array(); 
		for(var i = 0; i < names.length-1; i++){
				var namess = names[i]; 
				var tjson = {caption: namess, // 展示的文件名 						
						width: '120px', 
						url: locat+"/deleteImage.do", // 删除url 
						key: namess // 删除是Ajax向后台传递的参数 
				}; 
				preConfigList[i] = tjson; 					
			}				
		$("#myFile").fileinput({
			
            language : 'zh',
            uploadUrl : locat+"/newuploadfile.do?type=1",
            uploadAsync:true, 
            showBrowse:true,
			showCaption: true, 
			showUpload: false,//是否显示上传按钮 
			showRemove: false,//是否显示删除按钮 
			showCaption: true,//是否显示输入框 
			showPreview:true, 
			showCancel:true, 		
			browseOnZoneClick:true,
			dropZoneEnabled: false, 
			maxFileCount: 10, 				
			initialPreviewShowDelete:true, 
			msgFilesTooMany: "选择上传的文件数量 超过允许的最大数值！", 
			initialPreview: previewJson, 
			overwriteInitial:false,
			previewFileIcon: '<i class="glyphicon glyphicon-file"></i>', 
			//allowedFileExtensions : ['jpg','png','txt'],	
			//allowedPreviewTypes : [ 'image','txt'],//配置所有的被预览文件类型		
			otherActionButtons:'<button  type="button" id="" class="kv-cust-btn btn btn-xs btn-default" title="Download" {dataKey}><i class="glyphicon glyphicon-download"></i></button>',//自定义按钮
			preferIconicPreview:true,
			layoutTemplates:{//删除上传按钮
			actionUpload:'',			
			},
			initialPreviewConfig: preConfigList 
        }).on("fileuploaded", function(e, data) {//文件上传成功后执行
            var res = data.response;
            document.getElementById("fileidstr").value=document.getElementById("fileidstr").value+res.success+",";            
        }); 
		//点击下载触发下载方法
		$('.kv-cust-btn').on('click', function() {
		    var $btn = $(this), key = $btn.data('key');
		    var url= locat+"/downUpfile.do?fileid="+key+"&type=2";		    
		    window.location.href=url;
		    
		});
}		
	