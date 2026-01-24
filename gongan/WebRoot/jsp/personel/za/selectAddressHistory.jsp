<%@ page contentType='text/html;charset=UTF-8' language='java' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>" media="all"/>
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>" media="all"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <style type="text/css">
        .layui-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .history-table-container {
            padding: 15px;
        }
    </style>
</head>
<body class="childrenBody layui-fluid">
<div class="history-table-container">
    <table class="layui-hide" id="addressHistoryTable" lay-filter="addressHistoryTable"></table>
</div>

<script type="text/javascript">
    var personnelid = '${param.personnelid}';

    layui.use(['table', 'layer'], function () {
        var table = layui.table;
        var layer = layui.layer;

        // 渲染历史住址表格
        table.render({
            elem: '#addressHistoryTable',
            url: '<c:url value="/getHomeplaceHistory.do"/>',
            where: {personnelid: personnelid},
            method: 'post',
            cols: [[
                {field: 'id', title: 'ID', width: 60, align: 'center', hide: true},
                {field: 'province', title: '省', width: 80, align: 'center'},
                {field: 'city', title: '地级市', width: 100, align: 'center'},
                {field: 'county', title: '县级市/区', width: 100, align: 'center'},
                {field: 'town', title: '镇/街道', width: 100, align: 'center'},
                {field: 'detailAddress', title: '详细地址', minWidth: 150, align: 'center'},
                {field: 'policeStationName', title: '派出所', width: 120, align: 'center'},
                {field: 'longitude', title: '经度', width: 100, align: 'center'},
                {field: 'latitude', title: '纬度', width: 100, align: 'center'},
                {field: 'addtime', title: '记录时间', width: 160, align: 'center'}
            ]],
            page: true,
            limit: 10,
            limits: [10, 20, 30, 50],
            text: {
                none: '暂无历史住址记录'
            },
            done: function(res, curr, count) {
                if (count === 0) {
                    layer.msg('暂无历史住址记录', {icon: 6});
                }
            }
        });
    });
</script>
</body>
</html>

