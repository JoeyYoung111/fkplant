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
     <title>人员属性标签</title>
    <base href="<%=basePath%>">
    
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <style>
     /*layui-table 表格内容允许换行*/
     .layui-table-main .layui-table div{
         height: auto;
         overflow:visible;
         text-overflow:inherit;
         white-space:normal;
     }
     .layui-table-cell .layui-form-checkbox[lay-skin=primary] {
	    top: 3px;
	 }
     .layui-table-fixed .layui-table-body{
      display:none;
     }
   </style>
  </head>
  
 <body>
 <input type="hidden"  name="attributelabels"  id="attributelabels"   value=${personlabel.attributelabels }>
<table id="authTreeTable" class="layui-hide" lay-filter="authTreeTable"></table>

 <script type="text/html" id="toolbarDemo">
	 <button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#x1005;</i>确定标签</button>
   </script>

<script>
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.config({
       base: "<c:url value="/layui/lay/modules/"/>"
    }).extend({
        treetable: 'treetable-lay/treetable'
    }).use(['layer', 'table', 'treetable'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var treetable = layui.treetable;

        // 渲染表格
        layer.load(2);
        treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#authTreeTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		defaultToolbar: ['filter', 'exports', 'print'],
            //url: 'json/menus.json',
             url: '<c:url value="/getAttributeLabelTree.do"/>',
            page: false,
            cols: [
            [
                {field:'id', type:'checkbox',width: 100},
                {field: 'attributelabel', title: '属性标签'},
                {field: 'memo', align: 'center',width: 400, title: '标签描述'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
           		//利用回调函数进行回显
	           var dataArr = res.data;
	           var attributelabels=$("#attributelabels").val().split(",");
	           for(var i=0;i<attributelabels.length;i++){
	               for (var j = 0; j < dataArr.length; j++) {
	              //console.log(j+"    "+dataArr[j].id+"        "+dataArr[j].attributelabel);
	              if (dataArr[j].id == attributelabels[i]) {
	                     dataArr[j]["LAY_CHECKED"]='true';
	                     var index= res.data[j]['LAY_TABLE_INDEX'];
	                     $('tr[data-index=' + index + '] input[type="checkbox"]').prop('checked', true);//设置选中
                         $('tr[data-index=' + index + '] input[type="checkbox"]').next().addClass('layui-form-checked');//改变选中样式
                       
	                }
	             };
	          }
	       }
        });



        // 头部工具栏点击事件
        table.on('toolbar(authTreeTable)', function (obj) {
             var id=${personlabel.id };
             var menuid=${menuid};
    		 if(obj.event == 'add'){
		            var checkStatus = layui.table.checkStatus('authTreeTable').data;
		            var ids = [];
		          // alert(checkStatus.length);
		          console.log(checkStatus); 
		    	    for(var i=0;i<checkStatus.length;i++){
		    		    ids.push(checkStatus[i].id);
				    }
			        ids = ids.join(',');//数组转字符串
				   //alert(ids);
		           $.ajax({
							url:		'<c:url value="/updateAttributelabels.do"/>',
							type:		'post',
							data:		{id:id,attributelabels:ids,menuid:menuid},
							dataType:	'json',
							async:		false,
							success:	function(data){  
								var obj = eval('(' + data + ')');
								//alert("flag="+obj.flag);
								if(obj.flag>0){
									var index = top.layer.msg('数据提交中...',{icon: 16,time:false,shade:0.8});
									setTimeout(function(){
										top.layer.msg(obj.msg);
										top.layer.close(index);
										parent.layer.closeAll("iframe");
										parent.getAttributelabels();//刷新父页面人员属性标签
										
									},500);
								}
							},error:function(){
								alert("请求失败");
							}
						});
				
            }
        });

 
  });	
   

</script>
</body>

</html>

