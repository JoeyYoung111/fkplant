package com.szrj.business.model.event;

public class ZbEventInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int datatype;			//数据类型(1-涉及组织 2-涉及网络群组 3-涉及场所 4-涉及物品)
	private int cdtid;				//矛盾id
	private String name;			//名称
	private String type;			//类型
	private String result;			//结果
	private String memo;			//备注
	private int validflag;			//状态标识
	private int addoperatorid;		//添加人id
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	/*---------------------非数据库中字段------------------------------*/
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
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
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getDatatype() {
		return datatype;
	}
	public void setDatatype(int datatype) {
		this.datatype = datatype;
	}
}
