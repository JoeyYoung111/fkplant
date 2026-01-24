layui.use(['form','layer','jquery','laypage','element'], function(){
  var $ = layui.jquery;
  element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  //监听左侧菜单点击
    element.on('nav(left-menu)', function(elem){
    if(elem.attr("data-url")!=undefined){
        addTab(elem.attr("data-title"),elem.attr("data-url"),elem.attr("data-id"));
       }
    });
    $(".opotab").click(function(){
  		addTab1($(this).attr("data-title"),$(this).attr("data-url"),$(this).attr("data-id"));
	});
    
     
     /**
 * 新增tab选项卡，如果已经存在则打开已经存在的，不存在则新增
 * @param tabTitle 选项卡标题名称
 * @param tabUrl 选项卡链接的页面URL
 * @param tabId 选项卡id
 */
function addTab(tabTitle,tabUrl,tabId){
    if ($(".layui-tab-title li[lay-id=" + tabId + "]").length > 0) {
        element.tabChange('bodyTab', tabId);
   }else{
  		var title='';
  		title += '<cite>'+tabTitle+'</cite>';
		title += '<i class="layui-icon layui-unselect layui-tab-close" data-id="'+tabId+'">&#x1006;</i>';
        element.tabAdd('bodyTab', {
            title: title
            ,content: '<iframe src='+tabUrl+' width="100%" style="min-height: 500px;" frameborder="0" scrolling="auto"></iframe>' // 选项卡内容，支持传入html
            ,id: tabId //选项卡标题的lay-id属性值
        });
        element.tabChange('bodyTab', tabId); //切换到新增的tab上
    }
}
function addTab1(tabTitle,tabUrl,tabId){
    if (parent.$(".layui-tab-title li[lay-id=" + tabId + "]").length > 0) {
        parent.layui.element.tabChange('bodyTab', tabId);
   }else{
  		var title='';
  		title += '<cite>'+tabTitle+'</cite>';
		title += '<i class="layui-icon layui-unselect layui-tab-close" data-id="'+tabId+'">&#x1006;</i>';
        parent.layui.element.tabAdd('bodyTab', {
            title: title
            ,content: '<iframe src='+tabUrl+' width="100%" style="min-height: 500px;" frameborder="0" scrolling="auto" ></iframe>' // 选项卡内容，支持传入html
            ,id: tabId //选项卡标题的lay-id属性值
        });
        parent.layui.element.tabChange('bodyTab', tabId); //切换到新增的tab上
    }
}
// 删除tab选项卡
$("body").on("click",".top_tab li i.layui-tab-close",function(){
element.tabDelete('bodyTab',$(this).attr("data-id"));
});

 //刷新当前
	$(".refresh").on("click",function(){  //此处添加禁止连续点击刷新一是为了降低服务器压力，另外一个就是为了防止超快点击造成chrome本身的一些js文件的报错(不过貌似这个问题还是存在，不过概率小了很多)
		if($(this).hasClass("refreshThis")){
			$(this).removeClass("refreshThis");
			$(".clildFrame .layui-tab-item.layui-show").find("iframe")[0].contentWindow.location.reload(true);
			setTimeout(function(){
				$(".refresh").addClass("refreshThis");
			},2000)
		}else{
			layer.msg("您点击的速度超过了服务器的响应速度，还是等两秒再刷新吧！");
		}
	})
	//关闭其他
	$(".closePageOther").on("click",function(){
	if($("#top_tabs li").length>2 && $("#top_tabs li.layui-this cite").text()!="后台首页"){
	$("#top_tabs li").each(function(){
	if($(this).attr("lay-id") != '' && !$(this).hasClass("layui-this")){
		element.tabDelete("bodyTab",$(this).attr("lay-id")).init();
	}				
    })
	}else{
	layer.msg("没有可以关闭的窗口了@_@");
	}	
        //渲染顶部窗口
    tab.tabMove();
	})
	//关闭全部
	$(".closePageAll").on("click",function(){
		if($("#top_tabs li").length > 1){
			$("#top_tabs li").each(function(){
				if($(this).attr("lay-id") != ''){
					element.tabDelete("bodyTab",$(this).attr("lay-id")).init();
					
				}
			})
		}else{
			layer.msg("没有可以关闭的窗口了@_@");
		}
		//渲染顶部窗口
	//	tab.tabMove();
	})
	//隐藏左侧导航
	$(".icon-menu1").click(function(){
		$(".layui-layout-admin").toggleClass("showMenu");
		//渲染顶部窗口
	//	tab.tabMove();
	})

	//渲染左侧菜单
	//tab.render();
});
