function mqttServer(config){
	let defaultConfig = {
		mapKey: '', //用户id
		userId: '', //用户id
		appId: '', //应用id
		topic: '', //主题
		host: '', //主机地址
		port:6040,
		reconnect:3, //断线重新连接次数
		reconnectTime: 5000, //超时重新连接间隔
		messageArrivedCallBack: null,//接收消息的回调函数
		reconnectionSuccessCallBack: null,//重连成功回调
		connectionLostCallBack: null,//连接丢失回调
		socket:null
	}
	this.mqttConfig = extend(defaultConfig, config);
}

mqttServer.prototype._getMqttConfig = function () {
	return this.mqttConfig;
};

mqttServer.prototype._createMqttClient = function () {
    const config = this._getMqttConfig();
	// 校验参数
	const { userId, appId, topic, host, mapKey} = config
	var verifyResult = true
	if (!userId){
		console.error('创建客户端失败, userId为空');
		verifyResult = false
	}else if (!appId){
		console.error('创建客户端失败, appId为空');
		verifyResult = false
	}else if (!topic){
		console.error('创建客户端失败, topic为空');
		verifyResult = false
	}else if (!host){
		console.error('创建客户端失败, host为空');
		verifyResult = false
	}
	if (!verifyResult){
		return {}
	}
	
	const promise = new Promise((resolve, reject) => {
		const calllback = {
			onSuccess: res => {
				resolve(res);
			},
			onFailure: err => {
				reject(err);
			}
		}
		createClient(config, calllback, this)
	});
	
	return promise;
};

mqttServer.prototype._onMessage = function(callback){
	const config = this._getMqttConfig();
	config.messageArrivedCallBack = callback
}

mqttServer.prototype._onConnectionLost = function(callback){
	const config = this._getMqttConfig();
	config.connectionLostCallBack = callback
}

mqttServer.prototype._onReconnectionSuccess = function(callback){
	const config = this._getMqttConfig();
	config.reconnectionSuccessCallBack = callback
}
// 查询未读消息数量
mqttServer.prototype._unreadMessageCount = function () {
	const { host, port, userId, topic, appId } = this._getMqttConfig();
	return request()({
		baseURL:'http://'+host+':'+port,
		url: '/message/unread/count?userId='+userId+'&topic='+topic+'&appId='+appId,
		method: 'get'
	})
}

// 分页查询未读消息
mqttServer.prototype._unreadMessagePageList = function ({page, size}) {
	const { host, port, userId, topic, appId } = this._getMqttConfig();
	return request()({
		baseURL:'http://'+host+':'+port,
		url: '/message/unread/page-list?userId='+userId+'&topic='+topic+'&appId='+appId,
		method: 'post',
		data:JSON.stringify({
			pageSize:size,
			currentPage:page
		})
	})
}
// 设置消息已读
mqttServer.prototype._setMessageRead = function (messageId) {
	const { host, port, appId, userId } = this._getMqttConfig();
	return request()({
		baseURL:'http://'+host+':'+port,
		url: '/message/setRead/'+messageId+'?appId='+appId+'&userId='+userId,
		method: 'get'
	})
}
mqttServer.prototype._setMessageReads = function (ids) {
	const { host, port, appId, userId } = this._getMqttConfig();
	return request()({
		baseURL:'http://'+host+':'+port,
		url: '/message/setRead/'+'?appId='+appId+'&userId='+userId,
		method: 'post',
		data:ids
	})
}
var lockReconnect = false //避免重复连接
var timeoutFlag = true
var timeoutSet = null
var reconnectNum = 0

function createClient(config, callback, _this){
	const { messageArrivedCallBack, connectionLostCallBack, reconnectionSuccessCallBack } = config
	const { userId, appId, topic, host, port,mapKey } = config
	//实现化WebSocket对象，指定要连接的服务器地址与端口  建立连接
	var socketUrl = "ws://"+host+":"+port+"/imserver/"+appId+"/"+topic+"/"+userId+"/"+mapKey;
	//var socketUrl = "ws://"+host+":"+port+"/imserver/"+appId+"/"+topic+"/"+userId;
	if(config.socket!=null){
		config.socket.close();
		config.socket=null;
	}
	try{
		const socket = new WebSocket(socketUrl);
	
		//打开事件
		socket.onopen = function() {
			reconnectNum = 0;
			timeoutFlag = false;
			clearTimeout(timeoutSet);
			heartCheck.reset().start(config);
			if(!lockReconnect){
				socket.send(JSON.stringify({
					topics:[topic]
				}))
				callback.onSuccess("连接成功")
			}else{
				if(config.reconnectionSuccessCallBack != null){
					config.reconnectionSuccessCallBack(200)
				}
			}
			lockReconnect = false
		};
		//获得消息事件
		socket.onmessage = function(response) {
			var result = response.data;
			if(result == 'HeartBeat')return;
            var data = JSON.parse(result);
			if(data.status == -1){
				console.error(data.errorMsg)
			}else{
				if(config.messageArrivedCallBack != null){
					config.messageArrivedCallBack(data)
				}
			}
		};
		//关闭事件
		socket.onclose = function(e) {
			if (e.code !== 1000) {
				timeoutFlag = false;
				clearTimeout(timeoutSet);
				reconnect(config);
				if(config.connectionLostCallBack != null){
					config.connectionLostCallBack(e)
				}
			} else {
				clearInterval(heartCheck.timeoutObj);
				clearTimeout(heartCheck.serverTimeoutObj);
			}
		};
		//发生了错误事件
		socket.onerror = function(err) {
			reconnect(config) //重连
			if(callback){
				callback.onFailure("连接失败")
			}
			if(config.connectionLostCallBack != null){
				config.connectionLostCallBack(err)
			}
		}
		config.socket = socket
	}catch(err){
		console.log(err);
		reconnect(config)
	}
}
	
//心跳检测
var heartCheck = {
	timeoutObj: null,
	serverTimeoutObj: null,
	reset: function() {
	  clearInterval(this.timeoutObj);
	  clearTimeout(this.serverTimeoutObj);
	  return this;
	},
	start: function(config) {
	  var count = 0;
	  this.timeoutObj = setInterval(() => {
		if (count < 3) {
		  if (config.socket.readyState === 1) {
			// config.socket.send('HeartBeat');
			config.socket.send(JSON.stringify({
				heart:'HeartBeat'
			}))
			console.info('HeartBeat第'+(count+1)+'次')
		  }
		  count++;
		} else {
		  clearInterval(this.timeoutObj);
		  count = 0;
		  if (config.socket.readyState === 0 && config.socket.readyState === 1) {
			config.socket.close();
		  }
		}
	  }, config.reconnectTime)
	}
}

function reconnect(config) {
	if (lockReconnect) return
	lockReconnect = true
	//没连接上会一直重连，设置延迟避免请求过多
	if (reconnectNum < config.reconnect) {
	  setTimeout(function() {
		timeoutFlag = true
		createClient(config)
		console.info('正在重连第'+(reconnectNum + 1)+'次')
		reconnectNum++
		// lockReconnect = false
	  }, 10000) //这里设置重连间隔(ms)
	}
}

// ======================================== utils ===============================================
function request(){
	const service = axios.create({
	  baseURL: 'http://127.0.0.1:6040',
	  timeout: 3000,
	  headers: {'Content-Type': 'application/json;charset=UTF-8'}
	});
	
	// request拦截器
	service.interceptors.request.use(config => {
	  return config;
	}, error => {
	
	})
	
	// respone拦截器
	service.interceptors.response.use(
	  response => {
	    if (response.status == 200) {
	      let data = response.data
	      if (data.status == -1) {
			 console.error(data.errorMsg)
	      }
	      return data;
	    }else{
			console.error(系统错误)
	    }
	  },
	  error => {}
	)
	return service
}

function extend() {
    var length = arguments.length;
    if(length == 0)return {};
    if(length == 1)return arguments[0];
    var target = arguments[0] || {};
    for (var i = 1; i < length; i++) {
        var source = arguments[i];
        for (var key in source) {
            if (source.hasOwnProperty(key)) {
                target[key] = source[key];
            }
        }
    }
    return target;
}

function deepCopy(obj) {
    if (!!obj) {
      var result = Array.isArray(obj) ? [] : {};

      for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
          if (typeof obj[key] === 'object' && obj[key] !== null) {
            result[key] = deepCopy(obj[key]); //递归复制
          } else {
            result[key] = obj[key];
          }
        }
      }

      return result;
    } else {
      return obj;
    }
  }