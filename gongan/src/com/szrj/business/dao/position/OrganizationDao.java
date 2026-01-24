package com.szrj.business.dao.position;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.position.Organization;
import com.szrj.business.model.position.OrganizationPerson;
import com.szrj.business.model.position.WorkRecord;

public interface OrganizationDao {
	/******组织主表******/
	public NewPageModel searchOrganization(Organization organization, NewPageModel pm) throws DataAccessException;
	public Organization getById(int id) throws DataAccessException;
	public int add(Organization organization) throws DataAccessException;
	public int update(Organization organization) throws DataAccessException;
	public int cancel(Organization organization) throws DataAccessException;
	/******组织人员************/
	public NewPageModel searchOrgPersonnel(OrganizationPerson organizationPerson,NewPageModel pm) throws DataAccessException;
	public OrganizationPerson getOrganizationPersonnById(int id) throws DataAccessException;
	public int addOrganizationPerson(OrganizationPerson organizationPerson) throws DataAccessException;
	public int updateOrganizationPerson(OrganizationPerson organizationPerson) throws DataAccessException;
	public int cancelOrganizationPerson(OrganizationPerson organizationPerson) throws DataAccessException;
	public List<OrganizationPerson> getOrganizationPersonListByOrgid(int orgid) throws DataAccessException;
	/******民警工作记载************/
	public NewPageModel searchWorkRecord(WorkRecord workRecord,NewPageModel pm) throws DataAccessException;
	public WorkRecord getWorkRecordById(int id) throws DataAccessException;
	public int addWorkRecord(WorkRecord workRecord) throws DataAccessException;
	public int updateWorkRecord(WorkRecord workRecord) throws DataAccessException;
	public int cancelWorkRecord(WorkRecord workRecord) throws DataAccessException;
	
}
