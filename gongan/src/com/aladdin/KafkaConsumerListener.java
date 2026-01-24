package com.aladdin;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.listener.MessageListener;

import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.interfaces.ShortMessageDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.dao.personel.WenGradeDao;
import com.szrj.business.model.interfaces.Yujing;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.RelationVehicle;
import com.szrj.business.model.personel.WenGrade;


public class KafkaConsumerListener implements MessageListener<Integer, String>{
	@Autowired
	private WenGradeDao wenGradeDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private KaKouDao kaKouDao;
	public void onMessage(ConsumerRecord<Integer, String> consumerRecord) {

		Object obj= consumerRecord.value();
		JSONObject json = JSONObject.fromObject(obj);
		 //获取消息ID
	       String messageId=json.get("id").toString();
	       
	       //获取应用ID
	       String appid=json.get("appId").toString();
	       JSONObject header=json.getJSONObject("header");
	       JSONArray receives=header.getJSONArray("receives");
	       JSONObject receive=receives.getJSONObject(0);
	       JSONObject body=json.getJSONObject("body");
	       String title=body.get("title").toString();
	       JSONObject content=body.getJSONObject("content");
	       String points=",江阴信访局(微),江阴客运站安检(微),霞客高速收费站,江阴高速口,江阴北高速口,顾山高速口,青阳高速口,新桥南高速收费站上海方向(微),华西高速收费站,江阴南高速口,璜塘高速口,京沪高速无锡枢纽北,京沪高速偃桥服务区北,沪武高速海港大道,沪武高速新桥东西向,锡澄高速江阴大桥南桥头,靖江京沪高速上海方向1051.7公里处,长山卡口(虹旭),小湖路常州交界(微),芙蓉大道与S232路口,扬子大道与兴隆路路口,扬子大道与港城大道路口,利港汽渡,红旗路西黄桥南,江阴汽渡,西利线南常州交界处(微),澄鹿路与新杨路路口西50米,徐霞客大道卡口,芙蓉大道与红星路路口,扬子大道与芙蓉大道路口,镇澄路西利路路口(虹旭),芙蓉大道与亚包大道路口,海港大道与暨南大道路口,南湫路与黄河路路口(微),长安大道暨南大道路口(虹旭),光辉路顾家桥(微),南焦路常州交界处,小湖卡口(虹旭),石庄卡口滨江西道与扬子大道路口,锡张路黄旗桥南,文林卡口,锡张路与云顾线路口,长安大道卡口,桐安路与河滨西路路口(微),暨南大道与老红豆路路口,月城卡口,锡澄路与暨南大道路口,璜土卡口镇澄路格林豪泰,扬子大道与赣江路路口,旌阳路与圣杨路路口(微),东舜路习礼桥卡口(微),马朋路与马镇村路路口,马文路与锡澄路路口,桐蓉路与常州交界,芙蓉大道西常州交界,月城环山路与常州交界,月城河岸路与常州交界,月城徐家村与常州交界,江阴河东村卡口,江阴暨南大道云顾路,江阴青阳呈彩桥(微）,江阴青阳太平桥(微),江阴青阳界溪桥(微）,江阴南公安检查站,璜土科技大道与常州交界（微）,江阴小湖卡口(微),暨南大道-锡张路-西G,";
	       
	       try {
	    	   SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   		   String addtime=dateFormat.format(new Date());
	    	   String deployType=content.get("deployType").toString();
	    	   String siteName=content.get("siteName").toString();
	    	   String alarmTarget=content.get("alarmTarget").toString();
	    	   String alarmTime=content.get("alarmTime").toString();
	    	   Yujing yujing=new Yujing();
	    	   yujing.setCardnumber("320219197209136054");
	    	   yujing.setModel_title(title);
	    	   yujing.setModelId("dw");
	    	   yujing.setResult(content.toString());
	    	   yujing.setAddtime(addtime);
	    	   boolean flag = false;
	    	   String exec_column="";
	    	   if("全息布控".equals(deployType)&&points.indexOf(","+siteName+",")!=-1){
	    		   int alarmTargetLength=alarmTarget.length();
		   			if (alarmTargetLength>14) {
		   				List<RelationTelnumber> rtList=relationDao.getRelationTelnumberByImsi(alarmTarget);
		   				if(rtList!=null&&rtList.size()>0){
		   					for (int i = 0; i < rtList.size(); i++) {
		   						RelationTelnumber telnumber=rtList.get(i);
		   						int personnelid=telnumber.getPersonnelid();
		   						WenGrade grade=wenGradeDao.getBypersonnelid(personnelid);
		   						String level=grade.getJointcontrollevel();
		   						if("一级".equals(level)||"二级".equals(level)||"三级".equals(level)){
		   							Personnel personnel=personnelDao.getById(personnelid);
	//	   							String phoneNumber="13771233910";
		   							String phoneNumber=personnel.getPphone1();
		   							String messege="涉稳["+level+"]人员预警："+personnel.getPersonname()+"（"+personnel.getCardnumber()+"）所属的手机（"+telnumber.getTelnumber()+"）于"+alarmTime+"到达"+siteName;
		   							new ShortMessageDao().sendmessage(phoneNumber,messege);
		   							if(!"".equals(exec_column))exec_column+=";";
		   							exec_column+=phoneNumber;
		   							flag=true;
		   							//给领悟消息中心推送
	//	   							HashMap<String,Object> map9=new HashMap<String,Object>();
	//	   							String toIds9 = "liyi";
	//	   							if ("城中派出所".equals(personnel.getJurisdictunit())) {
	//	   								toIds9+=",gyn";//高伊娜	15961535159
	//	   							}
	//	   							if ("君山派出所".equals(personnel.getJurisdictunit())) {
	//	   								toIds9+=",zhouxn";//周欣妮	15251587239
	//	   							}
	//	   							if ("西郊派出所".equals(personnel.getJurisdictunit())) {
	//	   								toIds9+=",13861622524";//徐渭	13861622524
	//	   							}
	//	   							if ("要塞派出所".equals(personnel.getJurisdictunit())) {
	//	   								//toIds9+=",13861622524";//徐渭	13861622524
	//	   							}
	//	   							if ("城东派出所".equals(personnel.getJurisdictunit())) {
	//	   								//toIds9+=",13861622524";//徐渭	13861622524
	//	   							}
	//	   							if ("滨江派出所".equals(personnel.getJurisdictunit())) {
	//	   								toIds9+=",777";//陆翊军	13861601007
	//	   							}
	//	   							if ("云亭派出所".equals(personnel.getJurisdictunit())) {
	//	   								//toIds9+=",13861622524";//徐渭	13861622524
	//	   							}
	//	   							if ("南闸派出所".equals(personnel.getJurisdictunit())) {
	//	   								//toIds9+=",13861622524";//徐渭	13861622524
	//	   							}
	//	   							if ("夏港派出所".equals(personnel.getJurisdictunit())) {
	//	   								//toIds9+=",13861622524";//徐渭	13861622524
	//	   							}
	//	   							if ("利港派出所".equals(personnel.getJurisdictunit())) {
	//	   								toIds9+=",228460";//吴仪	15961624939
	//	   							}
	//	   							if ("申港派出所".equals(personnel.getJurisdictunit())) {
	//	   								//toIds9+=",cj";//陈杰	13812100384   张彬	15161606471
	//	   							}
	//	   							
	//	   							
	//	   							String content9 = messege;
	//	   							map9.put("event", content9);
	//	   							content9 = new String(URLEncoder.encode(content9, "UTF-8").getBytes());
	//	   							//System.out.println(content);
	//	   							String param9="fromId="+userSession.getLoginUserCode()+"&toIds="+toIds9+"&content="+content9;
	//	   							String url9 = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param9;
	//	   							SendChat sendchat9=new SendChat();
	//	   							String result9=sendchat9.doHttpGet(url9);
	//	   							System.out.println("领悟消息中心接口发送========"+result9);
		   						}
		   					}
		   				}
		   			}else if(alarmTargetLength>0&&alarmTargetLength<10){
		   				List<RelationVehicle> rvList=relationDao.getRelationVehicleByVehiclenum(alarmTarget);
		   				if(rvList!=null&&rvList.size()>0){
		   					for (int i = 0; i < rvList.size(); i++) {
		   						RelationVehicle vehicle=rvList.get(i);
		   						int personnelid=vehicle.getPersonnelid();
		   						WenGrade grade=wenGradeDao.getBypersonnelid(personnelid);
		   						String level=grade.getJointcontrollevel();
		   						if("一级".equals(level)||"二级".equals(level)||"三级".equals(level)){
		   							Personnel personnel=personnelDao.getById(personnelid);
	//	   							String phoneNumber="13771233910";
		   							String phoneNumber=personnel.getPphone1();
		   							String messege="涉稳["+level+"]人员预警："+personnel.getPersonname()+"（"+personnel.getCardnumber()+"）所属的车辆（"+alarmTarget+"）于"+alarmTime+"到达"+siteName;
		   							new ShortMessageDao().sendmessage(phoneNumber,messege);
		   							if(!"".equals(exec_column))exec_column+=";";
		   							exec_column+=phoneNumber;
		   							flag=true;
		   						}
		   					}
		   				}
		   			}
		   			if(flag){
		   				yujing.setResult_status("1");
		   				yujing.setExec_column(exec_column);
		   				yujing.setResult_feedback("电围短信分发成功！");
					}else {
						yujing.setResult_status("0");
		    		    yujing.setResult_feedback("无匹配结果！！");
					}
		   			kaKouDao.addYujing(yujing);
	    	   }else {
	    		   yujing.setResult_status("0");
	    		   yujing.setResult_feedback("非全息布控，或不属于重点关注点位！！");
	    	   }
			} catch (Exception e) {
				e.printStackTrace();
			}
	       
	       //获取接收人ID
	       String receiveId=receive.getString("receiveId");
	       //将未读消息设置已读
	       String urlstr="http://50.64.128.50:6040/message/setRead/"+messageId+"?appId="+appid+"&userId="+receiveId;
	       String result  = "";
	       CloseableHttpClient client = HttpClients.createDefault();
	       CloseableHttpResponse response = null;
	       HttpGet get = new HttpGet(urlstr);
	       try {
	            response = client.execute(get);
	            HttpEntity entity = response.getEntity();
	            if(entity != null){
	                result = EntityUtils.toString(entity, "UTF-8");
	            }
	            EntityUtils.consume(entity);
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();

	        } catch (ClientProtocolException e) {
	            e.printStackTrace();

	        } catch (IOException e) {
	            e.printStackTrace();

	        }finally{
	            if(response != null){
	                try {
	                    response.close();
	                } catch (IOException e) {
	                    e.printStackTrace();

	                }
	            }
	            if(client != null){
	                try {
	                    client.close();
	                } catch (IOException e) {
	                    e.printStackTrace();

	                }
	            }
	        }
	       System.out.println(result);

	}

}
