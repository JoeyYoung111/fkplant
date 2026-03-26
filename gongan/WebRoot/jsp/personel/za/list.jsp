<%@ page contentType='text/html;charset=UTF-8' language='java' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ page import="com.aladdin.model.UserSession"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    UserSession userSession = (UserSession) session.getAttribute("userSession");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>治安人员查询</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>" media="all"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
</head>
<body>
<blockquote class="layui-elem-quote news_search">
    <div class="demoTable">
        <form class="layui-form" onsubmit="return false;" style="display:inline;" onsubmit="return false;">

            <div class="layui-inline" style="width:212px;">
                <input class="layui-input" type="text" id="cardnumber" placeholder=" 身份证号：" autocomplete="off">
            </div>
            <div class="layui-inline" style="width:212px;">
                <input class="layui-input" type="text" id="personname" placeholder=" 姓名：" autocomplete="off">
            </div>
            <div class="layui-inline" style="width:212px;">
                <input class="layui-input" type="text" id="homeplace" placeholder=" 现居住地详址：" autocomplete="off">
            </div>
            <div class="layui-inline">
                <div id="attributelabels" style="width:360px;"></div>
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="isMinor">
                    <option value="">是否未成年: 全部</option>
                    <option value="1">是</option>
                    <option value="0">否</option>
                </select>
            </div>
            <div class="layui-inline" style="width:212px;">
                <select id="handleUnitCode">
                    <option value="">打处单位: 全部</option>
                    <option value="NOT_PCT">治安大队</option>
                </select>
            </div>
            <br>
            <div class="layui-inline" style="width:150px;">
                <input class="layui-input" type="text" id="punishDateStart" placeholder="处罚日期起" autocomplete="off"
                       readonly>
            </div>
            <div class="layui-inline" style="width:150px;">
                <input class="layui-input" type="text" id="punishDateEnd" placeholder="处罚日期止" autocomplete="off"
                       readonly>
            </div>
            <br>
            <div class="layui-inline" style="line-height:38px;font-weight:600;">
                涉赌人员搜索：
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="duPersonAttribute">
                    <option value="">涉赌人员属性</option>
                </select>
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="duMethod">
                    <option value="">涉赌方式</option>
                </select>
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="duPart">
                    <option value="">涉赌部位</option>
                </select>
            </div>
            <div class="layui-inline" style="line-height:38px;font-weight:600;">
                陪侍人员搜索：
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="peiMemo">
                    <option value="">角色标签</option>
                </select>
            </div>
            <br>
            <div class="layui-inline" style="line-height:38px;font-weight:600;">
                涉黄人员搜索：
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="changPersonAttribute">
                    <option value="">涉黄人员属性</option>
                </select>
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="changMethod">
                    <option value="">涉黄方式</option>
                </select>
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="changType">
                    <option value="">涉黄类型</option>
                </select>
            </div>
            <div class="layui-inline" style="width:150px;">
                <select id="isMinorCase">
                    <option value="">未成年案件: 全部</option>
                    <option value="1">是</option>
                    <option value="0">否</option>
                </select>
            </div>


            <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
            <button type="button" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
            <script type="text/html" id="toolbarDemo">
                <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-1"></i>添 加
                </button>
                <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i
                        class="layui-icon  layui-icon-edit"></i>修 改
                </button>
                <c:if test='${fn:contains(param.buttons,"删除")}'>
                    <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i
                            class="layui-icon layui-icon-delete"></i>删 除
                    </button>
                </c:if>
<%--                <c:if test='${fn:contains(param.buttons,"导入")}'>--%>
<%--                    <button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导--%>
<%--                        入--%>
<%--                    </button>--%>
<%--                </c:if>--%>
<%--                <c:if test='${fn:contains(param.buttons,"导出")}'>--%>
<%--                    <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon">&#xe601;</i>导 出</button>--%>
<%--                </c:if>--%>
                <!-- 专项导出按钮始终显示，不受权限控制 -->
                <button type="button" class="layui-btn layui-btn-sm" lay-event="zxexport"><i class="layui-icon">&#xe601;</i>专项导出
                </button>
            </script>
            <script type="text/html" id="barButton">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>
            </script>
        </form>
    </div>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
<script>
    var locat = (window.location + '').split('/');
    var now = new Date();
    var thistitle = parent.$("li.layui-this").find("cite").text();
    $(function () {
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }
        ;
    });

    function fillOption(data) {
        var options = '';
        $.each(data.list, function (i, item) {
            $.each(item, function (i) {
                options += '<option value="' + this.text + '">' + this.text + '</option>';
            });
        });
        return options;
    }

    function getpersontype() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 20,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#persontype").append(options);
            }
        });
    }

    // 加载涉赌人员属性
    function loadDuPersonAttribute() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 301,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#duPersonAttribute").append(options);
            }
        });
    }

    // 加载涉赌方式
    function loadDuMethod() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 302,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#duMethod").append(options);
            }
        });
    }

    // 加载涉赌部位
    function loadDuPart() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 303,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#duPart").append(options);
            }
        });
    }

    // 加载涉黄人员属性
    function loadChangPersonAttribute() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 304,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#changPersonAttribute").append(options);
            }
        });
    }

    // 加载涉黄方式
    function loadChangMethod() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 305,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#changMethod").append(options);
            }
        });
    }

    // 加载涉黄类型
    function loadChangType() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 308,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#changType").append(options);
            }
        });
    }

    // 加载陪侍角色标签
    function loadPeiMemo() {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBMByTypeToJSON.do?basicType="/>' + 310,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                $("#peiMemo").append(options);
            }
        });
    }

    // 加载打处单位（江阴派出所列表，ID范围240-263）
    function loadHandleUnit() {
        // 创建全局映射表，预置47号
        window.policeStationMap = {
            '47': '治安大队'
        };

        $.ajax({
            type: 'GET',
            url: '<c:url value="/getJiangyinPoliceStations.do"/>',
            dataType: 'json',
            async: false,
            success: function (data) {
                console.log('打处单位接口返回数据：', data);

                // 接口直接返回数组
                var list = data;

                if (list && list.length > 0) {
                    var options = '';
                    var count = 0;
                    $.each(list, function (i, item) {
                        // 只显示ID在240-263范围内的派出所
                        if (item.departmentid >= 240 && item.departmentid <= 263) {
                            // 注意：字段名是 departname，不是 departmentname
                            options += '<option value="' + item.departmentid + '">' + item.departname + '</option>';
                            count++;

                            // 保存到全局映射表（用于表格显示）
                            window.policeStationMap[item.departmentid] = item.departname;
                        }
                    });

                    if (options) {
                        $("#handleUnitCode").append(options);
                        console.log('成功添加 ' + count + ' 个打处单位选项');
                        console.log('派出所映射表：', window.policeStationMap);

                        // 重新渲染 layui 表单，确保下拉框显示正常
                        if (window.layui && layui.form) {
                            layui.form.render('select');
                            console.log('已重新渲染 layui 表单');
                        }
                    } else {
                        console.warn('没有找到ID在240-263范围内的派出所');
                    }
                } else {
                    console.warn('接口返回的数据列表为空');
                }
            },
            error: function(xhr, status, error) {
                console.error('加载打处单位列表失败:', status, error);
            }
        });
    }

    function buildSearchParams() {
        var params = {
            zslabel1: ${param.personlabelid},
            cardnumber: $("#cardnumber").val(),
            personname: $("#personname").val(),
            homeplace: $("#homeplace").val(),
            jdunit1: $("input[name='jurisdictunit1']").val(),
            jdpolice1: $("#jurisdictpolice1").val(),
            persontype: $("#persontype").val(),
            attributelabels: $("input[name='attributelabels']").val(),
            hasSheduRecord: $("#hasSheduRecord").val(),
            hasSechangRecord: $("#hasSechangRecord").val(),
            isMinor: $("#isMinor").val(),
            handleUnitCode: isPoliceStation ? currentUserUnitId : $("#handleUnitCode").val(),
            duPersonAttribute: $("#duPersonAttribute").val(),
            duMethod: $("#duMethod").val(),
            duPart: $("#duPart").val(),
            changPersonAttribute: $("#changPersonAttribute").val(),
            changMethod: $("#changMethod").val(),
            changType: $("#changType").val(),
            isMinorCase: $("#isMinorCase").val(),
            punishDateStart: $("#punishDateStart").val().replace(/-/g, ""),
            punishDateEnd: $("#punishDateEnd").val().replace(/-/g, ""),
            peiMemo: $("#peiMemo").val()
        };

        // 将 null / undefined 统一转为空字符串，保留所有 key
        // 这样 layui table.reload 深度合并时，空字符串会覆盖上次搜索的旧值
        // 后端 iBatis <isNotEmpty> 会自动忽略空字符串，不影响查询
        Object.keys(params).forEach(function (key) {
            if (key === 'handleUnitCode' && isPoliceStation) return; // 派出所用户保留
            if (params[key] === null || params[key] === undefined) {
                params[key] = "";
            }
        });

        return params;
    }

    function resetForm() {

        /* ========== 1. 普通 input ========= */
        $("#cardnumber").val("");
        $("#personname").val("");
        $("#homeplace").val("");
        $("#punishDateStart").val("");
        $("#punishDateEnd").val("");

        /* ========== 2. select ========= */
        $("#isMinor").prop("selectedIndex", 0);
        $("#handleUnitCode").prop("selectedIndex", 0);
        $("#duPersonAttribute").prop("selectedIndex", 0);
        $("#duMethod").prop("selectedIndex", 0);
        $("#duPart").prop("selectedIndex", 0);
        $("#changPersonAttribute").prop("selectedIndex", 0);
        $("#changMethod").prop("selectedIndex", 0);
        $("#changType").prop("selectedIndex", 0);
        $("#isMinorCase").prop("selectedIndex", 0);
        $("#peiMemo").prop("selectedIndex", 0);

        /* ========== 3. 人员子标签（重点修复） ========= */
        if (_zTreeSelectM2) {
            // 使用插件提供的 set 方法，传入空数组即可清空已选、清空显示、重置内部状态
            _zTreeSelectM2.set([]);
        } else {
            // 兜底方案：如果插件实例没加载成功，尝试手动暴力清空
            $("input[name='attributelabels']").val("");
            var treeObj = $.fn.zTree.getZTreeObj("attributelabels_tree");
            if (treeObj) { treeObj.checkAllNodes(false); }
            $("#attributelabels").find(".zTreeSelectM-input").empty().append('<span class="zTreeSelectM-placeholder"> 人员子标签：</span>');
        }

        /* ========== 4. layui 表单重渲染 ========= */
        layui.form.render();
    }


    function emptySearchParams() {
        return {
            zslabel1: ${param.personlabelid},
            cardnumber: "",
            personname: "",
            homeplace: "",
            jdunit1: "",
            jdpolice1: "",
            persontype: "",
            attributelabels: "",
            hasSheduRecord: "",
            hasSechangRecord: "",
            isMinor: "",
            handleUnitCode: isPoliceStation ? currentUserUnitId : "",
            duPersonAttribute: "",
            duMethod: "",
            duPart: "",
            changPersonAttribute: "",
            changMethod: "",
            changType: "",
            isMinorCase: "",
            punishDateStart: "",
            punishDateEnd: "",
            peiMemo: ""
        };
    }




    $(document).ready(function () {
        getpersontype();
        loadDuPersonAttribute();
        loadDuMethod();
        loadDuPart();
        loadChangPersonAttribute();
        loadChangMethod();
        loadChangType();
        loadPeiMemo();
        loadHandleUnit();
    });

    // 获取当前登录用户的单位ID和单位名称
    var currentUserUnitId = '<%=userSession != null ? userSession.getLoginUserDepartmentid() : ""%>';
    var currentUserUnitName = '<%=userSession != null ? userSession.getLoginUserDepartname() : ""%>';
    var currentUserDepartCode = '<%=userSession != null ? userSession.getLoginDepartcode() : ""%>';

    // 判断当前用户是否属于派出所（departmentid在240-263范围内）
    var currentUserUnitIdNum = parseInt(currentUserUnitId);
    var isPoliceStation = !isNaN(currentUserUnitIdNum) && currentUserUnitIdNum >= 240 && currentUserUnitIdNum <= 263;

    layui.config({
        base: "<c:url value="/layui/lay/modules/"/>"
    }).extend({
        zTreeSelectM: "zTreeSelectM/zTreeSelectM"
    });
    var _zTreeSelectM2;
    layui.use(['table', 'form', 'zTreeSelectM', 'laydate'], function () {
        var table = layui.table,
            zTreeSelectM = layui.zTreeSelectM,
            form = layui.form,
            laydate = layui.laydate;

        // 加载打处单位列表（在 layui form 初始化之后）
        loadHandleUnit();

        // 处罚日期选择器
        laydate.render({
            elem: '#punishDateStart',
            type: 'date'
        });
        laydate.render({
            elem: '#punishDateEnd',
            type: 'date'
        });

         _zTreeSelectM2 = zTreeSelectM({
            elem: '#attributelabels',//元素容器【必填】
            data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid=' +${param.personlabelid},
            type: 'get',  //设置了长度
            selected: [],//默认值
            max: 100,//最多选中个数，默认5
            name: 'attributelabels',//input的name 不设置与选择器相同(去#.)
            delimiter: ',',//值的分隔符
            tips: ' 人员子标签：',
            field: {idName: 'id', titleName: 'name'},//候选项数据的键名
            zTreeSetting: { //zTree设置
                check: {
                    enable: true,
                    chkboxType: {"Y": "", "N": ""}
                },
                data: {
                    simpleData: {
                        enable: false
                    },
                    key: {
                        name: 'name',
                        children: 'children'
                    }
                },
                view: {
                    showIcon: false
                }
            }
        });
        // 如果是派出所用户，自动锁定打处单位下拉框
        if (isPoliceStation) {
            // 设置并锁定打处单位下拉框
            $("#handleUnitCode").val(currentUserUnitId);
            $("#handleUnitCode").prop("disabled", true);
            form.render("select");
        }

        // 构建初始查询参数（派出所用户自动过滤本单位）
        var initWhere = {zslabel1: ${param.personlabelid}};
        if (isPoliceStation) {
            initWhere.handleUnitCode = currentUserUnitId;
        }

        //方法级渲染
        table.render({
            elem: '#followTable',
            toolbar: true,
            defaultToolbar: ['filter', 'print'],
            url: '<c:url value="/searchZaPersonnel.do"/>',
            method: 'post',
            where: initWhere,
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', type: 'radio', fixed: 'true', align: "center"},
                {
                    field: 'personname', title: '姓名', width: 100, align: "center", templet: function (item) {
                        return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel(" + item.id + ");'><font color='blue'>" + item.personname + "</font></span>";
                    }
                },
                {field: 'cardnumber', title: '身份证号码', width: 180, align: "center"},
                {field: 'sexes', title: '性别', width: 100},
                {
                    field: 'officeName',
                    title: '年龄',
                    width: 100,
                    templet: function (item) {
                        var cardnumber = item.cardnumber;
                        if (!cardnumber) return '';

                        var year, month, day;
                        var len = cardnumber.length;
                        var now = new Date();

                        if (len === 15) {
                            var yy = parseInt(cardnumber.substring(6, 8), 10);
                            var currentYY = now.getFullYear() % 100;

                            // 世纪推断：关键修复点
                            year = yy > currentYY ? 1900 + yy : 2000 + yy;

                            month = parseInt(cardnumber.substring(8, 10), 10);
                            day = parseInt(cardnumber.substring(10, 12), 10);
                        } else if (len === 18) {
                            year = parseInt(cardnumber.substring(6, 10), 10);
                            month = parseInt(cardnumber.substring(10, 12), 10);
                            day = parseInt(cardnumber.substring(12, 14), 10);
                        } else {
                            return '';
                        }

                        var age = now.getFullYear() - year;

                        // 生日是否已过
                        if (
                            now.getMonth() + 1 < month ||
                            (now.getMonth() + 1 === month && now.getDate() < day)
                        ) {
                            age--;
                        }

                        return "<span>" + age + "</span>";
                    }
                },
                {field: 'houseplace', title: '户籍地址', width: 200, align: "center"},
                {field: 'homeplace', title: '现住地址', width: 200, align: "center"},
                {field: 'homepolice', title: '现住地派出所', width: 150, align: "center"},
                {
                    field: 'isMinorDisplay',
                    title: '是否未成年',
                    width: 100,
                    align: "center",
                    templet: function (item) {
                        // 根据年龄字段动态计算是否未成年
                        var cardnumber = item.cardnumber;
                        if (!cardnumber) return "<span>否</span>";

                        var year, month, day;
                        var len = cardnumber.length;
                        var now = new Date();

                        if (len === 15) {
                            var yy = parseInt(cardnumber.substring(6, 8), 10);
                            var currentYY = now.getFullYear() % 100;
                            year = yy > currentYY ? 1900 + yy : 2000 + yy;
                            month = parseInt(cardnumber.substring(8, 10), 10);
                            day = parseInt(cardnumber.substring(10, 12), 10);
                        } else if (len === 18) {
                            year = parseInt(cardnumber.substring(6, 10), 10);
                            month = parseInt(cardnumber.substring(10, 12), 10);
                            day = parseInt(cardnumber.substring(12, 14), 10);
                        } else {
                            return "<span>否</span>";
                        }

                        var age = now.getFullYear() - year;
                        if (
                            now.getMonth() + 1 < month ||
                            (now.getMonth() + 1 === month && now.getDate() < day)
                        ) {
                            age--;
                        }

                        // 小于18岁为未成年
                        if (age < 18) {
                            return "<span style='color:red;'>是</span>";
                        } else {
                            return "<span>否</span>";
                        }
                    }
                },
                // {
                //     field: 'hasSheduRecord', title: '涉赌前科', width: 100, align: "center", templet: function (item) {
                //         if (item.hasSheduRecord == 1) {
                //             return "<span style='color:red;'>有</span>";
                //         } else {
                //             return "<span>无</span>";
                //         }
                //     }
                // },
                // {
                //     field: 'hasSechangRecord',
                //     title: '涉黄前科',
                //     width: 100,
                //     align: "center",
                //     templet: function (item) {
                //         if (item.hasSechangRecord == 1) {
                //             return "<span style='color:red;'>有</span>";
                //         } else {
                //             return "<span>无</span>";
                //         }
                //     }
                // },
                {
                    field: 'policename2', title: '人员类型', width: 200, templet: function (item) {
                        var str = "";
                        if (item.zslabel2 && item.zslabel2 != "") {
                            var zslabel1s = item.zslabel2.split(",");
                            for (var i = 0; i < zslabel1s.length; i++) {
                                $.ajax({
                                    type: 'POST',
                                    url: '<c:url value="/getAttributeLabelByLabelid.do"/>',
                                    data: {
                                        id: zslabel1s[i]
                                    },
                                    dataType: 'json',
                                    async: false,
                                    success: function (data) {
                                        str += "<span><font color='red'>" + data.attributelabel + "&nbsp;&nbsp;</font></span>";
                                    }
                                });
                            }
                        }
                        return str;
                    }
                },
                {
                    field: 'handleUnitCode',
                    title: '打处单位',
                    width: 200,
                    align: "center",
                    templet: function (item) {
                        if (!item.handleUnitCode) return '';

                        var unitNames = [];
                        var hasNonPct = false; // 是否存在不在240-263范围的代码

                        // 分割多个单位代码
                        var codes = item.handleUnitCode.split(',');

                        for (var i = 0; i < codes.length; i++) {
                            var code = codes[i].trim();
                            if (!code) continue;
                            var codeNum = parseInt(code, 10);
                            // 判断是否在派出所范围 240-263
                            if (!isNaN(codeNum) && codeNum >= 240 && codeNum <= 263) {
                                // 派出所：显示对应名称
                                if (window.policeStationMap && window.policeStationMap[code]) {
                                    unitNames.push(window.policeStationMap[code]);
                                } else {
                                    unitNames.push(code);
                                }
                            } else {
                                // 不在240-263范围（包括47、50等），统一标记为"治安大队"（只显示一次）
                                hasNonPct = true;
                            }
                        }

                        // 若存在非派出所代码，在列表末尾追加"治安大队"（仅一次）
                        if (hasNonPct) {
                            unitNames.push('治安大队');
                        }

                        var unitName = unitNames.length > 0 ? unitNames.join('，') : item.handleUnitCode;

                        return "<span>" + unitName + "</span>";
                    }
                }
            ]],
            page: true,
            limit: 10
        });

        //监听行工具事件
        table.on('toolbar(followTable)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    var index = layui.layer.open({
                        title: "添加" + thistitle,
                        type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        content: '<c:url value="/jsp/personel/za/add.jsp"/>?menuid=${param.menuid}&zslabel1=${param.personlabelid}&typename=' + thistitle,
                        area: ['1000', '600px'],
                        maxmin: true,
                        success: function (layero, index) {
                            setTimeout(function () {
                                layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
                                    tips: 3
                                });
                            }, 500)
                        }
                    })
                    layui.layer.full(index);
                    break;
                case 'update':
                    var data = JSON.stringify(checkStatus.data);
                    var datas = JSON.parse(data);
                    if (datas != "") {
                        var id = datas[0].id;
                        var index = layui.layer.open({
                            title: "修改" + thistitle + "信息",
                            type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                            content: locat + '/getZaPersonById.do?id=' + id + '&buttons=${param.buttons }&menuid=${param.menuid }',
                            area: ['800', '750px'],
                            maxmin: true,
                            success: function (layero, index) {
                                setTimeout(function () {
                                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                                        tips: 3
                                    });
                                }, 500)
                            },
                            cancel: function () {
                                table.reload('followTable', {});
                            }
                        })
                        layui.layer.full(index);
                    } else {
                        layer.alert("请先选择修改哪条数据！");
                    }
                    break;
                case 'cancel':
                    var data = JSON.stringify(checkStatus.data);
                    var datas = JSON.parse(data);
                    if (datas != "") {
                        var id = datas[0].id;
                        layer.confirm('确定删除此' + thistitle + '信息？', function (index) {
                            layer.close(index);
                            $.getJSON(locat + "/cancelZaPerson.do?id=" + id + '&personnelid='+${param.personlabelid}+
                            "&menuid=" +${param.menuid }, {}, function (data) {
                                var str = eval('(' + data + ')');
                                if (str.flag == 1) {
                                    top.layer.msg("数据删除成功！");
                                    table.reload('followTable', {});
                                } else {
                                    top.layer.msg("删除失败!");
                                }
                            }
                        )
                            ;
                        });
                    } else {
                        layer.alert("请先选择删除哪条数据！");
                    }
                    break;
                case 'export':
                    var index = layui.layer.open({
                        title : thistitle+"信息导出",
                        type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        content : '<c:url value="/jsp/personel/za/export.jsp?menuid='+${param.menuid}+'&personlabelid='+${param.personlabelid}+'&personlabelname='+thistitle+'"/>',
                        area: ['1000px', '600px'],
                        maxmin: true,
                        success : function(layero, index){
                            setTimeout(function(){
                                layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                                    tips: 3
                                });
                            },500)
                        }
                    });
                    break;
                case 'zxexport':
                    var index = layui.layer.open({
                        title: thistitle + "专项信息导出",
                        type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        content: '<c:url value="/jsp/personel/za/zxexport.jsp?menuid='+${param.menuid}+'&personlabelid='+${param.personlabelid}+'&personlabelname='+thistitle+'"/>',
                        area: ['1000px', '600px'],
                        maxmin: true,
                        success: function (layero, index) {
                            setTimeout(function () {
                                layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                                    tips: 3
                                });
                            }, 500)
                        }
                    });
                    break;
                case 'import':
                    var index = layui.layer.open({
                        title: "导入" + thistitle + "信息",
                        type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        content: "<c:url value="/jsp/personel/custom/import.jsp?menuid=${param.menuid }&personlabelid=${param.personlabelid }"/>",
                        area: ['600', '650'],
                        maxmin: true,
                        offset: ['30'],
                        btn: ['导入', '关闭'],
                        yes: function (index, layero) {   //通过回调得到iframe的值
                            var body = layer.getChildFrame('body', index);//建立父子联系
                            var iframeWin = window[layero.find('iframe')[0]['name']];
                            body.find("#btns").click();
                        },
                        end: function () {
                            $("#search").click();
                        }
                    });
                    break;
            }
        });
        //搜索查询
        $("#search").on("click", function () {
            table.reload('followTable', {
                where: buildSearchParams(),
                page: { curr: 1 }
            });
        });

        $("#reset").on("click", function () {
            resetForm();

            table.reload('followTable', {
                where: emptySearchParams(),
                page: { curr: 1 }
            });
        });
    });

    function showinfoPersonnelExtend(id) {
        var index = layui.layer.open({
            title: thistitle + "详情",
            type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            content: locat + '/getPersonnelExtendUpdate.do?id=' + id + '&personlabelid='+${param.personlabelid}+
            '&memo='+thistitle + '&menuid='+${param.menuid}+
            '&page=showinfo',
            area: ['800', '750px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            }
        })
        layui.layer.full(index);
    }

    function showinfoPersonel(id) {
        var index = layui.layer.open({
            title: "治安人员详情",
            type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            content: locat + '/getZaPersonelInfo.do?personnelid=' + id + '&menuid=' +${param.menuid},
            area: ['800', '750px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            }
        })
        layui.layer.full(index);
    }


</script>
</body>

</html>