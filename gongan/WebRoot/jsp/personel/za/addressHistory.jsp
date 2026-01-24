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
    <title>历史住址记录</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>" media="all" />
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>" media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
</head>
<body class="childrenBody">
    <table class="layui-hide" id="addressHistoryTable" lay-filter="addressHistoryTable"></table>

    <script type="text/javascript">
        layui.use(['table'], function(){
            var table = layui.table;

            table.render({
                elem: '#addressHistoryTable',
                url: '<c:url value="/getHomeplaceHistory.do"/>',
                where: {personnelid: '${param.personnelid}'},
                method: 'post',
                cols: [[
                    {field:'province', title: '省', width:80, align:'center'},
                    {field:'city', title: '市', width:80, align:'center'},
                    {field:'county', title: '区/县', width:80, align:'center'},
                    {field:'town', title: '镇/街道', width:100, align:'center'},
                    {field:'policeStationName', title: '派出所', width:120, align:'center'},
                    {field:'detailAddress', title: '详细地址', minWidth:200, align:'left'},
                    {field:'startDate', title: '开始日期', width:100, align:'center'},
                    {field:'endDate', title: '结束日期', width:100, align:'center'},
                    {field:'addtime', title: '记录时间', width:160, align:'center'}
                ]],
                page: true,
                limit: 10,
                limits: [10, 20, 50]
            });
        });
    </script>
</body>
</html>

