<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>选择关联案件</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>" media="all" />
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>" media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
</head>
<body class="childrenBody layui-fluid">
    <div class="layui-form layui-row" style="margin-bottom:10px;">
        <div class="layui-inline">
            <label class="layui-form-label">案件名称</label>
            <div class="layui-input-inline">
                <input type="text" id="caseName" placeholder="请输入案件名称" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button class="layui-btn" id="searchBtn"><i class="layui-icon">&#xe615;</i>搜索</button>
        </div>
    </div>

    <table class="layui-hide" id="caseTable" lay-filter="caseTable"></table>

    <script type="text/html" id="caseBar">
        <a class="layui-btn layui-btn-xs" lay-event="select">选择</a>
    </script>

    <script type="text/javascript">
        var selectType = '${param.type}';

        layui.use(['table', 'form'], function(){
            var table = layui.table;
            var form = layui.form;

            table.render({
                elem: '#caseTable',
                url: '<c:url value="/searchAjxxByCardnumber.do"/>',
                where: {sfzh: '${param.cardnumber}'},
                method: 'post',
                cols: [[
                    {field:'ajbh', title: '案件编号', width:150, align:'center'},
                    {field:'ajmc', title: '案件名称', minWidth:200, align:'left'},
                    {field:'ajlx', title: '案件类型', width:100, align:'center'},
                    {field:'slsj', title: '受理时间', width:160, align:'center'},
                    {title: '操作', width:80, align:'center', toolbar: '#caseBar'}
                ]],
                page: true,
                limit: 10,
                limits: [10, 20, 50]
            });

            // 搜索
            $('#searchBtn').click(function(){
                table.reload('caseTable', {
                    where: {
                        sfzh: '${param.cardnumber}',
                        ajmc: $('#caseName').val()
                    }
                });
            });

            // 行工具事件
            table.on('tool(caseTable)', function(obj){
                var data = obj.data;
                if(obj.event === 'select'){
                    // 回调父页面
                    if(parent && parent.setSelectedCase){
                        parent.setSelectedCase(selectType, data.id, data.ajmc);
                    }
                    // 关闭当前弹层
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            });
        });
    </script>
</body>
</html>

