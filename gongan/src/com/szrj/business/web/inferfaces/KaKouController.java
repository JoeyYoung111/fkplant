package com.szrj.business.web.inferfaces;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserSession;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.interfaces.SendChat;
import com.szrj.business.dao.interfaces.ShortMessageDao;
import com.szrj.business.dao.interfaces.YujingDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.dao.personel.WenGradeDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.User;
import com.szrj.business.model.interfaces.Hotel;
import com.szrj.business.model.interfaces.InternetBar;
import com.szrj.business.model.interfaces.KaKou;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;
import com.szrj.business.model.interfaces.Yujing;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.RelationVehicle;
import com.szrj.business.model.personel.WenGrade;

@Controller
@SessionAttributes("userSession")
public class KaKouController {

	@Autowired
	private KaKouDao kaKouDao;
	@Autowired
	private YujingDao yujingDao;
	@Autowired
	private WenGradeDao wenGradeDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchtrajectoryKK.do")
	@ResponseBody
	public Map<String, Object> searchtrajectoryKK(KaKou  kakou,int page,NewPageModel pm){
		System.out.println("/searchtrajectoryKK.do........="+kakou.getPersoncard_number()+"  ");
		pm.setPageNumber(page);
		if(kakou.getData_origin().equals("2")){
			kakou.setData_origin("电子围栏");
		}else if(kakou.getData_origin().equals("1")){
			kakou.setData_origin("卡口数据");
		}else if(kakou.getData_origin().equals("3")){
			kakou.setData_origin("人脸轨迹");
		}else if(kakou.getData_origin().equals("4")){
			kakou.setData_origin("车辆轨迹");
		}
		NewPageModel listTemp = kaKouDao.searchtrajectoryKK(kakou, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	@RequestMapping("/searchAlltrajectoryKK.do")
	@ResponseBody
	public Map<String, Object> searchAlltrajectoryKK(KaKou  kakou,int page,NewPageModel pm){
		System.out.println("/searchAlltrajectoryKK.do........="+kakou.getPersoncard_number()+"  ");
		pm.setPageNumber(page);
		NewPageModel listTemp = kaKouDao.searchAlltrajectoryKK(kakou, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	@RequestMapping("/gettrajectoryKKtypesToJSON.do")
	public ModelAndView getBMByParentBasicNameToJSON(){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<String> bmList=kaKouDao.gettrajectoryKKtypes();
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).toString());
			sm.setValue(bmList.get(i).toString());
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	@RequestMapping("/searchHotel.do")
	@ResponseBody
	public Map<String, Object> searchHotel(Hotel  hotel,int page,NewPageModel pm){
		System.out.println("/searchHotel.do........="+hotel.getZJHM()+"  ");
		pm.setPageNumber(page);
		NewPageModel listTemp = kaKouDao.searchHotel(hotel, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	
	@RequestMapping("/getTrajectoryKKCount.do")
	@ResponseBody
	public Map<String, Object> getTrajectoryKKCount(KaKou  kakou,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String color="";
		KaKou kakouresult=kaKouDao.searchtrajectoryKK_count(kakou);
		if(kakouresult.getCount()==0){
			color="blue";
		}else{
			if(kakouresult.getIntervaltime()!=null){
				if(Integer.parseInt(kakouresult.getIntervaltime())<=43200){//最新数据与当前数据对比，小于12小时
					color="green";
				}else if(Integer.parseInt(kakouresult.getIntervaltime())>43200&&Integer.parseInt(kakouresult.getIntervaltime())<=86400){//最新数据与当前事假对比，大于12小时小于24小时
					color="orange";
				}else{
					color="red";
				}
			}else{
				color="blue";
			}
		}
		result.put("color", color);
		return result;
	}
	
	@RequestMapping("/searchInternetBar.do")
	@ResponseBody
	public Map<String, Object> searchInternetBar(InternetBar  internetbar,int page,NewPageModel pm){
		System.out.println("/searchHotel.do........="+internetbar.getCERTIFICATE_CODE()+"  ");
		pm.setPageNumber(page);
		NewPageModel listTemp = kaKouDao.searchInternetBar(internetbar, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	
	
	@RequestMapping("/searchXdJqxx.do")
	@ResponseBody
	public Map<String, Object> searchXdJqxx(XdJqxx  xdjqxx,int page,NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			System.out.println("/searchXdJqxx.do........="+xdjqxx.getSfzh()+"  ");
			pm.setPageNumber(page);
			NewPageModel listTemp = kaKouDao.searchXdJqxx(xdjqxx, pm);
			result.put("code", 0);
			result.put("count", listTemp.getTotal());
			result.put("data", listTemp.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping("/searchXdAjxx.do")
	@ResponseBody
	public Map<String, Object> searchXdAjxx(XdAjxx  xdajxx,int page,NewPageModel pm){
		System.out.println("/searchXdAjxx.do........="+xdajxx.getSfzh()+"  ");
		pm.setPageNumber(page);
		NewPageModel listTemp = kaKouDao.searchXdAjxx(xdajxx, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	
	
	@RequestMapping("/findYbssRkByCardnumber.do")
	@ResponseBody
	public Map<String, Object> findYbssRkByCardnumber(String cardnumber){
		boolean flag = false;
		Map<String,Object> map = new HashMap<String, Object>();
		String ID = kaKouDao.findYbssRkByCardnumber(cardnumber);
		if(!"0".equals(ID)){
			flag = true;
			map.put("ID", ID);
			Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ID);
			map.put("ybssPersonnel", ybssPersonnel);
		}
		map.put("flag", flag);
		return map;
	}
	
	@RequestMapping("/connectYujingByModelId.do")
	@ResponseBody
	public Map<String, Object> connectYujingByModelId(Yujing modelYujing,String dataid,@ModelAttribute("userSession")UserSession userSession) {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("dataid", dataid);
		boolean flag = false;
		try {
			List<Yujing> columnList=yujingDao.getYujingColumnListByModelId(modelYujing.getModelId());
			if(columnList!=null&&columnList.size()>0){
				for (int i = 0; i < columnList.size(); i++) {
					Yujing column=columnList.get(i);
					List<Yujing> resultList=yujingDao.getYujingResultListByColumn(column);
					if(resultList!=null&&resultList.size()>0){
						for (int j = 0; j < resultList.size(); j++) {
							Yujing getResult=resultList.get(j);
							boolean jysfzhflag=false;
							String result=getResult.getResult();
							HashMap<String,String> resultMap=new HashMap<String, String>();
							JSONObject resultObject=JSONObject.fromObject(result);
							Iterator resultIt=resultObject.keys();
							while (resultIt.hasNext()) {
								String keyString=String.valueOf(resultIt.next()).toString();
								String valueString=(String)resultObject.get(keyString).toString();
								String valuebase64=new String(Base64.decodeBase64(valueString),"UTF-8");
								if(keyString.equals("jysfzh")){
									if(valuebase64.equals(userSession.getLoginUserCardnumber()))jysfzhflag=true;
								}
								resultMap.put(keyString,valuebase64);
							}
							org.json.JSONObject resultJSON=new org.json.JSONObject(resultMap);
							if(jysfzhflag){
								getResult.setCardnumber(modelYujing.getCardnumber());
								getResult.setTable_name(column.getTable_name());
								getResult.setCreate_time(column.getCreate_time());
								getResult.setModelId(modelYujing.getModelId());
								int inFlag=kaKouDao.findYujingByColumn(getResult);
								if(inFlag==0){
									getResult.setResult(resultJSON.toString());
									getResult.setModel_title(modelYujing.getModel_title());
									getResult.setAddtime(addtime);
									getResult.setResult_status("0");
									
									HashMap<String,Object> map1=new HashMap<String,Object>();
									map1.put("event", JSONObject.fromObject(resultMap).toString());
									map1.put("user_tag", userSession.getLoginUserCode());//发送人
									map1.put("jsf_tag", (String)resultJSON.get("jysfzh").toString());//接受人
									map1.put("modelid", modelYujing.getModelId());//模型id
									SendChat sendchat=new SendChat();
									String parame=JSONObject.fromObject(map1).toString();
									String fzresult=sendchat.doHttpPost("http://50.64.128.56:9004/api/szsh/saveSzshSjNotFj", parame);
									//String fzresult=sendchat.doHttpPost("http://50.66.189.145:9014/api/szsh/saveSzshSjNotFj", parame);
									System.out.println("方正消息中心接口发送========fzresult="+fzresult);
									if(fzresult.length()>0){
										getResult.setResult_status("1");
									}
									kaKouDao.addYujing(getResult);
								}
							}
						}
					}
				}
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("flag", flag);
		return map;
	}
	@RequestMapping("/connectDianweiByModelId.post")
	@ResponseBody
	public Map<String, Object> connectDianweiByModelId(Yujing modelYujing,String zhibanmj,String dataid) {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("dataid", dataid);
		boolean flag = false;
		try {
			User fromuser=userDao.getByCardnumber(modelYujing.getCardnumber());
			String fromId=fromuser.getUsercode();
			String result=modelYujing.getResult();
			JSONObject resultObject=JSONObject.fromObject(result);
			String alarmTarget=resultObject.get("alarmTarget").toString();
			String siteName=resultObject.get("siteName").toString();
			String alarmTime=resultObject.get("alarmTime").toString();
			String exec_column="";
			String header="";
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
							String phoneNumber=personnel.getPphone1();
							String messege="涉稳["+level+"]人员预警："+personnel.getPersonname()+"（"+personnel.getCardnumber()+"）所属的手机（"+telnumber.getTelnumber()+"）于"+alarmTime+"到达"+siteName;
							new ShortMessageDao().sendmessage(phoneNumber,messege);
							if(!"".equals(exec_column))exec_column+=";";
							exec_column+=phoneNumber;
							flag=true;
							
							//给领悟消息中心推送
							HashMap<String,Object> map9=new HashMap<String,Object>();
							String toIds9 = "liyi";
							JSONArray zbmj=JSONArray.fromObject(zhibanmj);
							for (int j = 0; j < zbmj.size(); j++) {
								if(zbmj.getJSONObject(j).get("unit").equals(personnel.getJurisdictunit()))toIds9+=","+zbmj.getJSONObject(j).get("mj");
							}
							if(!"".equals(header))header+=";";
							header+=toIds9;
							String content9 = messege;
							map9.put("event", content9);
							content9 = new String(URLEncoder.encode(content9, "UTF-8").getBytes());
							//System.out.println(content);
							String param9="fromId="+fromId+"&toIds="+toIds9+"&content="+content9;
							String url9 = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param9;
							SendChat sendchat9=new SendChat();
							String result9=sendchat9.doHttpGet(url9);
							System.out.println("领悟消息中心接口发送========"+result9);
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
//							String phoneNumber="13771233910";
							String phoneNumber=personnel.getPphone1();
							String messege="涉稳["+level+"]人员预警："+personnel.getPersonname()+"（"+personnel.getCardnumber()+"）所属的车辆（"+alarmTarget+"）于"+alarmTime+"到达"+siteName;
							new ShortMessageDao().sendmessage(phoneNumber,messege);
							if(!"".equals(exec_column))exec_column+=";";
							exec_column+=phoneNumber;
							flag=true;
							
							//给领悟消息中心推送
							HashMap<String,Object> map9=new HashMap<String,Object>();
							String toIds9 = "liyi";
							JSONArray zbmj=JSONArray.fromObject(zhibanmj);
							for (int j = 0; j < zbmj.size(); j++) {
								if(zbmj.getJSONObject(j).get("unit").equals(personnel.getJurisdictunit()))toIds9+=","+zbmj.getJSONObject(j).get("mj");
							}
							
							if(!"".equals(header))header+=";";
							header+=toIds9;
							String content9 = messege;
							map9.put("event", content9);
							content9 = new String(URLEncoder.encode(content9, "UTF-8").getBytes());
							//System.out.println(content);
							String param9="fromId="+fromId+"&toIds="+toIds9+"&content="+content9;
							String url9 = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param9;
							SendChat sendchat9=new SendChat();
							String result9=sendchat9.doHttpGet(url9);
							System.out.println("领悟消息中心接口发送========"+result9);
						}
					}
				}
			}
			if(flag){
				modelYujing.setResult_status("1");
				modelYujing.setExec_column(exec_column);
				modelYujing.setHeader(header);
				modelYujing.setResult_feedback("电围短信分发成功！");
			}else {
				modelYujing.setResult_status("0");
				modelYujing.setResult_feedback("无匹配结果！！");
			}
			modelYujing.setAddtime(addtime);
			kaKouDao.addYujing(modelYujing);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("flag", flag);
		return map;
	}
	@RequestMapping("/connectRenlianByModelId.post")
	@ResponseBody
	public Map<String, Object> connectRenlianByModelId(Yujing modelYujing,String zhibanmj,String dataid) {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("dataid", dataid);
		boolean flag = false;
		try {
			User fromuser=userDao.getByCardnumber(modelYujing.getCardnumber());
			String fromId=fromuser.getUsercode();
			String result=modelYujing.getResult();
			JSONObject resultObject=JSONObject.fromObject(result);
			String hitPersonId=resultObject.get("hitPersonId").toString();
			String desc=resultObject.get("desc").toString();
			String[] descstrs=desc.split("布控人信息");
			String personId=resultObject.get("personId").toString();
			String exec_column="";
			String header="";
			
			Personnel riskPersonnel=personnelDao.getPersonnelByCardnumber(hitPersonId);
			if (riskPersonnel!=null) {
				Personnel personnel=personnelDao.getById(riskPersonnel.getId());
				String phoneNumber=personnel.getPphone1();
				String messege=descstrs[0];
				new ShortMessageDao().sendmessage(phoneNumber,messege);
				if(!"".equals(exec_column))exec_column+=";";
				exec_column+=phoneNumber;
				flag=true;
				
				//给领悟消息中心推送
				HashMap<String,Object> map9=new HashMap<String,Object>();
				String toIds9 = "liyi";
				JSONArray zbmj=JSONArray.fromObject(zhibanmj);
				for (int j = 0; j < zbmj.size(); j++) {
					if(zbmj.getJSONObject(j).get("unit").equals(personnel.getJurisdictunit()))toIds9+=","+zbmj.getJSONObject(j).get("mj");
				}
				if(!"".equals(header))header+=";";
				header+=toIds9;
				String content9 = messege;
				map9.put("event", content9);
				content9 = new String(URLEncoder.encode(content9, "UTF-8").getBytes());
				//System.out.println(content);
				String param9="fromId="+fromId+"&toIds="+toIds9+"&content="+content9;
				String url9 = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param9;
				SendChat sendchat9=new SendChat();
				String result9=sendchat9.doHttpGet(url9);
				System.out.println("领悟消息中心接口发送========"+result9);
			}
			
			if(flag){
				modelYujing.setResult_status("1");
				modelYujing.setExec_column(exec_column);
				modelYujing.setHeader(header);
				modelYujing.setResult_feedback("依图人脸短信分发成功！");
			}else {
				modelYujing.setResult_status("0");
				modelYujing.setResult_feedback("无匹配结果！！");
			}
			modelYujing.setAddtime(addtime);
			kaKouDao.addYujing(modelYujing);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("flag", flag);
		return map;
	}
	@RequestMapping("/connectJujiByModelId.post")
	@ResponseBody
	public Map<String, Object> connectJujiByModelId(Yujing modelYujing,String zhibanmj,String dataid) {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("dataid", dataid);
		boolean flag = false;
		try {
			User fromuser=userDao.getByCardnumber(modelYujing.getCardnumber());
			String fromId=fromuser.getUsercode();
			List<Yujing> columnList=yujingDao.getYujingColumnListByModelId(modelYujing.getModelId());
			if(columnList!=null&&columnList.size()>0){
				for (int i = 0; i < columnList.size(); i++) {
					Yujing column=columnList.get(i);
					List<Yujing> resultList=yujingDao.getYujingResultListByColumn(column);
					if(resultList!=null&&resultList.size()>0){
						for (int j = 0; j < resultList.size(); j++) {
							Yujing getResult=resultList.get(j);
							String result=getResult.getResult();
							HashMap<String,String> resultMap=new HashMap<String, String>();
							JSONObject resultObject=JSONObject.fromObject(result);
							Iterator resultIt=resultObject.keys();
							while (resultIt.hasNext()) {
								String keyString=String.valueOf(resultIt.next()).toString();
								String valueString=(String)resultObject.get(keyString).toString();
								String valuebase64=new String(Base64.decodeBase64(valueString),"UTF-8");
								resultMap.put(keyString,valuebase64);
							}
							String IDno=resultMap.get("IDno").toString();
							String resultstr=resultMap.get("result").toString();
							org.json.JSONObject resultJSON=new org.json.JSONObject(resultMap);
							getResult.setCardnumber(modelYujing.getCardnumber());
							getResult.setTable_name(column.getTable_name());
							getResult.setCreate_time(column.getCreate_time());
							getResult.setModelId(modelYujing.getModelId());
							int inFlag=kaKouDao.findYujingByColumn(getResult);
							if(inFlag==0&&!"".equals(resultstr)){
								getResult.setResult(resultJSON.toString());
								getResult.setModel_title(modelYujing.getModel_title());
								getResult.setAddtime(addtime);
								getResult.setResult_status("0");
								
								String messege="电围聚集预警："+resultstr;
								String[] cardnumbers=IDno.split(",");
								String exec_column="";
								String header="";
								String toIds9 = "liyi";
								for (int k = 0; k < cardnumbers.length; k++) {
									Personnel riskPersonnel=personnelDao.getPersonnelByCardnumber(cardnumbers[k]);
									Personnel personnel=personnelDao.getById(riskPersonnel.getId());
									String phoneNumber=personnel.getPphone1();
									new ShortMessageDao().sendmessage(phoneNumber,messege);
									if(!"".equals(exec_column))exec_column+=";";
									exec_column+=phoneNumber;
									JSONArray zbmj=JSONArray.fromObject(zhibanmj);
									for (int l = 0; l < cardnumbers.length; l++) {
										if(zbmj.getJSONObject(l).get("unit").equals(personnel.getJurisdictunit()))toIds9+=","+zbmj.getJSONObject(l).get("mj");
									}
								}
								
								//给领悟消息中心推送
								HashMap<String,Object> map9=new HashMap<String,Object>();
								if(!"".equals(header))header+=";";
								header+=toIds9;
								String content9 = messege;
								map9.put("event", content9);
								content9 = new String(URLEncoder.encode(content9, "UTF-8").getBytes());
								//System.out.println(content);
								String param9="fromId="+fromId+"&toIds="+toIds9+"&content="+content9;
								String url9 = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param9;
								SendChat sendchat9=new SendChat();
								String result9=sendchat9.doHttpGet(url9);
								System.out.println("领悟消息中心接口发送========"+result9);
								
								getResult.setResult_status("1");
								kaKouDao.addYujing(getResult);
							}
						}
					}
				}
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("flag", flag);
		return map;
	}
	
	@RequestMapping("/searchYujing.do")
	@ResponseBody
	public Map<String, Object> searchYujing(Yujing yujing,int page,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("/searchYujing.do........cardnumber=="+yujing.getCardnumber()+" ");
		pm.setPageNumber(page);
		String cardnumber=userSession.getLoginUserCardnumber();
//		if(userSession.getLoginUserRoleid()==1)cardnumber="all";
		if(userSession.getLoginRoleMsgFilter()==0)cardnumber="all";
		cardnumber=((cardnumber!=null&&cardnumber!="")?cardnumber:"none");
		yujing.setCardnumber(cardnumber);
		NewPageModel listTemp = kaKouDao.searchYujing(yujing, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	
	@RequestMapping("/feedbackYujing.post")
	public String feedbackYujing(Yujing yujing){
		System.out.println("/feedbackYujing.post........id=="+yujing.getId()+" ");
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		Map<String, Object> result = new HashMap<String, Object>();
		boolean resultflag=false;
		int index=0;
		try {
			yujing.setUpdatetime(updatetime);
			index=kaKouDao.feedbackYujing(yujing);
			resultflag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("flag", resultflag);
		result.put("index", index);
		return JSONObject.fromObject(result).toString();
	}
	@RequestMapping("/getShowinfoYujing.do")
	public String getShowinfoYujing(int id,ModelMap model,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("getShowinfoYujing.do.................");
		String url="";
		url="/jsp/yujing/showinfo";
		Yujing yujing=kaKouDao.getYujingById(id);
		model.addAttribute("yujing",yujing);
		return url;
	}
	
}
