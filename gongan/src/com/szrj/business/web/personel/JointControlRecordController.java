package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletRequest;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.personel.JointControlRecordDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.information.InfoJointPerson;
import com.szrj.business.model.personel.JointControlRecord;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.SocialRelations;
import com.szrj.business.model.personel.WenVisit;


@Controller
@SessionAttributes("userSession")
public class JointControlRecordController {
	@Autowired
	private JointControlRecordDao jointControlRecordDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private PersonnelDao personnelDao;
	
	@RequestMapping("/searchJointControlRecord.do")
	@ResponseBody
	public Map<String,Object>  searchJointControlRecord(JointControlRecord jointcontrolrecord,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchJointControlRecord.do..............="+userSession.getLoginUserID());
		    pm.setPageNumber(page);
		    NewPageModel listTemp=jointControlRecordDao.searchJointControlRecord(jointcontrolrecord, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询联控信息");
			String operate_Condition = "";
			if(jointcontrolrecord.getPersonnelid() != 0){
				operate_Condition += "人员主表id = '" + jointcontrolrecord.getPersonnelid() + "'";
			}
			if(jointcontrolrecord.getWenvisitid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "涉稳关联绑定id in '" + jointcontrolrecord.getWenvisitid() + "'";
				}else{
					operate_Condition += " and 涉稳关联绑定id in '" + jointcontrolrecord.getWenvisitid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addjointcontrolrecord.do")
	public @ResponseBody String addrelationbank(JointControlRecord jointcontrolrecord,String [] cardnumber,String [ ]togethername,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addjointcontrolrecord.do.......................长度="+togethername.length);
		try {
			    jointcontrolrecord.setAddtime(addtime);
			    jointcontrolrecord.setAddoperator(userSession.getLoginUserName());
			   if(cardnumber.length>0){
				   for (int i=0;i<cardnumber.length;i++){
					   String cardnumber1=cardnumber[i];
					   String togethername1=togethername[i];
					   if (i==0){
						   System.out.println("i==0");
						   jointcontrolrecord.setCardnumber1(cardnumber1);
					       jointcontrolrecord.setTogethername1(togethername1);
					   }else if (i==1){
						   System.out.println("i==1");
						   jointcontrolrecord.setCardnumber2(cardnumber1);
						   jointcontrolrecord.setTogethername2(togethername1);
					   }else if (i==2){
						   System.out.println("i==2");
						    jointcontrolrecord.setCardnumber3(cardnumber1);
						    jointcontrolrecord.setTogethername3(togethername1);
					   }else if (i==3){
						   System.out.println("i==3");
							 jointcontrolrecord.setCardnumber4(cardnumber1);
							jointcontrolrecord.setTogethername4(togethername1);
					   }else if (i==4){
						   System.out.println("i==4");
							jointcontrolrecord.setCardnumber5(cardnumber1);
							jointcontrolrecord.setTogethername5(togethername1);
					   }		
				   }
			    }
			    jointControlRecordDao.add(jointcontrolrecord);
			    message= new Message("true","联控信息-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "联控信息-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addjointcontrolrecord.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("联控信息添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","联控信息-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "联控信息-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addjointcontrolrecord.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("联控信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updatejointcontrolrecord.do")
	public @ResponseBody String updatejointcontrolrecord(JointControlRecord jointcontrolrecord,String [] cardnumber,String [ ]togethername,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatejointcontrolrecord.do.......................");
		try {
			     jointcontrolrecord.setUpdatetime(updatetime);
			     jointcontrolrecord.setUpdateoperator(userSession.getLoginUserName());
			     if(cardnumber.length>0){
					   for (int i=0;i<cardnumber.length;i++){
						   String cardnumber1=cardnumber[i];
						   String togethername1=togethername[i];
						   if (i==0){
							   System.out.println("i==0");
							   jointcontrolrecord.setCardnumber1(cardnumber1);
						       jointcontrolrecord.setTogethername1(togethername1);
						   }else if (i==1){
							   System.out.println("i==1");
							   jointcontrolrecord.setCardnumber2(cardnumber1);
							   jointcontrolrecord.setTogethername2(togethername1);
						   }else if (i==2){
							   System.out.println("i==2");
							    jointcontrolrecord.setCardnumber3(cardnumber1);
							    jointcontrolrecord.setTogethername3(togethername1);
						   }else if (i==3){
							   System.out.println("i==3");
								 jointcontrolrecord.setCardnumber4(cardnumber1);
								jointcontrolrecord.setTogethername4(togethername1);
						   }else if (i==4){
							   System.out.println("i==4");
								jointcontrolrecord.setCardnumber5(cardnumber1);
								jointcontrolrecord.setTogethername5(togethername1);
						   }		
					   }
				    }
			    jointControlRecordDao.update(jointcontrolrecord);
				message= new Message("true","联控信息-修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "联控信息-修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updatejointcontrolrecord.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("联控信息修改");
				String operate_Condition = "";
				operate_Condition += "联控信息id = '" + jointcontrolrecord.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","联控信息-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "联控信息-修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatejointcontrolrecord.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("联控信息修改");
			String operate_Condition = "";
			operate_Condition += "联控信息id = '" + jointcontrolrecord.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/canceljointcontrolrecord.do")
	public @ResponseBody String canceljointcontrolrecord(JointControlRecord jointcontrolrecord,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("canceljointcontrolrecord.do.......................");
		try {
			     jointcontrolrecord.setUpdatetime(updatetime);
			    jointcontrolrecord.setUpdateoperator(userSession.getLoginUserName());
			    jointControlRecordDao.cancel(jointcontrolrecord);
				message= new Message("true","联控信息-作废成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "联控信息-作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
				System.out.println("canceljointcontrolrecord.do.......................作废成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("联控信息作废");
				String operate_Condition = "";
				operate_Condition += "联控信息id = '" + jointcontrolrecord.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","联控信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "联控信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("canceljointcontrolrecord.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("联控信息作废");
			String operate_Condition = "";
			operate_Condition += "联控信息id = '" + jointcontrolrecord.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getpersonelname.do")
	public @ResponseBody String getsocialrelationscount(String cardnumber){
		Message message;
		System.out.println("getpersonelname.do.......................");
		try {
			     int count=0;
			     count=personnelDao.findPersonInPersonnel(cardnumber);
			     if(count>0){
			    	 Personnel  persnnel=new   Personnel();
			    	 persnnel=personnelDao.getPersonnelByCardnumber(cardnumber);
			    	 JSONObject jsonObject = JSONObject.fromObject(persnnel);
			    	 System.out.println("jsonObject......................."+jsonObject.toString());
			    	 message= new Message(jsonObject.toString(),persnnel.getPersonname());
					 message.setFlag(1);
			     }else{
			    	 SocialRelations socialrelations=new SocialRelations();
			    	 socialrelations.setPersonnelid(0);
			    	 socialrelations.setCardnumber(cardnumber);
			    	 count=relationDao.getsocialrelationscount(socialrelations);
			    	 if(count>0){
			    		 socialrelations=relationDao.getsocialrelationsname(cardnumber);
			    		 JSONObject jsonObject = JSONObject.fromObject(socialrelations);
			    		 message= new Message(jsonObject.toString(),socialrelations.getPersonname());
						 message.setFlag(2);
			    	 }else{
			    		 message= new Message("true","没有检查到身份证姓名");
						 message.setFlag(-1); 
			    	 }
			     }
		} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","查询身份证姓名出错");
				message.setFlag(-1);
	   }
		return JSONObject.fromObject(message).toString();
	}	
	
	@RequestMapping("/getjointcontrolrecordbyid.do")
	public String getjointcontrolrecordbyid(int id,int menuid,String page,ModelMap model) throws Exception{
		System.out.println("getjointcontrolrecordbyid.do.................");
		JointControlRecord jointcontrolrecord=jointControlRecordDao.getJointControlRecordByid(id);
		model.addAttribute("jointcontrolrecord", jointcontrolrecord);
		System.out.println("Cardnumber1="+jointcontrolrecord.getCardnumber1()+"   Cardnumber2="+jointcontrolrecord.getCardnumber2()+"   Cardnumber3="+jointcontrolrecord.getCardnumber3());
		String cardnumber5=jointcontrolrecord.getCardnumber5();
		model.addAttribute("menuid", menuid);
		String  urlString;
		if(page.equals("update")){
			  urlString="/jsp/personel/jointcontrolrecord/update";
		}else if(page.equals("qbbs")){
			ArrayList<InfoJointPerson> list=new ArrayList();
			if(jointcontrolrecord.getCardnumber1()!=null  &&  ! jointcontrolrecord.getCardnumber1().equals("")){
				String cardnumber=jointcontrolrecord.getCardnumber1();
				InfoJointPerson  infojoint=new InfoJointPerson();
				infojoint.setJointCardNumber(cardnumber);//身份证号码
				infojoint.setJointName(jointcontrolrecord.getTogethername1());//姓名
				Personnel  personnel=personnelDao.getPersonnelByCardnumber(cardnumber);
				if(personnel!=null){
					Relation ralation=relationDao.searchrelation(personnel.getId());
					if(ralation!=null){
						infojoint.setJointTelephone(ralation.getTelnumber());//联系方式
					}
					infojoint.setJointHomePlace(personnel.getHomeplace());//现居住地
					infojoint.setJointHousePlace(personnel.getHouseplace());//户籍地
				}else{
					SocialRelations socialRelations=new SocialRelations();
					socialRelations.setCardnumber(cardnumber);
					List<SocialRelations>   socialRelationslist=relationDao.getsocialrelationsbycardnumber(socialRelations);
					if(socialRelationslist.size()>0){
						infojoint.setJointHomePlace(socialRelationslist.get(0).getHomeplace());//现居住地
						infojoint.setJointTelephone(socialRelationslist.get(0).getTelnumber1());//联系方式
					}
					
				}
				list.add(infojoint);
			}
			if(jointcontrolrecord.getCardnumber2()!=null && ! jointcontrolrecord.getCardnumber2().equals("")){
				String cardnumber=jointcontrolrecord.getCardnumber2();
				InfoJointPerson  infojoint=new InfoJointPerson();
				infojoint.setJointCardNumber(cardnumber);//身份证号码
				infojoint.setJointName(jointcontrolrecord.getTogethername2());//姓名
				Personnel  personnel=personnelDao.getPersonnelByCardnumber(cardnumber);
				if(personnel!=null){
					Relation ralation=relationDao.searchrelation(personnel.getId());
					if(ralation!=null){
						infojoint.setJointTelephone(ralation.getTelnumber());//联系方式
					}
					infojoint.setJointHomePlace(personnel.getHomeplace());//现居住地
					infojoint.setJointHousePlace(personnel.getHouseplace());//户籍地
				}else{
					SocialRelations socialRelations=new SocialRelations();
					socialRelations.setCardnumber(cardnumber);
					List<SocialRelations>   socialRelationslist=relationDao.getsocialrelationsbycardnumber(socialRelations);
					if(socialRelationslist.size()>0){
						infojoint.setJointHomePlace(socialRelationslist.get(0).getHomeplace());//现居住地
						infojoint.setJointTelephone(socialRelationslist.get(0).getTelnumber1());//联系方式
					}
					
				}
				list.add(infojoint);
			}
			if(jointcontrolrecord.getCardnumber3()!=null  && ! jointcontrolrecord.getCardnumber3().equals("")){
				System.out.println("Cardnumber3.................");
				String cardnumber=jointcontrolrecord.getCardnumber3();
				InfoJointPerson  infojoint=new InfoJointPerson();
				infojoint.setJointCardNumber(cardnumber);//身份证号码
				infojoint.setJointName(jointcontrolrecord.getTogethername3());//姓名
				Personnel  personnel=personnelDao.getPersonnelByCardnumber(cardnumber);
				if(personnel!=null){
					Relation ralation=relationDao.searchrelation(personnel.getId());
					if(ralation!=null){
						infojoint.setJointTelephone(ralation.getTelnumber());//联系方式
					}
					infojoint.setJointHomePlace(personnel.getHomeplace());//现居住地
					infojoint.setJointHousePlace(personnel.getHouseplace());//户籍地
				}else{
					SocialRelations socialRelations=new SocialRelations();
					socialRelations.setCardnumber(cardnumber);
					List<SocialRelations>   socialRelationslist=relationDao.getsocialrelationsbycardnumber(socialRelations);
					if(socialRelationslist.size()>0){
						infojoint.setJointHomePlace(socialRelationslist.get(0).getHomeplace());//现居住地
						infojoint.setJointTelephone(socialRelationslist.get(0).getTelnumber1());//联系方式
					}
					
				}
				list.add(infojoint);
			}
			if(jointcontrolrecord.getCardnumber4()!=null  && ! jointcontrolrecord.getCardnumber4().equals("")){
				String cardnumber=jointcontrolrecord.getCardnumber4();
				InfoJointPerson  infojoint=new InfoJointPerson();
				infojoint.setJointCardNumber(cardnumber);//身份证号码
				infojoint.setJointName(jointcontrolrecord.getTogethername4());//姓名
				Personnel  personnel=personnelDao.getPersonnelByCardnumber(cardnumber);
				if(personnel!=null){
					Relation ralation=relationDao.searchrelation(personnel.getId());
					if(ralation!=null){
						infojoint.setJointTelephone(ralation.getTelnumber());//联系方式
					}
					infojoint.setJointHomePlace(personnel.getHomeplace());//现居住地
					infojoint.setJointHousePlace(personnel.getHouseplace());//户籍地
				}else{
					SocialRelations socialRelations=new SocialRelations();
					socialRelations.setCardnumber(cardnumber);
					List<SocialRelations>   socialRelationslist=relationDao.getsocialrelationsbycardnumber(socialRelations);
					if(socialRelationslist.size()>0){
						infojoint.setJointHomePlace(socialRelationslist.get(0).getHomeplace());//现居住地
						infojoint.setJointTelephone(socialRelationslist.get(0).getTelnumber1());//联系方式
					}
					
				}
				list.add(infojoint);
			}
			if(jointcontrolrecord.getCardnumber5()!=null  && ! jointcontrolrecord.getCardnumber5().equals("")){
				String cardnumber=jointcontrolrecord.getCardnumber5();
				InfoJointPerson  infojoint=new InfoJointPerson();
				infojoint.setJointCardNumber(cardnumber);//身份证号码
				infojoint.setJointName(jointcontrolrecord.getTogethername5());//姓名
				Personnel  personnel=personnelDao.getPersonnelByCardnumber(cardnumber);
				if(personnel!=null){
					Relation ralation=relationDao.searchrelation(personnel.getId());
					if(ralation!=null){
						infojoint.setJointTelephone(ralation.getTelnumber());//联系方式
					}
					infojoint.setJointHomePlace(personnel.getHomeplace());//现居住地
					infojoint.setJointHousePlace(personnel.getHouseplace());//户籍地
				}else{
					SocialRelations socialRelations=new SocialRelations();
					socialRelations.setCardnumber(cardnumber);
					List<SocialRelations>   socialRelationslist=relationDao.getsocialrelationsbycardnumber(socialRelations);
					if(socialRelationslist.size()>0){
						infojoint.setJointHomePlace(socialRelationslist.get(0).getHomeplace());//现居住地
						infojoint.setJointTelephone(socialRelationslist.get(0).getTelnumber1());//联系方式
					}
					
				}
				list.add(infojoint);
			}
			
			
			 model.addAttribute("infojointperson", list);
			 model.addAttribute("listsize", list.size());
			urlString="/jsp/personel/jointcontrolrecord/information_add";
		}else{
			  urlString="/jsp/personel/jointcontrolrecord/showinfo";
		}
		return urlString;
	}
	
	@RequestMapping("/infoJointpersonelname.do")
	public @ResponseBody String infoJointpersonelname(String cardnumber){
		InfoJointPerson person = new InfoJointPerson();
		System.out.println("infoJointpersonelname.do.......................");
		try {
		    	 Personnel persnnel = new Personnel();
		    	 persnnel=personnelDao.getPersonnelByCardnumber(cardnumber);
		    	 if(null!=persnnel && persnnel.getCardnumber().length()>0){
		    		 person.setJointName(persnnel.getPersonname());		//姓名
		    		 person.setJointNickName(persnnel.getNickname());	//昵称绰号
		    		 person.setJointHomePlace(persnnel.getHomeplace());	//现住地详址
		    		 person.setJointHousePlace(persnnel.getHouseplace());//户籍地
		    		 Integer id = persnnel.getId();
		    		 person.setFlag(id);
		    		 Relation relation = relationDao.searchrelation(id);
		    		 if(null != relation){
		    			 person.setJointTelephone(relation.getTelnumber());
		    		 }
		    	 }else{
		    		 person.setFlag(-1);
		    	 }
		} catch (Exception e) {
				e.printStackTrace();
	   }
		return JSONObject.fromObject(person).toString();
	}	
	
	@RequestMapping("/searchJointControlRecord_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchJointControlRecord_zfw(JointControlRecord jointcontrolrecord,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=jointControlRecordDao.searchJointControlRecord_zfw(jointcontrolrecord, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/zfwJointControlRecord_check.do")
	@ResponseBody
	public String zfwJointControlRecord_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		JointControlRecord jointControlRecord=jointControlRecordDao.getJointControlRecordByid_zfw(id);
		try {
			jointControlRecordDao.add(jointControlRecord);
			jointControlRecord.setValidflag(2);
			jointControlRecord.setId(id);
			jointControlRecordDao.update_zfw(jointControlRecord);
			message= new Message("true","审查政法委联控信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险人员-审查政法委联控信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("联控信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委联控信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getjointcontrolrecordbyid_zfw.do")
	public String getjointcontrolrecordbyid_zfw(int id,int menuid,String page,ModelMap model) throws Exception{
		JointControlRecord jointcontrolrecord=jointControlRecordDao.getJointControlRecordByid_zfw(id);
		model.addAttribute("jointcontrolrecord", jointcontrolrecord);
		model.addAttribute("menuid", menuid);
		return "/jsp/personel/jointcontrolrecord/showinfo";
	}
}
