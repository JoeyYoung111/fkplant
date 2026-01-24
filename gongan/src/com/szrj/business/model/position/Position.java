package com.szrj.business.model.position;
/**
 * @author szrj_huaxia
 *政保阵地主表 a_position_t
 */
public class Position {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private String positionname;//名称
	private String positiontype;//阵地级别
	private String positioncharacter;//阵地类别
	private String foreignname;//外文名称
	private String setuptime;//成立时间
	private String setupplace;//成立地点
	private String address;//详细地址
	private String placearea;//占地面积
	private String personnum;//涉及人数
	private String chargeunit;//主管政府部门或单位
	private String positionsurvey;//阵地概况
	private String jdunit;//管控单位
	private String jdpolice;//管控民警
	private String jdphone;//联系电话(长号)
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String unitname;//管辖责任单位名称
	private String policename;//管辖责任民警名称
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段 
	private int personnelid;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPositionname() {
		return positionname;
	}
	public void setPositionname(String positionname) {
		this.positionname = positionname;
	}
	public String getPositiontype() {
		return positiontype;
	}
	public void setPositiontype(String positiontype) {
		this.positiontype = positiontype;
	}
	public String getPositioncharacter() {
		return positioncharacter;
	}
	public void setPositioncharacter(String positioncharacter) {
		this.positioncharacter = positioncharacter;
	}
	public String getForeignname() {
		return foreignname;
	}
	public void setForeignname(String foreignname) {
		this.foreignname = foreignname;
	}
	public String getSetuptime() {
		return setuptime;
	}
	public void setSetuptime(String setuptime) {
		this.setuptime = setuptime;
	}
	public String getSetupplace() {
		return setupplace;
	}
	public void setSetupplace(String setupplace) {
		this.setupplace = setupplace;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPlacearea() {
		return placearea;
	}
	public void setPlacearea(String placearea) {
		this.placearea = placearea;
	}
	public String getPersonnum() {
		return personnum;
	}
	public void setPersonnum(String personnum) {
		this.personnum = personnum;
	}
	public String getChargeunit() {
		return chargeunit;
	}
	public void setChargeunit(String chargeunit) {
		this.chargeunit = chargeunit;
	}
	public String getPositionsurvey() {
		return positionsurvey;
	}
	public void setPositionsurvey(String positionsurvey) {
		this.positionsurvey = positionsurvey;
	}
	public String getJdunit() {
		return jdunit;
	}
	public void setJdunit(String jdunit) {
		this.jdunit = jdunit;
	}
	public String getJdpolice() {
		return jdpolice;
	}
	public void setJdpolice(String jdpolice) {
		this.jdpolice = jdpolice;
	}
	public String getJdphone() {
		return jdphone;
	}
	public void setJdphone(String jdphone) {
		this.jdphone = jdphone;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getAddoperator() {
		return addoperator;
	}
	public void setAddoperator(String addoperator) {
		this.addoperator = addoperator;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getUpdateoperator() {
		return updateoperator;
	}
	public void setUpdateoperator(String updateoperator) {
		this.updateoperator = updateoperator;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getPersonFilter() {
		return personFilter;
	}
	public void setPersonFilter(int personFilter) {
		this.personFilter = personFilter;
	}
	public int getUnitFilter() {
		return unitFilter;
	}
	public void setUnitFilter(int unitFilter) {
		this.unitFilter = unitFilter;
	}
	public String getUnitname() {
		return unitname;
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public String getPolicename() {
		return policename;
	}
	public void setPolicename(String policename) {
		this.policename = policename;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	
}
