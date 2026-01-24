//函数说明：合并指定表格（表格id为_w_table_id）指定列（列数为_w_table_colnum）的相同文本的相邻单元格
//参数说明：_w_table_id 为需要进行合并单元格的表格的id。如在HTMl中指定表格 id="data" ，此参数应为 #data
//参数说明：_w_table_colnum 为需要合并单元格的所在列。为数字，从最左边第一列为1开始算起。
function _w_table_rowspan(_w_table_id, _w_table_colnum) {
    var _w_table_firsttd = "";
    var _w_table_currenttd = "";
    var _w_table_SpanNum = 0;
    var _w_table_Obj = $(_w_table_id + " tr td:nth-child(" + _w_table_colnum + ")");
    _w_table_Obj.each(function(i) {
        if (i == 0) {
            _w_table_firsttd = $(this);
            _w_table_SpanNum = 1;
        } else {
            _w_table_currenttd = $(this);
            if(_w_table_firsttd.text()==""&&_w_table_currenttd.text()==""){
           
            }
            else{
           
            if (_w_table_firsttd.text() == _w_table_currenttd.text()) {
                _w_table_SpanNum++;
                _w_table_currenttd.hide(); //remove();
                _w_table_firsttd.attr("rowSpan", _w_table_SpanNum);
            } else {
                _w_table_firsttd = $(this);
                _w_table_SpanNum = 1;
            }
            }
        }
    });
}

//函数说明：合并指定表格（表格id为_w_table_id）指定列（列数为_w_table_colnum）的相同文本的相邻单元格
//参数说明：_w_table_id 为需要进行合并单元格的表格的id。如在HTMl中指定表格 id="data" ，此参数应为 #data
//参数说明：_w_table_colnum 为需要合并单元格的所在列。为数字，从最左边第一列为1开始算起。
function _w_table_rowspan1(_w_table_id, _w_table_colnum,_w_table_colnum2) {
    var _w_table_firsttd = "";
     var _w_table_firsttd2 = "";
    var _w_table_currenttd = "";
    var _w_table_currenttd2 = "";
    var _w_table_SpanNum = 0;
    var _w_table_Obj = $(_w_table_id + " tr td:nth-child(" + _w_table_colnum + ")");
    var _w_table_Obj1 = $(_w_table_id + " tr td:nth-child(" + _w_table_colnum2 + ")");
    _w_table_Obj.each(function(i) {
        var index=_w_table_Obj.index($(this));
       
        if (i == 0) {
            _w_table_firsttd = $(this);
             _w_table_firsttd2=$(_w_table_Obj1[index]);
            _w_table_SpanNum = 1;
        } else {
            _w_table_currenttd = $(this);
            _w_table_currenttd2 = $(_w_table_Obj1[index]);
            if(_w_table_firsttd.text()==""&&_w_table_currenttd.text()==""){
           
            }
            else{
           
            if (_w_table_firsttd.text() == _w_table_currenttd.text()) {
                _w_table_SpanNum++;
                _w_table_currenttd2.hide(); //remove();
                _w_table_firsttd2.attr("rowSpan", _w_table_SpanNum);
            } else {
                _w_table_firsttd = $(this);
                _w_table_firsttd2=$(_w_table_Obj1[index]);
                _w_table_SpanNum = 1;
            }
            }
        }
    });
}


//函数说明：鼠标移动时经过表格的tr时，经过的tr会有颜色的变化
//参数说明：tr 为需要进行颜色变换的tr。在需要变换颜色的tr调用函数的时候写_c_table_color(this)即变换颜色
function _c_table_color(tr){
	$(tr).addClass("changecolor");
	
}

//函数说明：鼠标移动时经过表格的tr时，经过的tr会有颜色的变化
//参数说明：tr 为需要进行颜色变换的tr。在需要变换颜色的tr调用函数的时候写_c_table_removecolor(this)即取消颜色
function _c_table_removecolor(tr){
	$(tr).removeClass("changecolor");
}

//函数说明：判断开始时间和结束时间是否合法，即开始时间不能大于结束时间，开始时间和结束时间都要是同样的时间精度
//参数说明：beginTime 开始时间，通过97Date传过来的参数
//参数说明：endTiem 结束时间，通过97Date传过来的参数
//返回值说明：0-开始时间大于结束时间（即非法），1-开始时间小于等于结束时间（即合法）
function judgeTime(beginTime,endTiem){
	var d1 = new Date(beginTime.replace(/\-/g,"\/"));
	var d2 = new Date(endTiem.replace(/\-/g,"\/"));
	if(d1 > d2){
		alert("开始时间不能大于结束时间！");
		return 0;
	}
	return 1;
}

//函数说明：用于限制textarea的文字内容长度
//参数说明:num 允许写入的字数
//参数说明:id 该textarea的ID
function limitTA(num,id){
	var text = document.getElementById(id).value;
	if(text.length >= num){
		text = text.substring(0,num-1);
		document.getElementById(id).value = text;
	}
}

//函数说明：用于将后台封装好的数据放到前台组装成select的option
//参数说明:data 异步请求回来的json数据
function fillOption(data) {
	var options = '';
	$.each(data.list, function(i, item) {
		$.each(item, function(i) {
			options += '<option value="' + this.value + '">' + this.text + '</option>';
		});
	});
	return options;
}

//函数说明：用于校验该数据格式是否符合身份证要求
//参数说明:card 该数据
function checkIdentity(card){
	var reg = /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;
	if(reg.test(card) == false){
		return false;
	}
	return true;
}


//函数说明：用于校验该数据格式是否符合手机要求
//参数说明:tel 该数据
function tele(tel){	      	
	if(!/^1[3578]{1}\d{9}/gi.test(tel)){
		return false;			
	}else{				
		return true;
	}
		return true;
}
//函数说明：用于校验该数据格式是否符合邮箱要求
//参数说明:cem 该数据
function checkEmail(cem){	      	
	if(!/^([0-9a-zA-Z_-])+@([a-z0-9A-Z_-])+((\.[a-z0-9A-Z_-]{2,3}){1,2})$/.test(cem)){
		return false;			
	}else{				
		return true;
	}
	return true;
}

//函数说明：用于校验该数据格式是否符合固定电话要求
//参数说明:guhua 该数据
function checkHousePhone(housePhone){
	var reg= /^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	if(reg.test(housePhone) == false){
		return false;
	}
	return true;
}

//函数说明：用于校验该数据格式是否符合传真要求
//参数说明:faxNum 该数据
function checkFaxNum(faxNum){
	var reg= /^(\d{3,4}-)?\d{7,8}$/;
	if(reg.test(faxNum) == false){
		return false;
	}
	return true;
}