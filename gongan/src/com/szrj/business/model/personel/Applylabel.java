package com.szrj.business.model.personel;

public class Applylabel {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;			//人员主表id
	private int applytype;				//申请类型1-新增 2-删除
	private String applylabel1;			//申请标签1级
	private String applylabel2;			//申请标签子级
	private String applylabel1name;		//申请标签1级名字
	private String applylabel2name;		//申请标签子级名字
	private int validflag;				//1-正常 0-作废
	private int adddepartmentid;		//申请部门id
	private int addoperatorid;			//申请人id
	private String addoperator;			//申请人
	private String addtime;				//申请时间
	private int examinemanid;			//审核人id
	private String examineman;			//审核人
	private String examinetime;			//审核时间
	private int examineflag;			//审核标记 0-未审核 1-审核通过 2-审核不通过
	private String failreason;			//审核不通过理由
	private String memo;				//备注信息
	private String applyreason;			//申请理由
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private int departmentid;			//一级标签归属部门
	private String cardnumber;			//人员身份证号
	private String personname;			//人员姓名
	private String personneltype;//新增涉毒风险人员时人员类别
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
	public int getApplytype() {
		return applytype;
	}
	public void setApplytype(int applytype) {
		this.applytype = applytype;
	}
	public String getApplylabel1() {
		return applylabel1;
	}
	public void setApplylabel1(String applylabel1) {
		this.applylabel1 = applylabel1;
	}
	public String getApplylabel2() {
		return applylabel2;
	}
	public void setApplylabel2(String applylabel2) {
		this.applylabel2 = applylabel2;
	}
	public String getApplylabel1name() {
		return applylabel1name;
	}
	public void setApplylabel1name(String applylabel1name) {
		this.applylabel1name = applylabel1name;
	}
	public String getApplylabel2name() {
		return applylabel2name;
	}
	public void setApplylabel2name(String applylabel2name) {
		this.applylabel2name = applylabel2name;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getAdddepartmentid() {
		return adddepartmentid;
	}
	public void setAdddepartmentid(int adddepartmentid) {
		this.adddepartmentid = adddepartmentid;
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
	public int getExaminemanid() {
		return examinemanid;
	}
	public void setExaminemanid(int examinemanid) {
		this.examinemanid = examinemanid;
	}
	public String getExamineman() {
		return examineman;
	}
	public void setExamineman(String examineman) {
		this.examineman = examineman;
	}
	public String getExaminetime() {
		return examinetime;
	}
	public void setExaminetime(String examinetime) {
		this.examinetime = examinetime;
	}
	public int getExamineflag() {
		return examineflag;
	}
	public void setExamineflag(int examineflag) {
		this.examineflag = examineflag;
	}
	public String getFailreason() {
		return failreason;
	}
	public void setFailreason(String failreason) {
		this.failreason = failreason;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
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
	public String getApplyreason() {
		return applyreason;
	}
	public void setApplyreason(String applyreason) {
		this.applyreason = applyreason;
	}
	public String getPersonneltype() {
		return personneltype;
	}
	public void setPersonneltype(String personneltype) {
		this.personneltype = personneltype;
	}
}
