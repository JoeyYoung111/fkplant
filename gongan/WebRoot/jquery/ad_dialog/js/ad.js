//不设置全局变量绑定在btn上会有问题
var isMax = true;
function miaovAddEvent(oEle, sEventName, fnHandler)
{
	if(oEle.attachEvent)
	{
		oEle.attachEvent('on'+sEventName, fnHandler);
	}
	else
	{
		oEle.addEventListener(sEventName, fnHandler, false);
	}
}

window.onload = function() {
    as_window_load();
};

function startMove(obj, iTarget, fnCallBackEnd)
{
	var oDiv = document.getElementById('miaov_float_layer');
	if(iTarget==0){
		var messageCount=0;
		if(oDiv.getElementsByTagName('tbody').length>0){
			messageCount = oDiv.getElementsByTagName('tbody')[0].childElementCount;
		}
    	if(messageCount>0){
    		oDiv.getElementsByTagName('h2')[0].style.backgroundImage="url(jquery/ad_dialog/images/title_bg_red.gif)";
    	}
	}else{
		oDiv.getElementsByTagName('h2')[0].style.backgroundImage="url(jquery/ad_dialog/images/title_bg.gif)";
	}
	if(obj.timer)
	{
		clearInterval(obj.timer);
	}
	obj.timer=setInterval
	(
		function ()
		{
			doMove(obj, iTarget, fnCallBackEnd);
		},30
	);
}

function doMove(obj, iTarget, fnCallBackEnd)
{
	var iSpeed=(iTarget-obj.offsetHeight)/8;
	if(iSpeed>-5){
		iSpeed=iTarget-obj.offsetHeight;
	}else{
		iSpeed=(iTarget-obj.offsetHeight)/8;
	}
	if(obj.offsetHeight==iTarget)
	{
		clearInterval(obj.timer);
		obj.timer=null;
		if(fnCallBackEnd)
		{
			fnCallBackEnd();
		}
	}
	else
	{
		iSpeed=iSpeed>0?Math.ceil(iSpeed):Math.floor(iSpeed);
		obj.style.height=obj.offsetHeight+iSpeed+'px';
		((window.navigator.userAgent.match(/MSIE 6/ig) && window.navigator.userAgent.match(/MSIE 6/ig).length==2)?repositionAbsolute:repositionFixed)()
	}
}

function repositionAbsolute()
{
	var oDiv=document.getElementById('miaov_float_layer');
	var left=document.body.scrollLeft||document.documentElement.scrollLeft;
	var top=document.body.scrollTop||document.documentElement.scrollTop;
	var width=document.documentElement.clientWidth;
	var height=document.documentElement.clientHeight;
	
	oDiv.style.left=left+width-oDiv.offsetWidth+'px';
	oDiv.style.top=top+height-oDiv.offsetHeight+'px';
}

function repositionFixed()
{
	var oDiv=document.getElementById('miaov_float_layer');
	var width=document.documentElement.clientWidth;
	var height=document.documentElement.clientHeight;
	
	oDiv.style.left=width-oDiv.offsetWidth+'px';
	oDiv.style.top=height-oDiv.offsetHeight+'px';
}

//重新显示弹窗内容
function add_context(str){
	document.getElementById("ad_context").innerHTML = str;
}

function open_window(){
	var oDiv = document.getElementById('miaov_float_layer');
	oDiv.style.display = 'block';
}
function as_window_load(){
	var oDiv = document.getElementById('miaov_float_layer');
    var oBtnMin = document.getElementById('btn_min');
    var oDivContent = oDiv.getElementsByTagName('div')[0];

	//如果不定死在刷新页面时候拿的最高高度就为0了
    var iMaxHeight = 400;

    var isIE6 = window.navigator.userAgent.match(/MSIE 6/ig) && !window.navigator.userAgent.match(/MSIE 7|8/ig);

    oDiv.style.display = 'block';
    //iMaxHeight = oDivContent.offsetHeight;

    if (isIE6) {
        oDiv.style.position = 'absolute';
        repositionAbsolute();
        miaovAddEvent(window, 'scroll', repositionAbsolute);
        miaovAddEvent(window, 'resize', repositionAbsolute);
    }
    else {
        oDiv.style.position = 'fixed';
        repositionFixed();
        miaovAddEvent(window, 'resize', repositionFixed);
    }

    oBtnMin.timer = null;
    oBtnMin.onclick = function() {
        startMove
		(
			oDivContent, (isMax=!isMax) ? iMaxHeight : 0,
			function() {
			    oBtnMin.className = oBtnMin.className == 'min' ? 'max' : 'min';
			}
		);
    };
}