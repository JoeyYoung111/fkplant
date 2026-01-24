package com.szrj.business.web.inferfaces;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.RoleUserDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.LwUserDao;
import com.szrj.business.model.Department;
import com.szrj.business.model.RoleUser;
import com.szrj.business.model.User;

@Controller
@SessionAttributes("userSession")
public class LwUserController {
	@Autowired
	private LwUserDao lwUserDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleUserDao roleUserDao;
	@Autowired
	private DepartmentDao departmentDao;
	
	@RequestMapping("/updateLingwuUsers.do")
	public void updateLingwuUsers(){
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		
		try {
			Department department=new Department();
			department.setDeparttype("0");
			List<Department> departmentList=departmentDao.getDepartmentList(department);
			
			for (int i = 0; i < departmentList.size(); i++) {
				if(departmentList.get(i).getLingwuid()!=null&&!"".equals(departmentList.get(i).getLingwuid())){
					List<User> lwusers=lwUserDao.getUsersByDepartmentLingwuid(departmentList.get(i).getLingwuid());
					for (int j = 0; j < lwusers.size(); j++) {
						int userid=userDao.getUserInUse(lwusers.get(j).getUsercode());
						if(userid>0){
							User oldUser=userDao.getById(userid);
							int before_departmentid=oldUser.getDepartmentid();
							oldUser.setUsercode(lwusers.get(j).getUsercode());
							oldUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
							oldUser.setStaffName(lwusers.get(j).getStaffName());
							oldUser.setCardnumber(lwusers.get(j).getCardnumber());
							oldUser.setSexes(lwusers.get(j).getSexes());
							oldUser.setContactnumber(lwusers.get(j).getContactnumber());
							oldUser.setBefore_departmentid(before_departmentid);
							oldUser.setDepartmentid(departmentList.get(i).getId());
							oldUser.setDpName(departmentList.get(i).getDepartname());
							oldUser.setMemo("lingwu_update："+addtime);
							userDao.update(oldUser);
						}else {
							if(lwusers.get(j).getAlarmsignal()!=null&&!"".equals(lwusers.get(j).getAlarmsignal())){
								userid=userDao.getUserInUse(lwusers.get(j).getAlarmsignal());
								if (userid>0) {
									User oldUser=userDao.getById(userid);
									int before_departmentid=oldUser.getDepartmentid();
									oldUser.setUsercode(lwusers.get(j).getUsercode());
									oldUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
									oldUser.setStaffName(lwusers.get(j).getStaffName());
									oldUser.setCardnumber(lwusers.get(j).getCardnumber());
									oldUser.setSexes(lwusers.get(j).getSexes());
									oldUser.setContactnumber(lwusers.get(j).getContactnumber());
									oldUser.setBefore_departmentid(before_departmentid);
									oldUser.setDepartmentid(departmentList.get(i).getId());
									oldUser.setDpName(departmentList.get(i).getDepartname());
									oldUser.setMemo("lingwu_update："+addtime);
									userDao.update(oldUser);
								} else {
									if(lwusers.get(j).getContactnumber()!=null&&!"".equals(lwusers.get(j).getContactnumber())){
										userid=userDao.getUserInUse(lwusers.get(j).getContactnumber());
										if (userid>0) {
											User oldUser=userDao.getById(userid);
											int before_departmentid=oldUser.getDepartmentid();
											oldUser.setUsercode(lwusers.get(j).getUsercode());
											oldUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
											oldUser.setStaffName(lwusers.get(j).getStaffName());
											oldUser.setCardnumber(lwusers.get(j).getCardnumber());
											oldUser.setSexes(lwusers.get(j).getSexes());
											oldUser.setContactnumber(lwusers.get(j).getContactnumber());
											oldUser.setBefore_departmentid(before_departmentid);
											oldUser.setDepartmentid(departmentList.get(i).getId());
											oldUser.setDpName(departmentList.get(i).getDepartname());
											oldUser.setMemo("lingwu_update："+addtime);
											userDao.update(oldUser);
										} else {
											User newUser=new User();
											newUser.setAddoperator("system_lingwu");
											newUser.setAddtime(addtime);
											newUser.setUsercode(lwusers.get(j).getUsercode());
											newUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
											newUser.setUserpassword("e10adc3949ba59abbe56e057f20f883e");
											newUser.setStaffName(lwusers.get(j).getStaffName());
											newUser.setCardnumber(lwusers.get(j).getCardnumber());
											newUser.setSexes(lwusers.get(j).getSexes());
											newUser.setContactnumber(lwusers.get(j).getContactnumber());
											newUser.setDepartmentid(departmentList.get(i).getId());
											newUser.setDpName(departmentList.get(i).getDepartname());
											newUser.setValidflag(1);
											newUser.setRoleid(31);
											int a=userDao.add(newUser);
											RoleUser roleUser=new RoleUser();	
											roleUser.setRoleid(31);
										    roleUser.setUserid(a);
											roleUser.setAddtime(addtime);
											roleUser.setValidflag(1);
											roleUser.setAddoperator("system_lingwu");
											roleUserDao.add(roleUser);
										}
									}else {
										User newUser=new User();
										newUser.setAddoperator("system_lingwu");
										newUser.setAddtime(addtime);
										newUser.setUsercode(lwusers.get(j).getUsercode());
										newUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
										newUser.setUserpassword("e10adc3949ba59abbe56e057f20f883e");
										newUser.setStaffName(lwusers.get(j).getStaffName());
										newUser.setCardnumber(lwusers.get(j).getCardnumber());
										newUser.setSexes(lwusers.get(j).getSexes());
										newUser.setContactnumber(lwusers.get(j).getContactnumber());
										newUser.setDepartmentid(departmentList.get(i).getId());
										newUser.setDpName(departmentList.get(i).getDepartname());
										newUser.setValidflag(1);
										newUser.setRoleid(31);
										int a=userDao.add(newUser);
										RoleUser roleUser=new RoleUser();	
										roleUser.setRoleid(31);
									    roleUser.setUserid(a);
										roleUser.setAddtime(addtime);
										roleUser.setValidflag(1);
										roleUser.setAddoperator("system_lingwu");
										roleUserDao.add(roleUser);
									}
								}
							}else {
								if(lwusers.get(j).getContactnumber()!=null&&!"".equals(lwusers.get(j).getContactnumber())){
									userid=userDao.getUserInUse(lwusers.get(j).getContactnumber());
									if (userid>0) {
										User oldUser=userDao.getById(userid);
										int before_departmentid=oldUser.getDepartmentid();
										oldUser.setUsercode(lwusers.get(j).getUsercode());
										oldUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
										oldUser.setStaffName(lwusers.get(j).getStaffName());
										oldUser.setCardnumber(lwusers.get(j).getCardnumber());
										oldUser.setSexes(lwusers.get(j).getSexes());
										oldUser.setContactnumber(lwusers.get(j).getContactnumber());
										oldUser.setBefore_departmentid(before_departmentid);
										oldUser.setDepartmentid(departmentList.get(i).getId());
										oldUser.setDpName(departmentList.get(i).getDepartname());
										oldUser.setMemo("lingwu_update："+addtime);
										userDao.update(oldUser);
									} else {
										User newUser=new User();
										newUser.setAddoperator("system_lingwu");
										newUser.setAddtime(addtime);
										newUser.setUsercode(lwusers.get(j).getUsercode());
										newUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
										newUser.setUserpassword("e10adc3949ba59abbe56e057f20f883e");
										newUser.setStaffName(lwusers.get(j).getStaffName());
										newUser.setCardnumber(lwusers.get(j).getCardnumber());
										newUser.setSexes(lwusers.get(j).getSexes());
										newUser.setContactnumber(lwusers.get(j).getContactnumber());
										newUser.setDepartmentid(departmentList.get(i).getId());
										newUser.setDpName(departmentList.get(i).getDepartname());
										newUser.setValidflag(1);
										newUser.setRoleid(31);
										int a=userDao.add(newUser);
										RoleUser roleUser=new RoleUser();	
										roleUser.setRoleid(31);
									    roleUser.setUserid(a);
										roleUser.setAddtime(addtime);
										roleUser.setValidflag(1);
										roleUser.setAddoperator("system_lingwu");
										roleUserDao.add(roleUser);
									}
								}else {
									User newUser=new User();
									newUser.setAddoperator("system_lingwu");
									newUser.setAddtime(addtime);
									newUser.setUsercode(lwusers.get(j).getUsercode());
									newUser.setAlarmsignal(lwusers.get(j).getAlarmsignal());
									newUser.setUserpassword("e10adc3949ba59abbe56e057f20f883e");
									newUser.setStaffName(lwusers.get(j).getStaffName());
									newUser.setCardnumber(lwusers.get(j).getCardnumber());
									newUser.setSexes(lwusers.get(j).getSexes());
									newUser.setContactnumber(lwusers.get(j).getContactnumber());
									newUser.setDepartmentid(departmentList.get(i).getId());
									newUser.setDpName(departmentList.get(i).getDepartname());
									newUser.setValidflag(1);
									newUser.setRoleid(31);
									int a=userDao.add(newUser);
									RoleUser roleUser=new RoleUser();	
									roleUser.setRoleid(31);
								    roleUser.setUserid(a);
									roleUser.setAddtime(addtime);
									roleUser.setValidflag(1);
									roleUser.setAddoperator("system_lingwu");
									roleUserDao.add(roleUser);
								}
							}
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
