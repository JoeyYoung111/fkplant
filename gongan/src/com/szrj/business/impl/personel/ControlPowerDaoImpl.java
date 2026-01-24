package com.szrj.business.impl.personel;

import com.aladdin.model.NewPageModel;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.personel.ControlPowerDao;
import com.szrj.business.model.personel.ControlPower;


public class ControlPowerDaoImpl extends BaseDaoiBatis implements ControlPowerDao {

    @Override
    public void add(ControlPower controlpower) {
        getSqlMapClientTemplate().insert("controlpower.add", controlpower);
    }

    @Override
    public void update(ControlPower controlpower) {
        getSqlMapClientTemplate().update("controlpower.update", controlpower);
    }

    @Override
    public void cancel(ControlPower controlpower) {
        getSqlMapClientTemplate().update("controlpower.cancel", controlpower);
    }

    @Override
    public ControlPower getById(int id) {
        return (ControlPower) getSqlMapClientTemplate().queryForObject("controlpower.getById", id);
    }

    @Override
    public void delete(int id) {
        getSqlMapClientTemplate().update("controlpower.delete", id);
    }

    @Override
    public NewPageModel searchcontrolpower(int personnelid, NewPageModel pm) throws DataAccessException {
        // 查询总记录数
        int total = (Integer) getSqlMapClientTemplate().queryForObject("controlpower.searchcontrolpower_count", personnelid);
        pm.setTotal(total);
        pm.setup();
        // 查询分页数据
        pm.setRows(getSqlMapClientTemplate().queryForList("controlpower.searchcontrolpower", personnelid, pm.getStart(), pm.getTruepagesize()));
        return pm;
    }
}