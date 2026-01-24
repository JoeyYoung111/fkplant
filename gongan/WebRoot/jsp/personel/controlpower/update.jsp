<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
</head>
<body>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>编辑管控力量</legend>
    </fieldset>
    <form class="layui-form" method="post" id="form1">
        <input type="hidden"  name="menuid" id="menuid"  value=0></input>
        <input type="hidden"  name="id" id="id"  value=${controlpower.id}></input>
        <input type="hidden"  name="personnelid" id="personnelid"  value=${controlpower.personnelid}></input>
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="personname" value="${controlpower.personname}" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">身份证号码</label>
                <div class="layui-input-block">
                    <input type="text" name="cardnumber" value="${controlpower.cardnumber}" lay-verify="required|identity" autocomplete="off" placeholder="请输入身份证号码" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">工作单位</label>
                <div class="layui-input-block">
                    <input type="text" name="workunit" value="${controlpower.workunit}" lay-verify="required" autocomplete="off" placeholder="请输入工作单位" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">工作职务</label>
                <div class="layui-input-block">
                    <input type="text" name="workjob" value="${controlpower.workjob}" lay-verify="required" autocomplete="off" placeholder="请输入工作职务" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-block">
                    <input type="text" name="mobile" value="${controlpower.mobile}" lay-verify="required|phone" autocomplete="off" placeholder="请输入联系电话" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注信息</label>
                <div class="layui-input-block">
                    <textarea name="memo" placeholder="请输入备注信息" class="layui-textarea">${controlpower.memo}</textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>

    <script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'layedit', 'laydate'], function() {
            var form = layui.form,
                layer = layui.layer;

            //监听提交
            form.on('submit(demo1)', function(data) {
                $("#form1").ajaxSubmit({
                    url:        '<c:url value="/updatecontrolpower.do"/>',
                    dataType:   'json',
                    async:  false,
                    success:    function(data) {
                        var obj = eval('(' + data + ')');
                        if(obj.flag>0){
                            //弹出loading
                            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                            setTimeout(function(){
                                top.layer.msg(obj.msg);
                                top.layer.close(index);
                                layer.closeAll("iframe");
                                //刷新父页面
                                parent.location.reload();
                            },2000);
                        }else{
                            layer.msg(obj.msg);
                        }
                    },
                    error:function() {
                        layer.alert("请求失败！");
                    }

                });
                return false;
            });
        });
    </script>
</body>
</html>