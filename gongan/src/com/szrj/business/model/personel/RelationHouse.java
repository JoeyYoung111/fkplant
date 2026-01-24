package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *人员关联信息-涉及房产表 p_relation_house_t
 */
public class RelationHouse {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private String housetype;//房产类型  必选，数据字典，存汉字
	private String houseorigin;//房产来源  必选，数据字典，存汉字
	private String houseaddress;//房产地址
	private int liveflag;//是否落脚居住  0-否 1-是
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
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
	public String getHousetype() {
		return housetype;
	}
	public void setHousetype(String housetype) {
		this.housetype = housetype;
	}
	public String getHouseorigin() {
		return houseorigin;
	}
	public void setHouseorigin(String houseorigin) {
		this.houseorigin = houseorigin;
	}
	public String getHouseaddress() {
		return houseaddress;
	}
	public void setHouseaddress(String houseaddress) {
		this.houseaddress = houseaddress;
	}
	public int getLiveflag() {
		return liveflag;
	}
	public void setLiveflag(int liveflag) {
		this.liveflag = liveflag;
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
	
}
