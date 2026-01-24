<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>关系拓扑图</title>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/echarts.min.js"/>"></script>
  </head>
<body>
<div id="charts" style="height: 100%;"></div>
<script>
	$(document).ready(function(){
		var personList = ${personList};
		var contradictionInfoList = ${contradictionInfoList};
		var fxsjpersons = "";
		var datas = [{
			name:"社会关系",
			id:"-1",
			expand:"false",
			label: {
                  normal: {
                        show: true,
                        position: 'bottom',
                        fontSize: '12'
                 }
            },
	        symbol:'circle',
	        symbolSize: [40, 40]
		},{
			name:"风险事件",
			id:"-2",
			expand:"false",
			label: {
                  normal: {
                        show: true,
                        position: 'bottom',
                        fontSize: '12'
                 }
            },
	        symbol:'circle',
	        symbolSize: [40, 40]
		}];
		var linkmes = [{
			source:"shgx0",
         	target: "-1",
         	value:""
		},{
			source:"shgx0",
         	target: "-2",
         	value:""
		}];
		//加入社会关系节点
		for(var i=0;i<personList.length;i++){
			if(fxsjpersons.indexOf(personList[i].cardnumber+",")<0){
				fxsjpersons += personList[i].cardnumber+",";
			}
			var symbol='';
			var expand='false';
			if(personList[i].fileallName==""){
				if(personList[i].riskpersonnel==1){
					symbol = 'image://images/photo2.png';
				}else{
					symbol = 'image://images/photo1.png';
				}
			}else{
				if(personList[i].validflag>1){
					symbol = 'image://../uploadFiles/'+personList[i].fileallName;
				}else{
					symbol = 'image://../uploadFiles/pictures/'+personList[i].fileallName;
				}
			}
			if(i>0&&personList[i].riskpersonnel==1){
				expand='true';
			}
			datas.push({
				name:personList[i].personname,
				id:"shgx"+personList[i].relationid,
				personid:""+personList[i].id,
				expand:expand,
				label: {
	                    normal: {
	                          show: true,
	                          position: 'bottom',
	                          fontSize: '12'
	                   }
	              },
	            symbol:symbol,
	            symbolSize: [40, 40]
            });
            if(i>0){
            	linkmes.push({
            		source:"-1",
            		target: "shgx"+personList[i].relationid,
            		value:personList[i].appellation
            	});
            }
		}
		
		//加入风险事件节点
		for(var i=0;i<contradictionInfoList.length;i++){
			datas.push({
				name:contradictionInfoList[i].cdtname,
				id:"fxsj"+contradictionInfoList[i].id,
				cdtid:contradictionInfoList[i].id,
				expand:"true",
				label: {
	                    normal: {
	                          show: true,
	                          position: 'bottom',
	                          fontSize: '12'
	                   }
	              },
	            symbol:'image://images/event.png',
	            symbolSize: [40, 40]
            });
            
            linkmes.push({
           		source:"-2",
           		target: "fxsj"+contradictionInfoList[i].id,
           		value:""
           	});
		}
		
		var myChart = echarts.init(document.getElementById("charts"));
		//配置图标属性
		option = {
            animationDurationUpdate: 1500,
            animationEasingUpdate: 'quinticInOut',
            color: ['#83e0ff', '#45f5ce', '#b158ff'],
            series: [{
                type: 'graph',
                layout: 'force',
				edgeSymbol : ['circle', 'arrow'],//边两端的标记类型，可以是一个数组分别指定两端，也可以是单个统一指定。默认不显示标记，常见的可以设置为箭头，如下：edgeSymbol: ['circle', 'arrow']
 				edgeSymbolSize : [0,10],//边两端的标记大小，可以是一个数组分别指定两端，也可以是单个统一指定。
 				edgeLabel: {
					normal: {
						show: true,
						textStyle: {
							fontSize: 10
						},
						formatter: "{c}"
					}
				},
                force: {
                    repulsion: 1000,
                    edgeLength: 100
                },
                roam: true,
                label: {
                    normal: {
                        show: true
                    }
                },
                data: datas,
                links: linkmes,
                lineStyle: {
                    color:'#000000',
                    width:2
                }
            }]
        }

		if (option && typeof option === 'object') {
		    myChart.setOption(option);
		}
		
		//点击事件
		myChart.on('click', function (params) {
			//是否是节点且能展开
		    if (params.dataType == "node"&&params.data.expand == "true") {
		    	//找出当前选中节点改为无法展开
		    	for(var i=0;i<datas.length;i++){
		    		if(datas[i].id==params.data.id){
		    			console.log(params.data.id+params.data.name);
		    			datas[i].expand="false";
		    		}
		    	}
		    	if(params.data.id.indexOf("shgx")>-1){
		    		//查找拓展节点
			    	$.ajax({
						type:		'POST',
						url:		'<c:url value="/expandRelationchart.do"/>',
						data:		{personnelid:params.data.personid,cardnumber:fxsjpersons.substr(0,fxsjpersons.length-1)},
						dataType:	'json',
						success:	function(data){
							if(data.data.length>1){
								for(var i=0;i<data.data.length;i++){
									if(fxsjpersons.indexOf(data.data[i].cardnumber+",")<0){
										fxsjpersons += data.data[i].cardnumber+",";
									}
									var symbol='';
									var expand='false';
									console.log(data.data[i].personname);
									if(data.data[i].fileallName==""||data.data[i].fileallName==null){
										if(data.data[i].riskpersonnel==1){
											symbol = 'image://images/photo2.png';
										}else{
											symbol = 'image://images/photo1.png';
										}
									}else{
										if(data.data[i].validflag>1){
											symbol = 'image://../uploadFiles/'+data.data[i].fileallName;
										}else{
											symbol = 'image://../uploadFiles/pictures/'+data.data[i].fileallName;
										}
									}
									if(data.data[i].riskpersonnel==1){
										expand='true';
									}
									datas.push({
										name:data.data[i].personname,
										id:"shgx"+data.data[i].relationid,
										personid:""+data.data[i].id,
										expand:expand,
										label: {
							                    normal: {
							                          show: true,
							                          position: 'bottom',
							                          fontSize: '12'
							                   }
							              },
							            symbol:symbol,
							            symbolSize: [40, 40],
						            });
						            
						            linkmes.push({
					            		source:params.data.id,
					            		target: "shgx"+data.data[i].relationid,
					            		value:data.data[i].appellation
					            	});
								}
							}
							option.series[0].data = datas;
							myChart.setOption(option);
						}
					});
		    	}else{
		    		//查找拓展节点
			    	$.ajax({
						type:		'POST',
						url:		'<c:url value="/expandFxsjPerson.do"/>',
						data:		{cdtid:params.data.cdtid},
						dataType:	'json',
						success:	function(data){
							for(var i=0;i<data.data.length;i++){
								var symbol='';
								if(data.data[i].fileallName==""||data.data[i].fileallName==null){
									symbol = 'image://images/photo1.png';
								}else{
									if(data.data[i].validflag>1){
										symbol = 'image://../uploadFiles/'+data.data[i].fileallName;
									}else{
										symbol = 'image://../uploadFiles/pictures/'+data.data[i].fileallName;
									}
								}
								
								datas.push({
									name:data.data[i].personname,
									id:"fxsj-"+params.data.id+"-"+data.data[i].id,
									expand:"false",
									label: {
						                    normal: {
						                          show: true,
						                          position: 'bottom',
						                          fontSize: '12'
						                   }
						              },
						            symbol:symbol,
						            symbolSize: [40, 40],
					            });
					            
					            linkmes.push({
				            		source:params.data.id,
				            		target: "fxsj-"+params.data.id+"-"+data.data[i].id,
				            		value:"主要组织人员"
				            	});
							}
							option.series[0].data = datas;
							myChart.setOption(option);
						}
					});
		    	}
		    }
		});
	});
</script>
</body>
</html>