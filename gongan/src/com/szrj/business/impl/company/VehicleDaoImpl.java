package com.szrj.business.impl.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.dao.company.VehicleDao;
import com.szrj.business.model.company.Vehicle;

public class VehicleDaoImpl extends BaseDaoiBatis implements VehicleDao {

	public int add(Vehicle vehicle) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("vehicle.add", vehicle);
	}

	public int cancel(Vehicle vehicle) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("vehicle.cancel", vehicle);
	}

	public Vehicle getById(int id) throws DataAccessException {
		return (Vehicle)getSqlMapClientTemplate().queryForObject("vehicle.getById",id);
	}

	public NewPageModel searchVehicle(Vehicle vehicle, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("vehicle.searchVehicle_count", vehicle);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("vehicle.searchVehicle", vehicle, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(Vehicle vehicle) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("vehicle.update", vehicle);
	}

	public int upVehCompanyName(Vehicle vehicle) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("vehicle.upVehCompanyName", vehicle);
	}

	public int checkCP(String vehicleno) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("vehicle.checkCP",vehicleno);
	}

	public List<SelectModel> countByVehicletype() throws DataAccessException {
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList("vehicle.countByVehicletype");
	}

	
}
