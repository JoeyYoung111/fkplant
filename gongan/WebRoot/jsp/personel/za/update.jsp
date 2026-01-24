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
            <div class="layui-row" style="border-bottom: 1px solid #eee;padding: 15px;">
                <div class="layui-inline layui-col-md12">
                    <label class="layui-form-label layui-font-blue">基本信息：</label>
                </div>
                <div class=" my-onload-img layui-col-md2" style="height: 260px;">
                    <img id="defaultPhoto">
                    <a class="my-font-blue" style="text-decoration: underline;cursor:pointer;" onclick="openPhotos()">编
                        辑</a>
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
                <%--                <div class="layui-col-md6">--%>
                <%--                    <div class="layui-form-item my-form-item">--%>
                <%--                        <label class="layui-form-label">联系电话：</label>--%>
                <%--                        <div class="layui-input-block">--%>
                <%--                            <input type="text" name="phone" id="personPhone" value="${personnel.phone}"--%>
                <%--                                   placeholder="请输入联系电话" class="layui-input"--%>
                <%--                                   style="width:60%;display:inline-block;">--%>
                <%--                            <button type="button" class="layui-btn layui-btn-sm layui-btn-warm"--%>
                <%--                                    onclick="showPhoneHistory(${personnel.id})"><i class="layui-icon">&#xe68d;</i>历史号码--%>
                <%--                            </button>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <!-- 涉赌前科和涉娼前科显示（自动根据历史记录填充） -->
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">涉赌前科：</label>
                        <div class="layui-input-block">
                            <c:choose>
                                <c:when test="${duEditable == false}">
                                    <select name="hasSheduRecord" disabled="disabled" style="background:#efefef;">
                                        <option value="1" selected>有</option>
                                    </select>
                                    <input type="hidden" name="hasSheduRecord" value="1"/>
                                    <span class="layui-form-mid" style="color:#FF5722;font-size:12px;">该人员存在涉赌记录，涉赌前科由系统自动判定，不可修改</span>
                                </c:when>
                                <c:otherwise>
                                    <select name="hasSheduRecord">
                                        <option value="0" <c:if test="${personnel.hasSheduRecord == 0}">selected</c:if>>
                                            无
                                        </option>
                                        <option value="1" <c:if test="${personnel.hasSheduRecord == 1}">selected</c:if>>
                                            有
                                        </option>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">涉娼前科：</label>
                        <div class="layui-input-block">
                            <c:choose>
                                <c:when test="${changEditable == false}">
                                    <select name="hasSechangRecord" disabled="disabled" style="background:#efefef;">
                                        <option value="1" selected>有</option>
                                    </select>
                                    <input type="hidden" name="hasSechangRecord" value="1"/>
                                    <span class="layui-form-mid" style="color:#FF5722;font-size:12px;">该人员存在涉娼记录，涉娼前科由系统自动判定，不可修改</span>
                                </c:when>
                                <c:otherwise>
                                    <select name="hasSechangRecord">
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
                            <input type="hidden" name="handleUnit" id="handleUnit" value="${personnel.handleUnit}">
                            <input type="hidden" name="handleUnitCode" id="handleUnitCode"
                                   value="${personnel.handleUnitCode}">
                            <span class="layui-form-mid" style="color:#999;font-size:12px;">最多添加3个打处单位</span>
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
                            <input type="text" name="houseProvince" id="houseProvince"
                                   value="${personnel.houseProvince}" placeholder="省" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">地级市：</label>
                        <div class="layui-input-block">
                            <input type="text" name="houseCity" id="houseCity" value="${personnel.houseCity}"
                                   placeholder="地级市" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">县级市：</label>
                        <div class="layui-input-block">
                            <input type="text" name="houseCounty" id="houseCounty" value="${personnel.houseCounty}"
                                   placeholder="县级市/区" class="layui-input">
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
                            <input type="text" name="homeProvince" id="homeProvince" value="${personnel.homeProvince}"
                                   placeholder="省" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">地级市：</label>
                        <div class="layui-input-block">
                            <input type="text" name="homeCity" id="homeCity" value="${personnel.homeCity}"
                                   placeholder="地级市"
                                   class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3">
                    <div class="layui-form-item my-form-item">
                        <label class="layui-form-label">县级市：</label>
                        <div class="layui-input-block">
                            <input type="text" name="homeCounty" id="homeCounty" value="${personnel.homeCounty}"
                                   placeholder="县级市/区" class="layui-input">
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
            <%--            <!-- 分级分类信息 -->--%>
            <%--            <div class="layui-row" style="padding: 15px;">--%>
            <%--                <div class="layui-inline layui-col-md12">--%>
            <%--                    <label class="layui-form-label layui-font-blue my-text-nowarp">分级分类信息</label>--%>
            <%--                </div>--%>
            <%--                <div class="layui-col-md8">--%>
            <%--                    <div class="layui-col-md7">--%>
            <%--                        <div class="layui-form-item my-form-item">--%>
            <%--                            <label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任单位：</label>--%>
            <%--                            <div class="layui-input-block">--%>
            <%--                                <input type="text" id="jdunit1" name="jdunit1" value="0" lay-filter="jdunit1" lay-verify="jdunit1" class="layui-input">--%>
            <%--                            </div>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                    <div class="layui-col-md5">--%>
            <%--                        <div class="layui-form-item my-form-item">--%>
            <%--                            <label class="layui-form-label my-text-nowarp"><font color="red" size=2>*</font>管辖责任民警：</label>--%>
            <%--                            <div class="layui-input-block">--%>
            <%--                                <select id="jdpolice1" name="jdpolice1" lay-filter="jdpolice1">--%>
            <%--                                </select>--%>
            <%--                            </div>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="layui-col-md4">--%>
            <%--                    <div class="layui-form-item my-form-item">--%>
            <%--                        <label class="layui-form-label">民警手机：</label>--%>
            <%--                        <div class="layui-input-block">--%>
            <%--                            <input type="text" autocomplete="off" name="pphone1" id="pphone1" lay-verify=""--%>
            <%--                                   value="${personnel.pphone1}" placeholder="请输入民警手机" class="layui-input">--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="layui-col-md8">--%>
            <%--                    <div class="layui-col-md7">--%>
            <%--                        <div class="layui-form-item my-form-item">--%>
            <%--                            <label class="layui-form-label my-text-nowarp">双列管单位：</label>--%>
            <%--                            <div class="layui-input-block">--%>
            <%--                                <input type="text" id="jdunit2" name="jdunit2" value="0" lay-filter="jdunit2" lay-verify="jdunit2" class="layui-input">--%>
            <%--                            </div>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                    <div class="layui-col-md5">--%>
            <%--                        <div class="layui-form-item my-form-item">--%>
            <%--                            <label class="layui-form-label my-text-nowarp">双列管民警：</label>--%>
            <%--                            <div class="layui-input-block">--%>
            <%--                                <select id="jdpolice2" name="jdpolice2"  lay-filter="jdpolice2">--%>
            <%--                                </select>--%>
            <%--                            </div>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="layui-col-md4">--%>
            <%--                    <div class="layui-form-item my-form-item">--%>
            <%--                        <label class="layui-form-label">民警手机：</label>--%>
            <%--                        <div class="layui-input-block">--%>
            <%--                            <input type="text" autocomplete="off" name="pphone2" id="pphone2" lay-verify=""--%>
            <%--                                   value="${personnel.pphone2}" placeholder="请输入民警手机" class="layui-input">--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <div class="layui-col-md4 layui-col-md-offset6" style="margin-bottom: 30px;margin-top: 30px;">
                <div class="layui-form-item my-form-item">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="updateZa">立即提交</button>
                </div>
            </div>
            <%--            </div>--%>
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
                        <li class="btn btn_6 swiper-slide" onclick="openZaChang(${personnel.id})">涉娼背景</li>
                        <li class="btn btn_11 swiper-slide" onclick="openAttributelabel()">人员属性标签</li>
                        <li class="btn btn_1 swiper-slide">关联信息</li>
                        <li class="btn btn_4 swiper-slide" onclick="openTrajectoryKK('${personnel.cardnumber}','');">
                            轨迹信息
                        </li>
                        <li class="btn btn_3 swiper-slide" onclick="openSocialRelations(${personnel.id});">社会关系</li>
                        <li class="btn btn_12 swiper-slide" onclick="openjqxx('${personnel.cardnumber}')">涉警涉案</li>
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
                                <label class="my-form-label-br">关联案件</label>
                                <div class="my-input-block">
                                    <input type="hidden" name="relatedCaseId"
                                           id="du_relatedCaseId" value="">
                                    <input type="text" id="du_caseName"
                                           autocomplete="off" placeholder="点击选择关联案件"
                                           class="layui-input" readonly
                                           onclick="selectRelatedCase('du')"
                                           style="cursor:pointer;background:#efefef;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">历史涉赌情况综述
                                    <button class="layui-btn layui-btn-sm" id="duHistory" style="display:none;"><i
                                            class="layui-icon">&#xe68d;</i>历史记录
                                    </button>
                                </label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="lssdqk" name="lssdqk" lay-verify="lssdqk"></textarea>
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
                                <label class="my-form-label-br">处罚时间
                                </label>
                                <div class="my-input-block">
                                    <input type="text" name="chsj" id="chsj" lay-verify="chsj"
                                           lay-reqtext="请选择处罚时间" autocomplete="off" placeholder="年-月-日"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">省：</label>
                                <div class="layui-input-block"><input type="text"
                                                                      id="du_homeProvince"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">地级市：</label>
                                <div class="layui-input-block"><input type="text" id="du_homeCity"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">县级市：</label>
                                <div class="layui-input-block"><input type="text" id="du_homeCounty"
                                                                      class="layui-input"
                                                                      oninput="checkDuPoliceStation()"
                                                                      onblur="checkDuPoliceStation()">
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
                                <label class="my-form-label-br">采集日期</label>
                                <div class="my-input-block">
                                    <input type="text" name="collectDate" id="du_collectDate" autocomplete="off"
                                           placeholder="年-月-日" class="layui-input">
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


                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">查获经过</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chjg" name="chjg" lay-verify="chjg"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处罚结果</label>
                                <div class="my-input-block" id="cfjg-div">
                                    <select name="cfjg" id="cfjg" lay-verify="cfjg" lay-reqdiv="cfjg-div">
                                        <option value="">==请选择==</option>
                                        <option value="刑事处罚">刑事处罚</option>
                                        <option value="治安处罚">治安处罚</option>
                                        <option value="未处罚">未处罚</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处理详情</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="clxq" name="clxq" lay-verify="clxq"></textarea>
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
                                <label class="my-form-label-br">历史涉嫖情况综述
                                    <button class="layui-btn layui-btn-sm" id="changHistory" style="display:none;"><i
                                            class="layui-icon">&#xe68d;</i>历史记录
                                    </button>
                                </label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_lsscqk" name="chang_lsscqk"
                                                      lay-verify="chang_lsscqk"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集来源</label>
                                <div class="my-input-block"
                                     id="collectSource-chang-div">
                                    <select id="collectSource-chang" name="collectSource"
                                            lay-filter="collectSource-chang" lay-verify=""
                                            lay-reqdiv="collectSource-chang-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉娼角色</label>
                                <div class="my-input-block"
                                     id="chang_scjs-div">
                                    <select id="chang_scjs" name="chang_scjs"
                                            lay-filter="chang_scjs"
                                            lay-verify="chang_scjs"
                                            lay-reqdiv="chang_scjs-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉娼方式</label>
                                <div class="my-input-block" id="chang_myfs-div">
                                    <select id="chang_myfs" name="chang_myfs"
                                            lay-filter="chang_myfs"
                                            lay-verify="chang_myfs"
                                            lay-reqdiv="chang_myfs-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">涉娼部位</label>
                                <div class="my-input-block" id="chang_scbw-div">
                                    <select id="chang_scbw" name="chang_scbw" lay-filter="chang_scbw"
                                            lay-verify="chang_scbw"
                                            lay-reqdiv="chang_scbw-div">
                                        <option value="">==请选择==</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">手机号码</label>
                                <div class="my-input-block">
                                    <input type="text" name="phone" id="chang_phone"
                                           autocomplete="off" placeholder="请输入手机号码"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">是否未成年案件</label>
                                <div class="my-input-block">
                                    <input type="radio" name="isMinorCase" value="0"
                                           title="否" checked>
                                    <input type="radio" name="isMinorCase" value="1"
                                           title="是">
                                    <span
                                            style="color:#999;font-size:12px;">(系统将自动根据处罚日期计算)</span>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
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

                        <div class="layui-col-md12">
                            <label class="layui-form-label" style="color:#1E9FFF;font-weight:bold;">现住地址：</label>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">省：</label>
                                <div class="layui-input-block"><input type="text"
                                                                      name="homeProvince" id="chang_homeProvince"
                                                                      value="${personnel.homeProvince}"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">地级市：</label>
                                <div class="layui-input-block"><input type="text"
                                                                      name="homeCity" id="chang_homeCity"
                                                                      value="${personnel.homeCity}"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">县级市：</label>
                                <div class="layui-input-block"><input type="text"
                                                                      name="homeCounty" id="chang_homeCounty"
                                                                      value="${personnel.homeCounty}"
                                                                      class="layui-input"
                                                                      oninput="checkChangPoliceStation()"
                                                                      onblur="checkChangPoliceStation()">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3">
                            <div class="layui-form-item my-form-item"><label
                                    class="layui-form-label">镇街：</label>
                                <div class="layui-input-block"><input type="text"
                                                                      name="homeTown" id="chang_homeTown"
                                                                      value="${personnel.homeTown}"
                                                                      class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">详细地址：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="homeplace" lay-verify="" autocomplete="off"
                                           value="${personnel.homeplace}" placeholder="请输入现住地详址"
                                           class="layui-input"
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
                                            name="homepolice"
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
                                    <input type="text" name="homex" lay-verify="" autocomplete="off"
                                           value="${personnel.homex}" class="layui-input" id="chang_homex"
                                           onclick="openPGisChang('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="layui-form-label my-text-nowarp">现住地纬度：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="homey" lay-verify="" autocomplete="off"
                                           value="${personnel.homey}" class="layui-input" id="chang_homey"
                                           onclick="openPGisChang('home','现住地');" readonly
                                           style="background:#efefef;cursor:pointer;">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">采集日期</label>
                                <div class="my-input-block">
                                    <input type="text" name="collectDate"
                                           id="chang_collectDate" autocomplete="off"
                                           placeholder="年-月-日" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">关联案件</label>
                                <div class="my-input-block">
                                    <input type="hidden" name="relatedCaseId"
                                           id="chang_relatedCaseId" value="">
                                    <input type="text" id="chang_caseName"
                                           autocomplete="off" placeholder="点击选择关联案件"
                                           class="layui-input" readonly
                                           onclick="selectRelatedCase('chang')"
                                           style="cursor:pointer;background:#efefef;">
                                </div>
                            </div>
                        </div>


                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br"
                                       style="display: inline-block; float: left;">涉案地址：</label>
                                <span class="layui-word-aux"
                                      style="display: inline-block; line-height: 38px; margin-left: 10px;">最多填写 5 个</span>
                                <div class="my-input-block" id="changCaseAddressContainer">
                                    <!-- 动态生成 -->
                                </div>
                                <div class="my-input-block" style="margin-top: 5px;">
                                    <!-- ✅ 改为使用 onclick 内联方式 -->
                                    <button type="button"
                                            class="layui-btn layui-btn-sm"
                                            id="addChangCaseAddressBtn"
                                            onclick="handleAddChangCaseAddress()">
                                        + 新增地址
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">查获经过</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_chjg" name="chang_chjg"
                                                      lay-verify="chang_chjg"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处罚结果</label>
                                <div class="my-input-block" id="chang_cfjg-div">
                                    <select name="chang_cfjg" id="chang_cfjg" lay-verify="chang_cfjg"
                                            lay-reqdiv="chang_cfjg-div">
                                        <option value="">==请选择==</option>
                                        <option value="刑事处罚">刑事处罚</option>
                                        <option value="治安处罚">治安处罚</option>
                                        <option value="未处罚">未处罚</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-form-item my-form-item">
                                <label class="my-form-label-br">处理详情</label>
                                <div class="my-input-block">
											<textarea placeholder="请输入内容" class="layui-textarea"
                                                      id="chang_clxq" name="chang_clxq"
                                                      lay-verify="chang_clxq"></textarea>
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

                <div class="right-child-content layui-tab-item"><!--人员属性标签 -->
                    <form class="layui-form" method="post" id="formAttributeLabel" onsubmit="return false;">
                        <div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                            <ul class="layui-tab-title my-tab-title">
                                <li class="layui-this">人员属性标签</li>
                                <li>标签维护记录</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <table class="layui-table">
                                        <tr>
                                            <td valign="top" width="20%">
                                                <div id="zTree" align="center"
                                                     style="width:98%;overflow: auto;height: 480px;"></div>
                                            </td>
                                            <td valign="top" width="80%">
                                                <div id="attributelabel" style="height: 480px;">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100%" colspan="2">
                                                <div class="layui-form-item" align="center">
                                                    <button type="submit" class="layui-btn" lay-submit=""
                                                            lay-filter="attributeLabelSub">立即提交
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="layui-tab-item">
                                    <table class="layui-hide" id="applyTable" lay-filter="applyTable"></table>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
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
                    <%--<div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
								<ul class="layui-tab-title my-tab-title">
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',2);" class="layui-this">电围</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',1);">卡口</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',3);">人脸识别</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',4);">车辆</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',5);">旅馆</li>
									<li onclick="openTrajectoryKK('${personnel.cardnumber}',6);">网吧</li>
								</ul>
								<div class="layui-tab-content">
									<div class="layui-tab-item layui-show">
										<table class="layui-hide" id="trajectoryTable2" lay-filter="trajectoryTable2"></table>
									</div>
									<div class="layui-tab-item">
										<table class="layui-hide" id="trajectoryTable1" lay-filter="trajectoryTable1"></table>
									</div>
									<div class="layui-tab-item">
									    <table class="layui-hide" id="trajectoryTable3" lay-filter="trajectoryTable3"></table>
									</div>
									<div class="layui-tab-item">
									   <table class="layui-hide" id="trajectoryTable4" lay-filter="trajectoryTable4"></table>
									</div>
									<div class="layui-tab-item">
									   <table class="layui-hide" id="trajectoryTable5" lay-filter="trajectoryTable5"></table>
									</div>
									<div class="layui-tab-item">
									   <table class="layui-hide" id="trajectoryTable6" lay-filter="trajectoryTable6"></table>
									</div>
								</div>
						    </div>
						--%></div>

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
                    <div class="layui-tab my-tab layui-tab-brief" lay-filter="GuiJi">
                        <ul class="layui-tab-title my-tab-title">
                            <li onclick="openjqxx('${personnel.cardnumber}');" class="layui-this">涉警信息</li>
                            <li onclick="openajxx('${personnel.cardnumber}');">涉案信息</li>

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

    // 打处单位队列管理
    var handleUnitQueue = [];       // 存储单位名称
    var handleUnitCodeQueue = [];   // 存储单位编码
    var MAX_HANDLE_UNITS = 3;       // 最大数量

    // 初始化打处单位队列
    function initHandleUnitQueue() {
        var savedUnits = $('#handleUnit').val();
        var savedCodes = $('#handleUnitCode').val();

        if (savedUnits && savedUnits.trim() !== '') {
            handleUnitQueue = savedUnits.split(',').filter(function (item) {
                return item.trim() !== '';
            });
        }
        if (savedCodes && savedCodes.trim() !== '') {
            handleUnitCodeQueue = savedCodes.split(',').filter(function (item) {
                return item.trim() !== '';
            });
        }

        // 同步长度
        while (handleUnitCodeQueue.length < handleUnitQueue.length) {
            handleUnitCodeQueue.push('');
        }

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
            if (!unitCode && policeData && policeData. length > 0) {
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
                $('#housepolice').attr('lay-verify', 'required');
                $div.find('.layui-form-label').html('户籍地派出所：<span style="color:red;">*</span>');
            } else {
                $div.hide();
                $('#housepolice').removeAttr('lay-verify').val('');
            }
        } else if (type === 'home') {
            var $div = $('#homepolice_div');
            var $required = $('#homepolice-required');
            if (county === '江阴市') {
                $div.show();
                $required.show();
                $('#homepolice').attr('lay-verify', 'required');
            } else {
                $div.hide();
                $required.hide();
                $('#homepolice').removeAttr('lay-verify').val('');
            }
        } else if (type === 'du_home') {
            // 涉赌背景tab - 现住地派出所
            var $div = $('#du_homepolice_div'); // 修改点：匹配 HTML 中的 ID
            var $required = $('#du_homepolice-required'); // 修改点：使用 # 获取 ID 而非 . 获取 class
            if (county === '江阴市') {
                $div.show();
                $required.show();
                $('#du_policeStation').attr('lay-verify', 'required');
            } else {
                $div.hide();
                $required.hide();
                $('#du_policeStation').removeAttr('lay-verify').val('');
            }
        } else if (type === 'chang_home') {
            // 涉娼背景tab - 现住地派出所
            var $div = $('#chang_homepolice_div'); // 修改点：匹配你 HTML 里的 id="chang_homepolice_div"
            var $required = $('#chang_homepolice-required'); // 修改点：匹配你 HTML 里的 id="chang_homepolice-required"
            if (county === '江阴市') {
                $div.show();
                $required.show();
                $('#chang_policeStation').attr('lay-verify', 'required');
            } else {
                $div.hide();
                $required.hide();
                $('#chang_policeStation').removeAttr('lay-verify').val('');
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

            // 1. 先加载派出所数据
            loadJiangyinPoliceData(function () {

                // 2. 户籍地
                renderPoliceSelect({
                    elem: '#housepolice',
                    initValue: '${personnel.housepolice}',
                    initId: '${personnel.housePoliceStationId}'
                });

                // 3. 现住地
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

                // 6. Tab - 涉娼
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
        $('#homeCounty').on('input blur', function () {
            togglePoliceDiv($(this).val().trim(), 'home');
        });
        $(document).on('input blur', '#du_homeCounty', function () {
            togglePoliceDiv($(this).val().trim(), 'du_home');
        });

        // ====== 涉娼 ======
        $(document).on('input blur', '#chang_homeCounty', function () {
            togglePoliceDiv($(this).val().trim(), 'chang_home');
        });

        // 页面加载时触发
        togglePoliceDiv($('#houseCounty').val().trim(), 'house');
        togglePoliceDiv($('#homeCounty').val().trim(), 'home');

    });

    // // 7. 修改：加载数据字典
    // loadBasicMsg('302', 'dbfs');           // 赌博方式-
    // loadBasicMsg('303', 'dbbw');           // 赌博部位-
    // loadBasicMsg('305', 'chang_myfs');     // 卖淫方式-
    // loadBasicMsg('308', 'chang_scbw');     // 涉娼部位-
    // loadBasicMsg('304', 'chang_scjs'); // 涉娼角色-
    // loadBasicMsg('301', 'personAttribute-du');   // 涉赌人员属性-
    // loadBasicMsg('307', 'collectSource-du');     // 涉赌采集来源-
    // loadBasicMsg('307', 'collectSource-chang');   // 涉娼采集来源-

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

    // 渲染派出所下拉选择框（使用原生 Layui select）
    // cfg.initValue: 派出所名称
    // cfg.initId: 派出所ID（优先按ID匹配）
    // function renderPoliceSelect(cfg) {
    //     var $select = $(cfg.elem);
    //     var initValue = cfg.initValue || '';
    //     var initId = cfg.initId || '';
    //
    //     // 清空现有选项（保留placeholder）
    //     $select.find('option:not(:first)').remove();
    //
    //     // 添加派出所列表选项
    //     var foundById = false;
    //     if (policeData && policeData.length > 0) {
    //         policeData.forEach(function (item) {
    //             var selected = '';
    //             // 优先按ID匹配
    //             if (initId && item.departmentid && item.departmentid == initId) {
    //                 selected = 'selected';
    //                 foundById = true;
    //             } else if (!initId && initValue === item.name) {
    //                 // 如果没有ID，则按名称匹配
    //                 selected = 'selected';
    //             }
    //             var dataAttr = item.departmentid ?  ' data-departmentid="' + item.departmentid + '"' : '';
    //             // 添加data-departmentid属性存储派出所ID
    //             $select.append(
    //                 '<option value="' + item.name + '" data-departmentid="' + (item.departmentid || '') + '" ' + selected + '>' +
    //                 item.name +
    //                 '</option>'
    //             );
    //         });
    //     }
    //
    //     // 如果初始值不在下拉列表中，也要显示（仅当没有按ID找到时）
    //     if (!foundById && initValue && policeData.every(function (p) {
    //         return p.name !== initValue;
    //     })) {
    //         $select.append('<option value="' + initValue + '" selected>' + initValue + '</option>');
    //     }
    //
    //     layui.form.render('select');
    // }

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
        laydate.render({elem: '#chsj', format: 'yyyy-MM-dd'});
        laydate.render({elem: '#chang_chsj', format: 'yyyy-MM-dd'});
        laydate.render({elem: '#du_collectDate', format: 'yyyy-MM-dd'});
        laydate.render({elem: '#chang_collectDate', format: 'yyyy-MM-dd'});

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
        form.on('submit(updateZa)', function (data) {
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

            $("#formZa").ajaxSubmit({
                url: url,
                type: 'post',
                dataType: 'json',
                data: {
                    homePoliceStationId: safeIntParam(homePoliceStationId),
                    housePoliceStationId: safeIntParam(housePoliceStationId)
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
                        // 使用 layer.alert 代替 layer.msg 测试，因为 alert 必须点击确定，不会自动消失
                        top.layer.msg(obj.msg || '治安人员修改成功！', {
                            icon: 1,
                            time: 2000, zIndex: 99999999
                        });
                        // 如果希望消息显示完后关闭当前弹窗
                        // var index = parent.layer.getFrameIndex(window.name);
                        // setTimeout(function(){
                        //     parent.layer.close(index);
                        // }, 2000)
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
    });

    // ==================== 涉案地址相关函数 ====================
    var maxAddressCount = 5; // 最多填写 5 个涉案地址

    // 涉赌背景：添加涉案地址输入框
    function addDuCaseAddressInput(value) {
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

        var html = '<div class="layui-form-item address-row" style="margin-bottom: 5px;">' +
            '<div class="layui-input-inline" style="width: 300px;">' +
            '<input type="text" name="du_caseAddress" value="' + (value || '') + '" placeholder="请输入涉案地址" class="layui-input">' +
            '</div>' +
            '<div class="layui-input-inline" style="width: 100px;">' +
            '<button type="button" class="layui-btn layui-btn-danger btn-remove-address" onclick="removeAddressRow(this)">删除</button>' +
            '</div>' +
            '</div>';

        $container.append(html);
        console.log('✓ 添加涉赌涉案地址成功，当前数量：' + ($container.find('.address-row').length));
    }

    // 涉娼背景：添加涉案地址输入框
    function addChangCaseAddressInput(value) {
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

        var html = '<div class="layui-form-item address-row" style="margin-bottom: 5px;">' +
            '<div class="layui-input-inline" style="width: 300px;">' +
            '<input type="text" name="chang_caseAddress" value="' + (value || '') + '" placeholder="请输入涉案地址" class="layui-input">' +
            '</div>' +
            '<div class="layui-input-inline" style="width: 100px;">' +
            '<button type="button" class="layui-btn layui-btn-danger btn-remove-address" onclick="removeAddressRow(this)">删除</button>' +
            '</div>' +
            '</div>';

        $container.append(html);
        console.log('✓ 添加涉娼涉案地址成功，当前数量：' + ($container.find('.address-row').length));
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
            var val = $. trim($(this).val());
            if (val) {
                list.push(val);
            }
        });
        console.log('📋 收集涉赌地址：', list);
        return list;
    }

    // ✅ 收集涉娼地址
    function collectChangCaseAddressList() {
        var list = [];
        $('#changCaseAddressContainer').find('input[name="chang_caseAddress"]').each(function () {
            var val = $.trim($(this).val());
            if (val) {
                list.push(val);
            }
        });
        console.log('📋 收集涉娼地址：', list);
        return list;
    }

    // ==================== 事件绑定（使用 onclick 内联方式） ====================
    // ✅ 涉赌新增地址按钮 - 改用 onclick 属性
    function handleAddDuCaseAddress() {
        console.log('🔘 点击了涉赌新增地址按钮');
        addDuCaseAddressInput('');
    }

    // ✅ 涉娼新增地址按钮 - 改用 onclick 属性
    function handleAddChangCaseAddress() {
        console.log('🔘 点击了涉娼新增地址按钮');
        addChangCaseAddressInput('');
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

        // 初始化涉娼地址容器
        if ($('#changCaseAddressContainer').length > 0) {
            if ($('#changCaseAddressContainer .address-row').length === 0) {
                addChangCaseAddressInput('');
                console.log('📦 初始化涉娼地址容器');
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
</script>
<script type="text/javascript">
    layui.use(['element', 'form', 'jquery', 'table', 'treeSelect', 'zTreeSelectM', 'laydate'], function () {
        var element = layui.element,
            $ = layui.jquery,
            table = layui.table,
            laydate = layui.laydate,
            form = layui.form;

        laydate.render({
            elem: '#chsj'
            , format: 'yyyy-MM-dd'
        });
        laydate.render({
            elem: '#chang_chsj'
            , format: 'yyyy-MM-dd'
        });

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


        form.verify({
            lssdqk: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") return "请输入历史涉赌情况综述";
            },
            chsj: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") return "请选择处罚时间";
            },
            chjg: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") return "请输入查获经过";
            },
            cfjg: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") {
                    $(item).next().find("input[type='text']").focus();
                    return "请选择处罚结果";
                }
            },
            clxq: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") return "请输入处理详情";
            },
            dbfs: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") {
                    return "请选择赌博方式";
                }
            },
            dbbw: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "duSub") {
                    return "请选择赌博部位";
                }
            },
            chang_lsscqk: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") return "请输入历史涉嫖情况综述";
            },
            chang_chsj: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") return "请选择处罚时间";
            },
            chang_chjg: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") return "请输入查获经过";
            },
            chang_cfjg: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") {
                    $(item).next().find("input[type='text']").focus();
                    return "请选择处罚结果";
                }
            },
            chang_clxq: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") return "请输入处理详情";
            },
            chang_scjs: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") {
                    return "请选择涉娼角色";
                }
            },
            chang_myfs: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") {
                    return "请选择涉娼方式";
                }
            },
            chang_scbw: function (value, item) {
                if (value == "" && item.ownerDocument.activeElement.id == "changSub") {
                    return "请选择涉娼部位";
                }
            }
        });

        form.on('submit(duSub)', function (data) {
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
                        homePoliceStationId = policeData[i]. departmentid || '';
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

            console.log('涉赌提交现住地址: 省=' + duHomeProvince + ', 市=' + duHomeCity + ', 县=' + duHomeCounty +
                        ', 镇=' + duHomeTown + ', 详址=' + duHomeplace + ', 经度=' + duHomex + ', 纬度=' + duHomey);

            $("#formZaDu").ajaxSubmit({
                url: '<c:url value="/updateZaDu.do"/>',
                data: {
                    personnelid:${personnel.id},
                    id: $('#firstDu').val(),
                    menuid:${menuid},
                    caseAddressList: duCaseAddressList. join('，'),
                    updateoperator: '<%=userSession != null ? userSession.getLoginUserName() : ""%>',
                    homePoliceStationId: homePoliceStationId,
                    homeProvince: duHomeProvince,
                    homeCity: duHomeCity,
                    homeCounty: duHomeCounty,
                    homeTown: duHomeTown,
                    homeplace: duHomeplace,
                    homepolice: selectedPoliceStation,
                    homex: duHomex,
                    homey: duHomey,
                    validflag: 1
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    var obj = eval('(' + data + ')');
                    if (obj.flag > 0) {
                        //弹出loading
                        var index = top.layer.msg('涉赌背景提交中，请稍候', {icon: 16, time: false, shade: 0.8});
                        setTimeout(function () {
                            top.layer.msg(obj.msg);
                            top.layer.close(index);
                            //刷新涉赌背景模块
                            openZaDu(obj.flag);
                        }, 2000);
                    } else {
                        layer.msg(obj.msg);
                    }

                },
                error: function () {
                    layer.alert("请求失败！");
                }
            });
            return false;
        });
        form.on('submit(changSub)', function (data) {
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
            console.log('涉娼背景提交: 派出所=' + selectedChangPolice + ', ID=' + changHomePoliceStationId);

            $("#formZaChang").ajaxSubmit({
                url: '<c:url value="/updateZaChang.do"/>',
                data: {
                    personnelid:${personnel.id},
                    id: $('#firstChang').val(),
                    menuid:${menuid},
                    caseAddressList: changCaseAddressList.join('，'),
                    homePoliceStationId: changHomePoliceStationId
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    var obj = eval('(' + data + ')');
                    if (obj.flag > 0) {
                        //弹出loading
                        var index = top.layer.msg('涉娼背景提交中，请稍候', {icon: 16, time: false, shade: 0.8});
                        setTimeout(function () {
                            top.layer.msg(obj.msg);
                            top.layer.close(index);
                            //刷新涉娼背景模块
                            openZaChang(obj.flag);
                        }, 2000);
                    } else {
                        layer.msg(obj.msg);
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
                title: "涉赌背景历史记录",
                type: 2,  // iframe 层
                content: locat + "/jsp/personel/za/duhistory.jsp? personnelid=${personnel.id}",
                area: ['1400px', '600px'],  // ✅ 增加宽度以展示所有列
                maxmin: true,
                success: function (layero, index) {
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回列表', '. layui-layer-setwin . layui-layer-close', {
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

        // 2. 无论何时都显示“历史记录”按钮
        $('#duHistory').show();

        // 3. 初始化派出所下拉框（传入空值，显示“请选择”）
        renderPoliceSelect({
            elem: '#du_policeStation',
            initValue: ''
        });

        // 4. 执行清空逻辑
        $('#firstDu').val(0); // 标记为新记录，ID设为0

        // 清空文本框、时间插件和隐藏域
        $('#lssdqk, #chsj, #chjg, #clxq, #du_phone, #du_collectDate, #du_homeProvince, #du_homeCity, #du_homeCounty, #du_homeTown, #du_homeplace, #du_homex, #du_homey').val('');
        // 下拉框重置
        $('#cfjg, #personAttribute-du, #collectSource-du, #dbfs, #dbbw').val('');

        // 5. 涉案地址初始化：清空容器并只给一个空输入框
        $('#duCaseAddressContainer').empty();
        addDuCaseAddressInput(''); // 调用您之前定义的函数生成第一个空框

        // 6. 隐藏原本因为有数据才显示的派出所区域
        togglePoliceDiv('', 'du_home');

        // 7. 【关键】重新渲染表单，使清空后的状态生效
        layui.form.render();
    }

    function openZaChang(personnelid) {
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getZaChangByPersonnelid.do?personnelid="/>' + personnelid,
            dataType: 'json',
            async: false,
            success: function (data) {
                if (data.firstChang > 0) {
                    var zaChang = data.zaChang;
                    $('#firstChang').val(zaChang.id);//存放zaChang id
                    $('#changHistory').show();
                    $('#chang_lsscqk').val(zaChang.chang_lsscqk);
                    $('#chang_chsj').val(zaChang.chang_chsj);
                    $('#chang_chjg').val(zaChang.chang_chjg);
                    $('#chang_clxq').val(zaChang.chang_clxq);
                    $('#chang_phone').val(zaChang.phone);
                    $('#chang_collectDate').val(zaChang.collectDate);

                    // 处罚结果
                    if (zaChang.chang_cfjg) {
                        $("#chang_cfjg").val(zaChang.chang_cfjg);
                    }
                    // 采集来源
                    if (zaChang.collectSource) {
                        $("#collectSource-chang").val(zaChang.collectSource);
                    }
                    // 涉黄方式
                    if (zaChang.chang_myfs) {
                        if ($("#chang_myfs option[value='" + zaChang.chang_myfs + "']").length == 0) {
                            $('#chang_myfs').append("<option value='" + zaChang.chang_myfs + "'>" + zaChang.chang_myfs + "</option>");
                        }
                        $("#chang_myfs").val(zaChang.chang_myfs);
                    }
                    // 涉娼部位
                    if (zaChang.chang_scbw) {
                        if ($("#chang_scbw option[value='" + zaChang.chang_scbw + "']").length == 0) {
                            $('#chang_scbw').append("<option value='" + zaChang.chang_scbw + "'>" + zaChang.chang_scbw + "</option>");
                        }
                        $("#chang_scbw").val(zaChang.chang_scbw);
                    }
                    // 涉娼角色（使用chang_scjs显示）
                    if (zaChang.chang_scjs) {
                        if ($("#chang_scjs option[value='" + zaChang.chang_scjs + "']").length == 0) {
                            $('#chang_scjs').append("<option value='" + zaChang.chang_scjs + "'>" + zaChang.chang_scjs + "</option>");
                        }
                        $("#chang_scjs").val(zaChang.chang_scjs);
                    }
                    layui.form.render('select');

                    // 涉案地址回显
                    $('#changCaseAddressContainer').empty(); // 清空容器
                    var addressList = zaChang.caseAddressArray || [];
                    if (addressList.length === 0) {
                        addChangCaseAddressInput('');
                    } else {
                        addressList.forEach(function (addr) {
                            addChangCaseAddressInput(addr);
                        });
                    }
                } else {
                    $('#firstChang').val(0);
                    $('#changHistory').hide();
                }
            }
        });
    }

    function openAttributelabel() {
        //清空页面
        $("#zTree").html("");
        $('#attributelabel').html("");
        var zslabel1 = ",${personnel.zslabel1},";
        $.ajax({
            type: 'POST',
            url: '<c:url value="/getRootAttributeLabel.do" />',
            dataType: 'json',
            async: false,
            success: function (data) {
                $.each(data, function (num, item) {
                    if (zslabel1.indexOf("," + item.id + ",") > -1) {
                        $("#zTree").append("<input type='checkbox' name='attributeLable' value='" + item.id + "' lay-filter='attributeLable' title='" + item.attributelabel + "' checked disabled>");
                        $('#attributelabel').append("<div class='layui-col-md11' style='left:-30px;'><div class='layui-form-item my-form-item'><label class='layui-form-label'>" + item.attributelabel +
                            "</label><div class='layui-input-block'><div id='attribute" + item.id + "'></div></div></div></div>" +
                            "<div class='layui-col-md1' style='left:-30px;'><div class='layui-form-item my-form-item'><button onclick='addLabel(" + item.id + ",&quot;" + item.attributelabel + "&quot;)' class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more'>&#xe624;更多</button></div></div></div>");
                        if (item.id == 9) {
                            var _zTreeSelectM = layui.zTreeSelectM({
                                elem: '#attribute' + item.id,//元素容器【必填】
                                data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid=' + item.id,
                                type: 'get',  //设置了长度
                                max: 20,//最多选中个数，默认5
                                selected: [${personnel.zslabel2}],//默认值
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
                            var _zTreeSelectM = layui.zTreeSelectM({
                                elem: '#attribute' + item.id,//元素容器【必填】
                                data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid=' + item.id,
                                type: 'get',  //设置了长度
                                max: 5,//最多选中个数，默认5
                                selected: [${personnel.zslabel2}],//默认值
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
                    } else {
                        $("#zTree").append("<input type='checkbox' name='attributeLable' value='" + item.id + "' lay-filter='attributeLable' title='" + item.attributelabel + "'>");
                    }
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

        layui.use('form', function() {
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
            if(data.homePoliceStationName) {
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

            // ✅ 查获经过
            $('#chjg').val(data.chjg || '');

            // ✅ 处罚结果
            $('#cfjg').val(data.cfjg || '');

            // ✅ 处理详情
            $('#clxq').val(data.clxq || '');

            // ✅ 处罚时间
            $('#chsj').val(data.chsj || '');

            // ✅ 涉案地址列表 - 重新生成地址行
            if(data.caseAddressList) {
                $('#duCaseAddressContainer').empty();
                var addresses = data.caseAddressList. split('，');
                addresses.forEach(function(addr) {
                    if(addr. trim()) {
                        addDuCaseAddressInput(addr);
                    }
                });
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

</script>




<script type="text/javascript" src="<c:url value="/jsp/personel/personel221018.js"/>"></script>
<!-- 头像编辑、关联信息 、社会关系 数据处理js -->
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

    // 涉娼背景tab专用地图选点函数
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

    // 涉赌背景tab - 根据县级市判断派出所显示
    function checkDuPoliceStation() {
        var county = $('#du_homeCounty').val().trim();
        togglePoliceDiv(county, 'du_home');
    }

    // 涉娼背景tab - 根据县级市判断派出所显示
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

</script>
</body>
</html>
