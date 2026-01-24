package com.szrj.business.web.personel;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CardnumberCheck;
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.personel.HeiEditorDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.User;
import com.szrj.business.model.personel.HeiEditor;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.RealityShow;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.SocialRelations;

@Controller
@SessionAttributes("userSession")
public class HeiPersonelController {
	@Autowired
	private HeiEditorDao heiEditorDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private KaKouDao kaKouDao;
	@Autowired
	private LogDao logDao;
	/**
	 * 查询涉黑人员列表
	 * @param personnel
	 * @param pm
	 * @param page
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/getHeiPersonnel.do")
	@ResponseBody
	public Map<String,Object>  getHeiPersonnel(Personnel personnel,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/getHeiPersonnel.do..............="+userSession.getLoginUserID());
		    pm.setPageNumber(page);
		    personnel.setAddoperatorid(userSession.getLoginUserID());
		    NewPageModel listTemp=heiEditorDao.searchHeiPersonnel(personnel, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询涉黑人员");
			String operate_Condition = "";
			if(personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnel.getCardnumber() + "'";
			}
			if(personnel.getPersonname() != null && !"".equals(personnel.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnel.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnel.getPersonname() + "'";
				}
			}
			if(personnel.getSexes() != null && !"".equals(personnel.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + personnel.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + personnel.getSexes() + "'";
				}
			}
			if(personnel.getNation() != null && !"".equals(personnel.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 LIKE '" + personnel.getNation() + "'";
				}else{
					operate_Condition += " and 民族 LIKE '" + personnel.getNation() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 LIKE '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 LIKE '" + personnel.getPersontype() + "'";
				}
			}
			if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}
			}
			if(personnel.getWorkplace() != null && !"".equals(personnel.getWorkplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}else{
					operate_Condition += " and 工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}
			}
			if(personnel.getHomepolice() != null && !"".equals(personnel.getHomepolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}else{
					operate_Condition += " and 现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}
			}
			if(personnel.getWorkpolice() != null && !"".equals(personnel.getWorkpolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}else{
					operate_Condition += " and 工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	/**
	 * 添加涉黑人员信息
	 * @param personnel
	 * @param heieditor
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addHeiPersonel.do")
	public @ResponseBody String addHeiPersonel(Personnel personnel,String ybssid,HeiEditor heieditor,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addHeiPersonel.do.......................heieditor="+heieditor.getEditableid()+"    name="+heieditor.getEditablename());
		/*String editableid;
		String editablename;
		if(heieditor.getEditableid().equals("")){
			 editableid=userSession.getLoginUserID()+"";
			 editablename=userSession.getLoginUserName();
		}else{
			 editableid=userSession.getLoginUserID()+","+heieditor.getEditableid();
			 editablename=userSession.getLoginUserName()+","+heieditor.getEditablename();
		}*/
		try {
			int findid=personnelDao.findPersonInPersonnel(personnel.getCardnumber());
			if(findid>0){
				Personnel person=personnelDao.getById(findid);//根据身份证号查询人员基本信息
				/*****非风险人提升为风险人*****/
				if(person.getIsrisk()==2){
					//变为风险人员
					person.setIsrisk(1);
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.updateCyPersonRisk(person);
				}
				/*****风险人员主表标签修改*****/
				String zslabel1=person.getZslabel1();
				if(zslabel1!="")zslabel1+=",";
				zslabel1+="3";//添加标签 涉黑-3
				person.setZslabel1(zslabel1);
				person.setUpdateoperator(userSession.getLoginUserName());
				person.setUpdatetime(addtime);
				personnelDao.update(person);
				/*****添加涉黑子表信息*****/
				heieditor.setPersonnelid(findid);
				heieditor.setIncontrolleve(1);//默认插入关注中......
				//heieditor.setEditableid(editableid);
				//heieditor.setEditablename(editablename);
				heieditor.setAddoperator(userSession.getLoginUserName());
				heieditor.setAddoperatorid(userSession.getLoginUserID());
				heieditor.setDepartmentid(userSession.getLoginUserDepartmentid());
				heieditor.setAddtime(addtime);
				heiEditorDao.add(heieditor);
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				message= new Message("true","涉黑人员-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉黑人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addHeiPersonel.do.......................添加成功");
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("非风险人员升级为涉黑人员");
				String operate_Condition = "";
				operate_Condition += "人员id = '" + findid + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else{
				/*****风险人员主表添加*****/
		        personnel.setZslabel1("3");//标签 涉黑-3
		        personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
		        personnel.setValidflag(1);
		        personnel.setAddoperator(userSession.getLoginUserName());
		        personnel.setAddoperatorid(userSession.getLoginUserID());
		        personnel.setAddtime(addtime);
				int personid=personnelDao.add(personnel);
				/*****默认添加空关联信息*****/
				Relation relation=new Relation();
			    relation.setPersonnelid(personid);
			    relationDao.addrelation(relation);
			    
			    /*****一标三识数据关联*****/
			    if(ybssid!=null&&!"".equals(ybssid)){
			    	personnel=personnelDao.getById(personid);
					Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
					personnel.setPersontype(ybssPersonnel.getPersontype());
					personnel.setNation(ybssPersonnel.getNation());
					personnel.setMarrystatus(ybssPersonnel.getMarrystatus());
					personnel.setEducation(ybssPersonnel.getEducation());
					personnel.setHouseplace(ybssPersonnel.getHouseplace());
					personnel.setHomeplace(ybssPersonnel.getHomeplace());
					personnel.setHomex(ybssPersonnel.getHomex());
					personnel.setHomey(ybssPersonnel.getHomey());
					personnel.setWorkplace(ybssPersonnel.getWorkplace());
					if(ybssPersonnel.getTelnumber()!=null&&!"".equals(ybssPersonnel.getTelnumber())){
						String[] telnumbers=ybssPersonnel.getTelnumber().split(";");
						for (int i = 0; i < telnumbers.length; i++) {
							if(!"".equals(telnumbers[i])&&telnumbers[i].length()>10){
								RelationTelnumber relationtelnumber=new RelationTelnumber();
								relationtelnumber.setPersonnelid(personid);
								relationtelnumber.setTelnumber(telnumbers[i]);
								relationtelnumber.setAddtime(addtime);
								relationtelnumber.setAddoperator(userSession.getLoginUserName());
								relationDao.addrelationtelnumber(relationtelnumber);
							}
						}
					}
					personnelDao.update(personnel);
					
				}
			    
				/*****涉黑人员子表添加*****/
				heieditor.setPersonnelid(personid);
				heieditor.setIncontrolleve(1);//默认插入关注中......
				//heieditor.setEditableid(editableid);
				//heieditor.setEditablename(editablename);
				heieditor.setAddoperator(userSession.getLoginUserName());
				heieditor.setAddoperatorid(userSession.getLoginUserID());
				heieditor.setDepartmentid(userSession.getLoginUserDepartmentid());
				heieditor.setAddtime(addtime);
				heiEditorDao.add(heieditor);
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(personnel.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				logDao.recordLog(menuid, "风险人员-涉黑人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				message= new Message("true","涉黑人员-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉黑人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addHeiPersonel.do.......................添加成功");
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉黑人员添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉黑人员-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉黑人员-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addHeiPersonel.do.......................添加失败");
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉黑人员添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * treeselect 使用 去除已选择人员
	 * @param departmentid
	 * @param response
	 */
	@RequestMapping("/getUsersByDepartidJSON1.do")
	 public void  getbasicMsgJSON(int departmentid,int personnelid,HttpServletResponse response){
		System.out.println("/getUsersByDepartidJSON1.do......................");
		try{
		HeiEditor heieditor=	heiEditorDao.getBypersonnelid(personnelid);
		User user=new User();
		user.setDepartmentid(departmentid);
		user.setDepartname(heieditor.getEditableid());
		List<User> bmList=userDao.getByDepartmentidNotin(user);
		List nodes=new ArrayList();
		for (int i = 0; i < bmList.size(); i++) {
		     HashMap<String,Object> tsNode=new HashMap<String, Object>();
				tsNode.put("id", bmList.get(i).getId());
				tsNode.put("name",bmList.get(i).getStaffName());
				nodes.add(tsNode);
		}
		JSONArray json=new JSONArray();
		 json=JSONArray.fromObject(nodes);
		response.setCharacterEncoding("UTF-8");
		System.out.println("/getUsersByDepartidJSON1.do......................="+json.toString());
		response.getWriter().print(json.toString());
	} catch (IOException e) {
		e.printStackTrace();
	}   
	}

	@RequestMapping("/getHeiPersonelUpdate.do")
	public String getHeiPersonelUpdate(HeiEditor heieditor,int menuid,String buttons,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getHeiPersonelUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		model.addAttribute("buttons",buttons);
		try {
		    //获取基本信息
		    Personnel personnel=personnelDao.getById(heieditor.getPersonnelid());
			model.addAttribute("personnel",personnel);
			int age=CardnumberInfo.getAge(personnel.getCardnumber());
			model.addAttribute("age",age);
		    Relation relation=relationDao.searchrelation(heieditor.getPersonnelid());	//关联信息
			model.addAttribute("relation",relation);
			heieditor=heiEditorDao.getBypersonnelid(heieditor.getPersonnelid());
			model.addAttribute("heieditor",heieditor);
			
			
			if(page.equals("update")){
				List<BasicMsg> marrystatus=basicMsgDao.getByType(16);//通用-婚姻状况
				model.addAttribute("marrystatus",marrystatus);
				
				List<BasicMsg> nation=basicMsgDao.getByType(15);//通用-民族
				model.addAttribute("nation",nation);
				
				List<BasicMsg> soldierstatus=basicMsgDao.getByType(21);//通用-兵役状况
				model.addAttribute("soldierstatus",soldierstatus);
				
				List<BasicMsg> heathstatus=basicMsgDao.getByType(54);//通用-健康状态
				model.addAttribute("heathstatus",heathstatus);
				
				List<BasicMsg> politicalposition=basicMsgDao.getByType(17);//通用-政治面貌
				model.addAttribute("politicalposition",politicalposition);
				
				List<BasicMsg> faith=basicMsgDao.getByType(18);//通用-宗教信仰
				model.addAttribute("faith",faith);
				
				List<BasicMsg> education=basicMsgDao.getByType(19);//通用-文化程度
				model.addAttribute("education",education);
				
				List<BasicMsg> persontype=basicMsgDao.getByType(20);//通用-人员类别
				model.addAttribute("persontype",persontype);
				
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				url="/jsp/personel/hei/update";
			}else{
				url="/jsp/personel/hei/showinfo";
			}    
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
	@RequestMapping("/updateHeiPersonel.do")
	public @ResponseBody String updateHeiPersonel(HeiEditor heieditor,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateHeiPersonel.do.......................editableid="+heieditor.getEditableid()+"   editablename="+heieditor.getEditablename()+"  editableid1= "+heieditor.getEditableid1()+"   editablename1="+heieditor.getEditablename1());
		try {
		    personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.update(personnel);
			
			heieditor.setId(Integer.parseInt(heieditor.getHeieditorid()));
			heieditor.setUpdateoperator(userSession.getLoginUserName());
			heieditor.setUpdatetime(addtime);
		    if(heieditor.getEditableid1().equals("")){
		    	
		    }else{
		    	if(heieditor.getEditableid().equals("")){
		    	    System.out.println("已存在可编辑人。。。。。。。。。为空");
		    		heieditor.setEditableid(heieditor.getEditableid1());
			    	heieditor.setEditablename(heieditor.getEditablename1());
		    	}else{
		    	    System.out.println("已存在可编辑人。。。。。。。。。不为空");
		    		heieditor.setEditableid(heieditor.getEditableid()+","+heieditor.getEditableid1());
			    	heieditor.setEditablename(heieditor.getEditablename()+","+heieditor.getEditablename1());
		    	}
		    }
			heiEditorDao.update(heieditor);
			message = new Message("true","涉黑人员-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉黑人员-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateHeiPersonel.do.......................修改成功");
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉黑人员修改");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉黑人员-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉黑人员-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateHeiPersonel.do.......................修改失败");
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉黑人员修改");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/cancelHeiPersonel.do")
	public @ResponseBody String cancelHeiPersonel(HeiEditor heieditor,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelHeiPersonel.do.......................");
		try {
			heieditor.setUpdateoperator(userSession.getLoginUserName());
			heieditor.setUpdatetime(addtime);
			heiEditorDao.cancel(heieditor);
			
			Personnel person=personnelDao.getById(heieditor.getPersonnelid());
			person.setUpdateoperator(userSession.getLoginUserName());
			person.setUpdatetime(addtime);
			String personlabel=person.getZslabel1();
			//String personlabel=person.getPersonlabel();
			String[] labelstr=personlabel.split(",");
			int[] labelint=new int[labelstr.length];
			for (int i = 0; i < labelstr.length; i++) {
				labelint[i]=Integer.parseInt(!"".equals(labelstr[i])?labelstr[i]:"0");
			}
			Arrays.sort(labelint);//数组排序
			int labelindex=Arrays.binarySearch(labelint,3);//涉黑-3
			String newlabel="";
			for (int i = 0; i < labelint.length; i++) {
				if(i!=labelindex&&labelint[i]!=0){
					if(newlabel!="")newlabel+=",";
					newlabel+=String.valueOf(labelint[i]);
				}
			}
			person.setZslabel1(newlabel);
			personnelDao.update(person);
			System.out.println("cancelHeiPersonel.do.......................更新风险人员标签!!!!");
			/*if(newlabel.equals("")){
				personnelDao.cancel(person);
				System.out.println("cancelHeiPersonel.do.......................同时删除风险人员!!!!");
			}else {
				person.setPersonlabel(newlabel);
				personnelDao.update(person);
				System.out.println("cancelHeiPersonel.do.......................更新风险人员标签!!!!");
			}*/
			
			message = new Message("true","涉黑人员-删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉黑人员-删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelHeiPersonel.do.......................删除成功");
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉黑人员删除");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + heieditor.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉黑人员-删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉黑人员-删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelHeiPersonel.do.......................删除失败");
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉黑人员删除");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + heieditor.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getHeiEditorByPersonnelid.do")
	@ResponseBody
	public HashMap<String, Object> getHeiEditorByPersonnelid(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		HashMap<String, Object> results=new HashMap<String, Object>();
		boolean filterflag=false;
		HeiEditor heieditor=heiEditorDao.getBypersonnelid(personnelid);
		if(heieditor!=null){
			if(heieditor.getAddoperatorid()==userSession.getLoginUserID())filterflag=true;
			String editableid=heieditor.getEditableid();
			if(editableid!=null&&editableid!=""){
				String[] editableidstr=editableid.split(",");
				for (int i = 0; i < editableidstr.length; i++) {
					if(Integer.parseInt(editableidstr[i])==userSession.getLoginUserID()){
						filterflag=true;
						break;
					}
				}
			}
		}
		results.put("filterflag",filterflag);
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据人员ID查询涉黑人员扩展信息");
		String operate_Condition = "";
		operate_Condition += "人员ID = '" + personnelid + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return results;
	}
	@RequestMapping("/exportHeiPersonnel.do")
	public void exportHeiPersonnel(HttpServletResponse response,Personnel personnel,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,
											String personnelfield,String personneltext,
											String gradefield,String gradetext,
											String relationfield,String relationtext,
										    String showfield,String showtext,
											int menuid){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("exportHeiPersonnel.do.......................gradefield="+gradefield+"  gradetext"+gradetext+"  relationfield"+relationfield+"  relationtext"+relationtext+"  showfield"+showfield+"  showtext"+showtext);
		
		try {
			List<HeiEditor> list=heiEditorDao.searchHeiPersonnelList(personnel);
			
			if(list.size()>0){
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel");
				/*设置输出文件名称*/
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode("风险人员(涉黑)信息.xls", "UTF-8"));
				
				/*将数据写入excel*/
				/*建立新的HSSFWorkbook对象*/
				HSSFWorkbook wb = new HSSFWorkbook();
				/*建立新的工作簿*/
				HSSFSheet sheet = wb.createSheet("涉黑人员");
				
				/*excel表单内容样式*/
				HSSFCellStyle border = wb.createCellStyle();
				border.setWrapText(true);
				border.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				border.setBorderRight(HSSFCellStyle.BORDER_THIN);
				border.setBorderTop(HSSFCellStyle.BORDER_THIN);
				border.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				border .setAlignment(HSSFCellStyle.ALIGN_CENTER);
				border.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				HSSFFont font3 = wb.createFont();
				font3.setFontName("宋体");
				font3.setFontHeightInPoints((short)10);
				border.setFont(font3);
				
				/*excel标题样式*/
				HSSFCellStyle style = wb.createCellStyle();
				style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				HSSFFont font = wb.createFont();
				font.setFontName("宋体");
				font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
				font.setFontHeightInPoints((short)14);
				style.setFont(font);
				
				/*excel表单内容的小标题样式*/
				HSSFCellStyle style2 = wb.createCellStyle();
				style2 .setAlignment(HSSFCellStyle.ALIGN_CENTER);
				style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				HSSFFont font2 = wb.createFont();
				font2.setFontName("宋体");
				font2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
				font2.setFontHeightInPoints((short)10);
				style2.setFont(font2);
				
				/*勾选字段解析*/
				String[] personnelfieldStrings=personnelfield.split(",");
				String[] personneltextStrings=personneltext.split(",");
				int personnellength=personnelfieldStrings.length;
				
				String[] gradefieldStrings=gradefield.split(",");
				String[] gradetextStrings=gradetext.split(",");
				int gradelength=(gradefield!=""?gradefieldStrings.length:0);
				
				String[] relationfieldStrings=relationfield.split(",");
				String[] relationtextStrings=relationtext.split(",");
				int relationlength=(relationfield!=""?relationfieldStrings.length:0);
				
			    String[] showfieldStrings=showfield.split(",");
				String[] showtextStrings=showtext.split(",");
				int showlength=(showfield!=""?showfieldStrings.length:0);
				
				/*定义标题*/
				HSSFRow rowtitle = sheet.createRow(0);
				rowtitle.setHeightInPoints(40);
				CellRangeAddress r = new CellRangeAddress(0,0,0,personnellength+gradelength+relationlength+showlength);
				sheet.addMergedRegion(r);
				HSSFCell cellhead = rowtitle.createCell(0);
				HSSFRichTextString valuehead = new HSSFRichTextString("涉黑人员信息");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				/*定义副标题*/
				rowtitle=sheet.createRow(1);
				rowtitle.setHeightInPoints(30);
				/*基本信息*/
				int titlelength=personnellength;
				r=new CellRangeAddress(1,1,0,titlelength);
				sheet.addMergedRegion(r);
				cellhead = rowtitle.createCell(0);
				valuehead=new HSSFRichTextString("基本信息");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				/*可编辑人员信息*/
				if(gradelength>0){
					r=new CellRangeAddress(1,1,titlelength+1,titlelength+gradelength);
					sheet.addMergedRegion(r);
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("可编辑人员信息");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=gradelength;
				}
				/*关联信息*/
				if(relationlength>0){
					r=new CellRangeAddress(1,1,titlelength+1,titlelength+relationlength);
					sheet.addMergedRegion(r);
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("关联信息");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=relationlength;
				}
			
				/*现实表现*/
				if(showlength>0){
					r=new CellRangeAddress(1,1,titlelength+1,titlelength+showlength);
					sheet.addMergedRegion(r);
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("现实表现");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=showlength;
				}
				/*数据*/
				HSSFRow row;
				HSSFCell cell;
				HSSFRichTextString value;
				
				/*标题行*/
				row = sheet.createRow(2);
				row.setHeightInPoints(25);
				cell = row.createCell(0);
				value = new HSSFRichTextString("编号");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				for(int i=0;i<personnellength;i++){
					cell = row.createCell(i+1);
					value = new HSSFRichTextString(personneltextStrings[i]);
					cell.setCellValue(value);
					cell.setCellStyle(style2);
				}
				int cell2length=personnellength;
				if(gradelength>0){
					for(int i=0;i<gradelength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(gradetextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=gradelength;
				}
				if(relationlength>0){
					for(int i=0;i<relationlength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(relationtextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=relationlength;
				}
			  if(showlength>0){
					for(int i=0;i<showlength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(showtextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=showlength;
				}
				
				/*数据行*/
				/*创建行*/
				for (int i = 0; i < list.size(); i++) {
					row = sheet.createRow(i+3);
					row.setHeightInPoints(60);
					cell = row.createCell(0);
					value = new HSSFRichTextString(String.valueOf(i+1));
					cell.setCellValue(value);
					cell.setCellStyle(border);
					int cellindex=0;
					JSONObject node=JSONObject.fromObject(list.get(i).getExportPersonnel());
				
					for (int j = 0; j < personnellength; j++) {
						if(j==1){
							sheet.setColumnWidth(cellindex+j+1, 5000);
						}else{
							sheet.setColumnWidth(cellindex+j+1, 3000);
						}
						
						cell = row.createCell(cellindex+j+1);
						String celltext=node.get(personnelfieldStrings[j]).toString();
						//System.out.println("j="+j+"   celltext= "+celltext );
					    value = new HSSFRichTextString(celltext);
						cell.setCellValue(value);
						cell.setCellStyle(border);
						if(personnelfieldStrings[j].equals("cardnumber")){
							String ageString=String.valueOf(CardnumberInfo.getAge(node.get(personnelfieldStrings[j]).toString()));
							j++;
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(ageString);
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
					}
					cellindex+=personnellength;
					
					if(gradelength>0){
						node=JSONObject.fromObject(list.get(i));
						for (int j = 0; j < gradelength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 5000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(gradefieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=gradelength;
					}
					if(relationlength>0){
						if(list.get(i).getExportRelation()!=null)node=JSONObject.fromObject(list.get(i).getExportRelation());
						else node=JSONObject.fromObject(new Relation());
						for (int j = 0; j < relationlength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 4000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(relationfieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=relationlength;
					}
					
					if(showlength>0){
						if(list.get(i).getExportRealityShow()!=null)node=JSONObject.fromObject(list.get(i).getExportRealityShow());
						else node=JSONObject.fromObject(new RealityShow());
						for (int j = 0; j < showlength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 6000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(showfieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=showlength;
					}
				}
				
				message = new Message("true","涉黑人员-导出成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉黑人员-导出", userSession.getLoginUserName(), addtime, "导出成功", "");
				
				/*将excel内容写入要输出的excel中*/
				OutputStream outputStream=response.getOutputStream();
				wb.write(outputStream);
				outputStream.flush();
				outputStream.close();
			}else {
				message = new Message("false","涉黑人员-无导出数据！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "风险人员-涉黑人员-导出", userSession.getLoginUserName(), addtime, "无导出数据", "");
			}
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("导出涉黑人员");
			String operate_Condition = "";
			if(personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnel.getCardnumber() + "'";
			}
			if(personnel.getPersonname() != null && !"".equals(personnel.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnel.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnel.getPersonname() + "'";
				}
			}
			if(personnel.getSexes() != null && !"".equals(personnel.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + personnel.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + personnel.getSexes() + "'";
				}
			}
			if(personnel.getNation() != null && !"".equals(personnel.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 LIKE '" + personnel.getNation() + "'";
				}else{
					operate_Condition += " and 民族 LIKE '" + personnel.getNation() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 LIKE '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 LIKE '" + personnel.getPersontype() + "'";
				}
			}
			if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}
			}
			if(personnel.getWorkplace() != null && !"".equals(personnel.getWorkplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}else{
					operate_Condition += " and 工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}
			}
			if(personnel.getHomepolice() != null && !"".equals(personnel.getHomepolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}else{
					operate_Condition += " and 现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}
			}
			if(personnel.getWorkpolice() != null && !"".equals(personnel.getWorkpolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}else{
					operate_Condition += " and 工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉黑人员-导出失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉黑人员-导出", userSession.getLoginUserName(), addtime, "导出失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("导出涉黑人员");
			String operate_Condition = "";
			if(personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnel.getCardnumber() + "'";
			}
			if(personnel.getPersonname() != null && !"".equals(personnel.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnel.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnel.getPersonname() + "'";
				}
			}
			if(personnel.getSexes() != null && !"".equals(personnel.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + personnel.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + personnel.getSexes() + "'";
				}
			}
			if(personnel.getNation() != null && !"".equals(personnel.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 LIKE '" + personnel.getNation() + "'";
				}else{
					operate_Condition += " and 民族 LIKE '" + personnel.getNation() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 LIKE '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 LIKE '" + personnel.getPersontype() + "'";
				}
			}
			if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}
			}
			if(personnel.getWorkplace() != null && !"".equals(personnel.getWorkplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}else{
					operate_Condition += " and 工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}
			}
			if(personnel.getHomepolice() != null && !"".equals(personnel.getHomepolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}else{
					operate_Condition += " and 现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}
			}
			if(personnel.getWorkpolice() != null && !"".equals(personnel.getWorkpolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}else{
					operate_Condition += " and 工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		//return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/importHeiPersonel.do")
	@ResponseBody
    public   Map<String, Object>  importHeiPersonel(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	Map<String, Object> json = new HashMap<String, Object>();  
    	String msg = "";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	System.out.println("importHeiPersonel.do.......................");
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	String addtime=dateFormat.format(new Date());
    	try{
    	  String fileName = myFile.getOriginalFilename();
          String fileType = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
          Sheet sheet;
          int totalRows=0;
            Workbook workbook=WorkbookFactory.create(myFile.getInputStream());
            sheet=workbook.getSheetAt(0);
            totalRows=sheet.getPhysicalNumberOfRows();//返回索引
            Row rowdata;
            System.out.println("importHeiPersonel.do.......................fileName="+fileName+"   totalRows="+totalRows);
            for (int i =1; i < totalRows; i++) {
            	rowdata=sheet.getRow(i);
            	 int rownum=i+1;
            	 rowmsg=" 第2行 至 第"+totalRows+"行<br/>"; 
            	//System.out.println("开始读取.......................读取行号="+rownum+"   身份证号码="+rowdata.getCell(0).getStringCellValue());
            	 if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
              	   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){
              		   if(rownum>2)rowmsg=" 第2行 至 第"+i+"行<br/>"; 
              		   else rowmsg="<font color='red'>无数据导入</font><br/>";
              		   break;
              	   }
              	   btmsg+="第"+rownum+"行，第一列无序号；"+"<br/>"; 
                 }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
              	   btmsg+="第"+rownum+"行，第二列(身份证号)为必填项；"+"<br/>";
                 }else if(rowdata.getCell(3)==null||rowdata.getCell(3).getCellType()==rowdata.getCell(3).CELL_TYPE_BLANK){           	
              	   btmsg+="第"+rownum+"行，第四列(姓名)为必填项；"+"<br/>";
                 }else{  
              	   rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
              	   rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
              	   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
              	   if(CardnumberCheck.check(rowdata.getCell(1).getStringCellValue())){
              		   int findid=personnelDao.findPersonInPersonnel(rowdata.getCell(0).getStringCellValue());
              		   String unitname="";
              		   int personid=0;
              		   Personnel person=new Personnel();
              		   HeiEditor heieditor=new HeiEditor();
                  	   if(findid>0){
                  		   //btmsg+="第"+rownum+"行，第二列(身份证号)已存在；"+"<br/>";   //暂时未处理身份证已存在数据覆盖问题，需确认数据更新顺序
                  		   person=personnelDao.getById(findid);
                  		   personid=findid;
                  		   String zslabel1=person.getZslabel1();
                  		   if(!"".equals(zslabel1))zslabel1+=",";
                  		   zslabel1+="3";
                  		   person.setZslabel1(zslabel1);
                  		   person.setUpdatetime(addtime);
                  		   person.setUpdateoperator("黄晶晶");
                  	   }else {
                  		   /*****风险人员主表添加*****/
                  		   person.setCardnumber(rowdata.getCell(1).getStringCellValue());
                  		   person.setPersonname(rowdata.getCell(3).getStringCellValue());
                  		   person.setZslabel1("3");//标签 涉黑-3
                  		   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(1).getStringCellValue()));
                  		   person.setValidflag(1);
                  		   person.setAddoperator("黄晶晶");//hei 默认建档人 黄晶晶--userid：2530
                  		   person.setAddoperatorid(2530);
                  		   person.setAddtime(addtime);
                  		   personid=personnelDao.add(person);
                  		   person=personnelDao.getById(personid);
                  		   
                  		   /*****默认添加空关联信息*****/
                  		   Relation relation=new Relation();
                  		   relation.setPersonnelid(personid);
                  		   relationDao.addrelation(relation);
                  		   String ybssid = kaKouDao.findYbssRkByCardnumber(rowdata.getCell(1).getStringCellValue());
	                  		 /*****一标三识数据关联*****/
	           				if(!"0".equals(ybssid)){
	           					Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
	           					person.setPersontype(ybssPersonnel.getPersontype());
	           					person.setNation(ybssPersonnel.getNation());
	           					person.setMarrystatus(ybssPersonnel.getMarrystatus());
	           					person.setEducation(ybssPersonnel.getEducation());
	           					person.setHouseplace(ybssPersonnel.getHouseplace());
	           					if(rowdata.getCell(4)==null)person.setHomeplace(ybssPersonnel.getHomeplace());
	           					person.setHomex(ybssPersonnel.getHomex());
	        					person.setHomey(ybssPersonnel.getHomey());
	           					person.setWorkplace(ybssPersonnel.getWorkplace());
	           					if(rowdata.getCell(6)==null&&ybssPersonnel.getTelnumber()!=null&&!"".equals(ybssPersonnel.getTelnumber())){
	           						String[] telnumbers=ybssPersonnel.getTelnumber().split(";");
	           						for (int j = 0; j < telnumbers.length; j++) {
	           							if(!"".equals(telnumbers[j])&&telnumbers[j].length()>10){
	           								RelationTelnumber relationtelnumber=new RelationTelnumber();
	           								relationtelnumber.setPersonnelid(personid);
	           								relationtelnumber.setTelnumber(telnumbers[j]);
	           								relationtelnumber.setAddtime(addtime);
	           								relationtelnumber.setAddoperator("黄晶晶");
	           								relationDao.addrelationtelnumber(relationtelnumber);
	           							}
	           						}
	           					}
	           				}
                  		   
							/*****修改社会关系中人员风险类别*****/
							SocialRelations socialrelations=new SocialRelations();
							socialrelations.setUpdateoperator(userSession.getLoginUserName());
							socialrelations.setUpdatetime(addtime);
							socialrelations.setCardnumber(person.getCardnumber());
							relationDao.updateriskpersonnel(socialrelations);
                  	   }
                  	   if(rowdata.getCell(4)!=null){//现住地详址
                  		   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                  		   person.setHomeplace(rowdata.getCell(4).getStringCellValue());
                  	   }
                  	   if(rowdata.getCell(5)!=null){//现住地派出所
                  		   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                  		   unitname=rowdata.getCell(5).getStringCellValue();
                  		   person.setHomepolice(unitname);
                  	   }
                  	   if(rowdata.getCell(6)!=null){//手机号
                  		   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                  		   String telnumber=rowdata.getCell(6).getStringCellValue();
                  		   if (!"".equals(telnumber)) {
                  			 String[] telnumbers=telnumber.split(";");
    						for (int j = 0; j < telnumbers.length; j++) {
    							if(!"".equals(telnumbers[j])&&telnumbers[j].length()>10){
    								RelationTelnumber relationtelnumber=new RelationTelnumber();
    								relationtelnumber.setPersonnelid(personid);
    								relationtelnumber.setTelnumber(telnumbers[j]);
    								relationtelnumber.setAddtime(addtime);
    								relationtelnumber.setAddoperator("黄晶晶");
    								relationDao.addrelationtelnumber(relationtelnumber);
    							}
    						}
                  		   }
                  	   }
                  	   personnelDao.update(person);
                  	   /*****添加涉黑子表信息*****/
                  	   if(!"".equals(unitname)){
                  		   String editableid="1,2378,2265,2498,2485,2148,2483,2723",editablename="管理员,石良红,华军,余军,徐刚,朱敏华,魏泽君,刘晔乾";
                  		   if("要塞派出所".equals(unitname)){
                  			   editableid+=",2247,2126,2141";
                  			   editablename+=",陈华,陈正华,葛志星";
                  		   }
                  		   if("君山派出所".equals(unitname)){
                  			   editableid+=",2247,2126,2590";
                  			   editablename+=",陈华,陈正华,王伟";
                  		   }
                  		   if("城中派出所".equals(unitname)){
                  			   editableid+=",2247,2126,2342";
                  			   editablename+=",陈华,陈正华,刘鸣峰";
                  		   }
                  		   if("西郊派出所".equals(unitname)){
                  			   editableid+=",2247,2126,2965";
                  			   editablename+=",陈华,陈正华,耿澄城";
                  		   }
                  		   if("申港派出所".equals(unitname)){
                  			   editableid+=",2247,221,2162";
                  			   editablename+=",陈华,王丰恺,吴明";
                  		   }
                  		   if("利港派出所".equals(unitname)){
                  			   editableid+=",2247,221,2391";
                  			   editablename+=",陈华,王丰恺,邓晓华";
                  		   }
                  		   if("夏港派出所".equals(unitname)){
                  			   editableid+=",2247,221,2749";
                  			   editablename+=",陈华,王丰恺,顾江涛";
                  		   }
                  		   if("璜土派出所".equals(unitname)){
                  			   editableid+=",2247,221,2161";
                  			   editablename+=",陈华,王丰恺,殷智源";
                  		   }
                  		   if("城东派出所".equals(unitname)){
                  			   editableid+=",3344,2193,2527";
                  			   editablename+=",田晓军,赵海,张少石";
                  		   }
                  		   if("滨江派出所".equals(unitname)){
                  			   editableid+=",3344,2193,2918";
                  			   editablename+=",田晓军,赵海,冯钢";
                  		   }
                  		   if("云亭派出所".equals(unitname)){
                  			   editableid+=",3344,2193,2433";
                  			   editablename+=",田晓军,赵海,谢纪锋";
                  		   }
                  		   if("南闸派出所".equals(unitname)){
                  			   editableid+=",3344,2193,2147";
                  			   editablename+=",田晓军,赵海,庄熠";
                  		   }
                  		   if("周庄派出所".equals(unitname)){
                  			   editableid+=",3344,2241,2788";
                  			   editablename+=",田晓军,龚勇,卞利清";
                  		   }
                  		   if("三房巷派出所".equals(unitname)){
                  			   editableid+=",3344,2241,2700";
                  			   editablename+=",田晓军,龚勇,冯铭";
                  		   }
                  		   if("华士派出所".equals(unitname)){
                  			   editableid+=",3344,2241,2613";
                  			   editablename+=",田晓军,龚勇,沈昭华";
                  		   }
                  		   if("华西派出所".equals(unitname)){
                  			   editableid+=",3344,2241,2867";
                  			   editablename+=",田晓军,龚勇,吴成鸣";
                  		   }
                  		   if("新桥派出所".equals(unitname)){
                  			   editableid+=",3344,2241,2404";
                  			   editablename+=",田晓军,龚勇,章升溢";
                  		   }
                  		   if("青阳派出所".equals(unitname)){
                  			   editableid+=",2544,2665,2638";
                  			   editablename+=",唐黎翔,徐轶泽,陆伟";
                  		   }
                  		   if("月城派出所".equals(unitname)){
                  			   editableid+=",2544,2665,2504";
                  			   editablename+=",唐黎翔,徐轶泽,冯本度";
                  		   }
                  		   if("徐霞客派出所".equals(unitname)){
                  			   editableid+=",2544,2665,2396";
                  			   editablename+=",唐黎翔,徐轶泽,卫锡锋";
                  		   }
                  		   if("峭岐派出所".equals(unitname)){
                  			   editableid+=",2544,2665,2174";
                  			   editablename+=",唐黎翔,徐轶泽,季平";
                  		   }
                  		   if("长泾派出所".equals(unitname)){
                  			   editableid+=",2544,2599,2276";
                  			   editablename+=",唐黎翔,徐盟,苏磊";
                  		   }
                  		   if("顾山派出所".equals(unitname)){
                  			   editableid+=",2544,2599,2800";
                  			   editablename+=",唐黎翔,徐盟,陈可为";
                  		   }
                  		   if("祝塘派出所".equals(unitname)){
                  			   editableid+=",2544,2599,2257";
                  			   editablename+=",唐黎翔,徐盟,王道祥";
                  		   }
                  		   if("水上派出所".equals(unitname)){
                  			   editableid+=",2544,2456";
                  			   editablename+=",唐黎翔,吴涛";
                  		   }
                  		   
                  		   heieditor.setEditableid(editableid);
                  		   heieditor.setEditablename(editablename);
                  	   }
                  	   heieditor.setPersonnelid(personid);
                  	   heieditor.setAddoperator("黄晶晶");
                  	   heieditor.setAddoperatorid(2530);
                  	   heieditor.setDepartmentid(78);
                  	   heieditor.setAddtime(addtime);
                  	   heieditor.setIncontrolleve(2);
                  	   heiEditorDao.add(heieditor);
                  	   pCount++;
              	   }else {
              		   btmsg+="第"+rownum+"行，第二列(身份证号)格式错误；"+"<br/>"; 
              	   }
                 } 
            }
        	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
        	msg+="<tr><td>成功导入：</td><td>风险人员（涉黑）<font color='red'>"+pCount+"</font> 名</td></tr>";
        	if(btmsg!=""){
        		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
        		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
        	}
        	msg+="</table>";
            json.put("success",msg);
            logDao.recordLog(0, "风险人员-涉黑人员-信息导入", userSession.getLoginUserName(), addtime, "导出成功", "");
    } catch (Exception e) {
        e.printStackTrace();
        logDao.recordLog(0, "风险人员-涉黑人员-信息导入", userSession.getLoginUserName(), addtime, "导出失败", "");
    }   
       return json;  
    }
	
	
}
