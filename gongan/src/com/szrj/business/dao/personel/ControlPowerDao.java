package com.szrj.business.dao.personel;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.ControlPower;
import org.springframework.dao.DataAccessException;

/**
 * 管控力量信息数据访问接口
 */
public interface ControlPowerDao {
    
    /**
     * 添加管控力量信息
     * @param controlpower 管控力量信息对象
     */
    void add(ControlPower controlpower);
    
    /**
     * 更新管控力量信息
     * @param controlpower 管控力量信息对象
     */
    void update(ControlPower controlpower);

    void cancel(ControlPower controlpower);
    
    /**
     * 根据ID获取管控力量信息
     * @param id 管控力量信息ID
     * @return 管控力量信息对象
     */
    ControlPower getById(int id);
    
    /**
     * 删除管控力量信息（逻辑删除）
     * @param id 管控力量信息ID
     */
    void delete(int id);
    
    /**
     * 查询管控力量信息
     * @param personnelid 人员ID
     * @param pm 分页模型
     * @return 分页结果
     * @throws DataAccessException 数据访问异常
     */
    NewPageModel searchcontrolpower(int personnelid, NewPageModel pm) throws DataAccessException;
}