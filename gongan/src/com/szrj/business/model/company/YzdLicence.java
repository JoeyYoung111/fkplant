package com.szrj.business.model.company;

/**
 * 许可证信息  c_yzd_licence_t
 * @author 李昊
 * Aug 24, 2021
 */
public class YzdLicence {
	/*---------------数据库字段---------------------*/
	private int id;			//ID自增
	private int companyid;	//风险单位id
	private int credentialstype;//证件类型:存数据字典id
	private String companyname;	//企业名称
	private String licenceno;	//编号
	private String chargeperson;//负责人
	private String allowrange;	//许可范围
	private String allowtype;	//许可品种:化学品种类,多选
	private String validitystart;//有效期开始
	private String validityend;	//有效期结束
	private String allowunit;	//发证机关
	private String allowdate;	//发证日期
	private String direction;	//主要流向
	private String varietyyield;//品种产量
	private String attachments;	//附件
	private int validflag;	//状态标识 1:正常 0:作废
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String updateoperator;//最新修改人:包括修改、删除修改此字段信息
	private String updatetime;	//最新修改时间
	private String memo;		//备注信息
	private String jyfs;		//经营方式
	/*---------------非数据库字段---------------------*/
	private String basicName;
	private String allowtypeMsg;
	private String fileids;
	private String fileallnames;
	/*--------------get/set方法--------------------*/
	public String getBasicName() {
		return basicName;
	}
	public void setBasicName(String basicName) {
		this.basicName = basicName;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCompanyid() {
		return companyid;
	}
	public void setCompanyid(int companyid) {
		this.companyid = companyid;
	}
	public int getCredentialstype() {
		return credentialstype;
	}
	public void setCredentialstype(int credentialstype) {
		this.credentialstype = credentialstype;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getLicenceno() {
		return licenceno;
	}
	public void setLicenceno(String licenceno) {
		this.licenceno = licenceno;
	}
	public String getChargeperson() {
		return chargeperson;
	}
	public void setChargeperson(String chargeperson) {
		this.chargeperson = chargeperson;
	}
	public String getAllowrange() {
		return allowrange;
	}
	public void setAllowrange(String allowrange) {
		this.allowrange = allowrange;
	}
	public String getAllowtype() {
		return allowtype;
	}
	public void setAllowtype(String allowtype) {
		this.allowtype = allowtype;
	}
	public String getValiditystart() {
		return validitystart;
	}
	public void setValiditystart(String validitystart) {
		this.validitystart = validitystart;
	}
	public String getValidityend() {
		return validityend;
	}
	public void setValidityend(String validityend) {
		this.validityend = validityend;
	}
	public String getAllowunit() {
		return allowunit;
	}
	public void setAllowunit(String allowunit) {
		this.allowunit = allowunit;
	}
	public String getAllowdate() {
		return allowdate;
	}
	public void setAllowdate(String allowdate) {
		this.allowdate = allowdate;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getVarietyyield() {
		return varietyyield;
	}
	public void setVarietyyield(String varietyyield) {
		this.varietyyield = varietyyield;
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
	public String getAllowtypeMsg() {
		return allowtypeMsg;
	}
	public void setAllowtypeMsg(String allowtypeMsg) {
		this.allowtypeMsg = allowtypeMsg;
	}
	public String getJyfs() {
		return jyfs;
	}
	public void setJyfs(String jyfs) {
		this.jyfs = jyfs;
	}
	public String getFileids() {
		return fileids;
	}
	public void setFileids(String fileids) {
		this.fileids = fileids;
	}
	public String getFileallnames() {
		return fileallnames;
	}
	public void setFileallnames(String fileallnames) {
		this.fileallnames = fileallnames;
	}
	
}
