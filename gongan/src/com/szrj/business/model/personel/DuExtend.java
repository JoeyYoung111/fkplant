package com.szrj.business.model.personel;

public class DuExtend {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;//人员主表id
	private String jointcontrollevel;//联控级别  数据字典汉字
	private String incontrollevel;//在控状态  数据字典汉字
	private int jurisdictunit1;//管辖责任单位  必选、默认当前登录人单位
	private int jurisdictpolice1;//管辖责任民警  必选、默认当前登录人id
	private String policephone1;//管辖责任民警手机  自动带出
	private String jurisdictunit2;//双管辖责任单位
	private String jurisdictpolice2;//双管辖责任民警
	private String policephone2;//双管辖责任民警电话
	private int personneltype;//风险人员类别  1-吸毒人员 2-制贩毒前科 3-两者都是
	private String narcoticstype;//毒品种类
	private String firsttime;//初次吸毒时间
	private String lasttime;//末次处罚时间
	private String controlstatus;//管控现状-->评定依据
	private String controlstatusmemo;//管控现状-其他特殊状态
	private int caredperson;//是否平安关爱对象 1-否 2-是
	private String safetyaction;//平安措施
	private String actualstate;//现实表现-->管控现状
	private String attachments;//附件
	private String casename;	//案件名称
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//现实表现-->管控现状-其他备注信息
	private String ptype;//人员类别 与Personnel类别区分 <本地在册/外来前科>
	private String yesorno;//1-人户分离 2-双向管控 3-精神疾病患者 4-病残人员 5-三年内处罚人员
	/*---------------------------------------非数据库中字段-------------------------------------*/
	
	private String cardnumber;//身份证号
	private String personname;//姓名
	private String sexes;//性别
	private String homeplace;//现住地详址
	private String nation;//民族
	private String persontype;//人员类别
	//关联字段
	private String unitname1;//管辖责任单位名称
	private String policename1;//管辖责任民警名称
	private String unitname2;//双管辖责任单位名称
	private String policename2;//双管辖责任民警名称
	private String casenameMsg;
	
	private String checkRecord;//判断是否关联发检记录
	private String startTime;
	private String endTime;
	
	private String duextendid;
	private String filesname;
	private String filesallname;
	
	//显示权限 0-全部 1-派出所 2-民警
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段 
	
	//导出类
	private Personnel exportPersonnel=new Personnel();
	private Relation exportRelation=new Relation();
	
	
	public Personnel getExportPersonnel() {
		return exportPersonnel;
	}
	public void setExportPersonnel(Personnel exportPersonnel) {
		this.exportPersonnel = exportPersonnel;
	}
	public Relation getExportRelation() {
		return exportRelation;
	}
	public void setExportRelation(Relation exportRelation) {
		this.exportRelation = exportRelation;
	}
	public String getFilesname() {
		return filesname;
	}
	public void setFilesname(String filesname) {
		this.filesname = filesname;
	}
	public String getDuextendid() {
		return duextendid;
	}
	public String getFilesallname() {
		return filesallname;
	}
	public void setFilesallname(String filesallname) {
		this.filesallname = filesallname;
	}
	public void setDuextendid(String duextendid) {
		this.duextendid = duextendid;
	}
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
	public String getJointcontrollevel() {
		return jointcontrollevel;
	}
	public void setJointcontrollevel(String jointcontrollevel) {
		this.jointcontrollevel = jointcontrollevel;
	}
	public String getIncontrollevel() {
		return incontrollevel;
	}
	public void setIncontrollevel(String incontrollevel) {
		this.incontrollevel = incontrollevel;
	}
	public int getJurisdictunit1() {
		return jurisdictunit1;
	}
	public void setJurisdictunit1(int jurisdictunit1) {
		this.jurisdictunit1 = jurisdictunit1;
	}
	public int getJurisdictpolice1() {
		return jurisdictpolice1;
	}
	public void setJurisdictpolice1(int jurisdictpolice1) {
		this.jurisdictpolice1 = jurisdictpolice1;
	}
	public String getPolicephone1() {
		return policephone1;
	}
	public void setPolicephone1(String policephone1) {
		this.policephone1 = policephone1;
	}
	public String getJurisdictunit2() {
		return jurisdictunit2;
	}
	public void setJurisdictunit2(String jurisdictunit2) {
		this.jurisdictunit2 = jurisdictunit2;
	}
	public String getJurisdictpolice2() {
		return jurisdictpolice2;
	}
	public void setJurisdictpolice2(String jurisdictpolice2) {
		this.jurisdictpolice2 = jurisdictpolice2;
	}
	public String getPolicephone2() {
		return policephone2;
	}
	public void setPolicephone2(String policephone2) {
		this.policephone2 = policephone2;
	}
	public int getPersonneltype() {
		return personneltype;
	}
	public void setPersonneltype(int personneltype) {
		this.personneltype = personneltype;
	}
	public String getNarcoticstype() {
		return narcoticstype;
	}
	public void setNarcoticstype(String narcoticstype) {
		this.narcoticstype = narcoticstype;
	}
	public String getFirsttime() {
		return firsttime;
	}
	public void setFirsttime(String firsttime) {
		this.firsttime = firsttime;
	}
	public String getLasttime() {
		return lasttime;
	}
	public void setLasttime(String lasttime) {
		this.lasttime = lasttime;
	}
	public String getControlstatus() {
		return controlstatus;
	}
	public void setControlstatus(String controlstatus) {
		this.controlstatus = controlstatus;
	}
	public int getCaredperson() {
		return caredperson;
	}
	public void setCaredperson(int caredperson) {
		this.caredperson = caredperson;
	}
	public String getSafetyaction() {
		return safetyaction;
	}
	public void setSafetyaction(String safetyaction) {
		this.safetyaction = safetyaction;
	}
	public String getActualstate() {
		return actualstate;
	}
	public void setActualstate(String actualstate) {
		this.actualstate = actualstate;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
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
	public String getUnitname1() {
		return unitname1;
	}
	public void setUnitname1(String unitname1) {
		this.unitname1 = unitname1;
	}
	public String getPolicename1() {
		return policename1;
	}
	public void setPolicename1(String policename1) {
		this.policename1 = policename1;
	}
	public String getUnitname2() {
		return unitname2;
	}
	public void setUnitname2(String unitname2) {
		this.unitname2 = unitname2;
	}
	public String getPolicename2() {
		return policename2;
	}
	public void setPolicename2(String policename2) {
		this.policename2 = policename2;
	}
	public String getCardnumber() {
		return cardnumber;
	}
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	public String getPersonname() {
		return personname;
	}
	public void setPersonname(String personname) {
		this.personname = personname;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getControlstatusmemo() {
		return controlstatusmemo;
	}
	public void setControlstatusmemo(String controlstatusmemo) {
		this.controlstatusmemo = controlstatusmemo;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getPersontype() {
		return persontype;
	}
	public void setPersontype(String persontype) {
		this.persontype = persontype;
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
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public String getCheckRecord(){
		return checkRecord;
	}
	public void setCheckRecord(String checkRecord){
		this.checkRecord = checkRecord;
	}
	public String getStartTime(){
		return startTime;
	}
	public void setStartTime(String startTime){
		this.startTime = startTime;
	}
	public String getEndTime(){
		return endTime;
	}
	public void setEndTime(String endTime){
		this.endTime = endTime;
	}
	public String getCasename() {
		return casename;
	}
	public void setCasename(String casename) {
		this.casename = casename;
	}
	public String getCasenameMsg() {
		return casenameMsg;
	}
	public void setCasenameMsg(String casenameMsg) {
		this.casenameMsg = casenameMsg;
	}
	public String getYesorno() {
		return yesorno;
	}
	public void setYesorno(String yesorno) {
		this.yesorno = yesorno;
	}
	
	
}
