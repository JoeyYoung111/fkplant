var curPath=window.document.location.href;//获得当前网址
var pathname=window.document.location.pathname;//获得主机地址之后目录
var pos=curPath.indexOf(pathname);//
var localhostpath=curPath.substring(0,pos);//获得主机地址
var PorjectName=pathname.substring(0,pathname.substr(1).indexOf('/')+1);//获得项目名称，自带/
var path=localhostpath+PorjectName;
 /** 不可删除**/
 function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }

    function responseHandler(res) {
        $.each(res.rows, function (i, row) {
            row.state = $.inArray(row.id, selections) !== -1;
        });
        return res;
    }
   $('#myModal').on('hide.bs.modal', function () {
    $("#table").bootstrapTable('refresh');
    $(this).removeData("bs.modal");
	});	
    function getHeight() {
    	
        return $(window).height() -100;
    }
	function showPopover(target, msg){
	target.attr("data-original-title", msg);
	$('[data-toggle="tooltip"]').tooltip();
	target.tooltip('show');
	target.focus();
	var id = setTimeout(
	function () {
	target.attr("data-original-title", "");
	target.tooltip('hide');
	}, 2000
	);
	}
    $(function () {
     initTable();
     
    });
    
  


    