<%@ page contentType='text/html;charset=UTF-8' language='java'%>
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
        <legend>添加管控文件</legend>
    </fieldset>
    <form class="layui-form" method="post" id="form1">
        <input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
        <input type="hidden"  name="type" id="type"  value=${param.type}></input>
        <input type="hidden"  name="menuid" id="menuid"  value=0></input>


        <div class="layui-form-item">
            <label class="layui-form-label">文件名称</label>
            <div class="layui-input-block">
                <button type="button" class="layui-btn" id="uploadFile"><i class="layui-icon"></i>上传文件</button>
                <input type="text" name="filename" id="filename" lay-verify="required"  autocomplete="off" class="layui-input" readonly style="background:#efefef;cursor:pointer;">
                <input type="hidden" name="attachment_id" id="attachment_id" value=""/>
            </div>
        </div>


        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注信息</label>
            <div class="layui-input-block">
                <textarea name="memo" id="memo" placeholder="请输入备注信息" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>

    <script>
        var locat = (window.location+'').split('/');
    layui.use(['form', 'upload'], function(){
        var form = layui.form;
        var upload = layui.upload;
        var layer = layui.layer;
        
        //监听提交
        form.on('submit(formDemo)', function(data){
            // 直接提交表单，因为文件已经在选择时上传
            submitForm();
            return false;
        });

        // 表单提交函数
        function submitForm(){

            $("#form1").ajaxSubmit({
                url:        '<c:url value="/addcontrolfiles.do"/>',
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



        }

        // 文件上传功能
        upload.render({
            elem: '#uploadFile',
            url: '<c:url value="/newuploadfile1.do"/>',
            accept: 'file',
            auto: true,
            choose: function(obj) {
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result) {
                    $("#filename").val(file.name);
                });
            },
            before: function(obj){
                layer.load();
            },
            done: function(res){
                layer.closeAll('loading');
                if(res.success > 0){
                    layer.msg('上传成功');
                    $("#attachment_id").val(res.success);
                } else {
                    layer.msg('上传失败');
                }
            },
            error: function(){
                layer.closeAll('loading');
                layer.msg('上传失败');
            }
        });
    });
    </script>
</body>
</html>