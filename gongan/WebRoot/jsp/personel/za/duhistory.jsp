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
        /*.layui-table-main . layui-table td div: not(.laytable-cell-radio){*/
        /*    height: auto;*/
        /*    overflow: visible;*/
        /*    text-overflow:inherit;*/
        /*    white-space:normal;*/
        /*}*/
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

    // ✅ 获取showflag参数（判断是否为只读详情模式）
    var urlParams = new URLSearchParams(window.location.search);
    var showflag = urlParams.get('showflag');
    var isShowOnlyMode = (showflag === '1'); // true表示只显示"详情"按钮

    // ✅ 获取menuid（从URL参数或父窗口）
    var menuid = getMenuId();

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


                // ✅ 现住地址（省）- 隐藏
                {
                    field: 'homeProvince',
                    title: '省',
                    width: 80,
                    align: 'center',
                    hide: true
                },

                // ✅ 现住地址（地级市）- 隐藏
                {
                    field: 'homeCity',
                    title: '地级市',
                    width: 100,
                    align: 'center',
                    hide: true
                },

                // ✅ 现住地址（县级市/区）- 隐藏
                {
                    field:  'homeCounty',
                    title: '县级市/区',
                    width: 100,
                    align: 'center',
                    hide: true
                },

                // ✅ 现住地址（镇/街道）- 隐藏
                {
                    field: 'homeTown',
                    title: '镇/街道',
                    width: 100,
                    align: 'center',
                    hide: true
                },

                // ✅ 现住地址（详细地址）
                {
                    field: 'homeDetail',
                    title: '现住地详址',
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
                    title:  '所属派出所',
                    width: 120,
                    align: 'center'
                },

                // ✅ 联系电话
                {
                    field: 'phone',
                    title: '手机号码',
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
                    title: '涉赌方式',
                    width: 100,
                    align: 'center'
                },

                // ✅ 赌博部位
                {
                    field: 'dbbw',
                    title: '涉赌部位',
                    width: 100,
                    align: 'center'
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
                    title: '采集时间',
                    width: 120,
                    align: 'center'
                },

                // ✅ 历史涉赌情况综述 - 隐藏
                {
                    field:  'lssdqk',
                    title: '涉赌情况综述',
                    width: '12%',
                    align: 'center',
                    hide: true,
                    templet: function(item) {
                        var lssdqk = item.lssdqk ?  item.lssdqk. replace(/\n/g, '<br/>') : '';
                        return '<div>' + lssdqk + '</div>';
                    }
                },

                // ✅ 查获经过 - 隐藏
                {
                    field: 'chjg',
                    title: '查获经过',
                    width: '12%',
                    align: 'center',
                    hide: true,
                    templet:  function(item) {
                        var chjg = item.chjg ? item.chjg.replace(/\n/g, '<br/>') : '';
                        return '<div>' + chjg + '</div>';
                    }
                },

                // ✅ 处罚结果
                {
                    field: 'cfjg',
                    title: '处罚情况',
                    width: 100,
                    align: 'center'
                },
                // ✅ 处罚时间
                {
                    field: 'chsj',
                    title: '处罚日期',
                    width:  120,
                    align: 'center'
                },

                // ✅ 涉赌前科
                {
                    field: 'hasSheduRecord',
                    title: '涉赌前科',
                    width: 100,
                    align: 'center',
                    templet: function(item) {
                        if (item.hasSheduRecord == 1) {
                            return '<span style="color:#FF5722;">有</span>';
                        } else {
                            return '<span>无</span>';
                        }
                    }
                },

                // ✅ 打处单位
                {
                    field: 'handleUnitCode',
                    title: '打处单位',
                    width: 150,
                    align: 'center',
                    templet: function(item) {
                        if (!item.handleUnitCode) {
                            return '-';
                        }

                        var codes = (item.handleUnitCode + '').split(',');
                        var names = [];
                        var hasOther = false; // 是否已有不在范围内的数字
                        for (var i = 0; i < codes.length; i++) {
                            var code = parseInt(codes[i].trim());
                            if (isNaN(code)) continue;
                            if (code >= 240 && code <= 263) {
                                // 在范围内，查找对应单位名称
                                var found = false;
                                if (window.parent && window.parent.policeData) {
                                    var policeData = window.parent.policeData;
                                    for (var j = 0; j < policeData.length; j++) {
                                        if (policeData[j].departmentid == code) {
                                            names.push(policeData[j].name);
                                            found = true;
                                            break;
                                        }
                                    }
                                }
                                if (!found) {
                                    names.push(code);
                                }
                            } else {
                                // 不在范围内，仅标记一次"治安大队或其他"
                                hasOther = true;
                            }
                        }
                        if (hasOther) {
                            names.push('治安大队或其他');
                        }
                        return names.length > 0 ? names.join('、') : '-';
                    }
                },

                // ✅ 处理详情 - 隐藏
                {
                    field: 'clxq',
                    title: '处理详情',
                    width: '12%',
                    align: 'center',
                    hide: true,
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



                // ✅ 关联警情ID
                {
                    field: 'relJqIds',
                    title: '关联警情ID',
                    width: 120,
                    align: 'center',
                    templet: function(d) {
                        return d.relJqIds ? '<span style="color:#1E9FFF;">' + d.relJqIds + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },

                // ✅ 关联案件ID
                {
                    field: 'relAjIds',
                    title: '关联案件ID',
                    width: 120,
                    align: 'center',
                    templet: function(d) {
                        return d.relAjIds ? '<span style="color:#1E9FFF;">' + d.relAjIds + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },

                // ✅ 最新修改人
                {
                    field: 'addoperator',
                    title: '添加人',
                    width: 100,
                    align: 'center'
                },

                // ✅ 最新修改时间
                {
                    field: 'addtime',
                    title: '添加时间',
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

        // ✅ 监听行工具事件（修改按钮 & 删除按钮 & 详情按钮）
        table.on('tool(followTable)', function(obj) {
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
                layui.layer.confirm('确定删除该条涉赌记录？删除后将同时清除所有关联关系。', {
                    btn: ['确定删除', '取消']
                }, function(index) {
                    // 调用删除接口
                    $.ajax({
                        url: locat + '/deleteZaDu.do',
                        type: 'POST',
                        data: {
                            duId: data.id,
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
                                table.reload('followTable');
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