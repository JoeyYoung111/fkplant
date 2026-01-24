package com.szrj.business.model.personel;

public class KongControlPower {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;//人员主表id
	private int forcetype;//管控力量类型 1-公共管控力量2-秘密管控力量
	private String personname;//姓名
	private String birthdate;//出生年月
	private String sexes;//性别
	private String interesting;//兴趣爱好
	private String speciality;//特殊技能
	private String partyduty;//党派职务
	private String duty;//职务
	private String nickname;//别名绰号
	private String education;//文化程度
	private String telephone;//电话
	private String address;//家庭住址
	private String lifeplace;//暂住地址
	private String workunit;//工作单位
	private String records;//前科情况
	private String actualstate;//现实表现
	private String purposetask;//建立的目的和任务
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String ids;		//勾选的id列
	/*---------------------------------------get/set-------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public int getForcetype() {
		return forcetype;
	}
	public void setForcetype(int forcetype) {
		this.forcetype = forcetype;
	}
	public String getPersonname() {
		return personname;
	}
	public void setPersonname(String personname) {
		this.personname = personname;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getInteresting() {
		return interesting;
	}
	public void setInteresting(String interesting) {
		this.interesting = interesting;
	}
	public String getSpeciality() {
		return speciality;
	}
	public void setSpeciality(String speciality) {
		this.speciality = speciality;
	}
	public String getPartyduty() {
		return partyduty;
	}
	public void setPartyduty(String partyduty) {
		this.partyduty = partyduty;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLifeplace() {
		return lifeplace;
	}
	public void setLifeplace(String lifeplace) {
		this.lifeplace = lifeplace;
	}
	public String getWorkunit() {
		return workunit;
	}
	public void setWorkunit(String workunit) {
		this.workunit = workunit;
	}
	public String getRecords() {
		return records;
	}
	public void setRecords(String records) {
		this.records = records;
	}
	public String getActualstate() {
		return actualstate;
	}
	public void setActualstate(String actualstate) {
		this.actualstate = actualstate;
	}
	public String getPurposetask() {
		return purposetask;
	}
	public void setPurposetask(String purposetask) {
		this.purposetask = purposetask;
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
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
}
