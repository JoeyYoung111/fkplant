<%@ page contentType='text/html;charset=UTF-8' language='java' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<%@ page import="com.aladdin.model.UserSession" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    UserSession userSession = (UserSession) session.getAttribute("userSession");
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
    <link rel="stylesheet" href="<c:url value="/js/tagtree/font-awesome-4.7.0/css/font-awesome.min.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/js/tagtree/tagTree.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>" media="all"/>
    <link rel="stylesheet" href="<c:url value="/js/swiper/swiper-bundle.min.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/tagtree/tagTree.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/swiper/swiper-bundle.min.js"/>"></script>

    <!-- ztree -->
    <script type="text/javascript" src="<c:url value="/jquery/ztree/jquery.ztree.all-3.5.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/jquery/ztree/zTreeStyle.css"/>"/>

    <!-- 头像编辑、关联信息 、社会关系 数据处理js - 需要在HTML前加载 -->
    <script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script>
    <style type="text/css">
        .layui-form-checkbox {
            position: relative;
            height: 30px;
            line-height: 30px;
            margin-right: 10px;
            padding-right: 30px;
            cursor: pointer;
            font-size: 0;
            -webkit-transition: .1s linear;
            transition: .1s linear;
            box-sizing: border-box;
            margin-top: 20px;
        }

        .layui-form-checkbox span {
            padding: 0 10px;
            /* height: 100%; */
            font-size: 14px;
            border-radius: 2px 0 0 2px;
            background-color: #4898ed;
            color: #fff;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        <%--		    width: 100px;--%> text-align: center;
        }

        .layui-form-checked span, .layui-form-checked:hover span {
            background-color: #5FB878;
        }

        /* 打处单位标签样式 */
        #handleUnitTags .layui-badge {
            display: inline-block;
            cursor: default;
        }

        #handleUnitTags .layui-icon-close:hover {
            color: #FF5722;
        }

        /* 修复小屏幕下左右tab重叠和滚动问题 */
        .layui-form.layui-row {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
            align-items: flex-start; /* 确保两栏从顶部对齐 */
            height: calc(100vh - 20px); /* 优化高度计算，确保不超出视口 */
        }

        .layui-form.layui-row > .layui-col-md6 {
            flex: 0 0 50%;
            min-width: 500px;
            max-width: 50%;
            overflow-y: auto !important; /* 强制启用垂直滚动 */
            overflow-x: hidden; /* 隐藏水平滚动条 */
            height: 100%; /* 使用父容器的完整高度 */
            min-height: 105%; /* 强制内容稍高于容器，确保滚动条可用 */
            padding-bottom: 100px !important; /* 底部留白100px，确保提交按钮可见 */
        }

        /* 右侧tab容器也需要独立滚动 */
        .layui-form.layui-row > .layui-col-md6 > .layui-tab {
            height: 100%;
            display: flex;
            flex-direction: column;
            min-height: 105%; /* 确保tab容器也有足够高度触发滚动 */
        }

        .layui-form.layui-row > .layui-col-md6 > .layui-tab > .layui-tab-content {
            flex: 1;
            overflow-y: auto !important; /* 强制启用滚动 */
            overflow-x: hidden;
            padding-bottom: 100px !important; /* 右侧tab内容底部留白 */
        }

        /* 在小屏幕下确保两栏并排显示，允许横向滚动 */
        @media screen and (max-width: 1200px) {
            .layui-form.layui-row {
                height: calc(100vh - 20px);
            }

            .layui-form.layui-row > .layui-col-md6 {
                flex: 0 0 600px;
                min-width: 500px;
                max-width: 600px;
            }
        }

        @media screen and (max-width: 768px) {
            .layui-form.layui-row {
                height: calc(100vh - 20px);
            }

            .layui-form.layui-row > .layui-col-md6 {
                flex: 0 0 500px;
                min-width: 450px;
                max-width: 500px;
            }
        }

        /* 确保左侧表单提交按钮可见 */
        .layui-form.layui-row > .layui-col-md6 form {
            min-height: 105%; /* 强制内容高度超出容器 */
            padding-bottom: 100px !important; /* 底部留白100px */
        }

        /* 确保右侧tab内的表单提交按钮可见 */
        .layui-form.layui-row > .layui-col-md6 .layui-tab-content form {
            min-height: 105%;
            padding-bottom: 200px !important;
        }
    </style>
</head>
<body class="childrenBody layui-fluid">

<div class="layui-form layui-row">
    <!-- 左边表单 -->
    <div class="layui-col-md6" style="border-right: 1px solid #eee">
        <!-- 基本信息 -->
        <form class="layui-form" method="post" id="formZa">
            <input type="hidden" name="menuid" id="menuid" value=${menuid }>
            <input type="hidden" name="policephone1" value="${personnel.pphone1}">
            <input type="hidden" name="id" id="id" value=${personnel.id }>
            <input type="hidden" name="zslabel1" id="zslabel1" value=${personnel.zslabel1 }>
            <input type="hidden" id="hasPhoto" value="0">
            <div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
                <div class="layui-inline layui-col-md12">
                    <label class="layui-form-label layui-font-blue">基本信息：</label>
                </div>
                <div class=" my-onload-img layui-col-md2" style="height: 260px;">
                    <img id="defaultPhoto">
                    <a class="my-font-blue" style="text-decoration: underline;cursor:pointer;" onclick="openPhotos()">编
                        辑</a>
                    <span style="color:red;font-weight:bold;margin-left:5px;">*必填</span>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">身份证号：</label>
                        <div class="layui-input-block">
                            <input type="text" autocomplete="off" style="background:#efefef"
                                   value="${personnel.cardnumber}" readonly class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">姓名：</label>
                        <div class="layui-input-block">
                            <%--									<input type="text" autocomplete="off" style="background:#efefef"--%>
                            <%--										value="${personnel.personname}" readonly class="layui-input">--%>
                            <input type="text" name="personname" autocomplete="off" value="${personnel.personname}"
                                   class="layui-input">
                        </div>
                    </div>
                </div>

                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">性别：</label>
                        <div class="layui-input-block">
                            <input type="text" autocomplete="off" style="background:#efefef"
                                   value="${personnel.sexes}" readonly class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">年龄：</label>
                        <div class="layui-input-block">
                            <input type="text" autocomplete="off" style="background:#efefef"
                                   value="${age}" readonly class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">曾用名：</label>
                        <div class="layui-input-block">
                            <input type="text" name="usedname" lay-verify="" autocomplete="off"
                                   value="${personnel.usedname}" placeholder="请输入曾用名" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">绰号：</label>
                        <div class="layui-input-block">
                            <input type="text" name="nickname" lay-verify="" autocomplete="off"
                                   value="${personnel.nickname}" placeholder="请输入绰号" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">身高：</label>
                        <div class="layui-input-block">
                            <input type="text" name="personheight" lay-verify="" autocomplete="off"
                                   value="${personnel.personheight}" placeholder="请输入身高" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">婚姻状况：</label>
                        <div class="layui-input-block">
                            <select name="marrystatus">
                                <option value="">==请选择==</option>
                                <c:forEach items="${marrystatus}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.marrystatus }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">民族：</label>
                        <div class="layui-input-block">
                            <select name="nation" lay-search>
                                <option value="">==请选择==</option>
                                <c:forEach items="${nation}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.nation }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">人员类别：</label>
                        <div class="layui-input-block">
                            <select name="persontype">
                                <option value="">==请选择==</option>
                                <c:forEach items="${persontype}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.persontype }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">兵役状况：</label>
                        <div class="layui-input-block">
                            <select name="soldierstatus">
                                <option value="">==请选择==</option>
                                <c:forEach items="${soldierstatus}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.soldierstatus }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">健康状态：</label>
                        <div class="layui-input-block">
                            <select name="heathstatus">
                                <option value="">==请选择==</option>
                                <c:forEach items="${heathstatus}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.heathstatus }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">政治面貌：</label>
                        <div class="layui-input-block">
                            <select name="politicalposition">
                                <option value="">==请选择==</option>
                                <c:forEach items="${politicalposition}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.politicalposition }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">宗教信仰：</label>
                        <div class="layui-input-block">
                            <select name="faith">
                                <option value="">==请选择==</option>
                                <c:forEach items="${faith}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.faith }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">文化程度：</label>
                        <div class="layui-input-block">
                            <select name="education">
                                <option value="">==请选择==</option>
                                <c:forEach items="${education}" var="row" varStatus="num">
                                    <option value="${row.basicName}"
                                            <c:if test="${row.basicName == personnel.education }">selected</c:if>>${row.basicName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">网络社交技能习惯：</label>
                        <div class="layui-input-block">
                            <select name="netskillhabit">
                                <option value="" <c:if test="${personnel.netskillhabit eq ''}">selected</c:if>>
                                    ==请选择==
                                </option>
                                <option value="有" <c:if test="${personnel.netskillhabit eq '有'}">selected</c:if>>有
                                </option>
                                <option value="无" <c:if test="${personnel.netskillhabit eq '无'}">selected</c:if>>无
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
                <!-- 涉赌前科和涉黄前科显示（自动根据历史记录填充） -->
                <!-- 隐藏字段：已移至各自tab中，基本信息提交时不提交这两个字段 -->
                <div class="layui-col-md6" style="display:none;">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">涉赌前科：</label>
                        <div class="layui-input-block">
                            <c:choose>
                                <c:when test="${duEditable == false}">
                                    <select disabled="disabled" style="background:#efefef; width:100px;">
                                        <option value="1" selected>有</option>
                                    </select>
                                    <span class="layui-form-mid" style="color:#FF5722;font-size:12px;">该人员存在涉赌记录，涉赌前科由系统自动判定，不可修改</span>
                                </c:when>
                                <c:otherwise>
                                    <select disabled="disabled">
                                        <option value="0"
                                                <c:if test="${personnel.hasSheduRecord == 0}">selected</c:if>>无
                                        </option>
                                        <option value="1"
                                                <c:if test="${personnel.hasSheduRecord == 1}">selected</c:if>>有
                                        </option>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6" style="display:none;">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">涉黄前科：</label>
                        <div class="layui-input-block">
                            <c:choose>
                                <c:when test="${changEditable == false}">
                                    <select disabled="disabled" style="background:#efefef; width:100px;">
                                        <option value="1" selected>有</option>
                                    </select>
                                    <span class="layui-form-mid" style="color:#FF5722;font-size:12px;">该人员存在涉黄记录，涉黄前科由系统自动判定，不可修改</span>
                                </c:when>
                                <c:otherwise>
                                    <select disabled="disabled">
                                        <option value="0"
                                                <c:if test="${personnel.hasSechangRecord == 0}">selected</c:if>>无
                                        </option>
                                        <option value="1"
                                                <c:if test="${personnel.hasSechangRecord == 1}">selected</c:if>>有
                                        </option>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
<%--                <div class="layui-col-md6">--%>
<%--                    <div class="layui-form-item my-form-item">--%>
<%--                        <label class="layui-form-label">是否陪侍人员：</label>--%>
<%--                        <div class="layui-input-block">--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${peiEditable == false}">--%>
<%--                                    <select name="isPeishi" disabled="disabled" style="background:#efefef; width:100px;">--%>
<%--                                        <option value="1" selected>是</option>--%>
<%--                                    </select>--%>
<%--                                    <input type="hidden" name="isPeishi" value="1"/>--%>
<%--                                    <span class="layui-form-mid" style="color:#FF5722;font-size:12px;">该人员存在陪侍记录，由系统自动判定，不可修改</span>--%>
<%--                                </c:when>--%>
<%--                                <c:otherwise>--%>
<%--                                    <select name="isPeishi" style="width:100px;">--%>
<%--                                        <option value="0"--%>
<%--                                                <c:if test="${personnel.isPeishi == 0 || personnel.isPeishi == null}">selected</c:if>>否--%>
<%--                                        </option>--%>
<%--                                        <option value="1"--%>
<%--                                                <c:if test="${personnel.isPeishi == 1}">selected</c:if>>是--%>
<%--                                        </option>--%>
<%--                                    </select>--%>
<%--                                </c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">是否未成年：</label>
                        <div class="layui-input-block">
                            <!-- 是否未成年：动态计算，不可修改 -->
                            <select name="isMinor" disabled="disabled" style="background:#efefef;">
                                <option value="0" <c:if test="${isMinorCalculated == 0}">selected</c:if>>否</option>
                                <option value="1" <c:if test="${isMinorCalculated == 1}">selected</c:if>>是</option>
                            </select>
                            <input type="hidden" name="isMinor" value="${isMinorCalculated}"/>
                            <span class="layui-form-mid"
                                  style="color:#1E9FFF;font-size:12px;">根据身份证号动态计算，不可修改</span>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">打处单位：</label>
                        <div class="layui-input-block">
                            <!-- 可编辑区域（仅限有权限的用户） -->
                            <div id="handleUnitEditArea" style="display: none;">
                                <div style="display: flex; align-items: center;">
                                    <select id="handleUnitSelect" lay-filter="handleUnitSelect" style="flex: 1;">
                                        <option value="">请选择打处单位</option>
                                    </select>
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal"
                                            id="addHandleUnitBtn" style="margin-left: 5px;"><i
                                            class="layui-icon">&#xe654;</i>添加
                                    </button>
                                </div>
                                <div id="handleUnitTags" style="margin-top: 5px;"></div>
                                <span class="layui-form-mid" style="color:#999;font-size:12px;">最多添加3个打处单位</span>
                            </div>
                            <!-- 只读显示区域（无权限用户） -->
                            <div id="handleUnitReadOnlyArea" style="display: none;">
                                <span id="handleUnitDisplayText" style="line-height: 38px; color: #333;"></span>
                                <span class="layui-form-mid" style="color:#FF5722;font-size:12px;">（您无权修改此字段）</span>
                            </div>
                            <input type="hidden" name="handleUnit" id="handleUnit" value="${personnel.handleUnit}">
                            <input type="hidden" name="handleUnitCode" id="handleUnitCode"
                                   value="${personnel.handleUnitCode}">
                        </div>
                    </div>
                </div>
            </div>
            <!-- 户籍地结构化 -->
            <div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
                <div class="layui-col-md12">
                    <label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">户籍地址：</label>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">省：</label>
                        <div class="layui-input-block">
                            <select name="houseProvince" id="houseProvince" lay-filter="houseProvince">
                                <option value="">请选择省份</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">地级市：</label>
                        <div class="layui-input-block">
                            <select name="houseCity" id="houseCity" lay-filter="houseCity">
                                <option value="">请选择地级市</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">县级市：</label>
                        <div class="layui-input-block">
                            <select name="houseCounty" id="houseCounty" lay-filter="houseCounty">
                                <option value="">请选择县级市/区</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">镇街：</label>
                        <div class="layui-input-block">
                            <input type="text" name="houseTown" id="houseTown" value="${personnel.houseTown}"
                                   placeholder="镇/街道" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">户籍地详址：</label>
                        <div class="layui-input-block">
                            <input type="text" name="houseplace" lay-verify="" autocomplete="off"
                                   value="${personnel.houseplace}" placeholder="请输入户籍地详址" class="layui-input"
                                   id="houseplace" onclick="openPGis('house','户籍地');" readonly
                                   style="background:#efefef;cursor:pointer;">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">户籍地派出所：</label>
                        <div class="layui-input-block">
                            <select id="housepolice"
                                    name="housepolice"
                                    lay-filter="housepolice">
                                <option value="">请选择户籍地派出所</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">户籍地经度：</label>
                        <div class="layui-input-block">
                            <input type="text" name="housex" lay-verify="" autocomplete="off"
                                   value="${personnel.housex}" class="layui-input" id="housex"
                                   onclick="openPGis('house','户籍地');" readonly
                                   style="background:#efefef;cursor:pointer;">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">户籍地纬度：</label>
                        <div class="layui-input-block">
                            <input type="text" name="housey" lay-verify="" autocomplete="off"
                                   value="${personnel.housey}" class="layui-input" id="housey"
                                   onclick="openPGis('house','户籍地');" readonly
                                   style="background:#efefef;cursor:pointer;">
                        </div>
                    </div>
                </div>
            </div>
            <!-- 现住地结构化 -->
            <div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
                <div class="layui-col-md12">
                    <label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
                    <button type="button" class="layui-btn layui-btn-xs layui-btn-warm" style="margin-left:10px;"
                            onclick="showAddressHistory(${personnel.id})"><i class="layui-icon">&#xe68d;</i>历史住址
                    </button>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">省：</label>
                        <div class="layui-input-block">
                            <select name="homeProvince" id="homeProvince" lay-filter="homeProvince">
                                <option value="">请选择省份</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">地级市：</label>
                        <div class="layui-input-block">
                            <select name="homeCity" id="homeCity" lay-filter="homeCity">
                                <option value="">请选择地级市</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">县级市：</label>
                        <div class="layui-input-block">
                            <select name="homeCounty" id="homeCounty" lay-filter="homeCounty">
                                <option value="">请选择县级市/区</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">镇街：</label>
                        <div class="layui-input-block">
                            <input type="text" name="homeTown" id="homeTown" value="${personnel.homeTown}"
                                   placeholder="镇/街道"
                                   class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">现住地详址：</label>
                        <div class="layui-input-block">
                            <input type="text" name="homeplace" lay-verify="" autocomplete="off"
                                   value="${personnel.homeplace}" placeholder="请输入现住地详址" class="layui-input"
                                   id="homeplace" onclick="openPGis('home','现住地');" readonly
                                   style="background:#efefef;cursor:pointer;">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6" id="homepolice_div">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">现住地派出所：<span id="homepolice-required"
                                                                                          style="color:red;display:none;">*</span></label>
                        <div class="layui-input-block">
                            <select id="homepolice"
                                    name="homepolice"
                                    lay-filter="homepolice">
                                <option value="">请选择现住地派出所</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">现住地经度：</label>
                        <div class="layui-input-block">
                            <input type="text" name="homex" lay-verify="" autocomplete="off"
                                   value="${personnel.homex}" class="layui-input" id="homex"
                                   onclick="openPGis('home','户籍地');" readonly
                                   style="background:#efefef;cursor:pointer;">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">现住地纬度：</label>
                        <div class="layui-input-block">
                            <input type="text" name="homey" lay-verify="" autocomplete="off"
                                   value="${personnel.homey}" class="layui-input" id="homey"
                                   onclick="openPGis('home','户籍地');" readonly
                                   style="background:#efefef;cursor:pointer;">
                        </div>
                    </div>
                </div>
            </div>
            <!-- 其他信息 -->
            <div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
                <div class="layui-col-md12">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">特殊特征：</label>
                        <div class="layui-input-block">
                            <input type="text" name="feature" lay-verify="" autocomplete="off"
                                   value="${personnel.feature}" placeholder="请输入特殊特征" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">技能专长：</label>
                        <div class="layui-input-block">
                            <input type="text" name="speciality" lay-verify="" autocomplete="off"
                                   value="${personnel.speciality}" placeholder="请输入技能专长" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label my-text-nowarp">前科劣迹：</label>
                        <div class="layui-input-block">
                            <input type="text" name="records" lay-verify="" autocomplete="off"
                                   value="${personnel.records}" placeholder="请输入前科劣迹" class="layui-input">
                        </div>
                    </div>
                </div>
            </div>

            <!-- 打处单位处理确认模块 -->
            <div id="dealUnitConfirmSection"
                 style="display:none; border-top: 1px solid #eee; padding: 15px; margin: 15px 0; background-color: #f8f8f8;">
                <div style="display: flex; flex-wrap: nowrap; align-items: center;">
                    <span style="color:#FF5722;font-weight:bold;white-space:nowrap;">打处单位处理确认：</span>
                    <span id="currentUnitNameDisplay"
                          style="color: #333; font-weight: bold; margin: 0 15px; white-space:nowrap;"></span>
                    <span style="white-space:nowrap;margin-right:10px;">是否已处理：</span>
                    <input type="radio" name="dealUnitHandled" value="0" title="否" checked>
                    <input type="radio" name="dealUnitHandled" value="1" title="是">
                    <span style="margin-left: 15px; color: #999; font-size: 12px; white-space:nowrap;">
                        <i class="layui-icon layui-icon-tips" style="color: #FFB800;"></i>
                        选择「是」后当前单位将从打处单位列表中移除
                    </span>
                </div>
            </div>

            <div class="layui-col-md4 layui-col-md-offset6" style="margin-bottom: 30px;margin-top: 30px;">
                <div class="layui-form-item my-form-item">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="updateZa">立即提交</button>
                </div>
            </div>
        </form>
        <div style="height:100px;"></div>
    </div>

    <!-- 右边表单 -->
    <div class="layui-col-md6">
        <div class="layui-tab" lay-filter="dev_tab">
            <div style="position: relative;">
                <div #swiperRef="" class="swiper mySwiperS  layui-tab-title btn-list swiper-container"
                     style="margin: 0 30px;width: auto !important;">
                    <div class="swiper-wrapper" style="width:85px;height: 80px;">
                        <li class="btn btn_2 layui-this swiper-slide" onclick="openZaDu(${personnel.id})">涉赌背景</li>
                        <li class="btn btn_6 swiper-slide" onclick="openZaChang(${personnel.id})">涉黄背景</li>
                        <li class="btn btn_13 swiper-slide" onclick="openZaPei(${personnel.id})">陪侍记录</li>
                        <li class="btn btn_11 swiper-slide" onclick="openAttributelabel()">人员属性标签</li>
                        <li class="btn btn_1 swiper-slide">关联信息</li>
                        <li class="btn btn_4 swiper-slide" onclick="openTrajectoryKK('${personnel.cardnumber}','');">
                            轨迹信息
                        </li>
                        <li class="btn btn_3 swiper-slide" onclick="openSocialRelations(${personnel.id});">社会关系</li>
                        <li class="btn btn_12 swiper-slide" onclick="openzajqxx('${personnel.cardnumber}')">涉警涉案</li>
                        <li class="btn btn_7 swiper-slide" onclick="openGoodsShow(${personnel.id})">关联物品</li>
                        <li class="btn btn_5 swiper-slide" id="zaextendButton" onclick="openZaExtend(${personnel.id});">
                            更多信息
                        </li>
                        <div class="swiper-slide"></div>
                    </div>
                </div>
                <div class="my-swiper-button-next swiper-button-next1"></div>
                <div class="my-swiper-button-prev swiper-button-prev1"></div>
            </div>
            <div class="layui-tab-content">
                <div class="right-child-content layui-tab-item layui-show">
                    <form class="layui-form" method="post" id="formZaDu" onsubmit="return false;">
                        <input type="hidden" id="firstDu" value=0>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <button class="layui-btn layui-btn-sm" id="duHistory"><i
                                        class="layui-icon">&#xe68d;</i>历史记录
                                </button>
                                <label class="my-form-label-br">关联案件</label>
                                <div class="my-input-block" style="display:flex;align-items:center;">
                                    <input type="hidden" name="relatedCaseId"
                                           id="du_relatedCaseId" value="">
                                    <input type="text" id="du_caseName"
                                           autocomplete="off" placeholder="点击右侧按钮选择关联警情/案件"
                                           class="layui-input" readonly
                                           style="flex:1;background:#efefef;cursor:default;">
                                    <button type="button" class="layui-btn layui-btn-normal layui-btn-sm"
                                            onclick="selectdujqaj('${personnel.cardnumber}', $('#firstDu').val())"
                                            style="margin-left:10px;">
                                        <i class="layui-icon layui-icon-add-1"></i> 选择
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉赌情况综述
                                    <button class="layui-btn layui-btn-sm" id="duHistory"><i
                                            class="layui-icon">&#xe68d;</i>历史记录
                                    </button>
                                </label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="lssdqk" name="lssdqk" lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集来源</label>
                                <div class="my-input-block" id="collectSource-du-div">
                                    <select id="collectSource-du" name="collectSource" lay-filter="collectSource-du"
                                            lay-verify=""
                                            lay-reqdiv="collectSource-du-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集日期</label>
                                <div class="my-input-block">
                                    <input type="text" name="collectDate" id="du_collectDate" autocomplete="off"
                                           placeholder="年-月-日" class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">人员属性</label>
                                <div class="my-input-block" id="personAttribute-du-div">
                                    <select id="personAttribute-du" name="personAttribute"
                                            lay-filter="personAttribute-du"
                                            lay-verify="personAttribute-du" lay-reqdiv="personAttribute-du-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉赌方式</label>
                                <div class="my-input-block" id="dbfs-div">
                                    <select id="dbfs" name="dbfs" lay-filter="dbfs" lay-verify="dbfs"
                                            lay-reqdiv="dbfs-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉赌部位</label>
                                <div class="my-input-block" id="dbbw-div">
                                    <select id="dbbw" name="dbbw" lay-filter="dbbw" lay-verify="dbbw"
                                            lay-reqdiv="dbbw-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!-- 涉赌前科字段 -->
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"><span style="color:red;">*</span>涉赌前科</label>
                                <div class="my-input-block" id="hasSheduRecord-du-div">
                                    <select id="hasSheduRecord-du" name="hasSheduRecord" lay-filter="hasSheduRecord-du"
                                            lay-verify="hasSheduRecord-du" lay-reqdiv="hasSheduRecord-du-div">
                                        <option value="">==请选择==</option>
                                        <option value="0">无</option>
                                        <option value="1">有</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">手机号码</label>
                                <div class="my-input-block">
                                    <input type="text" name="phone" id="du_phone" autocomplete="off"
                                           placeholder="请输入手机号码" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处罚情况</label>
                                <div class="my-input-block" id="cfjg-div">
                                    <select name="cfjg" id="cfjg" lay-verify="cfjg" lay-reqdiv="cfjg-div">
                                        <option value="">==请选择==</option>
                                        <option value="刑事处罚">刑事处罚</option>
                                        <option value="行政拘留并处罚款">治安拘留并处罚款</option>
                                        <option value="治安拘留">治安拘留</option>
                                        <option value="罚款">罚款</option>
                                        <option value="不予治安处罚">不予治安处罚</option>
                                        <option value="保证金取保候审">保证金取保候审</option>
                                        <option value="保证人取保候审">保证人取保候审</option>
                                        <option value="监视居住">监视居住</option>
                                        <option value="行政拘留">行政拘留</option>
                                        <option value="行政拘留并处罚款">行政拘留并处罚款</option>
                                        <option value="行政拘留（不予执行）">行政拘留（不予执行）</option>
                                        <option value="行政拘留（不予执行）并处罚款">行政拘留（不予执行）并处罚款</option>
                                        <option value="不予行政处罚">不予行政处罚</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处罚日期
                                </label>
                                <div class="my-input-block">
                                    <input type="text" name="chsj" id="chsj" lay-verify="chsj"
                                           lay-reqtext="请选择处罚日期" autocomplete="off" placeholder="年-月-日"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <!-- 打处单位字段 -->
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">打处单位</label>
                                <div class="my-input-block">
                                    <input type="text" id="du_handleUnit" autocomplete="off"
                                           placeholder="自动填充当前用户所属单位" class="layui-input"
                                           readonly style="background:#efefef;">
                                    <input type="hidden" id="du_handleUnitCode" name="handleUnitCode" value="">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">省：</label>
                                <div class="layui-input-block">
                                    <select id="du_homeProvince" lay-filter="du_homeProvince">
                                        <option value="">请选择省份</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">地级市：</label>
                                <div class="layui-input-block">
                                    <select id="du_homeCity" lay-filter="du_homeCity">
                                        <option value="">请选择地级市</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">县级市：</label>
                                <div class="layui-input-block">
                                    <select id="du_homeCounty" lay-filter="du_homeCounty">
                                        <option value="">请选择县级市/区</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">镇街：</label>
                                <div class="layui-input-block"><input type="text" id="du_homeTown"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">详细地址：</label>
                                <div class="layui-input-block">
                                    <input type="text" lay-verify="" autocomplete="off"
                                           placeholder="请输入现住地详址" class="layui-input"
                                           id="du_homeplace" onclick="openPGisDu('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6" id="du_homepolice_div">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地派出所：<span
                                        id="du_homepolice-required" style="color:red;display:none;">*</span></label>
                                <div class="layui-input-block">
                                    <select id="du_policeStation"
                                            lay-filter="du_policeStation">
                                        <option value="">请选择派出所</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地经度：</label>
                                <div class="layui-input-block">
                                    <input type="text" lay-verify="" autocomplete="off"
                                           class="layui-input" id="du_homex"
                                           onclick="openPGisDu('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地纬度：</label>
                                <div class="layui-input-block">
                                    <input type="text" lay-verify="" autocomplete="off"
                                           class="layui-input" id="du_homey"
                                           onclick="openPGisDu('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>




                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"
                                       style="display: inline-block; float: left;">涉案地址：</label>

                                <span class="layui-word-aux"
                                      style="display: inline-block; line-height: 38px; margin-left: 10px;">
                                        最多填写 5 个
                                </span>

                                <div class="my-input-block" id="duCaseAddressContainer">
                                    <!-- 这里只放 address-row -->
                                </div>

                                <div class="my-input-block" style="margin-top: 5px;">
                                    <!-- ✅ 改为使用 onclick 内联方式 -->
                                    <button type="button"
                                            class="layui-btn layui-btn-sm"
                                            id="addDuCaseAddressBtn"
                                            onclick="handleAddDuCaseAddress()">
                                        + 新增地址
                                    </button>
                                </div>
                            </div>
                        </div>


                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">查获经过</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chjg" name="chjg" lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处理详情</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="clxq" name="clxq" lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>





                        <div class="layui-col-md3 layui-col-md-offset5">
                            <div class="layui-form-item my-form-item" style="padding: 15px;">
                                <button id="duSub" type="submit" class="layui-btn" lay-submit="" lay-filter="duSub">
                                    立即提交
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="right-child-content layui-tab-item">
                    <form class="layui-form" method="post" id="formZaChang" onsubmit="return false;">
                        <input type="hidden" id="firstChang" value=0>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <button class="layui-btn layui-btn-sm" id="changHistory" style="display:none;"><i
                                        class="layui-icon">&#xe68d;</i>历史记录
                                </button>
                                <label class="my-form-label-br">关联案件</label>
                                <div class="my-input-block" style="display:flex;align-items:center;">
                                    <input type="hidden" name="relatedCaseId"
                                           id="chang_relatedCaseId" value="">
                                    <input type="text" id="chang_caseName"
                                           autocomplete="off" placeholder="点击右侧按钮选择关联警情/案件"
                                           class="layui-input" readonly
                                           style="flex:1;background:#efefef;cursor:default;">
                                    <button type="button" class="layui-btn layui-btn-normal layui-btn-sm"
                                            onclick="selectchangjqaj('${personnel.cardnumber}', $('#firstchang').val())"
                                            style="margin-left:10px;">
                                        <i class="layui-icon layui-icon-add-1"></i> 选择
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉黄情况综述
                                    <button class="layui-btn layui-btn-sm" id="changHistory" style="display:none;"><i
                                            class="layui-icon">&#xe68d;</i>历史记录
                                    </button>
                                </label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_lsscqk" name="chang_lsscqk" lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集来源</label>
                                <div class="my-input-block" id="collectSource-chang-div">
                                    <select id="collectSource-chang" name="collectSource"
                                            lay-filter="collectSource-chang"
                                            lay-verify=""
                                            lay-reqdiv="collectSource-chang-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集日期</label>
                                <div class="my-input-block">
                                    <input type="text" name="collectDate" id="chang_collectDate" autocomplete="off"
                                           placeholder="年-月-日" class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">人员属性</label>
                                <div class="my-input-block" id="chang_scjs-div">
                                    <select id="chang_scjs" name="chang_scjs"
                                            lay-filter="chang_scjs"
                                            lay-verify="chang_scjs" lay-reqdiv="chang_scjs-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉黄方式</label>
                                <div class="my-input-block" id="chang_myfs-div">
                                    <select id="chang_myfs" name="chang_myfs" lay-filter="chang_myfs"
                                            lay-verify="chang_myfs"
                                            lay-reqdiv="chang_myfs-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉黄类型</label>
                                <div class="my-input-block" id="changType-div">
                                    <select id="changType" name="changType" lay-filter="changType"
                                            lay-verify="changType"
                                            lay-reqdiv="changType-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!-- 涉黄前科字段 -->
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"><span style="color:red;">*</span>涉黄前科</label>
                                <div class="my-input-block" id="hasShechangRecord-chang-div">
                                    <select id="hasShechangRecord-chang" name="hasShechangRecord" lay-filter="hasShechangRecord-chang"
                                            lay-verify="hasShechangRecord-chang" lay-reqdiv="hasShechangRecord-chang-div">
                                        <option value="">==请选择==</option>
                                        <option value="0">无</option>
                                        <option value="1">有</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">手机号码</label>
                                <div class="my-input-block">
                                    <input type="text" name="phone" id="chang_phone" autocomplete="off"
                                           placeholder="请输入手机号码" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处罚情况</label>
                                <div class="my-input-block" id="chang_cfjg-div">
                                    <select name="chang_cfjg" id="chang_cfjg" lay-verify="chang_cfjg"
                                            lay-reqdiv="chang_cfjg-div">
                                        <option value="">==请选择==</option>
                                        <option value="刑事处罚">刑事处罚</option>
                                        <option value="行政拘留并处罚款">治安拘留并处罚款</option>
                                        <option value="治安拘留">治安拘留</option>
                                        <option value="罚款">罚款</option>
                                        <option value="不予治安处罚">不予治安处罚</option>
                                        <option value="保证金取保候审">保证金取保候审</option>
                                        <option value="保证人取保候审">保证人取保候审</option>
                                        <option value="监视居住">监视居住</option>
                                        <option value="行政拘留">行政拘留</option>
                                        <option value="行政拘留并处罚款">行政拘留并处罚款</option>
                                        <option value="行政拘留（不予执行）">行政拘留（不予执行）</option>
                                        <option value="行政拘留（不予执行）并处罚款">行政拘留（不予执行）并处罚款</option>
                                        <option value="不予行政处罚">不予行政处罚</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处罚时间
                                </label>
                                <div class="my-input-block">
                                    <input type="text" name="chang_chsj" id="chang_chsj" lay-verify="chang_chsj"
                                           lay-reqtext="请选择处罚时间" autocomplete="off" placeholder="年-月-日"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <!-- 打处单位字段 -->

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">是否未成年案件</label>
                                <div class="my-input-block">
                                    <input type="radio" name="isMinorCase" value="0"
                                           title="否" checked>
                                    <input type="radio" name="isMinorCase" value="1"
                                           title="是">
                                    <span
                                            style="color:#999;font-size:12px;">(系统根据处罚时间自动计算)</span>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">打处单位</label>
                                <div class="my-input-block">
                                    <input type="text" id="chang_handleUnit" autocomplete="off"
                                           placeholder="自动填充当前用户所属单位" class="layui-input"
                                           readonly style="background:#efefef;">
                                    <input type="hidden" id="chang_handleUnitCode" name="handleUnitCode" value="">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12">
                            <label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">省：</label>
                                <div class="layui-input-block">
                                    <select id="chang_homeProvince" lay-filter="chang_homeProvince">
                                        <option value="">请选择省份</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">地级市：</label>
                                <div class="layui-input-block">
                                    <select id="chang_homeCity" lay-filter="chang_homeCity">
                                        <option value="">请选择地级市</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">县级市：</label>
                                <div class="layui-input-block">
                                    <select id="chang_homeCounty" lay-filter="chang_homeCounty">
                                        <option value="">请选择县级市/区</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">镇街：</label>
                                <div class="layui-input-block"><input type="text" id="chang_homeTown"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">详细地址：</label>
                                <div class="layui-input-block">
                                    <input type="text" lay-verify="" autocomplete="off"
                                           placeholder="请输入现住地详址" class="layui-input"
                                           id="chang_homeplace" onclick="openPGisChang('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6" id="chang_homepolice_div">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地派出所：<span
                                        id="chang_homepolice-required" style="color:red;display:none;">*</span></label>
                                <div class="layui-input-block">
                                    <select id="chang_policeStation"
                                            lay-filter="chang_policeStation">
                                        <option value="">请选择派出所</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地经度：</label>
                                <div class="layui-input-block">
                                    <input type="text" lay-verify="" autocomplete="off"
                                           class="layui-input" id="chang_homex"
                                           onclick="openPGisChang('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地纬度：</label>
                                <div class="layui-input-block">
                                    <input type="text" lay-verify="" autocomplete="off"
                                           class="layui-input" id="chang_homey"
                                           onclick="openPGisChang('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>




                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"
                                       style="display: inline-block; float: left;">涉案地址：</label>

                                <span class="layui-word-aux"
                                      style="display: inline-block; line-height: 38px; margin-left: 10px;">
                                        最多填写 5 个
                                </span>

                                <div class="my-input-block" id="changCaseAddressContainer">
                                    <!-- 这里只放 address-row -->
                                </div>

                                <div class="my-input-block" style="margin-top: 5px;">
                                    <!-- ✅ 改为使用 onclick 内联方式 -->
                                    <button type="button"
                                            class="layui-btn layui-btn-sm"
                                            id="addchangCaseAddressBtn"
                                            onclick="handleAddChangCaseAddress()">
                                        + 新增地址
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">查获经过</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_chjg" name="chang_chjg"
                                                      lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处理详情</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_clxq" name="chang_clxq"
                                                      lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>





                        <div class="layui-col-md3 layui-col-md-offset5">
                            <div class="layui-form-item my-form-item" style="padding: 15px;">
                                <button id="changSub" type="submit" class="layui-btn" lay-submit=""
                                        lay-filter="changSub">立即提交
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="right-child-content layui-tab-item">
                    <form class="layui-form" method="post" id="formZaPei" onsubmit="return false;">
                        <input type="hidden" id="firstPei" value=0>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <button class="layui-btn layui-btn-sm" id="PeiHistory" style="display:none;"><i
                                        class="layui-icon">&#xe68d;</i>历史记录
                                </button>
                                <label class="my-form-label-br">关联案件</label>
                                <div class="my-input-block" style="display:flex;align-items:center;">
                                    <input type="hidden" name="relatedCaseId"
                                           id="pei_relatedCaseId" value="">
                                    <input type="text" id="pei_caseName"
                                           autocomplete="off" placeholder="点击右侧按钮选择关联警情/案件"
                                           class="layui-input" readonly
                                           style="flex:1;background:#efefef;cursor:default;">
                                    <button type="button" class="layui-btn layui-btn-normal layui-btn-sm"
                                            onclick="selectpeijqaj('${personnel.cardnumber}', $('#firstpei').val())"
                                            style="margin-left:10px;">
                                        <i class="layui-icon layui-icon-add-1"></i> 选择
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12" style="display:none;">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">陪侍情况综述
                                    <button class="layui-btn layui-btn-sm" id="PeiHistory" style="display:none;"><i
                                            class="layui-icon">&#xe68d;</i>历史记录
                                    </button>
                                </label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="otherMemo" name="otherMemo" lay-verify=""></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集来源</label>
                                <div class="my-input-block" id="collectSource-pei-div">
                                    <select id="collectSource-pei" name="collectSource" lay-filter="collectSource-pei"
                                            lay-verify=""
                                            lay-reqdiv="collectSource-pei-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集日期</label>
                                <div class="my-input-block">
                                    <input type="text" name="collectDate" id="pei_collectDate" autocomplete="off"
                                           placeholder="年-月-日" class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">角色标签</label>
                                <div class="my-input-block">
                                    <select id="pei_memo" name="pei_memo" lay-filter="pei_memo">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!-- 涉黄前科字段 -->
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"><span style="color:red;">*</span>涉黄前科</label>
                                <div class="my-input-block" id="hasShechangRecord-pei-div">
                                    <select id="hasShechangRecord-pei" name="hasShechangRecord" lay-filter="hasShechangRecord-pei"
                                            lay-verify="hasShechangRecord-pei" lay-reqdiv="hasShechangRecord-pei-div">
                                        <option value="">==请选择==</option>
                                        <option value="0">无</option>
                                        <option value="1">有</option>
                                    </select>
                                </div>
                            </div>
                        </div>


                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"
                                       style="display: inline-block; float: left;">活动场所：</label>

                                <span class="layui-word-aux"
                                      style="display: inline-block; line-height: 38px; margin-left: 10px;">
                                        最多填写 5 个
                                </span>

                                <div class="my-input-block" id="peiCaseAddressContainer">
                                    <!-- 这里只放 address-row -->
                                </div>

                                <div class="my-input-block" style="margin-top: 5px;">
                                    <!-- ✅ 改为使用 onclick 内联方式 -->
                                    <button type="button"
                                            class="layui-btn layui-btn-sm"
                                            id="addpeiCaseAddressBtn"
                                            onclick="handleAddpeiCaseAddress()">
                                        + 新增地址
                                    </button>
                                </div>
                            </div>
                        </div>



                        <div class="layui-col-md3 layui-col-md-offset5">
                            <div class="layui-form-item my-form-item" style="padding: 15px;">
                                <button id="peiSub" type="submit" class="layui-btn" lay-submit=""
                                        lay-filter="peiSub">立即提交
                                </button>
                            </div>
                        </div>


                    </form>
                </div>
                <div class="right-child-content layui-tab-item">
                    <div class="layui-form">
                        <div class="layui-tab my-tab layui-tab-brief">
                            <ul class="layui-tab-title my-tab-title">
                                <li class="layui-this">人员属性标签</li>
                                <li>标签维护记录</li>
                            </ul>

                            <div class="layui-tab-content">

                                <!-- 只读展示区 -->
                                <div class="layui-tab-item layui-show readonly-view">
                                    <table class="layui-table">
                                        <tr>
                                            <td valign="top" width="20%">
                                                <div id="zTree"
                                                     style="width:98%;overflow:auto;height:480px;"></div>
                                            </td>
                                            <td valign="top" width="80%">
                                                <form class="layui-form" id="attributelabel" style="height:480px;"></form>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <!-- 维护记录 -->
                                <div class="layui-tab-item">
                                    <table class="layui-hide" id="applyTable" lay-filter="applyTable"></table>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

<%--                <div class="right-child-content layui-tab-item"><!--人员属性标签 -->--%>
<%--                    <form class="layui-form" method="post" id="formAttributeLabel" onsubmit="return false;">--%>
<%--                        <div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">--%>
<%--                            <ul class="layui-tab-title my-tab-title">--%>
<%--                                <li class="layui-this">人员属性标签</li>--%>
<%--                                <li>标签维护记录</li>--%>
<%--                            </ul>--%>
<%--                            <div class="layui-tab-content">--%>
<%--                                <div class="layui-tab-item layui-show">--%>
<%--                                    <table class="layui-table">--%>
<%--                                        <tr>--%>
<%--                                            <td valign="top" width="20%">--%>
<%--                                                <div id="zTree" align="center"--%>
<%--                                                     style="width:98%;overflow: auto;height: 480px;"></div>--%>
<%--                                            </td>--%>
<%--                                            <td valign="top" width="80%">--%>
<%--                                                <div id="attributelabel" style="height: 480px;">--%>
<%--                                                </div>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                        <tr>--%>
<%--                                            <td width="100%" colspan="2">--%>
<%--                                                <div class="layui-form-item" align="center">--%>
<%--                                                    <button type="submit" class="layui-btn" lay-submit=""--%>
<%--                                                            lay-filter="attributeLabelSub">立即提交--%>
<%--                                                    </button>--%>
<%--                                                </div>--%>
<%--                                            </td>--%>
<%--                                        </tr>--%>
<%--                                    </table>--%>
<%--                                </div>--%>
<%--                                <div class="layui-tab-item">--%>
<%--                                    <table class="layui-hide" id="applyTable" lay-filter="applyTable"></table>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </form>--%>
<%--                </div>--%>
                <div class="right-child-content layui-tab-item">
                    <form class="layui-form" method="post" id="formRelation" onsubmit="return false;">
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">手机号码：</label>
                                <div class="layui-input-block">
                                    <input type="text" name=telnumber id="telnumber" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.telnumber}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('telnumber',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">使用手机：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="telephone" id="telephone" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.telephone}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('telephone',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">关联wifi：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="relatedwifi" id="relatedwifi" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.relatedwifi}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('relatedwifi',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">交通工具：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="relatedvehicle" id="relatedvehicle" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.relatedvehicle}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('relatedvehicle',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">银行账号：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="bankaccount" id="bankaccount" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.bankaccount}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('bankaccount',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>

                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">虚拟身份：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="netidentity" id="netidentity" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.netidentity}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('netidentity',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>

                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">网络支付：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="netpayment" id="netpayment" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.netpayment}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('netpayment',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>

                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label">涉及房产：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="relatedhouse" id="relatedhouse" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.relatedhouse}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('relatedhouse',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>

                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label ">法人组织：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="relatedlegal" id="relatedlegal" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.relatedlegal}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('relatedlegal',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label ">驾驶证件：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="relateddriver" id="relateddriver" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.relateddriver}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('relateddriver',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <div class="layui-col-md11">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label ">护照情况：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="relatedpassport" id="relatedpassport" lay-verify="title"
                                           autocomplete="off"
                                           value="${relation.relatedpassport}" placeholder="" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md1">
                            <div class="layui-form-item my-form-item">
                                <button onclick="openRelation('relatedpassport',${personnel.id},1);"
                                        class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more">&#xe624;
                                    更多
                                </button>
                            </div>
                        </div>
                        <br>
                        <div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 30px;margin-top: 30px;">
                            <%--						<div class="layui-form-item my-form-item">--%>
                            <%--						    <button type="submit" class="layui-btn"  lay-submit="" lay-filter="relationSub">立即提交</button>--%>
                            <%--							<button type="button" class="layui-btn layui-btn-sm layui-btn-primary">&nbsp;重置&nbsp;</button>--%>
                            <%--						</div>--%>
                        </div>
                    </form>
                </div>

                <div class="right-child-content layui-tab-item"><!-- 轨迹信息 -->
                    <form class="layui-form" method="post" id="formTrajectoryTable" onsubmit="return false;">
                        <div class="layui-inline" style="width:212px;left:20px;">
                            <select id="trajectoryTableTypes" lay-filter="trajectoryTableTypes"></select>
                        </div>
                        <table class="layui-hide" id="trajectoryTable" lay-filter="trajectoryTable"></table>
                    </form>
                </div>

                <script type="text/html" id="socialrelationstoolbar">
                    <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i
                            class="layui-icon">&#xe654;</i>添 加
                    </button>
                    <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修
                        改
                    </button>
                    <c:if test='${fn:contains(buttons,"删除")}'>
                        <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删
                            除
                        </button>
                    </c:if>
                </script>
                <script type="text/html" id="socialrelationsbar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>
                </script>
                <div class="right-child-content layui-tab-item"><!--社会关系 -->
                    <table class="layui-hide" id="socialrelationsTable" lay-filter="socialrelationsTable"></table>
                </div>
                <div class="right-child-content layui-tab-item"><!-- 涉警涉案信息 -->
                    <div class="layui-tab my-tab layui-tab-brief" lay-filter="zajqajTab">
                        <ul class="layui-tab-title my-tab-title">
                            <li class="layui-this">涉警信息</li>
                            <li>涉案信息</li>
                        </ul>
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show">
                                <table class="layui-hide" id="jqxxTable" lay-filter="jqxxTable"></table>
                            </div>
                            <div class="layui-tab-item">
                                <table class="layui-hide" id="ajxxTable" lay-filter="ajxxTable"></table>
                            </div>

                        </div>
                    </div>
                </div>
                <script type="text/html" id="goodstoolbar">
                    <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i
                            class="layui-icon">&#xe654;</i>新增物品
                    </button>
                    <button type="button" class="layui-btn layui-btn-sm" lay-event="addConnect"><i class="layui-icon">&#xe64c;</i>新增关联
                    </button>
                    <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删除关联
                    </button>
                </script>
                <div class="right-child-content layui-tab-item"><!-- 关联物品 -->
                    <form class="layui-form" method="post" id="goodsForm" onsubmit="return false;">
                        <table class="layui-hide" id="goodsTable" lay-filter="goodsTable"></table>
                    </form>
                </div>
                <div class="right-child-content layui-tab-item">
                    <form class="layui-form" method="post" id="formzaextend">
                        <input type="hidden" name="kongextendid" id="kongextendid">
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">职业</label>
                                <div class="my-input-block">
                                    <input type="text" name="zy" id="zy" autocomplete="off" placeholder="请输入职业"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">工作单位</label>
                                <div class="my-input-block">
                                    <input type="text" name="workunit" id="workunit" autocomplete="off"
                                           placeholder="请输入工作单位" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3 layui-col-md-offset5">
                            <div class="layui-form-item my-form-item" style="padding: 15px;">
                                <button type="submit" class="layui-btn" lay-submit="zaextendSub"
                                        lay-filter="zaextendSub">立即提交
                                </button>

                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var users1 = {}, users2 = {};

    // 加载默认照片并标记是否有照片
    function getDefaultPhoto() {
        var personnelid = $("#id").val();
        $.ajax({
            type: 'POST',
            url: locat + '/getPersonnelPhotoFlowList.do?personnelid=' + personnelid,
            dataType: 'json',
            async: false,
            success: function (data) {
                var defaultid = 0;
                if (data.count > 0) {
                    $.each(data.photos, function (i) {
                        if (this.defaultflag == 1) {
                            defaultid = this.id;
                            if (this.validflag > 1) $('#defaultPhoto').attr('src', '../uploadFiles/' + this.fileallName);
                            else $('#defaultPhoto').attr('src', '../uploadFiles/pictures/' + this.fileallName);
                            // 标记有照片
                            $('#hasPhoto').val('1');
                            return false;
                        }
                    });
                }
                if (defaultid == 0) {
                    $('#defaultPhoto').attr('src', locat + '/images/nophoto.png');
                    // 标记没有照片
                    $('#hasPhoto').val('0');
                }
                $('#defaultPhoto').attr('onload', "javascript:DrawImage(this,110,150)");
            }
        });
    }

    // 打开图片编辑上传页面（覆盖personel.js中的同名函数）
    function openPhotos() {
        var menuid = $("#menuid").val();
        var personnelid = $("#id").val();
        var index = layui.layer.open({
            title: "编辑风险人员照片",
            type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            content: locat + '/jsp/personel/wen/photo.jsp?personnelid=' + personnelid + '&menuid=' + menuid,
            area: ['700', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            end: function () {
                // 弹窗关闭时重新加载照片，更新hasPhoto标记
                getDefaultPhoto();
            }
        })
        layui.layer.full(index);
    }

    // 打处单位队列管理
    var handleUnitQueue = [];       // 存储单位名称
    var handleUnitCodeQueue = [];   // 存储单位编码
    var MAX_HANDLE_UNITS = 3;       // 最大数量

    // 初始化打处单位队列
    function initHandleUnitQueue() {
        // 优先从handle_unit_code（部门ID）加载，确保每次打开页面都显示最新数据
        var savedCodes = $('#handleUnitCode').val();

        console.log('========== 初始化打处单位队列 ==========');
        console.log('从数据库获取的handle_unit_code: ' + savedCodes);

        handleUnitQueue = [];
        handleUnitCodeQueue = [];

        if (savedCodes && savedCodes.trim() !== '') {
            var codeArray = savedCodes.split(',').filter(function (item) {
                return item.trim() !== '';
            });

            var otherAdded = false; // 标记"治安大队"是否已添加
            // 根据handle_unit_code查找对应的单位名称
            codeArray.forEach(function(code) {
                var unitName = '';
                var codeNum = parseInt(code.trim());

                // 不在240-263范围内的数字，显示"治安大队"（只显示一次）
                if (isNaN(codeNum) || codeNum < 240 || codeNum > 263) {
                    if (!otherAdded) {
                        otherAdded = true;
                        handleUnitCodeQueue.push(code.trim());
                        handleUnitQueue.push('治安大队');
                        console.log('加载打处单位: code=' + code + ', name=治安大队');
                    } else {
                        console.log('跳过重复的"治安大队": code=' + code);
                    }
                    return;
                }

                // 在240-263范围内，从policeData中查找对应的单位名称
                if (policeData && policeData.length > 0) {
                    for (var i = 0; i < policeData.length; i++) {
                        if (policeData[i].departmentid == code) {
                            unitName = policeData[i].name;
                            break;
                        }
                    }
                }

                // 如果没找到单位名称，使用部门ID作为显示
                if (!unitName) {
                    unitName = '部门' + code;
                    console.warn('未找到部门ID ' + code + ' 对应的名称，使用默认显示');
                }

                handleUnitCodeQueue.push(code.trim());
                handleUnitQueue.push(unitName);
                console.log('加载打处单位: code=' + code + ', name=' + unitName);
            });
        }

        // 更新隐藏字段的handleUnit值（保持同步）
        $('#handleUnit').val(handleUnitQueue.join(','));

        console.log('初始化完成: handleUnitQueue=' + handleUnitQueue.join(','));
        console.log('初始化完成: handleUnitCodeQueue=' + handleUnitCodeQueue.join(','));

        renderHandleUnitTags();
        bindHandleUnitEvents();
    }

    // 添加打处单位
    function addHandleUnit(unitName, unitCode) {
        if (!unitName || unitName.trim() === '') {
            return false;
        }

        // 检查是否已存在
        if (handleUnitQueue.indexOf(unitName) !== -1) {
            layer.msg('该单位已添加', {icon: 2});
            return false;
        }

        // 如果超过最大数量，删除最先添加的
        if (handleUnitQueue.length >= MAX_HANDLE_UNITS) {
            handleUnitQueue.shift();
            handleUnitCodeQueue.shift();
        }

        handleUnitQueue.push(unitName);
        handleUnitCodeQueue.push(unitCode || '');

        updateHandleUnitHiddenFields();
        renderHandleUnitTags();
        return true;
    }

    // 移除打处单位
    function removeHandleUnit(index) {
        if (index >= 0 && index < handleUnitQueue.length) {
            handleUnitQueue.splice(index, 1);
            handleUnitCodeQueue.splice(index, 1);
            updateHandleUnitHiddenFields();
            renderHandleUnitTags();
        }
    }

    // 更新隐藏字段值
    function updateHandleUnitHiddenFields() {
        $('#handleUnit').val(handleUnitQueue.join(','));
        $('#handleUnitCode').val(handleUnitCodeQueue.join(','));
    }

    // 渲染打处单位标签
    function renderHandleUnitTags() {
        var html = '';
        for (var i = 0; i < handleUnitQueue.length; i++) {
            html += '<span class="layui-badge layui-bg-blue" style="margin-right:5px;margin-bottom:3px;padding:5px 10px;font-size:12px;">';
            html += handleUnitQueue[i];
            html += '<i class="layui-icon layui-icon-close" data-index="' + i + '" style="margin-left:5px;cursor:pointer;font-size:12px;"></i>';
            html += '</span>';
        }
        $('#handleUnitTags').html(html);

        // 绑定删除事件
        $('#handleUnitTags .layui-icon-close').off('click').on('click', function () {
            var idx = $(this).data('index');
            removeHandleUnit(idx);
        });
    }

    // 绑定添加按钮事件
    function bindHandleUnitEvents() {
        $('#addHandleUnitBtn').off('click').on('click', function () {
            var $select = $('#handleUnitSelect');
            var unitName = $select.val();

            if (!unitName) {
                layer.msg('请先选择打处单位', {icon: 2});
                return;
            }


            // 优先从DOM获取departmentid，然后尝试从policeData中查找
            var unitCode = '';
            var $selectedOption = $select.find('option:selected');
            // 方案 1：尝试从 DOM data 属性获取
            if ($selectedOption.length > 0) {
                unitCode = $selectedOption.data('departmentid');
                if (!unitCode) {
                    unitCode = $selectedOption.attr('data-departmentid');
                }
            }
            // 方案 2：如果方案 1 失败，从 policeData 数组中查找
            if (!unitCode && policeData && policeData.length > 0) {
                for (var i = 0; i < policeData.length; i++) {
                    if (policeData[i].name === unitName) {
                        unitCode = policeData[i].departmentid || '';
                        break;
                    }
                }
            }
            console.log('添加打处单位:  名称=' + unitName + ', 编码=' + unitCode + ', DOM获取结果=' + $selectedOption.attr('data-departmentid'));

            if (addHandleUnit(unitName, unitCode)) {
                layer.msg('添加成功', {icon: 1, time: 1000});
                // 重置下拉框
                $select.val('');
                layui.form.render('select');
            }
        });
    }

    // 初始化涉赌、涉黄、陪侍tab的打处单位字段
    function initTabHandleUnitFields() {
        // 获取当前用户的部门信息
        var currentUserDeptId = '<%=userSession != null ? userSession.getLoginUserDepartmentid() : ""%>';
        var currentUserDeptName = '';

        // 从policeData中查找当前用户的部门名称
        if (currentUserDeptId && policeData && policeData.length > 0) {
            for (var i = 0; i < policeData.length; i++) {
                if (policeData[i].departmentid == currentUserDeptId) {
                    currentUserDeptName = policeData[i].name;
                    break;
                }
            }
        }

        // 如果没找到，使用默认显示
        if (!currentUserDeptName && currentUserDeptId) {
            currentUserDeptName = '治安大队';
        }

        // 设置涉赌tab的打处单位
        if (currentUserDeptName) {
            $('#du_handleUnit').val(currentUserDeptName);
            $('#du_handleUnitCode').val(currentUserDeptId);
        }

        // 设置涉黄tab的打处单位
        if (currentUserDeptName) {
            $('#chang_handleUnit').val(currentUserDeptName);
            $('#chang_handleUnitCode').val(currentUserDeptId);
        }

        console.log('初始化tab打处单位字段: deptId=' + currentUserDeptId + ', deptName=' + currentUserDeptName);
    }

    // ========== 打处单位修改权限控制 ==========
    // 允许修改打处单位的部门ID：1(管理员)、47、48、49、51、53、65(治安大队及相关)
    var allowedDepartmentIds = ['1', '47', '48', '49', '51', '53', '65'];

    // 获取当前登录用户的单位ID和单位名称
    var currentUserUnitId = '<%=userSession != null ? userSession.getLoginUserDepartmentid() : ""%>';
    var currentUserUnitName = '<%=userSession != null ? userSession.getLoginUserDepartname() : ""%>';
    var currentUserDepartCode = '<%=userSession != null ? userSession.getLoginDepartcode() : ""%>';

    // 获取人员的打处单位编码列表（用于判断编辑权限）
    var handleUnitCodeForPermission = '${personnel.handleUnitCode}' || '';
    var handleUnitCodesArray = handleUnitCodeForPermission.split(',').filter(function(item) {
        return item.trim() !== '';
    });

    // 判断当前用户是否有打处单位修改权限
    // 条件1：用户在allowedDepartmentIds中（管理员或治安大队）
    // 条件2：用户的departmentid在handle_unit_code列表中
    var isInAllowedDepartments = allowedDepartmentIds.indexOf(currentUserUnitId) !== -1;
    var isInHandleUnitCode = handleUnitCodesArray.indexOf(currentUserUnitId) !== -1;
    var hasHandleUnitEditPermission = isInAllowedDepartments || isInHandleUnitCode;

    console.log('========== 权限初始化调试 ==========');
    console.log('currentUserUnitId: ' + currentUserUnitId);
    console.log('handleUnitCodesArray: ', handleUnitCodesArray);
    console.log('isInAllowedDepartments: ' + isInAllowedDepartments);
    console.log('isInHandleUnitCode: ' + isInHandleUnitCode);
    console.log('hasHandleUnitEditPermission: ' + hasHandleUnitEditPermission);

    // 初始化打处单位显示区域
    function initHandleUnitDisplay() {
        console.log('========== 打处单位权限控制初始化 ==========');
        console.log('当前用户部门ID: ' + currentUserUnitId);
        console.log('是否有打处单位修改权限: ' + hasHandleUnitEditPermission);

        if (hasHandleUnitEditPermission) {
            // 有权限：显示可编辑区域
            $('#handleUnitEditArea').show();
            $('#handleUnitReadOnlyArea').hide();
        } else {
            // 无权限：显示只读区域，根据handle_unit_code获取单位名称显示
            $('#handleUnitEditArea').hide();
            $('#handleUnitReadOnlyArea').show();

            // 根据handle_unit_code从policeData查找对应中文名称
            var handleUnitCodes = $('#handleUnitCode').val() || '';
            var displayText = '';

            if (handleUnitCodes.trim() !== '') {
                var codes = handleUnitCodes.split(',');
                var names = [];
                for (var i = 0; i < codes.length; i++) {
                    var code = codes[i].trim();
                    if (code !== '') {
                        if (code === '47') {
                            names.push('治安大队');
                        } else {
                            var foundName = '';
                            // 从policeData中查找匹配的名称
                            if (typeof policeData !== 'undefined' && policeData && policeData.length > 0) {
                                for (var j = 0; j < policeData.length; j++) {
                                    if (policeData[j].departmentid && policeData[j].departmentid.toString() === code) {
                                        foundName = policeData[j].name;
                                        break;
                                    }
                                }
                            }
                            // 如果找到了名称，使用名称；否则回退显示编码
                            names.push(foundName || code);
                        }
                    }
                }
                displayText = names.join(', ');
            }

            if (displayText === '') {
                displayText = '暂无';
            }
            $('#handleUnitDisplayText').text(displayText);
        }
    }

    // ========== 打处单位处理确认模块 ==========

    // 可使用dealUnitHandled（处理"治安大队"）的部门ID列表
    var dealUnitAllowedIds = ['1', '47', '48', '49', '51', '53', '65'];

    // 初始化打处单位处理确认模块
    function initDealUnitConfirmSection() {
        // 获取人员的打处单位编码列表
        var handleUnitCodeStr = $('#handleUnitCode').val() || '';
        var handleUnitCodes = handleUnitCodeStr.split(',').filter(function (item) {
            return item.trim() !== '';
        });

        console.log('========== 打处单位处理确认模块初始化 ==========');
        console.log('当前用户单位ID: ' + currentUserUnitId);
        console.log('当前用户单位名称: ' + currentUserUnitName);
        console.log('当前用户单位编码: ' + currentUserDepartCode);
        console.log('人员打处单位编码列表: ', handleUnitCodes);

        // 判断当前用户单位是否在人员的打处单位列表中
        var isInDealUnitList = false;

        // 优先使用单位编码匹配（更准确）
        if (currentUserDepartCode && currentUserDepartCode.trim() !== '') {
            for (var i = 0; i < handleUnitCodes.length; i++) {
                if (handleUnitCodes[i] === currentUserDepartCode) {
                    isInDealUnitList = true;
                    break;
                }
            }
        }

        // 如果编码匹配失败，尝试使用单位ID匹配（兼容处理）
        if (!isInDealUnitList && currentUserUnitId && currentUserUnitId.trim() !== '') {
            for (var i = 0; i < handleUnitCodes.length; i++) {
                if (handleUnitCodes[i] === currentUserUnitId) {
                    isInDealUnitList = true;
                    break;
                }
            }
        }

        // 额外：若用户属于治安大队相关部门（1,47,48,49,51,53,65），且handleUnitCode中含有不在240-263范围的数字，也显示模块
        var isZadaUser = dealUnitAllowedIds.indexOf(currentUserUnitId) !== -1;
        // 检查 handleUnitCode 中是否存在不在 240-263 范围内的代码（即"治安大队"）
        var hasNonPctCode = handleUnitCodes.some(function(code) {
            var n = parseInt(code, 10);
            return !isNaN(n) && (n < 240 || n > 263);
        });
        var showForNonPct = isZadaUser && hasNonPctCode;

        console.log('是否治安大队相关用户: ' + isZadaUser + ', handleUnitCode含非派出所代码: ' + hasNonPctCode);
        console.log('当前单位是否在打处单位列表中: ' + isInDealUnitList);

        // 如果当前单位在打处单位列表中，或者是治安大队用户且含非派出所代码，显示模块
        if (isInDealUnitList || showForNonPct) {
            // 显示名称：优先显示"治安大队"（当含非派出所代码且是治安大队用户），否则显示当前单位名称
            var displayName = (showForNonPct && !isInDealUnitList) ? '治安大队' : currentUserUnitName;
            $('#currentUnitNameDisplay').text(displayName);
            $('#dealUnitConfirmSection').show();
            console.log('打处单位处理确认模块已显示，displayName=' + displayName);
        } else {
            $('#dealUnitConfirmSection').hide();
            console.log('打处单位处理确认模块已隐藏');
        }
    }

    function getUsers(departmentid, index, value) {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getUsersByDepartmentid.do?departmentid="/>' + departmentid,
            dataType: 'json',
            async: false,
            success: function (data) {
                var options = fillOption(data);
                var firstid = 0;
                if (index == 1) users1 = {};
                else if (index == 2) users2 = {};
                $.each(data.list, function (i, item) {
                    $.each(item, function (i) {
                        if (i == 0) firstid = this.value;
                        if (index == 1) users1[this.value] = this.memo;
                        else if (index == 2) users2[this.value] = this.memo;
                    });
                });
                var id = "#jdpolice" + index;
                $(id).html(options);
                layui.form.render();
                if (value != "" && value != 0)
                    $(id + " option[value=" + value + "]").select();
                else {
                    if (index == 1) $("#pphone1").val(users1[firstid]);
                    else if (index == 2) $("#pphone2").val(users2[firstid]);
                }
            }
        });
    }

    // 统一的派出所显示/隐藏控制函数
    function togglePoliceDiv(county, type) {
        if (type === 'house') {
            var $div = $('#housepolice').closest('.layui-form-item');
            if (county === '江阴市') {
                $div.show();
                // 不使用lay-verify，改为在提交时手动验证
                $div.find('.layui-form-label').html('户籍地派出所：<span style="color:red;">*</span>');
            } else {
                $div.hide();
                $('#housepolice').val('');
            }
        } else if (type === 'home') {
            var $div = $('#homepolice_div');
            var $required = $('#homepolice-required');
            if (county === '江阴市') {
                $div.show();
                $required.show();
                // 不使用lay-verify，改为在提交时手动验证
            } else {
                $div.hide();
                $required.hide();
                $('#homepolice').val('');
            }
        } else if (type === 'du_home') {
            // 涉赌背景tab - 现住地派出所
            var $div = $('#du_homepolice_div'); // 修改点：匹配 HTML 中的 ID
            var $required = $('#du_homepolice-required'); // 修改点：使用 # 获取 ID 而非 . 获取 class
            if (county === '江阴市') {
                $div.show();
                $required.show();
                // 不使用lay-verify，改为在提交时手动验证
            } else {
                $div.hide();
                $required.hide();
                $('#du_policeStation').val('');
            }
        } else if (type === 'chang_home') {
            // 涉黄背景tab - 现住地派出所
            var $div = $('#chang_homepolice_div'); // 修改点：匹配你 HTML 里的 id="chang_homepolice_div"
            var $required = $('#chang_homepolice-required'); // 修改点：匹配你 HTML 里的 id="chang_homepolice-required"
            if (county === '江阴市') {
                $div.show();
                $required.show();
                // 不使用lay-verify，改为在提交时手动验证
            } else {
                $div.hide();
                $required.hide();
                $('#chang_policeStation').val('');
            }
        }
        layui.form.render('select');
    }

    // 全局变量：江阴派出所数据
    var policeData = [];

    $(document).ready(function () {
        getDefaultPhoto();//加载默认图片
        var personnelid = "${personnel.id}"; // 确保能获取到 ID

        layui.use(['selectInput', 'form'], function () {
            var form = layui.form;

            // 初始化基础信息tab的省市县级联下拉框（放在layui.use内部）
            // 1. 初始化现住地省市县
            initRegionCascade('home', '${personnel.homeProvince}', '${personnel.homeCity}', '${personnel.homeCounty}');

            // 2. 初始化户籍地省市县
            initRegionCascade('house', '${personnel.houseProvince}', '${personnel.houseCity}', '${personnel.houseCounty}');

            // 3. 先加载派出所数据
            loadJiangyinPoliceData(function () {

                // 4. 户籍地派出所
                renderPoliceSelect({
                    elem: '#housepolice',
                    initValue: '${personnel.housepolice}',
                    initId: '${personnel.housePoliceStationId}'
                });

                // 5. 现住地派出所
                renderPoliceSelect({
                    elem: '#homepolice',
                    initValue: '${personnel.homepolice}',
                    initId: '${personnel.homePoliceStationId}'
                });

                // 5. Tab - 涉赌
                // renderPoliceSelect({
                //     elem: '#du_policeStation',
                //     initValue: ''
                // });

                // 6. Tab - 涉黄
                renderPoliceSelect({
                    elem: '#chang_policeStation',
                    initValue: ''
                });

                // 7. 打处单位下拉框
                renderPoliceSelect({
                    elem: '#handleUnitSelect',
                    initValue: ''
                });

                // 初始化打处单位队列
                initHandleUnitQueue();
                bindHandleUnitEvents();

                // 初始化打处单位显示权限控制
                initHandleUnitDisplay();

                // 初始化打处单位处理确认模块
                initDealUnitConfirmSection();

                // 初始化涉赌、涉黄、陪侍tab的打处单位字段（自动填充当前用户部门）
                initTabHandleUnitFields();

                form.render('select');
                // 使用延时确保 DOM 和基础数据字典(loadBasicMsg) 有足够时间准备好
                setTimeout(function () {
                    if (personnelid) {
                        console.log("正在执行涉赌初始化...");
                        openZaDu(personnelid);
                    }
                }, 300); // 延迟 300 毫秒执行

                // 绑定搜索框失焦事件，支持手动输入
                bindPoliceInputBlur();
            });
        });

        // 绑定事件
        $('#houseCounty').on('input blur', function () {
            togglePoliceDiv($(this).val().trim(), 'house');
        });

        // 页面加载时触发
        togglePoliceDiv($('#houseCounty').val().trim(), 'house');

    });

    // // 7. 修改：加载数据字典
    // loadBasicMsg('302', 'dbfs');           // 赌博方式-
    // loadBasicMsg('303', 'dbbw');           // 赌博部位-
    // loadBasicMsg('305', 'chang_myfs');     // 涉黄方式-
    // loadBasicMsg('308', 'chang_scbw');     // 涉黄部位-
    // loadBasicMsg('304', 'chang_scjs'); // 涉黄角色-
    // loadBasicMsg('306', 'changType'); // 涉黄类型-
    // loadBasicMsg('301', 'personAttribute-du');   // 涉赌人员属性-
    // loadBasicMsg('307', 'collectSource-du');     // 涉赌采集来源-
    // loadBasicMsg('307', 'collectSource-chang');   // 涉黄采集来源-

    // 加载江阴派出所数据
    function loadJiangyinPoliceData(callback) {
        $.ajax({
            type: 'GET',
            url: '<c:url value="/getJiangyinPoliceStations.do"/>',
            dataType: 'json',
            success: function (data) {
                policeData = [];
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        policeData.push({
                            value: data[i].departname, // 表单提交的值
                            name: data[i].departname,  // 下拉显示
                            departmentid: data[i].departmentid  // 存储departmentid用于handle_unit_code
                        });
                    }
                }
                if (callback) callback();
            },
            error: function () {
                console.error('派出所数据加载失败');
                if (callback) callback();
            }
        });
    }

    function renderPoliceSelect(cfg) {
        var $select = $(cfg.elem);
        var initValue = cfg.initValue || '';
        var initId = cfg.initId || '';

        // 清空现有选项（保留placeholder）
        $select.find('option:not(:first)').remove();

        var foundById = false;

        // 1️⃣ 渲染下拉数据，并尝试按 ID 选中
        if (policeData && policeData.length > 0) {
            policeData.forEach(function (item) {
                var selected = '';

                // 只按 ID 判断是否选中
                if (initId && item.departmentid && item.departmentid == initId) {
                    selected = 'selected';
                    foundById = true;
                }

                $select.append(
                    '<option value="' + item.name + '" data-departmentid="' + (item.departmentid || '') + '" ' + selected + '>' +
                    item.name +
                    '</option>'
                );
            });
        }

        // 2️⃣ 如果 ID 没找到，再兜底显示 initValue
        if (!foundById && initValue) {
            var existByName = false;

            // 下拉列表里是否已有该名称
            $select.find('option').each(function () {
                if ($(this).val() === initValue) {
                    $(this).prop('selected', true);
                    existByName = true;
                }
            });

            // 如果名称也不在下拉中，追加一个
            if (!existByName) {
                $select.append(
                    '<option value="' + initValue + '" selected>' + initValue + '</option>'
                );
            }
        }

        layui.form.render('select');
    }

    // 绑定派出所选择事件
    function bindPoliceInputBlur() {
        // 监听所有派出所相关的 select 选择事件
        var policeSelectors = ['#housepolice', '#homepolice', '#workpolice', '#du_policeStation', '#chang_policeStation'];

        // 监听 select 选择事件
        policeSelectors.forEach(function (selector) {
            if ($(selector).length === 0) return;

            var selectId = selector.substring(1); // 去掉 #
            layui.form.on('select(' + selectId + ')', function (data) {
                // 当用户选择下拉选项时，Layui 会自动更新值
                console.log('选择了派出所:', data.value);
            });
        });
    }

    function renderPoliceSelectInput(cfg) {
        layui.selectInput.render({
            elem: cfg.elem,
            name: cfg.name,
            initValue: cfg.initValue || '',
            placeholder: cfg.placeholder || '请选择派出所',
            data: policeData,
            remoteSearch: false
        });
    }

    // 7. 修改：数据字典加载函数
    function loadBasicMsg(basicType, selectId) {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBasicMsgByType.do"/>',
            data: {basicType: basicType},
            dataType: 'json',
            async: false,
            success: function (data) {
                var html = '<option value="">==请选择==</option>';
                // 返回的数据结构是 [{basicname: "xxx", id: xxx}, ...]
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].basicname + '">' + data[i].basicname + '</option>';
                    }
                }
                $('#' + selectId).html(html);
            },
            error: function (xhr, status, error) {
                console.error('加载数据字典失败: ' + selectId, error);
            }
        });
    }

    // 8. 省市县级联下拉框函数（使用数据字典basicType=500）
    // 加载省级数据
    function loadProvinceData(selectId, callback) {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBasicMsgByParentId.do"/>',
            data: {
                basicType: 500,
                parentid: 0  // 查询顶级节点（省份数据，parentid=0）
            },
            dataType: 'json',
            async: false,
            success: function (data) {
                var html = '<option value="">请选择省份</option>';
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].basicname + '" data-id="' + data[i].id + '">' + data[i].basicname + '</option>';
                    }
                }
                $('#' + selectId).html(html);
                layui.form.render('select');
                if (callback) callback();
            },
            error: function (xhr, status, error) {
                console.error('加载省份数据失败: ' + selectId, error);
                if (callback) callback();
            }
        });
    }

    // 加载市级数据
    function loadCityData(provinceSelectId, citySelectId, callback) {
        var selectedOption = $('#' + provinceSelectId + ' option:selected');
        var parentId = selectedOption.attr('data-id');

        var html = '<option value="">请选择地级市</option>';
        if (!parentId) {
            $('#' + citySelectId).html(html);
            layui.form.render('select');
            if (callback) callback();
            return;
        }

        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBasicMsgByParentId.do"/>',
            data: {
                basicType: 500,
                parentid: parentId
            },
            dataType: 'json',
            async: false,
            success: function (data) {
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].basicname + '" data-id="' + data[i].id + '">' + data[i].basicname + '</option>';
                    }
                }
                $('#' + citySelectId).html(html);
                layui.form.render('select');
                if (callback) callback();
            },
            error: function (xhr, status, error) {
                console.error('加载市级数据失败: ' + citySelectId, error);
                if (callback) callback();
            }
        });
    }

    // 加载县级数据
    function loadCountyData(citySelectId, countySelectId, callback) {
        var selectedOption = $('#' + citySelectId + ' option:selected');
        var parentId = selectedOption.attr('data-id');

        var html = '<option value="">请选择县级市/区</option>';
        if (!parentId) {
            $('#' + countySelectId).html(html);
            layui.form.render('select');
            if (callback) callback();
            return;
        }

        $.ajax({
            type: 'POST',
            url: '<c:url value="/getBasicMsgByParentId.do"/>',
            data: {
                basicType: 500,
                parentid: parentId
            },
            dataType: 'json',
            async: false,
            success: function (data) {
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        html += '<option value="' + data[i].basicname + '" data-id="' + data[i].id + '">' + data[i].basicname + '</option>';
                    }
                }
                $('#' + countySelectId).html(html);
                layui.form.render('select');
                if (callback) callback();
            },
            error: function (xhr, status, error) {
                console.error('加载县级数据失败: ' + countySelectId, error);
                if (callback) callback();
            }
        });
    }

    // 初始化省市县级联下拉框（指定前缀）
    function initRegionCascade(prefix, initProvince, initCity, initCounty) {
        var provinceId = prefix + 'Province';
        var cityId = prefix + 'City';
        var countyId = prefix + 'County';

        // 加载省份数据
        loadProvinceData(provinceId, function() {
            // 如果有初始省份值，设置并加载市
            if (initProvince) {
                $('#' + provinceId).val(initProvince);
                layui.form.render('select');
                loadCityData(provinceId, cityId, function() {
                    if (initCity) {
                        $('#' + cityId).val(initCity);
                        layui.form.render('select');
                        loadCountyData(cityId, countyId, function() {
                            if (initCounty) {
                                $('#' + countyId).val(initCounty);
                                layui.form.render('select');
                                // 触发县级市改变事件，检查派出所显示
                                $('#' + countyId).trigger('change');
                            }
                        });
                    }
                });
            }
        });

        // 监听省份改变
        layui.form.on('select(' + provinceId + ')', function(data) {
            $('#' + cityId).html('<option value="">请选择地级市</option>');
            $('#' + countyId).html('<option value="">请选择县级市/区</option>');
            layui.form.render('select');

            if (data.value) {
                loadCityData(provinceId, cityId);
            }
        });

        // 监听市改变
        layui.form.on('select(' + cityId + ')', function(data) {
            $('#' + countyId).html('<option value="">请选择县级市/区</option>');
            layui.form.render('select');

            if (data.value) {
                loadCountyData(cityId, countyId);
            }
        });

        // 监听县级市改变 - 触发派出所显示逻辑
        layui.form.on('select(' + countyId + ')', function(data) {
            var county = data.value;
            // 根据前缀判断是哪个tab
            if (prefix === 'home') {
                togglePoliceDiv(county, 'home');
            } else if (prefix === 'house') {
                togglePoliceDiv(county, 'house');
            } else if (prefix === 'du_home') {
                togglePoliceDiv(county, 'du_home');
            } else if (prefix === 'chang_home') {
                togglePoliceDiv(county, 'chang_home');
            }
        });
    }

    function safeIntParam(val) {
        return val === undefined || val === null || val === '' ? null : val;
    }

    layui.config({
        base: "<c:url value="/layui/lay/modules/"/>"
    }).extend({
        treeSelect: "treeSelect",
        selectInput: "selectInput/selectInput",
        zTreeSelectM: 'zTreeSelectM/zTreeSelectM'
    });


    layui.use(['element', 'form', 'upload', 'jquery', 'selectInput', 'treeSelect', 'table', 'laydate', 'layer', 'zTreeSelectM'], function () {
        var element = layui.element,
            upload = layui.upload,
            $ = layui.jquery,
            selectInput = layui.selectInput,
            table = layui.table,
            form = layui.form,
            laydate = layui.laydate,
            treeSelect = layui.treeSelect,
            zTreeSelectM = layui.zTreeSelectM,
            layer = layui.layer;

        // 5. 修改：日期组件
        laydate.render({
            elem: '#chsj',
            format: 'yyyy-MM-dd',
            trigger: 'click',
            zIndex: 99999999
        });
        laydate.render({
            elem: '#chang_chsj',
            format: 'yyyy-MM-dd',
            trigger: 'click',
            zIndex: 99999999,
            done: function(value, date) {
                // 当处罚时间改变时，自动计算是否未成年案件
                calculateChangIsMinorCase();
            }
        });
        laydate.render({
            elem: '#du_collectDate',
            format: 'yyyy-MM-dd',
            trigger: 'click',
            zIndex: 99999999
        });
        laydate.render({
            elem: '#chang_collectDate',
            format: 'yyyy-MM-dd',
            trigger: 'click',
            zIndex: 99999999
        });
        laydate.render({
            elem: '#pei_collectDate',
            format: 'yyyy-MM-dd',
            trigger: 'click',
            zIndex: 99999999
        }); // ✅ 陪侍采集日期组件初始化

        treeSelect.render({
            // 选择器
            elem: '#jdunit1',
            // 数据
            data: '<c:url value="/getDepartmentTree.do"/>',
            // 异步加载方式：get/post，默认get
            type: 'get',
            // 占位符
            placeholder: '管辖责任单位',
            // 是否开启搜索功能：true/false，默认false
            search: false,
            // 一些可定制的样式
            style: {
                folder: {
                    enable: false
                },
                line: {
                    enable: true
                }
            },
            // 点击回调
            click: function (d) {
                getUsers($('#jdunit1').val(), 1, 0);
                form.render();
            },
            // 加载完成后的回调函数
            success: function (d) {
                treeSelect.checkNode('jdunit1', "${personnel.jdunit1}");
                treeSelect.refresh('jdunit1');
                getUsers("${personnel.jdunit1}", 1, "${personnel.jdpolice1}");
                form.render();
            }
        });
        var ztreestylechange2 = treeSelect.render({
            // 选择器
            elem: '#jdunit2',
            // 数据
            data: '<c:url value="/getDepartmentTree.do"/>',
            // 异步加载方式：get/post，默认get
            type: 'get',
            // 占位符
            placeholder: '管辖责任单位',
            // 是否开启搜索功能：true/false，默认false
            search: false,
            // 一些可定制的样式
            style: {
                folder: {
                    enable: false
                },
                line: {
                    enable: true
                }
            },
            // 点击回调
            click: function (d) {
                if ($('#jdunit2').val() != "") getUsers($('#jdunit2').val(), 2, 0);
                else getUsers(0, 2, 0)
                form.render();
            },
            // 加载完成后的回调函数
            success: function (d) {
                var treeObj = treeSelect.zTree('jdunit2');
                if ("${personnel.jdunit2}" != "" && "${personnel.jdunit2}" != "0") {
                    treeSelect.checkNode('jdunit2', "${personnel.jdunit2}");
                    getUsers("${personnel.jdunit2}", 2, "${personnel.jdpolice2}");
                }
                var newNode = {name: "取消选择"};
                treeObj.addNodes(null, 0, newNode);
                treeSelect.refresh('jdunit2');
                ztreestylechange2.hideIcon();
                form.render();
            }
        });
        form.on('select(jdpolice1)', function (data) {
            $('#pphone1').val(users1[data.value]);
            form.render();
        });
        form.on('select(jdpolice2)', function (data) {
            $('#pphone2').val(users2[data.value]);
            form.render();
        });

        //方法级渲染
        table.render({
            elem: '#applyTable',
            toolbar: false,
            defaultToolbar: ['filter', 'print'],
            url: '<c:url value="/searchApplylabel.do"/>',
            limit: 5,
            method: 'post',
            cols: [[
                {field: 'applylabel1name', title: '申请标签1级', width: 200, align: "center"},
                {field: 'applylabel2name', title: '申请标签子级', align: "center"},
                {field: 'addtime', title: '申请时间', width: 200, align: "center"},
                {
                    field: 'examineflag', title: '审核标记', width: 150, align: "center", templet: function (item) {
                        if (item.examineflag == 0) {
                            return "未审核";
                        } else if (item.examineflag == 1) {
                            return "审核通过";
                        } else if (item.examineflag == 2) {
                            return "审核不通过";
                        }
                    }
                }
            ]],
            page: true
        });


        form.on('select(jdpolice1)', function (data) {
            $('#pphone1').val(users1[data.value]);
            form.render();
        });
        form.on('select(jdpolice2)', function (data) {
            $('#pphone2').val(users2[data.value]);
            form.render();
        });

        form.render();
        //滚动图片按钮显示
        var swiper = new Swiper(".mySwiperS", {
            slidesPerView: 6,
            centeredSlides: false,
            spaceBetween: 5,
            allowTouchMove: false,
            navigation: {
                nextEl: ".swiper-button-next1",
                prevEl: ".swiper-button-prev1",
            }
        });
        // 基本信息+分类分级 监听提交

        // ========== 初始化权限检查 ==========
        console.log('========== 页面加载时权限检查 ==========');
        console.log('currentUserUnitId: ' + currentUserUnitId);
        console.log('allowedDepartmentIds: ' + allowedDepartmentIds.join(','));
        console.log('hasHandleUnitEditPermission: ' + hasHandleUnitEditPermission);

        // 如果没有权限，禁用提交按钮并添加点击提示
        if (!hasHandleUnitEditPermission) {
            console.log('用户无修改权限，禁用提交按钮');
            var $submitBtn = $('button[lay-filter="updateZa"]');
            $submitBtn.addClass('layui-btn-disabled').attr('disabled', true);
            $submitBtn.text('无修改权限');

            // 添加点击事件，即使按钮被禁用也显示提示
            $submitBtn.on('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                layer.msg('您当前没有权限修改此人员信息', {icon: 2, time: 2000});
                return false;
            });
        }

        form.on('submit(updateZa)', function (data) {
            console.log('========== updateZa提交事件触发 ==========');
            console.log('hasHandleUnitEditPermission: ' + hasHandleUnitEditPermission);
            console.log('currentUserUnitId: ' + currentUserUnitId);
            console.log('allowedDepartmentIds: ' + allowedDepartmentIds.join(','));

            // 检查是否有照片（必填项）
            var hasPhoto = $('#hasPhoto').val();
            if (hasPhoto === '0' || hasPhoto === '' || !hasPhoto) {
                layer.msg('请上传人员照片！人员照片为必填项', {icon: 2, time: 3000});
                return false;
            }

            // 验证现住地派出所（如果县级市是江阴市）
            var homeCounty = $('#homeCounty').val();
            var homePolice = $('#homepolice').val();
            if (homeCounty === '江阴市' && (!homePolice || homePolice.trim() === "")) {
                layer.msg('现住地派出所必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证户籍地派出所（如果县级市是江阴市）
            var houseCounty = $('#houseCounty').val();
            var housePolice = $('#housepolice').val();
            if (houseCounty === '江阴市' && (!housePolice || housePolice.trim() === "")) {
                layer.msg('户籍地派出所必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 权限检查：无打处单位修改权限的用户不能提交
            if (!hasHandleUnitEditPermission) {
                console.log('权限检查失败，显示无权限提示');
                layer.msg('您当前没有权限', {icon: 2, time: 2000});
                return false;
            }
            console.log('权限检查通过，继续提交');

            var url = '<c:url value="/updateZaPerson.do"/>?1=1';
            // if (!$("input[name=homewifi]").prop("checked")) url += "&homewifi=";
            // if (!$("input[name=homewide]").prop("checked")) url += "&homewide=";
            // if (!$("input[name=workwifi]").prop("checked")) url += "&workwifi=";
            // if (!$("input[name=workwide]").prop("checked")) url += "&workwide=";

            // 获取现住地派出所ID
            var $homePoliceSelect = $('#homepolice');
            var selectedHomePolice = $homePoliceSelect.val();
            var homePoliceStationId = '';
            var $selectedHomeOption = $homePoliceSelect.find('option:selected');
            if ($selectedHomeOption.length > 0) {
                homePoliceStationId = $selectedHomeOption.data('departmentid');
                if (!homePoliceStationId) {
                    homePoliceStationId = $selectedHomeOption.attr('data-departmentid');
                }
            }
            // 如果上述方法失败，从policeData查找
            if (!homePoliceStationId && selectedHomePolice && typeof policeData !== 'undefined' && policeData && policeData.length > 0) {
                for (var i = 0; i < policeData.length; i++) {
                    if (policeData[i].name === selectedHomePolice) {
                        homePoliceStationId = policeData[i].departmentid || '';
                        break;
                    }
                }
            }

            // 获取户籍派出所ID
            var $housePoliceSelect = $('#housepolice');
            var selectedHousePolice = $housePoliceSelect.val();
            var housePoliceStationId = '';
            var $selectedHouseOption = $housePoliceSelect.find('option:selected');
            if ($selectedHouseOption.length > 0) {
                housePoliceStationId = $selectedHouseOption.data('departmentid');
                if (!housePoliceStationId) {
                    housePoliceStationId = $selectedHouseOption.attr('data-departmentid');
                }
            }
            // 如果上述方法失败，从policeData查找
            if (!housePoliceStationId && selectedHousePolice && typeof policeData !== 'undefined' && policeData && policeData.length > 0) {
                for (var i = 0; i < policeData.length; i++) {
                    if (policeData[i].name === selectedHousePolice) {
                        housePoliceStationId = policeData[i].departmentid || '';
                        break;
                    }
                }
            }
            console.log('基本信息提交: 现住派出所=' + selectedHomePolice + ', ID=' + homePoliceStationId + ', 户籍派出所=' + selectedHousePolice + ', ID=' + housePoliceStationId);

            // ========== 打处单位处理确认逻辑 ==========
            var dealUnitHandled = '0'; // 默认否
            var removeDealUnit = '0';  // 是否移除打处单位标志

            // 如果打处单位确认模块可见（即当前单位在打处单位列表中）
            if ($('#dealUnitConfirmSection').is(':visible')) {
                dealUnitHandled = $('input[name="dealUnitHandled"]:checked').val() || '0';
                console.log('打处单位处理确认: ' + (dealUnitHandled === '1' ? '是' : '否'));

                // 如果选择"是"，从打处单位列表中移除相应单位
                if (dealUnitHandled === '1') {
                    var currentHandleUnitCodes = handleUnitCodeQueue.slice(); // 复制数组
                    var currentHandleUnitNames = handleUnitQueue.slice();

                    var isZadaUserForRemove = dealUnitAllowedIds.indexOf(currentUserUnitId) !== -1;

                    if (isZadaUserForRemove) {
                        // 治安大队相关用户：移除 handleUnitCode 中所有不在 240-263 范围内的代码
                        var filteredCodes = [];
                        var filteredNames = [];
                        for (var ri = 0; ri < currentHandleUnitCodes.length; ri++) {
                            var rCode = currentHandleUnitCodes[ri];
                            var rNum = parseInt(rCode, 10);
                            if (!isNaN(rNum) && rNum >= 240 && rNum <= 263) {
                                // 保留派出所范围内的代码
                                filteredCodes.push(rCode);
                                filteredNames.push(currentHandleUnitNames[ri] || rCode);
                            }
                            // 不在240-263范围的代码（47、50等）全部移除
                        }

                        if (filteredCodes.length !== currentHandleUnitCodes.length) {
                            $('#handleUnit').val(filteredNames.join(','));
                            $('#handleUnitCode').val(filteredCodes.join(','));
                            removeDealUnit = '1';
                            console.log('已移除所有非派出所范围代码，更新后编码: ' + filteredCodes.join(','));
                        }
                    } else {
                        // 非治安大队用户：按原逻辑，优先使用单位编码匹配
                        var removeIndex = -1;
                        if (currentUserDepartCode && currentUserDepartCode.trim() !== '') {
                            removeIndex = currentHandleUnitCodes.indexOf(currentUserDepartCode);
                        }
                        if (removeIndex === -1 && currentUserUnitId && currentUserUnitId.trim() !== '') {
                            removeIndex = currentHandleUnitCodes.indexOf(currentUserUnitId);
                        }
                        if (removeIndex !== -1) {
                            currentHandleUnitCodes.splice(removeIndex, 1);
                            currentHandleUnitNames.splice(removeIndex, 1);
                            $('#handleUnit').val(currentHandleUnitNames.join(','));
                            $('#handleUnitCode').val(currentHandleUnitCodes.join(','));
                            removeDealUnit = '1';
                            console.log('已从打处单位列表中移除相应单位');
                        }
                    }
                    console.log('更新后的打处单位: ' + $('#handleUnit').val());
                    console.log('更新后的打处单位编码: ' + $('#handleUnitCode').val());
                }
            }

            $("#formZa").ajaxSubmit({
                url: url,
                type: 'post',
                dataType: 'json',
                data: {
                    homePoliceStationId: safeIntParam(homePoliceStationId),
                    housePoliceStationId: safeIntParam(housePoliceStationId),
                    dealUnitHandled: dealUnitHandled,
                    removeDealUnit: removeDealUnit
                },
                success: function (data) {
                    var obj = (typeof data === 'string') ? JSON.parse(data) : data;
                    // 兼容处理：如果 data 已经是对象则直接使用，否则解析
                    if (typeof data === 'string') {
                        obj = eval('(' + data + ')');
                    } else {
                        obj = data;
                    }
                    if (obj.flag > 0) {
                        var successMsg = obj.msg || '治安人员修改成功！';

                        // 如果移除了打处单位，添加特别提示
                        if (removeDealUnit === '1') {
                            successMsg = '治安人员修改成功！当前单位已从打处单位列表中移除，后续将无法对该人员进行操作。';
                            top.layer.msg(successMsg, {
                                icon: 1,
                                time: 3000,
                                zIndex: 99999999
                            }, function () {
                                // 关闭当前弹窗或刷新页面
                                var index = parent.layer.getFrameIndex(window.name);
                                if (index) {
                                    parent.layer.close(index);
                                }
                            });
                        } else {
                            top.layer.msg(successMsg, {
                                icon: 1,
                                time: 2000,
                                zIndex: 99999999
                            });
                        }
                    } else {
                        layer.msg(obj.msg || '操作失败', {icon: 2});
                    }
                },
                error: function () {
                    layer.alert("请求失败！");
                }
            });
            return false;
        });

        form.on('submit(attributeLabelSub)', function (data) {
            //以前的正式标签
            var exzslabel1 = ",${personnel.zslabel1},";
            //需要审核的
            var addattributeLables = [];
            var addattributeLablenames = [];
            var addresult = [];
            //已有一级标签不需要审核的
            var uncheckattributeLables = [];
            $("input[name=attributeLable]:checked").each(function () {
                var p = $(this);
                if (exzslabel1.indexOf("," + p.val() + ",") == -1) {
                    addattributeLables.push(p.val());
                    addattributeLablenames.push(p.context.title);
                } else {
                    uncheckattributeLables.push(p.val());
                }
            });
            //新增审核
            $.each(addattributeLables, function (num, item) {
                addresult[num] = '{"attribute1":' + item + ',"attribute2":"' + $("#attribute" + item).find("input").val() + '","applylabel1name":"' + addattributeLablenames[num] + '","applylabel2name":"' + _zTreeSelectMsz[item].names.join() + '"}';
            });
            var addjson = "[" + addresult.join(",") + "]";
            console.log(addjson);
            //直接更新二级标签
            var attribute2 = [];
            $.each(uncheckattributeLables, function (num, item) {
                attribute2.push($("#attribute" + item).find("input").val());
            });
            attribute2str = attribute2.join(",");
            $.ajax({
                type: 'POST',
                url: '<c:url value="/applyAttribbuteLabel.do" />',
                data: {addjson: addjson, zslabel2: attribute2str, id:${personnel.id }},
                dataType: 'json',
                success: function (data) {
                    var str = eval('(' + data + ')');
                    if (str.flag == 1) {
                        top.layer.msg(str.msg);
                    } else {
                        top.layer.msg(str.msg);
                    }
                }
            });
            return false;
        });

        form.on('submit(zaextendSub)', function (data) {
            $("#formzaextend").ajaxSubmit({
                url: '<c:url value="/updateZaExtend.do"/>?personnelid=' + $("#id").val() + "&menuid=${menuid}",
                dataType: 'json',
                async: false,
                success: function (data) {
                    var obj = eval('(' + data + ')');
                    if (obj.flag > 0) {
                        //弹出loading
                        top.layer.msg(obj.msg);
                        $("#zaextendButton").click();
                    } else {
                        top.layer.msg(obj.msg);
                    }
                }
            });
            return false;
        });

        $("#labelHistory").click(function () {
            var index = layui.layer.open({
                title: '自定义标签(' + $('#customlabel').val() + ')' + "维护记录",
                type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                content: locat + "/jsp/personel/custom/labelhistory.jsp?personnelid="+${personnel.id}+
                "&customlabelid="+$("#customlabelid").val(),
                area: ['800', '600px'],
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
        });

        // ========== 涉警涉案tab切换监听 ==========
        element.on('tab(zajqajTab)', function(data){
            var cardnumber = '${personnel.cardnumber}';
            console.log('📌 涉警涉案tab切换，index=' + data.index);
            if(data.index === 0) {
                // 切换到涉警信息tab
                console.log('切换到涉警信息tab');
                if (typeof openzajqxx === 'function') {
                    openzajqxx(cardnumber);
                } else {
                    console.warn('⚠️ openzajqxx function is not defined');
                }
            } else if(data.index === 1) {
                // 切换到涉案信息tab
                console.log('切换到涉案信息tab');
                if (typeof openzaajxx === 'function') {
                    openzaajxx(cardnumber);
                } else {
                    console.warn('⚠️ openzaajxx function is not defined');
                }
            }
        });
    });

    // ==================== 涉案地址相关函数 ====================
    var maxAddressCount = 5; // 最多填写 5 个涉案地址

    // 涉赌背景：添加涉案地址输入框
    function addDuCaseAddressInput(value, xValue, yValue) {
        var $container = $('#duCaseAddressContainer');

        if ($container.length === 0) {
            console.warn('duCaseAddressContainer 不存在');
            return;
        }

        var count = $container.find('.address-row').length;
        if (count >= maxAddressCount) {
            if (window.layer && typeof layer.msg === 'function') {
                layer.msg('最多只能填写 5 个涉案地址');
            } else {
                alert('最多只能填写 5 个涉案地址');
            }
            return;
        }

        var addressId = 'du_caseAddress_' + new Date().getTime() + '_' + Math.floor(Math.random() * 1000);
        var html = '<div class="layui-form-item address-row" style="margin-bottom: 5px;">' +
            '<div class="layui-input-inline" style="width: 300px;">' +
            '<input type="text" name="du_caseAddress" id="' + addressId + '" value="' + (value || '') + '" placeholder="请输入涉案地址" class="layui-input" onclick="openPGisDuCaseAddress(\'' + addressId + '\');" readonly style="background:#efefef;cursor:pointer;">' +
            '<input type="hidden" name="du_caseAddress_x" id="' + addressId + '_x" value="' + (xValue || '') + '">' +
            '<input type="hidden" name="du_caseAddress_y" id="' + addressId + '_y" value="' + (yValue || '') + '">' +
            '</div>' +
            '<div class="layui-input-inline" style="width: 100px;">' +
            '<button type="button" class="layui-btn layui-btn-danger btn-remove-address" onclick="removeAddressRow(this)">删除</button>' +
            '</div>' +
            '</div>';

        $container.append(html);
        console.log('✓ 添加涉赌涉案地址成功，当前数量：' + ($container.find('.address-row').length));
    }

    // 涉黄背景：添加涉案地址输入框
    function addChangCaseAddressInput(value, xValue, yValue) {
        var $container = $('#changCaseAddressContainer');

        if ($container.length === 0) {
            console.warn('changCaseAddressContainer 不存在');
            return;
        }

        var count = $container.find('.address-row').length;
        if (count >= maxAddressCount) {
            if (window.layer && typeof layer.msg === 'function') {
                layer.msg('最多只能填写 5 个涉案地址');
            } else {
                alert('最多只能填写 5 个涉案地址');
            }
            return;
        }

        var addressId = 'chang_caseAddress_' + new Date().getTime() + '_' + Math.floor(Math.random() * 1000);
        var html = '<div class="layui-form-item address-row" style="margin-bottom: 5px;">' +
            '<div class="layui-input-inline" style="width: 300px;">' +
            '<input type="text" name="chang_caseAddress" id="' + addressId + '" value="' + (value || '') + '" placeholder="请输入涉案地址" class="layui-input" onclick="openPGisChangCaseAddress(\'' + addressId + '\');" readonly style="background:#efefef;cursor:pointer;">' +
            '<input type="hidden" name="chang_caseAddress_x" id="' + addressId + '_x" value="' + (xValue || '') + '">' +
            '<input type="hidden" name="chang_caseAddress_y" id="' + addressId + '_y" value="' + (yValue || '') + '">' +
            '</div>' +
            '<div class="layui-input-inline" style="width: 100px;">' +
            '<button type="button" class="layui-btn layui-btn-danger btn-remove-address" onclick="removeAddressRow(this)">删除</button>' +
            '</div>' +
            '</div>';

        $container.append(html);
        console.log('✓ 添加涉黄涉案地址成功，当前数量：' + ($container.find('.address-row').length));
    }

    // ✅ 删除地址行的通用函数
    function removeAddressRow(btn) {
        $(btn).closest('.address-row').remove();
        console.log('🗑️ 删除了一个地址行');
    }

    // ✅ 收集涉赌地址
    function collectDuCaseAddressList() {
        var list = [];
        $('#duCaseAddressContainer').find('input[name="du_caseAddress"]').each(function () {
            var val = $.trim($(this).val());
            if (val) {
                list.push(val);
            }
        });
        console.log('📋 收集涉赌地址：', list);
        return list;
    }

    // ✅ 收集涉黄地址
    function collectChangCaseAddressList() {
        var list = [];
        $('#changCaseAddressContainer').find('input[name="chang_caseAddress"]').each(function () {
            var val = $.trim($(this).val());
            if (val) {
                list.push(val);
            }
        });
        console.log('📋 收集涉黄地址：', list);
        return list;
    }

    // 陪侍背景：添加活动场所输入框
    function addPeiCaseAddressInput(value, xValue, yValue) {
        var $container = $('#peiCaseAddressContainer');

        if ($container.length === 0) {
            console.warn('peiCaseAddressContainer 不存在');
            return;
        }

        var count = $container.find('.address-row').length;
        if (count >= maxAddressCount) {
            if (window.layer && typeof layer.msg === 'function') {
                layer.msg('最多只能填写 5 个活动场所');
            } else {
                alert('最多只能填写 5 个活动场所');
            }
            return;
        }

        var addressId = 'pei_activityVenue_' + new Date().getTime() + '_' + Math.floor(Math.random() * 1000);
        var html = '<div class="layui-form-item address-row" style="margin-bottom: 5px;">' +
            '<div class="layui-input-inline" style="width: 300px;">' +
            '<input type="text" name="pei_activityVenue" id="' + addressId + '" value="' + (value || '') + '" placeholder="请输入活动场所" class="layui-input" onclick="openPGisPeiActivityVenue(\'' + addressId + '\');" readonly style="background:#efefef;cursor:pointer;">' +
            '<input type="hidden" name="pei_activityVenue_x" id="' + addressId + '_x" value="' + (xValue || '') + '">' +
            '<input type="hidden" name="pei_activityVenue_y" id="' + addressId + '_y" value="' + (yValue || '') + '">' +
            '</div>' +
            '<div class="layui-input-inline" style="width: 100px;">' +
            '<button type="button" class="layui-btn layui-btn-danger btn-remove-address" onclick="removeAddressRow(this)">删除</button>' +
            '</div>' +
            '</div>';

        $container.append(html);
        console.log('✓ 添加陪侍活动场所成功，当前数量：' + ($container.find('.address-row').length));
    }

    // ✅ 收集陪侍活动场所
    function collectPeiCaseAddressList() {
        var list = [];
        $('#peiCaseAddressContainer').find('input[name="pei_activityVenue"]').each(function () {
            var val = $.trim($(this).val());
            if (val) {
                list.push(val);
            }
        });
        console.log('📋 收集陪侍活动场所：', list);
        return list;
    }

    // ==================== 事件绑定（使用 onclick 内联方式） ====================
    // ✅ 涉赌新增地址按钮 - 改用 onclick 属性
    function handleAddDuCaseAddress() {
        console.log('🔘 点击了涉赌新增地址按钮');
        addDuCaseAddressInput('');
    }

    // ✅ 涉黄新增地址按钮 - 改用 onclick 属性
    function handleAddChangCaseAddress() {
        console.log('🔘 点击了涉黄新增地址按钮');
        addChangCaseAddressInput('');
    }

    // ✅ 陪侍新增地址按钮 - 改用 onclick 属性
    function handleAddpeiCaseAddress() {
        console.log('🔘 点击了陪侍新增地址按钮');
        addPeiCaseAddressInput('');
    }

    // ==================== 页面加载初始化 ====================
    $(document).ready(function () {
        console.log('========== 初始化涉案地址 ==========');

        // 初始化涉赌地址容器
        if ($('#duCaseAddressContainer').length > 0) {
            if ($('#duCaseAddressContainer . address-row').length === 0) {
                addDuCaseAddressInput('');
                console.log('📦 初始化涉赌地址容器');
            }
        }

        // 初始化涉黄地址容器
        if ($('#changCaseAddressContainer').length > 0) {
            if ($('#changCaseAddressContainer .address-row').length === 0) {
                addChangCaseAddressInput('');
                console.log('📦 初始化涉黄地址容器');
            }
        }

        // 初始化陪侍活动场所容器
        if ($('#peiCaseAddressContainer').length > 0) {
            if ($('#peiCaseAddressContainer .address-row').length === 0) {
                addPeiCaseAddressInput('');
                console.log('📦 初始化陪侍活动场所容器');
            }
        }

        console.log('========== 初始化完成 ==========');
    });

    // ==================== 涉案地址相关函数结束 ====================

    layui.use(['form', 'zTreeSelectM'], function () {
        var form = layui.form,
            zTreeSelectM = layui.zTreeSelectM,
            layer = layui.layer;
        form.render();
    });

    function edittagtree(index) {
        switch (index) {
            case 1:
                var parentid = $("#customlabelid").val();  //是否是一级菜单
                var parentlabel = $("#customlabelname").val() == "" ? "无" : $("#customlabelname").val();//父节点自动以标签
                var personlabel =${personnel.id};//人员类型标签
                var index = layui.layer.open({
                    title: "添加自定义标签",
                    type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                    content: '<c:url value="/jsp/personel/customlabel/add.jsp?menuid='+${param.menuid }+'&parentlabel='+parentlabel+'&personlabel='+personlabel+'&parentid='+parentid+'"/>',
                    offset: ["50"],
                    area: ['1000px', '600px'],
                    maxmin: true,
                    success: function (layero, index) {
                        setTimeout(function () {
                            layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                                tips: 3
                            });
                        }, 500)
                    }
                })
                break;
            case 2:
                var id = $("#customlabelid").val();
                if (id != 0) {
                    var index = layui.layer.open({
                        title: "修改自定义标签",
                        type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        content: locat + '/getCustomLabelByid.do?id=' + id + "&menuid=" +${param.menuid },
                        offset: ["50"],
                        area: ['1000px', '600px'],
                        maxmin: true,
                        success: function (layero, index) {
                            setTimeout(function () {
                                layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                                    tips: 3
                                });
                            }, 500)
                        }
                    })
                } else {
                    top.layer.alert("请先选择自定义标签！");
                }
                break;
            case 3:
                var id = $("#customlabelid").val();
                if (id != 0) {
                    top.layer.confirm('确定删除此信息？', function (index) {
                        layer.close(index);
                        $.getJSON(locat + "/cancelcustomlabel.do?id=" + id + "&menuid=" +${param.menuid }, {}, function (data) {
                            var str = eval('(' + data + ')');
                            if (str.flag == 1) {
                                top.layer.msg("数据删除成功！");
                                $("#tabCustomlabel").click()
                            } else {
                                top.layer.msg("删除失败!");
                                $("#tabCustomlabel").click()
                            }
                        });
                    });
                } else {
                    top.layer.alert("请先选择自定义标签！");
                }
                break;
        }
    }

    function bouncer(array) {
        return array.filter(function (val) {
            return !(!val || val == "");
        })
    }

    /**
     * 自动计算涉黄是否未成年案件
     * 根据处罚时间和人员出生日期自动判断
     */
    function calculateChangIsMinorCase() {
        console.log('========== 前端计算未成年案件 ==========');
        var cardnumber = '${personnel.cardnumber}';
        var punishDate = $('#chang_chsj').val();

        console.log('身份证号:', cardnumber);
        console.log('处罚时间:', punishDate);

        // 只支持18位身份证
        if (!cardnumber || cardnumber.length !== 18) {
            console.warn('⚠️ 身份证号不合法，无法自动判断是否未成年');
            return;
        }

        if (!punishDate || punishDate.length < 10) {
            console.warn('⚠️ 处罚时间为空或格式错误');
            return;
        }

        try {
            // 出生日期
            var birthYear = parseInt(cardnumber.substr(6, 4));
            var birthMonth = parseInt(cardnumber.substr(10, 2));
            var birthDay = parseInt(cardnumber.substr(12, 2));

            console.log('出生日期: ' + birthYear + '-' + birthMonth + '-' + birthDay);

            // 处罚日期（只取 yyyy-MM-dd）
            var punish = punishDate.substr(0, 10).split('-');
            var punishYear = parseInt(punish[0]);
            var punishMonth = parseInt(punish[1]);
            var punishDay = parseInt(punish[2]);

            console.log('处罚日期: ' + punishYear + '-' + punishMonth + '-' + punishDay);

            var age = punishYear - birthYear;
            console.log('初步年龄差: ' + age);

            if (punishMonth < birthMonth ||
                (punishMonth === birthMonth && punishDay < birthDay)) {
                age--;
                console.log('处罚日期未到生日，年龄-1');
            }

            console.log('✓ 最终计算年龄: ' + age);

            if (age < 18) {
                console.log('✓ 判定结果: 是未成年案件 (age=' + age + ' < 18)');
                $('input[name="isMinorCase"][value="1"]').prop('checked', true);
                $('input[name="isMinorCase"][value="0"]').prop('checked', false);
            } else {
                console.log('✓ 判定结果: 非未成年案件 (age=' + age + ' >= 18)');
                $('input[name="isMinorCase"][value="0"]').prop('checked', true);
                $('input[name="isMinorCase"][value="1"]').prop('checked', false);
            }

            layui.form.render('radio');

            // 验证设置是否成功
            var checkedValue = $('input[name="isMinorCase"]:checked').val();
            console.log('✓ Radio设置后的选中值: ' + checkedValue);
            console.log('========================================');
        } catch (e) {
            console.error('❌ 计算未成年案件失败', e);
        }
    }


</script>
<script type="text/javascript">
    layui.use(['element', 'form', 'jquery', 'table', 'treeSelect', 'zTreeSelectM', 'laydate'], function () {
        var element = layui.element,
            $ = layui.jquery,
            table = layui.table,
            laydate = layui.laydate,
            form = layui.form;

        // 注意：chsj 和 chang_chsj 的日期组件已在页面加载时初始化（第2619-2623行），无需重复初始化

        //方法级渲染
        table.render({
            elem: '#applyTable',
            toolbar: false,
            defaultToolbar: ['filter', 'print'],
            url: '<c:url value="/searchApplylabel.do"/>',
            where: {personnelid:${personnel.id }, examineflag: -1},
            limit: 5,
            method: 'post',
            cols: [[
                {field: 'applylabel1name', title: '申请标签1级', width: 200, align: "center"},
                {field: 'applylabel2name', title: '申请标签子级', align: "center"},
                {field: 'addtime', title: '申请时间', width: 200, align: "center"},
                {
                    field: 'examineflag', title: '审核标记', width: 150, align: "center", templet: function (item) {
                        if (item.examineflag == 0) {
                            return "未审核";
                        } else if (item.examineflag == 1) {
                            return "审核通过";
                        } else if (item.examineflag == 2) {
                            return "审核不通过";
                        }
                    }
                },
                {field: 'failreason', title: '审核理由', width: 200, align: "center"}
            ]],
            page: true
        });


        var _zTreeSelectMsz = {};
        form.on('checkbox(attributeLable)', function (data) {
            if (data.elem.checked == true) {
                if (document.getElementById("attribute" + data.value) == null) {
                    $('#attributelabel').append("<div id='div" + data.value + "'><div class='layui-col-md11' style='left:-30px;'><div class='layui-form-item my-form-item'><label class='layui-form-label'>" + data.elem.title +
                        "</label><div class='layui-input-block'><div id='attribute" + data.value + "'></div></div></div></div>" +
                        "<div class='layui-col-md1' style='left:-30px;'><div class='layui-form-item my-form-item'><button onclick='addLabel(" + data.value + ",&quot;" + data.elem.title + "&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div>" +
                        "<div class='layui-col-md12' style='left:-30px;'><div class='layui-form-item my-form-item'><label class='layui-form-label'>申请理由</label><div class='layui-input-block' width='100%';><textarea placeholder='请输入内容' class='layui-textarea' id='reason" + data.value + "'></textarea></div></div></div>");
                    if (data.value == 9) {
                        _zTreeSelectMsz[data.value] = layui.zTreeSelectM({
                            elem: '#attribute' + data.value,//元素容器【必填】
                            data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid=' + data.value,
                            type: 'get',  //设置了长度
                            max: 20,//最多选中个数，默认5
                            name: 'attributelabel2',//input的name 不设置与选择器相同(去#.)
                            delimiter: ',',//值的分隔符
                            field: {idName: 'id', titleName: 'name'},//候选项数据的键名
                            tips: '风险二级及以下标签：',
                            zTreeSetting: { //zTree设置
                                check: {
                                    enable: true,
                                    chkboxType: {"Y": "p", "N": "p"}
                                },
                                data: {
                                    simpleData: {
                                        enable: false
                                    },
                                    key: {
                                        name: 'name',
                                        children: 'children'
                                    }
                                }
                            }
                        });
                    } else {
                        _zTreeSelectMsz[data.value] = layui.zTreeSelectM({
                            elem: '#attribute' + data.value,//元素容器【必填】
                            data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid=' + data.value,
                            type: 'get',  //设置了长度
                            max: 5,//最多选中个数，默认5
                            name: 'attributelabel2',//input的name 不设置与选择器相同(去#.)
                            delimiter: ',',//值的分隔符
                            field: {idName: 'id', titleName: 'name'},//候选项数据的键名
                            tips: '风险二级及以下标签：',
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
                                }
                            }
                        });
                    }
                }
            } else {
                $("#div" + data.value).remove();
            }
        });

        form.on('submit(attributeLabelSub)', function (data) {
            //以前的正式标签
            var exzslabel1 = ",${personnel.zslabel1},";
            //需要审核的
            var addattributeLables = [];
            var addattributeLablenames = [];
            var addresult = [];
            //已有一级标签不需要审核的
            var uncheckattributeLables = [];
            $("input[name=attributeLable]:checked").each(function () {
                var p = $(this);
                if (exzslabel1.indexOf("," + p.val() + ",") == -1) {
                    addattributeLables.push(p.val());
                    addattributeLablenames.push(p.context.title);
                } else {
                    uncheckattributeLables.push(p.val());
                }
            });
            //新增审核
            $.each(addattributeLables, function (num, item) {
                addresult[num] = '{"attribute1":' + item + ',"attribute2":"' + $("#attribute" + item).find("input").val() + '","applylabel1name":"' + addattributeLablenames[num] + '","applylabel2name":"' + _zTreeSelectMsz[item].names.join() + '","reason":"' + $("#reason" + item).val() + '"}';
            });
            var addjson = "[" + addresult.join(",") + "]";
            //直接更新二级标签
            var attribute2 = [];
            $.each(uncheckattributeLables, function (num, item) {
                attribute2.push($("#attribute" + item).find("input").val());
            });
            attribute2str = attribute2.join(",");
            $.ajax({
                type: 'POST',
                url: '<c:url value="/applyAttribbuteLabel.do" />',
                data: {addjson: addjson, zslabel2: attribute2str, id:${personnel.id }},
                dataType: 'json',
                success: function (data) {
                    var str = eval('(' + data + ')');
                    if (str.flag == 1) {
                        top.layer.msg(str.msg);
                    } else {
                        top.layer.msg(str.msg);
                    }
                }
            });
            return false;
        });

        //监听行工具事件
        table.on('toolbar(goodsTable)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    var index = layui.layer.open({
                        title: "添加风险物品",
                        type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        content: '<c:url value="/jsp/personel/za/addGoods.jsp"/>?menuid=${menuid }&sjdx=${personnel.personname}&dxsfz=${personnel.cardnumber}',
                        area: ['800', '800px'],
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
                case 'addConnect':
                    top.layer.prompt({
                        formType: 2,//这里依然指定类型是多行文本框，但是在下面content中也可绑定多行文本框
                        title: '新增物品关联',
                        area: ['300px', '100px'],
                        btnAlign: 'c',
                        content: `<div><input type="text" name="codenum" id="codenum"  placeholder="请输入物品唯一标识码" class="layui-input" autocomplete="off"></div>`,
                        yes: function (index, layero) {
                            var codenum = top.$('#codenum').val();//获取多行文本框的值
                            if (codenum != "") {
                                $.getJSON(locat + "/updatePersonByCodenum.do?personid="+${personnel.id }+
                                '&codenum=' + codenum + '&menuid=' +${menuid}, {}, function (data) {
                                    if (data.flag > 0) {
                                        top.layer.close(index);
                                        table.reload('goodsTable', {});
                                        layer.msg(data.msg);
                                    } else {
                                        top.layer.close(index);
                                        layer.msg(data.msg);
                                    }
                                }
                            )
                                ;
                            } else {
                                layer.msg("请输入物品唯一标识码！", {icon: 5, anim: 6});
                            }
                        }
                    });
                    break;
                case 'cancel':
                    var data = JSON.stringify(checkStatus.data);
                    var datas = JSON.parse(data);
                    if (datas != "") {
                        var id = datas[0].id;
                        layer.confirm('确定删除此信息？', function (index) {
                            layer.close(index);
                            $.getJSON(locat + "/cancelGoodsConnect.do?id=" + id + '&menuid=' +${menuid}, {}, function (data) {
                                if (data.flag > 0) {
                                    top.layer.close(index);
                                    table.reload('goodsTable', {});
                                    layer.msg(data.msg);
                                } else {
                                    top.layer.close(index);
                                    layer.msg(data.msg);
                                }
                            });
                        });
                    }
                    break;
            }
        });


        // 注意：form.verify已被移除，改为在提交时使用layer.msg进行验证提示

        form.on('submit(duSub)', function (data) {
            // ===== 必填项验证（使用layer.msg显示提示） =====

            // 验证现住地派出所（如果县级市是江阴市）
            var duHomeCounty = $('#du_homeCounty').val();
            var duPoliceStation = $('#du_policeStation').val();
            if (duHomeCounty === '江阴市' && (!duPoliceStation || duPoliceStation.trim() === "")) {
                layer.msg('现住地派出所必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证涉赌情况综述
            // var duLssdqk = $('#formZaDu #lssdqk').val();
            // if (!duLssdqk || duLssdqk.trim() === "") {
            //     layer.msg('涉赌情况综述必填项未填写，无法提交！', {icon: 2, time: 3000});
            //     return false;
            // }

            // 验证赌博方式
            var dbfs = $('#dbfs').val();
            if (!dbfs || dbfs.trim() === "") {
                layer.msg('赌博方式必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证赌博部位
            var dbbw = $('#dbbw').val();
            if (!dbbw || dbbw.trim() === "") {
                layer.msg('赌博部位必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证处罚情况
            var cfjg = $('#cfjg').val();
            if (!cfjg || cfjg.trim() === "") {
                layer.msg('处罚情况必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证处罚日期
            var chsj = $('#chsj').val();
            if (!chsj || chsj.trim() === "") {
                layer.msg('处罚日期必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证查获经过
            // var chjg = $('#chjg').val();
            // if (!chjg || chjg.trim() === "") {
            //     layer.msg('查获经过必填项未填写，无法提交！', {icon: 2, time: 3000});
            //     return false;
            // }

            // 验证处理详情
            // var clxq = $('#clxq').val();
            // if (!clxq || clxq.trim() === "") {
            //     layer.msg('处理详情必填项未填写，无法提交！', {icon: 2, time: 3000});
            //     return false;
            // }

            // ===== 验证通过，继续提交 =====

            var duCaseAddressList = collectDuCaseAddressList();
            // 获取选中派出所对应的ID - 优先从DOM获取
            var $duPoliceSelect = $('#du_policeStation');
            var selectedPoliceStation = $duPoliceSelect.val();
            var homePoliceStationId = '';

            // ✅ 修复方案 1：尝试从选项的 attr 获取（最可靠）
            var $selectedOption = $duPoliceSelect.find('option:selected');
            if ($selectedOption.length > 0) {
                // 先尝试 data() 方法
                homePoliceStationId = $selectedOption.data('departmentid');
                // 如果失败，尝试 attr() 方法
                if (!homePoliceStationId) {
                    homePoliceStationId = $selectedOption.attr('data-departmentid');
                }
            }
            // ✅ 修复方案 2：如果上述方法都失败，从 policeData 查找
            if (!homePoliceStationId && selectedPoliceStation && policeData && policeData.length > 0) {
                for (var i = 0; i < policeData.length; i++) {
                    if (policeData[i].name === selectedPoliceStation) {
                        homePoliceStationId = policeData[i].departmentid || '';
                        break;
                    }
                }
            }
            console.log('涉赌提交: 派出所=' + selectedPoliceStation + ', ID=' + homePoliceStationId + ', 手机=' + $('#du_phone').val());

            // 收集现住地址字段
            var duHomeProvince = $('#du_homeProvince').val() || '';
            var duHomeCity = $('#du_homeCity').val() || '';
            var duHomeCounty = $('#du_homeCounty').val() || '';
            var duHomeTown = $('#du_homeTown').val() || '';
            var duHomeplace = $('#du_homeplace').val() || '';
            var duHomex = $('#du_homex').val() || '';
            var duHomey = $('#du_homey').val() || '';

            console.log('du field: pro=' + duHomeProvince + ', city=' + duHomeCity + ', country=' + duHomeCounty +
                ', town=' + duHomeTown + ', place=' + duHomeplace + ', x=' + duHomex + ', y=' + duHomey);

            // 收集关联的警情/案件ID
            var relJqIds = [];
            var relAjIds = [];
            if (window.selectedDuRelations && window.selectedDuRelations.length > 0) {
                window.selectedDuRelations.forEach(function (rel) {
                    if (rel.type === 'jq') {
                        relJqIds.push(rel.id);
                    } else if (rel.type === 'aj') {
                        relAjIds.push(rel.id);
                    }
                });
            }
            console.log('du JQ ID:', relJqIds.join(','));
            console.log('du AJ ID:', relAjIds.join(','));

            // ✅ 处理可能包含逗号的字段（历史数据合并显示导致），只取第一个值
            var rawPhone = $('#du_phone').val() || '';
            var phone = rawPhone.split(',')[0].trim();

            var rawLssdqk = $('#lssdqk').val() || '';
            var lssdqk = rawLssdqk.split(',')[0].trim();

            var rawCollectSource = $('#collectSource-du').val() || '';
            var collectSource = rawCollectSource.split(',')[0].trim();

            var rawCollectDate = $('#du_collectDate').val() || '';
            var collectDate = rawCollectDate.split(',')[0].trim();

            var rawPersonAttribute = $('#personAttribute-du').val() || '';
            var personAttribute = rawPersonAttribute.split(',')[0].trim();

            var rawDbfs = $('#dbfs').val() || '';
            var dbfs = rawDbfs.split(',')[0].trim();

            var rawDbbw = $('#dbbw').val() || '';
            var dbbw = rawDbbw.split(',')[0].trim();

            var rawChjg = $('#chjg').val() || '';
            var chjg = rawChjg.split(',')[0].trim();

            var rawCfjg = $('#cfjg').val() || '';
            var cfjg = rawCfjg.split(',')[0].trim();

            var rawClxq = $('#clxq').val() || '';
            var clxq = rawClxq.split(',')[0].trim();

            var rawChsj = $('#chsj').val() || '';
            var chsj = rawChsj.split(',')[0].trim();

            console.log('✓ 处理后字段值:');
            console.log('  collectDate: ' + rawCollectDate + ' -> ' + collectDate);
            console.log('  chsj: ' + rawChsj + ' -> ' + chsj);
            console.log('  phone: ' + rawPhone + ' -> ' + phone);

            // 获取涉赌前科和打处单位
            var hasSheduRecord = $('#hasSheduRecord-du').val() || '0';
            // ✅ 打处单位始终使用当前登录用户的departmentid，不使用历史记录的旧值
            var handleUnitCode = '<%=userSession != null ? userSession.getLoginUserDepartmentid() : ""%>';

            // ✅ 使用 $.ajax 代替 ajaxSubmit，完全自定义数据，避免表单自动序列化导致字段重复
            $.ajax({
                url: '<c:url value="/updateZaDu.do"/>',
                type: 'POST',
                data: {
                    personnelid:${personnel.id},
                    id: $('#firstDu').val(),
                    menuid:${menuid},
                    // 现住地址字段
                    homePoliceStationId: homePoliceStationId,
                    homeProvince: duHomeProvince,
                    homeCity: duHomeCity,
                    homeCounty: duHomeCounty,
                    homeTown: duHomeTown,
                    homeplace: duHomeplace,
                    homepolice: selectedPoliceStation,
                    homex: duHomex,
                    homey: duHomey,
                    // 联系电话
                    phone: phone,
                    // 涉赌前科
                    hasSheduRecord: hasSheduRecord,
                    // 打处单位
                    handleUnitCode: handleUnitCode,
                    // 历史涉赌情况综述
                    lssdqk: lssdqk,
                    // 采集来源
                    collectSource: collectSource,
                    // 采集日期
                    collectDate: collectDate,
                    // 人员属性
                    personAttribute: personAttribute,
                    // 赌博方式
                    dbfs: dbfs,
                    // 赌博部位
                    dbbw: dbbw,
                    // 查获经过
                    chjg: chjg,
                    // 处罚情况
                    cfjg: cfjg,
                    // 处理详情
                    clxq: clxq,
                    // 处罚时间
                    chsj: chsj,
                    // 涉案地址列表
                    caseAddressList: duCaseAddressList.join('，'),
                    // 操作人
                    updateoperator: '<%=userSession != null ? userSession.getLoginUserName() : ""%>',
                    // 状态
                    validflag: 1,
                    // 关联警情和案件ID
                    relJqIds: relJqIds.join(','),
                    relAjIds: relAjIds.join(',')
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    var obj = data;

                    // 统一兜底解析
                    if (typeof data === 'string') {
                        try {
                            obj = JSON.parse(data);
                        } catch (e) {
                            console.error('JSON解析失败:', data);
                            top.layer.msg('服务端返回数据格式错误', {icon: 2});
                            return;
                        }
                    }

                    console.log('涉赌背景提交响应:', obj);

                    if (obj.flag > 0) {
                        window.selectedPeiRelations = [];

                        var index = top.layer.msg('涉赌背景提交中，请稍候', {
                            icon: 16,
                            time: false,
                            shade: 0.8
                        });

                        setTimeout(function () {
                            top.layer.msg(obj.msg || '操作成功');
                            top.layer.close(index);
                            openZaPei(obj.flag);
                        }, 2000);

                    } else {
                        // ⚠️ 关键：权限不足也在这里
                        top.layer.msg(obj.msg || '操作失败', {
                            icon: 2,
                            time: 3000
                        });
                    }
                },
                error: function () {
                    layer.alert("请求失败！");
                }
            });
            return false;
        });
        form.on('submit(changSub)', function (data) {
        console.log('========== 涉黄表单提交 ==========');

        // ✅ 提交前强制重新计算未成年案件，确保值是最新的
        calculateChangIsMinorCase();

        // 等待一小段时间确保Radio值已更新
        setTimeout(function() {
            submitChangForm();
        }, 50);

        return false; // 阻止表单默认提交
    });

    // 实际的提交逻辑
    function submitChangForm() {
            // ===== 必填项验证（使用layer.msg显示提示） =====

            // 验证现住地派出所（如果县级市是江阴市）
            var changHomeCounty = $('#chang_homeCounty').val();
            var changPoliceStation = $('#chang_policeStation').val();
            if (changHomeCounty === '江阴市' && (!changPoliceStation || changPoliceStation.trim() === "")) {
                layer.msg('现住地派出所必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证涉嫖情况综述
            // var changLsscqk = $('#chang_lsscqk').val();
            // if (!changLsscqk || changLsscqk.trim() === "") {
            //     layer.msg('涉嫖情况综述必填项未填写，无法提交！', {icon: 2, time: 3000});
            //     return false;
            // }

            // 验证涉黄角色
            var changScjs = $('#chang_scjs').val();
            if (!changScjs || changScjs.trim() === "") {
                layer.msg('人员属性必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证涉黄方式
            var changMyfs = $('#chang_myfs').val();
            if (!changMyfs || changMyfs.trim() === "") {
                layer.msg('涉黄方式必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证涉黄类型
            var changType = $('#changType').val();
            if (!changType || changType.trim() === "") {
                layer.msg('涉黄类型必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证处罚情况
            var changCfjg = $('#chang_cfjg').val();
            if (!changCfjg || changCfjg.trim() === "") {
                layer.msg('处罚情况必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证处罚时间
            var changChsj = $('#chang_chsj').val();
            if (!changChsj || changChsj.trim() === "") {
                layer.msg('处罚时间必填项未填写，无法提交！', {icon: 2, time: 3000});
                return false;
            }

            // 验证查获经过
            // var changChjg = $('#chang_chjg').val();
            // if (!changChjg || changChjg.trim() === "") {
            //     layer.msg('查获经过必填项未填写，无法提交！', {icon: 2, time: 3000});
            //     return false;
            // }

            // 验证处理详情
            // var changClxq = $('#chang_clxq').val();
            // if (!changClxq || changClxq.trim() === "") {
            //     layer.msg('处理详情必填项未填写，无法提交！', {icon: 2, time: 3000});
            //     return false;
            // }

            // ===== 验证通过，继续提交 =====

            // 收集涉案地址列表
            var changCaseAddressList = collectChangCaseAddressList();

            // 获取现住地派出所ID
            var $changPoliceSelect = $('#chang_policeStation');
            var selectedChangPolice = $changPoliceSelect.val();
            var changHomePoliceStationId = '';
            var $selectedChangOption = $changPoliceSelect.find('option:selected');
            if ($selectedChangOption.length > 0) {
                changHomePoliceStationId = $selectedChangOption.data('departmentid');
                if (!changHomePoliceStationId) {
                    changHomePoliceStationId = $selectedChangOption.attr('data-departmentid');
                }
            }
            // 如果上述方法失败，从policeData查找
            if (!changHomePoliceStationId && selectedChangPolice && typeof policeData !== 'undefined' && policeData && policeData.length > 0) {
                for (var i = 0; i < policeData.length; i++) {
                    if (policeData[i].name === selectedChangPolice) {
                        changHomePoliceStationId = policeData[i].departmentid || '';
                        break;
                    }
                }
            }

            var changHomeProvince = $('#chang_homeProvince').val() || '';
            var changHomeCity = $('#chang_homeCity').val() || '';
            var changHomeCounty = $('#chang_homeCounty').val() || '';
            var changHomeTown = $('#chang_homeTown').val() || '';
            var changHomeplace = $('#chang_homeplace').val() || '';
            var changHomex = $('#chang_homex').val() || '';
            var changHomey = $('#chang_homey').val() || '';

            console.log('chang field: pro=' + changHomeProvince + ', city=' + changHomeCity + ', country=' + changHomeCounty +
                ', town=' + changHomeTown + ', place=' + changHomeplace + ', x=' + changHomex + ', y=' + changHomey);

            // 收集关联的警情/案件ID（如果有的话，非必填）
            var relJqIds = [];
            var relAjIds = [];
            if (window.selectedChangRelations && window.selectedChangRelations.length > 0) {
                window.selectedChangRelations.forEach(function (rel) {
                    if (rel.type === 'jq') {
                        relJqIds.push(rel.id);
                    } else if (rel.type === 'aj') {
                        relAjIds.push(rel.id);
                    }
                });
            }
            console.log('chang JQ ID:', relJqIds.join(','));
            console.log('chang AJ ID:', relAjIds.join(','));

            // ✅ 处理可能包含逗号的字段（历史数据合并显示导致），只取第一个值
            var rawChangPhone = $('#chang_phone').val() || '';
            var changPhone = rawChangPhone.split(',')[0].trim();

            var rawChangLsscqk = $('#chang_lsscqk').val() || '';
            var changLsscqk = rawChangLsscqk.split(',')[0].trim();

            var rawChangCollectSource = $('#collectSource-chang').val() || '';
            var changCollectSource = rawChangCollectSource.split(',')[0].trim();

            var rawChangCollectDate = $('#chang_collectDate').val() || '';
            var changCollectDate = rawChangCollectDate.split(',')[0].trim();

            var rawChangScjs = $('#chang_scjs').val() || '';
            var changScjs = rawChangScjs.split(',')[0].trim();

            var rawChangMyfs = $('#chang_myfs').val() || '';
            var changMyfs = rawChangMyfs.split(',')[0].trim();

            var rawChangType = $('#changType').val() || '';
            var changType = rawChangType.split(',')[0].trim();

            var rawChangChjg = $('#chang_chjg').val() || '';
            var changChjg = rawChangChjg.split(',')[0].trim();

            var rawChangCfjg = $('#chang_cfjg').val() || '';
            var changCfjg = rawChangCfjg.split(',')[0].trim();

            var rawChangClxq = $('#chang_clxq').val() || '';
            var changClxq = rawChangClxq.split(',')[0].trim();

            var rawChangChsj = $('#chang_chsj').val() || '';
            var changChsj = rawChangChsj.split(',')[0].trim();

            console.log('✓ 涉黄处理后字段值:');
            console.log('  collectDate: ' + rawChangCollectDate + ' -> ' + changCollectDate);
            console.log('  chang_chsj: ' + rawChangChsj + ' -> ' + changChsj);
            console.log('  phone: ' + rawChangPhone + ' -> ' + changPhone);

            // ✅ 获取是否未成年案件（从radio按钮获取选中的值）
            var isMinorCase = $('input[name="isMinorCase"]:checked').val() || '0';
            console.log('========== 涉黄提交前检查 ==========');
            console.log('  处罚时间(chang_chsj): ' + changChsj);
            console.log('  isMinorCase获取值: ' + isMinorCase);
            console.log('  Radio按钮状态:');
            $('input[name="isMinorCase"]').each(function() {
                console.log('    值=' + $(this).val() + ', 选中=' + $(this).prop('checked'));
            });
            console.log('====================================');

            // 获取涉黄前科和打处单位
            var hasShechangRecord = $('#hasShechangRecord-chang').val() || '0';
            // ✅ 打处单位始终使用当前登录用户的departmentid，不使用历史记录的旧值
            var changHandleUnitCode = '<%=userSession != null ? userSession.getLoginUserDepartmentid() : ""%>';

            // ✅ 使用 $.ajax 代替 ajaxSubmit，避免表单自动序列化导致字段重复
            $.ajax({
                url: '<c:url value="/updateZaChang.do"/>',
                type: 'POST',
                data: {
                    personnelid:${personnel.id},
                    id: $('#firstChang').val(),
                    menuid:${menuid},
                    // 现住地址字段
                    homePoliceStationId: changHomePoliceStationId,
                    homeProvince: changHomeProvince,
                    homeCity: changHomeCity,
                    homeCounty: changHomeCounty,
                    homeTown: changHomeTown,
                    homeplace: changHomeplace,
                    homepolice: selectedChangPolice,
                    homex: changHomex,
                    homey: changHomey,
                    // 联系电话
                    phone: changPhone,
                    // 涉黄前科
                    hasShechangRecord: hasShechangRecord,
                    // 打处单位
                    handleUnitCode: changHandleUnitCode,
                    // 涉嫖情况综述
                    chang_lsscqk: changLsscqk,
                    // 采集来源
                    collectSource: changCollectSource,
                    // 采集日期
                    collectDate: changCollectDate,
                    // 人员属性（涉黄角色）
                    chang_scjs: changScjs,
                    // 涉黄方式
                    chang_myfs: changMyfs,
                    // 涉黄类型
                    changType: changType,
                    // 查获经过
                    chang_chjg: changChjg,
                    // 处罚情况
                    chang_cfjg: changCfjg,
                    // 处理详情
                    chang_clxq: changClxq,
                    // 处罚时间
                    chang_chsj: changChsj,
                    // 是否未成年案件
                    isMinorCase: isMinorCase,
                    // 涉案地址列表
                    caseAddressList: changCaseAddressList.join('，'),
                    // 操作人
                    updateoperator: '<%=userSession != null ? userSession.getLoginUserName() : ""%>',
                    // 状态
                    validflag: 1,
                    // 关联警情和案件ID
                    relJqIds: relJqIds.join(','),
                    relAjIds: relAjIds.join(',')
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    var obj = data;

                    // 统一兜底解析
                    if (typeof data === 'string') {
                        try {
                            obj = JSON.parse(data);
                        } catch (e) {
                            console.error('JSON解析失败:', data);
                            top.layer.msg('服务端返回数据格式错误', {icon: 2});
                            return;
                        }
                    }

                    console.log('涉黄背景提交响应:', obj);

                    if (obj.flag > 0) {
                        window.selectedPeiRelations = [];

                        var index = top.layer.msg('涉黄背景提交中，请稍候', {
                            icon: 16,
                            time: false,
                            shade: 0.8
                        });

                        setTimeout(function () {
                            top.layer.msg(obj.msg || '操作成功');
                            top.layer.close(index);
                            openZaPei(obj.flag);
                        }, 2000);

                    } else {
                        // ⚠️ 关键：权限不足也在这里
                        top.layer.msg(obj.msg || '操作失败', {
                            icon: 2,
                            time: 3000
                        });
                    }
                },
                error: function () {
                    layer.alert("请求失败！");
                }
            });
        } // submitChangForm函数结束

        form.on('submit(peiSub)', function (data) {
            // 收集活动场所列表
            var peiActivityVenueList = collectPeiCaseAddressList();

            console.log('pei field =' + peiActivityVenueList.join('，'));

            // 收集关联的警情/案件ID（如果有的话，非必填）
            var relJqIds = [];
            var relAjIds = [];
            if (window.selectedPeiRelations && window.selectedPeiRelations.length > 0) {
                window.selectedPeiRelations.forEach(function (rel) {
                    if (rel.type === 'jq') {
                        relJqIds.push(rel.id);
                    } else if (rel.type === 'aj') {
                        relAjIds.push(rel.id);
                    }
                });
            }
            console.log('pei JQ ID:', relJqIds.join(','));
            console.log('pei AJ ID:', relAjIds.join(','));

            // ✅ ajaxSubmit会自动序列化表单中的hasShechangRecord字段，无需重复添加
            $("#formZaPei").ajaxSubmit({
                url: '<c:url value="/updateZaPei.do"/>',
                data: {
                    personnelid:${personnel.id},
                    id: $('#firstPei').val(),
                    menuid:${menuid},
                    // hasShechangRecord已在表单中，ajaxSubmit会自动序列化，无需重复添加
                    activityVenue: peiActivityVenueList.join('，'),  // ✅ 改为activityVenue匹配后端字段
                    memo: $('#pei_memo').val(),  // ✅ 角色标签
                    updateoperator: '<%=userSession != null ? userSession.getLoginUserName() : ""%>',
                    validflag: 1,
                    relJqIds: relJqIds.join(','),
                    relAjIds: relAjIds.join(',')
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    var obj = data;

                    // 统一兜底解析
                    if (typeof data === 'string') {
                        try {
                            obj = JSON.parse(data);
                        } catch (e) {
                            console.error('JSON解析失败:', data);
                            top.layer.msg('服务端返回数据格式错误', {icon: 2});
                            return;
                        }
                    }

                    console.log('陪侍背景提交响应:', obj);

                    if (obj.flag > 0) {
                        window.selectedPeiRelations = [];

                        var index = top.layer.msg('陪侍背景提交中，请稍候', {
                            icon: 16,
                            time: false,
                            shade: 0.8
                        });

                        setTimeout(function () {
                            top.layer.msg(obj.msg || '操作成功');
                            top.layer.close(index);
                            openZaPei(obj.flag);
                        }, 2000);

                    } else {
                        // ⚠️ 关键：权限不足也在这里
                        top.layer.msg(obj.msg || '操作失败', {
                            icon: 2,
                            time: 3000
                        });
                    }
                },
                error: function () {
                    layer.alert("请求失败！");
                }
            });
            return false;
        });

        $("#duHistory").click(function () {
            var index = layui.layer.open({
                title: "涉赌背景历史记录",
                type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                content: locat + "/jsp/personel/za/duhistory.jsp?personnelid=${personnel.id}",
                area: ['800', '600px'],
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
        });
        $("#changHistory").click(function () {
            var index = layui.layer.open({
                title: "涉黄背景历史记录",
                type: 2,  // iframe 层
                content: locat + "/jsp/personel/za/changhistory.jsp?personnelid=${personnel.id}&menuid=${menuid}",
                area: ['1400px', '600px'],  // ✅ 增加宽度以展示所有列
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
        });
        $("#PeiHistory").click(function () {
            var index = layui.layer.open({
                title: "陪侍背景历史记录",
                type: 2,  // iframe 层
                content: locat + "/jsp/personel/za/peihistory.jsp?personnelid=${personnel.id}&menuid=${menuid}",
                area: ['1400px', '600px'],
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
        });

    });

    function openZaDu(personnelid) {
        // 1. 基础字典数据加载（这些必须执行，否则下拉框没选项）
        loadBasicMsg('302', 'dbfs');               // 赌博方式
        loadBasicMsg('303', 'dbbw');               // 赌博部位
        loadBasicMsg('301', 'personAttribute-du'); // 涉赌人员属性
        loadBasicMsg('307', 'collectSource-du');   // 涉赌采集来源

        // 2. 无论何时都显示"历史记录"按钮
        $('#duHistory').show();

        // 3. 初始化派出所下拉框（传入空值，显示"请选择"）
        renderPoliceSelect({
            elem: '#du_policeStation',
            initValue: ''
        });

        // 4. 先初始化涉赌tab的省市县级联下拉框（必须在清空之前执行）
        initRegionCascade('du_home', '', '', '');

        // 5. 执行清空逻辑
        $('#firstDu').val(0); // 标记为新记录，ID设为0

        // 清空文本框、时间插件和隐藏域（不包括省市县select）
        $('#lssdqk, #chsj, #chjg, #clxq, #du_phone, #du_collectDate, #du_homeTown, #du_homeplace, #du_homex, #du_homey').val('');
        // 下拉框重置（不包括省市县select）
        $('#cfjg, #personAttribute-du, #collectSource-du, #dbfs, #dbbw').val('');

        // 6. 涉案地址初始化：清空容器并只给一个空输入框
        $('#duCaseAddressContainer').empty();
        addDuCaseAddressInput(''); // 调用您之前定义的函数生成第一个空框

        // 7. 隐藏原本因为有数据才显示的派出所区域
        togglePoliceDiv('', 'du_home');

        // 8. 【关键】重新渲染表单，使清空后的状态生效
        layui.form.render();
    }

    function openZaChang(personnelid) {
        loadBasicMsg('304', 'chang_scjs');               // 涉黄角色
        loadBasicMsg('305', 'chang_myfs');               // 涉黄方式
        loadBasicMsg('306', 'changType');                // 涉黄类型
        loadBasicMsg('307', 'collectSource-chang');     // 采集来源

        // 2. 无论何时都显示"历史记录"按钮
        $('#changHistory').show();

        // 3. 初始化派出所下拉框（传入空值，显示"请选择"）
        renderPoliceSelect({
            elem: '#chang_policeStation',
            initValue: ''
        });

        // 4. 先初始化涉黄tab的省市县级联下拉框（必须在清空之前执行）
        initRegionCascade('chang_home', '', '', '');

        // 5. 执行清空逻辑
        $('#firstChang').val(0); // 标记为新记录，ID设为0
        // 清空文本框、时间插件和隐藏域（不包括省市县select）
        $('#chang_lsscqk, #chang_chsj, #chang_chjg, #chang_clxq, #chang_phone, #chang_collectDate, #chang_homeTown, #chang_homeplace, #chang_homex, #chang_homey').val('');
        // 下拉框重置（不包括省市县select）
        $('#chang_cfjg, #chang_scjs, #collectSource-chang, #chang_myfs, #changType').val('');

        // 6. 涉案地址初始化：清空容器并只给一个空输入框
        $('#changCaseAddressContainer').empty();
        addChangCaseAddressInput(''); // 调用您之前定义的函数生成第一个空框

        // 7. 隐藏原本因为有数据才显示的派出所区域
        togglePoliceDiv('', 'chang_home');

        // 8. 【关键】重新渲染表单，使清空后的状态生效
        layui.form.render();
    }

    function openZaPei(personnelid) {
        // 1. 基础字典数据加载
        loadBasicMsg('310', 'pei_memo');// 陪侍角色标签
        loadBasicMsg('311', 'collectSource-pei');   // 陪侍采集来源

        // 2. 无论何时都显示"历史记录"按钮
        $('#PeiHistory').show();

        // 3. 执行清空逻辑
        $('#firstPei').val(0); // 标记为新记录，ID设为0

        // 清空文本框和时间插件
        $('#otherMemo, #pei_collectDate, #pei_caseName, #pei_relatedCaseId').val('');
        // 下拉框重置
        $('#collectSource-pei').val('');

        // 4. 活动场所初始化：清空容器并只给一个空输入框
        $('#peiCaseAddressContainer').empty();
        addPeiCaseAddressInput(''); // 调用函数生成第一个空框

        // 5. 【关键】重新渲染表单，使清空后的状态生效
        layui.form.render();
    }

    function openAttributelabel() {
        $("#zTree").html("");
        $("#attributelabel").html("");

        // 获取人员已拥有的标签，确保过滤掉空字符串
        var zslabel1Str = "${personnel.zslabel1}" || "";
        var zslabel2Str = "${personnel.zslabel2}" || "";

        var zslabel1Array = zslabel1Str.split(",").filter(function(id) {
            return id && id.trim() !== "";
        });
        var zslabel2Array = zslabel2Str.split(",").filter(function(id) {
            return id && id.trim() !== "";
        });

        console.log("一级标签:", zslabel1Array);
        console.log("子标签:", zslabel2Array);

        // 如果没有一级标签，显示提示信息
        if (zslabel1Array.length === 0) {
            $("#attributelabel").append(
                "<table class='layui-table' lay-skin='line'>" +
                "  <thead>" +
                "    <tr>" +
                "      <th width='30%'>一级标签</th>" +
                "      <th width='70%'>子标签</th>" +
                "    </tr>" +
                "  </thead>" +
                "  <tbody>" +
                "    <tr>" +
                "      <td colspan='2' style='text-align:center;color:#999;'>暂无标签</td>" +
                "    </tr>" +
                "  </tbody>" +
                "</table>"
            );
            return;
        }

        // 创建table结构
        var tableHtml =
            "<table class='layui-table' lay-skin='line'>" +
            "  <thead>" +
            "    <tr>" +
            "      <th width='30%'>一级标签</th>" +
            "      <th width='70%'>子标签</th>" +
            "    </tr>" +
            "  </thead>" +
            "  <tbody id='labelTableBody'>" +
            "  </tbody>" +
            "</table>";

        $("#attributelabel").append(tableHtml);

        // 获取所有一级标签
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getRootAttributeLabel.do" />',
            dataType: 'json',
            async: false,
            success: function (rootLabels) {

                // 遍历人员已拥有的每个一级标签
                $.each(rootLabels, function (num, rootLabel) {

                    // 只展示人员已拥有的一级标签
                    if (zslabel1Array.indexOf(String(rootLabel.id)) === -1) {
                        return true; // continue
                    }

                    // 获取该一级标签对应的所有子标签
                    $.ajax({
                        type: 'GET',
                        url: '<c:url value="/getChildrenLabelByParentid.do"/>',
                        data: { parentid: rootLabel.id },
                        dataType: 'json',
                        async: false,
                        success: function (childLabels) {

                            // 筛选出人员已拥有的子标签名称
                            var ownedChildLabels = [];
                            if (childLabels && childLabels.length > 0) {
                                console.log("子标签数据:", childLabels);
                                $.each(childLabels, function (i, childLabel) {
                                    // TreeSelect返回的JSON中，字段名是name而不是attributelabel
                                    if (childLabel && childLabel.id) {
                                        if (zslabel2Array.indexOf(String(childLabel.id)) !== -1) {
                                            // 优先使用name字段，如果没有则使用title字段
                                            var labelName = childLabel.name || childLabel.title || "";
                                            if (labelName && labelName.trim() !== "") {
                                                ownedChildLabels.push(labelName);
                                            }
                                        }
                                    }
                                });
                            }

                            console.log("筛选出的子标签名称:", ownedChildLabels);

                            // 构建子标签显示内容
                            var childLabelsHtml = "";
                            if (ownedChildLabels.length > 0) {
                                // 有子标签，用顿号分隔显示
                                childLabelsHtml = ownedChildLabels.join("、");
                            } else {
                                // 无子标签
                                childLabelsHtml = "<span style='color:#999;'>无子标签</span>";
                            }

                            // 添加一行到table
                            var rowHtml =
                                "<tr>" +
                                "  <td style='font-weight:600;'>" + rootLabel.attributelabel + "</td>" +
                                "  <td>" + childLabelsHtml + "</td>" +
                                "</tr>";

                            $("#labelTableBody").append(rowHtml);
                        }
                    });
                });

                layui.form.render();
            }
        });
    }


    function openGoodsShow() {
        //方法级渲染
        layui.table.render({
            elem: '#goodsTable',
            toolbar: true,
            defaultToolbar: ['filter', 'print'],
            url: '<c:url value="/searchItemByPerson.do"/>',
            where: {personid:${personnel.id }},
            limit: 5,
            method: 'post',
            toolbar: '#goodstoolbar',
            cols: [[
                {field: 'id', type: 'radio', fixed: 'true', align: "center"},
                {field: 'itemtype', title: '物品品种', width: 200, align: "center"},
                {field: 'goodscodename', title: '物品型号', width: 200, align: "center"},
                {field: 'casename', title: '案件名称', align: "center"},
                {field: 'sjdate', title: '收缴日期', width: 200, align: "center"}
            ]],
            page: true
        });
    }

    function addLabel(parentid, parentlabel) {
        var index = layui.layer.open({
            title: "添加人员二级标签",
            offset: ["50"],
            type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            content: '<c:url value="/jsp/personel/attributelabel/add1.jsp?examineflag=0&menuid='+${menuid }+'&parentlabel='+parentlabel+'&parentid='+parentid+'"/>',
            area: ['900', '500px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            }
        })
    }

    function examine(personnelid) {
        var jointcontrollevel = "${wenGrade.jointcontrollevel}";
        if (jointcontrollevel == null) {
            jointcontrollevel = "";
        }
        $.getJSON(locat + "/getjointcontrollevelCount.do?personnelid=" + personnelid, {}, function (data) {
            var str = eval('(' + data + ')');
            if (str.flag > 0) {
                top.layer.msg("该人员存在未审核联控级别调整申请，不可重复申请......");
            } else {
                var index = layui.layer.open({
                    title: "联控级别调整申请",
                    type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                    content: '<c:url value="/jsp/personel/wen/jointcontrollevel/add.jsp?menuid='+${param.menuid}+'&personnelid='+personnelid+'&jointcontrollevel_old='+jointcontrollevel+'"/>',
                    area: ['800', '500px'],
                    offset: ['50'],
                    maxmin: true,
                    success: function (layero, index) {
                        setTimeout(function () {
                            layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                                tips: 3
                            });
                        }, 500)
                    }
                })
            }
        });
    }

    function echoZaDuData(data) {
        console.log('📥 从历史记录接收数据:', data);

        layui.use('form', function () {
            var form = layui.form;

            // ✅ 设置 ID（用于后续更新）
            $('#firstDu').val(data.id || 0);

            // ✅ 现住地址 - 省市县镇
            $('#du_homeProvince').val(data.homeProvince || '');
            $('#du_homeCity').val(data.homeCity || '');
            $('#du_homeCounty').val(data.homeCounty || '');
            $('#du_homeTown').val(data.homeTown || '');
            $('#du_homeplace').val(data.homeDetail || '');

            // ✅ 派出所
            if (data.homePoliceStationName) {
                $('#du_policeStation').val(data.homePoliceStationName);
            }

            // ✅ 联系电话
            $('#du_phone').val(data.phone || '');

            // ✅ 历史涉赌情况综述
            $('#lssdqk').val(data.lssdqk || '');

            // ✅ 采集来源
            $('#collectSource-du').val(data.collectSource || '');

            // ✅ 采集日期
            $('#du_collectDate').val(data.collectDate || '');

            // ✅ 人员属性
            $('#personAttribute-du').val(data.personAttribute || '');

            // ✅ 赌博方式
            $('#dbfs').val(data.dbfs || '');

            // ✅ 赌博部位
            $('#dbbw').val(data.dbbw || '');

            // ✅ 涉赌前科
            $('#hasSheduRecord-du').val(data.hasSheduRecord || '0');

            // ✅ 打处单位显示（仅显示历史记录的单位名称供参考，不覆盖隐藏字段）
            // du_handleUnitCode 始终保持当前登录用户的 departmentid，提交时使用当前用户部门
            if (data.handleUnitCode) {
                var code = parseInt(data.handleUnitCode);
                var unitName = '';
                if (code >= 240 && code <= 263) {
                    if (policeData && policeData.length > 0) {
                        for (var i = 0; i < policeData.length; i++) {
                            if (policeData[i].departmentid == data.handleUnitCode) {
                                unitName = policeData[i].name;
                                break;
                            }
                        }
                    }
                    if (!unitName) {
                        unitName = '部门' + data.handleUnitCode;
                    }
                } else {
                    unitName = '治安大队';
                }
                // ⚠️ 不覆盖 du_handleUnitCode，仅更新显示名称供参考
                // 提交时 du_handleUnitCode 仍为当前登录用户的 departmentid
                $('#du_handleUnit').val(unitName + '（记录）');
            }

            // ✅ 查获经过
            $('#chjg').val(data.chjg || '');

            // ✅ 处罚情况：如存在cfjg字段则直接回显，否则不覆盖
            if (data.cfjg) {
                $('#cfjg').val(data.cfjg);
            }

            // ✅ 处理详情
            $('#clxq').val(data.clxq || '');

            // ✅ 处罚时间
            $('#chsj').val(data.chsj || '');

            // ✅ 涉案地址列表 - 重新生成地址行
            if (data.caseAddressList) {
                $('#duCaseAddressContainer').empty();
                var addresses = data.caseAddressList.split('，');
                addresses.forEach(function (addr) {
                    if (addr.trim()) {
                        addDuCaseAddressInput(addr);
                    }
                });
            }

            // ✅ 加载关联的警情和案件
            if (data.id) {
                console.log('📌 加载涉赌关联关系，duId:', data.id);
                loadExistingDuRel(data.id);
            }

            // ✅ 重新渲染表单
            form.render();

            // ✅ 滚动到涉赌表单位置
            var duFormPosition = $('#formZaDu').offset().top - 100;
            $('html, body').animate({
                scrollTop: duFormPosition
            }, 500);

            console.log('✓ 数据回显完成');
        });
    }

    // ✅ 涉黄背景数据回显方法
    function echoZaChangData(data) {
        console.log('📥 涉黄背景数据回显:', data);

        layui.use('form', function () {
            var form = layui.form;

            // ✅ 设置 ID
            $('#firstChang').val(data.id || 0);

            // ✅ 现住地址 - 省市县镇
            $('#chang_homeProvince').val(data.homeProvince || '');
            $('#chang_homeCity').val(data.homeCity || '');
            $('#chang_homeCounty').val(data.homeCounty || '');
            $('#chang_homeTown').val(data.homeTown || '');
            $('#chang_homeplace').val(data.homeDetail || '');

            // ✅ 派出所
            if (data.homePoliceStationName) {
                $('#chang_policeStation').val(data.homePoliceStationName);
            }
            // ✅ 联系电话
            $('#chang_phone').val(data.phone || '');

            // ✅ 涉嫖情况综述
            $('#chang_lsscqk').val(data.chang_lsscqk || '');

            // ✅ 处罚时间
            $('#chang_chsj').val(data.chang_chsj || '');

            // ✅ 查获经过
            $('#chang_chjg').val(data.chang_chjg || '');

            // ✅ 处理详情
            $('#chang_clxq').val(data.chang_clxq || '');

            // ✅ 联系电话
            $('#chang_phone').val(data.phone || '');

            // ✅ 采集日期
            $('#chang_collectDate').val(data.collectDate || '');

            // ✅ 处罚情况：如存在chang_cfjg字段则直接回显，否则不覆盖
            if (data.chang_cfjg) {
                $('#chang_cfjg').val(data.chang_cfjg);
            }

            // ✅ 采集来源
            $('#collectSource-chang').val(data.collectSource || '');

            // ✅ 涉黄方式
            $('#chang_myfs').val(data.chang_myfs || '');

            // ✅ 涉黄类型
            $('#changType').val(data.changType || '');

            // ✅ 人员属性（涉黄角色）
            $('#chang_scjs').val(data.chang_scjs || '');

            // ✅ 涉黄前科
            $('#hasShechangRecord-chang').val(data.hasShechangRecord || '0');

            // ✅ 打处单位显示（仅显示历史记录的单位名称供参考，不覆盖隐藏字段）
            // chang_handleUnitCode 始终保持当前登录用户的 departmentid，提交时使用当前用户部门
            if (data.handleUnitCode) {
                var code = parseInt(data.handleUnitCode);
                var unitName = '';
                if (code >= 240 && code <= 263) {
                    if (policeData && policeData.length > 0) {
                        for (var i = 0; i < policeData.length; i++) {
                            if (policeData[i].departmentid == data.handleUnitCode) {
                                unitName = policeData[i].name;
                                break;
                            }
                        }
                    }
                    if (!unitName) {
                        unitName = '部门' + data.handleUnitCode;
                    }
                } else {
                    unitName = '治安大队';
                }
                // ⚠️ 不覆盖 chang_handleUnitCode，仅更新显示名称供参考
                // 提交时 chang_handleUnitCode 仍为当前登录用户的 departmentid
                $('#chang_handleUnit').val(unitName + '（记录）');
            }

            // ✅ 未成年案件 - 根据处罚时间自动计算
            // 先调用计算函数，而不是直接设置值
            if (data.chang_chsj) {
                setTimeout(function() {
                    calculateChangIsMinorCase();
                }, 100);
            }


            // ✅ 涉案地址列表 - 重新生成地址行
            if (data.caseAddressList) {
                $('#changCaseAddressContainer').empty();
                var addresses = data.caseAddressList.split('，');
                addresses.forEach(function (addr) {
                    if (addr.trim()) {
                        addChangCaseAddressInput(addr);
                    }
                });
            }

            // ✅ 加载关联的警情和案件
            if (data.id) {
                console.log('📌 加载涉黄关联关系，changId:', data.id);
                loadExistingChangRel(data.id);
            }

            // ✅ 重新渲染表单
            form.render();

            // ✅ 滚动到涉赌表单位置
            var changFormPosition = $('#formZaChang').offset().top - 100;
            $('html, body').animate({
                scrollTop: changFormPosition
            }, 500);

            console.log('✓ 涉黄数据回显完成');
        });
    }

    // ✅ 陪侍记录数据回显方法
    function echoZaPeiData(data) {
        console.log('📥 陪侍记录数据回显:', data);

        layui.use('form', function () {
            var form = layui.form;

            // ✅ 设置 ID
            $('#firstPei').val(data.id || 0);

            // ✅ 陪侍情况综述 - 使用otherMemo字段
            $('#otherMemo').val(data.otherMemo || '');

            // ✅ 采集日期
            $('#pei_collectDate').val(data.collectDate || '');

            // ✅ 采集来源
            $('#collectSource-pei').val(data.collectSource || '');

            // ✅ 角色标签
            $('#pei_memo').val(data.memo || '');

            // ✅ 涉黄前科
            $('#hasShechangRecord-pei').val(data.hasShechangRecord || '0');

            // ✅ 活动场所列表 - 重新生成地址行
            if (data.activityVenue) {
                $('#peiCaseAddressContainer').empty();
                var addresses = data.activityVenue.split('，');
                addresses.forEach(function (addr) {
                    if (addr.trim()) {
                        addPeiCaseAddressInput(addr);
                    }
                });
            }
            // ✅ 加载关联的警情和案件
            if (data.id) {
                console.log('📌 加载陪侍关联关系，peiId:', data.id);
                loadExistingPeiRel(data.id);
            }
            // ✅ 重新渲染表单
            form.render();

            // ✅ 滚动到涉赌表单位置
            var peiFormPosition = $('#formZaPei').offset().top - 100;
            $('html, body').animate({
                scrollTop: peiFormPosition
            }, 500);

            console.log('✓ 陪侍数据回显完成');
        });
    }

</script>


<script type="text/javascript">
    function openPGis(type, name) {
        var place = $("#" + type + "place").val().trim();
        var x = $("#" + type + "x").val();
        var y = $("#" + type + "y").val();
        var f1 = function (event) {
            place = event.data.mc;
            x = event.data.lx;
            y = event.data.ly;
            $("#" + type + "place").val(place);
            $("#" + type + "x").val(x);
            $("#" + type + "y").val(y);
            layer.close(index);
            window.removeEventListener('message', f1, false);
        };
        var index = layui.layer.open({
            title: name + "标准地址修改",
            offset: ["50"],
            type: 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            content: 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc=' + place + '&lx=' + x + '&ly=' + y,
            area: ['800', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            cancel: function () {
                window.removeEventListener('message', f1, false);
            }
        })
        layui.layer.full(index);
        window.addEventListener('message', f1);
    }

    function showAddressHistory(personnelid) {
        var index = layui.layer.open({
            title: "历史住址记录",
            type: 2,
            content: '<c:url value="/jsp/personel/za/selectAddressHistory.jsp"/>?personnelid=' + personnelid,
            area: ['900px', '500px'],
            offset: '50px',
            maxmin: true
        });
    }

    // 涉赌背景tab专用地图选点函数
    function openPGisDu(type, name) {
        var place = $("#du_homeplace").val().trim();
        var x = $("#du_homex").val();
        var y = $("#du_homey").val();
        var f1 = function (event) {
            place = event.data.mc;
            x = event.data.lx;
            y = event.data.ly;
            $("#du_homeplace").val(place);
            $("#du_homex").val(x);
            $("#du_homey").val(y);
            layer.close(index);
            window.removeEventListener('message', f1, false);
        };
        var index = layui.layer.open({
            title: name + "标准地址修改",
            offset: ["50"],
            type: 2,
            content: 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc=' + place + '&lx=' + x + '&ly=' + y,
            area: ['800', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            cancel: function () {
                window.removeEventListener('message', f1, false);
            }
        })
        layui.layer.full(index);
        window.addEventListener('message', f1);
    }

    // 涉黄背景tab专用地图选点函数
    function openPGisChang(type, name) {
        var place = $("#chang_homeplace").val().trim();
        var x = $("#chang_homex").val();
        var y = $("#chang_homey").val();
        var f1 = function (event) {
            place = event.data.mc;
            x = event.data.lx;
            y = event.data.ly;
            $("#chang_homeplace").val(place);
            $("#chang_homex").val(x);
            $("#chang_homey").val(y);
            layer.close(index);
            window.removeEventListener('message', f1, false);
        };
        var index = layui.layer.open({
            title: name + "标准地址修改",
            offset: ["50"],
            type: 2,
            content: 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc=' + place + '&lx=' + x + '&ly=' + y,
            area: ['800', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            cancel: function () {
                window.removeEventListener('message', f1, false);
            }
        })
        layui.layer.full(index);
        window.addEventListener('message', f1);
    }

    // 涉赌背景tab - 涉案地址地图选点函数（支持动态多个）
    function openPGisDuCaseAddress(addressId) {
        var place = $("#" + addressId).val().trim();
        var x = $("#" + addressId + "_x").val();
        var y = $("#" + addressId + "_y").val();
        var f1 = function (event) {
            place = event.data.mc;
            x = event.data.lx;
            y = event.data.ly;
            $("#" + addressId).val(place);
            $("#" + addressId + "_x").val(x);
            $("#" + addressId + "_y").val(y);
            layer.close(index);
            window.removeEventListener('message', f1, false);
        };
        var index = layui.layer.open({
            title: "涉案地址标准地址修改",
            offset: ["50"],
            type: 2,
            content: 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc=' + place + '&lx=' + x + '&ly=' + y,
            area: ['800', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            cancel: function () {
                window.removeEventListener('message', f1, false);
            }
        })
        layui.layer.full(index);
        window.addEventListener('message', f1);
    }

    // 涉黄背景tab - 涉案地址地图选点函数（支持动态多个）
    function openPGisChangCaseAddress(addressId) {
        var place = $("#" + addressId).val().trim();
        var x = $("#" + addressId + "_x").val();
        var y = $("#" + addressId + "_y").val();
        var f1 = function (event) {
            place = event.data.mc;
            x = event.data.lx;
            y = event.data.ly;
            $("#" + addressId).val(place);
            $("#" + addressId + "_x").val(x);
            $("#" + addressId + "_y").val(y);
            layer.close(index);
            window.removeEventListener('message', f1, false);
        };
        var index = layui.layer.open({
            title: "涉案地址标准地址修改",
            offset: ["50"],
            type: 2,
            content: 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc=' + place + '&lx=' + x + '&ly=' + y,
            area: ['800', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            cancel: function () {
                window.removeEventListener('message', f1, false);
            }
        })
        layui.layer.full(index);
        window.addEventListener('message', f1);
    }

    // 陪侍背景tab - 活动场所地图选点函数（支持动态多个）
    function openPGisPeiActivityVenue(addressId) {
        var place = $("#" + addressId).val().trim();
        var x = $("#" + addressId + "_x").val();
        var y = $("#" + addressId + "_y").val();
        var f1 = function (event) {
            place = event.data.mc;
            x = event.data.lx;
            y = event.data.ly;
            $("#" + addressId).val(place);
            $("#" + addressId + "_x").val(x);
            $("#" + addressId + "_y").val(y);
            layer.close(index);
            window.removeEventListener('message', f1, false);
        };
        var index = layui.layer.open({
            title: "活动场所标准地址修改",
            offset: ["50"],
            type: 2,
            content: 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc=' + place + '&lx=' + x + '&ly=' + y,
            area: ['800', '600px'],
            maxmin: true,
            success: function (layero, index) {
                setTimeout(function () {
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }, 500)
            },
            cancel: function () {
                window.removeEventListener('message', f1, false);
            }
        })
        layui.layer.full(index);
        window.addEventListener('message', f1);
    }

    // 涉赌背景tab - 根据县级市判断派出所显示
    function checkDuPoliceStation() {
        var county = $('#du_homeCounty').val().trim();
        togglePoliceDiv(county, 'du_home');
    }

    // 涉黄背景tab - 根据县级市判断派出所显示
    function checkChangPoliceStation() {
        var county = $('#chang_homeCounty').val().trim();
        togglePoliceDiv(county, 'chang_home');
    }


    function openZaExtend(personnelid) {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getZaExtend.do?personnelid="/>' + personnelid,
            dataType: 'json',
            async: false,
            success: function (data) {
                $("#zy").val(data.zaExtend.zy);
                $("#workunit").val(data.zaExtend.workunit);
            }
        });
    }

    // ========== 涉警涉案函数定义 ==========
    // 从personel221018.js复制的函数
    /**
     * 打开关联警情信息（只读展示，附带涉赌/涉黄/陪侍关联ID）
     * @param sfzh 身份证号
     */
    function openzajqxx(sfzh) {
        layui.table.render({
            elem: '#jqxxTable',
            toolbar: true,
            defaultToolbar: ['filter', 'exports', 'print'],
            url: locat + "/queryZaJqxxWithRel.do?sfzh=" + sfzh,
            method: 'post',
            cols: [[
                {field: 'id', type: 'radio', fixed: 'true', align: "center"},
                {field: 'jjrqsj', title: '接警时间', width: 180, align: "center"},
                {field: 'bjnr', title: '报警内容', width: 150, align: "center"},
                {field: 'bjlx', title: '报警类型', width: 150, align: "center"},
                {field: 'sfdd', title: '事发地点', width: 150, align: "center"},
                {field: 'cljgnr', title: '处理结果内容', width: 150, align: "center"},
                {field: 'cjdwmc', title: '处警单位名称', width: 150, align: "center"},
                {
                    field: 'du_ids',
                    title: '关联涉赌',
                    width: 120,
                    align: "center",
                    templet: function(d) {
                        return d.du_ids ? '<span style="color:#1E9FFF;">' + d.du_ids + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    field: 'chang_ids',
                    title: '关联涉黄',
                    width: 120,
                    align: "center",
                    templet: function(d) {
                        return d.chang_ids ? '<span style="color:#1E9FFF;">' + d.chang_ids + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    field: 'pei_ids',
                    title: '关联陪侍',
                    width: 120,
                    align: "center",
                    templet: function(d) {
                        return d.pei_ids ? '<span style="color:#1E9FFF;">' + d.pei_ids + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    title: '关联详情',
                    width: 100,
                    align: 'center',
                    templet: function(d) {
                        if(d.du_ids || d.chang_ids || d.pei_ids){
                            return '<button class="layui-btn layui-btn-xs layui-btn-normal" onclick="showJqRelDetail(' + d.id + ',\'' + (d.du_ids || '') + '\',\'' + (d.chang_ids || '') + '\',\'' + (d.pei_ids || '') + '\')">查看</button>';
                        } else {
                            return '<span style="color:#ccc;">无关联</span>';
                        }
                    }
                }
            ]],
            page: true,
            limit: 10
        });
    }

    /**
     * 打开关联案件信息（只读展示，附带涉赌/涉黄/陪侍关联ID）
     * @param sfzh 身份证号
     */
    function openzaajxx(sfzh) {
        layui.table.render({
            elem: '#ajxxTable',
            toolbar: true,
            defaultToolbar: ['filter', 'exports', 'print'],
            url: locat + "/queryZaAjxxWithRel.do?sfzh=" + sfzh,
            method: 'post',
            cols: [[
                {field: 'id', type: 'radio', fixed: 'true', align: "center"},
                {field: 'jjbh', title: '案件编号', width: 180, align: "center"},
                {field: 'slsj', title: '受理时间', width: 180, align: "center"},
                {field: 'ajlb', title: '案件类别', width: 150, align: "center"},
                {field: 'ajmc', title: '案件名称', width: 150, align: "center"},
                {field: 'sldwmc', title: '受理单位', width: 150, align: "center"},
                {field: 'jyaq', title: '简要案情', width: 150, align: "center"},
                {field: 'cfqk', title: '处罚情况', width: 180, align: "center"},
                {
                    field: 'cfrq',
                    title: '处罚日期',
                    width: 150,
                    align: "center",
                    templet: function(d) {
                        if (d.cfrq && d.cfrq.length === 14) {
                            // 格式：20260318134727 -> 2026-03-18
                            return d.cfrq.substring(0, 4) + '-' + d.cfrq.substring(4, 6) + '-' + d.cfrq.substring(6, 8);
                        }
                        return d.cfrq || '';
                    }
                },
                {
                    field: 'du_ids',
                    title: '关联涉赌',
                    width: 120,
                    align: "center",
                    templet: function(d) {
                        return d.du_ids ? '<span style="color:#1E9FFF;">' + d.du_ids + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    field: 'chang_ids',
                    title: '关联涉黄',
                    width: 120,
                    align: "center",
                    templet: function(d) {
                        return d.chang_ids ? '<span style="color:#1E9FFF;">' + d.chang_ids + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    field: 'pei_ids',
                    title: '关联陪侍',
                    width: 120,
                    align: "center",
                    templet: function(d) {
                        return d.pei_ids ? '<span style="color:#1E9FFF;">' + d.pei_ids + '</span>' : '<span style="color:#ccc;">-</span>';
                    }
                },
                {
                    title: '关联详情',
                    width: 100,
                    align: 'center',
                    templet: function(d) {
                        if(d.du_ids || d.chang_ids || d.pei_ids){
                            return '<button class="layui-btn layui-btn-xs layui-btn-normal" onclick="showAjRelDetail(' + d.id + ',\'' + (d.du_ids || '') + '\',\'' + (d.chang_ids || '') + '\',\'' + (d.pei_ids || '') + '\')">查看</button>';
                        } else {
                            return '<span style="color:#ccc;">无关联</span>';
                        }
                    }
                }
            ]],
            page: true,
            limit: 10
        });
    }

    /**
     * 显示警情关联详情（涉赌/涉黄/陪侍记录）
     */
    function showJqRelDetail(jqId, duIds, changIds, peiIds) {
        var content = '<div style="padding:20px;">';

        // 涉赌记录详情
        if(duIds && duIds.trim()){
            content += '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding-bottom:5px;">关联涉赌记录</h3>';
            content += '<div id="duRelDetail" style="margin-bottom:20px;"></div>';
        }

        // 涉黄记录详情
        if(changIds && changIds.trim()){
            content += '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding-bottom:5px;">关联涉黄记录</h3>';
            content += '<div id="changRelDetail" style="margin-bottom:20px;"></div>';
        }

        // 陪侍记录详情
        if(peiIds && peiIds.trim()){
            content += '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding-bottom:5px;">关联陪侍记录</h3>';
            content += '<div id="peiRelDetail" style="margin-bottom:20px;"></div>';
        }

        content += '</div>';

        layui.layer.open({
            title: '警情关联详情',
            type: 1,
            content: content,
            area: ['900px', '70%'],
            offset: '50px',
            success: function(){
                if(duIds && duIds.trim()) loadDuDetails(duIds.split(','), '#duRelDetail');
                if(changIds && changIds.trim()) loadChangDetails(changIds.split(','), '#changRelDetail');
                if(peiIds && peiIds.trim()) loadPeiDetails(peiIds.split(','), '#peiRelDetail');
            }
        });
    }

    /**
     * 显示案件关联详情（涉赌/涉黄/陪侍记录）
     */
    function showAjRelDetail(ajId, duIds, changIds, peiIds) {
        var content = '<div style="padding:20px;">';

        if(duIds && duIds.trim()){
            content += '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding-bottom:5px;">关联涉赌记录</h3>';
            content += '<div id="duRelDetail" style="margin-bottom:20px;"></div>';
        }

        if(changIds && changIds.trim()){
            content += '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding-bottom:5px;">关联涉黄记录</h3>';
            content += '<div id="changRelDetail" style="margin-bottom:20px;"></div>';
        }

        if(peiIds && peiIds.trim()){
            content += '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding-bottom:5px;">关联陪侍记录</h3>';
            content += '<div id="peiRelDetail" style="margin-bottom:20px;"></div>';
        }

        content += '</div>';

        layui.layer.open({
            title: '案件关联详情',
            type: 1,
            content: content,
            area: ['900px', '70%'],
            offset: '50px',
            success: function(){
                if(duIds && duIds.trim()) loadDuDetails(duIds.split(','), '#duRelDetail');
                if(changIds && changIds.trim()) loadChangDetails(changIds.split(','), '#changRelDetail');
                if(peiIds && peiIds.trim()) loadPeiDetails(peiIds.split(','), '#peiRelDetail');
            }
        });
    }

    /**
     * 加载涉赌记录详情
     */
    function loadDuDetails(duIds, container) {
        var html = '<table class="layui-table" lay-size="sm">';
        html += '<thead><tr><th>ID</th><th>处罚日期</th><th>处罚情况</th><th>人员属性</th><th>赌博方式</th><th>赌博部位</th>' +
            '<th>涉案地址</th><th>采集来源</th></tr></thead><tbody>';

        var loadedCount = 0;
        duIds.forEach(function(id){
            if(!id || !id.trim()) return;
            $.ajax({
                url: locat + '/getZaDuById.do',
                data: {id: id.trim()},
                type: 'POST',
                dataType: 'json',
                async: false,
                success: function(data){
                    if(data){
                        html += '<tr>';
                        html += '<td>' + (data.id || '-') + '</td>';
                        html += '<td>' + (data.chsj || '-') + '</td>';
                        html += '<td>' + (data.cfjg || '-') + '</td>';
                        html += '<td>' + (data.personAttribute || '-') + '</td>';
                        html += '<td>' + (data.dbfs || '-') + '</td>';
                        html += '<td>' + (data.dbbw || '-') + '</td>';
                        html += '<td>' + (data.caseAddressList || '-') + '</td>';
                        html += '<td>' + (data.collectSource || '-') + '</td>';
                        html += '</tr>';
                        loadedCount++;
                    }
                }
            });
        });

        if(loadedCount === 0){
            html += '<tr><td colspan="5" style="text-align:center;color:#999;">暂无数据</td></tr>';
        }

        html += '</tbody></table>';
        $(container).html(html);
    }

    /**
     * 加载涉黄记录详情
     */
    function loadChangDetails(changIds, container) {
        var html = '<table class="layui-table" lay-size="sm">';
        html += '<thead><tr><th>ID</th><th>处罚时间</th><th>处罚情况</th><th>人员属性</th><th>涉黄方式</th><th>涉黄类型</th><th>涉案地址</th><th>采集来源</th></tr></thead><tbody>';

        var loadedCount = 0;
        changIds.forEach(function(id){
            if(!id || !id.trim()) return;
            $.ajax({
                url: locat + '/getZaChangById.do',
                data: {id: id.trim()},
                type: 'POST',
                dataType: 'json',
                async: false,
                success: function(data){
                    if(data){
                        html += '<tr>';
                        html += '<td>' + (data.id || '-') + '</td>';
                        html += '<td>' + (data.chang_chsj || '-') + '</td>';
                        html += '<td>' + (data.chang_cfjg || '-') + '</td>';
                        html += '<td>' + (data.chang_scjs || '-') + '</td>';
                        html += '<td>' + (data.chang_myfs || '-') + '</td>';
                        html += '<td>' + (data.changType || '-') + '</td>';
                        html += '<td>' + (data.caseAddressList || '-') + '</td>';
                        html += '<td>' + (data.collectSource || '-') + '</td>';
                        html += '</tr>';
                        loadedCount++;
                    }
                }
            });
        });

        if(loadedCount === 0){
            html += '<tr><td colspan="5" style="text-align:center;color:#999;">暂无数据</td></tr>';
        }

        html += '</tbody></table>';
        $(container).html(html);
    }

    /**
     * 加载陪侍记录详情
     */
    function loadPeiDetails(peiIds, container) {
        var html = '<table class="layui-table" lay-size="sm">';
        html += '<thead><tr><th>ID</th><th>采集时间</th><th>活动地点</th><th>采集来源</th></tr></thead><tbody>';

        var loadedCount = 0;
        peiIds.forEach(function(id){
            if(!id || !id.trim()) return;
            $.ajax({
                url: locat + '/getZaPeiById.do',
                data: {id: id.trim()},
                type: 'POST',
                dataType: 'json',
                async: false,
                success: function(data){
                    if(data){
                        html += '<tr>';
                        html += '<td>' + (data.id || '-') + '</td>';
                        html += '<td>' + (data.collectDate || '-') + '</td>';
                        html += '<td>' + (data.activityVenue || '-') + '</td>';
                        html += '<td>' + (data.collectSource || '-') + '</td>';
                        html += '</tr>';
                        loadedCount++;
                    }
                }
            });
        });

        if(loadedCount === 0){
            html += '<tr><td colspan="5" style="text-align:center;color:#999;">暂无数据</td></tr>';
        }

        html += '</tbody></table>';
        $(container).html(html);
    }


    // ========== 涉警涉案初始化 ==========
    $(document).ready(function() {

        // 页面加载完成后，初始化涉警信息表格
        setTimeout(function() {
            if (typeof openzajqxx === 'function') {
                openzajqxx('${personnel.cardnumber}');
            } else {
                console.warn('⚠️ openzajqxx function is not defined yet');
            }
        }, 100);
    });

    // ========== 涉赌关联案件选择函数 ==========
    // 存储已选择的涉赌关联记录
    window.selectedDuRelations = window.selectedDuRelations || [];
    // 存储已选择的涉黄关联记录
    window.selectedChangRelations = window.selectedChangRelations || [];
    // 存储已选择的陪侍关联记录
    window.selectedPeiRelations = window.selectedPeiRelations || [];

    /**
     * 加载涉赌记录的已有关联关系（警情和案件）
     * @param duId 涉赌记录ID
     */
    function loadExistingDuRel(duId) {
        if (!duId || duId <= 0) {
            console.log('无效的duId，跳过加载关联关系');
            return;
        }

        var locat = (window.location + '').split('/');
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }

        console.log('🔍 开始加载涉赌关联关系，duId:', duId);

        // ✅ 调用 queryDuRelations.do 获取详细信息
        $.ajax({
            url: locat + '/queryDuRelations.do',
            data: {duId: duId},
            type: 'POST',
            dataType: 'json',
            async: false,
            success: function(result) {
                if (result && result.code === 0) {
                    console.log('✓ 查询到涉赌关联详情:', result);

                    // 清空之前的选择
                    window.selectedDuRelations = [];

                    // 加载关联的警情详情
                    if (result.jqList && result.jqList.length > 0) {
                        result.jqList.forEach(function(jq) {
                            window.selectedDuRelations.push({
                                type: 'jq',
                                id: jq.id,
                                name: (jq.jjsj || '') + '-' + (jq.bjnr || '')
                            });
                        });
                        console.log('✓ 加载 ' + result.jqList.length + ' 条警情');
                    }

                    // 加载关联的案件详情
                    if (result.ajList && result.ajList.length > 0) {
                        result.ajList.forEach(function(aj) {
                            window.selectedDuRelations.push({
                                type: 'aj',
                                id: aj.id,
                                name: (aj.ajbh || '') + '-' + (aj.ajmc || '')
                            });
                        });
                        console.log('✓ 加载 ' + result.ajList.length + ' 条案件');
                    }

                    // 更新显示
                    updateDuRelationDisplay();

                    console.log('✅ 涉赌关联关系加载完成，共 ' + window.selectedDuRelations.length + ' 条');
                } else {
                    console.error('❌ 查询关联关系失败:', result);
                }
            },
            error: function(xhr, status, error) {
                console.error('❌ 加载涉赌关联关系失败:', error);
            }
        });
    }

    /**
     * 加载涉黄记录的已有关联关系（警情和案件）
     * @param changId 涉黄记录ID
     */
    function loadExistingChangRel(changId) {
        if (!changId || changId <= 0) {
            console.log('无效的changId，跳过加载关联关系');
            return;
        }

        var locat = (window.location + '').split('/');
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }

        console.log('🔍 开始加载涉黄关联关系，changId:', changId);

        // ✅ 调用 queryChangRelations.do 获取详细信息
        $.ajax({
            url: locat + '/queryChangRelations.do',
            data: {changId: changId},
            type: 'POST',
            dataType: 'json',
            async: false,
            success: function(result) {
                if (result && result.code === 0) {
                    console.log('✓ 查询到涉chang关联详情:', result);

                    // 清空之前的选择
                    window.selectedChangRelations = [];

                    // 加载关联的警情详情
                    if (result.jqList && result.jqList.length > 0) {
                        result.jqList.forEach(function(jq) {
                            window.selectedChangRelations.push({
                                type: 'jq',
                                id: jq.id,
                                name: (jq.jjsj || '') + '-' + (jq.bjnr || '')
                            });
                        });
                        console.log('✓ 加载 ' + result.jqList.length + ' 条警情');
                    }

                    // 加载关联的案件详情
                    if (result.ajList && result.ajList.length > 0) {
                        result.ajList.forEach(function(aj) {
                            window.selectedChangRelations.push({
                                type: 'aj',
                                id: aj.id,
                                name: (aj.ajbh || '') + '-' + (aj.ajmc || '')
                            });
                        });
                        console.log('✓ 加载 ' + result.ajList.length + ' 条案件');
                    }

                    // 更新显示
                    updateChangRelationDisplay();

                    console.log('✅ 涉chang关联关系加载完成，共 ' + window.selectedChangRelations.length + ' 条');
                } else {
                    console.error('❌ 查询关联关系失败:', result);
                }
            },
            error: function(xhr, status, error) {
                console.error('❌ 加载涉chang关联关系失败:', error);
            }
        });
    }

    /**
     * 加载涉pei记录的已有关联关系（警情和案件）
     * @param peiId 涉赌记录ID
     */
    function loadExistingPeiRel(peiId) {
        if (!peiId || peiId <= 0) {
            console.log('无效的peiId，跳过加载关联关系');
            return;
        }

        var locat = (window.location + '').split('/');
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }

        console.log('🔍 开始加载陪侍关联关系，peiId:', peiId);

        // ✅ 调用 queryPeiRelations.do 获取详细信息
        $.ajax({
            url: locat + '/queryPeiRelations.do',
            data: {peiId: peiId},
            type: 'POST',
            dataType: 'json',
            async: false,
            success: function(result) {
                if (result && result.code === 0) {
                    console.log('✓ 查询到陪侍关联详情:', result);

                    // 清空之前的选择
                    window.selectedPeiRelations = [];

                    // 加载关联的警情详情
                    if (result.jqList && result.jqList.length > 0) {
                        result.jqList.forEach(function(jq) {
                            window.selectedPeiRelations.push({
                                type: 'jq',
                                id: jq.id,
                                name: (jq.jjsj || '') + '-' + (jq.bjnr || '')
                            });
                        });
                        console.log('✓ 加载 ' + result.jqList.length + ' 条警情');
                    }

                    // 加载关联的案件详情
                    if (result.ajList && result.ajList.length > 0) {
                        result.ajList.forEach(function(aj) {
                            window.selectedPeiRelations.push({
                                type: 'aj',
                                id: aj.id,
                                name: (aj.ajbh || '') + '-' + (aj.ajmc || '')
                            });
                        });
                        console.log('✓ 加载 ' + result.ajList.length + ' 条案件');
                    }

                    // 更新显示
                    updatePeiRelationDisplay();

                    console.log('✅ 陪侍关联关系加载完成，共 ' + window.selectedPeiRelations.length + ' 条');
                } else {
                    console.error('❌ 查询关联关系失败:', result);
                }
            },
            error: function(xhr, status, error) {
                console.error('❌ 加载陪侍关联关系失败:', error);
            }
        });
    }

    /**
     * 选择涉赌关联警情/案件
     * @param sfzh 身份证号
     * @param duId 涉赌记录ID（用于回显已有关联）
     */
    function selectdujqaj(sfzh, duId) {
        var locat = (window.location + '').split('/');
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }

        layui.layer.open({
            type: 1,
            title: '选择关联警情/案件',
            area: ['1000px', '600px'],
            offset: '50px',
            shade: 0.3,
            content: '<div style="padding:20px;">' +
                '<div id="duRelSelectContainer">' +
                '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding:10px 0;margin-bottom:10px;">--涉警记录--</h3>' +
                '<table class="layui-hide" id="duJqSelectTable" lay-filter="duJqSelectTable"></table>' +
                '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding:10px 0;margin:20px 0 10px 0;">--涉案记录--</h3>' +
                '<table class="layui-hide" id="duAjSelectTable" lay-filter="duAjSelectTable"></table>' +
                '</div>' +
                '</div>',
            success: function(layero, index) {

                // 渲染涉警记录表格
                layui.table.render({
                    elem: '#duJqSelectTable',
                    url: locat + "/queryZaJqxxWithRel.do?sfzh=" + sfzh,
                    method: 'post',
                    height: 220,
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'jjrqsj', title: '接警时间', width: 160, align: "center", templet: function(d){ return formatRawDate(d.jjrqsj); }},
                        {field: 'bjnr', title: '报警内容', width: 200, align: "center"},
                        {field: 'bjlx', title: '报警类型', width: 120, align: "center"},
                        {field: 'sfdd', title: '事发地点', width: 180, align: "center"}
                    ]],
                    page: true,
                    limit: 10,
                    limits: [10, 20, 30, 50]
                });

                // 渲染涉案记录表格
                layui.table.render({
                    elem: '#duAjSelectTable',
                    url: locat + "/queryZaAjxxWithRel.do?sfzh=" + sfzh,
                    method: 'post',
                    height: 220,
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'jjbh', title: '案件编号', width: 150, align: "center"},
                        {field: 'slsj', title: '受理时间', width: 160, align: "center", templet: function(d){ return formatRawDate(d.slsj); }},
                        {field: 'ajlb', title: '案件类别', width: 120, align: "center"},
                        {field: 'ajmc', title: '案件名称', width: 180, align: "center"},
                        {field: 'sldwmc', title: '受理单位', width: 150, align: "center"},
                        {field: 'cfqk', title: '处罚情况', width: 150, align: "center"},
                        {field: 'cfrq', title: '处罚日期', width: 160, align: "center", templet: function(d){ return formatRawDate(d.cfrq); }}
                    ]],
                    page: true,
                    limit: 10,
                    limits: [10, 20, 30, 50]
                });
            },
            btn: ['确定选择', '取消'],
            yes: function(index, layero) {
                // 获取选中的警情记录
                var jqCheckStatus = layui.table.checkStatus('duJqSelectTable');
                var jqData = jqCheckStatus.data;

                // 获取选中的案件记录
                var ajCheckStatus = layui.table.checkStatus('duAjSelectTable');
                var ajData = ajCheckStatus.data;

                // 初始化数组（如果不存在）
                if (!window.selectedDuRelations) {
                    window.selectedDuRelations = [];
                }

                var addedCount = 0;

                // 添加选中的警情（检查是否已存在）
                jqData.forEach(function(row) {
                    var exists = window.selectedDuRelations.some(function(rel) {
                        return rel.type === 'jq' && rel.id === row.id;
                    });
                    if (!exists) {
                        window.selectedDuRelations.push({
                            type: 'jq',
                            id: row.id,
                            name: (row.jjrqsj || '') + ' - ' + (row.bjnr || ''),
                            data: row
                        });
                        addedCount++;
                    }
                });

                // 添加选中的案件（检查是否已存在）
                ajData.forEach(function(row) {
                    var exists = window.selectedDuRelations.some(function(rel) {
                        return rel.type === 'aj' && rel.id === row.id;
                    });
                    if (!exists) {
                        window.selectedDuRelations.push({
                            type: 'aj',
                            id: row.id,
                            name: (row.jjbh || '') + ' - ' + (row.ajmc || ''),
                            data: row
                        });
                        addedCount++;
                    }
                });

                // 涉赌tab：自动填写字段
                if(jqData.length > 0) {
                    // 选择了警情，填写"警情"
                    $('#collectSource-du').val('警情');
                    layui.form.render('select');
                } else if(ajData.length > 0) {
                    // 选择了案件，填写"案件"、处罚情况、处罚日期
                    $('#collectSource-du').val('案件');

                    // 取第一条案件数据
                    var firstAj = ajData[0];

                    // ✅ 修复：直接将cfqk填写到处罚情况输入框（不管是否与数据字典匹配）
                    if(firstAj.cfqk) {
                        var $cfjgSelect = $('#cfjg');
                        var cfqkValue = firstAj.cfqk;

                        // 检查选项是否存在
                        var optionExists = $cfjgSelect.find('option[value="' + cfqkValue + '"]').length > 0;

                        // 如果选项不存在，添加新选项
                        if (!optionExists) {
                            $cfjgSelect.append('<option value="' + cfqkValue + '">' + cfqkValue + '</option>');
                        }

                        // 设置值
                        $cfjgSelect.val(cfqkValue);
                        console.log('涉赌-自动填写处罚情况: ' + cfqkValue);
                    }

                    // ✅ 修复：直接将cfrq填写到处罚日期输入框
                    if(firstAj.cfrq) {
                        $('#chsj').val(firstAj.cfrq);
                        console.log('涉赌-自动填写处罚日期: ' + firstAj.cfrq);
                    }

                    layui.form.render('select');
                }

                // 更新显示
                updateDuRelationDisplay();

                layui.layer.close(index);

                if(addedCount > 0) {
                    layui.layer.msg('已添加 ' + addedCount + ' 条记录，共 ' + window.selectedDuRelations.length + ' 条', {icon: 1});
                } else if(jqData.length > 0 || ajData.length > 0) {
                    layui.layer.msg('所选记录已存在', {icon: 0});
                }
            }
        });
    }

    /**
     * 将原始紧凑日期字符串（如 20160320134727）转换为标准格式（2016-03-20 13:47:27）
     */
    function formatRawDate(val) {
        if (!val) return '';
        var s = String(val).replace(/\D/g, '');
        if (s.length >= 8) {
            var y = s.substring(0, 4);
            var mo = s.substring(4, 6);
            var d = s.substring(6, 8);
            var result = y + '-' + mo + '-' + d;
            if (s.length >= 12) {
                var h = s.substring(8, 10);
                var mi = s.substring(10, 12);
                result += ' ' + h + ':' + mi;
                if (s.length >= 14) {
                    result += ':' + s.substring(12, 14);
                }
            }
            return result;
        }
        return val;
    }

    /**
     * 更新涉赌关联记录显示
     */
    function updateDuRelationDisplay() {
        // 找到输入框所在的整个 form-item 容器
        var formItem = $('#du_caseName').closest('.layui-form-item');
        formItem.find('.du-relation-list').remove();

        if (window.selectedDuRelations && window.selectedDuRelations.length > 0) {
            // 更新输入框显示
            $('#du_caseName').val('已选择 ' + window.selectedDuRelations.length + ' 条关联记录');

            // 构建已添加列表HTML（放在输入框下方）
            var html = '<div class="du-relation-list" style="margin-top:10px;border:1px solid #e6e6e6;padding:10px;border-radius:4px;background:#f8f8f8;width:100%;">';
            html += '<div style="margin-bottom:8px;font-weight:bold;color:#333;">已添加列表：</div>';

            window.selectedDuRelations.forEach(function(rel, index) {
                var typeText = rel.type === 'jq'
                    ? '<span style="display:inline-block;padding:2px 8px;background:#1E9FFF;color:#fff;border-radius:3px;font-size:12px;">警情</span>'
                    : '<span style="display:inline-block;padding:2px 8px;background:#FF5722;color:#fff;border-radius:3px;font-size:12px;">案件</span>';

                html += '<div class="relation-item" style="padding:8px;margin:5px 0;background:#fff;border:1px solid #e6e6e6;border-radius:3px;display:flex;justify-content:space-between;align-items:center;">';
                html += '<span style="flex:1;padding-right:10px;">' + typeText + ' <span style="margin-left:8px;color:#666;">' + rel.name + '</span></span>';
                html += '<button class="layui-btn layui-btn-xs layui-btn-danger" onclick="removeDuRelation(' + index + ')"><i class="layui-icon layui-icon-delete"></i> 删除</button>';
                html += '</div>';
            });

            html += '</div>';
            formItem.append(html);
        } else {
            $('#du_caseName').val('');
        }
    }

    /**
     * 删除涉赌关联记录
     */
    function removeDuRelation(index) {
        if (window.selectedDuRelations && index >= 0 && index < window.selectedDuRelations.length) {
            window.selectedDuRelations.splice(index, 1);
            updateDuRelationDisplay();
            layui.layer.msg('已删除', {icon: 1, time: 1000});
        }
    }

    // ============================================================
    // 涉黄关联案件功能
    // ============================================================

    /**
     * 涉黄-选择关联警情/案件
     */
    function selectchangjqaj(sfzh, changId) {
        var locat = (window.location + '').split('/');
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }

        layui.layer.open({
            type: 1,
            title: '选择关联警情/案件',
            area: ['1000px', '600px'],
            offset: '50px',
            shade: 0.3,
            content: '<div style="padding:20px;">' +
                '<div id="changRelSelectContainer">' +
                '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding:10px 0;margin-bottom:10px;">--涉警记录--</h3>' +
                '<table class="layui-hide" id="changJqSelectTable" lay-filter="changJqSelectTable"></table>' +
                '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding:10px 0;margin:20px 0 10px 0;">--涉案记录--</h3>' +
                '<table class="layui-hide" id="changAjSelectTable" lay-filter="changAjSelectTable"></table>' +
                '</div>' +
                '</div>',
            success: function(layero, index) {

                // 渲染涉警记录表格
                layui.table.render({
                    elem: '#changJqSelectTable',
                    url: locat + "/queryZaJqxxWithRel.do?sfzh=" + sfzh,
                    method: 'post',
                    height: 220,
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'jjrqsj', title: '接警时间', width: 160, align: "center", templet: function(d){ return formatRawDate(d.jjrqsj); }},
                        {field: 'bjnr', title: '报警内容', width: 200, align: "center"},
                        {field: 'bjlx', title: '报警类型', width: 120, align: "center"},
                        {field: 'sfdd', title: '事发地点', width: 180, align: "center"}
                    ]],
                    page: true,
                    limit: 10,
                    limits: [10, 20, 30, 50]
                });

                // 渲染涉案记录表格
                layui.table.render({
                    elem: '#changAjSelectTable',
                    url: locat + "/queryZaAjxxWithRel.do?sfzh=" + sfzh,
                    method: 'post',
                    height: 220,
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'jjbh', title: '案件编号', width: 150, align: "center"},
                        {field: 'slsj', title: '受理时间', width: 160, align: "center", templet: function(d){ return formatRawDate(d.slsj); }},
                        {field: 'ajlb', title: '案件类别', width: 120, align: "center"},
                        {field: 'ajmc', title: '案件名称', width: 180, align: "center"},
                        {field: 'sldwmc', title: '受理单位', width: 150, align: "center"},
                        {field: 'cfqk', title: '处罚情况', width: 150, align: "center"},
                        {field: 'cfrq', title: '处罚日期', width: 160, align: "center", templet: function(d){ return formatRawDate(d.cfrq); }}
                    ]],
                    page: true,
                    limit: 10,
                    limits: [10, 20, 30, 50]
                });
            },
            btn: ['确定选择', '取消'],
            yes: function(index, layero) {
                // 获取选中的警情记录
                var jqCheckStatus = layui.table.checkStatus('changJqSelectTable');
                var jqData = jqCheckStatus.data;

                // 获取选中的案件记录
                var ajCheckStatus = layui.table.checkStatus('changAjSelectTable');
                var ajData = ajCheckStatus.data;

                // 初始化数组（如果不存在）
                if (!window.selectedChangRelations) {
                    window.selectedChangRelations = [];
                }

                var addedCount = 0;

                // 添加选中的警情（检查是否已存在）
                jqData.forEach(function(row) {
                    var exists = window.selectedChangRelations.some(function(rel) {
                        return rel.type === 'jq' && rel.id === row.id;
                    });
                    if (!exists) {
                        window.selectedChangRelations.push({
                            type: 'jq',
                            id: row.id,
                            name: (row.jjrqsj || '') + ' - ' + (row.bjnr || ''),
                            data: row
                        });
                        addedCount++;
                    }
                });

                // 添加选中的案件（检查是否已存在）
                ajData.forEach(function(row) {
                    var exists = window.selectedChangRelations.some(function(rel) {
                        return rel.type === 'aj' && rel.id === row.id;
                    });
                    if (!exists) {
                        window.selectedChangRelations.push({
                            type: 'aj',
                            id: row.id,
                            name: (row.jjbh || '') + ' - ' + (row.ajmc || ''),
                            data: row
                        });
                        addedCount++;
                    }
                });

                // 涉黄tab：自动填写字段
                if(jqData.length > 0) {
                    // 选择了警情，填写"警情"
                    $('#collectSource-chang').val('警情');
                    layui.form.render('select');
                } else if(ajData.length > 0) {
                    // 选择了案件，填写"案件"、处罚情况、处罚时间
                    $('#collectSource-chang').val('案件');

                    // 取第一条案件数据
                    var firstAj = ajData[0];

                    // ✅ 修复：直接将cfqk填写到处罚情况输入框（不管是否与数据字典匹配）
                    if(firstAj.cfqk) {
                        var $changCfjgSelect = $('#chang_cfjg');
                        var cfqkValue = firstAj.cfqk;

                        // 检查选项是否存在
                        var optionExists = $changCfjgSelect.find('option[value="' + cfqkValue + '"]').length > 0;

                        // 如果选项不存在，添加新选项
                        if (!optionExists) {
                            $changCfjgSelect.append('<option value="' + cfqkValue + '">' + cfqkValue + '</option>');
                        }

                        // 设置值
                        $changCfjgSelect.val(cfqkValue);
                        console.log('涉黄-自动填写处罚情况: ' + cfqkValue);
                    }

                    // ✅ 修复：直接将cfrq填写到处罚时间输入框
                    if(firstAj.cfrq) {
                        $('#chang_chsj').val(firstAj.cfrq);
                        console.log('涉黄-自动填写处罚时间: ' + firstAj.cfrq);
                    }

                    layui.form.render('select');
                }

                // 更新显示
                updateChangRelationDisplay();

                layui.layer.close(index);

                if(addedCount > 0) {
                    layui.layer.msg('已添加 ' + addedCount + ' 条记录，共 ' + window.selectedChangRelations.length + ' 条', {icon: 1});
                } else if(jqData.length > 0 || ajData.length > 0) {
                    layui.layer.msg('所选记录已存在', {icon: 0});
                }
            }
        });
    }

    /**
     * 更新涉黄关联记录显示
     */
    function updateChangRelationDisplay() {
        // 找到输入框所在的整个 form-item 容器
        var formItem = $('#chang_caseName').closest('.layui-form-item');
        formItem.find('.chang-relation-list').remove();

        if (window.selectedChangRelations && window.selectedChangRelations.length > 0) {
            // 更新输入框显示
            $('#chang_caseName').val('已选择 ' + window.selectedChangRelations.length + ' 条关联记录');

            // 构建已添加列表HTML（放在输入框下方）
            var html = '<div class="chang-relation-list" style="margin-top:10px;border:1px solid #e6e6e6;padding:10px;border-radius:4px;background:#f8f8f8;width:100%;">';
            html += '<div style="margin-bottom:8px;font-weight:bold;color:#333;">已添加列表：</div>';

            window.selectedChangRelations.forEach(function(rel, index) {
                var typeText = rel.type === 'jq'
                    ? '<span style="display:inline-block;padding:2px 8px;background:#1E9FFF;color:#fff;border-radius:3px;font-size:12px;">警情</span>'
                    : '<span style="display:inline-block;padding:2px 8px;background:#FF5722;color:#fff;border-radius:3px;font-size:12px;">案件</span>';

                html += '<div class="relation-item" style="padding:8px;margin:5px 0;background:#fff;border:1px solid #e6e6e6;border-radius:3px;display:flex;justify-content:space-between;align-items:center;">';
                html += '<span style="flex:1;padding-right:10px;">' + typeText + ' <span style="margin-left:8px;color:#666;">' + rel.name + '</span></span>';
                html += '<button class="layui-btn layui-btn-xs layui-btn-danger" onclick="removeChangRelation(' + index + ')"><i class="layui-icon layui-icon-delete"></i> 删除</button>';
                html += '</div>';
            });

            html += '</div>';
            formItem.append(html);
        } else {
            $('#chang_caseName').val('');
        }
    }

    /**
     * 删除涉黄关联记录
     */
    function removeChangRelation(index) {
        if (window.selectedChangRelations && index >= 0 && index < window.selectedChangRelations.length) {
            window.selectedChangRelations.splice(index, 1);
            updateChangRelationDisplay();
            layui.layer.msg('已删除', {icon: 1, time: 1000});
        }
    }

    // ============================================================
    // 陪侍关联案件功能
    // ============================================================

    /**
     * 陪侍-选择关联警情/案件
     */
    function selectpeijqaj(sfzh, peiId) {
        var locat = (window.location + '').split('/');
        if ('main' == locat[3]) {
            locat = locat[0] + '//' + locat[2];
        } else {
            locat = locat[0] + '//' + locat[2] + '/' + locat[3];
        }

        layui.layer.open({
            type: 1,
            title: '选择关联警情/案件',
            area: ['1000px', '600px'],
            offset: '50px',
            shade: 0.3,
            content: '<div style="padding:20px;">' +
                '<div id="peiRelSelectContainer">' +
                '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding:10px 0;margin-bottom:10px;">--涉警记录--</h3>' +
                '<table class="layui-hide" id="peiJqSelectTable" lay-filter="peiJqSelectTable"></table>' +
                '<h3 style="color:#1E9FFF;border-bottom:2px solid #1E9FFF;padding:10px 0;margin:20px 0 10px 0;">--涉案记录--</h3>' +
                '<table class="layui-hide" id="peiAjSelectTable" lay-filter="peiAjSelectTable"></table>' +
                '</div>' +
                '</div>',
            success: function(layero, index) {

                // 渲染涉警记录表格
                layui.table.render({
                    elem: '#peiJqSelectTable',
                    url: locat + "/queryZaJqxxWithRel.do?sfzh=" + sfzh,
                    method: 'post',
                    height: 220,
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'jjrqsj', title: '接警时间', width: 150, align: "center"},
                        {field: 'bjnr', title: '报警内容', width: 200, align: "center"},
                        {field: 'bjlx', title: '报警类型', width: 120, align: "center"},
                        {field: 'sfdd', title: '事发地点', width: 180, align: "center"}
                    ]],
                    page: true,
                    limit: 10,
                    limits: [10, 20, 30, 50]
                });

                // 渲染涉案记录表格
                layui.table.render({
                    elem: '#peiAjSelectTable',
                    url: locat + "/queryZaAjxxWithRel.do?sfzh=" + sfzh,
                    method: 'post',
                    height: 220,
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'jjbh', title: '案件编号', width: 150, align: "center"},
                        {field: 'slsj', title: '受理时间', width: 150, align: "center"},
                        {field: 'ajlb', title: '案件类别', width: 120, align: "center"},
                        {field: 'ajmc', title: '案件名称', width: 180, align: "center"},
                        {field: 'sldwmc', title: '受理单位', width: 150, align: "center"},
                        {field: 'cfqk', title: '处罚情况', width: 150, align: "center"},
                        {field: 'cfrq', title: '处罚日期', width: 150, align: "center"}
                    ]],
                    page: true,
                    limit: 10,
                    limits: [10, 20, 30, 50]
                });
            },
            btn: ['确定选择', '取消'],
            yes: function(index, layero) {
                // 获取选中的警情记录
                var jqCheckStatus = layui.table.checkStatus('peiJqSelectTable');
                var jqData = jqCheckStatus.data;

                // 获取选中的案件记录
                var ajCheckStatus = layui.table.checkStatus('peiAjSelectTable');
                var ajData = ajCheckStatus.data;

                // 初始化数组（如果不存在）
                if (!window.selectedPeiRelations) {
                    window.selectedPeiRelations = [];
                }

                var addedCount = 0;

                // 添加选中的警情（检查是否已存在）
                jqData.forEach(function(row) {
                    var exists = window.selectedPeiRelations.some(function(rel) {
                        return rel.type === 'jq' && rel.id === row.id;
                    });
                    if (!exists) {
                        window.selectedPeiRelations.push({
                            type: 'jq',
                            id: row.id,
                            name: (row.jjrqsj || '') + ' - ' + (row.bjnr || ''),
                            data: row
                        });
                        addedCount++;
                    }
                });

                // 添加选中的案件（检查是否已存在）
                ajData.forEach(function(row) {
                    var exists = window.selectedPeiRelations.some(function(rel) {
                        return rel.type === 'aj' && rel.id === row.id;
                    });
                    if (!exists) {
                        window.selectedPeiRelations.push({
                            type: 'aj',
                            id: row.id,
                            name: (row.jjbh || '') + ' - ' + (row.ajmc || ''),
                            data: row
                        });
                        addedCount++;
                    }
                });

                // 陪侍tab：自动填写字段
                if(jqData.length > 0) {
                    // 选择了警情，填写"涉警"
                    $('#collectSource-pei').val('涉警');
                    layui.form.render('select');
                } else if(ajData.length > 0) {
                    // 选择了案件，填写"涉案"
                    $('#collectSource-pei').val('涉案');
                    layui.form.render('select');
                }

                // 更新显示
                updatePeiRelationDisplay();

                layui.layer.close(index);

                if(addedCount > 0) {
                    layui.layer.msg('已添加 ' + addedCount + ' 条记录，共 ' + window.selectedPeiRelations.length + ' 条', {icon: 1});
                } else if(jqData.length > 0 || ajData.length > 0) {
                    layui.layer.msg('所选记录已存在', {icon: 0});
                }
            }
        });
    }

    /**
     * 更新陪侍关联记录显示
     */
    function updatePeiRelationDisplay() {
        // 找到输入框所在的整个 form-item 容器
        var formItem = $('#pei_caseName').closest('.layui-form-item');
        formItem.find('.pei-relation-list').remove();

        if (window.selectedPeiRelations && window.selectedPeiRelations.length > 0) {
            // 更新输入框显示
            $('#pei_caseName').val('已选择 ' + window.selectedPeiRelations.length + ' 条关联记录');

            // 构建已添加列表HTML（放在输入框下方）
            var html = '<div class="pei-relation-list" style="margin-top:10px;border:1px solid #e6e6e6;padding:10px;border-radius:4px;background:#f8f8f8;width:100%;">';
            html += '<div style="margin-bottom:8px;font-weight:bold;color:#333;">已添加列表：</div>';

            window.selectedPeiRelations.forEach(function(rel, index) {
                var typeText = rel.type === 'jq'
                    ? '<span style="display:inline-block;padding:2px 8px;background:#1E9FFF;color:#fff;border-radius:3px;font-size:12px;">警情</span>'
                    : '<span style="display:inline-block;padding:2px 8px;background:#FF5722;color:#fff;border-radius:3px;font-size:12px;">案件</span>';

                html += '<div class="relation-item" style="padding:8px;margin:5px 0;background:#fff;border:1px solid #e6e6e6;border-radius:3px;display:flex;justify-content:space-between;align-items:center;">';
                html += '<span style="flex:1;padding-right:10px;">' + typeText + ' <span style="margin-left:8px;color:#666;">' + rel.name + '</span></span>';
                html += '<button class="layui-btn layui-btn-xs layui-btn-danger" onclick="removePeiRelation(' + index + ')"><i class="layui-icon layui-icon-delete"></i> 删除</button>';
                html += '</div>';
            });

            html += '</div>';
            formItem.append(html);
        } else {
            $('#pei_caseName').val('');
        }
    }

    /**
     * 删除陪侍关联记录
     */
    function removePeiRelation(index) {
        if (window.selectedPeiRelations && index >= 0 && index < window.selectedPeiRelations.length) {
            window.selectedPeiRelations.splice(index, 1);
            updatePeiRelationDisplay();
            layui.layer.msg('已删除', {icon: 1, time: 1000});
        }
    }

</script>
</body>
</html>
