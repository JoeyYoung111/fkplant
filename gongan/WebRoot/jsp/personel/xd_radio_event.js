var jqjson="";
function radio_jqxx(){
	layui.table.on('radio(jqxxTable)',function(obj){
		jqjson=obj.data;
		var index = layui.layer.open({
			title : "涉警信息详情",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : locat+'/jsp/personel/xd/jdxx.jsp',
			area: ['800', '700px'],
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
}
var ajjson="";
function radio_ajxx(){
	layui.table.on('radio(ajxxTable)',function(obj){
		ajjson=obj.data;
		var index = layui.layer.open({
			title : "涉案信息详情",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : locat+'/jsp/personel/xd/ajxx.jsp',
			area: ['800', '700px'],
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
}

