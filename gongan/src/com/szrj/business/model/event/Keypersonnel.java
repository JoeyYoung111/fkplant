package com.szrj.business.model.event;

//矛盾主要组织人员
public class Keypersonnel {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private int personnelid;		//风险人员id
	private int validflag;			//状态标识
	private int addoperatorid;		//添加人id
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	private int workinfoid;			//工作交办ID
	private String deal;			//处理措施
	private int importance;			//重要程度
	/*---------------------非数据库中字段------------------------------*/
	private String cardnumber;		//人员身份证号
	private String personname;		//姓名
	private String houseplace;		//户籍地详址
	private String homeplace;		//现住地详址
	private String conflictdetails;	//矛盾风险产生的经过、详情 
	private String sexes;			//性别
	private String nation;			//民族
	private String marrystatus;		//婚姻状态
	private String education;		//文化程度
	private String politicalposition;//政治面貌
	private String faith;			//宗教信仰
	private String wenid;			//wengrade表的id
	private String persontype;		//人员类别
	private String telnumber;		//手机号码
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCdtid() {
		return cdtid;
	}
	public void setCdtid(int cdtid) {
		this.cdtid = cdtid;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
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
	public String getHouseplace() {
		return houseplace;
	}
	public void setHouseplace(String houseplace) {
		this.houseplace = houseplace;
	}
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public int getWorkinfoid() {
		return workinfoid;
	}
	public void setWorkinfoid(int workinfoid) {
		this.workinfoid = workinfoid;
	}
	public String getConflictdetails() {
		return conflictdetails;
	}
	public void setConflictdetails(String conflictdetails) {
		this.conflictdetails = conflictdetails;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getMarrystatus() {
		return marrystatus;
	}
	public void setMarrystatus(String marrystatus) {
		this.marrystatus = marrystatus;
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
	public String getFaith() {
		return faith;
	}
	public void setFaith(String faith) {
		this.faith = faith;
	}
	public String getWenid() {
		return wenid;
	}
	public void setWenid(String wenid) {
		this.wenid = wenid;
	}
	public String getPersontype() {
		return persontype;
	}
	public void setPersontype(String persontype) {
		this.persontype = persontype;
	}
	public String getDeal() {
		return deal;
	}
	public void setDeal(String deal) {
		this.deal = deal;
	}
	public String getTelnumber() {
		return telnumber;
	}
	public void setTelnumber(String telnumber) {
		this.telnumber = telnumber;
	}
	public int getImportance() {
		return importance;
	}
	public void setImportance(int importance) {
		this.importance = importance;
	}
}
