package com.szrj.business.model.personel;

public class KongExtend {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;//人员主表id
	private String contractperson;//是否国家、省平台签约人员   是/否
	private String nativeplace;//籍贯
	private int jointtype;//联控级别 1-红色、2-橙色、3-黄色、4-蓝色
	private String incontrollevel;//在控状态
	private String suspectaffair;//主要涉恐嫌疑情况
	private int controltime;//时间管控
	private String cometime;//来本地时间
	private String leavetime;//离开时间
	private String comereason;//来本地事由
	private String engagedwork;//从事行业
	private String identity;//身份
	private String serviceplace;//服务处所
	private String classify;//分类
	private String classifydetail;//分类明细
	private String religion;//宗教特征情况
	private String suspiciousthing;//可疑物品情况
	private String featuresphoto;//体貌特征照片
	private int isassign;//是否分配 0-未分配 1-已分配
	private String jurisdictunit1;//管辖责任单位  必选、默认当前登录人单位
	private String jurisdictpolice1;//管辖责任民警  必选、默认当前登录人id
	private String policephone1;//管辖责任民警手机  自动带出
	private String jurisdictunit2;//双管辖责任单位
	private String jurisdictpolice2;//双管辖责任民警
	private String policephone2;//双管辖责任民警电话
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	private int tz;		//台账（0-无 1-有）
	private String gdreason;	//归档理由
	private String zptime;		//指派时间
	private String gdtime;		//归档
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String jurisdictunit;//管辖+双管辖拼接责任单位
	private String cardnumber;//身份证号
	private String personname;//姓名
	private String sexes;//性别
	private String homeplace;//现住地详址
	private String persontype;//人员类别
	private String kongextendid;
	private String filesname;//可疑照片附件名
	private String filesallname;//
	private String personlabel;//人员标签
	private String qq;			//QQ
	private String wechat;		//微信
	private String isFilter;//数据过滤 1-民警过滤 2-单位过滤
	private String filtervalue;//数据过滤 过滤值
	private int personcount;	//计算人数
	private String jointtypename;//联控级别名字
	private int filevalidflag;	//文件标志位
	private String checkresume;	//背景审查简述
	//导出类
	private Personnel exportPersonnel=new Personnel();
	private Relation exportRelation=new Relation();
	//排序
	private String sortsql;
	private String GDsortsql;
	
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
	public String getPersonlabel() {
		return personlabel;
	}
	public void setPersonlabel(String personlabel) {
		this.personlabel = personlabel;
	}
	public String getFilesname() {
		return filesname;
	}
	public void setFilesname(String filesname) {
		this.filesname = filesname;
	}
	public String getPersontype() {
		return persontype;
	}
	public void setPersontype(String persontype) {
		this.persontype = persontype;
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
	public String getContractperson() {
		return contractperson;
	}
	public void setContractperson(String contractperson) {
		this.contractperson = contractperson;
	}
	public String getNativeplace() {
		return nativeplace;
	}
	public void setNativeplace(String nativeplace) {
		this.nativeplace = nativeplace;
	}
	public int getJointtype() {
		return jointtype;
	}
	public void setJointtype(int jointtype) {
		this.jointtype = jointtype;
	}
	public String getSuspectaffair() {
		return suspectaffair;
	}
	public void setSuspectaffair(String suspectaffair) {
		this.suspectaffair = suspectaffair;
	}
	public int getControltime() {
		return controltime;
	}
	public void setControltime(int controltime) {
		this.controltime = controltime;
	}
	public String getCometime() {
		return cometime;
	}
	public void setCometime(String cometime) {
		this.cometime = cometime;
	}
	public String getLeavetime() {
		return leavetime;
	}
	public void setLeavetime(String leavetime) {
		this.leavetime = leavetime;
	}
	public String getComereason() {
		return comereason;
	}
	public void setComereason(String comereason) {
		this.comereason = comereason;
	}
	public String getEngagedwork() {
		return engagedwork;
	}
	public void setEngagedwork(String engagedwork) {
		this.engagedwork = engagedwork;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}

	public String getServiceplace() {
		return serviceplace;
	}
	public void setServiceplace(String serviceplace) {
		this.serviceplace = serviceplace;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getSuspiciousthing() {
		return suspiciousthing;
	}
	public void setSuspiciousthing(String suspiciousthing) {
		this.suspiciousthing = suspiciousthing;
	}
	public String getFeaturesphoto() {
		return featuresphoto;
	}
	public void setFeaturesphoto(String featuresphoto) {
		this.featuresphoto = featuresphoto;
	}
	
	public int getIsassign() {
		return isassign;
	}
	public void setIsassign(int isassign) {
		this.isassign = isassign;
	}
	public String getJurisdictunit1() {
		return jurisdictunit1;
	}
	public void setJurisdictunit1(String jurisdictunit1) {
		this.jurisdictunit1 = jurisdictunit1;
	}
	public String getJurisdictpolice1() {
		return jurisdictpolice1;
	}
	public void setJurisdictpolice1(String jurisdictpolice1) {
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
	public String getIncontrollevel() {
		return incontrollevel;
	}
	public void setIncontrollevel(String incontrollevel) {
		this.incontrollevel = incontrollevel;
	}
	public String getJurisdictunit() {
		return jurisdictunit;
	}
	public void setJurisdictunit(String jurisdictunit) {
		this.jurisdictunit = jurisdictunit;
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
	public String getKongextendid() {
		return kongextendid;
	}
	public void setKongextendid(String kongextendid) {
		this.kongextendid = kongextendid;
	}
	public String getFilesallname() {
		return filesallname;
	}
	public void setFilesallname(String filesallname) {
		this.filesallname = filesallname;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	public String getIsFilter() {
		return isFilter;
	}
	public void setIsFilter(String isFilter) {
		this.isFilter = isFilter;
	}
	public String getFiltervalue() {
		return filtervalue;
	}
	public void setFiltervalue(String filtervalue) {
		this.filtervalue = filtervalue;
	}
	public int getPersoncount() {
		return personcount;
	}
	public void setPersoncount(int personcount) {
		this.personcount = personcount;
	}
	public String getJointtypename() {
		return jointtypename;
	}
	public void setJointtypename(String jointtypename) {
		this.jointtypename = jointtypename;
	}
	public String getSortsql() {
		return sortsql;
	}
	public void setSortsql(String sortsql) {
		this.sortsql = sortsql;
	}
	public String getGDsortsql() {
		return GDsortsql;
	}
	public void setGDsortsql(String dsortsql) {
		GDsortsql = dsortsql;
	}
	public int getTz() {
		return tz;
	}
	public void setTz(int tz) {
		this.tz = tz;
	}
	public int getFilevalidflag() {
		return filevalidflag;
	}
	public void setFilevalidflag(int filevalidflag) {
		this.filevalidflag = filevalidflag;
	}
	public String getGdreason() {
		return gdreason;
	}
	public void setGdreason(String gdreason) {
		this.gdreason = gdreason;
	}
	public String getZptime() {
		return zptime;
	}
	public void setZptime(String zptime) {
		this.zptime = zptime;
	}
	public String getGdtime() {
		return gdtime;
	}
	public void setGdtime(String gdtime) {
		this.gdtime = gdtime;
	}
	public String getCheckresume() {
		return checkresume;
	}
	public void setCheckresume(String checkresume) {
		this.checkresume = checkresume;
	}
	public String getClassify() {
		return classify;
	}
	public void setClassify(String classify) {
		this.classify = classify;
	}
	public String getClassifydetail() {
		return classifydetail;
	}
	public void setClassifydetail(String classifydetail) {
		this.classifydetail = classifydetail;
	}
	
}
