package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *分类分级表-涉稳 p_wen_grade_t
 */
public class WenGrade {
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
	private String personneltype;//风险目标人员类别  数据字典id 多选
	private String responsiblepolice;//责任警种  数据字典，存id 多选
	private String awaywill;//上行意愿  高中低
	private int jointcontrollevelapply;//联控级别调整申请  0-未申请1-申请未审核2-已审核通过3-已审核不通过
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	//查询条件
	private String cardnumber;//身份证号
	private String personname;//姓名
	private String homeplace;//现居住地详址
	private String persontype;//户籍类别（人员类别）
	private String sqltype;	//查询语句(风险目标)
	private String sqlpolice;//查询语句(责任警种)
	private String telnumber;//名下手机号
	//补充显示字段
	private String sexes;//性别
	private int maintainrate1;//维护率
	//关联字段
	private String unitname1;//管辖责任单位名称
	private String policename1;//管辖责任民警名称
	private String unitname2;//双管辖责任单位名称
	private String policename2;//双管辖责任民警名称
	private String typename;//风险目标人员类别名称
	private String policename;//责任警种名称
	//显示权限 0-全部 1-派出所 2-民警 3-责任警种
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段 
	private int policeFilter;//警种字段
	private int cdtid;//矛盾ID
	private int workinfoid;			//工作交办ID
	private String deal;
	private String color;
	//排序
	private String sortsql;
	//导出类
	private Personnel exportPersonnel=new Personnel();
	private Relation exportRelation=new Relation();
	private WenRisk exportWenRisk=new WenRisk();
	private RealityShow exportRealityShow=new RealityShow();
	private String conflictdetails;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
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
	public String getPersonneltype() {
		return personneltype;
	}
	public void setPersonneltype(String personneltype) {
		this.personneltype = personneltype;
	}
	public String getResponsiblepolice() {
		return responsiblepolice;
	}
	public void setResponsiblepolice(String responsiblepolice) {
		this.responsiblepolice = responsiblepolice;
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
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getPersontype() {
		return persontype;
	}
	public void setPersontype(String persontype) {
		this.persontype = persontype;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public int getMaintainrate1() {
		return maintainrate1;
	}
	public void setMaintainrate1(int maintainrate1) {
		this.maintainrate1 = maintainrate1;
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
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getPolicename() {
		return policename;
	}
	public void setPolicename(String policename) {
		this.policename = policename;
	}
	public String getSqltype() {
		return sqltype;
	}
	public void setSqltype(String sqltype) {
		this.sqltype = sqltype;
	}
	public String getSqlpolice() {
		return sqlpolice;
	}
	public void setSqlpolice(String sqlpolice) {
		this.sqlpolice = sqlpolice;
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
	public int getCdtid() {
		return cdtid;
	}
	public void setCdtid(int cdtid) {
		this.cdtid = cdtid;
	}
	public int getWorkinfoid() {
		return workinfoid;
	}
	public void setWorkinfoid(int workinfoid) {
		this.workinfoid = workinfoid;
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
	public int getJointcontrollevelapply() {
		return jointcontrollevelapply;
	}
	public void setJointcontrollevelapply(int jointcontrollevelapply) {
		this.jointcontrollevelapply = jointcontrollevelapply;
	}
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
	public WenRisk getExportWenRisk() {
		return exportWenRisk;
	}
	public void setExportWenRisk(WenRisk exportWenRisk) {
		this.exportWenRisk = exportWenRisk;
	}
	public RealityShow getExportRealityShow() {
		return exportRealityShow;
	}
	public void setExportRealityShow(RealityShow exportRealityShow) {
		this.exportRealityShow = exportRealityShow;
	}
	public String getConflictdetails() {
		return conflictdetails;
	}
	public void setConflictdetails(String conflictdetails) {
		this.conflictdetails = conflictdetails;
	}
	public String getTelnumber() {
		return telnumber;
	}
	public void setTelnumber(String telnumber) {
		this.telnumber = telnumber;
	}
	public int getPoliceFilter() {
		return policeFilter;
	}
	public void setPoliceFilter(int policeFilter) {
		this.policeFilter = policeFilter;
	}
	public String getDeal() {
		return deal;
	}
	public void setDeal(String deal) {
		this.deal = deal;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSortsql() {
		return sortsql;
	}
	public void setSortsql(String sortsql) {
		this.sortsql = sortsql;
	}
	public String getAwaywill() {
		return awaywill;
	}
	public void setAwaywill(String awaywill) {
		this.awaywill = awaywill;
	}
	
}
