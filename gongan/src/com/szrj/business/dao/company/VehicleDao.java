package com.szrj.business.dao.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.model.company.Vehicle;

/**
 * 风险车辆
 * @author 李昊
 * Sep 24, 2021
 */
public interface VehicleDao {

	/**
	 * 查询全部 分页
	 * @param Check
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchVehicle(Vehicle vehicle, NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public Vehicle getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param Check
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Vehicle vehicle) throws DataAccessException;
	
	/**
	 * 删除
	 * @param Check
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(Vehicle vehicle) throws DataAccessException;
	
	/**
	 * 修改
	 * @return
	 * @throws DataAccessException
	 */
	public int update(Vehicle vehicle) throws DataAccessException;
	
	/**
	 * 级联修改
	 * @param vehicle
	 * @return
	 * @throws DataAccessException
	 */
	public int upVehCompanyName(Vehicle vehicle) throws DataAccessException;
	
	public int checkCP(String vehicleno) throws DataAccessException;
	
	public List<SelectModel> countByVehicletype() throws DataAccessException;
}
