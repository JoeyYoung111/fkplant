<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<! DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <style>
        /*layui-table 表格内容允许���行*/
        .layui-table-main . layui-table td div: not(.laytable-cell-radio){
            height: auto;
            overflow: visible;
            text-overflow:inherit;
            white-space:normal;
        }
        . layui-table-fixed .layui-table-body{
            display:none;
        }
    </style>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
</head>
<body>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
<script>
    var locat = (window.location+'').split('/');
    var now=new Date();
    $(function(){
        if('main'== locat[3]){
            locat =  locat[0]+'//'+locat[2];
        }else{
            locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
        }
    });

    layui.use(['table','form'], function(){
        var table = layui.table,
            form = layui.form;

        //方法级渲染
        table.render({
            elem: '#followTable',
            toolbar: true,
            defaultToolbar: ['filter'],
            url :   locat+"/searchZaDu.do?personnelid="+${param.personnelid},
            method:'post',
            cols: [[
                // ✅ 第一列：操作
                {
                    field: 'id',
                    title: '操作',
                    width: 100,
                    align: 'center',
                    fixed: 'left',
                    templet: function(item) {
                        return '<button class="layui-btn layui-btn-sm layui-btn-primary" lay-event="edit">修改</button>';
                    }
                },

                // ✅ 记录序号（按添加时间排序）
                {
                    field: 'id',
                    title: '记录序号',
                    width:  80,
                    align: 'center',
                    templet: function(item) {
                        return '<span>' + (item.rowIndex || '') + '</span>';
                    }
                },

                // ✅ 现住地址（省）
                {
                    field: 'homeProvince',
                    title: '省',
                    width: 80,
                    align: 'center'
                },

                // ✅ 现住地址（地级市）
                {
                    field: 'homeCity',
                    title: '地级市',
                    width: 100,
                    align: 'center'
                },

                // ✅ 现住地址（县级市/区）
                {
                    field:  'homeCounty',
                    title: '县级市/区',
                    width: 100,
                    align: 'center'
                },

                // ✅ 现住地址（镇/街道）
                {
                    field: 'homeTown',
                    title: '镇/街道',
                    width: 100,
                    align: 'center'
                },

                // ✅ 现住地址（详细地址）
                {
                    field: 'homeDetail',
                    title: '详细地址',
                    width:  '12%',
                    align: 'center',
                    templet: function(item) {
                        var addr = item.homeDetail || '';
                        return '<div>' + addr + '</div>';
                    }
                },

                // ✅ 派出所名称
                {
                    field: 'homePoliceStationName',
                    title:  '派出所',
                    width: 120,
                    align: 'center'
                },

                // ✅ 联系电话
                {
                    field: 'phone',
                    title: '联系电话',
                    width: 120,
                    align: 'center'
                },

                // ✅ 历史涉赌情况综述
                {
                    field:  'lssdqk',
                    title: '历史涉赌情况综述',
                    width: '12%',
                    align: 'center',
                    templet: function(item) {
                        var lssdqk = item.lssdqk ?  item.lssdqk. replace(/\n/g, '<br/>') : '';
                        return '<div>' + lssdqk + '</div>';
                    }
                },

                // ✅ 采集来源
                {
                    field: 'collectSource',
                    title: '采集来源',
                    width: 100,
                    align: 'center'
                },

                // ✅ 采集日期
                {
                    field: 'collectDate',
                    title: '采集日期',
                    width: 120,
                    align: 'center'
                },

                // ✅ 人员属性
                {
                    field: 'personAttribute',
                    title: '人员属性',
                    width: 100,
                    align: 'center'
                },

                // ✅ 赌博方式
                {
                    field: 'dbfs',
                    title: '赌博方式',
                    width: 100,
                    align: 'center'
                },

                // ✅ 赌博部位
                {
                    field: 'dbbw',
                    title: '赌博部位',
                    width: 100,
                    align: 'center'
                },

                // ✅ 查获经过
                {
                    field: 'chjg',
                    title: '查获经过',
                    width: '12%',
                    align: 'center',
                    templet:  function(item) {
                        var chjg = item.chjg ? item.chjg.replace(/\n/g, '<br/>') : '';
                        return '<div>' + chjg + '</div>';
                    }
                },

                // ✅ 处罚结果
                {
                    field: 'cfjg',
                    title: '处罚结果',
                    width: 100,
                    align: 'center'
                },

                // ✅ 处理详情
                {
                    field: 'clxq',
                    title: '处理详情',
                    width: '12%',
                    align: 'center',
                    templet: function(item) {
                        var clxq = item.clxq ? item.clxq. replace(/\n/g, '<br/>') : '';
                        return '<div>' + clxq + '</div>';
                    }
                },

                // ✅ 涉案地址列表
                {
                    field: 'caseAddressList',
                    title: '涉案地址',
                    width: '12%',
                    align: 'center',
                    templet:  function(item) {
                        var addresses = item.caseAddressList || '';
                        return '<div>' + addresses + '</div>';
                    }
                },
                // ✅ 关联案件
                {
                    field: 'glanjian',
                    title: '关联案件',
                    width:  120,
                    align: 'center'
                },

                // ✅ 处罚时间
                {
                    field: 'chsj',
                    title: '处罚时间',
                    width:  120,
                    align: 'center'
                },

                // ✅ 最新修改人
                {
                    field: 'addoperator',
                    title: '修改人',
                    width: 100,
                    align: 'center'
                },

                // ✅ 最新修改时间
                {
                    field: 'addtime',
                    title: '修改时间',
                    width: 160,
                    align: 'center'
                }
            ]],
            page: true,
            limit: 10,
            done: function(res, curr, count) {
                console.log('表格数据加载完成', res);
            }
        });

        // ✅ 监听行工具事件（修改按钮）
        table.on('tool(followTable)', function(obj) {
            var data = obj.data;

            if(obj.event === 'edit') {
                console.log('✓ 点击修改按钮，数据:', data);
                // 调用回显函数，将数据返回给父窗口
                echoDataToParent(data);
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
            if(typeof parentWindow.echoZaDuData === 'function') {
                parentWindow.echoZaDuData(data);
                console.log('✓ 数据成功回显到父窗口');
            } else {
                console.error('父窗口未找到 echoZaDuData 函数');
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