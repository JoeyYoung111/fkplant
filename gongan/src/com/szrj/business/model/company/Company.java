package com.szrj.business.model.company;

/**
 * 单位基本信息 c_company_t
 * @author 李昊
 * Aug 25, 2021
 */
public class Company {
	/*---------------数据库字段---------------------*/
	private int id;				//ID自增
	private String companyname;	//单位名称
	private String companycode;	//社会统一代码
	private String companytype;	//单位大类:存数据字典id
	private String affecttype;	//单位类型:生产、经营、使用、运输【2022/2/25由int改为String 类型可能有2-3个】+仓储
	private int innet;			//是否入网:是/否
	private String managetype;	//涉及品种
	private String telephone;	//联系电话
	private String companystatus;//企业状态:正常、停用
	private String unusedreason;//停用原因:工艺改进、政策关停、其他
	private String managerange;	//经营范围
	private String registerplace;//注册地详址
	private String registerowner;//注册地所属辖区
	private String realworkplace;//实际办公地详址
	private String realworkowner;//实际办公地所属辖区
	private String longitude;	//经度
	private String latitude;	//维度
	private String codephoto;	//营业执照照片
	private String legalname;	//法人信息-姓名
	private String sexes;		//法人信息-性别
	private String zjlx;		//法人证件类型
	private String cardnumber;	//法人信息-身份证号码/证件号码
	private String nation;		//法人信息-民族
	private String education;	//法人信息-文化程度
	private String politicalposition;//法人信息-政治面貌
	private String legalphone;	//法人信息-联系电话
	private String homeplace;	//法人信息-户籍地详址
	private String lifeplace;	//法人信息-现住地详址
	private int validflag;	//状态标识 1:正常 0:作废
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String updateoperator;//最新修改人:包括修改、删除修改此字段信息
	private String updatetime;	//最新修改时间
	private String memo;		//备注信息
	/*------------------非数据库字段--------------*/
	private String registerownerString;
	private String realworkownerString;
	private String sjpzMsg;
	private String filenames;
	/*------------get/set方法--------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getCompanycode() {
		return companycode;
	}
	public void setCompanycode(String companycode) {
		this.companycode = companycode;
	}
	public String getCompanytype() {
		return companytype;
	}
	public void setCompanytype(String companytype) {
		this.companytype = companytype;
	}
	public int getInnet() {
		return innet;
	}
	public void setInnet(int innet) {
		this.innet = innet;
	}
	public String getManagetype() {
		return managetype;
	}
	public void setManagetype(String managetype) {
		this.managetype = managetype;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getCompanystatus() {
		return companystatus;
	}
	public void setCompanystatus(String companystatus) {
		this.companystatus = companystatus;
	}
	public String getUnusedreason() {
		return unusedreason;
	}
	public void setUnusedreason(String unusedreason) {
		this.unusedreason = unusedreason;
	}
	public String getManagerange() {
		return managerange;
	}
	public void setManagerange(String managerange) {
		this.managerange = managerange;
	}
	public String getRegisterplace() {
		return registerplace;
	}
	public void setRegisterplace(String registerplace) {
		this.registerplace = registerplace;
	}
	public String getRegisterowner() {
		return registerowner;
	}
	public void setRegisterowner(String registerowner) {
		this.registerowner = registerowner;
	}
	public String getRealworkplace() {
		return realworkplace;
	}
	public void setRealworkplace(String realworkplace) {
		this.realworkplace = realworkplace;
	}
	public String getRealworkowner() {
		return realworkowner;
	}
	public void setRealworkowner(String realworkowner) {
		this.realworkowner = realworkowner;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getCodephoto() {
		return codephoto;
	}
	public void setCodephoto(String codephoto) {
		this.codephoto = codephoto;
	}
	public String getLegalname() {
		return legalname;
	}
	public void setLegalname(String legalname) {
		this.legalname = legalname;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getCardnumber() {
		return cardnumber;
	}
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getPoliticalposition() {
		return politicalposition;
	}
	public void setPoliticalposition(String politicalposition) {
		this.politicalposition = politicalposition;
	}
	public String getLegalphone() {
		return legalphone;
	}
	public void setLegalphone(String legalphone) {
		this.legalphone = legalphone;
	}
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getLifeplace() {
		return lifeplace;
	}
	public void setLifeplace(String lifeplace) {
		this.lifeplace = lifeplace;
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
	public String getRegisterownerString() {
		return registerownerString;
	}
	public void setRegisterownerString(String registerownerString) {
		this.registerownerString = registerownerString;
	}
	public String getRealworkownerString() {
		return realworkownerString;
	}
	public void setRealworkownerString(String realworkownerString) {
		this.realworkownerString = realworkownerString;
	}
	public String getFilenames() {
		return filenames;
	}
	public void setFilenames(String filenames) {
		this.filenames = filenames;
	}
	public String getZjlx() {
		return zjlx;
	}
	public void setZjlx(String zjlx) {
		this.zjlx = zjlx;
	}
	public String getSjpzMsg() {
		return sjpzMsg;
	}
	public void setSjpzMsg(String sjpzMsg) {
		this.sjpzMsg = sjpzMsg;
	}
	public String getAffecttype() {
		return affecttype;
	}
	public void setAffecttype(String affecttype) {
		this.affecttype = affecttype;
	}
	
	
}
