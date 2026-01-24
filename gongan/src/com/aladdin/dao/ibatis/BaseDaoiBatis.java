package com.aladdin.dao.ibatis;

import java.io.Serializable;
import java.util.List;


import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.jdbc.core.JdbcTemplate;
import com.aladdin.dao.ibatis.ext.LimitSqlExecutor;
//import com.aladdin.domain.BaseObject;
import com.aladdin.util.ReflectUtil;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.engine.execution.SqlExecutor;
import com.ibatis.sqlmap.engine.impl.ExtendedSqlMapClient;

import javax.sql.DataSource;

public abstract class BaseDaoiBatis extends SqlMapClientDaoSupport {
    private SqlExecutor sqlExecutor;

    public SqlExecutor getSqlExecutor() {
        return sqlExecutor;
    }

    public void setSqlExecutor(SqlExecutor sqlExecutor) {
        this.sqlExecutor = sqlExecutor;
    }

    public void setEnableLimit(boolean enableLimit) {
        if (sqlExecutor instanceof LimitSqlExecutor) {
            ((LimitSqlExecutor) sqlExecutor).setEnableLimit(enableLimit);
        }
    }

    public void initialize() throws Exception {
        if (sqlExecutor != null) {
            SqlMapClient sqlMapClient = getSqlMapClientTemplate().getSqlMapClient();
            if (sqlMapClient instanceof ExtendedSqlMapClient) {
                ReflectUtil.setFieldValue(((ExtendedSqlMapClient) sqlMapClient).getDelegate(), "sqlExecutor", SqlExecutor.class, sqlExecutor);
            }
        }
    }

    public int getQueryCount(String sql) {
        int cc = 0;
        if (sqlExecutor instanceof LimitSqlExecutor) {
            cc = ((LimitSqlExecutor) sqlExecutor).getQueryCount(super.getDataSource(), sql);
        }
        return cc;
    }
}