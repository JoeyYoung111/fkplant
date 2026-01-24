package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.User;

public interface UserDao {
	
	/**
	 * 查询
	 * @param user
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchUser(User user,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增
	 * @param user
	 * @return
	 * @throws DataAccessException
	 */
	public int add(User user) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @param user
	 * @return
	 * @throws DataAccessException
	 */
	public int update(User user) throws DataAccessException;
	
	/**
	 * 检查该用户名是否正在被使用中
	 * @author xuxj
	 * @param usercode
	 * @return int
	 * @throws DataAccessException
	 */
	public int getUserInUse(String usercode) throws DataAccessException;
	
	/**
	 * 检查登录的用户名和密码是否正确
	 * @author xuxj
	 * @param user
	 * @return int
	 * @throws DataAccessException
	 */
	public int checkUserMsg(User user) throws DataAccessException;
	
	/**
	 * 根据登录账号和密码查询用户信息
	 * @author xuxj
	 * @param user
	 * @return User
	 * @throws DataAccessException
	 */
	public User getUserByCodeAndPwd(User user) throws DataAccessException;
	
	/**
	 * 根据ID查询
	 * @author xuxj
	 * @param id
	 * @return User
	 * @throws DataAccessException
	 */
	public User getById(int id) throws DataAccessException;
	public User getByCardnumber(String cardnumber) throws DataAccessException;
	/**
	 * 修改密码
	 * @author xuxj
	 * @param user
	 * @return int
	 * @throws DataAccessException
	 */
	public int changePWD(User user) throws DataAccessException;
	
   /**
	 * 获取角色id为roleid的所有用户
	 * @param user
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public List<User> getRoleUser(int roleid) throws DataAccessException;
	/**
	 * 
	 * @param user
	 * @return
	 * @throws DataAccessException
	 */
	public int revStop(User user) throws DataAccessException;
	
	/**
	 * 根据部门id获取用户列表
	 * @param departmentid
	 * @return
	 * @throws DataAccessException
	 */
	public List<User> getUsersByDepartmentid(int departmentid) throws DataAccessException;
	
	/**
	 *  根据部门ID查询人员除去部分人员
	 * @param departmentid
	 * @return
	 * @throws DataAccessException
	 */
	public List<User> getByDepartmentidNotin(User user) throws DataAccessException;
	/**
	 *  根据部门一串id查询多条人员信息
	 * @param departmentid
	 * @return
	 * @throws DataAccessException
	 */
	public List<User> getUserByIds(String departname) throws DataAccessException;
	
	/**
	 * 查询部门下所有人员
	 * @param departname
	 * @return
	 * @throws DataAccessException
	 */
	public List<User> getUsersByDepartids(String departname) throws DataAccessException;
}
