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
    <base href="<%=basePath%>">
    <title>民意诉求人员列表</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>" media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <style>
      /* 未完善信息行标红 */
      .ducha-unviewed td { color: red !important; }
    </style>
  </head>
  <body>

<blockquote class="layui-elem-quote news_search">
<div class="demoTable">
<form class="layui-form" onsubmit="return false;" style="display:inline;">

  <!-- 第一行搜索条件 -->
  <div class="layui-inline" style="width:212px;">
    <input class="layui-input" type="text" id="cardnumber" placeholder=" 身份证号：" autocomplete="off">
  </div>
  <div class="layui-inline" style="width:160px;">
    <input class="layui-input" type="text" id="personname" placeholder=" 姓名：" autocomplete="off">
  </div>
  <div class="layui-inline" style="width:212px;">
    <input class="layui-input" type="text" id="homeplace" placeholder=" 现住地详址：" autocomplete="off">
  </div>
  <div class="layui-inline">
    <div id="jurisdictunit1" style="width:280px;"></div>
  </div>
  <div class="layui-inline" style="width:150px;">
    <input class="layui-input" type="text" id="jurisdictpolice1" placeholder=" 责任民警：" autocomplete="off">
  </div>
  <br>

  <!-- 第二行搜索条件 -->
  <div class="layui-inline" style="width:160px;">
    <select id="jointcontrollevel">
      <option value=""> 联控级别: 全部</option>
    </select>
  </div>
  <div class="layui-inline" style="width:160px;">
    <select id="personnelLevel">
      <option value="-1"> 人员级别: 全部</option>
      <option value="0">已化解</option>
      <option value="1">一般未化解</option>
      <option value="2">重点未化解</option>
    </select>
  </div>
  <div class="layui-inline">
    <div id="attributelabels" style="width:300px;"></div>
  </div>

  <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
  <button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>

  <!-- 工具栏按钮模板 -->
  <script type="text/html" id="toolbarDemo">
    <c:if test='${fn:contains(param.buttons,"新增")}'>
      <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>新 增</button>
    </c:if>
    <c:if test='${fn:contains(param.buttons,"修改")}'>
      <button type="button" class="layui-btn layui-btn-sm" lay-event="update">
        <i class="layui-icon layui-icon-edit"></i>修 改
      </button>
    </c:if>
    <c:if test='${fn:contains(param.buttons,"导出")}'>
      <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导 出</button>
    </c:if>
  </script>

  <!-- 行操作按钮模板 -->
<%--  <script type="text/html" id="barButton">--%>
<%--    <c:if test='${fn:contains(param.buttons,"详情")}'>--%>
<%--      <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>--%>
<%--    </c:if>--%>
<%--    <c:if test='${fn:contains(param.buttons,"修改")}'>--%>
<%--      <a class="layui-btn layui-btn-xs" lay-event="update">修改</a>--%>
<%--    </c:if>--%>
<%--  </script>--%>

</form>
</div>
</blockquote>

<table class="layui-hide" id="duchaTable" lay-filter="duchaTable"></table>

<script>
var locat = (window.location+'').split('/');
var now = new Date();
$(function(){
  if('main' == locat[3]){
    locat = locat[0]+'//'+locat[2];
  } else {
    locat = locat[0]+'//'+locat[2]+'/'+locat[3];
  }
});

/* ===== 工具函数：填充下拉选项 ===== */
function fillOption(data) {
  var options = '';
  $.each(data.list, function(i, item) {
    $.each(item, function(i) {
      options += '<option value="' + this.text + '">' + this.text + '</option>';
    });
  });
  return options;
}

/* ===== 初始化联控级别下拉 ===== */
function getJointcontrollevel() {
  $.ajax({
    type: 'POST',
    url:  '<c:url value="/getBMByTypeToJSON.do?basicType="/>'+47,
    dataType: 'json',
    async: false,
    success: function(data) {
      $("#jointcontrollevel").append(fillOption(data));
    }
  });
}

$(document).ready(function(){
  getJointcontrollevel();
});

/* ===== Layui 模块初始化 ===== */
layui.config({
  base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
  zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});

layui.use(['table','form','zTreeSelectM'], function(){
  var table = layui.table;
  var zTreeSelectM = layui.zTreeSelectM;

  /* ===== 管辖责任单位树形下拉 ===== */
  var _unitSelect = zTreeSelectM({
    elem: '#jurisdictunit1',
    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
    type: 'get',
    selected: [],
    max: 100,
    name: 'jurisdictunit1',
    delimiter: ',',
    tips: ' 管辖责任单位：',
    field: { idName: 'id', titleName: 'name' },
    zTreeSetting: {
      check: { enable: true, chkboxType: { "Y": "", "N": "" } },
      data: {
        simpleData: { enable: false },
        key: { name: 'name', children: 'children' }
      },
      view: { showIcon: false }
    }
  });

  /* ===== 人员属性子标签多选下拉（由菜单跳转时传入 personlabelid） ===== */
  var _labelSelect = zTreeSelectM({
    elem: '#attributelabels',
    data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid=${param.personlabelid}',
    type: 'get',
    selected: [],
    max: 100,
    name: 'attributelabels',
    delimiter: ',',
    tips: ' 人员属性标签：',
    field: { idName: 'id', titleName: 'name' },
    zTreeSetting: {
      check: { enable: true, chkboxType: { "Y": "", "N": "" } },
      data: {
        simpleData: { enable: false },
        key: { name: 'name', children: 'children' }
      },
      view: { showIcon: false }
    }
  });

  /* ===== Table 渲染 ===== */
  table.render({
    elem: '#duchaTable',
    url:  '<c:url value="/ducha/searchDuchaPersonnel.do"/>',
    method: 'post',
    toolbar: '#toolbarDemo',
    defaultToolbar: ['filter', 'print'],
    cols: [[
      { field: 'id', type: 'radio', fixed: 'left' },
      { field: 'personname', title: '姓名', width: 90,
        templet: function(item) {
          var style = (item.duchaViewed === 0 || item.duchaViewed === '0')
                      ? "color:red;font-weight:bold;" : "color:#1E9FFF;";
          return "<span style='cursor:pointer;" + style + "' onclick='openShowinfo(" + item.id + ")'>" + item.personname + "</span>";
        }
      },
      { field: 'cardnumber', title: '身份证号码', width: 185,
        templet: function(item) {
          var style = (item.duchaViewed === 0 || item.duchaViewed === '0')
                      ? "color:red;" : "";
          return "<span style='" + style + "'>" + item.cardnumber + "</span>";
        }
      },
      { field: 'sexes',    title: '性别',   width: 55 },
      { field: 'officeName', title: '年龄', width: 55,
        templet: function(item) {
          var age = now.getFullYear();
          var cn = item.cardnumber ? item.cardnumber.toString() : '';
          if (cn.length === 15)      { age -= (parseInt(cn.substring(6,8)) + 1900); age++; }
          else if (cn.length === 18) { age -= parseInt(cn.substring(6,10)); age++; }
          else                       { age = ''; }
          return "<span>" + age + "</span>";
        }
      },
      { field: 'houseplace', title: '户籍地址',    width: 160 },
      { field: 'homeplace',  title: '现住地址',    width: 160 },
      { field: 'jurisdictunit',  title: '管辖责任单位', width: 120 },
      { field: 'jurisdictpolice', title: '责任民警',   width: 90  },
      { field: 'personnelLevel', title: '人员级别', width: 100,
        templet: function(item) {
          var lv = item.personnelLevel;
          if (lv === 0 || lv === '0') return "<span style='color:green;'>已化解</span>";
          if (lv === 1 || lv === '1') return "<span style='color:orange;'>一般未化解</span>";
          if (lv === 2 || lv === '2') return "<span style='color:red;font-weight:bold;'>重点未化解</span>";
          return "<span>—</span>";
        }
      },
      { field: 'jointcontrollevel', title: '联控级别', width: 90 },
      { field: 'persontype',        title: '人员类别', width: 90 }
      // { field: 'right', title: '操作', toolbar: '#barButton', width: 140, align: 'center', fixed: 'right' }
    ]],
    page: true,
    limit: 15,
    /* 列表渲染完成后，对 duchaViewed=0 的行整体标红 */
    done: function(res, curr, count) {
      // Layui table 渲染的 tbody 行，通过 lay-filter 对应的容器定位
      setTimeout(function() {
        $('table[lay-filter="duchaTable"]').closest('.layui-table-box')
          .find('.layui-table-body tbody tr').each(function(idx) {
            var rowData = res.data[idx];
            if (rowData && (rowData.duchaViewed === 0 || rowData.duchaViewed === '0')) {
              $(this).addClass('ducha-unviewed');
            }
          });
      }, 50);
    }
  });

  /* ===== 工具栏事件（toolbar） ===== */
  table.on('toolbar(duchaTable)', function(obj) {
    var checkStatus = table.checkStatus(obj.config.id);
    switch (obj.event) {
      case 'add':
        layui.layer.open({
          title: '新增民意诉求人员',
          type: 2,
          content: locat + '/ducha/getDuchaAdd.do?menuid=' + '${param.menuid}'
                   + '&buttons=' + encodeURIComponent('${param.buttons}'),
          area: ['1100px', '780px'],
          maxmin: true,
          end: function() {
            layui.table.reload('duchaTable', {});
          }
        });
        break;
      case 'update':
        var datas = checkStatus.data;
        if (datas && datas.length > 0) {
          openUpdate(datas[0].id);
        } else {
          layer.alert("请先选择要修改的记录！");
        }
        break;
      case 'export':
        layui.layer.open({
          title: '民意诉求人员信息导出',
          type: 2,
          content: locat + '/jsp/personel/ducha/export.jsp?menuid=' + '${param.menuid}'
                   + '&personlabelid=${param.personlabelid}',
          area: ['1000px', '600px'],
          maxmin: true
        });
        break;
    }
  });

  /* ===== 行按钮事件 ===== */
  table.on('tool(duchaTable)', function(obj) {
    var data = obj.data;
    switch (obj.event) {
      case 'showinfo':
        openShowinfo(data.id);
        break;
      case 'update':
        openUpdate(data.id);
        break;
    }
  });

  /* ===== 搜索按钮 ===== */
  $("#search").click(function() {
    table.reload('duchaTable', {
      where: {
        cardnumber:       $("#cardnumber").val(),
        personname:       $("#personname").val(),
        homeplace:        $("#homeplace").val(),
        unitname1:        $("input[name='jurisdictunit1']").val(),
        policename1:      $("#jurisdictpolice1").val(),
        jointcontrollevel: $("#jointcontrollevel").val(),
        personnelLevel:   $("#personnelLevel").val(),
        attributelabels:  $("input[name='attributelabels']").val()
      },
      page: { curr: 1 }
    });
  });

  /* ===== 重置按钮 ===== */
  $("#reset").click(function() {
    $('form')[0].reset();
    table.reload('duchaTable', { where: {}, page: { curr: 1 } });
  });

}); // end layui.use

/* ===== 打开详情页 ===== */
function openShowinfo(id) {
  var index = layui.layer.open({
    title: '民意诉求人员详情',
    type: 2,
    content: locat + '/ducha/getDuchaShowinfo.do?personnelid=' + id
             + '&menuid=' + '${param.menuid}'
             + '&buttons=' + encodeURIComponent('${param.buttons}'),
    area: ['1000px', '750px'],
    maxmin: true,
    cancel: function() {
      layui.table.reload('duchaTable', {});
    }
  });
  layui.layer.full(index);
}

/* ===== 打开修改页 ===== */
function openUpdate(id) {
  var index = layui.layer.open({
    title: '修改民意诉求人员信息',
    type: 2,
    content: locat + '/ducha/getDuchaUpdate.do?personnelid=' + id
             + '&menuid=' + '${param.menuid}'
             + '&buttons=' + encodeURIComponent('${param.buttons}'),
    area: ['1100px', '780px'],
    maxmin: true,
    cancel: function() {
      layui.table.reload('duchaTable', {});
    }
  });
  layui.layer.full(index);
}
</script>

</body>
</html>

