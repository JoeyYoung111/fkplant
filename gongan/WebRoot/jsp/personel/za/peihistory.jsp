<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <style>
        /*layui-table 表格内容允许换行*/
        /*.layui-table-main .layui-table td div:not(.laytable-cell-radio){*/
        /*    height: auto;*/
        /*    overflow: visible;*/
        /*    text-overflow:inherit;*/
        /*    white-space:normal;*/
        /*}*/
        .layui-table-fixed .layui-table-body{
            display:none;
        }
    </style>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
</head>
<body>
<table class="layui-hide" id="peiHistoryTable" lay-filter="peiHistoryTable"></table>
<script>
    var locat = (window.location+'').split('/');
    var now=new Date();
    var menuid = ${param.menuid != null ? param.menuid : 0}; // ✅ 从URL参数获取menuid

    // ✅ 获取showflag参数（判断是否为只读详情模式）
    var urlParams = new URLSearchParams(window.location.search);
    var showflag = urlParams.get('showflag');
    var isShowOnlyMode = (showflag === '1'); // true表示只显示"详情"按钮

    // ✅ 旧的getMenuId函数保留作为备用（目前不使用）
    function getMenuId() {
        // 1. 尝试从URL参数获取
        var urlParams = new URLSearchParams(window.location.search);
        var menuIdFromUrl = urlParams.get('menuid');
        if (menuIdFromUrl) {
            return menuIdFromUrl;
        }

        // 2. 尝试从父窗口获取
        try {
            var parentWindow = window.parent || window.opener;
            if (parentWindow && parentWindow.$) {
                var menuIdFromParent = parentWindow.$('#menuid').val();
                if (menuIdFromParent) {
                    return menuIdFromParent;
                }
            }
        } catch(e) {
            console.warn('无法从父窗口获取menuid:', e);
        }

        // 3. 默认值
        return 0;
    }
    $(function(){
        if('main'== locat[3]){
            locat =  locat[0]+'//'+locat[2];
        }else{
            locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
        }
    });

    layui.use(['table', 'layer', 'form'], function () {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;

        // 渲染表格
        table.render({
            elem: '#peiHistoryTable',
            toolbar: true,
            defaultToolbar: ['filter'],
            url: locat + "/searchZaPei.do?personnelid=" + ${param.personnelid},
            method:'post',
            cols: [[
                // ✅ 第一列：操作
                {
                    field: 'id',
                    title: '操作',
                    width: '12%',
                    align: 'center',
                    fixed: 'left',
                    templet: function(item) {
                        // ✅ 如果showflag=1，只显示"详情"按钮
                        if (isShowOnlyMode) {
                            return '<button class="layui-btn layui-btn-sm layui-btn-primary" lay-event="detail">详情</button>';
                        } else {
                            // ✅ 否则显示"修改"和"删除"按钮
                            return '<button class="layui-btn layui-btn-sm layui-btn-primary" lay-event="edit">修改</button> <button class="layui-btn layui-btn-sm layui-btn-primary" lay-event="delete">删除</button>';
                        }
                    }
                },
                {
                    field:  'otherMemo',
                    title: '陪侍情况综述',
                    width: '12%',
                    align: 'center',
                    hide: true,
                    templet: function(item) {
                        var otherMemo = item.otherMemo ?  item.otherMemo. replace(/\n/g, '<br/>') : '';
                        return '<div>' + otherMemo + '</div>';
                    }
                },
                {field: 'memo', title: '角色标签', width: 120, align: 'center'},
                {field: 'collectSource', title: '采集来源', width: 120, align: 'center'},
                {field: 'collectDate', title: '采集时间', width: 120, align: 'center'},

                // ✅ 涉黄前科
                {
                    field: 'hasShechangRecord',
                    title: '涉黄前科',
                    width: 100,
                    align: 'center',
                    templet: function(item) {
                        if (item.hasShechangRecord == 1) {
                            return '<span style="color:#FF5722;">有</span>';
                        } else {
                            return '<span>无</span>';
                        }
                    }
                },

                // ✅ 活动场所列表
                {
                    field: 'activityVenue',
                    title: '活动场所',
                    width: '12%',
                    align: 'center',
                    templet:   function (d) {
                        var addresses = d.activityVenue || '';
                        return '<div>' + addresses + '</div>';
                    }
                },
                {
                    field: 'relJqIds', title: '关联警情ID', width: 120, align: 'center', templet: function (d) {
                        return d.relJqIds ? '<span style="color:#1E9FFF;">' + d.relJqIds + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    field: 'relAjIds', title: '关联案件ID', width: 120, align: 'center', templet: function (d) {
                        return d.relAjIds ? '<span style="color:#FF5722;">' + d.relAjIds + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {field: 'addoperator', title: '添加人', width: 100, align: 'center'},
                {field: 'addtime', title: '添加时间', width: 160, align: 'center'}
            ]],
            page: true,
            limit: 10,
            done: function(res, curr, count) {
                console.log('表格数据加载完成', res);
            }
        });

        // ✅ 监听行工具事件（修改按钮 & 删除按钮 & 详情按钮）
        table.on('tool(peiHistoryTable)', function(obj) {
            var data = obj.data;

            if(obj.event === 'detail') {
                console.log('✓ 点击详情按钮，数据:', data);
                // 调用回显函数，将数据返回给父窗口（详情页模式）
                echoDataToParent(data);
            }
            else if(obj.event === 'edit') {
                console.log('✓ 点击修改按钮，数据:', data);
                // 调用回显函数，将数据返回给父窗口
                echoDataToParent(data);
            }
            else if(obj.event === 'delete') {
                console.log('✓ 点击删除按钮，数据:', data);
                // 二次确认删除
                layui.layer.confirm('确定删除该条陪侍记录？删除后将同时清除所有关联关系。', {
                    btn: ['确定删除', '取消']
                }, function(index) {
                    // 调用删除接口
                    $.ajax({
                        url: locat + '/deleteZaPei.do',
                        type: 'POST',
                        data: {
                            peiId: data.id,
                            menuid: menuid
                        },
                        dataType: 'json',
                        success: function(result) {
                            // 1. 安全检查：如果返回的是字符串，手动解析成对象
                            // 统一使用 result
                            var dataObj = (typeof result === 'string')
                                ? JSON.parse(result)
                                : result;

                            console.log('解析后的响应对象:', dataObj);
                            if (dataObj.flag == 1 || dataObj.result === "true") {
                                layui.layer.msg(dataObj.msg || '删除成功', { icon: 1 });
                                // 重新加载表格
                                table.reload('peiHistoryTable');
                            } else {
                                // 报错时显示后端返回的具体 msg
                                layui.layer.msg(dataObj.msg || '删除失败', { icon: 2 });
                            }
                            layui.layer.close(index);
                        },
                        error: function() {
                            layui.layer.msg('删除失败，请稍后重试', { icon: 2 });
                            layui.layer.close(index);
                        }
                    });
                }, function(index) {
                    // 取消删除
                    layui.layer.close(index);
                });
            }
        });

        form.render();
    });

    // ✅ 将历史记录数据回显到 update.jsp
    function echoDataToParent(data) {
        console.log('📤 回显数据到父窗口:', data);

        // 获取父窗口的 window 对象
        var parentWindow = window.parent || window.opener;

        if(! parentWindow) {
            alert('无法获取父窗口，请确保此页面是通过 iframe 或 layer 打开的');
            return;
        }

        try {
            // ✅ 调用父窗口的回显函数
            if(typeof parentWindow.echoZaPeiData === 'function') {
                parentWindow.echoZaPeiData(data);
                console.log('✓ 数据成功回显到父窗口');
            } else {
                console.error('父窗口未找到 echoZaPeiData 函数');
            }

            // 关闭当前窗口（如果是 layer 打开的）
            setTimeout(function() {
                var index = parent.layer.getFrameIndex(window. name);
                parent.layer.close(index);
            }, 500);

        } catch(e) {
            console.error('回显数据时出错:', e);
            alert('回显数据失败：' + e.message);
        }
    }
</script>
</body>
</html>

