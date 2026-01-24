package com.szrj.business.impl.position;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.position.OrganizationDao;
import com.szrj.business.model.position.Organization;
import com.szrj.business.model.position.OrganizationPerson;
import com.szrj.business.model.position.WorkRecord;

public class OrganizationDaoImpl extends BaseDaoiBatis implements OrganizationDao {

	public int add(Organization organization) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("organization.addOrganization",organization);
	}

	public int addOrganizationPerson(OrganizationPerson organizationPerson)throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("organization.addOrganizationPerson",organizationPerson);
	}

	public int cancel(Organization organization) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("organization.cancelOrganization", organization);
	}

	public int cancelOrganizationPerson(OrganizationPerson organizationPerson)throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("organization.cancelOrganizationPerson", organizationPerson);
	}

	public Organization getById(int id) throws DataAccessException {
		return (Organization)getSqlMapClientTemplate().queryForObject("organization.organizationgetById",id);
	}

	@SuppressWarnings("unchecked")
	public List<OrganizationPerson> getOrganizationPersonListByOrgid(int orgid) throws DataAccessException {
		return (List<OrganizationPerson>)getSqlMapClientTemplate().queryForList("organization.getOrganizationPersonListByOrgid", orgid);
	}

	public OrganizationPerson getOrganizationPersonnById(int id) throws DataAccessException {
		return (OrganizationPerson)getSqlMapClientTemplate().queryForObject("organization.getOrganizationPersonnById", id);
	}

	public NewPageModel searchOrgPersonnel(OrganizationPerson organizationPerson, NewPageModel pm)throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("organization.searchOrganizationPerson_count", organizationPerson);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("organization.searchOrganizationPerson",organizationPerson,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchOrganization(Organization organization,NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("organization.searchOrganization_count", organization);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("organization.searchOrganization",organization,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	public int update(Organization organization) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("organization.updateOrganization", organization);
	}

	public int updateOrganizationPerson(OrganizationPerson organizationPerson)throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("organization.updateOrganizationPerson", organizationPerson);
	}

	public int addWorkRecord(WorkRecord workRecord) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("organization.addWorkRecord",workRecord);
	}

	public int cancelWorkRecord(WorkRecord workRecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("organization.cancelWorkRecord", workRecord);
	}

	public WorkRecord getWorkRecordById(int id) throws DataAccessException {
		return (WorkRecord)getSqlMapClientTemplate().queryForObject("organization.getWorkRecordById", id);
	}

	public NewPageModel searchWorkRecord(WorkRecord workRecord, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("organization.searchWorkRecord_count", workRecord);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("organization.searchWorkRecord",workRecord,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	public int updateWorkRecord(WorkRecord workRecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("organization.updateWorkRecord", workRecord);
	}

}
