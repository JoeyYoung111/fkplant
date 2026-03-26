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
    <link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
<body style="background-color:#FFFFFF;">
<form class="layui-form" method="post" id="form1" onsubmit="return false;">
    <table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 2.5%;margin-top: 2.5%;margin-bottom: 30px;">
        <tr>
            <td width="60%" colspan=2>
                <strong>请选择导出人员：</strong>
            </td>
            <%--				<td width="30%">--%>
            <%--					（姓名和身份证、年龄为导出的必选属性）--%>
            <%--				</td>--%>
        </tr>
        <tr>
            <td width="60%" colspan=2>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend>涉赌人员导出</legend>
                </fieldset>
            </td>
            <td width="20%" style="padding-left:25px;">
                <input type="checkbox" name="exportTypeOption" value="shedu" title="选择" lay-skin="primary" lay-filter="typeFilter">
            </td>
        </tr>
        <tr>
            <td width="60%" colspan=2>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend>涉黄人员导出</legend>
                </fieldset>
            </td>
            <td width="20%" style="padding-left:25px;">
                <input type="checkbox" name="exportTypeOption" value="shechang" title="选择" lay-skin="primary" lay-filter="typeFilter">
            </td>
        </tr>
        <tr>
            <td width="60%" colspan=2>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend>陪侍人员导出</legend>
                </fieldset>
            </td>
            <td width="20%" style="padding-left:25px;">
                <input type="checkbox" name="exportTypeOption" value="peishi" title="选择" lay-skin="primary" lay-filter="typeFilter">
            </td>
        </tr>
        <tr>
            <td width="60%" colspan=2>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend>治安未成年人导出</legend>
                </fieldset>
            </td>
            <td width="20%" style="padding-left:25px;">
                <input type="checkbox" name="exportTypeOption" value="minor" title="选择" lay-skin="primary" lay-filter="typeFilter">
            </td>
        </tr>
        <tr>
            <td width="60%" colspan=2>
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend>涉及未成年人案件人员导出</legend>
                </fieldset>
            </td>
            <td width="20%" style="padding-left:25px;">
                <input type="checkbox" name="exportTypeOption" value="minorCase" title="选择" lay-skin="primary" lay-filter="typeFilter">
            </td>
        </tr>
    </table>
    <div class="layui-form-item">
        <div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 20px;">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="exportSub"><i class="layui-icon">&#xe67d;</i>导 出</button>
        </div>
    </div>
</form>
<script type="text/javascript">
    layui.use(['form', 'layer'],function(){
        var form=layui.form;
        var layer=layui.layer;

        // 1. 实现复选框单选逻辑
        // 使用 Layui 的 form.on('checkbox') 来监听复选框变化
        form.on('checkbox(typeFilter)', function(data){
            if(data.elem.checked){
                // 当选中一个时，取消其他所有同名复选框的选中状态
                $("input[name='exportTypeOption']").prop("checked", false);
                $(data.elem).prop("checked", true);
            }
            form.render('checkbox'); // 必须重新渲染
        });

        // 2. 导出按钮提交逻辑
        form.on('submit(exportSub)', function(data){
            // 获取用户选择的导出类型
            var selectedExportType = $("input[name=exportTypeOption]:checked");

            // 增强提示信息
            if (selectedExportType.length === 0) {
                // 使用 layer.msg 弹出醒目提示
                layer.msg('请先选择一个导出类型！（每次仅可选择一项）', {icon: 7, anim: 6, time: 3000});
                return false;
            }

            var exportType = selectedExportType.val();
            var index = top.layer.msg('数据导出中，请稍候...', {icon: 16, time: false, shade: 0.8});

            // 专项导出逻辑：全量导出，不再叠加前端搜索条件
            var url = '<c:url value="/exportZaPersonnelSpecial.do"/>?'+
                'exportType='+exportType+
                '&personlabelid='+${param.personlabelid}+
                '&menuid='+${param.menuid};

            var xhr=new XMLHttpRequest();
            xhr.open('POST',url,true);
            xhr.responseType="blob";
            xhr.onload=function(){
                top.layer.close(index);

                // 检查HTTP状态码
                if(this.status!==200){
                    top.layer.msg('导出失败，HTTP状态：'+this.status, {icon: 2, time: 3000});
                    return;
                }

                var blob=this.response;
                var contentType=xhr.getResponseHeader("Content-Type");

                // 检查是否是JSON错误响应
                if(contentType&&contentType.indexOf("application/json")!==-1){
                    // 读取JSON错误消息
                    var reader=new FileReader();
                    reader.onload=function(e){
                        try{
                            var json=JSON.parse(e.target.result);
                            var errorMsg=json.message||"导出失败";
                            top.layer.msg(errorMsg, {icon: 2, time: 3000});
                        }catch(err){
                            top.layer.msg("导出失败", {icon: 2, time: 3000});
                        }
                    };
                    reader.readAsText(blob);
                    return;
                }

                // 检查是否是HTML错误页（兼容老版本错误处理）
                if(contentType&&contentType.indexOf("text/html")!==-1){
                    // 读取blob内容检查是否是错误消息
                    var reader2=new FileReader();
                    reader2.onload=function(e){
                        var text=e.target.result;
                        if(text.indexOf("<script>")!==-1||text.indexOf("alert")!==-1){
                            // 提取alert中的错误信息
                            var match=text.match(/alert\('([^']+)'\)/);
                            var errorMsg=match?match[1]:"导出失败";
                            top.layer.msg(errorMsg, {icon: 2, time: 3000});
                        }else{
                            top.layer.msg("导出失败，返回了错误页面", {icon: 2, time: 3000});
                        }
                    };
                    reader2.readAsText(blob);
                    return;
                }

                // 获取文件名
                var headerName=xhr.getResponseHeader("Content-Disposition");
                if(!headerName){
                    top.layer.msg("无导出数据!未生成文件。", {icon: 2, time: 3000});
                    return;
                }

                // 解析文件名（支持 filename= 和 filename*= 两种格式）
                var fileName="";
                var match=headerName.match(/filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/);
                if(match&&match[1]){
                    fileName=decodeURIComponent(match[1].replace(/['"]/g,''));
                }

                if(!fileName||fileName===""){
                    top.layer.msg("无导出数据!未生成文件。", {icon: 2, time: 3000});
                    return;
                }

                // 下载文件
                if(window.navigator.msSaveOrOpenBlob){
                    // IE浏览器
                    navigator.msSaveOrOpenBlob(blob,fileName);
                }else{
                    // 其他浏览器
                    var a=document.createElement('a');
                    a.href=URL.createObjectURL(blob);
                    a.download=fileName;
                    document.body.appendChild(a);
                    a.click();
                    setTimeout(function(){
                        document.body.removeChild(a);
                        URL.revokeObjectURL(a.href);
                    },100);
                }

                parent.layer.closeAll("iframe");
            };

            xhr.onerror=function(){
                top.layer.close(index);
                top.layer.msg('网络请求失败，请检查网络连接', {icon: 2, time: 3000});
            };

            xhr.send();

            return false;
        });
    })
</script>
</body>
</html>
