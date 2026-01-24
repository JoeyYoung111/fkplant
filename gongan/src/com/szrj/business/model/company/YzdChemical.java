package com.szrj.business.model.company;

/**
 * 化学品种类 c_yzd_chemical_t
 * @author 李昊
 * Aug 25, 2021
 */
public class YzdChemical {
	/*---------------数据库字段---------------------*/
	private int id;			//自增ID
	private int companyid;	//风险单位id
	private int belongtype;	//化学品所属类别:第一类、第二类、第三类
	private String chemicalname;//化学品名称[实际程序中存的是id 没有再单独写方法获取 2021/9/29 lh]
	private String purpose;		//用途:经营、运输、使用
	private String chemicaltype;//化学品类别:试剂、工业(多选)
	private String packingtype;//包装:散装、桶装、瓶装(多选)
	private int validflag;	//状态标识 1:正常 0:作废
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String updateoperator;//最新修改人:包括修改、删除修改此字段信息
	private String updatetime;	//最新修改时间
	private String memo;		//备注信息
	/*---------------非数据中字段-------------------*/
	private String belongtypemsg;
	private String realName;
	/*--------------get/set方法--------------------*/
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
	public int getBelongtype() {
		return belongtype;
	}
	public void setBelongtype(int belongtype) {
		this.belongtype = belongtype;
	}
	public String getChemicalname() {
		return chemicalname;
	}
	public void setChemicalname(String chemicalname) {
		this.chemicalname = chemicalname;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getChemicaltype() {
		return chemicaltype;
	}
	public void setChemicaltype(String chemicaltype) {
		this.chemicaltype = chemicaltype;
	}
	public String getPackingtype() {
		return packingtype;
	}
	public void setPackingtype(String packingtype) {
		this.packingtype = packingtype;
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
	public String toString() {
		return addoperator.toString();
	}
	public String getBelongtypemsg() {
		return belongtypemsg;
	}
	public void setBelongtypemsg(String belongtypemsg) {
		this.belongtypemsg = belongtypemsg;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	
}
