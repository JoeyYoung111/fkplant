var pathName=window.document.location.pathname;
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
var protocol = location.protocol;
var hostname = location.hostname;    
var port = location.port; 
var locat = protocol + "//" + hostname + ":" + port + projectName;
console.log(locat);
             //关联信息  更多事件
              function  openRelation(flag,personnelid,buttons){
				  console.log('openRelation',flag);
				  if(flag=='controlemergency'){
					  var index = layui.layer.open({
						  title : "应急预案列表",
						  type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						  content :locat+"/jsp/personel/controlfiles/list.jsp?personnelid="+personnelid+"&buttons="+buttons+"&type=2",
						  area: ['1400px', '800px'],
						  offset: ['30px', '30px'],
						  success: function(layero, index){
						  },
						  cancel: function (index, layero) {//取消事件

						  }
					  })
					  // layui.layer.full(index);
				  }else if(flag=='controlplan'){
					  var index = layui.layer.open({
						  title : "管控方案列表",
						  type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						  content :locat+"/jsp/personel/controlfiles/list.jsp?personnelid="+personnelid+"&buttons="+buttons+"&type=1",
						  area: ['1400px', '800px'],
						  offset: ['30px', '30px'],
						  success: function(layero, index){
						  },
						  cancel: function (index, layero) {//取消事件

						  }
					  })
					  // layui.layer.full(index);
				  }else if(flag=='controlpower'){
					  var index = layui.layer.open({
						  title : "管控力量列表",
						  type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						  content :locat+"/jsp/personel/controlpower/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						  area: ['1400px', '800px'],
						  offset: ['30px', '30px'],
						  success: function(layero, index){
						  },
						  cancel: function (index, layero) {//取消事件

						  }
					  })
					  // layui.layer.full(index);
				  }else if(flag=='bankaccount'){
                      var index = layui.layer.open({
						title : "银行账号",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationbank/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getbankaccount.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#bankaccount").val(str.msg);
									}
								});
					      }
					})
					layui.layer.full(index);		
                   }else if(flag=='telnumber'){
                    var index = layui.layer.open({
						title : "手机号码",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationtelnumber/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/gettelnumber.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#telnumber").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='telephone'){
                      var index = layui.layer.open({
						title : "使用手机",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationphone/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/gettelbrand.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#telephone").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedwifi'){
                     var index = layui.layer.open({
						title : "关联WIFI",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationwifi/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getssid.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedwifi").val(str.msg);
									}
								});
					      }
					})		
					layui.layer.full(index);		
                   }else if(flag=='relatedvehicle'){
                    var index = layui.layer.open({
						title : "交通工具",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationvehicle/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getvehicletype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedvehicle").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='netidentity'){
                   var index = layui.layer.open({
						title : "虚拟身份信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationidentity/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getidentitytype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#netidentity").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='netpayment'){
                  var index = layui.layer.open({
						title : "网络支付",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationpayment/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getpaymentname.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#netpayment").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedhouse'){
                  var index = layui.layer.open({
						title : "房产信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationhouse/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/gethousetype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedhouse").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedlegal'){
                   var index = layui.layer.open({
						title : "法人组织",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationlegal/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getlegalname.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedlegal").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relateddriver'){
                    var index = layui.layer.open({
						title : "驾驶证件",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationdriver/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getdrivertype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relateddriver").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedpassport'){
                	var index = layui.layer.open({
						title : "护照信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/relation/relationpassport/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getpassporttype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedpassport").val(str.msg);
									}
								});
					      }
					})
					layui.layer.full(index);				
                   }
             }
             
             
                 //社会关系 列表显示
                 function  openSocialRelations(personnelid){
                   layui.table.render({
					    elem: '#socialrelationsTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchsocialrelations.do?personnelid="+personnelid,
					    method:'post',
					    toolbar: '#socialrelationstoolbar',
					    cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'relationtype', title: '关系类别', width:120,align:"center",templet: function (item) {
								   return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoSocialrelations("+item.id+");'><font color='blue'>"+item.relationtype+"</font></span>";
		                    }},
					        {field:'appellation', title: '关系称谓', width:120,align:"center",templet: function (item) {
							       return "<span>"+item.appellation+(item.appellation=="其他"?("("+item.memo+")"):"")+"</span>";
		                    }},
					        {field:'personname', title: '姓名',width:120,align:"center",templet: function (item) {							        
					        	   if (item.riskpersonnel=="1") {
							             return "<span><a href='javascript:showinfo(&apos;"+item.cardnumber+"&apos;,"+item.riskpersonnel+");' style='text-decoration:underline;color:blue;' ><font color='red'>"+item.personname+"</font></a></span>";
							       }else{
							           return "<span><a href='javascript:showinfo(&apos;"+item.cardnumber+"&apos;,"+item.riskpersonnel+");' style='text-decoration:underline;color:blue;' ><font color='blue'>"+item.personname+"</font></a></span>";
							       }
		                    }}, 
		                    {field:'homeplace', title: '现居住地',align:"center"} ,
					        {field:'telnumber1', title: '联系电话',width:120,align:"center"} 
//					        {field: 'right', title: '操作', toolbar: '#socialrelationsbar',width:50,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
					    });
                 }
            
   layui.use(['table', 'form'], function() {
     var table = layui.table;
     var	form = layui.form;
     var menuid=$("#menuid").val();
     var personnelid=$("#id").val();
        //监听社会关系   头部按钮  添加、修改、删除
		  table.on('toolbar(socialrelationsTable)', function(obj){
		  var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增社会关系",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/socialrelations/add.jsp?menuid="+menuid+"&personnelid="+personnelid,
						area: ['800', '600px'],
						maxmin: true,
						success : function(layero, index){
						},
						cancel: function (index, layero) {//取消事件
						       //  alert(1);
						    //  element.tabChange('dev_tab', "six");
						}
					})		
				  layui.layer.full(index);
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改社会关系",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content :locat+"/getsocialrelationsbyid.do?id="+id+"&menuid="+menuid+'&page=update',
							area: ['800', '600px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
						layui.layer.full(index);
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelsocialrelations.do?id="+id+'&menuid='+menuid,{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('socialrelationsTable', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
	         }
		});		
		//监听社会关系   详情按钮
	  table.on('tool(socialrelationsTable)', function(obj){
		  var id = obj.data.id;
		  if(obj.event === 'showinfo'){
		   		var index = layui.layer.open({
					title : "社会关系详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getsocialrelationsbyid.do?id='+id+'&menuid='+menuid+'&page=showinfo',
					area: ['800', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})			
			layui.layer.full(index);	
		    }
    	});
    	   //关联信息  保存
    		form.on('submit(relationSub)', function(data){
    		alert(locat+'/addrelation.do?personnelid='+$("#id").val()+'&menuid='+$("#menuid").val());
		     $("#formRelation").ajaxSubmit({
	              	url :     locat+'/addrelation.do?personnelid='+$("#id").val()+'&menuid='+$("#menuid").val(),
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(obj.msg);
	                     		//top.layer.close(index);
				        		//layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		//parent.location.reload();
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
   			function showinfoSocialrelations(id){
			   		var menuid=$("#menuid").val();
			   		var index = layui.layer.open({
						title : "社会关系详情",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getsocialrelationsbyid.do?id='+id+'&menuid='+menuid+'&page=showinfo',
						area: ['800', '600px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					})			
				layui.layer.full(index);	
	    	}
   	/**
			 * 图片按宽高比例进行自动缩放
			 * @param ImgObj
			 * 缩放图片源对象
			 * @param maxWidth
			 * 允许缩放的最大宽度
			 * @param maxHeight
			 * 允许缩放的最大高度
			 * @usage 
			 * 调用：<img src="图片" onload="javascript:DrawImage(this,100,100)">
			 */
			function DrawImage(ImgObj, maxWidth, maxHeight){
				var image = new Image();
				//原图片原始地址（用于获取原图片的真实宽高，当<img>标签指定了宽、高时不受影响）
				image.src = ImgObj.src;
				// 用于设定图片的宽度和高度
				var tempWidth;
				var tempHeight;
			
				if(image.width > 0 && image.height > 0){
					//原图片宽高比例 大于 指定的宽高比例，这就说明了原图片的宽度必然 > 高度
					if (image.width/image.height >= maxWidth/maxHeight) {
						if (image.width > maxWidth) {
							tempWidth = maxWidth;
							// 按原图片的比例进行缩放
							tempHeight = (image.height * maxWidth) / image.width;
						} else {
							// 按原图片的大小进行缩放
							tempWidth = image.width;
							tempHeight = image.height;
						}
					} else {// 原图片的高度必然 > 宽度
						if (image.height > maxHeight) { 
							tempHeight = maxHeight;
							// 按原图片的比例进行缩放
							tempWidth = (image.width * maxHeight) / image.height; 
						} else {
							// 按原图片的大小进行缩放
							tempWidth = image.width;
							tempHeight = image.height;
						}
					}
					// 设置页面图片的宽和高
					ImgObj.height = tempHeight;
					ImgObj.width = tempWidth;
					// 提示图片的原来大小
					ImgObj.alt = image.width + "×" + image.height;
				}
			}
			   //打开图片编辑上传页面
				function openPhotos(){
				 var menuid=$("#menuid").val();
                 var personnelid=$("#id").val();
				var index = layui.layer.open({
					title : "编辑风险人员照片",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/jsp/personel/wen/photo.jsp?personnelid='+personnelid+'&menuid='+menuid,
					area: ['700', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})		
			  	layui.layer.full(index);
			}
			    //打开头像图片浏览页面
				function openPhotosInfo(personnelid){
				 var menuid=$("#menuid").val();
                var index = layui.layer.open({
					title : "查看风险人员照片",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/jsp/personel/wen/photoInfo.jsp?personnelid='+personnelid+'&menuid='+menuid,
					area: ['700', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})		
			  	layui.layer.full(index);
			}
			//读取默认图片
			function getDefaultPhoto(){
		      var personnelid=$("#id").val();
				$.ajax({
					type:		'POST',
					url :       locat+'/getPersonnelPhotoFlowList.do?personnelid='+personnelid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var defaultid=0;
						if(data.count>0){
							$.each(data.photos, function(i) {
								if(this.defaultflag==1){
									defaultid=this.id;
									if(this.validflag>1)$('#defaultPhoto').attr('src','../uploadFiles/'+this.fileallName);
									else $('#defaultPhoto').attr('src','../uploadFiles/pictures/'+this.fileallName);
									return false;
								}
							});
						}
						if(defaultid==0){
							$('#defaultPhoto').attr('src',locat+'/images/nophoto.png');
						}
						$('#defaultPhoto').attr('onload',"javascript:DrawImage(this,110,150)");
					}
				});
			}
   	     //社会关系  姓名超链接打卡页面      
         function showinfo(cardnumber,riskpersonnel){
           var index= layui.layer.open({
				title : "详情信息",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getsocialrelationsbycardnumber.do?cardnumber='+cardnumber+"&riskpersonnel="+riskpersonnel,
				area: ['800', '700px'],
				maxmin: true,
				success : function(layero, index){
				}
			})	
			layui.layer.full(index);		    
         } 
         
                //轨迹信息 列表显示
                 function  openTrajectoryRecord(personnelid){
                
                   layui.table.render({
					    elem: '#trajectoryTable1',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchtrajectoryrecord.do?personnelid="+personnelid,
					    method:'post',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'tracktype', title: '轨迹类型',align:"center"} ,
					        {field:'phonenumber', title: '感知目标要素', width:150,align:"center"},
					        {field:'perceivedtime', title: '感知时间', width:150,align:"center"},
					        {field:'location', title: '位置',align:"center"} ,
					        {field:'pushtime', title: '推送时间',align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }       
                 
                 //轨迹信息 卡口查询
                 function openTrajectoryKK(personcard_number,data_origin_selected){
                      if(data_origin_selected==""){
	                      $.ajax({
								type:		'POST',
								url:		locat+"/gettrajectoryKKtypesToJSON.do",
								dataType:	'json',
								async:      false,
								success:	function(data){
									var options = '<option value="">轨迹类型: 全部</option>'+fillOption(data);
									$("#trajectoryTableTypes").html(options);
									layui.form.render();
								}
							});
                      }
                      layui.table.render({
                 		elem:	'#trajectoryTable',
                 		toolbar:true,
                 		url:	locat+"/searchAlltrajectoryKK.do?personcard_number="+personcard_number+"&data_origin="+data_origin_selected,
                 		method:	'post',
                 		toolbar: '#trajectoryTableToolbar',
                 		cols:[[
                 			{field:'data_origin',title:'感知ID',align:"center",templet: function (item) {
                 				var data_origin=item.data_origin;
                 				switch(data_origin){
                 					case "人脸轨迹":
                 						data_origin="人脸";
                 						break;
                 					case "电子围栏":
                 						data_origin="手机："+(item.telephone_number!=null?item.telephone_number:"");
                 						break;
                 					case "网吧记录":
                 						data_origin="身份证："+(item.personcard_number!=null?item.personcard_number:"");
                 						break;
                 					case "车辆数据":
                 						data_origin="车辆："+(item.vehicle_number!=null?item.vehicle_number:"");
                 						break;
                 					
                 				}
                 				return "<span>"+data_origin+"</span>";
                 			}},
                 			{field:'appear_time',title:'感知时间',align:"center"},
                 			{field:'appear_address', title: '感知地点',align:"center",templet: function (item) {
                 				var appear_address=item.appear_address;
                 				switch(item.data_origin){
                 					case "人脸轨迹":
                 						appear_address+="";
                 						break;
                 					case "电子围栏":
                 						appear_address+=((item.longitude!=null&&item.longitude!="")?("(经度:"+item.longitude+((item.latitude!=null&&item.latitude!="")?("，纬度:"+item.latitude+")"):"")):"");
                 						break;
                 					case "网吧记录":
                 						appear_address+="";
                 						break;
                 					case "车辆数据":
                 						appear_address+=((item.kakou_point!=null&&item.kakou_point!="")?("(卡口点位:"+item.kakou_point+")"):"");
                 						break;
                 					
                 				}
                 				return "<span>"+appear_address+"</span>";
                 			}} ,
					        {field:'insert_time', title: '推送时间',align:"center"}
                 		]],
                 		page:	true,
                 		limit:	10,
                 		done: function(){
                 			layui.form.on('select(trajectoryTableTypes)', function(data){
							  openTrajectoryKK(personcard_number,data.value);
						  });
                 		}
                 	});
             }
                 
                 //涉警信息 列表显示
                 function  openjqxx(sfzh){
                    layui.table.render({
					    elem: '#jqxxTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchXdJqxx.do?sfzh="+sfzh,
					    method:'post',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'jjrqsj', title: '接警时间',width:180,align:"center"} ,
					        {field:'bjnr', title: '报警内容', width:150,align:"center"},
					        {field:'bjlx', title: '报警类型', width:150,align:"center"},
					        {field:'sfdd', title: '事发地点',width:150,align:"center"} ,
					        {field:'cljgnr', title: '处理结果内容',width:150,align:"center"} ,
					        {field:'cjdwmc', title: '处警单位名称',width:150,align:"center"} 
					    ]],
					    page: true,
					    limit: 10
					    });
                 } 
                 
                 
                  //涉案信息 列表显示
                 function  openajxx(sfzh){
                    layui.table.render({
					    elem: '#ajxxTable',
					    toolbar: true,
					    defaultToolbar: ['filter', 'exports', 'print'],
					    url :   locat+"/searchXdAjxx.do?sfzh="+sfzh,
					    method:'post',
					   cols: [[
					        {field:'id',type:'radio',fixed:'true',align:"center"},
					        {field:'jjbh', title: '案件编号',width:180,align:"center"} ,
					        {field:'slsj', title: '受理时间',width:180,align:"center"} ,
					        {field:'ajlb', title: '案件类别', width:150,align:"center"},
					        {field:'ajmc', title: '案件名称', width:150,align:"center"},
					        {field:'sldwmc', title: '受理单位',width:150,align:"center"} ,
					        {field:'jyaq', title: '简要案情',width:150,align:"center"}
					    ]],
					    page: true,
					    limit: 10
					    });
                 }       
          //标签维护记录       
          function applyTable(personnelid){
          
           layui.table.render({
				    elem: '#applyTable',
				    toolbar: false,
				   	defaultToolbar: ['filter', 'print'],
				    url :   locat+"/searchApplylabel.do?personnelid="+personnelid+"&examineflag=-1",
				    limit:5,
				    method:'post',
				    cols: [[
				    	{field:'applylabel1name', title: '申请标签1级', width:200,align:"center"} ,
				    	{field:'applylabel2name', title: '申请标签子级',align:"center"} ,
				    	{field:'addtime', title: '申请时间', width:200,align:"center"} ,
				    	{field:'examineflag', title: '审核标记', width:150,align:"center",templet: function (item) {
				    		if(item.examineflag==0){
				    			return "未审核";
				    		}else if(item.examineflag==1){
				    			return "审核通过";
				    		}else if(item.examineflag==2){
				    			return "审核不通过";
				    		}
				    	}}
				    ]],
				    page: true
				  });
          
          }        
          //人员标签信息       
         function addLabels(zslabel1,zslabel2,lslabel1,lslabel2,personnelid){
             var str1="",str2="";
          		if(zslabel1!=null&&zslabel1!=""){
	               		var zslabel1s=zslabel1.split(",");
	               		for(var i=0;i<zslabel1s.length;i++){
		               		if(zslabel1s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url :   locat+"/getAttributeLabelByLabelid.do",
									data:		{
													id: zslabel1s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										//str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;padding-left:10px;">'+data.attributelabel+'</span>';
										if(data&&data!=null&&data!=""){
											if(zslabel1s[i]==3){
												$.ajax({
													type:		'POST',
													url:		locat+"/getHeiEditorByPersonnelid.do?personnelid="+personnelid,
													dataType:	'json',
													async:      false,
													success:	function(heidata){
														if(heidata&&heidata!=null&&heidata!=""){
															if(heidata.filterflag)str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;padding-left:10px;">'+data.attributelabel+'</span>';
														}
													}
												});
											}else str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;padding-left:10px;">'+data.attributelabel+'</span>';
										}
									}
								});
		               		}
	               		}
	               }
	               if(lslabel1!=null&&lslabel1!=""){
	               		var lslabel1s=lslabel1.split(",");
	               		for(var i=0;i<lslabel1s.length;i++){
		               		if(lslabel1s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url :   locat+"/getAttributeLabelByLabelid.do",
									data:		{
													id: lslabel1s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										//str1+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;padding-left:10px;">'+data.attributelabel+'</span>';
										if(data&&data!=null&&data!=""){
											if(lslabel1s[i]==3){
												$.ajax({
													type:		'POST',
													url:		locat+"/getHeiEditorByPersonnelid.do?personnelid="+personnelid,
													dataType:	'json',
													async:      false,
													success:	function(heidata){
														if(heidata&&heidata!=null&&heidata!=""){
															if(heidata.filterflag)str1+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;padding-left:10px;">'+data.attributelabel+'</span>';
														}
													}
												});
											}else str1+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;padding-left:10px;">'+data.attributelabel+'</span>';
										}
									}
								});
		               		}
	               		}
	               }
					if(zslabel2!=null&&zslabel2!=""){
	               		var zslabel2s=zslabel2.split(",");
	               		for(var i=0;i<zslabel2s.length;i++){
	               			if(zslabel2s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url :   locat+"/getAttributeLabelByLabelid.do",
									data:		{
													id: zslabel2s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										str2+='<span class="my-tag-item3" style="background-color:#5FB878;color:white;border: 1px border #5FB878;padding-left:10px;">'+data.attributelabel+'</span>';
									}
								});
	               			}
	               		}
	               }
					if(lslabel2!=null&&lslabel2!=""){
	               		var lslabel2s=lslabel2.split(",");
	               		for(var i=0;i<lslabel2s.length;i++){
		               		if(lslabel2s[i]!=""){
			               		$.ajax({
									type:		'POST',
									url :   locat+"/getAttributeLabelByLabelid.do",
									data:		{
													id: lslabel2s[i]
												},
									dataType:	'json',
									async:      false,
									success:	function(data){
										str2+='<span class="my-tag-item3" style="color:red;border: 1px dashed #F70909;background-color:#E9E8E2;padding-left:10px;">'+data.attributelabel+'</span>';
									}
								});
		               		}
	               		}
	               }
	               
	               $("#zslabels1").html(str1);
	               $("#zslabels2").html(str2);
	              // layui.form.render();
          }
          
          
			//政法委关联信息  更多事件
			function  openRelation_zfw(flag,personnelid,buttons){
                     if(flag=='bankaccount'){
                      var index = layui.layer.open({
						title : "银行账号",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationbank/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getbankaccount.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#bankaccount").val(str.msg);
									}
								});
					      }
					})
					layui.layer.full(index);		
                   }else if(flag=='telnumber'){
                    var index = layui.layer.open({
						title : "手机号码",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationtelnumber/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/gettelnumber.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#telnumber").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='telephone'){
                      var index = layui.layer.open({
						title : "使用手机",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationphone/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/gettelbrand.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#telephone").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedwifi'){
                     var index = layui.layer.open({
						title : "关联WIFI",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationwifi/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getssid.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedwifi").val(str.msg);
									}
								});
					      }
					})		
					layui.layer.full(index);		
                   }else if(flag=='relatedvehicle'){
                    var index = layui.layer.open({
						title : "交通工具",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationvehicle/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getvehicletype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedvehicle").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='netidentity'){
                   var index = layui.layer.open({
						title : "虚拟身份信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationidentity/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getidentitytype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#netidentity").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='netpayment'){
                  var index = layui.layer.open({
						title : "网络支付",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationpayment/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getpaymentname.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#netpayment").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedhouse'){
                  var index = layui.layer.open({
						title : "房产信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationhouse/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/gethousetype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedhouse").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedlegal'){
                   var index = layui.layer.open({
						title : "法人组织",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationlegal/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getlegalname.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedlegal").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relateddriver'){
                    var index = layui.layer.open({
						title : "驾驶证件",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationdriver/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getdrivertype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relateddriver").val(str.msg);
									}
								});
					      }
					})	
					layui.layer.full(index);			
                   }else if(flag=='relatedpassport'){
                	var index = layui.layer.open({
						title : "护照信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content :locat+"/jsp/personel/zfw_relation/relationpassport/list.jsp?personnelid="+personnelid+"&buttons="+buttons,
						area: ['1400px', '800px'],
						maxmin: true,
						success : function(layero, index){
                        },
						cancel: function (index, layero) {//取消事件
					      $.ajax({
									type:		'POST',
									url:		locat+"/getpassporttype.do?personnelid="+personnelid,
									dataType:	'json',
									async:		false,
									success:	function(data){
									     var str = eval('(' + data + ')');
					      	             $("#relatedpassport").val(str.msg);
									}
								});
					      }
					})
					layui.layer.full(index);				
                   }
             }
                            
    